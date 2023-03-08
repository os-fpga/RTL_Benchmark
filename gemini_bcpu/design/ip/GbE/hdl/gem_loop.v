//------------------------------------------------------------------------------
// Copyright (c) 2000-2017 Cadence Design Systems, Inc.
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
//   Filename:           gem_loop.v
//   Module Name:        gem_loop
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
//   Description    :   This block implements the internal loop back function
//
//------------------------------------------------------------------------------


module gem_loop (

   // control signals
   n_ntxreset,
   n_tx_clk,
   loopback_local,

   // external ethernet signals.
   col_to_loop,
   crs_to_loop,
   tx_er_from_loop,
   txd_from_loop,
   tx_en_from_loop,
   rxd_to_loop,
   rx_er_to_loop,
   rx_dv_to_loop,
   ext_match1_to_loop,
   ext_match2_to_loop,
   ext_match3_to_loop,
   ext_match4_to_loop,

   // internal ethernet signals.
   col_from_loop,
   crs_from_loop,
   tx_er_to_loop,
   txd_to_loop,
   tx_en_to_loop,
   rxd_from_loop,
   rx_er_from_loop,
   rx_dv_from_loop,
   ext_match1_from_loop,
   ext_match2_from_loop,
   ext_match3_from_loop,
   ext_match4_from_loop

);

   // control signals
   input         n_ntxreset;              // n_tx_clk reset
   input         n_tx_clk;                // neg edge of tx_clk used to retime
                                          // tx_clk outputs to rx_clk inputs.
   input         loopback_local;          // internal loopback signal.

   // external side of loopback module
   input         col_to_loop;             // collision detect signal from the
                                          // PHY.
   input         crs_to_loop;             // carrier sense signal from the PHY.
   output        tx_er_from_loop;         // transmit error signal to the PHY.
   output  [8:0] txd_from_loop;           // 0-7 bits transmit data to the PHY.
                                          // 8 bit parity
   output        tx_en_from_loop;         // transmit enable signal to the PHY.
   input   [8:0] rxd_to_loop;             // 0-7 bits receive data from the PHY.
                                          // 8 bit parity
   input         rx_er_to_loop;           // receive error signal from the PHY.
   input         rx_dv_to_loop;           // receive data valid signal from the
                                          // PHY.
   input         ext_match1_to_loop;      // external match (frame to be copied)
   input         ext_match2_to_loop;      // external match (frame to be copied)
   input         ext_match3_to_loop;      // external match (frame to be copied)
   input         ext_match4_to_loop;      // external match (frame to be copied)

   // internal side of loopback module
   output        col_from_loop;           // collision detect signal from the
                                          // PHY.
   output        crs_from_loop;           // carrier sense signal from the PHY.
   input         tx_er_to_loop;           // transmit error signal to the PHY.
   input   [8:0] txd_to_loop;             // 0-7 bits transmit data to the PHY.
                                          // 8 bit parity
   input         tx_en_to_loop;           // transmit enable signal to the PHY.
   output  [8:0] rxd_from_loop;           // 0-7 bits receive data from the PHY.
                                          // 8 bit parity
   output        rx_er_from_loop;         // receive error signal from the PHY.
   output        rx_dv_from_loop;         // receive data valid signal from the
                                          // PHY.
   output        ext_match1_from_loop;    // external match (frame to be copied)
   output        ext_match2_from_loop;    // external match (frame to be copied)
   output        ext_match3_from_loop;    // external match (frame to be copied)
   output        ext_match4_from_loop;    // external match (frame to be copied)


   // Internal reg and wire declarations
   reg     [8:0] rxd_looped;              // 0-7 bits txd sampled on the falling edge
                                          // 8 bit parity
   reg           rx_er_looped;            // tx_er sampled on the falling edge
   reg           rx_dv_looped;            // tx_en sampled on the falling edge


   // register tx signals on falling edge of n_tx_clk to allow better
   // setup and hold times to rx_clk_int_in
   always@(posedge n_tx_clk or negedge n_ntxreset)
     begin
      if (~n_ntxreset)
        begin
          rxd_looped   <= {1'b0,8'h00};
          rx_er_looped <= 1'b0;
          rx_dv_looped <= 1'b0;
        end
      else
        begin
          rxd_looped   <= txd_to_loop;
          rx_er_looped <= tx_er_to_loop;
          rx_dv_looped <= tx_en_to_loop;
        end
     end


   assign tx_er_from_loop = ((loopback_local) ? 1'b0 : tx_er_to_loop);
   assign txd_from_loop   = ((loopback_local) ? 9'd0 : txd_to_loop);
   assign tx_en_from_loop = ((loopback_local) ? 1'b0 : tx_en_to_loop);

   assign col_from_loop   = ((loopback_local) ? 1'b0          : col_to_loop);
   assign crs_from_loop   = ((loopback_local) ? tx_en_to_loop : crs_to_loop);

   assign rxd_from_loop   = ((loopback_local) ? rxd_looped    : rxd_to_loop);
   assign rx_er_from_loop = ((loopback_local) ? rx_er_looped  : rx_er_to_loop);
   assign rx_dv_from_loop = ((loopback_local) ? rx_dv_looped  : rx_dv_to_loop);

   assign ext_match1_from_loop = ((loopback_local) ? 1'b0 : ext_match1_to_loop);
   assign ext_match2_from_loop = ((loopback_local) ? 1'b0 : ext_match2_to_loop);
   assign ext_match3_from_loop = ((loopback_local) ? 1'b0 : ext_match3_to_loop);
   assign ext_match4_from_loop = ((loopback_local) ? 1'b0 : ext_match4_to_loop);

endmodule

