// $Id: registers.v 912 2015-05-14 21:41:57Z nxp20190 $
//
// @brief Sango X7 Main SPI registers.
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

module tg_registers
  (
   input 			clk_i, rst_i, we_i, oe_i, cs_i,
   input [3:0]			adr_i,
   input [15:0]			dat_i,
   output reg [15:0]		dat_o = 16'b0,
   input [`TG_REG_BITS_R]	reg_r,
   output [`TG_REG_BITS_W]	reg_w,
   output [`TG_REG_BITS_CTL]	reg_ctl
   );

   reg [15:0] 			dat_i_sync = 16'b0;
   reg [15:0] 			dat_i_dly = 16'b0;
   reg [3:0] 			addr_keep = 4'b0;
   reg 				wr_keep = 1'b0;
   reg 				rd_keep = 1'b0;
   reg 				wr_dly = 1'b0;
   reg 				wr_dly1 = 1'b0;
   reg 				w_strobe = 1'b0;
   reg 				w_strobe_dly = 1'b0;
   wire 			wr_strobe = wr_dly & ~wr_dly1;

   // RW registers, strobes
   reg [15:0] 			tctrl = 16'h0000;
   reg 				tctrl_ld = 1'b0;
/* -----\/----- EXCLUDED -----\/-----
   reg [31:0] 			tqueue = 32'h00000000;
 -----/\----- EXCLUDED -----/\----- */
   reg [15:0] 			tqueue = 16'h0000; // HACK!
   reg 				tqueue_ld = 1'b0;
/* -----\/----- EXCLUDED -----\/-----
   reg 				tqueue_ld_dly = 1'b0;
 -----/\----- EXCLUDED -----/\----- */
   reg [15:0] 			mctrl = 16'h0000;
   reg 				mctrl_ld = 1'b0;
   reg [15:0] 			mconf = 16'h0400;
   reg 				mconf_ld = 1'b0;
   reg [15:0] 			debug = 16'h0000;
   reg 				debug_ld = 1'b0;
/* -----\/----- EXCLUDED -----\/-----
   reg [15:0] 			wr_multi = 16'b00;
   reg 				wr_multi_ld = 1'b0;
   reg [15:0] 			rd_multi = 16'b0;
 -----/\----- EXCLUDED -----/\----- */
   reg 				mqueue_rd = 0;

   assign reg_w = {debug, mconf, mctrl, tqueue, tctrl, dat_i_dly};
/* -----\/----- EXCLUDED -----\/-----
   assign reg_ctl = {mqueue_rd, tqueue_ld | tqueue_ld_dly};
 -----/\----- EXCLUDED -----/\----- */
   assign reg_ctl = {mqueue_rd, tqueue_ld};	// HACK!

   // synchronise inputs
   always @ (posedge clk_i)
     if (rst_i) begin
        rd_keep <= 0;
        wr_keep <= 0;
        addr_keep <= 0;
     end
     else begin
        rd_keep <= cs_i & oe_i;
        wr_keep <= cs_i & we_i;
        if (rd_keep | wr_keep)
          addr_keep <= adr_i;
     end

   // write pipeline
   always @ (posedge clk_i)
     if (rst_i) begin
        wr_dly <= 0;
        wr_dly1 <= 0;
        dat_i_sync <= 0;
     end
     else begin
        wr_dly <= wr_keep;
        wr_dly1 <= wr_dly;
        dat_i_dly <= dat_i_sync;
        if (wr_keep)
          dat_i_sync <= dat_i;
     end

   // address decoding
   always @ (posedge clk_i) 
     if (rst_i) begin
        tctrl_ld <= 0;
        tqueue_ld <= 0;
        mctrl_ld <= 0;
        debug_ld <= 0;
        mconf_ld <= 0;
/* -----\/----- EXCLUDED -----\/-----
        wr_multi_ld <= 0;
 -----/\----- EXCLUDED -----/\----- */
        mqueue_rd <= 0;
	w_strobe <= 0;
/* -----\/----- EXCLUDED -----\/-----
        tqueue_ld_dly <= 0;
 -----/\----- EXCLUDED -----/\----- */
     end
     else begin
        tctrl_ld <= wr_strobe & (addr_keep == `TG_TCTRL_AD);
/* -----\/----- EXCLUDED -----\/-----
        tqueue_ld <= wr_strobe & (addr_keep == (`TG_TQUEUE_AD | 5'd2));
 -----/\----- EXCLUDED -----/\----- */
        tqueue_ld <= wr_strobe & (addr_keep == `TG_TQUEUE_AD); // HACK!
        mctrl_ld <= wr_strobe & (addr_keep == `TG_MCTRL_AD);
        mconf_ld <= wr_strobe & (addr_keep == `TG_MCONF_AD);
        debug_ld <= wr_strobe & (addr_keep == `TG_DEBUG_AD);
/* -----\/----- EXCLUDED -----\/-----
        wr_multi_ld <= wr_strobe & (addr_keep == `TG_TQUEUE_AD);
 -----/\----- EXCLUDED -----/\----- */
        mqueue_rd <= rd_keep & (addr_keep == `TG_MQUEUE_AD);
	w_strobe <= tctrl_ld | mctrl_ld;
/* -----\/----- EXCLUDED -----\/-----
        tqueue_ld_dly <= tqueue_ld;
 -----/\----- EXCLUDED -----/\----- */
     end

   // W writes need to be valid for 2 clk200 cycles
   always @ (posedge clk_i)
     if (rst_i) begin
        tctrl <= 0;
        mctrl <= 0;
	w_strobe_dly <= 0;
     end
     else begin
	w_strobe_dly <= w_strobe;
        if (w_strobe_dly) begin
           tctrl <= 0;
           mctrl <= 0;
	end
	else begin
           if (tctrl_ld)
             tctrl <= dat_i_dly;
           if (mctrl_ld)
             mctrl <= dat_i_dly;
	end
     end

   // RW writes
   always @ (posedge clk_i)
     if (rst_i) begin
        mconf <= 16'h0400;
        debug <= 16'h0000;
/* -----\/----- EXCLUDED -----\/-----
        wr_multi <= 0;
        tqueue <= 32'h00000000;
 -----/\----- EXCLUDED -----/\----- */
        tqueue <= 16'h0000;			// HACK!
     end
     else begin
        if (debug_ld)
          debug <= dat_i_dly;
        if (mconf_ld)
          mconf <= dat_i_dly;
/* -----\/----- EXCLUDED -----\/-----
        if (wr_multi_ld)
          wr_multi <= dat_i_dly;
 -----/\----- EXCLUDED -----/\----- */
        if (tqueue_ld) begin
/* -----\/----- EXCLUDED -----\/-----
           tqueue[31:16] <= dat_i_dly;
           tqueue[15:0] <= wr_multi;
 -----/\----- EXCLUDED -----/\----- */
           tqueue <= dat_i_dly;			// HACK!
        end
     end

   // reads for RW and R registers
   always @ (posedge clk_i)
     if (rst_i) begin
        dat_o <= 0;
/* -----\/----- EXCLUDED -----\/-----
        rd_multi <= 0;
 -----/\----- EXCLUDED -----/\----- */
     end
     else if (rd_keep)
       case (addr_keep)
         `TG_TQ_STAT_AD: dat_o <= reg_r[`TG_TQ_STAT_INDEX];
         `TG_MQ_STAT_AD: dat_o <= reg_r[`TG_MQ_STAT_INDEX];
         `TG_DEBUG_AD: dat_o <= debug;
         `TG_MCONF_AD: dat_o <= mconf;
         `TG_MQUEUE_AD: dat_o <= reg_r[`TG_MQUEUE_INDEX];
/* -----\/----- EXCLUDED -----\/-----
         `TG_TQUEUE_AD: {rd_multi, dat_o} <= tqueue; // verify correct order
	 `TG_TQUEUE_AD + 2: dat_o <= rd_multi;
 -----/\----- EXCLUDED -----/\----- */
         `TG_TQUEUE_AD: dat_o <= reg_r[`TG_TQUEUE_INDEX]; // HACK!
         default: dat_o <= 0;
       endcase

endmodule

module registers
  (
   input			clk_i, rst_i, we_i, oe_i, cs_i,
   input [5:0]			adr_i,
   input [15:0]			dat_i,
   output reg [15:0]		dat_o = 16'b0,
   input [`REG_BITS_R]		reg_r,
   output [`REG_BITS_W]		reg_w
   );

   reg [15:0] 			dat_i_sync = 16'b0;
   reg [15:0] 			dat_i_dly = 16'b0;
   reg [5:0] 			addr_keep = 6'b0;
   reg 				wr_keep = 1'b0;
   reg 				rd_keep = 1'b0;
   reg 				wr_dly = 1'b0;
   reg 				wr_dly1 = 1'b0;
   reg 				w_strobe = 1'b0;
   reg 				w_strobe_dly = 1'b0;
   wire 			wr_strobe = wr_dly & ~wr_dly1;

   // RW registers, strobes
   reg [15:0] 			conf = 16'b0;
   reg 				conf_ld = 1'b0;
   reg [15:0] 			trig_src = 16'b0;
   reg 				trig_src_ld = 1'b0;
   reg [15:0] 			ctrl = 16'b0;
   reg 				ctrl_ld = 1'b0;
   reg [15:0] 			irq_mask = 16'b0;
   reg 				irq_mask_ld = 1'b0;
   reg [15:0] 			irq_clr = 16'b0;
   reg 				irq_clr_ld = 1'b0;
   reg [15:0] 			sync = 16'b0;
   reg 				sync_ld = 1'b0;
   reg [15:0] 			filter = 16'd10000;
   reg 				filter_ld = 1'b0;

   assign reg_w = {filter, sync, irq_clr, irq_mask, ctrl, trig_src, conf, dat_i_dly};

   // synchronise inputs
   always @ (posedge clk_i)
     if (rst_i) begin
        rd_keep <= 0;
        wr_keep <= 0;
        addr_keep <= 0;
     end
     else begin
        rd_keep <= cs_i & oe_i;
        wr_keep <= cs_i & we_i;
        if (rd_keep | wr_keep)
          addr_keep <= adr_i;
     end

   // write pipeline
   always @ (posedge clk_i)
     if (rst_i) begin
        wr_dly <= 0;
        wr_dly1 <= 0;
        dat_i_sync <= 0;
     end
     else begin
        wr_dly <= wr_keep;
        wr_dly1 <= wr_dly;
        dat_i_dly <= dat_i_sync;
        if (wr_keep)
          dat_i_sync <= dat_i;
     end

   // address decoding
   always @ (posedge clk_i)
     if (rst_i) begin
        conf_ld <= 0;
        trig_src_ld <= 0;
        ctrl_ld <= 0;
        irq_mask_ld <= 0;
        irq_clr_ld <= 0;
        sync_ld <= 0;
        filter_ld <= 0;
	w_strobe <= 0;
     end
     else begin
        conf_ld <= wr_strobe & (addr_keep == `CONF_AD);
        trig_src_ld <= wr_strobe & (addr_keep == `TRIG_SRC_AD);
	ctrl_ld <= wr_strobe & (addr_keep == `CTRL_AD);
        irq_mask_ld <= wr_strobe & (addr_keep == `IRQ_MASK_AD);
	irq_clr_ld <= wr_strobe & (addr_keep == `IRQ_CLR_AD);
        sync_ld <= wr_strobe & (addr_keep == `SYNC_AD);
        filter_ld <= wr_strobe & (addr_keep == `FILTER_AD);
	w_strobe <= ctrl_ld | irq_clr_ld;
     end

   // W writes
   always @ (posedge clk_i)
     if (rst_i) begin
        ctrl <= 0;
        irq_clr <= 0;
	w_strobe_dly <= 0;
     end
     else begin
	w_strobe_dly <= w_strobe;
        if (w_strobe_dly) begin
           ctrl <= 0;
           irq_clr <= 0;
	end
	else begin
           if (ctrl_ld)
             ctrl <= dat_i_dly;
           if (irq_clr_ld)
             irq_clr <= dat_i_dly;
	end
     end

   // RW writes
   always @ (posedge clk_i)
     if (rst_i) begin
        conf <= 16'h0000;
        trig_src <= 16'h0000;
        irq_mask <= 16'h0000;
        sync <= 16'h0000;
        filter <= 16'd10000;
     end
     else begin
        if (conf_ld)
          conf <= dat_i_dly;
        if (trig_src_ld)
          trig_src <= dat_i_dly;
        if (irq_mask_ld)
          irq_mask <= dat_i_dly;
        if (sync_ld)
          sync <= dat_i_dly;
        if (filter_ld)
          filter <= dat_i_dly;
     end

   // reads for RW and R registers
   always @ (posedge clk_i)
     if (rst_i) begin
        dat_o <= 0;
     end
     else if (rd_keep)
       case (addr_keep)
         `STAT_AD: dat_o <= reg_r[`STAT_INDEX];
         `IRQ_AD: dat_o <= reg_r[`IRQ_INDEX];
         `VERSION_AD: dat_o <= reg_r[`VERSION_INDEX];
         `CONF_AD: dat_o <= conf;
         `TRIG_SRC_AD: dat_o <= trig_src;
         `IRQ_MASK_AD: dat_o <= irq_mask;
         `SYNC_AD: dat_o <= sync;
         `FILTER_AD: dat_o <= filter;
         default: dat_o <= 0;
       endcase

endmodule
