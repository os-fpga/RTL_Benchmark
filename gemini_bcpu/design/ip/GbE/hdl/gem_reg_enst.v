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
//   Filename:           gem_reg_enst.v
//   Module Name:        gem_reg_enst
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
//   Description    : Contains registers for QBV ENST functionality.
//
//------------------------------------------------------------------------------

// include definitions files
`ifndef gem_defs_defined
`define gem_defs_defined
`include "gem_gxl_defs.v"
`include "edma_defs.v"
`endif

module gem_reg_enst # (
  parameter p_edma_queues = 32'd1,
  parameter p_parity_prot = 1'b0
)(
  input               pclk,                 // APB clock
  input               n_preset,             // Active low reset
  input       [11:0]  i_paddr,              // Full APB address
  input               psel,                 // APB select
  input               write_registers,      // write to apb registers.
  input               read_registers,       // read from apb registers.
  input       [31:0]  pwdata,               // APB write data
  input       [3:0]   pwdata_par,           // Parity associated with pwdata

  output  reg [7:0]   enst_en,              // Disable/Enable vector
  output      [255:0] start_time,           // start_time of the transmission
  output      [135:0] on_time,              // on_time of the transmission expressed in bytes
  output      [135:0] off_time,             // off_time of the transmission expressed in bytes

  output  reg [31:0]  prdata_enst,          // APB read data combinatorial
  output  reg         perr_enst,            // APB access error, registered
  output              enst_par_err          // Parity error detected

);

  // Up to a maximum of 8 ENST controllable queues are supported
  localparam p_num_enst  = p_edma_queues <= 32'd8 ? p_edma_queues : 32'd8;

  reg   [31:0]  start_time_r[p_num_enst-1:0]; // Array of registers for start_time
  reg   [16:0]  on_time_r[p_num_enst-1:0];    // Array of registers for on_time
  reg   [16:0]  off_time_r[p_num_enst-1:0];   // Array of registers for off_time

  wire  [p_num_enst-1:0]  enst_par_err_int;   // Parity error for each ENST function

  // Control register
  always@(posedge pclk or negedge n_preset)
  begin
    if(~n_preset)
      enst_en   <= 8'h00;
    else
      if (write_registers && (i_paddr == `gem_enst_control_reg))
        enst_en <= pwdata[7:0];
  end


  // Write to the various registers.
  // This can be coded this way as the registers are defined to be contiguous
  generate
    genvar  enst_var;
    genvar  enst_var2;
    for (enst_var=0; enst_var<p_num_enst; enst_var = enst_var + 1)
    begin : gen_enst_regs

      always@(posedge pclk or negedge n_preset)
      begin
        if(~n_preset)
        begin
          start_time_r[enst_var]  <= 32'h00000000;
          on_time_r[enst_var]     <= {17{1'b1}};
          off_time_r[enst_var]    <= {17{1'b0}};
        end
        else
          if (write_registers)
          begin
            if ({{20{1'b0}},i_paddr} == (`gem_start_time_reg_0 + (enst_var * 4)))
              start_time_r[enst_var]  <= pwdata;
            if ({{20{1'b0}},i_paddr} == (`gem_on_time_reg_0 + (enst_var * 4)))
              on_time_r[enst_var]     <= pwdata[16:0];
            if ({{20{1'b0}},i_paddr} == (`gem_off_time_reg_0 + (enst_var * 4)))
              off_time_r[enst_var]    <= pwdata[16:0];
          end
      end
      assign start_time[(enst_var*32)+31:(enst_var*32)] = start_time_r[enst_var];
      assign on_time[(enst_var*17)+16:(enst_var*17)]    = on_time_r[enst_var];
      assign off_time[(enst_var*17)+16:(enst_var*17)]   = off_time_r[enst_var];

      // Optional parity protection
      if (p_parity_prot == 1) begin : gen_par
        reg   [3:0] start_time_par;
        reg   [2:0] on_time_par;
        reg   [2:0] off_time_par;

        // Store associated parity
        always @(posedge pclk or negedge n_preset)
        begin
          if (~n_preset)
          begin
            start_time_par  <= 4'b0000;
            on_time_par     <= 3'b100;
            off_time_par    <= 3'b000;
          end
          else if (write_registers)
          begin
            if ({{20{1'b0}},i_paddr} == (`gem_start_time_reg_0 + (enst_var * 4)))
              start_time_par  <= pwdata_par;
            if ({{20{1'b0}},i_paddr} == (`gem_on_time_reg_0 + (enst_var * 4)))
              on_time_par     <= {pwdata[16],pwdata_par[1:0]};
            if ({{20{1'b0}},i_paddr} == (`gem_off_time_reg_0 + (enst_var * 4)))
              off_time_par    <= {pwdata[16],pwdata_par[1:0]};
          end
        end

        // Check the parity constantly
        cdnsdru_asf_parity_check_v1 #(.p_data_width(80)) i_par_chk (
          .odd_par    (1'b0),
          .data_in    ({7'h00,on_time_r[enst_var],
                        7'h00,off_time_r[enst_var],
                        start_time_r[enst_var]}),
          .parity_in  ({on_time_par,
                        off_time_par,
                        start_time_par}),
          .parity_err (enst_par_err_int[enst_var])
        );
      end else begin : gen_no_par
        assign enst_par_err_int[enst_var] = 1'b0;
      end

    end
    if (p_num_enst<32'd8) begin : gen_do_gen_enst_regs_pad
    for (enst_var2=p_num_enst; enst_var2<8; enst_var2 = enst_var2 + 1)
    begin : gen_enst_regs_pad
      assign start_time[(enst_var2*32)+31:(enst_var2*32)] = 32'h00000000;
      assign on_time[(enst_var2*17)+16:(enst_var2*17)]    = {17{1'b0}};
      assign off_time[(enst_var2*17)+16:(enst_var2*17)]   = {17{1'b0}};
    end
    end
  endgenerate

  // APB read of registers.
  // The prdata_enst should be registered externally.
  always @(*)
  begin
    if (read_registers)
      case (i_paddr)
        `gem_start_time_reg_0 : prdata_enst = start_time[31:0];
        `gem_start_time_reg_1 : prdata_enst = start_time[63:32];
        `gem_start_time_reg_2 : prdata_enst = start_time[95:64];
        `gem_start_time_reg_3 : prdata_enst = start_time[127:96];
        `gem_start_time_reg_4 : prdata_enst = start_time[159:128];
        `gem_start_time_reg_5 : prdata_enst = start_time[191:160];
        `gem_start_time_reg_6 : prdata_enst = start_time[223:192];
        `gem_start_time_reg_7 : prdata_enst = start_time[255:224];
        `gem_on_time_reg_0    : prdata_enst = {15'd0,on_time[16:0]};
        `gem_on_time_reg_1    : prdata_enst = {15'd0,on_time[33:17]};
        `gem_on_time_reg_2    : prdata_enst = {15'd0,on_time[50:34]};
        `gem_on_time_reg_3    : prdata_enst = {15'd0,on_time[67:51]};
        `gem_on_time_reg_4    : prdata_enst = {15'd0,on_time[84:68]};
        `gem_on_time_reg_5    : prdata_enst = {15'd0,on_time[101:85]};
        `gem_on_time_reg_6    : prdata_enst = {15'd0,on_time[118:102]};
        `gem_on_time_reg_7    : prdata_enst = {15'd0,on_time[135:119]};
        `gem_off_time_reg_0   : prdata_enst = {15'd0,off_time[16:0]};
        `gem_off_time_reg_1   : prdata_enst = {15'd0,off_time[33:17]};
        `gem_off_time_reg_2   : prdata_enst = {15'd0,off_time[50:34]};
        `gem_off_time_reg_3   : prdata_enst = {15'd0,off_time[67:51]};
        `gem_off_time_reg_4   : prdata_enst = {15'd0,off_time[84:68]};
        `gem_off_time_reg_5   : prdata_enst = {15'd0,off_time[101:85]};
        `gem_off_time_reg_6   : prdata_enst = {15'd0,off_time[118:102]};
        `gem_off_time_reg_7   : prdata_enst = {15'd0,off_time[135:119]};
        `gem_enst_control_reg : prdata_enst = {24'd0,enst_en};
        default               : prdata_enst = 32'h00000000;
      endcase
    else
      prdata_enst = 32'h00000000;
  end

  // Perr signal for accesses out of range
  always @(posedge pclk or negedge n_preset)
  begin
    if (~n_preset)
      perr_enst <= 1'b0;
    else
      if (psel)
        case (i_paddr)
          `gem_enst_control_reg ,
          `gem_start_time_reg_0 ,
          `gem_on_time_reg_0    ,
          `gem_off_time_reg_0   : perr_enst <= 1'b0;
          `gem_start_time_reg_1 ,
          `gem_on_time_reg_1    ,
          `gem_off_time_reg_1   : perr_enst <= p_edma_queues < 32'd2;
          `gem_start_time_reg_2 ,
          `gem_on_time_reg_2    ,
          `gem_off_time_reg_2   : perr_enst <= p_edma_queues < 32'd3;
          `gem_start_time_reg_3 ,
          `gem_on_time_reg_3    ,
          `gem_off_time_reg_3   : perr_enst <= p_edma_queues < 32'd4;
          `gem_start_time_reg_4 ,
          `gem_on_time_reg_4    ,
          `gem_off_time_reg_4   : perr_enst <= p_edma_queues < 32'd5;
          `gem_start_time_reg_5 ,
          `gem_on_time_reg_5    ,
          `gem_off_time_reg_5   : perr_enst <= p_edma_queues < 32'd6;
          `gem_start_time_reg_6 ,
          `gem_on_time_reg_6    ,
          `gem_off_time_reg_6   : perr_enst <= p_edma_queues < 32'd7;
          `gem_start_time_reg_7 ,
          `gem_on_time_reg_7    ,
          `gem_off_time_reg_7   : perr_enst <= p_edma_queues < 32'd8;
          default               : perr_enst <= 1'b1;  // No match
        endcase
      else
        perr_enst <= 1'b0;
  end


  // Optional parity protection
  generate if (p_parity_prot == 1) begin : gen_par
    reg   enst_en_par;      // Parity for enst_en
    reg   enst_par_err_r;
    wire  enst_ctrl_par_err;

    // Store the parity
    always@(posedge pclk or negedge n_preset)
    begin
      if(~n_preset)
        enst_en_par <= 1'b0;
      else
        if (write_registers && (i_paddr == `gem_enst_control_reg))
          enst_en_par <= pwdata_par[0];
    end

    // Check the parity constantly
    cdnsdru_asf_parity_check_v1 #(.p_data_width(8)) i_par_chk (
      .odd_par    (1'b0),
      .data_in    (enst_en),
      .parity_in  (enst_en_par),
      .parity_err (enst_ctrl_par_err)
    );

    // Combine and register
    always @(posedge pclk or negedge n_preset)
    begin
      if (~n_preset)
        enst_par_err_r  <= 1'b0;
      else
        enst_par_err_r  <= (|enst_par_err_int) | enst_ctrl_par_err;
    end
    assign enst_par_err = enst_par_err_r;
  end
  else begin : gen_no_par
    assign enst_par_err = 1'b0;
  end
  endgenerate

endmodule
