//------------------------------------------------------------------------------
// Copyright (c) 2007-2017 Cadence Design Systems, Inc.
//
// The information herein (Cadence IP) contains confidential and proprietary
// information of Cadence Design Systems, Inc. Cadence IP may not be modified,
// copied, reproduced, distributed, or disclosed to third parties in any manner,
// medium, or form, in whole or in part, without the prior written consent of
// Cadence Design Systems Inc. Cadence IP is for use by Cadence Design Systems,
// Inc. customers only. Cadence Design Systems, Inc. reserves the right to make
// changes to Cadence IP at any time and without notice.
//------------------------------------------------------------------------------
//
//   Filename:           gem_tsu.v
//   Module Name:        gem_tsu
//
//   Release Revision:   r1p12
//   Release SVN Tag:    gem_gxl_det0102_r1p12
//
//   IP Name:            GEM Gigabit Ethernet MAC
//   IP Part Number:     IP7014
//
//   Product Type:       Off-the-shelf
//   IP Type:            Soft
//   IP Family:          Ethernet Controller
//   Technology:         N/A
//   Protocol:           Ethernet
//   Architecture:       N/A
//   Licensable IP:      SIP-Ethernet-MAC+DMA+1588+TSN+PCS-10M/100M/1G-IP7014
//
//------------------------------------------------------------------------------
//   Description :      Timer unit to support IEEE 1588.
//
//------------------------------------------------------------------------------

// include definitions files
`ifndef gem_defs_defined
`define gem_defs_defined
`include "gem_gxl_defs.v"
`include "edma_defs.v"
`endif

module gem_tsu(

   // clock and reset
   tsu_clk,
   n_tsureset,

   // external input control signals
   gem_tsu_ms,
   gem_tsu_inc_ctrl,

   // signals from gem_registers
   tsu_timer_sec,
   tsu_timer_nsec,
   tsu_timer_sec_wr,
   tsu_timer_nsec_wr,
   tsu_timer_adj_ctrl,
   tsu_timer_adj,
   tsu_timer_adj_wr,
   tsu_timer_incr,
   tsu_timer_incr_wr,
   tsu_timer_alt_incr,
   tsu_timer_num_incr,
   tsu_timer_nsec_cmp,
   tsu_timer_nsec_cmp_wr,
   tsu_timer_sec_cmp,

   // external tsu timer ports
   ext_tsu_timer,
   ext_tsu_timer_par,
   ext_tsu_timer_en,

   timer_strobe,
   tsu_sec_incr,
   tsu_timer_cnt,
   tsu_timer_cnt_par,
   tsu_timer_cmp_val

);

  parameter p_edma_tsu_clk        = 1'b0;
  parameter p_edma_ext_tsu_timer  = 1'b0;
  parameter p_edma_asf_dap_prot   = 1'b0;

   // system signals.
   input         tsu_clk;                 // clock
   input         n_tsureset;              // reset

   // external input control signals
   input         gem_tsu_ms;              // timer master/slave
   input   [1:0] gem_tsu_inc_ctrl;        // timer increment control

   // signals from gem_registers
   input  [47:0] tsu_timer_sec;           // timer value seconds
   input  [29:0] tsu_timer_nsec;          // timer value nanoseconds
   input         tsu_timer_sec_wr;        // indicates a TSU timer secs write
   input         tsu_timer_nsec_wr;       // indicates a TSU timer nsecs write
   input         tsu_timer_adj_ctrl;      // TSU timer add/subtract adjust
   input  [29:0] tsu_timer_adj;           // TSU timer adjust
   input         tsu_timer_adj_wr;        // indicates a TSU timer adjust write
   input  [31:0] tsu_timer_incr;          // TSU timer increment
   input         tsu_timer_incr_wr;       // TSU timer incr written
   input   [7:0] tsu_timer_alt_incr;      // TSU timer alternative increment
   input   [7:0] tsu_timer_num_incr;      // TSU timer number of increments
                                          // alternative increment value used
   input  [21:0] tsu_timer_nsec_cmp;      // TSU timer comparison nanoseconds
   input         tsu_timer_nsec_cmp_wr;   // indicates a comparison ns write
   input  [47:0] tsu_timer_sec_cmp;       // TSU timer comparison seconds

   // external tsu timer ports
   input  [93:0] ext_tsu_timer;           // alternative external tsu timer
   input  [11:0] ext_tsu_timer_par;
   input         ext_tsu_timer_en;        // use external tsu timer when '1'

   output        timer_strobe;            // write timer sync strobe registers
                                          // nanoseconds
   output        tsu_sec_incr;            // TSU timer seconds incremented
   output [93:0] tsu_timer_cnt;           // TSU timer count value
   output [11:0] tsu_timer_cnt_par;
   output        tsu_timer_cmp_val;       // TSU timer comparison valid





//------------------------------------------------------------------------------
// wire and reg declarations.
//------------------------------------------------------------------------------


   reg     [7:0] timer_incr_cnt;          // counter for timer increment
   reg           tsu_timer_incr_adj;      // indicates when the alternative
                                          // timer increment is used
   wire   [54:0] timer_nsec_ap;           // nanoseconds plus alternative
                                          // increment
   wire   [55:0] timer_nsec_ap1;          // nanoseconds plus alternative
                                          // increment plus 1
   wire   [53:0] timer_nsec_am1;          // nanoseconds plus alternative
                                          // increment minus 1
   wire   [54:0] timer_nsec_p;            // nanoseconds plus increment
   wire   [55:0] timer_nsec_p1;           // nanoseconds plus increment plus 1
   wire   [53:0] timer_nsec_m1;           // nanoseconds plus increment minus 1
   reg    [53:0] tsu_timer_nsec_1;        // intermediate nanoseconds result
   reg    [54:0] tsu_timer_nsec_2;        // intermediate nanoseconds result
   reg    [53:0] tsu_timer_nsec_3;        // intermediate nanoseconds result
   reg    [45:0] timer_nsec_calc_val;     // selected int/ext nanosecs result
   reg    [53:0] int_timer_nsec_calc_val; // registered nanoseconds result
   reg     [1:0] timer_sec_plus;          // number of seconds to increment
   reg     [1:0] timer_sec_minus;         // number of seconds to decrement
   reg    [48:0] tsu_timer_sec_1;         // intermediate seconds result
   reg    [47:0] timer_sec_calc_val;      // selected int/ext seconds result
   reg    [47:0] int_timer_sec_calc_val;  // registered seconds result

   wire   [31:0] tsu_timer_alt_incr_32_bit; // increase 8 bit register to 32 bit
                                            // to match tsu_timer_inc size

   reg           timer_strobe;            // write timer sync strobe registers

   reg           tsu_sec_incr_det;        // indicates that timer seconds
   reg           tsu_sec_incr;            // is incremented
   wire   [69:0] timer_cmp;               // TSU timer comparison value
   reg           tsu_timer_cmp_val;       // TSU timer comparison valid

   // signals used for timer adjust write toggle detection
   wire          adj_wr_tog;              // tsu_clk pulse when an tsu_timer_adj_wr
                                          // toggle was detected

   // signals used for timer seconds write toggle detection
   wire          sec_wr_tog;              // tsu_clk pulse when an tsu_timer_sec_wr
                                          // toggle was detected

   // signals used for timer nanoseconds write toggle detection
   wire          nsec_wr_tog;             // tsu_clk pulse when an tsu_timer_nsec_wr
                                          // toggle was detected

   wire   [47:0] tsu_timer_sec_safe;      // gated with qualifier for CDC
   wire   [29:0] tsu_timer_nsec_safe;     //
   wire   [29:0] tsu_timer_adj_safe;      // gated with qualifier for CDC
   wire          tsu_timer_adj_ctrl_safe; // gatd with qualifer for CDC

   reg           gem_tsu_ms_d;            // register timer master/slave input
   reg     [1:0] gem_tsu_inc_ctrl_d;      // register timer increment control in

   reg    [31:0] tsu_timer_incr_safe;     // updated when safe to do so
   wire          incr_wr_tog;             // tsu_clk pulse when incr written
   wire          nsec_cmp_wr_tog;         // tsu_clk pulse when ns compare written
   reg           allow_cmp;               // set when nsec compare register is written to enable comparison

//------------------------------------------------------------------------------
// External signal synchronisation
//------------------------------------------------------------------------------

generate if (p_edma_tsu_clk == 1) begin : gen_using_tsu_clk
   // synchronise tsu_timer_adj_wr, used to adjust timer. Also detect a toggle
   edma_toggle_detect i_edma_toggle_detect_tsu_timer_adj_wr (
      .clk(tsu_clk),
      .reset_n(n_tsureset),
      .din(tsu_timer_adj_wr),
      .rise_edge(),
      .fall_edge(),
      .any_edge(adj_wr_tog));

   // synchronise tsu_timer_sec_wr and tsu_timer_nsec_wr,
   // used to update timer after APB write
   edma_toggle_detect i_edma_toggle_detect_sec_sec_tog (
      .clk(tsu_clk),
      .reset_n(n_tsureset),
      .din(tsu_timer_sec_wr),
      .rise_edge(),
      .fall_edge(),
      .any_edge(sec_wr_tog));

   edma_toggle_detect i_edma_toggle_detect_sec_nsec_tog (
      .clk(tsu_clk),
      .reset_n(n_tsureset),
      .din(tsu_timer_nsec_wr),
      .rise_edge(),
      .fall_edge(),
      .any_edge(nsec_wr_tog));

   edma_toggle_detect i_edma_toggle_detect_incr_tog (
      .clk(tsu_clk),
      .reset_n(n_tsureset),
      .din(tsu_timer_incr_wr),
      .rise_edge(),
      .fall_edge(),
      .any_edge(incr_wr_tog));

   // synchronise tsu_timer_nsec_cmp_wr
   edma_toggle_detect i_edma_toggle_detect_ns_cmp_tog (
      .clk(tsu_clk),
      .reset_n(n_tsureset),
      .din(tsu_timer_nsec_cmp_wr),
      .rise_edge(),
      .fall_edge(),
      .any_edge(nsec_cmp_wr_tog));

   // Update nanosecond increment in tsu_clk domain when the tsu_timer_incr value is stable.
   // With release 1p08f1 this functionality has changed so that the entire nanosecond and
   // sub-nanosecond value is updated a safe time after a write to the nanosecond increment
   // register. This means that the sub-nanosecond increment value must be written before
   // the nano-second increment value.
   always@(posedge tsu_clk or negedge n_tsureset)
   begin
      if (~n_tsureset)
         begin
            tsu_timer_incr_safe <= 32'd0;
         end
      else if (incr_wr_tog)
         begin
            tsu_timer_incr_safe <= tsu_timer_incr;
         end
   end

   assign timer_nsec_p   = int_timer_nsec_calc_val +
                          {22'h000000, tsu_timer_incr_safe};
   assign timer_nsec_p1 = int_timer_nsec_calc_val +
                          {22'h000000, tsu_timer_incr_safe} +
                          54'h00000001000000;
   assign timer_nsec_m1 = int_timer_nsec_calc_val +
                          {22'h000000, tsu_timer_incr_safe} -
                          54'h00000001000000;

end else begin : gen_not_using_tsu_clk

   // synchronise tsu_timer_adj_wr, used to adjust timer
   // synchronise tsu_timer_sec_wr and tsu_timer_nsec_wr,
   // used to update timer after APB write
   reg tsu_timer_adj_wr_reg, tsu_timer_nsec_wr_reg, tsu_timer_sec_wr_reg, tsu_timer_incr_wr_reg, tsu_timer_nsec_cmp_wr_reg;
   always@(posedge tsu_clk or negedge n_tsureset)
   begin : p_timer_upd
      if (~n_tsureset)
         begin
            tsu_timer_adj_wr_reg <= 1'b0;
            tsu_timer_sec_wr_reg <= 1'b0;
            tsu_timer_nsec_wr_reg <= 1'b0;
            tsu_timer_incr_wr_reg <= 1'b0;
            tsu_timer_nsec_cmp_wr_reg <= 1'b0;
         end
      else
         begin
            tsu_timer_adj_wr_reg <= tsu_timer_adj_wr;
            tsu_timer_sec_wr_reg <= tsu_timer_sec_wr;
            tsu_timer_nsec_wr_reg <= tsu_timer_nsec_wr;
            tsu_timer_incr_wr_reg <= tsu_timer_incr_wr;
            tsu_timer_nsec_cmp_wr_reg <= tsu_timer_nsec_cmp_wr;
         end
   end  // block p_timer_upd

   // used to perform timer adjustment, asserted on toggle
   assign adj_wr_tog = tsu_timer_adj_wr_reg ^ tsu_timer_adj_wr;

   assign incr_wr_tog = tsu_timer_incr_wr_reg ^ tsu_timer_incr_wr;

   // only update sub nano-second portion when there is a write to the nano-second portion (sub-ns portion updated 1 pclk cycle after ns portion)
   // this means the sub-nanosecond portion does not take effect until after the nano-second portion has been written
   always@(posedge tsu_clk or negedge n_tsureset)
   begin
      if (~n_tsureset)
         begin
            tsu_timer_incr_safe[23:0] <= 24'd0;
         end
      else if (incr_wr_tog)
         begin
            tsu_timer_incr_safe[23:0] <= tsu_timer_incr[23:0];
         end
   end

   // used to perform timer update, asserted on toggle
   assign sec_wr_tog  = tsu_timer_sec_wr_reg ^ tsu_timer_sec_wr;
   assign nsec_wr_tog = tsu_timer_nsec_wr_reg ^ tsu_timer_nsec_wr;

   assign timer_nsec_p   = int_timer_nsec_calc_val +
                          {22'h000000, tsu_timer_incr[31:24],tsu_timer_incr_safe[23:0]};
   assign timer_nsec_p1 = int_timer_nsec_calc_val +
                          {22'h000000, tsu_timer_incr[31:24],tsu_timer_incr_safe[23:0]} +
                          54'h00000001000000;
   assign timer_nsec_m1 = int_timer_nsec_calc_val +
                          {22'h000000, tsu_timer_incr[31:24],tsu_timer_incr_safe[23:0]} -
                          54'h00000001000000;

   assign nsec_cmp_wr_tog  = tsu_timer_nsec_cmp_wr_reg ^ tsu_timer_nsec_cmp_wr;

end
endgenerate


// -----------------------------------------------------------------------------
//  Timer calculation
// -----------------------------------------------------------------------------

   // register gem_tsu_ms_d and gem_tsu_inc_ctrl_d
   always @(posedge tsu_clk or negedge n_tsureset)
   begin
      if (~n_tsureset)
         begin
            gem_tsu_ms_d       <= 1'b0;
            gem_tsu_inc_ctrl_d <= 2'b00;
         end
      else
         begin
            gem_tsu_ms_d       <= gem_tsu_ms;
            gem_tsu_inc_ctrl_d <= gem_tsu_inc_ctrl;
         end
   end

   // set tsu_timer_incr_adj when timer alternative increment should be used
   always @(posedge tsu_clk or negedge n_tsureset)
   begin : p_incr_adj

      if (~n_tsureset)
         begin
            timer_incr_cnt     <= 8'h00;
            tsu_timer_incr_adj <= 1'b0;
            tsu_sec_incr       <= 1'b0;
         end
      else
         begin
            if (tsu_sec_incr_det)
              tsu_sec_incr       <= ~tsu_sec_incr;

            // use number of increments after which alternative increment
            // value should be used
            if (tsu_timer_num_incr != 8'h00)
               begin
                  // increment counter has reached number of increments after
                  // which alternative increment value should be used
                  if (timer_incr_cnt >= tsu_timer_num_incr)
                     begin
                        timer_incr_cnt     <= 8'h00;
                        tsu_timer_incr_adj <= 1'b1;
                     end
                  // increment counter
                  else
                     begin
                        timer_incr_cnt     <= timer_incr_cnt + 8'h01;
                        tsu_timer_incr_adj <= 1'b0;
                     end
               end
            // no number of increments after which alternative increment
            // value should be used
            else
               begin
                  timer_incr_cnt     <= 8'h00;
                  tsu_timer_incr_adj <= 1'b0;
               end
         end
   end // block p_incr_adj


   assign tsu_timer_alt_incr_32_bit =  {tsu_timer_alt_incr, 24'h000000};

   assign timer_nsec_ap  = int_timer_nsec_calc_val +
                          {22'h000000, tsu_timer_alt_incr_32_bit};
   assign timer_nsec_ap1 = int_timer_nsec_calc_val +
                          {22'h000000, tsu_timer_alt_incr_32_bit} +
                          54'h00000001000000;
   assign timer_nsec_am1 = int_timer_nsec_calc_val +
                          {22'h000000, tsu_timer_alt_incr_32_bit} -
                          54'h00000001000000;

   assign tsu_timer_nsec_safe = tsu_timer_nsec & {30{nsec_wr_tog}};

   // asynchronous Timer calculation (Part 1) tsu_timer_nsec_1 adjust.
   always@(*)
   begin
      // timer nanoseconds update after APB write
      if (nsec_wr_tog)
         begin
            tsu_timer_nsec_1[53:24] = tsu_timer_nsec_safe; //only top 30 bits
                                                      //  (nsecs) written
            tsu_timer_nsec_1[23:0]  = 24'd0; // set LSBs to zero
         end
      else
         begin
            // add timer alternative increment
            if (tsu_timer_incr_adj)
               begin
                  if (gem_tsu_inc_ctrl_d == 2'b11)
                     begin
                        tsu_timer_nsec_1 = timer_nsec_ap[53:0];
                     end
                  else if (gem_tsu_inc_ctrl_d == 2'b01)
                     begin
                        tsu_timer_nsec_1 = timer_nsec_ap1[53:0];
                     end
                  else if (gem_tsu_inc_ctrl_d == 2'b10)
                     begin
                        tsu_timer_nsec_1 = timer_nsec_am1[53:0];
                     end
                  else
                     begin
                        if (gem_tsu_ms_d)
                           begin
                              tsu_timer_nsec_1 = 54'h00000000000000;
                           end
                        else
                           begin
                              tsu_timer_nsec_1 = timer_nsec_ap[53:0];
                           end
                     end
               end
            // add timer increment
            else
               begin
                  if (gem_tsu_inc_ctrl_d == 2'b11)
                     begin
                        tsu_timer_nsec_1 = timer_nsec_p[53:0];
                     end
                  else if (gem_tsu_inc_ctrl_d == 2'b01)
                     begin
                        tsu_timer_nsec_1 = timer_nsec_p1[53:0];
                     end
                  else if (gem_tsu_inc_ctrl_d == 2'b10)
                     begin
                        tsu_timer_nsec_1 = timer_nsec_m1[53:0];
                     end
                  else
                     begin
                        if (gem_tsu_ms_d)
                           begin
                              tsu_timer_nsec_1 = 54'h00000000000000;
                           end
                        else
                           begin
                              tsu_timer_nsec_1 = timer_nsec_p[53:0];
                           end
                     end
               end
         end

   end




   assign tsu_timer_adj_safe = tsu_timer_adj & {30{adj_wr_tog}};
   assign tsu_timer_adj_ctrl_safe = tsu_timer_adj_ctrl & adj_wr_tog;
   
   wire [55:0] tsu_timer_nsec_1_p_adjust_safe;
   assign      tsu_timer_nsec_1_p_adjust_safe = ({1'b0, tsu_timer_nsec_1} + {31'd1000000000, 24'd0});
    
   // asynchronous Timer calculation (Part 2) tsu_timer_nsec_2 adjust.
   always@(*)
   begin

      // adj_wr_tog is set with apb write on tsu_timer_adjust register
      if (adj_wr_tog)
         begin
            // subtract timer_adjust from timer
            if (tsu_timer_adj_ctrl_safe)
               begin
                  // with timer nanoseconds greater or equal than
                  // timer_adjust, no decrement of timer seconds
                  if (tsu_timer_nsec_1[53:8] >= {tsu_timer_adj_safe, 16'h0000})
                     begin
                        tsu_timer_nsec_2 = tsu_timer_nsec_1 -
                                          {tsu_timer_adj_safe, 24'h000000};
                        timer_sec_minus  = 2'b00;
                     end

                  // with timer nanoseconds smaller timer_adjust,
                  // decrement of timer seconds
                  else
                     begin
                        // timer seconds must be decremented by 1
                        if (tsu_timer_nsec_1_p_adjust_safe >= {2'd0,tsu_timer_adj_safe, 24'h000000})
                           begin
                              tsu_timer_nsec_2 = {31'd1000000000, 24'd0} +
                                                 {1'b0,tsu_timer_nsec_1} -
                                                 {1'b0,tsu_timer_adj_safe, 24'h000000};
                              timer_sec_minus  = 2'b01;
                           end
                        // timer seconds must be decremented by 2
                        else
                           begin
                              tsu_timer_nsec_2 = {31'd2000000000, 24'd0} +
                                                 {1'b0,tsu_timer_nsec_1} -
                                                 {1'b0,tsu_timer_adj_safe, 24'h000000};
                              timer_sec_minus  = 2'b10;
                           end
                     end
               end
            // add timer_adjust to timer
            else
               begin
                  tsu_timer_nsec_2 = {tsu_timer_nsec_1} +
                                     {tsu_timer_adj_safe, 24'h000000};
                  timer_sec_minus  = 2'b00;
               end
         end

      else // no timer adjustment
         begin
            tsu_timer_nsec_2 = {1'b0,tsu_timer_nsec_1};
            timer_sec_minus  = 2'b00;
         end

   end


   // calculate timer nanoseconds, check if timer seconds must be incremented
   always@(*)
   begin
      // timer seconds must be incremented by 2
      if (tsu_timer_nsec_2 >= {31'd2000000000 , 24'd0})
         begin
            tsu_timer_nsec_3 = tsu_timer_nsec_2 - {31'd2000000000 , 24'd0};
            timer_sec_plus   = 2'b10;
         end
      // timer seconds must be incremented by 1
      else if (tsu_timer_nsec_2 >= {31'd1000000000 , 24'd0})
         begin
            tsu_timer_nsec_3 = tsu_timer_nsec_2 - {31'd1000000000 , 24'd0};
            timer_sec_plus   = 2'b01;
         end
      // no increment of timer seconds
      else
         begin
            tsu_timer_nsec_3 = tsu_timer_nsec_2[53:0];
            timer_sec_plus   = 2'b00;
         end
   end


   assign tsu_timer_sec_safe = tsu_timer_sec & {48{sec_wr_tog}};

   // calculation of timer seconds depends on timer nanoseconds calculation
   always@(*)
   begin
      if (sec_wr_tog)
         begin
            tsu_timer_sec_1  = {1'b0,tsu_timer_sec_safe};
            tsu_sec_incr_det = 1'b0;
         end
      else
         begin
            if ((gem_tsu_inc_ctrl_d == 2'b00) & gem_tsu_ms_d)
               begin
                  tsu_timer_sec_1  = int_timer_sec_calc_val + 48'd1;
                  tsu_sec_incr_det = 1'b0;
               end
            else
               begin
                  if (timer_sec_minus == 2'b10)
                     begin
                        tsu_timer_sec_1  = {1'b0,int_timer_sec_calc_val} - 49'd2;
                        tsu_sec_incr_det = 1'b0;
                     end
                  else if (timer_sec_minus == 2'b01)
                     begin
                        tsu_timer_sec_1  = {1'b0,int_timer_sec_calc_val} - 49'd1;
                        tsu_sec_incr_det = 1'b0;
                     end
                  else if (timer_sec_plus == 2'b10)
                     begin
                        tsu_timer_sec_1  = int_timer_sec_calc_val + 48'd2;
                        tsu_sec_incr_det = 1'b1;
                     end
                  else if (timer_sec_plus == 2'b01)
                     begin
                        tsu_timer_sec_1  = int_timer_sec_calc_val + 48'd1;
                        tsu_sec_incr_det = 1'b1;
                     end
                  else
                     begin
                        tsu_timer_sec_1  = {1'b0,int_timer_sec_calc_val};
                        tsu_sec_incr_det = 1'b0;
                     end
               end
         end
   end


   // register calculated timer value
   always @(posedge tsu_clk or negedge n_tsureset)
   begin : p_timer_calc

      if (~n_tsureset)
         begin
            int_timer_nsec_calc_val  <= 54'h00000000000000;
            int_timer_sec_calc_val   <= 48'h000000000000;
         end
      else
         begin
            int_timer_nsec_calc_val  <= tsu_timer_nsec_3;
            int_timer_sec_calc_val   <= tsu_timer_sec_1[47:0];
         end
   end // block p_timer_calc


generate if (p_edma_ext_tsu_timer == 1) begin : gen_using_ext_tsu_timer
    // signal which can be substitiuted with with int_timer_sec_calc_val
    // and int_timer_nsec_calc_val
    wire   [47:0] ext_tsu_timer_sec;  // top 48 bits of ext_tsu_timer (secs)
    wire   [45:0] ext_tsu_timer_nsec; // low 46 bits of ext_tsu_timer
                                     // (nsecs/sub-nsecs)
    // useful names for external timer
    assign ext_tsu_timer_sec  = ext_tsu_timer[93:46];
    assign ext_tsu_timer_nsec = ext_tsu_timer[45:0];

    // external tsu timer mux
    // select .._calc_val depending on ext_tsu_timer_en. ( '1' = external, '0' - internal )
    always @(*)
    begin
      if (ext_tsu_timer_en)
      begin
        timer_sec_calc_val  = ext_tsu_timer_sec;
        timer_nsec_calc_val = ext_tsu_timer_nsec;
      end
      else
      begin
        timer_sec_calc_val  = int_timer_sec_calc_val;
        timer_nsec_calc_val = int_timer_nsec_calc_val[53:8];
      end
    end

end else begin : gen_not_using_ext_tsu_timer
    always @(*)
    begin
      timer_sec_calc_val  = int_timer_sec_calc_val;
      timer_nsec_calc_val = int_timer_nsec_calc_val[53:8];
    end
end
endgenerate

  // Optional parity
  wire  [11:0]  tsu_timer_cnt_par_int;
  generate if (p_edma_asf_dap_prot == 1) begin : gen_par
    cdnsdru_asf_parity_gen_v1 #(.p_data_width(94)) i_gen_tsu_par (
      .odd_par    (1'b0),
      .data_in    (tsu_timer_cnt),
      .data_out   (),
      .parity_out (tsu_timer_cnt_par_int)
    );
  end else begin : gen_no_par
    assign tsu_timer_cnt_par_int  = 12'h000;
  end
  endgenerate
  assign tsu_timer_cnt_par  = ((p_edma_ext_tsu_timer == 1) & ext_tsu_timer_en)  ? ext_tsu_timer_par
                                                                                : tsu_timer_cnt_par_int;

   // register strobe register load control
   always @(posedge tsu_clk or negedge n_tsureset)
   begin : p_timer_strobe
      if (~n_tsureset)
         timer_strobe <= 1'b0;
      else
         timer_strobe <= ((gem_tsu_inc_ctrl_d == 2'b00) & ~gem_tsu_ms_d);
   end

   assign tsu_timer_cnt = {timer_sec_calc_val,timer_nsec_calc_val};
   assign timer_cmp     = {tsu_timer_sec_cmp,tsu_timer_nsec_cmp};


   // compare timer count value
   // timer_cmp is a pclk timed signal so comparison is disabled by the tsu_clk timed signal
   // allow_cmp until timer_cmp is known to be stable. tsu_timer_cnt comes from a multiplexer
   // controlled by the pclk timed signal ext_tsu_en. To avoid CDC hazards the user is required
   // to write the TSU nanosecond compare register after the second compare register and after
   // writing the external tsu timer enable bit.
   always @(posedge tsu_clk or negedge n_tsureset)
   begin : p_timer_cmp

      if (~n_tsureset)
         begin
            tsu_timer_cmp_val       <= 1'b0;
            allow_cmp               <= 1'b0;
         end
      else
         begin
            if (nsec_cmp_wr_tog)
               allow_cmp            <= 1'b1;
            else if (allow_cmp & (tsu_timer_cnt[93:24] == timer_cmp))
               begin
                  tsu_timer_cmp_val <= 1'b1;
                  allow_cmp         <= 1'b0;
               end
            else
               tsu_timer_cmp_val    <= 1'b0;
         end
   end // block p_timer_cmp


endmodule
