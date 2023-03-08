//------------------------------------------------------------------------------
// Copyright (c) 2016-2019 Cadence Design Systems, Inc.
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
//   Filename:           gem_mmsl_rx_smd_decode.v
//   Module Name:        gem_mmsl_rx_smd_decode
//
//   Release Revision:   r1p12f1
//   Release SVN Tag:    gem_gxl_det0102_r1p12f1
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
//   Description :      Receive filter decoding the the non Express m-packets
//                      SMD and flagging it to the top module gem_mmsl_rx_proc
//                      and chosing the rxd_word_muxed to feed the MCRC checker
//
//------------------------------------------------------------------------------


module gem_mmsl_rx_smd_decode (

  input             rx_clk,                     // clk
  input             n_rxreset,                  // reset
  input       [3:0] n_state,                    // main FSM next    state
  input       [3:0] c_state,                    // main FSM current state
  input       [3:0] rxd_dv,                     // 16 bits vector rxd built - data valid
  input      [15:0] rxd_word,                   // 16 bits vector rxd built - data
  input             rxd_ready,                  // ready signal validating rxd_word
  input      [27:0] rxd_pipe,                   // sampled                version of rxd_word on rxd_ready
  input       [3:0] rxd_pipe_dv_extended,       // 
  input      [27:0] rxd_word_pipe_rial,         // sampled and re-aligned version of rxd_word on rxd_ready
  input       [3:0] rxd_pipe_rial_dv_extended,  //

  output reg [27:0] rxd_word_muxed,             // 16 bits vector chosen after pipe selection system
  output reg  [3:0] rxd_word_muxed_dv_extended,
  output reg  [2:0] rx_frame_cnt,               // keeps track of the frame count when packet resumes
  output reg  [2:0] c_frame_cnt,                // keeps track of the frame count when packet starts
  output reg  [2:0] rx_frag_cnt,                // keeps track of the continuation counts on a resume
  output reg  [2:0] nxt_frag_cnt,               // forecast of the next fragment count based on the previous one
  output reg        frag_count_rx_toggle,       // toggle signal for statistic registers
  output reg        rxd_is_smds_hi,             // output to the main state machine
  output reg        rxd_is_smdc_lo,             // output to the main state machine
  output            rxd_is_sfd_lo,              // output to the main state machine
  output            rxd_is_sfd_hi,              // output to the main state machine
  output            rxd_is_smdv_lo,             // output to the main state machine
  output            rxd_is_smdv_hi,             // output to the main state machine
  output            rxd_is_smdr_lo,             // output to the main state machine
  output            rxd_is_smdr_hi,             // output to the main state machine
  output            rxd_is_preamble_hi,         // output to the main state machine
  output            rxd_is_preamble_lo          // output to the main state machine

);

  // -----------------------------------------------------------------------------
  // Signals and registers declaration
  // -----------------------------------------------------------------------------
  reg        smd_chk_vld;
  reg        early_check_done;
  reg        rxd_is_preamble_lo_early;
  reg        rxd_is_preamble_hi_early;
  reg        rxd_is_smdc_lo_early;
  reg        rxd_is_smdc_hi_early;
  reg        rxd_is_smds_lo_early;
  reg        rxd_is_smds_hi_early;
  reg        rxd_is_smdv_lo_early;
  reg        rxd_is_smdr_lo_early;
  reg        rxd_is_smdv_hi_early;
  reg        rxd_is_smdr_hi_early;
  reg        rxd_is_sfd_lo_early;
  reg        rxd_is_sfd_hi_early;
  reg        rxd_is_preamble_lo_early_del;
  reg        rxd_is_preamble_hi_early_del;
  reg        rxd_is_smdc_hi_early_del;
  reg        pipe_select_hold;
  reg        pipe_select;
  wire       sfd_ok;
  wire       smdv_ok;
  wire       smdr_ok;
  wire       smds_ok;
  wire       smds_not_ok;
  wire       smdc_ok;
  wire       smdc_not_ok;
  wire       sample_pipe_select;

  parameter IDLE_N_CHECK_FOR_START  = 4'b0001;
  parameter REPLACE_SMD             = 4'b0010;
  parameter WAIT_N_CHECK_FOR_RESUME = 4'b0101;
  parameter INCREMENT_FRAG_COUNT    = 4'b0110;

  // -----------------------------------------------------------------------------
  // SMD DECODE
  // -----------------------------------------------------------------------------

  // These are the signals telling the frame has to be aligned
  assign smds_not_ok = (smd_chk_vld && rxd_is_smds_lo_early && rxd_is_preamble_hi_early_del);
  assign smdc_not_ok = (smd_chk_vld && rxd_is_smds_lo_early && rxd_is_smdc_hi_early_del && rxd_is_preamble_lo_early_del);

  // These are the signals telling the frame has not to be aligned
  assign smds_ok     = (smd_chk_vld && rxd_is_smds_hi_early && rxd_is_preamble_lo_early);
  assign smdc_ok     = (smd_chk_vld && rxd_is_smds_hi_early && rxd_is_smdc_lo_early && rxd_is_preamble_hi_early_del);

  // These are used to determine the end of the early check and hence to gate the decode machine
  assign sfd_ok      = (smd_chk_vld && ((rxd_is_preamble_hi_early_del && rxd_is_sfd_lo_early) ||(rxd_is_preamble_lo_early && rxd_is_sfd_hi_early)));
  assign smdv_ok     = (smd_chk_vld && ((rxd_is_preamble_hi_early_del && rxd_is_smdv_lo_early)||(rxd_is_preamble_lo_early && rxd_is_smdv_hi_early)));
  assign smdr_ok     = (smd_chk_vld && ((rxd_is_preamble_hi_early_del && rxd_is_smdr_lo_early)||(rxd_is_preamble_lo_early && rxd_is_smdr_hi_early)));

  // Definition of the validity window for the smd detections
  always @ *
  begin
    if(c_state == IDLE_N_CHECK_FOR_START || c_state == WAIT_N_CHECK_FOR_RESUME)
      smd_chk_vld = 1'b1;
    else
      smd_chk_vld = 1'b0;
  end

  // We need to gate the early decoder when the SMDS / SMDC, FRAG_COUNT is passed and
  // the payload started.
  always @ (posedge rx_clk or negedge n_rxreset)
  begin
    if(~n_rxreset)
      early_check_done <= 1'b0;
    else
      begin
        if(rxd_dv != 4'b1111)
          early_check_done <= 1'b0;
        else
          begin
            if(smds_ok || smds_not_ok || smdc_ok || smdc_not_ok || sfd_ok || smdv_ok || smdr_ok)
              early_check_done <= 1'b1;
          end
      end
  end

  // This block will detect the nature of the SMDS/SMDC of the packet after it has been built in a 16 bits word.
  // This vector has a valid content only when rxd_ready is 1, which is every 4 clock cycles in nibble mode,
  // every 2 clock cycles when in byte mode, and it is always valid in PCS mode.
  // This will drive the pipe select system, which will decide if we need to pass the rxd_pipe or rxd_pipe_rial
  // to the MCRC checker. (Where rxd_pipe is the registered version of rxd_word on rxd_ready=1 and rxd_pipe_rial
  // is a ri-aligned version getting the payload starting from the beginning of the 16 bits word.
  always @ *
  begin
    if(rxd_ready && ~early_check_done)
      begin
        rxd_is_preamble_lo_early = (rxd_word[7:0]  == 8'h55);
        rxd_is_preamble_hi_early = (rxd_word[15:8] == 8'h55);
        rxd_is_smdc_lo_early     = (rxd_word[7:0]  == 8'h61 || rxd_word[7:0]  == 8'h52 || rxd_word[7:0]  == 8'h9e || rxd_word[7:0]  == 8'h2a);
        rxd_is_smdc_hi_early     = (rxd_word[15:8] == 8'h61 || rxd_word[15:8] == 8'h52 || rxd_word[15:8] == 8'h9e || rxd_word[15:8] == 8'h2a);
        rxd_is_smds_lo_early     = (rxd_word[7:0]  == 8'he6 || rxd_word[7:0]  == 8'h4c || rxd_word[7:0]  == 8'h7f || rxd_word[7:0]  == 8'hb3) && 
                                   (rxd_is_preamble_hi_early_del || rxd_is_smdc_hi_early_del);
        rxd_is_smds_hi_early     = (rxd_word[15:8] == 8'he6 || rxd_word[15:8] == 8'h4c || rxd_word[15:8] == 8'h7f || rxd_word[15:8] == 8'hb3) &&
                                   (rxd_is_preamble_lo_early || rxd_is_smdc_lo_early);
        rxd_is_smdv_lo_early     = (rxd_word[7:0]  == 8'h07);
        rxd_is_smdv_hi_early     = (rxd_word[15:8] == 8'h07);
        rxd_is_smdr_lo_early     = (rxd_word[7:0]  == 8'h19);
        rxd_is_smdr_hi_early     = (rxd_word[15:8] == 8'h19);
        rxd_is_sfd_lo_early      = (rxd_word[7:0]  == 8'hd5);
        rxd_is_sfd_hi_early      = (rxd_word[15:8] == 8'hd5);
      end
    else
      begin
        rxd_is_preamble_lo_early = 1'b0;
        rxd_is_preamble_hi_early = 1'b0;
        rxd_is_smdc_lo_early     = 1'b0;
        rxd_is_smdc_hi_early     = 1'b0;
        rxd_is_smds_lo_early     = 1'b0;
        rxd_is_smds_hi_early     = 1'b0;
        rxd_is_smdv_lo_early     = 1'b0;
        rxd_is_smdv_hi_early     = 1'b0;
        rxd_is_smdr_lo_early     = 1'b0;
        rxd_is_smdr_hi_early     = 1'b0;
        rxd_is_sfd_lo_early      = 1'b0;
        rxd_is_sfd_hi_early      = 1'b0;
      end
  end

  // We need some delayed signals in order to generate the early_check_done signal
  always @ (posedge rx_clk or negedge n_rxreset)
  begin
    if(~n_rxreset)
      begin
        rxd_is_preamble_lo_early_del <= 1'd0;
        rxd_is_preamble_hi_early_del <= 1'd0;
        rxd_is_smdc_hi_early_del     <= 1'd0;
      end
    else
      begin
        if(rxd_ready)
          begin
            rxd_is_preamble_lo_early_del <= rxd_is_preamble_lo_early;
            rxd_is_preamble_hi_early_del <= rxd_is_preamble_hi_early;
            rxd_is_smdc_hi_early_del     <= rxd_is_smdc_hi_early;
          end
      end
  end

  // pipe_select is a MUX selector which will select the pipeline word to pass to the gem_stripe modules (rxd_word_muxed)
  // deciding it based whether the Payload starts in the middle of the word or not.
  // The choice is made between rxd_pipe and rxd_pipe_rial.
  // The choice is made looking at rxd_is_*_early, which is detected on rxd_word.

  assign sample_pipe_select = (smds_not_ok || smdc_not_ok || smds_ok || smdc_ok);

  always @ (posedge rx_clk or negedge n_rxreset)
  begin
    if(~n_rxreset)
      pipe_select_hold <= 1'b0;
    else if(sample_pipe_select)
      pipe_select_hold <= pipe_select;
  end

  always @ *
  begin
    if(smds_not_ok || smdc_not_ok)
      pipe_select = 1'b1;
    else
      begin
        if(smds_ok || smdc_ok)
          pipe_select = 1'b0;
        else
          pipe_select = pipe_select_hold;
      end
  end

  always @ *
  begin
    if(pipe_select)
      begin
        rxd_word_muxed             = rxd_word_pipe_rial;
        rxd_word_muxed_dv_extended = rxd_pipe_rial_dv_extended;
      end  
    else
      begin
        rxd_word_muxed             = rxd_pipe;
        rxd_word_muxed_dv_extended = rxd_pipe_dv_extended;
      end  
  end

  // We will just re-use the results from the
  // rxd_is_*_early and pipe_select decision
  // to decode the frame's header.
  always @ (posedge rx_clk or negedge n_rxreset)
  begin
    if(~n_rxreset)
      begin
        rxd_is_smds_hi  <= 1'b0;
        rxd_is_smdc_lo  <= 1'b0;
      end
    else
      begin
        if(rxd_ready)
          begin
            rxd_is_smds_hi  <= rxd_is_smds_lo_early || rxd_is_smds_hi_early;
            rxd_is_smdc_lo  <= rxd_is_smdc_lo_early || (pipe_select && rxd_is_smdc_hi_early_del);
          end
      end
  end

  assign rxd_is_preamble_hi = (rxd_word_muxed[15:8] == 8'h55);
  assign rxd_is_preamble_lo = (rxd_word_muxed[7:0]  == 8'h55);
  assign rxd_is_smdv_hi     = (rxd_word_muxed[15:8] == 8'h07);
  assign rxd_is_smdv_lo     = (rxd_word_muxed[7:0]  == 8'h07);
  assign rxd_is_smdr_hi     = (rxd_word_muxed[15:8] == 8'h19);
  assign rxd_is_smdr_lo     = (rxd_word_muxed[7:0]  == 8'h19);
  assign rxd_is_sfd_hi      = (rxd_word_muxed[15:8] == 8'hd5);
  assign rxd_is_sfd_lo      = (rxd_word_muxed[7:0]  == 8'hd5);

  // This has to decode the SMD-C of a continuation packet
  // because it has been checked that it matches with
  // c_frame_cnt, which has been set decoding the
  // SMD_S of its related start packet
  // Since it's a continuation packet we know
  // the SMD_C is in the low part of the word
  always @ *
    begin
      if(rxd_is_smdc_lo && smd_chk_vld)
        case(rxd_word_muxed[7:0])
          8'h61  : rx_frame_cnt = 3'd0;
          8'h52  : rx_frame_cnt = 3'd1;
          8'h9e  : rx_frame_cnt = 3'd2;
          default: rx_frame_cnt = 3'd3; // 8'h2a
        endcase
      else
        rx_frame_cnt = 3'd4;
  end

  // c_frame_cnt has to be set when a start packet is detected.
  // in a start packet is in the high part of the word
  always @ (posedge rx_clk or negedge n_rxreset)
  begin
    if(~n_rxreset)
      c_frame_cnt <= 3'd0;
    else
      begin
        if(rxd_is_smds_hi && ~rxd_is_smdc_lo && smd_chk_vld)
          case(rxd_word_muxed[15:8])
            8'he6  : c_frame_cnt <= 3'd0;
            8'h4c  : c_frame_cnt <= 3'd1;
            8'h7f  : c_frame_cnt <= 3'd2;
            default: c_frame_cnt <= 3'd3; // 8'hb3
          endcase
        else
          c_frame_cnt <= c_frame_cnt;
      end
  end

  // We also need to decode the FRAG_COUNT field in case of SMD-C m-frame.
  // Since we are checking on rxd_word_muxed - which is rxd_pipe[1] or rxd_pipe_rial,
  // we are sure that the FRAG_COUNT field will always be on the [15:8] of it.
  always @ *
  begin
    if(smd_chk_vld && rxd_is_smdc_lo)
      case(rxd_word_muxed[15:8])
        8'he6  : rx_frag_cnt = 3'd0;
        8'h4c  : rx_frag_cnt = 3'd1;
        8'h7f  : rx_frag_cnt = 3'd2;
        default: rx_frag_cnt = 3'd3; // 8'hb3
      endcase
    else
      rx_frag_cnt = 3'd4;
  end

  // nxt_frag_cnt implementation
  always @ (posedge rx_clk or negedge n_rxreset)
  begin
    if(~n_rxreset)
      begin
        nxt_frag_cnt         <= 3'd0;
        frag_count_rx_toggle <= 1'b0;
      end
    else
      begin
        if((n_state == IDLE_N_CHECK_FOR_START)||((c_state == WAIT_N_CHECK_FOR_RESUME) && (n_state == REPLACE_SMD)))
          begin
            nxt_frag_cnt         <= 3'd0;
            frag_count_rx_toggle <= frag_count_rx_toggle;
          end
        else if(c_state == INCREMENT_FRAG_COUNT && rxd_ready)
          begin
            frag_count_rx_toggle <= ~frag_count_rx_toggle;
            if(nxt_frag_cnt == 3'd3)
              nxt_frag_cnt <= 3'd0;
            else
              nxt_frag_cnt <= nxt_frag_cnt + 3'd1;
          end
      end
  end

endmodule
