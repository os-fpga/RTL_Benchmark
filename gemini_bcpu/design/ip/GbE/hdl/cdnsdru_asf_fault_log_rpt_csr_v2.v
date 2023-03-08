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
//   Filename:           cdnsdru_asf_fault_log_rpt_csr_v2.v
//   Module Name:        cdnsdru_asf_fault_log_rpt_csr_v2
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
// Description    : ASF IP Fault logging and report submodule
//                  This module contains all interrupts and  status registers.
//------------------------------------------------------------------------------
//------------------------------------------------------------------------------


module cdnsdru_asf_fault_log_rpt_csr_v2 #(
  parameter p_add_sram_protect      = 1'b1,   // Set to add AFS SRAM protection fault logging and report.
  parameter p_add_sram_corr_count   = 1'b1,   // Add a 16-bit counter for correctable errors
  parameter p_add_sram_uncorr_count = 1'b1,   // Add a 16-bit counter for uncorrectable errors
  parameter p_add_dap_parity        = 1'b1,   // Set to add AFS Data and Address Paths  protection fault logging and report.
  parameter p_add_csr_parity        = 1'b1,   // Set to add AFS Configuration and Status Registers protection fault logging and report.
  parameter p_add_trans_to          = 1'b1,   // Set to add AFS Transaction Timeouts fault logging and report.
  parameter p_trans_to_status_width = 32'd32, // Defines number of transaction timeout sources (max=32,min=1).
  parameter p_trans_to_status_exists = {p_trans_to_status_width{1'b1}}, // Define transaction timeout bits which actually exists
  parameter p_add_protocol_check    = 1'b1,   // Set to add AFS Protocol fault logging and report.
  parameter p_protocol_status_width = 32'd32, // Defines number of protocol error sources (max=32,min=1).
  parameter p_protocol_status_exists = {p_protocol_status_width{1'b1}}, // Define protocol error bits which actually exists
  parameter p_add_integrity_check   = 1'b1,    //  Set to add AFS Integrity fault logging and report.
  //  ASF Register Map
  parameter ASF_INT_STATUS_ADDR               = 7'h00,
  parameter ASF_INT_RAW_STATUS_ADDR           = 7'h04,
  parameter ASF_INT_TEST_ADDR                 = 7'h0C,
  parameter ASF_SRAM_CORR_FAULT_STATUS_ADDR   = 7'h20,
  parameter ASF_SRAM_UNCORR_FAULT_STATUS_ADDR = 7'h24,
  parameter ASF_SRAM_FAULT_STATS_ADDR         = 7'h28,
  parameter ASF_TRANS_TO_FAULT_STATUS_ADDR    = 7'h38,
  parameter ASF_PROTOCOL_FAULT_STATUS_ADDR    = 7'h44
) (
   // system inputs.
   input                                 asf_clk,                     // Clock
   input                                 asf_reset_n,                 // Reset

   // ASF register interface inputs.
   input                                 asf_write_registers,         // Indicates write data to ASF interface registers
   input                                 asf_read_data,               // Indicates ASF read data. 
   input [6:0]                           asf_addr,                    // ASF address for accessing ASF registers
                                                                      // 32-bit aligned, bottom 2-bits of
                                                                      // address should always be 0
   input [31:0]                          asf_wdata,                   // ASF write data
   input                                 asf_sel,                     // ASF module select (assert high to access module)
   // ASF register interface outputs.
   output [31:0]                         asf_rdata_csr,               // ASF read data
   output                                asf_err_csr,                 // ASF register interface access error
                                                                      // Driven high when asf_sel is asserted
                                                                      // if address is undefined or reserved.

   // ASF fault indication and status/stats inputs
   input  [6:0]                          asf_fatal_nonfatal_select,       // ASF Fatal or non-Fatal Interrupt Selecetion Register
   input  [6:0]                          asf_int_mask,                    // ASF Interrupt Mask Register
   input                                 asf_sram_corr_fault,             // ASF SRAM correctable fault occurred
   input  [31:0]                         asf_sram_corr_fault_status,      // Status for ASF SRAM correctable faults
   input  [7:0]                          asf_sram_corr_fault_stats_upd,   // Update internal statistics count for number of SRAM correctable faults
   input                                 asf_sram_uncorr_fault,           // ASF SRAM uncorrectable fault occurred
   input  [31:0]                         asf_sram_uncorr_fault_status,    // Status for ASF SRAM uncorrectable faults
   input  [7:0]                          asf_sram_uncorr_fault_stats_upd, // Update internal statistics count for number of SRAM uncorrectable faults
   input                                 asf_dap_fault,                   // Data and address paths signal
   input                                 asf_csr_fault,                   // Configuration and Status Registers fault signal
   input  [p_trans_to_status_width-1:0]  asf_trans_to_fault_mask,         // Mask register for each ASF transaction timeout fault source
   input  [p_trans_to_status_width-1:0]  asf_trans_to_fault,              // ASF Transaction Timeout fault occurred
   input  [p_protocol_status_width-1:0]  asf_protocol_fault_mask,         // Mask register for each ASF protocol fault source
   input  [p_protocol_status_width-1:0]  asf_protocol_fault,              // ASF Protocol fault occurred
   input                                 asf_integrity_fault,             // ASF Integrity Check fault occurred

   // ASF comman output error indications
   // and fatal and non-fatal interrupts
   // The following 1 bit output signals which
   // are expected to be routed to the top level:
   output                                asf_sram_corr_err,             // SRAM correctable error indication
   output                                asf_sram_uncorr_err,           // SRAM uncorrectable error indication
   output                                asf_dap_err,                   // Data and Address Paths error indication
   output                                asf_csr_err,                   // Configuration and Status Registers error indication
   output                                asf_trans_to_err,              // Transaction Timeouts indication
   output                                asf_protocol_err,              // Protocol error indication
   output                                asf_integrity_err,             // Integrity error indication
   output                                asf_int_nonfatal,              // ASF non-fatal interrupt
   output                                asf_int_fatal                  // ASF fatal interrupt
);


// -----------------------------------------------------------------------------
//  wire and reg declarations
// -----------------------------------------------------------------------------

   // ASF interface registers (drive outputs)
   reg    [31:0]                         asf_rdata_csr_i;             // ASF read data
   reg                                   asf_err_csr_i;               // ASF register interface access error
                                                                      // Driven high when asf_sel is asserted
                                                                      // if address is undefined or reserved.

   // ASF register related to interrupt handling
   // bit 6 integrity error interrupt
   // bit 5 protocol error interrupt
   // bit 4 transaction timeouts error interrupt
   // bit 3 configuration and status registers error interrupt
   // bit 2 data and address paths parity error interrupt
   // bit 1 SRAM uncorrectable error interrupt
   // bit 0 SRAM correctable error interrupt
   wire   [6:0]                              asf_int_raw_status;              // ASF Interrupt Raw Status Register
   wire   [6:0]                              asf_int_status;                  // ASF Interrupt (masked) Status Register.

   // ASF registers
   wire   [7:0]                              asf_sram_corr_fault_inst;         // Last SRAM instance that generated fault
   wire   [23:0]                             asf_sram_corr_fault_addr;         // Last SRAM address that generated fault
   wire   [7:0]                              asf_sram_uncorr_fault_inst;       // Last SRAM instance that generated fault
   wire   [23:0]                             asf_sram_uncorr_fault_addr;       // Last SRAM address that generated fault
   wire   [15:0]                             asf_sram_fault_uncorr_stats;      // Count of number of uncorrectable errors
   wire   [15:0]                             asf_sram_fault_corr_stats;        // Count of number of correctable errors
   wire   [31:0]                             asf_trans_to_fault_status_padded; // Status bits for transaction timeouts faults
   wire   [31:0]                             asf_protocol_fault_status_padded; // Status bits for protocol faults

   // ASF interface timing and decoding
   wire                                      asf_int_test_active;             // emulate HW event: write-1 to ASF status registers
   wire                                      asf_int_status_write;            // Write to interrupt status registers
   wire                                      asf_trans_to_fault_status_write; // Write to Status register for transaction timeouts fault
   wire                                      asf_protocol_fault_status_write; // Write to Status register for protocols fault

// -----------------------------------------------------------------------------
//  Beginning of main code.
// -----------------------------------------------------------------------------

  // -----------------------------------------------------------------------------
  //  ASF interface timing and decoding
  // -----------------------------------------------------------------------------

   // emulate HW event: write-1 to ASF status registers
   assign asf_int_test_active  = asf_write_registers &
                                 (asf_addr == ASF_INT_TEST_ADDR);

   // Write to ASF interrupt status registers
   assign asf_int_status_write = asf_write_registers &
                                 ((asf_addr == ASF_INT_STATUS_ADDR) || (asf_addr == ASF_INT_RAW_STATUS_ADDR));

   // Write to Status register for transaction timeouts fault
   assign asf_trans_to_fault_status_write  = asf_write_registers &
                                 (asf_addr == ASF_TRANS_TO_FAULT_STATUS_ADDR);

   // Write to Status register for protocols fault
   assign asf_protocol_fault_status_write  = asf_write_registers &
                                 (asf_addr == ASF_PROTOCOL_FAULT_STATUS_ADDR);


//------------------------------------------------------------------------------
// ASF read data
//------------------------------------------------------------------------------

 always @(*)
   begin : gen_asf_read_data
   if (asf_read_data)
        begin
            case (asf_addr)
             ASF_INT_STATUS_ADDR              : asf_rdata_csr_i[31:0] = {25'd0,
                                                                          asf_int_status[6],
                                                                          asf_int_status[5],
                                                                          asf_int_status[4],
                                                                          asf_int_status[3],
                                                                          asf_int_status[2],
                                                                          asf_int_status[1],
                                                                          asf_int_status[0]};
             ASF_INT_RAW_STATUS_ADDR          : asf_rdata_csr_i[31:0] = {25'd0,
                                                                         asf_int_raw_status[6],
                                                                         asf_int_raw_status[5],
                                                                         asf_int_raw_status[4],
                                                                         asf_int_raw_status[3],
                                                                         asf_int_raw_status[2],
                                                                         asf_int_raw_status[1],
                                                                         asf_int_raw_status[0]};
             ASF_SRAM_CORR_FAULT_STATUS_ADDR   : asf_rdata_csr_i = {asf_sram_corr_fault_inst,asf_sram_corr_fault_addr};
             ASF_SRAM_UNCORR_FAULT_STATUS_ADDR : asf_rdata_csr_i = {asf_sram_uncorr_fault_inst,asf_sram_uncorr_fault_addr};
             ASF_SRAM_FAULT_STATS_ADDR         : asf_rdata_csr_i = {asf_sram_fault_uncorr_stats,asf_sram_fault_corr_stats};
             ASF_TRANS_TO_FAULT_STATUS_ADDR    : asf_rdata_csr_i = asf_trans_to_fault_status_padded;
             ASF_PROTOCOL_FAULT_STATUS_ADDR    : asf_rdata_csr_i = asf_protocol_fault_status_padded;
             default : asf_rdata_csr_i = 32'd0;
           endcase // end case
        end // end if
      else 
        asf_rdata_csr_i = 32'd0;
   end  // asf_read_data

  assign asf_rdata_csr = asf_rdata_csr_i;

//------------------------------------------------------------------------------
// drive asf_err when address not recognised.
//------------------------------------------------------------------------------

   // asf_err output is driven when asf_addr does not match any know address
  always @(posedge asf_clk or negedge asf_reset_n)
   begin : p_asf_err
      if (~asf_reset_n)
         asf_err_csr_i <= 1'b0;
      else
          if (asf_sel)
         case (asf_addr)
             ASF_INT_STATUS_ADDR,
             ASF_INT_RAW_STATUS_ADDR,
             ASF_INT_TEST_ADDR                 : asf_err_csr_i <= 1'b0;

             ASF_SRAM_CORR_FAULT_STATUS_ADDR,
             ASF_SRAM_UNCORR_FAULT_STATUS_ADDR : asf_err_csr_i <= (p_add_sram_protect == 0);
             ASF_SRAM_FAULT_STATS_ADDR         : asf_err_csr_i <= (p_add_sram_protect == 0) 
                                                                | ((p_add_sram_uncorr_count == 0) & (p_add_sram_corr_count == 0));

             ASF_TRANS_TO_FAULT_STATUS_ADDR    : asf_err_csr_i <= (p_add_trans_to == 0);

             ASF_PROTOCOL_FAULT_STATUS_ADDR    :  asf_err_csr_i <= (p_add_protocol_check == 0);

            default                   : asf_err_csr_i <= 1'b1;
         endcase
      else
         asf_err_csr_i <= 1'b0;
   end // block: p_asf_err.

   assign asf_err_csr = asf_err_csr_i;

generate if(p_add_integrity_check == 1'b1) begin  : gen_integrity_check_added
   // ASF Interrupt Raw Status Register
   // this sets bit 6 in the ASF status register when
   // Integrity fault is detected,
   // set on rising edge of asf_integrity_fault.
   // Emulate HW event by SW Write-1 to ASF interrupt test register.
   // Cleared by SW write-1 to ASF interrupt status registers.
   reg asf_int_raw_status_r6;              // ASF Interrupt Raw Status Register
   always@(posedge asf_clk or negedge asf_reset_n)
   begin
      if (~asf_reset_n)
         asf_int_raw_status_r6 <= 1'b0;
      else if (asf_integrity_fault | (asf_int_test_active & asf_wdata[6]))
         asf_int_raw_status_r6 <= 1'b1;   // fault is detected or emulate HW event
      else if (asf_int_status_write & asf_wdata[6])
         asf_int_raw_status_r6 <= 1'b0;   // Clear
   end
   assign asf_int_raw_status[6] = asf_int_raw_status_r6;
end else begin : gen_no_integrity_check
   assign asf_int_raw_status[6] = 1'b0;
end
endgenerate

  //------------------------------------------------------------------------------
  // ASF protocol faults
  // --------------------------------------------------------------------------
generate if(p_add_protocol_check == 1'b1) begin  : gen_protocol_check_added
   // ASF Interrupt Raw Status Register
   // this sets bit 5 in the ASF status register when
   // Protocol fault is detected,
   // set on rising edge of asf_protocol_fault.
   // Emulate HW event by SW Write-1 to ASF interrupt test register.
   // Cleared by SW write-1 to ASF interrupt status registers.
   reg asf_int_raw_status_r5;              // ASF Interrupt Raw Status Register
   always@(posedge asf_clk or negedge asf_reset_n)
   begin
      if (~asf_reset_n)
         asf_int_raw_status_r5 <= 1'b0;
      else if ((|(asf_protocol_fault & ~asf_protocol_fault_mask)) | (asf_int_test_active & asf_wdata[5]))
         asf_int_raw_status_r5 <= 1'b1;   // fault is detected or emulate HW event
      else if (asf_int_status_write & asf_wdata[5])
         asf_int_raw_status_r5 <= 1'b0;   // Clear
   end
   assign asf_int_raw_status[5] = asf_int_raw_status_r5;

  // Status register for protocol faults
  // If a fault occurs the relevant status bit will be set to 1
  // Each bit can be cleared by software writing 1 to each bit
  // Interrupt status
  wire [p_protocol_status_width-1:0] asf_protocol_fault_status_w;       // Status bits for protocol faults
  genvar n;
  for (n=0; n <  p_protocol_status_width[31:0]; n=n+1)
  begin : gen_asf_protocol_fault_status
    if (p_protocol_status_exists[n])
    begin : gen_asf_protocol_fault_status_exists
      reg asf_protocol_fault_status_rn;
      always @ (posedge asf_clk or negedge asf_reset_n)
      begin
        if (~asf_reset_n)
          asf_protocol_fault_status_rn <= 1'b0;
        // Set based on trigger
        else if (asf_protocol_fault[n] & ~asf_protocol_fault_mask[n])
          asf_protocol_fault_status_rn <= 1'b1;
        // Clear by  writing
        else if (asf_protocol_fault_status_write & asf_wdata[n])
          asf_protocol_fault_status_rn <= 1'b0;
        else
          asf_protocol_fault_status_rn <= asf_protocol_fault_status_rn;
      end
      assign asf_protocol_fault_status_w[n] = asf_protocol_fault_status_rn;
    end else begin : gen_asf_protocol_fault_status_no_exists
      assign asf_protocol_fault_status_w[n] = 1'b0;
    end // gen_asf_protocol_fault_status_no_exists
  end // gen_asf_protocol_fault_status

   if (p_protocol_status_width == 32'd32) begin : gen_protocol_status_no_pad
     assign asf_protocol_fault_status_padded = asf_protocol_fault_status_w;
   end else begin : gen_protocol_status_pad
     assign asf_protocol_fault_status_padded = {{(32-p_protocol_status_width){1'b0}},asf_protocol_fault_status_w[p_protocol_status_width-1:0]};
   end
end else begin : gen_no_protocol_check
   assign asf_int_raw_status[5] = 1'b0;
   assign asf_protocol_fault_status_padded = 32'd0;
end
endgenerate

  //------------------------------------------------------------------------------
  // Transaction Timeouts fault
  // --------------------------------------------------------------------------
generate if(p_add_trans_to == 1'b1) begin  : gen_trans_to_added
   // ASF Interrupt Raw Status Register
   // this sets bit 4 in the ASF status register when
   // Transaction Timeouts is detected,
   // set on rising edge of asf_trans_to_fault.
   // Emulate HW event by SW Write-1 to ASF interrupt test register.
   // Cleared by SW write-1 to ASF interrupt status registers.
   reg asf_int_raw_status_r4;              // ASF Interrupt Raw Status Register
   always@(posedge asf_clk or negedge asf_reset_n)
   begin
      if (~asf_reset_n)
         asf_int_raw_status_r4 <= 1'b0;
      else if (|(asf_trans_to_fault & ~asf_trans_to_fault_mask) | (asf_int_test_active & asf_wdata[4]))
         asf_int_raw_status_r4 <= 1'b1;   // fault is detected or emulate HW event
      else if (asf_int_status_write & asf_wdata[4])
         asf_int_raw_status_r4 <= 1'b0;   // Clear
   end
   assign asf_int_raw_status[4] = asf_int_raw_status_r4;

  // Status register for transaction timeouts fault
  // If a fault occurs the relevant status bit will be set to 1
  // Each bit can be cleared by software writing 1 to each bit
  // Interrupt status
  wire [p_trans_to_status_width-1:0] asf_trans_to_fault_status_w;       // Status bits for transaction timeouts faults
  genvar m;
  for (m=0; m < p_trans_to_status_width; m=m+1)
  begin : gen_asf_trans_to_fault_status
    if (p_trans_to_status_exists[m])
    begin : gen_asf_trans_to_fault_status_exists
      reg asf_trans_to_fault_status_rm;
      always @ (posedge asf_clk or negedge asf_reset_n)
      begin
        if (~asf_reset_n)
          asf_trans_to_fault_status_rm <= 1'b0;
        // Set based on trigger
        else if (asf_trans_to_fault[m] & ~asf_trans_to_fault_mask[m])
          asf_trans_to_fault_status_rm <= 1'b1;
        // Clear by  writing
        else if (asf_trans_to_fault_status_write & asf_wdata[m])
          asf_trans_to_fault_status_rm <= 1'b0;
        else
          asf_trans_to_fault_status_rm <= asf_trans_to_fault_status_rm;
      end
      assign asf_trans_to_fault_status_w[m] = asf_trans_to_fault_status_rm;
    end else begin : gen_asf_trans_to_fault_status_no_exists
      assign asf_trans_to_fault_status_w[m] = 1'b0;
    end // gen_asf_trans_to_fault_status_no_exists
  end // gen_asf_trans_to_fault_status

    if (p_trans_to_status_width == 32'd32) begin : gen_trans_to_no_pad
      assign asf_trans_to_fault_status_padded = asf_trans_to_fault_status_w;
    end else begin : gen_trans_to_pad
      assign asf_trans_to_fault_status_padded = {{(32-p_trans_to_status_width){1'b0}},asf_trans_to_fault_status_w[p_trans_to_status_width-1:0]};
    end
end else begin : gen_no_trans_to
   assign asf_int_raw_status[4] = 1'b0;
   assign asf_trans_to_fault_status_padded = 32'd0;
end
endgenerate

//------------------------------------------------------------------------------
// Configuration and Status Registers protection
// --------------------------------------------------------------------------
generate if(p_add_csr_parity == 1'b1) begin  : gen_csr_parity_added
   // ASF Interrupt Raw Status Register
   // this sets bit 3 in the ASF status register when
   // Configuration and Status Registers fault is detected,
   // set on rising edge of asf_csr_fault.
   // Emulate HW event by SW Write-1 to ASF interrupt test register.
   // Cleared by SW write-1 to ASF interrupt status registers.
   reg asf_int_raw_status_r3;              // ASF Interrupt Raw Status Register
   always@(posedge asf_clk or negedge asf_reset_n)
   begin
      if (~asf_reset_n)
         asf_int_raw_status_r3 <= 1'b0;
      else if (asf_csr_fault | (asf_int_test_active & asf_wdata[3]))
         asf_int_raw_status_r3 <= 1'b1;   // fault is detected or emulate HW event
      else if (asf_int_status_write & asf_wdata[3])
         asf_int_raw_status_r3 <= 1'b0;   // Clear
   end
   assign asf_int_raw_status[3] = asf_int_raw_status_r3;
end else begin : gen_no_csr_parity
   assign asf_int_raw_status[3] = 1'b0;
end
endgenerate

//------------------------------------------------------------------------------
// Data and Address Paths  protection
// --------------------------------------------------------------------------
generate if(p_add_dap_parity == 1'b1) begin  : gen_dap_parity_added
   // ASF Interrupt Raw Status Register
   // this sets bit 2 in the ASF status register when
   // Data or Address Path fault is detected,
   // set on rising edge of asf_dap_fault.
   // Emulate HW event by SW Write-1 to ASF interrupt test register.
   // Cleared by SW write-1 to ASF interrupt status registers.
   reg asf_int_raw_status_r2;              // ASF Interrupt Raw Status Register
   always@(posedge asf_clk or negedge asf_reset_n)
   begin
      if (~asf_reset_n)
         asf_int_raw_status_r2 <= 1'b0;
      else if (asf_dap_fault | (asf_int_test_active & asf_wdata[2]))
         asf_int_raw_status_r2 <= 1'b1;   // fault is detected or emulate HW event
      else if (asf_int_status_write & asf_wdata[2])
         asf_int_raw_status_r2 <= 1'b0;   // Clear
   end
   assign asf_int_raw_status[2] = asf_int_raw_status_r2;
end else begin : gen_no_dap_parity
   assign asf_int_raw_status[2] = 1'b0;
end
endgenerate

//------------------------------------------------------------------------------
// SRAM (un)correctable fault
// --------------------------------------------------------------------------
generate if(p_add_sram_protect == 1'b1) begin  : gen_sram_protect_added
   reg          asf_int_raw_status_r1;           // ASF Interrupt Raw Status Register
   reg          asf_int_raw_status_r0;           // ASF Interrupt Raw Status Register
   reg    [7:0] asf_sram_corr_fault_inst_r;      // Last SRAM instance that generated fault
   reg   [23:0] asf_sram_corr_fault_addr_r;      // Last SRAM address that generated fault
   reg    [7:0] asf_sram_uncorr_fault_inst_r;    // Last SRAM instance that generated fault
   reg   [23:0] asf_sram_uncorr_fault_addr_r;    // Last SRAM address that generated fault

   // ASF Interrupt Raw Status Register
   // this sets bit 1 in the ASF status register when
   // SRAM uncorrectable fault is detected,
   // set on rising edge of asf_sram_uncorr_fault.
   // Emulate HW event by SW Write-1 to ASF interrupt test register.
   // Cleared by SW write-1 to ASF interrupt status registers.
   always@(posedge asf_clk or negedge asf_reset_n)
   begin
      if (~asf_reset_n)
         asf_int_raw_status_r1 <= 1'b0;
      else if (asf_sram_uncorr_fault | (asf_int_test_active & asf_wdata[1]))
         asf_int_raw_status_r1 <= 1'b1;   // fault is detected or emulate HW event
      else if (asf_int_status_write & asf_wdata[1])
         asf_int_raw_status_r1 <= 1'b0;   // Clear
   end
   assign asf_int_raw_status[1] = asf_int_raw_status_r1;

   // ASF Interrupt Raw Status Register
   // this sets bit 0 in the ASF status register when
   // SRAM correctable fault is detected,
   // set on rising edge of asf_sram_corr_fault.
   // Emulate HW event by SW Write-1 to ASF interrupt test register.
   // Cleared by SW write-1 to ASF interrupt status registers.
   always@(posedge asf_clk or negedge asf_reset_n)
   begin
      if (~asf_reset_n)
         asf_int_raw_status_r0 <= 1'b0;
      else if (asf_sram_corr_fault | (asf_int_test_active & asf_wdata[0]))
         asf_int_raw_status_r0 <= 1'b1;   // fault is detected or emulate HW event
      else if (asf_int_status_write & asf_wdata[0])
         asf_int_raw_status_r0 <= 1'b0;   // Clear
   end
   assign asf_int_raw_status[0] = asf_int_raw_status_r0;

  //------------------------------------------------------------------------------
  // Status register for SRAM (un)correctable fault
  // --------------------------------------------------------------------------
   always@(posedge asf_clk or negedge asf_reset_n)
   begin
      if (~asf_reset_n) begin 
         asf_sram_corr_fault_inst_r[7:0]  <= 8'h00;
         asf_sram_corr_fault_addr_r[23:0] <= 24'h000000;
      end else begin
         if (asf_sram_corr_fault) begin
           asf_sram_corr_fault_inst_r[7:0]  <= asf_sram_corr_fault_status[31:24];
           asf_sram_corr_fault_addr_r[23:0] <= asf_sram_corr_fault_status[23:0];
         end
      end // else
   end // always
   always@(posedge asf_clk or negedge asf_reset_n)
   begin
      if (~asf_reset_n) begin 
         asf_sram_uncorr_fault_inst_r[7:0]  <= 8'h00;
         asf_sram_uncorr_fault_addr_r[23:0] <= 24'h000000;
      end else begin
         if (asf_sram_uncorr_fault) begin
           asf_sram_uncorr_fault_inst_r[7:0]  <= asf_sram_uncorr_fault_status[31:24];
           asf_sram_uncorr_fault_addr_r[23:0] <= asf_sram_uncorr_fault_status[23:0];
         end
      end // else
   end // always
   assign asf_sram_corr_fault_inst   = asf_sram_corr_fault_inst_r;
   assign asf_sram_corr_fault_addr   = asf_sram_corr_fault_addr_r;
   assign asf_sram_uncorr_fault_inst = asf_sram_uncorr_fault_inst_r;
   assign asf_sram_uncorr_fault_addr = asf_sram_uncorr_fault_addr_r;

   /////////////////////////////////////////
   //  Statistics register for SRAM faults.
  if(p_add_sram_uncorr_count == 1) begin : gen_asf_sram_uncorr_count
     // Count of number of uncorrectable errors
     // Update internal statistics count for number of SRAM uncorrectable faults. This update
     // value is added to an internal accumulator and will be sampled on asf_sram_uncorr_fault.
    reg  [15:0] asf_sram_fault_uncorr_stats_r;   // Count of number of uncorrectable errors
    wire [16:0] uncorr_stats_nxt;                // wire for the Count of number of uncorrectable errors
    assign uncorr_stats_nxt[16:0] = asf_sram_fault_uncorr_stats[15:0] + {8'h00,asf_sram_uncorr_fault_stats_upd};
    always @(posedge asf_clk or negedge asf_reset_n)
    begin
      if (~asf_reset_n)
        asf_sram_fault_uncorr_stats_r <= 16'h0000;
      else if (asf_write_registers & asf_addr == ASF_SRAM_FAULT_STATS_ADDR)
        asf_sram_fault_uncorr_stats_r <= 16'h0000;
      else if (asf_sram_uncorr_fault) begin
        if (uncorr_stats_nxt[16]) 
          asf_sram_fault_uncorr_stats_r <= 16'hffff;
        else 
          asf_sram_fault_uncorr_stats_r <= uncorr_stats_nxt[15:0];
      end else
        asf_sram_fault_uncorr_stats_r <= asf_sram_fault_uncorr_stats_r;
    end
    assign asf_sram_fault_uncorr_stats = asf_sram_fault_uncorr_stats_r;
  end // gen_asf_sram_uncorr_count
  else begin : gen_asf_sram_uncorr_no_count
    assign asf_sram_fault_uncorr_stats = 16'h0000;
  end
  if(p_add_sram_corr_count == 1) begin : gen_asf_sram_corr_count
     // Count of number of correctable errors
     // Update internal statistics count for number of SRAM correctable faults. This update
     // value is added to an internal accumulator and will be sampled on asf_sram_corr_fault.
    reg  [15:0] asf_sram_fault_corr_stats_r;     // Count of number of correctable errors
    wire [16:0] corr_stats_nxt;                  // wire for the Count of number of correctable errors
    assign corr_stats_nxt[16:0] = asf_sram_fault_corr_stats[15:0] + {8'h00,asf_sram_corr_fault_stats_upd};
    always @(posedge asf_clk or negedge asf_reset_n)
    begin
      if (~asf_reset_n)
        asf_sram_fault_corr_stats_r <= 16'h0000;
      else if (asf_write_registers & asf_addr == ASF_SRAM_FAULT_STATS_ADDR)
        asf_sram_fault_corr_stats_r <= 16'h0000;
      else if (asf_sram_corr_fault) begin
        if (corr_stats_nxt[16]) 
          asf_sram_fault_corr_stats_r <= 16'hffff;
        else 
          asf_sram_fault_corr_stats_r <= corr_stats_nxt[15:0];
      end else
        asf_sram_fault_corr_stats_r <= asf_sram_fault_corr_stats_r;
    end
    assign asf_sram_fault_corr_stats = asf_sram_fault_corr_stats_r;
  end // gen_asf_sram_corr_count
  else begin : gen_asf_sram_corr_no_count
    assign asf_sram_fault_corr_stats = 16'h0000;
  end
end else begin : gen_no_sram_protect
   assign asf_int_raw_status[1]       = 1'b0;
   assign asf_int_raw_status[0]       = 1'b0;
   assign asf_sram_corr_fault_inst    = 8'h00;
   assign asf_sram_corr_fault_addr    = 24'h000000;
   assign asf_sram_uncorr_fault_inst  = 8'h00;
   assign asf_sram_uncorr_fault_addr  = 24'h000000;
   assign asf_sram_fault_uncorr_stats = 16'h0000;
   assign asf_sram_fault_corr_stats   = 16'h0000;
end
endgenerate

  //------------------------------------------------------------------------------
  // ASF Interrupt (masked) Status Register
  // --------------------------------------------------------------------------

   assign asf_int_status   = asf_int_raw_status[6:0] & ~asf_int_mask[6:0];

  //------------------------------------------------------------------------------
  // ASF comman output error indications
  // --------------------------------------------------------------------------

   assign asf_integrity_err   = asf_int_raw_status[6];
   assign asf_protocol_err    = asf_int_raw_status[5];
   assign asf_trans_to_err    = asf_int_raw_status[4];
   assign asf_csr_err         = asf_int_raw_status[3];
   assign asf_dap_err         = asf_int_raw_status[2];
   assign asf_sram_uncorr_err = asf_int_raw_status[1];
   assign asf_sram_corr_err   = asf_int_raw_status[0];

  //------------------------------------------------------------------------------
  // ASF fatal and non-fatal interrupts
  // --------------------------------------------------------------------------

   assign asf_int_nonfatal   = (asf_int_status[6] & ~asf_fatal_nonfatal_select[6])
                               | (asf_int_status[5] & ~asf_fatal_nonfatal_select[5])
                               | (asf_int_status[4] & ~asf_fatal_nonfatal_select[4])
                               | (asf_int_status[3] & ~asf_fatal_nonfatal_select[3])
                               | (asf_int_status[2] & ~asf_fatal_nonfatal_select[2])
                               | (asf_int_status[1] & ~asf_fatal_nonfatal_select[1])
                               | (asf_int_status[0] & ~asf_fatal_nonfatal_select[0]);

   assign asf_int_fatal      = (asf_int_status[6] & asf_fatal_nonfatal_select[6])
                               | (asf_int_status[5] & asf_fatal_nonfatal_select[5])
                               | (asf_int_status[4] & asf_fatal_nonfatal_select[4])
                               | (asf_int_status[3] & asf_fatal_nonfatal_select[3])
                               | (asf_int_status[2] & asf_fatal_nonfatal_select[2])
                               | (asf_int_status[1] & asf_fatal_nonfatal_select[1])
                               | (asf_int_status[0] & asf_fatal_nonfatal_select[0]);

endmodule
