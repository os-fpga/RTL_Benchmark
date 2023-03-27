//------------------------------------------------------------------------------
// Copyright (c) 2006-2017 Cadence Design Systems, Inc.
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
//   Filename:           gem_fifo_8b_if.v
//   Module Name:        gem_fifo_8b_if
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
//   Description    :   8b FIFO wrapper for GEM
//
//------------------------------------------------------------------------------

// include definitions files
`ifndef gem_defs_defined
`define gem_defs_defined
`include "gem_gxl_defs.v"
`include "edma_defs.v"
`endif

module gem_fifo_8b_if (

   // system signals
   tx_clk,
   tx_rst_n,
   rx_clk,
   rx_rst_n,
  `ifdef gem_no_pcs
  `else // if not gem_no_pcs
   rx_clk_from_phy,
  `endif

   tbi_selected,
   enable_transmit,
   enable_receive,
   tx_r_data_8b,
   tx_r_sop_8b,
   tx_r_eop_8b,
   tx_r_err_8b,
   tx_r_valid_8b,
   tx_r_data_rdy_8b,
   tx_r_underflow_8b,
   tx_r_flushed_8b,
   tx_r_rd_8b,
   tx_r_control_8b,
   rx_w_wr_8b,
   rx_w_data_8b,
   rx_w_sop_8b,
   rx_w_eop_8b,
   rx_w_err_8b,
   rx_w_status_8b,
  `ifdef gem_tsu
   rx_w_timestamp_8b,
  `endif

   tx_r_data_mac,
   tx_r_mod_mac,
   tx_r_sop_mac,
   tx_r_eop_mac,
   tx_r_err_mac,
   tx_r_valid_mac,
   tx_r_data_rdy_mac,
   tx_r_underflow_mac,
   tx_r_rd_mac,
   tx_r_control_mac,
   tx_r_fixed_lat_8b,
   rx_w_wr_mac,
   rx_w_data_mac,
   rx_w_mod_mac,
   rx_w_sop_mac,
   rx_w_eop_mac,
   rx_w_err_mac,
  `ifdef gem_tsu
   rx_w_timestamp_mac,
  `endif

   rx_w_status_mac

   );

   parameter p_rx_fifo_depth = 12;

   input          tx_clk;
   input          tx_rst_n;
   input          rx_clk;
   input          rx_rst_n;
  `ifdef gem_no_pcs
  `else // if not gem_no_pcs
   input          rx_clk_from_phy;      // extra clock needed when rx_clk is only 62.5Mhz.  This clock is
                                        // frequency locked and aligned to rx_clk
  `endif

   input          tbi_selected;         // indicates the PCS is in use, and therefore the data is coming in on a clock of 62.5MHz
                                        // rather than the usual 125MHz
   input          enable_transmit;      // TX enable
   input          enable_receive;       // RX enable
   input  [7:0]   tx_r_data_8b;         // output data from the transmit fifo
   input          tx_r_sop_8b;          // start of packet indicator.
   input          tx_r_eop_8b;          // end of packet indicator.
   input          tx_r_err_8b;          // packet in error indicator.
   output         tx_r_rd_8b;           // request new data from fifo.
   input          tx_r_valid_8b;        // new tx data available from fifo.
   input          tx_r_flushed_8b;      // external flush
   input          tx_r_data_rdy_8b;     // indicates either a complete packet
                                        // is present in the fifo or a certain
                                        // threshold of data has been crossed,
                                        // the mac uses this input to trigger
                                        // a frame transfer.
   input          tx_r_underflow_8b;    // signals tx fifo underrun condition.
   input          tx_r_control_8b;      // tx control from in-line FIFO word
  `ifdef gem_tsu
   output [77:0]  rx_w_timestamp_8b;    // valid on rx_w_eop
  `endif
   output         rx_w_wr_8b;           // rx write output to the receive
                                        // fifo.
   output [7:0]   rx_w_data_8b;         // output data to the receive fifo.
   output         rx_w_sop_8b;          // rx start of packet indicator.
   output         rx_w_eop_8b;          // rx end of packet indicator.
   output         rx_w_err_8b;          // rx packet in error indicator.
   output  [44:0] rx_w_status_8b;       // rx status written to in-line FIFO word.
   output         tx_r_fixed_lat_8b;    // latency has become fixed

   output  [31:0] tx_r_data_mac;        // input  data from the transmit fifo
                                        // to the tx module.
   output   [3:0] tx_r_mod_mac;         // tx number of valid bytes in last
                                        // transfer of the frame.
                                        // 0000 - tx_r_data[127:0] valid,
                                        // 0001 - tx_r_data[7:0] valid,
                                        // 0010 - tx_r_data[15:0] valid, until
                                        // 1111 - tx_r_data[119:0] valid.
   output         tx_r_sop_mac;         // start of packet indicator.
   output         tx_r_eop_mac;         // end of packet indicator.
   output         tx_r_err_mac;         // packet in error indicator.
   input          tx_r_rd_mac;          // request new data from fifo.
   output         tx_r_valid_mac;       // new tx data available from fifo.
   output         tx_r_data_rdy_mac;    // indicates either a complete packet
                                        // is present in the fifo or a certain
                                        // threshold of data has been crossed,
                                        // the mac uses this outputto trigger
                                        // a frame transfer.
   output         tx_r_underflow_mac;   // signals tx fifo underrun condition.
   output         tx_r_control_mac;     // tx control from in-line FIFO word
  `ifdef gem_tsu
   input  [77:0]  rx_w_timestamp_mac;    // valid on rx_w_eop
  `endif
   input          rx_w_wr_mac;           // rx write input  to the receive
                                         // fifo.
   input  [31:0]  rx_w_data_mac;         // input  data to the receive fifo.
   input    [3:0] rx_w_mod_mac;          // rx number of valid bytes in last.
                                         // transfer of the frame.
   input          rx_w_sop_mac;          // rx start of packet indicator.
   input          rx_w_eop_mac;          // rx end of packet indicator.
   input          rx_w_err_mac;          // rx packet in error indicator.
   input   [44:0] rx_w_status_mac;       // rx status written to in-line FIFO word.

  // wires and registers declaration
  reg [12:0]      tx_data_array [7:0];
  reg [3:0]       tx_wr_ptr;
  wire [2:0]      nxt_mac_tx_wr_ptr;
  integer         tx_array_int_rd;
  integer         tx_array_int;
  reg             tx_r_valid_mac;
  reg             tx_r_rd_8b_r;
  wire            tx_r_rd_8b;
  reg [7:0]       sop_vector;
  reg [7:0]       eop_vector;
  reg [7:0]       err_vector;
  reg [31:0]      tx_r_data_mac;
  reg  [3:0]      tx_r_mod_mac;
  reg             tx_r_underflow_mac;
  reg             tx_r_sop_mac;
  reg             tx_r_control_mac;
  reg             tx_r_eop_mac;
  reg             tx_r_err_mac;
  wire            tx_fifo_full;
  reg             tx_r_fixed_lat_8b;
  reg             tx_r_fixed_lat_en;
  `ifdef gem_tsu
  reg [122:0]     rx_w_status_hold;
  `else
  reg [44:0]      rx_w_status_hold;
  `endif
  wire            tx_eop_condition;
  wire            tx_eop_next_frame_avail;
  wire            eop_in_bottom_4;
  reg             tx_pip;
  reg             tx_data_avail;
  reg  [3:0]      tx_wr_ptr_sub_nxt;

  wire            rx_w_sop_mac_gated;
  wire            rx_w_eop_mac_gated;
  wire            rx_w_wr_mac_gated;
  `ifdef gem_no_pcs
  `else // if not gem_no_pcs
  reg             rx_w_sop_mac_d1;
  reg             rx_w_eop_mac_d1;
  reg             rx_w_wr_mac_d1;
  `endif
  wire            tx_valid_write;
  wire            tx_uflow_detected;
  wire            tx_eop_no_new_frame_avail;
  
  assign tx_fifo_full = tx_wr_ptr >= 4'd6;
  assign tx_eop_condition = (tx_r_valid_8b & (tx_r_eop_8b | tx_r_err_8b));
  assign tx_eop_next_frame_avail = (tx_eop_condition & tx_r_data_rdy_8b) & ~tx_r_underflow_8b;
  assign tx_eop_no_new_frame_avail = (tx_eop_condition & ~tx_r_data_rdy_8b) | tx_r_underflow_8b;
  assign tx_valid_write = (tx_r_valid_8b & (tx_r_sop_8b | tx_pip));
  assign tx_uflow_detected = tx_r_rd_mac & tx_wr_ptr == 4'h0;
  always @(*)
  begin
    if ((tx_r_eop_mac|tx_r_err_mac|tx_r_underflow_mac) & (|tx_r_mod_mac))
      tx_wr_ptr_sub_nxt = tx_r_mod_mac[3:0];
    else
      tx_wr_ptr_sub_nxt = 4'h4;
  end
  assign nxt_mac_tx_wr_ptr = tx_wr_ptr - tx_wr_ptr_sub_nxt;

  assign tx_r_rd_8b = tx_r_rd_8b_r;

  always@(posedge tx_clk or negedge tx_rst_n)
  begin
    if (~tx_rst_n)
    begin
      tx_r_rd_8b_r  <= 1'b0;
      tx_wr_ptr   <= 4'h0;
      tx_pip      <= 1'b0;
      tx_data_avail <= 1'b0;
      for (tx_array_int = 0; tx_array_int < 8; tx_array_int=tx_array_int+1)
        tx_data_array[tx_array_int] <= 13'd0;

      tx_r_valid_mac  <= 1'b0;
      tx_r_fixed_lat_8b <= 1'b0;
      tx_r_fixed_lat_en <= 1'b0;
    end
    else if (~enable_transmit | tx_r_flushed_8b)
    begin
      tx_r_rd_8b_r  <= 1'b0;
      tx_wr_ptr   <= 4'h0;
      tx_pip      <= 1'b0;
      tx_data_avail <= 1'b0;
      for (tx_array_int = 0; tx_array_int < 8; tx_array_int=tx_array_int+1)
        tx_data_array[tx_array_int] <= 13'd0;

      tx_r_valid_mac  <= 1'b0;
      tx_r_fixed_lat_8b <= 1'b0;
      tx_r_fixed_lat_en <= 1'b0;
    end
    else
    begin
      if (tx_eop_next_frame_avail)
      begin
        tx_data_avail <= 1'b1;
        tx_r_rd_8b_r  <= ~tx_fifo_full;
      end
      else if (tx_eop_no_new_frame_avail)
      begin
        tx_data_avail <= 1'b0;
        tx_r_rd_8b_r  <= 1'b0;
      end
      else if (tx_data_avail)
      begin
        tx_data_avail <= tx_data_avail;
        tx_r_rd_8b_r  <= ~tx_fifo_full;
      end
      else if (tx_r_data_rdy_8b)
      begin
        tx_data_avail <= 1'b1;
        tx_r_rd_8b_r  <= ~tx_fifo_full;
      end

      if (tx_eop_condition | tx_r_underflow_8b)
        tx_pip  <= 1'b0;
      else if (tx_pip | tx_valid_write)
        tx_pip  <= 1'b1;

      tx_r_valid_mac  <= tx_r_rd_mac & (|tx_wr_ptr);

      if ((tx_r_eop_mac|tx_r_err_mac) & tx_r_valid_mac)
      begin
        tx_r_fixed_lat_8b <= 1'b0;
        tx_r_fixed_lat_en <= 1'b0;
      end
      else if (tx_r_fixed_lat_en & tx_r_valid_mac)
      begin
        tx_r_fixed_lat_8b <= 1'b1;
        tx_r_fixed_lat_en <= 1'b0;
      end
      else if (tx_r_sop_mac & tx_r_valid_mac)
      begin
        tx_r_fixed_lat_8b <= 1'b0;
        tx_r_fixed_lat_en <= 1'b1;
      end

      if (tx_valid_write) // increment write pointer
      begin
        if (tx_r_valid_mac) //take the mod from write pointer
        begin
          tx_wr_ptr <= tx_wr_ptr - tx_wr_ptr_sub_nxt + 4'h1;
          for (tx_array_int = 0; tx_array_int < 8; tx_array_int=tx_array_int+1)
          begin
            if (tx_array_int[2:0] == nxt_mac_tx_wr_ptr[2:0])
              tx_data_array[tx_array_int[2:0]]  <= {tx_r_data_8b,tx_r_control_8b,tx_r_underflow_8b,tx_r_err_8b,tx_r_eop_8b,tx_r_sop_8b};
            else if (tx_array_int[2:0] < nxt_mac_tx_wr_ptr[2:0])
              tx_data_array[tx_array_int[2:0]]  <= tx_data_array[tx_array_int[2:0] + tx_wr_ptr_sub_nxt[2:0]];
          end
        end
        else
        begin
          tx_wr_ptr <= tx_wr_ptr + 3'h1;
          tx_data_array[tx_wr_ptr]  <= {tx_r_data_8b,tx_r_control_8b,tx_r_underflow_8b,tx_r_err_8b,tx_r_eop_8b,tx_r_sop_8b};
        end
      end
      else if (tx_r_valid_mac) //take the mod from write pointer
      begin
        tx_wr_ptr <= tx_wr_ptr - tx_wr_ptr_sub_nxt;
        for (tx_array_int = 0; tx_array_int < 8; tx_array_int=tx_array_int+1)
        begin
          if (tx_array_int[2:0] < nxt_mac_tx_wr_ptr[2:0])
            tx_data_array[tx_array_int[2:0]]  <= tx_data_array[tx_array_int[2:0] + tx_wr_ptr_sub_nxt[2:0]];
        end
      end
    end
  end
  assign eop_in_bottom_4 =  ((tx_data_array[0][1] | tx_data_array[0][2] | tx_data_array[0][3]) & (tx_wr_ptr >= 3'd1)) |
                            ((tx_data_array[1][1] | tx_data_array[1][2] | tx_data_array[1][3]) & (tx_wr_ptr >= 3'd2)) |
                            ((tx_data_array[2][1] | tx_data_array[2][2] | tx_data_array[2][3]) & (tx_wr_ptr >= 3'd3)) |
                            ((tx_data_array[3][1] | tx_data_array[3][2] | tx_data_array[3][3]) & (tx_wr_ptr >= 3'd4));
  assign tx_r_data_rdy_mac = tx_wr_ptr >= 3'd4 | eop_in_bottom_4;

  always @(*)
  begin
    tx_r_sop_mac = tx_data_array[0][0];
    tx_r_control_mac = tx_data_array[0][4];
    if (tx_data_array[0][1] | tx_data_array[0][2] | tx_data_array[0][3])
    begin
      tx_r_eop_mac = tx_data_array[0][1] | tx_data_array[0][3];
      tx_r_err_mac = tx_data_array[0][2];
      tx_r_mod_mac = 4'h1;
      tx_r_underflow_mac = tx_uflow_detected | (tx_data_array[0][3] & tx_r_valid_mac);
    end
    else if (tx_data_array[1][1] | tx_data_array[1][2] | tx_data_array[1][3])
    begin
      tx_r_eop_mac = tx_data_array[1][1] | tx_data_array[1][3];
      tx_r_err_mac = tx_data_array[1][2];
      tx_r_mod_mac = 4'h2;
      tx_r_underflow_mac = tx_uflow_detected | (tx_data_array[1][3] & tx_r_valid_mac);
    end
    else if (tx_data_array[2][1] | tx_data_array[2][2] | tx_data_array[2][3])
    begin
      tx_r_eop_mac = tx_data_array[2][1] | tx_data_array[2][3];
      tx_r_err_mac = tx_data_array[2][2];
      tx_r_mod_mac = 4'h3;
      tx_r_underflow_mac = tx_uflow_detected | (tx_data_array[2][3] & tx_r_valid_mac);
    end
    else if (tx_data_array[3][1] | tx_data_array[3][2] | tx_data_array[3][3])
    begin
      tx_r_eop_mac = tx_data_array[3][1] | tx_data_array[3][3];
      tx_r_err_mac = tx_data_array[3][2];
      tx_r_mod_mac = 4'h0;
      tx_r_underflow_mac = tx_uflow_detected | (tx_data_array[3][3] & tx_r_valid_mac);
    end
    else
    begin
      tx_r_eop_mac = 1'b0;
      tx_r_err_mac = 1'b0;
      tx_r_mod_mac = 4'h0;
      tx_r_underflow_mac = tx_uflow_detected;
    end

    for (tx_array_int_rd = 0; tx_array_int_rd < 4; tx_array_int_rd=tx_array_int_rd+1)
    begin
      tx_r_data_mac[(tx_array_int_rd*8+7)] = tx_data_array[tx_array_int_rd][12];
      tx_r_data_mac[(tx_array_int_rd*8+6)] = tx_data_array[tx_array_int_rd][11];
      tx_r_data_mac[(tx_array_int_rd*8+5)] = tx_data_array[tx_array_int_rd][10];
      tx_r_data_mac[(tx_array_int_rd*8+4)] = tx_data_array[tx_array_int_rd][9];
      tx_r_data_mac[(tx_array_int_rd*8+3)] = tx_data_array[tx_array_int_rd][8];
      tx_r_data_mac[(tx_array_int_rd*8+2)] = tx_data_array[tx_array_int_rd][7];
      tx_r_data_mac[(tx_array_int_rd*8+1)] = tx_data_array[tx_array_int_rd][6];
      tx_r_data_mac[(tx_array_int_rd*8)]   = tx_data_array[tx_array_int_rd][5];
    end
  end

// RX

  reg [10:0]      rx_data_array [p_rx_fifo_depth-1:0];
  reg [10:0]      nxt_rx_data_array [p_rx_fifo_depth-1:0];
  reg [3:0]       rx_wr_ptr;
  reg [3:0]       nxt_rx_wr_ptr;
  integer         rx_array_int1;
  integer         rx_array_int;
  reg             rx_w_valid_mac;
  wire [3:0]      rx_wr_ptr_m1;
  assign rx_wr_ptr_m1 = rx_wr_ptr - 4'h1;
  always@(posedge rx_clk or negedge rx_rst_n)
  begin
    if (~rx_rst_n)
    begin
      rx_wr_ptr   <= 4'h0;
      `ifdef gem_tsu
      rx_w_status_hold  <= {123{1'b0}};
      `else
      rx_w_status_hold  <= {45{1'b0}};
      `endif
      for (rx_array_int1 = 0; rx_array_int1 < p_rx_fifo_depth; rx_array_int1=rx_array_int1+1)
        rx_data_array[rx_array_int1] <= 11'h000;

      `ifdef gem_no_pcs
      `else // if not gem_no_pcs
      rx_w_sop_mac_d1 <= 1'b0;
      rx_w_eop_mac_d1 <= 1'b0;
      rx_w_wr_mac_d1 <= 1'b0;
      `endif
    end
    else if (~enable_receive)
    begin
      rx_wr_ptr   <= 4'h0;
      `ifdef gem_tsu
      rx_w_status_hold  <= {123{1'b0}};
      `else
      rx_w_status_hold  <= {45{1'b0}};
      `endif
      for (rx_array_int1 = 0; rx_array_int1 < p_rx_fifo_depth; rx_array_int1=rx_array_int1+1)
        rx_data_array[rx_array_int1] <= 11'h000;

      `ifdef gem_no_pcs
      `else // if not gem_no_pcs
      rx_w_sop_mac_d1 <= 1'b0;
      rx_w_eop_mac_d1 <= 1'b0;
      rx_w_wr_mac_d1 <= 1'b0;
      `endif
    end
    else
    begin
      `ifdef gem_no_pcs
      `else // if not gem_no_pcs
      rx_w_sop_mac_d1 <= rx_w_sop_mac;
      rx_w_eop_mac_d1 <= rx_w_eop_mac;
      rx_w_wr_mac_d1 <= rx_w_wr_mac;
      `endif
      if (rx_w_wr_mac & rx_w_eop_mac)
      `ifdef gem_tsu
        rx_w_status_hold  <= {rx_w_timestamp_mac,rx_w_status_mac};
      `else
        rx_w_status_hold  <= rx_w_status_mac;
      `endif
      rx_wr_ptr <= nxt_rx_wr_ptr;
      for (rx_array_int1 = 0; rx_array_int1 < p_rx_fifo_depth; rx_array_int1=rx_array_int1+1)
        rx_data_array[rx_array_int1]  <= nxt_rx_data_array[rx_array_int1];

    end
  end

  // Use a combinatorial process here to avoid false LINT warnings to do with driving a signal multiple times
  // using non blocking assignments
  always @(*)
  begin
    if (rx_w_wr_mac_gated)
    begin
      if (rx_w_wr_8b)
      begin

        if (rx_w_eop_mac & (|rx_w_mod_mac))
          nxt_rx_wr_ptr = rx_wr_ptr_m1 + {2'b00,rx_w_mod_mac[1:0]};
        else
          nxt_rx_wr_ptr = rx_wr_ptr_m1 + 4'h4;

        for (rx_array_int = 0; rx_array_int < p_rx_fifo_depth; rx_array_int=rx_array_int+1)
        begin
          if (rx_array_int[3:0] == rx_wr_ptr_m1)
            nxt_rx_data_array[rx_array_int[3:0]]  = {rx_w_data_mac[7:0],(rx_w_err_mac & rx_w_mod_mac == 4'h1),(rx_w_eop_mac_gated & rx_w_mod_mac == 4'h1),rx_w_sop_mac_gated};
          else if (rx_array_int[3:0] == (rx_wr_ptr_m1 + 4'h1))
            nxt_rx_data_array[rx_array_int[3:0]]  = {rx_w_data_mac[15:8],(rx_w_err_mac & rx_w_mod_mac == 4'h2),(rx_w_eop_mac & rx_w_mod_mac == 4'h2),1'b0};
          else if (rx_array_int[3:0] == (rx_wr_ptr_m1 + 4'h2))
            nxt_rx_data_array[rx_array_int[3:0]]  = {rx_w_data_mac[23:16],(rx_w_err_mac & rx_w_mod_mac == 4'h3),(rx_w_eop_mac & rx_w_mod_mac == 4'h3),1'b0};
          else if (rx_array_int[3:0] == (rx_wr_ptr_m1 + 4'h3))
            nxt_rx_data_array[rx_array_int[3:0]]  = {rx_w_data_mac[31:24],(rx_w_err_mac & rx_w_mod_mac == 4'h0),(rx_w_eop_mac & rx_w_mod_mac == 4'h0),1'b0};
          else if (rx_array_int[3:0] != p_rx_fifo_depth-1)
            nxt_rx_data_array[rx_array_int[3:0]]  = rx_data_array[rx_array_int+1];
          else
            nxt_rx_data_array[rx_array_int[3:0]]  = rx_data_array[rx_array_int];
        end
      end

      else
      begin

        if (rx_w_eop_mac & (|rx_w_mod_mac))
          nxt_rx_wr_ptr = rx_wr_ptr + {2'b00,rx_w_mod_mac[1:0]};
        else
          nxt_rx_wr_ptr = rx_wr_ptr + 4'd4;

        for (rx_array_int = 0; rx_array_int < p_rx_fifo_depth; rx_array_int=rx_array_int+1)
        begin
          if (rx_array_int[3:0] == rx_wr_ptr)
            nxt_rx_data_array[rx_array_int[3:0]]  = {rx_w_data_mac[7:0],(rx_w_err_mac & rx_w_mod_mac == 4'h1),(rx_w_eop_mac_gated & rx_w_mod_mac == 4'h1),rx_w_sop_mac_gated};
          else if (rx_array_int[3:0] == (rx_wr_ptr + 4'h1))
            nxt_rx_data_array[rx_array_int[3:0]]  = {rx_w_data_mac[15:8],(rx_w_err_mac & rx_w_mod_mac == 4'h2),(rx_w_eop_mac & rx_w_mod_mac == 4'h2),1'b0};
          else if (rx_array_int[3:0] == (rx_wr_ptr + 4'h2))
            nxt_rx_data_array[rx_array_int[3:0]]  = {rx_w_data_mac[23:16],(rx_w_err_mac & rx_w_mod_mac == 4'h3),(rx_w_eop_mac & rx_w_mod_mac == 4'h3),1'b0};
          else if (rx_array_int[3:0] == (rx_wr_ptr + 4'h3))
            nxt_rx_data_array[rx_array_int[3:0]]  = {rx_w_data_mac[31:24],(rx_w_err_mac & rx_w_mod_mac == 4'h0),(rx_w_eop_mac & rx_w_mod_mac == 4'h0),1'b0};
          else
            nxt_rx_data_array[rx_array_int[3:0]]  = rx_data_array[rx_array_int];
        end
      end
    end

    else if (rx_w_wr_8b)
    begin
      nxt_rx_wr_ptr = rx_wr_ptr_m1;
      nxt_rx_data_array[(p_rx_fifo_depth-1)]  = rx_data_array[(p_rx_fifo_depth-1)];
      for (rx_array_int = 0; rx_array_int < (p_rx_fifo_depth-1); rx_array_int=rx_array_int+1)
        nxt_rx_data_array[rx_array_int[3:0]]  = rx_data_array[rx_array_int+1];
    end

    else
    begin
      nxt_rx_wr_ptr = rx_wr_ptr;
      for (rx_array_int = 0; rx_array_int < p_rx_fifo_depth; rx_array_int=rx_array_int+1)
        nxt_rx_data_array[rx_array_int[3:0]]  = rx_data_array[rx_array_int];
    end
  end

  assign rx_w_wr_8b         = |rx_wr_ptr;
  assign rx_w_sop_8b        = rx_data_array[0][0];
  assign rx_w_eop_8b        = rx_data_array[0][1];
  assign rx_w_err_8b        = rx_data_array[0][2];
  assign rx_w_data_8b       = rx_data_array[0][10:3];
  assign rx_w_status_8b     = rx_w_status_hold[44:0];
  `ifdef gem_tsu
  assign rx_w_timestamp_8b  = rx_w_status_hold[122:45];
  `endif

  `ifdef gem_no_pcs
  assign rx_w_sop_mac_gated = rx_w_sop_mac;
  assign rx_w_eop_mac_gated = rx_w_eop_mac;
  assign rx_w_wr_mac_gated  = rx_w_wr_mac;
  `else // if not gem_no_pcs
  assign rx_w_sop_mac_gated = tbi_selected ? rx_w_sop_mac & ~rx_w_sop_mac_d1 : rx_w_sop_mac;
  assign rx_w_eop_mac_gated = tbi_selected ? rx_w_eop_mac & ~rx_w_eop_mac_d1 : rx_w_eop_mac;
  assign rx_w_wr_mac_gated  = tbi_selected ? rx_w_wr_mac & ~rx_w_wr_mac_d1 : rx_w_wr_mac;
  `endif // if not gem_no_pcs


endmodule
