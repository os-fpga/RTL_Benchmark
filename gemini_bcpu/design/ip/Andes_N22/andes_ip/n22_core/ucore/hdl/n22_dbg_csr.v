
`include "global.inc"

`ifdef N22_HAS_DEBUG

module n22_dbg_csr (

  input csr_ena,
  input csr_wr_en,
  input csr_rd_en,
  input [12-1:0] csr_idx,
  input wbck_csr_wen,
  input  [`N22_XLEN-1:0] wbck_csr_dat,
  output [`N22_XLEN-1:0] read_csr_dat,
  output csr_addr_legal,
  output csr_prv_ilgl,


  input  [`N22_PC_SIZE-1:0] cmt_dpc,
  input  cmt_dpc_ena,

  input  [3-1:0] cmt_dcause,
  input  cmt_dcause_ena,

  output  [`N22_XLEN-1:0] dbg_dexc2dbg_r,
  input   [`N22_XLEN-1:0] cmt_ddcause,
  input   cmt_ddcause_ena,

  input  cmt_dprv_ena,
  input  [2-1:0] cmt_dprv,
  output [2-1:0] dbg_prv_r,

`ifdef N22_HAS_TRIGM
  output [`N22_XLEN*`N22_DEBUG_TRIGM_NUM-1:0] dbg_tdata1,
  output [`N22_XLEN*`N22_DEBUG_TRIGM_NUM-1:0] dbg_tdata2,
  input  icount_taken_ena,
`endif


  output[`N22_PC_SIZE-1:0]  csr_dpc_r,

  output dbg_mode,
  output dbg_step_r,
  output dbg_ebreakm_r,

  output dbg_stopcount,
  output dbg_stoptime,

  output dbg_ebreaku_r,
  output dbg_stepie,
  output dbg_mprven,
  input  nmi_irq_r,

  input  clk,
  input  rst_n
  );


`ifdef N22_HAS_TRIGM
localparam TRIGM_NUM_LOG2 = `CLOG2(`N22_DEBUG_TRIGM_NUM);
`endif

wire [32-1:0] dcsr_r;
wire [`N22_PC_SIZE-1:0] dpc_r;
wire [32-1:0] dscratch0_r;
wire [32-1:0] dscratch1_r;
wire [32-1:0] dexc2dbg_r;
wire [32-1:0] ddcause_r;

wire sel_dcsr_raw      = (csr_idx == 12'h7b0);
wire sel_dpc_raw       = (csr_idx == 12'h7b1);
wire sel_dscratch0_raw = (csr_idx == 12'h7b2);
wire sel_dscratch1_raw = (csr_idx == 12'h7b3);
wire sel_dexc2dbg_raw  = (csr_idx == 12'h7e0);
wire sel_ddcause_raw   = (csr_idx == 12'h7e1);

wire sel_dcsr      = dbg_mode & sel_dcsr_raw     ;
wire sel_dpc       = dbg_mode & sel_dpc_raw      ;
wire sel_dscratch0 = dbg_mode & sel_dscratch0_raw;
wire sel_dscratch1 = dbg_mode & sel_dscratch1_raw;
wire sel_dexc2dbg  = dbg_mode & sel_dexc2dbg_raw ;
wire sel_ddcause   = dbg_mode & sel_ddcause_raw  ;

assign csr_prv_ilgl = (~dbg_mode) & (
              sel_dcsr_raw
            | sel_dpc_raw
            | sel_dscratch0_raw
            | sel_dscratch1_raw
            | sel_dexc2dbg_raw
            | sel_ddcause_raw   );

wire rd_dcsr     = csr_rd_en & sel_dcsr    ;
wire rd_dpc      = csr_rd_en & sel_dpc     ;
wire rd_dscratch0 = csr_rd_en & sel_dscratch0;
wire rd_dscratch1 = csr_rd_en & sel_dscratch1;
wire rd_dexc2dbg  = csr_rd_en & sel_dexc2dbg ;
wire rd_ddcause = csr_rd_en & sel_ddcause;

wire sel_tselect  = (csr_idx == 12'h7a0);
wire sel_tdata1   = (csr_idx == 12'h7a1);
wire sel_tdata2   = (csr_idx == 12'h7a2);
wire sel_tdata3   = (csr_idx == 12'h7a3);
wire sel_tinfo    = (csr_idx == 12'h7a4);
wire sel_mcontext = (csr_idx == 12'h7a8);
wire sel_textra32 = (csr_idx == 12'h7a3);

wire rd_tselect  =  csr_rd_en & sel_tselect ;
wire rd_tdata1   =  csr_rd_en & sel_tdata1  ;
wire rd_tdata2   =  csr_rd_en & sel_tdata2  ;
wire rd_tdata3   =  csr_rd_en & sel_tdata3  ;
wire rd_tinfo    =  csr_rd_en & sel_tinfo   ;
wire rd_mcontext =  csr_rd_en & sel_mcontext;
wire rd_textra32 =  csr_rd_en & sel_textra32;

    `ifdef N22_HAS_TRIGM
wire wr_tselect_ena  = wbck_csr_wen & sel_tselect ;
wire wr_tdata1_ena   = wbck_csr_wen & sel_tdata1  ;
wire wr_tdata2_ena   = wbck_csr_wen & sel_tdata2  ;

wire [`N22_XLEN-1:0] tdata1_r ;
wire [`N22_XLEN-1:0] tdata2_r ;
wire [`N22_XLEN-1:0] tselect_r ;
wire [`N22_XLEN-1:0] csr_tdata1   = tdata1_r ;
wire [`N22_XLEN-1:0] csr_tdata2   = tdata2_r ;
wire [`N22_XLEN-1:0] csr_tdata3   = `N22_XLEN'b0 ;
wire [`N22_XLEN-1:0] csr_tinfo    = {26'b0,4'b1111,2'b0};
wire [`N22_XLEN-1:0] csr_tselect  = tselect_r ;

    `endif
    `ifndef N22_HAS_TRIGM
wire [`N22_XLEN-1:0] csr_tinfo    = 32'b1;
wire [`N22_XLEN-1:0] csr_tselect  = 32'b0;
wire [`N22_XLEN-1:0] csr_tdata1   = 32'b0;
wire [`N22_XLEN-1:0] csr_tdata2   = 32'b0;
wire [`N22_XLEN-1:0] csr_tdata3   = 32'b0;
    `endif

wire wr_dcsr_ena     = wbck_csr_wen & sel_dcsr    ;
wire wr_dpc_ena      = wbck_csr_wen & sel_dpc     ;
wire wr_dscratch0_ena = wbck_csr_wen & sel_dscratch0;
wire wr_dscratch1_ena = wbck_csr_wen & sel_dscratch1;
wire wr_dexc2dbg_ena = wbck_csr_wen & sel_dexc2dbg;
wire wr_ddcause_ena = wbck_csr_wen & sel_ddcause;



wire [`N22_XLEN-1:0] csr_dcsr     = dcsr_r    ;
wire [`N22_XLEN-1:0] csr_dpc      = dpc_r     ;
wire [`N22_XLEN-1:0] csr_dscratch0 = dscratch0_r;
wire [`N22_XLEN-1:0] csr_dscratch1 = dscratch1_r;
wire [`N22_XLEN-1:0] csr_dexc2dbg = dexc2dbg_r;
wire [`N22_XLEN-1:0] csr_ddcause = ddcause_r;


assign {csr_addr_legal, read_csr_dat} = {1'b0,`N22_XLEN'b0}
               | {sel_dcsr_raw    ,({`N22_XLEN{rd_dcsr       }} & csr_dcsr    )      }
               | {sel_dpc_raw     ,({`N22_XLEN{rd_dpc        }} & csr_dpc     )      }
               | {sel_dscratch0_raw,({`N22_XLEN{rd_dscratch0   }} & csr_dscratch0)      }
               | {sel_dscratch1_raw,({`N22_XLEN{rd_dscratch1   }} & csr_dscratch1)      }
               | {sel_dexc2dbg_raw ,({`N22_XLEN{rd_dexc2dbg    }} & csr_dexc2dbg)      }
               | {sel_ddcause_raw,({`N22_XLEN{rd_ddcause   }} & csr_ddcause)      }
               | {sel_tselect, ({`N22_XLEN{rd_tselect    }} & csr_tselect)       }
               | {sel_tdata1 , ({`N22_XLEN{rd_tdata1     }} & csr_tdata1)        }
               | {sel_tdata2 , ({`N22_XLEN{rd_tdata2     }} & csr_tdata2)        }
               | {sel_tdata3 , ({`N22_XLEN{rd_tdata3     }} & csr_tdata3)        }
               | {sel_tinfo  , ({`N22_XLEN{rd_tinfo      }} & csr_tinfo )        }
               | {sel_mcontext  , ({`N22_XLEN{rd_mcontext      }} & 32'b0 )        }
               | {sel_textra32  , ({`N22_XLEN{rd_textra32      }} & 32'b0 )        }
               ;


assign csr_dpc_r = dpc_r;


  wire dpc_ena = wr_dpc_ena | cmt_dpc_ena;
  wire [`N22_PC_SIZE-1:0] dpc_nxt;
  assign dpc_nxt[`N22_PC_SIZE-1:1] =
       cmt_dpc_ena ? cmt_dpc[`N22_PC_SIZE-1:1]
                   : wbck_csr_dat[`N22_PC_SIZE-1:1];
  assign dpc_nxt[0] = 1'b0;
  n22_gnrl_dfflr #(`N22_PC_SIZE) dpc_dfflr (dpc_ena, dpc_nxt, dpc_r, clk, rst_n);

  wire dscratch0_ena = wr_dscratch0_ena;
  wire [32-1:0] dscratch0_nxt;
  assign dscratch0_nxt = wbck_csr_dat;
  n22_gnrl_dfflr #(32) dscratch0_dfflr (dscratch0_ena, dscratch0_nxt, dscratch0_r, clk, rst_n);

  wire dscratch1_ena = wr_dscratch1_ena;
  wire [32-1:0] dscratch1_nxt;
  assign dscratch1_nxt = wbck_csr_dat;
  n22_gnrl_dfflr #(32) dscratch1_dfflr (dscratch1_ena, dscratch1_nxt, dscratch1_r, clk, rst_n);

  wire dexc2dbg_ena = wr_dexc2dbg_ena;
  wire [32-1:0] dexc2dbg_nxt;
  assign dexc2dbg_nxt = {12'b0,
          `ifdef N22_HAS_PMONITOR
                wbck_csr_dat[19],
          `else
                1'b0,
          `endif
                3'b0,wbck_csr_dat[15],2'b0,
          `ifdef N22_HAS_STACKSAFE
                wbck_csr_dat[12],
          `else
                1'b0,
          `endif
                    wbck_csr_dat[11],
                    2'b0,
          `ifdef N22_HAS_UMODE
                wbck_csr_dat[8],
          `else
                1'b0,
          `endif
                    wbck_csr_dat[7:0]
                    };
  n22_gnrl_dfflr #(32) dexc2dbg_dfflr (dexc2dbg_ena, dexc2dbg_nxt, dexc2dbg_r, clk, rst_n);

  wire ddcause_ena = cmt_ddcause_ena;
  wire [32-1:0] ddcause_nxt;
  assign ddcause_nxt = cmt_ddcause;
  n22_gnrl_dfflr #(32) ddcause_dfflr (ddcause_ena, ddcause_nxt, ddcause_r, clk, rst_n);

`ifdef N22_HAS_TRIGM
  wire[31:0] tdata1 [0:`N22_DEBUG_TRIGM_NUM-1];
  wire[31:0] tdata2 [0:`N22_DEBUG_TRIGM_NUM-1];
  wire[`N22_DEBUG_TRIGM_NUM-1:0] tdata1_wr_ena;
  wire[`N22_DEBUG_TRIGM_NUM-1:0] tdata2_wr_ena;
  wire[`N22_DEBUG_TRIGM_NUM-1:0] tselect_sel;
  wire[`N22_DEBUG_TRIGM_NUM-1:0] tdata_wr_enable;
  wire[`N22_DEBUG_TRIGM_NUM-1:0] tdata1_type_ena;
  wire[`N22_TDATA1_TYPE_W-1:0] tdata1_type_nxt[0:`N22_DEBUG_TRIGM_NUM-1];
  wire[`N22_TDATA1_TYPE_W-1:0] tdata1_type    [0:`N22_DEBUG_TRIGM_NUM-1];
  wire[`N22_DEBUG_TRIGM_NUM-1:0] tdata1_type_2;
  wire[`N22_DEBUG_TRIGM_NUM-1:0] tdata1_type_3;
  wire[`N22_DEBUG_TRIGM_NUM-1:0] tdata1_type_4;
  wire[`N22_DEBUG_TRIGM_NUM-1:0] tdata1_type_5;
  wire[`N22_DEBUG_TRIGM_NUM-1:0] tdata1_type_nxt_2;
  wire[`N22_DEBUG_TRIGM_NUM-1:0] tdata1_type_nxt_3;
  wire[`N22_DEBUG_TRIGM_NUM-1:0] tdata1_type_nxt_4;
  wire[`N22_DEBUG_TRIGM_NUM-1:0] tdata1_type_nxt_5;
  wire[`N22_DEBUG_TRIGM_NUM-1:0] tdata1_dmode_ena;
  wire[`N22_TDATA1_DMODE_W-1:0] tdata1_dmode_nxt[0:`N22_DEBUG_TRIGM_NUM-1];
  wire[`N22_TDATA1_DMODE_W-1:0] tdata1_dmode    [0:`N22_DEBUG_TRIGM_NUM-1];
  wire[`N22_DEBUG_TRIGM_NUM-1:0] tdata1_data_ena;
  wire[`N22_TDATA1_DATA_W-1:0] tdata1_data_nxt[0:`N22_DEBUG_TRIGM_NUM-1];
  wire[`N22_TDATA1_DATA_W-1:0] tdata1_data    [0:`N22_DEBUG_TRIGM_NUM-1];
  wire[`N22_TDATA1_DATA_W-1:0] tdata1_data_pos    [0:`N22_DEBUG_TRIGM_NUM-1];
  wire[`N22_DEBUG_TRIGM_NUM-1:0] tdata1_data_9_6_clr;
  wire[`N22_DEBUG_TRIGM_NUM-1:0] tdata1_data_9_6_ena;
  wire[3:0] tdata1_data_9_6_nxt[0:`N22_DEBUG_TRIGM_NUM-1];

  wire tselect_ena = wr_tselect_ena;
  wire [TRIGM_NUM_LOG2-1:0] tselect_nxt = wbck_csr_dat[TRIGM_NUM_LOG2-1:0];
  n22_gnrl_dfflr #(TRIGM_NUM_LOG2) tselect_dfflr (tselect_ena, tselect_nxt, tselect_r[TRIGM_NUM_LOG2-1:0], clk, rst_n);
  assign tselect_r[31:TRIGM_NUM_LOG2] = {32-TRIGM_NUM_LOG2{1'b0}};

  genvar i;

  generate
  for(i=0; i<`N22_DEBUG_TRIGM_NUM; i=i+1) begin: gen_tdata
    assign dbg_tdata2 [`N22_XLEN*i +: `N22_XLEN] = tdata2[i];
    assign dbg_tdata1 [`N22_XLEN*i +: `N22_XLEN] = tdata1[i];

    assign tselect_sel[i] = (tselect_r[TRIGM_NUM_LOG2-1:0] == i[TRIGM_NUM_LOG2-1:0]);

    assign tdata_wr_enable[i] = (tdata1_dmode[i] ? dbg_mode : 1'b1);
    assign tdata1_wr_ena[i] = wr_tdata1_ena & tselect_sel[i] & tdata_wr_enable[i];
    assign tdata2_wr_ena[i] = wr_tdata2_ena & tselect_sel[i] & tdata_wr_enable[i];

    n22_gnrl_dfflr #(32) tdata2_dfflr (tdata2_wr_ena[i], wbck_csr_dat, tdata2[i], clk, rst_n);


    assign tdata1_type_ena[i] = tdata1_wr_ena[i];
    assign tdata1_type_nxt[i] =
                              (wbck_csr_dat[`N22_TDATA1_TYPE] == `N22_TDATA1_TYPE_W'd5) ? `N22_TDATA1_TYPE_W'd5 :
                              (wbck_csr_dat[`N22_TDATA1_TYPE] == `N22_TDATA1_TYPE_W'd4) ? `N22_TDATA1_TYPE_W'd4 :
                              (wbck_csr_dat[`N22_TDATA1_TYPE] == `N22_TDATA1_TYPE_W'd3) ? `N22_TDATA1_TYPE_W'd3 :
                                                                                          `N22_TDATA1_TYPE_W'd2 ;
    n22_gnrl_dfflr #(2) tdata1_type_3_2_dfflr (tdata1_type_ena[i], tdata1_type_nxt[i][3:2], tdata1_type[i][3:2], clk, rst_n);
    n22_gnrl_dfflrs#(1) tdata1_type_1_dfflrs  (tdata1_type_ena[i], tdata1_type_nxt[i][1]  , tdata1_type[i][1]  , clk, rst_n);
    n22_gnrl_dfflr #(1) tdata1_type_0_dfflr   (tdata1_type_ena[i], tdata1_type_nxt[i][0]  , tdata1_type[i][0]  , clk, rst_n);

    assign tdata1_type_nxt_2[i] = (tdata1_type_nxt[i] == `N22_TDATA1_TYPE_W'd2);
    assign tdata1_type_nxt_3[i] = (tdata1_type_nxt[i] == `N22_TDATA1_TYPE_W'd3);
    assign tdata1_type_nxt_4[i] = (tdata1_type_nxt[i] == `N22_TDATA1_TYPE_W'd4);
    assign tdata1_type_nxt_5[i] = (tdata1_type_nxt[i] == `N22_TDATA1_TYPE_W'd5);


    assign tdata1_type_2[i] = (tdata1_type[i] == `N22_TDATA1_TYPE_W'd2);
    assign tdata1_type_3[i] = (tdata1_type[i] == `N22_TDATA1_TYPE_W'd3);
    assign tdata1_type_4[i] = (tdata1_type[i] == `N22_TDATA1_TYPE_W'd4);
    assign tdata1_type_5[i] = (tdata1_type[i] == `N22_TDATA1_TYPE_W'd5);

    assign tdata1_dmode_ena[i] = tdata1_wr_ena[i] & dbg_mode;
    assign tdata1_dmode_nxt[i] = wbck_csr_dat[`N22_TDATA1_DMODE];
    n22_gnrl_dfflr #(`N22_TDATA1_DMODE_W) tdata1_dmode_dfflr (tdata1_dmode_ena[i], tdata1_dmode_nxt[i], tdata1_dmode[i], clk, rst_n);

    assign tdata1_data_ena[i] = tdata1_wr_ena[i];
    assign tdata1_data_nxt[i] = wbck_csr_dat[`N22_TDATA1_DATA] & (
        ({`N22_TDATA1_DATA_W{tdata1_type_nxt_2[i]}} & {6'd12,3'b0,
                                                             (
                                                                (wbck_csr_dat[17:12] == 6'd1) ? 6'd1 : 6'd0
                                                             ),
                                  `ifdef N22_DEBUG_TRIGM_CHAIN
                                                             wbck_csr_dat[11],
                                  `else
                                                             1'b0,
                                  `endif
                                                             (
                                                                (wbck_csr_dat[10:7] == 4'd0) ? 4'd0 :
                                                                (wbck_csr_dat[10:7] == 4'd1) ? 4'd1 : 4'd0
                                                             ),
                                                               wbck_csr_dat[6],2'b0,wbck_csr_dat[3:0]})
      | ({`N22_TDATA1_DATA_W{tdata1_type_nxt_3[i]}} & {16'b0,1'b1,wbck_csr_dat[9],2'b0,wbck_csr_dat[6],
                                                                ((wbck_csr_dat[5:0] == 6'd1) ? 6'd1 : 6'd0)
                                                       })
      | ({`N22_TDATA1_DATA_W{tdata1_type_nxt_4[i]}} & {17'b0,wbck_csr_dat[9],2'b0,wbck_csr_dat[6],
                                                                ((wbck_csr_dat[5:0] == 6'd1) ? 6'd1 : 6'd0)
                                                       })
      | ({`N22_TDATA1_DATA_W{tdata1_type_nxt_5[i]}} & {17'b0,wbck_csr_dat[9],2'b0,wbck_csr_dat[6],
                                                                ((wbck_csr_dat[5:0] == 6'd1) ? 6'd1 : 6'd0)
                                                       })
      );

    n22_gnrl_dfflr #(17) tdata1_data_26_10dfflr (tdata1_data_ena[i], tdata1_data_nxt[i][26:10], tdata1_data[i][26:10], clk, rst_n);
    n22_gnrl_dfflr #(6 ) tdata1_data_5_0_dfflr  (tdata1_data_ena[i], tdata1_data_nxt[i][5:0], tdata1_data[i][5:0], clk, rst_n);
    assign  tdata1_data_9_6_clr[i] =  tdata1_type_3[i] & icount_taken_ena;
    assign  tdata1_data_9_6_nxt[i] =  tdata1_data_9_6_clr[i] ? 4'b0 :  tdata1_data_nxt[i][9:6];
    assign  tdata1_data_9_6_ena[i] =  tdata1_data_ena[i] | tdata1_data_9_6_clr[i];
    n22_gnrl_dfflr #(4 ) tdata1_data_9_6_dfflr  (tdata1_data_9_6_ena[i], tdata1_data_9_6_nxt[i], tdata1_data[i][9:6], clk, rst_n);
    assign tdata1_data_pos[i] = (
        ({`N22_TDATA1_DATA_W{tdata1_type_2[i]}} & {6'd12,3'b0,
                                                      (tdata1_dmode[i] ? tdata1_data[i][17:12] : 6'b0),
                                                      tdata1_data[i][11:6],2'b0,
                                                  `ifdef N22_HAS_UMODE
                                                      tdata1_data[i][3],
                                                  `else
                                                       1'b0,
                                                  `endif
                                                      tdata1_data[i][2:0]
                                                      })
      | ({`N22_TDATA1_DATA_W{tdata1_type_3[i]}} & {16'b0,1'b1,tdata1_data[i][9],2'b0,
                                                  `ifdef N22_HAS_UMODE
                                                       tdata1_data[i][6],
                                                  `else
                                                       1'b0,
                                                  `endif
                                                      (tdata1_dmode[i] ? tdata1_data[i][5:0] : 6'b0)
                                                      })
      | ({`N22_TDATA1_DATA_W{tdata1_type_4[i]}} & {17'b0,tdata1_data[i][9],2'b0,
                                                  `ifdef N22_HAS_UMODE
                                                       tdata1_data[i][6],
                                                  `else
                                                       1'b0,
                                                  `endif
                                                      (tdata1_dmode[i] ? tdata1_data[i][5:0] : 6'b0)
                                                      })
      | ({`N22_TDATA1_DATA_W{tdata1_type_5[i]}} & {17'b0,tdata1_data[i][9],2'b0,
                                                  `ifdef N22_HAS_UMODE
                                                       tdata1_data[i][6],
                                                  `else
                                                       1'b0,
                                                  `endif
                                                      (tdata1_dmode[i] ? tdata1_data[i][5:0] : 6'b0)
                                                      })
      );

    assign tdata1[i][`N22_TDATA1_TYPE]  = tdata1_type[i];
    assign tdata1[i][`N22_TDATA1_DMODE] = tdata1_dmode[i];
    assign tdata1[i][`N22_TDATA1_DATA]  = tdata1_data_pos[i];

  end
  endgenerate

  wire [TRIGM_NUM_LOG2-1:0] tselect_idx = tselect_r[TRIGM_NUM_LOG2-1:0];

  assign tdata1_r = tdata1[tselect_idx];
  assign tdata2_r = tdata2[tselect_idx];

`endif

  wire dcause_ena = cmt_dcause_ena;
  wire [3-1:0] dcause_r;
  wire [3-1:0] dcause_nxt = cmt_dcause;
  n22_gnrl_dfflr #(3) dcause_dfflr (dcause_ena, dcause_nxt, dcause_r, clk, rst_n);
  wire step_ena = wr_dcsr_ena;
  wire step_nxt;
  wire step_r;
  assign step_nxt = wbck_csr_dat[2];
  n22_gnrl_dfflr #(1) step_dfflr (step_ena, step_nxt, step_r, clk, rst_n);

  wire mprven_ena = wr_dcsr_ena;
  wire mprven_nxt;
  wire mprven_r;
  assign mprven_nxt = wbck_csr_dat[4];
  n22_gnrl_dfflr #(1) mprven_dfflr (mprven_ena, mprven_nxt, mprven_r, clk, rst_n);

 `ifdef N22_HAS_UMODE
  wire prv_ena = cmt_dprv_ena | wr_dcsr_ena;
  wire [1:0] prv_nxt;
  wire [1:0] prv_r;
  assign prv_nxt = wr_dcsr_ena ? wbck_csr_dat[1:0] : cmt_dprv;
  n22_gnrl_dfflrs #(2) prv_dfflrs (prv_ena, prv_nxt, prv_r, clk, rst_n);
 `endif

 `ifndef N22_HAS_UMODE
  wire [1:0] prv_r = 2'b11;
 `endif

  wire stepie_ena = wr_dcsr_ena;
  wire stepie_nxt;
  wire stepie_r;
  assign stepie_nxt = wbck_csr_dat[11];
  n22_gnrl_dfflr #(1) stepie_dfflr (stepie_ena, stepie_nxt, stepie_r, clk, rst_n);

  wire ebreakm_ena = wr_dcsr_ena;
  wire ebreakm_nxt;
  wire ebreakm_r;
  assign ebreakm_nxt = wbck_csr_dat[15];
  n22_gnrl_dfflr #(1) ebreakm_dfflr (ebreakm_ena, ebreakm_nxt, ebreakm_r, clk, rst_n);
 `ifdef N22_HAS_UMODE
  wire ebreaku_ena = wr_dcsr_ena;
  wire ebreaku_nxt;
  wire ebreaku_r;
  assign ebreaku_nxt = wbck_csr_dat[12];
  n22_gnrl_dfflr #(1) ebreaku_dfflr (ebreaku_ena, ebreaku_nxt, ebreaku_r, clk, rst_n);
 `endif

 `ifndef N22_HAS_UMODE
  wire ebreaku_r = 1'b0;
 `endif

  wire stopcount_ena = wr_dcsr_ena;
  wire stopcount_nxt;
  wire stopcount_r;
  assign stopcount_nxt = wbck_csr_dat[10];
  n22_gnrl_dfflrs #(1) stopcount_dfflrs (stopcount_ena, stopcount_nxt, stopcount_r, clk, rst_n);
  wire stoptime_ena = wr_dcsr_ena;
  wire stoptime_nxt;
  wire stoptime_r;
  assign stoptime_nxt = wbck_csr_dat[9];
  n22_gnrl_dfflrs #(1) stoptime_dfflrs (stoptime_ena, stoptime_nxt, stoptime_r, clk, rst_n);

  assign dcsr_r [31:28] = 4'd4;
  assign dcsr_r [27:16]  = 12'b0;
  assign dcsr_r [15]  = ebreakm_r;
  assign dcsr_r [14:13]  = 2'b0;
  assign dcsr_r [12]  = ebreaku_r;
  assign dcsr_r [11]  = stepie_r;
  assign dcsr_r [10]    = stopcount_r;
  assign dcsr_r [9]     = stoptime_r;
  assign dcsr_r [8:6]   = dcause_r;
  assign dcsr_r [5]     = 1'b0;
  assign dcsr_r [4]   = mprven_r;
  assign dcsr_r [3]   = nmi_irq_r;
  assign dcsr_r [2]   = step_r;
  assign dcsr_r [1:0] = prv_r;

  wire dmode_ena = cmt_dcause_ena;
  wire dbg_mode_nxt;
  wire dbg_mode_r;
  assign dbg_mode_nxt = ~(dcause_nxt == 3'b0);
  n22_gnrl_dfflr #(1) dmode_dfflr (dmode_ena, dbg_mode_nxt, dbg_mode_r, clk, rst_n);
  assign dbg_mode = dbg_mode_r;

  assign dbg_dexc2dbg_r = csr_dexc2dbg;

  assign dbg_step_r = step_r;
  assign dbg_ebreakm_r = ebreakm_r;
  assign dbg_ebreaku_r = ebreaku_r;
  assign dbg_prv_r = prv_r;

  assign dbg_stepie = stepie_r;
  assign dbg_mprven  = mprven_r ;


  assign dbg_stopcount = stopcount_r;

  wire dbg_stoptime_ena;
  wire dbg_stoptime_nxt;
  assign dbg_stoptime_ena = dmode_ena | stoptime_ena;
  assign dbg_stoptime_nxt = (dmode_ena ? dbg_mode_nxt : dbg_mode)
                          & (stoptime_ena ? stoptime_nxt : stoptime_r)
			  ;
  n22_gnrl_dfflr #(1) dbg_stoptime_dfflr (dbg_stoptime_ena, dbg_stoptime_nxt, dbg_stoptime, clk, rst_n);

endmodule

`endif
