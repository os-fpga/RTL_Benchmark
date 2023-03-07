//------------------------------------------------------------------------------
// Copyright (c) 2002-2017 Cadence Design Systems, Inc.
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
//   Filename:           rgmii_interface.v
//   Module Name:        rgmii_interface
//
//   Release Revision:   r1p12f2
//   Release SVN Tag:    gem_gxl_det0102_r1p12f2
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
//   Description    : This is the rgmii_interface module for the Ethernet MAC.
//                    It provides the appropriate interfaces to connect the EMAC
//                    GMII interface and ten bit interface to an RGMII
//                    compatible PHY.
//
//------------------------------------------------------------------------------

// include definitions files
`ifndef gem_defs_defined
`define gem_defs_defined
`include "gem_gxl_defs.v"
`include "edma_defs.v"
`endif

// rgmii interface for MAC
module rgmii(
                       // System signals
                       n_rgmii_rxreset,
                       n_rgmii_rx_n_reset,

                       n_rgmii_txreset,
                       n_rgmii_tx_n_reset,
                       rgmii_tx_clk,
                       rgmii_tx_n_clk,

                       // Clock input signal
                       rgmii_rx_clk,
                       rgmii_rx_n_clk,
                       rgmii_tx_clk_sig,

                       // RGMII signals
                       rgmii_txd,
                       rgmii_tx_ctl,
                       rgmii_rxd,
                       rgmii_rx_ctl,

                       // gmii / mii ethernet interface.
                       gmii_col,
                       gmii_crs,
                       gmii_tx_er,
                       gmii_txd,
                       gmii_tx_en,
                       gmii_rxd,
                       gmii_rx_er,
                       gmii_rx_dv,
                       gmii_gigabit,
                       gmii_link_status,
                       gmii_speed,
                       gmii_duplex_in,
                       gmii_duplex_out

                       );

//------------------------------------------------------------------------------
// Declare inputs and outputs
//------------------------------------------------------------------------------
   input          n_rgmii_rxreset;     // reset associated with rgmii_rx_clk
   input          n_rgmii_rx_n_reset;  // reset associated with rgmii_rx_n_clk

   input          n_rgmii_txreset;     // reset associated with rgmii_tx_clk
   input          n_rgmii_tx_n_reset;  // reset associated with rgmii_tx_n_clk
   input          rgmii_tx_clk;        //transmit clock
   input          rgmii_tx_n_clk;      //out of phase transmit clock


   // Clock inputs
   input          rgmii_rx_clk;        //receive clock
   input          rgmii_rx_n_clk;      //out of phase transmit clock
   input          rgmii_tx_clk_sig;    //transmit clock used as mux select


   // MII signals
   // Note that gmii_col and crs are asynchronous output signals.
   output         gmii_col;             // Indicate collision occured.
   output         gmii_crs;             // Carrier sense signal.
   input    [7:0] gmii_txd;             // Transmit data byte.
   input          gmii_tx_en;           // Transmit enable.
   input          gmii_tx_er;           // transmit error
   output   [7:0] gmii_rxd;             // Receive data byte.
   output         gmii_rx_er;           // Receive error.
   output         gmii_rx_dv;           // Receive data valid.
   input          gmii_gigabit;         // indicates gigabit operation
   output         gmii_link_status;     // indicates link status
   output [1:0]   gmii_speed;           // Rgmii extracted speed signal
   output         gmii_duplex_out;      // Rgmii extracted duplex signal
   input          gmii_duplex_in;       // input duplex signal

   // RGMII signals
   output   [3:0] rgmii_txd;       // Transmit data, nibble.
   output         rgmii_tx_ctl;    // Transmit enable on RGMII.
   input    [3:0] rgmii_rxd;       // Receive data, nibble.
   input          rgmii_rx_ctl;    // Receive error on RGMII.


   // Wire and reg declarations.
   wire           gmii_col;        // Indicate collision occured.
   wire           gmii_crs;        // Carrier sense signal.
   reg      [7:0] gmii_rxd;        // Receive data byte.
   reg            gmii_rx_er;      // Receive error.
   reg            gmii_rx_dv;      // Receive data valid.
   reg      [3:0] tx_data_neg;     // nibble to be transmitted on neg edge
   reg      [3:0] tx_data_pos;     // nibble to be transmitted on pos edge
   reg            tx_ctrl_neg;     // ctrl bit to be transmitted on neg edge
   reg            tx_ctrl_pos;     // ctrl bit to be transmitted on pos edge
   reg      [3:0] rx_data_pos;     // nibble received on neg edge
   reg            rx_ctrl_pos;     // ctrl bit received on neg edge
   reg      [3:0] rx_data_neg;     // nibble received on neg edge
   reg            rx_ctrl_neg;     // ctrl bit received on neg edge
   reg            crs_dv;          // carrier sense and data valid
   reg            gmii_duplex_out; // Rgmii extracted duplex signal
   reg            gmii_link_status;// indicates link status
   reg      [1:0] gmii_speed;      // Rgmii extracted speed signal
   reg      [3:0] tx_data_neg_1b;  // early nibble received on neg edge
   reg            tx_ctrl_neg_1b;  // early ctrl bit received on neg edge
   wire           gmii_gigabit_sync; // gmii_gigabit synchronised to rgmii_rx_clk


   assign rgmii_txd    = rgmii_tx_clk_sig? tx_data_pos : tx_data_neg;
   assign rgmii_tx_ctl = rgmii_tx_clk_sig? tx_ctrl_pos : tx_ctrl_neg;


//==============================================================================
// transmit data on tx_pose  edge
// pos signals are the signals to be transmitted on the rising edge of the
// rgmii_tx_clk
// _neg_1b signals are to be sampled on the rising edge of rgmii_tx_n_clk
// and to be transmitted on the falling edge of rgmii_tx_clk.
//==============================================================================
   always@(posedge rgmii_tx_clk or negedge n_rgmii_txreset)
     begin
        if (~n_rgmii_txreset)
          begin
             tx_data_pos    <=  4'h0;
             tx_ctrl_pos    <=  1'b0;
             tx_data_neg_1b <=  4'h0;
             tx_ctrl_neg_1b <=  1'b0;
          end
        else
          begin
             tx_data_pos    <=  gmii_txd[3:0];
             tx_ctrl_pos    <=  gmii_tx_en;
             tx_data_neg_1b <=  gmii_txd[7:4];
             tx_ctrl_neg_1b <=  gmii_tx_en ^ gmii_tx_er;
          end
     end


//==============================================================================
// negedge transmit data
// tx data and control signals that has to be transmitted on the rising
// edge of the rgmii_tx_clk
//==============================================================================
   always@(posedge rgmii_tx_n_clk or negedge n_rgmii_tx_n_reset )
     begin
        if (~n_rgmii_tx_n_reset)
          begin
             tx_data_neg <=  4'h0;
             tx_ctrl_neg <=  1'b0;
          end
        else
          begin
             tx_data_neg <=  tx_data_neg_1b;
             tx_ctrl_neg <=  tx_ctrl_neg_1b;
          end
     end



//==============================================================================
// posedge receive data
// -lower nibble of gmii_rxd
// -gmii_rx_dv
// reset value is been set to 4 which resuts in the decode of
// speed,link_status and duplex_out signals to their default values
//==============================================================================
   always@(posedge rgmii_rx_clk or negedge n_rgmii_rxreset)
     begin
        if (~n_rgmii_rxreset)
          begin
             rx_data_pos <=  4'h4;
             rx_ctrl_pos <=  1'b0;
          end
        else
          begin
             rx_data_pos <=  rgmii_rxd;
             rx_ctrl_pos <=  rgmii_rx_ctl;
          end
     end


//==============================================================================
// negedge receive data
// -upper nibble of gmii_rxd
// -encoded gmii_rx_er signal
//==============================================================================
   always@(posedge rgmii_rx_n_clk or negedge n_rgmii_rx_n_reset)
     begin
        if (~n_rgmii_rx_n_reset)
          begin
             rx_data_neg <=  4'h0;
             rx_ctrl_neg <=  1'b0;
          end
        else
          begin
             rx_data_neg <=  rgmii_rxd;
             rx_ctrl_neg <=  rgmii_rx_ctl;
          end
     end



//==============================================================================
// received data and control (gmii) signals
// -gmii_rx_dv is received on the rising edge of the rgmii_rx_clk
// -gmii_rx_er is received on the falling edge of the rgmii_rx_clk
// -gmii_rxd is received on the both edges of the rgmii_rx_clk in the form of
//  nibbles
//==============================================================================
  always@(posedge rgmii_rx_clk or negedge n_rgmii_rxreset)
     begin
        if (~n_rgmii_rxreset)
          begin
             gmii_rxd      <=  8'h00;
             gmii_rx_er    <=  1'b0;
             gmii_rx_dv    <=  1'b0;
          end
        else
          begin
             gmii_rx_dv    <=  rx_ctrl_pos;
        //   gmii_rxd      <=  {rx_data_neg,rx_data_pos};
             gmii_rxd[3:0] <=  rx_data_pos;
             gmii_rxd[7:4] <=  rx_data_neg & {4{gmii_gigabit_sync}};
             gmii_rx_er    <=  rx_ctrl_pos ^ rx_ctrl_neg;
          end
     end

// synchronize gmii_gigabit
//wire gmii_gigabit_sync;
   cdnsdru_datasync_v1 i_cdnsdru_datasync_v1_gmii_gigabit (
      .clk(rgmii_rx_clk),
      .reset_n(n_rgmii_rxreset),
      .din(gmii_gigabit),
      .dout(gmii_gigabit_sync));

//==============================================================================
// carrier sense /data valid signal decoding
// - GMII_RX_DV true ie. rx_ctrl_pos
// - GMII_RX_DV is false and GMII_RX_ER is true (ie. rx_ctrl_neg) and
//    - GMII_RXD[7:0] contains ff (carrier sense)
//    - GMII_RXD[7:0] contains oe (false carrier indication)
//    - if gigabit mode and
//         - GMII_RXD[7:0] contains 1f (carrier extend error)
//         - GMII_RXD[7:0] contains 0f (carrier extend)
//==============================================================================
   always@(posedge rgmii_rx_clk or negedge n_rgmii_rxreset)
     begin
        if (~n_rgmii_rxreset)
          begin
             crs_dv   <=  1'b0;
          end
        else
          if (((rx_ctrl_neg & ~rx_ctrl_pos) &
               (({rx_data_neg,rx_data_pos} == 8'hff) |
                ({rx_data_neg,rx_data_pos} == 8'h0e) |
                ((({rx_data_neg,rx_data_pos} == 8'h1f)  |
                  ({rx_data_neg,rx_data_pos} == 8'h0f)) &
                 gmii_gigabit_sync))) | rx_ctrl_pos)
            begin
               crs_dv   <=  1'b1;
            end
          else
            begin
               crs_dv   <=  1'b0;
            end
     end


//==============================================================================
// extraction of GMII control signals
// -when there is no carrier sense and no receive error detected
//  gmii_rxd contains the control information:
//    gmii_link_status  gmii_rxd[0]
//    gmii_duplex_out   gmii_rxd[3]
//    gmii_speed        gmii_rxd[2:1]
//==============================================================================
   always@(posedge rgmii_rx_clk or negedge n_rgmii_rxreset)
     begin
        if (~n_rgmii_rxreset)
          begin
             gmii_link_status  <=  1'b0;
             gmii_duplex_out   <=  1'b0;
             gmii_speed        <=  2'b10;
          end
        else
          begin
             if (~rx_ctrl_pos & ~rx_ctrl_neg)
               begin
                  gmii_link_status  <= rx_data_pos[0];
                  gmii_speed        <= rx_data_pos[2:1];
                  gmii_duplex_out   <= rx_data_pos[3];
               end
             else
               begin
                  gmii_link_status  <= gmii_link_status;
                  gmii_speed        <= gmii_speed;
                  gmii_duplex_out   <= gmii_duplex_out;
               end
          end
     end



//==============================================================================
// gmii_col indicates the collision detection in the half duplex mode
//==============================================================================

   assign gmii_col = crs_dv & gmii_tx_en & ~gmii_duplex_in;

//==============================================================================
// gmii_crs indicates carrier sense ie  valid data received
//
// Note the RGMII interface should assert CRS on TX_EN. When the RGMII spec says
// 'The PHY will not assert CRS as a result of TX_EN being true' it is referring
// to the PHY and not the RGMII interface.
//
//==============================================================================

   assign gmii_crs = crs_dv | gmii_tx_en;


endmodule
