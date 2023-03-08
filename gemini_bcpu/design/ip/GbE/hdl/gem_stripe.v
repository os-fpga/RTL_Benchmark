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
//   Filename:           gem_stripe.v
//   Module Name:        gem_stripe
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
//   Description :      Generates CRC from parallel data.
//
//------------------------------------------------------------------------------


// this module is used for generating CRC using parallel data.
// operates using reversed bit order with respect to Bowmore.
module gem_stripe(

   // inputs.
   din,
   stripe_in,

   // output.
   stripe_out
   );

   input          din;                       // input data for crc calculation.
   input   [31:0] stripe_in;                 // previously generated crc from
                                             // last clock cycle.
   output  [31:0] stripe_out;                // newly calculated crc value.

   assign stripe_out[31] =  stripe_in[30] ;
   assign stripe_out[30] =  stripe_in[29] ;
   assign stripe_out[29] =  stripe_in[28] ;
   assign stripe_out[28] =  stripe_in[27] ;
   assign stripe_out[27] =  stripe_in[26] ;
   assign stripe_out[26] =  stripe_in[25] ^ (stripe_in[31] ^ din) ;//26
   assign stripe_out[25] =  stripe_in[24] ;
   assign stripe_out[24] =  stripe_in[23] ;
   assign stripe_out[23] =  stripe_in[22] ^ (stripe_in[31] ^ din) ;//23
   assign stripe_out[22] =  stripe_in[21] ^ (stripe_in[31] ^ din) ;//22
   assign stripe_out[21] =  stripe_in[20] ;
   assign stripe_out[20] =  stripe_in[19] ;
   assign stripe_out[19] =  stripe_in[18] ;
   assign stripe_out[18] =  stripe_in[17] ;
   assign stripe_out[17] =  stripe_in[16] ;
   assign stripe_out[16] =  stripe_in[15] ^ (stripe_in[31] ^ din) ;//16
   assign stripe_out[15] =  stripe_in[14] ;
   assign stripe_out[14] =  stripe_in[13] ;
   assign stripe_out[13] =  stripe_in[12] ;
   assign stripe_out[12] =  stripe_in[11] ^ (stripe_in[31] ^ din);//12
   assign stripe_out[11] =  stripe_in[10] ^ (stripe_in[31] ^ din);//11
   assign stripe_out[10] =  stripe_in[9]  ^ (stripe_in[31] ^ din);//10
   assign stripe_out[9]  =  stripe_in[8]  ;
   assign stripe_out[8]  =  stripe_in[7]  ^ (stripe_in[31] ^ din) ;//8
   assign stripe_out[7]  =  stripe_in[6]  ^ (stripe_in[31] ^ din) ;//7
   assign stripe_out[6]  =  stripe_in[5]  ;
   assign stripe_out[5]  =  stripe_in[4]  ^ (stripe_in[31] ^ din) ;//5
   assign stripe_out[4]  =  stripe_in[3]  ^ (stripe_in[31] ^ din) ;//4
   assign stripe_out[3]  =  stripe_in[2]  ;
   assign stripe_out[2]  =  stripe_in[1]  ^ (stripe_in[31] ^ din) ;//2
   assign stripe_out[1]  =  stripe_in[0]  ^ (stripe_in[31] ^ din) ;//1
   assign stripe_out[0]  = (stripe_in[31] ^ din) ;//0


endmodule



