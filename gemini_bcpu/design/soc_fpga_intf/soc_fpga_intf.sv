module soc_fpga_intf #(
    parameter FCB_CHAIN_NUM = 128,
    parameter ICB_CHAIN_NUM = 1  ,
    parameter AWIDTH        = 32 ,
    parameter DWIDTH        = 32
) (
    // FCB/PCB clock / reset
    input  logic                clk_apb_ug                ,
    input  logic                rst_n_per                 ,
    // FCB/PCB APB
    input  logic [  AWIDTH-1:0] fcb_s0_paddr              ,
    input  logic                fcb_s0_psel               ,
    input  logic                fcb_s0_penable            ,
    input  logic                fcb_s0_pwrite             ,
    input  logic [DWIDTH/8-1:0] fcb_s0_pwbe               ,
    input  logic [  DWIDTH-1:0] fcb_s0_pwdata             ,
    output logic [  DWIDTH-1:0] fcb_s0_prdata             ,
    output logic                fcb_s0_pready             ,
    output logic                fcb_s0_pslverr            ,
    // FPGA fabric clocks
    input  logic                clk_fpga_fabric_m0        ,
    input  logic                clk_fpga_fabric_m1        ,
    input  logic                clk_fpga_fabric_s0        ,
    input  logic                clk_fpga_fabric_fcb_pcb   ,
    input  logic                clk_fpga_fabric_irq       ,
    input  logic                clk_fpga_fabric_dma       ,
    input  logic                clk_fpga_fabric_ace       ,
    input  logic                rst_n_fpga_fabric_m0      ,
    input  logic                rst_n_fpga_fabric_m1      ,
    input  logic                rst_n_fpga_fabric_s0      ,
    input  logic                rst_n_fpga_fabric_fcb_pcb ,
    input  logic                rst_n_fpga_fabric_irq     ,
    input  logic                rst_n_fpga_fabric_dma     ,
    input  logic                rst_n_fpga_fabric_ace     ,
    // SoC clocks
    input  logic                clk_acpu                  ,
    input  logic                rst_n_fpga_soc_m0         ,
    input  logic                rst_n_fpga_soc_m1         ,
    input  logic                rst_n_fpga_soc_s0         ,
    input  logic                rst_n_acpu                ,
    //////////////////////////////////////////////
    // interface signals to FPGA fabric
    //////////////////////////////////////////////
    // FPGA, IOB, PLL's Configuration intf
    //fcb
    output logic                fcb_clk_o  [FCB_CHAIN_NUM],
    output logic                fcb_data_o [FCB_CHAIN_NUM],
    output logic                fcb_cmd_o  [FCB_CHAIN_NUM],
    input  logic                fcb_clk_i  [FCB_CHAIN_NUM],
    input  logic                fcb_data_i [FCB_CHAIN_NUM],
    output logic                fcb_rst_n                 ,
    //icb
    output logic                icb_clk_o  [ICB_CHAIN_NUM],
    output logic                icb_data_o [ICB_CHAIN_NUM],
    output logic                icb_cmd_o  [ICB_CHAIN_NUM],
    input  logic                icb_clk_i  [ICB_CHAIN_NUM],
    input  logic                icb_data_i [ICB_CHAIN_NUM],
    output logic                icb_rst_n                 ,
    //pcb
    output logic [        35:0] pl_data_o                 ,
    output logic [        31:0] pl_addr_o                 ,
    output logic                pl_ena_o                  ,
    output logic                pl_clk_o                  ,
    output logic                pl_ren_o                  ,
    output logic                pl_init_o                 ,
    output logic [         1:0] pl_wen_o                  ,
    input  logic [        35:0] pl_data_i                 ,
    //ccb
    // pll0 control
    output logic [        11:0] fpga_pll0_dskewcalin      ,
    output logic                fpga_pll0_pllen           ,
    output logic                fpga_pll0_dsmen           ,
    output logic                fpga_pll0_dskewfastcal    ,
    output logic                fpga_pll0_dskewcalen      ,
    output logic [         2:0] fpga_pll0_dskewcalcnt     ,
    output logic                fpga_pll0_dskewcalbyp     ,
    output logic                fpga_pll0_dacen           ,
    output logic [         5:0] fpga_pll0_refdiv          ,
    output logic                fpga_pll0_foutvcoen       ,
    output logic [         4:0] fpga_pll0_foutvcobyp      ,
    output logic [         3:0] fpga_pll0_fouten          ,
    output logic [        23:0] fpga_pll0_frac            ,
    output logic [        11:0] fpga_pll0_fbdiv           ,
    output logic [         3:0] fpga_pll0_postdiv3        ,
    output logic [         3:0] fpga_pll0_postdiv2        ,
    output logic [         3:0] fpga_pll0_postdiv1        ,
    output logic [         3:0] fpga_pll0_postdiv0        ,
    // pll0 status
    input  logic                fpga_pll0_lock            ,
    input  logic                fpga_pll0_dskewcallock    ,
    input  logic [        11:0] fpga_pll0_dskewcalout     ,
    // pll1 control
    output logic [        11:0] fpga_pll1_dskewcalin      ,
    output logic                fpga_pll1_pllen           ,
    output logic                fpga_pll1_dsmen           ,
    output logic                fpga_pll1_dskewfastcal    ,
    output logic                fpga_pll1_dskewcalen      ,
    output logic [         2:0] fpga_pll1_dskewcalcnt     ,
    output logic                fpga_pll1_dskewcalbyp     ,
    output logic                fpga_pll1_dacen           ,
    output logic [         5:0] fpga_pll1_refdiv          ,
    output logic                fpga_pll1_foutvcoen       ,
    output logic [         4:0] fpga_pll1_foutvcobyp      ,
    output logic [         3:0] fpga_pll1_fouten          ,
    output logic [        23:0] fpga_pll1_frac            ,
    output logic [        11:0] fpga_pll1_fbdiv           ,
    output logic [         3:0] fpga_pll1_postdiv3        ,
    output logic [         3:0] fpga_pll1_postdiv2        ,
    output logic [         3:0] fpga_pll1_postdiv1        ,
    output logic [         3:0] fpga_pll1_postdiv0        ,
    // pll1 status
    input  logic                fpga_pll1_lock            ,
    input  logic                fpga_pll1_dskewcallock    ,
    input  logic [        11:0] fpga_pll1_dskewcalout     ,
    // pll2 control
    output logic [        11:0] fpga_pll2_dskewcalin      ,
    output logic                fpga_pll2_pllen           ,
    output logic                fpga_pll2_dsmen           ,
    output logic                fpga_pll2_dskewfastcal    ,
    output logic                fpga_pll2_dskewcalen      ,
    output logic [         2:0] fpga_pll2_dskewcalcnt     ,
    output logic                fpga_pll2_dskewcalbyp     ,
    output logic                fpga_pll2_dacen           ,
    output logic [         5:0] fpga_pll2_refdiv          ,
    output logic                fpga_pll2_foutvcoen       ,
    output logic [         4:0] fpga_pll2_foutvcobyp      ,
    output logic [         3:0] fpga_pll2_fouten          ,
    output logic [        23:0] fpga_pll2_frac            ,
    output logic [        11:0] fpga_pll2_fbdiv           ,
    output logic [         3:0] fpga_pll2_postdiv3        ,
    output logic [         3:0] fpga_pll2_postdiv2        ,
    output logic [         3:0] fpga_pll2_postdiv1        ,
    output logic [         3:0] fpga_pll2_postdiv0        ,
    // pll2 status
    input  logic                fpga_pll2_lock            ,
    input  logic                fpga_pll2_dskewcallock    ,
    input  logic [        11:0] fpga_pll2_dskewcalout     ,
    // pll3 control
    output logic [        11:0] fpga_pll3_dskewcalin      ,
    output logic                fpga_pll3_pllen           ,
    output logic                fpga_pll3_dsmen           ,
    output logic                fpga_pll3_dskewfastcal    ,
    output logic                fpga_pll3_dskewcalen      ,
    output logic [         2:0] fpga_pll3_dskewcalcnt     ,
    output logic                fpga_pll3_dskewcalbyp     ,
    output logic                fpga_pll3_dacen           ,
    output logic [         5:0] fpga_pll3_refdiv          ,
    output logic                fpga_pll3_foutvcoen       ,
    output logic [         4:0] fpga_pll3_foutvcobyp      ,
    output logic [         3:0] fpga_pll3_fouten          ,
    output logic [        23:0] fpga_pll3_frac            ,
    output logic [        11:0] fpga_pll3_fbdiv           ,
    output logic [         3:0] fpga_pll3_postdiv3        ,
    output logic [         3:0] fpga_pll3_postdiv2        ,
    output logic [         3:0] fpga_pll3_postdiv1        ,
    output logic [         3:0] fpga_pll3_postdiv0        ,
    // pll3 status
    input  logic                fpga_pll3_lock            ,
    input  logic                fpga_pll3_dskewcallock    ,
    input  logic [        11:0] fpga_pll3_dskewcalout     ,
    //config controller status
    output logic                cfg_done                  ,
    //AHB slave
    output logic [        31:0] fpga_clk_ahb_s0_haddr     ,
    output logic [         2:0] fpga_clk_ahb_s0_hburst    ,
    output logic                fpga_clk_ahb_s0_hmastlock ,
    input logic                 fpga_clk_ahb_s0_hready    ,
    output logic [         3:0] fpga_clk_ahb_s0_hprot     ,
    input  logic [        31:0] fpga_clk_ahb_s0_hrdata    ,
    input  logic                fpga_clk_ahb_s0_hresp     ,
    output logic                fpga_clk_ahb_s0_hsel      ,
    output logic [         2:0] fpga_clk_ahb_s0_hsize     ,
    output logic [         1:0] fpga_clk_ahb_s0_htrans    ,
    output logic [         3:0] fpga_clk_ahb_s0_hwbe      ,
    output logic [        31:0] fpga_clk_ahb_s0_hwdata    ,
    output logic                fpga_clk_ahb_s0_hwrite    ,
    // AXI master 0
    input  logic [        31:0] fpga_clk_axi_m0_ar_addr   ,
    input  logic [         1:0] fpga_clk_axi_m0_ar_burst  ,
    input  logic [         3:0] fpga_clk_axi_m0_ar_cache  ,
    input  logic [         3:0] fpga_clk_axi_m0_ar_id     ,
    input  logic [         2:0] fpga_clk_axi_m0_ar_len    ,
    input  logic                fpga_clk_axi_m0_ar_lock   ,
    input  logic [         2:0] fpga_clk_axi_m0_ar_prot   ,
    output logic                fpga_clk_axi_m0_ar_ready  ,
    input  logic [         2:0] fpga_clk_axi_m0_ar_size   ,
    input  logic                fpga_clk_axi_m0_ar_valid  ,
    input  logic [        31:0] fpga_clk_axi_m0_aw_addr   ,
    input  logic [         1:0] fpga_clk_axi_m0_aw_burst  ,
    input  logic [         3:0] fpga_clk_axi_m0_aw_cache  ,
    input  logic [         3:0] fpga_clk_axi_m0_aw_id     ,
    input  logic [         2:0] fpga_clk_axi_m0_aw_len    ,
    input  logic                fpga_clk_axi_m0_aw_lock   ,
    input  logic [         2:0] fpga_clk_axi_m0_aw_prot   ,
    output logic                fpga_clk_axi_m0_aw_ready  ,
    input  logic [         2:0] fpga_clk_axi_m0_aw_size   ,
    input  logic                fpga_clk_axi_m0_aw_valid  ,
    output logic [         3:0] fpga_clk_axi_m0_b_id      ,
    input  logic                fpga_clk_axi_m0_b_ready   ,
    output logic [         1:0] fpga_clk_axi_m0_b_resp    ,
    output logic                fpga_clk_axi_m0_b_valid   ,
    output logic [        63:0] fpga_clk_axi_m0_r_data    ,
    output logic [         3:0] fpga_clk_axi_m0_r_id      ,
    output logic                fpga_clk_axi_m0_r_last    ,
    input  logic                fpga_clk_axi_m0_r_ready   ,
    output logic [         1:0] fpga_clk_axi_m0_r_resp    ,
    output logic                fpga_clk_axi_m0_r_valid   ,
    input  logic [        63:0] fpga_clk_axi_m0_w_data    ,
    input  logic                fpga_clk_axi_m0_w_last    ,
    output logic                fpga_clk_axi_m0_w_ready   ,
    input  logic [         7:0] fpga_clk_axi_m0_w_strb    ,
    input  logic                fpga_clk_axi_m0_w_valid   ,
    //AXI master 1
    input  logic [        31:0] fpga_clk_axi_m1_ar_addr   ,
    input  logic [         1:0] fpga_clk_axi_m1_ar_burst  ,
    input  logic [         3:0] fpga_clk_axi_m1_ar_cache  ,
    input  logic [         3:0] fpga_clk_axi_m1_ar_id     ,
    input  logic [         3:0] fpga_clk_axi_m1_ar_len    ,
    input  logic                fpga_clk_axi_m1_ar_lock   ,
    input  logic [         2:0] fpga_clk_axi_m1_ar_prot   ,
    output logic                fpga_clk_axi_m1_ar_ready  ,
    input  logic [         2:0] fpga_clk_axi_m1_ar_size   ,
    input  logic                fpga_clk_axi_m1_ar_valid  ,
    input  logic [        31:0] fpga_clk_axi_m1_aw_addr   ,
    input  logic [         1:0] fpga_clk_axi_m1_aw_burst  ,
    input  logic [         3:0] fpga_clk_axi_m1_aw_cache  ,
    input  logic [         3:0] fpga_clk_axi_m1_aw_id     ,
    input  logic [         3:0] fpga_clk_axi_m1_aw_len    ,
    input  logic                fpga_clk_axi_m1_aw_lock   ,
    input  logic [         2:0] fpga_clk_axi_m1_aw_prot   ,
    output logic                fpga_clk_axi_m1_aw_ready  ,
    input  logic [         2:0] fpga_clk_axi_m1_aw_size   ,
    input  logic                fpga_clk_axi_m1_aw_valid  ,
    output logic [         3:0] fpga_clk_axi_m1_b_id      ,
    input  logic                fpga_clk_axi_m1_b_ready   ,
    output logic [         1:0] fpga_clk_axi_m1_b_resp    ,
    output logic                fpga_clk_axi_m1_b_valid   ,
    output logic [        31:0] fpga_clk_axi_m1_r_data    ,
    output logic [         3:0] fpga_clk_axi_m1_r_id      ,
    output logic                fpga_clk_axi_m1_r_last    ,
    input  logic                fpga_clk_axi_m1_r_ready   ,
    output logic [         1:0] fpga_clk_axi_m1_r_resp    ,
    output logic                fpga_clk_axi_m1_r_valid   ,
    input  logic [        31:0] fpga_clk_axi_m1_w_data    ,
    input  logic                fpga_clk_axi_m1_w_last    ,
    output logic                fpga_clk_axi_m1_w_ready   ,
    input  logic [         3:0] fpga_clk_axi_m1_w_strb    ,
    input  logic                fpga_clk_axi_m1_w_valid   ,
    // FPGA IRQ
    input  logic [        15:0] fpga_clk_irq_src          ,
    output logic [        12:0] fpga_clk_irq_set          ,
    // FPGA DMA
    input  logic [         3:0] fpga_clk_dma_req          ,
    output logic [         3:0] fpga_clk_dma_ack          ,
    // ACE
    output logic                fpga_ace_vstart           ,
    output logic                fpga_ace_istart           ,
    output logic                fpga_ace_divalid          ,
    output logic                fpga_ace_doready          ,
    output logic [        31:0] fpga_ace_dinop            ,
    input  logic                fpga_ace_dovalid          ,
    input  logic                fpga_ace_vbreak           ,
    input  logic                fpga_ace_diready          ,
    input  logic [        31:0] fpga_ace_doutop           ,
    //////////////////////////////////////////////
    // interface signals to SoC
    //////////////////////////////////////////////
    //AHB slave
    input  logic [        31:0] soc_clk_ahb_s0_haddr      ,
    input  logic [         2:0] soc_clk_ahb_s0_hburst     ,
    input  logic                soc_clk_ahb_s0_hmastlock  ,
    input  logic [         3:0] soc_clk_ahb_s0_hprot      ,
    output logic [        31:0] soc_clk_ahb_s0_hrdata     ,
    output logic                soc_clk_ahb_s0_hready     ,
    output logic                soc_clk_ahb_s0_hresp      ,
    input  logic                soc_clk_ahb_s0_hsel       ,
    input  logic [         2:0] soc_clk_ahb_s0_hsize      ,
    input  logic [         1:0] soc_clk_ahb_s0_htrans     ,
    input  logic [         3:0] soc_clk_ahb_s0_hwbe       ,
    input  logic [        31:0] soc_clk_ahb_s0_hwdata     ,
    input  logic                soc_clk_ahb_s0_hwrite     ,
    // AXI master 0
    output logic [        31:0] soc_clk_axi_m0_ar_addr    ,
    output logic [         1:0] soc_clk_axi_m0_ar_burst   ,
    output logic [         3:0] soc_clk_axi_m0_ar_cache   ,
    output logic [         3:0] soc_clk_axi_m0_ar_id      ,
    output logic [         2:0] soc_clk_axi_m0_ar_len     ,
    output logic                soc_clk_axi_m0_ar_lock    ,
    output logic [         2:0] soc_clk_axi_m0_ar_prot    ,
    input  logic                soc_clk_axi_m0_ar_ready   ,
    output logic [         2:0] soc_clk_axi_m0_ar_size    ,
    output logic                soc_clk_axi_m0_ar_valid   ,
    output logic [        31:0] soc_clk_axi_m0_aw_addr    ,
    output logic [         1:0] soc_clk_axi_m0_aw_burst   ,
    output logic [         3:0] soc_clk_axi_m0_aw_cache   ,
    output logic [         3:0] soc_clk_axi_m0_aw_id      ,
    output logic [         2:0] soc_clk_axi_m0_aw_len     ,
    output logic                soc_clk_axi_m0_aw_lock    ,
    output logic [         2:0] soc_clk_axi_m0_aw_prot    ,
    input  logic                soc_clk_axi_m0_aw_ready   ,
    output logic [         2:0] soc_clk_axi_m0_aw_size    ,
    output logic                soc_clk_axi_m0_aw_valid   ,
    input  logic [         3:0] soc_clk_axi_m0_b_id       ,
    output logic                soc_clk_axi_m0_b_ready    ,
    input  logic [         1:0] soc_clk_axi_m0_b_resp     ,
    input  logic                soc_clk_axi_m0_b_valid    ,
    input  logic [        63:0] soc_clk_axi_m0_r_data     ,
    input  logic [         3:0] soc_clk_axi_m0_r_id       ,
    input  logic                soc_clk_axi_m0_r_last     ,
    output logic                soc_clk_axi_m0_r_ready    ,
    input  logic [         1:0] soc_clk_axi_m0_r_resp     ,
    input  logic                soc_clk_axi_m0_r_valid    ,
    output logic [        63:0] soc_clk_axi_m0_w_data     ,
    output logic                soc_clk_axi_m0_w_last     ,
    input  logic                soc_clk_axi_m0_w_ready    ,
    output logic [         7:0] soc_clk_axi_m0_w_strb     ,
    output logic                soc_clk_axi_m0_w_valid    ,
    //AXI master 1
    output logic [        31:0] soc_clk_axi_m1_ar_addr    ,
    output logic [         1:0] soc_clk_axi_m1_ar_burst   ,
    output logic [         3:0] soc_clk_axi_m1_ar_cache   ,
    output logic [         3:0] soc_clk_axi_m1_ar_id      ,
    output logic [         3:0] soc_clk_axi_m1_ar_len     ,
    output logic                soc_clk_axi_m1_ar_lock    ,
    output logic [         2:0] soc_clk_axi_m1_ar_prot    ,
    input  logic                soc_clk_axi_m1_ar_ready   ,
    output logic [         2:0] soc_clk_axi_m1_ar_size    ,
    output logic                soc_clk_axi_m1_ar_valid   ,
    output logic [        31:0] soc_clk_axi_m1_aw_addr    ,
    output logic [         1:0] soc_clk_axi_m1_aw_burst   ,
    output logic [         3:0] soc_clk_axi_m1_aw_cache   ,
    output logic [         3:0] soc_clk_axi_m1_aw_id      ,
    output logic [         3:0] soc_clk_axi_m1_aw_len     ,
    output logic                soc_clk_axi_m1_aw_lock    ,
    output logic [         2:0] soc_clk_axi_m1_aw_prot    ,
    input  logic                soc_clk_axi_m1_aw_ready   ,
    output logic [         2:0] soc_clk_axi_m1_aw_size    ,
    output logic                soc_clk_axi_m1_aw_valid   ,
    input  logic [         3:0] soc_clk_axi_m1_b_id       ,
    output logic                soc_clk_axi_m1_b_ready    ,
    input  logic [         1:0] soc_clk_axi_m1_b_resp     ,
    input  logic                soc_clk_axi_m1_b_valid    ,
    input  logic [        31:0] soc_clk_axi_m1_r_data     ,
    input  logic [         3:0] soc_clk_axi_m1_r_id       ,
    input  logic                soc_clk_axi_m1_r_last     ,
    output logic                soc_clk_axi_m1_r_ready    ,
    input  logic [         1:0] soc_clk_axi_m1_r_resp     ,
    input  logic                soc_clk_axi_m1_r_valid    ,
    output logic [        31:0] soc_clk_axi_m1_w_data     ,
    output logic                soc_clk_axi_m1_w_last     ,
    input  logic                soc_clk_axi_m1_w_ready    ,
    output logic [         3:0] soc_clk_axi_m1_w_strb     ,
    output logic                soc_clk_axi_m1_w_valid    ,
    // FPGA IRQ
    output logic [        15:0] soc_clk_irq_src           ,
    input  logic [        12:0] soc_clk_irq_set           ,
    // FPGA DMA
    output logic [         3:0] soc_clk_dma_req           ,
    input  logic [         3:0] soc_clk_dma_ack           ,
    // ACE
    input  logic                soc_ace_vstart            ,
    input  logic                soc_ace_istart            ,
    input  logic                soc_ace_divalid           ,
    input  logic                soc_ace_doready           ,
    input  logic [        31:0] soc_ace_dinop             ,
    output logic                soc_ace_dovalid           ,
    output logic                soc_ace_vbreak            ,
    output logic                soc_ace_diready           ,
    output logic [        31:0] soc_ace_doutop            ,
    // FPGA PLL's clock sel
    input  logic                clk_xtal_ref              ,
    input  logic                clk_osc                   ,
    input  logic                clk_fpga_ref1             ,
    input  logic                clk_fpga_ref2             ,
    input  logic                clk_fpga_ref3             ,
    input  logic                clk_fpga_ref4             ,
    output logic                clk_fpga_pll0_ref         ,
    output logic                clk_fpga_pll1_ref         ,
    output logic                clk_fpga_pll2_ref         ,
    output logic                clk_fpga_pll3_ref         ,
    input  logic [         1:0] fpga_pll3_clk_sel         ,
    input  logic [         1:0] fpga_pll2_clk_sel         ,
    input  logic [         1:0] fpga_pll1_clk_sel         ,
    input  logic [         1:0] fpga_pll0_clk_sel
);
localparam FIFO_DEPTH = 8;

//*****************************************************************************
//             FCB declaration
//*****************************************************************************

    config_controller config_controller_u (
        .clk                   (clk_apb_ug            ),
        .rst_n                 (rst_n_per             ),
        .apb_addr              (fcb_s0_paddr[15:0]    ),
        .apb_sel               (fcb_s0_psel           ),
        .apb_en                (fcb_s0_penable        ),
        .apb_wr                (fcb_s0_pwrite         ),
        .apb_wdata             (fcb_s0_pwdata         ),
        .apb_strb              (fcb_s0_pwbe           ),
        .apb_rdata             (fcb_s0_prdata         ),
        .apb_ready             (fcb_s0_pready         ),
        .apb_err               (fcb_s0_pslverr        ),
        .fcb_clk_o             (fcb_clk_o             ),
        .fcb_data_o            (fcb_data_o            ),
        .fcb_cmd_o             (fcb_cmd_o             ),
        .fcb_clk_i             (fcb_clk_i             ),
        .fcb_data_i            (fcb_data_i            ),
        .fcb_rst_n             (fcb_rst_n             ),
        .icb_clk_o             (icb_clk_o             ),
        .icb_data_o            (icb_data_o            ),
        .icb_cmd_o             (icb_cmd_o             ),
        .icb_clk_i             (icb_clk_i             ),
        .icb_data_i            (icb_data_i            ),
        .icb_rst_n             (icb_rst_n             ),
        .pl_data_o             (pl_data_o             ),
        .pl_addr_o             (pl_addr_o             ),
        .pl_ena_o              (pl_ena_o              ),
        .pl_clk_o              (pl_clk_o              ),
        .pl_ren_o              (pl_ren_o              ),
        .pl_init_o             (pl_init_o             ),
        .pl_wen_o              (pl_wen_o              ),
        .pl_data_i             (pl_data_i             ),
        .fpga_pll0_dskewcalin  (fpga_pll0_dskewcalin  ),
        .fpga_pll0_pllen       (fpga_pll0_pllen       ),
        .fpga_pll0_dsmen       (fpga_pll0_dsmen       ),
        .fpga_pll0_dskewfastcal(fpga_pll0_dskewfastcal),
        .fpga_pll0_dskewcalen  (fpga_pll0_dskewcalen  ),
        .fpga_pll0_dskewcalcnt (fpga_pll0_dskewcalcnt ),
        .fpga_pll0_dskewcalbyp (fpga_pll0_dskewcalbyp ),
        .fpga_pll0_dacen       (fpga_pll0_dacen       ),
        .fpga_pll0_refdiv      (fpga_pll0_refdiv      ),
        .fpga_pll0_foutvcoen   (fpga_pll0_foutvcoen   ),
        .fpga_pll0_foutvcobyp  (fpga_pll0_foutvcobyp  ),
        .fpga_pll0_fouten      (fpga_pll0_fouten      ),
        .fpga_pll0_frac        (fpga_pll0_frac        ),
        .fpga_pll0_fbdiv       (fpga_pll0_fbdiv       ),
        .fpga_pll0_postdiv3    (fpga_pll0_postdiv3    ),
        .fpga_pll0_postdiv2    (fpga_pll0_postdiv2    ),
        .fpga_pll0_postdiv1    (fpga_pll0_postdiv1    ),
        .fpga_pll0_postdiv0    (fpga_pll0_postdiv0    ),
        .fpga_pll0_lock        (fpga_pll0_lock        ),
        .fpga_pll0_dskewcallock(fpga_pll0_dskewcallock),
        .fpga_pll0_dskewcalout (fpga_pll0_dskewcalout ),
        .fpga_pll1_dskewcalin  (fpga_pll1_dskewcalin  ),
        .fpga_pll1_pllen       (fpga_pll1_pllen       ),
        .fpga_pll1_dsmen       (fpga_pll1_dsmen       ),
        .fpga_pll1_dskewfastcal(fpga_pll1_dskewfastcal),
        .fpga_pll1_dskewcalen  (fpga_pll1_dskewcalen  ),
        .fpga_pll1_dskewcalcnt (fpga_pll1_dskewcalcnt ),
        .fpga_pll1_dskewcalbyp (fpga_pll1_dskewcalbyp ),
        .fpga_pll1_dacen       (fpga_pll1_dacen       ),
        .fpga_pll1_refdiv      (fpga_pll1_refdiv      ),
        .fpga_pll1_foutvcoen   (fpga_pll1_foutvcoen   ),
        .fpga_pll1_foutvcobyp  (fpga_pll1_foutvcobyp  ),
        .fpga_pll1_fouten      (fpga_pll1_fouten      ),
        .fpga_pll1_frac        (fpga_pll1_frac        ),
        .fpga_pll1_fbdiv       (fpga_pll1_fbdiv       ),
        .fpga_pll1_postdiv3    (fpga_pll1_postdiv3    ),
        .fpga_pll1_postdiv2    (fpga_pll1_postdiv2    ),
        .fpga_pll1_postdiv1    (fpga_pll1_postdiv1    ),
        .fpga_pll1_postdiv0    (fpga_pll1_postdiv0    ),
        .fpga_pll1_lock        (fpga_pll1_lock        ),
        .fpga_pll1_dskewcallock(fpga_pll1_dskewcallock),
        .fpga_pll1_dskewcalout (fpga_pll1_dskewcalout ),
        .fpga_pll2_dskewcalin  (fpga_pll2_dskewcalin  ),
        .fpga_pll2_pllen       (fpga_pll2_pllen       ),
        .fpga_pll2_dsmen       (fpga_pll2_dsmen       ),
        .fpga_pll2_dskewfastcal(fpga_pll2_dskewfastcal),
        .fpga_pll2_dskewcalen  (fpga_pll2_dskewcalen  ),
        .fpga_pll2_dskewcalcnt (fpga_pll2_dskewcalcnt ),
        .fpga_pll2_dskewcalbyp (fpga_pll2_dskewcalbyp ),
        .fpga_pll2_dacen       (fpga_pll2_dacen       ),
        .fpga_pll2_refdiv      (fpga_pll2_refdiv      ),
        .fpga_pll2_foutvcoen   (fpga_pll2_foutvcoen   ),
        .fpga_pll2_foutvcobyp  (fpga_pll2_foutvcobyp  ),
        .fpga_pll2_fouten      (fpga_pll2_fouten      ),
        .fpga_pll2_frac        (fpga_pll2_frac        ),
        .fpga_pll2_fbdiv       (fpga_pll2_fbdiv       ),
        .fpga_pll2_postdiv3    (fpga_pll2_postdiv3    ),
        .fpga_pll2_postdiv2    (fpga_pll2_postdiv2    ),
        .fpga_pll2_postdiv1    (fpga_pll2_postdiv1    ),
        .fpga_pll2_postdiv0    (fpga_pll2_postdiv0    ),
        .fpga_pll2_lock        (fpga_pll2_lock        ),
        .fpga_pll2_dskewcallock(fpga_pll2_dskewcallock),
        .fpga_pll2_dskewcalout (fpga_pll2_dskewcalout ),
        .fpga_pll3_dskewcalin  (fpga_pll3_dskewcalin  ),
        .fpga_pll3_pllen       (fpga_pll3_pllen       ),
        .fpga_pll3_dsmen       (fpga_pll3_dsmen       ),
        .fpga_pll3_dskewfastcal(fpga_pll3_dskewfastcal),
        .fpga_pll3_dskewcalen  (fpga_pll3_dskewcalen  ),
        .fpga_pll3_dskewcalcnt (fpga_pll3_dskewcalcnt ),
        .fpga_pll3_dskewcalbyp (fpga_pll3_dskewcalbyp ),
        .fpga_pll3_dacen       (fpga_pll3_dacen       ),
        .fpga_pll3_refdiv      (fpga_pll3_refdiv      ),
        .fpga_pll3_foutvcoen   (fpga_pll3_foutvcoen   ),
        .fpga_pll3_foutvcobyp  (fpga_pll3_foutvcobyp  ),
        .fpga_pll3_fouten      (fpga_pll3_fouten      ),
        .fpga_pll3_frac        (fpga_pll3_frac        ),
        .fpga_pll3_fbdiv       (fpga_pll3_fbdiv       ),
        .fpga_pll3_postdiv3    (fpga_pll3_postdiv3    ),
        .fpga_pll3_postdiv2    (fpga_pll3_postdiv2    ),
        .fpga_pll3_postdiv1    (fpga_pll3_postdiv1    ),
        .fpga_pll3_postdiv0    (fpga_pll3_postdiv0    ),
        .fpga_pll3_lock        (fpga_pll3_lock        ),
        .fpga_pll3_dskewcallock(fpga_pll3_dskewcallock),
        .fpga_pll3_dskewcalout (fpga_pll3_dskewcalout ),
        .cfg_done              (cfg_done              )
    );



//*****************************************************************************
//             IRQ async FIFO
//*****************************************************************************
localparam DATA_WIDTH_ASYNC_FIFO_IRQ_F2A = 16;
localparam DATA_WIDTH_ASYNC_FIFO_IRQ_A2F = 13;

logic wr_irq_f2a;
logic rd_irq_f2a;
logic empty_irq_f2a;
logic full_irq_f2a;
logic [DATA_WIDTH_ASYNC_FIFO_IRQ_F2A-1:0]wr_data_irq_f2a;
logic [DATA_WIDTH_ASYNC_FIFO_IRQ_F2A-1:0]rd_data_irq_f2a;
assign wr_irq_f2a      = ~full_irq_f2a;
assign rd_irq_f2a      = ~empty_irq_f2a;
assign wr_data_irq_f2a = fpga_clk_irq_src;
assign soc_clk_irq_src = rd_data_irq_f2a;

    nds_async_fifo_afe #(
        .DATA_WIDTH(DATA_WIDTH_ASYNC_FIFO_IRQ_F2A),
        .FIFO_DEPTH(FIFO_DEPTH                   )
    ) async_fifo_irq_f2a (
        .w_reset_n   (rst_n_fpga_fabric_irq),
        .r_reset_n   (rst_n_fpga_soc_m0    ),
        .w_clk       (clk_fpga_fabric_irq  ),
        .r_clk       (clk_apb_ug      ),
        .wr          (wr_irq_f2a           ),
        .wr_data     (wr_data_irq_f2a      ),
        .rd          (rd_irq_f2a           ),
        .rd_data     (rd_data_irq_f2a      ),
        .almost_empty(                     ),
        .almost_full (                     ),
        .empty       (empty_irq_f2a        ),
        .full        (full_irq_f2a         )
    );         

logic wr_irq_a2f;
logic rd_irq_a2f;
logic empty_irq_a2f;
logic full_irq_a2f;
logic [DATA_WIDTH_ASYNC_FIFO_IRQ_A2F-1:0]wr_data_irq_a2f;
logic [DATA_WIDTH_ASYNC_FIFO_IRQ_A2F-1:0]rd_data_irq_a2f;

assign wr_irq_a2f      = ~full_irq_a2f;
assign rd_irq_a2f      = ~empty_irq_a2f;
assign wr_data_irq_a2f = soc_clk_irq_set;
assign fpga_clk_irq_set = rd_data_irq_a2f;

    nds_async_fifo_afe #(
        .DATA_WIDTH(DATA_WIDTH_ASYNC_FIFO_IRQ_A2F),
        .FIFO_DEPTH(FIFO_DEPTH                   )
    ) async_fifo_irq_a2f (
        .w_reset_n   (rst_n_fpga_soc_m0    ),
        .r_reset_n   (rst_n_fpga_fabric_irq),
        .w_clk       (clk_apb_ug      ),
        .r_clk       (clk_fpga_fabric_irq  ),
        .wr          (wr_irq_a2f           ),
        .wr_data     (wr_data_irq_a2f      ),
        .rd          (rd_irq_a2f           ),
        .rd_data     (rd_data_irq_a2f      ),
        .almost_empty(                     ),
        .almost_full (                     ),
        .empty       (empty_irq_a2f        ),
        .full        (full_irq_a2f         )
    );
//*****************************************************************************
//             DMA async FIFO
//*****************************************************************************

localparam DATA_WIDTH_ASYNC_FIFO_DMA_F2A = 4;
localparam DATA_WIDTH_ASYNC_FIFO_DMA_A2F = 4;    


logic wr_dma_f2a;
logic rd_dma_f2a;
logic empty_dma_f2a;
logic full_dma_f2a;
logic [DATA_WIDTH_ASYNC_FIFO_DMA_F2A-1:0]wr_data_dma_f2a;
logic [DATA_WIDTH_ASYNC_FIFO_DMA_F2A-1:0]rd_data_dma_f2a;
assign wr_dma_f2a      = ~full_dma_f2a;
assign rd_dma_f2a      = ~empty_dma_f2a;
assign wr_data_dma_f2a = fpga_clk_dma_req;
assign soc_clk_dma_req = rd_data_dma_f2a;

    nds_async_fifo_afe #(
        .DATA_WIDTH(DATA_WIDTH_ASYNC_FIFO_DMA_F2A),
        .FIFO_DEPTH(FIFO_DEPTH                   )
    ) async_fifo_dma_f2a (
        .w_reset_n   (rst_n_fpga_fabric_dma),
        .r_reset_n   (rst_n_fpga_soc_m0    ),
        .w_clk       (clk_fpga_fabric_dma  ),
        .r_clk       (clk_apb_ug      ),
        .wr          (wr_dma_f2a           ),
        .wr_data     (wr_data_dma_f2a      ),
        .rd          (rd_dma_f2a           ),
        .rd_data     (rd_data_dma_f2a      ),
        .almost_empty(                     ),
        .almost_full (                     ),
        .empty       (empty_dma_f2a        ),
        .full        (full_dma_f2a         )
    );          

logic wr_dma_a2f;
logic rd_dma_a2f;
logic empty_dma_a2f;
logic full_dma_a2f;
logic [DATA_WIDTH_ASYNC_FIFO_DMA_A2F-1:0]wr_data_dma_a2f;
logic [DATA_WIDTH_ASYNC_FIFO_DMA_A2F-1:0]rd_data_dma_a2f;

assign wr_dma_a2f      = ~full_dma_a2f;
assign rd_dma_a2f      = ~empty_dma_a2f;
assign wr_data_dma_a2f = soc_clk_dma_ack;
assign fpga_clk_dma_ack = rd_data_dma_a2f;

    nds_async_fifo_afe #(
        .DATA_WIDTH(DATA_WIDTH_ASYNC_FIFO_DMA_A2F),
        .FIFO_DEPTH(FIFO_DEPTH                   )
    ) async_fifo_dma_a2f (
        .w_reset_n   (rst_n_fpga_soc_m0    ),
        .r_reset_n   (rst_n_fpga_fabric_dma),
        .w_clk       (clk_apb_ug      ),
        .r_clk       (clk_fpga_fabric_dma  ),
        .wr          (wr_dma_a2f           ),
        .wr_data     (wr_data_dma_a2f      ),
        .rd          (rd_dma_a2f           ),
        .rd_data     (rd_data_dma_a2f      ),
        .almost_empty(                     ),
        .almost_full (                     ),
        .empty       (empty_dma_a2f        ),
        .full        (full_dma_a2f         )
    );
//*****************************************************************************
//             ACE async FIFO
//*****************************************************************************

localparam DATA_WIDTH_ASYNC_FIFO_ACE_F2A = 1+1+1+32  ;
localparam DATA_WIDTH_ASYNC_FIFO_ACE_A2F = 1+1+1+1+32;

logic wr_ace_f2a;
logic rd_ace_f2a;
logic empty_ace_f2a;
logic full_ace_f2a;
logic wr_ace_a2f;
logic rd_ace_a2f;
logic empty_ace_a2f;
logic full_ace_a2f;
logic [DATA_WIDTH_ASYNC_FIFO_ACE_A2F-1:0]wr_data_ace_a2f;
logic [DATA_WIDTH_ASYNC_FIFO_ACE_A2F-1:0]rd_data_ace_a2f;
logic [DATA_WIDTH_ASYNC_FIFO_ACE_F2A-1:0]wr_data_ace_f2a;
logic [DATA_WIDTH_ASYNC_FIFO_ACE_F2A-1:0]rd_data_ace_f2a;

assign wr_ace_f2a      = fpga_ace_dovalid & fpga_ace_doready;
assign rd_ace_f2a      = ~empty_ace_f2a;
assign wr_data_ace_f2a = {fpga_ace_dovalid,
                          fpga_ace_vbreak,
                          fpga_ace_diready,
                          fpga_ace_doutop};

assign soc_ace_dovalid = rd_data_ace_f2a [DATA_WIDTH_ASYNC_FIFO_ACE_F2A-1 -:1];
assign soc_ace_vbreak  = rd_data_ace_f2a [DATA_WIDTH_ASYNC_FIFO_ACE_F2A-2 -:1];
assign soc_ace_diready = rd_data_ace_f2a [DATA_WIDTH_ASYNC_FIFO_ACE_F2A-3 -:1] & ~full_ace_a2f;
assign soc_ace_doutop  = rd_data_ace_f2a [DATA_WIDTH_ASYNC_FIFO_ACE_F2A-4 -:32];

    nds_async_fifo_afe #(
        .DATA_WIDTH(DATA_WIDTH_ASYNC_FIFO_ACE_F2A),
        .FIFO_DEPTH(FIFO_DEPTH                   )
    ) async_fifo_ace_f2a (
        .w_reset_n   (rst_n_fpga_fabric_ace),
        .r_reset_n   (rst_n_acpu           ),
        .w_clk       (clk_fpga_fabric_ace  ),
        .r_clk       (clk_acpu             ),
        .wr          (wr_ace_f2a           ),
        .wr_data     (wr_data_ace_f2a      ),
        .rd          (rd_ace_f2a           ),
        .rd_data     (rd_data_ace_f2a      ),
        .almost_empty(                     ),
        .almost_full (                     ),
        .empty       (empty_ace_f2a        ),
        .full        (full_ace_f2a         )
    );          



assign wr_ace_a2f      = soc_ace_divalid & soc_ace_diready;
assign rd_ace_a2f      = ~empty_ace_a2f;
assign wr_data_ace_a2f = {soc_ace_vstart,
                          soc_ace_istart,
                          soc_ace_divalid,
                          soc_ace_doready,
                          soc_ace_dinop};
assign fpga_ace_vstart = rd_data_ace_a2f[DATA_WIDTH_ASYNC_FIFO_ACE_A2F-1 -: 1];
assign fpga_ace_istart = rd_data_ace_a2f[DATA_WIDTH_ASYNC_FIFO_ACE_A2F-2 -: 1];
assign fpga_ace_divalid = rd_data_ace_a2f[DATA_WIDTH_ASYNC_FIFO_ACE_A2F-3 -: 1];
assign fpga_ace_doready = rd_data_ace_a2f[DATA_WIDTH_ASYNC_FIFO_ACE_A2F-4 -: 1] & ~full_ace_f2a;
assign fpga_ace_dinop = rd_data_ace_a2f[DATA_WIDTH_ASYNC_FIFO_ACE_A2F-5 -: 32];

    nds_async_fifo_afe #(
        .DATA_WIDTH(DATA_WIDTH_ASYNC_FIFO_ACE_A2F),
        .FIFO_DEPTH(FIFO_DEPTH                   )
    ) async_fifo_ace_a2f (
        .w_reset_n   (rst_n_acpu           ),
        .r_reset_n   (rst_n_fpga_fabric_ace),
        .w_clk       (clk_acpu             ),
        .r_clk       (clk_fpga_fabric_ace  ),
        .wr          (wr_ace_a2f           ),
        .wr_data     (wr_data_ace_a2f      ),
        .rd          (rd_ace_a2f           ),
        .rd_data     (rd_data_ace_a2f      ),
        .almost_empty(                     ),
        .almost_full (                     ),
        .empty       (empty_ace_a2f        ),
        .full        (full_ace_a2f         )
    );    


//
assign fpga_clk_ahb_s0_haddr     = soc_clk_ahb_s0_haddr;
assign fpga_clk_ahb_s0_hburst    = soc_clk_ahb_s0_hburst;
assign fpga_clk_ahb_s0_hmastlock = soc_clk_ahb_s0_hmastlock;
assign fpga_clk_ahb_s0_hprot     = soc_clk_ahb_s0_hprot;
assign fpga_clk_ahb_s0_hsel      = soc_clk_ahb_s0_hsel;
assign fpga_clk_ahb_s0_hsize     = soc_clk_ahb_s0_hsize;
assign fpga_clk_ahb_s0_htrans    = soc_clk_ahb_s0_htrans;
assign fpga_clk_ahb_s0_hwbe      = soc_clk_ahb_s0_hwbe;
assign fpga_clk_ahb_s0_hwdata    = soc_clk_ahb_s0_hwdata;
assign fpga_clk_ahb_s0_hwrite    = soc_clk_ahb_s0_hwrite;
assign soc_clk_ahb_s0_hrdata     = fpga_clk_ahb_s0_hrdata;
assign soc_clk_ahb_s0_hready     = fpga_clk_ahb_s0_hready;
assign soc_clk_ahb_s0_hresp      = fpga_clk_ahb_s0_hresp;
assign fpga_clk_axi_m0_ar_ready  = soc_clk_axi_m0_ar_ready;
assign fpga_clk_axi_m0_aw_ready  = soc_clk_axi_m0_aw_ready;
assign fpga_clk_axi_m0_b_id      = soc_clk_axi_m0_b_id;
assign fpga_clk_axi_m0_b_resp    = soc_clk_axi_m0_b_resp;
assign fpga_clk_axi_m0_b_valid   = soc_clk_axi_m0_b_valid;
assign fpga_clk_axi_m0_r_data    = soc_clk_axi_m0_r_data;
assign fpga_clk_axi_m0_r_id      = soc_clk_axi_m0_r_id;
assign fpga_clk_axi_m0_r_last    = soc_clk_axi_m0_r_last;
assign fpga_clk_axi_m0_r_resp    = soc_clk_axi_m0_r_resp;
assign fpga_clk_axi_m0_r_valid   = soc_clk_axi_m0_r_valid;
assign fpga_clk_axi_m0_w_ready   = soc_clk_axi_m0_w_ready;
assign soc_clk_axi_m0_ar_addr    = fpga_clk_axi_m0_ar_addr;
assign soc_clk_axi_m0_ar_burst   = fpga_clk_axi_m0_ar_burst;
assign soc_clk_axi_m0_ar_cache   = fpga_clk_axi_m0_ar_cache;
assign soc_clk_axi_m0_ar_id      = fpga_clk_axi_m0_ar_id;
assign soc_clk_axi_m0_ar_len     = fpga_clk_axi_m0_ar_len;
assign soc_clk_axi_m0_ar_lock    = fpga_clk_axi_m0_ar_lock;
assign soc_clk_axi_m0_ar_prot    = fpga_clk_axi_m0_ar_prot;
assign soc_clk_axi_m0_ar_size    = fpga_clk_axi_m0_ar_size;
assign soc_clk_axi_m0_ar_valid   = fpga_clk_axi_m0_ar_valid;
assign soc_clk_axi_m0_aw_addr    = fpga_clk_axi_m0_aw_addr;
assign soc_clk_axi_m0_aw_burst   = fpga_clk_axi_m0_aw_burst;
assign soc_clk_axi_m0_aw_cache   = fpga_clk_axi_m0_aw_cache;
assign soc_clk_axi_m0_aw_id      = fpga_clk_axi_m0_aw_id;
assign soc_clk_axi_m0_aw_len     = fpga_clk_axi_m0_aw_len;
assign soc_clk_axi_m0_aw_lock    = fpga_clk_axi_m0_aw_lock;
assign soc_clk_axi_m0_aw_prot    = fpga_clk_axi_m0_aw_prot;
assign soc_clk_axi_m0_aw_size    = fpga_clk_axi_m0_aw_size;
assign soc_clk_axi_m0_aw_valid   = fpga_clk_axi_m0_aw_valid;
assign soc_clk_axi_m0_b_ready    = fpga_clk_axi_m0_b_ready;
assign soc_clk_axi_m0_r_ready    = fpga_clk_axi_m0_r_ready;
assign soc_clk_axi_m0_w_data     = fpga_clk_axi_m0_w_data;
assign soc_clk_axi_m0_w_last     = fpga_clk_axi_m0_w_last;
assign soc_clk_axi_m0_w_strb     = fpga_clk_axi_m0_w_strb;
assign soc_clk_axi_m0_w_valid    = fpga_clk_axi_m0_w_valid;
assign fpga_clk_axi_m1_ar_ready  = soc_clk_axi_m1_ar_ready;
assign fpga_clk_axi_m1_aw_ready  = soc_clk_axi_m1_aw_ready;
assign fpga_clk_axi_m1_b_id      = soc_clk_axi_m1_b_id;
assign fpga_clk_axi_m1_b_resp    = soc_clk_axi_m1_b_resp;
assign fpga_clk_axi_m1_b_valid   = soc_clk_axi_m1_b_valid;
assign fpga_clk_axi_m1_r_data    = soc_clk_axi_m1_r_data;
assign fpga_clk_axi_m1_r_id      = soc_clk_axi_m1_r_id;
assign fpga_clk_axi_m1_r_last    = soc_clk_axi_m1_r_last;
assign fpga_clk_axi_m1_r_resp    = soc_clk_axi_m1_r_resp;
assign fpga_clk_axi_m1_r_valid   = soc_clk_axi_m1_r_valid;
assign fpga_clk_axi_m1_w_ready   = soc_clk_axi_m1_w_ready;
assign soc_clk_axi_m1_ar_addr    = fpga_clk_axi_m1_ar_addr;
assign soc_clk_axi_m1_ar_burst   = fpga_clk_axi_m1_ar_burst;
assign soc_clk_axi_m1_ar_cache   = fpga_clk_axi_m1_ar_cache;
assign soc_clk_axi_m1_ar_id      = fpga_clk_axi_m1_ar_id;
assign soc_clk_axi_m1_ar_len     = fpga_clk_axi_m1_ar_len;
assign soc_clk_axi_m1_ar_lock    = fpga_clk_axi_m1_ar_lock;
assign soc_clk_axi_m1_ar_prot    = fpga_clk_axi_m1_ar_prot;
assign soc_clk_axi_m1_ar_size    = fpga_clk_axi_m1_ar_size;
assign soc_clk_axi_m1_ar_valid   = fpga_clk_axi_m1_ar_valid;
assign soc_clk_axi_m1_aw_addr    = fpga_clk_axi_m1_aw_addr;
assign soc_clk_axi_m1_aw_burst   = fpga_clk_axi_m1_aw_burst;
assign soc_clk_axi_m1_aw_cache   = fpga_clk_axi_m1_aw_cache;
assign soc_clk_axi_m1_aw_id      = fpga_clk_axi_m1_aw_id;
assign soc_clk_axi_m1_aw_len     = fpga_clk_axi_m1_aw_len;
assign soc_clk_axi_m1_aw_lock    = fpga_clk_axi_m1_aw_lock;
assign soc_clk_axi_m1_aw_prot    = fpga_clk_axi_m1_aw_prot;
assign soc_clk_axi_m1_aw_size    = fpga_clk_axi_m1_aw_size;
assign soc_clk_axi_m1_aw_valid   = fpga_clk_axi_m1_aw_valid;
assign soc_clk_axi_m1_b_ready    = fpga_clk_axi_m1_b_ready;
assign soc_clk_axi_m1_r_ready    = fpga_clk_axi_m1_r_ready;
assign soc_clk_axi_m1_w_data     = fpga_clk_axi_m1_w_data;
assign soc_clk_axi_m1_w_last     = fpga_clk_axi_m1_w_last;
assign soc_clk_axi_m1_w_strb     = fpga_clk_axi_m1_w_strb;
assign soc_clk_axi_m1_w_valid    = fpga_clk_axi_m1_w_valid;
 

//*****************************************************************************
//             FPGA PLL's clock sel
//*****************************************************************************
  logic clk_fpga_pll0_mux0;
  logic clk_fpga_pll0_mux1;
  clkmux clkmux_osc_xtal_pll0  (.clka(clk_osc),            .clkb(clk_xtal_ref),       .select(fpga_pll0_clk_sel[0]), .clk_out(clk_fpga_pll0_mux0));
  clkmux clkmux_fpga_ref_pll0  (.clka(clk_fpga_ref1),      .clkb(1'b0),               .select(fpga_pll0_clk_sel[0]), .clk_out(clk_fpga_pll0_mux1));
  clkmux clkmux_fpga_pll0      (.clka(clk_fpga_pll0_mux1), .clkb(clk_fpga_pll0_mux0), .select(fpga_pll0_clk_sel[1]), .clk_out(clk_fpga_pll0_ref));

  logic clk_fpga_pll1_mux0;
  logic clk_fpga_pll1_mux1;
  clkmux clkmux_osc_xtal_pll1  (.clka(clk_osc),            .clkb(clk_xtal_ref),       .select(fpga_pll1_clk_sel[0]), .clk_out(clk_fpga_pll1_mux0));
  clkmux clkmux_fpga_ref_pll1  (.clka(clk_fpga_ref2),      .clkb(1'b0),               .select(fpga_pll1_clk_sel[0]), .clk_out(clk_fpga_pll1_mux1));
  clkmux clkmux_fpga_pll1      (.clka(clk_fpga_pll1_mux1), .clkb(clk_fpga_pll1_mux0), .select(fpga_pll1_clk_sel[1]), .clk_out(clk_fpga_pll1_ref));

  logic clk_fpga_pll2_mux0;
  logic clk_fpga_pll2_mux1;
  clkmux clkmux_osc_xtal_pll2  (.clka(clk_osc),            .clkb(clk_xtal_ref),       .select(fpga_pll2_clk_sel[0]), .clk_out(clk_fpga_pll2_mux0));
  clkmux clkmux_fpga_ref_pll2  (.clka(clk_fpga_ref3),      .clkb(1'b0),               .select(fpga_pll2_clk_sel[0]), .clk_out(clk_fpga_pll2_mux1));
  clkmux clkmux_fpga_pll2      (.clka(clk_fpga_pll2_mux1), .clkb(clk_fpga_pll2_mux0), .select(fpga_pll2_clk_sel[1]), .clk_out(clk_fpga_pll2_ref));

  logic clk_fpga_pll3_mux0;
  logic clk_fpga_pll3_mux1;
  clkmux clkmux_osc_xtal_pll3  (.clka(clk_osc),            .clkb(clk_xtal_ref),       .select(fpga_pll3_clk_sel[0]), .clk_out(clk_fpga_pll3_mux0));
  clkmux clkmux_fpga_ref_pll3  (.clka(clk_fpga_ref4),      .clkb(1'b0),               .select(fpga_pll3_clk_sel[0]), .clk_out(clk_fpga_pll3_mux1));
  clkmux clkmux_fpga_pll3      (.clka(clk_fpga_pll3_mux1), .clkb(clk_fpga_pll3_mux0), .select(fpga_pll3_clk_sel[1]), .clk_out(clk_fpga_pll3_ref));

endmodule