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
//   Filename:           gem_pcs_rxstate.v
//   Module Name:        gem_pcs_rxstate
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
//   Description    :   This module implements the functions of the receive
//                      state diagrams illustrated in the IEEE 802.3 specs,
//                      clause 36.  The inputs to this module are the decoded
//                      receive code words from the 8b10b decoder module, this
//                      is used by the state machine to determine the correct
//                      values for the rx_dv, rx_er, and rxd signals.
//                      Note that these are not standard GMII signals as they
//                      are twice the standard width to accomodate the slower
//                      clock frequency of 62.5MHz.
//
//------------------------------------------------------------------------------
//   Limitations    :   Operates on 16-bit wide receive data with both current
//                      and future code words (current is delayed version).
//                      In doing so, the state machine differs somewhat from the
//                      state diagram illustrated in the IEEE 802.3 spec.
//
//------------------------------------------------------------------------------


module   gem_pcs_rxstate (

   // System Inputs

   rx_clk,
   n_reset,
   sync_reset,

   // Inputs from the encoders

   rx_code,
   rx_code_par,
   rx_dec_error,
   rx_control,

   // Input from auto-negotiation and rx sync blocks.

   xmit,
   sync_status,

   carrier_detect,

   // Outputs

   rx_dv,
   rx_er,
   rxd,
   rxd_par,

   receiving,

   rx_config_reg,
   rx_indicate

   );


   // Port declarations

   // System inputs

   input          rx_clk;              // The receive clock.
   input          n_reset;             // Asynchronous active low reset.
   input          sync_reset;          // Synchronous active high reset.

   // Encoder inputs

   input [31:0]   rx_code;             // Decoded data stream.
   input [3:0]    rx_code_par;         // Optional parity
   input [3:0]    rx_dec_error;        // Decoder error indication.
   input [3:0]    rx_control;          // Control code indicator.

   // Auto-negotiation and rx sync inputs

   input [1:0]    xmit;                // Auto-negotiate data type.
   input          sync_status;         // Sync status from rx sync block.
   input          carrier_detect;      // Signal from rx block detecting carrier

   // Outputs

   output [1:0]   rx_dv;               // Signals going to the Gigabit MAC
   output [1:0]   rx_er;               // interface, that is twice the width
   output [15:0]  rxd;                 // of the standard GMII at half the
                                       // clock speed.
   output [1:0]   rxd_par;

   output         receiving;           // Signal for carrier sense generation.
   output [15:0]  rx_config_reg;       // Received configuration data.
   output [1:0]   rx_indicate;         // Receive type indicator to the
                                       // auto-negotiate


   // Reg and wire declarations

   reg [1:0]      rx_dv;               // Signals going to the Gigabit MAC
   reg [1:0]      rx_er;               // interface, that is twice the width
   reg [15:0]     rxd;                 // of the standard GMII at half the
                                       // clock speed.
   reg [1:0]      rxd_par;
   reg            receiving;           // Signal for carrier sense generation.
   reg [1:0]      rx_indicate;         // Receive type indicator to the
                                       // auto-negotiate
   reg [15:0]     rx_config_reg;       // Received configuration data.
   reg [3:0]      rx_state;            // main rx state machine

   reg [15:0]     rx_config_reg_next;  // The following signals are generated
   reg            receiving_next;      // within the state machine and are used
   reg [1:0]      rx_indicate_next;    // to update the relevant signals on
   reg [3:0]      rx_state_next;       // rising clock edge.


   // Some declarations for more tidy and readable code..

   wire [7:0]     byte0;               // bits 7:0 of rx_code
   wire [7:0]     byte1;               // bits 15:8 of rx_code
   wire [7:0]     byte2;               // bits 23:16 of rx_code
   wire [7:0]     byte3;               // bits 31:24 of rx_code


   wire           code1_config;        // Code 1 contains data encoding of one
                                       // of the configuration ordered sets.
   wire           code1_lpi;           // Code 1 contains Low Power Idle code
   wire           code1_idle;          // Code 1 contains Idle code
   wire           code0_K;             // Code 0 contains K28.5
   wire           code0_D;             // Code 0 is a valid data code.
   wire           code0_T;             // EOP
   wire           code0_R;             // Carrier extension
   wire           code0_S;             // SOP
   wire           code1_D;             // Code 1 is a valid data code.
   wire           code1_T;             // EOP
   wire           code1_R;             // Carrier extension
   wire           code1_S;             // SOP
   wire           code2_K;             // Code 2 contains K28.5
   wire           code2_D;             // Code 2 is a valid data code.
   wire           code2_R;             // Carrier extension
   wire           code2_S;             // SOP
   wire           code3_R;             // Carrier extension
   wire           code3_S;             // SOP

   // Check for special end sequences.  Odd and even versions depending on
   // whether check executed on the first or second byte of the current
   // working set.

   wire           check_KDK_even;      // Control K - Data - Control K on even.
   wire           check_KDD_even;      // Control K followed by 2 Data on even.
   wire           check_TRK_even;      // Good end sequence without extension.
   wire           check_TRR_even;      // End with extension on even.
   wire           check_TRR_odd;       // End with extension on odd.
   wire           check_RRR_even;      // Extension even.
   wire           check_RRR_odd;       // Extension odd
   wire           check_RRK_even;      // End of extension to idle on control.
   wire           check_RRS_even;      // End of extension, frame burst on even.
   wire           check_RRS_odd;       // End of extension, frame burst on odd.

   // xmit encodings.

   parameter
      XMIT_CONFIG       = 2'b00,       // Configuration for auto-negotiation.
      XMIT_DATA         = 2'b11;       // Normal operation


   // rx_indicate encodings.

   parameter
      IDLE_INDICATE     = 2'b00,       // IDLE set received.
      INVALID_INDICATE  = 2'b01,       // Invalid combination.
      CONFIG_INDICATE   = 2'b11;       // Configuration set.


   // State machine encodings.

   parameter
      WAIT_FOR_KD    = 4'h0,           // Wait for control code.
      CONFIG_ST      = 4'h1,           // Configuration data received.
      RX_INVALID     = 4'h2,           // Invalid combinations.
      IDLE_CARRIER   = 4'h3,           // Idle set received, wait for carrier.
      EPD2_CHECK     = 4'h4,           // Check end of packet.
      RECEIVE        = 4'h5,           // Receiving data
      LINK_FAILED    = 4'h6,           // Link failed when lose sync.
      ODD_START      = 4'h7,           // Start packet on odd boundary.
      START_PACKET   = 4'h8,           // Start packet on even boundary.
      LPIDLE         = 4'h9;           // Low Power Idle, wait for next Idle.


   // The wires used to simplify code..

   assign byte0 = rx_code[7:0];
   assign byte1 = rx_code[15:8];
   assign byte2 = rx_code[23:16];
   assign byte3 = rx_code[31:24];

   // Code 1 contains data groups to indicate configuration groups.

   assign code1_config = ((byte1 == 8'hB5) | (byte1 == 8'h42)) &
                        ~rx_control[1];

   assign code1_lpi    = ((byte1 == 8'hA6) | (byte1 == 8'h9A)) &
                        ~rx_control[1];
   assign code1_idle   = ((byte1 == 8'hC5) | (byte1 == 8'h50)) &
                        ~rx_control[1];

   // Encodings for byte0, the oldest byte.

   assign code0_K = (byte0 == 8'hBC) & rx_control[0];

   assign code0_D = (~rx_control[0] & ~rx_dec_error[0]);

   assign code0_T = (byte0 == 8'hFD) & rx_control[0];

   assign code0_R = (byte0 == 8'hF7) & rx_control[0];

   assign code0_S = (byte0 == 8'hFB) & rx_control[0];

   // Encodings for byte1.

   assign code1_D = (~rx_control[1] & ~rx_dec_error[1]);

   assign code1_T = (byte1 == 8'hFD) & rx_control[1];

   assign code1_R = (byte1 == 8'hF7) & rx_control[1];

   assign code1_S = (byte1 == 8'hFB) & rx_control[1];

   // Encodings for byte2

   assign code2_K = (byte2 == 8'hBC) & rx_control[2];

   assign code2_D = (~rx_control[2] & ~rx_dec_error[2]);

   assign code2_R = (byte2 == 8'hF7) & rx_control[2];

   assign code2_S = (byte2 == 8'hFB) & rx_control[2];

   // Encodings for byte3, the most recent code to be received

   assign code3_R = (byte3 == 8'hF7) & rx_control[3];

   assign code3_S = (byte3 == 8'hFB) & rx_control[3];


   // Check for special end sequences..
   // Even and odd specify whether to check starting from byte0 or byte1.

   assign check_KDK_even = code0_K & code1_D & code2_K;

   assign check_KDD_even = code0_K & code1_D & code2_D;

   assign check_TRK_even = code0_T & code1_R & code2_K;

   assign check_TRR_even = code0_T & code1_R & code2_R;

   assign check_TRR_odd = code1_T & code2_R & code3_R;

   assign check_RRR_even = code0_R & code1_R & code2_R;

   assign check_RRR_odd = code1_R & code2_R & code3_R;

   assign check_RRK_even = code0_R & code1_R & code2_K;

   assign check_RRS_even = code0_R & code1_R & code2_S;

   assign check_RRS_odd = code1_R & code2_R & code3_S;



   // Main synchronisation process puts state machine into known state after
   // reset and also updates state machine state on every clock edge.  Also
   // forces state machine into LINK_FAILED state on loss of sync_status from
   // gem_pcs_rxsync.

   always@(posedge rx_clk or negedge n_reset)
    begin
      if (~n_reset)
         begin
            rx_indicate <= INVALID_INDICATE; // Force restart of configuration.
            rx_config_reg <= 16'h0000;
            rx_state <= WAIT_FOR_KD;
            receiving <= 1'b0;
         end
      else if (sync_reset)
         begin
            rx_indicate <= INVALID_INDICATE; // Force restart of configuration
            rx_config_reg <= 16'h0000;
            rx_state <= WAIT_FOR_KD;
            receiving <= 1'b0;
         end
      else if (~sync_status)
         begin
            rx_indicate <= rx_indicate_next;
            rx_config_reg <= 16'h0000;
            rx_state <= LINK_FAILED;
            receiving <= receiving_next;
         end
      else
         begin
            rx_indicate <= rx_indicate_next;
            rx_config_reg <= rx_config_reg_next;
            rx_state <= rx_state_next;
            receiving <= receiving_next;
         end
    end


   // The combinatorial state machine.
   // This is adapted from the state diagram illustrated in IEEE 802.3 clause 36
   // converted to suit the 16-bit data path in use due to the clocks.

   always@(*)
      begin
         case(rx_state)

            // Remain in this state and wait for a K28.5 signal then proceed to
            // the appropriate state depending on the odd code byte.

            WAIT_FOR_KD:
               begin
                  rx_indicate_next = rx_indicate;
                  receiving_next = 1'b0;
                  rx_dv = 2'b00;
                  rx_er = 2'b00;
                  rxd = 16'h0000;
                  rxd_par = 2'b00;
                  rx_config_reg_next = rx_config_reg;
                  if (code0_K)
                     if (code1_config)
                        rx_state_next = CONFIG_ST;
                     else if ((xmit == XMIT_DATA) & code1_lpi)
                        begin
                           rx_state_next = LPIDLE;
                           rx_er = 2'b11;
                           rxd = 16'h0101;
                           rxd_par = 2'b11;
                        end
//                     else if ( ((xmit != XMIT_DATA) & code1_D & ~code1_config) |
//                              ((xmit == XMIT_DATA) & ~code1_config) )
                     else if (code1_D || (xmit == XMIT_DATA))
                        rx_state_next = IDLE_CARRIER;
                     else
                        rx_state_next = RX_INVALID;
                  else
                     rx_state_next = WAIT_FOR_KD;
               end


            // Configuration ordered set has been received.  rx_config_reg is
            // updated with the received data values and an indication is
            // passed to the auto-negotiation block.

            CONFIG_ST:
               begin
                  receiving_next = 1'b0;
                  rx_dv = 2'b00;
                  rx_er = 2'b00;
                  rxd = 16'h0000;
                  rxd_par = 2'b00;
                  if (code0_D & code1_D)
                     begin
                        rx_config_reg_next = {byte1,byte0};
                        rx_indicate_next = CONFIG_INDICATE;
                        if (code2_K)   // Check future set...
                           rx_state_next = WAIT_FOR_KD;
                        else
                           rx_state_next = RX_INVALID;
                     end
                  else
                     begin
                        rx_config_reg_next = 16'h0000;
                        rx_indicate_next = rx_indicate;
                        rx_state_next = RX_INVALID;
                     end
               end


            // An invalid combination of codes has been received.

            RX_INVALID:
               begin
                  rx_dv = 2'b00;
                  rx_er = 2'b00;
                  rxd = 16'h0000;
                  rxd_par = 2'b00;
                  rx_config_reg_next = rx_config_reg;
                  if (xmit == XMIT_CONFIG)
                     begin
                        rx_indicate_next = INVALID_INDICATE;
                        receiving_next = 1'b0;
                     end
                  else if (xmit == XMIT_DATA)
                     begin
                        rx_indicate_next = rx_indicate;
                        receiving_next = 1'b1;
                     end
                  else
                     begin
                        rx_indicate_next = rx_indicate;
                        receiving_next = 1'b0;
                     end

                  // Same function as WAIT_FOR_KD state..

                  if (code0_K)
                     if (code1_config)
                        rx_state_next = CONFIG_ST;
                     else if (code1_D || (xmit == XMIT_DATA))
                        rx_state_next = IDLE_CARRIER;
                     else
                        rx_state_next = RX_INVALID;
                  else
                     rx_state_next = WAIT_FOR_KD;
               end


            // Idle sets have been received.  Now wait for a carrier signal and
            // act appropriately.

            IDLE_CARRIER:
               begin
                  rx_indicate_next = IDLE_INDICATE;
                  rx_config_reg_next = rx_config_reg;
                  if ((xmit == XMIT_DATA) && carrier_detect)  // Carrier detected.
                     begin
                        receiving_next = 1'b1;
                        if (~code0_S)
                           begin // No SOP delimiter received.
                              rx_er = 2'b01;
                              rx_dv = 2'b00;
                              rxd = 16'h000E;   // False carrier.
                              rxd_par = 2'b01;
                              rx_state_next = WAIT_FOR_KD;
                           end
                        else  // Proper SOP delimiter received.
                           begin
                              rx_er[0] = 1'b0;
                              rx_dv[0] = 1'b1;
                              rxd[7:0] = 8'h55; // Replace with preamble.
                              rxd_par[0] = 1'b0;
                              // Check current (odd) code and next two codes.

                              if (check_TRR_odd)
                                 begin
                                    rx_dv[1] = 1'b0;
                                    rx_er[1] = 1'b1;
                                    rxd[15:8] = 8'h0F;   // Carrier extend.
                                    rxd_par[1] = 1'b0;
                                    rx_state_next = EPD2_CHECK;
                                 end
                              else if (check_RRR_odd)
                                 begin
                                    rx_dv[1] = 1'b1;
                                    rx_er[1] = 1'b1;     // Early end
                                    rxd[15:8] = 8'h55;
                                    rxd_par[1]  = 1'b0;
                                    rx_state_next = EPD2_CHECK;
                                 end
                              else if (code1_D)
                                 begin
                                    rx_er[1] = 1'b0;
                                    rx_dv[1] = 1'b1;     // Normal data.
                                    rxd[15:8] = byte1;
                                    rxd_par[1]  = rx_code_par[1];
                                    rx_state_next = RECEIVE;
                                 end
                              else
                                 begin
                                    rx_er[1] = 1'b1;     // All other errors.
                                    rx_dv[1] = 1'b1;
                                    rxd[15:8] = 8'h55;
                                    rxd_par[1]  = 1'b0;
                                    rx_state_next = RECEIVE;
                                 end
                           end   // SOP received.
                     end   // carrier detected.
                  else if ( (xmit == XMIT_DATA) || code0_K )
                     begin // No carrier detected.
                        receiving_next = 1'b0;
                        rx_dv = 2'b00;
                        rx_er = 2'b00;
                        rxd = 16'h0000;
                        rxd_par = 2'b00;
                        // If control words, branch accordingly.
                        if (code0_K & code1_config)
                           rx_state_next = CONFIG_ST;
                        else if ( (xmit == XMIT_DATA) & code1_lpi & code0_K )
                           begin
                              rx_state_next = LPIDLE;
                              rx_er = 2'b11;
                              rxd = 16'h0101;
                              rxd_par = 2'b11;
                           end
                        else if ((xmit != XMIT_DATA) & ~code1_D)
                           rx_state_next = RX_INVALID;
                        else
                           rx_state_next = IDLE_CARRIER;
                     end
                  else  // if (~code0_K & (xmit != XMIT_DATA))
                     begin // Invalid combination.
                        rx_state_next = RX_INVALID;
                        receiving_next = 1'b0;
                        rx_dv = 2'b00;
                        rx_er = 2'b00;
                        rxd = 16'h0000;
                        rxd_par = 2'b00;
                     end
               end   // case IDLE_CARRIER


            // Low Power Idle codes have been received.

            LPIDLE:
               begin
                  rx_indicate_next = IDLE_INDICATE;
                  rx_config_reg_next = rx_config_reg;
                  receiving_next = 1'b0;
                  rx_dv = 2'b00;
                  rx_er = 2'b00;
                  rxd = 16'h0000;
                  rxd_par = 2'b00;
                  if ((~code0_K || ~code1_D) && (xmit != XMIT_DATA))  // Invalid combination
                     rx_state_next = RX_INVALID;
                  else if (code1_config)
                     rx_state_next = CONFIG_ST;
                  else if  (code1_idle)
                     rx_state_next = IDLE_CARRIER;
                  else
                     begin
                        rx_er = 2'b11;
                        rxd = 16'h0101;
                        rxd_par = 2'b11;
                        rx_state_next = LPIDLE;
                     end
               end   // case LPIDLE


            // Receiving normal data packets.  Constantly check for end
            // conditions.

            RECEIVE:
               begin
                  rx_indicate_next = rx_indicate;
                  rx_config_reg_next = rx_config_reg;

                  if (check_KDK_even | check_KDD_even)
                     begin // Aborted and back to idle or config.
                        receiving_next = 1'b0;
                        rx_er = 2'b01;
                        rx_dv = 2'b01;
                        rxd = 16'h0000;
                        rxd_par = 2'b00;
                        if (code1_config)
                           rx_state_next = CONFIG_ST;
                        else
                           rx_state_next = IDLE_CARRIER;
                     end

                  else if (check_TRK_even)
                     begin // Normal end.
                        receiving_next = 1'b0;
                        rx_dv = 2'b00;
                        rx_er = 2'b00;
                        rxd = 16'h0000;
                        rxd_par = 2'b00;
                        rx_state_next = WAIT_FOR_KD;
                     end

                  else if (check_TRR_even | check_RRR_even)
                     begin
                        receiving_next = receiving;
                        rx_er[0] = 1'b1;
                        if (check_TRR_even)
                           begin // carrier extend
                              rx_dv[0] = 1'b0;
                              rxd[7:0] = 8'h0F;
                              rxd_par[0] = 1'b0;
                           end
                        else
                           begin // error.
                              rx_dv[0] = 1'b1;
                              rxd[7:0] = 8'h00;
                              rxd_par[0] = 1'b0;
                           end

                        // Now process the next code byte.

                        rx_dv[1] = 1'b0;
                        rx_er[1] = 1'b1;
                        if (check_RRR_odd)
                           begin // carrier extending.
                              rxd[15:8] = 8'h0F;
                              rxd_par[1] = 1'b0;
                              rx_state_next = EPD2_CHECK;
                           end
                        else if (check_RRS_odd)
                           begin // Burst.
                              rxd[15:8] = 8'h0F;
                              rxd_par[1]= 1'b0;
                              rx_state_next = ODD_START;
                           end
                        else  // Extend error.
                           begin
                              rxd[15:8] = 8'h1F;
                              rxd_par[1]= 1'b1;
                              rx_state_next = EPD2_CHECK;
                           end
                     end // (check_TRR_even | check_RRR_even)

                  else  // All other even byte codings.
                     begin
                        receiving_next = receiving;
                        rx_dv[0] = 1'b1;
                        if (code0_D)   // Valid data.
                           begin
                              rx_er[0] = 1'b0;
                              rxd[7:0] = byte0;
                              rxd_par[0] = rx_code_par[0];
                           end
                        else  // Invalid data.
                           begin
                              rx_er[0] = 1'b1;
                              rxd[7:0] = 8'h00;
                              rxd_par[0] = 1'b0;
                           end

                        // Check end sequence with codes 1,2 and 3.

                        if (check_TRR_odd)
                           begin
                              rx_dv[1] = 1'b0;
                              rx_er[1] = 1'b1;
                              rxd[15:8] = 8'h0F;   // Carrier extend
                              rxd_par[1] = 1'b0;
                              rx_state_next = EPD2_CHECK;
                           end
                        else if (check_RRR_odd)
                           begin
                              rx_dv[1] = 1'b1;
                              rx_er[1] = 1'b1;     // Early end
                              rxd[15:8] = 8'h55;
                              rxd_par[1] = 1'b0;
                              rx_state_next = EPD2_CHECK;
                           end
                        else if (code1_D)
                           begin
                              rx_er[1] = 1'b0;
                              rx_dv[1] = 1'b1;     // Normal data
                              rxd[15:8] = byte1;
                              rxd_par[1] = rx_code_par[1];
                              rx_state_next = RECEIVE;
                           end
                        else
                           begin
                              rx_er[1] = 1'b1;     // All other errors
                              rx_dv[1] = 1'b1;
                              rxd[15:8] = 8'h55;
                              rxd_par[1] = 1'b0;
                              rx_state_next = RECEIVE;
                           end
                     end
               end   // case RECEIVE


            // Will only ever get this when bursting.  Happens when SOP
            // delimiter received in odd byte position.

            ODD_START:
               begin
                  receiving_next = receiving;
                  rx_indicate_next = rx_indicate;
                  rx_config_reg_next = rx_config_reg;
                  rx_state_next = RECEIVE;
                  rx_er = 2'b01;
                  rx_dv = 2'b10;
                  rxd = 16'h550F;   // carrier extension and preamble.
                  rxd_par = 2'b00;
               end


            // Check different ending sequences.

            EPD2_CHECK:
               begin
                  rx_config_reg_next = rx_config_reg;
                  rx_indicate_next = rx_indicate;
                  if (check_RRK_even)              // End of carrier extend
                     begin
                        receiving_next = 1'b0;
                        rx_dv = 2'b00;
                        rx_er = 2'b00;
                        rxd = 16'h0000;
                        rxd_par = 2'b00;
                        rx_state_next = WAIT_FOR_KD;
                     end
                  else if (check_RRS_even)         // Bursting (SOP on even)
                     begin
                        receiving_next = receiving;
                        rx_dv = 2'b00;
                        rx_er = 2'b11;
                        rxd = 16'h0F0F;
                        rxd_par = 2'b00;
                        rx_state_next = START_PACKET;
                     end
                  else if (check_RRR_even)         // Carrier extend
                     begin
                        receiving_next = receiving;
                        rx_dv[0] = 1'b0;
                        rx_er[0] = 1'b1;
                        rxd[7:0] = 8'h0F;
                        rxd_par[0] = 1'b0;
                        rx_dv[1] = 1'b0;
                        rx_er[1] = 1'b1;
                        if (check_RRR_odd)         // Carrier extend
                           begin
                              rxd[15:8] = 8'h0F;
                              rxd_par[1] = 1'b0;
                              rx_state_next = EPD2_CHECK;
                           end
                        else if (check_RRS_odd)    // Bursting (SOP on odd)
                           begin
                              rxd[15:8] = 8'h0F;
                              rxd_par[1] = 1'b0;
                              rx_state_next = ODD_START;
                           end
                        else
                           begin
                              rxd[15:8] = 8'h1F;   // Carrier extend error
                              rxd_par[1] = 1'b1;
                              rx_state_next = EPD2_CHECK;
                           end
                     end
                  else
                     begin
                        receiving_next = receiving;
                        rx_dv[0] = 1'b0;
                        rx_er[0] = 1'b1;
                        rxd[7:0] = 8'h1F;
                        rxd_par[0] = 1'b1;
                        if (code1_S)               // Odd SOP after extend error
                           begin
                              rx_dv[1] = 1'b1;
                              rx_er[1] = 1'b0;
                              rxd[15:8] = 8'h55;
                              rxd_par[1]= 1'b0;
                              rx_state_next = RECEIVE;
                           end
                        else
                           begin
                              rx_dv[1] = 1'b0;
                              rx_er[1] = 1'b1;
                              if (check_RRR_odd)   // Carrier extend after error
                                 begin
                                    rxd[15:8] = 8'h0F;
                                    rxd_par[1]= 1'b0;
                                    rx_state_next = EPD2_CHECK;
                                 end
                              else if (check_RRS_odd) // Odd SOP
                                 begin
                                    rxd[15:8] = 8'h0F;
                                    rxd_par[1]= 1'b0;
                                    rx_state_next = ODD_START;
                                 end
                              else                 // Another carrier ext error
                                 begin
                                    rxd[15:8] = 8'h1F;
                                    rxd_par[1] = 1'b1;
                                    if (code2_K)
                                       // even K28.5 next
                                       rx_state_next = WAIT_FOR_KD;
                                    else if (code2_S)
                                       // even SOP next
                                       rx_state_next = START_PACKET;
                                    else
                                       rx_state_next = EPD2_CHECK;
                                 end
                           end
                     end
               end // case EPD2_CHECK

            // Normal start of packet after burst.  SOP found in even byte.

            START_PACKET:
               begin
                  receiving_next = 1'b1;
                  rx_indicate_next = rx_indicate;
                  rx_config_reg_next = rx_config_reg;
                  rx_er[0] = 1'b0;
                  rx_dv[0] = 1'b1;
                  rxd[7:0] = 8'h55;
                  rxd_par[0] = 1'b0;

                  // Check end sequence with codes 1,2 and 3

                  if (check_TRR_odd)            // Carrier extend
                     begin
                        rx_dv[1] = 1'b0;
                        rx_er[1] = 1'b1;
                        rxd[15:8] = 8'h0F;
                        rxd_par[1] = 1'b0;
                        rx_state_next = EPD2_CHECK;
                     end
                  else if (check_RRR_odd)       // Early end
                     begin
                        rx_dv[1] = 1'b1;
                        rx_er[1] = 1'b1;
                        rxd[15:8] = 8'h55;
                        rxd_par[1] = 1'b0;
                        rx_state_next = EPD2_CHECK;
                     end
                  else if (code1_D)             // Normal data
                     begin
                        rx_er[1] = 1'b0;
                        rx_dv[1] = 1'b1;
                        rxd[15:8] = byte1;
                        rxd_par[1] = rx_code_par[1];
                        rx_state_next = RECEIVE;
                     end
                  else                          // All other errors
                     begin
                        rx_er[1] = 1'b1;
                        rx_dv[1] = 1'b1;
                        rxd[15:8] = 8'h55;
                        rxd_par[1] = 1'b0;
                        rx_state_next = RECEIVE;
                     end
               end // case START_PACKET


            default: // LINK_FAILED state
               begin
                  rxd = 16'h0000;
                  rxd_par = 2'b00;
                  rx_config_reg_next = rx_config_reg;
                  receiving_next = 1'b0;

                  // work out next indicate value
                  if (xmit != XMIT_DATA)
                     rx_indicate_next = INVALID_INDICATE;
                  else
                     rx_indicate_next = rx_indicate;

                  // If currently receiving when link fails, force code error
                  if (receiving)
                     begin
                        rx_er = 2'b01;
                        rx_dv = 2'b01;
                     end
                  else
                     begin
                        rx_er = 2'b00;
                        rx_dv = 2'b00;
                     end

                  // Next state conditions are the same as WAIT_FOR_KD.
                  // We have to check the code conditions here to ensure we
                  // do not miss any codes.
                  // This will be overridden by the synchronisation process if
                  // sync_status is still low.
                  if (code0_K)
                     begin
                     if (code1_config)
                        rx_state_next = CONFIG_ST;
                     else if (code1_D || (xmit == XMIT_DATA))
                        rx_state_next = IDLE_CARRIER;
                     else
                        rx_state_next = RX_INVALID;
                     end
                  else
                     rx_state_next = WAIT_FOR_KD;
               end
         endcase
      end

endmodule
