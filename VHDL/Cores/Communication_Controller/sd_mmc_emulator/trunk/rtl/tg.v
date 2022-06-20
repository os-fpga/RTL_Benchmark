// $Id: tg.v 914 2015-05-15 13:21:53Z nxp20190 $
//
// @brief Sango X7 Main timing/meas channel.
//
// @Author Roger Williams <roger.williams@nxp.com>
//
// (c) 2015 NXP Semiconductors. All rights reserved.
//
// PROPRIETARY INFORMATION
//
// The information contained in this file is the property of NXP Semiconductors.
// Except as specifically authorized in writing by NXP, the holder of this file:
// (1) shall keep all information contained herein confidential and shall protect
// same in whole or in part from disclosure and dissemination to all third parties
// and (2) shall use same for operation and maintenance purposes only.
// -----------------------------------------------------------------------------
// 0.03.1  2015-05-14 (RAW) Hard-code some parameters to get this working today
// 0.03.0  2015-05-13 (RAW) Adapted from XCtrl4 code for initial X7
//------------------------------------------------------------------------------

`include "registers_def.v"
`include "timescale.v"

module tg
  (
   // interface to channel
   output wire 	      rf_gate,
   // interface to Zmon
   output reg 	      adc_sck_o = 0,
   output reg 	      conv_o = 0,
   input wire 	      adcf_sdo_i,
   input wire 	      adcr_sdo_i,
   // interface to global control
   input wire [7:0]   control,
   output wire [7:0]  status,
   // interface to MCU
   input wire 	      we_i, oe_i, cs_i, rst_i,
   input wire [3:0]   adr_i,
   input wire [15:0]  dat_i,
   output wire [15:0] dat_o,
   input wire 	      clk200,	// 200MHz for register interface
   input wire 	      clk	// 100MHz for everything else
   );

   // HACK! quickly hard-code some parameters
   localparam TQ_p = 6'd0, TQ_to = 15'd10, TQ_td = 15'd0, TQ_tf = 15'd6, TQ_tw = 15'd24,
      TQ_f = 7'd0, TQ_ts = 12'd0, TQ_tk = 12'd0;

   wire [`TG_REG_BITS_R]	reg_r;
   wire [`TG_REG_BITS_W] 	reg_w;
   wire [`TG_REG_BITS_CTL]	reg_ctl;

   // reclock strobes in 100MHz domain
   reg [15:0] 		tctrl = 16'b0;
   wire			tctrl_RST = tctrl[15];
   wire			tctrl_ABT = tctrl[14];
   wire			tclr = tctrl[13];
   wire			tctrl_ARM = tctrl[12];
   wire			tctrl_TRIG = tctrl[11];
   wire			tctrl_CONV = tctrl[10];
   always @(posedge clk)
     tctrl <= reg_w[`TG_TCTRL_INDEX];

   reg [15:0] 		mctrl = 16'b0;
   wire			mctrl_RST = mctrl[15];
   wire			mctrl_ABT = mctrl[14];
   wire			mctrl_ARM = mctrl[12];
   always @(posedge clk)
     mctrl = reg_w[`TG_MCTRL_INDEX];

   wire 		meas_en = control[3];
   wire 		src_en = control[2];
   wire 		cont = control[1];
   wire 		tg_en = control[0];
   wire 		trst = control[7] | tctrl_RST;
   wire 		trst_en = control[7] | tctrl_RST | ~tg_en;
   wire 		tabt = control[6] | tctrl_ABT;
   wire 		tarm = control[5] | tctrl_ARM;
   wire 		trig = control[4] | tctrl_TRIG;
   wire 		mrst = control[7] | mctrl_RST;
   wire 		mrst_en = control[7] | mctrl_RST | ~meas_en | ~tg_en;
   wire 		mabt = control[6] | mctrl_ABT;
   wire 		marm = control[5] | mctrl_ARM;

/* -----\/----- EXCLUDED -----\/-----
   // make sure that tqueue strobe is exactly one clock tick wide
   reg 			tqueue_ld_dly = 1'b0;
   reg 			tqueue_ld_dly2 = 1'b0;
   wire			tqueue_ld = tqueue_ld_dly & ~tqueue_ld_dly2;
   always @(posedge clk) begin
      tqueue_ld_dly2 <= tqueue_ld_dly;
      tqueue_ld_dly <= reg_ctl[`TG_TQUEUE_LD_INDEX];
   end
 -----/\----- EXCLUDED -----/\----- */

   wire [15:0]		debug = reg_w[`TG_DEBUG_INDEX];
   reg 			gate = 1'b0;
   assign rf_gate = gate | (debug == 16'h202e); 	// force CW mode for testing (unicode RLO ;-)

   wire [15:0]		mconf = reg_w[`TG_MCONF_INDEX];
   wire [10:0] 		mconf_MAX_COUNT = mconf[10:0];
   wire [31:0]		tqueue = reg_w[`TG_TQUEUE_INDEX];

/* -----\/----- EXCLUDED -----\/-----
   // write 4 32-bit words of timing parameters into TQUEUE for each burst in sequence
   //   +31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10  9  8  7  6  5  4  3  2  1  0+
   //   +-----------------------+-----------------------+-----------------------+-----------------------+
   // 1 |||||||      POWER      |                 TC                |                 NP                |
   //   +-----------------------+-----------------------+-----------------------+-----------------------+
   // 2 ||||                     TO                     ||||                     TD                     |
   //   +-----------------------+-----------------------+-----------------------+-----------------------+
   // 3 ||||                     TF                     ||||                     TW                     |
   //   +-----------------------+-----------------------+-----------------------+-----------------------+
   // 4 ||||      FREQUENCY     |                 TS                |                 TK                |
   //   +-----------------------+-----------------------+-----------------------+-----------------------+

   reg [31:0] 		tparam1 =32'b0;
   wire [5:0]		burst_pwr = tparam1[29:24]; 	// POWER = VGA setting (0..63; 0.5dB steps)
   wire [11:0]		burst_tc = tparam1[23:12]; 	// TC = number of Zmon measurements in burst (0..4095)
   wire [11:0]		burst_np = tparam1[11:0]; 	// NP = number of pulses in the burst (0..4095, 0 disables burst)
   reg [31:0] 		tparam2 =32'b0;
   wire [14:0]		burst_to = tparam2[30:16]; 	// TO = offset into pulse for Zmon sample (0..32767; 0.1us steps)
   wire [14:0]		burst_td = tparam2[14:0]; 	// TD = starting delay for burst (0..32767; 0.1us steps)
   reg [31:0] 		tparam3 =32'b0;
   wire [14:0]		burst_tf = tparam3[30:16]; 	// TF = time between each pulse in burst (0..32767; 0.1us steps)
   wire [14:0]		burst_tw = tparam3[14:0]; 	// TW = width of each pulse in burst (0..32767; 0.1us steps)
   reg [31:0] 		tparam4 =32'b0;
   wire [6:0]		burst_freq = tparam4[30:24]; 	// FREQUENCY = MHz offset above 2400 (0..100; 1MHz steps)
   wire [11:0]		burst_ts = tparam4[23:12]; 	// TS = pulse skip for Zmon measurements (0..4094, 0 means sample every pulse)
   wire [11:0]		burst_tk = tparam4[11:0]; 	// TK = starting pulse for Zmon measurements (0..4094, 0 is first pulse)
   reg [4:0] 		tiptr = 5'h0;
   reg [3:0] 		toptr = 4'b0;
   reg [4:0] 		tcount = 5'b0;
   wire [2:0] 		tnbursts = tcount[4:2];
   reg 			tfetch = 1'b0;
   reg 			tstart = 1'b0;
   reg [31:0] 		tval = 32'b0;
   wire 		twe = tqueue_ld & ~tiptr[4];

   assign reg_r[`TG_TQ_STAT_INDEX] = {control, tnbursts, tiptr[4:0]};
  
   (* ram_style = "pipe_distributed" *)
     reg [31:0] 	tram [15:0];

   always @(posedge clk) begin
      if (twe)
	 tram[tiptr[3:0]] <= tqueue;
      if (tfetch)
	 tval <= tram[toptr];
   end

   always @(posedge clk)
      if (trst | tclr) begin
 	 tiptr <= 0;
	 toptr <= 0;
 	 tcount <= 0;
      end
      else if (tstart) begin
	 toptr <= 0;
	 tcount <= tiptr;
      end
      else if (tfetch) begin
	 toptr <= toptr + 1;
	 tcount <= tcount - 1;
      end
      else if (twe)
	 tiptr <= tiptr + 1;
 -----/\----- EXCLUDED -----/\----- */

   reg [2:0] 		tnbursts = 3'b0;	// HACK!
   reg [31:0] 		tparam1 =32'b0;
   wire [5:0]		burst_pwr = tparam1[29:24];
   wire [11:0]		burst_tc = tparam1[23:12];
   wire [11:0]		burst_np = tparam1[11:0];
   reg [31:0] 		tparam2 =32'b0;
   wire [14:0]		burst_to = tparam2[30:16];
   wire [14:0]		burst_td = tparam2[14:0];
   reg [31:0] 		tparam3 =32'b0;
   wire [14:0]		burst_tf = tparam3[30:16];
   wire [14:0]		burst_tw = tparam3[14:0];
   reg [31:0] 		tparam4 =32'b0;
   wire [6:0]		burst_freq = tparam4[30:24];
   wire [11:0]		burst_ts = tparam4[23:12];
   wire [11:0]		burst_tk = tparam4[11:0];
   reg 			tfetch = 1'b0;
   reg 			tstart = 1'b0;

   reg [14:0] 		ttimer = 15'b0;
   reg 			ttimer_load = 1'b0;
   reg [14:0] 		ttimer_count = 15'b0;
   reg [3:0] 		tprescale = 4'd9;
   wire 		ttimer_done = (ttimer_count == 0);
   always @(posedge clk)
     if (trst_en) begin
	tprescale <= 4'd9;
	ttimer_count <= 0;
     end
     else if (ttimer_load) begin
	tprescale <= 4'd7;
	ttimer_count <= ttimer;
     end
     else if (ttimer_count != 0)
       if (tprescale == 0) begin
	  tprescale <= 4'd9;
	  ttimer_count <= ttimer_count - 1;
       end
       else
	 tprescale <= tprescale - 1;

   reg 			trig_dly = 1'b0;
   wire 		trise = trig & ~trig_dly;
   always @(posedge clk)
     trig_dly <= trig;

   // pulse generator state machine
   localparam TIdle = 4'd0, Armed = 4'd1, NextBurst = 4'd2, Load0 = 4'd3, Load1 = 4'd4, Load2 = 4'd5, Load3 = 4'd6,
     Load4 = 4'd7, TBurstStart = 4'd8, PulseOffStart = 4'd9, PulseOff = 4'd10, PulseOnStart = 4'd11, PulseOn = 4'd12;
   reg [3:0] 		tstate = TIdle;
   reg [11:0] 		tnpulses = 12'b0;
   reg 			mdone = 1'b0;			// what does mdone mean?
   reg 			mhalf = 1'b0;
   reg 			sdone = 1'b0;
   reg 			tdone = 1'b0;
   reg [6:0] 		last_freq = 7'd50;		// assume initialised to 2450
   reg [5:0] 		last_pwr = 6'b0;
   reg 			pulse = 1'b0;
   reg 			burst_loaded = 1'b0;
   assign status = {mdone, mhalf, sdone, tdone, tstate};

   always @(posedge clk)
     if (trst_en | tabt) begin
	tstate <= TIdle;
	ttimer_load <= 0;
	tstart <= 0;
	tnpulses <= 0;
	pulse <= 0;
	gate <= 0;
	tdone <= 0;
     end
     else begin
	case (tstate)
	  TIdle: begin
	     tdone <= 0;
	     if (tarm) begin
		tstart <= 1;
		tstate <= Armed;
	     end
	  end
	  Armed: begin
	     tdone <= 0;
	     tstart <= 0;
	     tnbursts <= 1;
	     if (trise) begin
		tstate <= NextBurst;
	     end
	  end
	  NextBurst: begin
	     if (tnbursts > 0) begin
		tnbursts <= tnbursts - 1;
		tfetch <= 1;
		tstate <= Load0;
	     end
	     else begin
		tdone <= 1;
		if (cont) begin
		   tstart <= 1;
		   tstate <= Armed;
		end
		else
		  tstate <= TIdle;
	     end
	  end
	  Load0: begin
	     tstate <= Load1;
	  end
	  Load1: begin
/* -----\/----- EXCLUDED -----\/-----
	     tparam1 <= tval;				// POWER, TC, NP
 -----/\----- EXCLUDED -----/\----- */
	     tparam1 <= {2'b00, TQ_p, tqueue[11:0], tqueue[11:0]}; // HACK!
	     tstate <= Load2;
	  end
	  Load2: begin
/* -----\/----- EXCLUDED -----\/-----
	     tparam2 <= tval;				// TO, TD
 -----/\----- EXCLUDED -----/\----- */
	     tparam2 <= {1'b0, TQ_to, 1'b0, TQ_td};	// HACK!
	     tstate <= Load3;
	  end
	  Load3: begin
/* -----\/----- EXCLUDED -----\/-----
	     tparam3 <= tval;				// TF, TW
 -----/\----- EXCLUDED -----/\----- */
	     tparam3 <= {1'b0, TQ_tf, 1'b0, TQ_tw}; 	// HACK!
	     tfetch <= 0;
	     tstate <= Load4;
	  end
	  Load4: begin
/* -----\/----- EXCLUDED -----\/-----
	     tparam4 <= tval;				// FREQUENCY, TS, TK
 -----/\----- EXCLUDED -----/\----- */
	     tparam4 <= {1'b0, TQ_f, TQ_ts, TQ_tk};	// HACK!
	     burst_loaded <= 1;				// flag to meas state machine
	     tstate <= TBurstStart;
	  end
	  TBurstStart: begin
	     burst_loaded <= 0;
	     last_freq <= burst_freq;
	     last_pwr <= burst_pwr;
	     if (burst_np == 0 || burst_tw == 0)	// huh? that's no burst! but send SPI commands anyway
	       tstate <= NextBurst;
	     else begin
		tnpulses <= burst_np;
		ttimer <= burst_td;
		ttimer_load <= 1;
		tstate <= PulseOffStart;
	     end
	  end
	  PulseOffStart: begin
	     ttimer_load <= 0;
	     tstate <= PulseOff;
	  end
	  PulseOff: begin
	     if (ttimer_done) begin
		ttimer <= burst_tw;
		ttimer_load <= 1;
		gate <= src_en;
		pulse <= 1;
		tstate <= PulseOnStart;
	     end
	  end
	  PulseOnStart: begin
	     pulse <= 0;
	     tnpulses <= tnpulses - 1;			// decrement at start of pulse
	     ttimer_load <= 0;
	     tstate <= PulseOn;
	  end
	  PulseOn: begin
	     if (ttimer_done) begin
		gate <= 0;
		if (tnpulses == 0)
		  tstate <= NextBurst;
		else begin
		   ttimer <= burst_tf;
		   ttimer_load <= 1;
		   tstate <= PulseOffStart;
		end
	     end
	  end
	endcase // case (tstate)
     end

   // meas state machine
   localparam MIdle = 3'd0, MArmed = 3'd1, MBurstStart =  3'd2, ConvForce = 3'd3, ConvWait =  3'd4,
     ConvDelay = 3'd5, ConvStart =  3'd6, ConvEnd =  3'd7;
   reg [2:0] 		mstate = MIdle;
   reg [11:0] 		mnpulses = 12'b0;
   reg [10:0] 		maxpulses = 11'b0;
   reg [11:0] 		mnskip = 12'b0;
   reg [14:0] 		mtimer = 15'b0;
   reg 			mtimer_load = 1'b0;
   reg [14:0] 		mtimer_count = 15'b0;
   reg [3:0] 		mprescale = 4'd9;
   reg 			conv_force = 0;
   wire 		mtimer_done = (mtimer_count == 0);
   always @(posedge clk)
     if (mrst_en) begin
	mprescale <= 4'd9;
	mtimer_count <= 0;
     end
     else if (mtimer_load) begin
	mprescale <= 4'd7;
	mtimer_count <= mtimer;
     end
     else if (mtimer_count != 0)
       if (mprescale == 0) begin
	  mprescale <= 4'd9;
	  mtimer_count <= mtimer_count - 1;
       end
       else
	 mprescale <= mprescale - 1;

   always @(posedge clk)
     if (mrst_en | mabt) begin
	conv_force <= 0;
	mstate <= MIdle;
	mtimer_load <= 0;
	conv_o <= 0;
     end
     else begin
	if (tctrl_CONV)
	  conv_force <= 1;
	case (mstate)
	  MIdle: begin
	     conv_o <= 0;
	     maxpulses <= mconf_MAX_COUNT;
	     if (marm)
	       mstate <= MArmed;
	     else if (conv_force)
	       mstate <= ConvForce;
	  end
	  MArmed: begin
	     conv_o <= 0;
	     if (burst_loaded)
		mstate <= MBurstStart;
	     else if (conv_force)
	       mstate <= ConvForce;
	  end
	  MBurstStart: begin
	     if (burst_tc == 0)
	       mstate <= MArmed;
	     else begin
		mnpulses <= burst_tc;
		mnskip <= burst_tk;
		mstate <= ConvWait;
	     end
	  end
	  ConvForce: begin	// force single conversion on TCTRL[CONV] write
	     conv_force <= 0;
	     maxpulses <= 1;
	     mnpulses <= 1;
	     mnskip <= 0;
	     mtimer <= 4;
	     mtimer_load <= 1;
	     mstate <= ConvDelay;
	  end
	  ConvWait: begin
	     conv_o <= 0;
	     if (pulse)
	       if (mnskip == 0) begin
		  mtimer <= burst_to;
		  mtimer_load <= 1;
		  mstate <= ConvDelay;
	       end
	       else
		 mnskip <= mnskip - 1;
	  end
	  ConvDelay: begin
	     mtimer_load <= 0;
	     mstate <= ConvStart;
	  end
	  ConvStart: begin
	     if (mtimer_done) begin
		conv_o <= 1;
		mnpulses <= mnpulses - 1;
		maxpulses <= maxpulses - 1;
		mstate <= ConvEnd;
	     end
	  end
	  ConvEnd: begin
	     if (maxpulses == 0)
	       mstate <= MIdle;
	     else if (mnpulses == 0)
	       mstate <= MArmed;
	     else begin
		mnskip <= burst_ts;
		mstate <= ConvWait;
	     end
	  end
	endcase // case (mstate)
     end

   // ADC state machine
   localparam AIdle = 3'd0, ASckOn = 3'd1, ASckOnWait = 3'd2, ASckOff = 3'd3, ADone = 3'd4, ADone2 = 3'd5, SckOnStretch = 3'd2;
   reg [2:0] 		astate = AIdle;
   reg [31:0] 		adcf_dat = 32'b0;
   reg [31:0] 		adcr_dat = 32'b0;
   reg [31:0] 		adc_dat = 32'b0;
   reg [5:0] 		acount = 6'b0;
   reg 			adc_dat_wr = 1'b0;
   reg [2:0] 		sck_time = 3'b0;

   always @(posedge clk)
     if (mrst_en | mabt) begin
	astate <= AIdle;
	adc_dat_wr <= 0;
     end
     else begin
	case (astate)
	  AIdle: begin
	     adc_dat_wr <= 0;
	     if (conv_o) begin
		acount <= 6'd34;
		astate <= ASckOn;
	     end
	  end
	  ASckOn: begin
	     adc_sck_o <= 1;
	     acount <= acount - 1;
	     sck_time <= SckOnStretch;
	     astate <= ASckOnWait;
	  end
	  ASckOnWait: begin
	     if (sck_time == 0)
		astate <= ASckOff;
	     else
	       sck_time <= sck_time - 1;
	  end
	  ASckOff: begin
	     adc_sck_o <= 0;
	     adcf_dat <= {adcf_dat[30:0], adcf_sdo_i};
	     adcr_dat <= {adcr_dat[30:0], adcr_sdo_i};
	     if (acount == 0)
	       astate <= ADone;
	     else
	       astate <= ASckOn;
	  end
	  ADone: begin
	     adc_dat <= {adcf_dat[15:2], 2'b0, adcf_dat[31:18], 2'b0};
	     adc_dat_wr <= 1;				// write ADCR data
	     astate <= ADone2;
	  end
	  ADone2: begin
	     adc_dat <= {adcr_dat[15:2], 2'b0, adcr_dat[31:18], 2'b0};
	     adc_dat_wr <= 1;				// write ADCF data
	     astate <= AIdle;
	  end
	endcase // case (astate)
     end

   // MQUEUE FIFO
   reg [12:0]		mcount = 13'b0;
   reg [11:0]		mrptr = 12'b0;
   reg [10:0] 		mwptr = 11'b0;
   wire 		mfull = (mcount == 13'h1000);
   wire			mempty = (mcount == 13'h0);
   wire 		mfifo_wr = adc_dat_wr & ~mfull;
   reg [3:0] 		mfifo_rsel = 4'b0;
   reg [3:0] 		mfifo_wsel = 4'b0;
   reg [15:0] 		mqueue_dat_o = 16'b0;
   wire [4*16-1:0] 	mfifo_dat_o;

   always @* begin
      mfifo_wsel = 4'b0;
      case (mwptr[10:9])
	2'd0: mfifo_wsel[0] = 1;
	2'd1: mfifo_wsel[1] = 1;
	2'd2: mfifo_wsel[2] = 1;
	2'd3: mfifo_wsel[3] = 1;
      endcase
   end

   always @* begin
      mfifo_rsel = 4'b0;
      case (mrptr[11:10])
	2'd0: begin
	   mfifo_rsel[0] = 1;
	   mqueue_dat_o = mfifo_dat_o[1*16-1 -: 16];
	end
	2'd1: begin
	   mfifo_rsel[1] = 1;
	   mqueue_dat_o = mfifo_dat_o[2*16-1 -: 16];
	end
	2'd2: begin
	   mfifo_rsel[2] = 1;
	   mqueue_dat_o = mfifo_dat_o[3*16-1 -: 16];
	end
	2'd3: begin
	   mfifo_rsel[3] = 1;
	   mqueue_dat_o = mfifo_dat_o[4*16-1 -: 16];
	end
      endcase
   end
   
   assign reg_r[`TG_MQ_STAT_INDEX] = {3'b0, mcount};
   assign reg_r[`TG_MQUEUE_INDEX] = mqueue_dat_o;

   reg 			mqueue_rd_dly = 1'b0;
   reg 			mqueue_rd_dly2 = 1'b0;
   wire 		mqueue_rd = ~mqueue_rd_dly & mqueue_rd_dly2 & ~mempty;
   assign test = 1'b0;
   always @(posedge clk) begin
      mqueue_rd_dly <= reg_ctl[`TG_MQUEUE_RD_INDEX];
      mqueue_rd_dly2 <= mqueue_rd_dly;
   end
      
   always @(posedge clk) begin
      if (mrst) begin
	 mcount <= 0;
	 mrptr <= 0;
	 mwptr <= 0;
	 mhalf <= 0;
      end
      else begin
	 mhalf <= (mcount >= 13'h800);
	 if (mqueue_rd)
	   mrptr <= mrptr + 1;
	 if (mfifo_wr)
	   mwptr <= mwptr + 1;
	 if (mfifo_wr & ~mqueue_rd)			// write 2 words, no read
	   mcount <= mcount + 2;
	 else if (mfifo_wr & mqueue_rd)			// write 2 words, read 1 word
	   mcount <= mcount + 1;
	 else if (~mfifo_wr & mqueue_rd)		// no write, read 1 word
	   mcount <= mcount - 1;
      end
   end

   RAMB16_S18_S36 mfifo[3:0] (.DOA(mfifo_dat_o), .ADDRA(mrptr[9:0]), .CLKA(clk), .ENA(mfifo_rsel), .WEA(1'b0),
			      .DIA(16'b0), .DIPA(2'b0), .SSRA(1'b0), .ADDRB(mwptr[8:0]), .CLKB(clk),
			      .ENB(mfifo_wsel), .WEB({4{mfifo_wr}}), .DIB(adc_dat), .DIPB(4'b0), .SSRB(1'b0));

   tg_registers tg_reg (.clk_i(clk200), .rst_i(rst_i), .adr_i(adr_i), .dat_i(dat_i), .we_i(we_i),.oe_i(oe_i),
			.cs_i(cs_i), .dat_o(dat_o), .reg_w(reg_w), .reg_r(reg_r), .reg_ctl(reg_ctl));

endmodule
