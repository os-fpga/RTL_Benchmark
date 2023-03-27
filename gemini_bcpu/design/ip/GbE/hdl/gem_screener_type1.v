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
//   Filename:           gem_screener_type1.v
//   Module Name:        gem_screener_type1
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
//   Description :
//
//             Decoding logic: The received frame's UDP destination address,
//                             TOS/TC and VLAN are all used to determine
//                             which queue each type of packet should be
//                             routed to.
//
//------------------------------------------------------------------------------


// The gem_screener_type1 module definition
module gem_screener_type1 (

   // system signals
   n_rxreset,
   rx_clk,

  // Matches for screener module - Queue Priority
   udptos_rules,

  // Decodes for screener module - Queue Priority
  ip_v4_tos,
  ip_v6_tc,
  udp_dest_addr,
  ip_v4_frame,
  ip_v6_frame,
  udp_frame,
  matched,
  drop_frame

   );


// -----------------------------------------------------------------------------
// declare Inputs and Outputs
// -----------------------------------------------------------------------------

   // system inputs
   input          n_rxreset;     // RX clock system reset
   input          rx_clk;        // RX clock input

   input   [31:0] udptos_rules;

   // Decodes for screener module
   input    [7:0] ip_v4_tos;     // value of ipv4 TOS.
   input    [7:0] ip_v6_tc;      // value of ipv6 TC.
   input   [15:0] udp_dest_addr; // value of UDP Destination Addr.
   input          ip_v4_frame;   // Enable ipv4 tos.
   input          ip_v6_frame;   // Enable ipv6 tc.
   input          udp_frame;     // Enable ipv6 tc.
 
   output         matched;       // Match occurred
   output         drop_frame;    // drop frame on a match

// -----------------------------------------------------------------------------
// Match on UDP and TOS/TC if enabled
// -----------------------------------------------------------------------------

  wire ip_v4_tos_match;
  wire ip_v6_tc_match;
  wire udp_dest_addr_match;
  wire drop_on_match;
  reg  matched;

  // bit 30 sync in rx_clk domain
  cdnsdru_datasync_v1 i_drop_on_match_type1_sync (
    .clk     (rx_clk),
    .reset_n (n_rxreset),
    .din     (udptos_rules[30]),
    .dout    (drop_on_match)
  );

  assign ip_v4_tos_match     = ip_v4_frame & (ip_v4_tos == udptos_rules[11:4]);
  assign ip_v6_tc_match      = ip_v6_frame & (ip_v6_tc == udptos_rules[11:4]);
  assign udp_dest_addr_match = udp_frame   & (udp_dest_addr == udptos_rules[27:12]);
  assign drop_frame          = matched     & drop_on_match;

  always @(posedge rx_clk or negedge n_rxreset)
  begin
     if (~n_rxreset)
         matched <= 1'b0;
    else // UDP match Enable -/- TOS/TC Enable
       case ({udptos_rules[29], udptos_rules[28]})
          2'b01:   matched <= ip_v6_tc_match || ip_v4_tos_match;
          2'b10:   matched <= udp_dest_addr_match;
          2'b11:   matched <= udp_dest_addr_match && (ip_v6_tc_match || ip_v4_tos_match);
          default: matched <= 1'b0;
        endcase
  end

endmodule
