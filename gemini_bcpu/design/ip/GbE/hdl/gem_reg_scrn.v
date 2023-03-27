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
//   Filename:           gem_reg_scrn.v
//   Module Name:        gem_reg_scrn
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
//   Description    : Contains screener and compare registers for GEM.
//
//------------------------------------------------------------------------------

// include definitions files
`ifndef gem_defs_defined
`define gem_defs_defined
`include "gem_gxl_defs.v"
`include "edma_defs.v"
`endif

module gem_reg_scrn # (
  parameter p_num_type1_screeners   = 8'd1,
  parameter p_num_type2_screeners   = 8'd1,
  parameter p_num_scr2_compare_regs = 8'd1,
  parameter p_num_scr2_ethtype_regs = 8'd1,
  parameter p_parity_prot           = 1'b0

)(
  input               pclk,                   // APB clock
  input               n_preset,               // Active low reset
  input               psel,                   // Peripheral select
  input       [11:0]  i_paddr,                // Full APB address
  input               write_registers,        // write to apb registers.
  input               read_registers,         // read from apb registers.
  input       [31:0]  pwdata,                 // APB write data
  input       [3:0]   pwdata_par,             // Parity associated with pwdata
  output      [(32*p_num_type1_screeners):0]
                      screener_type1_regs,
  output      [(32*p_num_type2_screeners):0]
                      screener_type2_regs,
  output      [(43*p_num_scr2_compare_regs):0]
                      scr2_compare_regs,
  output      [(16*p_num_scr2_ethtype_regs):0]
                      scr2_ethtype_regs,
  output      [(32*p_num_type2_screeners):0]
                      scr2_rate_lim,
  input       [p_num_type2_screeners:0]
                      scr_excess_rate_pclk,   // this is a pulse in pclk domain
  output  reg [31:0]  prdata_scrn,            // Read data (combinatorial)
  output  reg         perr_scrn,              // Similarly perr signal (reg)
  output              scrn_par_err            // Parity error

);

  // Internal signals
  wire  [31:0]  scrn_type1[15:0];         // Array of all available Type 1 Screeners
  wire  [31:0]  scrn_type2[15:0];         // Array of all available Type 2 Screeners
  wire  [31:0]  type2_compa[31:0];        // Array of all available Type 2 Compare registers
  wire  [31:0]  type2_compb[31:0];        // Array of all available Type 2 Compare registers
  wire  [15:0]  type2_ethtype[7:0];       // Array of all available Type 2 Ethertype registers
  wire  [31:0]  scr2_rate_limiting[15:0]; // Array of all available Type 2 screeners rate limiting registers
  wire  [31:0]  scr_excess_rate_pclk_32;  // Array of all available Type 2 screeners status rate limit regs
  wire  [15:0]  scrn_type1_par_err;       // Parity error in screener Type 1 registers
  wire  [15:0]  scrn_type2_par_err;       // Parity error in screener Type 2 registers
  wire  [7:0]   ethtype_par_err;          // Parity error in Ethertype compare registers
  wire  [31:0]  type2_comp_par_err;       // Parity error in Compare registers
  wire  [15:0]  scr2_rate_lim_par_err;    // Parity error in rate limiting registers

  // Create registers for Type 1 Screeners
  genvar  loop_scrn1;
  generate for (loop_scrn1 = 0; loop_scrn1 < 16; loop_scrn1=loop_scrn1+1) begin : gen_type1
    if (loop_scrn1 < p_num_type1_screeners) begin : gen_exists
      reg   [30:0]  scrn;
      wire  [11:0]  addr_offset;
      wire  [12:0]  matching_addr;
      
      assign addr_offset   = (loop_scrn1 * 12'h004);
      assign matching_addr = (`type1_screener_base_addr + addr_offset);
      
      // Writes to the register
      always @(posedge pclk or negedge n_preset)
      begin
        if (~n_preset)
          scrn  <= 31'h00000000;
        else if (write_registers &
                (i_paddr == matching_addr[11:0]))
          scrn  <= pwdata[30:0];
      end
      assign scrn_type1[loop_scrn1] = {1'b0,scrn};
      // Note the shift to match old code.
      assign screener_type1_regs[(loop_scrn1*32)+32:(loop_scrn1*32)+1]  = {1'b0,scrn};

      // Optional parity protection
      if (p_parity_prot == 1) begin : gen_par
        reg   [3:0] scrn_par;

        // Store associated parity
        always @(posedge pclk or negedge n_preset)
        begin
          if (~n_preset)
            scrn_par  <= 4'h0;
          else if (write_registers &
                  (i_paddr == matching_addr[11:0]))
            scrn_par  <= {pwdata_par[3]^pwdata[31],pwdata_par[2:0]};
        end

        // Check the parity constantly
        cdnsdru_asf_parity_check_v1 #(.p_data_width(31)) i_par_chk (
          .odd_par    (1'b0),
          .data_in    (scrn),
          .parity_in  (scrn_par),
          .parity_err (scrn_type1_par_err[loop_scrn1])
        );
      end else begin : gen_no_par
        assign scrn_type1_par_err[loop_scrn1] = 1'b0;
      end
    end
    else
    begin : gen_no_exists
      assign scrn_type1[loop_scrn1] = 32'h00000000;
      assign scrn_type1_par_err[loop_scrn1] = 1'b0;
    end
  end
  endgenerate
  assign screener_type1_regs[0] = 1'b0;

  // Create registers for Type 2 Screeners
  genvar  loop_scrn2;
  generate for (loop_scrn2 = 0; loop_scrn2 < 16; loop_scrn2=loop_scrn2+1) begin : gen_type2
    if (loop_scrn2 < p_num_type2_screeners) begin : gen_exists
      reg   [31:0]  scrn;
      wire  [11:0]  addr_offset;
      wire  [12:0]  matching_addr;
      
      assign addr_offset   = (loop_scrn2 * 12'h004);
      assign matching_addr = `type2_screener_base_addr + addr_offset;
      
      // Writes to the register
      always @(posedge pclk or negedge n_preset)
      begin
        if (~n_preset)
          scrn  <= 32'd0;
        else if (write_registers &
                (i_paddr == matching_addr[11:0]))
          scrn  <= pwdata;
      end
      assign scrn_type2[loop_scrn2] = scrn;
      // Note the shift to match old code.
      assign screener_type2_regs[(loop_scrn2*32)+32:(loop_scrn2*32)+1]  = scrn;

      // Optional parity protection
      if (p_parity_prot == 1) begin : gen_par
        reg   [3:0] scrn_par;

        // Store associated parity
        always @(posedge pclk or negedge n_preset)
        begin
          if (~n_preset)
            scrn_par  <= 4'h0;
          else if (write_registers &
                  (i_paddr == matching_addr[11:0]))
            scrn_par  <= pwdata_par;
        end

        // Check the parity constantly
        cdnsdru_asf_parity_check_v1 #(.p_data_width(32)) i_par_chk (
          .odd_par    (1'b0),
          .data_in    (scrn),
          .parity_in  (scrn_par),
          .parity_err (scrn_type2_par_err[loop_scrn2])
        );
      end else begin : gen_no_par
        assign scrn_type2_par_err[loop_scrn2] = 1'b0;
      end

    end
    else
    begin : gen_no_exists
      assign scrn_type2[loop_scrn2] = 32'h00000000;
      assign scrn_type2_par_err[loop_scrn2] = 1'b0;
    end
  end
  endgenerate
  assign screener_type2_regs[0] = 1'b0;

  // Create registers for Ethertype registers
  genvar  loop_eth;
  generate for (loop_eth = 0; loop_eth < 8; loop_eth=loop_eth+1) begin : gen_ethtype
    if (loop_eth < p_num_scr2_ethtype_regs) begin : gen_exists
      reg   [15:0]  ethtype;
      wire  [11:0]  addr_offset;
      wire  [12:0]  matching_addr;
      
      assign addr_offset   = (loop_eth * 12'h004);
      assign matching_addr = `scr2_ethtype_reg_0 + addr_offset;
      
      // Writes to the register
      always @(posedge pclk or negedge n_preset)
      begin
        if (~n_preset)
          ethtype  <= 16'h0000;
        else if (write_registers && (i_paddr == matching_addr[11:0]))
          ethtype  <= pwdata[15:0];
      end
      assign type2_ethtype[loop_eth] = ethtype;
      // Note the shift to match old code.
      assign scr2_ethtype_regs[(loop_eth*16)+16:(loop_eth*16)+1]  = ethtype;

            // Optional parity protection
      if (p_parity_prot == 1) begin : gen_par
        reg   [1:0] eth_par;

        // Store associated parity
        always @(posedge pclk or negedge n_preset)
        begin
          if (~n_preset)
            eth_par <= 2'b00;
          else if (write_registers && (i_paddr == matching_addr[11:0]))
            eth_par <= pwdata_par[1:0];
        end

        // Check the parity constantly
        cdnsdru_asf_parity_check_v1 #(.p_data_width(16)) i_par_chk (
          .odd_par    (1'b0),
          .data_in    (ethtype),
          .parity_in  (eth_par),
          .parity_err (ethtype_par_err[loop_eth])
        );
      end else begin : gen_no_par
        assign ethtype_par_err[loop_eth] = 1'b0;
      end

    end
    else
    begin : gen_no_exists
      assign type2_ethtype[loop_eth] = 16'h0000;
      assign ethtype_par_err[loop_eth] = 1'b0;
    end
  end
  endgenerate
  assign scr2_ethtype_regs[0] = 1'b0;

  // Create registers for type2 compare registers
  genvar  loop_cmp;
  generate for (loop_cmp = 0; loop_cmp < 32; loop_cmp=loop_cmp+1) begin : gen_cmp
    if (loop_cmp < p_num_scr2_compare_regs) begin : gen_exists
      reg   [42:0]  cmp_r;
      wire  [11:0]  addr_offset;
      wire  [12:0]  matching_addr_0a;
      wire  [12:0]  matching_addr_0b;
      
      assign addr_offset      = (loop_cmp * 12'h008);
      assign matching_addr_0a = `scr2_compare_reg_0a + addr_offset;
      assign matching_addr_0b = `scr2_compare_reg_0b + addr_offset;
      
      // Writes to the register
      always @(posedge pclk or negedge n_preset)
      begin
        if (~n_preset)
          cmp_r  <= 43'h00000000000;
        else if (write_registers)
        begin
          if (i_paddr == matching_addr_0a[11:0])
            cmp_r[31:0]   <= pwdata;
          else if (i_paddr == matching_addr_0b[11:0])
            cmp_r[42:32]  <= pwdata[10:0];
        end
      end
      assign type2_compa[loop_cmp]  = cmp_r[31:0];
      assign type2_compb[loop_cmp]  = {21'h000000,cmp_r[42:32]};
      // Note the shift to match old code.
      assign scr2_compare_regs[(loop_cmp*43)+43:(loop_cmp*43)+1]  = cmp_r;

      // Optional parity protection
      if (p_parity_prot == 1) begin : gen_par
        reg   [5:0] cmp_par;

        // Store associated parity
        always @(posedge pclk or negedge n_preset)
        begin
          if (~n_preset)
            cmp_par <= 6'h00;
          else if (write_registers)
          begin
            if (i_paddr == matching_addr_0a[11:0])
              cmp_par[3:0]  <= pwdata_par;
            else if (i_paddr == matching_addr_0b[11:0])
              cmp_par[5:4]  <= {^pwdata[10:8],pwdata_par[0]};
          end
        end

        // Check the parity constantly
        cdnsdru_asf_parity_check_v1 #(.p_data_width(43)) i_par_chk (
          .odd_par    (1'b0),
          .data_in    (cmp_r),
          .parity_in  (cmp_par),
          .parity_err (type2_comp_par_err[loop_cmp])
        );
      end else begin : gen_no_par
        assign type2_comp_par_err[loop_cmp] = 1'b0;
      end

    end
    else
    begin : gen_no_exists
      assign type2_compa[loop_cmp] = {32{1'b0}};
      assign type2_compb[loop_cmp] = {32{1'b0}};
      assign type2_comp_par_err[loop_cmp] = 1'b0;
    end
  end
  endgenerate
  assign scr2_compare_regs[0] = 1'b0;

  // Create registers for type2 screener rate limiting algorithm
  genvar  loop_rate_lim;
  generate for (loop_rate_lim = 0; loop_rate_lim < 16; loop_rate_lim = loop_rate_lim+1) begin : gen_rate_lim
    if (loop_rate_lim < p_num_type2_screeners) begin : gen_exists
      reg   [31:0]  rate_lim_r;
      wire  [11:0]  addr_offset;
      wire  [12:0]  matching_addr;
      
      assign addr_offset   = (loop_rate_lim * 12'h004);
      assign matching_addr = `gem_scr2_0_rate_limit + addr_offset;
      
      // Writes to the register
      always @(posedge pclk or negedge n_preset)
      begin
        if (~n_preset)
          rate_lim_r  <= 32'd0;
        else if (write_registers && (i_paddr == matching_addr[11:0]))
          rate_lim_r  <= pwdata;
      end
      assign scr2_rate_limiting[loop_rate_lim] = rate_lim_r;
      assign scr2_rate_lim[(loop_rate_lim*32)+32:(loop_rate_lim*32)+1] = rate_lim_r;

      // Optional parity protection
      if (p_parity_prot == 1) begin : gen_par
        reg [3:0] lim_par;
        // Store associated parity
        always @(posedge pclk or negedge n_preset)
        begin
          if (~n_preset)
            lim_par <= 4'h0;
          else if (write_registers && (i_paddr == matching_addr[11:0]))
            lim_par <= pwdata_par;
        end

        // Check the parity constantly
        cdnsdru_asf_parity_check_v1 #(.p_data_width(32)) i_par_chk (
          .odd_par    (1'b0),
          .data_in    (rate_lim_r),
          .parity_in  (lim_par),
          .parity_err (scr2_rate_lim_par_err[loop_rate_lim])
        );
      end else begin : gen_no_par
        assign scr2_rate_lim_par_err[loop_rate_lim] = 1'b0;
      end

    end
    else
    begin : gen_no_exists
      assign scr2_rate_limiting[loop_rate_lim]    = 32'd0;
      assign scr2_rate_lim_par_err[loop_rate_lim] = 1'b0;
    end
  end
  endgenerate
  assign scr2_rate_lim[0] = 1'b0;

  generate if (p_num_type2_screeners > 8'd0) begin : gen_scr_exc_rate_sts
    reg [p_num_type2_screeners-1:0] scr_exc_rate_r;

    // Create registers for status type2 screener rate limiting algorithm
    always @ (posedge pclk or negedge n_preset)
    begin
      if(~n_preset)
        scr_exc_rate_r  <= {p_num_type2_screeners{1'b0}};
      else
        if(read_registers && i_paddr == `gem_scr_excess_rate)
          scr_exc_rate_r  <= scr_excess_rate_pclk[p_num_type2_screeners-1:0];  // Read to Clear
        else
          scr_exc_rate_r  <= scr_excess_rate_pclk[p_num_type2_screeners-1:0] | scr_exc_rate_r;
    end
    assign scr_excess_rate_pclk_32  = {{(32-p_num_type2_screeners){1'b0}},scr_exc_rate_r};
  end else begin : gen_no_scr_exc_rate_sts
    assign scr_excess_rate_pclk_32  = 32'd0;
  end
  endgenerate

  // APB read of registers.
  // The prdata_scrn should be registered externally.
  always @(*)
  begin
    if (read_registers)
      case (i_paddr)
        `type1_screener_0     : prdata_scrn = scrn_type1[0];
        `type1_screener_1     : prdata_scrn = scrn_type1[1];
        `type1_screener_2     : prdata_scrn = scrn_type1[2];
        `type1_screener_3     : prdata_scrn = scrn_type1[3];
        `type1_screener_4     : prdata_scrn = scrn_type1[4];
        `type1_screener_5     : prdata_scrn = scrn_type1[5];
        `type1_screener_6     : prdata_scrn = scrn_type1[6];
        `type1_screener_7     : prdata_scrn = scrn_type1[7];
        `type1_screener_8     : prdata_scrn = scrn_type1[8];
        `type1_screener_9     : prdata_scrn = scrn_type1[9];
        `type1_screener_10    : prdata_scrn = scrn_type1[10];
        `type1_screener_11    : prdata_scrn = scrn_type1[11];
        `type1_screener_12    : prdata_scrn = scrn_type1[12];
        `type1_screener_13    : prdata_scrn = scrn_type1[13];
        `type1_screener_14    : prdata_scrn = scrn_type1[14];
        `type1_screener_15    : prdata_scrn = scrn_type1[15];
        `type2_screener_0     : prdata_scrn = scrn_type2[0];
        `type2_screener_1     : prdata_scrn = scrn_type2[1];
        `type2_screener_2     : prdata_scrn = scrn_type2[2];
        `type2_screener_3     : prdata_scrn = scrn_type2[3];
        `type2_screener_4     : prdata_scrn = scrn_type2[4];
        `type2_screener_5     : prdata_scrn = scrn_type2[5];
        `type2_screener_6     : prdata_scrn = scrn_type2[6];
        `type2_screener_7     : prdata_scrn = scrn_type2[7];
        `type2_screener_8     : prdata_scrn = scrn_type2[8];
        `type2_screener_9     : prdata_scrn = scrn_type2[9];
        `type2_screener_10    : prdata_scrn = scrn_type2[10];
        `type2_screener_11    : prdata_scrn = scrn_type2[11];
        `type2_screener_12    : prdata_scrn = scrn_type2[12];
        `type2_screener_13    : prdata_scrn = scrn_type2[13];
        `type2_screener_14    : prdata_scrn = scrn_type2[14];
        `type2_screener_15    : prdata_scrn = scrn_type2[15];
        `scr2_ethtype_reg_0   : prdata_scrn = {16'h0000,type2_ethtype[0]};
        `scr2_ethtype_reg_1   : prdata_scrn = {16'h0000,type2_ethtype[1]};
        `scr2_ethtype_reg_2   : prdata_scrn = {16'h0000,type2_ethtype[2]};
        `scr2_ethtype_reg_3   : prdata_scrn = {16'h0000,type2_ethtype[3]};
        `scr2_ethtype_reg_4   : prdata_scrn = {16'h0000,type2_ethtype[4]};
        `scr2_ethtype_reg_5   : prdata_scrn = {16'h0000,type2_ethtype[5]};
        `scr2_ethtype_reg_6   : prdata_scrn = {16'h0000,type2_ethtype[6]};
        `scr2_ethtype_reg_7   : prdata_scrn = {16'h0000,type2_ethtype[7]};
        `scr2_compare_reg_0a  : prdata_scrn = type2_compa[0];
        `scr2_compare_reg_0b  : prdata_scrn = type2_compb[0];
        `scr2_compare_reg_1a  : prdata_scrn = type2_compa[1];
        `scr2_compare_reg_1b  : prdata_scrn = type2_compb[1];
        `scr2_compare_reg_2a  : prdata_scrn = type2_compa[2];
        `scr2_compare_reg_2b  : prdata_scrn = type2_compb[2];
        `scr2_compare_reg_3a  : prdata_scrn = type2_compa[3];
        `scr2_compare_reg_3b  : prdata_scrn = type2_compb[3];
        `scr2_compare_reg_4a  : prdata_scrn = type2_compa[4];
        `scr2_compare_reg_4b  : prdata_scrn = type2_compb[4];
        `scr2_compare_reg_5a  : prdata_scrn = type2_compa[5];
        `scr2_compare_reg_5b  : prdata_scrn = type2_compb[5];
        `scr2_compare_reg_6a  : prdata_scrn = type2_compa[6];
        `scr2_compare_reg_6b  : prdata_scrn = type2_compb[6];
        `scr2_compare_reg_7a  : prdata_scrn = type2_compa[7];
        `scr2_compare_reg_7b  : prdata_scrn = type2_compb[7];
        `scr2_compare_reg_8a  : prdata_scrn = type2_compa[8];
        `scr2_compare_reg_8b  : prdata_scrn = type2_compb[8];
        `scr2_compare_reg_9a  : prdata_scrn = type2_compa[9];
        `scr2_compare_reg_9b  : prdata_scrn = type2_compb[9];
        `scr2_compare_reg_10a : prdata_scrn = type2_compa[10];
        `scr2_compare_reg_10b : prdata_scrn = type2_compb[10];
        `scr2_compare_reg_11a : prdata_scrn = type2_compa[11];
        `scr2_compare_reg_11b : prdata_scrn = type2_compb[11];
        `scr2_compare_reg_12a : prdata_scrn = type2_compa[12];
        `scr2_compare_reg_12b : prdata_scrn = type2_compb[12];
        `scr2_compare_reg_13a : prdata_scrn = type2_compa[13];
        `scr2_compare_reg_13b : prdata_scrn = type2_compb[13];
        `scr2_compare_reg_14a : prdata_scrn = type2_compa[14];
        `scr2_compare_reg_14b : prdata_scrn = type2_compb[14];
        `scr2_compare_reg_15a : prdata_scrn = type2_compa[15];
        `scr2_compare_reg_15b : prdata_scrn = type2_compb[15];
        `scr2_compare_reg_16a : prdata_scrn = type2_compa[16];
        `scr2_compare_reg_16b : prdata_scrn = type2_compb[16];
        `scr2_compare_reg_17a : prdata_scrn = type2_compa[17];
        `scr2_compare_reg_17b : prdata_scrn = type2_compb[17];
        `scr2_compare_reg_18a : prdata_scrn = type2_compa[18];
        `scr2_compare_reg_18b : prdata_scrn = type2_compb[18];
        `scr2_compare_reg_19a : prdata_scrn = type2_compa[19];
        `scr2_compare_reg_19b : prdata_scrn = type2_compb[19];
        `scr2_compare_reg_20a : prdata_scrn = type2_compa[20];
        `scr2_compare_reg_20b : prdata_scrn = type2_compb[20];
        `scr2_compare_reg_21a : prdata_scrn = type2_compa[21];
        `scr2_compare_reg_21b : prdata_scrn = type2_compb[21];
        `scr2_compare_reg_22a : prdata_scrn = type2_compa[22];
        `scr2_compare_reg_22b : prdata_scrn = type2_compb[22];
        `scr2_compare_reg_23a : prdata_scrn = type2_compa[23];
        `scr2_compare_reg_23b : prdata_scrn = type2_compb[23];
        `scr2_compare_reg_24a : prdata_scrn = type2_compa[24];
        `scr2_compare_reg_24b : prdata_scrn = type2_compb[24];
        `scr2_compare_reg_25a : prdata_scrn = type2_compa[25];
        `scr2_compare_reg_25b : prdata_scrn = type2_compb[25];
        `scr2_compare_reg_26a : prdata_scrn = type2_compa[26];
        `scr2_compare_reg_26b : prdata_scrn = type2_compb[26];
        `scr2_compare_reg_27a : prdata_scrn = type2_compa[27];
        `scr2_compare_reg_27b : prdata_scrn = type2_compb[27];
        `scr2_compare_reg_28a : prdata_scrn = type2_compa[28];
        `scr2_compare_reg_28b : prdata_scrn = type2_compb[28];
        `scr2_compare_reg_29a : prdata_scrn = type2_compa[29];
        `scr2_compare_reg_29b : prdata_scrn = type2_compb[29];
        `scr2_compare_reg_30a : prdata_scrn = type2_compa[30];
        `scr2_compare_reg_30b : prdata_scrn = type2_compb[30];
        `scr2_compare_reg_31a : prdata_scrn = type2_compa[31];
        `scr2_compare_reg_31b : prdata_scrn = type2_compb[31];
        `gem_scr2_0_rate_limit: prdata_scrn = scr2_rate_limiting[0];
        `gem_scr2_1_rate_limit: prdata_scrn = scr2_rate_limiting[1];
        `gem_scr2_2_rate_limit: prdata_scrn = scr2_rate_limiting[2];
        `gem_scr2_3_rate_limit: prdata_scrn = scr2_rate_limiting[3];
        `gem_scr2_4_rate_limit: prdata_scrn = scr2_rate_limiting[4];
        `gem_scr2_5_rate_limit: prdata_scrn = scr2_rate_limiting[5];
        `gem_scr2_6_rate_limit: prdata_scrn = scr2_rate_limiting[6];
        `gem_scr2_7_rate_limit: prdata_scrn = scr2_rate_limiting[7];
        `gem_scr2_8_rate_limit: prdata_scrn = scr2_rate_limiting[8];
        `gem_scr2_9_rate_limit: prdata_scrn = scr2_rate_limiting[9];
        `gem_scr2_10_rate_limit:prdata_scrn = scr2_rate_limiting[10];
        `gem_scr2_11_rate_limit:prdata_scrn = scr2_rate_limiting[11];
        `gem_scr2_12_rate_limit:prdata_scrn = scr2_rate_limiting[12];
        `gem_scr2_13_rate_limit:prdata_scrn = scr2_rate_limiting[13];
        `gem_scr2_14_rate_limit:prdata_scrn = scr2_rate_limiting[14];
        `gem_scr2_15_rate_limit:prdata_scrn = scr2_rate_limiting[15];
        `gem_scr_excess_rate   :prdata_scrn = scr_excess_rate_pclk_32;
        default : prdata_scrn = 32'h00000000;
      endcase
    else
      prdata_scrn = 32'h00000000;
  end

  // Perr signal is similar to above. This is registered to match previous implementation
  always @(posedge pclk or negedge n_preset)
  begin
    if (~n_preset)
      perr_scrn <= 1'b0;
    else if (psel)
      case (i_paddr)
        `type1_screener_0     : perr_scrn <= (p_num_type1_screeners < 8'd1);
        `type1_screener_1     : perr_scrn <= (p_num_type1_screeners < 8'd2);
        `type1_screener_2     : perr_scrn <= (p_num_type1_screeners < 8'd3);
        `type1_screener_3     : perr_scrn <= (p_num_type1_screeners < 8'd4);
        `type1_screener_4     : perr_scrn <= (p_num_type1_screeners < 8'd5);
        `type1_screener_5     : perr_scrn <= (p_num_type1_screeners < 8'd6);
        `type1_screener_6     : perr_scrn <= (p_num_type1_screeners < 8'd7);
        `type1_screener_7     : perr_scrn <= (p_num_type1_screeners < 8'd8);
        `type1_screener_8     : perr_scrn <= (p_num_type1_screeners < 8'd9);
        `type1_screener_9     : perr_scrn <= (p_num_type1_screeners < 8'd10);
        `type1_screener_10    : perr_scrn <= (p_num_type1_screeners < 8'd11);
        `type1_screener_11    : perr_scrn <= (p_num_type1_screeners < 8'd12);
        `type1_screener_12    : perr_scrn <= (p_num_type1_screeners < 8'd13);
        `type1_screener_13    : perr_scrn <= (p_num_type1_screeners < 8'd14);
        `type1_screener_14    : perr_scrn <= (p_num_type1_screeners < 8'd15);
        `type1_screener_15    : perr_scrn <= (p_num_type1_screeners < 8'd16);
        `type2_screener_0     : perr_scrn <= (p_num_type2_screeners < 8'd1);
        `type2_screener_1     : perr_scrn <= (p_num_type2_screeners < 8'd2);
        `type2_screener_2     : perr_scrn <= (p_num_type2_screeners < 8'd3);
        `type2_screener_3     : perr_scrn <= (p_num_type2_screeners < 8'd4);
        `type2_screener_4     : perr_scrn <= (p_num_type2_screeners < 8'd5);
        `type2_screener_5     : perr_scrn <= (p_num_type2_screeners < 8'd6);
        `type2_screener_6     : perr_scrn <= (p_num_type2_screeners < 8'd7);
        `type2_screener_7     : perr_scrn <= (p_num_type2_screeners < 8'd8);
        `type2_screener_8     : perr_scrn <= (p_num_type2_screeners < 8'd9);
        `type2_screener_9     : perr_scrn <= (p_num_type2_screeners < 8'd10);
        `type2_screener_10    : perr_scrn <= (p_num_type2_screeners < 8'd11);
        `type2_screener_11    : perr_scrn <= (p_num_type2_screeners < 8'd12);
        `type2_screener_12    : perr_scrn <= (p_num_type2_screeners < 8'd13);
        `type2_screener_13    : perr_scrn <= (p_num_type2_screeners < 8'd14);
        `type2_screener_14    : perr_scrn <= (p_num_type2_screeners < 8'd15);
        `type2_screener_15    : perr_scrn <= (p_num_type2_screeners < 8'd16);
        `scr2_ethtype_reg_0   : perr_scrn <= (p_num_scr2_ethtype_regs < 8'd1);
        `scr2_ethtype_reg_1   : perr_scrn <= (p_num_scr2_ethtype_regs < 8'd2);
        `scr2_ethtype_reg_2   : perr_scrn <= (p_num_scr2_ethtype_regs < 8'd3);
        `scr2_ethtype_reg_3   : perr_scrn <= (p_num_scr2_ethtype_regs < 8'd4);
        `scr2_ethtype_reg_4   : perr_scrn <= (p_num_scr2_ethtype_regs < 8'd5);
        `scr2_ethtype_reg_5   : perr_scrn <= (p_num_scr2_ethtype_regs < 8'd6);
        `scr2_ethtype_reg_6   : perr_scrn <= (p_num_scr2_ethtype_regs < 8'd7);
        `scr2_ethtype_reg_7   : perr_scrn <= (p_num_scr2_ethtype_regs < 8'd8);
        `scr2_compare_reg_0a  : perr_scrn <= (p_num_scr2_compare_regs < 8'd1);
        `scr2_compare_reg_0b  : perr_scrn <= (p_num_scr2_compare_regs < 8'd1);
        `scr2_compare_reg_1a  : perr_scrn <= (p_num_scr2_compare_regs < 8'd2);
        `scr2_compare_reg_1b  : perr_scrn <= (p_num_scr2_compare_regs < 8'd2);
        `scr2_compare_reg_2a  : perr_scrn <= (p_num_scr2_compare_regs < 8'd3);
        `scr2_compare_reg_2b  : perr_scrn <= (p_num_scr2_compare_regs < 8'd3);
        `scr2_compare_reg_3a  : perr_scrn <= (p_num_scr2_compare_regs < 8'd4);
        `scr2_compare_reg_3b  : perr_scrn <= (p_num_scr2_compare_regs < 8'd4);
        `scr2_compare_reg_4a  : perr_scrn <= (p_num_scr2_compare_regs < 8'd5);
        `scr2_compare_reg_4b  : perr_scrn <= (p_num_scr2_compare_regs < 8'd5);
        `scr2_compare_reg_5a  : perr_scrn <= (p_num_scr2_compare_regs < 8'd6);
        `scr2_compare_reg_5b  : perr_scrn <= (p_num_scr2_compare_regs < 8'd6);
        `scr2_compare_reg_6a  : perr_scrn <= (p_num_scr2_compare_regs < 8'd7);
        `scr2_compare_reg_6b  : perr_scrn <= (p_num_scr2_compare_regs < 8'd7);
        `scr2_compare_reg_7a  : perr_scrn <= (p_num_scr2_compare_regs < 8'd8);
        `scr2_compare_reg_7b  : perr_scrn <= (p_num_scr2_compare_regs < 8'd8);
        `scr2_compare_reg_8a  : perr_scrn <= (p_num_scr2_compare_regs < 8'd9);
        `scr2_compare_reg_8b  : perr_scrn <= (p_num_scr2_compare_regs < 8'd9);
        `scr2_compare_reg_9a  : perr_scrn <= (p_num_scr2_compare_regs < 8'd10);
        `scr2_compare_reg_9b  : perr_scrn <= (p_num_scr2_compare_regs < 8'd10);
        `scr2_compare_reg_10a : perr_scrn <= (p_num_scr2_compare_regs < 8'd11);
        `scr2_compare_reg_10b : perr_scrn <= (p_num_scr2_compare_regs < 8'd11);
        `scr2_compare_reg_11a : perr_scrn <= (p_num_scr2_compare_regs < 8'd12);
        `scr2_compare_reg_11b : perr_scrn <= (p_num_scr2_compare_regs < 8'd12);
        `scr2_compare_reg_12a : perr_scrn <= (p_num_scr2_compare_regs < 8'd13);
        `scr2_compare_reg_12b : perr_scrn <= (p_num_scr2_compare_regs < 8'd13);
        `scr2_compare_reg_13a : perr_scrn <= (p_num_scr2_compare_regs < 8'd14);
        `scr2_compare_reg_13b : perr_scrn <= (p_num_scr2_compare_regs < 8'd14);
        `scr2_compare_reg_14a : perr_scrn <= (p_num_scr2_compare_regs < 8'd15);
        `scr2_compare_reg_14b : perr_scrn <= (p_num_scr2_compare_regs < 8'd15);
        `scr2_compare_reg_15a : perr_scrn <= (p_num_scr2_compare_regs < 8'd16);
        `scr2_compare_reg_15b : perr_scrn <= (p_num_scr2_compare_regs < 8'd16);
        `scr2_compare_reg_16a : perr_scrn <= (p_num_scr2_compare_regs < 8'd17);
        `scr2_compare_reg_16b : perr_scrn <= (p_num_scr2_compare_regs < 8'd17);
        `scr2_compare_reg_17a : perr_scrn <= (p_num_scr2_compare_regs < 8'd18);
        `scr2_compare_reg_17b : perr_scrn <= (p_num_scr2_compare_regs < 8'd18);
        `scr2_compare_reg_18a : perr_scrn <= (p_num_scr2_compare_regs < 8'd19);
        `scr2_compare_reg_18b : perr_scrn <= (p_num_scr2_compare_regs < 8'd19);
        `scr2_compare_reg_19a : perr_scrn <= (p_num_scr2_compare_regs < 8'd20);
        `scr2_compare_reg_19b : perr_scrn <= (p_num_scr2_compare_regs < 8'd20);
        `scr2_compare_reg_20a : perr_scrn <= (p_num_scr2_compare_regs < 8'd21);
        `scr2_compare_reg_20b : perr_scrn <= (p_num_scr2_compare_regs < 8'd21);
        `scr2_compare_reg_21a : perr_scrn <= (p_num_scr2_compare_regs < 8'd22);
        `scr2_compare_reg_21b : perr_scrn <= (p_num_scr2_compare_regs < 8'd22);
        `scr2_compare_reg_22a : perr_scrn <= (p_num_scr2_compare_regs < 8'd23);
        `scr2_compare_reg_22b : perr_scrn <= (p_num_scr2_compare_regs < 8'd23);
        `scr2_compare_reg_23a : perr_scrn <= (p_num_scr2_compare_regs < 8'd24);
        `scr2_compare_reg_23b : perr_scrn <= (p_num_scr2_compare_regs < 8'd24);
        `scr2_compare_reg_24a : perr_scrn <= (p_num_scr2_compare_regs < 8'd25);
        `scr2_compare_reg_24b : perr_scrn <= (p_num_scr2_compare_regs < 8'd25);
        `scr2_compare_reg_25a : perr_scrn <= (p_num_scr2_compare_regs < 8'd26);
        `scr2_compare_reg_25b : perr_scrn <= (p_num_scr2_compare_regs < 8'd26);
        `scr2_compare_reg_26a : perr_scrn <= (p_num_scr2_compare_regs < 8'd27);
        `scr2_compare_reg_26b : perr_scrn <= (p_num_scr2_compare_regs < 8'd27);
        `scr2_compare_reg_27a : perr_scrn <= (p_num_scr2_compare_regs < 8'd28);
        `scr2_compare_reg_27b : perr_scrn <= (p_num_scr2_compare_regs < 8'd28);
        `scr2_compare_reg_28a : perr_scrn <= (p_num_scr2_compare_regs < 8'd29);
        `scr2_compare_reg_28b : perr_scrn <= (p_num_scr2_compare_regs < 8'd29);
        `scr2_compare_reg_29a : perr_scrn <= (p_num_scr2_compare_regs < 8'd30);
        `scr2_compare_reg_29b : perr_scrn <= (p_num_scr2_compare_regs < 8'd30);
        `scr2_compare_reg_30a : perr_scrn <= (p_num_scr2_compare_regs < 8'd31);
        `scr2_compare_reg_30b : perr_scrn <= (p_num_scr2_compare_regs < 8'd31);
        `scr2_compare_reg_31a : perr_scrn <= (p_num_scr2_compare_regs < 8'd32);
        `scr2_compare_reg_31b : perr_scrn <= (p_num_scr2_compare_regs < 8'd32);
        `gem_scr2_0_rate_limit: perr_scrn <= (p_num_type2_screeners < 8'd1);
        `gem_scr2_1_rate_limit: perr_scrn <= (p_num_type2_screeners < 8'd2);
        `gem_scr2_2_rate_limit: perr_scrn <= (p_num_type2_screeners < 8'd3);
        `gem_scr2_3_rate_limit: perr_scrn <= (p_num_type2_screeners < 8'd4);
        `gem_scr2_4_rate_limit: perr_scrn <= (p_num_type2_screeners < 8'd5);
        `gem_scr2_5_rate_limit: perr_scrn <= (p_num_type2_screeners < 8'd6);
        `gem_scr2_6_rate_limit: perr_scrn <= (p_num_type2_screeners < 8'd7);
        `gem_scr2_7_rate_limit: perr_scrn <= (p_num_type2_screeners < 8'd8);
        `gem_scr2_8_rate_limit: perr_scrn <= (p_num_type2_screeners < 8'd9);
        `gem_scr2_9_rate_limit: perr_scrn <= (p_num_type2_screeners < 8'd10);
        `gem_scr2_10_rate_limit:perr_scrn <= (p_num_type2_screeners < 8'd11);
        `gem_scr2_11_rate_limit:perr_scrn <= (p_num_type2_screeners < 8'd12);
        `gem_scr2_12_rate_limit:perr_scrn <= (p_num_type2_screeners < 8'd13);
        `gem_scr2_13_rate_limit:perr_scrn <= (p_num_type2_screeners < 8'd14);
        `gem_scr2_14_rate_limit:perr_scrn <= (p_num_type2_screeners < 8'd15);
        `gem_scr2_15_rate_limit:perr_scrn <= (p_num_type2_screeners < 8'd16);
        `gem_scr_excess_rate   :perr_scrn <= (p_num_type2_screeners < 8'd1);
        default : perr_scrn <= 1'b1;
      endcase
    else
      perr_scrn <= 1'b0;
  end

  // Register parity error if supported
  generate if (p_parity_prot == 1) begin : gen_par
    reg scrn_par_err_r;
    always @(posedge pclk or negedge n_preset)
    begin
      if (~n_preset)
        scrn_par_err_r  <= 1'b0;
      else
        scrn_par_err_r  <=  (|scrn_type1_par_err) |
                            (|scrn_type2_par_err) |
                            (|ethtype_par_err)    |
                            (|type2_comp_par_err) |
                            (|scr2_rate_lim_par_err);
    end
    assign scrn_par_err = scrn_par_err_r;
  end
  else begin : gen_no_par
    assign scrn_par_err = 1'b0;
  end
  endgenerate


endmodule
