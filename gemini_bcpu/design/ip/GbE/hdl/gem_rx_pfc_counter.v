//------------------------------------------------------------------------------
// Copyright (c) 2009-2017 Cadence Design Systems, Inc.
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
//   Filename:           gem_rx_pfc_counter.v
//   Module Name:        gem_rx_pfc_counter
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
//   Description :      This module implementsthe 8 PFC pause time counters
//
//------------------------------------------------------------------------------


module gem_rx_pfc_counter (

   // system signals.
   n_rxreset,
   rx_clk,

   // register signals
   enable_receive_rck,
   retry_test_rck,
   tx_byte_mode,

   // PFC pause framesignals
   pfc_enable_rck,
   new_pfc_pause_time0,
   new_pfc_pause_time1,
   new_pfc_pause_time2,
   new_pfc_pause_time3,
   new_pfc_pause_time4,
   new_pfc_pause_time5,
   new_pfc_pause_time6,
   new_pfc_pause_time7,
   new_pfc_pause_tog,
   new_priority_enable,
   rx_pfc_paused);

   // system signals.
   input         n_rxreset;              // reset synchronized to rx_clk.
   input         rx_clk;                 // 2.5MHz, 25MHz or 125MHz receive
                                         // clock.

   // register signals
   input         enable_receive_rck;     // receive enable signal from network
                                         // control register (synced with rx_clk)
   input         retry_test_rck;         // reduces back off time - must be set
                                         // to zero for normal operation.
                                         // (synced with rx_clk)
   input         tx_byte_mode;           // tbi or gigabit
                                         // when = 1, byte mode
                                         // when = 0, nibble mode

   // PFC pause frame signals
   input         pfc_enable_rck;         // enable PFC puase_frame reception

   input  [15:0] new_pfc_pause_time0;    // value of decoded new PFC pause time
                                         // for priority 0
   input  [15:0] new_pfc_pause_time1;    // value of decoded new PFC pause time
                                         // for priority 1
   input  [15:0] new_pfc_pause_time2;    // value of decoded new PFC pause time
                                         // for priority 2
   input  [15:0] new_pfc_pause_time3;    // value of decoded new PFC pause time
                                         // for priority 3
   input  [15:0] new_pfc_pause_time4;    // value of decoded new PFC pause time
                                         // for priority 4
   input  [15:0] new_pfc_pause_time5;    // value of decoded new PFC pause time
                                         // for priority 5
   input  [15:0] new_pfc_pause_time6;    // value of decoded new PFC pause time
                                         // for priority 6
   input  [15:0] new_pfc_pause_time7;    // value of decoded new PFC pause time
                                         // for priority 7
   input         new_pfc_pause_tog;      // indicates a new PFC pause time rxed

   input   [7:0] new_priority_enable;    // priority enable of new PFC pause
                                         // frame
   output [7:0]  rx_pfc_paused;          // each bit is set when PFC frame has
                                         // been received and the associated
                                         // PFC counter != 0

   // reg and wire declarations.

   // PFC pause time counetrs
   reg    [15:0] pfc_pause_cnt0;         // current value of PFC pause time
                                         // counter (priority 0)
   reg    [15:0] pfc_pause_cnt1;         // current value of PFC pause time
                                         // counter (priority 1)
   reg    [15:0] pfc_pause_cnt2;         // current value of PFC pause time
                                         // counter (priority 2)
   reg    [15:0] pfc_pause_cnt3;         // current value of PFC pause time
                                         // counter (priority 3)
   reg    [15:0] pfc_pause_cnt4;         // current value of PFC pause time
                                         // counter (priority 4)
   reg    [15:0] pfc_pause_cnt5;         // current value of PFC pause time
                                         // counter (priority 5)
   reg    [15:0] pfc_pause_cnt6;         // current value of PFC pause time
                                         // counter (priority 6)
   reg    [15:0] pfc_pause_cnt7;         // current value of PFC pause time
                                         // counter (priority 7)
   reg    [15:0] pfc_pause_cnt0_nxt;     // next value of pfc_pause_cnt0
   reg    [15:0] pfc_pause_cnt1_nxt;     // next value of pfc_pause_cnt1
   reg    [15:0] pfc_pause_cnt2_nxt;     // next value of pfc_pause_cnt2
   reg    [15:0] pfc_pause_cnt3_nxt;     // next value of pfc_pause_cnt3
   reg    [15:0] pfc_pause_cnt4_nxt;     // next value of pfc_pause_cnt4
   reg    [15:0] pfc_pause_cnt5_nxt;     // next value of pfc_pause_cnt5
   reg    [15:0] pfc_pause_cnt6_nxt;     // next value of pfc_pause_cnt6
   reg    [15:0] pfc_pause_cnt7_nxt;     // next value of pfc_pause_cnt7

   reg           new_pfc_pause_del;     // new_pfc_pause_tog
                                        // delayed by one clock
   reg    [7:0]  load_new_pause_time;  // one clock wide PFC pause counter
                                       // load. One bit for one counter.
   wire          preset_count_512;      // counter load for 512-bit times
                                        // pause quanta count.
   reg     [6:0] count_512;             // counts to 512, used for
                                        // decrementing pause time.

   wire          dec_pfc_pause_cnt0;    // indicates when the PFC pause
                                        // counter0 may decrement.
   wire          dec_pfc_pause_cnt1;    // indicates when the PFC pause
                                        // counter1 may decrement.
   wire          dec_pfc_pause_cnt2;    // indicates when the PFC pause
                                        // counter2 may decrement.
   wire          dec_pfc_pause_cnt3;    // indicates when the PFC pause
                                        // counter3 may decrement.
   wire          dec_pfc_pause_cnt4;    // indicates when the PFC pause
                                        // counter4 may decrement.
   wire          dec_pfc_pause_cnt5;    // indicates when the PFC pause
                                        // counter5 may decrement.
   wire          dec_pfc_pause_cnt6;    // indicates when the PFC pause
                                        // counter6 may decrement.
   wire          dec_pfc_pause_cnt7;    // indicates when the PFC pause
                                        // counter7 may decrement.
   reg [7:0]     rx_pfc_paused;         // each bit is set when PFC frame has
                                        // been received and the associated
                                        // PFC counter != 0
   integer       i;                     // References array in for loop

//----------------------------------
//------ PFC pause counters  --------
//----------------------------------
   always@(posedge rx_clk or negedge n_rxreset)
   begin
      if (~n_rxreset)
         new_pfc_pause_del    <= 1'b0;
      else
         new_pfc_pause_del    <= new_pfc_pause_tog;
   end

// detect both rising and falling edges on PFC pause frame toggle signal
// load PFC counter with new pause time if the corresponding priority
// is enabled.
   always@( * )
   begin
      for (i = 0; i  <8; i = i + 1)
      begin
        load_new_pause_time[i] = (new_pfc_pause_tog ^ new_pfc_pause_del) &
                                  new_priority_enable[i];
      end
   end


   // decrement the PFC pause time counter whenever it is
   // non-zero providing the associated priority pause time
   // quantum is non-zero and pfc_enable bit is one
   assign dec_pfc_pause_cnt0 = ~(pfc_pause_cnt0 == 16'h0000)
                               & pfc_enable_rck;
   assign dec_pfc_pause_cnt1 = ~(pfc_pause_cnt1 == 16'h0000)
                               & pfc_enable_rck;
   assign dec_pfc_pause_cnt2 = ~(pfc_pause_cnt2 == 16'h0000)
                               & pfc_enable_rck;
   assign dec_pfc_pause_cnt3 = ~(pfc_pause_cnt3 == 16'h0000)
                               & pfc_enable_rck;
   assign dec_pfc_pause_cnt4 = ~(pfc_pause_cnt4 == 16'h0000)
                               & pfc_enable_rck;
   assign dec_pfc_pause_cnt5 = ~(pfc_pause_cnt5 == 16'h0000)
                               & pfc_enable_rck;
   assign dec_pfc_pause_cnt6 = ~(pfc_pause_cnt6 == 16'h0000)
                               & pfc_enable_rck;
   assign dec_pfc_pause_cnt7 = ~(pfc_pause_cnt7 == 16'h0000)
                               & pfc_enable_rck;

   // preset pause quantum counter whenever a new pause time value
   // is loaded or when the pause time counter is decremented.
   assign preset_count_512 = (|load_new_pause_time) |
                            ((dec_pfc_pause_cnt0 |
                              dec_pfc_pause_cnt1 |
                              dec_pfc_pause_cnt2 |
                              dec_pfc_pause_cnt3 |
                              dec_pfc_pause_cnt4 |
                              dec_pfc_pause_cnt5 |
                              dec_pfc_pause_cnt6 |
                              dec_pfc_pause_cnt7 )
                             & (count_512 == 7'h00));

   // counter for pause quantum.
   always@(posedge rx_clk or negedge n_rxreset)
   begin
      if(~n_rxreset)
         // asynchronous reset.
         count_512 <= 7'h00;
      else if (~enable_receive_rck)
         // synchronous reset (from software).
         count_512 <= 7'h00;
      else if (~pfc_enable_rck)
         // disable PFC pause frame reception.
         count_512 <= 7'h00;
      else if (preset_count_512 & tx_byte_mode)
         // load bit time count in tx_byte_mode.
         count_512 <= 7'h3f;  // 64 rx_clks in byte mode.
      else if (preset_count_512)
         // load bit time count in 10/100 mode.
         count_512 <= 7'h7f;  // 128 rx_clks in nibble mode.
      else if (dec_pfc_pause_cnt0 | dec_pfc_pause_cnt1 |
               dec_pfc_pause_cnt2 | dec_pfc_pause_cnt3 |
               dec_pfc_pause_cnt4 | dec_pfc_pause_cnt5 |
               dec_pfc_pause_cnt6 | dec_pfc_pause_cnt7)
         // count down if any of the 8 PFC pause counters is non-zero.
         count_512 <= count_512 - 7'h01;
      else
         // hold count once zero.
         count_512 <= count_512;
   end

   // Update and decrement PFC pause counters (next value).
   //-------------------------------
   //---- PFC pause counter0 -------
   //-------------------------------
   always@( * )
   begin
      if (~enable_receive_rck)
         // synchronous reset (from software).
         pfc_pause_cnt0_nxt = 16'd0;
      else if (~pfc_enable_rck)
         // disable PFC pause frame reception.
         pfc_pause_cnt0_nxt = 16'd0;
      else if (load_new_pause_time[0])
         // new PFC pause quantum received from rx.
         pfc_pause_cnt0_nxt = new_pfc_pause_time0;
      else if (dec_pfc_pause_cnt0 & retry_test_rck)
         // test mode, decrement every clock until zero.
         pfc_pause_cnt0_nxt = pfc_pause_cnt0 - 16'h0001;
      else if (dec_pfc_pause_cnt0 & (count_512 == 7'h00))
         // decrement every 512 bit times
         pfc_pause_cnt0_nxt = pfc_pause_cnt0 - 16'h0001;
      else
        begin
           // hold PFC pause count.
           pfc_pause_cnt0_nxt = pfc_pause_cnt0;
        end
   end
   //-------------------------------
   //---- PFC pause counter1 -------
   //-------------------------------
   always@( * )
   begin
      if (~enable_receive_rck)
         // synchronous reset (from software).
         pfc_pause_cnt1_nxt = 16'd0;
      else if (~pfc_enable_rck)
         // disable PFC pause frame reception.
         pfc_pause_cnt1_nxt = 16'd0;
      else if (load_new_pause_time[1])
         // new PFC pause quantum received from rx.
         pfc_pause_cnt1_nxt = new_pfc_pause_time1;
      else if (dec_pfc_pause_cnt1 & retry_test_rck)
         // test mode, decrement every clock until zero.
         pfc_pause_cnt1_nxt = pfc_pause_cnt1 - 16'h0001;
      else if (dec_pfc_pause_cnt1 & (count_512 == 7'h00))
         // decrement every 512 bit times
         pfc_pause_cnt1_nxt = pfc_pause_cnt1 - 16'h0001;
      else
        begin
           // hold PFC pause count.
           pfc_pause_cnt1_nxt = pfc_pause_cnt1;
        end
   end
   //-------------------------------
   //---- PFC pause counter2 -------
   //-------------------------------
   always@( * )
   begin
      if (~enable_receive_rck)
         // synchronous reset (from software).
         pfc_pause_cnt2_nxt = 16'd0;
      else if (~pfc_enable_rck)
         // disable PFC pause frame reception.
         pfc_pause_cnt2_nxt = 16'd0;
      else if (load_new_pause_time[2])
         // new PFC pause quantum received from rx.
         pfc_pause_cnt2_nxt = new_pfc_pause_time2;
      else if (dec_pfc_pause_cnt2 & retry_test_rck)
         // test mode, decrement every clock until zero.
         pfc_pause_cnt2_nxt = pfc_pause_cnt2 - 16'h0001;
      else if (dec_pfc_pause_cnt2 & (count_512 == 7'h00))
         // decrement every 512 bit times
         pfc_pause_cnt2_nxt = pfc_pause_cnt2 - 16'h0001;
      else
        begin
           // hold pause count.
           pfc_pause_cnt2_nxt = pfc_pause_cnt2;
        end
   end

   //-------------------------------
   //---- PFC pause counter3 -------
   //-------------------------------
   always@( * )
   begin
      if (~enable_receive_rck)
         // synchronous reset (from software).
         pfc_pause_cnt3_nxt = 16'd0;
      else if (~pfc_enable_rck)
         // disable PFC pause frame reception.
         pfc_pause_cnt3_nxt = 16'd0;
      else if (load_new_pause_time[3])
         // new PFC pause quantum received from rx.
         pfc_pause_cnt3_nxt = new_pfc_pause_time3;
      else if (dec_pfc_pause_cnt3 & retry_test_rck)
         // test mode, decrement every clock until zero.
         pfc_pause_cnt3_nxt = pfc_pause_cnt3 - 16'h0001;
      else if (dec_pfc_pause_cnt3 & (count_512 == 7'h00))
         // decrement every 512 bit times
         pfc_pause_cnt3_nxt = pfc_pause_cnt3 - 16'h0001;
      else
        begin
           // hold pause count.
           pfc_pause_cnt3_nxt = pfc_pause_cnt3;
        end
   end

   //-------------------------------
   //---- PFC pause counter4 -------
   //-------------------------------
   always@( * )
   begin
      if (~enable_receive_rck)
         // synchronous reset (from software).
         pfc_pause_cnt4_nxt = 16'd0;
      else if (~pfc_enable_rck)
         // disable PFC pause frame reception.
         pfc_pause_cnt4_nxt = 16'd0;
      else if (load_new_pause_time[4])
         // new PFC pause quantum received from rx.
         pfc_pause_cnt4_nxt = new_pfc_pause_time4;
      else if (dec_pfc_pause_cnt4 & retry_test_rck)
         // test mode, decrement every clock until zero.
         pfc_pause_cnt4_nxt = pfc_pause_cnt4 - 16'h0001;
      else if (dec_pfc_pause_cnt4 & (count_512 == 7'h00))
         // decrement every 512 bit times
         pfc_pause_cnt4_nxt = pfc_pause_cnt4 - 16'h0001;
      else
        begin
           // hold pause count.
           pfc_pause_cnt4_nxt = pfc_pause_cnt4;
        end
   end

   //-------------------------------
   //---- PFC pause counter5 -------
   //-------------------------------
   always@( * )
   begin
      if (~enable_receive_rck)
         // synchronous reset (from software).
         pfc_pause_cnt5_nxt = 16'd0;
      else if (~pfc_enable_rck)
         // disable PFC pause frame reception.
         pfc_pause_cnt5_nxt = 16'd0;
      else if (load_new_pause_time[5])
         // new PFC pause quantum received from rx.
         pfc_pause_cnt5_nxt = new_pfc_pause_time5;
      else if (dec_pfc_pause_cnt5 & retry_test_rck)
         // test mode, decrement every clock until zero.
         pfc_pause_cnt5_nxt = pfc_pause_cnt5 - 16'h0001;
      else if (dec_pfc_pause_cnt5 & (count_512 == 7'h00))
         // decrement every 512 bit times
         pfc_pause_cnt5_nxt = pfc_pause_cnt5 - 16'h0001;
      else
        begin
           // hold pause count.
           pfc_pause_cnt5_nxt = pfc_pause_cnt5;
        end
   end
   //-------------------------------
   //---- PFC pause counter6 -------
   //-------------------------------
   always@( * )
   begin
      if (~enable_receive_rck)
         // synchronous reset (from software).
         pfc_pause_cnt6_nxt = 16'd0;
      else if (~pfc_enable_rck)
         // disable PFC pause frame reception.
         pfc_pause_cnt6_nxt = 16'd0;
      else if (load_new_pause_time[6])
         // new PFC pause quantum received from rx.
         pfc_pause_cnt6_nxt = new_pfc_pause_time6;
      else if (dec_pfc_pause_cnt6 & retry_test_rck)
         // test mode, decrement every clock until zero.
         pfc_pause_cnt6_nxt = pfc_pause_cnt6 - 16'h0001;
      else if (dec_pfc_pause_cnt6 & (count_512 == 7'h00))
         // decrement every 512 bit times
         pfc_pause_cnt6_nxt = pfc_pause_cnt6 - 16'h0001;
      else
        begin
           // hold pause count.
           pfc_pause_cnt6_nxt = pfc_pause_cnt6;
        end
   end

   //-------------------------------
   //---- PFC pause counter7 -------
   //-------------------------------
   always@( * )
   begin
      if (~enable_receive_rck)
         // synchronous reset (from software).
         pfc_pause_cnt7_nxt = 16'd0;
      else if (~pfc_enable_rck)
         // disable PFC pause frame reception.
         pfc_pause_cnt7_nxt = 16'd0;
      else if (load_new_pause_time[7])
         // new PFC pause quantum received from rx.
         pfc_pause_cnt7_nxt = new_pfc_pause_time7;
      else if (dec_pfc_pause_cnt7 & retry_test_rck)
         // test mode, decrement every clock until zero.
         pfc_pause_cnt7_nxt = pfc_pause_cnt7 - 16'h0001;
      else if (dec_pfc_pause_cnt7 & (count_512 == 7'h00))
         // decrement every 512 bit times
         pfc_pause_cnt7_nxt = pfc_pause_cnt7 - 16'h0001;
      else
        begin
           // hold pause count.
           pfc_pause_cnt7_nxt = pfc_pause_cnt7;
        end
   end


   // update and decrement PFC pause counters (current value).
   always@(posedge rx_clk or negedge n_rxreset)
   begin
      if(~n_rxreset)
      begin
         pfc_pause_cnt0 <= 16'd0;
         pfc_pause_cnt1 <= 16'd0;
         pfc_pause_cnt2 <= 16'd0;
         pfc_pause_cnt3 <= 16'd0;
         pfc_pause_cnt4 <= 16'd0;
         pfc_pause_cnt5 <= 16'd0;
         pfc_pause_cnt6 <= 16'd0;
         pfc_pause_cnt7 <= 16'd0;
      end
      else
      begin
         pfc_pause_cnt0 <= pfc_pause_cnt0_nxt;
         pfc_pause_cnt1 <= pfc_pause_cnt1_nxt;
         pfc_pause_cnt2 <= pfc_pause_cnt2_nxt;
         pfc_pause_cnt3 <= pfc_pause_cnt3_nxt;
         pfc_pause_cnt4 <= pfc_pause_cnt4_nxt;
         pfc_pause_cnt5 <= pfc_pause_cnt5_nxt;
         pfc_pause_cnt6 <= pfc_pause_cnt6_nxt;
         pfc_pause_cnt7 <= pfc_pause_cnt7_nxt;
      end
   end


   // Each bit of rx_pfc_paused is set when PFC pause is enabled
   // and the corresponding PFC pause time counter is non-zero.

   always @(posedge rx_clk or negedge n_rxreset)
     begin
       if (~n_rxreset)
         begin
           rx_pfc_paused    <= 8'h00;
         end
       else
         begin
           if ((pfc_pause_cnt0 != 16'h0000) & pfc_enable_rck)
             rx_pfc_paused[0] <= 1'b1;
           else
             rx_pfc_paused[0] <= 1'b0;

           if ((pfc_pause_cnt1 != 16'h0000) & pfc_enable_rck)
             rx_pfc_paused[1] <= 1'b1;
           else
             rx_pfc_paused[1] <= 1'b0;

           if ((pfc_pause_cnt2 != 16'h0000) & pfc_enable_rck)
             rx_pfc_paused[2] <= 1'b1;
           else
             rx_pfc_paused[2] <= 1'b0;

           if ((pfc_pause_cnt3 != 16'h0000) & pfc_enable_rck)
             rx_pfc_paused[3] <= 1'b1;
           else
             rx_pfc_paused[3] <= 1'b0;

           if ((pfc_pause_cnt4 != 16'h0000) & pfc_enable_rck)
             rx_pfc_paused[4] <= 1'b1;
           else
             rx_pfc_paused[4] <= 1'b0;

           if ((pfc_pause_cnt5 != 16'h0000) & pfc_enable_rck)
             rx_pfc_paused[5] <= 1'b1;
           else
             rx_pfc_paused[5] <= 1'b0;

           if ((pfc_pause_cnt6 != 16'h0000) & pfc_enable_rck)
             rx_pfc_paused[6] <= 1'b1;
           else
             rx_pfc_paused[6] <= 1'b0;

           if ((pfc_pause_cnt7 != 16'h0000) & pfc_enable_rck)
             rx_pfc_paused[7] <= 1'b1;
           else
             rx_pfc_paused[7] <= 1'b0;

         end
     end

endmodule
