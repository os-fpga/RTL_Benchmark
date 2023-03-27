`include "soc_scu_registers.svh"
module soc_scu (
  // input clock control
  input  logic                clk_sel0                   ,
  input  logic                clk_sel1                   ,
  // input OSC clock
  input  logic                clk_osc                    ,
  // input soc xtal clock
  input  logic                clk_xtal_ref               ,
  // output PLL  ref clock
  output logic                clk_pll_soc_ref            ,
  // input power on reset
  input  logic                rst_n_poweron              ,
  // input pll's clocks
  input  logic                clk0                       ,
  input  logic                clk1                       ,
  // input FPGA clocks
  input  logic                clk_fpga0                  ,
  input  logic                clk_fpga1                  ,
  input  logic                clk_fpga_s                 ,
  //GbE clocks
  input  logic                clk_gbe_rx                 ,
  output logic                clk_gbe_rx_n               ,
  // output system clocks
  output logic                clk_acpu                   ,
  output logic                clk_acpu_mtime             ,
  output logic                clk_dma                    ,
  output logic                clk_bcpu_mtime             ,
  output logic                clk_bcpu                   ,
  output logic                clk_qspi                   ,
  output logic                clk_i2c                    ,
  output logic                clk_uart                   ,
  output logic                clk_gpio                   ,
  output logic                clk_gpt                    ,
  output logic                clk_usb                    ,
  output logic                clk_cru                    ,
  output logic                clk_ddr_phy                ,
  output logic                clk_ddr_ctl                ,
  output logic                clk_ddr_cfg                ,
  output logic                clk_pscc_xtl               ,
  output logic                clk_usb_wakeup             ,
  // output system resets
  output logic                rst_n_bcpu                 ,
  output logic                rst_n_bcpu_bus             ,
  output logic                rst_n_sram                 ,
  output logic                rst_n_acpu                 ,
  output logic                rst_n_acpu_bus             ,
  output logic                rst_n_per                  ,
  output logic                rst_n_fpga0                ,
  output logic                rst_n_fpga1                ,
  output logic                rst_n_fpga_s               ,
  output logic                rst_n_ddr                  ,
  output logic                rst_n_usb                  ,
  output logic                rst_n_emac                 ,
  output logic                rst_n_dma                  ,
  output logic                rst_n_133                  ,
  output logic                rst_n_266                  ,
  output logic                rst_n_533                  ,
  output logic                rst_n_gbe_tx               ,
  output logic                rst_n_gbe_ntx              ,
  output logic                rst_n_gbe_rx               ,
  output logic                rst_n_gbe_nrx              ,
  // APB
  input  logic [  AWIDTH-1:0] apb_addr                   ,
  input  logic                apb_sel                    ,
  input  logic                apb_en                     ,
  input  logic                apb_wr                     ,
  input  logic [  DWIDTH-1:0] apb_wdata                  ,
  input  logic [DWIDTH/8-1:0] apb_strb                   ,
  output logic [  DWIDTH-1:0] apb_rdata                  ,
  output logic                apb_ready                  ,
  output logic                apb_err                    ,
  // pll control signals
  output logic                soc_pll_ctl_dacen          ,
  output logic                soc_pll_ctl_dskewcalbyp    ,
  output logic [         2:0] soc_pll_ctl_dskewcalcnt    ,
  output logic                soc_pll_ctl_dskewcalen     ,
  output logic [        11:0] soc_pll_ctl_dskewcalin     ,
  output logic                soc_pll_ctl_dskewfastcal   ,
  output logic                soc_pll_ctl_dsmen          ,
  output logic                soc_pll_ctl_pllen          ,
  output logic [         3:0] soc_pll_ctl_fouten         ,
  output logic [         4:0] soc_pll_ctl_foutvcobyp     ,
  output logic                soc_pll_ctl_foutvcoen      ,
  output logic [         5:0] soc_pll_ctl_refdiv         ,
  output logic [        23:0] soc_pll_ctl_frac           ,
  output logic [         3:0] soc_pll_ctl_postdiv0       ,
  output logic [         3:0] soc_pll_ctl_postdiv1       ,
  output logic [        11:0] soc_pll_ctl_fbdiv          ,
  // pll status signals
  input  logic [        11:0] soc_pll_status_dskewcalout ,
  input  logic                soc_pll_status_dskewcallock,
  input  logic                soc_pll_status_lock        ,
  // debug control
  output logic [         1:0] jtag_control               ,
  // input interrupts
  input  logic                acpu_watchdog_irq          ,
  input  logic                bcpu_watchdog_irq          ,
  input  logic                timer_irq                  ,
  input  logic                usb_irq                    ,
  input  logic                emac_irq                   ,
  input  logic                uart0_irq                  ,
  input  logic                uart1_irq                  ,
  input  logic                qspi_irq                   ,
  input  logic                i2c_irq                    ,
  input  logic                gpio_irq                   ,
  input  logic                dma_irq                    ,
  input  logic                ddr_irq                    ,
  input  logic                acpu_mailbox_irq           ,
  input  logic                bcpu_mailbox_irq           ,
  input  logic                fpga0_mailbox_irq          ,
  input  logic                fpga1_mailbox_irq          ,
  input  logic                pscc_irq                   ,
  input  logic [        15:0] fpga_irq_src               ,
  // output interrupt sets
  output logic [        31:0] acpu_irq_set               ,
  output logic [        31:0] bcpu_irq_set               ,
  output logic [        12:0] fpga_irq_set               ,
  // isolation cells control
  output logic                ace_isolation_ctl          ,
  output logic                irq_isolation_ctl          ,
  output logic                fcb_isolation_ctl          ,
  output logic                ahb_isolation_ctl          ,
  output logic                axi1_isolation_ctl         ,
  output logic                axi0_isolation_ctl         ,
  // watchdog timers
  input  logic                bcpu_wathcdog_timer_reset  ,
  input  logic                acpu_wathcdog_timer_reset  ,
  // PAD control
  input  logic [        31:0] pad_c                      ,
  output logic [        31:0] pad_i                      ,
  output logic [        31:0] pad_oen                    ,
  output logic [        31:0] pad_ds0                    ,
  output logic [        31:0] pad_ds1                    ,
  output logic [        31:0] pad_pull_en                ,
  output logic [        31:0] pad_pull_dir               ,
  // PAD signal mux interface
  input  logic [        31:0] pad_inp_mux [1:0]          ,
  input  logic [        31:0] pad_dir_mux [1:0]          ,
  output logic [        31:0] pad_out_mux [1:0]          ,
  // PUFCC
  output logic                pufcc_rng_fre_en           ,
  output logic                pufcc_rng_fre_sel          ,
  input  logic                pufcc_rng_fre_out          ,
  //USB
  output logic                usb_wakeup                 ,
  output logic                usb_vbusfault              ,
  output logic [         1:0] usb_tsmode                 ,
  input  logic                usb_tmodecustom            ,
  input  logic [         7:0] usb_tmodeselcustom         ,
  output logic                usb_pll_bypass             ,
  output logic                usb_phy_biston             ,
  output logic [         3:0] usb_phy_bistmodesel        ,
  output logic                usb_phy_bistmodeen         ,
  input  logic                usb_phy_bistcomplete       ,
  input  logic                usb_phy_bisterror          ,
  input  logic [         7:0] usb_phy_bisterrorcount     ,
  // ID
  input  logic [         7:0] rev_id                     ,
  input  logic [         7:0] chip_id                    ,
  input  logic [        15:0] vendor_id                  ,
  //boot mode
  input  logic [         2:0] bootm                      ,
  // FPGA PLL's control
  output logic [         1:0] fpga_pll3_clk_sel          ,
  output logic [         1:0] fpga_pll2_clk_sel          ,
  output logic [         1:0] fpga_pll1_clk_sel          ,
  output logic [         1:0] fpga_pll0_clk_sel          ,
  // WDT pause
  output logic                acpu_wdt_pause             ,
  output logic                bcpu_wdt_pause
);

logic                rack;
logic                rerr;
logic [DWIDTH-1:0]   rdat;
logic [REGS_NUM-1:0] rreq;
logic                wack;
logic                werr;
logic [DWIDTH-1:0]   wdat;
logic [REGS_NUM-1:0] wreq;
logic [DWIDTH/8-1:0] wstr;

logic deassert_bcpu_rstn;
logic [1:0] clk_sel_status;

logic             dma_rstn  ;
logic             emac_rstn ;
logic             usb_rstn  ;
logic             ddr_rstn  ;
logic             fpga1_rstn;
logic             fpga0_rstn;
logic             per_rstn  ;
logic             bcpu_rstn ;
logic             acpu_rstn ;
logic [ 3:0]      div3      ;
logic [ 3:0]      div2      ;
logic [ 3:0]      div1      ;
logic [ 3:0]      div0      ;
logic [ 3:0]      div2_clk0 ;
logic [ 3:0]      div1_clk0 ;
logic [ 3:0]      div0_clk0 ;
logic [ 3:0]      div0_clk1 ;
logic             pscc_xtal_cg;
logic             ddr_cfg_ctl_cg;
logic             ddr_ctl_cg;
logic             ddr_phy_cg;
logic             gpt_cg    ;
logic             gpio_cg   ;
logic             uart_cg   ;
logic             i2c_cg    ;
logic             qspi_cg   ;
logic             bcpu_cg   ;
logic             sys_dma_cg;
logic             acpu_cg   ;
logic             usb_ctl_cg;
logic [31:0][2:0] irq_map   ;
logic [31:0]      irq_mask  ;

logic                apb_sel_scu   ;
logic                apb_err_scu   ;
logic                apb_ready_scu ;
logic                apb_sel_pad   ;
logic                apb_err_pad   ;
logic [  AWIDTH-1:0] apb_addr_pad  ;
logic                apb_ready_pad ;
logic [  DWIDTH-1:0] apb_rdata_pad ;
logic [  DWIDTH-1:0] apb_rdata_scu ;

logic                apb_sel_pvt   ;
logic                apb_err_pvt   ;
logic                apb_ready_pvt ;
logic [  DWIDTH-1:0] apb_rdata_pvt ;

logic                pvt_tstout;

//*****************************************************************************
//              APB slave declaration
//*****************************************************************************
  localparam [AWIDTH-1:0] PAD_ADDR = 'h1000;
  localparam [AWIDTH-1:0] PVT_ADDR = 'h2000;


  assign apb_sel_pad  = apb_sel && (apb_addr >= PAD_ADDR) && (apb_addr < PVT_ADDR);
  assign apb_sel_scu  = apb_sel && (apb_addr <  PAD_ADDR);
  assign apb_sel_pvt  = apb_sel && (apb_addr >= PVT_ADDR);
  assign apb_addr_pad =            (apb_addr -  PAD_ADDR);

  assign apb_rdata    = (apb_sel_pad)? apb_rdata_pad : 
                       ((apb_sel_pvt)? apb_rdata_pvt : apb_rdata_scu );

  assign apb_ready    = (apb_sel_pad)? apb_ready_pad : 
                       ((apb_sel_pvt)? apb_ready_pvt : apb_ready_scu );

  assign apb_err      = (apb_sel_pad)? apb_err_pad   :  
                       ((apb_sel_pvt)? apb_err_pvt   : apb_err_scu   );

  apb_manager #(
    .AWIDTH  (AWIDTH  ),
    .REGS_NUM(REGS_NUM),
    .DWIDTH  (DWIDTH  ),
    .MAP     (MAP     )
  ) apb_manager (
    .clk      (clk_cru       ),
    .rst_n    (rst_n_bcpu_bus),
    .apb_addr (apb_addr      ),
    .apb_sel  (apb_sel_scu   ),
    .apb_en   (apb_en        ),
    .apb_wr   (apb_wr        ),
    .apb_wdata(apb_wdata     ),
    .apb_strb (apb_strb      ),
    .apb_rdata(apb_rdata_scu ),
    .apb_ready(apb_ready_scu ),
    .apb_err  (apb_err_scu   ),
    .rack     (rack          ),
    .rerr     (rerr          ),
    .rdat     (rdat          ),
    .rreq     (rreq          ),
    .wack     (wack          ),
    .werr     (werr          ),
    .wdat     (wdat          ),
    .wreq     (wreq          ),
    .wstr     (wstr          )
  );

//*****************************************************************************
//              PVT Monitor
//*****************************************************************************
dti_pvt_controller pvt_inst (
  // Input
  .VDD    (1'b1          ), // Power Pin
  .VDDO   (1'b1          ), // Power Pin
  .VIN    (1'b1          ), // Input Voltage
  .VSS    (1'b0          ), // Power Pin
  .clk    (1'b0          ), //Need to connect 200MHz to 75 MHz Core IP Clock
  .paddr  (apb_addr[7:0] ), //Need to connect
  .pclk   (clk_cru       ),
  .penable(apb_en        ),
  .presetn(rst_n_bcpu_bus),
  .psel   (apb_sel_pvt   ),
  .pwdata (apb_wdata     ),
  .pwrite (apb_wr        ),
  .reset_n(rst_n_per     ), // To be fixed. System Async Reset
  //Output
  .TSTOUT (pvt_tstout    ), // Analog Voltage Monitoring
  .prdata (apb_rdata_pvt ),
  .pready (apb_ready_pvt ),
  .pslverr(apb_err_pvt   )
);
//*****************************************************************************
//              SCU registers declaration
//*****************************************************************************
  soc_scu_registers #(
    .AWIDTH  (AWIDTH  ),
    .REGS_NUM(REGS_NUM),
    .DWIDTH  (DWIDTH  ),
    .MAP     (MAP     )
  ) soc_scu_registers (
    .clk                   (clk_cru                    ),
    .rst_n                 (rst_n_sram                 ),
    .rst_n_por             (rst_n_poweron              ),
    .rack_o                (rack                       ),
    .rerr_o                (rerr                       ),
    .rdat_o                (rdat                       ),
    .rreq_i                (rreq                       ),
    .wack_o                (wack                       ),
    .werr_o                (werr                       ),
    .wdat_i                (wdat                       ),
    .wreq_i                (wreq                       ),
    .wstr_i                (wstr                       ),
    .dma_rstn              (dma_rstn                   ),
    .emac_rstn             (emac_rstn                  ),
    .usb_rstn              (usb_rstn                   ),
    .ddr_rstn              (ddr_rstn                   ),
    .fpga1_rstn            (fpga1_rstn                 ),
    .fpga0_rstn            (fpga0_rstn                 ),
    .per_rstn              (per_rstn                   ),
    .bcpu_rstn             (bcpu_rstn                  ),
    .acpu_rstn             (acpu_rstn                  ),
    .dskewcalin            (soc_pll_ctl_dskewcalin     ),
    .pllen                 (soc_pll_ctl_pllen          ),
    .dsmen                 (soc_pll_ctl_dsmen          ),
    .dskewfastcal          (soc_pll_ctl_dskewfastcal   ),
    .dskewcalen            (soc_pll_ctl_dskewcalen     ),
    .dskewcalcnt           (soc_pll_ctl_dskewcalcnt    ),
    .dskewcalbyp           (soc_pll_ctl_dskewcalbyp    ),
    .dacen                 (soc_pll_ctl_dacen          ),
    .refdiv                (soc_pll_ctl_refdiv         ),
    .foutvcoen             (soc_pll_ctl_foutvcoen      ),
    .foutvcobyp            (soc_pll_ctl_foutvcobyp     ),
    .fouten                (soc_pll_ctl_fouten         ),
    .frac                  (soc_pll_ctl_frac           ),
    .fbdiv                 (soc_pll_ctl_fbdiv          ),
    .postdiv1              (soc_pll_ctl_postdiv1       ),
    .postdiv0              (soc_pll_ctl_postdiv0       ),
    .div3                  (div3                       ),
    .div2                  (div2                       ),
    .div1                  (div1                       ),
    .div0                  (div0                       ),
    .div0_clk0             (div0_clk0                  ),
    .div1_clk0             (div1_clk0                  ),
    .div2_clk0             (div2_clk0                  ),
    .div0_clk1             (div0_clk1                  ),
    .pscc_xtal_cg          (pscc_xtal_cg               ),
    .ddr_cfg_ctl_cg        (ddr_cfg_ctl_cg             ),
    .usb_ctl_cg            (usb_ctl_cg                 ),
    .ddr_ctl_cg            (ddr_ctl_cg                 ),
    .ddr_phy_cg            (ddr_phy_cg                 ),
    .gpt_cg                (gpt_cg                     ),
    .gpio_cg               (gpio_cg                    ),
    .uart_cg               (uart_cg                    ),
    .i2c_cg                (i2c_cg                     ),
    .qspi_cg               (qspi_cg                    ),
    .bcpu_cg               (bcpu_cg                    ),
    .sys_dma_cg            (sys_dma_cg                 ),
    .acpu_cg               (acpu_cg                    ),
    .jtag_control          (jtag_control               ),
    .irq_map               (irq_map                    ),
    .irq_mask              (irq_mask                   ),
    .ace_isolation_ctl     (ace_isolation_ctl          ),
    .irq_isolation_ctl     (irq_isolation_ctl          ),
    .fcb_isolation_ctl     (fcb_isolation_ctl          ),
    .ahb_isolation_ctl     (ahb_isolation_ctl          ),
    .axi1_isolation_ctl    (axi1_isolation_ctl         ),
    .axi0_isolation_ctl    (axi0_isolation_ctl         ),
    .rev_id                (rev_id                     ),
    .chip_id               (chip_id                    ),
    .vendor_id             (vendor_id                  ),
    .deassert_bcpu_rstn    (deassert_bcpu_rstn         ),
    .bus_rstn              (rst_n_bcpu_bus             ),
    .sram_rstn             (rst_n_sram                 ),
    .lock                  (soc_pll_status_lock        ),
    .dskewcallock          (soc_pll_status_dskewcallock),
    .dskewcalout           (soc_pll_status_dskewcalout ),
    .clk_sel_status        (clk_sel_status             ),
    .pufcc_rng_fre_en      (pufcc_rng_fre_en           ),
    .pufcc_rng_fre_sel     (pufcc_rng_fre_sel          ),
    .pufcc_rng_fre_out     (pufcc_rng_fre_out          ),
    .usb_wakeup            (usb_wakeup                 ),
    .usb_vbusfault         (usb_vbusfault              ),
    .usb_tsmode            (usb_tsmode                 ),
    .usb_tmodecustom       (usb_tmodecustom            ),
    .usb_tmodeselcustom    (usb_tmodeselcustom         ),
    .usb_pll_bypass        (usb_pll_bypass             ),
    .usb_phy_biston        (usb_phy_biston             ),
    .usb_phy_bistmodesel   (usb_phy_bistmodesel        ),
    .usb_phy_bistmodeen    (usb_phy_bistmodeen         ),
    .usb_phy_bistcomplete  (usb_phy_bistcomplete       ),
    .usb_phy_bisterror     (usb_phy_bisterror          ),
    .usb_phy_bisterrorcount(usb_phy_bisterrorcount     ),
    .bootm                 (bootm                      ),
    .bcpu_wdt_rst          (bcpu_wathcdog_timer_reset  ),
    .fpga_pll3_clk_sel     (fpga_pll3_clk_sel          ),
    .fpga_pll2_clk_sel     (fpga_pll2_clk_sel          ),
    .fpga_pll1_clk_sel     (fpga_pll1_clk_sel          ),
    .fpga_pll0_clk_sel     (fpga_pll0_clk_sel          )
  );

//*****************************************************************************
//              Clock Reset Unit declaration
//*****************************************************************************
  soc_scu_cru soc_scu_cru (
    .clk_sel0                 (clk_sel0                 ),
    .clk_sel1                 (clk_sel1                 ),
    .clk_osc                  (clk_osc                  ),
    .clk_xtal_ref             (clk_xtal_ref             ),
    .clk_pll_soc_ref          (clk_pll_soc_ref          ),
    .rst_n_poweron            (rst_n_poweron            ),
    .clk0                     (clk0                     ),
    .clk1                     (clk1                     ),
    .clk_fpga0                (clk_fpga0                ),
    .clk_fpga1                (clk_fpga1                ),
    .clk_fpga_s               (clk_fpga_s               ),
    .clk_gbe_rx               (clk_gbe_rx               ),
    .clk_gbe_rx_n             (clk_gbe_rx_n             ),
    .clk_acpu                 (clk_acpu                 ),
    .clk_acpu_mtime           (clk_acpu_mtime           ),
    .clk_dma                  (clk_dma                  ),
    .clk_bcpu                 (clk_bcpu                 ),
    .clk_bcpu_mtime           (clk_bcpu_mtime           ),
    .clk_qspi                 (clk_qspi                 ),
    .clk_i2c                  (clk_i2c                  ),
    .clk_uart                 (clk_uart                 ),
    .clk_gpio                 (clk_gpio                 ),
    .clk_gpt                  (clk_gpt                  ),
    .clk_usb                  (clk_usb                  ),
    .clk_cru                  (clk_cru                  ),
    .clk_ddr_phy              (clk_ddr_phy              ),
    .clk_ddr_ctl              (clk_ddr_ctl              ),
    .clk_ddr_cfg              (clk_ddr_cfg              ),
    .clk_pscc_xtl             (clk_pscc_xtl             ),
    .clk_usb_wakeup           (clk_usb_wakeup           ),
    .rst_n_bcpu_core          (rst_n_bcpu               ),
    .rst_n_bcpu_bus           (rst_n_bcpu_bus           ),
    .rst_n_acpu_core          (rst_n_acpu               ),
    .rst_n_acpu_bus           (rst_n_acpu_bus           ),
    .rst_n_sram               (rst_n_sram               ),
    .rst_n_ddr                (rst_n_ddr                ),
    .rst_n_per                (rst_n_per                ),
    .rst_n_usb                (rst_n_usb                ),
    .rst_n_emac               (rst_n_emac               ),
    .rst_n_fpga0              (rst_n_fpga0              ),
    .rst_n_fpga1              (rst_n_fpga1              ),
    .rst_n_fpga_s             (rst_n_fpga_s             ),
    .rst_n_dma                (rst_n_dma                ),
    .rst_n_133                (rst_n_133                ),
    .rst_n_266                (rst_n_266                ),
    .rst_n_533                (rst_n_533                ),
    .rst_n_gbe_tx             (rst_n_gbe_tx             ),
    .rst_n_gbe_ntx            (rst_n_gbe_ntx            ),
    .rst_n_gbe_rx             (rst_n_gbe_rx             ),
    .rst_n_gbe_nrx            (rst_n_gbe_nrx            ),
    .pscc_xtal_cg             (pscc_xtal_cg             ),
    .ddr_cfg_ctl_cg           (ddr_cfg_ctl_cg           ),
    .usb_ctl_cg               (usb_ctl_cg               ),
    .ddr_ctl_cg               (ddr_ctl_cg               ),
    .ddr_phy_cg               (ddr_phy_cg               ),
    .gpt_cg                   (gpt_cg                   ),
    .gpio_cg                  (gpio_cg                  ),
    .uart_cg                  (uart_cg                  ),
    .i2c_cg                   (i2c_cg                   ),
    .qspi_cg                  (qspi_cg                  ),
    .bcpu_cg                  (bcpu_cg                  ),
    .sys_dma_cg               (sys_dma_cg               ),
    .acpu_cg                  (acpu_cg                  ),
    .div3                     (div3                     ),
    .div2                     (div2                     ),
    .div1                     (div1                     ),
    .div0                     (div0                     ),
    .div0_clk0                (div0_clk0                ),
    .div1_clk0                (div1_clk0                ),
    .div2_clk0                (div2_clk0                ),
    .div0_clk1                (div0_clk1                ),
    .sw_dma_rstn              (dma_rstn                 ),
    .sw_emac_rstn             (emac_rstn                ),
    .sw_usb_rstn              (usb_rstn                 ),
    .sw_ddr_rstn              (ddr_rstn                 ),
    .sw_fpga1_rstn            (fpga1_rstn               ),
    .sw_fpga0_rstn            (fpga0_rstn               ),
    .sw_per_rstn              (per_rstn                 ),
    .sw_bcpu_rstn             (bcpu_rstn                ),
    .sw_acpu_rstn             (acpu_rstn                ),
    .bcpu_wathcdog_timer_reset(bcpu_wathcdog_timer_reset),
    .acpu_wathcdog_timer_reset(acpu_wathcdog_timer_reset),
    .soc_pll_status_lock      (soc_pll_status_lock      ),
    .soc_pll_ctl_pllen        (soc_pll_ctl_pllen        ),
    .deassert_bcpu_rstn       (deassert_bcpu_rstn       ),
    .clk_sel_status           (clk_sel_status           )
  );

//*****************************************************************************
//              IRQ control declaration
//*****************************************************************************
  soc_scu_irq_control soc_scu_irq_control (
    .clk_bcpu         (clk_bcpu         ),
    .rst_n_bcpu       (rst_n_bcpu       ),
    .clk_acpu         (clk_acpu         ),
    .rst_n_acpu       (rst_n_acpu       ),
    .clk_cru          (clk_cru          ),
    .rst_n_per        (rst_n_per        ),
    .irq_map          (irq_map          ),
    .irq_mask         (irq_mask         ),
    .acpu_watchdog_irq(acpu_watchdog_irq),
    .bcpu_watchdog_irq(bcpu_watchdog_irq),
    .timer_irq        (timer_irq        ),
    .usb_irq          (usb_irq          ),
    .emac_irq         (emac_irq         ),
    .uart0_irq        (uart0_irq        ),
    .uart1_irq        (uart1_irq        ),
    .qspi_irq         (qspi_irq         ),
    .i2c_irq          (i2c_irq          ),
    .gpio_irq         (gpio_irq         ),
    .dma_irq          (dma_irq          ),
    .ddr_irq          (ddr_irq          ),
    .acpu_mailbox_irq (acpu_mailbox_irq ),
    .bcpu_mailbox_irq (bcpu_mailbox_irq ),
    .fpga0_mailbox_irq(fpga0_mailbox_irq),
    .fpga1_mailbox_irq(fpga1_mailbox_irq),
    .pscc_irq         (pscc_irq         ),
    .fpga_irq_src     (fpga_irq_src     ),
    .acpu_irq_set     (acpu_irq_set     ),
    .bcpu_irq_set     (bcpu_irq_set     ),
    .fpga_irq_set     (fpga_irq_set     )
  );


//*****************************************************************************
//              PAD control declaration
//*****************************************************************************

pad_ctrl #(.AWIDTH(AWIDTH)) pad_ctrl_u (
  .pclk        (clk_cru       ),
  .prst_n      (rst_n_bcpu_bus),
  .paddr       (apb_addr_pad  ),
  .psel        (apb_sel_pad   ),
  .penable     (apb_en        ),
  .pwrite      (apb_wr        ),
  .pwdata      (apb_wdata     ),
  .pstrb       (apb_strb      ),
  .prdata      (apb_rdata_pad ),
  .pready      (apb_ready_pad ),
  .perr        (apb_err_pad   ),

  .pad_c       (pad_c         ), //      | PAD -> DOUT - data to IP
  .pad_i       (pad_i         ), //      | PAD -> DIN  - data from IP
  .pad_oen     (pad_oen       ), //      | PAD -> OE   - out enable from IP
  .pad_ds0     (pad_ds0       ), // DS[0]| PAD -> DS0  - drive strength[0]
  .pad_ds1     (pad_ds1       ), // DS[1]| PAD -> DS1  - drive strength[0]
  .pad_pull_en (pad_pull_en   ), // PUE  | PAD -> PE   - pull-up enable
  .pad_pull_dir(pad_pull_dir  ), // PUD  | PAD -> PUD  - pull-up direction
  .pad_ds2     (              ), //      | unused
  .pad_st      (              ), //      | unused
  .pad_ie      (              ), //      | unused

  .inp_mux     (pad_inp_mux   ), // IP's interface muxing
  .dir_mux     (pad_dir_mux   ), // IP's interface muxing
  .out_mux     (pad_out_mux   )  // IP's interface muxing
);


endmodule
