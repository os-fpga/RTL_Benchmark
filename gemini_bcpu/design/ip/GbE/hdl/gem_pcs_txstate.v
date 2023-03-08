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
//   Filename:           gem_pcs_txstate.v
//   Module Name:        gem_pcs_txstate
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
//   Description    :   This module implements the functionality of the transmit
//                      state diagrams specified in the IEEE 802.3, 1998 edition
//                      specifications, clause 36.
//                      On reset, the state machine will be initialised to the
//                      Initial state, where it will remain until one of it's
//                      exit conditions is valid and proceed to the appropriate
//                      state.
//                      Some state transitions are dependant on signals from an
//                      auto negotiation module and the relevant supporting
//                      registers.
//                      Control and code signals are sourced from this module
//                      and passed to the 8b10b encoder module for code group
//                      generation and subsequent output to the PMA via a TBI.
//                      All outputs are asynchronous and should therefore be
//                      registered and synchronised at a higher level.
//
//------------------------------------------------------------------------------
//   Limitations    :   An 8B/10B encoder with 1 cycle latency is assumed.
//                      The state machine does not assume the form depicted in
//                      the IEEE 802.3 specifications, as the form depicted is
//                      not entirely suitable for hardware implementation.
//                      This module merely implements a state machine with
//                      equivalent functionality.
//
//------------------------------------------------------------------------------


module gem_pcs_txstate (

   // System inputs

   gtx_clk,
   n_gtxreset,
   sync_reset,

   // GMII inputs

   tx_en,
   txd,
   txd_par,
   tx_er,

   // Other inputs
   tx_local_fault,
   tx_remote_fault,
   tx_config_reg,    // from autoneg through sync.
   tx_config_reg_par,// Optional parity
   tx_disparity,
   xmit,             // from autoneg through sync.
   xmit_change_rx_s, // from autoneg through sync.
   receiving,        // Direct from rx block.

   // Outputs.  All outputs are unregistered since they are going to processes
   // in the same domain.

   col,              // Generated asynchronously from receiving signal.
   tx_code,
   tx_control,
   transmitting

   );

   // Port declarations

   // System inputs
   input          gtx_clk;             // The Gigabit transmit clock.
   input          n_gtxreset;          // Active low initialisation reset.
   input          sync_reset;          // Active high synchronous reset.

   // GMII inputs
   input          tx_en;               // GMII transmit enable signal.
   input [7:0]    txd;                 // GMII transmit data.
   input          txd_par;             // Optional parity
   input          tx_er;               // GMII transmit error signal.

   // Other inputs
   input          tx_local_fault;      // Local fault was received so transmit remote fault
   input          tx_remote_fault;     // Remote fault or link interruption was received so transmit idle
   input [15:0]   tx_config_reg;       // Configuration data to be transmitted
                                       // to link partner.  Comes from autoneg.
   input  [1:0]   tx_config_reg_par;
   input          tx_disparity;        // Disparity of last transmitted code.
   input [1:0]    xmit;                // Auto negotiation output indicating
                                       // type of data.
   input          xmit_change_rx_s;    // xmit_change synchronized to tx_clk
                                       // this is slightly delayed to give xmit
                                       // a chance to settle.
   input          receiving;           // Rx block input for col generation.

   // Outputs
   output         col;                 // GMII collision signal.
   output [8:0]   tx_code;             // Transmit code to be encoded with 1-bit parity
   output         tx_control;          // Indicate whether tx_code is control
   output         transmitting;        // Signal used to generate carrier sense.

   // reg declarations
   reg            col;                 // GMII collision signal.
   reg [8:0]      tx_code;             // Transmit code to be encoded.
   reg            tx_control;          // Indicate whether tx_code is control
   reg            transmitting;        // Signal used to generate carrier sense.

   reg            tx_oset_done;        // Indicates completion of code group tx.
   reg            tx_even;             // Will get updated with tx_even_next on
   reg            tx_even_next;        // clk. Keeps track of whether even or
                                       // odd group.

   reg [5:0]      tx_state;            // Current state of state machine.
   reg [5:0]      tx_state_next;       // Next state of state machine.

   reg [1:0]      xmit_save;           // Previous value of xmit.
   reg            xmit_change_save;    // Previous value of xmit_change_rx_s.
   reg            xmit_changed;        // Set if xmit changed.
   reg [7:0]      txd_save;            // Delayed version of txd.
   reg            txd_par_save;        // Optional parity

   wire           tx_idle;             // TX is idle = ~tx_en & ~tx_er
   wire           tx_dat_err;          // TX data error = tx_en & tx_er
   wire           tx_cext_err;         // TX carrier extension error

   wire           tx_v_func;           // Void function result
   reg            tx_v_nxt;            // Send /V/ to propagate error
   reg            tx_v;


   // Encodings for special codes.
   // Top bit is parity
   parameter
      CODE_K_28_5       = 9'h1BC,      // K28.5 control group
      CODE_K_S          = 9'h1FB,      // Start of packet delimiter
      CODE_K_T          = 9'h1FD,      // End of packet delimiter
      CODE_K_R          = 9'h1F7,      // Carrier extension
      CODE_K_V          = 9'h1FE,      // Error propagation
      CODE_D21_5        = 9'h1B5,      // Data group for configuration C1
      CODE_D2_2         = 9'h042,      // Data group for configuration C2
      CODE_D5_6         = 9'h0C5,      // Data group for idle I1
      CODE_D16_2        = 9'h050,      // Data group for idle I2
      CODE_D6_5         = 9'h0A6,      // Data group for low power idle LPI1
      CODE_D26_4        = 9'h09A;      // Data group for low power idle LPI2

   // xmit encodings.

   parameter
      XMIT_CONFIG       = 2'b00,       // Configuration for auto-negotiation.
      XMIT_DATA         = 2'b11;       // Normal operation

   // State machine encodings

   parameter
      INITIAL_STATE     = 6'h00,       // Initial POR state.
      CONFIG_1A         = 6'h01,       // Configuration group C1.
      CONFIG_1B         = 6'h02,
      CONFIG_1C         = 6'h03,
      CONFIG_1D         = 6'h04,
      CONFIG_2A         = 6'h05,       // Configuration group C2.
      CONFIG_2B         = 6'h06,
      CONFIG_2C         = 6'h07,
      CONFIG_2D         = 6'h08,
      IN_IDLE_DISP      = 6'h09,       // Initial idle disparity generation
      IN_DISP           = 6'h0a,
      IDLE_DISP         = 6'h0b,       // Normal idle disparity generation.
      DISP              = 6'h0c,
      START_ERROR       = 6'h0d,       // Error in start sequence.
//      TX_DATA_ERROR     = 5'h0e,       // Error propagation.
      SOP               = 6'h0f,       // Start of packet.
      TX_DATA           = 6'h10,       // Transmit data.
      EOP_NOEXT         = 6'h11,       // End of packet no carrier extension.
      EPD2              = 6'h12,
      EPD3              = 6'h13,
      EOP_EXT           = 6'h14,       // End of packet with carrier extension.
      CARRIER_EXTEND    = 6'h15,       // Carrier extension propagation.
      EXTEND_BY1        = 6'h16,       // Extend carrier by 1.
//      EOP_EXT_ERR       = 5'h17,       // When txd does not contain 0F.
//      CARR_EXT_ERR      = 5'h19,       // When txd does not contain 0F.
      LPIDLE_DISP       = 6'h18,       // Low power idle disparity generation.
      LP_DISP           = 6'h1a,

      SEQ_1A            = 6'h1b,
      SEQ_1B            = 6'h1c,
      SEQ_1C            = 6'h1d,
      SEQ_1D            = 6'h1e,
      SEQ_2A            = 6'h1f,
      SEQ_2B            = 6'h20,
      SEQ_2C            = 6'h21,
      SEQ_2D            = 6'h22;

   parameter LF_DATA_X  = 8'h02;
   parameter LF_DATA_Y  = 8'h00;
   parameter LF_DATA_Z  = 8'h00;

   // Decode GMII state, idle when MAC is not indicating anything:
   assign tx_idle = ~tx_en && ~tx_er;

   // State machine synchronisation process, updates tx_state with tx_state_next
   // on every rising edge of gtx_clk.  Also updates tx_even with tx_even_next,
   // note that tx_even indicates the code group alignment of the PREVIOUS code
   // group and not the current code group.
   // On asynchronous reset, tx_state is set to INITIAL and tx_even becomes
   // 1'b0.
   // If the value of xmit changes, then tx_state will be forced into an
   // alternative state depending on the new value of xmit and any other inputs.
   // tx_oset_done indicates when an ordered set has completed, so that we don't
   // change state in the middle of sending a config set etc.

   always@(posedge gtx_clk or negedge n_gtxreset)
   begin
      if (~n_gtxreset)
         begin
            tx_state          <= INITIAL_STATE;
            tx_even           <= 1'b0;
            xmit_save         <= 2'b11;
            xmit_change_save  <= 1'b0;
            xmit_changed      <= 1'b1;
            txd_save          <= 8'h00;
            txd_par_save      <= 1'b0;
            tx_v              <= 1'b0;
         end

      else if (sync_reset)
         begin
            tx_state          <= INITIAL_STATE;
            tx_even           <= 1'b0;
            xmit_save         <= 2'b11;
            xmit_change_save  <= 1'b0;
            xmit_changed      <= 1'b1;
            txd_save          <= 8'h00;
            txd_par_save      <= 1'b0;
            tx_v              <= 1'b0;
         end

      else if (tx_remote_fault & ~tx_even_next) // remote fault or link interruption was received so transmit idle
         begin
            tx_state      <= IDLE_DISP;
            tx_even       <= tx_even_next;
            txd_save      <= txd;
            txd_par_save  <= txd_par;
            tx_v          <= tx_v_nxt;
         end

      else if (tx_local_fault & ~tx_even_next & tx_oset_done) // local fault was received so transmit remote fault
         begin
            tx_state      <= SEQ_1A;
            tx_even       <= tx_even_next;
            txd_save      <= txd;
            txd_par_save  <= txd_par;
            tx_v          <= tx_v_nxt;
         end

      //else if (xmit_changed | ((xmit ^ xmit_save) != 2'b00))
      else if (xmit_changed | (xmit_change_rx_s ^ xmit_change_save))

         begin
            // Only change state when on even alignment and finished ordered set
            if (tx_oset_done & ~tx_even_next)
               begin
                  if (xmit == XMIT_CONFIG)
                     tx_state <= CONFIG_1A;
                  else
                     if ((xmit == XMIT_DATA) && tx_idle)
                        tx_state <= IDLE_DISP;
                     else
                        tx_state <= IN_IDLE_DISP;
                  xmit_save <= xmit;
                  xmit_change_save <= xmit_change_rx_s;
                  xmit_changed <= 1'b0;
               end
            // Otherwise, set bit to allow re-entry.
            else
               begin
                  xmit_changed <= 1'b1;
                  tx_state <= tx_state_next;
               end

            // Update variables.
            tx_even       <= tx_even_next;
            txd_save      <= txd;
            txd_par_save  <= txd_par;
            tx_v          <= tx_v_nxt;
         end

      else // Normal state transitions.
         begin
            tx_state      <= tx_state_next;
            tx_even       <= tx_even_next;
            txd_save      <= txd;
            txd_par_save  <= txd_par;
            tx_v          <= tx_v_nxt;
         end
   end


   // The void function as defined in the IEEE 802.3 Clause 36:
   assign tx_dat_err  = tx_en && tx_er;
   assign tx_cext_err = ~tx_en && tx_er && (txd != 8'h0f);
   assign tx_v_func   = tx_dat_err || tx_cext_err;

   // The transmit state machine.  This is a combinatorial state machine with
   // synchronous state transitions regulated by the main synchronisation
   // process above.  As a result, all outputs are asynchronously asserted and
   // should therefore be registered and synchronised at a higher level.

   always@(*)
   begin

      // Defaults
      tx_v_nxt      = 1'b0;
      col           = 1'b0;
      tx_oset_done  = 1'b1;
      tx_even_next  = ~tx_even;
      transmitting  = 1'b0;

      case (tx_state)

         // Configuration states entered when auto negotiation module requests
         // re-configuring.

         // Configuration code set C1.
         CONFIG_1A:
            begin
               tx_oset_done = 1'b0;
               tx_code = CODE_K_28_5;
               tx_control = 1'b1;
               tx_even_next = 1'b1;
               tx_state_next = CONFIG_1B;
            end

         CONFIG_1B:
            begin
               tx_oset_done = 1'b0;
               tx_code = CODE_D21_5;
               tx_control = 1'b0;
               tx_state_next = CONFIG_1C;
            end

         CONFIG_1C:
            begin
               tx_oset_done = 1'b0;
               tx_code = {tx_config_reg_par[0],tx_config_reg[7:0]};
               tx_control = 1'b0;
               tx_state_next = CONFIG_1D;
            end

         CONFIG_1D:
            begin
               tx_code = {tx_config_reg_par[1],tx_config_reg[15:8]};
               tx_control = 1'b0;
               tx_state_next = CONFIG_2A;
               // Note that this may be overridden by the main synchronisation
               // process when auto-negotiation reports complete.
            end

         // Configuration code set C2.
         CONFIG_2A:
            begin
               tx_oset_done = 1'b0;
               tx_code = CODE_K_28_5;
               tx_control = 1'b1;
               tx_state_next = CONFIG_2B;
            end

         CONFIG_2B:
            begin
               tx_oset_done = 1'b0;
               tx_code = CODE_D2_2;
               tx_control = 1'b0;
               tx_state_next = CONFIG_2C;
            end

         CONFIG_2C:
            begin
               tx_oset_done = 1'b0;
               tx_code = {tx_config_reg_par[0],tx_config_reg[7:0]};
               tx_control = 1'b0;
               tx_state_next = CONFIG_2D;
            end

         CONFIG_2D:
            begin
               tx_code = {tx_config_reg_par[1],tx_config_reg[15:8]};
               tx_control = 1'b0;
               tx_state_next = CONFIG_1A;
               // Note that this may be overridden by the main synchronisation
               // process when auto-negotiation reports complete.
            end

         // Sequence Ordered set .
         // From XGMII, this is a 4 byte sequence of
         // Data Z, Data Y, Data X, 0x9c (SEQ)
         // Data Y and X are both 0x00 for the three defined fault types
         // Data Z is 0x01 for local fault
         // Data Z is 0x02 for remote fault
         // Data Z is 0x03 for link interruption fault
         // For GPII, this converts to an 8 byte sequence of
         // Seq, Data S0, Seq, Data S1, Seq, Data S2, Seq, Data S3.
         // using the following rules ...
         //   S0<7> = S3<7> = 0, S1<7> = S2<7> = 1
         //   S0<5:0> = Data X<5:0>
         //   S1<5:0> = Data Y<3:0>, Data X<7:6>
         //   S2<5:0> = Data Z<1:0>, Data Y<7:4>
         //   S3<5:0> = Data Z<7:2>
         //   Sn<6> = Sn<7> if Sn<2> = 0
         //   Sn<6> = Sn<5> if Sn<2> = 1
         // Towards the PMA, this must be converted to
         // /K28.5/W0/K28.5/W1/K28.5/W2/K28.5/W3/
         // where W is the 8b10b encoded version of the Data S bytes
         // and K28.5 is the std COMMA
         // Since we are always sending remote faults here, we can just
         // fix the sequence and omit most of the steps above.
         // We may want to consider having GPII as an input to the GEM PCS as a future change.
         SEQ_1A:
            begin
               tx_oset_done   = 1'b0;
               tx_code        = CODE_K_28_5;
               tx_control     = 1'b1;
               tx_state_next  = SEQ_1B;
            end

         SEQ_1B:  // Send S0
            begin
               tx_oset_done  = 1'b0;
               tx_code       = {1'b0,8'h00};
               tx_control    = 1'b0;
               tx_state_next = SEQ_1C;
            end

         SEQ_1C:
            begin
               tx_oset_done   = 1'b0;
               tx_code        = CODE_K_28_5;
               tx_control     = 1'b1;
               tx_state_next  = SEQ_1D;
            end

         SEQ_1D:  // Send S1
                  // S1[7:6] = 2'b11
                  // S1[5:0] = 6'h00
            begin
               tx_oset_done  = 1'b0;
               tx_code       = {1'b0,8'hc0};
               tx_control    = 1'b0;
               tx_state_next = SEQ_2A;
            end

         SEQ_2A:
            begin
               tx_oset_done   = 1'b0;
               tx_code        = CODE_K_28_5;
               tx_control     = 1'b1;
               tx_state_next  = SEQ_2B;
            end

         SEQ_2B:  // Send S2
                  // S2[7:6] = 2'b11
                  // S2[5:4] = Z[1:0]. Since Z=0x2 for remote fault, Z[1] = 1, so S2[5:4] = 2'b10
                  // S2[3:0] = 0
            begin
               tx_oset_done  = 1'b0;
               tx_code       = {1'b1,8'he0};
               tx_control    = 1'b0;
               tx_state_next = SEQ_2C;
            end

         SEQ_2C:
            begin
               tx_oset_done   = 1'b0;
               tx_code        = CODE_K_28_5;
               tx_control     = 1'b1;
               tx_state_next  = SEQ_2D;
            end

         SEQ_2D:
            begin
               tx_code        = {1'b0,8'h00}; // S3
               tx_control     = 1'b0;
               tx_state_next  = IDLE_DISP;
            end

         // Idle code generation on request from auto negotiation
         // or when tx_en and tx_er not ready after configuration.
         // Will remain in IN_IDLE_DISP - IN_DISP until both tx_en and tx_er
         // from GMII interface is de-asserted.

         IN_IDLE_DISP:
            begin
               tx_oset_done = 1'b0;
               tx_code = CODE_K_28_5;
               tx_control = 1'b1;
               tx_state_next = IN_DISP;
            end

         IN_DISP:
            begin
               if (~tx_disparity)    // Will use disparity of code after K28_5.
                  tx_code = CODE_D5_6;  // Disparity correction.
               else
                  tx_code = CODE_D16_2; // Disparity preservation.
               tx_control = 1'b0;
               // Proceed now to disparity preservation.
               if ( (xmit_save == XMIT_DATA) && tx_idle)
                  tx_state_next = IDLE_DISP;
               else
                  tx_state_next = IN_IDLE_DISP;
            end


         // Normal idle disparity code group generation.
         // The first idle set sent out will reset the running disparity, all
         // subsequent codes are chosen to preserve the running disparity.

         IDLE_DISP:
            begin
               tx_oset_done = 1'b0;
               tx_code = CODE_K_28_5;
               tx_control = 1'b1;
               tx_state_next = DISP;
            end

         DISP:
            begin
               if (~tx_disparity)      // Disparity after K28_5.
                  tx_code = CODE_D5_6;
               else
                  tx_code = CODE_D16_2;
               tx_control = 1'b0;
               // Proceed now to disparity preservation or start.
               case ({tx_en,tx_er})
                 2'b01: tx_state_next = (txd == 8'h01)? LPIDLE_DISP : IDLE_DISP;
                 2'b10: tx_state_next = SOP;
                 2'b11: tx_state_next = START_ERROR;  // Not possible with GEM?
                 default: tx_state_next = IDLE_DISP;
               endcase
            end

         // Low power idle disparity code group generation.
         LPIDLE_DISP:
            begin
               tx_oset_done = 1'b0;
               tx_code = CODE_K_28_5;
               tx_control = 1'b1;
               tx_state_next  = LP_DISP;
            end

         LP_DISP:
            begin
               if (~tx_disparity)      // Disparity after K28_5.
                  tx_code = CODE_D6_5;
               else
                  tx_code = CODE_D26_4;
               tx_control = 1'b0;
               // Proceed now to disparity preservation or start.
               if ({tx_en,tx_er,txd} == 10'h101)
                  tx_state_next = LPIDLE_DISP;
               else
                  tx_state_next = IDLE_DISP;
            end

         // An error in the start sequence is propagated by first sending a
         // valid start of packet, this is followed by the error propagation
         // symbol.
         START_ERROR: // This may be unreachable with GEM
            begin
               transmitting = 1'b1;
               col = receiving;
               tx_code = CODE_K_S;
               tx_control = 1'b1;
               tx_state_next = TX_DATA;
               tx_v_nxt = 1'b1;
            end

         // A good start sequence...
         SOP:
            begin
               transmitting = 1'b1;
               col = receiving;
               tx_code = CODE_K_S;
               tx_control = 1'b1;
               tx_v_nxt = tx_v_func;  // Can GEM error at start?
               case ({tx_en,tx_er})
                  2'b00: tx_state_next = EOP_NOEXT; // Not possible with GEM?
                  2'b01: tx_state_next = EOP_EXT;   // Not possible with GEM?
                  default: tx_state_next = TX_DATA;
               endcase
            end

         TX_DATA:
            begin
               transmitting = 1'b1;
               col = receiving;
               if (tx_v)
                 tx_code = CODE_K_V;
               else
                 tx_code = {txd_par_save,txd_save};
               tx_control = tx_v;
               tx_v_nxt = tx_v_func;
               case ({tx_en,tx_er})
                  2'b00: tx_state_next = EOP_NOEXT;
                  2'b01: tx_state_next = EOP_EXT;
                  default: tx_state_next = TX_DATA;
               endcase
            end

         // Good end of packet with no carrier extension, not bursting.
         EOP_NOEXT:
            begin
               if (~tx_even)
                  transmitting = 1'b1; // last=odd, current=even, still txing

               tx_code = CODE_K_T;
               tx_control = 1'b1;
               tx_state_next = EPD2;
            end

         // End of packet part 2... determine whether need to send
         // another CODE_K_R to pad to proper alignment.
         EPD2:
            begin
               tx_code = CODE_K_R;
               tx_control = 1'b1;
               if (tx_even)
                  tx_state_next = IDLE_DISP; // last=even, current=odd - IDLE
               else
                  tx_state_next = EPD3; // last=odd, current=even - another /R/
            end

         // Pad to proper alignment
         EPD3:
            begin
               tx_code = CODE_K_R;
               tx_control = 1'b1;
               tx_state_next = IDLE_DISP;
            end

         // End of packet with carrier extension
         // Note that for tx_v to be active, the MAC would have to go from
         // sending a frame to de-assert tx_en with tx_er active but txd not
         // indicating 8'h0f. For GEM, in the event of an underrun or error, the
         // MAC tries to cleanly terminate. The only way to force this condition
         // is to force LPI mid-packet which is not realistic.
         EOP_EXT:
            begin
               transmitting = 1'b1;
               col = receiving;
               tx_control = 1'b1;
               if (tx_v)  // Not realistically reachable with GEM
                 tx_code = CODE_K_V;
               else
                 tx_code = CODE_K_T;
               tx_v_nxt = tx_v_func;
               if (~tx_er)
                  tx_state_next = EXTEND_BY1;
               else
                  tx_state_next = CARRIER_EXTEND;
            end

         // Normal carrier extension
         CARRIER_EXTEND:
            begin
               transmitting = 1'b1;
               col = receiving;
               if (tx_v)
                 tx_code = CODE_K_V;
               else
                 tx_code = CODE_K_R;
               tx_control = 1'b1;
               tx_v_nxt = tx_v_func;
               case ({tx_en,tx_er})
                  2'b00: tx_state_next = EXTEND_BY1;
                  2'b10: tx_state_next = SOP;
                  2'b11: tx_state_next = START_ERROR; // Not possible with GEM?
                  default: tx_state_next = CARRIER_EXTEND;
               endcase
            end

         // Extend by 1 extra R for end..
         EXTEND_BY1:
            begin
               if (~tx_even)
                  transmitting = 1'b1; // last=odd, current=even, still txing

               tx_code = CODE_K_R;
               tx_control = 1'b1;
               tx_state_next = EPD2;
            end

         // Entry state after reset or when something went wrong.  State
         // transitions depending on value of xmit from autonegotiation process
         // and state of GMII inputs, otherwise stay here.
         default: // INITIAL_STATE
            begin
               tx_even_next = 1'b0;
               tx_code = CODE_K_R;
               tx_control = 1'b1;
               tx_state_next = INITIAL_STATE;
            end

      endcase
   end

endmodule
