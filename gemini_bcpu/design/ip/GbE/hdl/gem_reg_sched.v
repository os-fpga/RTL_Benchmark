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
//   Filename:           gem_reg_sched.v
//   Module Name:        gem_reg_sched
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
//   Description    : Contains scheduler related registers
//
//------------------------------------------------------------------------------

// include definitions files
`ifndef gem_defs_defined
`define gem_defs_defined
`include "gem_gxl_defs.v"
`include "edma_defs.v"
`endif

module gem_reg_sched (
  input               pclk,             // APB clock
  input               n_preset,         // Active low reset
  input       [11:0]  i_paddr,          // Full APB address
  input               psel,             // APB select
  input               write_registers,  // write to apb registers.
  input               read_registers,   // read from apb registers.
  input       [31:0]  pwdata,           // APB write data
  input       [3:0]   pwdata_par,       // Parity associated with pwdata
  input       [3:0]   speed_mode,       // Indicate speed and interface.
  input       [15:0]  tx_disable_q_pad, // Padded Q disables
  output      [3:0]   cbs_q_a_id,       // Dynamic indication of top enabled queue
  output      [3:0]   cbs_q_b_id,       // Dynamic indication of top enabled queue
  output      [1:0]   cbs_enable,       // Enable for CBS queues
  output      [31:0]  idleslope_q_a,    // Rate of Change of credit for Queue A
  output      [31:0]  idleslope_q_b,    // Rate of Change of credit for Queue B
  output      [31:0]  port_tx_rate,     // TX rate for CBS
  output      [31:0]  dwrr_ets_control, // Schedule mode control
  output      [127:0] bw_rate_limit,    // Bandwidth rate limits
  output  reg [31:0]  prdata_sched,     // APB read data (comb)
  output  reg         perr_sched,       // Perr (reg)
  output              sched_par_err     // Parity error detected
);

  parameter p_edma_queues       = 32'd1;
  parameter p_edma_exclude_cbs  = 1'b0;
  parameter p_edma_spram        = 1'b0;
  parameter p_parity_prot       = 1'b0;

  // Internal signals
  wire  [31:0]  port_tx_rate_10m_rd;  // Transmit Rate for 10M
  wire  [31:0]  port_tx_rate_100m_rd; // Transmit Rate for 100M
  wire  [31:0]  port_tx_rate_1g_rd;   // Transmit Rate for 1G
  wire  [15:0]  bw_rate_lim_par_err;  // Parity error for bw_rate_limit
  wire          sched_ctrl_err;       // Error in control module
  wire          cbs_par_err;          // Parity error of CBS registers

  // Bandwidth rate limit registers are 8-bits per queue.
  genvar loop_q;
  generate for (loop_q=0;loop_q<32'd16;loop_q=loop_q+1) begin : gen_rate_limit
    wire [11:0] loop_q_x4;
    assign loop_q_x4 = ({loop_q[11:2],2'b00});
    
    if (loop_q < p_edma_queues[31:0]) begin : gen_q_exists
      reg   [7:0]   limit_r;
      wire  [12:0]  bw_lim_addr;    // Address to match

      assign bw_lim_addr  = `gem_bw_rate_limit_q03 + loop_q_x4;

      always@(posedge pclk or negedge n_preset)
      begin
        if(~n_preset)
          limit_r <= 8'h00;
        else
          if (write_registers && (i_paddr == bw_lim_addr[11:0]))
            limit_r <= pwdata[(8*loop_q[1:0])+7:(8*loop_q[1:0])];
      end

      // Optional parity protection
      if (p_parity_prot == 1'b1) begin : gen_par
        reg   limit_par;

        // Store associated parity
        always @(posedge pclk or negedge n_preset)
        begin
          if (~n_preset)
            limit_par <= 1'b0;
          else
            if (write_registers && (i_paddr == bw_lim_addr[11:0]))
              limit_par <= pwdata_par[loop_q[1:0]];
        end

        // Check the parity constantly
        cdnsdru_asf_parity_check_v1 #(.p_data_width(8)) i_par_chk (
          .odd_par    (1'b0),
          .data_in    (limit_r),
          .parity_in  (limit_par),
          .parity_err (bw_rate_lim_par_err[loop_q])
        );
      end else begin : gen_no_par
        assign bw_rate_lim_par_err[loop_q]  = 1'b0;
      end

      assign bw_rate_limit[(loop_q*8)+7:(loop_q*8)] = limit_r;
    end else begin : gen_no_q_exist
      assign bw_rate_lim_par_err[loop_q]  = 1'b0;
      assign bw_rate_limit[(loop_q*8)+7:(loop_q*8)] = 8'h00;
    end
  end
  endgenerate

  // Instantiate scheduler control registers
  gem_reg_sched_ctrl #(.p_edma_queues(p_edma_queues)) i_sched_ctrl (
    .pclk             (pclk),
    .n_preset         (n_preset),
    .i_paddr          (i_paddr),
    .write_registers  (write_registers),
    .pwdata           (pwdata),
    .tx_disable_q_pad (tx_disable_q_pad),
    .cbs_q_a_id       (cbs_q_a_id),
    .cbs_q_b_id       (cbs_q_b_id),
    .dwrr_ets_control (dwrr_ets_control)
  );

  // Optional duplication of control registers and fault compare
  generate if (p_parity_prot == 1'b1) begin : gen_sched_ctrl_dupl
    wire  [3:0]   cbs_q_a_id_dplc;
    wire  [3:0]   cbs_q_b_id_dplc;
    wire  [31:0]  dwrr_ets_control_dplc;

    gem_reg_sched_ctrl #(.p_edma_queues(p_edma_queues)) i_sched_ctrl_asf_duplc (
      .pclk             (pclk),
      .n_preset         (n_preset),
      .i_paddr          (i_paddr),
      .write_registers  (write_registers),
      .pwdata           (pwdata),
      .tx_disable_q_pad (tx_disable_q_pad),
      .cbs_q_a_id       (cbs_q_a_id_dplc),
      .cbs_q_b_id       (cbs_q_b_id_dplc),
      .dwrr_ets_control (dwrr_ets_control_dplc)
    );

    // Compare outputs
    assign sched_ctrl_err = (cbs_q_a_id_dplc       != cbs_q_a_id) ||
                            (cbs_q_b_id_dplc       != cbs_q_b_id) ||
                            (dwrr_ets_control_dplc != dwrr_ets_control);

  end else begin : gen_no_dupl
    assign sched_ctrl_err = 1'b0;
  end
  endgenerate

  // CBS specific registers
  generate if (p_edma_exclude_cbs == 1'b0) begin : gen_cbs_regs
    genvar        loop_i;
    reg   [31:0]  idleslope_q_a_r;
    reg   [31:0]  idleslope_q_b_r;
    wire  [15:0]  q_is_cbs_enabled;
    wire  [31:0]  port_tx_rate_10m;   // Transmit Rate for 10M
    wire  [31:0]  port_tx_rate_100m;  // Transmit Rate for 100M
    wire  [31:0]  port_tx_rate_1g;    // Transmit Rate for 1G
    wire          cbs_spram_par_err;  // SPRAM specific control regs parity error

    // Decode CBS control as it can be configured from 2 places and queues
    // are dynamically controlled
    for (loop_i=0; loop_i<16; loop_i=loop_i+1) begin : gen_cbs_enable
      assign q_is_cbs_enabled[loop_i] = dwrr_ets_control[loop_i*2+1:loop_i*2] == 2'b01;
    end

    always@(posedge pclk or negedge n_preset)
    begin
      if(~n_preset)
      begin
        idleslope_q_a_r <= 32'h00000000;
        idleslope_q_b_r <= 32'h00000000;
      end
      else
      begin
        if (write_registers)
        begin
          case (i_paddr)
            `gem_cbs_idleslope_q_a :
            begin
              idleslope_q_a_r <= pwdata[31:0];
            end

            `gem_cbs_idleslope_q_b :
            begin
              idleslope_q_b_r <= pwdata[31:0];
            end
            default : ;
          endcase
        end
      end
    end

    assign idleslope_q_a = idleslope_q_a_r;
    assign idleslope_q_b = idleslope_q_b_r;

    // CBS enable for highest priority queue
    assign cbs_enable[0] = q_is_cbs_enabled[cbs_q_a_id];

    // CBS for second highest priority queue only if more than 1 queue
    if (p_edma_queues > 32'd1) begin : set_cbs_enable
      assign cbs_enable[1] = q_is_cbs_enabled[cbs_q_b_id];
    end else begin  : set_cbs_enable_1q
      assign cbs_enable[1] = 1'b0;
    end

    // For CBS credit counting, the port_tx_rate variable is used. This is
    // programmable when configured to use SPRAM. Otherwise it is fixed.
    if (p_edma_spram == 1'b1) begin : gen_port_tx_rate
      reg   [31:0] port_tx_rate_10m_r;      // Transmit Rate for 10M
      reg   [31:0] port_tx_rate_100m_r;     // Transmit Rate for 100M
      reg   [31:0] port_tx_rate_1g_r;       // Transmit Rate for 1G
      always @(posedge pclk or negedge n_preset)
      begin
        if (~n_preset)
        begin
          port_tx_rate_10m_r     <= 32'h002625a0;
          port_tx_rate_100m_r    <= 32'h017d7840;
          port_tx_rate_1g_r      <= 32'h07735940;
        end
        else if (write_registers)
        begin
          if (i_paddr == `gem_cbs_port_tx_rate_10m)
            port_tx_rate_10m_r   <= pwdata[31:0];
          if (i_paddr == `gem_cbs_port_tx_rate_100m)
            port_tx_rate_100m_r  <= pwdata[31:0];
          if (i_paddr == `gem_cbs_port_tx_rate_1g)
            port_tx_rate_1g_r    <= pwdata[31:0];
        end
      end
      assign port_tx_rate_10m     = port_tx_rate_10m_r;
      assign port_tx_rate_100m    = port_tx_rate_100m_r;
      assign port_tx_rate_1g      = port_tx_rate_1g_r;
      assign port_tx_rate_10m_rd  = port_tx_rate_10m_r;
      assign port_tx_rate_100m_rd = port_tx_rate_100m_r;
      assign port_tx_rate_1g_rd   = port_tx_rate_1g_r;

      // Optional parity protection
      if (p_parity_prot == 1'b1) begin : gen_par
        reg   [3:0] rate_10m_par;
        reg   [3:0] rate_100m_par;
        reg   [3:0] rate_1g_par;

        // Store associated parity
        always @(posedge pclk or negedge n_preset)
        begin
          if (~n_preset)
          begin
            rate_10m_par  <= 4'b0110;
            rate_100m_par <= 4'b1001;
            rate_1g_par   <= 4'b1101;
          end
          else if (write_registers)
          begin
            if (i_paddr == `gem_cbs_port_tx_rate_10m)
              rate_10m_par  <= pwdata_par;
            if (i_paddr == `gem_cbs_port_tx_rate_100m)
              rate_100m_par <= pwdata_par;
            if (i_paddr == `gem_cbs_port_tx_rate_1g)
              rate_1g_par   <= pwdata_par;
          end
        end

        // Check the parity constantly
        cdnsdru_asf_parity_check_v1 #(.p_data_width(96)) i_par_chk (
          .odd_par    (1'b0),
          .data_in    ({port_tx_rate_1g_r,
                        port_tx_rate_100m_r,
                        port_tx_rate_10m_r}),
          .parity_in  ({rate_1g_par,
                        rate_100m_par,
                        rate_10m_par}),
          .parity_err (cbs_spram_par_err)
        );
      end else begin : gen_no_par
        assign cbs_spram_par_err  = 1'b0;
      end

    end else begin : gen_port_tx_rate_fixed
      assign cbs_spram_par_err    = 1'b0;
      assign port_tx_rate_10m     = 32'h002625a0;
      assign port_tx_rate_100m    = 32'h017d7840;
      assign port_tx_rate_1g      = 32'h07735940;
      assign port_tx_rate_10m_rd  = 32'h00000000;
      assign port_tx_rate_100m_rd = 32'h00000000;
      assign port_tx_rate_1g_rd   = 32'h00000000;
    end

    assign port_tx_rate = (speed_mode[1:0] == 2'b00)  ? port_tx_rate_10m: // 10M
                          (speed_mode[1:0] == 2'b01)  ? port_tx_rate_100m:// 100M
                                                        port_tx_rate_1g;  // 1G

    // Optional parity protection
    if (p_parity_prot == 1) begin : gen_par
      reg   [3:0] slope_a_par;
      reg   [3:0] slope_b_par;
      wire        cbs_reg_par_err;    // Parity error in CBS control regs

      // Store associated parity
      always @(posedge pclk or negedge n_preset)
      begin
        if (~n_preset)
        begin
          slope_a_par <= 4'h0;
          slope_b_par <= 4'h0;
        end
        else if (write_registers)
        begin
          if (i_paddr == `gem_cbs_idleslope_q_a)
            slope_a_par <= pwdata_par;
          if (i_paddr == `gem_cbs_idleslope_q_b)
            slope_b_par <= pwdata_par;
        end
      end

      // Check the parity constantly
      cdnsdru_asf_parity_check_v1 #(.p_data_width(64)) i_par_chk (
        .odd_par    (1'b0),
        .data_in    ({idleslope_q_b_r,idleslope_q_a_r}),
        .parity_in  ({slope_b_par,slope_a_par}),
        .parity_err (cbs_reg_par_err)
      );
      assign cbs_par_err  = cbs_reg_par_err | cbs_spram_par_err;
    end else begin : gen_no_par
      assign cbs_par_err  = 1'b0;
    end

  end else begin : gen_no_cbs_regs
    assign cbs_par_err          = 1'b0;
    assign idleslope_q_a        = 32'd0;
    assign idleslope_q_b        = 32'd0;
    assign cbs_enable[1:0]      = 2'b00;
    assign port_tx_rate         = 32'h00000000;
    assign port_tx_rate_10m_rd  = 32'h00000000;
    assign port_tx_rate_100m_rd = 32'h00000000;
    assign port_tx_rate_1g_rd   = 32'h00000000;
  end
  endgenerate


  // APB read of registers.
  // The prdata_sched should be registered externally.
  always @(*)
  begin
    if (read_registers)
      case (i_paddr)
        `gem_cbs_control          : prdata_sched  = {30'd0, cbs_enable};
        `gem_cbs_idleslope_q_a    : prdata_sched  = idleslope_q_a;
        `gem_cbs_idleslope_q_b    : prdata_sched  = idleslope_q_b;
        `gem_cbs_port_tx_rate_10m : prdata_sched  = port_tx_rate_10m_rd;
        `gem_cbs_port_tx_rate_100m: prdata_sched  = port_tx_rate_100m_rd;
        `gem_cbs_port_tx_rate_1g  : prdata_sched  = port_tx_rate_1g_rd;
        `gem_dwrr_ets_control     : prdata_sched  = dwrr_ets_control;
        `gem_bw_rate_limit_q03    : prdata_sched  = bw_rate_limit[31:0];
        `gem_bw_rate_limit_q47    : prdata_sched  = bw_rate_limit[63:32];
        `gem_bw_rate_limit_q8b    : prdata_sched  = bw_rate_limit[95:64];
        `gem_bw_rate_limit_qcf    : prdata_sched  = bw_rate_limit[127:96];
        default                   : prdata_sched  = 32'h00000000;
      endcase
    else
      prdata_sched  = 32'h00000000;
  end

  // Perr signal is similar to above. This is registered to match previous implementation
  always @(posedge pclk or negedge n_preset)
  begin
    if (~n_preset)
      perr_sched  <= 1'b0;
    else if (psel)
      case (i_paddr)
        `gem_cbs_control          : perr_sched  <= p_edma_exclude_cbs == 1;
        `gem_cbs_idleslope_q_a    : perr_sched  <= p_edma_exclude_cbs == 1;
        `gem_cbs_idleslope_q_b    : perr_sched  <= p_edma_exclude_cbs == 1;
        `gem_cbs_port_tx_rate_10m : perr_sched  <= p_edma_exclude_cbs == 1 || p_edma_spram == 0;
        `gem_cbs_port_tx_rate_100m: perr_sched  <= p_edma_exclude_cbs == 1 || p_edma_spram == 0;
        `gem_cbs_port_tx_rate_1g  : perr_sched  <= p_edma_exclude_cbs == 1 || p_edma_spram == 0;
        `gem_dwrr_ets_control     : perr_sched  <= 1'b0;
        `gem_bw_rate_limit_q03    : perr_sched  <= 1'b0;
        `gem_bw_rate_limit_q47    : perr_sched  <= p_edma_queues < 32'd5;
        `gem_bw_rate_limit_q8b    : perr_sched  <= p_edma_queues < 32'd9;
        `gem_bw_rate_limit_qcf    : perr_sched  <= p_edma_queues < 32'd13;
        default                   : perr_sched  <= 1'b1;  // No match for this module
      endcase
    else
      perr_sched  <= 1'b0;
  end

  // Register parity error if supported
  generate if (p_parity_prot == 1) begin : gen_par
    reg sched_par_err_r;
    always @(posedge pclk or negedge n_preset)
    begin
      if (~n_preset)
        sched_par_err_r  <= 1'b0;
      else
        sched_par_err_r  <= sched_ctrl_err | cbs_par_err | (|bw_rate_lim_par_err);
    end
    assign sched_par_err = sched_par_err_r;
  end
  else begin : gen_no_par
    assign sched_par_err = 1'b0;
  end
  endgenerate

endmodule
