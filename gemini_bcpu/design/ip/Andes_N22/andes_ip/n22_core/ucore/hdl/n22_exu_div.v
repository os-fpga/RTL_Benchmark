
`include "global.inc"

`ifdef N22_INDEP_MULDIV
module n22_exu_div(

  input  div_i_valid,
  output div_i_ready,

  input  [`N22_XLEN-1:0] div_i_rs1,
  input  [`N22_XLEN-1:0] div_i_rs2,
  input  [`N22_XLEN-1:0] div_i_imm,
  input  [`N22_DECINFO_MULDIV_WIDTH-1:0] div_i_info,
  input  [`N22_ITAG_WIDTH-1:0] div_i_itag,

  output div_i_longpipe,

  output div_o_valid,
  input  div_o_ready,
  output [`N22_XLEN-1:0] div_o_wbck_wdat,
  output div_o_wbck_err,

  output div_longp_o_valid,
  input  div_longp_o_ready,
  output [`N22_XLEN-1:0] div_longp_o_wdat,
  output div_longp_o_err,
  output [`N22_ITAG_WIDTH-1:0] div_longp_o_itag,

  input  clk,
  input  rst_n
  );

  wire s0;

  assign div_o_wbck_err  = 1'b1;
  assign div_o_wbck_wdat = `N22_XLEN'b0;

  assign div_i_ready =
           (div_o_ready)
         & (s0);

  wire   s1 = div_i_valid & div_o_ready;
  assign div_o_valid = div_i_valid & s0;

 localparam PIPE_PACK_W = `N22_XLEN*2 + `N22_DECINFO_MULDIV_WIDTH + `N22_ITAG_WIDTH;

 wire [PIPE_PACK_W-1:0] s2;
 wire [PIPE_PACK_W-1:0] s3;

 wire [`N22_XLEN-1:0] s4;
 wire [`N22_XLEN-1:0] s5;
 wire [`N22_ITAG_WIDTH-1:0] s6;
 wire [`N22_DECINFO_MULDIV_WIDTH-1:0] s7;
 wire [`N22_DECINFO_MULDIV_WIDTH-1:0] s8;

 assign s2 ={
                       div_i_rs1
                     , div_i_rs2
                     , div_i_info
                     , div_i_itag
                     };

 assign             {
                       s4
                     , s5
                     , s7
                     , s6
                     } = s3;

 wire s9;
 wire s10;

 n22_gnrl_pipe_stage # (
  .CUT_READY(0),
  .DP(1),
  .DW(PIPE_PACK_W)
 ) u_div_e1_stage (
   .i_vld(s1),
   .i_rdy(s0),
   .i_dat(s2  ),
   .o_vld(s9),
   .o_rdy(s10),
   .o_dat(s3 ),

   .clk  (clk  ),
   .rst_n(rst_n)
  );


  wire [`N22_MULDIV_ADDER_WIDTH-1:0] s11;
  wire [`N22_MULDIV_ADDER_WIDTH-1:0] s12;
  wire                                s13 ;
  wire                                s14 ;
  wire [`N22_MULDIV_ADDER_WIDTH-1:0] s15;

  wire          s16;
  wire [33-1:0] s17;
  wire [33-1:0] s18;

  wire          s19;
  wire [33-1:0] s20;
  wire [33-1:0] s21;


  assign s8[`N22_DECINFO_GRP          ] = s7[`N22_DECINFO_GRP ];
  assign s8[`N22_DECINFO_RV32         ] = s7[`N22_DECINFO_RV32];
  assign s8[`N22_DECINFO_MULDIV_MUL   ] = 1'b0;
  assign s8[`N22_DECINFO_MULDIV_MULH  ] = 1'b0;
  assign s8[`N22_DECINFO_MULDIV_MULHSU] = 1'b0;
  assign s8[`N22_DECINFO_MULDIV_MULHU ] = 1'b0;
  assign s8[`N22_DECINFO_MULDIV_DIV   ] = s7[`N22_DECINFO_MULDIV_DIV   ];
  assign s8[`N22_DECINFO_MULDIV_DIVU  ] = s7[`N22_DECINFO_MULDIV_DIVU  ];
  assign s8[`N22_DECINFO_MULDIV_REM   ] = s7[`N22_DECINFO_MULDIV_REM   ];
  assign s8[`N22_DECINFO_MULDIV_REMU  ] = s7[`N22_DECINFO_MULDIV_REMU  ];
  assign s8[`N22_DECINFO_MULDIV_B2B   ] = s7[`N22_DECINFO_MULDIV_B2B   ];

  assign div_longp_o_itag = s6;

  n22_exu_alu_muldiv u_n22_exu_alu_muldiv(

      .muldiv_i_valid      (s9),
      .muldiv_i_ready      (s10),

      .muldiv_i_rs1        (s4      ),
      .muldiv_i_rs2        (s5      ),
      .muldiv_i_imm        (`N22_XLEN'b0      ),
      .muldiv_i_info       (s8),
      .muldiv_i_longpipe   (),
      .muldiv_i_itag       (`N22_ITAG_WIDTH'b0),


      .flush_pulse         (1'b0    ),

      .muldiv_o_valid      (div_longp_o_valid    ),
      .muldiv_o_ready      (div_longp_o_ready    ),
      .muldiv_o_wbck_wdat  (div_longp_o_wdat),
      .muldiv_o_wbck_err   (div_longp_o_err ),

      .muldiv_req_alu_op1  (s11),
      .muldiv_req_alu_op2  (s12),
      .muldiv_req_alu_add  (s13),
      .muldiv_req_alu_sub  (s14),
      .muldiv_req_alu_res  (s15),

      .muldiv_sbf_0_ena    (s16  ),
      .muldiv_sbf_0_nxt    (s17  ),
      .muldiv_sbf_0_r      (s18    ),

      .muldiv_sbf_1_ena    (s19  ),
      .muldiv_sbf_1_nxt    (s20  ),
      .muldiv_sbf_1_r      (s21    ),

      .clk                 (clk               ),
      .rst_n               (rst_n             )
  );


  n22_gnrl_dffl #(33) div_sbf_0_dffl (s16, s17, s18, clk);
  n22_gnrl_dffl #(33) div_sbf_1_dffl (s19, s20, s21, clk);


  wire [`N22_MULDIV_ADDER_WIDTH-1:0] s22 = s11;
  wire [`N22_MULDIV_ADDER_WIDTH-1:0] s23 = s12;

  wire s24;
  wire [`N22_MULDIV_ADDER_WIDTH-1:0] s25;
  wire [`N22_MULDIV_ADDER_WIDTH-1:0] s26;
  wire [`N22_MULDIV_ADDER_WIDTH-1:0] s27;

  wire s28 = s13 ;
  wire s29 = s14 ;

  wire s30 = s28 | s29;


  assign s25 = {`N22_MULDIV_ADDER_WIDTH{s30}} & (s22);
  assign s26 = {`N22_MULDIV_ADDER_WIDTH{s30}} & (s29 ? (~s23) : s23);
  assign s24 = s30 & s29;

  assign s27 = s25 + s26 + {{`N22_MULDIV_ADDER_WIDTH-1{1'b0}},s24};

  assign s15 = s27;

  assign div_i_longpipe  = 1'b1;

endmodule
`endif



