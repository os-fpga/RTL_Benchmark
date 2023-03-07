//------------------------------------------------------------------------------
// Copyright (c) 2016-2017 Cadence Design Systems, Inc.
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
//   Filename:           cdnsdru_asf_trans_timeout_v1.v
//   Module Name:        cdnsdru_asf_trans_timeout_v1
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
// Description    : ASF Transaction Timeout Monitoring reuse component
//                  Support basic transaction timeout checking.
//                  A generic timeout module used for interfaces 
//                  with a request and response type handshake.
//                  The timeout value will be an input along with an enable.
//                  Whenever the request is signalled, the timer will start 
//                  incrementing until the timeout value is reached or a 
//                  response is signalled. 
//------------------------------------------------------------------------------
//------------------------------------------------------------------------------

module cdnsdru_asf_trans_timeout_v1 #(
  parameter p_count_width      = 32'd12,                   // Sets the number of bits used for the counter. Minimum value is 2.
  parameter p_reg_op           = 1'b0                      // Optionally: register the trans_timeout output 
                                                           // default value of 0 - unregistered
) (
   // system inputs.
   input                                 clock,            // Clock
   input                                 reset_n,          // Reset

   // Packet buffer external DPRAM/SPRAM connections
   input  [p_count_width-1:0]            timeout_val,    // Count value at which timeout should occur. 
                                                           // This should only be updated while enable 
                                                           // is set to 0 and should have a minimum count
                                                           // value of 2.
   input                                 enable,           // Enable for transaction timeout monitoring
   input                                 trans_req,        // Transaction initiated
   input                                 trans_resp,       // Transaction response received
   input                                 timer_cnt_en,     // Timer count_up enable - external prescaler
                                                           // tie to one for normal count
   output                                trans_timeout     // Transaction timed out
);

// -----------------------------------------------------------------------------
//  wire and reg declarations
// -----------------------------------------------------------------------------

   reg    [p_count_width-1:0]            timer;                  // Timer
   wire                                  count_up;               // Increment counting (between high trans_req and trans_resp)
   wire                                  zero;                   // reset the timer
   wire                                  timer_active;           // Timer is active
   wire                                  trans_timeout_int;      // Transaction timeout value is reached (internal wire)

// -----------------------------------------------------------------------------
//  Beginning of main code.
// -----------------------------------------------------------------------------

  // -----------------------------------------------------------------------------
  //  Start and end of time count
  // -----------------------------------------------------------------------------

  // Request is signalled, timer start increment
  // Timer increment until timer zero
  assign timer_active = |timer;
  assign count_up = (trans_req & ~timer_active) | (timer_cnt_en & timer_active) ;
  // Response is signalled, timer stop and then cleared
  // or timer reached timeout value and then cleared
  assign zero = trans_resp | trans_timeout_int;

  // -----------------------------------------------------------------------------
  //  Timer implementation.
  // -----------------------------------------------------------------------------
   always @(posedge clock or negedge reset_n)
   begin
      if (!reset_n)
         timer <= {p_count_width{1'b0}};
      else if(enable) begin
        if (zero)
          // new count
          timer <= {p_count_width{1'b0}};
        else if (count_up)
          // increment timer
          timer <= timer + {{p_count_width-1{1'b0}}, 1'b1};
        else
          timer <= timer;
      end else
         timer <= {p_count_width{1'b0}};
   end

  // start incrementing until the timeout value is reached
  assign trans_timeout_int  =  (timer == timeout_val) & enable;

generate if(p_reg_op == 1'b1) begin : gen_reg_op 
   // register the transaction timeout value
   reg trans_timeout_r;

   always @(posedge clock or negedge reset_n)
   begin
     if (!reset_n)
       trans_timeout_r <= 1'b0;
     else
       trans_timeout_r <= trans_timeout_int; 
   end

   assign trans_timeout  =  trans_timeout_r;

end else begin : gen_no_reg_op
  assign trans_timeout  =  trans_timeout_int;
end
endgenerate

endmodule

