module soc_scu_registers #(
  parameter                       AWIDTH   = 8 ,
  parameter                       REGS_NUM = 43,
  parameter                       DWIDTH   = 32,
  parameter [AWIDTH*REGS_NUM-1:0] MAP      = 0
) (
  // system
  input  logic                     clk                   ,
  input  logic                     rst_n                 ,
  input  logic                     rst_n_por             ,
  // read apb_manager
  output logic                     rack_o                ,
  output logic                     rerr_o                ,
  output logic [  DWIDTH-1:0]      rdat_o                ,
  input  logic [REGS_NUM-1:0]      rreq_i                ,
  // write apb_manager
  output logic                     wack_o                ,
  output logic                     werr_o                ,
  input  logic [  DWIDTH-1:0]      wdat_i                ,
  input  logic [REGS_NUM-1:0]      wreq_i                ,
  input  logic [DWIDTH/8-1:0]      wstr_i                ,
  // control registers
  output logic                     dma_rstn              ,
  output logic                     emac_rstn             ,
  output logic                     usb_rstn              ,
  output logic                     ddr_rstn              ,
  output logic                     fpga1_rstn            ,
  output logic                     fpga0_rstn            ,
  output logic                     per_rstn              ,
  output logic                     bcpu_rstn             ,
  output logic                     acpu_rstn             ,
  output logic [        11:0]      dskewcalin            ,
  output logic                     pllen                 ,
  output logic                     dsmen                 ,
  output logic                     dskewfastcal          ,
  output logic                     dskewcalen            ,
  output logic [         2:0]      dskewcalcnt           ,
  output logic                     dskewcalbyp           ,
  output logic                     dacen                 ,
  output logic [         5:0]      refdiv                ,
  output logic                     foutvcoen             ,
  output logic [         4:0]      foutvcobyp            ,
  output logic [         3:0]      fouten                ,
  output logic [        23:0]      frac                  ,
  output logic [        11:0]      fbdiv                 ,
  output logic [         3:0]      postdiv1              ,
  output logic [         3:0]      postdiv0              ,
  output logic [         3:0]      div3                  ,
  output logic [         3:0]      div2                  ,
  output logic [         3:0]      div1                  ,
  output logic [         3:0]      div0                  ,
  output logic [         3:0]      div0_clk0             ,
  output logic [         3:0]      div1_clk0             ,
  output logic [         3:0]      div2_clk0             ,
  output logic [         3:0]      div0_clk1             ,
  output logic                     pscc_xtal_cg          ,
  output logic                     ddr_cfg_ctl_cg        ,
  output logic                     usb_ctl_cg            ,
  output logic                     ddr_ctl_cg            ,
  output logic                     ddr_phy_cg            ,
  output logic                     gpt_cg                ,
  output logic                     gpio_cg               ,
  output logic                     uart_cg               ,
  output logic                     i2c_cg                ,
  output logic                     qspi_cg               ,
  output logic                     bcpu_cg               ,
  output logic                     sys_dma_cg            ,
  output logic                     acpu_cg               ,
  output logic [         1:0]      jtag_control          ,
  output logic [        31:0][2:0] irq_map               ,
  output logic [        31:0]      irq_mask              ,
  output logic                     ace_isolation_ctl     ,
  output logic                     irq_isolation_ctl     ,
  output logic                     fcb_isolation_ctl     ,
  output logic                     ahb_isolation_ctl     ,
  output logic                     axi1_isolation_ctl    ,
  output logic                     axi0_isolation_ctl    ,
  // id
  input  logic [         7:0]      rev_id                ,
  input  logic [         7:0]      chip_id               ,
  input  logic [        15:0]      vendor_id             ,
  // reset signals
  input  logic                     deassert_bcpu_rstn    ,
  input  logic                     bus_rstn              ,
  input  logic                     sram_rstn             ,
  // pll status
  input  logic                     lock                  ,
  input  logic                     dskewcallock          ,
  input  logic [        11:0]      dskewcalout           ,
  // clock select status
  input  logic [         1:0]      clk_sel_status        ,
  // PUFCC
  output logic                     pufcc_rng_fre_en      ,
  output logic                     pufcc_rng_fre_sel     ,
  input  logic                     pufcc_rng_fre_out     ,
  // USB
  output logic                     usb_wakeup            ,
  output logic                     usb_vbusfault         ,
  output logic [         1:0]      usb_tsmode            ,
  input  logic                     usb_tmodecustom       ,
  input  logic [         7:0]      usb_tmodeselcustom    ,
  output logic                     usb_pll_bypass        ,
  output logic                     usb_phy_biston        ,
  output logic [         3:0]      usb_phy_bistmodesel   ,
  output logic                     usb_phy_bistmodeen    ,
  input  logic                     usb_phy_bistcomplete  ,
  input  logic                     usb_phy_bisterror     ,
  input  logic [         7:0]      usb_phy_bisterrorcount,
  // boot mode
  input  logic [         2:0]      bootm                 ,
  // BCPU wdt reset
  input  logic                     bcpu_wdt_rst          ,
  // FPGA PLL's control
  output logic [         1:0]      fpga_pll3_clk_sel     ,
  output logic [         1:0]      fpga_pll2_clk_sel     ,
  output logic [         1:0]      fpga_pll1_clk_sel     ,
  output logic [         1:0]      fpga_pll0_clk_sel     ,
  // WDT pause
  output logic                     acpu_wdt_pause        ,
  output logic                     bcpu_wdt_pause
);

//*****************************************************************************
//              Declarations
//*****************************************************************************
logic [31:0]       rg_rdat_mux                 ;
logic [31:0]       rg_rdat_mux_d               ;
logic [31:0]       wstr_b                      ;

logic              rg_idrev_rreq               ;
logic              rg_sw_rst_control_rreq      ;
logic              rg_pll_config_0_rreq        ;
logic              rg_pll_config_1_rreq        ;
logic              rg_pll_config_2_rreq        ;
logic              rg_pll_config_3_rreq        ;
logic              rg_pll_config_4_rreq        ;
logic              rg_pll_status_rreq          ;
logic              rg_divider_conctrol_rreq    ;
logic              rg_gating_control_rreq      ;
logic              rg_debug_control_rreq       ;
logic [31:0]       rg_irq_mask_map_control_rreq;
logic              rg_isolation_control_rreq   ;
logic              rg_bootstrap_status_rreq    ;
logic              rg_main_divider_conctrol_rreq;
logic              rg_pufcc_rreq               ;
logic              rg_usb_ctrl_rreq            ;
logic              rg_fpga_pll_clk_sel_rreq    ;
logic              rg_wdt_pause_rreq           ;

logic              rg_sw_rst_control_wreq      ;
logic              rg_pll_config_0_wreq        ;
logic              rg_pll_config_1_wreq        ;
logic              rg_pll_config_2_wreq        ;
logic              rg_pll_config_3_wreq        ;
logic              rg_pll_config_4_wreq        ;
logic              rg_divider_conctrol_wreq    ;
logic              rg_gating_control_wreq      ;
logic              rg_debug_control_wreq       ;
logic [31:0]       rg_irq_mask_map_control_wreq;
logic              rg_isolation_control_wreq   ;
logic              rg_main_divider_conctrol_wreq;
logic              rg_pufcc_wreq               ;
logic              rg_usb_ctrl_wreq            ;
logic              rg_usb_ctrlc_wreq           ;
logic              rg_fpga_pll_clk_sel_wreq    ;
logic              rg_wdt_pause_wreq;

logic [31:0]       rg_idrev                    ;
logic [31:0]       rg_sw_rst_control           ;
logic [31:0]       rg_pll_config_0             ;
logic [31:0]       rg_pll_config_1             ;
logic [31:0]       rg_pll_config_2             ;
logic [31:0]       rg_pll_config_3             ;
logic [31:0]       rg_pll_config_4             ;
logic [31:0]       rg_pll_status               ;
logic [31:0]       rg_divider_conctrol         ;
logic [31:0]       rg_gating_control           ;
logic [31:0]       rg_debug_control            ;
logic [31:0][31:0] rg_irq_mask_map_control     ;
logic [31:0]       rg_isolation_control        ;
logic [31:0]       rg_bootstrap_status         ;
logic [31:0]       rg_main_divider_conctrol    ;
logic [31:0]       rg_pufcc                    ;
logic [31:0]       rg_usb_ctrl                 ;
logic [31:0]       rg_fpga_pll_clk_sel         ;
logic [31:0]       rg_wdt_pause                ;

//*****************************************************************************
//              Registers Access logic
//*****************************************************************************
assign wstr_b = {
                {8{wstr_i[3]}},
                {8{wstr_i[2]}},
                {8{wstr_i[1]}},
                {8{wstr_i[0]}}
                };

//write req
assign rg_sw_rst_control_wreq           = wreq_i[1];
assign rg_pll_config_0_wreq             = wreq_i[2];
assign rg_pll_config_1_wreq             = wreq_i[3];
assign rg_pll_config_2_wreq             = wreq_i[4];
assign rg_pll_config_3_wreq             = wreq_i[5];
assign rg_pll_config_4_wreq             = wreq_i[6];
assign rg_divider_conctrol_wreq         = wreq_i[8];
assign rg_gating_control_wreq           = wreq_i[9];
assign rg_debug_control_wreq            = wreq_i[10];
assign rg_irq_mask_map_control_wreq[0]  = wreq_i[11];
assign rg_irq_mask_map_control_wreq[1]  = wreq_i[12];
assign rg_irq_mask_map_control_wreq[2]  = wreq_i[13];
assign rg_irq_mask_map_control_wreq[3]  = wreq_i[14];
assign rg_irq_mask_map_control_wreq[4]  = wreq_i[15];
assign rg_irq_mask_map_control_wreq[5]  = wreq_i[16];
assign rg_irq_mask_map_control_wreq[6]  = wreq_i[17];
assign rg_irq_mask_map_control_wreq[7]  = wreq_i[18];
assign rg_irq_mask_map_control_wreq[8]  = wreq_i[19];
assign rg_irq_mask_map_control_wreq[9]  = wreq_i[20];
assign rg_irq_mask_map_control_wreq[10] = wreq_i[21];
assign rg_irq_mask_map_control_wreq[11] = wreq_i[22];
assign rg_irq_mask_map_control_wreq[12] = wreq_i[23];
assign rg_irq_mask_map_control_wreq[13] = wreq_i[24];
assign rg_irq_mask_map_control_wreq[14] = wreq_i[25];
assign rg_irq_mask_map_control_wreq[15] = wreq_i[26];
assign rg_irq_mask_map_control_wreq[16] = wreq_i[27];
assign rg_irq_mask_map_control_wreq[17] = wreq_i[28];
assign rg_irq_mask_map_control_wreq[18] = wreq_i[29];
assign rg_irq_mask_map_control_wreq[19] = wreq_i[30];
assign rg_irq_mask_map_control_wreq[20] = wreq_i[31];
assign rg_irq_mask_map_control_wreq[21] = wreq_i[32];
assign rg_irq_mask_map_control_wreq[22] = wreq_i[33];
assign rg_irq_mask_map_control_wreq[23] = wreq_i[34];
assign rg_irq_mask_map_control_wreq[24] = wreq_i[35];
assign rg_irq_mask_map_control_wreq[25] = wreq_i[36];
assign rg_irq_mask_map_control_wreq[26] = wreq_i[37];
assign rg_irq_mask_map_control_wreq[27] = wreq_i[38];
assign rg_irq_mask_map_control_wreq[28] = wreq_i[39];
assign rg_irq_mask_map_control_wreq[29] = wreq_i[40];
assign rg_irq_mask_map_control_wreq[30] = wreq_i[41];
assign rg_irq_mask_map_control_wreq[31] = wreq_i[42];
assign rg_isolation_control_wreq        = wreq_i[43];
assign rg_main_divider_conctrol_wreq    = wreq_i[45];
assign rg_pufcc_wreq                    = wreq_i[46];
assign rg_usb_ctrl_wreq                 = wreq_i[47];
assign rg_fpga_pll_clk_sel_wreq         = wreq_i[48];
assign rg_wdt_pause_wreq                = wreq_i[49];
//read req
assign rg_idrev_rreq                    = rreq_i[0];
assign rg_sw_rst_control_rreq           = rreq_i[1];
assign rg_pll_config_0_rreq             = rreq_i[2];
assign rg_pll_config_1_rreq             = rreq_i[3];
assign rg_pll_config_2_rreq             = rreq_i[4];
assign rg_pll_config_3_rreq             = rreq_i[5];
assign rg_pll_config_4_rreq             = rreq_i[6];
assign rg_pll_status_rreq               = rreq_i[7];
assign rg_divider_conctrol_rreq         = rreq_i[8];
assign rg_gating_control_rreq           = rreq_i[9];
assign rg_debug_control_rreq            = rreq_i[10];
assign rg_irq_mask_map_control_rreq[0]  = rreq_i[11];
assign rg_irq_mask_map_control_rreq[1]  = rreq_i[12];
assign rg_irq_mask_map_control_rreq[2]  = rreq_i[13];
assign rg_irq_mask_map_control_rreq[3]  = rreq_i[14];
assign rg_irq_mask_map_control_rreq[4]  = rreq_i[15];
assign rg_irq_mask_map_control_rreq[5]  = rreq_i[16];
assign rg_irq_mask_map_control_rreq[6]  = rreq_i[17];
assign rg_irq_mask_map_control_rreq[7]  = rreq_i[18];
assign rg_irq_mask_map_control_rreq[8]  = rreq_i[19];
assign rg_irq_mask_map_control_rreq[9]  = rreq_i[20];
assign rg_irq_mask_map_control_rreq[10] = rreq_i[21];
assign rg_irq_mask_map_control_rreq[11] = rreq_i[22];
assign rg_irq_mask_map_control_rreq[12] = rreq_i[23];
assign rg_irq_mask_map_control_rreq[13] = rreq_i[24];
assign rg_irq_mask_map_control_rreq[14] = rreq_i[25];
assign rg_irq_mask_map_control_rreq[15] = rreq_i[26];
assign rg_irq_mask_map_control_rreq[16] = rreq_i[27];
assign rg_irq_mask_map_control_rreq[17] = rreq_i[28];
assign rg_irq_mask_map_control_rreq[18] = rreq_i[29];
assign rg_irq_mask_map_control_rreq[19] = rreq_i[30];
assign rg_irq_mask_map_control_rreq[20] = rreq_i[31];
assign rg_irq_mask_map_control_rreq[21] = rreq_i[32];
assign rg_irq_mask_map_control_rreq[22] = rreq_i[33];
assign rg_irq_mask_map_control_rreq[23] = rreq_i[34];
assign rg_irq_mask_map_control_rreq[24] = rreq_i[35];
assign rg_irq_mask_map_control_rreq[25] = rreq_i[36];
assign rg_irq_mask_map_control_rreq[26] = rreq_i[37];
assign rg_irq_mask_map_control_rreq[27] = rreq_i[38];
assign rg_irq_mask_map_control_rreq[28] = rreq_i[39];
assign rg_irq_mask_map_control_rreq[29] = rreq_i[40];
assign rg_irq_mask_map_control_rreq[30] = rreq_i[41];
assign rg_irq_mask_map_control_rreq[31] = rreq_i[42];
assign rg_isolation_control_rreq        = rreq_i[43];
assign rg_bootstrap_status_rreq         = rreq_i[44];
assign rg_main_divider_conctrol_rreq    = rreq_i[45];
assign rg_pufcc_rreq                    = rreq_i[46];
assign rg_usb_ctrl_rreq                 = rreq_i[47];
assign rg_fpga_pll_clk_sel_rreq         = rreq_i[48];
assign rg_wdt_pause_rreq                = rreq_i[49];

assign rg_rdat_mux = (rg_idrev_rreq)                   ? rg_idrev :
                     (rg_sw_rst_control_rreq)          ? rg_sw_rst_control :
                     (rg_pll_config_0_rreq)            ? rg_pll_config_0 :
                     (rg_pll_config_1_rreq)            ? rg_pll_config_1 :
                     (rg_pll_config_2_rreq)            ? rg_pll_config_2 :
                     (rg_pll_config_3_rreq)            ? rg_pll_config_3 :
                     (rg_pll_config_4_rreq)            ? rg_pll_config_4 :
                     (rg_pll_status_rreq)              ? rg_pll_status :
                     (rg_divider_conctrol_rreq)        ? rg_divider_conctrol :
                     (rg_gating_control_rreq)          ? rg_gating_control :
                     (rg_debug_control_rreq)           ? rg_debug_control :
                     (rg_irq_mask_map_control_rreq[0]) ? rg_irq_mask_map_control[0]:
                     (rg_irq_mask_map_control_rreq[1]) ? rg_irq_mask_map_control[1]:
                     (rg_irq_mask_map_control_rreq[2]) ? rg_irq_mask_map_control[2]:
                     (rg_irq_mask_map_control_rreq[3]) ? rg_irq_mask_map_control[3]:
                     (rg_irq_mask_map_control_rreq[4]) ? rg_irq_mask_map_control[4]:
                     (rg_irq_mask_map_control_rreq[5]) ? rg_irq_mask_map_control[5]:
                     (rg_irq_mask_map_control_rreq[6]) ? rg_irq_mask_map_control[6]:
                     (rg_irq_mask_map_control_rreq[7]) ? rg_irq_mask_map_control[7]:
                     (rg_irq_mask_map_control_rreq[8]) ? rg_irq_mask_map_control[8]:
                     (rg_irq_mask_map_control_rreq[9]) ? rg_irq_mask_map_control[9]:
                     (rg_irq_mask_map_control_rreq[10])? rg_irq_mask_map_control[10]:
                     (rg_irq_mask_map_control_rreq[11])? rg_irq_mask_map_control[11]:
                     (rg_irq_mask_map_control_rreq[12])? rg_irq_mask_map_control[12]:
                     (rg_irq_mask_map_control_rreq[13])? rg_irq_mask_map_control[13]:
                     (rg_irq_mask_map_control_rreq[14])? rg_irq_mask_map_control[14]:
                     (rg_irq_mask_map_control_rreq[15])? rg_irq_mask_map_control[15]:
                     (rg_irq_mask_map_control_rreq[16])? rg_irq_mask_map_control[16]:
                     (rg_irq_mask_map_control_rreq[17])? rg_irq_mask_map_control[17]:
                     (rg_irq_mask_map_control_rreq[18])? rg_irq_mask_map_control[18]:
                     (rg_irq_mask_map_control_rreq[19])? rg_irq_mask_map_control[19]:
                     (rg_irq_mask_map_control_rreq[20])? rg_irq_mask_map_control[20]:
                     (rg_irq_mask_map_control_rreq[21])? rg_irq_mask_map_control[21]:
                     (rg_irq_mask_map_control_rreq[22])? rg_irq_mask_map_control[22]:
                     (rg_irq_mask_map_control_rreq[23])? rg_irq_mask_map_control[23]:
                     (rg_irq_mask_map_control_rreq[24])? rg_irq_mask_map_control[24]:
                     (rg_irq_mask_map_control_rreq[25])? rg_irq_mask_map_control[25]:
                     (rg_irq_mask_map_control_rreq[26])? rg_irq_mask_map_control[26]:
                     (rg_irq_mask_map_control_rreq[27])? rg_irq_mask_map_control[27]:
                     (rg_irq_mask_map_control_rreq[28])? rg_irq_mask_map_control[28]:
                     (rg_irq_mask_map_control_rreq[29])? rg_irq_mask_map_control[29]:
                     (rg_irq_mask_map_control_rreq[30])? rg_irq_mask_map_control[30]:
                     (rg_irq_mask_map_control_rreq[31])? rg_irq_mask_map_control[31]: 
                     (rg_isolation_control_rreq)       ? rg_isolation_control :
                     (rg_bootstrap_status_rreq)        ? rg_bootstrap_status : 
                     (rg_main_divider_conctrol_rreq)   ? rg_main_divider_conctrol :
                     (rg_pufcc_rreq)                   ? rg_pufcc :
                     (rg_usb_ctrl_rreq)                ? rg_usb_ctrl :
                     (rg_fpga_pll_clk_sel_rreq)        ? rg_fpga_pll_clk_sel :
                     (rg_wdt_pause_rreq)               ? rg_wdt_pause : 32'h0;

always @(posedge clk or negedge rst_n)
    if (!rst_n)       rg_rdat_mux_d <= 32'h0;
    else if (|rreq_i) rg_rdat_mux_d <= rg_rdat_mux;  

assign rdat_o = rg_rdat_mux_d;

always @ (posedge clk, negedge rst_n)
    if (!rst_n) rack_o <= 1'b0;
    else        rack_o <= |rreq_i;


always @ (posedge clk, negedge rst_n)
    if (!rst_n) wack_o <= 1'b0;
    else        wack_o <= |wreq_i;

assign rerr_o = 1'h0;
assign werr_o = wreq_i[0] | wreq_i[7] | wreq_i[44]; //RO registers

//*****************************************************************************
//              Register idRev
//              offset   0x0
//  Location    Attribute   Field Name
//
//  [31:24]     R/O         rev_id
//  [23:16]     R/O         chip_id
//  [15: 0]     R/O         vendor_id
//*****************************************************************************

assign rg_idrev = {
                  rev_id,
                  chip_id,
                  vendor_id
                  };

//*****************************************************************************
//              Register sw_rst_control
//              offset   0x4
//  Location    Attribute   Field Name
//
//  [31:11]     Rsvd  
//  [10]        R/W         dma_rst           
//  [9]         R/W         emac_rst
//  [8]         R/W         usb_rstn
//  [7]         R/W         ddr_rstn
//  [6]         R/W         fpga1_rstn
//  [5]         R/W         fpga0_rstn
//  [4]         R/W         per_rstn
//  [3]         R/W         acpu_rstn
//  [2]         R/O         sram_rstn
//  [1]         R/O         bus_rstn
//  [0]         R/WAC       bcpu_rstn
//*****************************************************************************
logic status_bcpu_rstn;

assign rg_sw_rst_control = {
                           21'h0,
                           dma_rstn,
                           emac_rstn,
                           usb_rstn,
                           ddr_rstn,
                           fpga1_rstn,
                           fpga0_rstn,
                           per_rstn,
                           acpu_rstn,
                           sram_rstn,
                           bus_rstn,
                           bcpu_rstn
                           };    

always @(posedge clk or negedge rst_n)
    if (!rst_n)                                   dma_rstn  <= 1'b0;
    else if (rg_sw_rst_control_wreq & wstr_b[10]) dma_rstn  <= wdat_i[10];                           
                           
always @(posedge clk or negedge rst_n)
    if (!rst_n)                                  emac_rstn  <= 1'b0;
    else if (rg_sw_rst_control_wreq & wstr_b[9]) emac_rstn  <= wdat_i[9];

always @(posedge clk or negedge rst_n)
    if (!rst_n)                                  usb_rstn  <= 1'b0;
    else if (rg_sw_rst_control_wreq & wstr_b[8]) usb_rstn <= wdat_i[8];

always @(posedge clk or negedge rst_n)
    if (!rst_n)                                  ddr_rstn  <= 1'b0;
    else if (rg_sw_rst_control_wreq & wstr_b[7]) ddr_rstn  <= wdat_i[7];

always @(posedge clk or negedge rst_n)
    if (!rst_n)                                  fpga1_rstn  <= 1'b0;
    else if (rg_sw_rst_control_wreq & wstr_b[6]) fpga1_rstn  <= wdat_i[6];

always @(posedge clk or negedge rst_n)
    if (!rst_n)                                  fpga0_rstn  <= 1'b0;
    else if (rg_sw_rst_control_wreq & wstr_b[5]) fpga0_rstn  <= wdat_i[5];

always @(posedge clk or negedge rst_n)
    if (!rst_n)                                  per_rstn  <= 1'b0;
    else if (rg_sw_rst_control_wreq & wstr_b[4]) per_rstn  <= wdat_i[4];

always @(posedge clk or negedge rst_n)
    if (!rst_n)                                  acpu_rstn  <= 1'b0;
    else if (rg_sw_rst_control_wreq & wstr_b[3]) acpu_rstn  <= wdat_i[3];

always @(posedge clk or negedge rst_n)
    if (!rst_n)begin
        bcpu_rstn        <= 1'b1;
        status_bcpu_rstn <= 1'b0;
    end    
    else if (rg_sw_rst_control_wreq & wstr_b[0]) begin
        bcpu_rstn        <= wdat_i[0];
        status_bcpu_rstn <= ~wdat_i[0];
    end    
    else if (deassert_bcpu_rstn) begin
        bcpu_rstn  <= 1'b1;
    end    

//*****************************************************************************
//              Register pll_config_0
//              offset   0x8
//  Location    Attribute   Field Name
//
//  [31]        R/WAC       PLL_CONFIG_0_WE 
//  [30:28]     Rsvd             
//  [27:16]     R/W         DSKEWCALIN
//  [15: 9]     Rsvd    
//  [8]         R/W         PLLEN
//  [7]         R/W         DSMEN
//  [6]         R/W         DSKEWFASTCAL
//  [5]         R/W         DSKEWCALEN
//  [ 4: 2]     R/W         DSKEWCALCNT
//  [1]         R/W         DSKEWCALBYP
//  [0]         R/W         DACEN
//*****************************************************************************
logic pll_config_0_we;
logic rg_pll_config_0_wreq_ff;
logic rg_pll_config_0_wdat_ff;

assign rg_pll_config_0 = {
                         pll_config_0_we,
                         3'h0,
                         dskewcalin,
                         7'h0,
                         pllen,
                         dsmen,
                         dskewfastcal,
                         dskewcalen,
                         dskewcalcnt,
                         dskewcalbyp,
                         dacen
                         };      
always @(posedge clk or negedge rst_n_por)
    if (!rst_n_por)rg_pll_config_0_wreq_ff  <= 1'h0;
    else           rg_pll_config_0_wreq_ff  <= rg_pll_config_0_wreq;

always @(posedge clk or negedge rst_n_por)
    if (!rst_n_por)                             rg_pll_config_0_wdat_ff  <= 'h0;
    else if (rg_pll_config_0_wreq & wstr_b[31]) rg_pll_config_0_wdat_ff  <= wdat_i[31];  

always @(posedge clk or negedge rst_n_por)
    if (!rst_n_por)                                                                       pll_config_0_we  <= 1'h0;
    else if (!rg_pll_config_0_wreq & rg_pll_config_0_wreq_ff)                             pll_config_0_we  <= rg_pll_config_0_wdat_ff;
    else if (pll_config_0_we & !rg_pll_config_0_wreq & rg_pll_config_0_wreq_ff & |wstr_b) pll_config_0_we  <= 1'h0;

always @(posedge clk or negedge rst_n_por)
    if (!rst_n_por)                                               dskewcalin  <= 12'h0;
    else if (rg_pll_config_0_wreq & wstr_b[27] & pll_config_0_we) dskewcalin  <= wdat_i[27:16];

always @(posedge clk or negedge rst_n)
    if (!rst_n)                                                  pllen  <= 1'b1;
    else if(!pllen)                                              pllen  <= 1'b1;
    else if (rg_pll_config_0_wreq & wstr_b[8] & pll_config_0_we) pllen  <= wdat_i[8];

always @(posedge clk or negedge rst_n_por)
    if (!rst_n_por)                                              dsmen  <= 1'b0;
    else if (rg_pll_config_0_wreq & wstr_b[7] & pll_config_0_we) dsmen  <= wdat_i[7];
            
always @(posedge clk or negedge rst_n_por)
    if (!rst_n_por)                                              dskewfastcal  <= 1'b0;
    else if (rg_pll_config_0_wreq & wstr_b[6] & pll_config_0_we) dskewfastcal  <= wdat_i[6];

always @(posedge clk or negedge rst_n_por)
    if (!rst_n_por)                                              dskewcalen  <= 1'b0;
    else if (rg_pll_config_0_wreq & wstr_b[5] & pll_config_0_we) dskewcalen  <= wdat_i[5];

always @(posedge clk or negedge rst_n_por)
    if (!rst_n_por)                                              dskewcalcnt  <= 3'h2;
    else if (rg_pll_config_0_wreq & wstr_b[4] & pll_config_0_we) dskewcalcnt  <= wdat_i[4:2];

always @(posedge clk or negedge rst_n_por)
    if (!rst_n_por)                                              dskewcalbyp  <= 1'b0;
    else if (rg_pll_config_0_wreq & wstr_b[1] & pll_config_0_we) dskewcalbyp  <= wdat_i[1];

always @(posedge clk or negedge rst_n_por)
    if (!rst_n_por)                                              dacen  <= 1'b0;
    else if (rg_pll_config_0_wreq & wstr_b[0] & pll_config_0_we) dacen  <= wdat_i[0];


//*****************************************************************************
//              Register pll_config_1
//              offset   0xC
//  Location    Attribute   Field Name
//
//  [31]        R/WAC       PLL_CONFIG_1_WE 
//  [30:22]     Rsvd         
//  [21:16]     R/W         REFDIV
//  [15:14]     Rsvd        
//  [13]        R/W         FOUTVCOEN
//  [12: 8]     R/W         FOUTVCOBYP
//  [ 7: 4]     Rsvd        
//  [ 3: 0]     R/W         FOUTEN
//*****************************************************************************
logic pll_config_1_we;
logic rg_pll_config_1_wreq_ff;
logic rg_pll_config_1_wdat_ff;

assign rg_pll_config_1 = {
                         pll_config_1_we,
                         9'h0,
                         refdiv,
                         2'h0,
                         foutvcoen,
                         foutvcobyp,
                         4'h0,
                         fouten
                         }; 
always @(posedge clk or negedge rst_n_por)
    if (!rst_n_por)rg_pll_config_1_wreq_ff  <= 1'h0;
    else           rg_pll_config_1_wreq_ff  <= rg_pll_config_1_wreq;

always @(posedge clk or negedge rst_n_por)
    if (!rst_n_por)                             rg_pll_config_1_wdat_ff  <= 'h0;
    else if (rg_pll_config_1_wreq & wstr_b[31]) rg_pll_config_1_wdat_ff  <= wdat_i[31];                           

always @(posedge clk or negedge rst_n_por)
    if (!rst_n_por)                                                                       pll_config_1_we  <= 1'h0;
    else if (!rg_pll_config_1_wreq & rg_pll_config_1_wreq_ff)                             pll_config_1_we  <= rg_pll_config_1_wdat_ff;
    else if (pll_config_1_we & !rg_pll_config_1_wreq & rg_pll_config_1_wreq_ff & |wstr_b) pll_config_1_we  <= 1'h0;

always @(posedge clk or negedge rst_n_por)
    if (!rst_n_por)                                               refdiv  <= 6'h1;
    else if (rg_pll_config_1_wreq & wstr_b[21] & pll_config_1_we) refdiv  <= wdat_i[21:16];

always @(posedge clk or negedge rst_n_por)
    if (!rst_n_por)                                               foutvcoen  <= 1'h0;
    else if (rg_pll_config_1_wreq & wstr_b[13] & pll_config_1_we) foutvcoen  <= wdat_i[13];

always @(posedge clk or negedge rst_n_por)
    if (!rst_n_por)                                               foutvcobyp  <= 5'h0;
    else if (rg_pll_config_1_wreq & wstr_b[12] & pll_config_1_we) foutvcobyp  <= wdat_i[12:8];

always @(posedge clk or negedge rst_n_por)
    if (!rst_n_por)                                               fouten  <= 4'h3;
    else if (rg_pll_config_1_wreq & wstr_b[3] & pll_config_1_we)  fouten  <= wdat_i[3:0];


//*****************************************************************************
//              Register pll_config_2
//              offset   0x10
//  Location    Attribute   Field Name
//
//  [31]        R/WAC       PLL_CONFIG_2_WE 
//  [30:24]     Rsvd        
//  [23: 0]     R/W         FRAC
//*****************************************************************************
logic pll_config_2_we;
logic rg_pll_config_2_wreq_ff;
logic rg_pll_config_2_wdat_ff;

assign rg_pll_config_2 = {
                  pll_config_2_we,
                  7'h0,
                  frac
                  }; 

always @(posedge clk or negedge rst_n_por)
    if (!rst_n_por) rg_pll_config_2_wreq_ff  <= 1'h0;
    else            rg_pll_config_2_wreq_ff  <= rg_pll_config_2_wreq;

always @(posedge clk or negedge rst_n_por)
    if (!rst_n_por)                                 rg_pll_config_2_wdat_ff  <= 'h0;
    else if (rg_pll_config_2_wreq & wstr_b[31])     rg_pll_config_2_wdat_ff  <= wdat_i[31];                     

always @(posedge clk or negedge rst_n_por)
    if (!rst_n_por)                                                                           pll_config_2_we  <= 1'h0;
    else if (!rg_pll_config_2_wreq & rg_pll_config_2_wreq_ff )                                pll_config_2_we  <= rg_pll_config_2_wdat_ff;
    else if (pll_config_2_we & !rg_pll_config_2_wreq & rg_pll_config_2_wreq_ff & |wstr_b)     pll_config_2_we  <= 1'h0;

always @(posedge clk or negedge rst_n_por)
    if (!rst_n_por)                                                   frac  <= 24'h0;
    else if (rg_pll_config_2_wreq & wstr_b[23] & pll_config_2_we)     frac  <= wdat_i[23:0];


//*****************************************************************************
//              Register pll_config_3
//              offset   0x14
//  Location    Attribute   Field Name
//
//  [31]        R/WAC       PLL_CONFIG_3_WE 
//  [30:8]      Rsvd        
//  [ 7: 4]     R/W         POSTDIV1
//  [ 3: 0]     R/W         POSTDIV0
//*****************************************************************************
logic pll_config_3_we;
logic rg_pll_config_3_wreq_ff;
logic rg_pll_config_3_wdat_ff;

assign rg_pll_config_3 = {
                         pll_config_3_we,
                         23'h0,
                         postdiv1,
                         postdiv0
                         }; 

always @(posedge clk or negedge rst_n_por)
    if (!rst_n_por) rg_pll_config_3_wreq_ff  <= 1'h0;
    else            rg_pll_config_3_wreq_ff  <= rg_pll_config_3_wreq;                         

always @(posedge clk or negedge rst_n_por)
    if (!rst_n_por)                                 rg_pll_config_3_wdat_ff  <= 'h0;
    else if (rg_pll_config_3_wreq & wstr_b[31])     rg_pll_config_3_wdat_ff  <= wdat_i[31];   

always @(posedge clk or negedge rst_n_por)
    if (!rst_n_por)                                                                           pll_config_3_we  <= 1'h0;
    else if (!rg_pll_config_3_wreq & rg_pll_config_3_wreq_ff)                                 pll_config_3_we  <= rg_pll_config_3_wdat_ff;
    else if (pll_config_3_we & !rg_pll_config_3_wreq & rg_pll_config_3_wreq_ff & |wstr_b)     pll_config_3_we  <= 1'h0;    

always @(posedge clk or negedge rst_n_por)
    if (!rst_n_por)                                                  postdiv1  <= 4'hF;
    else if (rg_pll_config_3_wreq & wstr_b[7] & pll_config_3_we)     postdiv1  <= wdat_i[7:4];

always @(posedge clk or negedge rst_n_por)
    if (!rst_n_por)                                                  postdiv0  <= 4'h2;
    else if (rg_pll_config_3_wreq & wstr_b[3] & pll_config_3_we)     postdiv0  <= wdat_i[3:0];

//*****************************************************************************
//              Register pll_config_4
//              offset   0x18
//  Location    Attribute   Field Name
//
//  [31:16]     W/O         FBDIV_COM_CODE
//  [15:12]     Rsvd        
//  [11: 0]     R/W         FBDIV
//*****************************************************************************
localparam FBDIV_COM_CODE = 16'hAE41; 
logic fbdiv_we;

assign fbdiv_we = rg_pll_config_4_wreq & wstr_b[31] & (wdat_i[31:16] == FBDIV_COM_CODE); 

assign rg_pll_config_4 = {
                         20'h0,
                         fbdiv
                         };


always @(posedge clk or negedge rst_n_por)
    if (!rst_n_por)                                        fbdiv  <= 12'd80;
    else if (rg_pll_config_4_wreq & wstr_b[11] & fbdiv_we) fbdiv  <= wdat_i[11:0];   

//*****************************************************************************
//              Register pll_status
//              offset   0x1C
//  Location    Attribute   Field Name
//
//  [31:14]     Rsvd         
//  [13]        R/O         LOCK
//  [12]        R/O         DSKEWCALLOCK
//  [11: 0]     R/O         DSKEWCALOUT
//*****************************************************************************

assign rg_pll_status = {
                       18'h0,
                       lock,
                       dskewcallock,
                       dskewcalout
                       }; 


//*****************************************************************************
//              Register divider_conctrol
//              offset   0x20
//  Location    Attribute   Field Name
//
//  [31:28]     Rsvd         
//  [27:24]     R/W         div3
//  [23:20]     Rsvd  
//  [19:16]     R/W         div2
//  [15:12]     Rsvd         
//  [11: 8]     R/W         div1
//  [ 7: 4]     Rsvd  
//  [ 3: 0]     R/W         div0
//*****************************************************************************

assign rg_divider_conctrol = {
                             4'h0,
                             div3,
                             4'h0,
                             div2,
                             4'h0,
                             div1,
                             4'h0,
                             div0
                             }; 
always @(posedge clk or negedge rst_n_por)
    if (!rst_n_por)                                     div3  <= 4'h1;
    else if (rg_divider_conctrol_wreq & wstr_b[27]) div3  <= wdat_i[27:24];

always @(posedge clk or negedge rst_n_por)
    if (!rst_n_por)                                     div2  <= 4'h0;
    else if (rg_divider_conctrol_wreq & wstr_b[19]) div2  <= wdat_i[19:16];

always @(posedge clk or negedge rst_n_por)
    if (!rst_n_por)                                     div1  <= 4'h0;
    else if (rg_divider_conctrol_wreq & wstr_b[11]) div1  <= wdat_i[11:8];

always @(posedge clk or negedge rst_n_por)
    if (!rst_n_por)                                    div0  <= 4'h0;
    else if (rg_divider_conctrol_wreq & wstr_b[3]) div0  <= wdat_i[3:0];

//*****************************************************************************
//              Register gating_control
//              offset   0x24
//  Location    Attribute   Field Name
//
//  [31:11]     Rsvd
//  [11]        R/W         ddr_cfg_ctl_cg 
//  [10]        R/W         usb_ctl_cg            
//  [9]         R/W         ddr_ctl_cg
//  [8]         R/W         ddr_phy_cg
//  [7]         R/W         gpt_cg
//  [6]         R/W         gpio_cg
//  [5]         R/W         uart_cg
//  [4]         R/W         I2c_cg
//  [3]         R/W         qspi_cg
//  [2]         R/W         bcpu_cg
//  [1]         R/W         sys_dma_cg
//  [0]         R/W         acpu_cg
//*****************************************************************************

assign rg_gating_control = {
                           19'h0,
                           pscc_xtal_cg,
                           ddr_cfg_ctl_cg,
                           usb_ctl_cg,
                           ddr_ctl_cg,
                           ddr_phy_cg,
                           gpt_cg,
                           gpio_cg,
                           uart_cg,
                           i2c_cg,
                           qspi_cg,
                           bcpu_cg,
                           sys_dma_cg,
                           acpu_cg
                           }; 

always @(posedge clk or negedge rst_n)
    if (!rst_n)                                   pscc_xtal_cg <= 1'b1;
    else if (rg_gating_control_wreq & wstr_b[12]) pscc_xtal_cg <= wdat_i[12];

always @(posedge clk or negedge rst_n)
    if (!rst_n)                                   ddr_cfg_ctl_cg <= 1'b1;
    else if (rg_gating_control_wreq & wstr_b[11]) ddr_cfg_ctl_cg <= wdat_i[11];

always @(posedge clk or negedge rst_n)
    if (!rst_n)                                   usb_ctl_cg  <= 1'b1;
    else if (rg_gating_control_wreq & wstr_b[10]) usb_ctl_cg  <= wdat_i[10];

always @(posedge clk or negedge rst_n)
    if (!rst_n)                                  ddr_ctl_cg  <= 1'b1;
    else if (rg_gating_control_wreq & wstr_b[9]) ddr_ctl_cg  <= wdat_i[9];

always @(posedge clk or negedge rst_n)
    if (!rst_n)                                  ddr_phy_cg  <= 1'b1;
    else if (rg_gating_control_wreq & wstr_b[8]) ddr_phy_cg  <= wdat_i[8];

always @(posedge clk or negedge rst_n)
    if (!rst_n)                                  gpt_cg  <= 1'b1;
    else if (rg_gating_control_wreq & wstr_b[7]) gpt_cg  <= wdat_i[7];    

always @(posedge clk or negedge rst_n)
    if (!rst_n)                                  gpio_cg  <= 1'b1;
    else if (rg_gating_control_wreq & wstr_b[6]) gpio_cg  <= wdat_i[6];

always @(posedge clk or negedge rst_n)
    if (!rst_n)                                  uart_cg  <= 1'b1;
    else if (rg_gating_control_wreq & wstr_b[5]) uart_cg  <= wdat_i[5];

always @(posedge clk or negedge rst_n)
    if (!rst_n)                                  i2c_cg  <= 1'b1;
    else if (rg_gating_control_wreq & wstr_b[4]) i2c_cg  <= wdat_i[4];

always @(posedge clk or negedge rst_n)
    if (!rst_n)                                  qspi_cg  <= 1'b1;
    else if (rg_gating_control_wreq & wstr_b[3]) qspi_cg  <= wdat_i[3];

always @(posedge clk or negedge rst_n)
    if (!rst_n)                                  bcpu_cg  <= 1'b1;
    else if (rg_gating_control_wreq & wstr_b[2]) bcpu_cg  <= wdat_i[2];

always @(posedge clk or negedge rst_n)
    if (!rst_n)                                  sys_dma_cg  <= 1'b1;
    else if (rg_gating_control_wreq & wstr_b[1]) sys_dma_cg  <= wdat_i[1];

always @(posedge clk or negedge rst_n)
    if (!rst_n)                                  acpu_cg  <= 1'b1;
    else if (rg_gating_control_wreq & wstr_b[0]) acpu_cg  <= wdat_i[0];


//*****************************************************************************
//              Register debug_control
//              offset   0x28
//  Location    Attribute   Field Name
//
//  [31: 0]     Rsvd             
//  [1:0]       R/W         jtag_control
//*****************************************************************************

assign rg_debug_control = {
                           30'h0,
                           jtag_control
                           };  

always @(posedge clk or negedge rst_n)
    if (!rst_n)                                 jtag_control  <= 2'b0;
    else if (rg_debug_control_wreq & wstr_b[1]) jtag_control  <= wdat_i[1:0];

//*****************************************************************************
//              Register irq_mask_map_control_n
//              offset   0x2C+n*0x4, n = 0...31
//  Location    Attribute   Field Name
//
//  [31:19]     Rsvd             
//  [18:16]     R/W         irq_map
//  [15: 1]     Rsvd
//  [0]         R/W         irq_mask
//*****************************************************************************


genvar n;
generate
    for(n = 0; n < 32; n = n + 1) begin : irq_control_regs
        assign rg_irq_mask_map_control[n] = {
                                             13'h0,
                                             irq_map[n],
                                             15'h0,
                                             irq_mask[n]
                                             };  

        always @(posedge clk or negedge rst_n)
            if (!rst_n)                                            irq_map[n]  <= 3'h1;
            else if (rg_irq_mask_map_control_wreq[n] & wstr_b[18]) irq_map[n]  <= wdat_i[18:16];   

        always @(posedge clk or negedge rst_n)
            if (!rst_n)                                           irq_mask[n]  <= 1'h1;
            else if (rg_irq_mask_map_control_wreq[n] & wstr_b[0]) irq_mask[n]  <= wdat_i[0];
    end
endgenerate



//*****************************************************************************
//              Register isolation_control
//              offset   0xAC
//  Location    Attribute   Field Name
//
//  [24]        R/W         ACE_isolation_cell
//  [16]        R/W         irq_isolation_cell
//  [8]         R/W         FCB_isolation_cell
//  [2]         R/W         AHB_isolation_cell
//  [1]         R/W         AXI_1_isolation_cell
//  [0]         R/W         AXI_0_isolation_cell
//*****************************************************************************

assign rg_isolation_control = {
                               7'h0,
                               ace_isolation_ctl,
                               7'h0,
                               irq_isolation_ctl,
                               7'h0,
                               fcb_isolation_ctl,
                               5'h0,
                               ahb_isolation_ctl,
                               axi1_isolation_ctl,
                               axi0_isolation_ctl
                              }; 

always @(posedge clk or negedge rst_n)
    if (!rst_n)                                      ace_isolation_ctl  <= 1'h1;
    else if (rg_isolation_control_wreq & wstr_b[24]) ace_isolation_ctl  <= wdat_i[24];

always @(posedge clk or negedge rst_n)
    if (!rst_n)                                      irq_isolation_ctl  <= 1'h1;
    else if (rg_isolation_control_wreq & wstr_b[16]) irq_isolation_ctl  <= wdat_i[16];

always @(posedge clk or negedge rst_n)
    if (!rst_n)                                     fcb_isolation_ctl  <= 1'h1;
    else if (rg_isolation_control_wreq & wstr_b[8]) fcb_isolation_ctl  <= wdat_i[8];

always @(posedge clk or negedge rst_n)
    if (!rst_n)                                     ahb_isolation_ctl  <= 1'h1;
    else if (rg_isolation_control_wreq & wstr_b[2]) ahb_isolation_ctl  <= wdat_i[2];

always @(posedge clk or negedge rst_n)
    if (!rst_n)                                     axi1_isolation_ctl  <= 1'h1;
    else if (rg_isolation_control_wreq & wstr_b[1]) axi1_isolation_ctl  <= wdat_i[1];

always @(posedge clk or negedge rst_n)
    if (!rst_n)                                     axi0_isolation_ctl  <= 1'h1;
    else if (rg_isolation_control_wreq & wstr_b[0]) axi0_isolation_ctl  <= wdat_i[0];


//*****************************************************************************
//              Register bootstrap_status
//              offset   0xB0
//  Location    Attribute   Field Name
//
//  [31:5 ]     Rsvd
//  [6]         R/O         bcpu_lock_rst_status      
//  [5]         R/O         bcpu_sw_rst_status      
//  [4:2]       R/O         bootm      
//  [1:0]       R/O         clk_sel_status
//*****************************************************************************
logic bcpu_sw_rst_status;
logic bcpu_lock_rst_status;
logic bcpu_wdt_rst_status;
logic pllen_latch;

assign rg_bootstrap_status = {
                       24'h0,
                       bcpu_wdt_rst_status,
                       bcpu_lock_rst_status,
                       bcpu_sw_rst_status,
                       bootm,
                       clk_sel_status
                       }; 

always_latch
  if(!rst_n_por)
    pllen_latch <= 'b0;
  else if(!pllen)
    pllen_latch <= 'b1;

always @(posedge clk or negedge rst_n_por)
    if (!rst_n_por)        bcpu_wdt_rst_status  <= 1'h0;
    else if (bcpu_wdt_rst) bcpu_wdt_rst_status  <= 1'h1;


always @(posedge clk or negedge rst_n_por)
    if (!rst_n_por)       bcpu_lock_rst_status  <= 1'h0;
    else if (pllen_latch) bcpu_lock_rst_status  <= 1'h1;

always @(posedge clk or negedge rst_n_por)
    if (!rst_n_por)                         bcpu_sw_rst_status  <= 1'h0;
    else if (!bcpu_rstn & status_bcpu_rstn) bcpu_sw_rst_status  <= 1'h1;
    
//*****************************************************************************
//              Register main_divider_conctrol
//              offset   0xB4
//  Location    Attribute   Field Name
//
//  [31:29]     Rsvd      
//  [27:24]     R/W         div0_clk1
//  [23:20]     Rsvd                      
//  [19:16]     R/W         div2_clk0
//  [15:12]     Rsvd  
//  [11: 8]     R/W         div1_clk0
//  [ 7: 4]     Rsvd  
//  [ 3: 0]     R/W         div0_clk0
//*****************************************************************************

assign rg_main_divider_conctrol = {
                             4'h0,
                             div0_clk1,
                             4'h0,
                             div2_clk0,                                                        
                             4'h0,
                             div1_clk0,
                             4'h0,
                             div0_clk0
                             }; 

always @(posedge clk or negedge rst_n_por)
    if (!rst_n_por)                                      div0_clk1  <= 4'h0;
    else if (rg_main_divider_conctrol_wreq & wstr_b[27]) div0_clk1  <= wdat_i[27:24];                                  

always @(posedge clk or negedge rst_n_por)
    if (!rst_n_por)                                      div2_clk0  <= 4'h1;
    else if (rg_main_divider_conctrol_wreq & wstr_b[19]) div2_clk0  <= wdat_i[19:16];      

always @(posedge clk or negedge rst_n_por)
    if (!rst_n_por)                                      div1_clk0  <= 4'h0;
    else if (rg_main_divider_conctrol_wreq & wstr_b[11]) div1_clk0  <= wdat_i[11:8];

always @(posedge clk or negedge rst_n_por)
    if (!rst_n_por)                                     div0_clk0  <= 4'h1;
    else if (rg_main_divider_conctrol_wreq & wstr_b[3]) div0_clk0  <= wdat_i[3:0];  


//*****************************************************************************
//              Register pufcc_ctl
//              offset   0xB8
//  Location    Attribute   Field Name
//
//  [31:3]     Rsvd         
//  [2]         R/W         pufcc_rng_fre_en
//  [1]         R/W         pufcc_rng_fre_sel
//  [0]         R/O         pufcc_rng_fre_out
//*****************************************************************************


assign rg_pufcc        = {
                         29'h0,
                         pufcc_rng_fre_en,
                         pufcc_rng_fre_sel,
                         pufcc_rng_fre_out
                         }; 

always @(posedge clk or negedge rst_n)
    if (!rst_n)                         pufcc_rng_fre_en  <= 'h0;
    else if (rg_pufcc_wreq & wstr_b[2]) pufcc_rng_fre_en  <= wdat_i[2];

always @(posedge clk or negedge rst_n)
    if (!rst_n)                         pufcc_rng_fre_sel  <= 'h0;
    else if (rg_pufcc_wreq & wstr_b[1]) pufcc_rng_fre_sel  <= wdat_i[1];                         



//*****************************************************************************
//              Register usb_ctrl
//              offset   0xBC
//  Location    Attribute   Field Name
//
//  [31:30]     Rsvd         
//  [29:22]      R/O         usb_phy_bisterrorcount
//  [21]         R/O         usb_phy_bisterror
//  [20]         R/O         usb_phy_bistcomplete
//  [19]         R/W         usb_phy_bistmodeen
//  [18:15]      R/W         usb_phy_bistmodesel
//  [14]         R/W         usb_phy_biston
//  [13]         R/W         usb_pll_bypass
//  [12:5]       R/O         usb_tmodecustom
//  [4]          R/O         usb_tmodeselcustom
//  [3:2]        R/W         usb_tsmode
//  [1]          R/W         usb_vbusfault
//  [0]          R/W         usb_wakeup
//*****************************************************************************

assign rg_usb_ctrl    = {
                         2'h0,
                         usb_phy_bisterrorcount,
                         usb_phy_bisterror,
                         usb_phy_bistcomplete,
                         usb_phy_bistmodeen,
                         usb_phy_bistmodesel,
                         usb_phy_biston,
                         usb_pll_bypass,
                         pufcc_rng_fre_out,
                         usb_tmodeselcustom,
                         usb_tsmode,
                         usb_vbusfault,
                         usb_wakeup
                         }; 

always @(posedge clk or negedge rst_n)
  if (!rst_n)                         usb_phy_bistmodeen  <= 'h0;
  else if (rg_usb_ctrl_wreq & wstr_b[19]) usb_phy_bistmodeen  <= wdat_i[19];

always @(posedge clk or negedge rst_n)
  if (!rst_n)                         usb_phy_bistmodesel  <= 'h0;
  else if (rg_usb_ctrl_wreq & wstr_b[18]) usb_phy_bistmodesel  <= wdat_i[18:15];

always @(posedge clk or negedge rst_n)
  if (!rst_n)                         usb_phy_biston  <= 'h0;
  else if (rg_usb_ctrl_wreq & wstr_b[14]) usb_phy_biston  <= wdat_i[14];

always @(posedge clk or negedge rst_n)
  if (!rst_n)                         usb_pll_bypass  <= 'h0;
  else if (rg_usb_ctrl_wreq & wstr_b[13]) usb_pll_bypass  <= wdat_i[13];

always @(posedge clk or negedge rst_n)
  if (!rst_n)                         usb_tsmode  <= 'h0;
  else if (rg_usb_ctrl_wreq & wstr_b[3]) usb_tsmode  <= wdat_i[3:2];

always @(posedge clk or negedge rst_n)
  if (!rst_n)                         usb_vbusfault  <= 'h0;
  else if (rg_usb_ctrl_wreq & wstr_b[1]) usb_vbusfault  <= wdat_i[1];

always @(posedge clk or negedge rst_n)
  if (!rst_n)                         usb_wakeup  <= 'h0;
  else if (rg_usb_ctrl_wreq & wstr_b[0]) usb_wakeup  <= wdat_i[0];


//*****************************************************************************
//              Register fpga_pll_clk_sel
//              offset   0xC0
//  Location    Attribute   Field Name
//
//  [31:26]     Rsvd  
//  [25:24]     R/W         fpga_pll3_clk_sel
//  [23:18]     Rsvd  
//  [17:16]     R/W         fpga_pll2_clk_sel
//  [15:10]     Rsvd  
//  [9 : 8]     R/W         fpga_pll1_clk_sel
//  [ 7: 2]     Rsvd  
//  [ 1: 0]     R/W         fpga_pll0_clk_sel
//*****************************************************************************

assign rg_fpga_pll_clk_sel = {
                             6'h0,
                             fpga_pll3_clk_sel,
                             6'h0,
                             fpga_pll2_clk_sel,                                                        
                             6'h0,
                             fpga_pll1_clk_sel,
                             6'h0,
                             fpga_pll0_clk_sel
                             }; 

always @(posedge clk or negedge rst_n)
    if (!rst_n)                                     fpga_pll3_clk_sel  <= 2'h0;
    else if (rg_fpga_pll_clk_sel_wreq & wstr_b[25]) fpga_pll3_clk_sel  <= wdat_i[25:24];  

always @(posedge clk or negedge rst_n)
    if (!rst_n)                                     fpga_pll2_clk_sel  <= 2'h0;
    else if (rg_fpga_pll_clk_sel_wreq & wstr_b[17]) fpga_pll2_clk_sel  <= wdat_i[17:16];  

always @(posedge clk or negedge rst_n)
    if (!rst_n)                                    fpga_pll1_clk_sel  <= 2'h0;
    else if (rg_fpga_pll_clk_sel_wreq & wstr_b[9]) fpga_pll1_clk_sel  <= wdat_i[9:8];          

always @(posedge clk or negedge rst_n)
    if (!rst_n)                                    fpga_pll0_clk_sel  <= 2'h0;
    else if (rg_fpga_pll_clk_sel_wreq & wstr_b[1]) fpga_pll0_clk_sel  <= wdat_i[1:0];  



//*****************************************************************************
//              Register wdt_pause
//              offset   0xC4
//  Location    Attribute   Field Name
//
//  [31:9]      Rsvd  
//  [8]         R/W         acpu_wdt_pause
//  [ 7: 1]     Rsvd  
//  [0]         R/W         bcpu_wdt_pause
//*****************************************************************************

assign rg_wdt_pause = {
                             23'h0,
                             acpu_wdt_pause,
                             7'h0,
                             bcpu_wdt_pause
                             }; 

always @(posedge clk or negedge rst_n)
    if (!rst_n)                             acpu_wdt_pause  <= 'h0;
    else if (rg_wdt_pause_wreq & wstr_b[8]) acpu_wdt_pause  <= wdat_i[8];  

always @(posedge clk or negedge rst_n)
    if (!rst_n)                             bcpu_wdt_pause  <= 'h0;
    else if (rg_wdt_pause_wreq & wstr_b[0]) bcpu_wdt_pause  <= wdat_i[0];  


endmodule
