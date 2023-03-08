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
//   Filename:           gem_mmsl_rx_exp_flt.v
//   Module Name:        gem_mmsl_rx_exp_flt
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
//   Description :      Receive filter processing the Express, Verify and
//                      response m-packets
//
//------------------------------------------------------------------------------


module gem_mmsl_rx_exp_flt (

  input               rx_clk,
  input               n_rxreset,
  input               rx_enable,        // Soft reset for the receive side

  // MII inputs
  input               rx_dv,            // RX data valid
  input               rx_dv_extended,   // RX data valid extended
  input               rx_er,            // RX error
  input       [7:0]   rxd,              // RX data
  input               rxd_par,

  // PCS inputs
  input       [1:0]   rx_dv_pcs,         // RX data valid from PCS
  input       [1:0]   rx_dv_pcs_extended,// RX data valid from PCS extended
  input       [1:0]   rx_er_pcs,         // RX error from PCS
  input      [15:0]   rxd_pcs,           // RX data from PCS
  input       [1:0]   rxd_par_pcs,

  input               invert_mcrc,      // Coming from MMSL configuration register
  input       [3:0]   speed_mode,       // speed mode from registers
  output              rcv_v_err_toggle, // Receive Verify packet error flag
  output              rcv_r_err_toggle, // Receive Response packet error flag
  output reg          rcv_v_set,        // Received Verify packet (toggle)
  output reg          rcv_r_set,        // Received Response packet (toggle)

  // Output to the eMAC - non PCS
  output reg          emac_rx_dv,       // RX data valid to the eMAC
  output reg          emac_rx_er,       // TX error to the eMAC
  output reg  [7:0]   emac_rxd,         // RX data to the eMAC
  output reg          emac_rxd_par,

  // Outputs to the pMAC - PCS
  output reg  [1:0]   emac_rx_dv_pcs,   // RX data valid to eMAC - PCS
  output reg  [1:0]   emac_rx_er_pcs,   // RX error to eMAC - PCS
  output reg [15:0]   emac_rxd_pcs,     // RX data to eMAC - PCS
  output reg  [1:0]   emac_rxd_par_pcs,

  // ASF error signalling
  output              asf_dap_mmsl_rx_err

);

  // -----------------------------------------------------------------------------
  // Declaration of the signals and parameters
  // -----------------------------------------------------------------------------

  reg [15:0] buf_data;
  reg  [3:0] buf_par;
  reg  [3:0] buf_dv;
  reg  [3:0] buf_dv_extended;
  reg  [3:0] buf_er;
  reg  [7:0] ver_len_cnt;
  reg  [3:0] c_state;
  reg  [3:0] n_state;
  reg        mcrc_err_del;
  reg        rxd_is_preamble;
  reg        rxd_is_sfd;
  reg        rxd_is_smdv;
  reg        rxd_is_smdr;
  reg        rxd_is_sfd_lo;   // detected an SFD   in the 8 LSB bits of the 16 bits word from PCS
  reg        rxd_is_sfd_hi;   // detected an SFD   in the 8 MSB bits of the 16 bits word from PCS
  reg        rxd_is_smdv_lo;  // detected an SMD-V in the 8 LSB bits of the 16 bits word from PCS
  reg        rxd_is_smdv_hi;  // detected an SMD-V in the 8 MSB bits of the 16 bits word from PCS
  reg        rxd_is_smdr_lo;  // detected an SMD-R in the 8 LSB bits of the 16 bits word from PCS
  reg        rxd_is_smdr_hi;  // detected an SMD-R in the 8 MSB bits of the 16 bits word from PCS
  reg        mcrc_err;
  reg        len_ok_del;
  reg        lower_dv;
  reg        lower_er;
  reg  [7:0] lower_data;
  reg [31:0] mcrc;
  wire       data_8in16;
  wire       data_16;
  wire       data_4;
  wire       len_ok;
  wire       mcrc_chk_active;
  wire       rcv_v_err;
  wire       rcv_r_err;
  wire [7:0] rxd_built;
  wire [3:0] buf_data_pipe2;
  wire       buf_dv_pipe2;
  wire       buf_dv_pipe2_extended;
  wire       buf_er_pipe2;
  wire       rx_mcrc_ok;
  wire [8:0] ver_len_cnt_incr;

  parameter p_edma_asf_dap_prot = 1'b0;  // Optional parity protection

  parameter INIT_EF                   = 4'b0000;
  parameter IDLE_N_CHECK_FOR_EXPRESS0 = 4'b0001;
  parameter CHECK_FOR_EXPRESS1        = 4'b0010;
  parameter FORWARD_PREAMBLE0         = 4'b0011;
  parameter FORWARD_PREAMBLE1         = 4'b0100;
  parameter SFD0                      = 4'b0101;
  parameter SFD1                      = 4'b0110;
  parameter E_RECEIVE_DATA            = 4'b0111;
  parameter E_RECEIVE_DATA_NBUFF      = 4'b1000;
  parameter RCV_V                     = 4'b1001;
  parameter V_MCRC_OK                 = 4'b1010;
  parameter RCV_R                     = 4'b1011;
  parameter R_MCRC_OK                 = 4'b1100;
  parameter NOT_EXPRESS               = 4'b1101;

  // ============================================================================
  //  Beginning of code
  // ============================================================================
  // On RX side, we are receiving nibbles if the 10Mbps or 100Mbps are set
  // (speed_mode == 4'b0000 or speed_mode = 4'b0001), while we receive
  // a 16 bits word if also the tbi bit is enabled (speed_mode[2]), and in
  // particular, this is a 8 bits word doubled on the upper part of the
  // 16 bits word if tbi is enabled on 10/100Mbps mode (data_8in16),
  // and a full-information 16 bits word if tbi is enabled
  // on the gigabit/two_pt_five_gig mode (data_16)
  assign data_4     = (speed_mode[3:1] == 3'b000);
  assign data_16    = (speed_mode[2:1] == 2'b11);
  assign data_8in16 = (speed_mode[3:1] == 3'b010);

  // -----------------------------------------------------------------------------
  // Finite State Machine
  // -----------------------------------------------------------------------------
  // FSM state vector
  always @ (posedge rx_clk or negedge n_rxreset)
  begin
    if(~n_rxreset)
      c_state <= INIT_EF;
    else
      c_state <= n_state;
  end

  // Next state calculation
  always @ *
  begin
    case(c_state)
      // We want to exit from this state using
      // the extended data valid condition because
      // this is the state in which we go after
      // receiving a NOT_EXPRESS packet, and we
      // want to stay here until the Carrier Extend
      // Signalling is finished (if there's one)
      INIT_EF:
      begin
        if(rx_enable)
          begin
            if(~(data_16||data_8in16))
              begin
                if(rx_dv_extended)
                  n_state = INIT_EF;
                else
                  n_state = IDLE_N_CHECK_FOR_EXPRESS0;
              end
            else
              begin
                if(|rx_dv_pcs_extended)
                  n_state = INIT_EF;
                else
                  n_state = IDLE_N_CHECK_FOR_EXPRESS0;
              end
          end
        else
          n_state = INIT_EF;
      end

      IDLE_N_CHECK_FOR_EXPRESS0:
      begin
        if(data_4) // if 4 bits data
          begin
            if(rx_dv && ~buf_dv[0])
              n_state = IDLE_N_CHECK_FOR_EXPRESS0;
            else
              begin
                if(rx_dv)
                  n_state = CHECK_FOR_EXPRESS1;
                else
                  n_state = IDLE_N_CHECK_FOR_EXPRESS0;
              end
          end
        else
          begin
            if(~(data_16||data_8in16)) // if 8 bits data
              begin
                if(rx_dv)
                  begin
                    begin
                      if(rxd_is_preamble)
                        n_state = IDLE_N_CHECK_FOR_EXPRESS0;
                      else
                        begin
                          if(rxd_is_sfd)
                            n_state = E_RECEIVE_DATA;
                          else
                            begin
                              if(rxd_is_smdv)
                                n_state = RCV_V;
                              else
                                begin
                                  if(rxd_is_smdr)
                                    n_state = RCV_R;
                                  else
                                    n_state = NOT_EXPRESS;
                                end
                            end
                        end
                    end
                  end
                else
                  n_state = IDLE_N_CHECK_FOR_EXPRESS0;
              end
            else // receiving 16 bits data
              begin
                if(|rx_dv_pcs)
                  begin
                    begin
                      if(rxd_is_preamble)
                        n_state = IDLE_N_CHECK_FOR_EXPRESS0;
                      else
                        begin
                          if(rxd_is_sfd_lo || rxd_is_sfd_hi) // these two exclude each other
                            begin
                              if(rxd_is_sfd_lo)
                                n_state = E_RECEIVE_DATA;
                              else //if(rxd_is_sfd_hi)
                                n_state = E_RECEIVE_DATA_NBUFF;
                            end
                          else
                            begin
                              if(rxd_is_smdv_lo || rxd_is_smdv_hi)
                                n_state = RCV_V;
                              else
                                begin
                                  if(rxd_is_smdr_lo || rxd_is_smdr_hi)
                                    n_state = RCV_R;
                                  else
                                    n_state = NOT_EXPRESS;
                                end
                            end
                        end
                    end
                  end
                else
                  n_state = IDLE_N_CHECK_FOR_EXPRESS0;
              end
          end
      end

      CHECK_FOR_EXPRESS1:
      begin
        if(rxd_is_preamble)
          n_state = IDLE_N_CHECK_FOR_EXPRESS0;
        else
          begin
            if(rxd_is_sfd)
              n_state = FORWARD_PREAMBLE0;
            else
              begin
                if(rxd_is_smdv)
                  n_state = RCV_V;
                else
                  if(rxd_is_smdr)
                    n_state = RCV_R;
                  else
                    n_state = NOT_EXPRESS;
              end
          end
      end

      FORWARD_PREAMBLE0: n_state = FORWARD_PREAMBLE1;
      FORWARD_PREAMBLE1: n_state = SFD0;
      SFD0:              n_state = SFD1;
      SFD1:              n_state = E_RECEIVE_DATA;
      
      // We will use the data valid extended here to exit from
      // the RECEIVE_DATA states, as it needs to appear that 
      // the carrier extension signaling is the continuation
      // of the normal frame.
      E_RECEIVE_DATA:
      begin
        if(~(data_16||data_8in16))
          begin
            if(data_4)
              begin
                if(~buf_dv_pipe2_extended)
                  n_state = IDLE_N_CHECK_FOR_EXPRESS0;
                else
                  n_state = E_RECEIVE_DATA;
              end
            else
              begin
                if(~buf_dv_extended[0])
                  n_state = IDLE_N_CHECK_FOR_EXPRESS0;
                else
                  n_state = E_RECEIVE_DATA;
              end
          end
        else
          begin
            if(buf_dv_extended[1:0] == 2'b00)
              n_state = IDLE_N_CHECK_FOR_EXPRESS0;
            else
              n_state = E_RECEIVE_DATA;
          end
      end

      E_RECEIVE_DATA_NBUFF:
      begin
        if(rx_dv_pcs_extended == 2'b00)
          n_state = IDLE_N_CHECK_FOR_EXPRESS0;
        else
          n_state = E_RECEIVE_DATA_NBUFF;
      end

      RCV_V:
      begin
        if(rx_mcrc_ok)
          n_state = V_MCRC_OK;
        else
          begin
            if(mcrc_err_del || len_ok_del)
              n_state = INIT_EF;
            else
              begin
                if(data_16||data_8in16)
                  begin
                    if(buf_dv[1:0] == 2'b00)
                      n_state = IDLE_N_CHECK_FOR_EXPRESS0;
                    else
                      n_state = RCV_V;
                  end
                else
                  begin
                    if(data_4)
                      begin
                        if(~buf_dv_pipe2)
                          n_state = IDLE_N_CHECK_FOR_EXPRESS0;
                        else
                          n_state = RCV_V;
                      end
                    else // 8 bits data
                      begin
                        if(~buf_dv[0])
                          n_state = IDLE_N_CHECK_FOR_EXPRESS0;
                        else
                          n_state = RCV_V;
                      end
                  end
              end
          end
      end

      RCV_R:
      begin
        if(rx_mcrc_ok)
          n_state = R_MCRC_OK;
        else
          begin
            if(mcrc_err_del || len_ok_del)
              n_state = INIT_EF;
            else
              begin
                if(data_16||data_8in16)
                  begin
                    if(buf_dv[1:0] == 2'b00)
                      n_state = IDLE_N_CHECK_FOR_EXPRESS0;
                    else
                      n_state = RCV_R;
                  end
                else
                  begin
                    if(data_4)
                      begin
                        if(~buf_dv_pipe2)
                          n_state = IDLE_N_CHECK_FOR_EXPRESS0;
                        else
                          n_state = RCV_R;
                      end
                    else
                      begin
                        if(~buf_dv[0])
                          n_state = IDLE_N_CHECK_FOR_EXPRESS0;
                        else
                          n_state = RCV_R;
                      end
                  end
              end
          end
      end

      V_MCRC_OK,
      R_MCRC_OK: n_state = IDLE_N_CHECK_FOR_EXPRESS0;

      default: n_state = INIT_EF; //NOT_EXPRESS

    endcase
  end

  // FSM Outputs - producing toggles for the Receive of the V/R m-frames
  always @ (posedge rx_clk or negedge n_rxreset)
  begin
    if(~n_rxreset)
      begin
        rcv_v_set <= 1'b0;
        rcv_r_set <= 1'b0;
      end
    else
      begin
        if(n_state == V_MCRC_OK)
          rcv_v_set <= ~rcv_v_set;
        else if(n_state == R_MCRC_OK)
          rcv_r_set <= ~rcv_r_set;
      end
  end

  // Producing the errors for the V/R m-packet receiving process
  assign rcv_v_err = (((n_state != RCV_V) && (n_state != V_MCRC_OK)) && (c_state == RCV_V));
  assign rcv_r_err = (((n_state != RCV_R) && (n_state != R_MCRC_OK)) && (c_state == RCV_R));

  // Generating the toggle signal for rcv_v_err
  edma_toggle_generate i_rcv_v_err_toggle (
  .clk    (rx_clk),
  .reset_n(n_rxreset),
  .din    (rcv_v_err),
  .dout   (rcv_v_err_toggle)
  );

  // Generating the toggle signal for rcv_r_err
  edma_toggle_generate i_rcv_r_err_toggle (
  .clk    (rx_clk),
  .reset_n(n_rxreset),
  .din    (rcv_r_err),
  .dout   (rcv_r_err_toggle)
  );

  // -----------------------------------------------------------------------------
  // BUFFER
  // -----------------------------------------------------------------------------
  // 2 clock cycles delayed data for nibbles transmission, because it needs
  // 2 clock cycles to forward the preamble in this case and 2 to forward the
  // SFD
  always @ (posedge rx_clk or negedge n_rxreset)
  begin
    if(~n_rxreset)
      begin
        buf_data        <= 16'h0000;
        buf_par         <= 4'h0;
        buf_dv          <= 4'h0;
        buf_dv_extended <= 4'h0;
        buf_er          <= 4'h0;
      end
    else
      begin
        if(data_16 || data_8in16)
          begin
            buf_data        <= rxd_pcs;
            buf_par         <= {2'b00,rxd_par_pcs};
            buf_dv          <= {2'b00,rx_dv_pcs};
            buf_dv_extended <= {2'b00,rx_dv_pcs_extended};
            buf_er          <= {2'b00,rx_er_pcs};
          end
        else
          begin
            if(data_4)
              begin
                buf_data        <= {buf_data[11:0],rxd[3:0]};
                buf_par         <= {buf_par  [2:0],rxd_par};
                buf_dv          <= {buf_dv   [2:0],rx_dv};
                buf_dv_extended <= {buf_dv_extended[2:0],rx_dv_extended};
                buf_er          <= {buf_er   [2:0],rx_er};
              end
            else // 8 bits
              begin
                buf_data        <= {8'h00,rxd};
                buf_par         <= {3'h0,rxd_par};
                buf_dv          <= {3'd0,rx_dv};
                buf_dv_extended <= {3'd0,rx_dv_extended};
                buf_er          <= {3'd0,rx_er};
              end
          end
      end
  end

  assign buf_data_pipe2        = buf_data[15:12];
  assign buf_dv_pipe2          = buf_dv[3];
  assign buf_dv_pipe2_extended = buf_dv_extended[3];
  assign buf_er_pipe2          = buf_er[3];

  // -----------------------------------------------------------------------------
  // MCRC CHK
  // -----------------------------------------------------------------------------
  // First of all we have to get the length of the verify/response packet
  // We have to consider we don't forward any of the preamble and SMD-V/R
  // once we detected the nature of the packet. We just receive the payload
  // until the end because we need to check the MCRC at the end to flag if
  // the packet is valid or not
    
  assign ver_len_cnt_incr = ver_len_cnt + ((rx_dv_pcs == 2'b11) ? 8'd2 : 8'd1);
  
  always @ (posedge rx_clk or negedge n_rxreset)
  begin
    if (~n_rxreset)
      ver_len_cnt <= 8'd0;
    else
      if(data_16)
        begin
          if ((c_state == IDLE_N_CHECK_FOR_EXPRESS0) && (rxd_is_smdv_lo || rxd_is_smdr_lo))
            ver_len_cnt <= 8'd1; // because 1 Payload byte has been received right after the SMD in this case
          else
            begin
              if ((c_state == RCV_V) || (c_state == RCV_R))
                begin
                  if(rx_dv_pcs != 2'b00)
                    ver_len_cnt <= ver_len_cnt_incr[7:0]; //counting the bytes
                  else
                    ver_len_cnt <= 8'd0;
                end
              else
                ver_len_cnt <= 8'd0;
            end
        end
      else // not data_16; if mii it will count the double of the length.
        begin
          if ((c_state == RCV_V) || (c_state == RCV_R))
            begin
              if((data_8in16? rx_dv_pcs[0]!= 1'b0: rx_dv != 1'b0))
                ver_len_cnt <= ver_len_cnt + 8'd1;
              else
                ver_len_cnt <= 8'd0;
            end
          else
            ver_len_cnt <= 8'd0;
        end
  end

  // mcrc_chk_active is the period in which the check on the MCRC has to be done
  // len_ok is the moment in which the length of the verify/response packet should be
  // finished.
  assign len_ok          = data_4 ? (ver_len_cnt == 8'd127) : (ver_len_cnt == 8'd64);
  assign mcrc_chk_active = ((c_state == RCV_V) && (n_state != V_MCRC_OK)) ||
                           ((c_state == RCV_R) && (n_state != R_MCRC_OK)) ||
                            (c_state == IDLE_N_CHECK_FOR_EXPRESS0) || (c_state == CHECK_FOR_EXPRESS1);


  // Now we have to check the MCRC for the Verify and Response Packet.
  // Note that the MCRC should be the following
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  // mcrc_parts       mcrc[31:24], mcrc[23:16], mcrc[15:8], mcrc[7:0]                                                   //
  // invert_mcrc = 1     08            89          ed        fb                                                         //
  // invert_mcrc = 0     f7            76          12        04                                                         //
  //                                                                                                                    //
  // mcrc_parts       mcrc[31:28], mcrc[27:24], mcrc[23:20], mcrc[19:16], mcrc[15:12], mcrc[11:8], mcrc[7:4], mcrc[3:0] //
  // invert_mcrc = 1     0             8             8           9           e           d           f           b      //
  // invert_mcrc = 0     f             7             7           6           1           2           0           4      //
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  // the ver_len_cnt could count odd or even numbers, depending if
  // rxd_is_smdv_lo || rxd_is_smdr_lo has been detected in CHECK_FOR_EXPRESS0

  always @ *
  begin
    if(invert_mcrc)
      mcrc = 32'h0889edfb;
    else
      mcrc = 32'hf7761204;
  end

  always @ *
  begin
    if(data_8in16)
      begin
        lower_data = rxd_pcs[7:0];
        lower_dv   = rx_dv_pcs_extended[0];
        lower_er   = rx_er_pcs[0];
      end
    else
      begin
        lower_data = rxd;
        lower_dv   = rx_dv_extended;
        lower_er   = rx_er;
      end
  end

  always @ *
  begin
    if(data_16) // 16 bits datapath from PCS
      begin
        mcrc_err = (((c_state == IDLE_N_CHECK_FOR_EXPRESS0) && (rxd_is_smdv_lo || rxd_is_smdr_lo) && (rxd_pcs[15:8] != 8'h00)) ||
                   ((c_state != IDLE_N_CHECK_FOR_EXPRESS0)  && (ver_len_cnt <= 8'd58) && (rxd_pcs != 16'h0000))                ||
                   ((ver_len_cnt == 8'd59) && (rxd_pcs      != {mcrc[31:24],     8'h00})) || //0800   |   f700
                   ((ver_len_cnt == 8'd60) && (rxd_pcs      != {mcrc[23:16],mcrc[31:24]}))|| //8908   |   76f7
                   ((ver_len_cnt == 8'd61) && (rxd_pcs      != {mcrc[15:8] ,mcrc[23:16]}))|| //ed89   |   1276
                   ((ver_len_cnt == 8'd62) && (rxd_pcs      != {mcrc[7:0]  ,mcrc[15:8]})) || //fbed   |   0412
                   ((ver_len_cnt == 8'd63) && (rxd_pcs[7:0] != {mcrc[7:0]}))||               //fb     |   04
                   ((ver_len_cnt == 8'd64) && (rx_dv_pcs == 2'b11))||                        //invert | non-invert
                   ((ver_len_cnt == 8'd65) && (rx_dv_pcs == 2'b11))||
                   ((rx_dv_pcs == 2'b11)   && |rx_er_pcs)  ||
                   ((rx_dv_pcs == 2'b01)   && rx_er_pcs[0])||
                   ((rx_dv_pcs == 2'b10)   && rx_er_pcs[1])) &&
                   (mcrc_chk_active);
      end
    else
      begin
        if(data_4) // 4 bits datapath from MII
          begin
            mcrc_err = (((c_state != IDLE_N_CHECK_FOR_EXPRESS0) && (c_state != CHECK_FOR_EXPRESS1) && (ver_len_cnt <= 8'd118) && (rxd[3:0] != 4'h0)) ||
                       ((ver_len_cnt == 8'd119) && (rxd[3:0] != mcrc[27:24]))||             //8      |    7
                       ((ver_len_cnt == 8'd120) && (rxd[3:0] != mcrc[31:28]))||             //0      |    f
                       ((ver_len_cnt == 8'd121) && (rxd[3:0] != mcrc[19:16]))||             //9      |    6
                       ((ver_len_cnt == 8'd122) && (rxd[3:0] != mcrc[23:20]))||             //8      |    7
                       ((ver_len_cnt == 8'd123) && (rxd[3:0] != mcrc[11:8])) ||             //d      |    2
                       ((ver_len_cnt == 8'd124) && (rxd[3:0] != mcrc[15:12]))||             //e      |    1
                       ((ver_len_cnt == 8'd125) && (rxd[3:0] != mcrc[3:0]))  ||             //b      |    4
                       ((ver_len_cnt == 8'd126) && (rxd[3:0] != mcrc[7:4]))  ||             //f      |    0
                       ((ver_len_cnt == 8'd127) && rx_dv) || rx_er) && (mcrc_chk_active);   //invert | non-invert
          end
        else // 8bits datapath from GMII or 8 bits from PCS with the upper 8bits duplicated.
          begin
            mcrc_err = (((c_state != IDLE_N_CHECK_FOR_EXPRESS0) && (ver_len_cnt <= 8'd59) && (lower_data != 8'h00)) ||
                       ((ver_len_cnt == 8'd60) && (lower_data != mcrc[31:24]))|| //08     /   f7
                       ((ver_len_cnt == 8'd61) && (lower_data != mcrc[23:16]))|| //89     /   76
                       ((ver_len_cnt == 8'd62) && (lower_data != mcrc[15:8])) || //ed     /   12
                       ((ver_len_cnt == 8'd63) && (lower_data != mcrc[7:0]))  || //fb     /   04
                       ((ver_len_cnt == 8'd64) && lower_dv) ||                   //invert / non-invert
                       lower_er) &&
                       (mcrc_chk_active);
          end
      end
  end

  always @ (posedge rx_clk or negedge n_rxreset)
  begin
    if(~n_rxreset)
      mcrc_err_del <= 1'b0;
    else
      mcrc_err_del <= mcrc_err;
  end

  always @ (posedge rx_clk or negedge n_rxreset)
  begin
    if(~n_rxreset)
      len_ok_del <= 1'b0;
    else
      len_ok_del <= len_ok;
  end

  // Generate the rx_mcrc_ok signal starting from mcrc_err
  assign rx_mcrc_ok = ~mcrc_err_del && len_ok_del;

  // -----------------------------------------------------------------------------
  // SMD DECODE
  // -----------------------------------------------------------------------------

  // Building the signal from the 2 nibbles received, in case of data_4 mode
  assign rxd_built = {buf_data[3:0], buf_data[7:4]};

  // Combinatorial block for the detection of the preamble / SMD
  always @ *
  begin
    if (data_4) // receiving nibbles from MII
      begin
        rxd_is_sfd      = (rxd_built == 8'hd5);
        rxd_is_smdv     = (rxd_built == 8'h07);
        rxd_is_smdr     = (rxd_built == 8'h19);
        rxd_is_preamble = (rxd_built == 8'h55);

        rxd_is_sfd_lo    = 1'b0;
        rxd_is_sfd_hi    = 1'b0;
        rxd_is_smdv_lo   = 1'b0;
        rxd_is_smdv_hi   = 1'b0;
        rxd_is_smdr_lo   = 1'b0;
        rxd_is_smdr_hi   = 1'b0;
      end
    else
      if (~data_16) // receiving 8 bits from GMII or from PCS with the upper byte duplicated
        begin
          rxd_is_sfd       = (lower_data == 8'hd5);
          rxd_is_smdv      = (lower_data == 8'h07);
          rxd_is_smdr      = (lower_data == 8'h19);
          rxd_is_preamble  = (lower_data == 8'h55);

          rxd_is_sfd_lo    = (lower_data == 8'hd5);
          rxd_is_sfd_hi    = 1'b0;
          rxd_is_smdv_lo   = (lower_data == 8'h07);
          rxd_is_smdv_hi   = 1'b0;
          rxd_is_smdr_lo   = (lower_data == 8'h19);
          rxd_is_smdr_hi   = 1'b0;
        end
      else // receiving 16 bits from PCS
        begin
          rxd_is_sfd_lo   = (rxd_pcs[7:0] == 8'hd5);
          rxd_is_sfd_hi   = (rxd_pcs      == 16'hd555);

          rxd_is_smdv_lo  = (rxd_pcs[7:0] == 8'h07);
          rxd_is_smdv_hi  = (rxd_pcs      == 16'h0755);

          rxd_is_smdr_lo  = (rxd_pcs[7:0] == 8'h19);
          rxd_is_smdr_hi  = (rxd_pcs      == 16'h1955);

          rxd_is_preamble = ((rx_dv_pcs == 2'b11) && (rxd_pcs       == 16'h5555)) ||
                            ((rx_dv_pcs == 2'b10) && (rxd_pcs[15:8] == 8'h55));

          rxd_is_sfd      = 1'b0;
          rxd_is_smdv     = 1'b0;
          rxd_is_smdr     = 1'b0;
        end
  end

  // -----------------------------------------------------------------------------
  // EMAC DRIVER LOGIC
  // -----------------------------------------------------------------------------
  always @ (posedge rx_clk or negedge n_rxreset)
  begin
    if(~n_rxreset)
      begin
        emac_rx_dv        <= 1'h0;
        emac_rx_er        <= 1'h0;
        emac_rxd          <= 8'h00;
        emac_rxd_par      <= 1'b0;
        emac_rx_dv_pcs    <= 2'h0;
        emac_rx_er_pcs    <= 2'h0;
        emac_rxd_pcs      <= 16'h0000;
        emac_rxd_par_pcs  <= 2'b00;
      end
    else
      begin
        case(n_state)
        INIT_EF,
        IDLE_N_CHECK_FOR_EXPRESS0,
        CHECK_FOR_EXPRESS1,
        RCV_V,
        RCV_R,
        V_MCRC_OK,
        R_MCRC_OK,
        NOT_EXPRESS:
        begin
          emac_rx_dv        <= 1'h0;
          emac_rx_er        <= 1'h0;
          emac_rxd          <= 8'h00;
          emac_rxd_par      <= 1'b0;
          emac_rx_dv_pcs    <= 2'h0;
          emac_rx_er_pcs    <= 2'h0;
          emac_rxd_pcs      <= 16'h0000;
          emac_rxd_par_pcs  <= 2'b00;
        end
        FORWARD_PREAMBLE0,
        FORWARD_PREAMBLE1,
        SFD0:
        begin
          emac_rx_dv        <= rx_dv;
          emac_rx_er        <= rx_er;
          emac_rxd          <= 8'h05;
          emac_rxd_par      <= 1'b0;
          emac_rx_dv_pcs    <= 2'h0;
          emac_rx_er_pcs    <= 2'h0;
          emac_rxd_pcs      <= 16'h0000;
          emac_rxd_par_pcs  <= 2'b00;
        end
        SFD1:
        begin
          emac_rx_dv        <= rx_dv;
          emac_rx_er        <= rx_er;
          emac_rxd          <= 8'h0d;
          emac_rxd_par      <= 1'b1;
          emac_rx_dv_pcs    <= 2'h0;
          emac_rx_er_pcs    <= 2'h0;
          emac_rxd_pcs      <= 16'h0000;
          emac_rxd_par_pcs  <= 2'b00;
        end
        E_RECEIVE_DATA:
        begin
          if(data_4)
            begin
              emac_rx_dv        <= buf_dv_pipe2;
              emac_rx_er        <= buf_er_pipe2;
              emac_rxd          <= {4'h0,buf_data_pipe2};
              emac_rxd_par      <= buf_par[3];
              emac_rx_dv_pcs    <= 2'h0;
              emac_rx_er_pcs    <= 2'h0;
              emac_rxd_pcs      <= 16'h0000;
              emac_rxd_par_pcs  <= 2'b00;
            end
          else
            begin
              if(~data_16)
                begin
                  if(data_8in16)
                    begin
                      emac_rx_dv        <= 1'b0;
                      emac_rx_er        <= 1'b0;
                      emac_rxd          <= 8'h00;
                      emac_rxd_par      <= 1'b0;
                      emac_rx_dv_pcs    <= buf_dv[1:0];
                      emac_rx_er_pcs    <= buf_er[1:0];
                      emac_rxd_pcs      <= buf_data;
                      emac_rxd_par_pcs  <= buf_par[1:0];
                    end
                  else
                    begin
                      emac_rx_dv        <= buf_dv[0];
                      emac_rx_er        <= buf_er[0];
                      emac_rxd          <= buf_data[7:0];
                      emac_rxd_par      <= buf_par[0];
                      emac_rx_dv_pcs    <= 2'h0;
                      emac_rx_er_pcs    <= 2'h0;
                      emac_rxd_pcs      <= 16'h0000;
                      emac_rxd_par_pcs  <= 2'b00;
                    end
                end
              else
                 begin
                   emac_rx_dv       <= 1'h0;
                   emac_rx_er       <= 1'h0;
                   emac_rxd         <= 8'h00;
                   emac_rxd_par     <= 1'b0;
                   emac_rx_dv_pcs   <= buf_dv[1:0];
                   emac_rx_er_pcs   <= buf_er[1:0];
                   emac_rxd_pcs     <= buf_data;
                   emac_rxd_par_pcs <= buf_par[1:0];
                 end
            end
        end
        default: //E_RECEIVE_DATA_NBUFF
        begin
          emac_rx_dv        <= 1'h0;
          emac_rx_er        <= 1'h0;
          emac_rxd          <= 8'h00;
          emac_rxd_par      <= 1'b0;
          emac_rx_dv_pcs    <= rx_dv_pcs;
          emac_rx_er_pcs    <= rx_er_pcs;
          emac_rxd_pcs      <= rxd_pcs;
          emac_rxd_par_pcs  <= rxd_par_pcs;
        end
        endcase
      end
  end

  // Optional ASF parity checking
  generate if (p_edma_asf_dap_prot == 1) begin : gen_par_chk
    cdnsdru_asf_parity_check_v1 #(.p_data_width(24)) i_par_chk (
      .odd_par    (1'b0),
      .data_in    ({emac_rxd_pcs,emac_rxd}),
      .parity_in  ({emac_rxd_par_pcs,emac_rxd_par}),
      .parity_err (asf_dap_mmsl_rx_err)
    );
  end else begin : gen_no_par_chk
    assign asf_dap_mmsl_rx_err  = 1'b0;
  end
  endgenerate

endmodule
