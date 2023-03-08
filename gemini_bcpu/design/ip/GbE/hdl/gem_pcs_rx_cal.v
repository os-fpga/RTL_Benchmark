//------------------------------------------------------------------------------
// Copyright (c) 2001-2017 Cadence Design Systems, Inc.
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
//   Filename:           gem_pcs_rx_cal.v
//   Module Name:        gem_pcs_rx_cal
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
//   Description    : Comma alignment module based on XAUI20 design.
//                    State machine is stripped out as GEM PCS has it's own
//                    synchronisation state machine.
//
//------------------------------------------------------------------------------


module gem_pcs_rx_cal (

  input               clk,          // Recovered clock from Transceiver
  input               rst_n,        // Active low reset of the RX channel
  input       [19:0]  pma_rd,       // 10B coded data associated with clk
  input               bypass,       // Bypass module
  input               en_cal,       // Comma alignment enable
  input               polarity_inv, // Invert Polarity

  // Outputs
  output  reg [19:0]  rcal_rx_data  // Comma aligned 10B coded data

);

  // Internal signals
  wire  [19:0]  correct_pma_rd; // Polarity corrected input data
  reg   [19:0]  xcv_rxd_d1;     // Input data delayed by 1cc
  reg   [8:0]   xcv_rxd_d2;     // Input data delayed by 2cc
  reg   [9:0]   cal_position;   // Comma alignment position signal
  reg   [9:0]   cal_select;     // Character select vector
  wire  [19:0]  xcv_rxd_align;  // Overall aligned character
  reg   [19:0]  xcv_rxd_align_r1; // Pipelined
  wire  [19:0]  xcv_rxd_align0; // Aligned character for cal_select[0]
  wire  [19:0]  xcv_rxd_align1; // Aligned character for cal_select[1]
  wire  [19:0]  xcv_rxd_align2; // Aligned character for cal_select[2]
  wire  [19:0]  xcv_rxd_align3; // Aligned character for cal_select[3]
  wire  [19:0]  xcv_rxd_align4; // Aligned character for cal_select[4]
  wire  [19:0]  xcv_rxd_align5; // Aligned character for cal_select[5]
  wire  [19:0]  xcv_rxd_align6; // Aligned character for cal_select[6]
  wire  [19:0]  xcv_rxd_align7; // Aligned character for cal_select[7]
  wire  [19:0]  xcv_rxd_align8; // Aligned character for cal_select[8]
  wire  [19:0]  xcv_rxd_align9; // Aligned character for cal_select[9]
  wire  [28:0]  cal_two_data;   // Concatenation of 1st and 2nd registered
                                // groups of 10B coded data
  wire  [9:0]   cal_char_0;     // 1st  10-bit character from concatenated input
  wire  [9:0]   cal_char_1;     // 2nd  10-bit character from concatenated input
  wire  [9:0]   cal_char_2;     // 3rd  10-bit character from concatenated input
  wire  [9:0]   cal_char_3;     // 4th  10-bit character from concatenated input
  wire  [9:0]   cal_char_4;     // 5th  10-bit character from concatenated input
  wire  [9:0]   cal_char_5;     // 6th  10-bit character from concatenated input
  wire  [9:0]   cal_char_6;     // 7th  10-bit character from concatenated input
  wire  [9:0]   cal_char_7;     // 8th  10-bit character from concatenated input
  wire  [9:0]   cal_char_8;     // 9th  10-bit character from concatenated input
  wire  [9:0]   cal_char_9;     // 10th 10-bit character from concatenated input
  wire  [9:0]   cal_char_10;    // 11th 10-bit character from concatenated input
  wire  [9:0]   cal_char_11;    // 12th 10-bit character from concatenated input
  wire  [9:0]   cal_char_12;    // 13th 10-bit character from concatenated input
  wire  [9:0]   cal_char_13;    // 24th 10-bit character from concatenated input
  wire  [9:0]   cal_char_14;    // 25th 10-bit character from concatenated input
  wire  [9:0]   cal_char_15;    // 26th 10-bit character from concatenated input
  wire  [9:0]   cal_char_16;    // 27th 10-bit character from concatenated input
  wire  [9:0]   cal_char_17;    // 28th 10-bit character from concatenated input
  wire  [9:0]   cal_char_18;    // 29th 10-bit character from concatenated input
  wire  [9:0]   cal_char_19;    // 20th 10-bit character from concatenated input

  wire  [9:0]   cal_det_pos;    // K28.5/K28.1/K28.7 detection for pos CRD
  wire  [9:0]   cal_det_neg;    // K28.5/K28.1/K28.7 detection for neg CRD

  wire          cal_load_en;    // Load a new shift value for comma alignment

  parameter lnk_sync_char_pos = 7'b1111100; // 7'h7C = COMMA (K28.5 = 0xBC,
                                            //                K28.1 = 0x3C,
                                            //                K28.7 = 0xFC)
  parameter lnk_sync_char_neg = 7'b0000011;
  parameter p_cal_msb    = 6;
  parameter p_cal_lsb    = 0;


  // ---------------------------------------------------------------------------
  //  ********************* Beginning of main code ****************************
  // ---------------------------------------------------------------------------

  //---------------------------------------------------------------------------
  // Invert incoming data if required
  //---------------------------------------------------------------------------
  assign correct_pma_rd = {20{polarity_inv}} ^ pma_rd;

  //---------------------------------------------------------------------------
  // Clock process to register the input signals and create the pipelined
  // stages.
  //---------------------------------------------------------------------------
  always @(posedge clk or negedge rst_n)
  begin
    if (~rst_n)
    begin
      xcv_rxd_d1 <= 20'd0;
      xcv_rxd_d2 <=  9'd0;
    end
    else
    begin
      xcv_rxd_d1 <= correct_pma_rd;
      xcv_rxd_d2 <= xcv_rxd_d1[19:11];
    end
  end


  // ---------------------------------------------------------------------------
  // Combinatorial assignments to calculate where the 10 bit comma is situated
  // within in the 20 bit concatenation of 1st and 2nd registered data groups.
  //
  //
  //                 2nd 20b char                              1st 20b char
  // |-------------------------------------------|----------------------------
  // | 1 1 1 1 1 1 1 1 1 1                       | 1 1 1 1 1 1 1 1 1 1
  // | 9 8 7 6 5 4 3 2 1 0   9 8 7 6 5 4 3 2 1 0 | 9 8 7 6 5 4 3 2 1 0 9 8 7
  // |-------------------------------------------|----------------------------
  // |                                           |
  // |    3rd 10b char           2nd 10b char    |     1st 10b char
  // |---------------------|---------------------|---------------------|------
  // | 9 8 7 6 5 4 3 2 1 0 | 9 8 7 6 5 4 3 2 1 0 | 9 8 7 6 5 4 3 2 1 X | X X X
  // |---------------------|---------------------|---------------------|------
  //
  //       Alignment Character Position        cal_two_data   cal_det_*
  //  |------------------|                       [28:9]          [9]
  //    |--------------------|                   [27:8]          [8]
  //      |--------------------|                 [26:7]          [7]
  //        |--------------------|               [25:6]          [6]
  //          |--------------------|             [24:5]          [5]
  //            |--------------------|           [23:4]          [4]
  //              |--------------------|         [22:3]          [3]
  //                |--------------------|       [21:2]          [2]
  //                  |--------------------|     [20:1]          [1]
  //                    |--------------------|   [19:0]          [0]
  //
  //
  // This calculation has been implemented using the assign statement to reduce
  // the amount of code and simplify the calulation.
  //
  //
  // ---------------------------------------------------------------------------

  // Concatenate the 1st and 2nd registered data sets
  assign cal_two_data = {xcv_rxd_d1, xcv_rxd_d2};

  // Map to the 10 possible character positions
  assign cal_char_19  = cal_two_data[28:19];
  assign cal_char_18  = cal_two_data[27:18];
  assign cal_char_17  = cal_two_data[26:17];
  assign cal_char_16  = cal_two_data[25:16];
  assign cal_char_15  = cal_two_data[24:15];
  assign cal_char_14  = cal_two_data[23:14];
  assign cal_char_13  = cal_two_data[22:13];
  assign cal_char_12  = cal_two_data[21:12];
  assign cal_char_11  = cal_two_data[20:11];
  assign cal_char_10  = cal_two_data[19:10];
  assign cal_char_9   = cal_two_data[18: 9];
  assign cal_char_8   = cal_two_data[17: 8];
  assign cal_char_7   = cal_two_data[16: 7];
  assign cal_char_6   = cal_two_data[15: 6];
  assign cal_char_5   = cal_two_data[14: 5];
  assign cal_char_4   = cal_two_data[13: 4];
  assign cal_char_3   = cal_two_data[12: 3];
  assign cal_char_2   = cal_two_data[11: 2];
  assign cal_char_1   = cal_two_data[10: 1];
  assign cal_char_0   = cal_two_data[ 9: 0];

  // Detect for either pos or neg disparity special character in the data stream
  // Only need to check for 7 consecutive identical bits for COM or FTS or K28.7
  // - Checking more bits results in lower probability of bad sync
  // - Don't just check for 5 identical consecutive bits as you may sync to a
  // solid line level from SerDes!
  // - Include 2 transitions to remove chances of synching to an edge event from
  //   the SerDes!
  // - Best to check for 1000001 or 0111110 for alignment
  // - Additional bit checking adds logic but provides additional protection
  //   against Loss-of-Sync occuring due to bursts of bit errors

  // K28.5- Detection ( == 10'b0101111100, or sub-field thereof)
  assign cal_det_neg[9] = (cal_char_19[p_cal_msb:p_cal_lsb] == lnk_sync_char_neg)|
                          (cal_char_9 [p_cal_msb:p_cal_lsb] == lnk_sync_char_neg);
  assign cal_det_neg[8] = (cal_char_18[p_cal_msb:p_cal_lsb] == lnk_sync_char_neg)|
                          (cal_char_8 [p_cal_msb:p_cal_lsb] == lnk_sync_char_neg);
  assign cal_det_neg[7] = (cal_char_17[p_cal_msb:p_cal_lsb] == lnk_sync_char_neg)|
                          (cal_char_7 [p_cal_msb:p_cal_lsb] == lnk_sync_char_neg);
  assign cal_det_neg[6] = (cal_char_16[p_cal_msb:p_cal_lsb] == lnk_sync_char_neg)|
                          (cal_char_6 [p_cal_msb:p_cal_lsb] == lnk_sync_char_neg);
  assign cal_det_neg[5] = (cal_char_15[p_cal_msb:p_cal_lsb] == lnk_sync_char_neg)|
                          (cal_char_5 [p_cal_msb:p_cal_lsb] == lnk_sync_char_neg);
  assign cal_det_neg[4] = (cal_char_14[p_cal_msb:p_cal_lsb] == lnk_sync_char_neg)|
                          (cal_char_4 [p_cal_msb:p_cal_lsb] == lnk_sync_char_neg);
  assign cal_det_neg[3] = (cal_char_13[p_cal_msb:p_cal_lsb] == lnk_sync_char_neg)|
                          (cal_char_3 [p_cal_msb:p_cal_lsb] == lnk_sync_char_neg);
  assign cal_det_neg[2] = (cal_char_12[p_cal_msb:p_cal_lsb] == lnk_sync_char_neg)|
                          (cal_char_2 [p_cal_msb:p_cal_lsb] == lnk_sync_char_neg);
  assign cal_det_neg[1] = (cal_char_11[p_cal_msb:p_cal_lsb] == lnk_sync_char_neg)|
                          (cal_char_1 [p_cal_msb:p_cal_lsb] == lnk_sync_char_neg);
  assign cal_det_neg[0] = (cal_char_10[p_cal_msb:p_cal_lsb] == lnk_sync_char_neg)|
                          (cal_char_0 [p_cal_msb:p_cal_lsb] == lnk_sync_char_neg);

  // K28.5+ Detection ( == 10'b10_1000_0011, or sub-field thereof)
  assign cal_det_pos[9] = (cal_char_19[p_cal_msb:p_cal_lsb] == lnk_sync_char_pos)|
                          (cal_char_9 [p_cal_msb:p_cal_lsb] == lnk_sync_char_pos);
  assign cal_det_pos[8] = (cal_char_18[p_cal_msb:p_cal_lsb] == lnk_sync_char_pos)|
                          (cal_char_8 [p_cal_msb:p_cal_lsb] == lnk_sync_char_pos);
  assign cal_det_pos[7] = (cal_char_17[p_cal_msb:p_cal_lsb] == lnk_sync_char_pos)|
                          (cal_char_7 [p_cal_msb:p_cal_lsb] == lnk_sync_char_pos);
  assign cal_det_pos[6] = (cal_char_16[p_cal_msb:p_cal_lsb] == lnk_sync_char_pos)|
                          (cal_char_6 [p_cal_msb:p_cal_lsb] == lnk_sync_char_pos);
  assign cal_det_pos[5] = (cal_char_15[p_cal_msb:p_cal_lsb] == lnk_sync_char_pos)|
                          (cal_char_5 [p_cal_msb:p_cal_lsb] == lnk_sync_char_pos);
  assign cal_det_pos[4] = (cal_char_14[p_cal_msb:p_cal_lsb] == lnk_sync_char_pos)|
                          (cal_char_4 [p_cal_msb:p_cal_lsb] == lnk_sync_char_pos);
  assign cal_det_pos[3] = (cal_char_13[p_cal_msb:p_cal_lsb] == lnk_sync_char_pos)|
                          (cal_char_3 [p_cal_msb:p_cal_lsb] == lnk_sync_char_pos);
  assign cal_det_pos[2] = (cal_char_12[p_cal_msb:p_cal_lsb] == lnk_sync_char_pos)|
                          (cal_char_2 [p_cal_msb:p_cal_lsb] == lnk_sync_char_pos);
  assign cal_det_pos[1] = (cal_char_11[p_cal_msb:p_cal_lsb] == lnk_sync_char_pos)|
                          (cal_char_1 [p_cal_msb:p_cal_lsb] == lnk_sync_char_pos);
  assign cal_det_pos[0] = (cal_char_10[p_cal_msb:p_cal_lsb] == lnk_sync_char_pos)|
                          (cal_char_0 [p_cal_msb:p_cal_lsb] == lnk_sync_char_pos);


  //---------------------------------------------------------------------------
  // Calculate and store the cal_position signal
  // Load new comma position select vector only if in a LOS state.
  //---------------------------------------------------------------------------
  always @(posedge clk or negedge rst_n)
  begin
    if (~rst_n)
    begin
      cal_position <= 10'd0;
      cal_select   <= 10'd0;
    end
    else
    begin
      cal_position <= cal_det_pos | cal_det_neg;
      if (cal_load_en)
        cal_select  <= cal_position;
    end
  end


  // If there is a new comma detection, enable loading of the position only
  // when FSM is in an LoS condition
  assign cal_load_en = (|cal_position) & en_cal;

  //---------------------------------------------------------------------------
  //Combinatorial Process to Align data
  //Uses the cal_select signal to choose the correct 10 bits of the data.
  //It uses the 4th and 5th 10 bit registered data sets due to the amount
  //of pipelining.
  //Normally we can make this a prioritised case so that we can ensure we only
  //pick one comma alignment, however for FPGA timing we can make this a
  //sum of products if we assume that cal_select is one-hot.
  //This will be true when the skew on the lanes is stable. Only consecutive
  //K28.7 comma characters can cause false alignment here.
  //---------------------------------------------------------------------------

  // Assign product terms
  assign xcv_rxd_align9 = {cal_char_19,cal_char_9} & {20{cal_select[9]}};
  assign xcv_rxd_align8 = {cal_char_18,cal_char_8} & {20{cal_select[8]}};
  assign xcv_rxd_align7 = {cal_char_17,cal_char_7} & {20{cal_select[7]}};
  assign xcv_rxd_align6 = {cal_char_16,cal_char_6} & {20{cal_select[6]}};
  assign xcv_rxd_align5 = {cal_char_15,cal_char_5} & {20{cal_select[5]}};
  assign xcv_rxd_align4 = {cal_char_14,cal_char_4} & {20{cal_select[4]}};
  assign xcv_rxd_align3 = {cal_char_13,cal_char_3} & {20{cal_select[3]}};
  assign xcv_rxd_align2 = {cal_char_12,cal_char_2} & {20{cal_select[2]}};
  assign xcv_rxd_align1 = {cal_char_11,cal_char_1} & {20{cal_select[1]}};
  assign xcv_rxd_align0 = {cal_char_10,cal_char_0} & {20{cal_select[0]}};

  // Perform sum of the products
  assign xcv_rxd_align = xcv_rxd_align0|xcv_rxd_align1|xcv_rxd_align2|
                         xcv_rxd_align3|xcv_rxd_align4|xcv_rxd_align5|
                         xcv_rxd_align6|xcv_rxd_align7|xcv_rxd_align8|
                         xcv_rxd_align9;

  // The following code is the prioritised case that has been replaced with
  // the sum of products for FPGA. It is left here to be more readable than the
  // sum of products, but is NOT functionally equivalent.
  // always @ ( cal_select  or
  //            cal_char_19 or cal_char_18 or cal_char_17 or cal_char_16 or
  //            cal_char_15 or cal_char_14 or cal_char_13 or cal_char_12 or
  //            cal_char_11 or cal_char_10 or
  //            cal_char_9  or cal_char_8  or cal_char_7  or cal_char_6  or
  //            cal_char_5  or cal_char_4  or cal_char_3  or cal_char_2  or
  //            cal_char_1  or cal_char_0                                     )
  //   begin
  //     casex(cal_select)
  //       10'b1xxxxxxxxx : xcv_rxd_align = {cal_char_19,cal_char_9};
  //       10'b01xxxxxxxx : xcv_rxd_align = {cal_char_18,cal_char_8};
  //       10'b001xxxxxxx : xcv_rxd_align = {cal_char_17,cal_char_7};
  //       10'b0001xxxxxx : xcv_rxd_align = {cal_char_16,cal_char_6};
  //       10'b00001xxxxx : xcv_rxd_align = {cal_char_15,cal_char_5};
  //       10'b000001xxxx : xcv_rxd_align = {cal_char_14,cal_char_4};
  //       10'b0000001xxx : xcv_rxd_align = {cal_char_13,cal_char_3};
  //       10'b00000001xx : xcv_rxd_align = {cal_char_12,cal_char_2};
  //       10'b000000001x : xcv_rxd_align = {cal_char_11,cal_char_1};
  //       10'b0000000001 : xcv_rxd_align = {cal_char_10,cal_char_0};
  //       default        : xcv_rxd_align = {cal_char_19,cal_char_9};
  //     endcase
  //  end


  //---------------------------------------------------------------------------
  // Clocked Process to register the outputs
  //---------------------------------------------------------------------------
  always @(posedge clk or negedge rst_n)
  begin
    if (~rst_n)
      xcv_rxd_align_r1  <= 20'h00000;
    else
      if (~bypass)
        xcv_rxd_align_r1  <= xcv_rxd_align;
  end

  // Optional 0-latency bypass
  always@(*)
  begin
    if (bypass)
      rcal_rx_data = pma_rd;
    else
      rcal_rx_data = xcv_rxd_align_r1;
  end

endmodule
