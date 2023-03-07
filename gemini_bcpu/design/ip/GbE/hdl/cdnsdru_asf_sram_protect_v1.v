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
//   Filename:           cdnsdru_asf_sram_protect_v1.v
//   Module Name:        cdnsdru_asf_sram_protect_v1
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
// Description    : ASF SRAM Protection reuse component
//                  A generic SRAM Protection reuse component support one of
//                  the following two configuration modes through parameterisation
//                  of the the module on instantiation:
//                  1. Parity protection for fault detection only.
//                  2. ECC Parity protection for fault detection and single bit fault correction.
//                  Each instance of this module will support a single port of the SRAM. for
//                  protection of dual port SRAM, two instances of this module should be 
//                  instantiated, one for each port.
//------------------------------------------------------------------------------
//------------------------------------------------------------------------------

module cdnsdru_asf_sram_protect_v1 #(

  // Configuration options for SRAM Protection module.
  parameter p_addr_width      = 32'd12,                // Set the address width of the SRAM
  parameter p_data_width      = 32'd32,                // Set the IP datapath width. This is NOT the SRAM width
  parameter p_use_ecc         = 1'b1,                  // Protection method is ECC if set to 1, otherwise parity is used.
  parameter p_write_prot      = 1'b1,                  // Configures write protection capability.
                                                       // If set to 0, no protection generation logic will be present.
  parameter p_read_check      = 1'b1,                  // Configures read checking capability.
                                                       // If set to 0, no protection checking  logic will be present
  parameter p_read_latency    = 32'd1,                 // Read latency of the SRAM. Minimum 1

  //  SRAM Protection internal parameters
  parameter p_num_data_par    = (p_data_width+32'd7)/32'd8,                                     // number of parity bits for the data bus (1bit per 1byte)
  parameter p_num_addr_par    = (p_addr_width+32'd7)/32'd8,                                     // number of parity bits  for the address bus (1bit per 1byte)
  parameter p_num_int_addr    = p_num_addr_par*32'd8,                                           // internal address width padded to bytes wise
  parameter p_num_bits_prot   = (p_data_width + p_num_addr_par),                                // Number of bits protected by ECC protection
  parameter p_num_ecc_inst    = (p_num_bits_prot+32'd79)/32'd80,                                // Number of ECC_80_8 needed
  parameter p_num_bits_e      = ((p_num_bits_prot + (p_num_ecc_inst-32'd1)) / p_num_ecc_inst),
  parameter p_num_bits_l      = p_num_bits_prot - ((p_num_ecc_inst-32'd1)*p_num_bits_e),
  parameter p_num_par_e       = (p_num_bits_e < 32'd58) ? 32'd7 : 32'd8,
  parameter p_num_par_l       = (p_num_bits_l < 32'd58) ? 32'd7 : 32'd8,
  parameter p_num_ecc_par     = (p_num_par_l + (p_num_ecc_inst-32'd1)*p_num_par_e),
  parameter p_sram_width      = (p_use_ecc == 1'b1)? (p_num_bits_prot + p_num_ecc_par) :        // number of ECC parity bits for the ECC protection
                                        (p_data_width+p_num_data_par+p_num_addr_par),
  parameter p_sram_diw        = (p_write_prot == 1'b1)? p_sram_width : p_data_width,
  parameter p_sram_dow        = (p_read_check == 1'b1)? p_sram_width : p_data_width,
  parameter p_num_int_data  =  p_num_data_par*32'd8                                             // internal write data width padded to bytes wise
) (
   // system inputs.
   input                                 clock,                       // Clock
   input                                 reset_n,                     // Reset

   // Packet buffer external DPRAM/SPRAM connections
   output                                     sram_en,                // Active high enable to SRAM
   output                                     sram_we,                // Active high write enable to SRAM
   output [p_addr_width-1:0]                  sram_addr,              // Address selection to SRAM
   output [p_sram_diw-1:0]
                                              sram_di,                // Write data in to SRAM including protection data
   input  [p_sram_dow-1:0]
                                              sram_do,                // Read data from SRAM including protection data

   // Internal IP logic connections
   input                                      int_sram_en,            // Active high SRAM enable from internal IP logic
   input                                      int_sram_we,            // Active high SRAM write enable from internal IP logic
   input  [p_addr_width-1:0]                  int_sram_addr,          // SRAM Address selection from internal IP logic
   input  [p_data_width-1:0]                  int_sram_di,            // Write data from internal IP logic
   output [p_data_width-1:0]                  int_sram_do,            // Read data to internal IP logic

   // 
   input                                      sram_chk_en,            // Synchronous read check/correction enable
   // signal going to ASF fault logging and reporting module
   output                                     corr_err,               // Correctable error detected
                                                                      // Only valid when ECC is configured
   output                                     uncorr_err,             // Uncorrectable error detected
   output [p_addr_width-1:0]                  err_addr                // Address related to corr/uncorr_err

);

// -----------------------------------------------------------------------------
//  wire and reg declarations
// -----------------------------------------------------------------------------

// -----------------------------------------------------------------------------
//  Beginning of main code.
// -----------------------------------------------------------------------------

  // -----------------------------------------------------------------------------
  //  SRAM Write 
  // -----------------------------------------------------------------------------
  //  SRAM Write Parity Generator for both data and address buses
  generate if((p_use_ecc == 0) & (p_write_prot == 1)) begin : gen_sram_par_gen
    //  wire and reg declarations
    wire   [p_num_addr_par-1:0]              sram_addr_par;            // Parity bits of the address bus
    wire   [p_num_data_par-1:0]              sram_di_par;              // Parity bits of the data bus
    
    // Generating Parity bits for the address bus
    cdnsdru_asf_parity_gen_v1 #( .p_data_width(p_addr_width),
                              .p_num_par(p_num_addr_par),
                              .p_int_width(p_num_int_addr) )
    i_par_gen_addr(
       .odd_par (1'b0),
       .data_in (int_sram_addr),
       .data_out(),
       .parity_out(sram_addr_par)
    );
    // Generating Parity bits for the data bus
    cdnsdru_asf_parity_gen_v1 #( .p_data_width(p_data_width),
                              .p_num_par(p_num_data_par),
                              .p_int_width(p_num_int_data) )
    i_par_gen_data(
       .odd_par (1'b0),
       .data_in (int_sram_di),
       .data_out(),
       .parity_out(sram_di_par)
    );

  assign sram_di = {sram_addr_par,sram_di_par,int_sram_di};
  end // end gen_sram_write_par
  // -----------------------------------------------------------------------------
  //  SRAM Write ECC Generator for data bus and Parity Generator for address bus
  // -----------------------------------------------------------------------------
  else if((p_use_ecc == 1) & (p_write_prot == 1)) begin : gen_sram_ecc_gen
    //  wire and reg declarations
    wire   [p_num_addr_par-1:0]              sram_addr_par;            // Parity bits of the address bus
    wire   [p_num_ecc_par-1:0]               sram_ecc_par;             // ECC parity bits of the data bus and address parity
    
    // Generating Parity bits for the address bus
    cdnsdru_asf_parity_gen_v1 #( .p_data_width(p_addr_width),
                              .p_num_par(p_num_addr_par),
                              .p_int_width(p_num_int_addr) )
    i_par_gen_addr(
       .odd_par (1'b0),
       .data_in (int_sram_addr),
       .data_out(),
       .parity_out(sram_addr_par)
    );

    // Generating ECC bits for the data bus and the address parity
    cdnsdru_ecc_parity_gen_wrap_v1 #(.p_num_bits(p_num_bits_prot)) i_ecc_par (
      .data_in  ({sram_addr_par,int_sram_di}),
      .parity_out(sram_ecc_par)
    );

    assign sram_di = {sram_addr_par,sram_ecc_par,int_sram_di};
  end // else if p_write_prot == 2
  // -----------------------------------------------------------------------------
  //  SRAM Write no protection on data and address buses
  // -----------------------------------------------------------------------------
  else begin : gen_sram_no_gen
     assign sram_di = int_sram_di;
  end
  endgenerate

  // -----------------------------------------------------------------------------
  //  SRAM Read Parity check/corret for both data and address buses
  // -----------------------------------------------------------------------------
  //  SRAM read parity check for both data and address buses
  generate if((p_use_ecc == 0) & (p_read_check == 1)) begin : gen_sram_par_check
    //  wire and reg declarations
    wire   [p_data_width-1:0]                sram_do_data;                        // Data bus extracted from sram_do
    wire   [p_num_data_par-1:0]              sram_do_data_par;                    // Data Parity bits extracted from sram_do
    wire   [p_num_addr_par-1:0]              sram_do_addr_par;                    // Address Parity bits extracted from sram_do
    reg    [p_addr_width-1:0]                sram_addr_dx[p_read_latency-1:0];    // Delaying the address 
    wire                                     int_check_en_zero;                   // SRAM read enable signal
    reg                                      int_check_en_dx[p_read_latency-1:0]; // Delaying the address
    wire                                     addr_par_err;                        // Address bus error indication signal
    wire                                     data_par_err;                        // Data bus error indication signal

    // SRAM read enable signal
    assign int_check_en_zero = (~int_sram_we) & int_sram_en & sram_chk_en;
    // extract data and parity signals from sram_do
    assign sram_do_data     = sram_do[p_data_width-1:0];
    assign sram_do_data_par = sram_do[p_data_width+p_num_data_par-1:p_data_width];
    assign sram_do_addr_par = sram_do[p_data_width+p_num_data_par+p_num_addr_par-1:p_data_width+p_num_data_par];
   // delay the address bus and the enable signal "p_read_latency" cycles
   genvar i;
   for (i=0; i < p_read_latency;i=i+1) begin : gen_sram_delay
     if(i==0) begin : gen_sram_d0
      always @(posedge clock or negedge reset_n)
        if (~reset_n) begin
          sram_addr_dx[i]    <= {p_addr_width{1'b0}};
          int_check_en_dx[i] <= 1'b0;
        end else begin
          sram_addr_dx[i]    <= int_sram_addr;
          int_check_en_dx[i] <= int_check_en_zero;
        end
     end else begin : gen_sram_dx
      always @(posedge clock or negedge reset_n)
        if (~reset_n) begin
          sram_addr_dx[i]    <= {p_addr_width{1'b0}};
          int_check_en_dx[i] <= 1'b0;
        end else begin
          sram_addr_dx[i]    <= sram_addr_dx[i-1];
          int_check_en_dx[i] <= int_check_en_dx[i-1];
        end
       end
   end // end gen_sram_delay

    // Check address parity bits against the address bus
    cdnsdru_asf_parity_check_v1 #( .p_data_width(p_addr_width),
                                .p_num_par(p_num_addr_par),
                                .p_int_width(p_num_int_addr) )
    i_par_check_addr(
      .odd_par (1'b0),
      .data_in (sram_addr_dx[p_read_latency-1]),
      .parity_in(sram_do_addr_par),
      .parity_err(addr_par_err)
    );

    // Check data parity bits against the data bus
    cdnsdru_asf_parity_check_v1 #( .p_data_width(p_data_width),
                                .p_num_par(p_num_data_par),
                                .p_int_width(p_num_int_data) )
    i_par_check_data(
      .odd_par (1'b0),
      .data_in (sram_do_data),
      .parity_in(sram_do_data_par),
      .parity_err(data_par_err)
    );

  // signals go to the ASF fault logging and reporting
  assign uncorr_err = int_check_en_dx[p_read_latency-1] & (data_par_err | addr_par_err);
  assign corr_err = 1'b0;
  assign err_addr = sram_addr_dx[p_read_latency-1];
  //Internal IP logic connections
  assign int_sram_do = sram_do_data;
  end // end gen_sram_write_par
  // -----------------------------------------------------------------------------
  //  SRAM read ECC check/correct for data bus and Parity check for address bus
  // -----------------------------------------------------------------------------
  else if((p_use_ecc == 1) & (p_read_check == 1)) begin : gen_sram_ecc_check
    //  wire and reg declarations
    wire   [p_data_width-1:0]                sram_do_data;                        // Data bus extracted from sram_do
    wire   [p_num_ecc_par-1:0]               sram_do_ecc_par;                     // ECC Parity bits extracted from sram_do
    wire   [p_num_addr_par-1:0]              sram_do_addr_par;                    // Parity Address bits extracted from sram_do
    wire   [p_data_width+p_num_addr_par-1:0]
                                             sram_do_corr_data_par_addr;          // Going to internal Data bus after ECC correction
    wire   [p_data_width-1:0]                data_corr;                           // Data bus after ECC correction
    wire   [p_num_addr_par-1:0]              addr_par_corr;                       // Parity bits after ECC correction
    reg    [p_addr_width-1:0]                sram_addr_dx[p_read_latency-1:0];    // Delaying the address 
    wire                                     int_check_en_zero;                   // SRAM read enable signal
    reg                                      int_check_en_dx[p_read_latency-1:0]; // Delaying the address
    wire                                     ecc_corr_err;                        // Correctable error indication signal from the ECC checker
    wire                                     ecc_uncorr_err;                      // Uncorrectable error indication signal from the ECC checker
    wire                                     addr_par_err;                        // Error indication from the parity Address bus

    // SRAM read enable signal
    assign int_check_en_zero = (~int_sram_we) & int_sram_en & sram_chk_en;
    // extract data and parity signals from sram_do
    assign sram_do_data     = sram_do[p_data_width-1:0];
    assign sram_do_ecc_par  = sram_do[p_data_width+p_num_ecc_par-1:p_data_width];
    assign sram_do_addr_par = sram_do[p_data_width+p_num_ecc_par+p_num_addr_par-1:p_data_width+p_num_ecc_par];
   // delay the address bus and the enable signal "p_read_latency" cycles
   genvar i;
   for (i=0; i < p_read_latency;i=i+1) begin : gen_sram_delay
      if(i==0) begin : gen_sram_d0
      always @(posedge clock or negedge reset_n)
        if (~reset_n) begin
          sram_addr_dx[i]    <= {p_addr_width{1'b0}};
          int_check_en_dx[i] <= 1'b0;
        end else begin
          sram_addr_dx[i]    <= int_sram_addr;
          int_check_en_dx[i] <= int_check_en_zero;
        end
      end else begin : gen_sram_dx
      always @(posedge clock or negedge reset_n)
        if (~reset_n) begin
          sram_addr_dx[i]    <= {p_addr_width{1'b0}};
          int_check_en_dx[i] <= 1'b0;
        end else begin
          sram_addr_dx[i]    <= sram_addr_dx[i-1];
          int_check_en_dx[i] <= int_check_en_dx[i-1];
        end
       end
   end // end gen_sram_delay

    // Check the ECC redundancy bits against the data bus and address parity
    cdnsdru_ecc_correct_wrap_v1 #(.p_num_bits(p_num_bits_prot)) i_ecc_corr (
      .data_in  ({sram_do_addr_par,sram_do_data}),
      .parity_in(sram_do_ecc_par),
      .data_out (sram_do_corr_data_par_addr),
      .correctable_error_out  (ecc_corr_err),
      .uncorrectable_error_out(ecc_uncorr_err)
    );

    assign data_corr = sram_do_corr_data_par_addr[p_data_width-1:0];
    assign addr_par_corr = sram_do_corr_data_par_addr[p_data_width+p_num_addr_par-1:p_data_width];

    // Check address parity bits against the address bus
    cdnsdru_asf_parity_check_v1 #( .p_data_width(p_addr_width),
                                .p_num_par(p_num_addr_par),
                                .p_int_width(p_num_int_addr) )
    i_par_check_addr(
      .odd_par (1'b0),
      .data_in (sram_addr_dx[p_read_latency-1]),
      .parity_in(addr_par_corr),
      .parity_err(addr_par_err)
        );

  // signals go to the ASF fault logging and reporting
  assign uncorr_err  = int_check_en_dx[p_read_latency-1] & (ecc_uncorr_err | addr_par_err);
  assign corr_err    = int_check_en_dx[p_read_latency-1] & ecc_corr_err;
  assign err_addr    = sram_addr_dx[p_read_latency-1];
  //Internal IP logic connections
  assign int_sram_do = int_check_en_dx[p_read_latency-1] ? data_corr : sram_do_data;
  end // else if p_read_check == 2
  // -----------------------------------------------------------------------------
  //  SRAM read no check/correct for data and address buses
  // -----------------------------------------------------------------------------
  else begin : gen_sram_no_check
  // signals go to the ASF fault logging and reporting
  assign uncorr_err  = 1'b0;
  assign corr_err    = 1'b0;
  assign err_addr    = 1'b0;
  //Internal IP logic connections
  assign int_sram_do = sram_do;
  end
  endgenerate

  // Always pass the address bus
  assign sram_addr = int_sram_addr;
  // always pass the SRAM strobe signals
  assign sram_en = int_sram_en;
  assign sram_we = int_sram_we;



endmodule
