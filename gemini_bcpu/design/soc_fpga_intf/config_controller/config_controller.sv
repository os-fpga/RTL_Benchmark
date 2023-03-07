`include "config_controller.svh"
module config_controller (
    input  logic                   clk                       ,
    input  logic                   rst_n                     ,
    // APB
    input  logic [  CC_AWIDTH-1:0] apb_addr                  ,
    input  logic                   apb_sel                   ,
    input  logic                   apb_en                    ,
    input  logic                   apb_wr                    ,
    input  logic [  CC_DWIDTH-1:0] apb_wdata                 ,
    input  logic [CC_DWIDTH/8-1:0] apb_strb                  ,
    output logic [  CC_DWIDTH-1:0] apb_rdata                 ,
    output logic                   apb_ready                 ,
    output logic                   apb_err                   ,
    //fcb
    output logic                   fcb_clk_o  [FCB_CHAIN_NUM],
    output logic                   fcb_data_o [FCB_CHAIN_NUM],
    output logic                   fcb_cmd_o  [FCB_CHAIN_NUM],
    input  logic                   fcb_clk_i  [FCB_CHAIN_NUM],
    input  logic                   fcb_data_i [FCB_CHAIN_NUM],
    output logic                   fcb_rst_n                 ,
    //icb
    output logic                   icb_clk_o  [ICB_CHAIN_NUM],
    output logic                   icb_data_o [ICB_CHAIN_NUM],
    output logic                   icb_cmd_o  [ICB_CHAIN_NUM],
    input  logic                   icb_clk_i  [ICB_CHAIN_NUM],
    input  logic                   icb_data_i [ICB_CHAIN_NUM],
    output logic                   icb_rst_n                 ,
    //pcb
    output logic [           35:0] pl_data_o                 ,
    output logic [           31:0] pl_addr_o                 ,
    output logic                   pl_ena_o                  ,
    output logic                   pl_clk_o                  ,
    output logic                   pl_ren_o                  ,
    output logic                   pl_init_o                 ,
    output logic [            1:0] pl_wen_o                  ,
    input  logic [           35:0] pl_data_i                 ,
    //ccb
    // pll0 control
    output logic [           11:0] fpga_pll0_dskewcalin      ,
    output logic                   fpga_pll0_pllen           ,
    output logic                   fpga_pll0_dsmen           ,
    output logic                   fpga_pll0_dskewfastcal    ,
    output logic                   fpga_pll0_dskewcalen      ,
    output logic [            2:0] fpga_pll0_dskewcalcnt     ,
    output logic                   fpga_pll0_dskewcalbyp     ,
    output logic                   fpga_pll0_dacen           ,
    output logic [            5:0] fpga_pll0_refdiv          ,
    output logic                   fpga_pll0_foutvcoen       ,
    output logic [            4:0] fpga_pll0_foutvcobyp      ,
    output logic [            3:0] fpga_pll0_fouten          ,
    output logic [           23:0] fpga_pll0_frac            ,
    output logic [           11:0] fpga_pll0_fbdiv           ,
    output logic [            3:0] fpga_pll0_postdiv3        ,
    output logic [            3:0] fpga_pll0_postdiv2        ,
    output logic [            3:0] fpga_pll0_postdiv1        ,
    output logic [            3:0] fpga_pll0_postdiv0        ,
    // pll0 status
    input  logic                   fpga_pll0_lock            ,
    input  logic                   fpga_pll0_dskewcallock    ,
    input  logic [           11:0] fpga_pll0_dskewcalout     ,
    // pll1 control
    output logic [           11:0] fpga_pll1_dskewcalin      ,
    output logic                   fpga_pll1_pllen           ,
    output logic                   fpga_pll1_dsmen           ,
    output logic                   fpga_pll1_dskewfastcal    ,
    output logic                   fpga_pll1_dskewcalen      ,
    output logic [            2:0] fpga_pll1_dskewcalcnt     ,
    output logic                   fpga_pll1_dskewcalbyp     ,
    output logic                   fpga_pll1_dacen           ,
    output logic [            5:0] fpga_pll1_refdiv          ,
    output logic                   fpga_pll1_foutvcoen       ,
    output logic [            4:0] fpga_pll1_foutvcobyp      ,
    output logic [            3:0] fpga_pll1_fouten          ,
    output logic [           23:0] fpga_pll1_frac            ,
    output logic [           11:0] fpga_pll1_fbdiv           ,
    output logic [            3:0] fpga_pll1_postdiv3        ,
    output logic [            3:0] fpga_pll1_postdiv2        ,
    output logic [            3:0] fpga_pll1_postdiv1        ,
    output logic [            3:0] fpga_pll1_postdiv0        ,
    // pll1 status
    input  logic                   fpga_pll1_lock            ,
    input  logic                   fpga_pll1_dskewcallock    ,
    input  logic [           11:0] fpga_pll1_dskewcalout     ,
    // pll2 control
    output logic [           11:0] fpga_pll2_dskewcalin      ,
    output logic                   fpga_pll2_pllen           ,
    output logic                   fpga_pll2_dsmen           ,
    output logic                   fpga_pll2_dskewfastcal    ,
    output logic                   fpga_pll2_dskewcalen      ,
    output logic [            2:0] fpga_pll2_dskewcalcnt     ,
    output logic                   fpga_pll2_dskewcalbyp     ,
    output logic                   fpga_pll2_dacen           ,
    output logic [            5:0] fpga_pll2_refdiv          ,
    output logic                   fpga_pll2_foutvcoen       ,
    output logic [            4:0] fpga_pll2_foutvcobyp      ,
    output logic [            3:0] fpga_pll2_fouten          ,
    output logic [           23:0] fpga_pll2_frac            ,
    output logic [           11:0] fpga_pll2_fbdiv           ,
    output logic [            3:0] fpga_pll2_postdiv3        ,
    output logic [            3:0] fpga_pll2_postdiv2        ,
    output logic [            3:0] fpga_pll2_postdiv1        ,
    output logic [            3:0] fpga_pll2_postdiv0        ,
    // pll2 status
    input  logic                   fpga_pll2_lock            ,
    input  logic                   fpga_pll2_dskewcallock    ,
    input  logic [           11:0] fpga_pll2_dskewcalout     ,
    // pll3 control
    output logic [           11:0] fpga_pll3_dskewcalin      ,
    output logic                   fpga_pll3_pllen           ,
    output logic                   fpga_pll3_dsmen           ,
    output logic                   fpga_pll3_dskewfastcal    ,
    output logic                   fpga_pll3_dskewcalen      ,
    output logic [            2:0] fpga_pll3_dskewcalcnt     ,
    output logic                   fpga_pll3_dskewcalbyp     ,
    output logic                   fpga_pll3_dacen           ,
    output logic [            5:0] fpga_pll3_refdiv          ,
    output logic                   fpga_pll3_foutvcoen       ,
    output logic [            4:0] fpga_pll3_foutvcobyp      ,
    output logic [            3:0] fpga_pll3_fouten          ,
    output logic [           23:0] fpga_pll3_frac            ,
    output logic [           11:0] fpga_pll3_fbdiv           ,
    output logic [            3:0] fpga_pll3_postdiv3        ,
    output logic [            3:0] fpga_pll3_postdiv2        ,
    output logic [            3:0] fpga_pll3_postdiv1        ,
    output logic [            3:0] fpga_pll3_postdiv0        ,
    // pll3 status
    input  logic                   fpga_pll3_lock            ,
    input  logic                   fpga_pll3_dskewcallock    ,
    input  logic [           11:0] fpga_pll3_dskewcalout     ,
    // config status
    output logic                   cfg_done
);



logic                 apb_sel_mng  ;
logic [CC_DWIDTH-1:0] apb_rdata_mng;
logic                 apb_ready_mng;
logic                 apb_err_mng  ;
logic                 apb_sel_pcb  ;
logic [         31:0] apb_addr_pcb ;
logic [CC_DWIDTH-1:0] apb_rdata_pcb;
logic                 apb_ready_pcb;
logic                 apb_err_pcb  ;

assign apb_sel_mng  = apb_sel && (apb_addr < PCB_BASE_ADDR);

assign apb_sel_pcb  = apb_sel && (apb_addr >= PCB_BASE_ADDR);
assign apb_addr_pcb = {16'h0000, (apb_addr -  PCB_BASE_ADDR)};

assign apb_rdata = apb_sel_mng ? apb_rdata_mng : apb_rdata_pcb;
assign apb_ready = apb_sel_mng ? apb_ready_mng : apb_ready_pcb;
assign apb_err   = apb_sel_mng ? apb_err_mng : apb_err_pcb;

// apb manager for fcb,ccb,icb
logic                   rack    ;
logic                   rerr    ;
logic [  CC_DWIDTH-1:0] rdat    ;
logic [CC_REGS_NUM-1:0] rreq    ;
logic                   wack    ;
logic                   werr    ;
logic [  CC_DWIDTH-1:0] wdat    ;
logic [CC_REGS_NUM-1:0] wreq    ;
logic [CC_DWIDTH/8-1:0] wstr    ;
logic                   rack_ofe;
logic                   rerr_ofe;
logic                   wack_ofe;
logic                   werr_ofe;
logic                   rack_fcb;
logic                   rerr_fcb;
logic                   wack_fcb;
logic                   werr_fcb;
logic                   rack_icb;
logic                   rerr_icb;
logic                   wack_icb;
logic                   werr_icb;
logic                   rack_ccb;
logic                   rerr_ccb;
logic                   wack_ccb;
logic                   werr_ccb;
logic [  CC_DWIDTH-1:0] rdat_ofe;
logic [  CC_DWIDTH-1:0] rdat_fcb;
logic [  CC_DWIDTH-1:0] rdat_icb;
logic [  CC_DWIDTH-1:0] rdat_ccb;

assign rack = rack_fcb | rack_icb | rack_ccb | rack_ofe;
assign wack = wack_fcb | wack_icb | wack_ccb | wack_ofe;
assign rerr = rerr_fcb | rerr_icb | rerr_ccb | rerr_ofe;
assign werr = werr_fcb | werr_icb | werr_ccb | werr_ofe;

assign rdat = rack_ofe ? rdat_ofe :
              rack_fcb ? rdat_fcb :
              rack_icb ? rdat_icb :
              rack_ccb ? rdat_ccb : 32'h0;

          

    apb_manager #(
        .AWIDTH  (CC_AWIDTH  ),
        .REGS_NUM(CC_REGS_NUM),
        .DWIDTH  (CC_DWIDTH  ),
        .MAP     (CC_MAP     )
    ) inst_apb_manager (
        .clk      (clk          ),
        .rst_n    (rst_n        ),
        .apb_addr (apb_addr     ),
        .apb_sel  (apb_sel_mng  ),
        .apb_en   (apb_en       ),
        .apb_wr   (apb_wr       ),
        .apb_wdata(apb_wdata    ),
        .apb_strb (apb_strb     ),
        .apb_rdata(apb_rdata_mng),
        .apb_ready(apb_ready_mng),
        .apb_err  (apb_err_mng  ),
        .rack     (rack         ),
        .rerr     (rerr         ),
        .rdat     (rdat         ),
        .rreq     (rreq         ),
        .wack     (wack         ),
        .werr     (werr         ),
        .wdat     (wdat         ),
        .wreq     (wreq         ),
        .wstr     (wstr         )
    );

////////////////////////////////////////

logic fcb_cfg_status;
logic icb_cfg_status;
    ofe #(
        .REGS_NUM(OFE_REG_NUM),
        .DWIDTH  (CC_DWIDTH  )
    ) ofe_u (
        .clk        (clk                  ),
        .rst_n      (rst_n                ),
        .rack_o     (rack_ofe             ),
        .rerr_o     (rerr_ofe             ),
        .rdat_o     (rdat_ofe             ),
        .rreq_i     (rreq[OFE_REG_NUM-1:0]),
        .wack_o     (wack_ofe             ),
        .werr_o     (werr_ofe             ),
        .wdat_i     (wdat                 ),
        .wreq_i     (wreq[OFE_REG_NUM-1:0]),
        .wstr_i     (wstr                 ),
        .cfg_done   (cfg_done             ),
        .pll3_status(fpga_pll3_lock       ),
        .pll2_status(fpga_pll2_lock       ),
        .pll1_status(fpga_pll1_lock       ),
        .pll0_status(fpga_pll0_lock       ),
        .icb_status (icb_cfg_status       ),
        .fcb_status (fcb_cfg_status       )
    );


    cfg_top #(
        .REGS_NUM        (FCB_REG_NUM         ),
        .DWIDTH          (CC_DWIDTH           ),
        .CHAIN_NUM       (FCB_CHAIN_NUM       ),
        .CHAIN_LENGTH_NUM(FCB_CHAIN_LENGTH_NUM)
    ) fcb_u (
        .clk         (clk                          ),
        .rst_n       (rst_n                        ),
        .rack_o      (rack_fcb                     ),
        .rerr_o      (rerr_fcb                     ),
        .rdat_o      (rdat_fcb                     ),
        .rreq_i      (rreq[FCB_REG_NUM:OFE_REG_NUM]),
        .wack_o      (wack_fcb                     ),
        .werr_o      (werr_fcb                     ),
        .wdat_i      (wdat                         ),
        .wreq_i      (wreq[FCB_REG_NUM:OFE_REG_NUM]),
        .wstr_i      (wstr                         ),
        .ccff_clk_o  (fcb_clk_o                    ),
        .ccff_data_o (fcb_data_o                   ),
        .ccff_cmd_o  (fcb_cmd_o                    ),
        .ccff_clk_i  (fcb_clk_i                    ),
        .ccff_data_i (fcb_data_i                   ),
        .ccff_rst_n  (fcb_rst_n                    ),
        .cfg_status_o(fcb_cfg_status               )
    );

    cfg_top #(
        .REGS_NUM        (ICB_REG_NUM         ),
        .DWIDTH          (CC_DWIDTH           ),
        .CHAIN_NUM       (ICB_CHAIN_NUM       ),
        .CHAIN_LENGTH_NUM(ICB_CHAIN_LENGTH_NUM)
    ) icb_u (
        .clk         (clk                                                                                        ),
        .rst_n       (rst_n                                                                                      ),
        .rack_o      (rack_icb                                                                                   ),
        .rerr_o      (rerr_icb                                                                                   ),
        .rdat_o      (rdat_icb                                                                                   ),
        .rreq_i      (rreq[FCB_REG_NUM+CCB_REG_NUM+ICB_REG_NUM+OFE_REG_NUM-1:FCB_REG_NUM+CCB_REG_NUM+OFE_REG_NUM]),
        .wack_o      (wack_icb                                                                                   ),
        .werr_o      (werr_icb                                                                                   ),
        .wdat_i      (wdat                                                                                       ),
        .wreq_i      (wreq[FCB_REG_NUM+CCB_REG_NUM+ICB_REG_NUM+OFE_REG_NUM-1:FCB_REG_NUM+CCB_REG_NUM+OFE_REG_NUM]),
        .wstr_i      (wstr                                                                                       ),
        .ccff_clk_o  (icb_clk_o                                                                                  ),
        .ccff_data_o (icb_data_o                                                                                 ),
        .ccff_cmd_o  (icb_cmd_o                                                                                  ),
        .ccff_clk_i  (icb_clk_i                                                                                  ),
        .ccff_data_i (icb_data_i                                                                                 ),
        .ccff_rst_n  (icb_rst_n                                                                                  ),
        .cfg_status_o(icb_cfg_status                                                                             )
    );

    ccb #(
        .REGS_NUM(CCB_REG_NUM),
        .DWIDTH  (CC_DWIDTH  )
    ) ccb_u (
        .clk                   (clk                                                                ),
        .rst_n                 (rst_n                                                              ),
        .rack_o                (rack_ccb                                                           ),
        .rerr_o                (rerr_ccb                                                           ),
        .rdat_o                (rdat_ccb                                                           ),
        .rreq_i                (rreq[FCB_REG_NUM+CCB_REG_NUM+OFE_REG_NUM-1:FCB_REG_NUM+OFE_REG_NUM]),
        .wack_o                (wack_ccb                                                           ),
        .werr_o                (werr_ccb                                                           ),
        .wdat_i                (wdat                                                               ),
        .wreq_i                (wreq[FCB_REG_NUM+CCB_REG_NUM+OFE_REG_NUM-1:FCB_REG_NUM+OFE_REG_NUM]),
        .wstr_i                (wstr                                                               ),
        .fpga_pll0_dskewcalin  (fpga_pll0_dskewcalin                                               ),
        .fpga_pll0_pllen       (fpga_pll0_pllen                                                    ),
        .fpga_pll0_dsmen       (fpga_pll0_dsmen                                                    ),
        .fpga_pll0_dskewfastcal(fpga_pll0_dskewfastcal                                             ),
        .fpga_pll0_dskewcalen  (fpga_pll0_dskewcalen                                               ),
        .fpga_pll0_dskewcalcnt (fpga_pll0_dskewcalcnt                                              ),
        .fpga_pll0_dskewcalbyp (fpga_pll0_dskewcalbyp                                              ),
        .fpga_pll0_dacen       (fpga_pll0_dacen                                                    ),
        .fpga_pll0_refdiv      (fpga_pll0_refdiv                                                   ),
        .fpga_pll0_foutvcoen   (fpga_pll0_foutvcoen                                                ),
        .fpga_pll0_foutvcobyp  (fpga_pll0_foutvcobyp                                               ),
        .fpga_pll0_fouten      (fpga_pll0_fouten                                                   ),
        .fpga_pll0_frac        (fpga_pll0_frac                                                     ),
        .fpga_pll0_fbdiv       (fpga_pll0_fbdiv                                                    ),
        .fpga_pll0_postdiv3    (fpga_pll0_postdiv3                                                 ),
        .fpga_pll0_postdiv2    (fpga_pll0_postdiv2                                                 ),
        .fpga_pll0_postdiv1    (fpga_pll0_postdiv1                                                 ),
        .fpga_pll0_postdiv0    (fpga_pll0_postdiv0                                                 ),
        .fpga_pll0_lock        (fpga_pll0_lock                                                     ),
        .fpga_pll0_dskewcallock(fpga_pll0_dskewcallock                                             ),
        .fpga_pll0_dskewcalout (fpga_pll0_dskewcalout                                              ),
        .fpga_pll1_dskewcalin  (fpga_pll1_dskewcalin                                               ),
        .fpga_pll1_pllen       (fpga_pll1_pllen                                                    ),
        .fpga_pll1_dsmen       (fpga_pll1_dsmen                                                    ),
        .fpga_pll1_dskewfastcal(fpga_pll1_dskewfastcal                                             ),
        .fpga_pll1_dskewcalen  (fpga_pll1_dskewcalen                                               ),
        .fpga_pll1_dskewcalcnt (fpga_pll1_dskewcalcnt                                              ),
        .fpga_pll1_dskewcalbyp (fpga_pll1_dskewcalbyp                                              ),
        .fpga_pll1_dacen       (fpga_pll1_dacen                                                    ),
        .fpga_pll1_refdiv      (fpga_pll1_refdiv                                                   ),
        .fpga_pll1_foutvcoen   (fpga_pll1_foutvcoen                                                ),
        .fpga_pll1_foutvcobyp  (fpga_pll1_foutvcobyp                                               ),
        .fpga_pll1_fouten      (fpga_pll1_fouten                                                   ),
        .fpga_pll1_frac        (fpga_pll1_frac                                                     ),
        .fpga_pll1_fbdiv       (fpga_pll1_fbdiv                                                    ),
        .fpga_pll1_postdiv3    (fpga_pll1_postdiv3                                                 ),
        .fpga_pll1_postdiv2    (fpga_pll1_postdiv2                                                 ),
        .fpga_pll1_postdiv1    (fpga_pll1_postdiv1                                                 ),
        .fpga_pll1_postdiv0    (fpga_pll1_postdiv0                                                 ),
        .fpga_pll1_lock        (fpga_pll1_lock                                                     ),
        .fpga_pll1_dskewcallock(fpga_pll1_dskewcallock                                             ),
        .fpga_pll1_dskewcalout (fpga_pll1_dskewcalout                                              ),
        .fpga_pll2_dskewcalin  (fpga_pll2_dskewcalin                                               ),
        .fpga_pll2_pllen       (fpga_pll2_pllen                                                    ),
        .fpga_pll2_dsmen       (fpga_pll2_dsmen                                                    ),
        .fpga_pll2_dskewfastcal(fpga_pll2_dskewfastcal                                             ),
        .fpga_pll2_dskewcalen  (fpga_pll2_dskewcalen                                               ),
        .fpga_pll2_dskewcalcnt (fpga_pll2_dskewcalcnt                                              ),
        .fpga_pll2_dskewcalbyp (fpga_pll2_dskewcalbyp                                              ),
        .fpga_pll2_dacen       (fpga_pll2_dacen                                                    ),
        .fpga_pll2_refdiv      (fpga_pll2_refdiv                                                   ),
        .fpga_pll2_foutvcoen   (fpga_pll2_foutvcoen                                                ),
        .fpga_pll2_foutvcobyp  (fpga_pll2_foutvcobyp                                               ),
        .fpga_pll2_fouten      (fpga_pll2_fouten                                                   ),
        .fpga_pll2_frac        (fpga_pll2_frac                                                     ),
        .fpga_pll2_fbdiv       (fpga_pll2_fbdiv                                                    ),
        .fpga_pll2_postdiv3    (fpga_pll2_postdiv3                                                 ),
        .fpga_pll2_postdiv2    (fpga_pll2_postdiv2                                                 ),
        .fpga_pll2_postdiv1    (fpga_pll2_postdiv1                                                 ),
        .fpga_pll2_postdiv0    (fpga_pll2_postdiv0                                                 ),
        .fpga_pll2_lock        (fpga_pll2_lock                                                     ),
        .fpga_pll2_dskewcallock(fpga_pll2_dskewcallock                                             ),
        .fpga_pll2_dskewcalout (fpga_pll2_dskewcalout                                              ),
        .fpga_pll3_dskewcalin  (fpga_pll3_dskewcalin                                               ),
        .fpga_pll3_pllen       (fpga_pll3_pllen                                                    ),
        .fpga_pll3_dsmen       (fpga_pll3_dsmen                                                    ),
        .fpga_pll3_dskewfastcal(fpga_pll3_dskewfastcal                                             ),
        .fpga_pll3_dskewcalen  (fpga_pll3_dskewcalen                                               ),
        .fpga_pll3_dskewcalcnt (fpga_pll3_dskewcalcnt                                              ),
        .fpga_pll3_dskewcalbyp (fpga_pll3_dskewcalbyp                                              ),
        .fpga_pll3_dacen       (fpga_pll3_dacen                                                    ),
        .fpga_pll3_refdiv      (fpga_pll3_refdiv                                                   ),
        .fpga_pll3_foutvcoen   (fpga_pll3_foutvcoen                                                ),
        .fpga_pll3_foutvcobyp  (fpga_pll3_foutvcobyp                                               ),
        .fpga_pll3_fouten      (fpga_pll3_fouten                                                   ),
        .fpga_pll3_frac        (fpga_pll3_frac                                                     ),
        .fpga_pll3_fbdiv       (fpga_pll3_fbdiv                                                    ),
        .fpga_pll3_postdiv3    (fpga_pll3_postdiv3                                                 ),
        .fpga_pll3_postdiv2    (fpga_pll3_postdiv2                                                 ),
        .fpga_pll3_postdiv1    (fpga_pll3_postdiv1                                                 ),
        .fpga_pll3_postdiv0    (fpga_pll3_postdiv0                                                 ),
        .fpga_pll3_lock        (fpga_pll3_lock                                                     ),
        .fpga_pll3_dskewcallock(fpga_pll3_dskewcallock                                             ),
        .fpga_pll3_dskewcalout (fpga_pll3_dskewcalout                                              )
    );


parameter ROWS     = 10'h2;
parameter COLUMNS  = 10'h2;
parameter R_OFFSET = 10'd1;
parameter C_OFFSET = 10'd2;
parameter R_STRIDE = 10'd3;
parameter C_STRIDE = 10'd2;

logic [66:0] apbs_csr_wdata                ;
logic        plc_apbs_fmask_win_calibration;
assign apbs_csr_wdata = { //total 67
    apb_sel_pcb,        // 1
    apb_wr,      // 1
    apb_en,     // 1
    apb_addr_pcb[31:0], //32
    apb_wdata[31:0] //32
};    

assign apb_err_pcb = 1'b0;

always@(*) begin 
  if (plc_apbs_fmask_win_calibration)
   apb_ready_pcb = 1'b0;
  else if (~apb_en)
   apb_ready_pcb = 1'b0;
  else 
   apb_ready_pcb = 1'b1;
end

FCB_PLC #(
    .ROWS    (ROWS    ),
    .COLUMNS (COLUMNS ),
    .R_OFFSET(R_OFFSET),
    .C_OFFSET(C_OFFSET),
    .R_STRIDE(R_STRIDE),
    .C_STRIDE(C_STRIDE)
) pcb_u (
    .PLC_APBS_fmask_win_calibration(plc_apbs_fmask_win_calibration),
    .PLC_APBS_prdata               (apb_rdata_pcb[31:0]           ), // Templated
    .PL_DATA_OUT                   (pl_data_o[35:0]               ), // Templated
    .PL_ADDR_OUT                   (pl_addr_o[31:0]               ), // Templated
    .PL_ENA                        (pl_ena_o                      ), // Templated
    .PL_CLK                        (pl_clk_o                      ), // Templated
    .PL_REN                        (pl_ren_o                      ), // Templated
    .PL_WEN                        (pl_wen_o[1:0]                 ), // Templated
    .PL_INIT                       (pl_init_o                     ),
    // Inputs
    .FCB_CLK                       (clk                           ), // Templated
    .fcb_reg_rstn                  (fcb_rst_n                     ), // Templated
    .APBS_CSR_wdata                (apbs_csr_wdata[66:0]          ), // Templated
    .PL_DATA_IN                    (pl_data_i[35:0]               )
);     

endmodule