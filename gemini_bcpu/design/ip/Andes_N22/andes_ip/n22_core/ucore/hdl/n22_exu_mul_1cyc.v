
`include "global.inc"

`ifdef N22_INDEP_MULDIV
  `ifdef N22_INDEP_MUL_1CYC
module n22_exu_mul_1cyc(

  input  mul_i_valid,
  output mul_i_ready,

  input  [`N22_XLEN-1:0] mul_i_rs1,
  input  [`N22_XLEN-1:0] mul_i_rs2,
  input  [`N22_XLEN-1:0] mul_i_imm,
  input  [`N22_DECINFO_MULDIV_WIDTH-1:0] mul_i_info,
  input  [`N22_ITAG_WIDTH-1:0] mul_i_itag,

  output mul_i_longpipe,

  output mul_o_valid,
  input  mul_o_ready,
  output [`N22_XLEN-1:0] mul_o_wbck_wdat,
  output mul_o_wbck_err,


  input  clk,
  input  rst_n
  );

  wire s0 = mul_i_valid & mul_i_ready;
  wire s1 = mul_o_valid & mul_o_ready;

  wire s2    = mul_i_info[`N22_DECINFO_MULDIV_MUL   ];
  wire s3   = mul_i_info[`N22_DECINFO_MULDIV_MULH  ];
  wire s4 = mul_i_info[`N22_DECINFO_MULDIV_MULHSU];
  wire s5  = mul_i_info[`N22_DECINFO_MULDIV_MULHU ];

  wire s6 = (s5)            ? 1'b0 : mul_i_rs1[`N22_XLEN-1];
  wire s7 = (s4 | s5) ? 1'b0 : mul_i_rs2[`N22_XLEN-1];

  wire [32:0] s8 = {s6, mul_i_rs1};
  wire [32:0] s9 = {s7, mul_i_rs2};




  assign mul_o_valid = mul_i_valid;
  assign mul_i_ready = mul_o_ready;

  assign mul_o_wbck_err = 1'b0;

  assign mul_i_longpipe = 1'b0;


  wire signed [63:0] s10 = $signed(s8) * $signed(s9);
  wire [63:0] s11 = $unsigned(s10);
  wire [31:0] s12    = s11[31:0];
  wire [31:0] s13   = s11[63:32];
  wire [31:0] s14 = s11[63:32];
  wire [31:0] s15  = s11[63:32];

  assign mul_o_wbck_wdat =
           ({32{s2   }} & s12    )
         | ({32{s3  }} & s13   )
         | ({32{s4}} & s14 )
         | ({32{s5 }} & s15  )
         ;



`ifndef FPGA_SOURCE
`ifndef SYNTHESIS
//synopsys translate_off







//synopsys translate_on
`endif
`endif


endmodule
  `endif
`endif



