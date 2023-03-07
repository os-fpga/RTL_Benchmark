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
//   Filename:           gem_pcs_rxsync.v
//   Module Name:        gem_pcs_rxsync
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
//                      synchronization process described in the IEEE 802.3,
//                      1998 specifications, clause 36.  However, the actual
//                      states and implementation method differ in order to
//                      accomodate the wider receive data path.
//
//------------------------------------------------------------------------------


module gem_pcs_rxsync (

   // Inputs

   rx_clk,
   n_reset,
   sync_reset,

   rx_code,
   rx_control,
   rx_dec_error,

   signal_detect,
   loop_back,

   // Output

   sync_status,
   en_cdet

   );

   // Port declarations

   // Inputs

   input          rx_clk;              // The rx clock, nominally at 62.5MHz.
   input          n_reset;             // Active low asynchronous reset.
   input          sync_reset;          // Active high synchronous reset.

   input [15:0]   rx_code;             // Decoded stream, only [15:0] used
   input [1:0]    rx_control;          // Corresponding control
   input [1:0]    rx_dec_error;        // and invalid codegroup indications.

   input          signal_detect;       // PMD signal detect.
   input          loop_back;           // enable loop back.

   // Outputs

   output         sync_status;         // Output to receive block.
   output         en_cdet;             // Enable comma alignment in PMA.

   // reg and wire declarations

   reg            sync_status;         // Synchronization status to rx block.
   reg            en_cdet;             // Enable comma alignment in PMA.
   reg            en_cdet_next;        // Next enable comma alignment in PMA.
   reg [1:0]      sync_state;          // Current state of state machine.
   reg [1:0]      sync_state_next;     // next state for state machine
   reg [1:0]      comma_count;         // Count commas for synchronization.
   reg [1:0]      comma_count_next;    // update for count.
   reg [1:0]      bad_cgs;             // Count bad codegroups for resync.
   reg [1:0]      bad_cgs_next;        // update for bad_cgs
   reg [1:0]      good_cgs;            // Number of consecutive good code groups
   reg [1:0]      good_cgs_next;       // update for good_cgs
   reg            signal_detect_save;  // Save old value of signal_detect.

   wire           code1_good;          // Signals to indicate whether received
   wire           code1_bad;           // codegroups are good or bad according
   wire           code0_good;          // to the rules described in the
   wire           code0_bad;           // IEEE 802.3 specifications, clause 36.
   wire           code0_comma;         // If code 0 (even code) contains comma.
   wire           code1_comma;         // If code 1 (odd code) contains comma.
   wire           code1_data;          // If code 1 belongs to data group.


   // State machine encodings.

   parameter
      COMMA_DETECTING   = 2'b00,       // Waiting for first comma.
      SYNC_ACQUIRED     = 2'b01,       // Acquire sync on receipt of 3 commas.
      BAD_SYNC          = 2'b11,       // Bad code received.
      GOOD_SYNC         = 2'b10;       // Good code received.


   // State machine synchronisation.  On every rising edge of rx_clk, the states
   // are updated with the next values.  Also, when a change is detected in the
   // signal_detect signal or on asynchronous reset, re-synchronisation via the
   // COMMA_DETECTING state is forced.

   always@(posedge rx_clk or negedge n_reset)
    begin
      if (~n_reset)
         begin
            sync_state <= COMMA_DETECTING;
            comma_count <= 2'b00;
            bad_cgs <= 2'b00;
            good_cgs <= 2'b00;
            signal_detect_save <= 1'b0;
            en_cdet <= 1'b1;
         end
      else if (sync_reset)
         begin
            sync_state <= COMMA_DETECTING;
            comma_count <= 2'b00;
            bad_cgs <= 2'b00;
            good_cgs <= 2'b00;
            signal_detect_save <= 1'b0;
            en_cdet <= 1'b1;
         end
      else if ((signal_detect_save ^ signal_detect) & ~loop_back)
         begin
            sync_state <= COMMA_DETECTING;
            comma_count <= 2'b00;
            bad_cgs <= 2'b00;
            good_cgs <= 2'b00;
            signal_detect_save <= signal_detect;
            en_cdet <= 1'b1;
         end
      else
         begin
            sync_state <= sync_state_next;
            comma_count <= comma_count_next;
            bad_cgs <= bad_cgs_next;
            good_cgs <= good_cgs_next;
            signal_detect_save <= signal_detect;
            en_cdet <= en_cdet_next;
         end
    end


   // Indicate if first code group (even) is one of the control bytes
   // containing a comma.

   assign code0_comma = (rx_control[0] & (
                        (rx_code[7:0] == 8'h3C) |
                        (rx_code[7:0] == 8'hBC) |
                        (rx_code[7:0] == 8'hFC) )
                       );

   // The even code word can only be bad if it was invalid, i.e. a
   // decoder error.

   assign code0_bad = rx_dec_error[0];

   // The even code is good when it has either a comma or when the code
   // was valid.

   assign code0_good = (code0_comma | ~code0_bad);

   // Similarly for checking commas in the odd code.

   assign code1_comma = (rx_control[1] & (
                        (rx_code[15:8] == 8'h3C) |
                        (rx_code[15:8] == 8'hBC) |
                        (rx_code[15:8] == 8'hFC) )
                       );

   // The odd code cannot have a comma.

   assign code1_bad = (rx_dec_error[1] | code1_comma);

   // The odd code is good when it is not bad...

   assign code1_good = ~code1_bad;

   // If the odd code group belongs only to data group.

   assign code1_data = code1_good & ~rx_control[1];


   // The synchronisation state machine: the initial state is the
   // COMMA_DETECTING state where it will remain until 3 consecutive commas with
   // no code errors in between are detected.
   // Comma alignment in the PMA is enabled by setting the en_cdet output when
   // we begin comma detection. When at least one comma is seen this output
   // is negated until bad synchronisation is seen again.

   wire [2:0] bad_cgs_p2;
   wire [2:0] good_cgs_p2;
   assign     bad_cgs_p2  = bad_cgs  + 2'b10;
   assign     good_cgs_p2 = good_cgs + 2'b10;

   always @ *
    begin
      case (sync_state)

         // The state machine will enter this state on reset and remain here
         // until 3 consecutive valid comma groups received with no errors in
         // between.  The state machine will return to this state whenever
         // signal_detect changes.  Note also that during comma detection, if
         // loop_back changes, the detection process will start over.

         COMMA_DETECTING:
            begin
               sync_status = 1'b0;
               good_cgs_next = 2'b00;
               bad_cgs_next = 2'b00;
               if (code0_comma & code1_data & (signal_detect_save | loop_back))
                  begin
                     comma_count_next = comma_count + 2'b01;
                     en_cdet_next = 1'b0;
                     if (comma_count == 2'b10)
                        sync_state_next = SYNC_ACQUIRED;
                     else
                        sync_state_next = COMMA_DETECTING;
                  end
               else if (code0_good & code1_good)
                  begin
                     // Remain in this state so long as no errors.
                     comma_count_next = comma_count;
                     en_cdet_next = en_cdet;
                     sync_state_next = COMMA_DETECTING;
                  end
               else
                  begin
                     // Otherwise restart the process.  Also when loop_back
                     // changes and got no signal_detect.
                     comma_count_next = 2'b00;
                     en_cdet_next = 1'b1;
                     sync_state_next = COMMA_DETECTING;
                  end
            end

         // Once three valid commas are detected, the state machine will enter
         // this state and assert the sync_status OK signal.  Here it will
         // remain until a bad code group is detected.

         SYNC_ACQUIRED:
            begin
               sync_status = 1'b1;
               en_cdet_next = 1'b0;
               comma_count_next = 2'b00;
               case ({code1_bad,code0_bad})
                  2'b00:  // Both good
                  begin
                        bad_cgs_next = 2'b00;
                        good_cgs_next = 2'b00;
                        sync_state_next = SYNC_ACQUIRED;
                  end
                  2'b01:  // Code 1 good, code 0 bad
                  begin
                        bad_cgs_next = 2'b01;
                        good_cgs_next = 2'b01;
                        sync_state_next = GOOD_SYNC;
                  end
                  2'b10:  // Code 1 bad, code 0 good
                  begin
                        bad_cgs_next = 2'b01;
                        good_cgs_next = 2'b00;
                        sync_state_next = BAD_SYNC;
                  end
                  default:  // Both bad
                  begin
                        bad_cgs_next = 2'b10;
                        sync_state_next = BAD_SYNC;
                        good_cgs_next = 2'b00;
                  end
               endcase
            end

         // Entry into this state is from the BAD_SYNC state (default) when
         // a good code word is detected.  If 4 consecutive good code words
         // are detected then the number of bad code groups are decremented.
         // If the number of bad code groups reaches 0, then the state
         // machine will return to the above SYNC_ACQUIRED state.
         // If a bad code word is detected, the counter is incremented and
         // the next state will be in the BAD_SYNC (default state).
         // Note that whenever a bad code group is detected the good code
         // groups counter is reset.

         GOOD_SYNC:
            begin
               sync_status = 1'b1;
               en_cdet_next = 1'b0;
               comma_count_next = 2'b00;
               if (code0_bad)
                  begin
                  if (code1_bad)
                     begin
                     if ((bad_cgs == 2'b10) | (bad_cgs == 2'b11))
                        begin
                           bad_cgs_next = 2'b00;
                           good_cgs_next = 2'b00;
                           en_cdet_next = 1'b1;
                           sync_state_next = COMMA_DETECTING;
                        end
                     else
                        begin
                           bad_cgs_next = bad_cgs_p2[1:0];
                           good_cgs_next = 2'b00;
                           sync_state_next = BAD_SYNC;
                        end
                     end
                  else  // Code 0 bad, code 1 good.
                     if (bad_cgs == 2'b11)
                        begin
                           bad_cgs_next = 2'b00;
                           good_cgs_next = 2'b00;
                           en_cdet_next = 1'b1;
                           sync_state_next = COMMA_DETECTING;
                        end
                     else
                        begin
                           bad_cgs_next = bad_cgs + 2'b01;
                           good_cgs_next = 2'b01;
                           sync_state_next = GOOD_SYNC;
                        end
                  end
               else  // code 0 good.
                  if (code1_bad)
                     begin
                     if (good_cgs == 2'b11)
                        begin
                           good_cgs_next = 2'b00;
                           bad_cgs_next = bad_cgs;
                           sync_state_next = BAD_SYNC;
                        end
                     else
                        if (bad_cgs == 2'b11)
                           begin
                              good_cgs_next = 2'b00;
                              bad_cgs_next = 2'b00;
                              en_cdet_next = 1'b1;
                              sync_state_next = COMMA_DETECTING;
                           end
                        else
                           begin
                              good_cgs_next = 2'b00;
                              bad_cgs_next = bad_cgs + 2'b01;
                              sync_state_next = BAD_SYNC;
                           end
                     end
                  else  // both good.
                     if (bad_cgs == 2'b00)
                        begin
                        if ((good_cgs == 2'b10) | (good_cgs == 2'b11))
                           begin
                              good_cgs_next = 2'b00;
                              bad_cgs_next = 2'b00;
                              sync_state_next = SYNC_ACQUIRED;
                           end
                        else
                           begin
                              good_cgs_next = good_cgs_p2[1:0];
                              bad_cgs_next = bad_cgs;
                              sync_state_next = GOOD_SYNC;
                           end
                        end
                     else
                        if (good_cgs == 2'b10)
                           begin
                              good_cgs_next = 2'b00;
                              bad_cgs_next = bad_cgs - 2'b01;
                              sync_state_next = GOOD_SYNC;
                           end
                        else if (good_cgs == 2'b11)
                           begin
                              good_cgs_next = 2'b01;
                              bad_cgs_next = bad_cgs - 2'b01;
                              sync_state_next = GOOD_SYNC;
                           end
                        else
                           begin
                              good_cgs_next = good_cgs_p2[1:0];
                              bad_cgs_next = bad_cgs;
                              sync_state_next = GOOD_SYNC;
                           end
            end

         // BAD_SYNC state, entered whenever a bad code word is detected.  If 4
         // bad code words detected, then request re-sync via COMMA_DETECTING.
         // The bad code groups counter can only be decremented on reception of
         // 4 consecutive good code groups from the GOOD_SYNC process.

         default:
            begin
               sync_status = 1'b1;
               en_cdet_next = 1'b0;
               comma_count_next = 2'b00;
               if (code0_bad)
                  begin
                  if (code1_bad)
                     begin
                     if ((bad_cgs == 2'b10) | (bad_cgs == 2'b11))
                        begin
                           bad_cgs_next = 2'b00;
                           good_cgs_next = 2'b00;
                           en_cdet_next = 1'b1;
                           sync_state_next = COMMA_DETECTING;
                        end
                     else
                        begin
                           bad_cgs_next = bad_cgs_p2[1:0];
                           good_cgs_next = 2'b00;
                           sync_state_next = BAD_SYNC;
                        end
                     end
                  else // ie code0_bad and not code1_bad
                     begin
                     if (bad_cgs == 2'b11)
                        begin
                           bad_cgs_next = 2'b00;
                           good_cgs_next = 2'b00;
                           en_cdet_next = 1'b1;
                           sync_state_next = COMMA_DETECTING;
                        end
                     else
                        begin
                           bad_cgs_next = bad_cgs + 2'b01;
                           good_cgs_next = 2'b01;
                           sync_state_next = GOOD_SYNC;
                        end
                     end
                  end
               else if (code1_bad) // ie code1_bad and not code0_bad
                  begin
                     if (bad_cgs == 2'b11)
                        begin
                           bad_cgs_next = 2'b00;
                           good_cgs_next = 2'b00;
                           en_cdet_next = 1'b1;
                           sync_state_next = COMMA_DETECTING;
                        end
                     else
                        begin
                           bad_cgs_next = bad_cgs + 2'b01;
                           good_cgs_next = 2'b00;
                           sync_state_next = BAD_SYNC;
                        end
                  end
               else // ie not code0_bad and not code1_bad
                     begin
                        good_cgs_next = 2'b10;
                        bad_cgs_next = bad_cgs;
                        sync_state_next = GOOD_SYNC;
                     end
            end
      endcase
    end

endmodule
