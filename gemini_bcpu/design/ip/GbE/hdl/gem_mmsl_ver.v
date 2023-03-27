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
//   Filename:           gem_mmsl_ver.v
//   Module Name:        gem_mmsl_ver
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
//   Description :      Verification block
//
//------------------------------------------------------------------------------


module gem_mmsl_ver (
  input            tx_clk,
  input            n_txreset,
  input            tx_enable,          // Soft reset for the Transmit Side
  input            v_tx_rdy,           // Backpressure signal from TX processing block
  input            r_tx_rdy,           // Backpressure signal from TX processing block
  input            pre_enable,         // pre-emption enable
  input            disable_verify,     // Disable verification process
  input      [3:0] speed_mode,         // Specifying the speed and the Independent Interface
  input            rcv_v_set,          // Verify packet received from the Express Filter (toggle)
  input            rcv_r_set,          // Response packet received from the Express Filter (toggle)
  input            restart_ver,        // Restart verification from pclk domain (pulse)
  input            mmsl_debug_mode_tx, // Debug mode to speed up timers for verification
  input            invert_mcrc,        // MMSL register control signals
  output           verified,           // verified flag, going to tx_proc
  output           v_tx_en,            // Verify packet TX enable to TX proc block
  output           r_tx_en,            // Response packet TX enable to TX proc block
  output reg [8:0] v_txd,              // verify packet Data to TX proc block, top bit parity
  output reg       send_r,             // Strobe to signal the TX block to send a response packet
  output reg [8:0] r_txd,              // Response packet Data to Tx proc block, top bit parity
  output reg       send_v,             // Strobe to signal the TX block to send a verify packet
  output     [2:0] v_state,            // Verify  SM states to send to the status register
  output           r_state             // Respond SM states to send to the status register
);

  // -----------------------------------------------------------------------------
  // Declaration of the signals and parameters
  // -----------------------------------------------------------------------------

  parameter INIT_VERIF  = 3'b000; // Initialization
  parameter V_IDLE      = 3'b001; // Verify IDLE
  parameter SEND_VERIFY = 3'b010; // Send Verify packet
  parameter WFR         = 3'b011; // Wait For Response
  parameter VERIFIED    = 3'b100; // Verified
  parameter VERIFY_FAIL = 3'b101; // Verification Fail

  parameter R_IDLE       = 1'b0; // Respond IDLE
  parameter SEND_RESPOND = 1'b1; // Send Respond

  reg   [2:0] verify_c_state;  // Current Verify FSM state
  reg   [2:0] verify_n_state;  // Next    Verify FSM state
  reg         respond_c_state; // Current Respond FSM state
  reg         respond_n_state; // Next    Respond FSM state
  reg         rcv_v_set_reg;
  reg         rcv_r_set_reg;
  reg         rcv_r;
  reg         rcv_v;
  reg  [24:0] verify_timer_1;
  reg   [1:0] verify_cnt;
  reg   [7:0] m_v_frame_cnt;
  reg   [7:0] m_r_frame_cnt;
  reg  [24:0] verify_timer_load_val;
  reg  [24:0] verify_timer;
  wire        verify_timer_done;
  wire        verify_limit_exceed;
  wire        rcv_v_clear;
  wire        rcv_r_clear;
  wire        rcv_v_set_edge;
  wire        rcv_r_set_edge;
  wire        send_v_set;
  wire        send_r_set;
  wire        send_v_clear;
  wire        send_r_clear;
  wire        send_v_done;
  wire        send_r_done;
  wire        verify_timer_load;
  wire        verify_timer_start;
  wire        mii;
  wire  [8:0] m_v_frame_cnt_incr;
  wire  [8:0] m_r_frame_cnt_incr;

  // ============================================================================
  //  Beginning of Hardware Description
  // ============================================================================

  // Needed to know if transmitting nibbles or bytes.
  assign mii = (speed_mode[3:1] == 3'b000);

  // -----------------------------------------------------------------------------
  //  Verify timer
  // -----------------------------------------------------------------------------
  always @ (*)
  begin
    case(speed_mode)
      4'b0000 : verify_timer_load_val = 25'd25000;   // 10ms @ 2.5MHz   (10Mbps   using MII)
      4'b0001 : verify_timer_load_val = 25'd250000;  // 10ms @ 25 MHz   (100Mbps  using MII)
      4'b0010 : verify_timer_load_val = 25'd1250000; // 10ms @ 125MHz   (1Gbps    using GMII)
      4'b0100 : verify_timer_load_val = 25'd12500;   // 10ms @ 1.25MHz  (10Mbps   using SGMII)
      4'b0101 : verify_timer_load_val = 25'd125000;  // 10ms @ 12.5MHz  (100Mbps  using SGMII)
      4'b0110 : verify_timer_load_val = 25'd1250000; // 10ms @ 125MHz   (1Gbps    using SGMII)
      4'b1010 : verify_timer_load_val = 25'd3125000; // 10ms @ 312.5MHz (2.5Gbps  using GMII)
      default : verify_timer_load_val = 25'd3125000; // 10ms @ 312.5MHz (2.5Gbps  using SGMII)
    endcase
  end

  // load the timer value but if debug mode is active then we speedup the timeout event
  // by a factor of 256
  always @ (posedge tx_clk or negedge n_txreset)
  begin
  if(~n_txreset)
    verify_timer_1 <= 25'd0;
  else if(~tx_enable)
    verify_timer_1 <= 25'd0;
  else
    begin
      if(verify_timer_load)
        begin
          if(mmsl_debug_mode_tx)
            verify_timer_1 <= {8'h00,verify_timer_load_val[24:8]};
          else
            verify_timer_1 <= verify_timer_load_val;
        end
      else
        begin
          if(verify_timer_start)
            verify_timer_1 <= verify_timer_1 - 25'd1;
          else
            verify_timer_1 <= 25'd0;
        end
    end
  end

  assign verify_timer_load  = (verify_c_state == SEND_VERIFY && ~send_v);
  assign verify_timer_done  = (verify_timer   == 25'd0);
  assign verify_timer_start = (verify_c_state == WFR);

  always @ *
  begin
    if(verify_c_state == WFR)
      verify_timer = verify_timer_1;
    else
      verify_timer = 25'd0;
  end

  // -----------------------------------------------------------------------------
  //  Verify counter
  // -----------------------------------------------------------------------------
  always @ (posedge tx_clk or negedge n_txreset)
  begin
  if(~n_txreset)
    verify_cnt <= 2'd0;
  else if(~tx_enable)
    verify_cnt <= 2'd0;
  else
    begin
      if((verify_c_state == VERIFIED) || (verify_c_state == VERIFY_FAIL))
        verify_cnt <= 2'd0;
      else if(verify_c_state == WFR && verify_timer_done)
        verify_cnt <= verify_cnt + 2'd1;
    end
  end

  assign verify_limit_exceed = (verify_c_state == VERIFIED)? 1'b0:(verify_cnt > 2'd1);

  // -----------------------------------------------------------------------------
  //  Receiving the "received a Verification/Response packet" signal from RX side
  // -----------------------------------------------------------------------------
  always @ (posedge tx_clk or negedge n_txreset)
  begin
  if(~n_txreset)
    begin
      rcv_v_set_reg <= 1'b0;
      rcv_r_set_reg <= 1'b0;
    end
  else if(~tx_enable)
    begin
      rcv_v_set_reg <= 1'b0;
      rcv_r_set_reg <= 1'b0;
    end
  else
    begin
      rcv_v_set_reg <= rcv_v_set;
      rcv_r_set_reg <= rcv_r_set;
    end
  end

  assign rcv_v_set_edge = rcv_v_set_reg != rcv_v_set; //if 1 then rcv_v_set has toggled
  assign rcv_r_set_edge = rcv_r_set_reg != rcv_r_set;

  assign rcv_v_clear = ((respond_c_state == R_IDLE && rcv_v)||(verify_c_state == INIT_VERIF)||restart_ver); //if 1 we have to set to zero rcv_v
  assign rcv_r_clear = (verify_c_state == INIT_VERIF || restart_ver);

  always @ (posedge tx_clk or negedge n_txreset)
  begin
  if(~n_txreset)
    rcv_v <= 1'b0;
  else if(~tx_enable)
    rcv_v <= 1'b0;
  else
    begin
      if(rcv_v_clear)
        rcv_v <= 1'b0;
      else if(rcv_v_set_edge)
        rcv_v <= 1'b1;
    end
  end

  always @ (posedge tx_clk or negedge n_txreset)
  begin
  if(~n_txreset)
    rcv_r <= 1'b0;
  else if(~tx_enable)
    rcv_r <= 1'b0;
  else
    begin
      if(rcv_r_clear)
        rcv_r <= 1'b0;
      else if(rcv_r_set_edge)
        rcv_r <= 1'b1;
    end
  end

  // -----------------------------------------------------------------------------
  //  Generating the "send a Verification/Response packet" signal to TX side
  // -----------------------------------------------------------------------------
  assign send_v_set   = ((verify_c_state  == V_IDLE) &&          pre_enable && ~disable_verify);
  assign send_r_set   = ((respond_c_state == R_IDLE) && rcv_v && pre_enable && ~disable_verify);
  assign send_v_clear = ((verify_c_state  == INIT_VERIF) ||(verify_c_state  == SEND_VERIFY  && send_v_done));
  assign send_r_clear = ((verify_c_state  == INIT_VERIF) ||(respond_c_state == SEND_RESPOND && send_r_done));
  assign send_v_done  = ((verify_c_state  == SEND_VERIFY)  && (mii ? (m_v_frame_cnt == 8'd143) : (m_v_frame_cnt == 8'd142)));
  assign send_r_done  = ((respond_c_state == SEND_RESPOND) && (mii ? (m_r_frame_cnt == 8'd143) : (m_r_frame_cnt == 8'd142)));


  always @ (posedge tx_clk or negedge n_txreset)
  begin
  if(~n_txreset)
    send_v <= 1'b0;
  else if(~tx_enable)
    send_v <= 1'b0;
  else
    begin
      if(send_v_set)
        send_v <= 1'b1;
      else if(send_v_clear)
        send_v <= 1'b0;
    end
  end

  always @ (posedge tx_clk or negedge n_txreset)
  begin
  if(~n_txreset)
    send_r <= 1'b0;
  else if(~tx_enable)
    send_r <= 1'b0;
  else
    begin
      if(send_r_set)
        send_r <= 1'b1;
      else if(send_r_clear)
        send_r <= 1'b0;
    end
  end

  // -----------------------------------------------------------------------------
  //  Verify State Machine
  // -----------------------------------------------------------------------------
  // Sequential section
  always @ (posedge tx_clk or negedge n_txreset)
  begin
    if(~n_txreset)
      verify_c_state <= INIT_VERIF;
    else if (~tx_enable)
      verify_c_state <= INIT_VERIF;
    else
      verify_c_state <= verify_n_state;
  end

  // Combinatorial section
  always @ *
  begin
    case(verify_c_state)
      INIT_VERIF: verify_n_state = V_IDLE;
      V_IDLE:
      begin
      if(pre_enable && ~disable_verify)
        verify_n_state = SEND_VERIFY;
      else
        verify_n_state = V_IDLE;
      end
      SEND_VERIFY:
      begin
      if(~send_v)
        verify_n_state = WFR;
      else
        verify_n_state = SEND_VERIFY;
      end
      WFR:
      begin
      if(~verify_timer_done)
        begin
        if(rcv_r)
          verify_n_state = VERIFIED;
        else
          verify_n_state = WFR;
        end
      else
        begin
        if(~verify_limit_exceed)
          verify_n_state = V_IDLE;
        else
          verify_n_state = VERIFY_FAIL;
        end
      end
      VERIFIED:
      begin
      if(~pre_enable || restart_ver)
        verify_n_state = V_IDLE;
      else
        verify_n_state = VERIFIED;
      end
      default: //VERIFY_FAIL
      begin
      if(~pre_enable || restart_ver)
        verify_n_state = V_IDLE;
      else
        verify_n_state = VERIFY_FAIL;
      end
    endcase
  end

  assign verified = (verify_c_state == VERIFIED);

  // -----------------------------------------------------------------------------
  //  Respond State Machine
  // -----------------------------------------------------------------------------
  // Sequential section
  always @ (posedge tx_clk or negedge n_txreset)
  begin
    if(~n_txreset)
      respond_c_state <= R_IDLE;
    else if (~tx_enable)
      respond_c_state <= R_IDLE;
    else
      respond_c_state <= respond_n_state;
  end

  // Combinatorial section
  always @ *
  begin
    case(respond_c_state)
      R_IDLE:
      begin
      if(~rcv_v)
        respond_n_state = R_IDLE;
      else
        respond_n_state = SEND_RESPOND;
      end
      default: //SEND_RESPOND
      begin
      if(~send_r)
        respond_n_state = R_IDLE;
      else
        respond_n_state = SEND_RESPOND;
      end
    endcase
  end

  // -----------------------------------------------------------------------------
  //  m_v_Packet generator
  // -----------------------------------------------------------------------------

  assign m_v_frame_cnt_incr = m_v_frame_cnt + (mii ? 8'd1 : 8'd2);
  
  always @ (posedge tx_clk or negedge n_txreset)
  begin
  if(~n_txreset)
    m_v_frame_cnt <= 8'd0;
  else if(~tx_enable)
    m_v_frame_cnt <= 8'd0;
  else
    begin
      if(send_v_done)
        m_v_frame_cnt <= 8'd0;
      else if(v_tx_en && v_tx_rdy)
        m_v_frame_cnt <= m_v_frame_cnt_incr[7:0];
    end
  end

  assign v_tx_en = send_v;

  always @ *
  begin
    if(~v_tx_en)
      v_txd = 9'h000;
    else
      begin
        if(~v_tx_rdy)
          v_txd = 9'h055;
        else
          begin
            if(mii)
              begin
                case (m_v_frame_cnt)
                  8'd0,  8'd1,
                  8'd2,  8'd3,
                  8'd4,  8'd5,
                  8'd6,  8'd7,
                  8'd8,  8'd9,
                  8'd10, 8'd11,
                  8'd12, 8'd13  : v_txd = {1'b0,4'h0, 4'h5}; // PREAMBLE
                  8'd14         : v_txd = {1'b1,4'h0, 4'h7}; // SMD-V low
                  8'd15         : v_txd = {1'b0,4'h0, 4'h0}; // SMD-V high
                  8'd136        : v_txd = invert_mcrc? {1'b1,4'h0,4'h8}:{1'b1,4'h0,4'h7}; // MCRC byte0 low
                  8'd137        : v_txd = invert_mcrc? {1'b0,4'h0,4'h0}:{1'b0,4'h0,4'hf}; // MCRC byte0 high
                  8'd138        : v_txd = invert_mcrc? {1'b0,4'h0,4'h9}:{1'b0,4'h0,4'h6}; // MCRC byte1 low
                  8'd139        : v_txd = invert_mcrc? {1'b1,4'h0,4'h8}:{1'b1,4'h0,4'h7}; // MCRC byte1 high
                  8'd140        : v_txd = invert_mcrc? {1'b1,4'h0,4'hd}:{1'b1,4'h0,4'h2}; // MCRC byte2 low
                  8'd141        : v_txd = invert_mcrc? {1'b1,4'h0,4'he}:{1'b1,4'h0,4'h1}; // MCRC byte2 high
                  8'd142        : v_txd = invert_mcrc? {1'b1,4'h0,4'hb}:{1'b1,4'h0,4'h4}; // MCRC byte3 low
                  8'd143        : v_txd = invert_mcrc? {1'b0,4'h0,4'hf}:{1'b0,4'h0,4'h0}; // MCRC byte3 high
                  default       : v_txd = {1'b0,4'h0, 4'h0}; // PAYLOAD
                endcase
              end
            else
              begin
                case (m_v_frame_cnt)
                  8'd0,
                  8'd2,
                  8'd4,
                  8'd6,
                  8'd8,
                  8'd10,
                  8'd12         : v_txd = {1'b0,8'h55}; // PREAMBLE
                  8'd14         : v_txd = {1'b1,8'h07}; // SMD-V
                  8'd136        : v_txd = invert_mcrc? {1'b1,8'h08}:{1'b1,8'hf7}; // MCRC byte0
                  8'd138        : v_txd = invert_mcrc? {1'b1,8'h89}:{1'b1,8'h76}; // MCRC byte1
                  8'd140        : v_txd = invert_mcrc? {1'b0,8'hed}:{1'b0,8'h12}; // MCRC byte2
                  8'd142        : v_txd = invert_mcrc? {1'b1,8'hfb}:{1'b1,8'h04}; // MCRC byte3
                  default       : v_txd = {1'b0,8'h00}; // PAYLOAD
                endcase
              end
          end
     end
  end

  // -----------------------------------------------------------------------------
  //  m_r_Packet generator
  // -----------------------------------------------------------------------------
  
  assign m_r_frame_cnt_incr = m_r_frame_cnt + (mii ? 8'd1 : 8'd2);
  
  always @ (posedge tx_clk or negedge n_txreset)
  begin
  if(~n_txreset)
    m_r_frame_cnt <= 8'd0;
  else if(~tx_enable)
    m_r_frame_cnt <= 8'd0;
  else
    begin
      if(send_r_done)
        m_r_frame_cnt <= 8'd0;
      else if(r_tx_en && r_tx_rdy)
        m_r_frame_cnt <= m_r_frame_cnt_incr[7:0];
    end
  end

  assign r_tx_en = send_r;

  always @ *
  begin
    if(~r_tx_en)
      r_txd = 9'h000;
    else
      begin
        if(~r_tx_rdy)
          r_txd = 9'h055;
        else
          begin
            if(mii)
              begin
                case (m_r_frame_cnt)
                  8'd0,  8'd1,
                  8'd2,  8'd3,
                  8'd4,  8'd5,
                  8'd6,  8'd7,
                  8'd8,  8'd9,
                  8'd10, 8'd11,
                  8'd12, 8'd13  : r_txd = {1'b0,4'h0, 4'h5}; // PREAMBLE
                  8'd14         : r_txd = {1'b0,4'h0, 4'h9}; // SMD-R low
                  8'd15         : r_txd = {1'b1,4'h0, 4'h1}; // SMD-R high
                  8'd136        : r_txd = invert_mcrc? {1'b1,4'h0,4'h8}:{1'b1,4'h0,4'h7}; // MCRC byte0 low
                  8'd137        : r_txd = invert_mcrc? {1'b0,4'h0,4'h0}:{1'b0,4'h0,4'hf}; // MCRC byte0 high
                  8'd138        : r_txd = invert_mcrc? {1'b0,4'h0,4'h9}:{1'b0,4'h0,4'h6}; // MCRC byte1 low
                  8'd139        : r_txd = invert_mcrc? {1'b1,4'h0,4'h8}:{1'b1,4'h0,4'h7}; // MCRC byte1 high
                  8'd140        : r_txd = invert_mcrc? {1'b1,4'h0,4'hd}:{1'b1,4'h0,4'h2}; // MCRC byte2 low
                  8'd141        : r_txd = invert_mcrc? {1'b1,4'h0,4'he}:{1'b1,4'h0,4'h1}; // MCRC byte2 high
                  8'd142        : r_txd = invert_mcrc? {1'b1,4'h0,4'hb}:{1'b1,4'h0,4'h4}; // MCRC byte3 low
                  8'd143        : r_txd = invert_mcrc? {1'b0,4'h0,4'hf}:{1'b0,4'h0,4'h0}; // MCRC byte3 high
                  default       : r_txd = {1'b0,4'h0, 4'h0}; // PAYLOAD
                endcase
              end
            else
              begin
                case (m_r_frame_cnt)
                  8'd0,
                  8'd2,
                  8'd4,
                  8'd6,
                  8'd8,
                  8'd10,
                  8'd12         : r_txd = {1'b0,8'h55}; // PREAMBLE
                  8'd14         : r_txd = {1'b1,8'h19}; // SMD-R
                  8'd136        : r_txd = invert_mcrc? {1'b1,8'h08}:{1'b1,8'hf7}; // MCRC byte0
                  8'd138        : r_txd = invert_mcrc? {1'b1,8'h89}:{1'b1,8'h76}; // MCRC byte1
                  8'd140        : r_txd = invert_mcrc? {1'b0,8'hed}:{1'b0,8'h12}; // MCRC byte2
                  8'd142        : r_txd = invert_mcrc? {1'b1,8'hfb}:{1'b1,8'h04}; // MCRC byte3
                  default       : r_txd = {1'b0,8'h00}; // PAYLOAD
                endcase
              end
          end
     end
  end

  // Let's assign a neat name to these outputs
  assign v_state = verify_c_state;
  assign r_state = respond_c_state;

  `ifdef ABV_ON
    ///////// Assertion 4.4.1.3 ///////////////////////////////////////////////
    // Check that the verify and respond packet are initiated simultaneously
    // We will check that if the Verify State Machine is sending a v-packet,
    // if the conditions are that the respond packet has to send a r-packet,
    // then the Response FSM will go to SEND_RESPONS state independently.
    // Then we'll check the opposite: if the Respond SM is working we will check
    // that the Verify SM will work too.
    property Pr_4413_a;
    @(posedge tx_clk)

      ((v_state == SEND_VERIFY) && (rcv_v && ~send_r)) |-> (##[0:2] r_state == SEND_RESPOND);

    endproperty
    AP_Pr_4413_a : assert property (Pr_4413_a);

    property Pr_4413_b;
    @(posedge tx_clk)

      ((r_state == SEND_RESPOND) && ((pre_enable && ~disable_verify && v_state == V_IDLE))) |-> (##1 v_state == SEND_VERIFY);

    endproperty
    AP_Pr_4413_b : assert property (Pr_4413_b);

    ///////// Assertion 4.4.1.4 /////////////////////////////////////////////////////////
    // Check that on a restart verification register write, verify packets are transmitted
    // We will make sure that the FSM will go into the appropriate state when restart_ver
    // will be '1' (pulse, input to this module, coming from gem_mmsl_reg)
    property Pr_4414;
    @(posedge tx_clk)

      (restart_ver && pre_enable && ~disable_verify && (v_state == VERIFIED || v_state == VERIFY_FAIL)) |-> (##[0:2] v_state == SEND_VERIFY);

    endproperty
    AP_Pr_4414 : assert property (Pr_4414);
  `endif

endmodule
