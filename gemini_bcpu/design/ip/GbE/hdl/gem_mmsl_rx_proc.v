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
//   Filename:           gem_mmsl_rx_proc.v
//   Module Name:        gem_mmsl_rx_proc
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
//   Description :      Receive filter processing the non Express m-packets
//
//------------------------------------------------------------------------------


  module gem_mmsl_rx_proc (

    input             rx_clk,
    input             n_rxreset,
    input             rx_enable,
    input       [3:0] speed_mode,

    // MII inputs
    input             rx_dv,
    input             rx_dv_extended,
    input             rx_er,
    input       [7:0] rxd,
    input             rxd_par,

    // PCS inputs
    input       [1:0] rx_dv_pcs,
    input       [1:0] rx_dv_pcs_extended,
    input       [1:0] rx_er_pcs,
    input      [15:0] rxd_pcs,
    input       [1:0] rxd_par_pcs,

    // Input from the MMSL control register
    input             invert_mcrc,

    // Outputs to the pMAC - non PCS
    output            pmac_rx_dv,
    output            pmac_rx_er,
    output      [7:0] pmac_rxd,
    output            pmac_rxd_par,

    // Output to the pMAC - PCS
    output      [1:0] pmac_rx_dv_pcs,
    output      [1:0] pmac_rx_er_pcs,
    output     [15:0] pmac_rxd_pcs,
    output      [1:0] pmac_rxd_par_pcs,

    output            frag_count_rx_toggle,
    output reg        ass_ok_count_toggle,
    output reg        smd_error_count_toggle,
    output reg        ass_error_count_toggle,
    output            fr_count_error_toggle,
    output            smd_error_toggle,
    output            smdc_error_toggle,
    output            smds_error_toggle,
    output            pmac_rx_halt,

    // ASF error signalling
    output            asf_dap_mmsl_rx_err

  );

  parameter p_edma_asf_dap_prot = 1'b0;  // Optional parity protection

  // -----------------------------------------------------------------------------
  // Declaration of the signals and parameters
  // -----------------------------------------------------------------------------
  wire        rx_halt;
  wire        rx_halt_edge;
  wire        p_cont;
  wire        nxt_frame_evald;
  wire        smd_error;
  wire        start_mcrc;
  wire        data_4;
  wire        data_16;
  wire        data_8in16;
  wire        rx_mcrc_ok_comb;
  wire        rx_mcrc_ok;
  wire [27:0] rxd_word_pipe_rial;

  wire [31:0] rx_stripe_out0;  // used for crc generation.
  wire [31:0] rx_stripe_out1;  // used for crc generation.
  wire [31:0] rx_stripe_out2;  // used for crc generation.
  wire [31:0] rx_stripe_out3;  // used for crc generation.
  wire [31:0] rx_stripe_out4;  // used for crc generation.
  wire [31:0] rx_stripe_out5;  // used for crc generation.
  wire [31:0] rx_stripe_out6;  // used for crc generation.
  wire [31:0] rx_stripe_out7;  // used for crc generation.
  wire [31:0] rx_stripe_out8;  // used for crc generation.
  wire [31:0] rx_stripe_out9;  // used for crc generation.
  wire [31:0] rx_stripe_out10; // used for crc generation.
  wire [31:0] rx_stripe_out11; // used for crc generation.
  wire [31:0] rx_stripe_out12; // used for crc generation.
  wire [31:0] rx_stripe_out13; // used for crc generation.
  wire [31:0] rx_stripe_out14; // used for crc generation.
  wire [31:0] rx_stripe_out15; // used for crc generation.
  wire [27:0] rxd_word_muxed;
  wire  [3:0] rxd_word_muxed_dv;
  wire  [3:0] rxd_pipe0_er;
  wire  [3:0] rxd_pipe0_dv;
  wire  [3:0] rxd_pipe0_dv_extended;
  wire  [3:0] rxd_pipe0_par;
  wire        rxd_is_preamble_lo;
  wire        rxd_is_preamble_hi;
  wire        rxd_is_sfd_lo;
  wire        rxd_is_sfd_hi;
  wire        rxd_is_smdv_lo;
  wire        rxd_is_smdv_hi;
  wire        rxd_is_smdr_lo;
  wire        rxd_is_smdr_hi;
  wire        rxd_is_smds_hi;
  wire        rxd_is_smdc_lo;
  wire  [2:0] rx_frame_cnt;
  wire  [2:0] c_frame_cnt;
  wire  [2:0] rx_frag_cnt;
  wire  [2:0] nxt_frag_cnt;
  wire  [2:0] g_cnt;
  wire        rxd_ready;
  wire [15:0] rxd_word;
  wire  [3:0] rxd_word_par;
  wire  [3:0] rxd_dv;
  wire  [3:0] rxd_dv_extended;
  wire  [3:0] rxd_er;
  wire        fw_all_word;
  wire        frame_complete;
  wire  [3:0] rxd_word_muxed_dv_extended;
  reg         contin_on_resume;
  reg   [3:0] rxd_word_muxed_dv_del;
  reg         word_odd_end;
  reg  [27:0] rxd_piped[0:4];
  reg   [3:0] n_state_pipe [0:4];
  reg  [27:0] rxd_pipe;
  reg   [3:0] rxd_pipe_dv_extended;
  reg   [3:0] n_state;
  reg   [3:0] c_state;
  reg  [31:0] crc;
  reg   [3:0] rxd_pipe_rial_dv;
  reg   [3:0] rxd_pipe_rial_er;
  reg   [3:0] rxd_pipe_rial_par;
  reg  [15:0] rxd_pipe_rial;
  reg   [3:0] rxd_pipe_rial_dv_extended;
  reg  [15:0] rxd_prev;
  reg   [3:0] rxd_par_prev;
  reg   [7:0] data_source_pipe;
  reg   [7:0] data_source[0:2];
  reg   [2:0] dv_source;
  reg   [2:0] dv_source_extended;
  reg   [2:0] er_source;
  reg   [2:0] par_source;
  reg  [15:0] data_to_driver;
  reg   [3:0] dv_to_driver;
  reg   [3:0] er_to_driver;
  reg   [3:0] par_to_driver;
  reg         dv_source_pipe;
  reg         dv_source_pipe_extended;
  reg         er_source_pipe;
  reg         par_source_pipe;
  reg         illegal_smd;
  reg         rx_mcrc_ok_hold;
  reg         dv_hi_pulse;
  reg         smd_error_start;
  reg         smd_error_resume;
  reg         fr_count_error;
  reg         smdc_error;
  reg         smds_error;
  reg         rx_halt_del;
  reg         rx_mcrc_ok_del;
  reg         rx_mcrc_ok_del2;
  reg  [31:0] stripe_15_pipe [0:2];
  reg  [31:0] stripe_7_pipe  [0:2];
  reg   [2:0] fw_cnt;
  reg         word_even_end;
  reg   [3:0] c_halt_state;
  reg   [3:0] n_halt_state;
  reg         just_preamble;
  reg         preamble_n_smds;
  reg         express_or_verify;
  reg         dv_low;
  reg         dv_extended_low;
  reg   [1:0] source_select_hold;
  reg   [1:0] source_select;
  reg         lpi_rxd;
  
  parameter INIT_RX                   = 4'b0000;
  parameter IDLE_N_CHECK_FOR_START    = 4'b0001;
  parameter REPLACE_SMD               = 4'b0010;
  parameter P_RECEIVE_DATA            = 4'b0011;
  parameter WAIT_FOR_DV_FALSE         = 4'b0100;
  parameter WAIT_N_CHECK_FOR_RESUME   = 4'b0101;
  parameter INCREMENT_FRAG_COUNT      = 4'b0110;
  parameter ASSEMBLY_ERROR            = 4'b0111;
  parameter BAD_FRAG                  = 4'b1000;
  parameter EXPRESS                   = 4'b1001;
  parameter LPI                       = 4'b1010;

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
  
  // First of all, we want to detect an LPI signalling.
  always @ *
  begin
    if(data_16)
      lpi_rxd = ((rx_dv_pcs == 2'b00) &&
               (((rx_er_pcs == 2'b11) && (rxd_pcs == 16'h0101))||
                ((rx_er_pcs == 2'b01) && (rxd_pcs == 16'h0001))||
                ((rx_er_pcs == 2'b10) && (rxd_pcs == 16'h0100))));
    else if(data_8in16)
      lpi_rxd = ((rx_dv_pcs == 2'b00) && (rx_er_pcs == 2'b11) && (rxd_pcs == 16'h0101));
    else
      lpi_rxd = (~rx_dv && rx_er && (rxd == 8'h01));
  end

  // Creating a 3 stage pipeline
  // So we can have 3 versions of the
  // incoming data at three different times.
  // This will allow us, later on, to
  // choose which one to elaborate
  // (We will choose the version which
  // has the data valid raising in the same
  // moment in which the g_count is zero and rxd_ready 1
  // So we can create our rxd_word vector
  // correctly, storing the first nibble
  // in rxd_word[3:0], the second in
  // rxd_word[7:4], and so on.
  always @ (posedge rx_clk or negedge n_rxreset)
  begin
    if(~n_rxreset)
      begin
        data_source[0]         <= 8'h00;
        data_source[1]         <= 8'h00;
        data_source[2]         <= 8'h00;

        dv_source[0]           <= 1'h0;
        dv_source[1]           <= 1'h0;
        dv_source[2]           <= 1'h0;
        
        dv_source_extended[0]  <= 1'h0;
        dv_source_extended[1]  <= 1'h0;
        dv_source_extended[2]  <= 1'h0;

        er_source[0]           <= 1'h0;
        er_source[1]           <= 1'h0;
        er_source[2]           <= 1'h0;

        par_source[0]          <= 1'b0;
        par_source[1]          <= 1'b0;
        par_source[2]          <= 1'b0;
      end
    else
      begin
        if(data_8in16)
          begin
            data_source[0]        <= rxd_pcs[7:0];
            dv_source  [0]        <= rx_dv_pcs[0];
            dv_source_extended[0] <= rx_dv_pcs_extended[0];
            er_source  [0]        <= rx_er_pcs[0];
            par_source [0]        <= rxd_par_pcs[0];
          end
        else
          begin
            data_source[0]        <= rxd;
            dv_source  [0]        <= rx_dv;
            dv_source_extended[0] <= rx_dv_extended;
            er_source  [0]        <= rx_er;
            par_source [0]        <= rxd_par;
          end
        data_source[1]         <= data_source[0];
        data_source[2]         <= data_source[1];
        dv_source  [1]         <= dv_source  [0];
        dv_source  [2]         <= dv_source  [1];
        dv_source_extended[1]  <= dv_source_extended[0];
        dv_source_extended[2]  <= dv_source_extended[1];
        er_source [1]          <= er_source  [0];
        er_source [2]          <= er_source  [1];
        par_source[1]          <= par_source [0];
        par_source[2]          <= par_source [1];
      end
  end

  always @*
  begin
    if((data_8in16? rx_dv_pcs[0]:rx_dv) && ~dv_source[0])
      dv_hi_pulse = 1'b1;
    else
      dv_hi_pulse = 1'b0;
  end

  // To select rxd       select 2'b00;
  // To select source[0] select 2'b01;
  // To select source[1] select 2'b10;
  // To select source[2] select 2'b11;
  // Clearly, in gmii mode, rx_dv can go 1
  // when g_cnt = 3'b000 or g_cnt = 3'b001,
  // since g_cnt only toggles between these
  // 2 values in that mode. So it means
  // we will only choose between rxd and source[0]
  // in gmii mode, (respectively when in g_cnt = 3'b000
  // and g_cnt = 3'b001)
  always @ *
  begin
    if(dv_hi_pulse)
      case(g_cnt)
        3'b000:
          source_select = 2'b00;
        3'b001:
          source_select = data_4? 2'b11: 2'b01;
        3'b010:
          source_select = 2'b10;
        default:
          source_select = 2'b01;
      endcase
    else
      source_select =  source_select_hold;
  end

  // Registered version of source_select_build
  // which samples the source_select value
  // and keeps it until the new rx_dv high happens
  always @ (posedge rx_clk or negedge n_rxreset)
  begin
    if(~n_rxreset)
      source_select_hold <= 2'b00;
    else if(dv_hi_pulse)
      source_select_hold <= source_select;
  end

  // here we select which data source to take
  // according to the source_select signal
  always @ *
  begin
    case(source_select)
      2'b00:
      begin
        if(data_8in16)
          begin
            data_source_pipe        = rxd_pcs  [7:0];
            dv_source_pipe          = rx_dv_pcs  [0];
            dv_source_pipe_extended = rx_dv_pcs_extended[0];
            er_source_pipe          = rx_er_pcs  [0];
            par_source_pipe         = rxd_par_pcs[0];
          end
        else
          begin
            data_source_pipe        = rxd;
            dv_source_pipe          = rx_dv;
            dv_source_pipe_extended = rx_dv_extended;
            er_source_pipe          = rx_er;
            par_source_pipe         = rxd_par;
          end
      end
      2'b01:
      begin
        data_source_pipe        = data_source[0];
        dv_source_pipe          = dv_source  [0];
        dv_source_pipe_extended = dv_source_extended[0];
        er_source_pipe          = er_source  [0];
        par_source_pipe         = par_source [0];
      end
      2'b10:
      begin
        data_source_pipe        = data_source[1];
        dv_source_pipe          = dv_source  [1];
        dv_source_pipe_extended = dv_source_extended[1];
        er_source_pipe          = er_source  [1];
        par_source_pipe         = par_source [1];
      end
      default:
      begin
        data_source_pipe        = data_source[2];
        dv_source_pipe          = dv_source  [2];
        dv_source_pipe_extended = dv_source_extended[2];
        er_source_pipe          = er_source  [2];
        par_source_pipe         = par_source [2];
      end
    endcase
  end

  // -----------------------------------------------------------------------------
  // Grouping the input data into 16 bits vector
  // -----------------------------------------------------------------------------
  // This sub-module will group the input data coming from above
  // and will put it into a 16-bits word vector, rxd_word,
  // rd_dv, rxd_er. Also g_cnt and rxd_ready will be output
  // Because they will be needed elsewhere in this top module
  gem_mmsl_rx_group16_sys i_gem_mmsl_rx_group16_sys (

    // Inputs
    .rx_clk                 (rx_clk),
    .n_rxreset              (n_rxreset),
    .data_16                (data_16),
    .data_4                 (data_4),
    .c_state                (c_state),
    .n_state                (n_state),
    .rxd_pcs                (rxd_pcs),
    .rxd_par_pcs            (rxd_par_pcs),
    .rx_dv_pcs              (rx_dv_pcs),
    .rx_dv_pcs_extended     (rx_dv_pcs_extended),
    .rx_er_pcs              (rx_er_pcs),
    .data_source_pipe       (data_source_pipe),
    .dv_source_pipe         (dv_source_pipe),
    .dv_source_pipe_extended(dv_source_pipe_extended),
    .er_source_pipe         (er_source_pipe),
    .par_source_pipe        (par_source_pipe),

    // Outputs
    .rxd_word               (rxd_word),
    .rxd_word_par           (rxd_word_par),
    .rxd_dv                 (rxd_dv),
    .rxd_dv_extended        (rxd_dv_extended),
    .rxd_er                 (rxd_er),
    .g_cnt                  (g_cnt),
    .rxd_ready              (rxd_ready)

  );

  // Here we calculate the registered version of rxd_word.
  // This will be chosen over rxd_word_pipe_rial according
  // to the pipe_select signal, which is inside the module
  // gem_mmsl_rx_smd_decode
  // Also, here we create the re-aligned vector to use
  // in case the rxd_word is not.
  always @ (posedge rx_clk or negedge n_rxreset)
  begin
    if(~n_rxreset)
      begin
        rxd_pipe                  <= 28'd0;
        rxd_pipe_dv_extended      <= 4'h0;
        rxd_pipe_rial             <= 16'd0;
        rxd_pipe_rial_dv          <= 4'h0;
        rxd_pipe_rial_dv_extended <= 4'h0;
        rxd_pipe_rial_er          <= 4'h0;
        rxd_pipe_rial_par         <= 4'h0;
      end
    else
      begin
        if(rxd_ready)
          begin
            rxd_pipe                       <= {rxd_word_par, rxd_er, rxd_dv, rxd_word};
            rxd_pipe_dv_extended           <= rxd_dv_extended;
            rxd_pipe_rial    [7:0]         <= rxd_pipe[15:8];
            rxd_pipe_rial_dv [1:0]         <= rxd_pipe0_dv[3:2];
            rxd_pipe_rial_dv_extended[1:0] <= rxd_pipe0_dv_extended[3:2];
            rxd_pipe_rial_er [1:0]         <= rxd_pipe0_er[3:2];
            rxd_pipe_rial_par[1:0]         <= rxd_pipe0_par[3:2];

            rxd_pipe_rial   [15:8]         <= rxd_word[7:0];
            rxd_pipe_rial_dv [3:2]         <= rxd_dv[1:0];
            rxd_pipe_rial_dv_extended[3:2] <= rxd_dv_extended[1:0];
            rxd_pipe_rial_er [3:2]         <= rxd_er[1:0];
            rxd_pipe_rial_par[3:2]         <= rxd_word_par[1:0];
          end
      end
  end
  assign rxd_pipe0_par         = rxd_pipe[27:24];
  assign rxd_pipe0_er          = rxd_pipe[23:20];
  assign rxd_pipe0_dv          = rxd_pipe[19:16];
  assign rxd_pipe0_dv_extended = rxd_pipe_dv_extended;

  assign rxd_word_pipe_rial = {rxd_pipe_rial_par, rxd_pipe_rial_er, rxd_pipe_rial_dv, rxd_pipe_rial};

  // -----------------------------------------------------------------------------
  // SMD decode and pipeline select
  // -----------------------------------------------------------------------------
  // This sub-module will implement a system which will detect the header of the
  // packet and will decide the rxd_word to forward according to the allignment
  // of the payload. Also other flags are output as they're driving the main FSM
  // and other statistic counters.
  gem_mmsl_rx_smd_decode i_gem_mmsl_rx_smd_decode (

     // Inputs
    .rx_clk                    (rx_clk),
    .n_rxreset                 (n_rxreset),
    .n_state                   (n_state),
    .c_state                   (c_state),
    .rxd_dv                    (rxd_dv),
    .rxd_word                  (rxd_word),
    .rxd_ready                 (rxd_ready),
    .rxd_pipe                  (rxd_pipe),
    .rxd_pipe_dv_extended      (rxd_pipe_dv_extended),
    .rxd_word_pipe_rial        (rxd_word_pipe_rial),
    .rxd_pipe_rial_dv_extended (rxd_pipe_rial_dv_extended),

     // Outputs
    .rxd_word_muxed            (rxd_word_muxed),
    .rxd_word_muxed_dv_extended(rxd_word_muxed_dv_extended),
    .rx_frame_cnt              (rx_frame_cnt),
    .c_frame_cnt               (c_frame_cnt),
    .rx_frag_cnt               (rx_frag_cnt),
    .nxt_frag_cnt              (nxt_frag_cnt),
    .frag_count_rx_toggle      (frag_count_rx_toggle),
    .rxd_is_smds_hi            (rxd_is_smds_hi),
    .rxd_is_smdc_lo            (rxd_is_smdc_lo),
    .rxd_is_sfd_lo             (rxd_is_sfd_lo),
    .rxd_is_sfd_hi             (rxd_is_sfd_hi),
    .rxd_is_smdv_lo            (rxd_is_smdv_lo),
    .rxd_is_smdv_hi            (rxd_is_smdv_hi),
    .rxd_is_smdr_lo            (rxd_is_smdr_lo),
    .rxd_is_smdr_hi            (rxd_is_smdr_hi),
    .rxd_is_preamble_lo        (rxd_is_preamble_lo),
    .rxd_is_preamble_hi        (rxd_is_preamble_hi)

  );

  // Once we have chosen the correct rxd_word_muxed between rxd_pipe_rial and rxd_pipe
  // we need to create a pipeline starting from it because we need to delay the signal to
  // the output in order to manage correctly the rx_halt signal.
  always @ (posedge rx_clk or negedge n_rxreset)
  begin
    if(~n_rxreset)
      begin
        rxd_piped[0]    <= 28'd0;
        rxd_piped[1]    <= 28'd0;
        rxd_piped[2]    <= 28'd0;
        rxd_piped[3]    <= 28'd0;
        rxd_piped[4]    <= 28'd0;

        n_state_pipe[0] <= 4'd0;
        n_state_pipe[1] <= 4'd0;
        n_state_pipe[2] <= 4'd0;
        n_state_pipe[3] <= 4'd0;
        n_state_pipe[4] <= 4'd0;
      end
    else
      begin
        if(rxd_ready)
          begin
            rxd_piped[0]    <= rxd_word_muxed;
            rxd_piped[1]    <= rxd_piped[0];
            rxd_piped[2]    <= rxd_piped[1];
            rxd_piped[3]    <= rxd_piped[2];
            rxd_piped[4]    <= rxd_piped[3];

            n_state_pipe[0] <= n_state;
            n_state_pipe[1] <= n_state_pipe[0];
            n_state_pipe[2] <= n_state_pipe[1];
            n_state_pipe[3] <= n_state_pipe[2];
            n_state_pipe[4] <= n_state_pipe[3];
          end
      end
  end

  // -----------------------------------------------------------------------------
  // Finite State Machine
  // -----------------------------------------------------------------------------
  // Some helper signals to make the FSM more readable
  always @ *
  begin
    express_or_verify = ((rxd_is_sfd_hi && rxd_is_preamble_lo)  || rxd_is_sfd_lo  ||
                         (rxd_is_smdv_hi && rxd_is_preamble_lo) || rxd_is_smdv_lo ||
                         (rxd_is_smdr_hi && rxd_is_preamble_lo) || rxd_is_smdr_lo);

    just_preamble     = (rxd_is_preamble_hi && rxd_is_preamble_lo) || (rxd_is_preamble_hi && ~rxd_word_muxed_dv[0]);
    preamble_n_smds   = (rxd_is_smds_hi && ~rxd_is_smdc_lo && rxd_is_preamble_lo);
    if(data_16)
      begin
        dv_low          = ~|rxd_word_muxed_dv;
        dv_extended_low = ~|rxd_word_muxed_dv_extended;
      end  
    else
      begin
        dv_low          = ~|rxd_word_muxed_dv          && ~rxd_ready;
        dv_extended_low = ~|rxd_word_muxed_dv_extended && ~rxd_ready;
      end  
  end

  // FSM state vector
  always @ (posedge rx_clk or negedge n_rxreset)
  begin
    if(~n_rxreset)
      c_state <= INIT_RX;
    else
      c_state <= n_state;
  end

  // Next state calculation
  always @ *
  begin
    case(c_state)
      INIT_RX:
      begin
        if(~rx_enable)
          n_state = INIT_RX;
        else
          n_state = IDLE_N_CHECK_FOR_START;
      end

      IDLE_N_CHECK_FOR_START:
      begin
      if(lpi_rxd)
        n_state = LPI;
      else
        begin
          if((|rxd_word_muxed_dv))
            begin
             if(just_preamble)
               n_state = IDLE_N_CHECK_FOR_START;
             else
               begin
                 if(preamble_n_smds)
                   begin
                     if(rxd_ready)
                       n_state = REPLACE_SMD;
                     else
                       n_state = IDLE_N_CHECK_FOR_START;
                   end
                 else
                   begin
                     if(express_or_verify)
                       n_state = EXPRESS;
                     else if(rxd_ready)
                       n_state = BAD_FRAG;
                     else
                       n_state = IDLE_N_CHECK_FOR_START;
                   end
               end
            end
          else
            n_state = IDLE_N_CHECK_FOR_START;
        end
      end

      LPI:
      begin
        if(lpi_rxd)
          n_state = LPI;
        else
          n_state = IDLE_N_CHECK_FOR_START;
      end

      REPLACE_SMD:
      begin
        if(~rxd_ready)
          n_state = REPLACE_SMD;
        else
          n_state = P_RECEIVE_DATA;
      end
      
      P_RECEIVE_DATA:
      begin
        if(~(|rxd_word_muxed_dv))
          begin
            if(rx_mcrc_ok)
              n_state = WAIT_N_CHECK_FOR_RESUME;    
            else
              begin
                // if the mcrc is not ok we want to
                // forward the CES (keeping on this state)
                // and then go to IDLE_N_CHECK_FOR_START
                if(|rxd_word_muxed_dv_extended)
                  n_state = P_RECEIVE_DATA;
                else
                  n_state = IDLE_N_CHECK_FOR_START;  
              end
          end
        else
          n_state = P_RECEIVE_DATA;
      end
                        
      WAIT_FOR_DV_FALSE:
      begin
        if((~|rxd_word_muxed_dv))
          n_state = WAIT_N_CHECK_FOR_RESUME;
        else
          n_state = WAIT_FOR_DV_FALSE;
      end

      WAIT_N_CHECK_FOR_RESUME:
      begin
      if(lpi_rxd)
        n_state = LPI;
      else
        begin
          if((|rxd_word_muxed_dv))
            begin
              if(just_preamble)
                n_state = WAIT_N_CHECK_FOR_RESUME;
              else
                begin
                  if(rxd_is_smdc_lo)
                    begin
                      if((c_frame_cnt == rx_frame_cnt) &&
                         (rx_frag_cnt == nxt_frag_cnt))
                        n_state = INCREMENT_FRAG_COUNT;
                      else
                        n_state = ASSEMBLY_ERROR;
                    end
                  else
                    begin
                      if(preamble_n_smds)
                        begin
                          if(rxd_ready)
                            n_state = REPLACE_SMD;
                          else
                            n_state = WAIT_N_CHECK_FOR_RESUME;
                        end
                      else
                        n_state = WAIT_FOR_DV_FALSE;
                    end
                end
            end
          else
            n_state = WAIT_N_CHECK_FOR_RESUME;
        end
      end

      INCREMENT_FRAG_COUNT:
      begin
        if(~rxd_ready)
          n_state = INCREMENT_FRAG_COUNT;
        else
          n_state = P_RECEIVE_DATA;
      end

      ASSEMBLY_ERROR:
      begin
        if(dv_low)
          n_state = IDLE_N_CHECK_FOR_START;
        else
          n_state = ASSEMBLY_ERROR;
      end

      BAD_FRAG:
      begin
        if(dv_low)
          n_state = IDLE_N_CHECK_FOR_START;
        else
          n_state = BAD_FRAG;
      end
      
      // We need to exit from the EXPRESS state
      // using the extended data low signal,
      // because we want to stay here for the
      // entire duration of the carrier extension
      // signalling as otherwise the FSM would go in 
      // IDLE_N_CHECK_FOR_START and it would 
      // forward the carrier extension signal, which 
      // we dont want as it is addressed to the eMAC.
      default: //EXPRESS
      begin
        if(dv_extended_low)
          n_state = IDLE_N_CHECK_FOR_START;
        else
          n_state = EXPRESS;
      end
    endcase
  end

  // -----------------------------------------------------------------------------
  // MCRC check
  // -----------------------------------------------------------------------------

  gem_stripe i_str_rx_0(.din         (rxd_word_muxed[0]),
                        .stripe_in   (crc),
                        .stripe_out  (rx_stripe_out0));

  gem_stripe i_str_rx_1(.din         (rxd_word_muxed[1]),
                        .stripe_in   (rx_stripe_out0),
                        .stripe_out  (rx_stripe_out1));

  gem_stripe i_str_rx_2(.din         (rxd_word_muxed[2]),
                        .stripe_in   (rx_stripe_out1),
                        .stripe_out  (rx_stripe_out2));

  gem_stripe i_str_rx_3(.din         (rxd_word_muxed[3]),
                        .stripe_in   (rx_stripe_out2),
                        .stripe_out  (rx_stripe_out3));

  gem_stripe i_str_rx_4(.din         (rxd_word_muxed[4]),
                        .stripe_in   (rx_stripe_out3),
                        .stripe_out  (rx_stripe_out4));

  gem_stripe i_str_rx_5(.din         (rxd_word_muxed[5]),
                        .stripe_in   (rx_stripe_out4),
                        .stripe_out  (rx_stripe_out5));

  gem_stripe i_str_rx_6(.din         (rxd_word_muxed[6]),
                        .stripe_in   (rx_stripe_out5),
                        .stripe_out  (rx_stripe_out6));

  gem_stripe i_str_rx_7(.din         (rxd_word_muxed[7]),
                        .stripe_in   (rx_stripe_out6),
                        .stripe_out  (rx_stripe_out7));

  gem_stripe i_str_rx_8(.din         (rxd_word_muxed[8]),
                        .stripe_in   (rx_stripe_out7),
                        .stripe_out  (rx_stripe_out8));

  gem_stripe i_str_rx_9(.din         (rxd_word_muxed[9]),
                        .stripe_in   (rx_stripe_out8),
                        .stripe_out  (rx_stripe_out9));

  gem_stripe i_str_rx_10(.din        (rxd_word_muxed[10]),
                        .stripe_in   (rx_stripe_out9),
                        .stripe_out  (rx_stripe_out10));

  gem_stripe i_str_rx_11(.din        (rxd_word_muxed[11]),
                        .stripe_in   (rx_stripe_out10),
                        .stripe_out  (rx_stripe_out11));

  gem_stripe i_str_rx_12(.din        (rxd_word_muxed[12]),
                        .stripe_in   (rx_stripe_out11),
                        .stripe_out  (rx_stripe_out12));

  gem_stripe i_str_rx_13(.din        (rxd_word_muxed[13]),
                        .stripe_in   (rx_stripe_out12),
                        .stripe_out  (rx_stripe_out13));

  gem_stripe i_str_rx_14(.din        (rxd_word_muxed[14]),
                        .stripe_in   (rx_stripe_out13),
                        .stripe_out  (rx_stripe_out14));

  gem_stripe i_str_rx_15(.din        (rxd_word_muxed[15]),
                        .stripe_in   (rx_stripe_out14),
                        .stripe_out  (rx_stripe_out15));


  // crc register and control.
  assign start_mcrc = data_16? ((c_state == P_RECEIVE_DATA || c_state == REPLACE_SMD || c_state == INCREMENT_FRAG_COUNT) && |(rxd_word_muxed_dv)):
                               ((c_state == P_RECEIVE_DATA || c_state == REPLACE_SMD) && rxd_ready && |(rxd_word_muxed_dv));

  always @ (posedge rx_clk or negedge n_rxreset)
  begin
    if(~n_rxreset)
      begin
        stripe_15_pipe[0] <= 32'd0;
        stripe_15_pipe[1] <= 32'd0;
        stripe_15_pipe[2] <= 32'd0;

        stripe_7_pipe[0]  <= 32'd0;
        stripe_7_pipe[1]  <= 32'd0;
        stripe_7_pipe[2]  <= 32'd0;
      end
    else if(rxd_ready)
      begin
        stripe_15_pipe[0] <= rx_stripe_out15;
        stripe_15_pipe[1] <= stripe_15_pipe[0];
        stripe_15_pipe[2] <= stripe_15_pipe[1];

        stripe_7_pipe[0]  <= rx_stripe_out7;
        stripe_7_pipe[1]  <= stripe_7_pipe[0];
        stripe_7_pipe[2]  <= stripe_7_pipe[1];
      end
  end

  always@(posedge rx_clk or negedge n_rxreset)
  begin
    if (~n_rxreset)
      crc <= 32'hffffffff;
    else
      begin
        if (((~|rxd_word_muxed_dv) && (n_state != WAIT_N_CHECK_FOR_RESUME)) || (c_state == ASSEMBLY_ERROR) || (c_state == WAIT_N_CHECK_FOR_RESUME && n_state == REPLACE_SMD))
          crc <= 32'hffffffff;
        else
          begin
            if ((~|rxd_word_muxed_dv) && (n_state == WAIT_N_CHECK_FOR_RESUME) && (c_state == P_RECEIVE_DATA))
              begin
                if(word_even_end)
                  crc <= stripe_15_pipe[2];
                else
                  crc <= stripe_7_pipe[2];
              end
            else
              begin
                if (start_mcrc)
                  begin
                    if(rxd_word_muxed_dv == 4'b1111)
                      crc <= rx_stripe_out15;
                    else
                      crc <= rx_stripe_out7;
                  end
                else
                  crc <= crc;
              end
          end
      end
  end

  always @ (posedge rx_clk or negedge n_rxreset)
  begin
    if(~n_rxreset)
      rx_mcrc_ok_hold <= 1'b0;
    else
      begin
        if(rx_mcrc_ok_comb)
          rx_mcrc_ok_hold <= 1'b1;
        else
          begin
            if(~data_16)
              begin
                 if(rxd_ready)
                   rx_mcrc_ok_hold <= rx_mcrc_ok;
                 else
                   rx_mcrc_ok_hold <= 1'b0;
              end
            else
              rx_mcrc_ok_hold <= 1'b0;
          end
      end
  end

  assign rx_mcrc_ok_comb   = (crc == (invert_mcrc? 32'h384cb906:32'hff48647d)) && ~|rxd_word_muxed_dv;
  assign rx_mcrc_ok        = rx_mcrc_ok_hold || rx_mcrc_ok_comb;
  assign rxd_word_muxed_dv = rxd_word_muxed[19:16];

  always @ (posedge rx_clk or negedge n_rxreset)
  begin
    if(~n_rxreset)
      rxd_word_muxed_dv_del <= 4'd0;
    else
      rxd_word_muxed_dv_del <= rxd_word_muxed_dv;
  end

  // We need to know if the stream ends in the middle of the
  // 16 bits word. If so, we need to take this in account because
  // when holding the frame while waiting for the continuation packet,
  // we need to release the hold to let pass the last part of the
  // frame (and error it if the continuation was bad), but of course
  // we need to let pass only the bytes really left of it and not
  // the whole word if the stream ended in the middle of it.
  always @(posedge rx_clk or negedge n_rxreset)
  begin
    if(~n_rxreset)
      word_odd_end <= 1'b0;
    else
      begin
        if(c_state == WAIT_FOR_DV_FALSE)
          word_odd_end <= word_odd_end;
        else
          begin
            begin // Detecting the passage 1111 -> 0011
              if( rxd_word_muxed_dv[0] &&  rxd_word_muxed_dv[1] && rxd_word_muxed_dv_del[0] && rxd_word_muxed_dv_del[1] &&
                 ~rxd_word_muxed_dv[2] && ~rxd_word_muxed_dv[3] && rxd_word_muxed_dv_del[2] && rxd_word_muxed_dv_del[3])

                 word_odd_end <= 1'b1;

              else
                begin // Detecting the passage 1111 -> 0000
                  if(~rxd_word_muxed_dv[0] && ~rxd_word_muxed_dv[1] && rxd_word_muxed_dv_del[0] && rxd_word_muxed_dv_del[1] &&
                     ~rxd_word_muxed_dv[2] && ~rxd_word_muxed_dv[3] && rxd_word_muxed_dv_del[2] && rxd_word_muxed_dv_del[3])

                    word_odd_end <= 1'b0;
                  else
                    word_odd_end <= word_odd_end;
                end
            end
          end
      end
  end

  assign fw_all_word = ~word_odd_end;

  always @ (*)
  begin // Detecting the passage 1111 -> 0011
    if( rxd_word_muxed_dv[0] &&  rxd_word_muxed_dv[1] && rxd_word_muxed_dv_del[0] && rxd_word_muxed_dv_del[1] &&
       ~rxd_word_muxed_dv[2] && ~rxd_word_muxed_dv[3] && rxd_word_muxed_dv_del[2] && rxd_word_muxed_dv_del[3])

       word_even_end = 1'b0;

    else
      begin // Detecting the passage 1111 -> 0000
        if(~rxd_word_muxed_dv[0] && ~rxd_word_muxed_dv[1] && rxd_word_muxed_dv_del[0] && rxd_word_muxed_dv_del[1] &&
           ~rxd_word_muxed_dv[2] && ~rxd_word_muxed_dv[3] && rxd_word_muxed_dv_del[2] && rxd_word_muxed_dv_del[3])

          word_even_end = 1'b1;
        else
          word_even_end = 1'b0;
      end
  end

  // Errors management
  // 1)   smd_error
  //      Illegal SMD value
  // 2)   fr_count_error
  //      the frame count encoded in the SMD-C does not match that of the SMD-S or
  //      The fragment count value in the continuation mPacket is not an increment of the previous fragment count value
  // 3)   smdc_error
  //      An SMD-C was received without a preceding SMD-S
  // 4)   smds_error
  //      An SMD-S was received mid-frame
  always @ *
  begin
    if(((c_state == WAIT_N_CHECK_FOR_RESUME)) && (n_state == WAIT_FOR_DV_FALSE))
      begin
        if((~rxd_is_sfd_lo)  && (~rxd_is_sfd_hi)  &&
           (~rxd_is_smdv_lo) && (~rxd_is_smdv_hi) &&
           (~rxd_is_smdr_lo) && (~rxd_is_smdr_hi))
          illegal_smd = 1'b1;
        else
          illegal_smd = 1'b0;
      end
    else
      illegal_smd = 1'b0;
  end

  always @ *
  begin
    if((c_state == IDLE_N_CHECK_FOR_START) && (n_state == BAD_FRAG) && ~rxd_is_smdc_lo)
      smd_error_start = 1'b1;
    else
      smd_error_start = 1'b0;

    if((c_state == WAIT_N_CHECK_FOR_RESUME) && (n_state == WAIT_FOR_DV_FALSE) && illegal_smd)
      smd_error_resume = 1'b1;
    else
      smd_error_resume = 1'b0;

    if((c_state == IDLE_N_CHECK_FOR_START) && (n_state == BAD_FRAG) && rxd_is_smdc_lo)
      smdc_error = 1'b1;
    else
      smdc_error = 1'b0;

    if(((c_state == WAIT_N_CHECK_FOR_RESUME)) && n_state == ASSEMBLY_ERROR)
      fr_count_error = 1'b1;
    else
      fr_count_error  = 1'b0;

    if(((c_state == WAIT_N_CHECK_FOR_RESUME)) && n_state == REPLACE_SMD)
      smds_error = 1'b1;
    else
      smds_error = 1'b0;

  end

  // This has to be a register because when we will get to the end of the frame
  // we want to know if that packet has been fragmented. We need to know it
  // in order to get the statistic signal ass_ok_count_toggle
  always @ (posedge rx_clk or negedge n_rxreset)
  begin
    if(~n_rxreset)
      contin_on_resume <= 1'b0;
    else
      begin
        if(n_state == IDLE_N_CHECK_FOR_START)
          contin_on_resume <= 1'b0;
        else if(n_state == INCREMENT_FRAG_COUNT)
          contin_on_resume <= 1'b1;
      end
  end

  assign smd_error = smd_error_start || smd_error_resume;

  // -----------------------------------------------------------------------------
  // RX Halt signal generation
  // -----------------------------------------------------------------------------
  // We will implement it using an FSM.
  parameter IDLE                 = 4'b0000;
  parameter HALT                 = 4'b0001;
  parameter FW_PREV_THEN_CONT_1  = 4'b0010;
  parameter FW_PREV_THEN_CONT_2  = 4'b0011;
  parameter FW_PREV_THEN_CONT_3  = 4'b0100;
  parameter FW_PREV_THEN_CONT_4  = 4'b0101;
  parameter HALT_THEN_CONT       = 4'b0110;
  parameter WAIT_FOR_START       = 4'b0111;
  parameter BUFFER_HALT_CONT     = 4'b1000;
  parameter FW_ERR_THEN_IDLE     = 4'b1001;

  always @ (posedge rx_clk or negedge n_rxreset)
  begin
    if(~n_rxreset)
      c_halt_state <= IDLE;
    else
      c_halt_state <= n_halt_state;
  end

  // Next State Calculation
  always @ *
  begin
    case (c_halt_state)
      IDLE:
      begin
        if((data_16? rx_mcrc_ok_del2: rx_mcrc_ok) && (rxd_word_muxed_dv == 4'b0000))
          n_halt_state = HALT;
        else
          n_halt_state = IDLE;
      end

      HALT:
      begin
        if(nxt_frame_evald)
          begin
            if(p_cont)
              n_halt_state = FW_PREV_THEN_CONT_1;
            else
              begin
                if(n_state == WAIT_FOR_DV_FALSE)
                  n_halt_state = HALT;
                else  // Bad continuation or a start packet
                  n_halt_state = FW_ERR_THEN_IDLE;
              end
          end
        else
          n_halt_state = HALT;
      end

      FW_ERR_THEN_IDLE: n_halt_state = WAIT_FOR_START;

      FW_PREV_THEN_CONT_1:
      begin
        if(data_16)
          n_halt_state = HALT_THEN_CONT;
        else
          begin
            if(fw_all_word || data_4)
              n_halt_state = FW_PREV_THEN_CONT_2;
            else
              n_halt_state = HALT_THEN_CONT;
          end
      end

      FW_PREV_THEN_CONT_2:
      begin
        if(data_4)
          begin
            if(fw_all_word)
              n_halt_state = FW_PREV_THEN_CONT_3;
            else
              n_halt_state = BUFFER_HALT_CONT;
          end
        else
          n_halt_state = HALT_THEN_CONT;
      end

      FW_PREV_THEN_CONT_3: n_halt_state = FW_PREV_THEN_CONT_4;
      FW_PREV_THEN_CONT_4: n_halt_state = HALT_THEN_CONT;
      BUFFER_HALT_CONT   : n_halt_state = HALT_THEN_CONT;

      WAIT_FOR_START:
      begin
        if(data_16? (n_state_pipe[3] == REPLACE_SMD): (n_state_pipe[2] == REPLACE_SMD))
          n_halt_state = IDLE;
        else
          n_halt_state = WAIT_FOR_START;
      end

      default: //HALT_THEN_CONT:
      begin
        if(data_16? (n_state_pipe[4] == P_RECEIVE_DATA):(n_state_pipe[3] == P_RECEIVE_DATA))
          n_halt_state = IDLE;
        else
          n_halt_state = HALT_THEN_CONT;
      end

    endcase
  end

  assign p_cont          = ((c_state == WAIT_N_CHECK_FOR_RESUME) && (n_state == INCREMENT_FRAG_COUNT));
  assign nxt_frame_evald = ((c_state == WAIT_N_CHECK_FOR_RESUME) && (n_state != WAIT_N_CHECK_FOR_RESUME));
  assign rx_halt         = ((n_halt_state == HALT)||(n_halt_state == HALT_THEN_CONT)||(n_halt_state == BUFFER_HALT_CONT));

  // -----------------------------------------------------------------------------
  // Storing the previous byte
  // -----------------------------------------------------------------------------
  // Need to detect the rising edge of both rx_halt and rx_mcrc_ok because
  // in that moment we need to store the last byte.
  always @ (posedge rx_clk or negedge n_rxreset)
  begin
    if(~n_rxreset)
      begin
        rx_halt_del    <= 1'b0;
        rx_mcrc_ok_del <= 1'b0;
        rx_mcrc_ok_del2<= 1'b0;
      end
    else
      begin
        rx_halt_del    <= rx_halt;
        rx_mcrc_ok_del <= rx_mcrc_ok;
        rx_mcrc_ok_del2<= rx_mcrc_ok_del;
      end
  end

  assign rx_halt_edge = rx_halt && ~rx_halt_del;

  // Here we just store the rxd_prev signal when
  // the rx_halt signal will rise.
  always @ (posedge rx_clk or negedge n_rxreset)
  begin
    if(~n_rxreset)
    begin
      rxd_prev      <= 16'd0;
      rxd_par_prev  <= 4'h0;
    end
    else
      if(rx_halt_edge)
      begin
        rxd_prev      <= data_to_driver;
        rxd_par_prev  <= par_to_driver;
      end
  end

  // -----------------------------------------------------------------------------
  // Output MUX
  // -----------------------------------------------------------------------------
  // First we need to determine the signals to feed the output driver
  always @ *
  begin
    if(data_16)
      begin
        data_to_driver = rxd_piped[4] [15:0];
        dv_to_driver   = rxd_piped[4][19:16];
        er_to_driver   = rxd_piped[4][23:20];
        par_to_driver  = rxd_piped[4][27:24];
      end
    else
      begin
        data_to_driver = rxd_piped[2] [15:0];
        dv_to_driver   = rxd_piped[2][19:16];
        er_to_driver   = rxd_piped[2][23:20];
        par_to_driver  = rxd_piped[2][27:24];
      end
  end

  // This counter will drive the last byte fwd
  always @ (posedge rx_clk or negedge n_rxreset)
  begin
    if(~n_rxreset)
      fw_cnt <= 3'd0;
    else
      begin
        if(n_halt_state == FW_PREV_THEN_CONT_1  ||
           n_halt_state == FW_PREV_THEN_CONT_2  ||
           n_halt_state == FW_PREV_THEN_CONT_3  ||
           n_halt_state == FW_PREV_THEN_CONT_4)
            begin
              if(data_4? fw_cnt == 3'd3: fw_cnt == 3'd1)
                fw_cnt <= 3'd0;
              else
                fw_cnt <= fw_cnt + 3'd1;
            end
        else
          fw_cnt <= 3'd0;
      end
  end

  gem_mmsl_rx_output_driver i_gem_mmsl_rx_output_driver (

    // Inputs
    .n_state          (n_state),
    .n_state_pipe4    (n_state_pipe[4]),
    .n_state_pipe2    (n_state_pipe[2]),
    .data_to_driver   (data_to_driver),
    .dv_to_driver     (dv_to_driver),
    .er_to_driver     (er_to_driver),
    .par_to_driver    (par_to_driver),
    .fw_cnt           (fw_cnt),
    .data_16          (data_16),
    .data_8in16       (data_8in16),
    .data_4           (data_4),
    .rx_halt          (rx_halt),
    .n_halt_state     (n_halt_state),
    .g_cnt            (g_cnt),
    .fw_all_word      (fw_all_word),
    .rxd_prev         (rxd_prev),
    .rxd_par_prev     (rxd_par_prev),

    // Outputs
    .pmac_rxd         (pmac_rxd),
    .pmac_rxd_par     (pmac_rxd_par),
    .pmac_rx_dv       (pmac_rx_dv),
    .pmac_rx_er       (pmac_rx_er),
    .pmac_rxd_pcs     (pmac_rxd_pcs),
    .pmac_rxd_par_pcs (pmac_rxd_par_pcs),
    .pmac_rx_dv_pcs   (pmac_rx_dv_pcs),
    .pmac_rx_er_pcs   (pmac_rx_er_pcs)

  );

  // Generating the ass_err_count_toggle for the statistic register
  always @(posedge rx_clk or negedge n_rxreset)
  begin
    if(~n_rxreset)
      ass_error_count_toggle <= 1'b0;
    else
      begin
        if((n_state == ASSEMBLY_ERROR) && (c_state == WAIT_N_CHECK_FOR_RESUME))
          ass_error_count_toggle <= ~ass_error_count_toggle;
        else
          ass_error_count_toggle <= ass_error_count_toggle;
      end
  end

  // Generating the smd_err_count_toggle for the statistic register
  always @(posedge rx_clk or negedge n_rxreset)
  begin
    if(~n_rxreset)
      smd_error_count_toggle <= 1'b0;
    else if(((n_state == BAD_FRAG)          && (c_state == IDLE_N_CHECK_FOR_START)) ||
             (n_state == WAIT_FOR_DV_FALSE) && illegal_smd)
      smd_error_count_toggle <= ~smd_error_count_toggle;
  end

  assign frame_complete = ((c_state == P_RECEIVE_DATA) && (n_state == IDLE_N_CHECK_FOR_START));

  // Generating ass_ok_count_toggle for the statistic register
  always @(posedge rx_clk or negedge n_rxreset)
  begin
    if(~n_rxreset)
      ass_ok_count_toggle <= 1'b0;
    else if(frame_complete && contin_on_resume)
      ass_ok_count_toggle <= ~ass_ok_count_toggle;
  end

  // Generating the toggles for fr_count_error, smd_error, smdc_error and smds_error
  // for a correct Clock domain crossing to the pclk destination domain
  edma_toggle_generate i_fr_count_error_toggle (
  .clk(rx_clk),
  .reset_n(n_rxreset),
  .din(fr_count_error),
  .dout(fr_count_error_toggle)
  );

  edma_toggle_generate i_smd_error_toggle (
  .clk(rx_clk),
  .reset_n(n_rxreset),
  .din(smd_error),
  .dout(smd_error_toggle)
  );

  edma_toggle_generate i_smdc_error_toggle (
  .clk(rx_clk),
  .reset_n(n_rxreset),
  .din(smdc_error),
  .dout(smdc_error_toggle)
  );

  edma_toggle_generate i_smds_error_toggle (
  .clk(rx_clk),
  .reset_n(n_rxreset),
  .din(smds_error),
  .dout(smds_error_toggle)
  );

  assign pmac_rx_halt = rx_halt;

  // Optional ASF parity checking
  generate if (p_edma_asf_dap_prot == 1) begin : gen_par_chk
    cdnsdru_asf_parity_check_v1 #(.p_data_width(24)) i_par_chk (
      .odd_par    (1'b0),
      .data_in    ({pmac_rxd_pcs,pmac_rxd}),
      .parity_in  ({pmac_rxd_par_pcs,pmac_rxd_par}),
      .parity_err (asf_dap_mmsl_rx_err)
    );
  end else begin : gen_no_par_chk
    assign asf_dap_mmsl_rx_err  = 1'b0;
  end
  endgenerate

endmodule
