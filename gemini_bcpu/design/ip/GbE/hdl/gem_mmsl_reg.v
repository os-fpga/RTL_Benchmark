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
//   Filename:           gem_mmsl_reg.v
//   Module Name:        gem_mmsl_reg
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
//   Description :      MMSL registers
//
//------------------------------------------------------------------------------

// include definitions files
`ifndef gem_defs_defined
`define gem_defs_defined
`include "gem_gxl_defs.v"
`include "edma_defs.v"
`endif

module gem_mmsl_reg (

  input               pclk,
  input               n_preset,
  input               psel,
  input               penable,
  input         [5:0] paddr,
  input               pwrite,
  input        [31:0] pwdata,
  input         [3:0] pwdata_par,
  output  reg         pslverr,
  output  reg  [31:0] prdata,
  output        [3:0] prdata_par,

  output  reg         invert_mcrc,
  output  reg         mmsl_debug_mode,
  output  reg         route_rx_to_pmac,
  output  reg         pre_enable,
  output  reg         restart_ver_tog,
  output  reg         disable_verify,
  output  reg   [1:0] add_frag_size,
  output              mmsl_int,
  output              asf_csr_mmsl_err,

  input               p_active,           // Received from the tx Proc block
  input         [2:0] verify_status,      // Received from the verification block
  input               respond_status,     // Received from the verification block
  input               smd_error,          // Received from the rx Proc block
  input               smdc_error,         // Received from the rx Proc block
  input               smds_error,         // Received from the rx Proc block
  input               fr_count_error,     // Received from the rx Proc block
  input               frag_count_rx_td,   // Received from the rx Proc block
  input               ass_ok_count_td,    // Received from the rx Proc block
  input               smd_error_count_td, // Received from the rx Proc block
  input               ass_error_count_td, // Received from the rx Proc block
  input               frag_count_tx_td,   // Received from the tx Proc block
  input               rcv_v_error,        // Received from the rx Express Filter
  input               rcv_r_error         // Received from the rx Express Filter

);
   parameter p_edma_irq_read_clear  = 1'b0; // Configure whether interrupts are cleared on read
   parameter p_edma_asf_csr_prot    = 1'b0; // Parity protect registers
   parameter p_edma_asf_host_par    = 1'b0; // Parity on prdata

   parameter MMSL_CONTROL       = 6'h00;
   parameter MMSL_STATUS        = 6'h01;
   parameter MMSL_ERR_STATS     = 6'h02;
   parameter MMSL_ASS_OK_COUNT  = 6'h03;
   parameter MMSL_FRAG_COUNT_RX = 6'h04;
   parameter MMSL_FRAG_COUNT_TX = 6'h05;
   parameter MMSL_INT_STATUS    = 6'h06;
   parameter MMSL_INT_EN        = 6'h07;
   parameter MMSL_INT_DIS       = 6'h08;
   parameter MMSL_INT_MASK      = 6'h09;

   reg   [31:0] prdata_i;
   wire   [7:0] mmsl_control;
   wire  [31:0] mmsl_err_stats;
   wire  [31:0] mmsl_ass_ok_count;
   wire  [31:0] mmsl_frag_count_rx;
   wire  [31:0] mmsl_frag_count_tx;
   reg   [16:0] ass_ok_count;
   reg   [16:0] frag_count_rx;
   reg   [16:0] frag_count_tx;
   reg    [7:0] smd_error_count;
   reg    [7:0] ass_error_count;
   wire   [5:0] error_status;
   wire  [31:0] mmsl_status;
   wire   [5:0] int_status;
   wire   [5:0] int_mask;
   wire         write_registers;
   wire         read_registers;

   assign write_registers  =  pwrite && ~penable && psel;
   assign read_registers   = ~pwrite && ~penable && psel;

   // Write registers
   always @ (posedge pclk or negedge n_preset)
   begin
     if (~n_preset)
       begin
         restart_ver_tog <= 1'b0;
         add_frag_size   <= 2'b00;
         disable_verify  <= 1'b0;
         pre_enable      <= 1'b0;
         route_rx_to_pmac<= 1'b1;
         mmsl_debug_mode <= 1'b0;
         invert_mcrc     <= 1'b0;
       end
     else
       if(write_registers && (paddr == MMSL_CONTROL))
         begin
           add_frag_size    <= pwdata[1:0];
           disable_verify   <= pwdata[2];
           pre_enable       <= pwdata[3];
           route_rx_to_pmac <= pwdata[5];
           mmsl_debug_mode  <= pwdata[6];
           invert_mcrc      <= pwdata[7];
           if (pwdata[4])
             restart_ver_tog  <= ~restart_ver_tog;
         end
   end

   assign mmsl_control[1:0] = add_frag_size;
   assign mmsl_control[2]   = disable_verify;
   assign mmsl_control[3]   = pre_enable;
   assign mmsl_control[4]   = 1'b0;
   assign mmsl_control[5]   = route_rx_to_pmac;
   assign mmsl_control[6]   = mmsl_debug_mode;
   assign mmsl_control[7]   = invert_mcrc;

   // Interrupt and status registers
   assign error_status  = {smd_error,
                           fr_count_error,
                           smdc_error,
                           smds_error,
                           rcv_v_error,
                           rcv_r_error};

   // Instantiate interrupts and status
   gem_mmsl_reg_int_sts #(
    .MMSL_STATUS            (MMSL_STATUS),
    .MMSL_INT_STATUS        (MMSL_INT_STATUS),
    .MMSL_INT_EN            (MMSL_INT_EN),
    .MMSL_INT_DIS           (MMSL_INT_DIS),
    .MMSL_INT_MASK          (MMSL_INT_MASK),
    .p_edma_irq_read_clear  (p_edma_irq_read_clear)
   ) i_int_sts (
    .pclk             (pclk),
    .n_preset         (n_preset),
    .write_registers  (write_registers),
    .read_registers   (read_registers),
    .paddr            (paddr),
    .pwdata           (pwdata[5:0]),
    .p_active         (p_active),
    .verify_status    (verify_status),
    .respond_status   (respond_status),
    .error_status     (error_status),
    .mmsl_status      (mmsl_status),
    .int_status       (int_status),
    .int_mask         (int_mask),
    .mmsl_int         (mmsl_int)
   );

   // Optional registers protection for ASF
   generate if (p_edma_asf_csr_prot == 1) begin : gen_asf_prot
     reg          mmsl_control_par;
     wire         mmsl_control_err; // Parity error
     wire [31:0]  mmsl_status_d;    // Duplicated signals
     wire [5:0]   int_status_d;
     wire [5:0]   int_mask_d;
     wire         mmsl_int_d;

     // Store optional parity bit for mmsl_control
     // Note that we subtract bit 4 from the parity result as that
     // is a toggle bit and is not checked. It will always read back 0.
     always @ (posedge pclk or negedge n_preset)
     begin
       if (~n_preset)
         mmsl_control_par <= 1'b1;
       else if(write_registers && (paddr == MMSL_CONTROL))
         mmsl_control_par <= pwdata_par[0] ^ pwdata[4];
     end

     // Continually check
     cdnsdru_asf_parity_check_v1 #(.p_data_width(8)) i_par_chk (
       .odd_par   (1'b0),
       .data_in   (mmsl_control),
       .parity_in (mmsl_control_par),
       .parity_err(mmsl_control_err)
     );

     // Duplicate interrupt/status registers
     gem_mmsl_reg_int_sts #(
      .MMSL_STATUS            (MMSL_STATUS),
      .MMSL_INT_STATUS        (MMSL_INT_STATUS),
      .MMSL_INT_EN            (MMSL_INT_EN),
      .MMSL_INT_DIS           (MMSL_INT_DIS),
      .MMSL_INT_MASK          (MMSL_INT_MASK),
      .p_edma_irq_read_clear  (p_edma_irq_read_clear)
     ) i_int_sts_asf_duplc (
      .pclk             (pclk),
      .n_preset         (n_preset),
      .write_registers  (write_registers),
      .read_registers   (read_registers),
      .paddr            (paddr),
      .pwdata           (pwdata[5:0]),
      .p_active         (p_active),
      .verify_status    (verify_status),
      .respond_status   (respond_status),
      .error_status     (error_status),
      .mmsl_status      (mmsl_status_d),
      .int_status       (int_status_d),
      .int_mask         (int_mask_d),
      .mmsl_int         (mmsl_int_d)
     );

     // Signal ASF error if above parity did not match or there was a mismatch in the
     // duplicated module.
     assign asf_csr_mmsl_err  = mmsl_control_err |
                                ({mmsl_status_d,
                                  int_status_d,
                                  int_mask_d,
                                  mmsl_int_d}   != {mmsl_status,
                                                    int_status,
                                                    int_mask,
                                                    mmsl_int});
   end else begin : gen_no_asf_prot
     assign asf_csr_mmsl_err  = 1'b0;
   end
   endgenerate

   // Generating the statistic counters,
   // when the counter is all ones it doesnt' increment anymore and if that register is begin read
   // the counter is cleared. That means that all the LINT warning on potential loss of RHS msb can be
   // waived
   // Note that these are informational only and not protected
   always @ (posedge pclk or negedge n_preset)
   begin
     if(~n_preset)
       begin
         ass_ok_count    <= 17'd0;
         frag_count_rx   <= 17'd0;
         frag_count_tx   <= 17'd0;
         smd_error_count <= 8'd0;
         ass_error_count <= 8'd0;
       end
     else
       begin
         if(read_registers && (paddr == MMSL_ASS_OK_COUNT))
           ass_ok_count <= {16'd0, ass_ok_count_td};
         else if(ass_ok_count_td && ~&ass_ok_count)
           ass_ok_count <= ass_ok_count + 17'd1;

         if(read_registers && (paddr == MMSL_FRAG_COUNT_RX))
           frag_count_rx <= {16'd0, frag_count_rx_td};
         else if(frag_count_rx_td && ~&frag_count_rx)
           frag_count_rx <= frag_count_rx + 17'd1;

         if(read_registers && (paddr == MMSL_FRAG_COUNT_TX))
           frag_count_tx <= {16'd0, frag_count_tx_td};
         else if(frag_count_tx_td && ~&frag_count_tx)
           frag_count_tx <= frag_count_tx + 17'd1;

         if(read_registers && (paddr == MMSL_ERR_STATS))
           smd_error_count <= {7'd0, smd_error_count_td};
         else if(smd_error_count_td && ~&smd_error_count)
           smd_error_count <= smd_error_count + 8'd1;

         if(read_registers && (paddr == MMSL_ERR_STATS))
           ass_error_count <= {7'd0,ass_error_count_td};
         else if(ass_error_count_td && ~&ass_error_count)
           ass_error_count <= ass_error_count + 8'd1;
       end
   end

   // Statistics
   assign mmsl_err_stats     = {8'd0,            // 31:24
                               smd_error_count,  // 23:16
                               8'd0,             // 15:8
                               ass_error_count}; // 7:0

   assign mmsl_ass_ok_count  = {15'd0,         // 31:17
                               ass_ok_count};  // 16:0

   assign mmsl_frag_count_rx = {15'd0,         // 31:17
                               frag_count_rx}; // 16:0

   assign mmsl_frag_count_tx = {15'd0,         // 31:17
                               frag_count_tx}; // 16:0


   // Register read MUX
   always@(*)
   begin
     if (read_registers)
       case (paddr)
         MMSL_CONTROL       : prdata_i = {24'd0,  // Reserved
                              mmsl_control[7:0]};
         MMSL_STATUS        : prdata_i = mmsl_status;
         MMSL_ERR_STATS     : prdata_i = mmsl_err_stats;
         MMSL_ASS_OK_COUNT  : prdata_i = mmsl_ass_ok_count;
         MMSL_FRAG_COUNT_RX : prdata_i = mmsl_frag_count_rx;
         MMSL_FRAG_COUNT_TX : prdata_i = mmsl_frag_count_tx;
         MMSL_INT_STATUS    : prdata_i = {26'd0, int_status};
         MMSL_INT_MASK      : prdata_i = {26'd0, int_mask};
         default            : prdata_i = 32'd0;
       endcase
     else
       prdata_i = 32'd0;
   end

   // Read Registers
   always @ (posedge pclk or negedge n_preset)
   begin
     if (~n_preset)
       prdata <= 32'd0;
     else
       prdata <= prdata_i;
   end

   // pslverr generation
   always @ (posedge pclk or negedge n_preset)
   begin
     if(~n_preset)
       pslverr <= 1'b0;
     else if(psel)
       case (paddr)
         MMSL_CONTROL,
         MMSL_STATUS,
         MMSL_ERR_STATS,
         MMSL_ASS_OK_COUNT,
         MMSL_FRAG_COUNT_RX,
         MMSL_FRAG_COUNT_TX,
         MMSL_INT_EN,
         MMSL_INT_DIS,
         MMSL_INT_STATUS,
         MMSL_INT_MASK      : pslverr <= 1'b0;
         default            : pslverr <= 1'b1; // No match for this module
       endcase
     else
       pslverr <= 1'b0;
   end

   // Optional generate parity on prdata if p_edma_asf_host_par
   generate if (p_edma_asf_host_par == 1) begin : gen_host_par
     wire  [3:0] prdata_par_i;
     reg   [3:0] prdata_par_r;

     cdnsdru_asf_parity_gen_v1 #(.p_data_width(32)) i_gen_par (
       .odd_par(1'b0),
       .data_in(prdata_i),
       .data_out(),
       .parity_out(prdata_par_i)
     );
     always@(posedge pclk or negedge n_preset)
     begin
       if (~n_preset)
         prdata_par_r  <= 2'b00;
       else
         prdata_par_r  <= prdata_par_i;
     end
     assign prdata_par = prdata_par_r;
   end else begin : gen_no_host_par
     assign prdata_par  = 4'h0;
   end
   endgenerate

endmodule
