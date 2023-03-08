
`include "global.inc"

module n22_exu_alu_csrctrl(
  input  alu_need_excp,

  input  csr_i_valid,
  output csr_i_ready,

  input  [`N22_XLEN-1:0] csr_i_rs1,
  input  [`N22_DECINFO_CSR_WIDTH-1:0] csr_i_info,
  input  csr_i_rdwen,

  output csr_ena,
  output csr_wr_en,
  output csr_rd_en,
  output [12-1:0] csr_idx,

  input  csr_access_ilgl,
  input  [`N22_XLEN-1:0] read_csr_dat,
  input  [`N22_XLEN-1:0] read_msts_dat,
  output [`N22_XLEN-1:0] wbck_csr_msts_dat,
  output [`N22_XLEN-1:0] wbck_csr_dat,

  output [`N22_XLEN-1:0] csr_op1,


  `ifdef N22_HAS_CSR_EAI
  output         csr_sel_eai,
  input          eai_xs_off,
  output         eai_csr_valid,
  input          eai_csr_ready,
  output  [31:0] eai_csr_addr,
  output         eai_csr_wr,
  output  [31:0] eai_csr_wdata,
  input   [31:0] eai_csr_rdata,
  `endif



  output csr_o_valid,
  input  csr_o_ready,
  output [`N22_XLEN-1:0] csr_o_wbck_wdat,
  output csr_o_wbck_err,

  input  clk,
  input  rst_n
  );





  `ifdef N22_HAS_CSR_EAI
  assign csr_sel_eai        = (csr_idx[11:8] == 4'hE);
  wire s0            = csr_sel_eai & (~eai_xs_off);
  wire s1         = s0 ? eai_csr_ready : 1'b1;

  assign csr_o_valid      = csr_i_valid
                            & s1;
  assign eai_csr_valid    = s0 & csr_i_valid &
                            csr_o_ready;

  assign csr_i_ready      = s0 ? (eai_csr_ready & csr_o_ready) : csr_o_ready;

  assign csr_o_wbck_err   = csr_access_ilgl;
  assign csr_o_wbck_wdat  = s0 ? eai_csr_rdata : read_csr_dat;

  assign eai_csr_addr = csr_idx;
  assign eai_csr_wr   = csr_wr_en;
  assign eai_csr_wdata = wbck_csr_dat;
  `else
  wire   s0          = 1'b0;
  assign csr_o_valid      = csr_i_valid;
  assign csr_i_ready      = csr_o_ready;
  assign csr_o_wbck_err   = csr_access_ilgl;
  assign csr_o_wbck_wdat  = read_csr_dat;
  `endif


  wire        s2  = csr_i_info[`N22_DECINFO_CSR_CSRRW ];
  wire        s3  = csr_i_info[`N22_DECINFO_CSR_CSRRS ];
  wire        s4  = csr_i_info[`N22_DECINFO_CSR_CSRRC ];
  wire        s5 = csr_i_info[`N22_DECINFO_CSR_RS1IMM];
  wire        s6 = csr_i_info[`N22_DECINFO_CSR_RS1IS0];
  wire [4:0]  s7   = csr_i_info[`N22_DECINFO_CSR_ZIMMM ];
  wire [11:0] s8 = csr_i_info[`N22_DECINFO_CSR_CSRIDX];

  assign csr_op1 = s5 ? {27'b0,s7} : csr_i_rs1;

  assign csr_rd_en = csr_i_valid &
    (
      (s2 ? csr_i_rdwen : 1'b0)
      | s3 | s4
     );
  assign csr_wr_en = csr_i_valid & (
                s2
               | ((s3 | s4) & (~s6))
            );

  assign csr_idx = s8;

  assign csr_ena = csr_o_valid & csr_o_ready & (~s0) & (~alu_need_excp);


  assign wbck_csr_dat =
              ({`N22_XLEN{s2}} & csr_op1)
            | ({`N22_XLEN{s3}} & (  csr_op1  | read_csr_dat))
            | ({`N22_XLEN{s4}} & ((~csr_op1) & read_csr_dat));

  assign wbck_csr_msts_dat =
              ({`N22_XLEN{s2}} & csr_op1)
            | ({`N22_XLEN{s3}} & (  csr_op1  | read_msts_dat))
            | ({`N22_XLEN{s4}} & ((~csr_op1) & read_msts_dat));
endmodule
