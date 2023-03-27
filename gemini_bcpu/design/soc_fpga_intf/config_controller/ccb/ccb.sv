module ccb #(
  parameter REGS_NUM = 5 ,
  parameter DWIDTH   = 32
) (
  input  logic                clk                   ,
  input  logic                rst_n             ,
  // read apb_manager
  output logic                rack_o                ,
  output logic                rerr_o                ,
  output logic [  DWIDTH-1:0] rdat_o                ,
  input  logic [REGS_NUM-1:0] rreq_i                ,
  // write apb_manager
  output logic                wack_o                ,
  output logic                werr_o                ,
  input  logic [  DWIDTH-1:0] wdat_i                ,
  input  logic [REGS_NUM-1:0] wreq_i                ,
  input  logic [DWIDTH/8-1:0] wstr_i                ,
  // pll0 control
  output logic [        11:0] fpga_pll0_dskewcalin  ,
  output logic                fpga_pll0_pllen       ,
  output logic                fpga_pll0_dsmen       ,
  output logic                fpga_pll0_dskewfastcal,
  output logic                fpga_pll0_dskewcalen  ,
  output logic [         2:0] fpga_pll0_dskewcalcnt ,
  output logic                fpga_pll0_dskewcalbyp ,
  output logic                fpga_pll0_dacen       ,
  output logic [         5:0] fpga_pll0_refdiv      ,
  output logic                fpga_pll0_foutvcoen   ,
  output logic [         4:0] fpga_pll0_foutvcobyp  ,
  output logic [         3:0] fpga_pll0_fouten      ,
  output logic [        23:0] fpga_pll0_frac        ,
  output logic [        11:0] fpga_pll0_fbdiv       ,
  output logic [         3:0] fpga_pll0_postdiv3    ,
  output logic [         3:0] fpga_pll0_postdiv2    ,
  output logic [         3:0] fpga_pll0_postdiv1    ,
  output logic [         3:0] fpga_pll0_postdiv0    ,
  // pll0 status
  input  logic                fpga_pll0_lock        ,
  input  logic                fpga_pll0_dskewcallock,
  input  logic [        11:0] fpga_pll0_dskewcalout ,
  // pll1 control
  output logic [        11:0] fpga_pll1_dskewcalin  ,
  output logic                fpga_pll1_pllen       ,
  output logic                fpga_pll1_dsmen       ,
  output logic                fpga_pll1_dskewfastcal,
  output logic                fpga_pll1_dskewcalen  ,
  output logic [         2:0] fpga_pll1_dskewcalcnt ,
  output logic                fpga_pll1_dskewcalbyp ,
  output logic                fpga_pll1_dacen       ,
  output logic [         5:0] fpga_pll1_refdiv      ,
  output logic                fpga_pll1_foutvcoen   ,
  output logic [         4:0] fpga_pll1_foutvcobyp  ,
  output logic [         3:0] fpga_pll1_fouten      ,
  output logic [        23:0] fpga_pll1_frac        ,
  output logic [        11:0] fpga_pll1_fbdiv       ,
  output logic [         3:0] fpga_pll1_postdiv3    ,
  output logic [         3:0] fpga_pll1_postdiv2    ,
  output logic [         3:0] fpga_pll1_postdiv1    ,
  output logic [         3:0] fpga_pll1_postdiv0    ,
  // pll1 status
  input  logic                fpga_pll1_lock        ,
  input  logic                fpga_pll1_dskewcallock,
  input  logic [        11:0] fpga_pll1_dskewcalout ,
  // pll2 control
  output logic [        11:0] fpga_pll2_dskewcalin  ,
  output logic                fpga_pll2_pllen       ,
  output logic                fpga_pll2_dsmen       ,
  output logic                fpga_pll2_dskewfastcal,
  output logic                fpga_pll2_dskewcalen  ,
  output logic [         2:0] fpga_pll2_dskewcalcnt ,
  output logic                fpga_pll2_dskewcalbyp ,
  output logic                fpga_pll2_dacen       ,
  output logic [         5:0] fpga_pll2_refdiv      ,
  output logic                fpga_pll2_foutvcoen   ,
  output logic [         4:0] fpga_pll2_foutvcobyp  ,
  output logic [         3:0] fpga_pll2_fouten      ,
  output logic [        23:0] fpga_pll2_frac        ,
  output logic [        11:0] fpga_pll2_fbdiv       ,
  output logic [         3:0] fpga_pll2_postdiv3    ,
  output logic [         3:0] fpga_pll2_postdiv2    ,
  output logic [         3:0] fpga_pll2_postdiv1    ,
  output logic [         3:0] fpga_pll2_postdiv0    ,
  // pll2 status
  input  logic                fpga_pll2_lock        ,
  input  logic                fpga_pll2_dskewcallock,
  input  logic [        11:0] fpga_pll2_dskewcalout ,
  // pll3 control
  output logic [        11:0] fpga_pll3_dskewcalin  ,
  output logic                fpga_pll3_pllen       ,
  output logic                fpga_pll3_dsmen       ,
  output logic                fpga_pll3_dskewfastcal,
  output logic                fpga_pll3_dskewcalen  ,
  output logic [         2:0] fpga_pll3_dskewcalcnt ,
  output logic                fpga_pll3_dskewcalbyp ,
  output logic                fpga_pll3_dacen       ,
  output logic [         5:0] fpga_pll3_refdiv      ,
  output logic                fpga_pll3_foutvcoen   ,
  output logic [         4:0] fpga_pll3_foutvcobyp  ,
  output logic [         3:0] fpga_pll3_fouten      ,
  output logic [        23:0] fpga_pll3_frac        ,
  output logic [        11:0] fpga_pll3_fbdiv       ,
  output logic [         3:0] fpga_pll3_postdiv3    ,
  output logic [         3:0] fpga_pll3_postdiv2    ,
  output logic [         3:0] fpga_pll3_postdiv1    ,
  output logic [         3:0] fpga_pll3_postdiv0    ,
  // pll3 status
  input  logic                fpga_pll3_lock        ,
  input  logic                fpga_pll3_dskewcallock,
  input  logic [        11:0] fpga_pll3_dskewcalout
);
  localparam PLL_NUM = 4;

  logic                        fpga_pll_rack_o      [PLL_NUM];
  logic                        fpga_pll_rerr_o      [PLL_NUM];
  logic [          DWIDTH-1:0] fpga_pll_rdat_o      [PLL_NUM];
  logic [REGS_NUM/PLL_NUM-1:0] fpga_pll_rreq_i      [PLL_NUM];
  logic                        fpga_pll_wack_o      [PLL_NUM];
  logic                        fpga_pll_werr_o      [PLL_NUM];
  logic [          DWIDTH-1:0] fpga_pll_wdat_i      [PLL_NUM];
  logic [REGS_NUM/PLL_NUM-1:0] fpga_pll_wreq_i      [PLL_NUM];
  logic [        DWIDTH/8-1:0] fpga_pll_wstr_i      [PLL_NUM];
  logic [                11:0] fpga_pll_dskewcalin  [PLL_NUM];
  logic                        fpga_pll_pllen       [PLL_NUM];
  logic                        fpga_pll_dsmen       [PLL_NUM];
  logic                        fpga_pll_dskewfastcal[PLL_NUM];
  logic                        fpga_pll_dskewcalen  [PLL_NUM];
  logic [                 2:0] fpga_pll_dskewcalcnt [PLL_NUM];
  logic                        fpga_pll_dskewcalbyp [PLL_NUM];
  logic                        fpga_pll_dacen       [PLL_NUM];
  logic [                 5:0] fpga_pll_refdiv      [PLL_NUM];
  logic                        fpga_pll_foutvcoen   [PLL_NUM];
  logic [                 4:0] fpga_pll_foutvcobyp  [PLL_NUM];
  logic [                 3:0] fpga_pll_fouten      [PLL_NUM];
  logic [                23:0] fpga_pll_frac        [PLL_NUM];
  logic [                11:0] fpga_pll_fbdiv       [PLL_NUM];
  logic [                 3:0] fpga_pll_postdiv3    [PLL_NUM];
  logic [                 3:0] fpga_pll_postdiv2    [PLL_NUM];
  logic [                 3:0] fpga_pll_postdiv1    [PLL_NUM];
  logic [                 3:0] fpga_pll_postdiv0    [PLL_NUM];
  logic                        fpga_pll_lock        [PLL_NUM];
  logic                        fpga_pll_dskewcallock[PLL_NUM];
  logic [                11:0] fpga_pll_dskewcalout [PLL_NUM];


  assign rerr_o = 'h0;

  assign werr_o = fpga_pll_werr_o[0] | fpga_pll_werr_o[1] | fpga_pll_werr_o[2] | fpga_pll_werr_o[3];

  assign rack_o = fpga_pll_rack_o[0] | fpga_pll_rack_o[1] | fpga_pll_rack_o[2] | fpga_pll_rack_o[3];

  assign wack_o = fpga_pll_wack_o[0] | fpga_pll_wack_o[1] | fpga_pll_wack_o[2] | fpga_pll_wack_o[3];

  assign rdat_o = fpga_pll_rack_o[0] ? fpga_pll_rdat_o[0] :
                  fpga_pll_rack_o[1] ? fpga_pll_rdat_o[1] :
                  fpga_pll_rack_o[2] ? fpga_pll_rdat_o[2] :
                  fpga_pll_rack_o[3] ? fpga_pll_rdat_o[3] : 32'h0;
  genvar i;
  generate
      for(i = 0; i < PLL_NUM; i = i + 1) begin : fpga_pll_num

        assign fpga_pll_rreq_i[i] = rreq_i[i*REGS_NUM/PLL_NUM + PLL_NUM :i*REGS_NUM/4];
        assign fpga_pll_wdat_i[i] = wdat_i;
        assign fpga_pll_wreq_i[i] = wreq_i[i*REGS_NUM/PLL_NUM + PLL_NUM :i*REGS_NUM/4];
        assign fpga_pll_wstr_i[i] = wstr_i;

        fpga_pll_regs #(
          .REGS_NUM(REGS_NUM/PLL_NUM),
          .DWIDTH  (DWIDTH          )
        ) fpga_pll_regs_u (
          .clk         (clk                     ),
          .rst_n       (rst_n                   ),
          .rack_o      (fpga_pll_rack_o[i]      ),
          .rerr_o      (fpga_pll_rerr_o[i]      ),
          .rdat_o      (fpga_pll_rdat_o[i]      ),
          .rreq_i      (fpga_pll_rreq_i[i]      ),
          .wack_o      (fpga_pll_wack_o[i]      ),
          .werr_o      (fpga_pll_werr_o[i]      ),
          .wdat_i      (fpga_pll_wdat_i[i]      ),
          .wreq_i      (fpga_pll_wreq_i[i]      ),
          .wstr_i      (fpga_pll_wstr_i[i]      ),
          .dskewcalin  (fpga_pll_dskewcalin[i]  ),
          .pllen       (fpga_pll_pllen[i]       ),
          .dsmen       (fpga_pll_dsmen[i]       ),
          .dskewfastcal(fpga_pll_dskewfastcal[i]),
          .dskewcalen  (fpga_pll_dskewcalen[i]  ),
          .dskewcalcnt (fpga_pll_dskewcalcnt[i] ),
          .dskewcalbyp (fpga_pll_dskewcalbyp[i] ),
          .dacen       (fpga_pll_dacen[i]       ),
          .refdiv      (fpga_pll_refdiv[i]      ),
          .foutvcoen   (fpga_pll_foutvcoen[i]   ),
          .foutvcobyp  (fpga_pll_foutvcobyp[i]  ),
          .fouten      (fpga_pll_fouten[i]      ),
          .frac        (fpga_pll_frac[i]        ),
          .fbdiv       (fpga_pll_fbdiv[i]       ),
          .postdiv3    (fpga_pll_postdiv3[i]    ),
          .postdiv2    (fpga_pll_postdiv2[i]    ),
          .postdiv1    (fpga_pll_postdiv1[i]    ),
          .postdiv0    (fpga_pll_postdiv0[i]    ),
          .lock        (fpga_pll_lock[i]        ),
          .dskewcallock(fpga_pll_dskewcallock[i]),
          .dskewcalout (fpga_pll_dskewcalout[i] )
        );
      end
      endgenerate

//input
  assign fpga_pll_lock[0]         = fpga_pll0_lock;
  assign fpga_pll_dskewcallock[0] = fpga_pll0_dskewcallock;
  assign fpga_pll_dskewcalout[0]  = fpga_pll0_dskewcalout;

  assign fpga_pll_lock[1]         = fpga_pll1_lock;
  assign fpga_pll_dskewcallock[1] = fpga_pll1_dskewcallock;
  assign fpga_pll_dskewcalout[1]  = fpga_pll1_dskewcalout;

  assign fpga_pll_lock[2]         = fpga_pll2_lock;
  assign fpga_pll_dskewcallock[2] = fpga_pll2_dskewcallock;
  assign fpga_pll_dskewcalout[2]  = fpga_pll2_dskewcalout;

  assign fpga_pll_lock[3]         = fpga_pll3_lock;
  assign fpga_pll_dskewcallock[3] = fpga_pll3_dskewcallock;
  assign fpga_pll_dskewcalout[3]  = fpga_pll3_dskewcalout;
//output
  assign fpga_pll0_dskewcalin   = fpga_pll_dskewcalin[0];
  assign fpga_pll0_pllen        = fpga_pll_pllen[0];
  assign fpga_pll0_dsmen        = fpga_pll_dsmen[0];
  assign fpga_pll0_dskewfastcal = fpga_pll_dskewfastcal[0];
  assign fpga_pll0_dskewcalen   = fpga_pll_dskewcalen[0];
  assign fpga_pll0_dskewcalcnt  = fpga_pll_dskewcalcnt[0];
  assign fpga_pll0_dskewcalbyp  = fpga_pll_dskewcalbyp[0];
  assign fpga_pll0_dacen        = fpga_pll_dacen[0];
  assign fpga_pll0_refdiv       = fpga_pll_refdiv[0];
  assign fpga_pll0_foutvcoen    = fpga_pll_foutvcoen[0];
  assign fpga_pll0_foutvcobyp   = fpga_pll_foutvcobyp[0];
  assign fpga_pll0_fouten       = fpga_pll_fouten[0];
  assign fpga_pll0_frac         = fpga_pll_frac[0];
  assign fpga_pll0_fbdiv        = fpga_pll_fbdiv[0];
  assign fpga_pll0_postdiv3     = fpga_pll_postdiv3[0];
  assign fpga_pll0_postdiv2     = fpga_pll_postdiv2[0];
  assign fpga_pll0_postdiv1     = fpga_pll_postdiv1[0];
  assign fpga_pll0_postdiv0     = fpga_pll_postdiv0[0];

  assign fpga_pll1_dskewcalin   = fpga_pll_dskewcalin[1];
  assign fpga_pll1_pllen        = fpga_pll_pllen[1];
  assign fpga_pll1_dsmen        = fpga_pll_dsmen[1];
  assign fpga_pll1_dskewfastcal = fpga_pll_dskewfastcal[1];
  assign fpga_pll1_dskewcalen   = fpga_pll_dskewcalen[1];
  assign fpga_pll1_dskewcalcnt  = fpga_pll_dskewcalcnt[1];
  assign fpga_pll1_dskewcalbyp  = fpga_pll_dskewcalbyp[1];
  assign fpga_pll1_dacen        = fpga_pll_dacen[1];
  assign fpga_pll1_refdiv       = fpga_pll_refdiv[1];
  assign fpga_pll1_foutvcoen    = fpga_pll_foutvcoen[1];
  assign fpga_pll1_foutvcobyp   = fpga_pll_foutvcobyp[1];
  assign fpga_pll1_fouten       = fpga_pll_fouten[1];
  assign fpga_pll1_frac         = fpga_pll_frac[1];
  assign fpga_pll1_fbdiv        = fpga_pll_fbdiv[1];
  assign fpga_pll1_postdiv3     = fpga_pll_postdiv3[1];
  assign fpga_pll1_postdiv2     = fpga_pll_postdiv2[1];
  assign fpga_pll1_postdiv1     = fpga_pll_postdiv1[1];
  assign fpga_pll1_postdiv0     = fpga_pll_postdiv0[1];

  assign fpga_pll2_dskewcalin   = fpga_pll_dskewcalin[2];
  assign fpga_pll2_pllen        = fpga_pll_pllen[2];
  assign fpga_pll2_dsmen        = fpga_pll_dsmen[2];
  assign fpga_pll2_dskewfastcal = fpga_pll_dskewfastcal[2];
  assign fpga_pll2_dskewcalen   = fpga_pll_dskewcalen[2];
  assign fpga_pll2_dskewcalcnt  = fpga_pll_dskewcalcnt[2];
  assign fpga_pll2_dskewcalbyp  = fpga_pll_dskewcalbyp[2];
  assign fpga_pll2_dacen        = fpga_pll_dacen[2];
  assign fpga_pll2_refdiv       = fpga_pll_refdiv[2];
  assign fpga_pll2_foutvcoen    = fpga_pll_foutvcoen[2];
  assign fpga_pll2_foutvcobyp   = fpga_pll_foutvcobyp[2];
  assign fpga_pll2_fouten       = fpga_pll_fouten[2];
  assign fpga_pll2_frac         = fpga_pll_frac[2];
  assign fpga_pll2_fbdiv        = fpga_pll_fbdiv[2];
  assign fpga_pll2_postdiv3     = fpga_pll_postdiv3[2];
  assign fpga_pll2_postdiv2     = fpga_pll_postdiv2[2];
  assign fpga_pll2_postdiv1     = fpga_pll_postdiv1[2];
  assign fpga_pll2_postdiv0     = fpga_pll_postdiv0[2];

  assign fpga_pll3_dskewcalin   = fpga_pll_dskewcalin[3];
  assign fpga_pll3_pllen        = fpga_pll_pllen[3];
  assign fpga_pll3_dsmen        = fpga_pll_dsmen[3];
  assign fpga_pll3_dskewfastcal = fpga_pll_dskewfastcal[3];
  assign fpga_pll3_dskewcalen   = fpga_pll_dskewcalen[3];
  assign fpga_pll3_dskewcalcnt  = fpga_pll_dskewcalcnt[3];
  assign fpga_pll3_dskewcalbyp  = fpga_pll_dskewcalbyp[3];
  assign fpga_pll3_dacen        = fpga_pll_dacen[3];
  assign fpga_pll3_refdiv       = fpga_pll_refdiv[3];
  assign fpga_pll3_foutvcoen    = fpga_pll_foutvcoen[3];
  assign fpga_pll3_foutvcobyp   = fpga_pll_foutvcobyp[3];
  assign fpga_pll3_fouten       = fpga_pll_fouten[3];
  assign fpga_pll3_frac         = fpga_pll_frac[3];
  assign fpga_pll3_fbdiv        = fpga_pll_fbdiv[3];
  assign fpga_pll3_postdiv3     = fpga_pll_postdiv3[3];
  assign fpga_pll3_postdiv2     = fpga_pll_postdiv2[3];
  assign fpga_pll3_postdiv1     = fpga_pll_postdiv1[3];
  assign fpga_pll3_postdiv0     = fpga_pll_postdiv0[3];

endmodule                       