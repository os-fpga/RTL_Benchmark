

`include "global.inc"

module n22_exu_wbck(

  input  alu_wbck_i_valid,
  output alu_wbck_i_ready,
  input  [`N22_XLEN-1:0] alu_wbck_i_wdat,
  input  [`N22_RFIDX_WIDTH-1:0] alu_wbck_i_rdidx,
  input  alu_wbck_i_wen,
  input  alu_wbck_i_rdsp,

  input  longp_wbck_i_valid,
  output longp_wbck_i_ready,
  input  [`N22_FLEN-1:0] longp_wbck_i_wdat,
  input  [5-1:0] longp_wbck_i_flags,
  input  [`N22_RFIDX_WIDTH-1:0] longp_wbck_i_rdidx,
  input  longp_wbck_i_rdfpu,
  input  longp_wbck_i_wen,
  input  longp_wbck_i_rdsp,

  `ifdef N22_REGFILE_2WP
  output  rf_wbck_o_ena1,
  output  [`N22_XLEN-1:0] rf_wbck_o_wdat1,
  output  [`N22_RFIDX_WIDTH-1:0] rf_wbck_o_rdidx1,

  output  rf_wbck_o_ena2,
  output  [`N22_XLEN-1:0] rf_wbck_o_wdat2,
  output  [`N22_RFIDX_WIDTH-1:0] rf_wbck_o_rdidx2,

  `endif

  `ifndef N22_REGFILE_2WP
  output  rf_wbck_o_ena,
  output  [`N22_XLEN-1:0] rf_wbck_o_wdat,
  output  [`N22_RFIDX_WIDTH-1:0] rf_wbck_o_rdidx,
  `endif



  output  rf_wbck_sp_ena1,
  output  rf_wbck_sp_ena2,

  input  clk,
  input  rst_n
  );


  `ifndef N22_REGFILE_2WP
  wire wbck_ready4alu = (~longp_wbck_i_valid);
  wire wbck_sel_alu = alu_wbck_i_valid & wbck_ready4alu;
  wire wbck_ready4longp = 1'b1;
  wire wbck_sel_longp = longp_wbck_i_valid & wbck_ready4longp;



  wire rf_wbck_o_ready = 1'b1;

  wire wbck_i_ready;
  wire wbck_i_valid;
  wire [`N22_FLEN-1:0] wbck_i_wdat;
  wire [5-1:0] wbck_i_flags;
  wire [`N22_RFIDX_WIDTH-1:0] wbck_i_rdidx;
  wire wbck_i_rdfpu;
  wire wbck_i_rdsp;
  wire wbck_i_wen;

  assign alu_wbck_i_ready   = wbck_ready4alu   & wbck_i_ready;
  assign longp_wbck_i_ready = wbck_ready4longp & wbck_i_ready;

  assign wbck_i_valid = wbck_sel_alu ? alu_wbck_i_valid : longp_wbck_i_valid;
  `ifdef N22_FLEN_IS_32
  assign wbck_i_wdat  = wbck_sel_alu ? alu_wbck_i_wdat  : longp_wbck_i_wdat;
  `else
  assign wbck_i_wdat  = wbck_sel_alu ? {{`N22_FLEN-`N22_XLEN{1'b0}},alu_wbck_i_wdat}  : longp_wbck_i_wdat;
  `endif
  assign wbck_i_flags = wbck_sel_alu ? 5'b0  : longp_wbck_i_flags;
  assign wbck_i_rdidx = wbck_sel_alu ? alu_wbck_i_rdidx : longp_wbck_i_rdidx;
  assign wbck_i_rdfpu = wbck_sel_alu ? 1'b0 : longp_wbck_i_rdfpu;
  assign wbck_i_rdsp  = wbck_sel_alu ? alu_wbck_i_rdsp  : longp_wbck_i_rdsp;
  assign wbck_i_wen   = wbck_sel_alu ? alu_wbck_i_wen   : longp_wbck_i_wen;

  assign wbck_i_ready  = rf_wbck_o_ready;
  wire rf_wbck_o_valid = wbck_i_valid;

  wire wbck_o_ena   = rf_wbck_o_valid & rf_wbck_o_ready;

  assign rf_wbck_o_ena   = wbck_o_ena & (~wbck_i_rdfpu) & wbck_i_wen;
  assign rf_wbck_o_wdat  = wbck_i_wdat[`N22_XLEN-1:0];
  assign rf_wbck_o_rdidx = wbck_i_rdidx;

  assign rf_wbck_sp_ena1   = wbck_o_ena & wbck_i_rdsp & wbck_i_wen;
  assign rf_wbck_sp_ena2   = 1'b0;


  `endif

  `ifdef N22_REGFILE_2WP
  assign longp_wbck_i_ready = 1'b1;
  assign alu_wbck_i_ready   = 1'b1;

  assign rf_wbck_o_ena1   = alu_wbck_i_valid & alu_wbck_i_ready & alu_wbck_i_wen;
  assign rf_wbck_o_wdat1  = alu_wbck_i_wdat[`N22_XLEN-1:0];
  assign rf_wbck_o_rdidx1 = alu_wbck_i_rdidx;

  assign rf_wbck_o_ena2   = longp_wbck_i_valid & longp_wbck_i_ready & (~longp_wbck_i_rdfpu) & longp_wbck_i_wen;
  assign rf_wbck_o_wdat2  = longp_wbck_i_wdat[`N22_XLEN-1:0];
  assign rf_wbck_o_rdidx2 = longp_wbck_i_rdidx;

  assign rf_wbck_sp_ena1   = alu_wbck_i_valid & alu_wbck_i_ready & alu_wbck_i_wen & alu_wbck_i_rdsp;
  assign rf_wbck_sp_ena2   = longp_wbck_i_valid & longp_wbck_i_ready & longp_wbck_i_wen & longp_wbck_i_rdsp;


  `endif

endmodule



