module soc_scu_cru (
  // input clock control
  input  logic       clk_sel0                 ,
  input  logic       clk_sel1                 ,
  // input OSC clock
  input  logic       clk_osc                  ,
  // input soc xtal clock
  input  logic       clk_xtal_ref             ,
  // PLL ref clock
  output logic       clk_pll_soc_ref          ,  
  // input power on reset
  input  logic       rst_n_poweron            ,
  // input pll's clocks
  input  logic       clk0                     ,
  input  logic       clk1                     ,
  // input FPGA's clocks
  input  logic       clk_fpga0                ,
  input  logic       clk_fpga1                ,
  input  logic       clk_fpga_s               ,
  // input GbE clocks
  input  logic       clk_gbe_rx               ,
  output logic       clk_gbe_rx_n             ,
  // output system's clocks
  output logic       clk_acpu                 ,
  output logic       clk_acpu_mtime           ,
  output logic       clk_dma                  ,
  output logic       clk_bcpu                 ,
  output logic       clk_bcpu_mtime           ,
  output logic       clk_qspi                 ,
  output logic       clk_i2c                  ,
  output logic       clk_uart                 ,
  output logic       clk_gpio                 ,
  output logic       clk_gpt                  ,
  output logic       clk_usb                  ,
  output logic       clk_cru                  ,
  output logic       clk_ddr_phy              ,
  output logic       clk_ddr_ctl              ,
  output logic       clk_ddr_cfg              ,
  output logic       clk_pscc_xtl             ,
  output logic       clk_usb_wakeup           ,
  // output system's resets
  output logic       rst_n_bcpu_core          ,
  output logic       rst_n_bcpu_bus           ,
  output logic       rst_n_acpu_core          ,
  output logic       rst_n_acpu_bus           ,
  output logic       rst_n_sram               ,
  output logic       rst_n_ddr                ,
  output logic       rst_n_per                ,
  output logic       rst_n_usb                ,
  output logic       rst_n_emac               ,
  output logic       rst_n_fpga0              ,
  output logic       rst_n_fpga1              ,
  output logic       rst_n_fpga_s             ,
  output logic       rst_n_dma                ,
  output logic       rst_n_133                ,
  output logic       rst_n_266                ,
  output logic       rst_n_533                ,
  output logic       rst_n_gbe_tx             ,
  output logic       rst_n_gbe_ntx            ,
  output logic       rst_n_gbe_rx             ,
  output logic       rst_n_gbe_nrx            ,
  // clock gate control from register
  input  logic       pscc_xtal_cg             ,
  input  logic       ddr_cfg_ctl_cg           ,
  input  logic       usb_ctl_cg               ,
  input  logic       ddr_ctl_cg               ,
  input  logic       ddr_phy_cg               ,
  input  logic       gpt_cg                   ,
  input  logic       gpio_cg                  ,
  input  logic       uart_cg                  ,
  input  logic       i2c_cg                   ,
  input  logic       qspi_cg                  ,
  input  logic       bcpu_cg                  ,
  input  logic       sys_dma_cg               ,
  input  logic       acpu_cg                  ,
  // main clock dividers
  input  logic [3:0] div0_clk0                ,
  input  logic [3:0] div1_clk0                ,
  input  logic [3:0] div2_clk0                ,
  input  logic [3:0] div0_clk1                ,  
  // clock dividers
  input  logic [3:0] div3                     ,
  input  logic [3:0] div2                     ,
  input  logic [3:0] div1                     ,
  input  logic [3:0] div0                     ,
  // SW reset control from register
  input  logic       sw_dma_rstn              ,
  input  logic       sw_emac_rstn             ,
  input  logic       sw_usb_rstn              ,
  input  logic       sw_ddr_rstn              ,
  input  logic       sw_fpga1_rstn            ,
  input  logic       sw_fpga0_rstn            ,
  input  logic       sw_per_rstn              ,
  input  logic       sw_bcpu_rstn             ,
  input  logic       sw_acpu_rstn             ,
  // watchdog timers
  input  logic       bcpu_wathcdog_timer_reset,
  input  logic       acpu_wathcdog_timer_reset,
  // SOC PLL lock signal
  input  logic       soc_pll_status_lock      ,
  input  logic       soc_pll_ctl_pllen        ,
  // to status register
  output logic       deassert_bcpu_rstn       ,
  output logic [1:0] clk_sel_status
);


//*****************************************************************************
//              Declarations
//*****************************************************************************
logic       rst_n_por_clk1        ;
logic       rst_n_por_osc         ;
logic       bcpu_rst_ctl          ;
logic       bcpu_cnt_en           ;
logic [7:0] bcpu_rst_cnt          ;
logic [1:0] bcpu_cnt_en_rse       ;
logic       bcpu_rst_cnt_start    ;
logic       acpu_rst_ctl          ;
logic       sram_noc_rst_ctl      ;
logic       ddr_controller_rst_ctl;
logic       peripher_rst_ctl      ;
logic       usb_rst_ctl           ;
logic       emac_rst_ctl          ;
logic       fpga0_rst_ctl         ;
logic       fpga1_rst_ctl         ;
logic       dma_rst_ctl           ;
logic [3:0] div1_ff               ;
logic       div1_en               ;
logic [3:0] div1_sync             ;
logic       ddr_phy_cg_sync       ;
logic       ddr_ctl_cg_sync       ;
logic       clksel_save           ;
logic [1:0] clksel                ;
logic       rst_n_poweron_mux     ;
logic       clk_int0              ;
logic       clk_int1              ;
logic       clk_int2              ;
logic       bcpu_rst_ctl_ff       ;
logic       acpu_rst_ctl_ff       ;
logic       clk_mux_int           ;
logic       rst_n_por             ;
logic       clk_int0_div2         ;
logic       clk1_div              ;
logic       clk_mux_osc_xtal      ;
 
//*****************************************************************************
//              Clock OSC PLL muxing
//*****************************************************************************

  always @ (posedge clk_osc or negedge rst_n_poweron) begin
    if (!rst_n_poweron) clksel_save <= 1'h1;
    else                clksel_save <= 1'h0;
  end

  always @ (posedge clk_osc) begin
    if (clksel_save)   clksel <= {clk_sel1, clk_sel0};
  end

  //clkmux clkmux_osc_xtal  (.clka(clk_osc), .clkb(clk_xtal_ref), .select(clksel[1]), .clk_out(clk_mux_osc_xtal));
  assign clk_mux_osc_xtal = clk_osc;
  assign clk_pll_soc_ref = clk_mux_osc_xtal;

  //clkmux clkmux_clk0_div2 (.clka(clk_mux_osc_xtal), .clkb(clk0), .select(clksel[0]), .clk_out(clk_mux_int));
  assign clk_mux_int = clk0;

  always @ (posedge clk_cru or negedge rst_n_133) begin
    if (!rst_n_133) clk_sel_status <= 'h0;
    else            clk_sel_status <= clksel;
  end




//*****************************************************************************
//             Reset source
//*****************************************************************************

assign rst_n_poweron_mux = clk_sel0 ? rst_n_poweron & soc_pll_ctl_pllen : soc_pll_status_lock;

  rstsync rst_sync_poweron
    (
      .clk          (clk_mux_int),
      .rst_soft     (1'b1),
      .rst_async    (rst_n_poweron_mux),
      .rst_sync_out (rst_n_por)
    );

// //*****************************************************************************
// //             Divider reset
// //*****************************************************************************

logic [3:0] div0_clk0_ff; 
logic [3:0] div1_clk0_ff; 
logic [3:0] div2_clk0_ff;
logic [3:0] div3_ff; 
logic [3:0] div2_ff; 
logic [3:0] div1_ff; 
logic [3:0] div0_ff; 


always @ (posedge clk_mux_osc_xtal or negedge rst_n_poweron)begin
  if(!rst_n_poweron) begin
     div0_clk0_ff <= 'h1;
     div1_clk0_ff <= 'h0;
     div2_clk0_ff <= 'h1;
     div3_ff <= 'h0;
     div2_ff <= 'h0;
     div1_ff <= 'h0;
     div0_ff <= 'h0;    
  end
  else if (!soc_pll_ctl_pllen) begin
    div0_clk0_ff <= div0_clk0;
    div1_clk0_ff <= div1_clk0;
    div2_clk0_ff <= div2_clk0; 
    div3_ff      <= div3;
    div2_ff      <= div2;
    div1_ff      <= div1;
    div0_ff      <= div0;      
  end
end

//*****************************************************************************
//             Clk_mux dividers
//*****************************************************************************

 // clk_div #(
 //     .DIVIDER_WIDTH(4)
 //   ) clk_div0 (
 //     .clk     (clk_mux_int), //pll0 or osc
 //     .rst_n   (rst_n_por),
 //     .dvalue  (div0_clk0_ff),
 //     .clk_out (clk_int0) //266 MHz - pll0/4
 //   );

assign clk_int0 = clk_osc;

 // clk_div #(
 //     .DIVIDER_WIDTH(4)
 //   ) clk_div1 (
 //     .clk     (clk_mux_int),
 //     .rst_n   (rst_n_por),
 //     .dvalue  (div1_clk0_ff),
 //     .clk_out (clk_int1) //533/266/133 MHz
 //   );
assign clk_int1 = clk1;

 // clk_div #(
 //     .DIVIDER_WIDTH(4)
 //   ) clk_div2 (
 //     .clk     (clk_mux_int),
 //     .rst_n   (rst_n_por),
 //     .dvalue  (div2_clk0_ff),
 //     .clk_out (clk_int2) // 266/133 MHz
 //   );
assign clk_int2 = clk_osc;



//*****************************************************************************
//              BCPU resets
//*****************************************************************************
  assign bcpu_rst_ctl = rst_n_por & !bcpu_wathcdog_timer_reset & sw_bcpu_rstn;

  always @ (posedge clk_int0 or negedge rst_n_por) begin
    if(!rst_n_por) bcpu_rst_ctl_ff <= 'h0;
    else           bcpu_rst_ctl_ff <= bcpu_rst_ctl;
  end

  rstsync rst_sync_bcpu
    (
      .clk          (clk_int0),
      .rst_soft     (1'b1),
      .rst_async    (bcpu_rst_ctl_ff),
      .rst_sync_out (bcpu_cnt_en)
    );

  always @ (posedge clk_int0) begin
    bcpu_cnt_en_rse <= {bcpu_cnt_en_rse[0], bcpu_cnt_en};
  end

  always @ (posedge clk_int0 or negedge rst_n_266) begin
    if (!rst_n_266)                                    bcpu_rst_cnt_start <= 1'h1;
    else if (!bcpu_cnt_en_rse[0] & bcpu_cnt_en_rse[1]) bcpu_rst_cnt_start <= 1'h1;
    else if (deassert_bcpu_rstn)                       bcpu_rst_cnt_start <= 1'h0;
  end

  always @ (posedge clk_int0 or negedge rst_n_266) begin
    if (!rst_n_266)             bcpu_rst_cnt <= 'h0;
    else if (bcpu_rst_cnt_start) bcpu_rst_cnt <= bcpu_rst_cnt + 1'h1;
    else                         bcpu_rst_cnt <= 'h0;
  end

  always @ (posedge clk_int0 or negedge rst_n_266) begin
    if (!rst_n_266)             rst_n_bcpu_core <= 'h0;
    else if (bcpu_rst_cnt_start) rst_n_bcpu_core <= bcpu_rst_cnt >= 8'h20;
  end

  always @ (posedge clk_int0 or negedge rst_n_266) begin
    if (!rst_n_266)             rst_n_bcpu_bus <= 'h0;
    else if (bcpu_rst_cnt_start) rst_n_bcpu_bus <= bcpu_rst_cnt >= 8'h10;
  end

  assign deassert_bcpu_rstn = bcpu_rst_cnt[5];

//*****************************************************************************
//              ACPU resets
//*****************************************************************************
  assign acpu_rst_ctl = rst_n_por & !acpu_wathcdog_timer_reset & sw_acpu_rstn;

  always @ (posedge clk_int1 or negedge rst_n_por) begin
    if(!rst_n_por) acpu_rst_ctl_ff <= 'h0;
    else           acpu_rst_ctl_ff <= acpu_rst_ctl;
  end

  rstsync rst_sync_acpu_bus
    (
      .clk          (clk_int1),
      .rst_soft     (1'b1),
      .rst_async    (acpu_rst_ctl_ff),
      .rst_sync_out (rst_n_acpu_bus)
    );

  rstsync rst_sync_acpu_core
    (
      .clk          (clk_int1),
      .rst_soft     (1'b1),
      .rst_async    (rst_n_acpu_bus),
      .rst_sync_out (rst_n_acpu_core)
    );

//*****************************************************************************
//              Peripheral resets
//*****************************************************************************

  rstsync rst_sync_clk_133
    (
      .clk          (clk_int1),
      .rst_soft     (1'b1),
      .rst_async    (rst_n_por),
      .rst_sync_out (rst_n_533)
    );

  rstsync rst_sync_clk_266
    (
      .clk          (clk_int0),
      .rst_soft     (1'b1),
      .rst_async    (rst_n_por),
      .rst_sync_out (rst_n_266)
    );

  rstsync rst_sync_clk_533
    (
      .clk          (clk_cru),
      .rst_soft     (1'b1),
      .rst_async    (rst_n_por),
      .rst_sync_out (rst_n_133)
    );

//*****************************************************************************
//              SRAM
//*****************************************************************************
  assign sram_noc_rst_ctl = rst_n_por;
  rstsync rst_sync_sram_noc
    (
      .clk          (clk_int1),
      .rst_soft     (1'b1),
      .rst_async    (sram_noc_rst_ctl),
      .rst_sync_out (rst_n_sram)
    );

//*****************************************************************************
//              DDR mem controller reset
//*****************************************************************************
  assign ddr_controller_rst_ctl = rst_n_por & sw_ddr_rstn;
  rstsync rst_sync_ddr_controller
    (
      .clk          (clk_int1),
      .rst_soft     (1'b1),
      .rst_async    (ddr_controller_rst_ctl),
      .rst_sync_out (rst_n_ddr)
    );

//*****************************************************************************
//              Peripherial reset
//*****************************************************************************
  assign peripher_rst_ctl = rst_n_por & sw_per_rstn;
  rstsync rst_sync_peripher
    (
      .clk          (clk_cru),
      .rst_soft     (1'b1),
      .rst_async    (peripher_rst_ctl),
      .rst_sync_out (rst_n_per)
    );
//*****************************************************************************
//              USB reset
//*****************************************************************************
  assign usb_rst_ctl = rst_n_por & sw_usb_rstn;
  rstsync rst_sync_usb
    (
      .clk          (clk_int2),
      .rst_soft     (1'b1),
      .rst_async    (usb_rst_ctl),
      .rst_sync_out (rst_n_usb)
    );
//*****************************************************************************
//              GbE reset
//*****************************************************************************

  assign clk_gbe_rx_n = ~clk_gbe_rx;

  assign emac_rst_ctl = rst_n_por & sw_emac_rstn;

  rstsync rst_sync_emac (
    .clk         (clk_int2    ),
    .rst_soft    (1'b1        ),
    .rst_async   (emac_rst_ctl),
    .rst_sync_out(rst_n_emac  )
  );

  rstsync rst_sync_gbe_txreset (
    .clk         (clk_gbe_rx  ),
    .rst_soft    (1'b1        ),
    .rst_async   (rst_n_por   ),
    .rst_sync_out(rst_n_gbe_tx)
  );

  rstsync rst_sync_gbe_ntxreset (
    .clk         (clk_gbe_rx_n  ),
    .rst_soft    (1'b1          ),
    .rst_async   (rst_n_por     ),
    .rst_sync_out(rst_n_gbe_ntx )
  );

  rstsync rst_sync_gbe_rxreset (
    .clk         (clk_gbe_rx  ),
    .rst_soft    (1'b1        ),
    .rst_async   (rst_n_por   ),
    .rst_sync_out(rst_n_gbe_rx)
  );

  rstsync rst_sync_gbe_nrxreset (
    .clk         (clk_gbe_rx_n  ),
    .rst_soft    (1'b1          ),
    .rst_async   (rst_n_por     ),
    .rst_sync_out(rst_n_gbe_nrx )
  );


//*****************************************************************************
//              FPGA resets
//*****************************************************************************
  assign fpga0_rst_ctl = rst_n_por & sw_fpga0_rstn;
  rstsync rst_sync_fpga0
    (
      .clk          (clk_fpga0),
      .rst_soft     (1'b1),
      .rst_async    (fpga0_rst_ctl),
      .rst_sync_out (rst_n_fpga0)
    );

  assign fpga1_rst_ctl = rst_n_por & sw_fpga1_rstn;
  rstsync rst_sync_fpga1
    (
      .clk          (clk_fpga1),
      .rst_soft     (1'b1),
      .rst_async    (fpga1_rst_ctl),
      .rst_sync_out (rst_n_fpga1)
    );

  rstsync rst_sync_fpga_s
    (
      .clk          (clk_fpga_s),
      .rst_soft     (1'b1),
      .rst_async    (fpga0_rst_ctl | fpga1_rst_ctl),
      .rst_sync_out (rst_n_fpga_s)
    );

//*****************************************************************************
//              DMA reset
//*****************************************************************************
    assign dma_rst_ctl = rst_n_por & sw_dma_rstn;
    rstsync rst_sync_dma
      (
        .clk          (clk_int2),
        .rst_soft     (1'b1),
        .rst_async    (dma_rst_ctl),
        .rst_sync_out (rst_n_dma)
      );
//*****************************************************************************
//              Clock divider 1 for QSPI, I2C, uart, GPIO, GPT logic
//*****************************************************************************

 // clk_div #(
 //     .DIVIDER_WIDTH(4)
 //   ) clk_div3 (
 //     .clk     (clk_int0),   // 266 MHz
 //     .rst_n   (rst_n_266),
 //     .dvalue  (div0_ff),
 //     .clk_out (clk_int0_div2) // 133 MHz
 //   );
assign clk_int0_div2 = clk_xtal_ref;

//*****************************************************************************
//              Clock divider 2 for DDR controller logic
//*****************************************************************************

  rstsync rst_sync_clk1
    (
      .clk          (clk1),
      .rst_soft     (1'b1),
      .rst_async    (rst_n_por),
      .rst_sync_out (rst_n_por_clk1)
    );

logic bypass;
logic [3:0] div0_clk1_ff;

logic clk1_ddr_phy_div;

always @ (posedge clk1 or negedge rst_n_por_clk1)
  if(!rst_n_por_clk1) bypass <= 'h1;
  else                bypass <= div0_clk1=='h0;

always @ (posedge clk1 or negedge rst_n_por_clk1)
  if(!rst_n_por_clk1) div0_clk1_ff <= 'h0;
  else                div0_clk1_ff <= div0_clk1_ff - 'h1;


 // clk_div #(
 //     .DIVIDER_WIDTH(4),
 //     .BYPASS_EN(1)
 //   ) clk_div_ddr_phy (
 //     .clk     (clk1),          
 //     .rst_n   (rst_n_por_clk1),
 //     .dvalue  (div0_clk1_ff),
 //     .bypass  (bypass),
 //     .clk_out (clk1_ddr_phy_div)       
 //   );
 assign clk1_ddr_phy_div = clk1;

//  clk_div #(
//      .DIVIDER_WIDTH(4)
//    ) clk_div4 (
//      .clk     (clk1_ddr_phy_div),  //1600 MHz
//      .rst_n   (rst_n_por_clk1),
//      .dvalue  (div1_ff),
//      .clk_out (clk1_div)       //800 MHz
//    );
 assign clk1_div = clk1;

//*****************************************************************************
//              Clock divider 3 for pscc xtal clock
//*****************************************************************************
  logic clk_pscc_div_ug;

  rstsync rst_sync_osc
    (
      .clk          (clk_osc),
      .rst_soft     (1'b1),
      .rst_async    (rst_n_por),
      .rst_sync_out (rst_n_por_osc)
    );


 // clk_div #(
 //     .DIVIDER_WIDTH(4)
 //   ) clk_pscc_div (
 //     .clk     (clk_osc),     // 50 MHz
 //     .rst_n   (rst_n_por_osc),
 //     .dvalue  (div2_ff),
 //     .clk_out (clk_pscc_div_ug) //25 MHz
 //   );

assign clk_pscc_div_ug = clk_xtal_ref;

//*****************************************************************************
//              Clock divider 4 for mtime ACPU/BCPU clock
//*****************************************************************************
logic [3:0] div3_clk1_sync;
logic [3:0] div3_clk0_sync;
logic clk_acpu_mtime_ug;
logic clk_bcpu_mtime_ug;

  sync_bus #(.DWIDTH(4)) sync_bus_div3_clk1 (
    .clk_in     (clk_cru       ),
    .clk_out    (clk_int1      ),
    .rst_n_in   (rst_n_133     ),
    .rst_n_out  (rst_n_533     ),
    .bus_vld_in (1'b1          ),
    .bus_in     (div3_ff       ),
    .bus_vld_out(              ),
    .bus_out    (div3_clk1_sync)
  );

  logic rst_acpu_div_sync;
  rstsync rst_sync_acpu_div
    (
      .clk          (clk_int1),
      .rst_soft     (1'b1),
      .rst_async    (rst_n_533),
      .rst_sync_out (rst_acpu_div_sync)
    );

 // clk_div #(
 //     .DIVIDER_WIDTH(4)
 //   ) clk_acpu_div (
 //     .clk     (clk_int1),     // 533 MHz
 //     .rst_n   (rst_acpu_div_sync),
 //     .dvalue  (div3_clk1_sync),
 //     .clk_out (clk_acpu_mtime_ug) //266 MHz
 //   );
assign clk_acpu_mtime_ug = clk1;

  sync_bus #(.DWIDTH(4)) sync_bus_div3_clk0 (
    .clk_in     (clk_cru       ),
    .clk_out    (clk_int0      ),
    .rst_n_in   (rst_n_133     ),
    .rst_n_out  (rst_n_266     ),
    .bus_vld_in (1'b1          ),
    .bus_in     (div3_ff       ),
    .bus_vld_out(              ),
    .bus_out    (div3_clk0_sync)
  );   

  logic rst_bcpu_div_sync;
  rstsync rst_sync_bcpu_div
    (
      .clk          (clk_int0),
      .rst_soft     (1'b1),
      .rst_async    (rst_n_266),
      .rst_sync_out (rst_bcpu_div_sync)
    );  

//  clk_div #(
//      .DIVIDER_WIDTH(4)
//    ) clk_bcpu_div (
//      .clk     (clk_int0),     // 266 MHz
//      .rst_n   (rst_bcpu_div_sync),
//      .dvalue  (div3_clk0_sync),
//      .clk_out (clk_bcpu_mtime_ug) //133 MHz
//    );    

assign clk_bcpu_mtime_ug = clk_xtal_ref;

//*****************************************************************************
//              Clock divider 5 for usb wakeup clock
//*****************************************************************************

//  clk_div #(
//      .DIVIDER_WIDTH(13)
//    ) clk_usb_wakeup_div (
//      .clk     (clk_osc),     // 50 MHz
//      .rst_n   (rst_n_por_osc),
//      .dvalue  (13'h1387),
//      .clk_out (clk_usb_wakeup) //5 kHz
//    );   

assign clk_usb_wakeup = clk_xtal_ref; 

//*****************************************************************************
//              Clock gating
//*****************************************************************************

    sync_ff #(
      .SYNC_STAGE(2),
      .DWIDTH(1)
    ) sync_ddr_phy_cg (
      .clk   (clk1_ddr_phy_div),
      .rst_n (rst_n_por_clk1),
      .din   (ddr_phy_cg),
      .dout  (ddr_phy_cg_sync)
    );

    sync_ff #(
      .SYNC_STAGE(2),
      .DWIDTH(1)
    ) sync_ddr_ctl_cg (
      .clk   (clk1_div),
      .rst_n (rst_n_por_clk1),
      .din   (ddr_ctl_cg),
      .dout  (ddr_ctl_cg_sync)
    );



  clkgate clkgate_clk_acpu        (.clk(clk_int1),          .clk_en(acpu_cg),         .clk_out(clk_acpu));
  clkgate clkgate_clk_acpu_mtime  (.clk(clk_acpu_mtime_ug), .clk_en(acpu_cg),         .clk_out(clk_acpu_mtime));
  clkgate clkgate_clk_dma         (.clk(clk_int2),          .clk_en(sys_dma_cg),      .clk_out(clk_dma));
  clkgate clkgate_clk_bcpu        (.clk(clk_int0),          .clk_en(bcpu_cg),         .clk_out(clk_bcpu));
  clkgate clkgate_clk_bcpu_mtime  (.clk(clk_bcpu_mtime_ug), .clk_en(bcpu_cg),         .clk_out(clk_bcpu_mtime));  
  clkgate clkgate_clk_qspi        (.clk(clk_int0_div2),     .clk_en(qspi_cg),         .clk_out(clk_qspi));
  clkgate clkgate_clk_i2c         (.clk(clk_int0_div2),     .clk_en(i2c_cg),          .clk_out(clk_i2c));
  clkgate clkgate_clk_uart        (.clk(clk_int0_div2),     .clk_en(uart_cg),         .clk_out(clk_uart));
  clkgate clkgate_clk_gpio        (.clk(clk_int0_div2),     .clk_en(gpio_cg),         .clk_out(clk_gpio));
  clkgate clkgate_clk_gpt         (.clk(clk_int0_div2),     .clk_en(gpt_cg),          .clk_out(clk_gpt));
  clkgate clkgate_clk_usb         (.clk(clk_int0_div2),     .clk_en(usb_ctl_cg),      .clk_out(clk_usb)); 
  clkgate clkgate_clk_ddr_cfg     (.clk(clk_int0_div2),     .clk_en(ddr_cfg_ctl_cg),  .clk_out(clk_ddr_cfg));   
  clkgate clkgate_clk_cru         (.clk(clk_int0_div2),     .clk_en(1'b1),            .clk_out(clk_cru));
  clkgate clkgate_clk_ddr_phy     (.clk(clk1_ddr_phy_div),  .clk_en(ddr_phy_cg_sync), .clk_out(clk_ddr_phy));
  clkgate clkgate_clk_ddr_ctl     (.clk(clk1_div),          .clk_en(ddr_ctl_cg_sync), .clk_out(clk_ddr_ctl));
  clkgate clkgate_clk_pscc_xtl    (.clk(clk_pscc_div_ug),   .clk_en(pscc_xtal_cg),    .clk_out(clk_pscc_xtl));

endmodule
