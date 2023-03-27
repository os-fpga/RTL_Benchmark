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
//   Filename:           gem_screener_top.v
//   Module Name:        gem_screener_top
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

// include definitions files
`ifndef gem_defs_defined
`define gem_defs_defined
`include "gem_gxl_defs.v"
`include "edma_defs.v"
`endif

// The gem_rx_decode module definition
module gem_screener_top (

   // system signals
   n_rxreset,
   rx_clk,

   // set default queue
   reset_queue_ptr,

   // Matches for screener module - Queue Priority
   screener_type1_regs,
   ip_v4_frame,
   ip_v6_frame,
   udp_frame,
   ip_v4_tos,
   ip_v6_tc,
   udp_dest_addr,

   screener_type2_regs,
   scr2_ethtype_match,
   scr2_compare_match,
   tci,
   vlan_tagged,

   priority_queue,
   drop_frame,

   scr2_match_vec

   );

parameter p_num_type1_screeners = 8'd0;
parameter p_num_type2_screeners = 8'd0;

  // -----------------------------------------------------------------------------
  // declare Inputs and Outputs
  // -----------------------------------------------------------------------------

  // system inputs
  input          n_rxreset;               // RX clock system reset
  input          rx_clk;                  // RX clock input

  input          reset_queue_ptr;         // Reset to default queue

  input          ip_v4_frame;
  input          ip_v6_frame;
  input          udp_frame;
  input    [7:0] ip_v4_tos;               // value of ipv4 TOS.
  input    [7:0] ip_v6_tc;                // value of ipv6 TC.
  input   [15:0] udp_dest_addr;           // value of UDP Destination Addr.

  input    [7:0] scr2_ethtype_match;      // Ethertype matched
  input   [31:0] scr2_compare_match;      // compare matched
  input    [2:0] tci;                     // used for extacting VLAN priority.
  input          vlan_tagged;             // Indicates VLAN packet


  input [(32*p_num_type1_screeners):0] screener_type1_regs;
  input [(32*p_num_type2_screeners):0] screener_type2_regs;


  output   [3:0] priority_queue;         // Queue for current packet
  output         drop_frame;             // The screeners have decided to drop the frame
  output  [15:0] scr2_match_vec;         // Raw match from screener 2.


  reg  [3:0] priority_queue;
  reg        drop_frame;

  wire [p_num_type1_screeners:0] match_queue_type1;  // matches from each screener
  wire [p_num_type1_screeners:0] drop_frame_type1;
  wire [p_num_type1_screeners:0] match_type1_temp1 ;
  wire [p_num_type1_screeners:0] match_type1_temp2 ;
  wire [p_num_type1_screeners:0] match_type1_temp3 ;
  wire [p_num_type1_screeners:0] match_type1_temp4 ;

  integer m;

  //-----------------------------------------------------------------------------
  //  UDP/TOS/TC Screener Decoding
  //-----------------------------------------------------------------------------

  // Generate the number of Instances of the required
  // UDP/TC/TOS screeners
  genvar i;
  genvar k;
  generate if (p_num_type1_screeners > 8'd0) begin : gen_scrn1
    wire  [(32*p_num_type1_screeners)-1:0]  screener_type1_regs_int;
    assign screener_type1_regs_int  = screener_type1_regs[(32*p_num_type1_screeners):1];

    wire [p_num_type1_screeners-1:0] match_queue_type1_c;
    reg  [p_num_type1_screeners-1:0] match_type1_temp1_r ;
    reg  [p_num_type1_screeners-1:0] match_type1_temp2_r ;
    reg  [p_num_type1_screeners-1:0] match_type1_temp3_r ;
    reg  [p_num_type1_screeners-1:0] match_type1_temp4_r ;
    wire [p_num_type1_screeners-1:0] low_match_type1;    // Match array location
    wire [p_num_type1_screeners-1:0] drop_frame_type1_c;
    for (i=0; i<p_num_type1_screeners; i = i+1) begin : gen_screener_type1
      gem_screener_type1 i_screener_type1(
        .n_rxreset     (n_rxreset),
        .rx_clk        (rx_clk),
        .udptos_rules  (screener_type1_regs_int[(32*i+31):i*32]),
        .ip_v4_tos     (ip_v4_tos),
        .ip_v6_tc      (ip_v6_tc),
        .ip_v4_frame   (ip_v4_frame),
        .ip_v6_frame   (ip_v6_frame),
        .udp_frame     (udp_frame),
        .udp_dest_addr (udp_dest_addr),
        .matched       (match_queue_type1_c[i]),
        .drop_frame    (drop_frame_type1_c[i])
      );

    end

    // Find the lowest addressed match - simplifies finding the queue #
    // 2's complement addtion
    //assign low_match_type2 = (match_queue_type2[0])? 1 : ((((~match_queue_type2)+ 1) & match_queue_type2) - 1);
    assign low_match_type1 = ((~match_queue_type1_c+ 1'b1) & match_queue_type1_c);

    // Generate an array to match up the screener match to its queue number
    for (k=0; k<p_num_type1_screeners; k = k+1) begin :screener_type1_q
      always@(*)
      begin
        match_type1_temp1_r [k] = screener_type1_regs_int[32*k] & low_match_type1[k];
        match_type1_temp2_r [k] = screener_type1_regs_int[((32*k)+1)] & low_match_type1[k];
        match_type1_temp3_r [k] = screener_type1_regs_int[((32*k)+2)] & low_match_type1[k];
        match_type1_temp4_r [k] = screener_type1_regs_int[((32*k)+3)] & low_match_type1[k];
       end
    end
    assign match_type1_temp1  = {match_type1_temp1_r,1'b0};
    assign match_type1_temp2  = {match_type1_temp2_r,1'b0};
    assign match_type1_temp3  = {match_type1_temp3_r,1'b0};
    assign match_type1_temp4  = {match_type1_temp4_r,1'b0};
    assign match_queue_type1  = {match_queue_type1_c,1'b0};
    assign drop_frame_type1   = {drop_frame_type1_c,1'b0};
  end else begin : gen_no_scrn1
    assign match_type1_temp1 = 1'b0;
    assign match_type1_temp2 = 1'b0;
    assign match_type1_temp3 = 1'b0;
    assign match_type1_temp4 = 1'b0;
    assign match_queue_type1 = 1'b0;
    assign drop_frame_type1  = 1'b0;
  end
  endgenerate

  //-----------------------------------------------------------------------------
  //  VLAN Screener Decoding
  //-----------------------------------------------------------------------------
  wire  [p_num_type2_screeners:0] match_queue_type2; // matches from each screener
  wire  [p_num_type2_screeners:0] drop_frame_type2;
  wire  [p_num_type2_screeners:0] match_type2_temp1 ;
  wire  [p_num_type2_screeners:0] match_type2_temp2 ;
  wire  [p_num_type2_screeners:0] match_type2_temp3 ;
  wire  [p_num_type2_screeners:0] match_type2_temp4 ;

  // Generate the number of Instances of the required
  // VLAN screeners
  genvar h;
  genvar t;
  genvar lp;
  generate if (p_num_type2_screeners > 8'd0) begin : gen_scrn2
    wire  [(32*p_num_type2_screeners)-1:0]  screener_type2_regs_int;
    assign screener_type2_regs_int  = screener_type2_regs[(32*p_num_type2_screeners):1];

    wire  [p_num_type2_screeners-1:0] low_match_type2;     // Match array location
    wire  [p_num_type2_screeners-1:0] match_queue_type2_c; // matches from each screener
    wire  [p_num_type2_screeners-1:0] drop_frame_type2_c;
    reg   [p_num_type2_screeners-1:0] match_type2_temp1_r;
    reg   [p_num_type2_screeners-1:0] match_type2_temp2_r;
    reg   [p_num_type2_screeners-1:0] match_type2_temp3_r;
    reg   [p_num_type2_screeners-1:0] match_type2_temp4_r;
    for (h=0; h<p_num_type2_screeners; h = h+1) begin :screener_type2
      gem_screener_type2 i_screener_type2(
        .n_rxreset          (n_rxreset),
        .rx_clk             (rx_clk),
        .vlan_rules         (screener_type2_regs_int[(32*h+31):h*32]),
        .scr2_ethtype_match (scr2_ethtype_match),
        .scr2_compare_match (scr2_compare_match),
        .tci                (tci),
        .vlan_tagged        (vlan_tagged),
        .matched            (match_queue_type2_c[h]),
        .drop_frame         (drop_frame_type2_c[h])
      );
      assign scr2_match_vec[h] = match_queue_type2_c[h];
    end

    if(p_num_type2_screeners < 8'd16) begin: gen_remaining_scrn2
      for (lp={24'd0,p_num_type2_screeners};lp<16;lp=lp+1) begin: scr2_vec_pad
         assign scr2_match_vec[lp] = 1'b0;
      end
    end
    // Find the lowest addressed match - simplifies finding the queue #
    assign low_match_type2 = ((~match_queue_type2_c + 1'b1) & match_queue_type2_c);

    // Generate an array to match up the screener match to its queue number
    for (t=0; t<p_num_type2_screeners; t=t+1)
    begin :screener_type2_q
      always@(*)
      begin
        match_type2_temp1_r [t] = screener_type2_regs_int[32*t]       & low_match_type2[t];
        match_type2_temp2_r [t] = screener_type2_regs_int[((32*t)+1)] & low_match_type2[t];
        match_type2_temp3_r [t] = screener_type2_regs_int[((32*t)+2)] & low_match_type2[t];
        match_type2_temp4_r [t] = screener_type2_regs_int[((32*t)+3)] & low_match_type2[t];
      end
    end
    assign match_type2_temp1 = {match_type2_temp1_r,1'b0};
    assign match_type2_temp2 = {match_type2_temp2_r,1'b0};
    assign match_type2_temp3 = {match_type2_temp3_r,1'b0};
    assign match_type2_temp4 = {match_type2_temp4_r,1'b0};
    assign match_queue_type2 = {match_queue_type2_c,1'b0};
    assign drop_frame_type2  = {drop_frame_type2_c,1'b0};
  end else begin : gen_no_scrn2
    assign match_type2_temp1 = 1'b0;
    assign match_type2_temp2 = 1'b0;
    assign match_type2_temp3 = 1'b0;
    assign match_type2_temp4 = 1'b0;
    assign match_queue_type2 = 1'b0;
    assign drop_frame_type2  = 1'b0;
    assign scr2_match_vec    = 16'h0000;
  end
  endgenerate

  //-----------------------------------------------------------------------------
  // Select queue number - Only the lowest addressed screener will have
  // a queue value
  //-----------------------------------------------------------------------------
  always @(posedge rx_clk or negedge n_rxreset)
  begin
   if (~n_rxreset)
     begin
       priority_queue <= 4'd0;
       drop_frame     <= 1'b0;
     end
   else
     begin
       if (reset_queue_ptr)
         begin
           priority_queue <= 4'd0;
           drop_frame     <= 1'b0;
         end
       else if (|match_queue_type1) // There is a udp/tc/tosmatch
         begin
           if(|drop_frame_type1)    // Drop on a match, priority_queue is don't care
             begin
               drop_frame     <= 1'b1;
               priority_queue <= 4'd0;
             end
           else
             begin
               drop_frame     <= 1'b0;
               priority_queue <= {|match_type1_temp4,|match_type1_temp3,|match_type1_temp2,|match_type1_temp1};
             end
         end
       else if (|match_queue_type2) // There is a vlan match
         begin
           if(|drop_frame_type2)    // Drop on a match, priority_queue is don't care
             begin
               drop_frame     <= 1'b1;
               priority_queue <= 4'd0;
             end
           else
             begin
               drop_frame     <= 1'b0;
               priority_queue <= {|match_type2_temp4,|match_type2_temp3,|match_type2_temp2,|match_type2_temp1};
             end
         end
       else // Use default Queue
         begin
            drop_frame     <= 1'b0;
            priority_queue <= 4'd0;
         end
     end
  end

endmodule
