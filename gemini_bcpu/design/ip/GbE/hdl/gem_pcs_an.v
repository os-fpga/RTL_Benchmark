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
//   Filename:           gem_pcs_an.v
//   Module Name:        gem_pcs_an
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
//   Description    :   This module implements the auto negotiation process
//                      specified in IEEE 802.3 specifications, 1998 edition,
//                      clause 37.  It also generates the necessary control
//                      signals to control the transmit and receive state
//                      machines.  The transmit configuration information is
//                      sourced from the local device auto negotiation registers
//                      and the link partner configuration is stored into the
//                      appropriate registers.  This information is provided as
//                      simple inputs to this module.
//
//------------------------------------------------------------------------------
//   Limitations    :   Does not perform actual configuration to match
//                      negotiated abilities, this is left for software to
//                      handle.
//
//------------------------------------------------------------------------------


module gem_pcs_an(

   // System Inputs

   rx_clk,
   n_reset,             // Synchronised to rx_clk
   sync_reset,          // Synchronised to rx_clk from gem_pcs_rx

   // Status information from gem_pcs_rx, in same clock domain.
   rx_indicate,
   sync_status,

   rx_config_reg,

   // Control registers inputs from gem_pcs_registers and top level registers.
   retry_test,          // Stable, registered and double synced.
   alt_sgmii_mode,
   sgmii_mode,
   uni_direct_en,
   two_pt_five_gig,
   mr_an_enable,        // Slow signal, registered and double synced
   mr_an_restart,       // Handshake signal, registered, double synced
   mr_adv_ability,      // Assume stable bus, registered, double synced
   mr_adv_ability_par,
   mr_np_tx,            // Assume stable bus, registered, double synced
   mr_np_tx_par,
   mr_np_loaded,        // Handshake signal, registered, double synced
   mr_lp_np_read,       // Handshake signal, registered, double synced


   // Output to gem_pcs_tx
   tx_config_reg,       // Slow double synced bus.
   tx_config_reg_par,

   // Output to gem_pcs_tx and gem_pcs_rx
   xmit,                // single synced to gem_pcs_tx, same domain for rx.
   xmit_change_rx,      // toggles when xmit changes

   // Outputs to gem_pcs_registers
   an_restarted,        // Indicates that AN will restart
   mr_page_rx,          // Registered, double synced toggle signal.
   mr_np_loaded_clr,    // Registered, double synced toggle signal.
   mr_link_status,      // Registered long double synced signal.
   mr_an_complete,      // Registered long double synced signal.
   mr_lp_adv_ability,   // Registered slow double synced bus,
   mr_lp_np_rx,         // Registered slow double synced bus,

   mr_base_rf_clear,    // Clear remote fault encodings of base register
   an_full_duplex_mode, // Negotiated to full duplex mode
   an_pause_tx_en,      // Negotiated to allow transmission of pause frames
   an_pause_rx_en       // Negotiated to allow reception of pause frames

   );

   // Port declarations

   // Inputs
   input          rx_clk;              // System clock for synchronous processes
   input          n_reset;             // Asynchronous active low reset.
   input          sync_reset;          // Synchronous active high reset.
   input          retry_test;          // Debug signal to shorten timer.
   input          alt_sgmii_mode;      // alternative tx config for SGMII
   input          sgmii_mode;          // PCS is configured for SGMII
   input          uni_direct_en;       // when set PCS transmits data rather
                                       // than idle when rx link is down
   input          two_pt_five_gig;     // indicates 2.5G operation
   input [1:0]    rx_indicate;         // Receive type.
   input          sync_status;         // Synchronisation status.
   input [15:0]   rx_config_reg;       // Configuration of link partner.

   // Inputs from management register block.
   input          mr_an_enable;        // Enable auto negotiation.
   input          mr_an_restart;       // Restart auto negotiation.
   input          mr_np_loaded;        // Next page loaded.
   input [7:0]    mr_adv_ability;      // Local device abilities.
   input          mr_adv_ability_par;
   input [15:0]   mr_np_tx;            // Local device next page.
   input [1:0]    mr_np_tx_par;
   input          mr_lp_np_read;       // Link partner's next page been read.

   // Outputs
   output [1:0]   xmit;                // Rx / Tx data type.
   output         xmit_change_rx;      // toggles when xmit changes
   output [15:0]  tx_config_reg;       // Transmit configuration data.
   output [1:0]   tx_config_reg_par;

   // Outputs to management register block.
   output         an_restarted;        // Autonegotiation restarted
   output         mr_page_rx;          // Page received.
   output         mr_np_loaded_clr;    // Clear next page loaded.
   output         mr_link_status;      // Link status.
   output         mr_an_complete;      // Auto-negotiation complete.
   output [15:0]  mr_lp_adv_ability;   // Link partner ability.
   output [15:0]  mr_lp_np_rx;         // Link partner next page.

   output         mr_base_rf_clear;    // Clear the RF bits of base register
   output         an_full_duplex_mode; // Negotiated to full duplex mode
   output         an_pause_tx_en;      // Negotiated to allow tx of pause frames
   output         an_pause_rx_en;      // Negotiated to allow rx of pause frames


   // Reg and wire declarations
   reg [1:0]      xmit;                // Rx / Tx data type.
   reg            xmit_change_rx;      // toggles when xmit changes
   reg [15:0]     tx_config_reg;       // Transmit configuration data.
   reg  [1:0]     tx_config_reg_par;
   reg            an_restarted;        // Autonegotiation restarted
   reg            an_restarted_next;   // Autonegotiation restarted
   reg            mr_page_rx;          // Page received.
   reg            mr_np_loaded_clr;    // Clear next page loaded.
   reg            mr_link_status;      // Link status.
   reg            mr_an_complete;      // Auto-negotiation complete.
   reg [15:0]     mr_lp_adv_ability;   // Link partner ability.
   reg [15:0]     mr_lp_np_rx;         // Link partner next page.

   reg            mr_base_rf_clear;    // Clear the RF bits of base register
   reg            an_full_duplex_mode; // Negotiated to full duplex mode
   reg            an_half_duplex_mode; // Negotiated to half duplex mode
   reg            an_pause_tx_en;      // Negotiated to allow tx of pause frames
   reg            an_pause_rx_en;      // Negotiated to allow rx of pause frames

   reg            resolve_priority;    // Enable priority resolution function.

   reg            clr_np_loaded_save;  // clear signal save.
   reg            mr_an_enable_save;   // Previous version of mr_an_enable
   reg            enable_timer;        // Activate link timer.
   reg            timer_done;          // Link timer complete.
   reg [20:0]     timer_count;         // Timer counter.
   reg [20:0]     link_fail_timer;     // Timer for link fail.
   reg            link_failed;         // Link has failed.
   reg [15:0]     ability_save;        // LP Base on match.
   reg [15:0]     detect_save;         // ability_save saved when going to
                                       // ACK_DET
   reg            ability_match_next;  // Match on next count.
   reg            ability_match;       // According to IEEE 802.3, 37.3.1.2
   reg [15:0]     ack_save;            // config_reg saved when ack_match.
   reg            ack_match_next;      // Match on next count.
   reg            ack_match;           // According to IEEE 802.3, 37.3.1.2
   reg            idle_match;          // 3 consecutive idle sets.
   reg [1:0]      idle_count;          // counter for idle sets.
   reg            toggle_tx;           // toggle bit to transmit.
   reg            toggle_tx_next;      // updated on clock edge.
   reg            toggle_rx;           // Received toggle information
   reg            toggle_rx_next;      // next value.
   reg            np_rx;               // Next page still to receive
   reg            np_rx_next;          // updated on clock
   reg            mr_page_rx_toggle;   // toggle page received
   reg            mr_page_rx_tog_sv;   // save for toggle flag
   reg [15:0]     tx_config_reg_next;  // next configuration to transmit.
   reg  [1:0]     tx_config_reg_par_next;
   reg [15:0]     lp_ability_next;     // link partner's ability
   reg [15:0]     lp_np_rx_next;       // link partner's next page.
   reg            an_complete;         // auto negotiation completed.
   reg [1:0]      xmit_next;           // next value of xmit.
   reg [1:0]      xmit_new;            // xmit_next with priority override
   reg            clr_np_loaded;       // clear the np loaded register.
   reg            link_status_next;    // status of the link.

   reg [3:0]      an_state;            // Current state machine state
   reg [3:0]      an_state_next;       // updated with next value on clock.

   wire           consistency_match;   // Check if ability saved is same as
                                       // when acknowledge was matched.
   reg            next_page;           // Indicate when onto next page..
   reg            base_page;           // Indicate when doing base page.

   reg            config_count_en;     // Toggle signal to strobe sampling
                                       // of rx_config_reg values since 2 clock
                                       // cycles needed to transfer each code
                                       // set.
   wire [15:0]    mr_adv_ability_int;  // Uncompacted
   wire [1:0]     mr_adv_ability_par_int;
   reg  [20:0]    max_time_val;        // Max value for timer based on sgmii/2.5

   parameter  p_edma_asf_dap_prot = 1'b0;

   // xmit encodings.
   parameter
      XMIT_CONFIG = 2'b00,    // Configuration for auto-negotiation.
      XMIT_IDLE   = 2'b01,    // IDLE detect.
      XMIT_DATA   = 2'b11;    // Normal operation


   // rx_indicate encodings
   parameter
      IDLE_INDICATE     = 2'b00, // Idle set received.
      INVALID_INDICATE  = 2'b01, // Invalid set received.
      CONFIG_INDICATE   = 2'b11; // Configuration data received.


   // State machine encodings
   parameter
      AN_ENABLE      = 4'h0,     // Initial POR state, check for an_enable.
      AN_RESTART     = 4'h1,     // Start auto-negotiation.
      AN_DISABLE     = 4'h2,     // Auto-neg disabled.
      ABILITY_DET    = 4'h3,     // Detect LP abilities.
      ACK_DET        = 4'h4,     // Send acknowledge and wait for response.
      COMPLETE_ACK   = 4'h5,     // Acknowledge received.
      ACK_TIMER      = 4'h6,     // Wait for next pages.
      NEXT_PAGE_WAIT = 4'h7,     // Process next page
      IDLE_DET       = 4'h8,     // Wait for idle sets.
      LINK_OK        = 4'h9;     // Complete.


   // link timer decodes (dependent on whether configured for SGMII mode)
   parameter
      LINK_TIMER_SGMII      = 21'd100000,   // 1.6ms @ 62.5MHz
      LINK_TIMER_SGMII_2_5  = 21'd250000,   // 1.6ms @ 156.25MHz
      LINK_TIMER            = 21'd625000,   // 10ms @ 62.5MHz
      LINK_TIMER_2_5        = 21'd1562500;  // 10ms @ 156.25MHz


   // Expand mr_adv_ability into 16-bit value
   assign mr_adv_ability_int  = {mr_adv_ability[7],1'b0,
                                  mr_adv_ability[6:5],3'b000,
                                  mr_adv_ability[4:1],4'b0000,
                                  mr_adv_ability[0]};

   // Optionally check and regenerate parity for mr_adv_ability_int
   generate if (p_edma_asf_dap_prot == 1) begin : gen_par
      gem_par_chk_regen #(.p_chk_dwid(8), .p_new_dwid(16)) i_regen_par (
        .odd_par  (1'b0),
        .chk_dat  (mr_adv_ability),
        .chk_par  (mr_adv_ability_par),
        .new_dat  (mr_adv_ability_int),
        .dat_out  (),
        .par_out  (mr_adv_ability_par_int),
        .chk_err  ()
      );
   end else begin : gen_no_par
     assign mr_adv_ability_par_int  = 2'b00;
   end
   endgenerate

   // The maximum value for the link timer is dependant on whether design is
   // operating in SGMII or 2.5G modes.
   always@(*)
   begin
      if (sgmii_mode)
      begin
        if (two_pt_five_gig)
           max_time_val = LINK_TIMER_SGMII_2_5;
        else
           max_time_val = LINK_TIMER_SGMII;
      end
      else
      begin
        if (two_pt_five_gig)
           max_time_val = LINK_TIMER_2_5;
        else
           max_time_val = LINK_TIMER;
      end
   end

   // Process to generate the counters.
   // The timer starts counting once enable_timer is signalled and will flag
   // timer_done when complete.  The counter will count approx 10ms with a
   // 62.5MHz clock.  If retry_test is active (for debug only), timer will
   // expire after 4 clocks.
   // The above max_time_val is used to differentiate between different
   // operating modes.
   always@(posedge rx_clk or negedge n_reset)
   begin
      if (~n_reset)
         begin
            timer_count <= 21'd0;
            timer_done <= 1'b0;
         end
      else if (sync_reset)
         begin
            timer_count <= 21'd0;
            timer_done <= 1'b0;
         end
      else
         begin
            if (enable_timer)
               begin
                  if (retry_test)
                  begin
                     if (timer_count[4])
                        timer_done <= 1'b1;
                     else
                     begin
                        timer_done <= 1'b0;
                        timer_count <= timer_count + 21'd1;
                     end
                  end
                  else
                  begin
                     if (timer_count == max_time_val)
                        timer_done <= 1'b1;
                     else
                     begin
                        timer_done <= 1'b0;
                        timer_count <= timer_count + 21'd1;
                     end
                  end
               end
            else
               begin
                  timer_count <= 21'd0;
                  timer_done <= 1'b0;
               end
         end
   end


   // Process to generate the link fail timer.  If sync_status = FAIL (0) for
   // more than specified time, then autonegotiation is restarted.
   // This is specified to be approx 10ms in the IEEE spec. Retry test can be
   // used to shorten this down to 4 cycles.

   always@(posedge rx_clk or negedge n_reset)
   begin
      if (~n_reset)
         begin
            link_fail_timer <= 21'd0;
            link_failed <= 1'b0;
         end
      else if (sync_reset || sync_status)
         begin
            link_fail_timer <= 21'd0;
            link_failed <= 1'b0;
         end
      else
         begin
            if (retry_test)
            begin
               if ((link_fail_timer[4]) | link_failed)
                  link_failed <= 1'b1;
               else
               begin
                  link_fail_timer <= link_fail_timer + 21'd1;
                  link_failed <= 1'b0;
               end
            end
            else
            begin
               if (link_failed | (link_fail_timer == max_time_val))
                  link_failed <= 1'b1;
               else
               begin
                  link_fail_timer <= link_fail_timer + 21'd1;
                  link_failed <= 1'b0;
               end
            end
         end
   end


   // Continuously monitor for ability match.  Set when three consecutive
   // rx_config_reg values received with matching bits [15,13:0].
   // Reset on receipt of IDLE, or when a rx_config_reg value fails to match.

   always@(posedge rx_clk or negedge n_reset)
   begin
      if (~n_reset)
         begin
            ability_match <= 1'b0;
            ability_match_next <= 1'b0;
            ability_save <= 16'h0000;
            detect_save <= 16'h0000;
            config_count_en <= 1'b1;
         end
      else if (sync_reset)
         begin
            ability_match <= 1'b0;
            ability_match_next <= 1'b0;
            ability_save <= 16'h0000;
            detect_save <= 16'h0000;
            config_count_en <= 1'b1;
         end
//      else if ((rx_indicate == INVALID_INDICATE) |
//              (rx_indicate == IDLE_INDICATE) )
      else if (rx_indicate != CONFIG_INDICATE)
         begin
            ability_match <= 1'b0;
            ability_match_next <= 1'b0;
            ability_save <= 16'h0000;
            config_count_en <= 1'b1;
         end

      else
      begin
//         if ( (rx_indicate == CONFIG_INDICATE) & config_count_en )
         if ( config_count_en )
         begin
            config_count_en <= 1'b0;
            if ((ability_save & 16'hBFFF) == (rx_config_reg & 16'hBFFF))
               begin
                  ability_match <= ability_match_next;
                  ability_match_next <= 1'b1;
               end
            else
               begin
                  ability_match <= 1'b0;
                  ability_match_next <= 1'b0;
                  ability_save <= rx_config_reg;
               end
         end
         else
            begin
               config_count_en <= 1'b1;
               ability_match <= ability_match;
               ability_match_next <= ability_match_next;
            end

         if ( (an_state_next == ACK_DET) &
              ((an_state == ABILITY_DET) | (an_state == NEXT_PAGE_WAIT)) )
            detect_save <= ability_save;
         else
            detect_save <= detect_save;
      end
   end


   // Similarly, check for acknowledge match, here the 16 config_reg bits should
   // be the same, in addition the ack bit, 14, should also be set.

   always@(posedge rx_clk or negedge n_reset)
   begin
      if (~n_reset)
         begin
            ack_match <= 1'b0;
            ack_match_next <= 1'b0;
            ack_save <= 16'h0000;
         end
      else if (sync_reset)
         begin
            ack_match <= 1'b0;
            ack_match_next <= 1'b0;
            ack_save <= 16'h0000;
         end
//      else if ((rx_indicate == INVALID_INDICATE) |
//              (rx_indicate == IDLE_INDICATE) )
      else if (rx_indicate != CONFIG_INDICATE)
         begin
            ack_match <= 1'b0;
            ack_match_next <= 1'b0;
            ack_save <= 16'h0000;
         end

//      else if ( (rx_indicate == CONFIG_INDICATE) & config_count_en )
      else if (config_count_en )
         begin
            if ((ack_save == rx_config_reg) & ack_save[14])
               begin
                     ack_match <= ack_match_next;
                     ack_match_next <= 1'b1;
               end
            else
               begin
                  ack_match <= 1'b0;
                  ack_match_next <= 1'b0;
                  ack_save <= rx_config_reg;
               end
         end
      else
         begin
            ack_match <= ack_match;
            ack_match_next <= ack_match_next;
         end
   end


   // Consistency matched when all bits except bit 14 of rx_config_reg match
   // for when ability matched and acknowledge matched.

   assign consistency_match = ack_match & ability_match & (
                            (detect_save & 16'hBFFF) == (ack_save & 16'hBFFF));




   // A process to generate the idle_match signal.  This is much simpler by
   // just counting the number of consecutive idle states every clock cycle.

   always@(posedge rx_clk or negedge n_reset)
   begin
      if (~n_reset)
         begin
            idle_match <= 1'b0;
            idle_count <= 2'b00;
         end
      else if (sync_reset)
         begin
            idle_match <= 1'b0;
            idle_count <= 2'b00;
         end
      else if ( (rx_indicate == CONFIG_INDICATE) | (an_state == AN_RESTART) )
         begin
            idle_match <= 1'b0;
            idle_count <= 2'b00;
         end
      else if (rx_indicate == IDLE_INDICATE)
         if (idle_count == 2'b10)
            idle_match <= 1'b1;
         else
            idle_count <= idle_count + 2'b01;
      else
         begin
            idle_match <= 1'b0;
            idle_count <= 2'b00;
         end
   end


   // State machine synchronisation process, updates registers on rising edge
   // of rx_clk.
   // If link fails, state machine is forced back to AN_ENABLE state.

   always@(posedge rx_clk or negedge n_reset)
   begin
      if (~n_reset)
         begin
            an_restarted <= 1'b0;
            tx_config_reg <= 16'h0000;
            tx_config_reg_par <= 2'h0;
            mr_link_status <= 1'b0;
            mr_an_complete <= 1'b0;
            mr_lp_adv_ability <= 16'h0000;
            mr_lp_np_rx <= 16'h0000;
            mr_an_enable_save <= 1'b0;
            toggle_tx <= 1'b0;
            toggle_rx <= 1'b0;
            np_rx <= 1'b0;
            xmit <= XMIT_DATA;
            xmit_change_rx <= 1'b0;
            an_state <= AN_DISABLE;
            mr_base_rf_clear <= 1'b0;
         end
      else if (sync_reset)
         begin
            an_restarted <= 1'b0;
            tx_config_reg <= 16'h0000;
            tx_config_reg_par <= 2'h0;
            mr_link_status <= 1'b0;
            mr_an_complete <= 1'b0;
            mr_lp_adv_ability <= 16'h0000;
            mr_lp_np_rx <= 16'h0000;
            mr_an_enable_save <= 1'b0;
            toggle_tx <= 1'b0;
            toggle_rx <= 1'b0;
            np_rx <= 1'b0;
            xmit <= XMIT_DATA;      // normal operation
            xmit_change_rx <= 1'b0;
            an_state <= AN_DISABLE;
            mr_base_rf_clear <= 1'b0;
         end
      else
         begin
            an_restarted <= an_restarted_next;
            tx_config_reg <= tx_config_reg_next;
            tx_config_reg_par <= tx_config_reg_par_next;
            mr_link_status <= link_status_next;
            mr_an_complete <= an_complete;
            mr_lp_adv_ability <= lp_ability_next;
            mr_lp_np_rx <= lp_np_rx_next;
            toggle_tx <= toggle_tx_next;
            toggle_rx <= toggle_rx_next;
            np_rx <= np_rx_next;
            mr_an_enable_save <= mr_an_enable;

            // Enable or restart autonegotiation.
            if ((mr_an_enable & ~mr_an_enable_save) | mr_an_restart |
                 link_failed | (rx_indicate == INVALID_INDICATE))
               begin
                  an_state <= AN_ENABLE;
               end
            // Disable autonegotiation
            else if (~mr_an_enable)
               begin
                  an_state <= AN_DISABLE;
               end
            // Normal state transitions.
            else
               begin
                  an_state <= an_state_next;
               end

            xmit  <= xmit_new;
            if (xmit != xmit_new)
               xmit_change_rx <= ~xmit_change_rx;

            if (an_state == IDLE_DET)
               mr_base_rf_clear <= 1'b1;
            else
               mr_base_rf_clear <= 1'b0;

         end
   end


   // Priority branch for xmit assignment
   always@(*)
   begin
      if ((mr_an_enable & ~mr_an_enable_save) | mr_an_restart |
                 link_failed | (rx_indicate == INVALID_INDICATE))
      begin
         if (mr_an_enable)
            xmit_new = XMIT_CONFIG;
         else if (uni_direct_en)
            xmit_new = XMIT_DATA;
         else
            xmit_new = XMIT_IDLE;
      end
      // Disable autonegotiation
      else if (~mr_an_enable)
         xmit_new = XMIT_DATA;
      // Normal state transitions.
      else
         xmit_new = xmit_next;
   end

   // Process to toggle the signal to clear next page loaded and page rx signals
   always@(posedge rx_clk or negedge n_reset)
   begin
      if (~n_reset)
         begin
            mr_np_loaded_clr <= 1'b0;
            clr_np_loaded_save <= 1'b0;
            mr_page_rx_tog_sv <= 1'b0;
            mr_page_rx <= 1'b0;
         end
      else if (sync_reset)
         begin
            mr_np_loaded_clr <= 1'b0;
            clr_np_loaded_save <= 1'b0;
         end
      else
         begin
            mr_page_rx_tog_sv <= mr_page_rx_toggle;
            clr_np_loaded_save <= clr_np_loaded;
            if (clr_np_loaded & ~clr_np_loaded_save)
               mr_np_loaded_clr <= ~mr_np_loaded_clr;
            else
               mr_np_loaded_clr <= mr_np_loaded_clr;

            if (mr_page_rx_toggle & ~mr_page_rx_tog_sv)
               mr_page_rx <= ~mr_page_rx;
            else
               mr_page_rx <= mr_page_rx;
         end
   end


   // Process to indicate whether processing next page information.
   // The first time going into acknowledge detect, we will be processing
   // the base page, subsequently it will be next pages.  The flags are
   // reset on entry into AN_RESTART.
   always@(posedge rx_clk or negedge n_reset)
   begin
      if (~n_reset)
         begin
            next_page <= 1'b0;
            base_page <= 1'b0;
         end
      else if (sync_reset)
         begin
            next_page <= 1'b0;
            base_page <= 1'b0;
         end
      else
      begin
         if (an_state == AN_RESTART)
            begin
               next_page <= 1'b0;
               base_page <= 1'b0;
            end
         else if (an_state == COMPLETE_ACK)
            begin
               if (~base_page & ~next_page)
                  begin
                     next_page <= 1'b0;
                     base_page <= 1'b1;
                  end
               else
                  begin
                     next_page <= 1'b1;
                     base_page <= 1'b0;
                  end
            end
         else
            begin
               next_page <= next_page;
               base_page <= base_page;
            end
      end
   end


   // The Auto Negotiation state machine.  Generates tx_config_reg and xmit
   // values for rx and tx blocks as well as register control and status
   // signals.  Combinatorial state machine, transitions controlled by
   // synchronisation process above.

   always@(*)
   begin

   case (an_state)

      // If autonegotiation is disabled, link status is just the recovered
      // sync status from gem_pcs_rx and will remain in this state until
      // a restart is requested or the link goes down.

      AN_DISABLE:
         begin
            an_restarted_next = 1'b0;
            enable_timer = 1'b0;
            toggle_tx_next = toggle_tx;
            toggle_rx_next = toggle_rx;
            np_rx_next = np_rx;
            mr_page_rx_toggle = 1'b0;
            lp_ability_next = mr_lp_adv_ability;
            lp_np_rx_next = mr_lp_np_rx;
            an_complete = 1'b0;
            clr_np_loaded = 1'b0;
            link_status_next = sync_status;
            tx_config_reg_next = tx_config_reg;
            tx_config_reg_par_next  = tx_config_reg_par;
            xmit_next = XMIT_DATA;
            an_state_next = AN_DISABLE;
            resolve_priority = 1'b0;
         end

      // Restart autonegotiation.  This is signalled to the link partner
      // through the continuous transmission of C1/C2 groups with 0 encoded
      // data for approx 10ms.

      AN_RESTART:
         begin
            an_restarted_next = 1'b0;
            enable_timer = 1'b1;
            toggle_tx_next = toggle_tx;
            toggle_rx_next = toggle_rx;
            np_rx_next = np_rx;
            mr_page_rx_toggle = 1'b0;
            lp_ability_next = mr_lp_adv_ability;
            lp_np_rx_next = mr_lp_np_rx;
            an_complete = 1'b0;
            clr_np_loaded = 1'b1;
            link_status_next = 1'b0;
            if (alt_sgmii_mode & sgmii_mode)
            begin
               tx_config_reg_next = 16'h4001;
               tx_config_reg_par_next = 2'b11;
            end
            else
            begin
               tx_config_reg_next = 16'h0000;
               tx_config_reg_par_next = 2'b00;
            end
            xmit_next = XMIT_CONFIG;
            resolve_priority = 1'b0;
            if (timer_done)
               an_state_next = ABILITY_DET;
            else
               an_state_next = AN_RESTART;
         end

      // Detect the link partner's advertised base abilities.  If the link
      // partner terminates the link and goes to idle, the state machine will
      // remain in this process as it is waiting for an ability match.  In
      // this case, exit is accomplished by the host restarting auto-neg or
      // if the link partner restarts by sending C1/C2 with config reg = 0.

      ABILITY_DET:
         begin
            an_restarted_next = 1'b0;
            enable_timer = 1'b0;
            toggle_tx_next = mr_adv_ability_int[11];
            toggle_rx_next = toggle_rx;
            np_rx_next = np_rx;
            mr_page_rx_toggle = 1'b0;
            lp_np_rx_next = mr_lp_np_rx;
            an_complete = 1'b0;
            clr_np_loaded = 1'b0;
            link_status_next = 1'b0;
            if (alt_sgmii_mode & sgmii_mode)
            begin
               tx_config_reg_next = 16'h4001;
               tx_config_reg_par_next = 2'b11;
            end
            else
            begin
               tx_config_reg_next = mr_adv_ability_int[15:0];
               tx_config_reg_par_next = mr_adv_ability_par_int[1:0];
            end
            xmit_next = XMIT_CONFIG;
            resolve_priority = 1'b0;
            if (ability_match & (ability_save != 16'h0000))
               begin
                  an_state_next = ACK_DET;
                  lp_ability_next = ability_save;
               end
            else
               begin
                  an_state_next = ABILITY_DET;
                  lp_ability_next = mr_lp_adv_ability;
               end
         end

      // Detect acknowledge from the link partner.

      ACK_DET:
         begin
            an_restarted_next = 1'b0;
            enable_timer = 1'b0;
            toggle_tx_next = toggle_tx;
            toggle_rx_next = toggle_rx;
            np_rx_next = np_rx;
            mr_page_rx_toggle = 1'b0;
            lp_np_rx_next = mr_lp_np_rx;
            lp_ability_next = mr_lp_adv_ability;
            an_complete = 1'b0;
            clr_np_loaded = 1'b0;
            link_status_next = 1'b0;
            if (alt_sgmii_mode & sgmii_mode)
            begin
               tx_config_reg_next = 16'h4001;
               tx_config_reg_par_next = 2'b11;
            end
            else
            begin
               tx_config_reg_next = tx_config_reg[15:0] | 16'h4000;
               tx_config_reg_par_next[0]  = tx_config_reg_par[0];
               tx_config_reg_par_next[1]  = tx_config_reg_par[1] ^ ~tx_config_reg[14];
            end
            xmit_next = XMIT_CONFIG;
            resolve_priority = 1'b0;

            if (ack_match & consistency_match)
               an_state_next = COMPLETE_ACK;
            else if ( (ability_match & (ability_save == 16'h0000)) |
                      ack_match )
               an_state_next = AN_ENABLE;
            else
               an_state_next = ACK_DET;
         end

      // Complete acknowledge and wait for next pages if requested.

      COMPLETE_ACK:
         begin
            an_restarted_next = 1'b0;
            enable_timer = 1'b1;
            toggle_tx_next = ~toggle_tx;
            toggle_rx_next = ack_save[11];
            np_rx_next = ack_save[15] & ~sgmii_mode;
            mr_page_rx_toggle = 1'b1;
            lp_np_rx_next = mr_lp_np_rx;
            lp_ability_next = mr_lp_adv_ability;
            an_complete = 1'b0;
            clr_np_loaded = 1'b0;
            link_status_next = 1'b0;
            tx_config_reg_next = tx_config_reg;
            tx_config_reg_par_next  = tx_config_reg_par;
            xmit_next = XMIT_CONFIG;
            an_state_next = ACK_TIMER;
            resolve_priority = 1'b0;
         end

      // Wait for link timer to expire..
      // When the timer expires and next pages required, it will wait until
      // host has written new next page tx register.

      ACK_TIMER:
         begin // wait here until timer expires or exit conditions matched.
            an_restarted_next = 1'b0;
            enable_timer = 1'b1;
            toggle_tx_next = toggle_tx;
            toggle_rx_next = toggle_rx;
            np_rx_next = np_rx;

            mr_page_rx_toggle = 1'b0;

            lp_np_rx_next = mr_lp_np_rx;
            lp_ability_next = mr_lp_adv_ability;
            an_complete = 1'b0;
            clr_np_loaded = 1'b0;
            link_status_next = 1'b0;
            tx_config_reg_next = tx_config_reg;
            tx_config_reg_par_next  = tx_config_reg_par;
            xmit_next = XMIT_CONFIG;
            resolve_priority = 1'b0;
            if ( ability_match & (ability_save == 16'h0000) )
               an_state_next = AN_ENABLE;
            else if (timer_done)
             begin
               if (mr_adv_ability_int[15] & mr_lp_adv_ability[15] &
                    mr_np_loaded & (tx_config_reg[15] | np_rx) & ~sgmii_mode)
                 begin
                   an_state_next = NEXT_PAGE_WAIT;
                   enable_timer = 1'b0;
                 end
               else
                 begin
                   an_state_next = IDLE_DET;
                   enable_timer = 1'b0;
                 end
             end
            else
              begin
                an_state_next = ACK_TIMER;
                enable_timer = 1'b1;
              end
         end

      // Next page exchange, entered when both devices support next pages and
      // either one of them wishes to exchange information.
      // Note that if the host is slow in reading the link partner next page
      // register, the gem will remain in this state until the host has read
      // the register.  It will then load the new tx value to send and
      // proceed to acknowledge detect if it receives valid info.
      // While the gem is still sending out it's old value, the link partner
      // should continue to send it's configuration code and then both should
      // align again.

      NEXT_PAGE_WAIT:
         begin
            an_restarted_next = 1'b0;
            enable_timer = 1'b0;
            toggle_tx_next = toggle_tx;
            toggle_rx_next = toggle_rx;
            np_rx_next = np_rx;
            lp_ability_next = mr_lp_adv_ability;
            an_complete = 1'b0;
            clr_np_loaded = 1'b1;
            link_status_next = 1'b0;
            mr_page_rx_toggle = 1'b0;
            resolve_priority = 1'b0;

            if (~mr_lp_np_read & next_page)
            begin
               tx_config_reg_next = tx_config_reg;
               tx_config_reg_par_next = tx_config_reg_par;
            end
            else
            begin
               tx_config_reg_next = {mr_np_tx[15:12],
                                      toggle_tx,
                                      mr_np_tx[10:0]};
               tx_config_reg_par_next = mr_np_tx_par ^ {toggle_tx^mr_np_tx[11],1'b0};
            end

            xmit_next = XMIT_CONFIG;

            if (~mr_lp_np_read & next_page)
               begin
                  an_state_next = NEXT_PAGE_WAIT;
                  lp_np_rx_next = mr_lp_np_rx;
               end
            else if (ability_match & (ability_save == 16'h0000))
               begin
                  an_state_next = AN_ENABLE;
                  lp_np_rx_next = mr_lp_np_rx;
               end
            else if (ability_match & (toggle_rx ^ ability_save[11]) )
               begin
                  an_state_next = ACK_DET;
                  lp_np_rx_next = ability_save;
               end
            else
               begin
                  an_state_next = NEXT_PAGE_WAIT;
                  lp_np_rx_next = mr_lp_np_rx;
               end
         end

      // Wait for a number of good idles and stay for approx 10ms.

      IDLE_DET:
         begin
            an_restarted_next = 1'b0;
            enable_timer = 1'b1;
            toggle_tx_next = toggle_tx;
            toggle_rx_next = toggle_rx;
            np_rx_next = np_rx;
            mr_page_rx_toggle = 1'b0;
            lp_np_rx_next = mr_lp_np_rx;
            lp_ability_next = mr_lp_adv_ability;
            an_complete = 1'b0;
            clr_np_loaded = 1'b0;
            link_status_next = 1'b0;
            tx_config_reg_next = tx_config_reg;
            tx_config_reg_par_next  = tx_config_reg_par;
            xmit_next = XMIT_IDLE;
            resolve_priority = 1'b1;
            if (ability_match & (ability_save == 16'h0000))
            begin
               an_state_next = AN_ENABLE;
            end
            else if (idle_match & timer_done)
            begin
               an_state_next = LINK_OK;
            end
            else
            begin
               an_state_next = IDLE_DET;
            end
         end

      // All done!
      // link_status will only be set if either of the duplex modes was
      // successfully resolved.
      LINK_OK:
         begin
            an_restarted_next = 1'b0;
            enable_timer = 1'b0;
            toggle_tx_next = toggle_tx;
            toggle_rx_next = toggle_rx;
            np_rx_next = np_rx;
            mr_page_rx_toggle = 1'b0;
            lp_np_rx_next = mr_lp_np_rx;
            lp_ability_next = mr_lp_adv_ability;
            an_complete = 1'b1;
            clr_np_loaded = 1'b0;
            link_status_next = (an_half_duplex_mode | an_full_duplex_mode |
                                sgmii_mode);
            tx_config_reg_next = tx_config_reg;
            tx_config_reg_par_next = tx_config_reg_par;
            xmit_next = XMIT_DATA;
            resolve_priority = 1'b1;
            if (ability_match)
            begin
               an_state_next = AN_ENABLE;
            end
            else
            begin
               an_state_next = LINK_OK;
            end
         end

      // This is the entry point after reset or restart.
      // If restart, then will remain in this state until gem_pcs_registers
      // has cleared down the mr_an_restart signal.  This will be done when
      // it receives an_restarted = 1, allowing transition out of this state.

      // mr_an_restart will never be set if AN is disabled so an_restarted is
      // ignored if AN is disabled.

      // AN_ENABLE:  This is now replaced as the default state....

      default:
         begin
            an_restarted_next = 1'b1;
            enable_timer = 1'b0;
            toggle_tx_next = toggle_tx;
            toggle_rx_next = toggle_rx;
            np_rx_next = np_rx;
            mr_page_rx_toggle = 1'b0;
            lp_ability_next = mr_lp_adv_ability;
            lp_np_rx_next = mr_lp_np_rx;
            an_complete = 1'b0;
            clr_np_loaded = 1'b0;
            link_status_next = 1'b0;
            tx_config_reg_next = 16'h0000;
            tx_config_reg_par_next  = 2'b00;
            xmit_next = XMIT_CONFIG;
            an_state_next = AN_RESTART;
            resolve_priority = 1'b0;
         end

   endcase
   end


   // Priority resolution function to determine highest negotiated modes.
   // This will generate the output hooks that may be used to control the MAC/
   // PCS registers.
   // If neither an_half_duplex_mode or an_full_duplex_mode are set when
   // mr_an_complete is active, then there must have been an autonegotiation
   // error, e.g one device only supports half duplex and the other only
   // supporting full duplex.  In such cases, the host should set the RF bits
   // of the base register to 2'b11 and request restart autoneg.
   // This functionality can also be incorporated into this module if necessary.
   always@(posedge rx_clk or negedge n_reset)
   begin
      if (~n_reset)
         begin
            an_full_duplex_mode <= 1'b0;
            an_half_duplex_mode <= 1'b0;
            an_pause_tx_en <= 1'b0;
            an_pause_rx_en <= 1'b0;
         end
      else
         if (resolve_priority)
            begin

               // Resolve pause modes.
               casex ({mr_adv_ability_int[8:7], mr_lp_adv_ability[8:7]})

                  4'bx1x1:
                     begin
                        an_pause_tx_en <= 1'b1;
                        an_pause_rx_en <= 1'b1;
                     end
                  4'b1110:
                     begin
                        an_pause_tx_en <= 1'b0;
                        an_pause_rx_en <= 1'b1;
                     end
                  4'b1011:
                     begin
                        an_pause_tx_en <= 1'b1;
                        an_pause_rx_en <= 1'b0;
                     end
                  default:
                     begin
                        an_pause_tx_en <= 1'b0;
                        an_pause_rx_en <= 1'b0;
                     end
               endcase

               // Resolve duplex modes, full duplex mode has highest priority.
               if (mr_adv_ability_int[5] & mr_lp_adv_ability[5])
                  begin
                     an_full_duplex_mode <= 1'b1;
                     an_half_duplex_mode <= 1'b0;
                  end
               else
                  if (mr_adv_ability_int[6] & mr_lp_adv_ability[6])
                     begin
                        an_full_duplex_mode <= 1'b0;
                        an_half_duplex_mode <= 1'b1;
                     end
                     else
                        begin
                           an_full_duplex_mode <= 1'b0;
                           an_half_duplex_mode <= 1'b0;
                        end
            end
         else
            // At all other times when we resolve_priority is not active, we are
            // not enabling any modes since autoneg should be active.
            // Care should be taken if manual setup is used, bypassing autoneg.
            begin
               an_full_duplex_mode <= 1'b0;
               an_half_duplex_mode <= 1'b0;
               an_pause_tx_en <= 1'b0;
               an_pause_rx_en <= 1'b0;
            end
   end


endmodule
