
`include "global.inc"

module n22_exu_oitf (
  output dis_ready,

  input  dis_ena,
  input  ret_ena,

`ifdef N22_HAS_STACKSAFE
  output ret_rdsp,
  output oitf_has_rdsp,
`endif

  output [`N22_ITAG_WIDTH-1:0] dis_ptr,
  output [`N22_ITAG_WIDTH-1:0] ret_ptr,

  output [`N22_RFIDX_WIDTH-1:0] ret_rdidx,
  output ret_rdwen,
  output ret_rdfpu,

  input  disp_i_rs1en,
  input  disp_i_rs2en,
  input  disp_i_rs3en,
  input  disp_i_rdwen,
  input  disp_i_rs1fpu,
  input  disp_i_rs2fpu,
  input  disp_i_rs3fpu,
  input  disp_i_rdfpu,
`ifdef N22_HAS_STACKSAFE
  input  disp_i_rdsp,
`endif
  input  [`N22_RFIDX_WIDTH-1:0] disp_i_rs1idx,
  input  [`N22_RFIDX_WIDTH-1:0] disp_i_rs2idx,
  input  [`N22_RFIDX_WIDTH-1:0] disp_i_rs3idx,
  input  [`N22_RFIDX_WIDTH-1:0] disp_i_rdidx,

  output oitfrd_match_disprs1,
  output oitfrd_match_disprs2,
  output oitfrd_match_disprs3,
  output oitfrd_match_disprd,

  output oitf_empty,
  input  clk,
  input  rst_n
);

  wire [`N22_OITF_DEPTH-1:0] s0;
  wire [`N22_OITF_DEPTH-1:0] s1;
  wire [`N22_OITF_DEPTH-1:0] s2;
  wire [`N22_OITF_DEPTH-1:0] s3;
  wire [`N22_OITF_DEPTH-1:0] s4;
  wire [`N22_OITF_DEPTH-1:0] s5;
  wire [`N22_OITF_DEPTH-1:0] s6;
`ifdef N22_HAS_STACKSAFE
  wire [`N22_OITF_DEPTH-1:0] s7;
`endif
  wire [`N22_RFIDX_WIDTH-1:0] s8[`N22_OITF_DEPTH-1:0];

  wire s9 = dis_ena;
  wire s10 = ret_ena;

  wire s11 ;

  wire [`N22_ITAG_WIDTH-1:0] s12;
  wire [`N22_ITAG_WIDTH-1:0] s13;

  localparam OITF_DEPTH = `N22_OITF_DEPTH;
  localparam OITF_DEPTH_MINUS1 = (`N22_OITF_DEPTH-1);

  generate
  if(OITF_DEPTH > 1) begin: gen_depth_gt1
      wire s14;
      wire s15 = ~s14;
      wire s16 = (s12 == OITF_DEPTH_MINUS1[`N22_ITAG_WIDTH-1:0]) & s9;

      n22_gnrl_dfflr #(1) alc_ptr_flg_dfflr (s16, s15, s14, clk, rst_n);

      wire [`N22_ITAG_WIDTH-1:0] s17;

      assign s17 = s16 ? `N22_ITAG_WIDTH'b0 : (s12 + {{`N22_ITAG_WIDTH-1{1'b0}},1'b1});

      n22_gnrl_dfflr #(`N22_ITAG_WIDTH) alc_ptr_dfflr (s9, s17, s12, clk, rst_n);


      wire s18;
      wire s19 = ~s18;
      wire s20 = (s13 == OITF_DEPTH_MINUS1[`N22_ITAG_WIDTH-1:0]) & s10;

      n22_gnrl_dfflr #(1) ret_ptr_flg_dfflr (s20, s19, s18, clk, rst_n);

      wire [`N22_ITAG_WIDTH-1:0] s21;

      assign s21 = s20 ? `N22_ITAG_WIDTH'b0 : (s13 + {{`N22_ITAG_WIDTH-1{1'b0}},1'b1});

      n22_gnrl_dfflr #(`N22_ITAG_WIDTH) ret_ptr_dfflr (s10, s21, s13, clk, rst_n);

      assign oitf_empty = (s13 == s12) &   (s18 == s14);
      assign s11  = (s13 == s12) & (~(s18 == s14));
      assign dis_ready = (~s11);
  end
  else begin: gen_depth_eq1
      assign s12 =1'b0;
      assign s13 =1'b0;
      assign oitf_empty = ~s4[0];
      assign s11  = s4[0];
      assign dis_ready = (~s11) | ret_ena;
  end
  endgenerate

  assign ret_ptr = s13;
  assign dis_ptr = s12;


  wire [`N22_OITF_DEPTH-1:0] s22;
  wire [`N22_OITF_DEPTH-1:0] s23;
  wire [`N22_OITF_DEPTH-1:0] s24;
  wire [`N22_OITF_DEPTH-1:0] s25;
`ifdef N22_HAS_STACKSAFE
  wire [`N22_OITF_DEPTH-1:0] s26;
`endif

  genvar i;
  generate
      for (i=0; i<`N22_OITF_DEPTH; i=i+1) begin:gen_oitf_entries

        assign s0[i] = s9 & (s12 == i[`N22_ITAG_WIDTH-1:0]);
        assign s1[i] = s10 & (s13 == i[`N22_ITAG_WIDTH-1:0]);
        assign s2[i] = s0[i] |   s1[i];
        assign s3[i] = s0[i] | (~s1[i]);

        n22_gnrl_dfflr #(1) vld_dfflr (s2[i], s3[i], s4[i], clk, rst_n);
        n22_gnrl_dfflr #(`N22_RFIDX_WIDTH) rdidx_dfflr  (s0[i], disp_i_rdidx, s8[i], clk, rst_n);
        n22_gnrl_dfflr #(1)                 rdwen_dfflr  (s0[i], disp_i_rdwen, s5[i], clk, rst_n);
        n22_gnrl_dfflr #(1)                 rdfpu_dfflr  (s0[i], disp_i_rdfpu, s6[i], clk, rst_n);
`ifdef N22_HAS_STACKSAFE
        n22_gnrl_dfflr #(1)                 rdsp_dfflr  (s0[i], disp_i_rdsp, s7[i], clk, rst_n);
`endif

        assign s22[i] = s4[i] & s5[i] & disp_i_rs1en & (s6[i] == disp_i_rs1fpu) & (s8[i] == disp_i_rs1idx);
        assign s23[i] = s4[i] & s5[i] & disp_i_rs2en & (s6[i] == disp_i_rs2fpu) & (s8[i] == disp_i_rs2idx);
        assign s24[i] = s4[i] & s5[i] & disp_i_rs3en & (s6[i] == disp_i_rs3fpu) & (s8[i] == disp_i_rs3idx);
        assign s25 [i] = s4[i] & s5[i] & disp_i_rdwen & (s6[i] == disp_i_rdfpu ) & (s8[i] == disp_i_rdidx );
`ifdef N22_HAS_STACKSAFE
        assign s26 [i] = s4[i] & s7[i];
`endif

      end
  endgenerate

  assign oitfrd_match_disprs1 = |s22;
  assign oitfrd_match_disprs2 = |s23;
  assign oitfrd_match_disprs3 = |s24;
  assign oitfrd_match_disprd  = |s25 ;

  assign ret_rdidx = s8[ret_ptr];
  assign ret_rdwen = s5[ret_ptr];
  assign ret_rdfpu = s6[ret_ptr];
`ifdef N22_HAS_STACKSAFE
  assign ret_rdsp = s7[ret_ptr];
  assign oitf_has_rdsp = |s26;
`endif

endmodule


