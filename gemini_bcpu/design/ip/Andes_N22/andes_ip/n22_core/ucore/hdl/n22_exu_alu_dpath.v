
`include "global.inc"

module n22_exu_alu_dpath(

  input  alu_req_alu,

  input  alu_req_alu_add ,
  input  alu_req_alu_sub ,
  input  alu_req_alu_xor ,
  input  alu_req_alu_sll ,
  input  alu_req_alu_srl ,
  input  alu_req_alu_sra ,
  input  alu_req_alu_or  ,
  input  alu_req_alu_and ,
  input  alu_req_alu_slt ,
  input  alu_req_alu_sltu,
  input  alu_req_alu_lui ,
  input  [`N22_XLEN-1:0] alu_req_alu_op1,
  input  [`N22_XLEN-1:0] alu_req_alu_op2,

  output [`N22_XLEN-1:0] alu_req_alu_res,

  input  bjp_req_alu,

  input  [`N22_XLEN-1:0] bjp_req_alu_op1,
  input  [`N22_XLEN-1:0] bjp_req_alu_op2,
  input  bjp_req_alu_cmp_eq ,
  input  bjp_req_alu_cmp_ne ,
  input  bjp_req_alu_cmp_lt ,
  input  bjp_req_alu_cmp_gt ,
  input  bjp_req_alu_cmp_ltu,
  input  bjp_req_alu_cmp_gtu,
  input  bjp_req_alu_add,

  output bjp_req_alu_cmp_res,
  output [`N22_XLEN-1:0] bjp_req_alu_add_res,

  input  agu_req_alu,

  input  [`N22_XLEN-1:0] agu_req_alu_op1,
  input  [`N22_XLEN-1:0] agu_req_alu_op2,
  input  agu_req_alu_swap,
  input  agu_req_alu_add ,
  input  agu_req_alu_and ,
  input  agu_req_alu_or  ,
  input  agu_req_alu_xor ,
  input  agu_req_alu_max ,
  input  agu_req_alu_min ,
  input  agu_req_alu_maxu,
  input  agu_req_alu_minu,

  output [`N22_XLEN-1:0] agu_req_alu_res,

  input  agu_sbf_0_ena,
  input  [`N22_XLEN-1:0] agu_sbf_0_nxt,
  output [`N22_XLEN-1:0] agu_sbf_0_r,

  input  agu_sbf_1_ena,
  input  [`N22_XLEN-1:0] agu_sbf_1_nxt,
  output [`N22_XLEN-1:0] agu_sbf_1_r,

`ifdef N22_SHARE_MULDIV
  input  muldiv_req_alu,

  input  [`N22_ALU_ADDER_WIDTH-1:0] muldiv_req_alu_op1,
  input  [`N22_ALU_ADDER_WIDTH-1:0] muldiv_req_alu_op2,
  input                              muldiv_req_alu_add ,
  input                              muldiv_req_alu_sub ,
  output [`N22_ALU_ADDER_WIDTH-1:0] muldiv_req_alu_res,

  input           muldiv_sbf_0_ena,
  input  [33-1:0] muldiv_sbf_0_nxt,
  output [33-1:0] muldiv_sbf_0_r,

  input           muldiv_sbf_1_ena,
  input  [33-1:0] muldiv_sbf_1_nxt,
  output [33-1:0] muldiv_sbf_1_r,
`endif

  input  clk,
  input  rst_n
  );



  wire [`N22_XLEN-1:0] s0;
  wire [`N22_XLEN-1:0] s1;

  wire [`N22_XLEN-1:0] s2 = s0[`N22_XLEN-1:0];
  wire [`N22_XLEN-1:0] s3 = s1[`N22_XLEN-1:0];

  wire [`N22_XLEN-1:0] s4 = alu_req_alu_op1[`N22_XLEN-1:0];
  wire [`N22_XLEN-1:0] s5 = alu_req_alu_op2[`N22_XLEN-1:0];

  wire s6;
  wire s7 ;
  wire s8;
  wire s9;

  wire s10;
  wire s11;
  wire s12 = s10 | s11;

  wire s13;
  wire s14;
  wire s15;

  wire s16;
  wire s17;
  wire s18;

  wire s19;
  wire s20;

  wire s21;


  wire s22 ;
  wire s23 ;
  wire s24 ;
  wire s25 ;
  wire s26;
  wire s27;

  wire s28;

  wire s29;
  wire [33-1:0] s30;
  wire [33-1:0] s31;

  wire s32;
  wire [33-1:0] s33;
  wire [33-1:0] s34;


  wire [`N22_XLEN-1:0] s35;
  wire [5-1:0] s36;
  wire [`N22_XLEN-1:0] s37;


  wire s38 = s18 | s16 | s17;

  assign s35 = {`N22_XLEN{s38}} &
           (
               (s18 | s17) ?
                 {
    s4[00],s4[01],s4[02],s4[03],
    s4[04],s4[05],s4[06],s4[07],
    s4[08],s4[09],s4[10],s4[11],
    s4[12],s4[13],s4[14],s4[15],
    s4[16],s4[17],s4[18],s4[19],
    s4[20],s4[21],s4[22],s4[23],
    s4[24],s4[25],s4[26],s4[27],
    s4[28],s4[29],s4[30],s4[31]
                 } : s4
           );
  assign s36 = {5{s38}} & s5[4:0];

  assign s37 = (s35 << s36);

  wire [`N22_XLEN-1:0] s39 = s37;
  wire [`N22_XLEN-1:0] s40 =
                 {
    s37[00],s37[01],s37[02],s37[03],
    s37[04],s37[05],s37[06],s37[07],
    s37[08],s37[09],s37[10],s37[11],
    s37[12],s37[13],s37[14],s37[15],
    s37[16],s37[17],s37[18],s37[19],
    s37[20],s37[21],s37[22],s37[23],
    s37[24],s37[25],s37[26],s37[27],
    s37[28],s37[29],s37[30],s37[31]
                 };

  wire [`N22_XLEN-1:0] s41 = (~(`N22_XLEN'b0)) >> s36;
  wire [`N22_XLEN-1:0] s42 =
               (s40 & s41) | ({32{s4[31]}} & (~s41));




  wire s43 = s20 | s26 | s27 | s8 | s9;
  wire [`N22_ALU_ADDER_WIDTH-1:0] s44 =
      {{`N22_ALU_ADDER_WIDTH-`N22_XLEN{(~s43) & s2[`N22_XLEN-1]}},s2};
  wire [`N22_ALU_ADDER_WIDTH-1:0] s45 =
      {{`N22_ALU_ADDER_WIDTH-`N22_XLEN{(~s43) & s3[`N22_XLEN-1]}},s3};


  wire [`N22_ALU_ADDER_WIDTH-1:0] s46 =
`ifdef N22_SHARE_MULDIV
      muldiv_req_alu ? muldiv_req_alu_op1 :
`endif
      s44;
  wire [`N22_ALU_ADDER_WIDTH-1:0] s47 =
`ifdef N22_SHARE_MULDIV
      muldiv_req_alu ? muldiv_req_alu_op2 :
`endif
      s45;

  wire s48;
  wire [`N22_ALU_ADDER_WIDTH-1:0] s49;
  wire [`N22_ALU_ADDER_WIDTH-1:0] s50;
  wire [`N22_ALU_ADDER_WIDTH-1:0] s51;

  wire s52;
  wire s53;

  assign s52 =
`ifdef N22_SHARE_MULDIV
      muldiv_req_alu ? muldiv_req_alu_add :
`endif
      s10;
  assign s53 =
`ifdef N22_SHARE_MULDIV
      muldiv_req_alu ? muldiv_req_alu_sub :
`endif
               (
               (s11)
             | (s24 | s25 |
                s26 | s27 |
                s6 | s8 |
                s7 | s9 |
                s19 | s20
               ));

  wire s54 = s52 | s53;


  assign s49 = {`N22_ALU_ADDER_WIDTH{s54}} & (s46);
  assign s50 = {`N22_ALU_ADDER_WIDTH{s54}} & (s53 ? (~s47) : s47);
  assign s48 = s54 & s53;

  assign s51 = s49 + s50 + { {`N22_ALU_ADDER_WIDTH-1{1'b0}}, s48 };




  wire [`N22_XLEN-1:0] s55;
  wire [`N22_XLEN-1:0] s56;

  wire s57 =
               s14
             | (s22 | s23);

  assign s55 = {`N22_XLEN{s57}} & s2;
  assign s56 = {`N22_XLEN{s57}} & s3;

  wire [`N22_XLEN-1:0] s58 = s55 ^ s56;
  wire [`N22_XLEN-1:0] s59  = s2 | s3;
  wire [`N22_XLEN-1:0] s60 = s2 & s3;


  wire s61  = (|s58);
  wire s62  = (s23  & s61);
  wire s63  = s22  & (~s61);
  wire s64  = s24  & s51[`N22_XLEN];
  wire s65 = s26 & s51[`N22_XLEN];
  wire s66  = (~s51[`N22_XLEN]);
  wire s67  = s25  & s66;
  wire s68 = s27 & s66;

  assign s28 = s63
                 | s62
                 | s64
                 | s67
                 | s65
                 | s68;

  wire [`N22_XLEN-1:0] s69 = s3;

  wire s70 = (s19 | s20);
  wire s71 = s70 & s51[`N22_XLEN];
  wire [`N22_XLEN-1:0] s72 =
               s71 ?
               `N22_XLEN'b1 : `N22_XLEN'b0;

  wire s73 =  ((s6 | s8) &   s66)
                      |  ((s7 | s9) & (~s66));

  wire [`N22_XLEN-1:0] s74  = s73 ? s2 : s3;

  wire [`N22_XLEN-1:0] s75 =
        ({`N22_XLEN{s13       }} & s59 )
      | ({`N22_XLEN{s15      }} & s60)
      | ({`N22_XLEN{s14      }} & s58)
      | ({`N22_XLEN{s12   }} & s51[`N22_XLEN-1:0])
      | ({`N22_XLEN{s17      }} & s40)
      | ({`N22_XLEN{s16      }} & s39)
      | ({`N22_XLEN{s18      }} & s42)
      | ({`N22_XLEN{s21    }} & s69)
      | ({`N22_XLEN{s70    }} & s72)
      | ({`N22_XLEN{s6 | s8 | s7 | s9}} & s74)
        ;

  n22_gnrl_dffl #(33) sbf_0_dffl (s29, s30, s31, clk);
  n22_gnrl_dffl #(33) sbf_1_dffl (s32, s33, s34, clk);


  localparam DPATH_MUX_WIDTH = ((`N22_XLEN*2)+21);

  assign  {
     s0
    ,s1
    ,s6
    ,s7
    ,s8
    ,s9
    ,s10
    ,s11
    ,s13
    ,s14
    ,s15
    ,s16
    ,s17
    ,s18
    ,s19
    ,s20
    ,s21
    ,s22
    ,s23
    ,s24
    ,s25
    ,s26
    ,s27
    }
    =
        ({DPATH_MUX_WIDTH{alu_req_alu}} & {
             alu_req_alu_op1
            ,alu_req_alu_op2
            ,1'b0
            ,1'b0
            ,1'b0
            ,1'b0
            ,alu_req_alu_add
            ,alu_req_alu_sub
            ,alu_req_alu_or
            ,alu_req_alu_xor
            ,alu_req_alu_and
            ,alu_req_alu_sll
            ,alu_req_alu_srl
            ,alu_req_alu_sra
            ,alu_req_alu_slt
            ,alu_req_alu_sltu
            ,alu_req_alu_lui
            ,1'b0
            ,1'b0
            ,1'b0
            ,1'b0
            ,1'b0
            ,1'b0
        })
      | ({DPATH_MUX_WIDTH{bjp_req_alu}} & {
             bjp_req_alu_op1
            ,bjp_req_alu_op2
            ,1'b0
            ,1'b0
            ,1'b0
            ,1'b0
            ,bjp_req_alu_add
            ,1'b0
            ,1'b0
            ,1'b0
            ,1'b0
            ,1'b0
            ,1'b0
            ,1'b0
            ,1'b0
            ,1'b0
            ,1'b0
            ,bjp_req_alu_cmp_eq
            ,bjp_req_alu_cmp_ne
            ,bjp_req_alu_cmp_lt
            ,bjp_req_alu_cmp_gt
            ,bjp_req_alu_cmp_ltu
            ,bjp_req_alu_cmp_gtu

        })
      | ({DPATH_MUX_WIDTH{agu_req_alu}} & {
             agu_req_alu_op1
            ,agu_req_alu_op2
            ,agu_req_alu_max
            ,agu_req_alu_min
            ,agu_req_alu_maxu
            ,agu_req_alu_minu
            ,agu_req_alu_add
            ,1'b0
            ,agu_req_alu_or
            ,agu_req_alu_xor
            ,agu_req_alu_and
            ,1'b0
            ,1'b0
            ,1'b0
            ,1'b0
            ,1'b0
            ,agu_req_alu_swap
            ,1'b0
            ,1'b0
            ,1'b0
            ,1'b0
            ,1'b0
            ,1'b0
        })
        ;

  assign alu_req_alu_res     = s75[`N22_XLEN-1:0];
  assign agu_req_alu_res     = s75[`N22_XLEN-1:0];
  assign bjp_req_alu_add_res = s75[`N22_XLEN-1:0];
  assign bjp_req_alu_cmp_res = s28;
`ifdef N22_SHARE_MULDIV
  assign muldiv_req_alu_res  = s51;
`endif

  assign s29 =
`ifdef N22_SHARE_MULDIV
      muldiv_req_alu ? muldiv_sbf_0_ena :
`endif
                 agu_sbf_0_ena;
  assign s32 =
`ifdef N22_SHARE_MULDIV
      muldiv_req_alu ? muldiv_sbf_1_ena :
`endif
                 agu_sbf_1_ena;

  assign s30 =
`ifdef N22_SHARE_MULDIV
      muldiv_req_alu ? muldiv_sbf_0_nxt :
`endif
                 {1'b0,agu_sbf_0_nxt};
  assign s33 =
`ifdef N22_SHARE_MULDIV
      muldiv_req_alu ? muldiv_sbf_1_nxt :
`endif
                 {1'b0,agu_sbf_1_nxt};

  assign agu_sbf_0_r = s31[`N22_XLEN-1:0];
  assign agu_sbf_1_r = s34[`N22_XLEN-1:0];

`ifdef N22_SHARE_MULDIV
  assign muldiv_sbf_0_r = s31;
  assign muldiv_sbf_1_r = s34;
`endif

endmodule



