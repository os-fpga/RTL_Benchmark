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
//   Filename:           gem_reg_filters.v
//   Module Name:        gem_reg_filters
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
//   Description    : Contains filtering registers such as hash and specific
//                    address regs.
//
//------------------------------------------------------------------------------

// include definitions files
`ifndef gem_defs_defined
`define gem_defs_defined
`include "gem_gxl_defs.v"
`include "edma_defs.v"
`endif

module gem_reg_filters # (
  parameter p_num_spec_add_filters  = 32'd4,
  parameter p_parity_prot           = 1'b0,
  parameter p_edma_asf_dap_prot     = 1'b0
)(
  input               pclk,                   // APB clock
  input               n_preset,               // Active low reset
  input       [11:0]  i_paddr,                // Full APB address
  input               psel,                   // APB select
  input               write_registers,        // write to apb registers.
  input               read_registers,         // read from apb registers.
  input       [31:0]  pwdata,                 // APB write data
  input       [3:0]   pwdata_par,             // Parity associated with pwdata
  output  reg [63:0]  hash,                   // hash register for destination
                                              // address filtering.
  output  reg [47:0]  mask_add1,              // specific address 1 mask for
                                              // destination address comparison.
  output  reg [15:0]  spec_type1,             // specific type 1 for type comparison
  output  reg [15:0]  spec_type2,             // specific type 2 for type comparison
  output  reg [15:0]  spec_type3,             // specific type 3 for type comparison
  output  reg [15:0]  spec_type4,             // specific type 4 for type comparison
  output  reg         spec_type1_active,      // spec_type1 can be used for type
                                              // comparison.
  output  reg         spec_type2_active,      // spec_type2 can be used for type
                                              // comparison.
  output  reg         spec_type3_active,      // spec_type3 can be used for type
                                              // comparison.
  output  reg         spec_type4_active,      // spec_type4 can be used for type
                                              // comparison.
  output      [55*(p_num_spec_add_filters+1)-1:0]
                      spec_add_filter_regs,   // specific address filters
  output      [p_num_spec_add_filters:0]
                      spec_add_filter_active, // specific address filter active
  output      [47:0]  spec_add1_tx,           // Source address for pause tx
  output      [5:0]   spec_add1_tx_par,       // Parity
  output  reg [31:0]  prdata_filters,         // APB read data (comb)
  output  reg         perr_filters,           // Perr signalling (reg)
  output              filt_par_err            // Parity error
);

  wire  [31:0]  spec_add_filt_top[35:0];  // Array of all possible specific address
  wire  [31:0]  spec_add_filt_bot[35:0];  // registers top and bottom.
  wire  [35:0]  spec_add_par_err;         // Parity error of specific address registers


  // Fixed filter registers

  // Write registers
  always @(posedge pclk or negedge n_preset)
  begin
    if (~n_preset)
    begin
      hash              <= 64'd0;
      mask_add1         <= 48'd0;
      spec_type1        <= 16'h0000;
      spec_type2        <= 16'h0000;
      spec_type3        <= 16'h0000;
      spec_type4        <= 16'h0000;
      spec_type1_active <= 1'b0;
      spec_type2_active <= 1'b0;
      spec_type3_active <= 1'b0;
      spec_type4_active <= 1'b0;
    end
    else
      if (write_registers) // begin if (write_registers)
        case (i_paddr)
          `gem_hash_bottom       : hash[31:0]       <= pwdata[31:0];
          `gem_hash_top          : hash[63:32]      <= pwdata[31:0];
          `gem_mask_add1_bottom  : mask_add1[31:0]  <= pwdata[31:0];
          `gem_mask_add1_top     : mask_add1[47:32] <= pwdata[15:0];

          `gem_spec_type1 :
          begin
            spec_type1[15:0]  <= pwdata[15:0];
            spec_type1_active <= pwdata[31];
          end
          `gem_spec_type2 :
          begin
            spec_type2[15:0]  <= pwdata[15:0];
            spec_type2_active <= pwdata[31];
          end
          `gem_spec_type3 :
          begin
            spec_type3[15:0]  <= pwdata[15:0];
            spec_type3_active <= pwdata[31];
          end
          `gem_spec_type4 :
          begin
            spec_type4[15:0]  <= pwdata[15:0];
            spec_type4_active <= pwdata[31];
          end
          default : ;
        endcase
  end


  // Populate all supported Specific Address Registers.
  // Note that p_num_spec_add_filters has a minimum value of 1 as it is required
  // by the mandatory TX pause functionality.
  genvar  loop_sa;
  generate for (loop_sa=0;loop_sa<36;loop_sa=loop_sa+1) begin : gen_spec_add_filt
    if (loop_sa < p_num_spec_add_filters[31:0]) begin : gen_exists
      wire  [11:0] addr_offset;
      wire  [11:0] addr_base;
      reg          spec_add_filter_active_r;
      wire  [12:0] matching_addr_bottom;
      wire  [12:0] matching_addr_top;

      // The register addresses are mapped in two separate ranges...
      if (loop_sa < 4) begin : gen_0_4_addr
        assign addr_base  = `gem_spec_add1_bottom;
      end else begin : gen_5_addr
        assign addr_base  = `gem_spec_add5_bottom - 12'h020;
      end

      assign addr_offset          = (loop_sa * 12'h008);
      assign matching_addr_bottom = addr_base + addr_offset;
      assign matching_addr_top    = matching_addr_bottom[11:0] + 12'h004;

      // The first specific address register does not have mask bits
      if (loop_sa < 1) begin : gen_0
        reg [48:0]  spec_add_filt_r;

        // Writes to the register
        always @(posedge pclk or negedge n_preset)
        begin
          if (~n_preset)
            spec_add_filt_r <= {49{1'b0}};
          else if (write_registers)
          begin
            if (i_paddr == matching_addr_bottom[11:0])
              spec_add_filt_r[31:0]   <= pwdata;
            else if (i_paddr == matching_addr_top[11:0])
              spec_add_filt_r[48:32]  <= pwdata[16:0];
          end
        end
        assign spec_add_filt_bot[loop_sa] = spec_add_filt_r[31:0];
        assign spec_add_filt_top[loop_sa] = {{15{1'b0}},spec_add_filt_r[48:32]};
        assign spec_add_filter_regs[(loop_sa*55)+54:(loop_sa*55)] = {6'h00,spec_add_filt_r};
        assign spec_add1_tx               = spec_add_filt_r[47:0];

        // Optional parity protection
        if ((p_parity_prot == 1) ||
            (p_edma_asf_dap_prot == 1)) begin : gen_par
          reg   [6:0] spec_add_par;

          // Store associated parity
          always @(posedge pclk or negedge n_preset)
          begin
            if (~n_preset)
              spec_add_par <= 7'h00;
            else if (write_registers)
            begin
              if (i_paddr == matching_addr_bottom[11:0])
                spec_add_par[3:0] <= pwdata_par;
              else if (i_paddr == matching_addr_top[11:0])
                spec_add_par[6:4] <= {pwdata[16],pwdata_par[1:0]};
            end
          end

          // Check the parity constantly
          cdnsdru_asf_parity_check_v1 #(.p_data_width(49)) i_par_chk (
            .odd_par    (1'b0),
            .data_in    (spec_add_filt_r),
            .parity_in  (spec_add_par),
            .parity_err (spec_add_par_err[loop_sa])
          );
          assign spec_add1_tx_par = spec_add_par[5:0];
        end else begin : gen_no_par
          assign spec_add_par_err[loop_sa]  = 1'b0;
          assign spec_add1_tx_par = 6'h00;
        end

      end else begin : gen_others
        reg   [54:0]  spec_add_filt_r;

        // Writes to the register
        always @(posedge pclk or negedge n_preset)
        begin
          if (~n_preset)
            spec_add_filt_r <= {55{1'b0}};
          else if (write_registers)
          begin
            if (i_paddr == matching_addr_bottom[11:0])
              spec_add_filt_r[31:0]   <= pwdata;
            else if (i_paddr == matching_addr_top[11:0])
              spec_add_filt_r[54:32]  <= {pwdata[29:24],pwdata[16:0]};
          end
        end
        assign spec_add_filt_bot[loop_sa]  = spec_add_filt_r[31:0];
        assign spec_add_filt_top[loop_sa]  = {2'h0,spec_add_filt_r[54:49],7'd0,spec_add_filt_r[48:32]};
        assign spec_add_filter_regs[(loop_sa*55)+54:(loop_sa*55)] = spec_add_filt_r;

        // Optional parity protection
        if (p_parity_prot == 1) begin : gen_par
          reg   [6:0] spec_add_par;

          // Store associated parity
          always @(posedge pclk or negedge n_preset)
          begin
            if (~n_preset)
              spec_add_par <= 7'h00;
            else if (write_registers)
            begin
              if (i_paddr == matching_addr_bottom[11:0])
                spec_add_par[3:0] <= pwdata_par;
              else if (i_paddr == matching_addr_top[11:0])
                spec_add_par[6:4] <= {^{pwdata[29:24],pwdata[16]},pwdata_par[1:0]};
            end
          end

          // Check the parity constantly
          cdnsdru_asf_parity_check_v1 #(.p_data_width(55)) i_par_chk (
            .odd_par    (1'b0),
            .data_in    (spec_add_filt_r),
            .parity_in  (spec_add_par),
            .parity_err (spec_add_par_err[loop_sa])
          );
        end else begin : gen_no_par
          assign spec_add_par_err[loop_sa]  = 1'b0;
        end

      end
      
      // spec_add_filter_active is set when top is written and cleared when bottom is written
      always @(posedge pclk or negedge n_preset)
      begin
        if (~n_preset)
          spec_add_filter_active_r  <= 1'b0;
        else if (write_registers)
        begin
          if (i_paddr == matching_addr_bottom[11:0])
            spec_add_filter_active_r  <= 1'b0;
          else if (i_paddr == matching_addr_top[11:0])
            spec_add_filter_active_r  <= 1'b1;
        end
      end
      assign spec_add_filter_active[loop_sa]  = spec_add_filter_active_r;
    end
    else
    begin : gen_no_exists
      assign spec_add_filt_top[loop_sa] = {32{1'b0}};
      assign spec_add_filt_bot[loop_sa] = {32{1'b0}};
      assign spec_add_par_err[loop_sa]  = 1'b0;
    end
  end
  endgenerate

  // Pad the top bits, this is legacy support to match old behavior, consider removing later.
  assign spec_add_filter_regs[55*(p_num_spec_add_filters+1)-1:(55*p_num_spec_add_filters)]  = {55{1'b0}};
  assign spec_add_filter_active[p_num_spec_add_filters] = 1'b0;


  // Read registers
  always @(*)
  begin
    if (read_registers)
      case (i_paddr)
        `gem_hash_bottom      : prdata_filters  = hash[31:0];
        `gem_hash_top         : prdata_filters  = hash[63:32];
        `gem_mask_add1_bottom : prdata_filters  = mask_add1[31:0];
        `gem_mask_add1_top    : prdata_filters  = {16'h0000,mask_add1[47:32]};
        `gem_spec_type1       : prdata_filters  = {spec_type1_active, 15'h0000,
                                               spec_type1[15:0]};
        `gem_spec_type2       : prdata_filters  = {spec_type2_active, 15'h0000,
                                               spec_type2[15:0]};
        `gem_spec_type3       : prdata_filters  = {spec_type3_active, 15'h0000,
                                               spec_type3[15:0]};
        `gem_spec_type4       : prdata_filters  = {spec_type4_active, 15'h0000,
                                               spec_type4[15:0]};
        `gem_spec_add1_bottom   : prdata_filters  = spec_add_filt_bot[0];
        `gem_spec_add1_top      : prdata_filters  = spec_add_filt_top[0];
        `gem_spec_add2_bottom   : prdata_filters  = spec_add_filt_bot[1];
        `gem_spec_add2_top      : prdata_filters  = spec_add_filt_top[1];
        `gem_spec_add3_bottom   : prdata_filters  = spec_add_filt_bot[2];
        `gem_spec_add3_top      : prdata_filters  = spec_add_filt_top[2];
        `gem_spec_add4_bottom   : prdata_filters  = spec_add_filt_bot[3];
        `gem_spec_add4_top      : prdata_filters  = spec_add_filt_top[3];
        `gem_spec_add5_bottom   : prdata_filters  = spec_add_filt_bot[4];
        `gem_spec_add5_top      : prdata_filters  = spec_add_filt_top[4];
        `gem_spec_add6_bottom   : prdata_filters  = spec_add_filt_bot[5];
        `gem_spec_add6_top      : prdata_filters  = spec_add_filt_top[5];
        `gem_spec_add7_bottom   : prdata_filters  = spec_add_filt_bot[6];
        `gem_spec_add7_top      : prdata_filters  = spec_add_filt_top[6];
        `gem_spec_add8_bottom   : prdata_filters  = spec_add_filt_bot[7];
        `gem_spec_add8_top      : prdata_filters  = spec_add_filt_top[7];
        `gem_spec_add9_bottom   : prdata_filters  = spec_add_filt_bot[8];
        `gem_spec_add9_top      : prdata_filters  = spec_add_filt_top[8];
        `gem_spec_add10_bottom  : prdata_filters  = spec_add_filt_bot[9];
        `gem_spec_add10_top     : prdata_filters  = spec_add_filt_top[9];
        `gem_spec_add11_bottom  : prdata_filters  = spec_add_filt_bot[10];
        `gem_spec_add11_top     : prdata_filters  = spec_add_filt_top[10];
        `gem_spec_add12_bottom  : prdata_filters  = spec_add_filt_bot[11];
        `gem_spec_add12_top     : prdata_filters  = spec_add_filt_top[11];
        `gem_spec_add13_bottom  : prdata_filters  = spec_add_filt_bot[12];
        `gem_spec_add13_top     : prdata_filters  = spec_add_filt_top[12];
        `gem_spec_add14_bottom  : prdata_filters  = spec_add_filt_bot[13];
        `gem_spec_add14_top     : prdata_filters  = spec_add_filt_top[13];
        `gem_spec_add15_bottom  : prdata_filters  = spec_add_filt_bot[14];
        `gem_spec_add15_top     : prdata_filters  = spec_add_filt_top[14];
        `gem_spec_add16_bottom  : prdata_filters  = spec_add_filt_bot[15];
        `gem_spec_add16_top     : prdata_filters  = spec_add_filt_top[15];
        `gem_spec_add17_bottom  : prdata_filters  = spec_add_filt_bot[16];
        `gem_spec_add17_top     : prdata_filters  = spec_add_filt_top[16];
        `gem_spec_add18_bottom  : prdata_filters  = spec_add_filt_bot[17];
        `gem_spec_add18_top     : prdata_filters  = spec_add_filt_top[17];
        `gem_spec_add19_bottom  : prdata_filters  = spec_add_filt_bot[18];
        `gem_spec_add19_top     : prdata_filters  = spec_add_filt_top[18];
        `gem_spec_add20_bottom  : prdata_filters  = spec_add_filt_bot[19];
        `gem_spec_add20_top     : prdata_filters  = spec_add_filt_top[19];
        `gem_spec_add21_bottom  : prdata_filters  = spec_add_filt_bot[20];
        `gem_spec_add21_top     : prdata_filters  = spec_add_filt_top[20];
        `gem_spec_add22_bottom  : prdata_filters  = spec_add_filt_bot[21];
        `gem_spec_add22_top     : prdata_filters  = spec_add_filt_top[21];
        `gem_spec_add23_bottom  : prdata_filters  = spec_add_filt_bot[22];
        `gem_spec_add23_top     : prdata_filters  = spec_add_filt_top[22];
        `gem_spec_add24_bottom  : prdata_filters  = spec_add_filt_bot[23];
        `gem_spec_add24_top     : prdata_filters  = spec_add_filt_top[23];
        `gem_spec_add25_bottom  : prdata_filters  = spec_add_filt_bot[24];
        `gem_spec_add25_top     : prdata_filters  = spec_add_filt_top[24];
        `gem_spec_add26_bottom  : prdata_filters  = spec_add_filt_bot[25];
        `gem_spec_add26_top     : prdata_filters  = spec_add_filt_top[25];
        `gem_spec_add27_bottom  : prdata_filters  = spec_add_filt_bot[26];
        `gem_spec_add27_top     : prdata_filters  = spec_add_filt_top[26];
        `gem_spec_add28_bottom  : prdata_filters  = spec_add_filt_bot[27];
        `gem_spec_add28_top     : prdata_filters  = spec_add_filt_top[27];
        `gem_spec_add29_bottom  : prdata_filters  = spec_add_filt_bot[28];
        `gem_spec_add29_top     : prdata_filters  = spec_add_filt_top[28];
        `gem_spec_add30_bottom  : prdata_filters  = spec_add_filt_bot[29];
        `gem_spec_add30_top     : prdata_filters  = spec_add_filt_top[29];
        `gem_spec_add31_bottom  : prdata_filters  = spec_add_filt_bot[30];
        `gem_spec_add31_top     : prdata_filters  = spec_add_filt_top[30];
        `gem_spec_add32_bottom  : prdata_filters  = spec_add_filt_bot[31];
        `gem_spec_add32_top     : prdata_filters  = spec_add_filt_top[31];
        `gem_spec_add33_bottom  : prdata_filters  = spec_add_filt_bot[32];
        `gem_spec_add33_top     : prdata_filters  = spec_add_filt_top[32];
        `gem_spec_add34_bottom  : prdata_filters  = spec_add_filt_bot[33];
        `gem_spec_add34_top     : prdata_filters  = spec_add_filt_top[33];
        `gem_spec_add35_bottom  : prdata_filters  = spec_add_filt_bot[34];
        `gem_spec_add35_top     : prdata_filters  = spec_add_filt_top[34];
        `gem_spec_add36_bottom  : prdata_filters  = spec_add_filt_bot[35];
        `gem_spec_add36_top     : prdata_filters  = spec_add_filt_top[35];
        default               : prdata_filters  = 32'h00000000;
      endcase
    else
      prdata_filters  = 32'h00000000;
  end

  // Perr signal is similar to above. This is registered to match previous implementation
  always @(posedge pclk or negedge n_preset)
  begin
    if (~n_preset)
      perr_filters  <= 1'b0;
    else if (psel)
      case (i_paddr)
        `gem_hash_bottom      : perr_filters  <= 1'b0;
        `gem_hash_top         : perr_filters  <= 1'b0;
        `gem_mask_add1_bottom : perr_filters  <= 1'b0;
        `gem_mask_add1_top    : perr_filters  <= 1'b0;
        `gem_spec_type1       : perr_filters  <= 1'b0;
        `gem_spec_type2       : perr_filters  <= 1'b0;
        `gem_spec_type3       : perr_filters  <= 1'b0;
        `gem_spec_type4       : perr_filters  <= 1'b0;
        `gem_spec_add1_bottom : perr_filters  <= 1'b0;
        `gem_spec_add1_top    : perr_filters  <= 1'b0;
        `gem_spec_add2_bottom : perr_filters  <= (p_num_spec_add_filters < 32'd2);
        `gem_spec_add2_top    : perr_filters  <= (p_num_spec_add_filters < 32'd2);
        `gem_spec_add3_bottom : perr_filters  <= (p_num_spec_add_filters < 32'd3);
        `gem_spec_add3_top    : perr_filters  <= (p_num_spec_add_filters < 32'd3);
        `gem_spec_add4_bottom : perr_filters  <= (p_num_spec_add_filters < 32'd4);
        `gem_spec_add4_top    : perr_filters  <= (p_num_spec_add_filters < 32'd4);
        `gem_spec_add5_bottom : perr_filters  <= (p_num_spec_add_filters < 32'd5);
        `gem_spec_add5_top    : perr_filters  <= (p_num_spec_add_filters < 32'd5);
        `gem_spec_add6_bottom : perr_filters  <= (p_num_spec_add_filters < 32'd6);
        `gem_spec_add6_top    : perr_filters  <= (p_num_spec_add_filters < 32'd6);
        `gem_spec_add7_bottom : perr_filters  <= (p_num_spec_add_filters < 32'd7);
        `gem_spec_add7_top    : perr_filters  <= (p_num_spec_add_filters < 32'd7);
        `gem_spec_add8_bottom : perr_filters  <= (p_num_spec_add_filters < 32'd8);
        `gem_spec_add8_top    : perr_filters  <= (p_num_spec_add_filters < 32'd8);
        `gem_spec_add9_bottom : perr_filters  <= (p_num_spec_add_filters < 32'd9);
        `gem_spec_add9_top    : perr_filters  <= (p_num_spec_add_filters < 32'd9);
        `gem_spec_add10_bottom  : perr_filters  <= (p_num_spec_add_filters < 32'd10);
        `gem_spec_add10_top     : perr_filters  <= (p_num_spec_add_filters < 32'd10);
        `gem_spec_add11_bottom  : perr_filters  <= (p_num_spec_add_filters < 32'd11);
        `gem_spec_add11_top     : perr_filters  <= (p_num_spec_add_filters < 32'd11);
        `gem_spec_add12_bottom  : perr_filters  <= (p_num_spec_add_filters < 32'd12);
        `gem_spec_add12_top     : perr_filters  <= (p_num_spec_add_filters < 32'd12);
        `gem_spec_add13_bottom  : perr_filters  <= (p_num_spec_add_filters < 32'd13);
        `gem_spec_add13_top     : perr_filters  <= (p_num_spec_add_filters < 32'd13);
        `gem_spec_add14_bottom  : perr_filters  <= (p_num_spec_add_filters < 32'd14);
        `gem_spec_add14_top     : perr_filters  <= (p_num_spec_add_filters < 32'd14);
        `gem_spec_add15_bottom  : perr_filters  <= (p_num_spec_add_filters < 32'd15);
        `gem_spec_add15_top     : perr_filters  <= (p_num_spec_add_filters < 32'd15);
        `gem_spec_add16_bottom  : perr_filters  <= (p_num_spec_add_filters < 32'd16);
        `gem_spec_add16_top     : perr_filters  <= (p_num_spec_add_filters < 32'd16);
        `gem_spec_add17_bottom  : perr_filters  <= (p_num_spec_add_filters < 32'd17);
        `gem_spec_add17_top     : perr_filters  <= (p_num_spec_add_filters < 32'd17);
        `gem_spec_add18_bottom  : perr_filters  <= (p_num_spec_add_filters < 32'd18);
        `gem_spec_add18_top     : perr_filters  <= (p_num_spec_add_filters < 32'd18);
        `gem_spec_add19_bottom  : perr_filters  <= (p_num_spec_add_filters < 32'd19);
        `gem_spec_add19_top     : perr_filters  <= (p_num_spec_add_filters < 32'd19);
        `gem_spec_add20_bottom  : perr_filters  <= (p_num_spec_add_filters < 32'd20);
        `gem_spec_add20_top     : perr_filters  <= (p_num_spec_add_filters < 32'd20);
        `gem_spec_add21_bottom  : perr_filters  <= (p_num_spec_add_filters < 32'd21);
        `gem_spec_add21_top     : perr_filters  <= (p_num_spec_add_filters < 32'd21);
        `gem_spec_add22_bottom  : perr_filters  <= (p_num_spec_add_filters < 32'd22);
        `gem_spec_add22_top     : perr_filters  <= (p_num_spec_add_filters < 32'd22);
        `gem_spec_add23_bottom  : perr_filters  <= (p_num_spec_add_filters < 32'd23);
        `gem_spec_add23_top     : perr_filters  <= (p_num_spec_add_filters < 32'd23);
        `gem_spec_add24_bottom  : perr_filters  <= (p_num_spec_add_filters < 32'd24);
        `gem_spec_add24_top     : perr_filters  <= (p_num_spec_add_filters < 32'd24);
        `gem_spec_add25_bottom  : perr_filters  <= (p_num_spec_add_filters < 32'd25);
        `gem_spec_add25_top     : perr_filters  <= (p_num_spec_add_filters < 32'd25);
        `gem_spec_add26_bottom  : perr_filters  <= (p_num_spec_add_filters < 32'd26);
        `gem_spec_add26_top     : perr_filters  <= (p_num_spec_add_filters < 32'd26);
        `gem_spec_add27_bottom  : perr_filters  <= (p_num_spec_add_filters < 32'd27);
        `gem_spec_add27_top     : perr_filters  <= (p_num_spec_add_filters < 32'd27);
        `gem_spec_add28_bottom  : perr_filters  <= (p_num_spec_add_filters < 32'd28);
        `gem_spec_add28_top     : perr_filters  <= (p_num_spec_add_filters < 32'd28);
        `gem_spec_add29_bottom  : perr_filters  <= (p_num_spec_add_filters < 32'd29);
        `gem_spec_add29_top     : perr_filters  <= (p_num_spec_add_filters < 32'd29);
        `gem_spec_add30_bottom  : perr_filters  <= (p_num_spec_add_filters < 32'd30);
        `gem_spec_add30_top     : perr_filters  <= (p_num_spec_add_filters < 32'd30);
        `gem_spec_add31_bottom  : perr_filters  <= (p_num_spec_add_filters < 32'd31);
        `gem_spec_add31_top     : perr_filters  <= (p_num_spec_add_filters < 32'd31);
        `gem_spec_add32_bottom  : perr_filters  <= (p_num_spec_add_filters < 32'd32);
        `gem_spec_add32_top     : perr_filters  <= (p_num_spec_add_filters < 32'd32);
        `gem_spec_add33_bottom  : perr_filters  <= (p_num_spec_add_filters < 32'd33);
        `gem_spec_add33_top     : perr_filters  <= (p_num_spec_add_filters < 32'd33);
        `gem_spec_add34_bottom  : perr_filters  <= (p_num_spec_add_filters < 32'd34);
        `gem_spec_add34_top     : perr_filters  <= (p_num_spec_add_filters < 32'd34);
        `gem_spec_add35_bottom  : perr_filters  <= (p_num_spec_add_filters < 32'd35);
        `gem_spec_add35_top     : perr_filters  <= (p_num_spec_add_filters < 32'd35);
        `gem_spec_add36_bottom  : perr_filters  <= (p_num_spec_add_filters < 32'd36);
        `gem_spec_add36_top     : perr_filters  <= (p_num_spec_add_filters < 32'd36);
        default               : perr_filters  <= 1'b1;
      endcase
    else
      perr_filters  <= 1'b0;
  end


  // Optional parity protection
  generate if (p_parity_prot == 1) begin : gen_par
    reg   [7:0] hash_par;
    reg   [5:0] mask_par;
    reg   [2:0] type1_par;
    reg   [2:0] type2_par;
    reg   [2:0] type3_par;
    reg   [2:0] type4_par;
    reg         filt_par_err_r;
    wire        filt_par_err_int;

    // Store associated parity
    always @(posedge pclk or negedge n_preset)
    begin
      if (~n_preset)
      begin
        hash_par  <= 8'h00;
        mask_par  <= 6'h00;
        type1_par <= 3'h0;
        type2_par <= 3'h0;
        type3_par <= 3'h0;
        type4_par <= 3'h0;
      end
      else if (write_registers)
      begin
        if (i_paddr == `gem_hash_bottom)
          hash_par[3:0] <= pwdata_par;
        if (i_paddr == `gem_hash_top)
          hash_par[7:4] <= pwdata_par;
        if (i_paddr == `gem_mask_add1_bottom)
          mask_par[3:0] <= pwdata_par;
        if (i_paddr == `gem_mask_add1_top)
          mask_par[5:4] <= pwdata_par[1:0];
        if (i_paddr == `gem_spec_type1)
          type1_par     <= {pwdata[31],pwdata_par[1:0]};
        if (i_paddr == `gem_spec_type2)
          type2_par     <= {pwdata[31],pwdata_par[1:0]};
        if (i_paddr == `gem_spec_type3)
          type3_par     <= {pwdata[31],pwdata_par[1:0]};
        if (i_paddr == `gem_spec_type4)
          type4_par     <= {pwdata[31],pwdata_par[1:0]};
      end
    end

    // Check the parity constantly
    cdnsdru_asf_parity_check_v1 #(.p_data_width(208)) i_par_chk (
      .odd_par    (1'b0),
      .data_in    ({7'h00,spec_type4_active,spec_type4,
                    7'h00,spec_type3_active,spec_type3,
                    7'h00,spec_type2_active,spec_type2,
                    7'h00,spec_type1_active,spec_type1,
                    mask_add1,
                    hash}),
      .parity_in  ({type4_par,
                    type3_par,
                    type2_par,
                    type1_par,
                    mask_par,
                    hash_par}),
      .parity_err (filt_par_err_int)
    );

    // Register parity check results
    always @(posedge pclk or negedge n_preset)
    begin
      if (~n_preset)
        filt_par_err_r  <= 1'b0;
      else
        filt_par_err_r  <= (|spec_add_par_err) | filt_par_err_int;
    end
    assign filt_par_err = filt_par_err_r;

  end else begin : gen_no_par
    assign filt_par_err = 1'b0;
  end
  endgenerate

endmodule
