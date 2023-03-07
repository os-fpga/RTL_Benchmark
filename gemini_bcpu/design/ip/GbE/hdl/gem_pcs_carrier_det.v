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
//   Filename:           gem_pcs_carrier_det.v
//   Module Name:        gem_pcs_carrier_det
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
//   Description    :   This module implements the carrier detect function
//                      specified in IEEE 802.3 clause 36.2.5.1.4.
//
//                      Original 1 cycle latency removed to keep in line with
//                      changes to the decoder latency.
//
//------------------------------------------------------------------------------


module gem_pcs_carrier_det (

   // Inputs
   rx_clk,
   n_reset,
   sync_reset,
   tbi_code,
//   rdisp_odd,

   // Outputs
   carrier
   );

   // Port declarations

   input       rx_clk;                 // Receive clock.
   input       n_reset;                // Asynchronous active low reset.
   input       sync_reset;             // Synchronous active high reset.
   input [9:0] tbi_code;               // Ten bit input code.
//   input       rdisp_odd;              // End running disparity of odd codegroup
   output      carrier;                // Carrier detected signal.

   // Reg and wire declarations.

   reg         carrier;                // Carrier detected output.
//   reg [9:0]   rx_code;                // Sampled input code.
   wire [9:0]  rx_code;                // Input code.

   wire [9:0]  rxcode_diff_negk;       // rx_code xor with neg K28.5
   wire [9:0]  rxcode_diff_posk;       // rx_code xor with pos K28.5

   reg         diff_negk_2_9;          // 2-9 bit difference with neg K28.5
   reg         diff_posk_2_9;          // 2-9 bit difference with pos K28.5

   wire        difk_2_8;               // 2-8 bit difference with both K28.5
   //wire        dif_expk_2_9;           // 2-9 bit difference with expected K28.5
   wire        carrier_detected;       // Carrier has been detected


   // Synchronise the process...
   always@(posedge rx_clk or negedge n_reset)
    begin
      if (~n_reset)
         begin
//            rx_code <= 10'b1010000011;
            carrier <= 1'b0;
         end
      else if (sync_reset)
         begin
//            rx_code <= 10'b1010000011;
            carrier <= 1'b0;
         end
      else
         begin
//            rx_code <= tbi_code;
            carrier <= carrier_detected;
         end
     end

   assign rx_code = tbi_code;

   assign rxcode_diff_negk = rx_code ^ 10'b0101111100;
   assign rxcode_diff_posk = rx_code ^ 10'b1010000011;


   // Check for whether a 2-9 bit difference exists between the received code
   // group and the negative disparity encoding of K28.5
   always@(rxcode_diff_negk)
      begin
         case (rxcode_diff_negk)
            10'b0000000000: diff_negk_2_9 = 1'b0; // 0-bit difference.
            10'b0000000001: diff_negk_2_9 = 1'b0; // 1-bit differences.
            10'b0000000010: diff_negk_2_9 = 1'b0;
            10'b0000000100: diff_negk_2_9 = 1'b0;
            10'b0000001000: diff_negk_2_9 = 1'b0;
            10'b0000010000: diff_negk_2_9 = 1'b0;
            10'b0000100000: diff_negk_2_9 = 1'b0;
            10'b0001000000: diff_negk_2_9 = 1'b0;
            10'b0010000000: diff_negk_2_9 = 1'b0;
            10'b0100000000: diff_negk_2_9 = 1'b0;
            10'b1000000000: diff_negk_2_9 = 1'b0;
            10'b1111111111: diff_negk_2_9 = 1'b0; // 10-bit difference.
            default: diff_negk_2_9 = 1'b1;  // 2 to 9-bit difference.
         endcase
      end

   // Check for whether a 2-9 bit difference exists between the received code
   // group and the positive disparity encoding of K28.5
   always@(rxcode_diff_posk)
      begin
         case (rxcode_diff_posk)
            10'b0000000000: diff_posk_2_9 = 1'b0; // 0-bit difference.
            10'b0000000001: diff_posk_2_9 = 1'b0; // 1-bit differences.
            10'b0000000010: diff_posk_2_9 = 1'b0;
            10'b0000000100: diff_posk_2_9 = 1'b0;
            10'b0000001000: diff_posk_2_9 = 1'b0;
            10'b0000010000: diff_posk_2_9 = 1'b0;
            10'b0000100000: diff_posk_2_9 = 1'b0;
            10'b0001000000: diff_posk_2_9 = 1'b0;
            10'b0010000000: diff_posk_2_9 = 1'b0;
            10'b0100000000: diff_posk_2_9 = 1'b0;
            10'b1000000000: diff_posk_2_9 = 1'b0;
            10'b1111111111: diff_posk_2_9 = 1'b0; // 10-bit difference.
            default: diff_posk_2_9 = 1'b1;  // 2 to 9-bit difference.
         endcase
      end

   // According to IEEE 802.3 clause 36.2.5.1.4, carrier is detected when
   // two or more bit difference exist between code and both K28.5 encodings
   // or a 2-9 bit difference exists between code and expected K28.5 encoding.

   // For the two or more bit differences between both code groups, this is
   // simply the diff_negk_2_9 and diff_posk_2_9 results ANDed together.
   // Note that the above processes only checked for 2-9 bit differences rather
   // than 2 or more, since they are mutually exclusive (9-bit difference with
   // one set means 1-bit difference with the other set).  Therefore, the spec
   // only allows for a 2-8 bit difference between the received code and both
   // disparity encodings of K28.5
   assign difk_2_8 = diff_negk_2_9 & diff_posk_2_9;

   // For the 2-9 bit difference with the expected K28.5, we need to know the
   // ending running disparity of the previous odd code group so that we know
   // what is the starting disparity of the even code group in which the next
   // codegroup where we detect carrier is going to arrive in.
   //assign dif_expk_2_9 = rdisp_odd ? diff_posk_2_9 : diff_negk_2_9;

   // Carrier is detected when either of the above conditions are true
   //assign carrier_detected = difk_2_8 | dif_expk_2_9;

   // UNH testing in November 2013 showed that the running disparity value
   // cannot be trusted when there are bit errors, so the correct thing to do
   // is assert carrier when there are two to eight errors. Nine errors is
   // equivalent to a single error in K28.5 with the changed disparity.
   assign carrier_detected = difk_2_8;


endmodule
