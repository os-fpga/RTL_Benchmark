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
//   Filename:           gem_reg_rx_q_flush.v
//   Module Name:        gem_reg_rx_q_flush
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
//   Description    : Contains per-queue receive flush feature related registers
//
//------------------------------------------------------------------------------

// include definitions files
`ifndef gem_defs_defined
`define gem_defs_defined
`include "gem_gxl_defs.v"
`include "edma_defs.v"
`endif

module gem_reg_rx_q_flush # (
  parameter p_edma_queues = 32'd1,
  parameter p_parity_prot = 1'b0
)(
  input               pclk,              // APB clock
  input               n_preset,          // Active low reset
  input       [11:0]  i_paddr,           // Full APB address
  input               psel,              // APB select
  input               write_registers,   // write to apb registers.
  input               read_registers,    // read from apb registers.
  input       [31:0]  pwdata,            // APB write data
  input       [3:0]   pwdata_par,        // Parity associated with pwdata
  output      [(32*p_edma_queues)-1:0]   // RX traffic policing registers
                      rx_q_flush,        // RX traffic policing registers
  output  reg [31:0]  prdata_rx_q_flush, // APB read data combinatorial
  output  reg         perr_rx_q_flush,   // Perr signal registered
  output              rx_q_flush_par_err // Parity error of registers
);

  // Internals
  wire               [31:0] rx_q_flush_arr[15:0]; // Helper signal for the rx_flush per queue regs
  wire  [p_edma_queues-1:0] rx_q_flush_par_error; // Parity error of rx_q_flush

  // RX traffic policing registers
  genvar loop_q;
  genvar loop_nq;
  generate for(loop_q=0; loop_q<p_edma_queues[4:0]; loop_q=loop_q+1) begin: gen_rx_q_flush_regs
    reg   [3:0] rx_queue_flush_3_0;
    reg  [15:0] rx_queue_flush_31_16;
    wire [11:0] loop_q_x4;
    wire [12:0] matching_addr;
    
    assign loop_q_x4     = ({loop_q,2'b00});
    assign matching_addr = `gem_rx_q0_flush + loop_q_x4;
    
    always @ (posedge pclk or negedge n_preset)
    begin
      if(~n_preset)
        begin
          rx_queue_flush_3_0   <= 4'd0;
          rx_queue_flush_31_16 <= 16'd0;
        end
      else
        if(write_registers)
        begin
          if (i_paddr == matching_addr[11:0])
            begin
              rx_queue_flush_31_16 <= pwdata[31:16];
              rx_queue_flush_3_0   <= pwdata[3:0];
            end
        end
    end
    assign rx_q_flush_arr[loop_q]                 = {rx_queue_flush_31_16, 12'd0, rx_queue_flush_3_0};
    assign rx_q_flush[(loop_q*32)+31:(loop_q*32)] = rx_q_flush_arr[loop_q];

    // Store and check optional parity
    if (p_parity_prot == 1) begin : gen_par
      reg [2:0] par_int;
      always@(posedge pclk or negedge n_preset)
      begin
        if (~n_preset)
          par_int <= 3'h0;
        else if (write_registers & ({{20{1'b0}},i_paddr} == (`gem_rx_q0_flush + (loop_q*4))))
          par_int <= {pwdata_par[3:2],^pwdata[3:0]};
      end
      cdnsdru_asf_parity_check_v1 #(.p_data_width(32)) i_par_chk (
        .odd_par    (1'b0),
        .data_in    (rx_q_flush_arr[loop_q]),
        .parity_in  ({par_int[2:1],1'b0,par_int[0]}),
        .parity_err (rx_q_flush_par_error[loop_q])
      );
    end else begin : gen_no_par
      assign rx_q_flush_par_error[loop_q] = 1'b0;
    end
  end

  if(p_edma_queues<32'd16) begin: gen_nq_rx_traffic_policing_per_queue
    for (loop_nq=p_edma_queues; loop_nq<16; loop_nq=loop_nq+1)
    begin: gen_loop
      assign rx_q_flush_arr[loop_nq]  = 32'd0;
    end
  end
  endgenerate

  // The prdata_dma should be registered externally.
  always @(*)
  begin
    if (read_registers)
      case (i_paddr)
        `gem_rx_q0_flush  : prdata_rx_q_flush = rx_q_flush_arr[0];
        `gem_rx_q1_flush  : prdata_rx_q_flush = rx_q_flush_arr[1];
        `gem_rx_q2_flush  : prdata_rx_q_flush = rx_q_flush_arr[2];
        `gem_rx_q3_flush  : prdata_rx_q_flush = rx_q_flush_arr[3];
        `gem_rx_q4_flush  : prdata_rx_q_flush = rx_q_flush_arr[4];
        `gem_rx_q5_flush  : prdata_rx_q_flush = rx_q_flush_arr[5];
        `gem_rx_q6_flush  : prdata_rx_q_flush = rx_q_flush_arr[6];
        `gem_rx_q7_flush  : prdata_rx_q_flush = rx_q_flush_arr[7];
        `gem_rx_q8_flush  : prdata_rx_q_flush = rx_q_flush_arr[8];
        `gem_rx_q9_flush  : prdata_rx_q_flush = rx_q_flush_arr[9];
        `gem_rx_q10_flush : prdata_rx_q_flush = rx_q_flush_arr[10];
        `gem_rx_q11_flush : prdata_rx_q_flush = rx_q_flush_arr[11];
        `gem_rx_q12_flush : prdata_rx_q_flush = rx_q_flush_arr[12];
        `gem_rx_q13_flush : prdata_rx_q_flush = rx_q_flush_arr[13];
        `gem_rx_q14_flush : prdata_rx_q_flush = rx_q_flush_arr[14];
        `gem_rx_q15_flush : prdata_rx_q_flush = rx_q_flush_arr[15];
        default           : prdata_rx_q_flush = 32'h00000000;
      endcase
    else
      prdata_rx_q_flush = 32'h00000000;
  end

  // Perr signal is similar to above. This is registered to match previous implementation
  always @(posedge pclk or negedge n_preset)
  begin
    if (~n_preset)
      perr_rx_q_flush  <= 1'b0;
    else if (psel)
      case (i_paddr)
        `gem_rx_q0_flush  : perr_rx_q_flush  <= 1'b0;
        `gem_rx_q1_flush  : perr_rx_q_flush  <= p_edma_queues < 32'd2;
        `gem_rx_q2_flush  : perr_rx_q_flush  <= p_edma_queues < 32'd3;
        `gem_rx_q3_flush  : perr_rx_q_flush  <= p_edma_queues < 32'd4;
        `gem_rx_q4_flush  : perr_rx_q_flush  <= p_edma_queues < 32'd5;
        `gem_rx_q5_flush  : perr_rx_q_flush  <= p_edma_queues < 32'd6;
        `gem_rx_q6_flush  : perr_rx_q_flush  <= p_edma_queues < 32'd7;
        `gem_rx_q7_flush  : perr_rx_q_flush  <= p_edma_queues < 32'd8;
        `gem_rx_q8_flush  : perr_rx_q_flush  <= p_edma_queues < 32'd9;
        `gem_rx_q9_flush  : perr_rx_q_flush  <= p_edma_queues < 32'd10;
        `gem_rx_q10_flush : perr_rx_q_flush  <= p_edma_queues < 32'd11;
        `gem_rx_q11_flush : perr_rx_q_flush  <= p_edma_queues < 32'd12;
        `gem_rx_q12_flush : perr_rx_q_flush  <= p_edma_queues < 32'd13;
        `gem_rx_q13_flush : perr_rx_q_flush  <= p_edma_queues < 32'd14;
        `gem_rx_q14_flush : perr_rx_q_flush  <= p_edma_queues < 32'd15;
        `gem_rx_q15_flush : perr_rx_q_flush  <= p_edma_queues < 32'd16;
        default           : perr_rx_q_flush  <= 1'b1;  // No match for this module
      endcase
    else
      perr_rx_q_flush  <= 1'b0;
  end

  // Optional parity protection
  generate if (p_parity_prot == 1) begin : gen_par
    reg rx_q_flush_par_err_r;
    // Combine and register parity check results
    always @(posedge pclk or negedge n_preset)
    begin
      if (~n_preset)
        rx_q_flush_par_err_r <= 1'b0;
      else
        rx_q_flush_par_err_r <= |rx_q_flush_par_error;
    end
    assign rx_q_flush_par_err  = rx_q_flush_par_err_r;
  end
  else begin : gen_no_par
    assign rx_q_flush_par_err  = 1'b0;
  end
  endgenerate

endmodule
