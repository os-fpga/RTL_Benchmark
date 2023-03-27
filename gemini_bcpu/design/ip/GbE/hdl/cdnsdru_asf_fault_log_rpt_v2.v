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
//   Filename:           cdnsdru_asf_fault_log_rpt_v2.v
//   Module Name:        cdnsdru_asf_fault_log_rpt_v2
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
// Description    : ASF IP Fault logging and report reuse component
//                  This module provides generic status bus inputs for each ASF 
//                  function to convey further status information to the customer
//                  software to further identify the cause of any faults.
//                  The AFS fault logging and report component contains of 
//                  interrupt (masked and raw) status registers, status and
//                  statistics registers and control registers.
//                  The module defines six different ASF functions, each of
//                  which has its own set of fault and status inputs.
//------------------------------------------------------------------------------
//------------------------------------------------------------------------------


module cdnsdru_asf_fault_log_rpt_v2 #(
  parameter p_add_sram_protect      = 1'b1,   // Set to add AFS SRAM protection fault logging and report.
  parameter p_add_sram_corr_count   = 1'b1,   // Add a 16-bit counter for correctable errors
  parameter p_add_sram_uncorr_count = 1'b1,   // Add a 16-bit counter for uncorrectable errors
  parameter p_add_dap_parity        = 1'b1,   // Set to add AFS Data and Address Paths  protection fault logging and report.
  parameter p_add_csr_parity        = 1'b1,   // Set to add AFS Configuration and Status Registers protection fault logging and report.
  parameter p_add_trans_to          = 1'b1,   // Set to add AFS Transaction Timeouts fault logging and report.
  parameter p_add_trans_to_ctrl = p_add_trans_to, //c ontrol whether the transaction timeout control register is present or not
  parameter p_trans_to_status_width = 32'd32, // Defines number of transaction timeout sources (max=32,min=1).
  parameter p_trans_to_status_exists = {p_trans_to_status_width{1'b1}}, // Define transaction timeout bits which actually exists
  parameter p_add_protocol_check    = 1'b1,   // Set to add AFS Protocol fault logging and report.
  parameter p_protocol_status_width = 32'd32, // Defines number of protocol error sources (max=32,min=1).
  parameter p_protocol_status_exists = {p_protocol_status_width{1'b1}}, // Define protocol error bits which actually exists
  parameter p_add_integrity_check   = 1'b1,   // Set to add AFS Integrity fault logging and report.

  // internal parameters
  parameter p_trans_to_status_par_width = ((p_trans_to_status_width+32'd7)/32'd8),  // number of parity protection for 
  parameter p_trans_to_status_int_width = p_trans_to_status_par_width*32'd8,    // transaction timeout status width padded (byte-wise)
  parameter p_protocol_status_par_width = ((p_protocol_status_width+32'd7)/32'd8),  // number of parity protection for
  parameter p_protocol_status_int_width = p_protocol_status_par_width*32'd8     // Protocol status width padded (byte-wise)
) (
   // system inputs.
   input                                 asf_clk,                     // Clock
   input                                 asf_reset_n,                 // Reset

   // ASF register interface inputs.
   input [6:0]                           asf_addr,                    // ASF address for accessing ASF registers
                                                                      // 32-bit aligned, bottom 2-bits of
                                                                      // address should always be 0
   input [31:0]                          asf_wdata,                   // ASF write data
   input [3:0]                           asf_wdata_par,               // Parity associated with asf_wdata
   input                                 asf_write,                   // ASF write strobe
   input                                 asf_sel,                     // ASF module select (assert high to access module)
   // ASF register interface outputs.
   output [31:0]                         asf_rdata,                   // ASF read data
   output [3:0]                          asf_rdata_par,               // Parity associated with asf_rdata
   output                                asf_err,                     // ASF register interface access error
                                                                      // Driven high when asf_sel is asserted
                                                                      // if address is undefined or reserved.

   // ASF fault indication and status/stats inputs
   input                                 asf_sram_corr_fault,             // ASF SRAM correctable fault occurred
   input  [31:0]                         asf_sram_corr_fault_status,      // Status for ASF SRAM correctable faults
   input  [7:0]                          asf_sram_corr_fault_stats_upd,   // Update internal statistics count for number of SRAM correctable faults
   input                                 asf_sram_uncorr_fault,           // ASF SRAM uncorrectable fault occurred
   input  [31:0]                         asf_sram_uncorr_fault_status,    // Status for ASF SRAM uncorrectable faults
   input  [7:0]                          asf_sram_uncorr_fault_stats_upd, // Update internal statistics count for number of SRAM uncorrectable faults
   input                                 asf_dap_fault,                   // Data and address paths signal
   input                                 asf_csr_fault,                   // Configuration and Status Registers fault signal
   input  [p_trans_to_status_width-1:0]  asf_trans_to_fault,              // ASF Transaction Timeout fault occurred
   input  [p_protocol_status_width-1:0]  asf_protocol_fault,              // ASF Protocol fault occurred
   input                                 asf_integrity_fault,             // ASF Integrity Check fault occurred

   // ASF control outputs
   output                                asf_trans_to_en,                 // Enable transaction timeout monitor
   output [15:0]                         asf_trans_to_time,               // Software programmable timeout timer reset value

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
//  ASF Register Map
// -----------------------------------------------------------------------------

   localparam ASF_INT_STATUS_ADDR               = 7'h00;
   localparam ASF_INT_RAW_STATUS_ADDR           = 7'h04;
   localparam ASF_INT_MASK_ADDR                 = 7'h08;
   localparam ASF_INT_TEST_ADDR                 = 7'h0C;
   localparam ASF_FATAL_NONFATAL_SELECT_ADDR    = 7'h10;
   localparam ASF_SRAM_CORR_FAULT_STATUS_ADDR   = 7'h20;
   localparam ASF_SRAM_UNCORR_FAULT_STATUS_ADDR = 7'h24;
   localparam ASF_SRAM_FAULT_STATS_ADDR         = 7'h28;
   localparam ASF_TRANS_TO_CTRL_ADDR            = 7'h30;
   localparam ASF_TRANS_TO_FAULT_MASK_ADDR      = 7'h34;
   localparam ASF_TRANS_TO_FAULT_STATUS_ADDR    = 7'h38;
   localparam ASF_PROTOCOL_FAULT_MASK_ADDR      = 7'h40;
   localparam ASF_PROTOCOL_FAULT_STATUS_ADDR    = 7'h44;

// -----------------------------------------------------------------------------
//  wire and reg declarations
// -----------------------------------------------------------------------------

   // ASF interface registers (drive outputs)
   reg    [31:0]                         asf_rdata_i;                 // ASF read data
   reg                                   asf_err_i;                   // ASF register interface access error
                                                                      // Driven high when asf_sel is asserted
                                                                      // if address is undefined or reserved.
   wire   [31:0]                         asf_rdata_csr;               // ASF read data from  Register status information submodule
   wire                                  asf_err_csr;                 // ASF register interface access error from  Register status information submodule
                                                                      // Driven high when asf_sel is asserted
                                                                      // if address is undefined or reserved.

   // ASF register related to interrupt handling
   // bit 7 unused (needed to be byte wise when checked against parity bits)
   // bit 6 integrity error interrupt
   // bit 5 protocol error interrupt
   // bit 4 transaction timeouts error interrupt
   // bit 3 configuration and status registers error interrupt
   // bit 2 data and address paths parity error interrupt
   // bit 1 SRAM uncorrectable error interrupt
   // bit 0 SRAM correctable error interrupt
   reg    [7:0]                              asf_fatal_nonfatal_select;       // ASF Fatal or non-Fatal Interrupt Selecetion Register
   reg    [7:0]                              asf_int_mask;                    // ASF Interrupt Mask Register

   // ASF mask padding
   wire   [31:0]                             asf_trans_to_fault_mask_padded;  // Mask register for each ASF transaction timeout fault source
   wire   [31:0]                             asf_protocol_fault_mask_padded;  // Mask register for each ASF protocol fault source

   // ASF interface timing and decoding
   wire                                      asf_write_registers;             // write data to ASF interface registers
   wire                                      asf_read_data;                   // ASF read data

   wire                                      int_csr_parity_err;              // CSR error Indication from CSR in this module
   wire                                      int_asf_csr_fault;               // internal and external CSR fault

   wire                                      asf_trans_to_en_err;             // asf_trans_to_en_err
   wire                                      asf_trans_to_time_err;           // asf_trans_to_time
   wire                                      asf_trans_to_fault_mask_err;     // asf_trans_to_fault_mask_err
   wire                                      asf_protocol_fault_mask_err;     // asf_protocol_fault_mask_err
// -----------------------------------------------------------------------------
//  Beginning of main code.
// -----------------------------------------------------------------------------

  // -----------------------------------------------------------------------------
  //  ASF interface timing and decoding
  // -----------------------------------------------------------------------------

   // Indicates write data to ASF interface registers
   assign asf_write_registers  =  asf_write & asf_sel;

   // Indicates ASF read data 
   assign asf_read_data        = ~asf_write & asf_sel;

  // -----------------------------------------------------------------------------
  //  Write data to ASF interface registers
  // -----------------------------------------------------------------------------
 always @(posedge asf_clk or negedge asf_reset_n)
   begin : gen_asf_write_registers
     if(~asf_reset_n) begin
         asf_int_mask                                <= 8'h7F;
         asf_fatal_nonfatal_select                   <= 8'h7F;
     end else begin //begin if not reset
         
         if(asf_write_registers) begin // begin module selected
           case (asf_addr)
             ASF_INT_MASK_ADDR              : begin
                                                asf_int_mask     <= asf_wdata[7:0];
                                              end  // ASF_INT_MASK_ADDR
             ASF_FATAL_NONFATAL_SELECT_ADDR : begin
                                                asf_fatal_nonfatal_select     <= asf_wdata[7:0];
                                              end  // ASF_FATAL_NONFATAL_SELECT_ADDR
             default : begin // no register match so maintain values
                         asf_int_mask              <= asf_int_mask;
                         asf_fatal_nonfatal_select <= asf_fatal_nonfatal_select;
                       end
           endcase // end case
         end // end  module selected 
     end // end if not reset
   end  // end asf_write_registers


  // ASF Transaction Timeouts fault
generate if(p_add_trans_to == 1'b1) begin  : gen_trans_to_added
   reg    [p_trans_to_status_int_width-1:0]  asf_trans_to_fault_mask_r;       // Mask register for each ASF transaction timeout fault source

  if(p_add_trans_to_ctrl == 1'b1) begin  : gen_trans_to_ctrl
    reg                                       asf_trans_to_en_r;               // Enable transaction timeout monitoring
    reg    [15:0]                             asf_trans_to_time_r;             // Timer value to use for transaction timeout monitor

    always @(posedge asf_clk or negedge asf_reset_n)
    begin : gen_asf_write_registers
      if(~asf_reset_n) begin
         asf_trans_to_en_r                <= 1'b0;
         asf_trans_to_time_r              <= 16'h0000;
      end else begin //begin if not reset
         if(asf_write_registers && (asf_addr==ASF_TRANS_TO_CTRL_ADDR) ) begin 
            asf_trans_to_en_r             <= asf_wdata[31];
            asf_trans_to_time_r           <= asf_wdata[15:0];
         end
      end
    end  // end gen_asf_write_registers
    assign asf_trans_to_en       = asf_trans_to_en_r;
    assign asf_trans_to_time     = asf_trans_to_time_r;
    if( p_add_csr_parity == 1'b1) begin : gen_trans_to_csr_protect
      reg                                       asf_trans_to_en_par_r;           // Parity protection for Enable transaction timeout monitoring
      reg    [1:0]                              asf_trans_to_time_par_r;         // Parity protection for Timer value to use for transaction timeout monitor

      always @(posedge asf_clk or negedge asf_reset_n)
      begin : gen_asf_write_registers
        if(~asf_reset_n) begin
          asf_trans_to_en_par_r            <= 1'b0;
          asf_trans_to_time_par_r          <= 2'b00;
        end else begin //begin if not reset
        if(asf_write_registers && (asf_addr==ASF_TRANS_TO_CTRL_ADDR) ) begin 
           asf_trans_to_en_par_r         <= asf_wdata[31];
           asf_trans_to_time_par_r       <= {2{p_add_csr_parity}} & asf_wdata_par[1:0];
        end
     end
   end  // end gen_asf_write_registers

    // parity check for asf_trans_to_en
    cdnsdru_asf_parity_check_v1 #( .p_data_width(1))
    i_parity_check_asf_trans_to_en(
     .odd_par (1'b0),
      .data_in (asf_trans_to_en_r),
      .parity_in(asf_trans_to_en_par_r),
      .parity_err(asf_trans_to_en_err)
      );

    // parity check for asf_trans_to_time
    cdnsdru_asf_parity_check_v1 #( .p_data_width(16))
    i_parity_check_asf_trans_to_time(
     .odd_par (1'b0),
      .data_in (asf_trans_to_time_r),
      .parity_in(asf_trans_to_time_par_r),
      .parity_err(asf_trans_to_time_err)
      );
    end else begin : gen_trans_to_no_csr_protect
      assign asf_trans_to_en_err = 1'b0;
      assign asf_trans_to_time_err = 1'b0;
    end
  end else begin : gen_no_trans_to_ctrl
    assign asf_trans_to_en       = 1'b0;
    assign asf_trans_to_time     = 16'h0000;
    assign asf_trans_to_en_err = 1'b0;
    assign asf_trans_to_time_err = 1'b0;
  end

 always @(posedge asf_clk or negedge asf_reset_n)
   begin : gen_asf_write_registers
     if(~asf_reset_n) begin
         asf_trans_to_fault_mask_r        <= {p_trans_to_status_int_width{1'b1}};
     end else begin //begin if not reset
         if(asf_write_registers && (asf_addr==ASF_TRANS_TO_FAULT_MASK_ADDR) ) begin 
            asf_trans_to_fault_mask_r     <= asf_wdata[p_trans_to_status_int_width-1:0];
         end
     end
   end  // end gen_asf_write_registers

   if (p_trans_to_status_width == 32'd32) begin : gen_trans_mask_no_pad
     assign asf_trans_to_fault_mask_padded = (p_trans_to_status_exists & asf_trans_to_fault_mask_r[31:0]);
   end else begin : gen_trans_to_mask_pad
     assign asf_trans_to_fault_mask_padded = {{(32-p_trans_to_status_width){1'b0}},(p_trans_to_status_exists & asf_trans_to_fault_mask_r[p_trans_to_status_width-1:0])};    
   end

  if( p_add_csr_parity == 1'b1) begin : gen_trans_to_csr_protect
   reg    [p_trans_to_status_par_width-1:0]  asf_trans_to_fault_mask_par_r;   // Parity protection for Mask register for each ASF transaction timeout fault source

   always @(posedge asf_clk or negedge asf_reset_n)
   begin : gen_asf_write_registers
     if(~asf_reset_n) begin
         asf_trans_to_fault_mask_par_r    <= {p_trans_to_status_par_width{1'b0}};
     end else begin //begin if not reset
         if(asf_write_registers && (asf_addr==ASF_TRANS_TO_FAULT_MASK_ADDR) ) begin 
            asf_trans_to_fault_mask_par_r <= {p_trans_to_status_par_width{p_add_csr_parity}} & asf_wdata_par[p_trans_to_status_par_width-1:0];
         end
     end
   end  // end gen_asf_write_registers

  // parity check for asf_trans_to_fault_mask
  cdnsdru_asf_parity_check_v1 #( .p_data_width(p_trans_to_status_int_width))
  i_parity_check_asf_trans_to_fault_mask(
   .odd_par (1'b0),
    .data_in (asf_trans_to_fault_mask_r[p_trans_to_status_int_width-1:0]),
    .parity_in(asf_trans_to_fault_mask_par_r),
    .parity_err(asf_trans_to_fault_mask_err)
      );
  end else begin : gen_trans_to_no_csr_protect
    assign asf_trans_to_fault_mask_err = 1'b0;
  end

end else begin : gen_no_trans_to
   assign asf_trans_to_en       = 1'b0;
   assign asf_trans_to_time     = 16'h0000;
   assign asf_trans_to_fault_mask_padded = 32'd0;
   assign asf_trans_to_en_err            = 1'b0;
   assign asf_trans_to_time_err          = 1'b0;
   assign asf_trans_to_fault_mask_err    = 1'b0;
end
endgenerate

  // ASF protocol faults mask
generate if(p_add_protocol_check == 1'b1) begin  : gen_protocol_check_added
   reg    [p_protocol_status_int_width-1:0]  asf_protocol_fault_mask_r;         // Mask register for each ASF protocol fault source

 always @(posedge asf_clk or negedge asf_reset_n)
   begin : gen_asf_write_registers
     if(~asf_reset_n) begin
         asf_protocol_fault_mask_r        <= {p_protocol_status_int_width{1'b1}};
     end else begin //begin if not reset
         if(asf_write_registers && (asf_addr==ASF_PROTOCOL_FAULT_MASK_ADDR) ) begin 
            asf_protocol_fault_mask_r     <= asf_wdata[p_protocol_status_int_width-1:0];
         end
     end
   end  // end gen_asf_write_registers

   if (p_protocol_status_width == 32'd32) begin : gen_protocol_mask_no_pad
     assign asf_protocol_fault_mask_padded = (p_protocol_status_exists & asf_protocol_fault_mask_r[31:0]);
   end else begin : gen_protocol_mask_pad
     assign asf_protocol_fault_mask_padded = {{(32-p_protocol_status_width){1'b0}},(p_protocol_status_exists & asf_protocol_fault_mask_r[p_protocol_status_width-1:0])};
   end

  if( p_add_csr_parity == 1'b1) begin : gen_protocol_check_csr_protect
     reg    [p_protocol_status_par_width-1:0]  asf_protocol_fault_mask_par_r;     // Parity protection for Mask register for each ASF protocol fault source

     always @(posedge asf_clk or negedge asf_reset_n)
       begin : gen_asf_write_registers
       if(~asf_reset_n) begin
         asf_protocol_fault_mask_par_r    <= {p_protocol_status_par_width{1'b0}};
       end else begin //begin if not reset
         if(asf_write_registers && (asf_addr==ASF_PROTOCOL_FAULT_MASK_ADDR) ) begin 
            asf_protocol_fault_mask_par_r <= {p_protocol_status_par_width{p_add_csr_parity}} & asf_wdata_par[p_protocol_status_par_width-1:0];
         end
       end
     end  // end gen_asf_write_registers
    // parity check for asf_protocol_fault_mask
    cdnsdru_asf_parity_check_v1 #( .p_data_width(p_protocol_status_int_width))
    i_parity_check_asf_protocol_fault_mask(
      .odd_par (1'b0),
      .data_in (asf_protocol_fault_mask_r[p_protocol_status_int_width-1:0]),
      .parity_in(asf_protocol_fault_mask_par_r),
      .parity_err(asf_protocol_fault_mask_err)
    );
  end else begin : gen_protocol_check_no_csr_protect
    assign asf_protocol_fault_mask_err = 1'b0;
  end
end else begin : gen_no_protocol_check
   assign asf_protocol_fault_mask_padded = 32'd0;
   assign asf_protocol_fault_mask_err    = 1'b0;
end
endgenerate
//------------------------------------------------------------------------------
// ASF read data
//------------------------------------------------------------------------------


 always @(*)
   begin : gen_asf_read_data
   if (asf_read_data)
        begin
            case (asf_addr)
             ASF_INT_MASK_ADDR              :  begin
                                                asf_rdata_i[31:0] = {25'd0,
                                                                   (p_add_integrity_check == 1) & asf_int_mask[6],
                                                                   (p_add_protocol_check == 1)  & asf_int_mask[5],
                                                                   (p_add_trans_to == 1)        & asf_int_mask[4],
                                                                   (p_add_csr_parity == 1)      & asf_int_mask[3],
                                                                   (p_add_dap_parity == 1)      & asf_int_mask[2],
                                                                   (p_add_sram_protect == 1)    & asf_int_mask[1],
                                                                   (p_add_sram_protect == 1)    & asf_int_mask[0]};
                                              end  // ASF_INT_MASK_ADDR
             ASF_FATAL_NONFATAL_SELECT_ADDR : begin
                                                asf_rdata_i[31:0] = {25'd0,
                                                                   (p_add_integrity_check == 1) & asf_fatal_nonfatal_select[6],
                                                                   (p_add_protocol_check == 1)  & asf_fatal_nonfatal_select[5],
                                                                   (p_add_trans_to == 1)        & asf_fatal_nonfatal_select[4],
                                                                   (p_add_csr_parity == 1)      & asf_fatal_nonfatal_select[3],
                                                                   (p_add_dap_parity == 1)      & asf_fatal_nonfatal_select[2],
                                                                   (p_add_sram_protect == 1)    & asf_fatal_nonfatal_select[1],
                                                                   (p_add_sram_protect == 1)    & asf_fatal_nonfatal_select[0]};
                                              end  // ASF_FATAL_NONFATAL_SELECT_ADDR
             ASF_TRANS_TO_CTRL_ADDR         : asf_rdata_i[31:0]  = {asf_trans_to_en,15'd0,asf_trans_to_time};
             ASF_TRANS_TO_FAULT_MASK_ADDR   : asf_rdata_i  = asf_trans_to_fault_mask_padded;
             ASF_PROTOCOL_FAULT_MASK_ADDR   : asf_rdata_i  = asf_protocol_fault_mask_padded;
             default : asf_rdata_i = 32'd0;
           endcase // end case
        end // end if
      else 
        asf_rdata_i = 32'd0;
   end  // asf_read_data

  generate if (p_add_dap_parity == 1'b1) begin : gen_host_par
    // parity bits for asf_rdata
    cdnsdru_asf_parity_gen_v1 #( .p_data_width(32) )
      i_par_gen_asf_rdata(
        .odd_par (1'b0),
        .data_in (asf_rdata),
        .data_out(),
        .parity_out(asf_rdata_par)
      );
  end else begin : gen_no_host_par
    assign asf_rdata_par = 4'h0;
  end
  endgenerate


   // Mux in read data
   assign asf_rdata = asf_rdata_i | asf_rdata_csr;

//------------------------------------------------------------------------------
// drive asf_err when address not recognised.
//------------------------------------------------------------------------------

   // asf_err output is driven when asf_addr does not match any know address
  always @(posedge asf_clk or negedge asf_reset_n)
   begin : p_asf_err
      if (~asf_reset_n)
         asf_err_i <= 1'b0;
      else
          if (asf_sel)
         case (asf_addr)
             ASF_FATAL_NONFATAL_SELECT_ADDR,
             ASF_INT_MASK_ADDR               : asf_err_i <= 1'b0;

             ASF_TRANS_TO_CTRL_ADDR          : asf_err_i <= (p_add_trans_to_ctrl == 1'b0) | (p_add_trans_to == 1'b0);
             ASF_TRANS_TO_FAULT_MASK_ADDR    : asf_err_i <= (p_add_trans_to == 1'b0);

             ASF_PROTOCOL_FAULT_MASK_ADDR    :  asf_err_i <= (p_add_protocol_check == 1'b0);

            default                   : asf_err_i <= 1'b1;
         endcase
      else
         asf_err_i <= 1'b0;
  end // block: p_asf_err.

  // Mux in p_err
  assign asf_err = asf_err_i & asf_err_csr;

  //------------------------------------------------------------------------------
  // Register status information that are
  // duplicated when CSR protection definded:
  // ASF Interrupts and Status (+ Static) Registers
  // ASF SRAM (un)correctable fault Status Registers
  // ASF transaction timeout faults Status Register
  // ASF protocol faults Register
  // --------------------------------------------------------------------------
  
  // internal and external CSR fault
  assign int_asf_csr_fault = asf_csr_fault | int_csr_parity_err;

  cdnsdru_asf_fault_log_rpt_csr_v2 #(
     .p_add_sram_protect                (p_add_sram_protect),
     .p_add_sram_corr_count             (p_add_sram_corr_count),
     .p_add_sram_uncorr_count           (p_add_sram_uncorr_count),
     .p_add_dap_parity                  (p_add_dap_parity),
     .p_add_csr_parity                  (p_add_csr_parity),
     .p_add_trans_to                    (p_add_trans_to),
     .p_trans_to_status_width           (p_trans_to_status_width),
     .p_trans_to_status_exists          (p_trans_to_status_exists),
     .p_add_protocol_check              (p_add_protocol_check),
     .p_protocol_status_exists          (p_protocol_status_exists),
     .p_protocol_status_width           (p_protocol_status_width),
     .p_add_integrity_check             (p_add_integrity_check),
     .ASF_INT_STATUS_ADDR               (ASF_INT_STATUS_ADDR),
     .ASF_INT_RAW_STATUS_ADDR           (ASF_INT_RAW_STATUS_ADDR),
     .ASF_INT_TEST_ADDR                 (ASF_INT_TEST_ADDR),
     .ASF_SRAM_CORR_FAULT_STATUS_ADDR   (ASF_SRAM_CORR_FAULT_STATUS_ADDR),
     .ASF_SRAM_UNCORR_FAULT_STATUS_ADDR (ASF_SRAM_UNCORR_FAULT_STATUS_ADDR),
     .ASF_SRAM_FAULT_STATS_ADDR         (ASF_SRAM_FAULT_STATS_ADDR),
     .ASF_TRANS_TO_FAULT_STATUS_ADDR    (ASF_TRANS_TO_FAULT_STATUS_ADDR),
     .ASF_PROTOCOL_FAULT_STATUS_ADDR    (ASF_PROTOCOL_FAULT_STATUS_ADDR)
  ) i_asf_fault_log_rpt_csr (
     .asf_clk                         (asf_clk),
     .asf_reset_n                     (asf_reset_n),
     .asf_write_registers             (asf_write_registers),
     .asf_read_data                   (asf_read_data),
     .asf_addr                        (asf_addr),
     .asf_wdata                       (asf_wdata),
     .asf_sel                         (asf_sel),
     .asf_rdata_csr                   (asf_rdata_csr),
     .asf_err_csr                     (asf_err_csr),
     .asf_fatal_nonfatal_select       (asf_fatal_nonfatal_select[6:0]),
     .asf_int_mask                    (asf_int_mask[6:0]),
     .asf_sram_corr_fault             (asf_sram_corr_fault),
     .asf_sram_corr_fault_status      (asf_sram_corr_fault_status),
     .asf_sram_corr_fault_stats_upd   (asf_sram_corr_fault_stats_upd),
     .asf_sram_uncorr_fault           (asf_sram_uncorr_fault),
     .asf_sram_uncorr_fault_status    (asf_sram_uncorr_fault_status),
     .asf_sram_uncorr_fault_stats_upd (asf_sram_uncorr_fault_stats_upd),
     .asf_dap_fault                   (asf_dap_fault),
     .asf_csr_fault                   (int_asf_csr_fault),
     .asf_trans_to_fault_mask         (asf_trans_to_fault_mask_padded[p_trans_to_status_width-1:0]),
     .asf_trans_to_fault              (asf_trans_to_fault),
     .asf_protocol_fault_mask         (asf_protocol_fault_mask_padded[p_protocol_status_width-1:0]),
     .asf_protocol_fault              (asf_protocol_fault),
     .asf_integrity_fault             (asf_integrity_fault),
     .asf_sram_corr_err               (asf_sram_corr_err),
     .asf_sram_uncorr_err             (asf_sram_uncorr_err),
     .asf_dap_err                     (asf_dap_err),
     .asf_csr_err                     (asf_csr_err),
     .asf_trans_to_err                (asf_trans_to_err),
     .asf_protocol_err                (asf_protocol_err),
     .asf_integrity_err               (asf_integrity_err),
     .asf_int_nonfatal                (asf_int_nonfatal),
     .asf_int_fatal                   (asf_int_fatal)
);


  //------------------------------------------------------------------------------
  // ASF Prity protection
  // --------------------------------------------------------------------------

generate if( p_add_csr_parity == 1'b1) begin : gen_asf_fault_csr_protect
  //  wire and reg declarations
  reg  asf_fatal_nonfatal_select_par;   // Parity protection for ASF Fatal or non-Fatal Interrupt Selecetion Register
  reg  asf_int_mask_par;                // Parity protection for ASF Interrupt Mask Register

  wire [31:0] asf_rdata_csr_d;         // ASF read data from  Register status information submodule
  wire asf_err_csr_d;                  // ASF register interface access error from  Register status information submodule 
  wire asf_sram_corr_err_d;            // SRAM correctable error indication
  wire asf_sram_uncorr_err_d;          // SRAM uncorrectable error indication
  wire asf_dap_err_d;                  // Data and Address Paths error indication
  wire asf_csr_err_d;                  // Configuration and Status Registers error indication
  wire asf_trans_to_err_d;             // Transaction Timeouts indication
  wire asf_protocol_err_d;             // Protocol error indication
  wire asf_integrity_err_d;            // Integrity error indication
  wire asf_int_nonfatal_d;             // ASF non-fatal interrupt
  wire asf_int_fatal_d;                // ASF fatal interrupt 
  //parity error indication from: 
  wire int_csr_parity_err_dplc_err;     // duplicated register status information submodule
  wire asf_fatal_nonfatal_select_err;   // asf_fatal_nonfatal_select_err
  wire asf_int_mask_err;                // asf_int_mask_err

  // -----------------------------------------------------------------------------
  //  Write parity data to ASF parity interface registers
  // -----------------------------------------------------------------------------
 always @(posedge asf_clk or negedge asf_reset_n)
   begin : gen_asf_write_registers
     if(~asf_reset_n) begin
         asf_int_mask_par                            <= 1'b1;
         asf_fatal_nonfatal_select_par               <= 1'b1;
     end else begin //begin if not reset
         
         if(asf_write_registers) begin // begin module selected
           case (asf_addr)
             ASF_INT_MASK_ADDR              : begin
                                                asf_int_mask_par <= asf_wdata_par[0];
                                              end  // ASF_INT_MASK_ADDR
             ASF_FATAL_NONFATAL_SELECT_ADDR : begin
                                                asf_fatal_nonfatal_select_par <= asf_wdata_par[0];
                                              end  // ASF_FATAL_NONFATAL_SELECT_ADDR
             default : begin // no register match so maintain values
                          asf_int_mask_par               <= asf_int_mask_par;
                          asf_fatal_nonfatal_select_par  <= asf_fatal_nonfatal_select_par;
                      end
           endcase // end case
         end // end  module selected 
     end // end if not reset
   end  // end asf_write_registers
 
  // parity check for asf_fatal_nonfatal_select
  cdnsdru_asf_parity_check_v1 #( .p_data_width(8))
  i_parity_check_asf_fatal_nonfatal_select(
   .odd_par (1'b0),
    .data_in (asf_fatal_nonfatal_select),
    .parity_in(asf_fatal_nonfatal_select_par),
    .parity_err(asf_fatal_nonfatal_select_err)
    );

  // parity check for asf_int_mask
  cdnsdru_asf_parity_check_v1 #( .p_data_width(8))
  i_parity_check_asf_int_mask(
   .odd_par (1'b0),
    .data_in (asf_int_mask),
    .parity_in(asf_int_mask_par),
    .parity_err(asf_int_mask_err)
    );

  //---------------------------------------------------------------------------
  // Duplicated Register status information
  // --------------------------------------------------------------------------
 cdnsdru_asf_fault_log_rpt_csr_v2 #(
     .p_add_sram_protect                (p_add_sram_protect),
     .p_add_sram_corr_count             (p_add_sram_corr_count),
     .p_add_sram_uncorr_count           (p_add_sram_uncorr_count),
     .p_add_dap_parity                  (p_add_dap_parity),
     .p_add_csr_parity                  (p_add_csr_parity),
     .p_add_trans_to                    (p_add_trans_to),
     .p_trans_to_status_width           (p_trans_to_status_width),
     .p_trans_to_status_exists          (p_trans_to_status_exists),
     .p_add_protocol_check              (p_add_protocol_check),
     .p_protocol_status_width           (p_protocol_status_width),
     .p_protocol_status_exists          (p_protocol_status_exists),
     .p_add_integrity_check             (p_add_integrity_check),
     .ASF_INT_STATUS_ADDR               (ASF_INT_STATUS_ADDR),
     .ASF_INT_RAW_STATUS_ADDR           (ASF_INT_RAW_STATUS_ADDR),
     .ASF_INT_TEST_ADDR                 (ASF_INT_TEST_ADDR),
     .ASF_SRAM_CORR_FAULT_STATUS_ADDR   (ASF_SRAM_CORR_FAULT_STATUS_ADDR),
     .ASF_SRAM_UNCORR_FAULT_STATUS_ADDR (ASF_SRAM_UNCORR_FAULT_STATUS_ADDR),
     .ASF_SRAM_FAULT_STATS_ADDR         (ASF_SRAM_FAULT_STATS_ADDR),
     .ASF_TRANS_TO_FAULT_STATUS_ADDR    (ASF_TRANS_TO_FAULT_STATUS_ADDR),
     .ASF_PROTOCOL_FAULT_STATUS_ADDR    (ASF_PROTOCOL_FAULT_STATUS_ADDR)
  ) i_asf_fault_log_rpt_csr_duplc (
     .asf_clk                         (asf_clk),
     .asf_reset_n                     (asf_reset_n),
     .asf_write_registers             (asf_write_registers),
     .asf_read_data                   (asf_read_data),
     .asf_addr                        (asf_addr),
     .asf_wdata                       (asf_wdata),
     .asf_sel                         (asf_sel),
     .asf_rdata_csr                   (asf_rdata_csr_d),
     .asf_err_csr                     (asf_err_csr_d),
     .asf_fatal_nonfatal_select       (asf_fatal_nonfatal_select[6:0]),
     .asf_int_mask                    (asf_int_mask[6:0]),
     .asf_sram_corr_fault             (asf_sram_corr_fault),
     .asf_sram_corr_fault_status      (asf_sram_corr_fault_status),
     .asf_sram_corr_fault_stats_upd   (asf_sram_corr_fault_stats_upd),
     .asf_sram_uncorr_fault           (asf_sram_uncorr_fault),
     .asf_sram_uncorr_fault_status    (asf_sram_uncorr_fault_status),
     .asf_sram_uncorr_fault_stats_upd (asf_sram_uncorr_fault_stats_upd),
     .asf_dap_fault                   (asf_dap_fault),
     .asf_csr_fault                   (int_asf_csr_fault),
     .asf_trans_to_fault_mask         (asf_trans_to_fault_mask_padded[p_trans_to_status_width-1:0]),
     .asf_trans_to_fault              (asf_trans_to_fault),
     .asf_protocol_fault_mask         (asf_protocol_fault_mask_padded[p_protocol_status_width-1:0]),
     .asf_protocol_fault              (asf_protocol_fault),
     .asf_integrity_fault             (asf_integrity_fault),
     .asf_sram_corr_err               (asf_sram_corr_err_d),
     .asf_sram_uncorr_err             (asf_sram_uncorr_err_d),
     .asf_dap_err                     (asf_dap_err_d),
     .asf_csr_err                     (asf_csr_err_d),
     .asf_trans_to_err                (asf_trans_to_err_d),
     .asf_protocol_err                (asf_protocol_err_d),
     .asf_integrity_err               (asf_integrity_err_d),
     .asf_int_nonfatal                (asf_int_nonfatal_d),
     .asf_int_fatal                   (asf_int_fatal_d)
  );
    assign int_csr_parity_err_dplc_err = (asf_rdata_csr        != asf_rdata_csr_d)       |
                                         (asf_err_csr          != asf_err_csr_d)         |
                                         (asf_sram_corr_err    != asf_sram_corr_err_d)   |
                                         (asf_sram_uncorr_err  != asf_sram_uncorr_err_d) |
                                         (asf_dap_err          != asf_dap_err_d)         |
                                         (asf_csr_err          != asf_csr_err_d)         |
                                         (asf_trans_to_err     != asf_trans_to_err_d)    |
                                         (asf_protocol_err     != asf_protocol_err_d)    |
                                         (asf_integrity_err    != asf_integrity_err_d)   |
                                         (asf_int_nonfatal     != asf_int_nonfatal_d)    |
                                         (asf_int_fatal        != asf_int_fatal_d);

  // All CSR error signals OR-ed
  assign int_csr_parity_err = asf_fatal_nonfatal_select_err
                              | asf_int_mask_err
                              | asf_trans_to_en_err
                              | asf_trans_to_time_err
                              | asf_trans_to_fault_mask_err
                              | asf_protocol_fault_mask_err
                              | int_csr_parity_err_dplc_err;
end  // gen_asf_csr_protect
else begin : gen_asf_fault_no_csr_protect
  assign int_csr_parity_err = 1'b0;
end // gen_asf_no_csr_protect
endgenerate


endmodule
