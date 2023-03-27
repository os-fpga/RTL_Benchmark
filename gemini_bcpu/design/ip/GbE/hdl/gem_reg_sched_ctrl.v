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
//   Filename:           gem_reg_sched_ctrl.v
//   Module Name:        gem_reg_sched_ctrl
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
//   Description    : Contains scheduler control registers that may be easily
//                    duplicated for protection.
//
//------------------------------------------------------------------------------

// include definitions files
`ifndef gem_defs_defined
`define gem_defs_defined
`include "gem_gxl_defs.v"
`include "edma_defs.v"
`endif

module gem_reg_sched_ctrl (
  input               pclk,                 // APB clock
  input               n_preset,             // Active low reset
  input       [11:0]  i_paddr,              // Full APB address
  input               write_registers,      // write to apb registers.
  input       [31:0]  pwdata,               // APB write data
  input       [15:0]  tx_disable_q_pad,     // Padded Q disables
  output      [3:0]   cbs_q_a_id,           // Dynamic indication of top enabled queue
  output      [3:0]   cbs_q_b_id,           // Dynamic indication of top enabled queue
  output      [31:0]  dwrr_ets_control      // Schedule mode control

);

  parameter p_edma_queues = 32'd1;

  // Internal signals
  reg   [32:0]                dwrr_ets_control_c; // Transmit Queue Scheduling registers (comb)
  reg   [p_edma_queues*2-1:0] dwrr_ets_control_r; // Transmit Queue Scheduling registers

  // Determine queues to use for CBS based on hard and soft config
  // This is always the top 2 enabled queues.
  // This variable is also used by some DMA functions.
  generate if (p_edma_queues > 32'd1) begin : gen_cbs_id
    reg  [3:0]              cbs_q_a_id_r;
    reg  [3:0]              cbs_q_b_id_r;
    always@(posedge pclk or negedge n_preset)
    begin
      if (~n_preset)
        cbs_q_a_id_r       <= 4'd0;
      else
        if (~tx_disable_q_pad[15] && p_edma_queues == 32'd16)
          cbs_q_a_id_r  <= 4'd15;
        else if (~tx_disable_q_pad[14] && p_edma_queues > 32'd14)
          cbs_q_a_id_r  <= 4'd14;
        else if (~tx_disable_q_pad[13] && p_edma_queues > 32'd13)
          cbs_q_a_id_r  <= 4'd13;
        else if (~tx_disable_q_pad[12] && p_edma_queues > 32'd12)
          cbs_q_a_id_r  <= 4'd12;
        else if (~tx_disable_q_pad[11] && p_edma_queues > 32'd11)
          cbs_q_a_id_r  <= 4'd11;
        else if (~tx_disable_q_pad[10] && p_edma_queues > 32'd10)
          cbs_q_a_id_r  <= 4'd10;
        else if (~tx_disable_q_pad[9] && p_edma_queues > 32'd9)
          cbs_q_a_id_r  <= 4'd9;
        else if (~tx_disable_q_pad[8] && p_edma_queues > 32'd8)
          cbs_q_a_id_r  <= 4'd8;
        else if (~tx_disable_q_pad[7] && p_edma_queues > 32'd7)
          cbs_q_a_id_r  <= 4'd7;
        else if (~tx_disable_q_pad[6] && p_edma_queues > 32'd6)
          cbs_q_a_id_r  <= 4'd6;
        else if (~tx_disable_q_pad[5] && p_edma_queues > 32'd5)
          cbs_q_a_id_r  <= 4'd5;
        else if (~tx_disable_q_pad[4] && p_edma_queues > 32'd4)
          cbs_q_a_id_r  <= 4'd4;
        else if (~tx_disable_q_pad[3] && p_edma_queues > 32'd3)
          cbs_q_a_id_r  <= 4'd3;
        else if (~tx_disable_q_pad[2] && p_edma_queues > 32'd2)
          cbs_q_a_id_r  <= 4'd2;
        else if (~tx_disable_q_pad[1] && p_edma_queues > 32'd1)
          cbs_q_a_id_r  <= 4'd1;
        else
          cbs_q_a_id_r  <= 4'd0;
    end
    always@(*)
    begin
      if (cbs_q_a_id_r == 4'd0)
        cbs_q_b_id_r = 4'd0;
      else
        cbs_q_b_id_r = cbs_q_a_id_r - 4'd1;
    end
    assign cbs_q_a_id = cbs_q_a_id_r;
    assign cbs_q_b_id = cbs_q_b_id_r;
  end else begin : gen_single_q
    assign cbs_q_a_id = 4'h0;
    assign cbs_q_b_id = 4'h0;
  end
  endgenerate


  // APB Register writes to scheduler registers
  always @(*)
  begin
    dwrr_ets_control_c = {{(33-(p_edma_queues*2)){1'b0}},dwrr_ets_control_r};
    if (write_registers) // begin if (write_registers)
      case (i_paddr)
        `gem_cbs_control   :
        begin
          if (cbs_q_a_id > 4'h0)  // More than 1 CBS queue active
          begin
            dwrr_ets_control_c[cbs_q_a_id*2+1]  = 1'b0;
            dwrr_ets_control_c[cbs_q_a_id*2]    = pwdata[0]; // Top queue
            dwrr_ets_control_c[cbs_q_b_id*2+1]  = 1'b0;
            dwrr_ets_control_c[cbs_q_b_id*2]    = pwdata[1]; // Bottom queue
          end
          else  // Only 1 queue active
          begin
            dwrr_ets_control_c[1] = 1'b0;
            dwrr_ets_control_c[0] = pwdata[0]; // Top queue (A)
          end
        end
        `gem_dwrr_ets_control : dwrr_ets_control_c[(p_edma_queues*2-1):0] = pwdata[(p_edma_queues*2-1):0];

        default : dwrr_ets_control_c = {{(33-(p_edma_queues*2)){1'b0}},dwrr_ets_control_r};
      endcase
  end

  always @(posedge pclk or negedge n_preset)
  begin
    if (~n_preset)
      dwrr_ets_control_r    <= {p_edma_queues*2{1'b0}};
    else
      dwrr_ets_control_r    <= dwrr_ets_control_c[(p_edma_queues*2)-1:0];
  end

  // Need to extend the upper bits for when there are less than 16 queues
  genvar  var_f;
  genvar  var_g;
  generate for (var_f=0; var_f<p_edma_queues[31:0]; var_f=var_f+1)
  begin : gen_ets_ctrl_lower
    assign dwrr_ets_control[var_f*2+1:var_f*2] = dwrr_ets_control_r[var_f*2+1:var_f*2];
  end
  endgenerate

  generate if(p_edma_queues<32'd16) begin: gen_ets_ctrl_upper
    for (var_g=p_edma_queues; var_g<16; var_g=var_g+1) begin : gen_loop
      assign dwrr_ets_control[var_g*2+1:var_g*2] = 2'b00;
    end
  end
  endgenerate


endmodule
