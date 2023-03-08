
`include "global.inc"

`ifdef N22_HAS_MULDIV
module n22_exu_alu_muldiv(

  input  muldiv_i_valid,
  output muldiv_i_ready,

  input  [`N22_XLEN-1:0] muldiv_i_rs1,
  input  [`N22_XLEN-1:0] muldiv_i_rs2,
  input  [`N22_XLEN-1:0] muldiv_i_imm,
  input  [`N22_DECINFO_MULDIV_WIDTH-1:0] muldiv_i_info,
  input  [`N22_ITAG_WIDTH-1:0] muldiv_i_itag,

  output muldiv_i_longpipe,

  input  flush_pulse,

  output muldiv_o_valid,
  input  muldiv_o_ready,
  output [`N22_XLEN-1:0] muldiv_o_wbck_wdat,
  output muldiv_o_wbck_err,

  output [`N22_MULDIV_ADDER_WIDTH-1:0] muldiv_req_alu_op1,
  output [`N22_MULDIV_ADDER_WIDTH-1:0] muldiv_req_alu_op2,
  output                                muldiv_req_alu_add ,
  output                                muldiv_req_alu_sub ,
  input  [`N22_MULDIV_ADDER_WIDTH-1:0] muldiv_req_alu_res,

  output          muldiv_sbf_0_ena,
  output [33-1:0] muldiv_sbf_0_nxt,
  input  [33-1:0] muldiv_sbf_0_r,

  output          muldiv_sbf_1_ena,
  output [33-1:0] muldiv_sbf_1_nxt,
  input  [33-1:0] muldiv_sbf_1_r,

  input  clk,
  input  rst_n
  );

  wire s0 = muldiv_i_valid & muldiv_i_ready;
  wire s1 = muldiv_o_valid & muldiv_o_ready;

  wire s2;
  wire s3 = flush_pulse;
  wire s4 = s1 & (~flush_pulse);
  wire s5 = s3 | s4;
  wire s6 = s3 | (~s4);
  n22_gnrl_dfflr #(1) flushed_dfflr (s5, s6, s2, clk, rst_n);



  wire s7    = muldiv_i_info[`N22_DECINFO_MULDIV_MUL   ];
  wire s8   = muldiv_i_info[`N22_DECINFO_MULDIV_MULH  ];
  wire s9 = muldiv_i_info[`N22_DECINFO_MULDIV_MULHSU];
  wire s10  = muldiv_i_info[`N22_DECINFO_MULDIV_MULHU ];
  wire s11    = muldiv_i_info[`N22_DECINFO_MULDIV_DIV   ];
  wire s12   = muldiv_i_info[`N22_DECINFO_MULDIV_DIVU  ];
  wire s13    = muldiv_i_info[`N22_DECINFO_MULDIV_REM   ];
  wire s14   = muldiv_i_info[`N22_DECINFO_MULDIV_REMU  ];
  wire s15 = 1'b0;

  wire s16 = s15;

  wire s17 = (s10)            ? 1'b0 : muldiv_i_rs1[`N22_XLEN-1];
  wire s18 = (s9 | s10) ? 1'b0 : muldiv_i_rs2[`N22_XLEN-1];

  wire [32:0] s19 = {s17, muldiv_i_rs1};
  wire [32:0] s20 = {s18, muldiv_i_rs2};

  wire s21 = s7 | s8 | s9 | s10;
  wire s22 = s11 | s12 | s13    | s14;


  localparam MULDIV_STATE_WIDTH = 3;

  wire [MULDIV_STATE_WIDTH-1:0] s23;
  wire [MULDIV_STATE_WIDTH-1:0] s24;
  wire s25;

  localparam MULDIV_STATE_0TH = 3'd0;
  localparam MULDIV_STATE_EXEC = 3'd1;
  localparam MULDIV_STATE_REMD_CHCK = 3'd2;
  localparam MULDIV_STATE_QUOT_CORR = 3'd3;
  localparam MULDIV_STATE_REMD_CORR = 3'd4;


  wire [MULDIV_STATE_WIDTH-1:0] s26;
  wire [MULDIV_STATE_WIDTH-1:0] s27;
  wire [MULDIV_STATE_WIDTH-1:0] s28;
  wire [MULDIV_STATE_WIDTH-1:0] s29;
  wire [MULDIV_STATE_WIDTH-1:0] s30;
  wire s31;
  wire s32;
  wire s33;
  wire s34;
  wire s35;

  wire s36;
  wire s37 = muldiv_i_valid & (~s16) & (~s36);

  wire   s38       = (s24 == MULDIV_STATE_0TH   );
  wire   s39      = (s24 == MULDIV_STATE_EXEC   );
  wire   s40  = (s24 == MULDIV_STATE_REMD_CHCK   );
  wire   s41 = (s24 == MULDIV_STATE_QUOT_CORR   );
  wire   s42 = (s24 == MULDIV_STATE_REMD_CORR   );

  assign s31 = s38 & s37 & (~flush_pulse);
  assign s26      = MULDIV_STATE_EXEC;

  wire s43;
  wire s44;
  wire s45;
  wire s46;
  assign s32 =  s39 & ((
                           s46
                         & (s22 ? 1'b1
                                            : s1))
            | flush_pulse);
  assign s27      =
                (
                         flush_pulse ? MULDIV_STATE_0TH :
                         s22 ? MULDIV_STATE_REMD_CHCK
                                         : MULDIV_STATE_0TH
                );

  assign s33 = (s40 & (
                                              (s43 ? 1'b1
                                                         : s1)
                                              | flush_pulse )) ;
  assign s28      = flush_pulse ? MULDIV_STATE_0TH :
                         s43 ? MULDIV_STATE_QUOT_CORR
                                         : MULDIV_STATE_0TH;

  assign s34 = (s41 & (flush_pulse | 1'b1));
  assign s29      = flush_pulse ? MULDIV_STATE_0TH : MULDIV_STATE_REMD_CORR;


  assign s35 = (s42 & (flush_pulse | s1));
  assign s30      = flush_pulse ? MULDIV_STATE_0TH : MULDIV_STATE_0TH;

  assign s25 = s31
                          | s32
                          | s33
                          | s34
                          | s35;

  assign s23 =
              ({MULDIV_STATE_WIDTH{s31      }} & s26      )
            | ({MULDIV_STATE_WIDTH{s32     }} & s27     )
            | ({MULDIV_STATE_WIDTH{s33}} & s28)
            | ({MULDIV_STATE_WIDTH{s34}} & s29)
            | ({MULDIV_STATE_WIDTH{s35}} & s30)
              ;

  n22_gnrl_dfflr #(MULDIV_STATE_WIDTH) muldiv_state_dfflr (s25, s23, s24, clk, rst_n);

  wire s47 = s25 & (s23 == MULDIV_STATE_EXEC);

  localparam EXEC_CNT_W  = 6;
  localparam EXEC_CNT_1  = 6'd1 ;
  localparam EXEC_CNT_16 = 6'd16;
  localparam EXEC_CNT_32 = 6'd32;

  wire[EXEC_CNT_W-1:0] s48;
  wire s49 = s47;
  wire s50 = s39 & (~s46);
  wire s51 = s50 | s49;
  wire[EXEC_CNT_W-1:0] s52 = s49 ? EXEC_CNT_1 : (s48 + {{EXEC_CNT_W-1{1'b0}},1'b1});
  n22_gnrl_dfflr #(EXEC_CNT_W) exec_cnt_dfflr (s51, s52, s48, clk, rst_n);

  wire s53  = s38;
  wire s54 = (s48 == EXEC_CNT_16);
  wire s55 = (s48 == EXEC_CNT_32);
  assign s44 = s54;
  assign s45 = s55;
  assign s46 = s21 ? s44 : s45;




  wire [32:0] s56;
  wire [32:0] s57;
  wire [32:0] s58;
  wire [32:0] s59;

  wire s60;
  wire [2:0] s61 = s53  ? {muldiv_i_rs1[1:0],1'b0}
                        : s54 ? {s17,s57[0],s60}
                        : {s57[1:0],s60};
  wire s62 = (s61 == 3'b000) | (s61 == 3'b111);
  wire s63  = (s61 == 3'b011) | (s61 == 3'b100);
  wire s64  = (~s62) & (~s63);
  wire s65  = s61[2];

  wire [`N22_MULDIV_ADDER_WIDTH-1:0] s66 = muldiv_req_alu_res;
  wire [`N22_MULDIV_ADDER_WIDTH-1:0] s67 =
      ({`N22_MULDIV_ADDER_WIDTH{s62}} & `N22_MULDIV_ADDER_WIDTH'b0)
    | ({`N22_MULDIV_ADDER_WIDTH{s64 }} & {s18,s18,s18,muldiv_i_rs2})
    | ({`N22_MULDIV_ADDER_WIDTH{s63 }} & {s18,s18,muldiv_i_rs2,1'b0})
      ;
  wire [`N22_MULDIV_ADDER_WIDTH-1:0] s68 =
       s53 ? `N22_MULDIV_ADDER_WIDTH'b0 : {s56[32],s56[32],s56};
  wire s69 = (~s65);
  wire s70 = s65;

  assign s58 = s66[34:2];
  assign s59 = {s66[1:0],
                         (s53 ? {s17,muldiv_i_rs1[31:2]} : s57[32:2])
                         };
  wire s71 = s53 ? muldiv_i_rs1[1] : s57[1];

  wire s72 = s49 & s21;
  wire s73 = s50 & s21;

  wire s74 = s72 | s73 | s32;
  wire s75 = s74;

  n22_gnrl_dfflr #(1) part_prdt_sft1_dfflr (s75, s71, s60, clk, rst_n);

  wire[`N22_XLEN-1:0] s76 = s7 ? s57[32:1] : s66[31:0];




  wire [32:0] s77;
  wire [32:0] s78;

  wire s79 = (s12 | s14) ? 1'b0 : muldiv_i_rs1[`N22_XLEN-1];
  wire s80 = (s12 | s14) ? 1'b0 : muldiv_i_rs2[`N22_XLEN-1];

  wire [65:0] s81 = {{33{s79}}, s79, muldiv_i_rs1};
  wire [33:0] s82  = {s80, s80, muldiv_i_rs2};

  wire s83 = (s81[65] ^ s82[33]) ? 1'b0 : 1'b1;

  wire [66:0] s84 = {s81[65:0],s83};


  wire s85 = s53 ? s83 : s78[0];

  wire s86;
  wire [33:0] s87 = muldiv_req_alu_res[33:0];
  wire [33:0] s88 = s53 ? s84[66:33] : {s86, s77[32:0]};
  wire [33:0] s89 = s82;
  wire s90 = (~s85);
  wire s91 =   s85 ;

  wire s92 = (s87[33] ^ s82[33]) ? 1'b0 : 1'b1;

  wire [66:0] s93;
  assign s93[66:33] = s87;
  assign s93[32: 0] = s53 ? s84[32:0] : s78[32:0];

  wire [67:0] s94 = {s93[66:0],s92};

  wire s95;
  n22_gnrl_dfflr #(1) part_remd_sft1_dfflr (s95, s87[32], s86, clk, rst_n);

  wire s96 = s49 & s22;
  wire s97 = s50 & s22;

  wire s98 = s42 | s41;
  wire s99  = s40;

  wire [33:0] s100;
  wire [33:0] s101;
  wire [32:0] s102 = s99  ? s77 [32:0]:
                         s98 ? s101[32:0] :
                                        s93[65:33];
  wire [32:0] s103 = s99  ? s78 [32:0]:
                         s98 ? s78 [32:0]:
                                        {s93[31:0],1'b1};

  wire [32:0] s104 = s98 ? s101[32:0] :
                              (s39 & s45) ? s102 :
                                                          s94[65:33];
  wire [32:0] s105 = s98 ? s100[32:0] :
                              (s39 & s45) ? s103 :
                                                          s94[32: 0];

  wire [33:0] s106 = muldiv_req_alu_res[33:0];
  wire [33:0] s107 = {s77[32], s77};
  wire [33:0] s108 = s82;
  wire s109 = 1'b1;
  wire s110 = 1'b0;

  wire s111 = ~(|s77);
  wire s112 = ~(|s106);
  wire s113 = (s77 == s82[32:0]);
  assign s43 = s22 & (
                                ((s77[32] ^ s81[65]) & (~s111))
                              | s112
                              | s113
                            );

  wire s114 = (s77[32] ^ s82[33]);

  assign s100 = muldiv_req_alu_res[33:0];
  wire [33:0] s115 = {s78[32], s78};
  wire [33:0] s116 = 34'b1;
  wire s117 = (~s114);
  wire s118 = s114;

  assign s101 = muldiv_req_alu_res[33:0];
  wire [33:0] s119 = {s77[32], s77};
  wire [33:0] s120 = s82;
  wire s121 = s114;
  wire s122 = ~s114;

  assign s95 = s96 | s97 | s32 | s35;
  wire s123 = s96 | s97 | s32 | s34;

  wire[`N22_XLEN-1:0] s124 = (s11 | s12) ? s103[`N22_XLEN-1:0] : s102[`N22_XLEN-1:0];



  wire s125 = ~(|muldiv_i_rs2);
  wire s126  = (s11 | s13) & (&muldiv_i_rs2)
                & muldiv_i_rs1[`N22_XLEN-1] & (~(|muldiv_i_rs1[`N22_XLEN-2:0]));

  wire[`N22_XLEN-1:0] s127 = ~`N22_XLEN'b0;
  wire[`N22_XLEN-1:0] s128 = s81[`N22_XLEN-1:0];
  wire[`N22_XLEN-1:0] s129 = (s11 | s12) ? s127 : s128;

  wire[`N22_XLEN-1:0] s130  = {1'b1,{`N22_XLEN-1{1'b0}}};
  wire[`N22_XLEN-1:0] s131  = `N22_XLEN'b0;
  wire[`N22_XLEN-1:0] s132 = (s11 | s12) ? s130 : s131;

  wire s133 = s22 & (s125 | s126);
  wire[`N22_XLEN-1:0] s134 = s125 ? s129 : s132;



  assign s36 = s133;
  wire[`N22_XLEN-1:0] s135 = s134;

  wire [`N22_XLEN-1:0] s136 = {s57[`N22_XLEN-2:0],s60};
  wire [`N22_XLEN-1:0] s137 = s77[`N22_XLEN-1:0];
  wire [`N22_XLEN-1:0] s138 = s78[`N22_XLEN-1:0];
  wire [`N22_XLEN-1:0] s139 = (
             ({`N22_XLEN{s7         }} & s136)
           | ({`N22_XLEN{s13 | s14}} & s137)
           | ({`N22_XLEN{s11 | s12}} & s138)
     );

  wire s140 = (s16 | s36) ? 1'b1 :
                       (
                           (s39 & s46 & (~s22))
                         | (s40 & (~s43))
                         | s42
                       );
  assign muldiv_o_valid = s140 & muldiv_i_valid;
  assign muldiv_i_ready = s140 & muldiv_o_ready;
  wire s141 = s36;
  wire s142  = s16 & (~s36);
  wire s143  = (~s16) & (~s36) & s22;
  wire s144  = (~s16) & (~s36) & s21;
  assign muldiv_o_wbck_wdat =
               ({`N22_XLEN{s142}} & s139)
             | ({`N22_XLEN{s141}} & s135)
             | ({`N22_XLEN{s143}} & s124)
             | ({`N22_XLEN{s144}} & s76);

  assign muldiv_o_wbck_err = 1'b0;

  wire s145 = s21;
  wire s146 = s22 & (s38 | s39);
  wire s147 = s22 & s41;
  wire s148 = s22 & s42;
  wire s149 = s22 & s40;

  assign muldiv_req_alu_op1 =
             ({`N22_MULDIV_ADDER_WIDTH{s145}} & s68      )
           | ({`N22_MULDIV_ADDER_WIDTH{s146}} & {{`N22_MULDIV_ADDER_WIDTH-34{1'b0}},s88      })
           | ({`N22_MULDIV_ADDER_WIDTH{s147}} & {{`N22_MULDIV_ADDER_WIDTH-34{1'b0}},s115})
           | ({`N22_MULDIV_ADDER_WIDTH{s148}} & {{`N22_MULDIV_ADDER_WIDTH-34{1'b0}},s119})
           | ({`N22_MULDIV_ADDER_WIDTH{s149}} & {{`N22_MULDIV_ADDER_WIDTH-34{1'b0}},s107});

  assign muldiv_req_alu_op2 =
             ({`N22_MULDIV_ADDER_WIDTH{s145}} & s67      )
           | ({`N22_MULDIV_ADDER_WIDTH{s146}} & {{`N22_MULDIV_ADDER_WIDTH-34{1'b0}},s89      })
           | ({`N22_MULDIV_ADDER_WIDTH{s147}} & {{`N22_MULDIV_ADDER_WIDTH-34{1'b0}},s116})
           | ({`N22_MULDIV_ADDER_WIDTH{s148}} & {{`N22_MULDIV_ADDER_WIDTH-34{1'b0}},s120})
           | ({`N22_MULDIV_ADDER_WIDTH{s149}} & {{`N22_MULDIV_ADDER_WIDTH-34{1'b0}},s108});

  assign muldiv_req_alu_add  =
             (s145 & s69      )
           | (s146 & s90      )
           | (s147 & s117)
           | (s148 & s121)
           | (s149 & s109);

  assign muldiv_req_alu_sub  =
             (s145 & s70      )
           | (s146 & s91      )
           | (s147 & s118)
           | (s148 & s122)
           | (s149 & s110);

  assign muldiv_sbf_0_ena = s95 | s74;
  assign muldiv_sbf_0_nxt = s21 ? s58 : s104;

  assign muldiv_sbf_1_ena = s123 | s75;
  assign muldiv_sbf_1_nxt = s21 ? s59 : s105;

  assign s77 = muldiv_sbf_0_r;
  assign s78 = muldiv_sbf_1_r;
  assign s56 = muldiv_sbf_0_r;
  assign s57 = muldiv_sbf_1_r;

  assign muldiv_i_longpipe = 1'b0;





`ifndef FPGA_SOURCE
`ifndef SYNTHESIS
//synopsys translate_off










//synopsys translate_on
`endif
`endif


endmodule
`endif



