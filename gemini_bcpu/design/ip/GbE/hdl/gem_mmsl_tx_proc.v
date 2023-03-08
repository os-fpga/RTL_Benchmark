//------------------------------------------------------------------------------
// Copyright (c) 2016-2022 Cadence Design Systems, Inc.
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
//   Filename:           gem_mmsl_tx_proc.v
//   Module Name:        gem_mmsl_tx_proc
//
//   Release Revision:   r1p12f7
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
//   Description :      TX processing block Multiplexing the pMAC and eMAC
//                      Outputs
//
//------------------------------------------------------------------------------


module gem_mmsl_tx_proc (

    input               tx_clk,
    input               n_txreset,
    input               tx_enable,            // Soft reset for the transmit side
    input               emac_tx_en,           // TX enable from the eMAC
    input               emac_tx_en_extended,  // TX enable from the eMAC, extended version
    input               emac_tx_er,           // TX error from the eMAC
    input         [7:0] emac_txd,             // TX data from the eMAC
    input               emac_txd_par,
    input               pmac_tx_en,           // TX enable from the pMAC
    input               pmac_tx_en_extended,  // TX enable from the pMAC, extended version
    input               pmac_tx_er,           // TX error from the pMAC
    input         [7:0] pmac_txd,             // TX data from the pMAC
    input               pmac_txd_par,
    input        [13:0] pmac_tx_frame_len,    // TX frame length from the pMAC
    input               send_v,               // send_v from verify block
    input               v_tx_en,              // verify mpacket GMII tx_en equivalent
    input         [7:0] v_txd,                // verify mpacket data
    input               v_txd_par,
    input               send_r,               // send_r from verify block
    input               r_tx_en,              // response mpacket GMII tx_en equivalent
    input         [7:0] r_txd,                // response mpacket data
    input               r_txd_par,
    input               hold,                 // coming from the EnST logic
    input               pre_enable,           // coming from the pclk domain
    input               disable_verify,       // coming from the pclk domain
    input               verified,             // coming from the verification block
    input         [1:0] add_frag_size,        // coming from the pclk domain
    input         [3:0] speed_mode,           // coming from the pclk domain
    input         [3:0] min_ifg,              // minimum transmit IFG divided by four
    input               invert_mcrc,          // MMSL register control signals
    output              pmac_tx_rdy,          // TX backpressure signal to the pMAC
    output              emac_tx_rdy,          // TX backpressure signal to the eMAC
    output              v_tx_rdy,             // verify mpacket backpressure to the verification block
    output              r_tx_rdy,             // response mpacket backpressure to the verification block
    output  reg         p_active,             // going to the configuration register block
    output  reg         p_active_rx,          // Version going to rx, doesn't take into accout state
    output  reg         frag_count_tx_toggle, // toggles every time a continuation packet is sent
    output  reg         tx_en,                // Driving the output
    output  reg         tx_er,                // Driving the output
    output  reg   [7:0] txd,                  // Driving the output
    output  reg         txd_par,
    output              asf_dap_mmsl_tx_err,  // Parity error

    // Lockup detection helper signals
    output  reg         e_pip,                // eMAC packet is in progress
    output  reg         p_pip,                // pMAC packet is in progress (may be halted)
    output              p_sop_gate,           // Start of packet detect gate for pMAC
    output              p_eop_gate            // End of packet detect gate for pMAC

  );

  // Configuration parameters
  parameter p_edma_asf_dap_prot = 1'b0; // Optional parity protection

  // -----------------------------------------------------------------------------
  // Declaration of the signals and parameters
  // -----------------------------------------------------------------------------

  parameter INIT_TX          = 5'b00000;
  parameter IDLE             = 5'b00001;
  parameter EXPRESS_TX       = 5'b00010;
  parameter E_TX_COMPLETE    = 5'b00011;
  parameter RESUME_WAIT      = 5'b00100;
  parameter RESUME_PREAMBLE  = 5'b00101;
  parameter SEND_SMD_C0      = 5'b00110;
  parameter SEND_SMD_C1      = 5'b00111;
  parameter SEND_FRAG_COUNT0 = 5'b01000;
  parameter SEND_FRAG_COUNT1 = 5'b01001;
  parameter PREEMPTABLE_TX   = 5'b01010;
  parameter TX_MCRC0         = 5'b01011;
  parameter TX_MCRC1         = 5'b01100;
  parameter TX_MCRC2         = 5'b01101;
  parameter TX_MCRC3         = 5'b01110;
  parameter TX_MCRC4         = 5'b01111;
  parameter TX_MCRC5         = 5'b10000;
  parameter TX_MCRC6         = 5'b10001;
  parameter TX_MCRC7         = 5'b10010;
  parameter P_TX_COMPLETE    = 5'b10011;
  parameter START_PREAMBLE   = 5'b10100;
  parameter SEND_SMD_S0      = 5'b10101;
  parameter SEND_SMD_S1      = 5'b10110;
  parameter TX_VERIFY        = 5'b10111;
  parameter TX_RESPOND       = 5'b11000;
  parameter TX_LPI           = 5'b11001;

  reg         resume_tx;
  reg         ipg_timer_load;
  reg         preemptable_frag_size;
  reg   [4:0] c_state;
  reg   [4:0] n_state;
  reg   [6:0] ipg_timer1;
  reg   [3:0] preamble_cnt_tmp;
  reg  [14:0] pmac_remain;
  reg  [16:0] frag_size;
  reg   [1:0] frame_count;
  reg   [1:0] frag_cnt;
  reg   [8:0] frag_count; // Encoded value of frag_cnt with top bit parity
  reg  [31:0] crc;
  reg   [8:0] smd_s;  // Top bit parity
  reg   [8:0] smd_c;  // Top bit parity
  wire  [6:0] ipg_timer;
  reg  [31:0] mcrc;
  wire  [7:0] mcrc_nib_par;
  wire [31:0] tx_stripe_out0;  // used for crc generation.
  wire [31:0] tx_stripe_out1;  // used for crc generation.
  wire [31:0] tx_stripe_out2;  // used for crc generation.
  wire [31:0] tx_stripe_out3;  // used for crc generation.
  wire [31:0] tx_stripe_out4;  // used for crc generation.
  wire [31:0] tx_stripe_out5;  // used for crc generation.
  wire [31:0] tx_stripe_out6;  // used for crc generation.
  wire [31:0] tx_stripe_out7;  // used for crc generation.
  wire [13:0] pmac_tx_payload_len;
  wire  [3:0] preamble_cnt;
  wire        min_remain;
  wire        ipg_timer_decr;
  wire        preamble_count_load_start;
  wire        preamble_count_load_resume;
  wire        preamble_count_go;
  wire        p_allow;
  wire        pmac_remain_load;
  wire        pmac_remain_decr;
  wire        preempt;
  wire        mii;
  wire        p_active_c;
  wire        pmac_lpi_indicate;
  wire        ipg_timer_done;
  reg         pmac_tx_en_del;
  reg         pmac_tx_en_extended_del;
  wire        p_tx_right_after_ces;
  wire        just_txed_ces_pmac;
  wire        just_txed_ces_emac;
  reg         emac_tx_en_extended_del;
  reg         emac_tx_en_del;
  wire [17:0] frag_size_incr;

  // ============================================================================
  //  Beginning of code
  // ============================================================================
  // This is needed to determine if we are transfering bytes or nibbles.
  assign mii = (speed_mode[3:1] == 3'b000);

  // -----------------------------------------------------------------------------
  // LPI signalling detection
  // -----------------------------------------------------------------------------
  // If the pMAC needs to transmit the LPI signalling then we will detect it, set
  // a signal and transmit the LPI signal as long as the pMAC is transmitting it
  assign pmac_lpi_indicate = (~pmac_tx_en && pmac_tx_er && (pmac_txd == 8'h01));

  // -----------------------------------------------------------------------------
  // interpacket gap timer
  // -----------------------------------------------------------------------------
  // The IPG doesn't have to decrement if we just finished a transmission with a
  // Carrier Extension at the end, because that would be already passed during
  // the time we transmit the Carrier Extension Signalling.
  assign just_txed_ces_pmac = (~pmac_tx_en_extended && pmac_tx_en_extended_del && ~pmac_tx_en_del);
  assign just_txed_ces_emac = (~emac_tx_en_extended && emac_tx_en_extended_del && ~emac_tx_en_del);

  always @ *
  begin
    if((c_state != RESUME_WAIT   && n_state == RESUME_WAIT)                         || // resuming
       (c_state != E_TX_COMPLETE && n_state == E_TX_COMPLETE && ~just_txed_ces_emac)|| // Express ended
       (c_state != P_TX_COMPLETE && n_state == P_TX_COMPLETE && ~just_txed_ces_pmac)|| // m-packet ended
       (c_state == TX_VERIFY     && n_state == IDLE)                                || // Verify ended
       (c_state == TX_RESPOND    && n_state == IDLE))                                  // Respond ended
      ipg_timer_load = 1'b1;
    else
      ipg_timer_load = 1'b0;
  end

  always @ (posedge tx_clk or negedge n_txreset)
  begin
    if(~n_txreset)
      ipg_timer1 <= 7'd0;
    else
      begin
        if(ipg_timer_load)
          begin
            if(~mii)
      //      ipg_timer1 <= 5'd11;
              ipg_timer1 <= (min_ifg * 4) - 7'd1;
            else
      //      ipg_timer1 <= 5'd23;
              ipg_timer1 <= (min_ifg * 8) - 7'd1;
          end
        else
          begin
            if(ipg_timer_decr)
              ipg_timer1 <= ipg_timer - 7'd1;
            else
              ipg_timer1 <= 7'd0;
          end
      end
  end

  assign ipg_timer       = (c_state == RESUME_WAIT || c_state == E_TX_COMPLETE || c_state == P_TX_COMPLETE || c_state == IDLE)? ipg_timer1 : 7'd0;
  assign ipg_timer_done  = (ipg_timer == 7'd0 && c_state != INIT_TX);
  assign ipg_timer_decr  = (c_state == RESUME_WAIT || c_state == E_TX_COMPLETE || c_state == P_TX_COMPLETE || c_state == IDLE) && ~ipg_timer_done;

  // -----------------------------------------------------------------------------
  // Preamble counter
  // -----------------------------------------------------------------------------
  always @ (posedge tx_clk or negedge n_txreset)
  begin
    if(~n_txreset)
      preamble_cnt_tmp <= 4'd0;
  else
    begin
      if(preamble_count_load_resume)
        begin
          if(~mii)
            preamble_cnt_tmp <= 4'd5;
          else
            preamble_cnt_tmp <= 4'd11;
        end
      else
        begin
          if(preamble_count_load_start)
            begin
              if(~mii)
                preamble_cnt_tmp <= 4'd6;
              else
                preamble_cnt_tmp <= 4'd13;
            end
          else if(preamble_count_go)
            preamble_cnt_tmp <= preamble_cnt_tmp - 4'd1;
        end
    end
  end

  assign preamble_count_load_resume = (n_state == RESUME_PREAMBLE && c_state != RESUME_PREAMBLE);
  assign preamble_count_load_start  = (n_state == START_PREAMBLE  && c_state != START_PREAMBLE);
  assign preamble_count_go          = (c_state == RESUME_PREAMBLE || c_state == START_PREAMBLE);
  assign preamble_cnt               = (preamble_count_go)? preamble_cnt_tmp: 4'd0;

  // -----------------------------------------------------------------------------
  // resume_tx logic
  // -----------------------------------------------------------------------------
  always @ (posedge tx_clk or negedge n_txreset)
  begin
    if(~n_txreset)
      resume_tx <= 1'b0;
    else
      begin
        if(c_state == IDLE)
          resume_tx <= 1'b0;
        else if(c_state == RESUME_WAIT)
          resume_tx <= 1'b1;
      end
  end

  // -----------------------------------------------------------------------------
  // preempt logic
  // -----------------------------------------------------------------------------
  // The signal p_active is built for the construction of the preempt signal.
  // Only update in idle state to prevent a pmac frame from being
  // fragmented after a normad SFD has been output
  // One version does not take into account the current TX state and is used to
  // switch the RX. The other version is for the local TX control and only updates
  // during idle to ensure that ongoing packets are not affected.
  assign p_active_c = pre_enable && (disable_verify || verified);

  always @ (posedge tx_clk or negedge n_txreset)
  begin
    if(~n_txreset)
      begin
        p_active    <= 1'b0;
        p_active_rx <= 1'b0;
      end
    else
      begin
        p_active_rx <= p_active_c;
        if(c_state == IDLE)
          p_active <= p_active_c;
      end
  end

  assign p_allow = (c_state == SEND_SMD_S0 || c_state == SEND_SMD_S1 || c_state == PREEMPTABLE_TX || c_state == PREEMPTABLE_TX)? p_active : 1'b0;

  // min_remain is telling if more than 64 bytes are left to transmit.
  // pmac_remain indicates the number of bytes left to transmit.
  // The length includes IPG, SMD and preamble (total = 20bytes).
  // Take this off to get actual packet length
  assign pmac_tx_payload_len = pmac_tx_frame_len - 14'd20;

  always @ (posedge tx_clk or negedge n_txreset)
  begin
    if(~n_txreset)
      pmac_remain <= 15'd0;
    else
      begin
        if(pmac_remain_load)
          begin
            if(~mii)
              pmac_remain <= {1'b0,pmac_tx_payload_len};
            else
              pmac_remain <= {pmac_tx_payload_len,1'b0};
          end
        else if(pmac_remain_decr && pmac_remain != 15'd0)
          pmac_remain <= pmac_remain - 15'd1;
      end
  end

  // pmac_remain has to be greater or equal than 65 bytes in order to preempt, because pmac_remain is actually signalling
  // the remaining bytes related to the previous byte so when signalling 64 it means that there are actually
  // 63 bytes left and it can't preempt
  assign min_remain       = (~mii) ? (pmac_remain >= 15'd65):(pmac_remain >= 15'd130);
  assign pmac_remain_load = ((n_state == PREEMPTABLE_TX) && ((c_state == SEND_SMD_S0) || (c_state == SEND_SMD_S1)));
  assign pmac_remain_decr = (c_state == PREEMPTABLE_TX);

  // frag_size: a count of the number of octets of mData transmitted in the current preemptable mPacket
  // This is counting the nibbles (4 bits).

  assign frag_size_incr = frag_size + (~mii ? 17'd2: 17'd1);

  always @ (posedge tx_clk or negedge n_txreset)
  begin
    if(~n_txreset)
      frag_size <= 17'd0;
    else
      begin
        if(n_state == IDLE || n_state == SEND_SMD_C0)
          frag_size <= 17'd0;
        else if(n_state == PREEMPTABLE_TX)
          frag_size <= frag_size_incr[16:0];
      end
  end

  // preemptable_frag_size is telling if the mPacket can be preempted
  // This depends on frag_size and add_frag_size as well, because preemptable_frag_size = 1 if frag_size >= (64*(1+add_frag_size)-4)
  always @ (*)
  begin
    case(add_frag_size)
      2'd0:     preemptable_frag_size = ((frag_size >= 17'd120) && ~frag_size[0]);
      2'd1:     preemptable_frag_size = ((frag_size >= 17'd248) && ~frag_size[0]);
      2'd2:     preemptable_frag_size = ((frag_size >= 17'd376) && ~frag_size[0]);
      default:  preemptable_frag_size = ((frag_size >= 17'd504) && ~frag_size[0]);
    endcase
  end

  assign preempt = p_allow & (emac_tx_en || hold) & preemptable_frag_size & min_remain;

  // -----------------------------------------------------------------------------
  // TX processor block FSM
  // -----------------------------------------------------------------------------
  // FSM state vector
  always @ (posedge tx_clk or negedge n_txreset)
  begin
    if(~n_txreset)
      c_state <= INIT_TX;
    else
      c_state <= n_state;
  end

  // Next state calculation
  always @ *
  begin
    case (c_state)
      INIT_TX:
      begin
      if(tx_enable)
        n_state = IDLE;
      else
        n_state = INIT_TX;
      end

      IDLE:
      begin
      if(pmac_lpi_indicate)
        n_state = TX_LPI;
      else
        begin
          if(~ipg_timer_done)
            n_state = IDLE;
          else
            begin
            if(emac_tx_en)
              n_state = EXPRESS_TX;
            else
              begin
              if(send_r)
                n_state = TX_RESPOND;
              else
                if(send_v)
                  n_state = TX_VERIFY;
                else
                  if(~hold && pmac_tx_en)
                    n_state = START_PREAMBLE;
                  else
                    n_state = IDLE;
              end
            end
        end
      end

      TX_LPI:
      begin
        if(pmac_lpi_indicate)
          n_state = TX_LPI;
        else
          n_state = IDLE;
      end

      EXPRESS_TX:
      begin
      if(emac_tx_en)
        n_state = EXPRESS_TX;
      else
        if(emac_tx_en_extended)
          n_state = EXPRESS_TX;
        else
          n_state = E_TX_COMPLETE;
      end

      E_TX_COMPLETE:
      begin
      if(resume_tx)
        n_state = RESUME_WAIT;
      else
        n_state = IDLE;
      end

      RESUME_WAIT:
      begin
      if(~ipg_timer_done)
        n_state = RESUME_WAIT;
      else
        begin
        if(emac_tx_en)
          n_state = EXPRESS_TX;
        else
          if(~hold)
            n_state = RESUME_PREAMBLE;
          else
            n_state = RESUME_WAIT;
        end
      end

      RESUME_PREAMBLE:
      begin
      if(preamble_cnt == 4'd0)
        n_state = SEND_SMD_C0;
      else
        n_state = RESUME_PREAMBLE;
      end

      SEND_SMD_C0:
      begin
      if(~mii)
        n_state = SEND_FRAG_COUNT0;
      else
        n_state = SEND_SMD_C1;
      end

      SEND_SMD_C1:
      begin
        n_state = SEND_FRAG_COUNT0;
      end

      SEND_FRAG_COUNT0:
      begin
      if(~mii)
        n_state = PREEMPTABLE_TX;
      else
        n_state = SEND_FRAG_COUNT1;
      end

      SEND_FRAG_COUNT1:
      begin
        n_state = PREEMPTABLE_TX;
      end

      PREEMPTABLE_TX:
      begin
      if(pmac_tx_en)
        begin
        if(~preempt)
          n_state = PREEMPTABLE_TX;
        else
          n_state = TX_MCRC0;
        end
      else
        begin
          if(pmac_tx_en_extended)
            n_state = PREEMPTABLE_TX;
          else
            n_state = P_TX_COMPLETE;
        end
      end

      TX_MCRC0 :
        n_state = TX_MCRC1;
      TX_MCRC1 :
        n_state = TX_MCRC2;
      TX_MCRC2 :
        n_state = TX_MCRC3;
      TX_MCRC3 :
        n_state = ~mii ? P_TX_COMPLETE : TX_MCRC4;
      TX_MCRC4 :
        n_state = TX_MCRC5;
      TX_MCRC5 :
        n_state = TX_MCRC6;
      TX_MCRC6 :
        n_state = TX_MCRC7;
      TX_MCRC7 :
        n_state = P_TX_COMPLETE;

      P_TX_COMPLETE:
      begin
      if(pmac_tx_en)
        n_state = RESUME_WAIT;
      else
        n_state = IDLE;
      end

      START_PREAMBLE:
      begin
      if(preamble_cnt == 4'd0)
        n_state = SEND_SMD_S0;
      else
        n_state = START_PREAMBLE;
      end

      SEND_SMD_S0:
      begin
      if(~mii)
        n_state = PREEMPTABLE_TX;
      else
        n_state = SEND_SMD_S1;
      end

      SEND_SMD_S1:
      begin
        n_state = PREEMPTABLE_TX;
      end

      TX_VERIFY:
      begin
      if(v_tx_en)
        n_state = TX_VERIFY;
      else
        n_state = IDLE;
      end

      default: //TX_RESPOND
      begin
      if(r_tx_en)
        n_state = TX_RESPOND;
      else
        n_state = IDLE;
      end
    endcase
  end

  // -----------------------------------------------------------------------------
  // TX backpressure signals
  // -----------------------------------------------------------------------------
  assign v_tx_rdy     =    ((~v_tx_en)||(n_state == TX_VERIFY));
  assign r_tx_rdy     =    ((~r_tx_en)||(n_state == TX_RESPOND));
  assign emac_tx_rdy  = ((~emac_tx_en)||(n_state == EXPRESS_TX));
  assign pmac_tx_rdy  = ((~pmac_tx_en)||(n_state == PREEMPTABLE_TX) ||
                                        (n_state == START_PREAMBLE) ||
                                        (n_state == SEND_SMD_S0)    ||
                                        (n_state == SEND_SMD_S1));

  // -----------------------------------------------------------------------------
  // MCRC generation
  // -----------------------------------------------------------------------------
  gem_stripe i_str_tx_0(.din         (pmac_txd[0]),
                        .stripe_in   (crc),
                        .stripe_out  (tx_stripe_out0));

  gem_stripe i_str_tx_1(.din         (pmac_txd[1]),
                        .stripe_in   (tx_stripe_out0),
                        .stripe_out  (tx_stripe_out1));

  gem_stripe i_str_tx_2(.din         (pmac_txd[2]),
                        .stripe_in   (tx_stripe_out1),
                        .stripe_out  (tx_stripe_out2));

  gem_stripe i_str_tx_3(.din         (pmac_txd[3]),
                        .stripe_in   (tx_stripe_out2),
                        .stripe_out  (tx_stripe_out3));

  gem_stripe i_str_tx_4(.din         (pmac_txd[4]),
                        .stripe_in   (tx_stripe_out3),
                        .stripe_out  (tx_stripe_out4));

  gem_stripe i_str_tx_5(.din         (pmac_txd[5]),
                        .stripe_in   (tx_stripe_out4),
                        .stripe_out  (tx_stripe_out5));

  gem_stripe i_str_tx_6(.din         (pmac_txd[6]),
                        .stripe_in   (tx_stripe_out5),
                        .stripe_out  (tx_stripe_out6));

  gem_stripe i_str_tx_7(.din         (pmac_txd[7]),
                        .stripe_in   (tx_stripe_out6),
                        .stripe_out  (tx_stripe_out7));

  always@(posedge tx_clk or negedge n_txreset)
  begin
    if (~n_txreset)
      crc <= 32'hffffffff;
    else
      if (n_state == PREEMPTABLE_TX)
        begin
          if (~mii)
            crc <= tx_stripe_out7;
          else
            crc <= tx_stripe_out3;
        end
      else if (c_state == IDLE)
        crc <= 32'hffffffff;
   end

  // The conditional assignment has not been used
  // because it causes problem in Code Coverage in
  // case the operands are not single bits like this.
  always @ *
  begin
    if(invert_mcrc)
      mcrc = crc ^ 32'hffff0000;
    else // Normal operation
      mcrc = crc ^ 32'h0000ffff;
  end

  generate if (p_edma_asf_dap_prot == 1) begin : gen_mcrc_par
    wire  [63:0]  mcrc_dat_64;  // Pad each nibble
    assign mcrc_dat_64  = {4'h0,mcrc[31:28],
                           4'h0,mcrc[27:24],
                           4'h0,mcrc[23:20],
                           4'h0,mcrc[19:16],
                           4'h0,mcrc[15:12],
                           4'h0,mcrc[11:8],
                           4'h0,mcrc[7:4],
                           4'h0,mcrc[3:0]};

    cdnsdru_asf_parity_gen_v1 #(.p_data_width(64)) i_gen_par (
      .odd_par    (1'b0),
      .data_in    (mcrc_dat_64),
      .data_out   (),
      .parity_out (mcrc_nib_par)
    );
  end else begin : gen_no_mcrc_par
    assign mcrc_nib_par = 8'd0;
  end
  endgenerate

  // -----------------------------------------------------------------------------
  // SMD_S generation
  // -----------------------------------------------------------------------------
  // The SMD_S value will be generated according to the
  // frame_count value.
  // The frame count is a modulo-4 counter which is keeping
  // track of the current m_frame being transmitted.
  // It's incrementing everytime a preemptable frame
  // is finished being transmitted and it is supposed to wrap
  // so we can just ignore the LINT warning that will be
  // generated for that.

  // When transmitting Carrier Extension Signalling it could happen
  // that the new transmission will be happening in the same clock cycle
  // the Carrier Extension finishes, so we wouldn't have the time to go
  // to P_TX_COMPLETE state and then to IDLE and update frame_count.
  // So we still need to update frame_count in this case so we will just
  // assume that the Carrier Extension will be transmitted at the end of
  // a frame (it wouldn't make sense to have a CES in the middle of a frame)
  // so the PREEMPTIBLE_TX state would go to P_TX_COMPLETE and then to IDLE
  // (and never from P_TX_COMPLETE to RESUME_WAIT). Having said that,
  // we will just update the frame_count if we detect that there's been
  // a preemptible frame transmitted right after a CES. (Carrier Extension Signalling).
  always @ (posedge tx_clk or negedge n_txreset)
  begin
    if(~n_txreset)
      begin
        pmac_tx_en_del          <= 1'b0;
        pmac_tx_en_extended_del <= 1'b0;
        emac_tx_en_del          <= 1'b0;
        emac_tx_en_extended_del <= 1'b0;
      end
    else
      begin
        pmac_tx_en_del          <= pmac_tx_en;
        pmac_tx_en_extended_del <= pmac_tx_en_extended;
        emac_tx_en_del          <= emac_tx_en;
        emac_tx_en_extended_del <= emac_tx_en_extended;
      end
  end

  assign p_tx_right_after_ces = pmac_tx_en_extended_del && pmac_tx_en && ~pmac_tx_en_del;

  always @ (posedge tx_clk or negedge n_txreset)
  begin
    if(~n_txreset)
      frame_count <= 2'd0;
    else if((((c_state == P_TX_COMPLETE) && (n_state == IDLE)) || p_tx_right_after_ces) && p_active)
      frame_count <= frame_count + 2'd1;
  end

  // Note that if pre-emption is not enabled, then as per IEEE spec, the SFD
  // is passed un-altered.
  always @ *
  begin
    if (p_active)
      case(frame_count)
        2'd0   : smd_s = {1'b1,8'he6};
        2'd1   : smd_s = {1'b1,8'h4c};
        2'd2   : smd_s = {1'b1,8'h7f};
        default: smd_s = {1'b1,8'hb3};
      endcase
    else
      smd_s = {1'b1,8'hd5};
  end

  // -----------------------------------------------------------------------------
  // SMD_C generation
  // -----------------------------------------------------------------------------
  always @ *
  begin
  case(frame_count)
    2'd0   : smd_c = {1'b1,8'h61};
    2'd1   : smd_c = {1'b1,8'h52};
    2'd2   : smd_c = {1'b1,8'h9e};
    default: smd_c = {1'b1,8'h2a};
  endcase
  end

  // -----------------------------------------------------------------------------
  // FRAG_COUNT generation
  // -----------------------------------------------------------------------------
  // The FRAG_COUNT will be generated according to the value of the
  // frag_cnt variable.
  // The FRAG_COUNT is following the SMD_C
  // frag_cmt is a modulo-4 counter that increments for each continuation fragment of the preemptable packet.
  // this is 0 in the first continuation of each preemption packet.
  // This is supposed to wrap if the number of fragments exceed 4, so ignore the LINT warnings generated by this, please.
  always @ (posedge tx_clk or negedge n_txreset)
  begin
  if(~n_txreset)
    begin
      frag_cnt             <= 2'd0;
      frag_count_tx_toggle <= 1'b0;
    end
  else
    begin
      if((n_state == IDLE && c_state == P_TX_COMPLETE) || p_tx_right_after_ces)// it means the MMSL finished sending all the fragments of the p-frame
        begin
          frag_cnt             <= 2'd0;
          frag_count_tx_toggle <= frag_count_tx_toggle;
        end
      else if(mii? n_state == SEND_FRAG_COUNT1 : n_state == SEND_FRAG_COUNT0)
        begin
          frag_cnt <= frag_cnt + 2'd1;
          frag_count_tx_toggle <= ~frag_count_tx_toggle;
        end
    end
  end

  always @ *
  begin
  case(frag_cnt)
    2'd0   : frag_count = {1'b1,8'he6};
    2'd1   : frag_count = {1'b1,8'h4c};
    2'd2   : frag_count = {1'b1,8'h7f};
    default: frag_count = {1'b1,8'hb3};
  endcase
  end

  // Packet in progress indications for lockup detection
  // These will signals will be pulled into the MII bridge for
  // lockup detect signalling back to the MAC.
  always @ (posedge tx_clk or negedge n_txreset)
  begin
    if(~n_txreset)
    begin
      e_pip <= 1'b0;
      p_pip <= 1'b0;
    end
    else
      case (n_state)
        EXPRESS_TX    : e_pip <= emac_tx_en;
        RESUME_WAIT   : e_pip <= 1'b0;
        START_PREAMBLE: p_pip <= pmac_tx_en;
        IDLE:
        begin
          e_pip <= 1'b0;
          p_pip <= 1'b0;
        end
        default:
        begin
          e_pip <= e_pip;
          p_pip <= p_pip;
        end
      endcase
  end

  // Only look at tx_en for packet start/end detection for pMAC during certain
  // state machine conditions.
  assign p_sop_gate = (n_state == START_PREAMBLE);
  assign p_eop_gate = (n_state == IDLE);

  // -----------------------------------------------------------------------------
  // Output MUX
  // -----------------------------------------------------------------------------
  always @ (posedge tx_clk or negedge n_txreset)
  begin
    if(~n_txreset)
      begin
        tx_en   <= 1'h0;
        tx_er   <= 1'h0;
        txd     <= 8'h00;
        txd_par <= 1'b0;
      end
  else
    begin
      case (n_state)
        EXPRESS_TX:
        begin
          tx_en   <= emac_tx_en;
          tx_er   <= emac_tx_er;
          txd     <= emac_txd;
          txd_par <= emac_txd_par;
        end

        TX_VERIFY:
        begin
          tx_en   <= v_tx_en;
          tx_er   <= 1'b0;
          txd     <= v_txd;
          txd_par <= v_txd_par;
        end

        TX_RESPOND:
        begin
          tx_en   <= r_tx_en;
          tx_er   <= 1'b0;
          txd     <= r_txd;
          txd_par <= r_txd_par;
        end

        START_PREAMBLE, PREEMPTABLE_TX, TX_LPI:
        begin
          tx_en   <= pmac_tx_en;
          tx_er   <= pmac_tx_er;
          txd     <= pmac_txd;
          txd_par <= pmac_txd_par;
        end

        SEND_SMD_S0:
        begin
          tx_en <= pmac_tx_en;
          tx_er <= pmac_tx_er;
          if(~mii)
          begin
            txd     <= smd_s[7:0];
            txd_par <= smd_s[8];
          end
          else
          begin
            txd     <= {4'd0, smd_s[3:0]};
            txd_par <= ^smd_s[8:4];       // Regenerate based on all other bits and parity
          end
        end

        SEND_SMD_S1:
        begin
          tx_en   <= pmac_tx_en;
          tx_er   <= pmac_tx_er;
          txd     <= {4'd0, smd_s[7:4]};
          txd_par <= ^{smd_s[8],smd_s[3:0]};
        end

        TX_MCRC0 :
        begin
          tx_en <= 1'b1;
          tx_er <= 1'b0;
          if(~mii)
          begin
            txd     <= {mcrc[24],mcrc[25],mcrc[26],mcrc[27],
                        mcrc[28],mcrc[29],mcrc[30],mcrc[31]};
            txd_par <= ^mcrc_nib_par[7:6];
          end
          else
          begin
            txd     <= {4'd0, mcrc[28],mcrc[29],mcrc[30],mcrc[31]};
            txd_par <= mcrc_nib_par[7];
          end
        end

        TX_MCRC1 :
        begin
          tx_en <= 1'b1;
          tx_er <= 1'b0;
          if(~mii)
          begin
            txd     <= {mcrc[16],mcrc[17],mcrc[18],mcrc[19],
                        mcrc[20],mcrc[21],mcrc[22],mcrc[23]};
            txd_par <= ^mcrc_nib_par[5:4];
          end
          else
          begin
            txd     <= {4'd0, mcrc[24],mcrc[25],mcrc[26],mcrc[27]};
            txd_par <= mcrc_nib_par[6];
          end
        end

        TX_MCRC2 :
        begin
          tx_en <= 1'b1;
          tx_er <= 1'b0;
          if(~mii)
          begin
            txd     <= {mcrc[8],mcrc[9],mcrc[10],mcrc[11],
                        mcrc[12],mcrc[13],mcrc[14],mcrc[15]};
            txd_par <= ^mcrc_nib_par[3:2];
          end
          else
          begin
            txd     <= {4'd0, mcrc[20],mcrc[21],mcrc[22],mcrc[23]};
            txd_par <= mcrc_nib_par[5];
          end
        end

        TX_MCRC3 :
        begin
          tx_en <= 1'b1;
          tx_er <= 1'b0;
          if(~mii)
          begin
            txd     <= {mcrc[0],mcrc[1],mcrc[2],mcrc[3],
                        mcrc[4],mcrc[5],mcrc[6],mcrc[7]};
            txd_par <= ^mcrc_nib_par[1:0];
          end
          else
          begin
            txd     <= {4'd0, mcrc[16],mcrc[17],mcrc[18],mcrc[19]};
            txd_par <= mcrc_nib_par[4];
          end
        end

        TX_MCRC4 :
        begin
          tx_en   <= 1'b1;
          tx_er   <= 1'b0;
          txd     <= {4'd0, mcrc[12],mcrc[13],mcrc[14],mcrc[15]};
          txd_par <= mcrc_nib_par[3];
        end

        TX_MCRC5 :
        begin
          tx_en   <= 1'b1;
          tx_er   <= 1'b0;
          txd     <= {4'd0, mcrc[8],mcrc[9],mcrc[10],mcrc[11]};
          txd_par <= mcrc_nib_par[2];
        end

        TX_MCRC6 :
        begin
          tx_en   <= 1'b1;
          tx_er   <= 1'b0;
          txd     <= {4'd0, mcrc[4],mcrc[5],mcrc[6],mcrc[7]};
          txd_par <= mcrc_nib_par[1];
        end

        TX_MCRC7 :
        begin
          tx_en   <= 1'b1;
          tx_er   <= 1'b0;
          txd     <= {4'd0, mcrc[0],mcrc[1],mcrc[2],mcrc[3]};
          txd_par <= mcrc_nib_par[0];
        end

        RESUME_PREAMBLE:
        begin
          tx_en   <= pmac_tx_en;
          tx_er   <= pmac_tx_er;
          txd     <= 8'h55;
          txd_par <= 1'b0;
        end

        SEND_SMD_C0:
        begin
          tx_en <= pmac_tx_en;
          tx_er <= pmac_tx_er;
          if(~mii)
          begin
            txd     <= smd_c[7:0];
            txd_par <= smd_c[8];
          end
          else
          begin
            txd     <= {4'd0, smd_c[3:0]};
            txd_par <= ^smd_c[8:4];       // Regenerate from all other fields
          end
        end

        SEND_SMD_C1:
        begin
          tx_en    <= pmac_tx_en;
          tx_er    <= pmac_tx_er;
          txd      <= {4'd0, smd_c[7:4]};
          txd_par  <= ^{smd_c[8],smd_c[3:0]};
        end

        SEND_FRAG_COUNT0:
        begin
          tx_en <= pmac_tx_en;
          tx_er <= pmac_tx_er;
          if(~mii)
          begin
            txd      <= frag_count[7:0];
            txd_par  <= frag_count[8];
          end
          else
          begin
            txd      <= {4'd0, frag_count[3:0]};
            txd_par  <= ^frag_count[8:4];  // Regenerate from all other bits
          end
        end

        SEND_FRAG_COUNT1:
        begin
          tx_en    <= pmac_tx_en;
          tx_er    <= pmac_tx_er;
          txd      <= {4'd0, frag_count[7:4]};
          txd_par  <= ^{frag_count[8],frag_count[3:0]};
        end

        default:
        begin
          tx_en    <= 1'b0;
          tx_er    <= 1'b0;
          txd      <= 8'd0;
          txd_par  <= 1'b0;
        end
      endcase
    end
  end

  // Optional ASF parity checker
  generate if (p_edma_asf_dap_prot == 1) begin : gen_par_chk
    cdnsdru_asf_parity_check_v1 #(.p_data_width(8)) i_par_chk (
      .odd_par    (1'b0),
      .data_in    (txd),
      .parity_in  (txd_par),
      .parity_err (asf_dap_mmsl_tx_err)
    );
  end else begin : gen_no_par_chk
    assign asf_dap_mmsl_tx_err  = 1'b0;
  end
  endgenerate

endmodule
