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
//   Filename:           gem_screener_type2.v
//   Module Name:        gem_screener_type2
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


// The gem_screener_type2 module definition
module gem_screener_type2 (

   // system signals
   input        n_rxreset,            // RX clock system reset
   input        rx_clk,               // RX clock input

   // Field Extractions
   input  [2:0] tci,                  // VLAN priority extracted from packet
   input        vlan_tagged,          // Packet is VLAN
   input  [7:0] scr2_ethtype_match,   // Ethertype matched
   input [31:0] scr2_compare_match,   // Compare matched


   // Matches for screener module - Queue Priority
   input [31:0] vlan_rules,

   // Decodes for screener module - Queue Priority
   output reg   matched,              // Match occurred
   output       drop_frame            // Drop frame on a match

   );

// -----------------------------------------------------------------------------
// declare wires and regs
// -----------------------------------------------------------------------------

  wire         vlan_match;
  wire         drop_on_match;
  reg          ethtype_matched;
  reg          compa_match;
  reg          compb_match;
  reg          compc_match;

  // bit 31 sync in rx_clk domain
  cdnsdru_datasync_v1 i_drop_on_match_type2_sync (
    .clk     (rx_clk),
    .reset_n (n_rxreset),
    .din     (vlan_rules[31]),
    .dout    (drop_on_match)
  );

  assign vlan_match = (tci == vlan_rules[6:4] & vlan_tagged);
  assign drop_frame = matched & drop_on_match;

  integer inta, intb;
  always @(*)
  begin
    ethtype_matched = 1'b0;
    for (inta = 0;inta <= 7;inta=inta+1)
    begin
      if (vlan_rules[11:9] == inta[2:0])
        ethtype_matched = scr2_ethtype_match[inta];
    end
  end

  always @(*)
  begin
    compa_match = 1'b0;
    compb_match = 1'b0;
    compc_match = 1'b0;
    for (intb = 0;intb <= 31;intb=intb+1)
    begin
      if (vlan_rules[17:13] == intb[4:0])
        compa_match = scr2_compare_match[intb];
      if (vlan_rules[23:19] == intb[4:0])
        compb_match = scr2_compare_match[intb];
      if (vlan_rules[29:25] == intb[4:0])
        compc_match = scr2_compare_match[intb];
    end
  end

// -----------------------------------------------------------------------------
// Match on UDP and TOS/TC if enabled
// -----------------------------------------------------------------------------

  always @(posedge rx_clk or negedge n_rxreset)
  begin
    if (~n_rxreset)
      matched <= 1'b0;
    else
    begin
      if (|{vlan_rules[8],
            vlan_rules[12],
            vlan_rules[18],
            vlan_rules[24],
            vlan_rules[30]})
      begin
        if  (~(~vlan_match       & vlan_rules[8])  &
             ~(~ethtype_matched  & vlan_rules[12]) &
             ~(~compa_match      & vlan_rules[18]) &
             ~(~compb_match      & vlan_rules[24]) &
             ~(~compc_match      & vlan_rules[30]))

          matched <= 1'b1;
        else
          matched <= 1'b0;
      end
      else
        matched <= 1'b0;
    end
  end

endmodule
