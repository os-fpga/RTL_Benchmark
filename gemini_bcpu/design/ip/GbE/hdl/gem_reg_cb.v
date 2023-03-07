//------------------------------------------------------------------------------
// Copyright (c) 2017 Cadence Design Systems, Inc.
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
//   Filename:           gem_reg_cb.v
//   Module Name:        gem_reg_cb
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
//   Description    : Contains registers for 802.1CB FRER functionality
//
//------------------------------------------------------------------------------

// include definitions files
`ifndef gem_defs_defined
`define gem_defs_defined
`include "gem_gxl_defs.v"
`include "edma_defs.v"
`endif

module gem_reg_cb # (
  parameter p_gem_num_cb_streams  = 8'd1,
  parameter p_parity_prot         = 1'b0
)(
  input               pclk,                 // APB clock
  input               n_preset,             // Active low reset
  input   [11:0]      i_paddr,              // Full APB address
  input               psel,                 // APB select
  input               write_registers,      // write to apb registers.
  input               read_registers,       // read from apb registers.
  input   [31:0]      pwdata,               // APB write data
  input   [3:0]       pwdata_par,           // Parity associated with pwdata

  input   [p_gem_num_cb_streams-1:0]
                      frer_to_pulse,        // indicate timeout occurred
  input   [p_gem_num_cb_streams-1:0]
                      frer_rogue_pulse,     // indicate rogue frame rcvd
  input   [p_gem_num_cb_streams-1:0]
                      frer_ooo_pulse,       // indicate out of order frame
  input   [p_gem_num_cb_streams-1:0]
                      frer_err_upd_pulse,   // enable update of latent errors
  input   [(p_gem_num_cb_streams*7)-1:0]
                      frer_err_upd_val,     // Incrememt value, use with above

  output  [15:0]      frer_to_cnt,          // Count of number of frer_to_cnt_tog
                                            // without passing frames before timeout
  output  [15:0]      frer_rtag_ethertype,  // Ethertype for redundancy tag detect
  output              frer_strip_rtag,      // Strip redundancy tags
  output              frer_6b_tag,          // R-Tag is 6 bytes as per D2.5 and later
  output  [p_gem_num_cb_streams-1:0]
                      frer_en_vec_alg,      // Select which algorithm to use.
  output  [p_gem_num_cb_streams-1:0]
                      frer_use_rtag,        // Set to use RTag or offset for seqnum
  output  [(p_gem_num_cb_streams*9)-1:0]
                      frer_seqnum_oset,     // Offset into frame for seqnum
  output  [(p_gem_num_cb_streams*5)-1:0]
                      frer_seqnum_len,      // Number of bits of seqnum to use
  output  [(p_gem_num_cb_streams*4)-1:0]
                      frer_scr_sel_1,       // Screener match for stream 1
  output  [(p_gem_num_cb_streams*4)-1:0]
                      frer_scr_sel_2,       // Screener match for stream 2
  output  [(p_gem_num_cb_streams*6)-1:0]
                      frer_vec_win_sz,      // History depth to use for vec rcv alg
  output  [p_gem_num_cb_streams-1:0]
                      frer_en_elim,         // Enable 802.1CB elimination function
  output  [p_gem_num_cb_streams-1:0]
                      frer_en_to,           // Enable 802.1CB timeout function

  output  [31:0]      prdata_cb,            // APB read data combinatorial
  output              perr_cb,              // APB access error, registered
  output              cb_par_err            // Parity error
);

  // Internal signals
  reg   [15:0]  frer_to_cnt_reg;      // Number of 8192 rx_clk before timeout
  reg   [15:0]  frer_red_tag;         // Redundancy Tag Ethertype
  reg   [1:0]   frer_red_tag_cfg;     // Config options for R-Tag
  reg   [31:0]  prdata_cb_tmp;        // Temporary assignment
  reg           perr_cb_tmp;          // ""
  wire  [31:0]  prdata_cb_strm[15:0]; // 2D array of prdata for stream funcs
  wire  [31:0]  prdata_cb_strm_cmb;   // OR of above
  wire  [11:0]  stream_base_addr;     // Base address for cb streams csr
  wire  [12:0]  stream_top_addr;      // Last supported address
  wire          addr_in_stream_range; // Accessing valid address space
  wire  [7:0]   stream_access;        // Stream to access...
  wire  [15:0]  strm_par_err;         // Parity error in stream funcs


  // The first set of the CSR for the CB streams and the last valid address
  // for the configured number of streams.
  assign stream_base_addr = `gem_frer_control_1_a;
  assign stream_top_addr  = stream_base_addr + 12'h00c +
                            ((p_gem_num_cb_streams-8'd1) << 4);
  assign addr_in_stream_range = (i_paddr[11:4] >= stream_base_addr[11:4]) &&
                                (i_paddr[11:4] <= stream_top_addr[11:4]);

  // The stream being accessed is calculated through the base address since
  // all the stream functions CSR are contiguous with each function taking
  // 4 locations.
  assign stream_access  = i_paddr[11:4] - stream_base_addr[11:4];

  // First deal with the common control registers..
  always @(posedge pclk or negedge n_preset)
  begin
    if (~n_preset)
    begin
      frer_to_cnt_reg   <= 16'h0000;
      frer_red_tag      <= 16'hf1c1;
      frer_red_tag_cfg  <= 2'b01;
    end
    else
      if (write_registers)
      begin
        case (i_paddr)
          `gem_frer_timeout : frer_to_cnt_reg <= pwdata[15:0];
          `gem_frer_red_tag :
          begin
            frer_red_tag      <= pwdata[15:0];
            frer_red_tag_cfg  <= pwdata[31:30];
          end
          default           : begin end
        endcase
      end
  end

  // Optional parity protection
  generate if (p_parity_prot == 1) begin : gen_par
    wire        frer_ctrl_par_err;    // Parity error of main control reg
    reg   [1:0] frer_to_cnt_par;
    reg   [1:0] frer_red_tag_par;
    reg         frer_red_tag_cfg_par;
    reg         cb_par_err_r;

    // Store associated parity and register output
    always @(posedge pclk or negedge n_preset)
    begin
      if (~n_preset)
      begin
        frer_to_cnt_par       <= 2'h0;
        frer_red_tag_par      <= 2'b11;
        frer_red_tag_cfg_par  <= 1'b1;
        cb_par_err_r          <= 1'b0;
      end
      else if (write_registers)
      begin
        if (i_paddr == `gem_frer_timeout)
          frer_to_cnt_par   <= pwdata_par[1:0];
        if (i_paddr == `gem_frer_red_tag)
        begin
          frer_red_tag_par      <= pwdata_par[1:0];
          frer_red_tag_cfg_par  <= ^pwdata[31:30];
        end
        cb_par_err_r  <= frer_ctrl_par_err | (|strm_par_err);
      end
    end

    // Check the parity constantly
    cdnsdru_asf_parity_check_v1 #(.p_data_width(34)) i_par_chk (
      .odd_par    (1'b0),
      .data_in    ({frer_red_tag_cfg,frer_red_tag,frer_to_cnt_reg}),
      .parity_in  ({frer_red_tag_cfg_par,frer_red_tag_par,frer_to_cnt_par}),
      .parity_err (frer_ctrl_par_err)
    );
    assign cb_par_err = cb_par_err_r;
  end else begin : gen_no_par
    assign cb_par_err = 1'b0;
  end
  endgenerate

  // Per stream function CSR
  generate
  genvar  cb_stream_var;
  for (cb_stream_var=0; cb_stream_var<16; cb_stream_var = cb_stream_var+1)
  begin : gen_stream_func
    if (cb_stream_var >= p_gem_num_cb_streams)
    begin : gen_no_func
      assign prdata_cb_strm[cb_stream_var]  = 32'h00000000;
      assign strm_par_err[cb_stream_var]    = 1'b0;
    end
    else
    begin : gen_func

      wire          strm_acc;     // This stream function is being accessed
      reg   [31:0]  ctrl_a;       // Control register a
      reg   [12:0]  ctrl_b;       // Control register b
      reg   [9:0]   rogue_cnt;    // Rogue frames statistics
      reg   [9:0]   latent_cnt;   // Latent errors statistics
      reg   [7:0]   seqrst_cnt;   // Timeout errors statistics
      reg   [9:0]   ooo_cnt;      // Out of order statistics
      reg   [31:0]  prdata_tmp;   // APB read data temp variable
      wire  [10:0]  latent_cnt_sum;
      wire  [31:0]  stat_a;       // Statistics register a
      wire  [31:0]  stat_b;       // Statistics register b

      assign stat_a = {6'h00,rogue_cnt,6'h00,latent_cnt};
      assign stat_b = {8'h00,seqrst_cnt,6'h00,ooo_cnt};

      assign strm_acc = addr_in_stream_range &
                        (stream_access == cb_stream_var[7:0]);

      // Control register set A and B.
      always @(posedge pclk or negedge n_preset)
      begin
        if (~n_preset)
        begin
          ctrl_a  <= 32'h00000000;
          ctrl_b  <= 13'h0000;
        end
        else
          if (write_registers & strm_acc)
          begin
            case (i_paddr[3:2])
              2'h0:     ctrl_a  <= {pwdata[31:28],
                                    11'h000,
                                    pwdata[16:0]};
              2'h1:     ctrl_b  <= {pwdata[12:8],
                                    2'h0,
                                    pwdata[5:0]};
              default: begin end
            endcase
          end
      end

      // Optional parity protection
      if (p_parity_prot == 1) begin : gen_par
        reg   [3:0] ctrl_a_par;
        reg   [1:0] ctrl_b_par;

        // Store associated parity
        always @(posedge pclk or negedge n_preset)
        begin
          if (~n_preset)
          begin
            ctrl_a_par  <= 4'h0;
            ctrl_b_par  <= 2'h0;
          end
          else if (write_registers & strm_acc)
          begin
            if (i_paddr[3:2] == 2'h0)
              ctrl_a_par  <= {^pwdata[31:28],pwdata[16],pwdata_par[1:0]};
            if (i_paddr[3:2] == 2'h1)
              ctrl_b_par  <= {^pwdata[12:8],^pwdata[5:0]};
          end
        end

        // Check the parity constantly
        cdnsdru_asf_parity_check_v1 #(.p_data_width(45)) i_par_chk (
          .odd_par    (1'b0),
          .data_in    ({ctrl_b,ctrl_a}),
          .parity_in  ({ctrl_b_par,ctrl_a_par}),
          .parity_err (strm_par_err[cb_stream_var])
        );

      end else begin : gen_no_par
        assign strm_par_err[cb_stream_var]    = 1'b0;
      end

      // MUX local reading
      always@(*)
      begin
        if (read_registers & strm_acc)
        begin
          case (i_paddr[3:2])
            2'h0:     prdata_tmp  = ctrl_a;
            2'h1:     prdata_tmp  = {19'h00000,ctrl_b};
            2'h2:     prdata_tmp  = stat_a;
            default:  prdata_tmp  = stat_b;
          endcase
        end
        else
          prdata_tmp  = 32'h00000000;
      end
      assign prdata_cb_strm[cb_stream_var]  = prdata_tmp;

      assign frer_en_elim[cb_stream_var]    = ctrl_a[31];
      assign frer_en_vec_alg[cb_stream_var] = ctrl_a[30];
      assign frer_en_to[cb_stream_var]      = ctrl_a[29];
      assign frer_use_rtag[cb_stream_var]   = ctrl_a[28];
      assign frer_seqnum_oset[9*cb_stream_var+:9] = ctrl_a[16:8];
      assign frer_scr_sel_1[4*cb_stream_var+:4] = ctrl_a[7:4];
      assign frer_scr_sel_2[4*cb_stream_var+:4] = ctrl_a[3:0];
      assign frer_seqnum_len[5*cb_stream_var+:5] = ctrl_b[12:8];
      assign frer_vec_win_sz[6*cb_stream_var+:6] = ctrl_b[5:0];

      wire  [9:0] rogue_inc_value;
      wire  [9:0] latent_inc_value;
      wire  [9:0] ooo_inc_value;
      wire  [7:0] seqrst_inc_value;

      assign rogue_inc_value  = frer_rogue_pulse[cb_stream_var]   ? 10'h001 : 10'h000;
      assign latent_inc_value = frer_err_upd_pulse[cb_stream_var] ? {3'h0,frer_err_upd_val[7*cb_stream_var+:7]}
                                                                  : 10'h000;
      assign seqrst_inc_value = frer_to_pulse[cb_stream_var]      ? 8'h01   : 8'h00;
      assign ooo_inc_value    = frer_ooo_pulse[cb_stream_var]     ? 10'h001 : 10'h000;

      // Updating of the statistics registers
      always @(posedge pclk or negedge n_preset)
      begin
        if (~n_preset)
          rogue_cnt <= 10'h000;
        else
          if (read_registers && strm_acc &&
              (i_paddr[3:2] == 2'h2))       // Read to clear
            rogue_cnt <= rogue_inc_value;
          else
            // Increment if not saturated
            if (~(&rogue_cnt))
              rogue_cnt <= rogue_cnt + rogue_inc_value;
      end

      // For the latent errors, this value is periodically
      // updated based on frer_err_upd_val and qualified
      // with frer_err_upd_pulse.
      // Since this is incremented by multi bits, we need
      // to precalc to ensure we don't overflow
      assign latent_cnt_sum = latent_cnt + latent_inc_value;

      always @(posedge pclk or negedge n_preset)
      begin
        if (~n_preset)
          latent_cnt  <= 10'h000;
        else
          if (read_registers && strm_acc &&
              (i_paddr[3:2] == 2'h2))       // Read to clear
            latent_cnt <= latent_inc_value;
          else
            // Increment if not saturated
            if (latent_cnt_sum[10])
              latent_cnt  <= 10'h3ff;
            else
              latent_cnt <= latent_cnt_sum[9:0];
      end

      always @(posedge pclk or negedge n_preset)
      begin
        if (~n_preset)
          seqrst_cnt  <= 8'h00;
        else
          if (read_registers && strm_acc &&
              (i_paddr[3:2] == 2'h3))       // Read to clear
            seqrst_cnt  <= seqrst_inc_value;
          else
            // Increment if not saturated
            if (~(&seqrst_cnt))
              seqrst_cnt  <= seqrst_cnt + seqrst_inc_value;
      end
      always @(posedge pclk or negedge n_preset)
      begin
        if (~n_preset)
          ooo_cnt <= 10'h000;
        else
          if (read_registers && strm_acc &&
              (i_paddr[3:2] == 2'h3))       // Read to clear
            ooo_cnt <= ooo_inc_value;
          else
            // Increment if not saturated
            if (~(&ooo_cnt))
              ooo_cnt <= ooo_cnt + ooo_inc_value;
      end

    end // gen_func
  end   // gen_stream_func
  endgenerate

  // Generate perr_cb_tmp, this is registered...
  always @(posedge pclk or negedge n_preset)
  begin
    if (~n_preset)
      perr_cb_tmp   <= 1'b0;
    else
      if (psel)
        case (i_paddr)
          `gem_frer_timeout : perr_cb_tmp <= 1'b0;
          `gem_frer_red_tag : perr_cb_tmp <= 1'b0;
          default           : perr_cb_tmp <= ~addr_in_stream_range;
        endcase
      else
        perr_cb_tmp   <= 1'b0;
  end

  // Assign prdata, this is combinatorial and will be registered in the main
  // code.
  always@(*)
  begin
    if (read_registers)
    begin
      case (i_paddr)
        `gem_frer_timeout : prdata_cb_tmp = {16'h0000,frer_to_cnt_reg};
        `gem_frer_red_tag : prdata_cb_tmp = {frer_red_tag_cfg[1:0],
                                              14'h0000,
                                              frer_red_tag[15:0]};
        default:            prdata_cb_tmp = prdata_cb_strm_cmb;
      endcase
    end
    else
      prdata_cb_tmp = 32'h00000000;
  end

  // Combine the read data results
  assign prdata_cb_strm_cmb = prdata_cb_strm[0] | prdata_cb_strm[1] |
                              prdata_cb_strm[2] | prdata_cb_strm[3] |
                              prdata_cb_strm[4] | prdata_cb_strm[5] |
                              prdata_cb_strm[6] | prdata_cb_strm[7] |
                              prdata_cb_strm[8] | prdata_cb_strm[9] |
                              prdata_cb_strm[10] | prdata_cb_strm[11] |
                              prdata_cb_strm[12] | prdata_cb_strm[13] |
                              prdata_cb_strm[14] | prdata_cb_strm[15];


  assign frer_to_cnt          = frer_to_cnt_reg;
  assign frer_rtag_ethertype  = frer_red_tag[15:0];
  assign frer_strip_rtag      = frer_red_tag_cfg[1];
  assign frer_6b_tag          = frer_red_tag_cfg[0];

  assign perr_cb    = perr_cb_tmp;
  assign prdata_cb  = prdata_cb_tmp;

endmodule
