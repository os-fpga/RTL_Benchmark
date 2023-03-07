// This file is generated from Magillem
// Generation : Mon Jul 11 06:16:59 PDT 2022 by gdavydov from project soc_ss_prj
// Component : Vendor Library soc_ss 1.0
// Design : Vendor Library soc_ss_arch 1.0
//  acpu      Vendor Library ae350_cpu_subsystem  1.0 /home/gdavydov/Magillem/SOC_SS/soc_ss_prj/soc_ss_prj/Vendor_Library_ae350_cpu_subsystem_1.0.xml 
//  config_ss Vendor Library soc_config_subsystem 1.0 /home/gdavydov/Magillem/SOC_SS/soc_ss_prj/soc_ss_prj/Vendor_Library_soc_config_subsystem_1.0.xml 
//  memory_ss Vendor Library memss                1.0 /home/gdavydov/Magillem/SOC_SS/soc_ss_prj/soc_ss_prj/Vendor_Library_memss_1.0.xml 
//  flexnoc   Vendor Library rsnoc                1.0 /home/gdavydov/Magillem/SOC_SS/soc_ss_prj/soc_ss_prj/Vendor_Library_rsnoc_1.0.xml 
// Magillem Release : 5.12.0


module soc_ss (
/*
 clk_osc, 
 rst_n_fpga0, 
 rst_n_fpga1, 
 rst_n_fpga_s, 
 clk_fpga_fabric_m0,
 clk_fpga_fabric_m1,
 clk_fpga_fabric_s0,
 clk_fpga_fabric_fcb_pcb,
 clk_fpga_fabric_irq,
 clk_fpga_fabric_dma,
 clk_fpga_fabric_ace,
 clk_fpga_pll0_ref,
 clk_fpga_pll1_ref,
 clk_fpga_pll2_ref,
 clk_fpga_pll3_ref,
 rst_n_fpga_fabric_m0,
 rst_n_fpga_fabric_m1,
 rst_n_fpga_fabric_s0,
 rst_n_fpga_fabric_fcb_pcb,
 rst_n_fpga_fabric_irq,
 rst_n_fpga_fabric_dma,
 rst_n_fpga_fabric_ace,
 scl_o, 
 spi_clk_oe, 
 spi_clk_out, 
 gpio_pulldown, 
 gpio_pullup, 
 pit_pause, 
 mdio_mdc, 
 usb_dp,
 usb_dn,
 usb_id,
 usb_vbus,
 usb_rtrim, 
 usb_xtal_in, 
 jtag_control, 
 acpu_jtag_tck, 
 acpu_jtag_tdi, 
 acpu_jtag_tdo, 
 acpu_jtag_tms, 
 bcpu_jtag_tck, 
 bcpu_jtag_tdi, 
 bcpu_jtag_tdo, 
 bcpu_jtag_tms, 
 atbytes, 
 atdata, 
 atid, 
 atready, 
 atvalid, 
 afvalid, 
 afready, 
 dm, 
 dq, 
 dqs, 
 dqs_n, 
 fpga_irq_src, 
 fpga_irq_set, 
 dma_req_fpga, 
 dma_ack_fpga, 
 fpga_ahb_s0_haddr, 
 fpga_ahb_s0_hburst, 
 fpga_ahb_s0_hmastlock, 
 fpga_ahb_s0_hprot, 
 fpga_ahb_s0_hrdata, 
 fpga_ahb_s0_hready, 
 fpga_ahb_s0_hresp, 
 fpga_ahb_s0_hsel, 
 fpga_ahb_s0_hsize, 
 fpga_ahb_s0_htrans, 
 fpga_ahb_s0_hwbe, 
 fpga_ahb_s0_hwdata, 
 fpga_ahb_s0_hwrite, 
 fpga_axi_m0_ar_addr, 
 fpga_axi_m0_ar_burst, 
 fpga_axi_m0_ar_cache, 
 fpga_axi_m0_ar_id, 
 fpga_axi_m0_ar_len, 
 fpga_axi_m0_ar_lock, 
 fpga_axi_m0_ar_prot, 
 fpga_axi_m0_ar_ready, 
 fpga_axi_m0_ar_size, 
 fpga_axi_m0_ar_valid, 
 fpga_axi_m0_aw_addr, 
 fpga_axi_m0_aw_burst, 
 fpga_axi_m0_aw_cache, 
 fpga_axi_m0_aw_id, 
 fpga_axi_m0_aw_len, 
 fpga_axi_m0_aw_lock, 
 fpga_axi_m0_aw_prot, 
 fpga_axi_m0_aw_ready, 
 fpga_axi_m0_aw_size, 
 fpga_axi_m0_aw_valid, 
 fpga_axi_m0_b_id, 
 fpga_axi_m0_b_ready, 
 fpga_axi_m0_b_resp, 
 fpga_axi_m0_b_valid, 
 fpga_axi_m0_r_data, 
 fpga_axi_m0_r_id, 
 fpga_axi_m0_r_last, 
 fpga_axi_m0_r_ready, 
 fpga_axi_m0_r_resp, 
 fpga_axi_m0_r_valid, 
 fpga_axi_m0_w_data, 
 fpga_axi_m0_w_last, 
 fpga_axi_m0_w_ready, 
 fpga_axi_m0_w_strb, 
 fpga_axi_m0_w_valid, 
 fpga_axi_m1_ar_addr, 
 fpga_axi_m1_ar_burst, 
 fpga_axi_m1_ar_cache, 
 fpga_axi_m1_ar_id, 
 fpga_axi_m1_ar_len, 
 fpga_axi_m1_ar_lock, 
 fpga_axi_m1_ar_prot, 
 fpga_axi_m1_ar_ready, 
 fpga_axi_m1_ar_size, 
 fpga_axi_m1_ar_valid, 
 fpga_axi_m1_aw_addr, 
 fpga_axi_m1_aw_burst, 
 fpga_axi_m1_aw_cache, 
 fpga_axi_m1_aw_id, 
 fpga_axi_m1_aw_len, 
 fpga_axi_m1_aw_lock, 
 fpga_axi_m1_aw_prot, 
 fpga_axi_m1_aw_ready, 
 fpga_axi_m1_aw_size, 
 fpga_axi_m1_aw_valid, 
 fpga_axi_m1_b_id, 
 fpga_axi_m1_b_ready, 
 fpga_axi_m1_b_resp, 
 fpga_axi_m1_b_valid, 
 fpga_axi_m1_r_data, 
 fpga_axi_m1_r_id, 
 fpga_axi_m1_r_last, 
 fpga_axi_m1_r_ready, 
 fpga_axi_m1_r_resp, 
 fpga_axi_m1_r_valid, 
 fpga_axi_m1_w_data, 
 fpga_axi_m1_w_last, 
 fpga_axi_m1_w_ready, 
 fpga_axi_m1_w_strb, 
 fpga_axi_m1_w_valid, 
 ace_isolation_ctl, 
 irq_isolation_ctl, 
 fcb_isolation_ctl, 
 ahb_isolation_ctl, 
 axi1_isolation_ctl, 
 axi0_isolation_ctl, 
 atclk, 
 atresetn,
 atclken,
 ace_vstart,
 ace_istart,
 ace_divalid,
 ace_doready,
 ace_dinop,
 ace_dovalid,
 ace_vbreak,
 ace_diready,
 ace_doutop,
 dti_ext_vref,
 pad_mem_ctl,
 pad_mem_clk,
 pad_mem_clk_n,
 pad_mem_dm,
 pad_mem_dq,
 pad_mem_dqs,
 pad_mem_dqs_n,
 clockdr_ctl,
 clockdr_clk,
 clockdr_dm,
 clockdr_dq,
 clockdr_dqs,
 jtag_si_ctl,
 jtag_si_clk,
 jtag_si_dm,
 jtag_si_dq,
 jtag_si_dqs,
 jtag_so_ctl,
 jtag_so_clk,
 jtag_so_dm,
 jtag_so_dq,
 jtag_so_dqs,
 mode_ctl,
 mode_clk,
 mode_dm,
 mode_dq,
 mode_dqs,
 mode_i_dm,
 mode_i_dq,
 mode_i_dqs,
 pad_ref,
 se,
 se_ck,
 shiftdr_ctl,
 shiftdr_clk,
 shiftdr_dm,
 shiftdr_dq,
 shiftdr_dqs,
 si_clk,
 si_ctl,
 si_dm,
 si_dq,
 si_rd,
 si_wr,
 so_clk,
 so_ctl,
 so_dm,
 so_dq,
 so_rd,
 so_wr,
 t_cgctl_ctl,
 t_cgctl_dq,
 t_rctl_ctl,
 t_rctl_dq,
 vdd,
 vddo,
 vss,
 updatedr_ctl,
 updatedr_clk,
 updatedr_dm,
 updatedr_dq,
 updatedr_dqs,
 pad_comp,
 yc_clk,
 yc_ctl,
 y_dm,
 y_dq,
 y_dqs,
 pad_vref,
  // PAD IOs
  RST_N,
  XIN,
  REF_CLK_1,
  REF_CLK_2,
  REF_CLK_3,
  REF_CLK_4,
  TESTMODE,
  BOOTM0,
  BOOTM1,
  BOOTM2,
  CLKSEL_0,
  CLKSEL_1,
  JTAG_TDI,
  JTAG_TDO,
  JTAG_TMS,
  JTAG_TCK,
  JTAG_TRSTN,
  GPIO_A_0,
  GPIO_A_1,
  GPIO_A_2,
  GPIO_A_3,
  GPIO_A_4,
  GPIO_A_5,
  GPIO_A_6,
  GPIO_A_7,
  GPIO_A_8,
  GPIO_A_9,
  GPIO_A_10,
  GPIO_A_11,
  GPIO_A_12,
  GPIO_A_13,
  GPIO_A_14,
  GPIO_A_15,
  GPIO_B_0,
  GPIO_B_1,
  GPIO_B_2,
  GPIO_B_3,
  GPIO_B_4,
  GPIO_B_5,
  GPIO_B_6,
  GPIO_B_7,
  GPIO_B_8,
  GPIO_B_9,
  GPIO_B_10,
  GPIO_B_11,
  GPIO_B_12,
  GPIO_B_13,
  GPIO_B_14,
  GPIO_B_15,
  GPIO_C_0,
  GPIO_C_1,
  GPIO_C_2,
  GPIO_C_3,
  GPIO_C_4,
  GPIO_C_5,
  GPIO_C_6,
  GPIO_C_7,
  GPIO_C_8,
  GPIO_C_9,
  GPIO_C_10,
  GPIO_C_11,
  GPIO_C_12,
  GPIO_C_13,
  GPIO_C_14,
  GPIO_C_15,
  I2C_SCL,
  SPI_SCLK,
  GPT_RTC,
  MDIO_MDC,
  MDIO_DATA,
  RGMII_TXD0,
  RGMII_TXD1,
  RGMII_TXD2,
  RGMII_TXD3,
  RGMII_TX_CTL,
  RGMII_TXC,
  RGMII_RXD0,
  RGMII_RXD1,
  RGMII_RXD2,
  RGMII_RXD3,
  RGMII_RX_CTL,
  RGMII_RXC,
  USB_DP,
  USB_DN,
  USB_XTAL_OUT,
  USB_XTAL_IN,
 fcb_clk_o,
 fcb_data_o,
 fcb_cmd_o,
 fcb_clk_i, 
 fcb_data_i,
 fcb_rst_n,
 icb_clk_o,
 icb_data_o,
 icb_cmd_o,
 icb_clk_i, 
 icb_data_i,
 icb_rst_n,
 pl_data_o,
 pl_addr_o,
 pl_ena_o,
 pl_clk_o,
 pl_ren_o,
 pl_init_o,
 pl_wen_o,
 pl_data_i,
 ccb_pll0_dskewcalin,
 ccb_pll0_pllen,
 ccb_pll0_dsmen,
 ccb_pll0_dskewfastcal,
 ccb_pll0_dskewcalen,
 ccb_pll0_dskewcalcnt,
 ccb_pll0_dskewcalbyp,
 ccb_pll0_dacen,
 ccb_pll0_refdiv,
 ccb_pll0_foutvcoen,
 ccb_pll0_foutvcobyp,
 ccb_pll0_fouten,
 ccb_pll0_frac,
 ccb_pll0_fbdiv,
 ccb_pll0_postdiv3,
 ccb_pll0_postdiv2,
 ccb_pll0_postdiv1,
 ccb_pll0_postdiv0,
 ccb_pll0_lock,
 ccb_pll0_dskewcallock,
 ccb_pll0_dskewcalout,
 ccb_pll1_dskewcalin,
 ccb_pll1_pllen,
 ccb_pll1_dsmen,
 ccb_pll1_dskewfastcal,
 ccb_pll1_dskewcalen,
 ccb_pll1_dskewcalcnt,
 ccb_pll1_dskewcalbyp,
 ccb_pll1_dacen,
 ccb_pll1_refdiv,
 ccb_pll1_foutvcoen,
 ccb_pll1_foutvcobyp,
 ccb_pll1_fouten,
 ccb_pll1_frac,
 ccb_pll1_fbdiv,
 ccb_pll1_postdiv3,
 ccb_pll1_postdiv2,
 ccb_pll1_postdiv1,
 ccb_pll1_postdiv0,
 ccb_pll1_lock,
 ccb_pll1_dskewcallock,
 ccb_pll1_dskewcalout,
 ccb_pll2_dskewcalin,
 ccb_pll2_pllen,
 ccb_pll2_dsmen,
 ccb_pll2_dskewfastcal,
 ccb_pll2_dskewcalen,
 ccb_pll2_dskewcalcnt,
 ccb_pll2_dskewcalbyp,
 ccb_pll2_dacen,
 ccb_pll2_refdiv,
 ccb_pll2_foutvcoen,
 ccb_pll2_foutvcobyp,
 ccb_pll2_fouten,
 ccb_pll2_frac,
 ccb_pll2_fbdiv,
 ccb_pll2_postdiv3,
 ccb_pll2_postdiv2,
 ccb_pll2_postdiv1,
 ccb_pll2_postdiv0,
 ccb_pll2_lock,
 ccb_pll2_dskewcallock,
 ccb_pll2_dskewcalout,
 ccb_pll3_dskewcalin,
 ccb_pll3_pllen,
 ccb_pll3_dsmen,
 ccb_pll3_dskewfastcal,
 ccb_pll3_dskewcalen,
 ccb_pll3_dskewcalcnt,
 ccb_pll3_dskewcalbyp,
 ccb_pll3_dacen,
 ccb_pll3_refdiv,
 ccb_pll3_foutvcoen,
 ccb_pll3_foutvcobyp,
 ccb_pll3_fouten,
 ccb_pll3_frac,
 ccb_pll3_fbdiv,
 ccb_pll3_postdiv3,
 ccb_pll3_postdiv2,
 ccb_pll3_postdiv1,
 ccb_pll3_postdiv0,
 ccb_pll3_lock,
 ccb_pll3_dskewcallock,
 ccb_pll3_dskewcalout,
 cfg_done */

   
    input logic clk_out1,
    input logic clk_out2,
    input logic clk_out3,
    input logic clk_out4,
    input logic uart0_sin,
    input logic uart0_rtsn,
    input logic reset,
   // input [2:0] bootm,
    output logic uart0_sout,
    output logic uart0_ctsn
    
    );
    
    assign uart0_ctsn = 1'b0;

//  clk_wiz_0 instance_name
//   (
//    // Clock out ports
//    .clk_out1(clk_out1),     // output clk_out1 106.66
//    .clk_out2(clk_out2),     // output clk_out2 53.3
//    .clk_out3(clk_out3),     // output clk_out3 26.65
//    .clk_out4(clk_out4),     // output clk_out4 13.33
//    // Status and control signals
//    .reset(reset), // input reset
//    .locked(locked),       // output locked
//   // Clock in ports
//    .clk_in1(dut_clk));      // input clk_in1

 
 
   
//   `ifdef  PROTOTYPE_SIM
//    assign dut_clk=CLK0_P;
//    assign reset=SYNC0_P;
//   `else
//   
//   
//     profpga_clocksync # (
//			.CLK_CORE_COMPENSATION ( "DELAYED" )
//			) 
//   U_PROFPGA_AXI_CLOCKSYNC (
//			    // access to FPGA pins
//			    .clk_p            ( CLK0_P  ),
//			    .clk_n            ( CLK0_N  ),
//			    .sync_p           ( SYNC0_P ),
//			    .sync_n           ( SYNC0_N ),
//			    
//			    // clock from pad
//			    .clk_o            ( clk_from_clocksync ),
//			    
//			    // clock feedback (either clk_o or 1:1 output from MMCM/PLL)
//			    .clk_i            ( dut_clk   ),
//			    .clk_locked_i     ( 1'b1      ),
//			    
//			    // configuration access from profpga_infrastructure, not needed here
//			    .mmi64_clk        ( 1'b1      ),
//			    .mmi64_reset      ( 1'b0      ),
//			    .cfg_dn_i         ( 20'b0     ),
//			    .cfg_up_o         (           ),
//			    
//			    // sync events
//			    .user_reset_o     ( reset  ),
//			    .user_strobe1_o   (         ),
//			    .user_strobe2_o   (             ),
//			    .user_event_id_o  (             ),
//			    .user_event_en_o  (             )
//);
//    BUFG U_BUFG_DUT_CLK ( .I (clk_from_clocksync), .O (dut_clk) );
//    `endif




    localparam FCB_CHAIN_NUM = 128;
    localparam ICB_CHAIN_NUM = 1;
/*
   input          clk_osc;
   output         rst_n_fpga0;
   output         rst_n_fpga1;
   output         rst_n_fpga_s;
   input          clk_fpga_fabric_m0;
   input          clk_fpga_fabric_m1;
   input          clk_fpga_fabric_s0;
   input          clk_fpga_fabric_fcb_pcb;
   input          clk_fpga_fabric_irq;
   input          clk_fpga_fabric_dma;
   input          clk_fpga_fabric_ace;
   output         clk_fpga_pll0_ref;
   output         clk_fpga_pll1_ref;
   output         clk_fpga_pll2_ref;
   output         clk_fpga_pll3_ref;   
   input          rst_n_fpga_fabric_m0;
   input          rst_n_fpga_fabric_m1;
   input          rst_n_fpga_fabric_s0;
   input          rst_n_fpga_fabric_fcb_pcb;
   input          rst_n_fpga_fabric_irq;
   input          rst_n_fpga_fabric_dma;
   input          rst_n_fpga_fabric_ace;
   output         scl_o;
   output         spi_clk_oe;
   output         spi_clk_out;
   output [31:0]  gpio_pulldown;
   output [31:0]  gpio_pullup;
   input          pit_pause;
   output         mdio_mdc;
   inout          usb_dp;
   inout          usb_dn;
   inout          usb_id;
   inout          usb_vbus;
   inout          usb_rtrim;
   input          usb_xtal_in;
   output [1:0]   jtag_control;
   input          acpu_jtag_tck;
   input          acpu_jtag_tdi;
   output         acpu_jtag_tdo;
   input          acpu_jtag_tms;
   input          bcpu_jtag_tck;
   input          bcpu_jtag_tdi;
   output         bcpu_jtag_tdo;
   input          bcpu_jtag_tms;
   output         atbytes;
   output [15:0]  atdata;
   output [7:0]   atid;
   input          atready;
   output         atvalid;
   input          afvalid;
   output         afready;
   inout  [7:0]   dm;
   inout  [63:0]  dq;
   inout  [7:0]   dqs;
   inout  [7:0]   dqs_n;
   input  [15:0]  fpga_irq_src;
   output [12:0]  fpga_irq_set;
   input  [3:0]   dma_req_fpga;
   output [3:0]   dma_ack_fpga;
   output [31:0]  fpga_ahb_s0_haddr;
   output [2:0]   fpga_ahb_s0_hburst;
   output         fpga_ahb_s0_hmastlock;
   output [3:0]   fpga_ahb_s0_hprot;
   input  [31:0]  fpga_ahb_s0_hrdata;
   input          fpga_ahb_s0_hready;
   input          fpga_ahb_s0_hresp;
   output         fpga_ahb_s0_hsel;
   output [2:0]   fpga_ahb_s0_hsize;
   output [1:0]   fpga_ahb_s0_htrans;
   output [3:0]   fpga_ahb_s0_hwbe;
   output [31:0]  fpga_ahb_s0_hwdata;
   output         fpga_ahb_s0_hwrite;
   input  [31:0]  fpga_axi_m0_ar_addr;
   input  [1:0]   fpga_axi_m0_ar_burst;
   input  [3:0]   fpga_axi_m0_ar_cache;
   input  [3:0]   fpga_axi_m0_ar_id;
   input  [2:0]   fpga_axi_m0_ar_len;
   input          fpga_axi_m0_ar_lock;
   input  [2:0]   fpga_axi_m0_ar_prot;
   output         fpga_axi_m0_ar_ready;
   input  [2:0]   fpga_axi_m0_ar_size;
   input          fpga_axi_m0_ar_valid;
   input  [31:0]  fpga_axi_m0_aw_addr;
   input  [1:0]   fpga_axi_m0_aw_burst;
   input  [3:0]   fpga_axi_m0_aw_cache;
   input  [3:0]   fpga_axi_m0_aw_id;
   input  [2:0]   fpga_axi_m0_aw_len;
   input          fpga_axi_m0_aw_lock;
   input  [2:0]   fpga_axi_m0_aw_prot;
   output         fpga_axi_m0_aw_ready;
   input  [2:0]   fpga_axi_m0_aw_size;
   input          fpga_axi_m0_aw_valid;
   output [3:0]   fpga_axi_m0_b_id;
   input          fpga_axi_m0_b_ready;
   output [1:0]   fpga_axi_m0_b_resp;
   output         fpga_axi_m0_b_valid;
   output [63:0]  fpga_axi_m0_r_data;
   output [3:0]   fpga_axi_m0_r_id;
   output         fpga_axi_m0_r_last;
   input          fpga_axi_m0_r_ready;
   output [1:0]   fpga_axi_m0_r_resp;
   output         fpga_axi_m0_r_valid;
   input  [63:0]  fpga_axi_m0_w_data;
   input          fpga_axi_m0_w_last;
   output         fpga_axi_m0_w_ready;
   input  [7:0]   fpga_axi_m0_w_strb;
   input          fpga_axi_m0_w_valid;
   input  [31:0]  fpga_axi_m1_ar_addr;
   input  [1:0]   fpga_axi_m1_ar_burst;
   input  [3:0]   fpga_axi_m1_ar_cache;
   input  [3:0]   fpga_axi_m1_ar_id;
   input  [3:0]   fpga_axi_m1_ar_len;
   input          fpga_axi_m1_ar_lock;
   input  [2:0]   fpga_axi_m1_ar_prot;
   output         fpga_axi_m1_ar_ready;
   input  [2:0]   fpga_axi_m1_ar_size;
   input          fpga_axi_m1_ar_valid;
   input  [31:0]  fpga_axi_m1_aw_addr;
   input  [1:0]   fpga_axi_m1_aw_burst;
   input  [3:0]   fpga_axi_m1_aw_cache;
   input  [3:0]   fpga_axi_m1_aw_id;
   input  [3:0]   fpga_axi_m1_aw_len;
   input          fpga_axi_m1_aw_lock;
   input  [2:0]   fpga_axi_m1_aw_prot;
   output         fpga_axi_m1_aw_ready;
   input  [2:0]   fpga_axi_m1_aw_size;
   input          fpga_axi_m1_aw_valid;
   output [3:0]   fpga_axi_m1_b_id;
   input          fpga_axi_m1_b_ready;
   output [1:0]   fpga_axi_m1_b_resp;
   output         fpga_axi_m1_b_valid;
   output [31:0]  fpga_axi_m1_r_data;
   output [3:0]   fpga_axi_m1_r_id;
   output         fpga_axi_m1_r_last;
   input          fpga_axi_m1_r_ready;
   output [1:0]   fpga_axi_m1_r_resp;
   output         fpga_axi_m1_r_valid;
   input  [31:0]  fpga_axi_m1_w_data;
   input          fpga_axi_m1_w_last;
   output         fpga_axi_m1_w_ready;
   input  [3:0]   fpga_axi_m1_w_strb;
   input          fpga_axi_m1_w_valid;
   output         ace_isolation_ctl;
   output         irq_isolation_ctl;
   output         fcb_isolation_ctl;
   output         ahb_isolation_ctl;
   output         axi1_isolation_ctl;
   output         axi0_isolation_ctl;
   input          atclk;
   input          atresetn;
   input          atclken;
   output         ace_vstart;
   output         ace_istart;
   output         ace_divalid;
   output         ace_doready;
   output [31:0]  ace_dinop;
   input          ace_dovalid;
   input          ace_vbreak;
   input          ace_diready;
   input  [31:0]  ace_doutop;  
   input  [ 3:0]  dti_ext_vref;; 
   output [29:0]  pad_mem_ctl;  
   output [ 1:0]  pad_mem_clk;  
   output [ 1:0]  pad_mem_clk_n;
   inout  [ 3:0]  pad_mem_dm;   
   inout  [31:0]  pad_mem_dq;   
   inout  [ 3:0]  pad_mem_dqs;  
   inout  [ 3:0]  pad_mem_dqs_n;
   input  [29:0]  clockdr_ctl;  
   input  [ 1:0]  clockdr_clk;  
   input  [ 3:0]  clockdr_dm;   
   input  [31:0]  clockdr_dq;   
   input  [ 3:0]  clockdr_dqs;  
   input  [29:0]  jtag_si_ctl;  
   input  [ 1:0]  jtag_si_clk;  
   input  [ 3:0]  jtag_si_dm;   
   input  [31:0]  jtag_si_dq;   
   input  [ 3:0]  jtag_si_dqs;  
   output [29:0]  jtag_so_ctl;  
   output [ 1:0]  jtag_so_clk;  
   output [ 3:0]  jtag_so_dm;   
   output [31:0]  jtag_so_dq;   
   output [ 3:0]  jtag_so_dqs;  
   input  [29:0]  mode_ctl;     
   input  [ 1:0]  mode_clk;     
   input  [ 3:0]  mode_dm;      
   input  [31:0]  mode_dq;      
   input  [ 3:0]  mode_dqs;     
   input  [ 3:0]  mode_i_dm;    
   input  [31:0]  mode_i_dq;    
   input  [ 3:0]  mode_i_dqs;   
   input          pad_ref;      
   input          se;           
   input          se_ck;        
   input  [29:0]  shiftdr_ctl;  
   input  [ 1:0]  shiftdr_clk;  
   input  [ 3:0]  shiftdr_dm;   
   input  [31:0]  shiftdr_dq;   
   input  [ 3:0]  shiftdr_dqs;  
   input  [ 1:0]  si_clk;       
   input  [29:0]  si_ctl;       
   input  [ 3:0]  si_dm;        
   input  [31:0]  si_dq;        
   input  [ 3:0]  si_rd;        
   input  [ 3:0]  si_wr;        
   output [ 1:0]  so_clk;       
   output [29:0]  so_ctl;       
   output [ 3:0]  so_dm;        
   output [31:0]  so_dq;        
   output [ 3:0]  so_rd;        
   output [ 3:0]  so_wr;        
   input          t_cgctl_ctl;  
   input  [ 3:0]  t_cgctl_dq;   
   input          t_rctl_ctl;   
   input  [ 3:0]  t_rctl_dq;    
   input          vdd;          
   input          vddo;         
   input          vss;          
   input  [29:0]  updatedr_ctl; 
   input  [ 1:0]  updatedr_clk; 
   input  [ 3:0]  updatedr_dm;  
   input  [31:0]  updatedr_dq;  
   input  [ 3:0]  updatedr_dqs; 
   inout          pad_comp;     
   output [ 1:0]  yc_clk;       
   output [29:0]  yc_ctl;       
   output [ 3:0]  y_dm;
   output [31:0]  y_dq;
   output [ 3:0]  y_dqs;        
   inout          pad_vref;
   output        fcb_clk_o  [FCB_CHAIN_NUM];
   output        fcb_data_o [FCB_CHAIN_NUM];
   output        fcb_cmd_o  [FCB_CHAIN_NUM];
   input         fcb_clk_i  [FCB_CHAIN_NUM];   
   input         fcb_data_i [FCB_CHAIN_NUM];
   output        fcb_rst_n               ;
   output        icb_clk_o  [ICB_CHAIN_NUM];
   output        icb_data_o [ICB_CHAIN_NUM];
   output        icb_cmd_o  [ICB_CHAIN_NUM];
   input         icb_clk_i  [ICB_CHAIN_NUM];   
   input         icb_data_i [ICB_CHAIN_NUM];
   output        icb_rst_n               ;
   output [35:0] pl_data_o               ;
   output [31:0] pl_addr_o               ;
   output        pl_ena_o                ;
   output        pl_clk_o                ;
   output        pl_ren_o                ;
   output        pl_init_o               ;
   output [ 1:0] pl_wen_o                ;
   input  [35:0] pl_data_i               ;
   output [11:0] ccb_pll0_dskewcalin    ;
   output        ccb_pll0_pllen         ;
   output        ccb_pll0_dsmen         ;
   output        ccb_pll0_dskewfastcal  ;
   output        ccb_pll0_dskewcalen    ;
   output [ 2:0] ccb_pll0_dskewcalcnt   ;
   output        ccb_pll0_dskewcalbyp   ;
   output        ccb_pll0_dacen         ;
   output [ 5:0] ccb_pll0_refdiv        ;
   output        ccb_pll0_foutvcoen     ;
   output [ 4:0] ccb_pll0_foutvcobyp    ;
   output [ 3:0] ccb_pll0_fouten        ;
   output [23:0] ccb_pll0_frac          ;
   output [11:0] ccb_pll0_fbdiv         ;
   output [ 3:0] ccb_pll0_postdiv3      ;
   output [ 3:0] ccb_pll0_postdiv2      ;
   output [ 3:0] ccb_pll0_postdiv1      ;
   output [ 3:0] ccb_pll0_postdiv0      ;
   input         ccb_pll0_lock          ;
   input         ccb_pll0_dskewcallock  ;
   input  [11:0] ccb_pll0_dskewcalout   ;
   output [11:0] ccb_pll1_dskewcalin    ;
   output        ccb_pll1_pllen         ;
   output        ccb_pll1_dsmen         ;
   output        ccb_pll1_dskewfastcal  ;
   output        ccb_pll1_dskewcalen    ;
   output [ 2:0] ccb_pll1_dskewcalcnt   ;
   output        ccb_pll1_dskewcalbyp   ;
   output        ccb_pll1_dacen         ;
   output [ 5:0] ccb_pll1_refdiv        ;
   output        ccb_pll1_foutvcoen     ;
   output [ 4:0] ccb_pll1_foutvcobyp    ;
   output [ 3:0] ccb_pll1_fouten        ;
   output [23:0] ccb_pll1_frac          ;
   output [11:0] ccb_pll1_fbdiv         ;
   output [ 3:0] ccb_pll1_postdiv3      ;
   output [ 3:0] ccb_pll1_postdiv2      ;
   output [ 3:0] ccb_pll1_postdiv1      ;
   output [ 3:0] ccb_pll1_postdiv0      ;
   input         ccb_pll1_lock          ;
   input         ccb_pll1_dskewcallock  ;
   input  [11:0] ccb_pll1_dskewcalout   ;
   output [11:0] ccb_pll2_dskewcalin    ;
   output        ccb_pll2_pllen         ;
   output        ccb_pll2_dsmen         ;
   output        ccb_pll2_dskewfastcal  ;
   output        ccb_pll2_dskewcalen    ;
   output [ 2:0] ccb_pll2_dskewcalcnt   ;
   output        ccb_pll2_dskewcalbyp   ;
   output        ccb_pll2_dacen         ;
   output [ 5:0] ccb_pll2_refdiv        ;
   output        ccb_pll2_foutvcoen     ;
   output [ 4:0] ccb_pll2_foutvcobyp    ;
   output [ 3:0] ccb_pll2_fouten        ;
   output [23:0] ccb_pll2_frac          ;
   output [11:0] ccb_pll2_fbdiv         ;
   output [ 3:0] ccb_pll2_postdiv3      ;
   output [ 3:0] ccb_pll2_postdiv2      ;
   output [ 3:0] ccb_pll2_postdiv1      ;
   output [ 3:0] ccb_pll2_postdiv0      ;
   input         ccb_pll2_lock          ;
   input         ccb_pll2_dskewcallock  ;
   input  [11:0] ccb_pll2_dskewcalout   ;
   output [11:0] ccb_pll3_dskewcalin    ;
   output        ccb_pll3_pllen         ;
   output        ccb_pll3_dsmen         ;
   output        ccb_pll3_dskewfastcal  ;
   output        ccb_pll3_dskewcalen    ;
   output [ 2:0] ccb_pll3_dskewcalcnt   ;
   output        ccb_pll3_dskewcalbyp   ;
   output        ccb_pll3_dacen         ;
   output [ 5:0] ccb_pll3_refdiv        ;
   output        ccb_pll3_foutvcoen     ;
   output [ 4:0] ccb_pll3_foutvcobyp    ;
   output [ 3:0] ccb_pll3_fouten        ;
   output [23:0] ccb_pll3_frac          ;
   output [11:0] ccb_pll3_fbdiv         ;
   output [ 3:0] ccb_pll3_postdiv3      ;
   output [ 3:0] ccb_pll3_postdiv2      ;
   output [ 3:0] ccb_pll3_postdiv1      ;
   output [ 3:0] ccb_pll3_postdiv0      ;
   input         ccb_pll3_lock          ;
   input         ccb_pll3_dskewcallock  ;
   input  [11:0] ccb_pll3_dskewcalout   ;   
   output        cfg_done               ;

   // PAD IOs
   inout		RST_N;
   inout		XIN;
   inout		REF_CLK_1;
   inout		REF_CLK_2;
   inout		REF_CLK_3;
   inout		REF_CLK_4;
   inout		TESTMODE;
   inout		BOOTM0;
   inout		BOOTM1;
   inout		BOOTM2;
   inout		CLKSEL_0;
   inout		CLKSEL_1;
   inout		JTAG_TDI;
   inout		JTAG_TDO;
   inout		JTAG_TMS;
   inout		JTAG_TCK;
   inout		JTAG_TRSTN;
   inout		GPIO_A_0;
   inout		GPIO_A_1;
   inout		GPIO_A_2;
   inout		GPIO_A_3;
   inout		GPIO_A_4;
   inout		GPIO_A_5;
   inout		GPIO_A_6;
   inout		GPIO_A_7;
   inout		GPIO_A_8;
   inout		GPIO_A_9;
   inout		GPIO_A_10;
   inout		GPIO_A_11;
   inout		GPIO_A_12;
   inout		GPIO_A_13;
   inout		GPIO_A_14;
   inout		GPIO_A_15;
   inout		GPIO_B_0;
   inout		GPIO_B_1;
   inout		GPIO_B_2;
   inout		GPIO_B_3;
   inout		GPIO_B_4;
   inout		GPIO_B_5;
   inout		GPIO_B_6;
   inout		GPIO_B_7;
   inout		GPIO_B_8;
   inout		GPIO_B_9;
   inout		GPIO_B_10;
   inout		GPIO_B_11;
   inout		GPIO_B_12;
   inout		GPIO_B_13;
   inout		GPIO_B_14;
   inout		GPIO_B_15;
   inout		GPIO_C_0;
   inout		GPIO_C_1;
   inout		GPIO_C_2;
   inout		GPIO_C_3;
   inout		GPIO_C_4;
   inout		GPIO_C_5;
   inout		GPIO_C_6;
   inout		GPIO_C_7;
   inout		GPIO_C_8;
   inout		GPIO_C_9;
   inout		GPIO_C_10;
   inout		GPIO_C_11;
   inout		GPIO_C_12;
   inout		GPIO_C_13;
   inout		GPIO_C_14;
   inout		GPIO_C_15;
   inout		I2C_SCL;
   inout		SPI_SCLK;
   inout		GPT_RTC;
   inout		MDIO_MDC;
   inout		MDIO_DATA;
   inout		RGMII_TXD0;
   inout		RGMII_TXD1;
   inout		RGMII_TXD2;
   inout		RGMII_TXD3;
   inout		RGMII_TX_CTL;
   inout		RGMII_TXC;
   inout		RGMII_RXD0;
   inout		RGMII_RXD1;
   inout		RGMII_RXD2;
   inout		RGMII_RXD3;
   inout		RGMII_RX_CTL;
   inout		RGMII_RXC;
   inout		USB_DP;
   inout		USB_DN;
   inout		USB_XTAL_OUT;
   inout		USB_XTAL_IN;

*/
   logic         clk_sel0;
   logic         clk_sel1;
   logic         clk_osc;
   logic         clk_xtal_ref;
   logic         rst_n_poweron;
   logic         rst_n_fpga0;
   logic         rst_n_fpga1;
   logic         rst_n_fpga_s;
   logic         clk_fpga_fabric_m0;
   logic         clk_fpga_fabric_m1;
   logic         clk_fpga_fabric_s0;
   logic         clk_fpga_fabric_fcb_pcb;
   logic         clk_fpga_fabric_irq;
   logic         clk_fpga_fabric_dma;
   logic         clk_fpga_fabric_ace;
   logic         clk_fpga_ref1;
   logic         clk_fpga_ref2;
   logic         clk_fpga_ref3;
   logic         clk_fpga_ref4;
   logic         clk_fpga_pll0_ref;
   logic         clk_fpga_pll1_ref;
   logic         clk_fpga_pll2_ref;
   logic         clk_fpga_pll3_ref;   
   logic         rst_n_fpga_fabric_m0;
   logic         rst_n_fpga_fabric_m1;
   logic         rst_n_fpga_fabric_s0;
   logic         rst_n_fpga_fabric_fcb_pcb;
   logic         rst_n_fpga_fabric_irq;
   logic         rst_n_fpga_fabric_dma;
   logic         rst_n_fpga_fabric_ace;   
   logic         testmode;
   logic         scl_o;
   logic         scl_i;
   logic         spi_clk_in;
   logic         spi_clk_oe;
   logic         spi_clk_out;
   logic [31:0]  gpio_pulldown;
   logic [31:0]  gpio_pullup;
   logic         rtc_clk;
   logic         pit_pause;
   logic [3:0]   rgmii_txd;
   logic         rgmii_tx_ctl;
   logic [3:0]   rgmii_rxd;
   logic         rgmii_rx_ctl;
   logic         rgmii_rxc;
   logic         mdio_mdc;
   logic         mdio_in;
   logic         mdio_out;
   logic         mdio_en;
   wire          usb_dp;
   wire          usb_dn;
   wire          usb_id;
   wire          usb_vbus;
   wire          usb_rtrim;
   logic         usb_xtal_in;
   logic [1:0]   jtag_control;
   logic         acpu_jtag_tck;
   logic         acpu_jtag_tdi;
   logic         acpu_jtag_tdo;
   logic         acpu_jtag_tms;
   logic         bcpu_jtag_tck;
   logic         bcpu_jtag_tdi;
   logic         bcpu_jtag_tdo;
   logic         bcpu_jtag_tms;
   logic         atbytes;
   logic [15:0]  atdata;
   logic [7:0]   atid;
   logic         atready;
   logic         atvalid;
   logic         afvalid;
   logic         afready;
   wire  [7:0]   dm;
   wire  [63:0]  dq;
   wire  [7:0]   dqs;
   wire  [7:0]   dqs_n;
   logic [15:0]  fpga_irq_src;
   logic [12:0]  fpga_irq_set;
   logic [3:0]   dma_req_fpga;
   logic [3:0]   dma_ack_fpga;
   logic [31:0]  fpga_ahb_s0_haddr;
   logic [2:0]   fpga_ahb_s0_hburst;
   logic         fpga_ahb_s0_hmastlock;
   logic [3:0]   fpga_ahb_s0_hprot;
   logic [31:0]  fpga_ahb_s0_hrdata;
   logic         fpga_ahb_s0_hready;
   logic         fpga_ahb_s0_hresp;
   logic         fpga_ahb_s0_hsel;
   logic [2:0]   fpga_ahb_s0_hsize;
   logic [1:0]   fpga_ahb_s0_htrans;
   logic [3:0]   fpga_ahb_s0_hwbe;
   logic [31:0]  fpga_ahb_s0_hwdata;
   logic         fpga_ahb_s0_hwrite;
   logic [31:0]  fpga_axi_m0_ar_addr;
   logic [1:0]   fpga_axi_m0_ar_burst;
   logic [3:0]   fpga_axi_m0_ar_cache;
   logic [3:0]   fpga_axi_m0_ar_id;
   logic [2:0]   fpga_axi_m0_ar_len;
   logic         fpga_axi_m0_ar_lock;
   logic [2:0]   fpga_axi_m0_ar_prot;
   logic         fpga_axi_m0_ar_ready;
   logic [2:0]   fpga_axi_m0_ar_size;
   logic         fpga_axi_m0_ar_valid;
   logic [31:0]  fpga_axi_m0_aw_addr;
   logic [1:0]   fpga_axi_m0_aw_burst;
   logic [3:0]   fpga_axi_m0_aw_cache;
   logic [3:0]   fpga_axi_m0_aw_id;
   logic [2:0]   fpga_axi_m0_aw_len;
   logic         fpga_axi_m0_aw_lock;
   logic [2:0]   fpga_axi_m0_aw_prot;
   logic         fpga_axi_m0_aw_ready;
   logic [2:0]   fpga_axi_m0_aw_size;
   logic         fpga_axi_m0_aw_valid;
   logic [3:0]   fpga_axi_m0_b_id;
   logic         fpga_axi_m0_b_ready;
   logic [1:0]   fpga_axi_m0_b_resp;
   logic         fpga_axi_m0_b_valid;
   logic [63:0]  fpga_axi_m0_r_data;
   logic [3:0]   fpga_axi_m0_r_id;
   logic         fpga_axi_m0_r_last;
   logic         fpga_axi_m0_r_ready;
   logic [1:0]   fpga_axi_m0_r_resp;
   logic         fpga_axi_m0_r_valid;
   logic [63:0]  fpga_axi_m0_w_data;
   logic         fpga_axi_m0_w_last;
   logic         fpga_axi_m0_w_ready;
   logic [7:0]   fpga_axi_m0_w_strb;
   logic         fpga_axi_m0_w_valid;
   logic [31:0]  fpga_axi_m1_ar_addr;
   logic [1:0]   fpga_axi_m1_ar_burst;
   logic [3:0]   fpga_axi_m1_ar_cache;
   logic [3:0]   fpga_axi_m1_ar_id;
   logic [3:0]   fpga_axi_m1_ar_len;
   logic         fpga_axi_m1_ar_lock;
   logic [2:0]   fpga_axi_m1_ar_prot;
   logic         fpga_axi_m1_ar_ready;
   logic [2:0]   fpga_axi_m1_ar_size;
   logic         fpga_axi_m1_ar_valid;
   logic [31:0]  fpga_axi_m1_aw_addr;
   logic [1:0]   fpga_axi_m1_aw_burst;
   logic [3:0]   fpga_axi_m1_aw_cache;
   logic [3:0]   fpga_axi_m1_aw_id;
   logic [3:0]   fpga_axi_m1_aw_len;
   logic         fpga_axi_m1_aw_lock;
   logic [2:0]   fpga_axi_m1_aw_prot;
   logic         fpga_axi_m1_aw_ready;
   logic [2:0]   fpga_axi_m1_aw_size;
   logic         fpga_axi_m1_aw_valid;
   logic [3:0]   fpga_axi_m1_b_id;
   logic         fpga_axi_m1_b_ready;
   logic [1:0]   fpga_axi_m1_b_resp;
   logic         fpga_axi_m1_b_valid;
   logic [31:0]  fpga_axi_m1_r_data;
   logic [3:0]   fpga_axi_m1_r_id;
   logic         fpga_axi_m1_r_last;
   logic         fpga_axi_m1_r_ready;
   logic [1:0]   fpga_axi_m1_r_resp;
   logic         fpga_axi_m1_r_valid;
   logic [31:0]  fpga_axi_m1_w_data;
   logic         fpga_axi_m1_w_last;
   logic         fpga_axi_m1_w_ready;
   logic [3:0]   fpga_axi_m1_w_strb;
   logic         fpga_axi_m1_w_valid;
   logic         ace_isolation_ctl;
   logic         irq_isolation_ctl;
   logic         fcb_isolation_ctl;
   logic         ahb_isolation_ctl;
   logic         axi1_isolation_ctl;
   logic         axi0_isolation_ctl;
   logic         atclk;
   logic         atresetn;
   logic         atclken;
   logic         ace_vstart;
   logic         ace_istart;
   logic         ace_divalid;
   logic         ace_doready;
   logic [31:0]  ace_dinop;
   logic         ace_dovalid;
   logic         ace_vbreak;
   logic         ace_diready;
   logic [31:0]  ace_doutop;   
   logic [ 3:0]  dti_ext_vref; 
   logic [29:0]  pad_mem_ctl;  
   logic [ 1:0]  pad_mem_clk;  
   logic [ 1:0]  pad_mem_clk_n;
   wire  [ 3:0]  pad_mem_dm;   
   wire  [31:0]  pad_mem_dq;   
   wire  [ 3:0]  pad_mem_dqs;  
   wire  [ 3:0]  pad_mem_dqs_n;
   logic [29:0]  clockdr_ctl;  
   logic [ 1:0]  clockdr_clk;  
   logic [ 3:0]  clockdr_dm;   
   logic [31:0]  clockdr_dq;   
   logic [ 3:0]  clockdr_dqs;  
   logic [29:0]  jtag_si_ctl;  
   logic [ 1:0]  jtag_si_clk;  
   logic [ 3:0]  jtag_si_dm;   
   logic [31:0]  jtag_si_dq;   
   logic [ 3:0]  jtag_si_dqs;  
   logic [29:0]  jtag_so_ctl;  
   logic [ 1:0]  jtag_so_clk;  
   logic [ 3:0]  jtag_so_dm;   
   logic [31:0]  jtag_so_dq;   
   logic [ 3:0]  jtag_so_dqs;  
   logic [29:0]  mode_ctl;     
   logic [ 1:0]  mode_clk;     
   logic [ 3:0]  mode_dm;      
   logic [31:0]  mode_dq;      
   logic [ 3:0]  mode_dqs;     
   logic [ 3:0]  mode_i_dm;    
   logic [31:0]  mode_i_dq;    
   logic [ 3:0]  mode_i_dqs;   
   logic         pad_ref;      
   logic         se;           
   logic         se_ck;        
   logic [29:0]  shiftdr_ctl;  
   logic [ 1:0]  shiftdr_clk;  
   logic [ 3:0]  shiftdr_dm;   
   logic [31:0]  shiftdr_dq;   
   logic [ 3:0]  shiftdr_dqs;  
   logic [ 1:0]  si_clk;       
   logic [29:0]  si_ctl;       
   logic [ 3:0]  si_dm;        
   logic [31:0]  si_dq;        
   logic [ 3:0]  si_rd;        
   logic [ 3:0]  si_wr;        
   logic [ 1:0]  so_clk;       
   logic [29:0]  so_ctl;       
   logic [ 3:0]  so_dm;        
   logic [31:0]  so_dq;        
   logic [ 3:0]  so_rd;        
   logic [ 3:0]  so_wr;        
   logic         t_cgctl_ctl;  
   logic [ 3:0]  t_cgctl_dq;   
   logic         t_rctl_ctl;   
   logic [ 3:0]  t_rctl_dq;    
   logic         vdd;          
   logic         vddo;         
   logic         vss;          
   logic [29:0]  updatedr_ctl; 
   logic [ 1:0]  updatedr_clk; 
   logic [ 3:0]  updatedr_dm;  
   logic [31:0]  updatedr_dq;  
   logic [ 3:0]  updatedr_dqs; 
   wire          pad_comp;     
   logic [ 1:0]  yc_clk;       
   logic [29:0]  yc_ctl;       
   logic [ 3:0]  y_dm;
   logic [31:0]  y_dq;
   logic [ 3:0]  y_dqs;        
   wire          pad_vref;
   logic        fcb_clk_o  [FCB_CHAIN_NUM];
   logic        fcb_data_o [FCB_CHAIN_NUM];
   logic        fcb_cmd_o  [FCB_CHAIN_NUM];
   logic        fcb_clk_i  [FCB_CHAIN_NUM]; 
   logic        fcb_data_i [FCB_CHAIN_NUM];
   logic        fcb_rst_n               ;
   logic        icb_clk_o  [ICB_CHAIN_NUM];
   logic        icb_data_o [ICB_CHAIN_NUM];
   logic        icb_cmd_o  [ICB_CHAIN_NUM];
   logic        icb_clk_i  [ICB_CHAIN_NUM];   
   logic        icb_data_i [ICB_CHAIN_NUM];
   logic        icb_rst_n               ;
   logic [35:0] pl_data_o               ;
   logic [31:0] pl_addr_o               ;
   logic        pl_ena_o                ;
   logic        pl_clk_o                ;
   logic        pl_ren_o                ;
   logic        pl_init_o               ;
   logic [ 1:0] pl_wen_o                ;
   logic [35:0] pl_data_i               ;
   logic [11:0] ccb_pll0_dskewcalin    ;
   logic        ccb_pll0_pllen         ;
   logic        ccb_pll0_dsmen         ;
   logic        ccb_pll0_dskewfastcal  ;
   logic        ccb_pll0_dskewcalen    ;
   logic [ 2:0] ccb_pll0_dskewcalcnt   ;
   logic        ccb_pll0_dskewcalbyp   ;
   logic        ccb_pll0_dacen         ;
   logic [ 5:0] ccb_pll0_refdiv        ;
   logic        ccb_pll0_foutvcoen     ;
   logic [ 4:0] ccb_pll0_foutvcobyp    ;
   logic [ 3:0] ccb_pll0_fouten        ;
   logic [23:0] ccb_pll0_frac          ;
   logic [11:0] ccb_pll0_fbdiv         ;
   logic [ 3:0] ccb_pll0_postdiv3      ;
   logic [ 3:0] ccb_pll0_postdiv2      ;
   logic [ 3:0] ccb_pll0_postdiv1      ;
   logic [ 3:0] ccb_pll0_postdiv0      ;
   logic        ccb_pll0_lock          ;
   logic        ccb_pll0_dskewcallock  ;
   logic [11:0] ccb_pll0_dskewcalout   ;
   logic [11:0] ccb_pll1_dskewcalin    ;
   logic        ccb_pll1_pllen         ;
   logic        ccb_pll1_dsmen         ;
   logic        ccb_pll1_dskewfastcal  ;
   logic        ccb_pll1_dskewcalen    ;
   logic [ 2:0] ccb_pll1_dskewcalcnt   ;
   logic        ccb_pll1_dskewcalbyp   ;
   logic        ccb_pll1_dacen         ;
   logic [ 5:0] ccb_pll1_refdiv        ;
   logic        ccb_pll1_foutvcoen     ;
   logic [ 4:0] ccb_pll1_foutvcobyp    ;
   logic [ 3:0] ccb_pll1_fouten        ;
   logic [23:0] ccb_pll1_frac          ;
   logic [11:0] ccb_pll1_fbdiv         ;
   logic [ 3:0] ccb_pll1_postdiv3      ;
   logic [ 3:0] ccb_pll1_postdiv2      ;
   logic [ 3:0] ccb_pll1_postdiv1      ;
   logic [ 3:0] ccb_pll1_postdiv0      ;
   logic        ccb_pll1_lock          ;
   logic        ccb_pll1_dskewcallock  ;
   logic [11:0] ccb_pll1_dskewcalout   ;
   logic [11:0] ccb_pll2_dskewcalin    ;
   logic        ccb_pll2_pllen         ;
   logic        ccb_pll2_dsmen         ;
   logic        ccb_pll2_dskewfastcal  ;
   logic        ccb_pll2_dskewcalen    ;
   logic [ 2:0] ccb_pll2_dskewcalcnt   ;
   logic        ccb_pll2_dskewcalbyp   ;
   logic        ccb_pll2_dacen         ;
   logic [ 5:0] ccb_pll2_refdiv        ;
   logic        ccb_pll2_foutvcoen     ;
   logic [ 4:0] ccb_pll2_foutvcobyp    ;
   logic [ 3:0] ccb_pll2_fouten        ;
   logic [23:0] ccb_pll2_frac          ;
   logic [11:0] ccb_pll2_fbdiv         ;
   logic [ 3:0] ccb_pll2_postdiv3      ;
   logic [ 3:0] ccb_pll2_postdiv2      ;
   logic [ 3:0] ccb_pll2_postdiv1      ;
   logic [ 3:0] ccb_pll2_postdiv0      ;
   logic        ccb_pll2_lock          ;
   logic        ccb_pll2_dskewcallock  ;
   logic [11:0] ccb_pll2_dskewcalout   ;
   logic [11:0] ccb_pll3_dskewcalin    ;
   logic        ccb_pll3_pllen         ;
   logic        ccb_pll3_dsmen         ;
   logic        ccb_pll3_dskewfastcal  ;
   logic        ccb_pll3_dskewcalen    ;
   logic [ 2:0] ccb_pll3_dskewcalcnt   ;
   logic        ccb_pll3_dskewcalbyp   ;
   logic        ccb_pll3_dacen         ;
   logic [ 5:0] ccb_pll3_refdiv        ;
   logic        ccb_pll3_foutvcoen     ;
   logic [ 4:0] ccb_pll3_foutvcobyp    ;
   logic [ 3:0] ccb_pll3_fouten        ;
   logic [23:0] ccb_pll3_frac          ;
   logic [11:0] ccb_pll3_fbdiv         ;
   logic [ 3:0] ccb_pll3_postdiv3      ;
   logic [ 3:0] ccb_pll3_postdiv2      ;
   logic [ 3:0] ccb_pll3_postdiv1      ;
   logic [ 3:0] ccb_pll3_postdiv0      ;
   logic        ccb_pll3_lock          ;
   logic        ccb_pll3_dskewcallock  ;
   logic [11:0] ccb_pll3_dskewcalout   ;   



logic  [ 3   : 0  ] acpu_arid_sig;
logic  [ 31  : 0  ] acpu_araddr_sig;
logic  [ 7   : 0  ] acpu_arlen_sig;
logic  [ 2   : 0  ] acpu_arsize_sig;
logic  [ 1   : 0  ] acpu_arburst_sig;
logic               acpu_arlock_sig;
logic  [ 3   : 0  ] acpu_arcache_sig;
logic  [ 2   : 0  ] acpu_arprot_sig;
logic               acpu_arvalid_sig;
logic  [ 3   : 0  ] acpu_awid_sig;
logic  [ 31  : 0  ] acpu_awaddr_sig;
logic  [ 7   : 0  ] acpu_awlen_sig;
logic  [ 2   : 0  ] acpu_awsize_sig;
logic  [ 1   : 0  ] acpu_awburst_sig;
logic               acpu_awlock_sig;
logic  [ 3   : 0  ] acpu_awcache_sig;
logic  [ 2   : 0  ] acpu_awprot_sig;
logic               acpu_awvalid_sig;
logic  [ 63  : 0  ] acpu_wdata_sig;
logic  [ 7   : 0  ] acpu_wstrb_sig;
logic               acpu_wlast_sig;
logic               acpu_wvalid_sig;
logic               acpu_bready_sig;
logic               acpu_rready_sig;
logic               acpu_dbg_srst_req_sig;
logic  [ 5   : 0  ] acpu_hart0_wakeup_event_sig;
logic               acpu_hart0_core_wfi_mode_sig;
logic               acpu_jtag_tdo_sig;
logic               config_ss_clk_acpu_sig;
logic               config_ss_clk_acpu_mtime_sig;
logic               config_ss_clk_bcpu_sig;
logic               config_ss_clk_ddr_phy_sig;
logic               config_ss_clk_ddr_ctl_sig;
logic               config_ss_clk_ddr_cfg_sig;
logic               config_ss_clk_apb_ug_sig;
logic               config_ss_rst_n_bcpu_sig;
logic               config_ss_rst_n_bcpu_bus_sig;
logic               config_ss_rst_n_sram_sig;
logic               config_ss_rst_n_acpu_sig;
logic               config_ss_rst_n_acpu_bus_sig;
logic               config_ss_rst_n_fpga0_sig;
logic               config_ss_rst_n_fpga1_sig;
logic               config_ss_rst_n_fpga_s_sig;
logic               config_ss_rst_n_ddr_sig;
logic               config_ss_rst_n_133_sig;
logic               config_ss_rst_n_266_sig;
logic               config_ss_rst_n_533_sig;
logic  [ 31  : 0  ] config_ss_acpu_wdt_s0_prdata_sig;
logic               config_ss_acpu_wdt_s0_pready_sig;
logic               config_ss_acpu_wdt_s0_pslverr_sig;
logic  [ 31  : 0  ] config_ss_bcpu_wdt_s0_prdata_sig;
logic               config_ss_bcpu_wdt_s0_pready_sig;
logic               config_ss_bcpu_wdt_s0_pslverr_sig;
logic  [ 31  : 0  ] config_ss_dma_s0_prdata_sig;
logic               config_ss_dma_s0_pready_sig;
logic               config_ss_dma_s0_pslverr_sig;
logic  [ 31  : 0  ] soc_fpga_intf_fcb_s0_prdata_sig;
logic               soc_fpga_intf_fcb_s0_pready_sig;
logic               soc_fpga_intf_fcb_s0_pslverr_sig;
logic  [ 31  : 0  ] config_ss_gpio_s0_prdata_sig;
logic               config_ss_gpio_s0_pready_sig;
logic               config_ss_gpio_s0_pslverr_sig;
logic  [ 31  : 0  ] config_ss_gpt_s0_prdata_sig;
logic               config_ss_gpt_s0_pready_sig;
logic               config_ss_gpt_s0_pslverr_sig;
logic  [ 31  : 0  ] config_ss_i2c_s0_prdata_sig;
logic               config_ss_i2c_s0_pready_sig;
logic               config_ss_i2c_s0_pslverr_sig;
logic  [ 31  : 0  ] config_ss_mbox_s0_prdata_sig;
logic               config_ss_mbox_s0_pready_sig;
logic               config_ss_mbox_s0_pslverr_sig;
logic  [ 31  : 0  ] config_ss_pufcc_s0_prdata_sig;
logic               config_ss_pufcc_s0_pready_sig;
logic               config_ss_pufcc_s0_pslverr_sig;
logic  [ 31  : 0  ] config_ss_scu_s0_prdata_sig;
logic               config_ss_scu_s0_pready_sig;
logic               config_ss_scu_s0_pslverr_sig;
logic  [ 31  : 0  ] config_ss_spi_reg_s0_hrdata_sig;
logic               config_ss_spi_reg_s0_hready_sig;
logic               config_ss_spi_reg_s0_hresp_sig;
logic  [ 31  : 0  ] config_ss_spi_mem_s0_hrdata_sig;
logic               config_ss_spi_mem_s0_hready_sig;
logic               config_ss_spi_mem_s0_hresp_sig;
logic  [ 31  : 0  ] config_ss_uart_s0_prdata_sig;
logic               config_ss_uart_s0_pready_sig;
logic               config_ss_uart_s0_pslverr_sig;
logic  [ 31  : 0  ] config_ss_uart_s1_prdata_sig;
logic               config_ss_uart_s1_pready_sig;
logic               config_ss_uart_s1_pslverr_sig;
logic               config_ss_usb_s0_arready_sig;
logic               config_ss_usb_s0_awready_sig;
logic  [ 1   : 0  ] config_ss_usb_s0_bresp_sig;
logic               config_ss_usb_s0_bvalid_sig;
logic  [ 31  : 0  ] config_ss_usb_s0_rdata_sig;
logic  [ 1   : 0  ] config_ss_usb_s0_rresp_sig;
logic               config_ss_usb_s0_rvalid_sig;
logic               config_ss_usb_s0_wready_sig;
logic  [ 31  : 0  ] config_ss_bcpu_m0_haddr_sig;
logic               config_ss_bcpu_m0_hsel_sig;
logic  [ 2   : 0  ] config_ss_bcpu_m0_hburst_sig;
logic  [ 3   : 0  ] config_ss_bcpu_m0_hprot_sig;
logic  [ 2   : 0  ] config_ss_bcpu_m0_hsize_sig;
logic  [ 1   : 0  ] config_ss_bcpu_m0_htrans_sig;
logic  [ 31  : 0  ] config_ss_bcpu_m0_hwdata_sig;
logic               config_ss_bcpu_m0_hwrite_sig;
logic  [ 31  : 0  ] config_ss_dma_m0_araddr_sig;
logic  [ 1   : 0  ] config_ss_dma_m0_arburst_sig;
logic  [ 3   : 0  ] config_ss_dma_m0_arcache_sig;
logic  [ 2   : 0  ] config_ss_dma_m0_arid_sig;
logic  [ 7   : 0  ] config_ss_dma_m0_arlen_sig;
logic               config_ss_dma_m0_arlock_sig;
logic  [ 2   : 0  ] config_ss_dma_m0_arprot_sig;
logic  [ 2   : 0  ] config_ss_dma_m0_arsize_sig;
logic               config_ss_dma_m0_arvalid_sig;
logic  [ 31  : 0  ] config_ss_dma_m0_awaddr_sig;
logic  [ 1   : 0  ] config_ss_dma_m0_awburst_sig;
logic  [ 3   : 0  ] config_ss_dma_m0_awcache_sig;
logic  [ 2   : 0  ] config_ss_dma_m0_awid_sig;
logic  [ 7   : 0  ] config_ss_dma_m0_awlen_sig;
logic               config_ss_dma_m0_awlock_sig;
logic  [ 2   : 0  ] config_ss_dma_m0_awprot_sig;
logic  [ 2   : 0  ] config_ss_dma_m0_awsize_sig;
logic               config_ss_dma_m0_awvalid_sig;
logic               config_ss_dma_m0_bready_sig;
logic               config_ss_dma_m0_rready_sig;
logic  [ 31  : 0  ] config_ss_dma_m0_wdata_sig;
logic               config_ss_dma_m0_wlast_sig;
logic  [ 3   : 0  ] config_ss_dma_m0_wstrb_sig;
logic               config_ss_dma_m0_wvalid_sig;
logic  [ 31  : 0  ] config_ss_dma_m1_araddr_sig;
logic  [ 1   : 0  ] config_ss_dma_m1_arburst_sig;
logic  [ 3   : 0  ] config_ss_dma_m1_arcache_sig;
logic  [ 2   : 0  ] config_ss_dma_m1_arid_sig;
logic  [ 7   : 0  ] config_ss_dma_m1_arlen_sig;
logic               config_ss_dma_m1_arlock_sig;
logic  [ 2   : 0  ] config_ss_dma_m1_arprot_sig;
logic  [ 2   : 0  ] config_ss_dma_m1_arsize_sig;
logic               config_ss_dma_m1_arvalid_sig;
logic  [ 31  : 0  ] config_ss_dma_m1_awaddr_sig;
logic  [ 1   : 0  ] config_ss_dma_m1_awburst_sig;
logic  [ 3   : 0  ] config_ss_dma_m1_awcache_sig;
logic  [ 2   : 0  ] config_ss_dma_m1_awid_sig;
logic  [ 7   : 0  ] config_ss_dma_m1_awlen_sig;
logic               config_ss_dma_m1_awlock_sig;
logic  [ 2   : 0  ] config_ss_dma_m1_awprot_sig;
logic  [ 2   : 0  ] config_ss_dma_m1_awsize_sig;
logic               config_ss_dma_m1_awvalid_sig;
logic               config_ss_dma_m1_bready_sig;
logic               config_ss_dma_m1_rready_sig;
logic  [ 31  : 0  ] config_ss_dma_m1_wdata_sig;
logic               config_ss_dma_m1_wlast_sig;
logic  [ 3   : 0  ] config_ss_dma_m1_wstrb_sig;
logic               config_ss_dma_m1_wvalid_sig;
logic  [ 31  : 0  ] config_ss_gbe_s0_prdata_sig;
logic               config_ss_gbe_s0_pslverr_sig;
logic  [ 31  : 0  ] config_ss_gbe_m0_araddr_sig;
logic  [ 1   : 0  ] config_ss_gbe_m0_arburst_sig;
logic  [ 3   : 0  ] config_ss_gbe_m0_arcache_sig;
logic  [ 3   : 0  ] config_ss_gbe_m0_arid_sig;
logic  [ 7   : 0  ] config_ss_gbe_m0_arlen_sig;
logic  [ 1   : 0  ] config_ss_gbe_m0_arlock_sig;
logic  [ 2   : 0  ] config_ss_gbe_m0_arprot_sig;
logic  [ 2   : 0  ] config_ss_gbe_m0_arsize_sig;
logic               config_ss_gbe_m0_arvalid_sig;
logic  [ 31  : 0  ] config_ss_gbe_m0_awaddr_sig;
logic  [ 1   : 0  ] config_ss_gbe_m0_awburst_sig;
logic  [ 3   : 0  ] config_ss_gbe_m0_awcache_sig;
logic  [ 3   : 0  ] config_ss_gbe_m0_awid_sig;
logic  [ 7   : 0  ] config_ss_gbe_m0_awlen_sig;
logic  [ 1   : 0  ] config_ss_gbe_m0_awlock_sig;
logic  [ 2   : 0  ] config_ss_gbe_m0_awprot_sig;
logic  [ 2   : 0  ] config_ss_gbe_m0_awsize_sig;
logic               config_ss_gbe_m0_awvalid_sig;
logic               config_ss_gbe_m0_bready_sig;
logic               config_ss_gbe_m0_rready_sig;
logic  [ 31  : 0  ] config_ss_gbe_m0_wdata_sig;
logic               config_ss_gbe_m0_wlast_sig;
logic  [ 3   : 0  ] config_ss_gbe_m0_wstrb_sig;
logic               config_ss_gbe_m0_wvalid_sig;
logic  [ 31  : 0  ] config_ss_pufcc_m0_ar_addr_sig;
logic  [ 1   : 0  ] config_ss_pufcc_m0_ar_burst_sig;
logic  [ 3   : 0  ] config_ss_pufcc_m0_ar_cache_sig;
logic  [ 3   : 0  ] config_ss_pufcc_m0_ar_id_sig;
logic  [ 7   : 0  ] config_ss_pufcc_m0_ar_len_sig;
logic               config_ss_pufcc_m0_ar_lock_sig;
logic  [ 2   : 0  ] config_ss_pufcc_m0_ar_prot_sig;
logic  [ 2   : 0  ] config_ss_pufcc_m0_ar_size_sig;
logic               config_ss_pufcc_m0_ar_valid_sig;
logic  [ 31  : 0  ] config_ss_pufcc_m0_aw_addr_sig;
logic  [ 1   : 0  ] config_ss_pufcc_m0_aw_burst_sig;
logic  [ 3   : 0  ] config_ss_pufcc_m0_aw_cache_sig;
logic  [ 3   : 0  ] config_ss_pufcc_m0_aw_id_sig;
logic  [ 7   : 0  ] config_ss_pufcc_m0_aw_len_sig;
logic               config_ss_pufcc_m0_aw_lock_sig;
logic  [ 2   : 0  ] config_ss_pufcc_m0_aw_prot_sig;
logic  [ 2   : 0  ] config_ss_pufcc_m0_aw_size_sig;
logic               config_ss_pufcc_m0_aw_valid_sig;
logic               config_ss_pufcc_m0_b_ready_sig;
logic               config_ss_pufcc_m0_r_ready_sig;
logic  [ 31  : 0  ] config_ss_pufcc_m0_w_data_sig;
logic               config_ss_pufcc_m0_w_last_sig;
logic  [ 3   : 0  ] config_ss_pufcc_m0_w_strb_sig;
logic               config_ss_pufcc_m0_w_valid_sig;
logic  [ 31  : 0  ] config_ss_usb_m0_araddr_sig;
logic  [ 1   : 0  ] config_ss_usb_m0_arburst_sig;
logic  [ 3   : 0  ] config_ss_usb_m0_arcache_sig;
logic  [ 3   : 0  ] config_ss_usb_m0_arid_sig;
logic  [ 3   : 0  ] config_ss_usb_m0_arlen_sig;
logic  [ 1   : 0  ] config_ss_usb_m0_arlock_sig;
logic  [ 2   : 0  ] config_ss_usb_m0_arprot_sig;
logic  [ 2   : 0  ] config_ss_usb_m0_arsize_sig;
logic               config_ss_usb_m0_arvalid_sig;
logic  [ 31  : 0  ] config_ss_usb_m0_awaddr_sig;
logic  [ 1   : 0  ] config_ss_usb_m0_awburst_sig;
logic  [ 3   : 0  ] config_ss_usb_m0_awcache_sig;
logic  [ 3   : 0  ] config_ss_usb_m0_awid_sig;
logic  [ 3   : 0  ] config_ss_usb_m0_awlen_sig;
logic  [ 1   : 0  ] config_ss_usb_m0_awlock_sig;
logic  [ 2   : 0  ] config_ss_usb_m0_awprot_sig;
logic  [ 2   : 0  ] config_ss_usb_m0_awsize_sig;
logic               config_ss_usb_m0_awvalid_sig;
logic               config_ss_usb_m0_bready_sig;
logic               config_ss_usb_m0_rready_sig;
logic  [ 31  : 0  ] config_ss_usb_m0_wdata_sig;
logic               config_ss_usb_m0_wlast_sig;
logic  [ 3   : 0  ] config_ss_usb_m0_wstrb_sig;
logic               config_ss_usb_m0_wvalid_sig;
logic  [ 31  : 0  ] config_ss_acpu_irq_set_sig;
logic  [ 12  : 0  ] soc_fpga_intf_fpga_irq_set_sig;
logic  [ 15  : 0  ] soc_fpga_intf_fpga_irq_src_sig;
logic               config_ss_ace_isolation_ctl_sig;
logic               config_ss_irq_isolation_ctl_sig;
logic               config_ss_fcb_isolation_ctl_sig;
logic               config_ss_ahb_isolation_ctl_sig;
logic               config_ss_axi1_isolation_ctl_sig;
logic               config_ss_axi0_isolation_ctl_sig;
logic               config_ss_scl_o_sig;
logic               config_ss_spi_clk_oe_sig;
logic               config_ss_spi_clk_out_sig;
logic  [ 31  : 0  ] config_ss_gpio_pulldown_sig;
logic  [ 31  : 0  ] config_ss_gpio_pullup_sig;
logic  [ 3   : 0  ] soc_fpga_intf_dma_ack_fpga_sig;
logic  [ 3   : 0  ] soc_fpga_intf_dma_req_fpga_sig;
logic  [ 3   : 0  ] config_ss_rgmii_txd_sig;
logic               config_ss_rgmii_tx_ctl_sig;
logic               config_ss_mdio_mdc_sig;
logic               config_ss_gbe_mdio_out_sig;
logic               config_ss_gbe_mdio_en_sig;
logic  [ 35  : 0  ] soc_fpga_intf_pl_data_o_sig;
logic  [ 31  : 0  ] soc_fpga_intf_pl_addr_o_sig;
logic               soc_fpga_intf_pl_ena_o_sig;
logic               soc_fpga_intf_pl_clk_o_sig;
logic               soc_fpga_intf_pl_ren_o_sig;
logic               soc_fpga_intf_pl_init_o_sig;
logic  [ 1   : 0  ] soc_fpga_intf_pl_wen_o_sig;
logic  [ 0   : 31 ] soc_fpga_intf_cfg_blsr_region_0_o_sig;
logic  [ 0   : 31 ] soc_fpga_intf_cfg_wlsr_region_0_o_sig;
logic               soc_fpga_intf_cfg_done_o_sig;
logic               soc_fpga_intf_cfg_rst_no_sig;
logic               soc_fpga_intf_cfg_blsr_region_0_clk_o_sig;
logic               soc_fpga_intf_cfg_wlsr_region_0_clk_o_sig;
logic               soc_fpga_intf_cfg_blsr_region_0_wen_o_sig;
logic               soc_fpga_intf_cfg_blsr_region_0_ren_o_sig;
logic               soc_fpga_intf_cfg_wlsr_region_0_wen_o_sig;
logic               soc_fpga_intf_cfg_wlsr_region_0_ren_o_sig;
logic               config_ss_bcpu_jtag_tdo_sig;
logic  [ 1   : 0  ] config_ss_jtag_control_sig;
logic               memory_ss_ddr0_awready_sig;
logic               memory_ss_ddr0_wready_sig;
logic               memory_ss_ddr0_bvalid_sig;
logic  [ 1   : 0  ] memory_ss_ddr0_bresp_sig;
logic  [ 3   : 0  ] memory_ss_ddr0_bid_sig;
logic               memory_ss_ddr0_arready_sig;
logic               memory_ss_ddr0_rvalid_sig;
logic               memory_ss_ddr0_rlast_sig;
logic  [ 127 : 0  ] memory_ss_ddr0_rdata_sig;
logic  [ 1   : 0  ] memory_ss_ddr0_rresp_sig;
logic  [ 3   : 0  ] memory_ss_ddr0_rid_sig;
logic               memory_ss_ddr1_awready_sig;
logic               memory_ss_ddr1_wready_sig;
logic               memory_ss_ddr1_bvalid_sig;
logic  [ 1   : 0  ] memory_ss_ddr1_bresp_sig;
logic  [ 3   : 0  ] memory_ss_ddr1_bid_sig;
logic               memory_ss_ddr1_arready_sig;
logic               memory_ss_ddr1_rvalid_sig;
logic               memory_ss_ddr1_rlast_sig;
logic  [ 127 : 0  ] memory_ss_ddr1_rdata_sig;
logic  [ 1   : 0  ] memory_ss_ddr1_rresp_sig;
logic  [ 3   : 0  ] memory_ss_ddr1_rid_sig;
logic               memory_ss_ddr2_awready_sig;
logic               memory_ss_ddr2_wready_sig;
logic               memory_ss_ddr2_bvalid_sig;
logic  [ 1   : 0  ] memory_ss_ddr2_bresp_sig;
logic  [ 3   : 0  ] memory_ss_ddr2_bid_sig;
logic               memory_ss_ddr2_arready_sig;
logic               memory_ss_ddr2_rvalid_sig;
logic               memory_ss_ddr2_rlast_sig;
logic  [ 127 : 0  ] memory_ss_ddr2_rdata_sig;
logic  [ 1   : 0  ] memory_ss_ddr2_rresp_sig;
logic  [ 3   : 0  ] memory_ss_ddr2_rid_sig;
logic               memory_ss_ddr3_awready_sig;
logic               memory_ss_ddr3_wready_sig;
logic               memory_ss_ddr3_bvalid_sig;
logic  [ 1   : 0  ] memory_ss_ddr3_bresp_sig;
logic  [ 3   : 0  ] memory_ss_ddr3_bid_sig;
logic               memory_ss_ddr3_arready_sig;
logic               memory_ss_ddr3_rvalid_sig;
logic               memory_ss_ddr3_rlast_sig;
logic  [ 127 : 0  ] memory_ss_ddr3_rdata_sig;
logic  [ 1   : 0  ] memory_ss_ddr3_rresp_sig;
logic  [ 3   : 0  ] memory_ss_ddr3_rid_sig;
logic               memory_ss_sramb0_awready_sig;
logic               memory_ss_sramb0_wready_sig;
logic               memory_ss_sramb0_bvalid_sig;
logic  [ 1   : 0  ] memory_ss_sramb0_bresp_sig;
logic  [ 3   : 0  ] memory_ss_sramb0_bid_sig;
logic               memory_ss_sramb0_arready_sig;
logic               memory_ss_sramb0_rvalid_sig;
logic               memory_ss_sramb0_rlast_sig;
logic  [ 31  : 0  ] memory_ss_sramb0_rdata_sig;
logic  [ 1   : 0  ] memory_ss_sramb0_rresp_sig;
logic  [ 3   : 0  ] memory_ss_sramb0_rid_sig;
logic               memory_ss_sramb1_awready_sig;
logic               memory_ss_sramb1_wready_sig;
logic               memory_ss_sramb1_bvalid_sig;
logic  [ 1   : 0  ] memory_ss_sramb1_bresp_sig;
logic  [ 3   : 0  ] memory_ss_sramb1_bid_sig;
logic               memory_ss_sramb1_arready_sig;
logic               memory_ss_sramb1_rvalid_sig;
logic               memory_ss_sramb1_rlast_sig;
logic  [ 31  : 0  ] memory_ss_sramb1_rdata_sig;
logic  [ 1   : 0  ] memory_ss_sramb1_rresp_sig;
logic  [ 3   : 0  ] memory_ss_sramb1_rid_sig;
logic               memory_ss_sramb2_awready_sig;
logic               memory_ss_sramb2_wready_sig;
logic               memory_ss_sramb2_bvalid_sig;
logic  [ 1   : 0  ] memory_ss_sramb2_bresp_sig;
logic  [ 3   : 0  ] memory_ss_sramb2_bid_sig;
logic               memory_ss_sramb2_arready_sig;
logic               memory_ss_sramb2_rvalid_sig;
logic               memory_ss_sramb2_rlast_sig;
logic  [ 31  : 0  ] memory_ss_sramb2_rdata_sig;
logic  [ 1   : 0  ] memory_ss_sramb2_rresp_sig;
logic  [ 3   : 0  ] memory_ss_sramb2_rid_sig;
logic               memory_ss_sramb3_awready_sig;
logic               memory_ss_sramb3_wready_sig;
logic               memory_ss_sramb3_bvalid_sig;
logic  [ 1   : 0  ] memory_ss_sramb3_bresp_sig;
logic  [ 3   : 0  ] memory_ss_sramb3_bid_sig;
logic               memory_ss_sramb3_arready_sig;
logic               memory_ss_sramb3_rvalid_sig;
logic               memory_ss_sramb3_rlast_sig;
logic  [ 31  : 0  ] memory_ss_sramb3_rdata_sig;
logic  [ 1   : 0  ] memory_ss_sramb3_rresp_sig;
logic  [ 3   : 0  ] memory_ss_sramb3_rid_sig;
logic               memory_ss_cntl_arready_sig;
logic               memory_ss_cntl_awready_sig;
logic  [ 1   : 0  ] memory_ss_cntl_bresp_sig;
logic               memory_ss_cntl_bvalid_sig;
logic  [ 31  : 0  ] memory_ss_cntl_rdata_sig;
logic  [ 1   : 0  ] memory_ss_cntl_rresp_sig;
logic               memory_ss_cntl_rvalid_sig;
logic               memory_ss_cntl_wready_sig;
logic  [ 1   : 0  ] memory_ss_int_gc_fsm_sig;
logic  [ 31  : 0  ] flexnoc_ACPU_WDT_PAddr_sig;
logic               flexnoc_ACPU_WDT_PEnable_sig;
logic               flexnoc_ACPU_WDT_PSel_sig;
logic  [ 3   : 0  ] flexnoc_ACPU_WDT_PWBe_sig;
logic  [ 31  : 0  ] flexnoc_ACPU_WDT_PWData_sig;
logic               flexnoc_ACPU_WDT_PWrite_sig;
logic  [ 31  : 0  ] flexnoc_BCPU_WDT_PAddr_sig;
logic               flexnoc_BCPU_WDT_PEnable_sig;
logic               flexnoc_BCPU_WDT_PSel_sig;
logic  [ 3   : 0  ] flexnoc_BCPU_WDT_PWBe_sig;
logic  [ 31  : 0  ] flexnoc_BCPU_WDT_PWData_sig;
logic               flexnoc_BCPU_WDT_PWrite_sig;
logic  [ 31  : 0  ] flexnoc_DMA_apb_s0_paddr_sig;
logic               flexnoc_DMA_apb_s0_penable_sig;
logic               flexnoc_DMA_apb_s0_psel_sig;
logic  [ 3   : 0  ] flexnoc_DMA_apb_s0_pwbe_sig;
logic  [ 31  : 0  ] flexnoc_DMA_apb_s0_pwdata_sig;
logic               flexnoc_DMA_apb_s0_pwrite_sig;
logic  [ 31  : 0  ] flexnoc_FCB_apb_s0_paddr_sig;
logic               flexnoc_FCB_apb_s0_penable_sig;
logic               flexnoc_FCB_apb_s0_psel_sig;
logic  [ 3   : 0  ] flexnoc_FCB_apb_s0_pwbe_sig;
logic  [ 31  : 0  ] flexnoc_FCB_apb_s0_pwdata_sig;
logic               flexnoc_FCB_apb_s0_pwrite_sig;
logic  [ 31  : 0  ] flexnoc_GPIO_apb_s0_paddr_sig;
logic               flexnoc_GPIO_apb_s0_penable_sig;
logic               flexnoc_GPIO_apb_s0_psel_sig;
logic  [ 3   : 0  ] flexnoc_GPIO_apb_s0_pwbe_sig;
logic  [ 31  : 0  ] flexnoc_GPIO_apb_s0_pwdata_sig;
logic               flexnoc_GPIO_apb_s0_pwrite_sig;
logic  [ 31  : 0  ] flexnoc_GPT_apb_s0_paddr_sig;
logic               flexnoc_GPT_apb_s0_penable_sig;
logic               flexnoc_GPT_apb_s0_psel_sig;
logic  [ 3   : 0  ] flexnoc_GPT_apb_s0_pwbe_sig;
logic  [ 31  : 0  ] flexnoc_GPT_apb_s0_pwdata_sig;
logic               flexnoc_GPT_apb_s0_pwrite_sig;
logic  [ 31  : 0  ] flexnoc_I2C_apb_s0_paddr_sig;
logic               flexnoc_I2C_apb_s0_penable_sig;
logic               flexnoc_I2C_apb_s0_psel_sig;
logic  [ 3   : 0  ] flexnoc_I2C_apb_s0_pwbe_sig;
logic  [ 31  : 0  ] flexnoc_I2C_apb_s0_pwdata_sig;
logic               flexnoc_I2C_apb_s0_pwrite_sig;
logic  [ 31  : 0  ] flexnoc_MBOX_apb_s0_paddr_sig;
logic               flexnoc_MBOX_apb_s0_penable_sig;
logic               flexnoc_MBOX_apb_s0_psel_sig;
logic  [ 3   : 0  ] flexnoc_MBOX_apb_s0_pwbe_sig;
logic  [ 31  : 0  ] flexnoc_MBOX_apb_s0_pwdata_sig;
logic               flexnoc_MBOX_apb_s0_pwrite_sig;
logic  [ 31  : 0  ] flexnoc_PUFCC_apb_s0_PAddr_sig;
logic               flexnoc_PUFCC_apb_s0_PEnable_sig;
logic  [ 2   : 0  ] flexnoc_PUFCC_apb_s0_PProt_sig;
logic               flexnoc_PUFCC_apb_s0_PSel_sig;
logic  [ 3   : 0  ] flexnoc_PUFCC_apb_s0_PStrb_sig;
logic  [ 31  : 0  ] flexnoc_PUFCC_apb_s0_PWData_sig;
logic               flexnoc_PUFCC_apb_s0_PWrite_sig;
logic  [ 31  : 0  ] flexnoc_SCU_PAddr_sig;
logic               flexnoc_SCU_PEnable_sig;
logic               flexnoc_SCU_PSel_sig;
logic  [ 3   : 0  ] flexnoc_SCU_PWBe_sig;
logic  [ 31  : 0  ] flexnoc_SCU_PWData_sig;
logic               flexnoc_SCU_PWrite_sig;
logic  [ 31  : 0  ] flexnoc_SPI_ahb_s0_haddr_sig;
logic  [ 2   : 0  ] flexnoc_SPI_ahb_s0_hburst_sig;
logic               flexnoc_SPI_ahb_s0_hmastlock_sig;
logic  [ 3   : 0  ] flexnoc_SPI_ahb_s0_hprot_sig;
logic               flexnoc_SPI_ahb_s0_hsel_sig;
logic  [ 2   : 0  ] flexnoc_SPI_ahb_s0_hsize_sig;
logic  [ 1   : 0  ] flexnoc_SPI_ahb_s0_htrans_sig;
logic  [ 3   : 0  ] flexnoc_SPI_ahb_s0_hwbe_sig;
logic  [ 31  : 0  ] flexnoc_SPI_ahb_s0_hwdata_sig;
logic               flexnoc_SPI_ahb_s0_hwrite_sig;
logic  [ 31  : 0  ] flexnoc_SPI_mem_ahb_haddr_sig;
logic  [ 2   : 0  ] flexnoc_SPI_mem_ahb_hburst_sig;
logic               flexnoc_SPI_mem_ahb_hmastlock_sig;
logic  [ 3   : 0  ] flexnoc_SPI_mem_ahb_hprot_sig;
logic               flexnoc_SPI_mem_ahb_hsel_sig;
logic  [ 2   : 0  ] flexnoc_SPI_mem_ahb_hsize_sig;
logic  [ 1   : 0  ] flexnoc_SPI_mem_ahb_htrans_sig;
logic  [ 3   : 0  ] flexnoc_SPI_mem_ahb_hwbe_sig;
logic  [ 31  : 0  ] flexnoc_SPI_mem_ahb_hwdata_sig;
logic               flexnoc_SPI_mem_ahb_hwrite_sig;
logic  [ 31  : 0  ] flexnoc_UART_apb_s0_paddr_sig;
logic               flexnoc_UART_apb_s0_penable_sig;
logic               flexnoc_UART_apb_s0_psel_sig;
logic  [ 3   : 0  ] flexnoc_UART_apb_s0_pwbe_sig;
logic  [ 31  : 0  ] flexnoc_UART_apb_s0_pwdata_sig;
logic               flexnoc_UART_apb_s0_pwrite_sig;
logic  [ 31  : 0  ] flexnoc_UART_apb_s1_paddr_sig;
logic               flexnoc_UART_apb_s1_penable_sig;
logic               flexnoc_UART_apb_s1_psel_sig;
logic  [ 3   : 0  ] flexnoc_UART_apb_s1_pwbe_sig;
logic  [ 31  : 0  ] flexnoc_UART_apb_s1_pwdata_sig;
logic               flexnoc_UART_apb_s1_pwrite_sig;
logic  [ 31  : 0  ] flexnoc_USB_axi_s0_ar_addr_sig;
logic  [ 2   : 0  ] flexnoc_USB_axi_s0_ar_prot_sig;
logic               flexnoc_USB_axi_s0_ar_valid_sig;
logic  [ 31  : 0  ] flexnoc_USB_axi_s0_aw_addr_sig;
logic  [ 2   : 0  ] flexnoc_USB_axi_s0_aw_prot_sig;
logic               flexnoc_USB_axi_s0_aw_valid_sig;
logic               flexnoc_USB_axi_s0_b_ready_sig;
logic               flexnoc_USB_axi_s0_r_ready_sig;
logic  [ 31  : 0  ] flexnoc_USB_axi_s0_w_data_sig;
logic  [ 3   : 0  ] flexnoc_USB_axi_s0_w_strb_sig;
logic               flexnoc_USB_axi_s0_w_valid_sig;
logic               flexnoc_acpu_axi_m0_ar_ready_sig;
logic               flexnoc_acpu_axi_m0_aw_ready_sig;
logic  [ 3   : 0  ] flexnoc_acpu_axi_m0_b_id_sig;
logic  [ 1   : 0  ] flexnoc_acpu_axi_m0_b_resp_sig;
logic               flexnoc_acpu_axi_m0_b_valid_sig;
logic  [ 63  : 0  ] flexnoc_acpu_axi_m0_r_data_sig;
logic  [ 3   : 0  ] flexnoc_acpu_axi_m0_r_id_sig;
logic               flexnoc_acpu_axi_m0_r_last_sig;
logic  [ 1   : 0  ] flexnoc_acpu_axi_m0_r_resp_sig;
logic               flexnoc_acpu_axi_m0_r_valid_sig;
logic               flexnoc_acpu_axi_m0_w_ready_sig;
logic  [ 31  : 0  ] flexnoc_bcpu_ahb_m0_hrdata_sig;
logic               flexnoc_bcpu_ahb_m0_hready_sig;
logic               flexnoc_bcpu_ahb_m0_hresp_sig;
logic  [ 31  : 0  ] flexnoc_ddr_axi_s0_ar_addr_sig;
logic  [ 1   : 0  ] flexnoc_ddr_axi_s0_ar_burst_sig;
logic  [ 3   : 0  ] flexnoc_ddr_axi_s0_ar_cache_sig;
logic  [ 3   : 0  ] flexnoc_ddr_axi_s0_ar_id_sig;
logic  [ 2   : 0  ] flexnoc_ddr_axi_s0_ar_len_sig;
logic               flexnoc_ddr_axi_s0_ar_lock_sig;
logic  [ 2   : 0  ] flexnoc_ddr_axi_s0_ar_prot_sig;
logic  [ 2   : 0  ] flexnoc_ddr_axi_s0_ar_size_sig;
logic               flexnoc_ddr_axi_s0_ar_valid_sig;
logic  [ 31  : 0  ] flexnoc_ddr_axi_s0_aw_addr_sig;
logic  [ 1   : 0  ] flexnoc_ddr_axi_s0_aw_burst_sig;
logic  [ 3   : 0  ] flexnoc_ddr_axi_s0_aw_cache_sig;
logic  [ 3   : 0  ] flexnoc_ddr_axi_s0_aw_id_sig;
logic  [ 2   : 0  ] flexnoc_ddr_axi_s0_aw_len_sig;
logic               flexnoc_ddr_axi_s0_aw_lock_sig;
logic  [ 2   : 0  ] flexnoc_ddr_axi_s0_aw_prot_sig;
logic  [ 2   : 0  ] flexnoc_ddr_axi_s0_aw_size_sig;
logic               flexnoc_ddr_axi_s0_aw_valid_sig;
logic               flexnoc_ddr_axi_s0_b_ready_sig;
logic               flexnoc_ddr_axi_s0_r_ready_sig;
logic  [ 127 : 0  ] flexnoc_ddr_axi_s0_w_data_sig;
logic               flexnoc_ddr_axi_s0_w_last_sig;
logic  [ 15  : 0  ] flexnoc_ddr_axi_s0_w_strb_sig;
logic               flexnoc_ddr_axi_s0_w_valid_sig;
logic  [ 31  : 0  ] flexnoc_ddr_axi_s1_ar_addr_sig;
logic  [ 1   : 0  ] flexnoc_ddr_axi_s1_ar_burst_sig;
logic  [ 3   : 0  ] flexnoc_ddr_axi_s1_ar_cache_sig;
logic  [ 3   : 0  ] flexnoc_ddr_axi_s1_ar_id_sig;
logic  [ 2   : 0  ] flexnoc_ddr_axi_s1_ar_len_sig;
logic               flexnoc_ddr_axi_s1_ar_lock_sig;
logic  [ 2   : 0  ] flexnoc_ddr_axi_s1_ar_prot_sig;
logic  [ 2   : 0  ] flexnoc_ddr_axi_s1_ar_size_sig;
logic               flexnoc_ddr_axi_s1_ar_valid_sig;
logic  [ 31  : 0  ] flexnoc_ddr_axi_s1_aw_addr_sig;
logic  [ 1   : 0  ] flexnoc_ddr_axi_s1_aw_burst_sig;
logic  [ 3   : 0  ] flexnoc_ddr_axi_s1_aw_cache_sig;
logic  [ 3   : 0  ] flexnoc_ddr_axi_s1_aw_id_sig;
logic  [ 2   : 0  ] flexnoc_ddr_axi_s1_aw_len_sig;
logic               flexnoc_ddr_axi_s1_aw_lock_sig;
logic  [ 2   : 0  ] flexnoc_ddr_axi_s1_aw_prot_sig;
logic  [ 2   : 0  ] flexnoc_ddr_axi_s1_aw_size_sig;
logic               flexnoc_ddr_axi_s1_aw_valid_sig;
logic               flexnoc_ddr_axi_s1_b_ready_sig;
logic               flexnoc_ddr_axi_s1_r_ready_sig;
logic  [ 127 : 0  ] flexnoc_ddr_axi_s1_w_data_sig;
logic               flexnoc_ddr_axi_s1_w_last_sig;
logic  [ 15  : 0  ] flexnoc_ddr_axi_s1_w_strb_sig;
logic               flexnoc_ddr_axi_s1_w_valid_sig;
logic  [ 31  : 0  ] flexnoc_ddr_axi_s2_ar_addr_sig;
logic  [ 1   : 0  ] flexnoc_ddr_axi_s2_ar_burst_sig;
logic  [ 3   : 0  ] flexnoc_ddr_axi_s2_ar_cache_sig;
logic  [ 3   : 0  ] flexnoc_ddr_axi_s2_ar_id_sig;
logic  [ 2   : 0  ] flexnoc_ddr_axi_s2_ar_len_sig;
logic               flexnoc_ddr_axi_s2_ar_lock_sig;
logic  [ 2   : 0  ] flexnoc_ddr_axi_s2_ar_prot_sig;
logic  [ 2   : 0  ] flexnoc_ddr_axi_s2_ar_size_sig;
logic               flexnoc_ddr_axi_s2_ar_valid_sig;
logic  [ 31  : 0  ] flexnoc_ddr_axi_s2_aw_addr_sig;
logic  [ 1   : 0  ] flexnoc_ddr_axi_s2_aw_burst_sig;
logic  [ 3   : 0  ] flexnoc_ddr_axi_s2_aw_cache_sig;
logic  [ 3   : 0  ] flexnoc_ddr_axi_s2_aw_id_sig;
logic  [ 2   : 0  ] flexnoc_ddr_axi_s2_aw_len_sig;
logic               flexnoc_ddr_axi_s2_aw_lock_sig;
logic  [ 2   : 0  ] flexnoc_ddr_axi_s2_aw_prot_sig;
logic  [ 2   : 0  ] flexnoc_ddr_axi_s2_aw_size_sig;
logic               flexnoc_ddr_axi_s2_aw_valid_sig;
logic               flexnoc_ddr_axi_s2_b_ready_sig;
logic               flexnoc_ddr_axi_s2_r_ready_sig;
logic  [ 127 : 0  ] flexnoc_ddr_axi_s2_w_data_sig;
logic               flexnoc_ddr_axi_s2_w_last_sig;
logic  [ 15  : 0  ] flexnoc_ddr_axi_s2_w_strb_sig;
logic               flexnoc_ddr_axi_s2_w_valid_sig;
logic  [ 31  : 0  ] flexnoc_ddr_axi_s3_ar_addr_sig;
logic  [ 1   : 0  ] flexnoc_ddr_axi_s3_ar_burst_sig;
logic  [ 3   : 0  ] flexnoc_ddr_axi_s3_ar_cache_sig;
logic  [ 3   : 0  ] flexnoc_ddr_axi_s3_ar_id_sig;
logic  [ 2   : 0  ] flexnoc_ddr_axi_s3_ar_len_sig;
logic               flexnoc_ddr_axi_s3_ar_lock_sig;
logic  [ 2   : 0  ] flexnoc_ddr_axi_s3_ar_prot_sig;
logic  [ 2   : 0  ] flexnoc_ddr_axi_s3_ar_size_sig;
logic               flexnoc_ddr_axi_s3_ar_valid_sig;
logic  [ 31  : 0  ] flexnoc_ddr_axi_s3_aw_addr_sig;
logic  [ 1   : 0  ] flexnoc_ddr_axi_s3_aw_burst_sig;
logic  [ 3   : 0  ] flexnoc_ddr_axi_s3_aw_cache_sig;
logic  [ 3   : 0  ] flexnoc_ddr_axi_s3_aw_id_sig;
logic  [ 2   : 0  ] flexnoc_ddr_axi_s3_aw_len_sig;
logic               flexnoc_ddr_axi_s3_aw_lock_sig;
logic  [ 2   : 0  ] flexnoc_ddr_axi_s3_aw_prot_sig;
logic  [ 2   : 0  ] flexnoc_ddr_axi_s3_aw_size_sig;
logic               flexnoc_ddr_axi_s3_aw_valid_sig;
logic               flexnoc_ddr_axi_s3_b_ready_sig;
logic               flexnoc_ddr_axi_s3_r_ready_sig;
logic  [ 127 : 0  ] flexnoc_ddr_axi_s3_w_data_sig;
logic               flexnoc_ddr_axi_s3_w_last_sig;
logic  [ 15  : 0  ] flexnoc_ddr_axi_s3_w_strb_sig;
logic               flexnoc_ddr_axi_s3_w_valid_sig;
logic  [ 31  : 0  ] flexnoc_ddr_axil_s0_ar_addr_sig;
logic  [ 2   : 0  ] flexnoc_ddr_axil_s0_ar_prot_sig;
logic               flexnoc_ddr_axil_s0_ar_valid_sig;
logic  [ 31  : 0  ] flexnoc_ddr_axil_s0_aw_addr_sig;
logic  [ 2   : 0  ] flexnoc_ddr_axil_s0_aw_prot_sig;
logic               flexnoc_ddr_axil_s0_aw_valid_sig;
logic               flexnoc_ddr_axil_s0_b_ready_sig;
logic               flexnoc_ddr_axil_s0_r_ready_sig;
logic  [ 31  : 0  ] flexnoc_ddr_axil_s0_w_data_sig;
logic  [ 3   : 0  ] flexnoc_ddr_axil_s0_w_strb_sig;
logic               flexnoc_ddr_axil_s0_w_valid_sig;
logic               flexnoc_dma_axi_m0_ar_ready_sig;
logic               flexnoc_dma_axi_m0_aw_ready_sig;
logic  [ 3   : 0  ] flexnoc_dma_axi_m0_b_id_sig;
logic  [ 1   : 0  ] flexnoc_dma_axi_m0_b_resp_sig;
logic               flexnoc_dma_axi_m0_b_valid_sig;
logic  [ 31  : 0  ] flexnoc_dma_axi_m0_r_data_sig;
logic  [ 3   : 0  ] flexnoc_dma_axi_m0_r_id_sig;
logic               flexnoc_dma_axi_m0_r_last_sig;
logic  [ 1   : 0  ] flexnoc_dma_axi_m0_r_resp_sig;
logic               flexnoc_dma_axi_m0_r_valid_sig;
logic               flexnoc_dma_axi_m0_w_ready_sig;
logic               flexnoc_dma_axi_m1_ar_ready_sig;
logic               flexnoc_dma_axi_m1_aw_ready_sig;
logic  [ 3   : 0  ] flexnoc_dma_axi_m1_b_id_sig;
logic  [ 1   : 0  ] flexnoc_dma_axi_m1_b_resp_sig;
logic               flexnoc_dma_axi_m1_b_valid_sig;
logic  [ 31  : 0  ] flexnoc_dma_axi_m1_r_data_sig;
logic  [ 3   : 0  ] flexnoc_dma_axi_m1_r_id_sig;
logic               flexnoc_dma_axi_m1_r_last_sig;
logic  [ 1   : 0  ] flexnoc_dma_axi_m1_r_resp_sig;
logic               flexnoc_dma_axi_m1_r_valid_sig;
logic               flexnoc_dma_axi_m1_w_ready_sig;
logic  [ 31  : 0  ] flexnoc_fpga_ahb_s0_haddr_sig;
logic  [ 2   : 0  ] flexnoc_fpga_ahb_s0_hburst_sig;
logic               flexnoc_fpga_ahb_s0_hmastlock_sig;
logic  [ 3   : 0  ] flexnoc_fpga_ahb_s0_hprot_sig;
logic               flexnoc_fpga_ahb_s0_hsel_sig;
logic  [ 2   : 0  ] flexnoc_fpga_ahb_s0_hsize_sig;
logic  [ 1   : 0  ] flexnoc_fpga_ahb_s0_htrans_sig;
logic  [ 3   : 0  ] flexnoc_fpga_ahb_s0_hwbe_sig;
logic  [ 31  : 0  ] flexnoc_fpga_ahb_s0_hwdata_sig;
logic               flexnoc_fpga_ahb_s0_hwrite_sig;
logic               flexnoc_fpga_axi_m0_ar_ready_sig;
logic               flexnoc_fpga_axi_m0_aw_ready_sig;
logic  [ 3   : 0  ] flexnoc_fpga_axi_m0_b_id_sig;
logic  [ 1   : 0  ] flexnoc_fpga_axi_m0_b_resp_sig;
logic               flexnoc_fpga_axi_m0_b_valid_sig;
logic  [ 63  : 0  ] flexnoc_fpga_axi_m0_r_data_sig;
logic  [ 3   : 0  ] flexnoc_fpga_axi_m0_r_id_sig;
logic               flexnoc_fpga_axi_m0_r_last_sig;
logic  [ 1   : 0  ] flexnoc_fpga_axi_m0_r_resp_sig;
logic               flexnoc_fpga_axi_m0_r_valid_sig;
logic               flexnoc_fpga_axi_m0_w_ready_sig;
logic               flexnoc_fpga_axi_m1_ar_ready_sig;
logic               flexnoc_fpga_axi_m1_aw_ready_sig;
logic  [ 3   : 0  ] flexnoc_fpga_axi_m1_b_id_sig;
logic  [ 1   : 0  ] flexnoc_fpga_axi_m1_b_resp_sig;
logic               flexnoc_fpga_axi_m1_b_valid_sig;
logic  [ 31  : 0  ] flexnoc_fpga_axi_m1_r_data_sig;
logic  [ 3   : 0  ] flexnoc_fpga_axi_m1_r_id_sig;
logic               flexnoc_fpga_axi_m1_r_last_sig;
logic  [ 1   : 0  ] flexnoc_fpga_axi_m1_r_resp_sig;
logic               flexnoc_fpga_axi_m1_r_valid_sig;
logic               flexnoc_fpga_axi_m1_w_ready_sig;
logic  [ 31  : 0  ] flexnoc_gbe_apb_s0_paddr_sig;
logic               flexnoc_gbe_apb_s0_penable_sig;
logic               flexnoc_gbe_apb_s0_psel_sig;
logic  [ 3   : 0  ] flexnoc_gbe_apb_s0_pwbe_sig;
logic  [ 31  : 0  ] flexnoc_gbe_apb_s0_pwdata_sig;
logic               flexnoc_gbe_apb_s0_pwrite_sig;
logic               flexnoc_gbe_axi_m0_ar_ready_sig;
logic               flexnoc_gbe_axi_m0_aw_ready_sig;
logic  [ 3   : 0  ] flexnoc_gbe_axi_m0_b_id_sig;
logic  [ 1   : 0  ] flexnoc_gbe_axi_m0_b_resp_sig;
logic               flexnoc_gbe_axi_m0_b_valid_sig;
logic  [ 31  : 0  ] flexnoc_gbe_axi_m0_r_data_sig;
logic  [ 3   : 0  ] flexnoc_gbe_axi_m0_r_id_sig;
logic               flexnoc_gbe_axi_m0_r_last_sig;
logic  [ 1   : 0  ] flexnoc_gbe_axi_m0_r_resp_sig;
logic               flexnoc_gbe_axi_m0_r_valid_sig;
logic               flexnoc_gbe_axi_m0_w_ready_sig;
logic               flexnoc_pufcc_axi_m0_ar_ready_sig;
logic               flexnoc_pufcc_axi_m0_aw_ready_sig;
logic  [ 3   : 0  ] flexnoc_pufcc_axi_m0_b_id_sig;
logic  [ 1   : 0  ] flexnoc_pufcc_axi_m0_b_resp_sig;
logic               flexnoc_pufcc_axi_m0_b_valid_sig;
logic  [ 31  : 0  ] flexnoc_pufcc_axi_m0_r_data_sig;
logic  [ 3   : 0  ] flexnoc_pufcc_axi_m0_r_id_sig;
logic               flexnoc_pufcc_axi_m0_r_last_sig;
logic  [ 1   : 0  ] flexnoc_pufcc_axi_m0_r_resp_sig;
logic               flexnoc_pufcc_axi_m0_r_valid_sig;
logic               flexnoc_pufcc_axi_m0_w_ready_sig;
logic  [ 31  : 0  ] flexnoc_sram_axi_s0_ar_addr_sig;
logic  [ 1   : 0  ] flexnoc_sram_axi_s0_ar_burst_sig;
logic  [ 3   : 0  ] flexnoc_sram_axi_s0_ar_cache_sig;
logic  [ 3   : 0  ] flexnoc_sram_axi_s0_ar_id_sig;
logic  [ 3   : 0  ] flexnoc_sram_axi_s0_ar_len_sig;
logic               flexnoc_sram_axi_s0_ar_lock_sig;
logic  [ 2   : 0  ] flexnoc_sram_axi_s0_ar_prot_sig;
logic  [ 2   : 0  ] flexnoc_sram_axi_s0_ar_size_sig;
logic               flexnoc_sram_axi_s0_ar_valid_sig;
logic  [ 31  : 0  ] flexnoc_sram_axi_s0_aw_addr_sig;
logic  [ 1   : 0  ] flexnoc_sram_axi_s0_aw_burst_sig;
logic  [ 3   : 0  ] flexnoc_sram_axi_s0_aw_cache_sig;
logic  [ 3   : 0  ] flexnoc_sram_axi_s0_aw_id_sig;
logic  [ 3   : 0  ] flexnoc_sram_axi_s0_aw_len_sig;
logic               flexnoc_sram_axi_s0_aw_lock_sig;
logic  [ 2   : 0  ] flexnoc_sram_axi_s0_aw_prot_sig;
logic  [ 2   : 0  ] flexnoc_sram_axi_s0_aw_size_sig;
logic               flexnoc_sram_axi_s0_aw_valid_sig;
logic               flexnoc_sram_axi_s0_b_ready_sig;
logic               flexnoc_sram_axi_s0_r_ready_sig;
logic  [ 31  : 0  ] flexnoc_sram_axi_s0_w_data_sig;
logic               flexnoc_sram_axi_s0_w_last_sig;
logic  [ 3   : 0  ] flexnoc_sram_axi_s0_w_strb_sig;
logic               flexnoc_sram_axi_s0_w_valid_sig;
logic  [ 31  : 0  ] flexnoc_sram_axi_s1_ar_addr_sig;
logic  [ 1   : 0  ] flexnoc_sram_axi_s1_ar_burst_sig;
logic  [ 3   : 0  ] flexnoc_sram_axi_s1_ar_cache_sig;
logic  [ 3   : 0  ] flexnoc_sram_axi_s1_ar_id_sig;
logic  [ 3   : 0  ] flexnoc_sram_axi_s1_ar_len_sig;
logic               flexnoc_sram_axi_s1_ar_lock_sig;
logic  [ 2   : 0  ] flexnoc_sram_axi_s1_ar_prot_sig;
logic  [ 2   : 0  ] flexnoc_sram_axi_s1_ar_size_sig;
logic               flexnoc_sram_axi_s1_ar_valid_sig;
logic  [ 31  : 0  ] flexnoc_sram_axi_s1_aw_addr_sig;
logic  [ 1   : 0  ] flexnoc_sram_axi_s1_aw_burst_sig;
logic  [ 3   : 0  ] flexnoc_sram_axi_s1_aw_cache_sig;
logic  [ 3   : 0  ] flexnoc_sram_axi_s1_aw_id_sig;
logic  [ 3   : 0  ] flexnoc_sram_axi_s1_aw_len_sig;
logic               flexnoc_sram_axi_s1_aw_lock_sig;
logic  [ 2   : 0  ] flexnoc_sram_axi_s1_aw_prot_sig;
logic  [ 2   : 0  ] flexnoc_sram_axi_s1_aw_size_sig;
logic               flexnoc_sram_axi_s1_aw_valid_sig;
logic               flexnoc_sram_axi_s1_b_ready_sig;
logic               flexnoc_sram_axi_s1_r_ready_sig;
logic  [ 31  : 0  ] flexnoc_sram_axi_s1_w_data_sig;
logic               flexnoc_sram_axi_s1_w_last_sig;
logic  [ 3   : 0  ] flexnoc_sram_axi_s1_w_strb_sig;
logic               flexnoc_sram_axi_s1_w_valid_sig;
logic  [ 31  : 0  ] flexnoc_sram_axi_s2_ar_addr_sig;
logic  [ 1   : 0  ] flexnoc_sram_axi_s2_ar_burst_sig;
logic  [ 3   : 0  ] flexnoc_sram_axi_s2_ar_cache_sig;
logic  [ 3   : 0  ] flexnoc_sram_axi_s2_ar_id_sig;
logic  [ 3   : 0  ] flexnoc_sram_axi_s2_ar_len_sig;
logic               flexnoc_sram_axi_s2_ar_lock_sig;
logic  [ 2   : 0  ] flexnoc_sram_axi_s2_ar_prot_sig;
logic  [ 2   : 0  ] flexnoc_sram_axi_s2_ar_size_sig;
logic               flexnoc_sram_axi_s2_ar_valid_sig;
logic  [ 31  : 0  ] flexnoc_sram_axi_s2_aw_addr_sig;
logic  [ 1   : 0  ] flexnoc_sram_axi_s2_aw_burst_sig;
logic  [ 3   : 0  ] flexnoc_sram_axi_s2_aw_cache_sig;
logic  [ 3   : 0  ] flexnoc_sram_axi_s2_aw_id_sig;
logic  [ 3   : 0  ] flexnoc_sram_axi_s2_aw_len_sig;
logic               flexnoc_sram_axi_s2_aw_lock_sig;
logic  [ 2   : 0  ] flexnoc_sram_axi_s2_aw_prot_sig;
logic  [ 2   : 0  ] flexnoc_sram_axi_s2_aw_size_sig;
logic               flexnoc_sram_axi_s2_aw_valid_sig;
logic               flexnoc_sram_axi_s2_b_ready_sig;
logic               flexnoc_sram_axi_s2_r_ready_sig;
logic  [ 31  : 0  ] flexnoc_sram_axi_s2_w_data_sig;
logic               flexnoc_sram_axi_s2_w_last_sig;
logic  [ 3   : 0  ] flexnoc_sram_axi_s2_w_strb_sig;
logic               flexnoc_sram_axi_s2_w_valid_sig;
logic  [ 31  : 0  ] flexnoc_sram_axi_s3_ar_addr_sig;
logic  [ 1   : 0  ] flexnoc_sram_axi_s3_ar_burst_sig;
logic  [ 3   : 0  ] flexnoc_sram_axi_s3_ar_cache_sig;
logic  [ 3   : 0  ] flexnoc_sram_axi_s3_ar_id_sig;
logic  [ 3   : 0  ] flexnoc_sram_axi_s3_ar_len_sig;
logic               flexnoc_sram_axi_s3_ar_lock_sig;
logic  [ 2   : 0  ] flexnoc_sram_axi_s3_ar_prot_sig;
logic  [ 2   : 0  ] flexnoc_sram_axi_s3_ar_size_sig;
logic               flexnoc_sram_axi_s3_ar_valid_sig;
logic  [ 31  : 0  ] flexnoc_sram_axi_s3_aw_addr_sig;
logic  [ 1   : 0  ] flexnoc_sram_axi_s3_aw_burst_sig;
logic  [ 3   : 0  ] flexnoc_sram_axi_s3_aw_cache_sig;
logic  [ 3   : 0  ] flexnoc_sram_axi_s3_aw_id_sig;
logic  [ 3   : 0  ] flexnoc_sram_axi_s3_aw_len_sig;
logic               flexnoc_sram_axi_s3_aw_lock_sig;
logic  [ 2   : 0  ] flexnoc_sram_axi_s3_aw_prot_sig;
logic  [ 2   : 0  ] flexnoc_sram_axi_s3_aw_size_sig;
logic               flexnoc_sram_axi_s3_aw_valid_sig;
logic               flexnoc_sram_axi_s3_b_ready_sig;
logic               flexnoc_sram_axi_s3_r_ready_sig;
logic  [ 31  : 0  ] flexnoc_sram_axi_s3_w_data_sig;
logic               flexnoc_sram_axi_s3_w_last_sig;
logic  [ 3   : 0  ] flexnoc_sram_axi_s3_w_strb_sig;
logic               flexnoc_sram_axi_s3_w_valid_sig;
logic               flexnoc_usb_axi_m0_ar_ready_sig;
logic               flexnoc_usb_axi_m0_aw_ready_sig;
logic  [ 3   : 0  ] flexnoc_usb_axi_m0_b_id_sig;
logic  [ 1   : 0  ] flexnoc_usb_axi_m0_b_resp_sig;
logic               flexnoc_usb_axi_m0_b_valid_sig;
logic  [ 31  : 0  ] flexnoc_usb_axi_m0_r_data_sig;
logic  [ 3   : 0  ] flexnoc_usb_axi_m0_r_id_sig;
logic               flexnoc_usb_axi_m0_r_last_sig;
logic  [ 1   : 0  ] flexnoc_usb_axi_m0_r_resp_sig;
logic               flexnoc_usb_axi_m0_r_valid_sig;
logic               flexnoc_usb_axi_m0_w_ready_sig;
logic               rst_n_per;
logic               acpu_ss_ace_vstart;
logic               acpu_ss_ace_istart;
logic               acpu_ss_ace_divalid;
logic               acpu_ss_ace_doready;
logic [31:0]        acpu_ss_ace_dinop;
logic               acpu_ss_ace_dovalid;
logic               acpu_ss_ace_vbreak;
logic               acpu_ss_ace_diready;
logic [31:0]        acpu_ss_ace_doutop;  
logic [31:0]        soc_fpga_intf_fpga_ahb_s0_hrdata;
logic               soc_fpga_intf_fpga_ahb_s0_hready;
logic               soc_fpga_intf_fpga_ahb_s0_hresp;
logic [31:0]  soc_fpga_intf_axi_m0_ar_addr;
logic [1:0]   soc_fpga_intf_axi_m0_ar_burst;
logic [3:0]   soc_fpga_intf_axi_m0_ar_cache;
logic [3:0]   soc_fpga_intf_axi_m0_ar_id;
logic [2:0]   soc_fpga_intf_axi_m0_ar_len;
logic         soc_fpga_intf_axi_m0_ar_lock;
logic [2:0]   soc_fpga_intf_axi_m0_ar_prot;
logic [2:0]   soc_fpga_intf_axi_m0_ar_size;
logic         soc_fpga_intf_axi_m0_ar_valid;
logic [31:0]  soc_fpga_intf_axi_m0_aw_addr;
logic [1:0]   soc_fpga_intf_axi_m0_aw_burst;
logic [3:0]   soc_fpga_intf_axi_m0_aw_cache;
logic [3:0]   soc_fpga_intf_axi_m0_aw_id;
logic [2:0]   soc_fpga_intf_axi_m0_aw_len;
logic         soc_fpga_intf_axi_m0_aw_lock;
logic [2:0]   soc_fpga_intf_axi_m0_aw_prot;
logic [2:0]   soc_fpga_intf_axi_m0_aw_size;
logic         soc_fpga_intf_axi_m0_aw_valid;
logic         soc_fpga_intf_axi_m0_b_ready;
logic         soc_fpga_intf_axi_m0_r_ready;
logic [63:0]  soc_fpga_intf_axi_m0_w_data;
logic         soc_fpga_intf_axi_m0_w_last;
logic [7:0]   soc_fpga_intf_axi_m0_w_strb;
logic         soc_fpga_intf_axi_m0_w_valid;
logic [31:0]  soc_fpga_intf_axi_m1_ar_addr;
logic [1:0]   soc_fpga_intf_axi_m1_ar_burst;
logic [3:0]   soc_fpga_intf_axi_m1_ar_cache;
logic [3:0]   soc_fpga_intf_axi_m1_ar_id;
logic [3:0]   soc_fpga_intf_axi_m1_ar_len;
logic         soc_fpga_intf_axi_m1_ar_lock;
logic [2:0]   soc_fpga_intf_axi_m1_ar_prot;
logic [2:0]   soc_fpga_intf_axi_m1_ar_size;
logic         soc_fpga_intf_axi_m1_ar_valid;
logic [31:0]  soc_fpga_intf_axi_m1_aw_addr;
logic [1:0]   soc_fpga_intf_axi_m1_aw_burst;
logic [3:0]   soc_fpga_intf_axi_m1_aw_cache;
logic [3:0]   soc_fpga_intf_axi_m1_aw_id;
logic [3:0]   soc_fpga_intf_axi_m1_aw_len;
logic         soc_fpga_intf_axi_m1_aw_lock;
logic [2:0]   soc_fpga_intf_axi_m1_aw_prot;
logic [2:0]   soc_fpga_intf_axi_m1_aw_size;
logic         soc_fpga_intf_axi_m1_aw_valid;
logic         soc_fpga_intf_axi_m1_b_ready;
logic         soc_fpga_intf_axi_m1_r_ready;
logic [31:0]  soc_fpga_intf_axi_m1_w_data;
logic         soc_fpga_intf_axi_m1_w_last;
logic [3:0]   soc_fpga_intf_axi_m1_w_strb;
logic         soc_fpga_intf_axi_m1_w_valid;
logic [ 1:0]  fpga_pll3_clk_sel;
logic [ 1:0]  fpga_pll2_clk_sel;
logic [ 1:0]  fpga_pll1_clk_sel;
logic [ 1:0]  fpga_pll0_clk_sel;
logic  [ 31  : 0  ] config_ss_fpga_ahb_s0_haddr_sig;
logic  [ 2   : 0  ] config_ss_fpga_ahb_s0_hburst_sig;
// logic               config_ss_fpga_ahb_s0_hmastlock_sig;
logic  [ 3   : 0  ] config_ss_fpga_ahb_s0_hprot_sig;
logic               config_ss_fpga_ahb_s0_hsel_sig;
logic  [ 2   : 0  ] config_ss_fpga_ahb_s0_hsize_sig;
logic  [ 1   : 0  ] config_ss_fpga_ahb_s0_htrans_sig;
logic  [ 3   : 0  ] config_ss_fpga_ahb_s0_hwbe_sig;
logic  [ 31  : 0  ] config_ss_fpga_ahb_s0_hwdata_sig;
logic               config_ss_fpga_ahb_s0_hwrite_sig;
logic               config_ss_fpga_axi_m0_ar_ready_sig;
logic               config_ss_fpga_axi_m0_aw_ready_sig;
logic  [ 3   : 0  ] config_ss_fpga_axi_m0_b_id_sig;
logic  [ 1   : 0  ] config_ss_fpga_axi_m0_b_resp_sig;
logic               config_ss_fpga_axi_m0_b_valid_sig;
logic  [ 63  : 0  ] config_ss_fpga_axi_m0_r_data_sig;
logic  [ 3   : 0  ] config_ss_fpga_axi_m0_r_id_sig;
logic               config_ss_fpga_axi_m0_r_last_sig;
logic  [ 1   : 0  ] config_ss_fpga_axi_m0_r_resp_sig;
logic               config_ss_fpga_axi_m0_r_valid_sig;
logic               config_ss_fpga_axi_m0_w_ready_sig;
logic               config_ss_fpga_axi_m1_ar_ready_sig;
logic               config_ss_fpga_axi_m1_aw_ready_sig;
logic  [ 3   : 0  ] config_ss_fpga_axi_m1_b_id_sig;
logic  [ 1   : 0  ] config_ss_fpga_axi_m1_b_resp_sig;
logic               config_ss_fpga_axi_m1_b_valid_sig;
logic  [ 31  : 0  ] config_ss_fpga_axi_m1_r_data_sig;
logic  [ 3   : 0  ] config_ss_fpga_axi_m1_r_id_sig;
logic               config_ss_fpga_axi_m1_r_last_sig;
logic  [ 1   : 0  ] config_ss_fpga_axi_m1_r_resp_sig;
logic               config_ss_fpga_axi_m1_r_valid_sig;
logic               config_ss_fpga_axi_m1_w_ready_sig;
logic [31:0]        config_ss_fpga_ahb_s0_hrdata;
logic               config_ss_fpga_ahb_s0_hready;
logic               config_ss_fpga_ahb_s0_hresp;
logic [31:0]  config_ss_axi_m0_ar_addr;
logic [1:0]   config_ss_axi_m0_ar_burst;
logic [3:0]   config_ss_axi_m0_ar_cache;
logic [3:0]   config_ss_axi_m0_ar_id;
logic [2:0]   config_ss_axi_m0_ar_len;
logic         config_ss_axi_m0_ar_lock;
logic [2:0]   config_ss_axi_m0_ar_prot;
logic [2:0]   config_ss_axi_m0_ar_size;
logic         config_ss_axi_m0_ar_valid;
logic [31:0]  config_ss_axi_m0_aw_addr;
logic [1:0]   config_ss_axi_m0_aw_burst;
logic [3:0]   config_ss_axi_m0_aw_cache;
logic [3:0]   config_ss_axi_m0_aw_id;
logic [2:0]   config_ss_axi_m0_aw_len;
logic         config_ss_axi_m0_aw_lock;
logic [2:0]   config_ss_axi_m0_aw_prot;
logic [2:0]   config_ss_axi_m0_aw_size;
logic         config_ss_axi_m0_aw_valid;
logic         config_ss_axi_m0_b_ready;
logic         config_ss_axi_m0_r_ready;
logic [63:0]  config_ss_axi_m0_w_data;
logic         config_ss_axi_m0_w_last;
logic [7:0]   config_ss_axi_m0_w_strb;
logic         config_ss_axi_m0_w_valid;
logic [31:0]  config_ss_axi_m1_ar_addr;
logic [1:0]   config_ss_axi_m1_ar_burst;
logic [3:0]   config_ss_axi_m1_ar_cache;
logic [3:0]   config_ss_axi_m1_ar_id;
logic [3:0]   config_ss_axi_m1_ar_len;
logic         config_ss_axi_m1_ar_lock;
logic [2:0]   config_ss_axi_m1_ar_prot;
logic [2:0]   config_ss_axi_m1_ar_size;
logic         config_ss_axi_m1_ar_valid;
logic [31:0]  config_ss_axi_m1_aw_addr;
logic [1:0]   config_ss_axi_m1_aw_burst;
logic [3:0]   config_ss_axi_m1_aw_cache;
logic [3:0]   config_ss_axi_m1_aw_id;
logic [3:0]   config_ss_axi_m1_aw_len;
logic         config_ss_axi_m1_aw_lock;
logic [2:0]   config_ss_axi_m1_aw_prot;
logic [2:0]   config_ss_axi_m1_aw_size;
logic         config_ss_axi_m1_aw_valid;
logic         config_ss_axi_m1_b_ready;
logic         config_ss_axi_m1_r_ready;
logic [31:0]  config_ss_axi_m1_w_data;
logic         config_ss_axi_m1_w_last;
logic [3:0]   config_ss_axi_m1_w_strb;
logic         config_ss_axi_m1_w_valid;
logic  [ 31  : 0  ] config_ss_FCB_apb_s0_paddr_sig;
logic               config_ss_FCB_apb_s0_penable_sig;
logic               config_ss_FCB_apb_s0_psel_sig;
logic  [ 3   : 0  ] config_ss_FCB_apb_s0_pwbe_sig;
logic  [ 31  : 0  ] config_ss_FCB_apb_s0_pwdata_sig;
logic               config_ss_FCB_apb_s0_pwrite_sig;
logic  [ 31  : 0  ] config_ss_fcb_s0_prdata_sig;
logic               config_ss_fcb_s0_pready_sig;
logic               config_ss_fcb_s0_pslverr_sig;



ae350_cpu_subsystem acpu (
      .arid(                         acpu_arid_sig                        ),
      .araddr(                       acpu_araddr_sig                      ),
      .arlen(                        acpu_arlen_sig                       ),
      .arsize(                       acpu_arsize_sig                      ),
      .arburst(                      acpu_arburst_sig                     ),
      .arlock(                       acpu_arlock_sig                      ),
      .arcache(                      acpu_arcache_sig                     ),
      .arprot(                       acpu_arprot_sig                      ),
      .arvalid(                      acpu_arvalid_sig                     ),
      .arready(                      flexnoc_acpu_axi_m0_ar_ready_sig     ),
      .awid(                         acpu_awid_sig                        ),
      .awaddr(                       acpu_awaddr_sig                      ),
      .awlen(                        acpu_awlen_sig                       ),
      .awsize(                       acpu_awsize_sig                      ),
      .awburst(                      acpu_awburst_sig                     ),
      .awlock(                       acpu_awlock_sig                      ),
      .awcache(                      acpu_awcache_sig                     ),
      .awprot(                       acpu_awprot_sig                      ),
      .awvalid(                      acpu_awvalid_sig                     ),
      .awready(                      flexnoc_acpu_axi_m0_aw_ready_sig     ),
      .wdata(                        acpu_wdata_sig                       ),
      .wstrb(                        acpu_wstrb_sig                       ),
      .wlast(                        acpu_wlast_sig                       ),
      .wvalid(                       acpu_wvalid_sig                      ),
      .wready(                       flexnoc_acpu_axi_m0_w_ready_sig      ),
      .bid(                          flexnoc_acpu_axi_m0_b_id_sig         ),
      .bresp(                        flexnoc_acpu_axi_m0_b_resp_sig       ),
      .bvalid(                       flexnoc_acpu_axi_m0_b_valid_sig      ),
      .bready(                       acpu_bready_sig                      ),
      .rid(                          flexnoc_acpu_axi_m0_r_id_sig         ),
      .rdata(                        flexnoc_acpu_axi_m0_r_data_sig       ),
      .rresp(                        flexnoc_acpu_axi_m0_r_resp_sig       ),
      .rlast(                        flexnoc_acpu_axi_m0_r_last_sig       ),
      .rvalid(                       flexnoc_acpu_axi_m0_r_valid_sig      ),
      .rready(                       acpu_rready_sig                      ),
      .axi_bus_clk_en(               1'b1                                 ),
      .core_clk(                     config_ss_clk_acpu_sig               ),
      .core_resetn(                  config_ss_rst_n_acpu_sig             ),
      .dbg_srst_req(                 acpu_dbg_srst_req_sig                ),
      .dc_clk(                       config_ss_clk_acpu_sig               ),
      .hart0_wakeup_event(           acpu_hart0_wakeup_event_sig          ),
      .lm_clk(                       config_ss_clk_acpu_sig               ),
      .test_rstn(                    1'b0                                 ),
      .aclk(                         config_ss_clk_acpu_sig               ),
      .aresetn(                      config_ss_rst_n_acpu_bus_sig         ),
      .scan_enable(                                                       ),
      .test_mode(                    testmode                            ),
      .int_src(                      config_ss_acpu_irq_set_sig[31:1]     ),
      .mtime_clk(                    config_ss_clk_acpu_mtime_sig         ),
      .por_rstn(                     config_ss_rst_n_acpu_bus_sig         ),
      .slvp_resetn(                  config_ss_rst_n_acpu_bus_sig         ),
      .hart0_reset_vector(           32'b00000000000000000000000000000000 ),
      .hart0_icache_disable_init(    1'b0                                 ),
      .hart0_dcache_disable_init(    1'b0                                 ),
      .hart0_core_wfi_mode(          acpu_hart0_core_wfi_mode_sig         ),
      .hart0_nmi(                    config_ss_acpu_irq_set_sig[0]        ),
      .jtag_tck(                     acpu_jtag_tck                        ),
      .jtag_tdi(                     acpu_jtag_tdi                        ),
      .jtag_tdo(                     acpu_jtag_tdo_sig                    ),
      .jtag_tms(                     acpu_jtag_tms                        ) 
      );


soc_config_subsystem config_ss (
      .locked_proto (1'b1),
      .reset_proto (~reset),
      .uart0_sout_proto (uart0_sout),
      .uart0_sin_proto (uart0_sin),
      .clk_out4_proto (clk_out4),
      .clk_out3_proto (clk_out3),
      .clk_out2_proto (clk_out2),
      .clk_out1_proto (clk_out1),
      .clk_osc(                        clk_out3                                ),
      .clk_fpga0(                      'd0                              ),
      .clk_fpga1(                      'd0                              ),
      .clk_fpga_s(                     'd0                              ),
    .clk_acpu                     (config_ss_clk_acpu_sig            ),
    .clk_acpu_mtime               (config_ss_clk_acpu_mtime_sig      ),
    .clk_bcpu                     (config_ss_clk_bcpu_sig            ),
    .clk_ddr_phy                  (config_ss_clk_ddr_phy_sig         ),
    .clk_ddr_ctl                  (config_ss_clk_ddr_ctl_sig         ),
    .clk_ddr_cfg                  (config_ss_clk_ddr_cfg_sig         ),
    .clk_apb_ug                   (config_ss_clk_apb_ug_sig          ),
    .rst_n_bcpu                   (config_ss_rst_n_bcpu_sig          ),
    .rst_n_bcpu_bus               (config_ss_rst_n_bcpu_bus_sig      ),
    .rst_n_sram                   (config_ss_rst_n_sram_sig          ),
    .rst_n_acpu                   (config_ss_rst_n_acpu_sig          ),
    .rst_n_acpu_bus               (config_ss_rst_n_acpu_bus_sig      ),
    .rst_n_fpga0                  (config_ss_rst_n_fpga0_sig         ),
    .rst_n_fpga1                  (config_ss_rst_n_fpga1_sig         ),
    .rst_n_fpga_s                 (config_ss_rst_n_fpga_s_sig        ),
    .rst_n_ddr                    (config_ss_rst_n_ddr_sig           ),
    .rst_n_133                    (config_ss_rst_n_133_sig           ),
    .rst_n_266                    (config_ss_rst_n_266_sig           ),
    .rst_n_533                    (config_ss_rst_n_533_sig           ),
    .rst_n_per                    (rst_n_per                         ),
    .acpu_wdt_s0_paddr            (flexnoc_ACPU_WDT_PAddr_sig        ),
    .acpu_wdt_s0_psel             (flexnoc_ACPU_WDT_PSel_sig         ),
    .acpu_wdt_s0_penable          (flexnoc_ACPU_WDT_PEnable_sig      ),
    .acpu_wdt_s0_pwrite           (flexnoc_ACPU_WDT_PWrite_sig       ),
    .acpu_wdt_s0_pwdata           (flexnoc_ACPU_WDT_PWData_sig       ),
    .acpu_wdt_s0_prdata           (config_ss_acpu_wdt_s0_prdata_sig  ),
    .acpu_wdt_s0_pready           (config_ss_acpu_wdt_s0_pready_sig  ),
    .acpu_wdt_s0_pslverr          (config_ss_acpu_wdt_s0_pslverr_sig ),
    .bcpu_wdt_s0_paddr            (flexnoc_BCPU_WDT_PAddr_sig        ),
    .bcpu_wdt_s0_psel             (flexnoc_BCPU_WDT_PSel_sig         ),
    .bcpu_wdt_s0_penable          (flexnoc_BCPU_WDT_PEnable_sig      ),
    .bcpu_wdt_s0_pwrite           (flexnoc_BCPU_WDT_PWrite_sig       ),
    .bcpu_wdt_s0_pwdata           (flexnoc_BCPU_WDT_PWData_sig       ),
    .bcpu_wdt_s0_prdata           (config_ss_bcpu_wdt_s0_prdata_sig  ),
    .bcpu_wdt_s0_pready           (config_ss_bcpu_wdt_s0_pready_sig  ),
    .bcpu_wdt_s0_pslverr          (config_ss_bcpu_wdt_s0_pslverr_sig ),
    .dma_s0_paddr                 (flexnoc_DMA_apb_s0_paddr_sig      ),
    .dma_s0_psel                  (flexnoc_DMA_apb_s0_psel_sig       ),
    .dma_s0_penable               (flexnoc_DMA_apb_s0_penable_sig    ),
    .dma_s0_pwrite                (flexnoc_DMA_apb_s0_pwrite_sig     ),
    .dma_s0_pwdata                (flexnoc_DMA_apb_s0_pwdata_sig     ),
    .dma_s0_prdata                (config_ss_dma_s0_prdata_sig       ),
    .dma_s0_pready                (config_ss_dma_s0_pready_sig       ),
    .dma_s0_pslverr               (config_ss_dma_s0_pslverr_sig      ),
    .gpio_s0_paddr                (flexnoc_GPIO_apb_s0_paddr_sig     ),
    .gpio_s0_psel                 (flexnoc_GPIO_apb_s0_psel_sig      ),
    .gpio_s0_penable              (flexnoc_GPIO_apb_s0_penable_sig   ),
    .gpio_s0_pwrite               (flexnoc_GPIO_apb_s0_pwrite_sig    ),
    .gpio_s0_pwdata               (flexnoc_GPIO_apb_s0_pwdata_sig    ),
    .gpio_s0_prdata               (config_ss_gpio_s0_prdata_sig      ),
    .gpio_s0_pready               (config_ss_gpio_s0_pready_sig      ),
    .gpio_s0_pslverr              (config_ss_gpio_s0_pslverr_sig     ),
    .gpt_s0_paddr                 (flexnoc_GPT_apb_s0_paddr_sig      ),
    .gpt_s0_psel                  (flexnoc_GPT_apb_s0_psel_sig       ),
    .gpt_s0_penable               (flexnoc_GPT_apb_s0_penable_sig    ),
    .gpt_s0_pwrite                (flexnoc_GPT_apb_s0_pwrite_sig     ),
    .gpt_s0_pwdata                (flexnoc_GPT_apb_s0_pwdata_sig     ),
    .gpt_s0_prdata                (config_ss_gpt_s0_prdata_sig       ),
    .gpt_s0_pready                (config_ss_gpt_s0_pready_sig       ),
    .gpt_s0_pslverr               (config_ss_gpt_s0_pslverr_sig      ),
    .i2c_s0_paddr                 (flexnoc_I2C_apb_s0_paddr_sig      ),
    .i2c_s0_psel                  (flexnoc_I2C_apb_s0_psel_sig       ),
    .i2c_s0_penable               (flexnoc_I2C_apb_s0_penable_sig    ),
    .i2c_s0_pwrite                (flexnoc_I2C_apb_s0_pwrite_sig     ),
    .i2c_s0_pwdata                (flexnoc_I2C_apb_s0_pwdata_sig     ),
    .i2c_s0_prdata                (config_ss_i2c_s0_prdata_sig       ),
    .i2c_s0_pready                (config_ss_i2c_s0_pready_sig       ),
    .i2c_s0_pslverr               (config_ss_i2c_s0_pslverr_sig      ),
    .mbox_s0_paddr                (flexnoc_MBOX_apb_s0_paddr_sig     ),
    .mbox_s0_psel                 (flexnoc_MBOX_apb_s0_psel_sig      ),
    .mbox_s0_penable              (flexnoc_MBOX_apb_s0_penable_sig   ),
    .mbox_s0_pwrite               (flexnoc_MBOX_apb_s0_pwrite_sig    ),
    .mbox_s0_pwdata               (flexnoc_MBOX_apb_s0_pwdata_sig    ),
    .mbox_s0_pstrb                (flexnoc_MBOX_apb_s0_pwbe_sig      ),
    .mbox_s0_prdata               (config_ss_mbox_s0_prdata_sig      ),
    .mbox_s0_pready               (config_ss_mbox_s0_pready_sig      ),
    .mbox_s0_pslverr              (config_ss_mbox_s0_pslverr_sig     ),
    .pufcc_s0_paddr               (flexnoc_PUFCC_apb_s0_PAddr_sig    ),
    .pufcc_s0_penable             (flexnoc_PUFCC_apb_s0_PEnable_sig  ),
    .pufcc_s0_prdata              (config_ss_pufcc_s0_prdata_sig     ),
    .pufcc_s0_pready              (config_ss_pufcc_s0_pready_sig     ),
    .pufcc_s0_psel                (flexnoc_PUFCC_apb_s0_PSel_sig     ),
    .pufcc_s0_pslverr             (config_ss_pufcc_s0_pslverr_sig    ),
    .pufcc_s0_pwdata              (flexnoc_PUFCC_apb_s0_PWData_sig   ),
    .pufcc_s0_pwrite              (flexnoc_PUFCC_apb_s0_PWrite_sig   ),
    .scu_s0_paddr                 (flexnoc_SCU_PAddr_sig             ),
    .scu_s0_psel                  (flexnoc_SCU_PSel_sig              ),
    .scu_s0_penable               (flexnoc_SCU_PEnable_sig           ),
    .scu_s0_pwrite                (flexnoc_SCU_PWrite_sig            ),
    .scu_s0_pwdata                (flexnoc_SCU_PWData_sig            ),
    .scu_s0_pstrb                 (flexnoc_SCU_PWBe_sig              ),
    .scu_s0_prdata                (config_ss_scu_s0_prdata_sig       ),
    .scu_s0_pready                (config_ss_scu_s0_pready_sig       ),
    .scu_s0_pslverr               (config_ss_scu_s0_pslverr_sig      ),
    .spi_reg_s0_haddr             (flexnoc_SPI_ahb_s0_haddr_sig      ),
    .spi_reg_s0_hrdata            (config_ss_spi_reg_s0_hrdata_sig   ),
    .spi_reg_s0_hready            (config_ss_spi_reg_s0_hready_sig   ),
    .spi_reg_s0_hresp             (config_ss_spi_reg_s0_hresp_sig    ),
    .spi_reg_s0_hsel              (flexnoc_SPI_ahb_s0_hsel_sig       ),
    .spi_reg_s0_htrans            (flexnoc_SPI_ahb_s0_htrans_sig     ),
    .spi_reg_s0_hwdata            (flexnoc_SPI_ahb_s0_hwdata_sig     ),
    .spi_reg_s0_hwrite            (flexnoc_SPI_ahb_s0_hwrite_sig     ),
    .spi_mem_s0_haddr             (flexnoc_SPI_mem_ahb_haddr_sig     ),
    .spi_mem_s0_hrdata            (config_ss_spi_mem_s0_hrdata_sig   ),
    .spi_mem_s0_hready            (config_ss_spi_mem_s0_hready_sig   ),
    .spi_mem_s0_hresp             (config_ss_spi_mem_s0_hresp_sig    ),
    .spi_mem_s0_hsel              (flexnoc_SPI_mem_ahb_hsel_sig      ),
    .spi_mem_s0_htrans            (flexnoc_SPI_mem_ahb_htrans_sig    ),
    .spi_mem_s0_hwrite            (flexnoc_SPI_mem_ahb_hwrite_sig    ),
    .uart_s0_paddr                (flexnoc_UART_apb_s0_paddr_sig     ),
    .uart_s0_psel                 (flexnoc_UART_apb_s0_psel_sig      ),
    .uart_s0_penable              (flexnoc_UART_apb_s0_penable_sig   ),
    .uart_s0_pwrite               (flexnoc_UART_apb_s0_pwrite_sig    ),
    .uart_s0_pwdata               (flexnoc_UART_apb_s0_pwdata_sig    ),
    .uart_s0_prdata               (config_ss_uart_s0_prdata_sig      ),
    .uart_s0_pready               (config_ss_uart_s0_pready_sig      ),
    .uart_s0_pslverr              (config_ss_uart_s0_pslverr_sig     ),
    .uart_s1_paddr                (flexnoc_UART_apb_s1_paddr_sig     ),
    .uart_s1_psel                 (flexnoc_UART_apb_s1_psel_sig      ),
    .uart_s1_penable              (flexnoc_UART_apb_s1_penable_sig   ),
    .uart_s1_pwrite               (flexnoc_UART_apb_s1_pwrite_sig    ),
    .uart_s1_pwdata               (flexnoc_UART_apb_s1_pwdata_sig    ),
    .uart_s1_prdata               (config_ss_uart_s1_prdata_sig      ),
    .uart_s1_pready               (config_ss_uart_s1_pready_sig      ),
    .uart_s1_pslverr              (config_ss_uart_s1_pslverr_sig     ),
    .usb_s0_araddr                (flexnoc_USB_axi_s0_ar_addr_sig    ),
    .usb_s0_arprot                (flexnoc_USB_axi_s0_ar_prot_sig    ),
    .usb_s0_arready               (config_ss_usb_s0_arready_sig      ),
    .usb_s0_arvalid               (flexnoc_USB_axi_s0_ar_valid_sig   ),
    .usb_s0_awaddr                (flexnoc_USB_axi_s0_aw_addr_sig    ),
    .usb_s0_awprot                (flexnoc_USB_axi_s0_aw_prot_sig    ),
    .usb_s0_awready               (config_ss_usb_s0_awready_sig      ),
    .usb_s0_awvalid               (flexnoc_USB_axi_s0_aw_valid_sig   ),
    .usb_s0_bready                (flexnoc_USB_axi_s0_b_ready_sig    ),
    .usb_s0_bresp                 (config_ss_usb_s0_bresp_sig        ),
    .usb_s0_bvalid                (config_ss_usb_s0_bvalid_sig       ),
    .usb_s0_rdata                 (config_ss_usb_s0_rdata_sig        ),
    .usb_s0_rready                (flexnoc_USB_axi_s0_r_ready_sig    ),
    .usb_s0_rresp                 (config_ss_usb_s0_rresp_sig        ),
    .usb_s0_rvalid                (config_ss_usb_s0_rvalid_sig       ),
    .usb_s0_wdata                 (flexnoc_USB_axi_s0_w_data_sig     ),
    .usb_s0_wready                (config_ss_usb_s0_wready_sig       ),
    .usb_s0_wstrb                 (flexnoc_USB_axi_s0_w_strb_sig     ),
    .usb_s0_wvalid                (flexnoc_USB_axi_s0_w_valid_sig    ),
    .bcpu_m0_hrdata               (flexnoc_bcpu_ahb_m0_hrdata_sig    ),
    .bcpu_m0_hready               (flexnoc_bcpu_ahb_m0_hready_sig    ),
    .bcpu_m0_hresp                ({ 1'b0,                           
                                   flexnoc_bcpu_ahb_m0_hresp_sig }   ), 
    .bcpu_m0_haddr                (config_ss_bcpu_m0_haddr_sig       ),
    .bcpu_m0_hsel                 (config_ss_bcpu_m0_hsel_sig        ),
    .bcpu_m0_hburst               (config_ss_bcpu_m0_hburst_sig      ),
    .bcpu_m0_hprot                (config_ss_bcpu_m0_hprot_sig       ),
    .bcpu_m0_hsize                (config_ss_bcpu_m0_hsize_sig       ),
    .bcpu_m0_htrans               (config_ss_bcpu_m0_htrans_sig      ),
    .bcpu_m0_hwdata               (config_ss_bcpu_m0_hwdata_sig      ),
    .bcpu_m0_hwrite               (config_ss_bcpu_m0_hwrite_sig      ),
    .dma_m0_araddr                (config_ss_dma_m0_araddr_sig       ),
    .dma_m0_arburst               (config_ss_dma_m0_arburst_sig      ),
    .dma_m0_arcache               (config_ss_dma_m0_arcache_sig      ),
    .dma_m0_arid                  (config_ss_dma_m0_arid_sig         ),
    .dma_m0_arlen                 (config_ss_dma_m0_arlen_sig        ),
    .dma_m0_arlock                (config_ss_dma_m0_arlock_sig       ),
    .dma_m0_arprot                (config_ss_dma_m0_arprot_sig       ),
    .dma_m0_arready               (flexnoc_dma_axi_m0_ar_ready_sig   ),
    .dma_m0_arsize                (config_ss_dma_m0_arsize_sig       ),
    .dma_m0_arvalid               (config_ss_dma_m0_arvalid_sig      ),
    .dma_m0_awaddr                (config_ss_dma_m0_awaddr_sig       ),
    .dma_m0_awburst               (config_ss_dma_m0_awburst_sig      ),
    .dma_m0_awcache               (config_ss_dma_m0_awcache_sig      ),
    .dma_m0_awid                  (config_ss_dma_m0_awid_sig         ),
    .dma_m0_awlen                 (config_ss_dma_m0_awlen_sig        ),
    .dma_m0_awlock                (config_ss_dma_m0_awlock_sig       ),
    .dma_m0_awprot                (config_ss_dma_m0_awprot_sig       ),
    .dma_m0_awready               (flexnoc_dma_axi_m0_aw_ready_sig   ),
    .dma_m0_awsize                (config_ss_dma_m0_awsize_sig       ),
    .dma_m0_awvalid               (config_ss_dma_m0_awvalid_sig      ),
    .dma_m0_bid                   (flexnoc_dma_axi_m0_b_id_sig[2:0]  ),
    .dma_m0_bready                (config_ss_dma_m0_bready_sig       ),
    .dma_m0_bresp                 (flexnoc_dma_axi_m0_b_resp_sig     ),
    .dma_m0_bvalid                (flexnoc_dma_axi_m0_b_valid_sig    ),
    .dma_m0_rdata                 (flexnoc_dma_axi_m0_r_data_sig     ),
    .dma_m0_rid                   (flexnoc_dma_axi_m0_r_id_sig[2:0]  ),
    .dma_m0_rlast                 (flexnoc_dma_axi_m0_r_last_sig     ),
    .dma_m0_rready                (config_ss_dma_m0_rready_sig       ),
    .dma_m0_rresp                 (flexnoc_dma_axi_m0_r_resp_sig     ),
    .dma_m0_rvalid                (flexnoc_dma_axi_m0_r_valid_sig    ),
    .dma_m0_wdata                 (config_ss_dma_m0_wdata_sig        ),
    .dma_m0_wlast                 (config_ss_dma_m0_wlast_sig        ),
    .dma_m0_wready                (flexnoc_dma_axi_m0_w_ready_sig    ),
    .dma_m0_wstrb                 (config_ss_dma_m0_wstrb_sig        ),
    .dma_m0_wvalid                (config_ss_dma_m0_wvalid_sig       ),
    .dma_m1_araddr                (config_ss_dma_m1_araddr_sig       ),
    .dma_m1_arburst               (config_ss_dma_m1_arburst_sig      ),
    .dma_m1_arcache               (config_ss_dma_m1_arcache_sig      ),
    .dma_m1_arid                  (config_ss_dma_m1_arid_sig         ),
    .dma_m1_arlen                 (config_ss_dma_m1_arlen_sig        ),
    .dma_m1_arlock                (config_ss_dma_m1_arlock_sig       ),
    .dma_m1_arprot                (config_ss_dma_m1_arprot_sig       ),
    .dma_m1_arready               (flexnoc_dma_axi_m1_ar_ready_sig   ),
    .dma_m1_arsize                (config_ss_dma_m1_arsize_sig       ),
    .dma_m1_arvalid               (config_ss_dma_m1_arvalid_sig      ),
    .dma_m1_awaddr                (config_ss_dma_m1_awaddr_sig       ),
    .dma_m1_awburst               (config_ss_dma_m1_awburst_sig      ),
    .dma_m1_awcache               (config_ss_dma_m1_awcache_sig      ),
    .dma_m1_awid                  (config_ss_dma_m1_awid_sig         ),
    .dma_m1_awlen                 (config_ss_dma_m1_awlen_sig        ),
    .dma_m1_awlock                (config_ss_dma_m1_awlock_sig       ),
    .dma_m1_awprot                (config_ss_dma_m1_awprot_sig       ),
    .dma_m1_awready               (flexnoc_dma_axi_m1_aw_ready_sig   ),
    .dma_m1_awsize                (config_ss_dma_m1_awsize_sig       ),
    .dma_m1_awvalid               (config_ss_dma_m1_awvalid_sig      ),
    .dma_m1_bid                   (flexnoc_dma_axi_m1_b_id_sig[2:0]  ),
    .dma_m1_bready                (config_ss_dma_m1_bready_sig       ),
    .dma_m1_bresp                 (flexnoc_dma_axi_m1_b_resp_sig     ),
    .dma_m1_bvalid                (flexnoc_dma_axi_m1_b_valid_sig    ),
    .dma_m1_rdata                 (flexnoc_dma_axi_m1_r_data_sig     ),
    .dma_m1_rid                   (flexnoc_dma_axi_m1_r_id_sig[2:0]  ),
    .dma_m1_rlast                 (flexnoc_dma_axi_m1_r_last_sig     ),
    .dma_m1_rready                (config_ss_dma_m1_rready_sig       ),
    .dma_m1_rresp                 (flexnoc_dma_axi_m1_r_resp_sig     ),
    .dma_m1_rvalid                (flexnoc_dma_axi_m1_r_valid_sig    ),
    .dma_m1_wdata                 (config_ss_dma_m1_wdata_sig        ),
    .dma_m1_wlast                 (config_ss_dma_m1_wlast_sig        ),
    .dma_m1_wready                (flexnoc_dma_axi_m1_w_ready_sig    ),
    .dma_m1_wstrb                 (config_ss_dma_m1_wstrb_sig        ),
    .dma_m1_wvalid                (config_ss_dma_m1_wvalid_sig       ),
    .gbe_s0_paddr                 (flexnoc_gbe_apb_s0_paddr_sig      ),
    .gbe_s0_psel                  (flexnoc_gbe_apb_s0_psel_sig       ),
    .gbe_s0_penable               (flexnoc_gbe_apb_s0_penable_sig    ),
    .gbe_s0_pwrite                (flexnoc_gbe_apb_s0_pwrite_sig     ),
    .gbe_s0_pwdata                (flexnoc_gbe_apb_s0_pwdata_sig     ),
    .gbe_s0_prdata                (config_ss_gbe_s0_prdata_sig       ),
    .gbe_s0_pslverr               (config_ss_gbe_s0_pslverr_sig      ),
    .gbe_m0_araddr                (config_ss_gbe_m0_araddr_sig       ),
    .gbe_m0_arburst               (config_ss_gbe_m0_arburst_sig      ),
    .gbe_m0_arcache               (config_ss_gbe_m0_arcache_sig      ),
    .gbe_m0_arid                  (config_ss_gbe_m0_arid_sig         ),
    .gbe_m0_arlen                 (config_ss_gbe_m0_arlen_sig        ),
    .gbe_m0_arlock                (config_ss_gbe_m0_arlock_sig       ),
    .gbe_m0_arprot                (config_ss_gbe_m0_arprot_sig       ),
    .gbe_m0_arready               (flexnoc_gbe_axi_m0_ar_ready_sig   ),
    .gbe_m0_arsize                (config_ss_gbe_m0_arsize_sig       ),
    .gbe_m0_arvalid               (config_ss_gbe_m0_arvalid_sig      ),
    .gbe_m0_awaddr                (config_ss_gbe_m0_awaddr_sig       ),
    .gbe_m0_awburst               (config_ss_gbe_m0_awburst_sig      ),
    .gbe_m0_awcache               (config_ss_gbe_m0_awcache_sig      ),
    .gbe_m0_awid                  (config_ss_gbe_m0_awid_sig         ),
    .gbe_m0_awlen                 (config_ss_gbe_m0_awlen_sig        ),
    .gbe_m0_awlock                (config_ss_gbe_m0_awlock_sig       ),
    .gbe_m0_awprot                (config_ss_gbe_m0_awprot_sig       ),
    .gbe_m0_awready               (flexnoc_gbe_axi_m0_aw_ready_sig   ),
    .gbe_m0_awsize                (config_ss_gbe_m0_awsize_sig       ),
    .gbe_m0_awvalid               (config_ss_gbe_m0_awvalid_sig      ),
    .gbe_m0_bid                   (flexnoc_gbe_axi_m0_b_id_sig       ),
    .gbe_m0_bready                (config_ss_gbe_m0_bready_sig       ),
    .gbe_m0_bresp                 (flexnoc_gbe_axi_m0_b_resp_sig     ),
    .gbe_m0_bvalid                (flexnoc_gbe_axi_m0_b_valid_sig    ),
    .gbe_m0_rdata                 (flexnoc_gbe_axi_m0_r_data_sig     ),
    .gbe_m0_rid                   (flexnoc_gbe_axi_m0_r_id_sig       ),
    .gbe_m0_rlast                 (flexnoc_gbe_axi_m0_r_last_sig     ),
    .gbe_m0_rready                (config_ss_gbe_m0_rready_sig       ),
    .gbe_m0_rresp                 (flexnoc_gbe_axi_m0_r_resp_sig     ),
    .gbe_m0_rvalid                (flexnoc_gbe_axi_m0_r_valid_sig    ),
    .gbe_m0_wdata                 (config_ss_gbe_m0_wdata_sig        ),
    .gbe_m0_wlast                 (config_ss_gbe_m0_wlast_sig        ),
    .gbe_m0_wready                (flexnoc_gbe_axi_m0_w_ready_sig    ),
    .gbe_m0_wstrb                 (config_ss_gbe_m0_wstrb_sig        ),
    .gbe_m0_wvalid                (config_ss_gbe_m0_wvalid_sig       ),
    .pufcc_m0_ar_addr             (config_ss_pufcc_m0_ar_addr_sig    ),
    .pufcc_m0_ar_burst            (config_ss_pufcc_m0_ar_burst_sig   ),
    .pufcc_m0_ar_cache            (config_ss_pufcc_m0_ar_cache_sig   ),
    .pufcc_m0_ar_id               (config_ss_pufcc_m0_ar_id_sig      ),
    .pufcc_m0_ar_len              (config_ss_pufcc_m0_ar_len_sig     ),
    .pufcc_m0_ar_lock             (config_ss_pufcc_m0_ar_lock_sig    ),
    .pufcc_m0_ar_prot             (config_ss_pufcc_m0_ar_prot_sig    ),
    .pufcc_m0_ar_ready            (flexnoc_pufcc_axi_m0_ar_ready_sig ),
    .pufcc_m0_ar_size             (config_ss_pufcc_m0_ar_size_sig    ),
    .pufcc_m0_ar_valid            (config_ss_pufcc_m0_ar_valid_sig   ),
    .pufcc_m0_aw_addr             (config_ss_pufcc_m0_aw_addr_sig    ),
    .pufcc_m0_aw_burst            (config_ss_pufcc_m0_aw_burst_sig   ),
    .pufcc_m0_aw_cache            (config_ss_pufcc_m0_aw_cache_sig   ),
    .pufcc_m0_aw_id               (config_ss_pufcc_m0_aw_id_sig      ),
    .pufcc_m0_aw_len              (config_ss_pufcc_m0_aw_len_sig     ),
    .pufcc_m0_aw_lock             (config_ss_pufcc_m0_aw_lock_sig    ),
    .pufcc_m0_aw_prot             (config_ss_pufcc_m0_aw_prot_sig    ),
    .pufcc_m0_aw_ready            (flexnoc_pufcc_axi_m0_aw_ready_sig ),
    .pufcc_m0_aw_size             (config_ss_pufcc_m0_aw_size_sig    ),
    .pufcc_m0_aw_valid            (config_ss_pufcc_m0_aw_valid_sig   ),
    .pufcc_m0_b_ready             (config_ss_pufcc_m0_b_ready_sig    ),
    .pufcc_m0_b_resp              (flexnoc_pufcc_axi_m0_b_resp_sig   ),
    .pufcc_m0_b_valid             (flexnoc_pufcc_axi_m0_b_valid_sig  ),
    .pufcc_m0_r_data              (flexnoc_pufcc_axi_m0_r_data_sig   ),
    .pufcc_m0_r_last              (flexnoc_pufcc_axi_m0_r_last_sig   ),
    .pufcc_m0_r_ready             (config_ss_pufcc_m0_r_ready_sig    ),
    .pufcc_m0_r_resp              (flexnoc_pufcc_axi_m0_r_resp_sig   ),
    .pufcc_m0_r_valid             (flexnoc_pufcc_axi_m0_r_valid_sig  ),
    .pufcc_m0_w_data              (config_ss_pufcc_m0_w_data_sig     ),
    .pufcc_m0_w_last              (config_ss_pufcc_m0_w_last_sig     ),
    .pufcc_m0_w_ready             (flexnoc_pufcc_axi_m0_w_ready_sig  ),
    .pufcc_m0_w_strb              (config_ss_pufcc_m0_w_strb_sig     ),
    .pufcc_m0_w_valid             (config_ss_pufcc_m0_w_valid_sig    ),
    .usb_m0_araddr                (config_ss_usb_m0_araddr_sig       ),
    .usb_m0_arburst               (config_ss_usb_m0_arburst_sig      ),
    .usb_m0_arcache               (config_ss_usb_m0_arcache_sig      ),
    .usb_m0_arid                  (config_ss_usb_m0_arid_sig         ),
    .usb_m0_arlen                 (config_ss_usb_m0_arlen_sig        ),
    .usb_m0_arlock                (config_ss_usb_m0_arlock_sig       ),
    .usb_m0_arprot                (config_ss_usb_m0_arprot_sig       ),
    .usb_m0_arready               (flexnoc_usb_axi_m0_ar_ready_sig   ),
    .usb_m0_arsize                (config_ss_usb_m0_arsize_sig       ),
    .usb_m0_arvalid               (config_ss_usb_m0_arvalid_sig      ),
    .usb_m0_awaddr                (config_ss_usb_m0_awaddr_sig       ),
    .usb_m0_awburst               (config_ss_usb_m0_awburst_sig      ),
    .usb_m0_awcache               (config_ss_usb_m0_awcache_sig      ),
    .usb_m0_awid                  (config_ss_usb_m0_awid_sig         ),
    .usb_m0_awlen                 (config_ss_usb_m0_awlen_sig        ),
    .usb_m0_awlock                (config_ss_usb_m0_awlock_sig       ),
    .usb_m0_awprot                (config_ss_usb_m0_awprot_sig       ),
    .usb_m0_awready               (flexnoc_usb_axi_m0_aw_ready_sig   ),
    .usb_m0_awsize                (config_ss_usb_m0_awsize_sig       ),
    .usb_m0_awvalid               (config_ss_usb_m0_awvalid_sig      ),
    .usb_m0_bid                   (flexnoc_usb_axi_m0_b_id_sig       ),
    .usb_m0_bready                (config_ss_usb_m0_bready_sig       ),
    .usb_m0_bresp                 (flexnoc_usb_axi_m0_b_resp_sig     ),
    .usb_m0_bvalid                (flexnoc_usb_axi_m0_b_valid_sig    ),
    .usb_m0_rdata                 (flexnoc_usb_axi_m0_r_data_sig     ),
    .usb_m0_rid                   (flexnoc_usb_axi_m0_r_id_sig       ),
    .usb_m0_rlast                 (flexnoc_usb_axi_m0_r_last_sig     ),
    .usb_m0_rready                (config_ss_usb_m0_rready_sig       ),
    .usb_m0_rresp                 (flexnoc_usb_axi_m0_r_resp_sig     ),
    .usb_m0_rvalid                (flexnoc_usb_axi_m0_r_valid_sig    ),
    .usb_m0_wdata                 (config_ss_usb_m0_wdata_sig        ),
    .usb_m0_wlast                 (config_ss_usb_m0_wlast_sig        ),
    .usb_m0_wready                (flexnoc_usb_axi_m0_w_ready_sig    ),
    .usb_m0_wstrb                 (config_ss_usb_m0_wstrb_sig        ),
    .usb_m0_wvalid                (config_ss_usb_m0_wvalid_sig       ),
    .fpga_irq_src                 (soc_fpga_intf_fpga_irq_src_sig    ),
    .ddr_irq_src                  (memory_ss_int_gc_fsm_sig[0]       ),
    .acpu_irq_set                 (config_ss_acpu_irq_set_sig        ),
    .fpga_irq_set                 (soc_fpga_intf_fpga_irq_set_sig    ),
    .ace_isolation_ctl            (config_ss_ace_isolation_ctl_sig   ),
    .irq_isolation_ctl            (config_ss_irq_isolation_ctl_sig   ),
    .fcb_isolation_ctl            (config_ss_fcb_isolation_ctl_sig   ),
    .ahb_isolation_ctl            (config_ss_ahb_isolation_ctl_sig   ),
    .axi1_isolation_ctl           (config_ss_axi1_isolation_ctl_sig  ),
    .axi0_isolation_ctl           (config_ss_axi0_isolation_ctl_sig  ),
    .scl_o                        (config_ss_scl_o_sig               ),
    .spi_clk_oe                   (config_ss_spi_clk_oe_sig          ),
    .spi_clk_out                  (config_ss_spi_clk_out_sig         ),
    .gpio_pulldown                (config_ss_gpio_pulldown_sig       ),
    .gpio_pullup                  (config_ss_gpio_pullup_sig         ),
    .pit_pause                    (pit_pause                         ),
    .dma_req_fpga                 (soc_fpga_intf_dma_req_fpga_sig    ),
    .dma_ack_fpga                 (soc_fpga_intf_dma_ack_fpga_sig    ),
    .mdio_mdc                     (config_ss_mdio_mdc_sig            ),
    .usb_dp                       (usb_dp                            ),
    .usb_dn                       (usb_dn                            ),
    .usb_id                       (usb_id                            ),
    .usb_vbus                     (usb_vbus                          ),
    .usb_rtrim                    (usb_rtrim                         ),
    .usb_xtal_in                  (usb_xtal_in                       ),
    .bcpu_jtag_tck                (bcpu_jtag_tck                     ),
    .bcpu_jtag_tdi                (bcpu_jtag_tdi                     ),
    .bcpu_jtag_tdo                (config_ss_bcpu_jtag_tdo_sig       ),
    .bcpu_jtag_tms                (bcpu_jtag_tms                     ),
    .jtag_control                 (config_ss_jtag_control_sig        ),
    .fpga_pll3_clk_sel            (fpga_pll3_clk_sel                 ),
    .fpga_pll2_clk_sel            (fpga_pll2_clk_sel                 ),
    .fpga_pll1_clk_sel            (fpga_pll1_clk_sel                 ),
    .fpga_pll0_clk_sel            (fpga_pll0_clk_sel                 ),
    .RST_N                        (RST_N                             ),
    .XIN                          (XIN                               ),
    .REF_CLK_1                    (REF_CLK_1                         ),
    .REF_CLK_2                    (REF_CLK_2                         ),
    .REF_CLK_3                    (REF_CLK_3                         ),
    .REF_CLK_4                    (REF_CLK_4                         ),
    .TESTMODE                     (TESTMODE                          ),
    .BOOTM0                       (BOOTM0                            ),
    .BOOTM1                       (BOOTM1                            ),
    .BOOTM2                       (BOOTM2                            ),
    .CLKSEL_0                     (CLKSEL_0                          ),
    .CLKSEL_1                     (CLKSEL_1                          ),
    .JTAG_TDI                     (JTAG_TDI                          ),
    .JTAG_TDO                     (JTAG_TDO                          ),
    .JTAG_TMS                     (JTAG_TMS                          ),
    .JTAG_TCK                     (JTAG_TCK                          ),
    .JTAG_TRSTN                   (JTAG_TRSTN                        ),
    .GPIO_B_0                     (GPIO_B_0                          ),
    .GPIO_B_1                     (GPIO_B_1                          ),
    .GPIO_B_2                     (GPIO_B_2                          ),
    .GPIO_B_3                     (GPIO_B_3                          ),
    .GPIO_B_4                     (GPIO_B_4                          ),
    .GPIO_B_5                     (GPIO_B_5                          ),
    .GPIO_B_6                     (GPIO_B_6                          ),
    .GPIO_B_7                     (GPIO_B_7                          ),
    .GPIO_B_8                     (GPIO_B_8                          ),
    .GPIO_B_9                     (GPIO_B_9                          ),
    .GPIO_B_10                    (GPIO_B_10                         ),
    .GPIO_B_11                    (GPIO_B_11                         ),
    .GPIO_B_12                    (GPIO_B_12                         ),
    .GPIO_B_13                    (GPIO_B_13                         ),
    .GPIO_B_14                    (GPIO_B_14                         ),
    .GPIO_B_15                    (GPIO_B_15                         ),
    .GPIO_C_0                     (GPIO_C_0                          ),
    .GPIO_C_1                     (GPIO_C_1                          ),
    .GPIO_C_2                     (GPIO_C_2                          ),
    .GPIO_C_3                     (GPIO_C_3                          ),
    .GPIO_C_4                     (GPIO_C_4                          ),
    .GPIO_C_5                     (GPIO_C_5                          ),
    .GPIO_C_6                     (GPIO_C_6                          ),
    .GPIO_C_7                     (GPIO_C_7                          ),
    .GPIO_C_8                     (GPIO_C_8                          ),
    .GPIO_C_9                     (GPIO_C_9                          ),
    .GPIO_C_10                    (GPIO_C_10                         ),
    .GPIO_C_11                    (GPIO_C_11                         ),
    .GPIO_C_12                    (GPIO_C_12                         ),
    .GPIO_C_13                    (GPIO_C_13                         ),
    .GPIO_C_14                    (GPIO_C_14                         ),
    .GPIO_C_15                    (GPIO_C_15                         ),
    .I2C_SCL                      (I2C_SCL                           ),
    .SPI_SCLK                     (SPI_SCLK                          ),
    .GPT_RTC                      (GPT_RTC                           ),
    .MDIO_MDC                     (MDIO_MDC                          ),
    .MDIO_DATA                    (MDIO_DATA                         ),
    .RGMII_TXD0                   (RGMII_TXD0                        ),
    .RGMII_TXD1                   (RGMII_TXD1                        ),
    .RGMII_TXD2                   (RGMII_TXD2                        ),
    .RGMII_TXD3                   (RGMII_TXD3                        ),
    .RGMII_TX_CTL                 (RGMII_TX_CTL                      ),
    .RGMII_TXC                    (RGMII_TXC                         ),
    .RGMII_RXD0                   (RGMII_RXD0                        ),
    .RGMII_RXD1                   (RGMII_RXD1                        ),
    .RGMII_RXD2                   (RGMII_RXD2                        ),
    .RGMII_RXD3                   (RGMII_RXD3                        ),
    .RGMII_RX_CTL                 (RGMII_RX_CTL                      ),
    .RGMII_RXC                    (RGMII_RXC                         ),
    .testmode                     (testmode                          ),
    .soc_fpga_intf_ahb_s0_haddr   (config_ss_fpga_ahb_s0_haddr_sig   ),
    .soc_fpga_intf_ahb_s0_hburst  (config_ss_fpga_ahb_s0_hburst_sig  ),
    .soc_fpga_intf_ahb_s0_hready  (soc_fpga_intf_fpga_ahb_s0_hready  ),
    .soc_fpga_intf_ahb_s0_hprot   (config_ss_fpga_ahb_s0_hprot_sig   ),
    .soc_fpga_intf_ahb_s0_hrdata  (soc_fpga_intf_fpga_ahb_s0_hrdata  ),
    .soc_fpga_intf_ahb_s0_hresp   (soc_fpga_intf_fpga_ahb_s0_hresp   ),
    .soc_fpga_intf_ahb_s0_hsel    (config_ss_fpga_ahb_s0_hsel_sig    ),
    .soc_fpga_intf_ahb_s0_hsize   (config_ss_fpga_ahb_s0_hsize_sig   ),
    .soc_fpga_intf_ahb_s0_htrans  (config_ss_fpga_ahb_s0_htrans_sig  ),
    .soc_fpga_intf_ahb_s0_hwbe    (config_ss_fpga_ahb_s0_hwbe_sig    ),
    .soc_fpga_intf_ahb_s0_hwdata  (config_ss_fpga_ahb_s0_hwdata_sig  ),
    .soc_fpga_intf_ahb_s0_hwrite  (config_ss_fpga_ahb_s0_hwrite_sig  ),
    
    .soc_fpga_intf_axi_m0_ar_addr (soc_fpga_intf_axi_m0_ar_addr      ),
    .soc_fpga_intf_axi_m0_ar_burst(soc_fpga_intf_axi_m0_ar_burst     ),
    .soc_fpga_intf_axi_m0_ar_cache(soc_fpga_intf_axi_m0_ar_cache     ),
    .soc_fpga_intf_axi_m0_ar_id   (soc_fpga_intf_axi_m0_ar_id        ),
    .soc_fpga_intf_axi_m0_ar_len  (soc_fpga_intf_axi_m0_ar_len       ),
    .soc_fpga_intf_axi_m0_ar_lock (soc_fpga_intf_axi_m0_ar_lock      ),
    .soc_fpga_intf_axi_m0_ar_prot (soc_fpga_intf_axi_m0_ar_prot      ),
    .soc_fpga_intf_axi_m0_ar_ready(config_ss_fpga_axi_m0_ar_ready_sig),
    .soc_fpga_intf_axi_m0_ar_size (soc_fpga_intf_axi_m0_ar_size      ),
    .soc_fpga_intf_axi_m0_ar_valid(soc_fpga_intf_axi_m0_ar_valid     ),
    .soc_fpga_intf_axi_m0_aw_addr (soc_fpga_intf_axi_m0_aw_addr      ),
    .soc_fpga_intf_axi_m0_aw_burst(soc_fpga_intf_axi_m0_aw_burst     ),
    .soc_fpga_intf_axi_m0_aw_cache(soc_fpga_intf_axi_m0_aw_cache     ),
    .soc_fpga_intf_axi_m0_aw_id   (soc_fpga_intf_axi_m0_aw_id        ),
    .soc_fpga_intf_axi_m0_aw_len  (soc_fpga_intf_axi_m0_aw_len       ),
    .soc_fpga_intf_axi_m0_aw_lock (soc_fpga_intf_axi_m0_aw_lock      ),
    .soc_fpga_intf_axi_m0_aw_prot (soc_fpga_intf_axi_m0_aw_prot      ),
    .soc_fpga_intf_axi_m0_aw_ready(config_ss_fpga_axi_m0_aw_ready_sig),
    .soc_fpga_intf_axi_m0_aw_size (soc_fpga_intf_axi_m0_aw_size      ),
    .soc_fpga_intf_axi_m0_aw_valid(soc_fpga_intf_axi_m0_aw_valid     ),
    .soc_fpga_intf_axi_m0_b_id    (config_ss_fpga_axi_m0_b_id_sig    ),
    .soc_fpga_intf_axi_m0_b_ready (soc_fpga_intf_axi_m0_b_ready      ),
    .soc_fpga_intf_axi_m0_b_resp  (config_ss_fpga_axi_m0_b_resp_sig  ),
    .soc_fpga_intf_axi_m0_b_valid (config_ss_fpga_axi_m0_b_valid_sig ),
    .soc_fpga_intf_axi_m0_r_data  (config_ss_fpga_axi_m0_r_data_sig  ),
    .soc_fpga_intf_axi_m0_r_id    (config_ss_fpga_axi_m0_r_id_sig    ),
    .soc_fpga_intf_axi_m0_r_last  (config_ss_fpga_axi_m0_r_last_sig  ),
    .soc_fpga_intf_axi_m0_r_ready (soc_fpga_intf_axi_m0_r_ready      ),
    .soc_fpga_intf_axi_m0_r_resp  (config_ss_fpga_axi_m0_r_resp_sig  ),
    .soc_fpga_intf_axi_m0_r_valid (config_ss_fpga_axi_m0_r_valid_sig ),
    .soc_fpga_intf_axi_m0_w_data  (soc_fpga_intf_axi_m0_w_data       ),
    .soc_fpga_intf_axi_m0_w_last  (soc_fpga_intf_axi_m0_w_last       ),
    .soc_fpga_intf_axi_m0_w_ready (config_ss_fpga_axi_m0_w_ready_sig ),
    .soc_fpga_intf_axi_m0_w_strb  (soc_fpga_intf_axi_m0_w_strb       ),
    .soc_fpga_intf_axi_m0_w_valid (soc_fpga_intf_axi_m0_w_valid      ),
    .soc_fpga_intf_axi_m1_ar_addr (soc_fpga_intf_axi_m1_ar_addr      ),
    .soc_fpga_intf_axi_m1_ar_burst(soc_fpga_intf_axi_m1_ar_burst     ),
    .soc_fpga_intf_axi_m1_ar_cache(soc_fpga_intf_axi_m1_ar_cache     ),
    .soc_fpga_intf_axi_m1_ar_id   (soc_fpga_intf_axi_m1_ar_id        ),
    .soc_fpga_intf_axi_m1_ar_len  (soc_fpga_intf_axi_m1_ar_len       ),
    .soc_fpga_intf_axi_m1_ar_lock (soc_fpga_intf_axi_m1_ar_lock      ),
    .soc_fpga_intf_axi_m1_ar_prot (soc_fpga_intf_axi_m1_ar_prot      ),
    .soc_fpga_intf_axi_m1_ar_ready(config_ss_fpga_axi_m1_ar_ready_sig),
    .soc_fpga_intf_axi_m1_ar_size (soc_fpga_intf_axi_m1_ar_size      ),
    .soc_fpga_intf_axi_m1_ar_valid(soc_fpga_intf_axi_m1_ar_valid     ),
    .soc_fpga_intf_axi_m1_aw_addr (soc_fpga_intf_axi_m1_aw_addr      ),
    .soc_fpga_intf_axi_m1_aw_burst(soc_fpga_intf_axi_m1_aw_burst     ),
    .soc_fpga_intf_axi_m1_aw_cache(soc_fpga_intf_axi_m1_aw_cache     ),
    .soc_fpga_intf_axi_m1_aw_id   (soc_fpga_intf_axi_m1_aw_id        ),
    .soc_fpga_intf_axi_m1_aw_len  (soc_fpga_intf_axi_m1_aw_len       ),
    .soc_fpga_intf_axi_m1_aw_lock (soc_fpga_intf_axi_m1_aw_lock      ),
    .soc_fpga_intf_axi_m1_aw_prot (soc_fpga_intf_axi_m1_aw_prot      ),
    .soc_fpga_intf_axi_m1_aw_ready(config_ss_fpga_axi_m1_aw_ready_sig),
    .soc_fpga_intf_axi_m1_aw_size (soc_fpga_intf_axi_m1_aw_size      ),
    .soc_fpga_intf_axi_m1_aw_valid(soc_fpga_intf_axi_m1_aw_valid     ),
    .soc_fpga_intf_axi_m1_b_id    (config_ss_fpga_axi_m1_b_id_sig    ),
    .soc_fpga_intf_axi_m1_b_ready (soc_fpga_intf_axi_m1_b_ready      ),
    .soc_fpga_intf_axi_m1_b_resp  (config_ss_fpga_axi_m1_b_resp_sig  ),
    .soc_fpga_intf_axi_m1_b_valid (config_ss_fpga_axi_m1_b_valid_sig ),
    .soc_fpga_intf_axi_m1_r_data  (config_ss_fpga_axi_m1_r_data_sig  ),
    .soc_fpga_intf_axi_m1_r_id    (config_ss_fpga_axi_m1_r_id_sig    ),
    .soc_fpga_intf_axi_m1_r_last  (config_ss_fpga_axi_m1_r_last_sig  ),
    .soc_fpga_intf_axi_m1_r_ready (soc_fpga_intf_axi_m1_r_ready      ),
    .soc_fpga_intf_axi_m1_r_resp  (config_ss_fpga_axi_m1_r_resp_sig  ),
    .soc_fpga_intf_axi_m1_r_valid (config_ss_fpga_axi_m1_r_valid_sig ),
    .soc_fpga_intf_axi_m1_w_data  (soc_fpga_intf_axi_m1_w_data       ),
    .soc_fpga_intf_axi_m1_w_last  (soc_fpga_intf_axi_m1_w_last       ),
    .soc_fpga_intf_axi_m1_w_ready (config_ss_fpga_axi_m1_w_ready_sig ),
    .soc_fpga_intf_axi_m1_w_strb  (soc_fpga_intf_axi_m1_w_strb       ),
    .soc_fpga_intf_axi_m1_w_valid (soc_fpga_intf_axi_m1_w_valid      ),
    
    .soc_fpga_intf_fcb_s0_paddr   (config_ss_FCB_apb_s0_paddr_sig    ),
    .soc_fpga_intf_fcb_s0_psel    (config_ss_FCB_apb_s0_psel_sig     ),
    .soc_fpga_intf_fcb_s0_penable (config_ss_FCB_apb_s0_penable_sig  ),
    .soc_fpga_intf_fcb_s0_pwrite  (config_ss_FCB_apb_s0_pwrite_sig   ),
    .soc_fpga_intf_fcb_s0_pwdata  (config_ss_FCB_apb_s0_pwdata_sig   ),
    .soc_fpga_intf_fcb_s0_prdata  (soc_fpga_intf_fcb_s0_prdata_sig   ),
    .soc_fpga_intf_fcb_s0_pready  (soc_fpga_intf_fcb_s0_pready_sig   ),
    
    .flexnoc_ahb_s0_haddr         (flexnoc_fpga_ahb_s0_haddr_sig     ),
    .flexnoc_ahb_s0_hburst        (flexnoc_fpga_ahb_s0_hburst_sig    ),
    .flexnoc_ahb_s0_hprot         (flexnoc_fpga_ahb_s0_hprot_sig     ),
    .flexnoc_ahb_s0_hrdata        (config_ss_fpga_ahb_s0_hrdata      ),
    .flexnoc_ahb_s0_hready        (config_ss_fpga_ahb_s0_hready      ),
    .flexnoc_ahb_s0_hresp         (config_ss_fpga_ahb_s0_hresp       ),
    .flexnoc_ahb_s0_hsel          (flexnoc_fpga_ahb_s0_hsel_sig      ),
    .flexnoc_ahb_s0_hsize         (flexnoc_fpga_ahb_s0_hsize_sig     ),
    .flexnoc_ahb_s0_htrans        (flexnoc_fpga_ahb_s0_htrans_sig    ),
    .flexnoc_ahb_s0_hwbe          (flexnoc_fpga_ahb_s0_hwbe_sig      ),
    .flexnoc_ahb_s0_hwdata        (flexnoc_fpga_ahb_s0_hwdata_sig    ),
    .flexnoc_ahb_s0_hwrite        (flexnoc_fpga_ahb_s0_hwrite_sig    ),
    
    .flexnoc_axi_m0_ar_addr       (config_ss_axi_m0_ar_addr          ),
    .flexnoc_axi_m0_ar_burst      (config_ss_axi_m0_ar_burst         ),
    .flexnoc_axi_m0_ar_cache      (config_ss_axi_m0_ar_cache         ),
    .flexnoc_axi_m0_ar_id         (config_ss_axi_m0_ar_id            ),
    .flexnoc_axi_m0_ar_len        (config_ss_axi_m0_ar_len           ),
    .flexnoc_axi_m0_ar_lock       (config_ss_axi_m0_ar_lock          ),
    .flexnoc_axi_m0_ar_prot       (config_ss_axi_m0_ar_prot          ),
    .flexnoc_axi_m0_ar_ready      (flexnoc_fpga_axi_m0_ar_ready_sig  ),
    .flexnoc_axi_m0_ar_size       (config_ss_axi_m0_ar_size          ),
    .flexnoc_axi_m0_ar_valid      (config_ss_axi_m0_ar_valid         ),
    .flexnoc_axi_m0_aw_addr       (config_ss_axi_m0_aw_addr          ),
    .flexnoc_axi_m0_aw_burst      (config_ss_axi_m0_aw_burst         ),
    .flexnoc_axi_m0_aw_cache      (config_ss_axi_m0_aw_cache         ),
    .flexnoc_axi_m0_aw_id         (config_ss_axi_m0_aw_id            ),
    .flexnoc_axi_m0_aw_len        (config_ss_axi_m0_aw_len           ),
    .flexnoc_axi_m0_aw_lock       (config_ss_axi_m0_aw_lock          ),
    .flexnoc_axi_m0_aw_prot       (config_ss_axi_m0_aw_prot          ),
    .flexnoc_axi_m0_aw_ready      (flexnoc_fpga_axi_m0_aw_ready_sig  ),
    .flexnoc_axi_m0_aw_size       (config_ss_axi_m0_aw_size          ),
    .flexnoc_axi_m0_aw_valid      (config_ss_axi_m0_aw_valid         ),
    .flexnoc_axi_m0_b_id          (flexnoc_fpga_axi_m0_b_id_sig      ),
    .flexnoc_axi_m0_b_ready       (config_ss_axi_m0_b_ready          ),
    .flexnoc_axi_m0_b_resp        (flexnoc_fpga_axi_m0_b_resp_sig    ),
    .flexnoc_axi_m0_b_valid       (flexnoc_fpga_axi_m0_b_valid_sig   ),
    .flexnoc_axi_m0_r_data        (flexnoc_fpga_axi_m0_r_data_sig    ),
    .flexnoc_axi_m0_r_id          (flexnoc_fpga_axi_m0_r_id_sig      ),
    .flexnoc_axi_m0_r_last        (flexnoc_fpga_axi_m0_r_last_sig    ),
    .flexnoc_axi_m0_r_ready       (config_ss_axi_m0_r_ready          ),
    .flexnoc_axi_m0_r_resp        (flexnoc_fpga_axi_m0_r_resp_sig    ),
    .flexnoc_axi_m0_r_valid       (flexnoc_fpga_axi_m0_r_valid_sig   ),
    .flexnoc_axi_m0_w_data        (config_ss_axi_m0_w_data           ),
    .flexnoc_axi_m0_w_last        (config_ss_axi_m0_w_last           ),
    .flexnoc_axi_m0_w_ready       (flexnoc_fpga_axi_m0_w_ready_sig   ),
    .flexnoc_axi_m0_w_strb        (config_ss_axi_m0_w_strb           ),
    .flexnoc_axi_m0_w_valid       (config_ss_axi_m0_w_valid          ),
    .flexnoc_axi_m1_ar_addr       (config_ss_axi_m1_ar_addr          ),
    .flexnoc_axi_m1_ar_burst      (config_ss_axi_m1_ar_burst         ),
    .flexnoc_axi_m1_ar_cache      (config_ss_axi_m1_ar_cache         ),
    .flexnoc_axi_m1_ar_id         (config_ss_axi_m1_ar_id            ),
    .flexnoc_axi_m1_ar_len        (config_ss_axi_m1_ar_len           ),
    .flexnoc_axi_m1_ar_lock       (config_ss_axi_m1_ar_lock          ),
    .flexnoc_axi_m1_ar_prot       (config_ss_axi_m1_ar_prot          ),
    .flexnoc_axi_m1_ar_ready      (flexnoc_fpga_axi_m1_ar_ready_sig  ),
    .flexnoc_axi_m1_ar_size       (config_ss_axi_m1_ar_size          ),
    .flexnoc_axi_m1_ar_valid      (config_ss_axi_m1_ar_valid         ),
    .flexnoc_axi_m1_aw_addr       (config_ss_axi_m1_aw_addr          ),
    .flexnoc_axi_m1_aw_burst      (config_ss_axi_m1_aw_burst         ),
    .flexnoc_axi_m1_aw_cache      (config_ss_axi_m1_aw_cache         ),
    .flexnoc_axi_m1_aw_id         (config_ss_axi_m1_aw_id            ),
    .flexnoc_axi_m1_aw_len        (config_ss_axi_m1_aw_len           ),
    .flexnoc_axi_m1_aw_lock       (config_ss_axi_m1_aw_lock          ),
    .flexnoc_axi_m1_aw_prot       (config_ss_axi_m1_aw_prot          ),
    .flexnoc_axi_m1_aw_ready      (flexnoc_fpga_axi_m1_aw_ready_sig  ),
    .flexnoc_axi_m1_aw_size       (config_ss_axi_m1_aw_size          ),
    .flexnoc_axi_m1_aw_valid      (config_ss_axi_m1_aw_valid         ),
    .flexnoc_axi_m1_b_id          (flexnoc_fpga_axi_m1_b_id_sig      ),
    .flexnoc_axi_m1_b_ready       (config_ss_axi_m1_b_ready          ),
    .flexnoc_axi_m1_b_resp        (flexnoc_fpga_axi_m1_b_resp_sig    ),
    .flexnoc_axi_m1_b_valid       (flexnoc_fpga_axi_m1_b_valid_sig   ),
    .flexnoc_axi_m1_r_data        (flexnoc_fpga_axi_m1_r_data_sig    ),
    .flexnoc_axi_m1_r_id          (flexnoc_fpga_axi_m1_r_id_sig      ),
    .flexnoc_axi_m1_r_last        (flexnoc_fpga_axi_m1_r_last_sig    ),
    .flexnoc_axi_m1_r_ready       (config_ss_axi_m1_r_ready          ),
    .flexnoc_axi_m1_r_resp        (flexnoc_fpga_axi_m1_r_resp_sig    ),
    .flexnoc_axi_m1_r_valid       (flexnoc_fpga_axi_m1_r_valid_sig   ),
    .flexnoc_axi_m1_w_data        (config_ss_axi_m1_w_data           ),
    .flexnoc_axi_m1_w_last        (config_ss_axi_m1_w_last           ),
    .flexnoc_axi_m1_w_ready       (flexnoc_fpga_axi_m1_w_ready_sig   ),
    .flexnoc_axi_m1_w_strb        (config_ss_axi_m1_w_strb           ),
    .flexnoc_axi_m1_w_valid       (config_ss_axi_m1_w_valid          ),
    .flexnoc_fcb_s0_paddr         (flexnoc_FCB_apb_s0_paddr_sig      ),
    .flexnoc_fcb_s0_psel          (flexnoc_FCB_apb_s0_psel_sig       ),
    .flexnoc_fcb_s0_penable       (flexnoc_FCB_apb_s0_penable_sig    ),
    .flexnoc_fcb_s0_pwrite        (flexnoc_FCB_apb_s0_pwrite_sig     ),
    .flexnoc_fcb_s0_pwdata        (flexnoc_FCB_apb_s0_pwdata_sig     ),
    .flexnoc_fcb_s0_prdata        (config_ss_fcb_s0_prdata_sig       ),
    .flexnoc_fcb_s0_pready        (config_ss_fcb_s0_pready_sig       ),
    .clk_fpga_ref1                (clk_fpga_ref1                     ),
    .clk_fpga_ref2                (clk_fpga_ref2                     ),
    .clk_fpga_ref3                (clk_fpga_ref3                     ),
    .clk_fpga_ref4                (clk_fpga_ref4                     )
);



memss #(
      .ADDR_WIDTH  (32),
      .SRAM_DWIDTH (32),
      .DDR_DWIDTH  (128),
      .SRAM_SWIDTH (4),
      .DDR_SWIDTH  (16) 
      ) 
memory_ss (
      .ddr_sys_clk(        config_ss_clk_ddr_ctl_sig        ),
      .ddr_phy_clk(        config_ss_clk_ddr_phy_sig        ),
      .ddr_sys_resetn(     config_ss_rst_n_ddr_sig          ),
      .sram_sys_clk(       config_ss_clk_acpu_sig           ),
      .sram_sys_resetn(    config_ss_rst_n_sram_sig         ),
      .ddr0_aclk(          config_ss_clk_acpu_sig           ),
      .ddr1_aclk(          config_ss_clk_acpu_sig           ),
      .ddr2_aclk(          config_ss_clk_acpu_sig           ),
      .ddr3_aclk(          config_ss_clk_acpu_sig           ),
      .sramb0_aclk(        config_ss_clk_acpu_sig           ),
      .sramb1_aclk(        config_ss_clk_acpu_sig           ),
      .sramb2_aclk(        config_ss_clk_acpu_sig           ),
      .sramb3_aclk(        config_ss_clk_acpu_sig           ),
      .cntl_aclk(          config_ss_clk_ddr_cfg_sig        ),
      .ddr0_aresetn(       config_ss_rst_n_acpu_bus_sig     ),
      .ddr1_aresetn(       config_ss_rst_n_acpu_bus_sig     ),
      .ddr2_aresetn(       config_ss_rst_n_acpu_bus_sig     ),
      .ddr3_aresetn(       config_ss_rst_n_acpu_bus_sig     ),
      .sramb0_aresetn(     config_ss_rst_n_acpu_bus_sig     ),
      .sramb1_aresetn(     config_ss_rst_n_acpu_bus_sig     ),
      .sramb2_aresetn(     config_ss_rst_n_acpu_bus_sig     ),
      .sramb3_aresetn(     config_ss_rst_n_acpu_bus_sig     ),
      .cntl_aresetn(       config_ss_rst_n_133_sig          ),
      .ddr0_awvalid(       flexnoc_ddr_axi_s0_aw_valid_sig  ),
      .ddr0_awready(       memory_ss_ddr0_awready_sig       ),
      .ddr0_awaddr(        flexnoc_ddr_axi_s0_aw_addr_sig   ),
      .ddr0_awsize(        flexnoc_ddr_axi_s0_aw_size_sig   ),
      .ddr0_awburst(       flexnoc_ddr_axi_s0_aw_burst_sig  ),
      .ddr0_awcache(       flexnoc_ddr_axi_s0_aw_cache_sig  ),
      .ddr0_awprot(        flexnoc_ddr_axi_s0_aw_prot_sig   ),
      .ddr0_awlock(        flexnoc_ddr_axi_s0_aw_lock_sig   ),
      .ddr0_awqos(         4'b0000                          ),
      .ddr0_awid(          flexnoc_ddr_axi_s0_aw_id_sig     ),
      .ddr0_awlen(       { 1'b0,
                           flexnoc_ddr_axi_s0_aw_len_sig }  ),
      .ddr0_wvalid(        flexnoc_ddr_axi_s0_w_valid_sig   ),
      .ddr0_wready(        memory_ss_ddr0_wready_sig        ),
      .ddr0_wlast(         flexnoc_ddr_axi_s0_w_last_sig    ),
      .ddr0_wdata(         flexnoc_ddr_axi_s0_w_data_sig    ),
      .ddr0_wstrb(         flexnoc_ddr_axi_s0_w_strb_sig    ),
      .ddr0_bvalid(        memory_ss_ddr0_bvalid_sig        ),
      .ddr0_bready(        flexnoc_ddr_axi_s0_b_ready_sig   ),
      .ddr0_bresp(         memory_ss_ddr0_bresp_sig         ),
      .ddr0_bid(           memory_ss_ddr0_bid_sig           ),
      .ddr0_arvalid(       flexnoc_ddr_axi_s0_ar_valid_sig  ),
      .ddr0_arready(       memory_ss_ddr0_arready_sig       ),
      .ddr0_araddr(        flexnoc_ddr_axi_s0_ar_addr_sig   ),
      .ddr0_arsize(        flexnoc_ddr_axi_s0_ar_size_sig   ),
      .ddr0_arburst(       flexnoc_ddr_axi_s0_ar_burst_sig  ),
      .ddr0_arcache(       flexnoc_ddr_axi_s0_ar_cache_sig  ),
      .ddr0_arprot(        flexnoc_ddr_axi_s0_ar_prot_sig   ),
      .ddr0_arlock(        flexnoc_ddr_axi_s0_ar_lock_sig   ),
      .ddr0_arqos(         4'b0000                          ),
      .ddr0_arid(          flexnoc_ddr_axi_s0_ar_id_sig     ),
      .ddr0_arlen(       { 1'b0,
                           flexnoc_ddr_axi_s0_ar_len_sig }  ),
      .ddr0_rvalid(        memory_ss_ddr0_rvalid_sig        ),
      .ddr0_rready(        flexnoc_ddr_axi_s0_r_ready_sig   ),
      .ddr0_rlast(         memory_ss_ddr0_rlast_sig         ),
      .ddr0_rdata(         memory_ss_ddr0_rdata_sig         ),
      .ddr0_rresp(         memory_ss_ddr0_rresp_sig         ),
      .ddr0_rid(           memory_ss_ddr0_rid_sig           ),
      .ddr1_awvalid(       flexnoc_ddr_axi_s1_aw_valid_sig  ),
      .ddr1_awready(       memory_ss_ddr1_awready_sig       ),
      .ddr1_awaddr(        flexnoc_ddr_axi_s1_aw_addr_sig   ),
      .ddr1_awsize(        flexnoc_ddr_axi_s1_aw_size_sig   ),
      .ddr1_awburst(       flexnoc_ddr_axi_s1_aw_burst_sig  ),
      .ddr1_awcache(       flexnoc_ddr_axi_s1_aw_cache_sig  ),
      .ddr1_awprot(        flexnoc_ddr_axi_s1_aw_prot_sig   ),
      .ddr1_awlock(        flexnoc_ddr_axi_s1_aw_lock_sig   ),
      .ddr1_awqos(         4'b0000                          ),
      .ddr1_awid(          flexnoc_ddr_axi_s1_aw_id_sig     ),
      .ddr1_awlen(       { 1'b0,
                           flexnoc_ddr_axi_s1_aw_len_sig }  ),
      .ddr1_wvalid(        flexnoc_ddr_axi_s1_w_valid_sig   ),
      .ddr1_wready(        memory_ss_ddr1_wready_sig        ),
      .ddr1_wlast(         flexnoc_ddr_axi_s1_w_last_sig    ),
      .ddr1_wdata(         flexnoc_ddr_axi_s1_w_data_sig    ),
      .ddr1_wstrb(         flexnoc_ddr_axi_s1_w_strb_sig    ),
      .ddr1_bvalid(        memory_ss_ddr1_bvalid_sig        ),
      .ddr1_bready(        flexnoc_ddr_axi_s1_b_ready_sig   ),
      .ddr1_bresp(         memory_ss_ddr1_bresp_sig         ),
      .ddr1_bid(           memory_ss_ddr1_bid_sig           ),
      .ddr1_arvalid(       flexnoc_ddr_axi_s1_ar_valid_sig  ),
      .ddr1_arready(       memory_ss_ddr1_arready_sig       ),
      .ddr1_araddr(        flexnoc_ddr_axi_s1_ar_addr_sig   ),
      .ddr1_arsize(        flexnoc_ddr_axi_s1_ar_size_sig   ),
      .ddr1_arburst(       flexnoc_ddr_axi_s1_ar_burst_sig  ),
      .ddr1_arcache(       flexnoc_ddr_axi_s1_ar_cache_sig  ),
      .ddr1_arprot(        flexnoc_ddr_axi_s1_ar_prot_sig   ),
      .ddr1_arlock(        flexnoc_ddr_axi_s1_ar_lock_sig   ),
      .ddr1_arqos(         4'b0000                          ),
      .ddr1_arid(          flexnoc_ddr_axi_s1_ar_id_sig     ),
      .ddr1_arlen(       { 1'b0,
                           flexnoc_ddr_axi_s1_ar_len_sig }  ),
      .ddr1_rvalid(        memory_ss_ddr1_rvalid_sig        ),
      .ddr1_rready(        flexnoc_ddr_axi_s1_r_ready_sig   ),
      .ddr1_rlast(         memory_ss_ddr1_rlast_sig         ),
      .ddr1_rdata(         memory_ss_ddr1_rdata_sig         ),
      .ddr1_rresp(         memory_ss_ddr1_rresp_sig         ),
      .ddr1_rid(           memory_ss_ddr1_rid_sig           ),
      .ddr2_awvalid(       flexnoc_ddr_axi_s2_aw_valid_sig  ),
      .ddr2_awready(       memory_ss_ddr2_awready_sig       ),
      .ddr2_awaddr(        flexnoc_ddr_axi_s2_aw_addr_sig   ),
      .ddr2_awsize(        flexnoc_ddr_axi_s2_aw_size_sig   ),
      .ddr2_awburst(       flexnoc_ddr_axi_s2_aw_burst_sig  ),
      .ddr2_awcache(       flexnoc_ddr_axi_s2_aw_cache_sig  ),
      .ddr2_awprot(        flexnoc_ddr_axi_s2_aw_prot_sig   ),
      .ddr2_awlock(        flexnoc_ddr_axi_s2_aw_lock_sig   ),
      .ddr2_awqos(         4'b0000                          ),
      .ddr2_awid(          flexnoc_ddr_axi_s2_aw_id_sig     ),
      .ddr2_awlen(       { 1'b0,
                           flexnoc_ddr_axi_s2_aw_len_sig }  ),
      .ddr2_wvalid(        flexnoc_ddr_axi_s2_w_valid_sig   ),
      .ddr2_wready(        memory_ss_ddr2_wready_sig        ),
      .ddr2_wlast(         flexnoc_ddr_axi_s2_w_last_sig    ),
      .ddr2_wdata(         flexnoc_ddr_axi_s2_w_data_sig    ),
      .ddr2_wstrb(         flexnoc_ddr_axi_s2_w_strb_sig    ),
      .ddr2_bvalid(        memory_ss_ddr2_bvalid_sig        ),
      .ddr2_bready(        flexnoc_ddr_axi_s2_b_ready_sig   ),
      .ddr2_bresp(         memory_ss_ddr2_bresp_sig         ),
      .ddr2_bid(           memory_ss_ddr2_bid_sig           ),
      .ddr2_arvalid(       flexnoc_ddr_axi_s2_ar_valid_sig  ),
      .ddr2_arready(       memory_ss_ddr2_arready_sig       ),
      .ddr2_araddr(        flexnoc_ddr_axi_s2_ar_addr_sig   ),
      .ddr2_arsize(        flexnoc_ddr_axi_s2_ar_size_sig   ),
      .ddr2_arburst(       flexnoc_ddr_axi_s2_ar_burst_sig  ),
      .ddr2_arcache(       flexnoc_ddr_axi_s2_ar_cache_sig  ),
      .ddr2_arprot(        flexnoc_ddr_axi_s2_ar_prot_sig   ),
      .ddr2_arlock(        flexnoc_ddr_axi_s2_ar_lock_sig   ),
      .ddr2_arqos(         4'b0000                          ),
      .ddr2_arid(          flexnoc_ddr_axi_s2_ar_id_sig     ),
      .ddr2_arlen(       { 1'b0,
                           flexnoc_ddr_axi_s2_ar_len_sig }  ),
      .ddr2_rvalid(        memory_ss_ddr2_rvalid_sig        ),
      .ddr2_rready(        flexnoc_ddr_axi_s2_r_ready_sig   ),
      .ddr2_rlast(         memory_ss_ddr2_rlast_sig         ),
      .ddr2_rdata(         memory_ss_ddr2_rdata_sig         ),
      .ddr2_rresp(         memory_ss_ddr2_rresp_sig         ),
      .ddr2_rid(           memory_ss_ddr2_rid_sig           ),
      .ddr3_awvalid(       flexnoc_ddr_axi_s3_aw_valid_sig  ),
      .ddr3_awready(       memory_ss_ddr3_awready_sig       ),
      .ddr3_awaddr(        flexnoc_ddr_axi_s3_aw_addr_sig   ),
      .ddr3_awsize(        flexnoc_ddr_axi_s3_aw_size_sig   ),
      .ddr3_awburst(       flexnoc_ddr_axi_s3_aw_burst_sig  ),
      .ddr3_awcache(       flexnoc_ddr_axi_s3_aw_cache_sig  ),
      .ddr3_awprot(        flexnoc_ddr_axi_s3_aw_prot_sig   ),
      .ddr3_awlock(        flexnoc_ddr_axi_s3_aw_lock_sig   ),
      .ddr3_awqos(         4'b0000                          ),
      .ddr3_awid(          flexnoc_ddr_axi_s3_aw_id_sig     ),
      .ddr3_awlen(       { 1'b0,
                           flexnoc_ddr_axi_s3_aw_len_sig }  ),
      .ddr3_wvalid(        flexnoc_ddr_axi_s3_w_valid_sig   ),
      .ddr3_wready(        memory_ss_ddr3_wready_sig        ),
      .ddr3_wlast(         flexnoc_ddr_axi_s3_w_last_sig    ),
      .ddr3_wdata(         flexnoc_ddr_axi_s3_w_data_sig    ),
      .ddr3_wstrb(         flexnoc_ddr_axi_s3_w_strb_sig    ),
      .ddr3_bvalid(        memory_ss_ddr3_bvalid_sig        ),
      .ddr3_bready(        flexnoc_ddr_axi_s3_b_ready_sig   ),
      .ddr3_bresp(         memory_ss_ddr3_bresp_sig         ),
      .ddr3_bid(           memory_ss_ddr3_bid_sig           ),
      .ddr3_arvalid(       flexnoc_ddr_axi_s3_ar_valid_sig  ),
      .ddr3_arready(       memory_ss_ddr3_arready_sig       ),
      .ddr3_araddr(        flexnoc_ddr_axi_s3_ar_addr_sig   ),
      .ddr3_arsize(        flexnoc_ddr_axi_s3_ar_size_sig   ),
      .ddr3_arburst(       flexnoc_ddr_axi_s3_ar_burst_sig  ),
      .ddr3_arcache(       flexnoc_ddr_axi_s3_ar_cache_sig  ),
      .ddr3_arprot(        flexnoc_ddr_axi_s3_ar_prot_sig   ),
      .ddr3_arlock(        flexnoc_ddr_axi_s3_ar_lock_sig   ),
      .ddr3_arqos(         4'b0000                          ),
      .ddr3_arid(          flexnoc_ddr_axi_s3_ar_id_sig     ),
      .ddr3_arlen(       { 1'b0,
                           flexnoc_ddr_axi_s3_ar_len_sig }  ),
      .ddr3_rvalid(        memory_ss_ddr3_rvalid_sig        ),
      .ddr3_rready(        flexnoc_ddr_axi_s3_r_ready_sig   ),
      .ddr3_rlast(         memory_ss_ddr3_rlast_sig         ),
      .ddr3_rdata(         memory_ss_ddr3_rdata_sig         ),
      .ddr3_rresp(         memory_ss_ddr3_rresp_sig         ),
      .ddr3_rid(           memory_ss_ddr3_rid_sig           ),
      .sramb0_awvalid(     flexnoc_sram_axi_s0_aw_valid_sig ),
      .sramb0_awready(     memory_ss_sramb0_awready_sig     ),
      .sramb0_awaddr(      flexnoc_sram_axi_s0_aw_addr_sig  ),
      .sramb0_awsize(      flexnoc_sram_axi_s0_aw_size_sig  ),
      .sramb0_awburst(     flexnoc_sram_axi_s0_aw_burst_sig ),
      .sramb0_awid(        flexnoc_sram_axi_s0_aw_id_sig    ),
      .sramb0_awlen(       flexnoc_sram_axi_s0_aw_len_sig   ),
      .sramb0_wvalid(      flexnoc_sram_axi_s0_w_valid_sig  ),
      .sramb0_wready(      memory_ss_sramb0_wready_sig      ),
      .sramb0_wlast(       flexnoc_sram_axi_s0_w_last_sig   ),
      .sramb0_wdata(       flexnoc_sram_axi_s0_w_data_sig   ),
      .sramb0_wstrb(       flexnoc_sram_axi_s0_w_strb_sig   ),
      .sramb0_wid(         4'b0000                          ),
      .sramb0_bvalid(      memory_ss_sramb0_bvalid_sig      ),
      .sramb0_bready(      flexnoc_sram_axi_s0_b_ready_sig  ),
      .sramb0_bresp(       memory_ss_sramb0_bresp_sig       ),
      .sramb0_bid(         memory_ss_sramb0_bid_sig         ),
      .sramb0_arvalid(     flexnoc_sram_axi_s0_ar_valid_sig ),
      .sramb0_arready(     memory_ss_sramb0_arready_sig     ),
      .sramb0_araddr(      flexnoc_sram_axi_s0_ar_addr_sig  ),
      .sramb0_arsize(      flexnoc_sram_axi_s0_ar_size_sig  ),
      .sramb0_arburst(     flexnoc_sram_axi_s0_ar_burst_sig ),
      .sramb0_arid(        flexnoc_sram_axi_s0_ar_id_sig    ),
      .sramb0_arlen(       flexnoc_sram_axi_s0_ar_len_sig   ),
      .sramb0_rvalid(      memory_ss_sramb0_rvalid_sig      ),
      .sramb0_rready(      flexnoc_sram_axi_s0_r_ready_sig  ),
      .sramb0_rlast(       memory_ss_sramb0_rlast_sig       ),
      .sramb0_rdata(       memory_ss_sramb0_rdata_sig       ),
      .sramb0_rresp(       memory_ss_sramb0_rresp_sig       ),
      .sramb0_rid(         memory_ss_sramb0_rid_sig         ),
      .sramb1_awvalid(     flexnoc_sram_axi_s1_aw_valid_sig ),
      .sramb1_awready(     memory_ss_sramb1_awready_sig     ),
      .sramb1_awaddr(      flexnoc_sram_axi_s1_aw_addr_sig  ),
      .sramb1_awsize(      flexnoc_sram_axi_s1_aw_size_sig  ),
      .sramb1_awburst(     flexnoc_sram_axi_s1_aw_burst_sig ),
      .sramb1_awid(        flexnoc_sram_axi_s1_aw_id_sig    ),
      .sramb1_awlen(       flexnoc_sram_axi_s1_aw_len_sig   ),
      .sramb1_wvalid(      flexnoc_sram_axi_s1_w_valid_sig  ),
      .sramb1_wready(      memory_ss_sramb1_wready_sig      ),
      .sramb1_wlast(       flexnoc_sram_axi_s1_w_last_sig   ),
      .sramb1_wdata(       flexnoc_sram_axi_s1_w_data_sig   ),
      .sramb1_wstrb(       flexnoc_sram_axi_s1_w_strb_sig   ),
      .sramb1_wid(         4'b0000                          ),
      .sramb1_bvalid(      memory_ss_sramb1_bvalid_sig      ),
      .sramb1_bready(      flexnoc_sram_axi_s1_b_ready_sig  ),
      .sramb1_bresp(       memory_ss_sramb1_bresp_sig       ),
      .sramb1_bid(         memory_ss_sramb1_bid_sig         ),
      .sramb1_arvalid(     flexnoc_sram_axi_s1_ar_valid_sig ),
      .sramb1_arready(     memory_ss_sramb1_arready_sig     ),
      .sramb1_araddr(      flexnoc_sram_axi_s1_ar_addr_sig  ),
      .sramb1_arsize(      flexnoc_sram_axi_s1_ar_size_sig  ),
      .sramb1_arburst(     flexnoc_sram_axi_s1_ar_burst_sig ),
      .sramb1_arid(        flexnoc_sram_axi_s1_ar_id_sig    ),
      .sramb1_arlen(       flexnoc_sram_axi_s1_ar_len_sig   ),
      .sramb1_rvalid(      memory_ss_sramb1_rvalid_sig      ),
      .sramb1_rready(      flexnoc_sram_axi_s1_r_ready_sig  ),
      .sramb1_rlast(       memory_ss_sramb1_rlast_sig       ),
      .sramb1_rdata(       memory_ss_sramb1_rdata_sig       ),
      .sramb1_rresp(       memory_ss_sramb1_rresp_sig       ),
      .sramb1_rid(         memory_ss_sramb1_rid_sig         ),
      .sramb2_awvalid(     flexnoc_sram_axi_s2_aw_valid_sig ),
      .sramb2_awready(     memory_ss_sramb2_awready_sig     ),
      .sramb2_awaddr(      flexnoc_sram_axi_s2_aw_addr_sig  ),
      .sramb2_awsize(      flexnoc_sram_axi_s2_aw_size_sig  ),
      .sramb2_awburst(     flexnoc_sram_axi_s2_aw_burst_sig ),
      .sramb2_awid(        flexnoc_sram_axi_s2_aw_id_sig    ),
      .sramb2_awlen(       flexnoc_sram_axi_s2_aw_len_sig   ),
      .sramb2_wvalid(      flexnoc_sram_axi_s2_w_valid_sig  ),
      .sramb2_wready(      memory_ss_sramb2_wready_sig      ),
      .sramb2_wlast(       flexnoc_sram_axi_s2_w_last_sig   ),
      .sramb2_wdata(       flexnoc_sram_axi_s2_w_data_sig   ),
      .sramb2_wstrb(       flexnoc_sram_axi_s2_w_strb_sig   ),
      .sramb2_wid(         4'b0000                          ),
      .sramb2_bvalid(      memory_ss_sramb2_bvalid_sig      ),
      .sramb2_bready(      flexnoc_sram_axi_s2_b_ready_sig  ),
      .sramb2_bresp(       memory_ss_sramb2_bresp_sig       ),
      .sramb2_bid(         memory_ss_sramb2_bid_sig         ),
      .sramb2_arvalid(     flexnoc_sram_axi_s2_ar_valid_sig ),
      .sramb2_arready(     memory_ss_sramb2_arready_sig     ),
      .sramb2_araddr(      flexnoc_sram_axi_s2_ar_addr_sig  ),
      .sramb2_arsize(      flexnoc_sram_axi_s2_ar_size_sig  ),
      .sramb2_arburst(     flexnoc_sram_axi_s2_ar_burst_sig ),
      .sramb2_arid(        flexnoc_sram_axi_s2_ar_id_sig    ),
      .sramb2_arlen(       flexnoc_sram_axi_s2_ar_len_sig   ),
      .sramb2_rvalid(      memory_ss_sramb2_rvalid_sig      ),
      .sramb2_rready(      flexnoc_sram_axi_s2_r_ready_sig  ),
      .sramb2_rlast(       memory_ss_sramb2_rlast_sig       ),
      .sramb2_rdata(       memory_ss_sramb2_rdata_sig       ),
      .sramb2_rresp(       memory_ss_sramb2_rresp_sig       ),
      .sramb2_rid(         memory_ss_sramb2_rid_sig         ),
      .sramb3_awvalid(     flexnoc_sram_axi_s3_aw_valid_sig ),
      .sramb3_awready(     memory_ss_sramb3_awready_sig     ),
      .sramb3_awaddr(      flexnoc_sram_axi_s3_aw_addr_sig  ),
      .sramb3_awsize(      flexnoc_sram_axi_s3_aw_size_sig  ),
      .sramb3_awburst(     flexnoc_sram_axi_s3_aw_burst_sig ),
      .sramb3_awid(        flexnoc_sram_axi_s3_aw_id_sig    ),
      .sramb3_awlen(       flexnoc_sram_axi_s3_aw_len_sig   ),
      .sramb3_wvalid(      flexnoc_sram_axi_s3_w_valid_sig  ),
      .sramb3_wready(      memory_ss_sramb3_wready_sig      ),
      .sramb3_wlast(       flexnoc_sram_axi_s3_w_last_sig   ),
      .sramb3_wdata(       flexnoc_sram_axi_s3_w_data_sig   ),
      .sramb3_wstrb(       flexnoc_sram_axi_s3_w_strb_sig   ),
      .sramb3_wid(         4'b0000                          ),
      .sramb3_bvalid(      memory_ss_sramb3_bvalid_sig      ),
      .sramb3_bready(      flexnoc_sram_axi_s3_b_ready_sig  ),
      .sramb3_bresp(       memory_ss_sramb3_bresp_sig       ),
      .sramb3_bid(         memory_ss_sramb3_bid_sig         ),
      .sramb3_arvalid(     flexnoc_sram_axi_s3_ar_valid_sig ),
      .sramb3_arready(     memory_ss_sramb3_arready_sig     ),
      .sramb3_araddr(      flexnoc_sram_axi_s3_ar_addr_sig  ),
      .sramb3_arsize(      flexnoc_sram_axi_s3_ar_size_sig  ),
      .sramb3_arburst(     flexnoc_sram_axi_s3_ar_burst_sig ),
      .sramb3_arid(        flexnoc_sram_axi_s3_ar_id_sig    ),
      .sramb3_arlen(       flexnoc_sram_axi_s3_ar_len_sig   ),
      .sramb3_rvalid(      memory_ss_sramb3_rvalid_sig      ),
      .sramb3_rready(      flexnoc_sram_axi_s3_r_ready_sig  ),
      .sramb3_rlast(       memory_ss_sramb3_rlast_sig       ),
      .sramb3_rdata(       memory_ss_sramb3_rdata_sig       ),
      .sramb3_rresp(       memory_ss_sramb3_rresp_sig       ),
      .sramb3_rid(         memory_ss_sramb3_rid_sig         ),
      .cntl_arready(       memory_ss_cntl_arready_sig       ),
      .cntl_awready(       memory_ss_cntl_awready_sig       ),
      .cntl_bresp(         memory_ss_cntl_bresp_sig         ),
      .cntl_bvalid(        memory_ss_cntl_bvalid_sig        ),
      .cntl_rdata(         memory_ss_cntl_rdata_sig         ),
      .cntl_rresp(         memory_ss_cntl_rresp_sig         ),
      .cntl_rvalid(        memory_ss_cntl_rvalid_sig        ),
      .cntl_wready(        memory_ss_cntl_wready_sig        ),
      .cntl_araddr(        flexnoc_ddr_axil_s0_ar_addr_sig  ),
      .cntl_arvalid(       flexnoc_ddr_axil_s0_ar_valid_sig ),
      .cntl_awaddr(        flexnoc_ddr_axil_s0_aw_addr_sig  ),
      .cntl_awvalid(       flexnoc_ddr_axil_s0_aw_valid_sig ),
      .cntl_bready(        flexnoc_ddr_axil_s0_b_ready_sig  ),
      .cntl_rready(        flexnoc_ddr_axil_s0_r_ready_sig  ),
      .cntl_wdata(         flexnoc_ddr_axil_s0_w_data_sig   ),
      .cntl_wvalid(        flexnoc_ddr_axil_s0_w_valid_sig  ),
      .int_gc_fsm(         memory_ss_int_gc_fsm_sig         ),
      .DTI_EXT_VREF(       dti_ext_vref                     ),
      .PAD_MEM_CTL(        pad_mem_ctl                      ),
      .PAD_MEM_CLK(        pad_mem_clk                      ),
      .PAD_MEM_CLK_N(      pad_mem_clk_n                    ),
      .PAD_MEM_DM(         pad_mem_dm                       ),
      .PAD_MEM_DQ(         pad_mem_dq                       ),
      .PAD_MEM_DQS(        pad_mem_dqs                      ),
      .PAD_MEM_DQS_N(      pad_mem_dqs_n                    ),
      .CLOCKDR_CTL(        clockdr_ctl                      ),
      .CLOCKDR_CLK(        clockdr_clk                      ),
      .CLOCKDR_DM(         clockdr_dm                       ),
      .CLOCKDR_DQ(         clockdr_dq                       ),
      .CLOCKDR_DQS(        clockdr_dqs                      ),
      .JTAG_SI_CTL(        jtag_si_ctl                      ),
      .JTAG_SI_CLK(        jtag_si_clk                      ),
      .JTAG_SI_DM(         jtag_si_dm                       ),
      .JTAG_SI_DQ(         jtag_si_dq                       ),
      .JTAG_SI_DQS(        jtag_si_dqs                      ),
      .JTAG_SO_CTL(        jtag_so_ctl                      ),
      .JTAG_SO_CLK(        jtag_so_clk                      ),
      .JTAG_SO_DM(         jtag_so_dm                       ),
      .JTAG_SO_DQ(         jtag_so_dq                       ),
      .JTAG_SO_DQS(        jtag_so_dqs                      ),
      .MODE_CTL(           mode_ctl                         ),
      .MODE_CLK(           mode_clk                         ),
      .MODE_DM(            mode_dm                          ),
      .MODE_DQ(            mode_dq                          ),
      .MODE_DQS(           mode_dqs                         ),
      .MODE_I_DM(          mode_i_dm                        ),
      .MODE_I_DQ(          mode_i_dq                        ),
      .MODE_I_DQS(         mode_i_dqs                       ),
      .PAD_REF(            pad_ref                          ),
      .SE(                 se                               ),
      .SE_CK(              se_ck                            ),
      .SHIFTDR_CTL(        shiftdr_ctl                      ),
      .SHIFTDR_CLK(        shiftdr_clk                      ),
      .SHIFTDR_DM(         shiftdr_dm                       ),
      .SHIFTDR_DQ(         shiftdr_dq                       ),
      .SHIFTDR_DQS(        shiftdr_dqs                      ),
      .SI_CLK(             si_clk                           ),
      .SI_CTL(             si_ctl                           ),
      .SI_DM(              si_dm                            ),
      .SI_DQ(              si_dq                            ),
      .SI_RD(              si_rd                            ),
      .SI_WR(              si_wr                            ),
      .SO_CLK(             so_clk                           ),
      .SO_CTL(             so_ctl                           ),
      .SO_DM(              so_dm                            ),
      .SO_DQ(              so_dq                            ),
      .SO_RD(              so_rd                            ),
      .SO_WR(              so_wr                            ),
      .T_CGCTL_CTL(        t_cgctl_ctl                      ),
      .T_CGCTL_DQ(         t_cgctl_dq                       ),
      .T_RCTL_CTL(         t_rctl_ctl                       ),
      .T_RCTL_DQ(          t_rctl_dq                        ),
      .VDD(                vdd                              ),
      .VDDO(               vddo                             ),
      .VSS(                vss                              ),
      .UPDATEDR_CTL(       updatedr_ctl                     ),
      .UPDATEDR_CLK(       updatedr_clk                     ),
      .UPDATEDR_DM(        updatedr_dm                      ),
      .UPDATEDR_DQ(        updatedr_dq                      ),
      .UPDATEDR_DQS(       updatedr_dqs                     ),
      .PAD_COMP(           pad_comp                         ),
      .YC_CLK(             yc_clk                           ),
      .YC_CTL(             yc_ctl                           ),
      .Y_DM(               y_dm                             ),
      .Y_DQ(               y_dq                             ),
      .Y_DQS(              y_dqs                            ),
      .PAD_VREF(           pad_vref                         )
      );


rsnoc flexnoc (
    .ACPU_WDT_PAddr       (flexnoc_ACPU_WDT_PAddr_sig        ),
    .ACPU_WDT_PEnable     (flexnoc_ACPU_WDT_PEnable_sig      ),
    .ACPU_WDT_PRData      (config_ss_acpu_wdt_s0_prdata_sig  ),
    .ACPU_WDT_PReady      (config_ss_acpu_wdt_s0_pready_sig  ),
    .ACPU_WDT_PSel        (flexnoc_ACPU_WDT_PSel_sig         ),
    .ACPU_WDT_PSlvErr     (config_ss_acpu_wdt_s0_pslverr_sig ),
    .ACPU_WDT_PWBe        (flexnoc_ACPU_WDT_PWBe_sig         ),
    .ACPU_WDT_PWData      (flexnoc_ACPU_WDT_PWData_sig       ),
    .ACPU_WDT_PWrite      (flexnoc_ACPU_WDT_PWrite_sig       ),
    .BCPU_WDT_PAddr       (flexnoc_BCPU_WDT_PAddr_sig        ),
    .BCPU_WDT_PEnable     (flexnoc_BCPU_WDT_PEnable_sig      ),
    .BCPU_WDT_PRData      (config_ss_bcpu_wdt_s0_prdata_sig  ),
    .BCPU_WDT_PReady      (config_ss_bcpu_wdt_s0_pready_sig  ),
    .BCPU_WDT_PSel        (flexnoc_BCPU_WDT_PSel_sig         ),
    .BCPU_WDT_PSlvErr     (config_ss_bcpu_wdt_s0_pslverr_sig ),
    .BCPU_WDT_PWBe        (flexnoc_BCPU_WDT_PWBe_sig         ),
    .BCPU_WDT_PWData      (flexnoc_BCPU_WDT_PWData_sig       ),
    .BCPU_WDT_PWrite      (flexnoc_BCPU_WDT_PWrite_sig       ),
    .DMA_apb_s0_paddr     (flexnoc_DMA_apb_s0_paddr_sig      ),
    .DMA_apb_s0_penable   (flexnoc_DMA_apb_s0_penable_sig    ),
    .DMA_apb_s0_prdata    (config_ss_dma_s0_prdata_sig       ),
    .DMA_apb_s0_pready    (config_ss_dma_s0_pready_sig       ),
    .DMA_apb_s0_psel      (flexnoc_DMA_apb_s0_psel_sig       ),
    .DMA_apb_s0_pslverr   (config_ss_dma_s0_pslverr_sig      ),
    .DMA_apb_s0_pwbe      (flexnoc_DMA_apb_s0_pwbe_sig       ),
    .DMA_apb_s0_pwdata    (flexnoc_DMA_apb_s0_pwdata_sig     ),
    .DMA_apb_s0_pwrite    (flexnoc_DMA_apb_s0_pwrite_sig     ),
    .FCB_apb_s0_paddr     (flexnoc_FCB_apb_s0_paddr_sig      ),
    .FCB_apb_s0_penable   (flexnoc_FCB_apb_s0_penable_sig    ),
    .FCB_apb_s0_prdata    (soc_fpga_intf_fcb_s0_prdata_sig   ),
    .FCB_apb_s0_pready    (soc_fpga_intf_fcb_s0_pready_sig   ),
    .FCB_apb_s0_psel      (flexnoc_FCB_apb_s0_psel_sig       ),
    .FCB_apb_s0_pslverr   (soc_fpga_intf_fcb_s0_pslverr_sig  ),
    .FCB_apb_s0_pwbe      (flexnoc_FCB_apb_s0_pwbe_sig       ),
    .FCB_apb_s0_pwdata    (flexnoc_FCB_apb_s0_pwdata_sig     ),
    .FCB_apb_s0_pwrite    (flexnoc_FCB_apb_s0_pwrite_sig     ),
    .GPIO_apb_s0_paddr    (flexnoc_GPIO_apb_s0_paddr_sig     ),
    .GPIO_apb_s0_penable  (flexnoc_GPIO_apb_s0_penable_sig   ),
    .GPIO_apb_s0_prdata   (config_ss_gpio_s0_prdata_sig      ),
    .GPIO_apb_s0_pready   (config_ss_gpio_s0_pready_sig      ),
    .GPIO_apb_s0_psel     (flexnoc_GPIO_apb_s0_psel_sig      ),
    .GPIO_apb_s0_pslverr  (config_ss_gpio_s0_pslverr_sig     ),
    .GPIO_apb_s0_pwbe     (flexnoc_GPIO_apb_s0_pwbe_sig      ),
    .GPIO_apb_s0_pwdata   (flexnoc_GPIO_apb_s0_pwdata_sig    ),
    .GPIO_apb_s0_pwrite   (flexnoc_GPIO_apb_s0_pwrite_sig    ),
    .GPT_apb_s0_paddr     (flexnoc_GPT_apb_s0_paddr_sig      ),
    .GPT_apb_s0_penable   (flexnoc_GPT_apb_s0_penable_sig    ),
    .GPT_apb_s0_prdata    (config_ss_gpt_s0_prdata_sig       ),
    .GPT_apb_s0_pready    (config_ss_gpt_s0_pready_sig       ),
    .GPT_apb_s0_psel      (flexnoc_GPT_apb_s0_psel_sig       ),
    .GPT_apb_s0_pslverr   (config_ss_gpt_s0_pslverr_sig      ),
    .GPT_apb_s0_pwbe      (flexnoc_GPT_apb_s0_pwbe_sig       ),
    .GPT_apb_s0_pwdata    (flexnoc_GPT_apb_s0_pwdata_sig     ),
    .GPT_apb_s0_pwrite    (flexnoc_GPT_apb_s0_pwrite_sig     ),
    .I2C_apb_s0_paddr     (flexnoc_I2C_apb_s0_paddr_sig      ),
    .I2C_apb_s0_penable   (flexnoc_I2C_apb_s0_penable_sig    ),
    .I2C_apb_s0_prdata    (config_ss_i2c_s0_prdata_sig       ),
    .I2C_apb_s0_pready    (config_ss_i2c_s0_pready_sig       ),
    .I2C_apb_s0_psel      (flexnoc_I2C_apb_s0_psel_sig       ),
    .I2C_apb_s0_pslverr   (config_ss_i2c_s0_pslverr_sig      ),
    .I2C_apb_s0_pwbe      (flexnoc_I2C_apb_s0_pwbe_sig       ),
    .I2C_apb_s0_pwdata    (flexnoc_I2C_apb_s0_pwdata_sig     ),
    .I2C_apb_s0_pwrite    (flexnoc_I2C_apb_s0_pwrite_sig     ),
    .MBOX_apb_s0_paddr    (flexnoc_MBOX_apb_s0_paddr_sig     ),
    .MBOX_apb_s0_penable  (flexnoc_MBOX_apb_s0_penable_sig   ),
    .MBOX_apb_s0_prdata   (config_ss_mbox_s0_prdata_sig      ),
    .MBOX_apb_s0_pready   (config_ss_mbox_s0_pready_sig      ),
    .MBOX_apb_s0_psel     (flexnoc_MBOX_apb_s0_psel_sig      ),
    .MBOX_apb_s0_pslverr  (config_ss_mbox_s0_pslverr_sig     ),
    .MBOX_apb_s0_pwbe     (flexnoc_MBOX_apb_s0_pwbe_sig      ),
    .MBOX_apb_s0_pwdata   (flexnoc_MBOX_apb_s0_pwdata_sig    ),
    .MBOX_apb_s0_pwrite   (flexnoc_MBOX_apb_s0_pwrite_sig    ),
    .PUFCC_apb_s0_PAddr   (flexnoc_PUFCC_apb_s0_PAddr_sig    ),
    .PUFCC_apb_s0_PEnable (flexnoc_PUFCC_apb_s0_PEnable_sig  ),
    .PUFCC_apb_s0_PProt   (flexnoc_PUFCC_apb_s0_PProt_sig    ),
    .PUFCC_apb_s0_PRData  (config_ss_pufcc_s0_prdata_sig     ),
    .PUFCC_apb_s0_PReady  (config_ss_pufcc_s0_pready_sig     ),
    .PUFCC_apb_s0_PSel    (flexnoc_PUFCC_apb_s0_PSel_sig     ),
    .PUFCC_apb_s0_PSlvErr (config_ss_pufcc_s0_pslverr_sig    ),
    .PUFCC_apb_s0_PStrb   (flexnoc_PUFCC_apb_s0_PStrb_sig    ),
    .PUFCC_apb_s0_PWData  (flexnoc_PUFCC_apb_s0_PWData_sig   ),
    .PUFCC_apb_s0_PWrite  (flexnoc_PUFCC_apb_s0_PWrite_sig   ),
    .SCU_PAddr            (flexnoc_SCU_PAddr_sig             ),
    .SCU_PEnable          (flexnoc_SCU_PEnable_sig           ),
    .SCU_PRData           (config_ss_scu_s0_prdata_sig       ),
    .SCU_PReady           (config_ss_scu_s0_pready_sig       ),
    .SCU_PSel             (flexnoc_SCU_PSel_sig              ),
    .SCU_PSlvErr          (config_ss_scu_s0_pslverr_sig      ),
    .SCU_PWBe             (flexnoc_SCU_PWBe_sig              ),
    .SCU_PWData           (flexnoc_SCU_PWData_sig            ),
    .SCU_PWrite           (flexnoc_SCU_PWrite_sig            ),
    .SPI_ahb_s0_haddr     (flexnoc_SPI_ahb_s0_haddr_sig      ),
    .SPI_ahb_s0_hburst    (flexnoc_SPI_ahb_s0_hburst_sig     ),
    .SPI_ahb_s0_hmastlock (flexnoc_SPI_ahb_s0_hmastlock_sig  ),
    .SPI_ahb_s0_hprot     (flexnoc_SPI_ahb_s0_hprot_sig      ),
    .SPI_ahb_s0_hrdata    (config_ss_spi_reg_s0_hrdata_sig   ),
    .SPI_ahb_s0_hready    (config_ss_spi_reg_s0_hready_sig   ),
    .SPI_ahb_s0_hresp     (config_ss_spi_reg_s0_hresp_sig    ),
    .SPI_ahb_s0_hsel      (flexnoc_SPI_ahb_s0_hsel_sig       ),
    .SPI_ahb_s0_hsize     (flexnoc_SPI_ahb_s0_hsize_sig      ),
    .SPI_ahb_s0_htrans    (flexnoc_SPI_ahb_s0_htrans_sig     ),
    .SPI_ahb_s0_hwbe      (flexnoc_SPI_ahb_s0_hwbe_sig       ),
    .SPI_ahb_s0_hwdata    (flexnoc_SPI_ahb_s0_hwdata_sig     ),
    .SPI_ahb_s0_hwrite    (flexnoc_SPI_ahb_s0_hwrite_sig     ),
    .SPI_mem_ahb_haddr    (flexnoc_SPI_mem_ahb_haddr_sig     ),
    .SPI_mem_ahb_hburst   (flexnoc_SPI_mem_ahb_hburst_sig    ),
    .SPI_mem_ahb_hmastlock(flexnoc_SPI_mem_ahb_hmastlock_sig ),
    .SPI_mem_ahb_hprot    (flexnoc_SPI_mem_ahb_hprot_sig     ),
    .SPI_mem_ahb_hrdata   (config_ss_spi_mem_s0_hrdata_sig   ),
    .SPI_mem_ahb_hready   (config_ss_spi_mem_s0_hready_sig   ),
    .SPI_mem_ahb_hresp    (config_ss_spi_mem_s0_hresp_sig    ),
    .SPI_mem_ahb_hsel     (flexnoc_SPI_mem_ahb_hsel_sig      ),
    .SPI_mem_ahb_hsize    (flexnoc_SPI_mem_ahb_hsize_sig     ),
    .SPI_mem_ahb_htrans   (flexnoc_SPI_mem_ahb_htrans_sig    ),
    .SPI_mem_ahb_hwbe     (flexnoc_SPI_mem_ahb_hwbe_sig      ),
    .SPI_mem_ahb_hwdata   (flexnoc_SPI_mem_ahb_hwdata_sig    ),
    .SPI_mem_ahb_hwrite   (flexnoc_SPI_mem_ahb_hwrite_sig    ),
    .UART_apb_s0_paddr    (flexnoc_UART_apb_s0_paddr_sig     ),
    .UART_apb_s0_penable  (flexnoc_UART_apb_s0_penable_sig   ),
    .UART_apb_s0_prdata   (config_ss_uart_s0_prdata_sig      ),
    .UART_apb_s0_pready   (config_ss_uart_s0_pready_sig      ),
    .UART_apb_s0_psel     (flexnoc_UART_apb_s0_psel_sig      ),
    .UART_apb_s0_pslverr  (config_ss_uart_s0_pslverr_sig     ),
    .UART_apb_s0_pwbe     (flexnoc_UART_apb_s0_pwbe_sig      ),
    .UART_apb_s0_pwdata   (flexnoc_UART_apb_s0_pwdata_sig    ),
    .UART_apb_s0_pwrite   (flexnoc_UART_apb_s0_pwrite_sig    ),
    .UART_apb_s1_paddr    (flexnoc_UART_apb_s1_paddr_sig     ),
    .UART_apb_s1_penable  (flexnoc_UART_apb_s1_penable_sig   ),
    .UART_apb_s1_prdata   (config_ss_uart_s1_prdata_sig      ),
    .UART_apb_s1_pready   (config_ss_uart_s1_pready_sig      ),
    .UART_apb_s1_psel     (flexnoc_UART_apb_s1_psel_sig      ),
    .UART_apb_s1_pslverr  (config_ss_uart_s1_pslverr_sig     ),
    .UART_apb_s1_pwbe     (flexnoc_UART_apb_s1_pwbe_sig      ),
    .UART_apb_s1_pwdata   (flexnoc_UART_apb_s1_pwdata_sig    ),
    .UART_apb_s1_pwrite   (flexnoc_UART_apb_s1_pwrite_sig    ),
    .USB_axi_s0_ar_addr   (flexnoc_USB_axi_s0_ar_addr_sig    ),
    .USB_axi_s0_ar_prot   (flexnoc_USB_axi_s0_ar_prot_sig    ),
    .USB_axi_s0_ar_ready  (config_ss_usb_s0_arready_sig      ),
    .USB_axi_s0_ar_valid  (flexnoc_USB_axi_s0_ar_valid_sig   ),
    .USB_axi_s0_aw_addr   (flexnoc_USB_axi_s0_aw_addr_sig    ),
    .USB_axi_s0_aw_prot   (flexnoc_USB_axi_s0_aw_prot_sig    ),
    .USB_axi_s0_aw_ready  (config_ss_usb_s0_awready_sig      ),
    .USB_axi_s0_aw_valid  (flexnoc_USB_axi_s0_aw_valid_sig   ),
    .USB_axi_s0_b_ready   (flexnoc_USB_axi_s0_b_ready_sig    ),
    .USB_axi_s0_b_resp    (config_ss_usb_s0_bresp_sig        ),
    .USB_axi_s0_b_valid   (config_ss_usb_s0_bvalid_sig       ),
    .USB_axi_s0_r_data    (config_ss_usb_s0_rdata_sig        ),
    .USB_axi_s0_r_ready   (flexnoc_USB_axi_s0_r_ready_sig    ),
    .USB_axi_s0_r_resp    (config_ss_usb_s0_rresp_sig        ),
    .USB_axi_s0_r_valid   (config_ss_usb_s0_rvalid_sig       ),
    .USB_axi_s0_w_data    (flexnoc_USB_axi_s0_w_data_sig     ),
    .USB_axi_s0_w_ready   (config_ss_usb_s0_wready_sig       ),
    .USB_axi_s0_w_strb    (flexnoc_USB_axi_s0_w_strb_sig     ),
    .USB_axi_s0_w_valid   (flexnoc_USB_axi_s0_w_valid_sig    ),
    .acpu_axi_m0_ar_addr  (acpu_araddr_sig                   ),
    .acpu_axi_m0_ar_burst (acpu_arburst_sig                  ),
    .acpu_axi_m0_ar_cache (acpu_arcache_sig                  ),
    .acpu_axi_m0_ar_id    (acpu_arid_sig                     ),
    .acpu_axi_m0_ar_len   (acpu_arlen_sig[2:0]               ),
    .acpu_axi_m0_ar_lock  (acpu_arlock_sig                   ),
    .acpu_axi_m0_ar_prot  (acpu_arprot_sig                   ),
    .acpu_axi_m0_ar_ready (flexnoc_acpu_axi_m0_ar_ready_sig  ),
    .acpu_axi_m0_ar_size  (acpu_arsize_sig                   ),
    .acpu_axi_m0_ar_valid (acpu_arvalid_sig                  ),
    .acpu_axi_m0_aw_addr  (acpu_awaddr_sig                   ),
    .acpu_axi_m0_aw_burst (acpu_awburst_sig                  ),
    .acpu_axi_m0_aw_cache (acpu_awcache_sig                  ),
    .acpu_axi_m0_aw_id    (acpu_awid_sig                     ),
    .acpu_axi_m0_aw_len   (acpu_awlen_sig[2:0]               ),
    .acpu_axi_m0_aw_lock  (acpu_awlock_sig                   ),
    .acpu_axi_m0_aw_prot  (acpu_awprot_sig                   ),
    .acpu_axi_m0_aw_ready (flexnoc_acpu_axi_m0_aw_ready_sig  ),
    .acpu_axi_m0_aw_size  (acpu_awsize_sig                   ),
    .acpu_axi_m0_aw_valid (acpu_awvalid_sig                  ),
    .acpu_axi_m0_b_id     (flexnoc_acpu_axi_m0_b_id_sig      ),
    .acpu_axi_m0_b_ready  (acpu_bready_sig                   ),
    .acpu_axi_m0_b_resp   (flexnoc_acpu_axi_m0_b_resp_sig    ),
    .acpu_axi_m0_b_valid  (flexnoc_acpu_axi_m0_b_valid_sig   ),
    .acpu_axi_m0_r_data   (flexnoc_acpu_axi_m0_r_data_sig    ),
    .acpu_axi_m0_r_id     (flexnoc_acpu_axi_m0_r_id_sig      ),
    .acpu_axi_m0_r_last   (flexnoc_acpu_axi_m0_r_last_sig    ),
    .acpu_axi_m0_r_ready  (acpu_rready_sig                   ),
    .acpu_axi_m0_r_resp   (flexnoc_acpu_axi_m0_r_resp_sig    ),
    .acpu_axi_m0_r_valid  (flexnoc_acpu_axi_m0_r_valid_sig   ),
    .acpu_axi_m0_w_data   (acpu_wdata_sig                    ),
    .acpu_axi_m0_w_last   (acpu_wlast_sig                    ),
    .acpu_axi_m0_w_ready  (flexnoc_acpu_axi_m0_w_ready_sig   ),
    .acpu_axi_m0_w_strb   (acpu_wstrb_sig                    ),
    .acpu_axi_m0_w_valid  (acpu_wvalid_sig                   ),
    .arm_axi_m0_ar_addr   (32'h0                             ),
    .arm_axi_m0_ar_burst  (2'h0                              ),
    .arm_axi_m0_ar_cache  (4'h0                              ),
    .arm_axi_m0_ar_id     (4'h0                              ),
    .arm_axi_m0_ar_len    (3'h0                              ),
    .arm_axi_m0_ar_lock   (1'h0                              ),
    .arm_axi_m0_ar_prot   (3'h0                              ),
    .arm_axi_m0_ar_ready  (                                  ),
    .arm_axi_m0_ar_size   (3'h0                              ),
    .arm_axi_m0_ar_valid  (1'h0                              ),
    .arm_axi_m0_aw_addr   (32'h0                             ),
    .arm_axi_m0_aw_burst  (2'h0                              ),
    .arm_axi_m0_aw_cache  (4'h0                              ),
    .arm_axi_m0_aw_id     (4'h0                              ),
    .arm_axi_m0_aw_len    (3'h0                              ),
    .arm_axi_m0_aw_lock   (1'h0                              ),
    .arm_axi_m0_aw_prot   (3'h0                              ),
    .arm_axi_m0_aw_ready  (                                  ),
    .arm_axi_m0_aw_size   (3'h0                              ),
    .arm_axi_m0_aw_valid  (1'h0                              ),
    .arm_axi_m0_b_id      (                                  ),
    .arm_axi_m0_b_ready   (1'h0                              ),
    .arm_axi_m0_b_resp    (                                  ),
    .arm_axi_m0_b_valid   (                                  ),
    .arm_axi_m0_r_data    (                                  ),
    .arm_axi_m0_r_id      (                                  ),
    .arm_axi_m0_r_last    (                                  ),
    .arm_axi_m0_r_ready   (1'h0                              ),
    .arm_axi_m0_r_resp    (                                  ),
    .arm_axi_m0_r_valid   (                                  ),
    .arm_axi_m0_w_data    (64'h0                             ),
    .arm_axi_m0_w_last    (1'h0                              ),
    .arm_axi_m0_w_ready   (                                  ),
    .arm_axi_m0_w_strb    (8'h0                              ),
    .arm_axi_m0_w_valid   (1'h0                              ),
    .bcpu_ahb_m0_haddr    (config_ss_bcpu_m0_haddr_sig       ),
    .bcpu_ahb_m0_hburst   (config_ss_bcpu_m0_hburst_sig      ),
    .bcpu_ahb_m0_hmastlock(1'b0                              ),
    .bcpu_ahb_m0_hprot    (config_ss_bcpu_m0_hprot_sig       ),
    .bcpu_ahb_m0_hrdata   (flexnoc_bcpu_ahb_m0_hrdata_sig    ),
    .bcpu_ahb_m0_hready   (flexnoc_bcpu_ahb_m0_hready_sig    ),
    .bcpu_ahb_m0_hresp    (flexnoc_bcpu_ahb_m0_hresp_sig     ),
    .bcpu_ahb_m0_hsel     (config_ss_bcpu_m0_hsel_sig        ),
    .bcpu_ahb_m0_hsize    (config_ss_bcpu_m0_hsize_sig       ),
    .bcpu_ahb_m0_htrans   (config_ss_bcpu_m0_htrans_sig      ),
    .bcpu_ahb_m0_hwbe     (4'b1111                           ),
    .bcpu_ahb_m0_hwdata   (config_ss_bcpu_m0_hwdata_sig      ),
    .bcpu_ahb_m0_hwrite   (config_ss_bcpu_m0_hwrite_sig      ),
    .clk_133              (config_ss_clk_apb_ug_sig          ),
    .clk_266              (config_ss_clk_bcpu_sig            ),
    .clk_533              (config_ss_clk_acpu_sig            ),
    .cpu_observer_AFReady (afready                           ), //
    .cpu_observer_AFValid (afvalid                           ),
    .cpu_observer_ATBytes (atbytes                           ),
    .cpu_observer_ATData  (atdata                            ),
    .cpu_observer_ATId    (atid[6:0]                         ),
    .cpu_observer_ATReady (atready                           ),
    .cpu_observer_ATValid (atvalid                           ), ////
    .ddr_axi_s0_ar_addr   (flexnoc_ddr_axi_s0_ar_addr_sig    ),
    .ddr_axi_s0_ar_burst  (flexnoc_ddr_axi_s0_ar_burst_sig   ),
    .ddr_axi_s0_ar_cache  (flexnoc_ddr_axi_s0_ar_cache_sig   ),
    .ddr_axi_s0_ar_id     (flexnoc_ddr_axi_s0_ar_id_sig      ),
    .ddr_axi_s0_ar_len    (flexnoc_ddr_axi_s0_ar_len_sig     ),
    .ddr_axi_s0_ar_lock   (flexnoc_ddr_axi_s0_ar_lock_sig    ),
    .ddr_axi_s0_ar_prot   (flexnoc_ddr_axi_s0_ar_prot_sig    ),
    .ddr_axi_s0_ar_ready  (memory_ss_ddr0_arready_sig        ),
    .ddr_axi_s0_ar_size   (flexnoc_ddr_axi_s0_ar_size_sig    ),
    .ddr_axi_s0_ar_valid  (flexnoc_ddr_axi_s0_ar_valid_sig   ),
    .ddr_axi_s0_aw_addr   (flexnoc_ddr_axi_s0_aw_addr_sig    ),
    .ddr_axi_s0_aw_burst  (flexnoc_ddr_axi_s0_aw_burst_sig   ),
    .ddr_axi_s0_aw_cache  (flexnoc_ddr_axi_s0_aw_cache_sig   ),
    .ddr_axi_s0_aw_id     (flexnoc_ddr_axi_s0_aw_id_sig      ),
    .ddr_axi_s0_aw_len    (flexnoc_ddr_axi_s0_aw_len_sig     ),
    .ddr_axi_s0_aw_lock   (flexnoc_ddr_axi_s0_aw_lock_sig    ),
    .ddr_axi_s0_aw_prot   (flexnoc_ddr_axi_s0_aw_prot_sig    ),
    .ddr_axi_s0_aw_ready  (memory_ss_ddr0_awready_sig        ),
    .ddr_axi_s0_aw_size   (flexnoc_ddr_axi_s0_aw_size_sig    ),
    .ddr_axi_s0_aw_valid  (flexnoc_ddr_axi_s0_aw_valid_sig   ),
    .ddr_axi_s0_b_id      (memory_ss_ddr0_bid_sig            ),
    .ddr_axi_s0_b_ready   (flexnoc_ddr_axi_s0_b_ready_sig    ),
    .ddr_axi_s0_b_resp    (memory_ss_ddr0_bresp_sig          ),
    .ddr_axi_s0_b_valid   (memory_ss_ddr0_bvalid_sig         ),
    .ddr_axi_s0_r_data    (memory_ss_ddr0_rdata_sig          ),
    .ddr_axi_s0_r_id      (memory_ss_ddr0_rid_sig            ),
    .ddr_axi_s0_r_last    (memory_ss_ddr0_rlast_sig          ),
    .ddr_axi_s0_r_ready   (flexnoc_ddr_axi_s0_r_ready_sig    ),
    .ddr_axi_s0_r_resp    (memory_ss_ddr0_rresp_sig          ),
    .ddr_axi_s0_r_valid   (memory_ss_ddr0_rvalid_sig         ),
    .ddr_axi_s0_w_data    (flexnoc_ddr_axi_s0_w_data_sig     ),
    .ddr_axi_s0_w_last    (flexnoc_ddr_axi_s0_w_last_sig     ),
    .ddr_axi_s0_w_ready   (memory_ss_ddr0_wready_sig         ),
    .ddr_axi_s0_w_strb    (flexnoc_ddr_axi_s0_w_strb_sig     ),
    .ddr_axi_s0_w_valid   (flexnoc_ddr_axi_s0_w_valid_sig    ),
    .ddr_axi_s1_ar_addr   (flexnoc_ddr_axi_s1_ar_addr_sig    ),
    .ddr_axi_s1_ar_burst  (flexnoc_ddr_axi_s1_ar_burst_sig   ),
    .ddr_axi_s1_ar_cache  (flexnoc_ddr_axi_s1_ar_cache_sig   ),
    .ddr_axi_s1_ar_id     (flexnoc_ddr_axi_s1_ar_id_sig      ),
    .ddr_axi_s1_ar_len    (flexnoc_ddr_axi_s1_ar_len_sig     ),
    .ddr_axi_s1_ar_lock   (flexnoc_ddr_axi_s1_ar_lock_sig    ),
    .ddr_axi_s1_ar_prot   (flexnoc_ddr_axi_s1_ar_prot_sig    ),
    .ddr_axi_s1_ar_ready  (memory_ss_ddr1_arready_sig        ),
    .ddr_axi_s1_ar_size   (flexnoc_ddr_axi_s1_ar_size_sig    ),
    .ddr_axi_s1_ar_valid  (flexnoc_ddr_axi_s1_ar_valid_sig   ),
    .ddr_axi_s1_aw_addr   (flexnoc_ddr_axi_s1_aw_addr_sig    ),
    .ddr_axi_s1_aw_burst  (flexnoc_ddr_axi_s1_aw_burst_sig   ),
    .ddr_axi_s1_aw_cache  (flexnoc_ddr_axi_s1_aw_cache_sig   ),
    .ddr_axi_s1_aw_id     (flexnoc_ddr_axi_s1_aw_id_sig      ),
    .ddr_axi_s1_aw_len    (flexnoc_ddr_axi_s1_aw_len_sig     ),
    .ddr_axi_s1_aw_lock   (flexnoc_ddr_axi_s1_aw_lock_sig    ),
    .ddr_axi_s1_aw_prot   (flexnoc_ddr_axi_s1_aw_prot_sig    ),
    .ddr_axi_s1_aw_ready  (memory_ss_ddr1_awready_sig        ),
    .ddr_axi_s1_aw_size   (flexnoc_ddr_axi_s1_aw_size_sig    ),
    .ddr_axi_s1_aw_valid  (flexnoc_ddr_axi_s1_aw_valid_sig   ),
    .ddr_axi_s1_b_id      (memory_ss_ddr1_bid_sig            ),
    .ddr_axi_s1_b_ready   (flexnoc_ddr_axi_s1_b_ready_sig    ),
    .ddr_axi_s1_b_resp    (memory_ss_ddr1_bresp_sig          ),
    .ddr_axi_s1_b_valid   (memory_ss_ddr1_bvalid_sig         ),
    .ddr_axi_s1_r_data    (memory_ss_ddr1_rdata_sig          ),
    .ddr_axi_s1_r_id      (memory_ss_ddr1_rid_sig            ),
    .ddr_axi_s1_r_last    (memory_ss_ddr1_rlast_sig          ),
    .ddr_axi_s1_r_ready   (flexnoc_ddr_axi_s1_r_ready_sig    ),
    .ddr_axi_s1_r_resp    (memory_ss_ddr1_rresp_sig          ),
    .ddr_axi_s1_r_valid   (memory_ss_ddr1_rvalid_sig         ),
    .ddr_axi_s1_w_data    (flexnoc_ddr_axi_s1_w_data_sig     ),
    .ddr_axi_s1_w_last    (flexnoc_ddr_axi_s1_w_last_sig     ),
    .ddr_axi_s1_w_ready   (memory_ss_ddr1_wready_sig         ),
    .ddr_axi_s1_w_strb    (flexnoc_ddr_axi_s1_w_strb_sig     ),
    .ddr_axi_s1_w_valid   (flexnoc_ddr_axi_s1_w_valid_sig    ),
    .ddr_axi_s2_ar_addr   (flexnoc_ddr_axi_s2_ar_addr_sig    ),
    .ddr_axi_s2_ar_burst  (flexnoc_ddr_axi_s2_ar_burst_sig   ),
    .ddr_axi_s2_ar_cache  (flexnoc_ddr_axi_s2_ar_cache_sig   ),
    .ddr_axi_s2_ar_id     (flexnoc_ddr_axi_s2_ar_id_sig      ),
    .ddr_axi_s2_ar_len    (flexnoc_ddr_axi_s2_ar_len_sig     ),
    .ddr_axi_s2_ar_lock   (flexnoc_ddr_axi_s2_ar_lock_sig    ),
    .ddr_axi_s2_ar_prot   (flexnoc_ddr_axi_s2_ar_prot_sig    ),
    .ddr_axi_s2_ar_ready  (memory_ss_ddr2_arready_sig        ),
    .ddr_axi_s2_ar_size   (flexnoc_ddr_axi_s2_ar_size_sig    ),
    .ddr_axi_s2_ar_valid  (flexnoc_ddr_axi_s2_ar_valid_sig   ),
    .ddr_axi_s2_aw_addr   (flexnoc_ddr_axi_s2_aw_addr_sig    ),
    .ddr_axi_s2_aw_burst  (flexnoc_ddr_axi_s2_aw_burst_sig   ),
    .ddr_axi_s2_aw_cache  (flexnoc_ddr_axi_s2_aw_cache_sig   ),
    .ddr_axi_s2_aw_id     (flexnoc_ddr_axi_s2_aw_id_sig      ),
    .ddr_axi_s2_aw_len    (flexnoc_ddr_axi_s2_aw_len_sig     ),
    .ddr_axi_s2_aw_lock   (flexnoc_ddr_axi_s2_aw_lock_sig    ),
    .ddr_axi_s2_aw_prot   (flexnoc_ddr_axi_s2_aw_prot_sig    ),
    .ddr_axi_s2_aw_ready  (memory_ss_ddr2_awready_sig        ),
    .ddr_axi_s2_aw_size   (flexnoc_ddr_axi_s2_aw_size_sig    ),
    .ddr_axi_s2_aw_valid  (flexnoc_ddr_axi_s2_aw_valid_sig   ),
    .ddr_axi_s2_b_id      (memory_ss_ddr2_bid_sig            ),
    .ddr_axi_s2_b_ready   (flexnoc_ddr_axi_s2_b_ready_sig    ),
    .ddr_axi_s2_b_resp    (memory_ss_ddr2_bresp_sig          ),
    .ddr_axi_s2_b_valid   (memory_ss_ddr2_bvalid_sig         ),
    .ddr_axi_s2_r_data    (memory_ss_ddr2_rdata_sig          ),
    .ddr_axi_s2_r_id      (memory_ss_ddr2_rid_sig            ),
    .ddr_axi_s2_r_last    (memory_ss_ddr2_rlast_sig          ),
    .ddr_axi_s2_r_ready   (flexnoc_ddr_axi_s2_r_ready_sig    ),
    .ddr_axi_s2_r_resp    (memory_ss_ddr2_rresp_sig          ),
    .ddr_axi_s2_r_valid   (memory_ss_ddr2_rvalid_sig         ),
    .ddr_axi_s2_w_data    (flexnoc_ddr_axi_s2_w_data_sig     ),
    .ddr_axi_s2_w_last    (flexnoc_ddr_axi_s2_w_last_sig     ),
    .ddr_axi_s2_w_ready   (memory_ss_ddr2_wready_sig         ),
    .ddr_axi_s2_w_strb    (flexnoc_ddr_axi_s2_w_strb_sig     ),
    .ddr_axi_s2_w_valid   (flexnoc_ddr_axi_s2_w_valid_sig    ),
    .ddr_axi_s3_ar_addr   (flexnoc_ddr_axi_s3_ar_addr_sig    ),
    .ddr_axi_s3_ar_burst  (flexnoc_ddr_axi_s3_ar_burst_sig   ),
    .ddr_axi_s3_ar_cache  (flexnoc_ddr_axi_s3_ar_cache_sig   ),
    .ddr_axi_s3_ar_id     (flexnoc_ddr_axi_s3_ar_id_sig      ),
    .ddr_axi_s3_ar_len    (flexnoc_ddr_axi_s3_ar_len_sig     ),
    .ddr_axi_s3_ar_lock   (flexnoc_ddr_axi_s3_ar_lock_sig    ),
    .ddr_axi_s3_ar_prot   (flexnoc_ddr_axi_s3_ar_prot_sig    ),
    .ddr_axi_s3_ar_ready  (memory_ss_ddr3_arready_sig        ),
    .ddr_axi_s3_ar_size   (flexnoc_ddr_axi_s3_ar_size_sig    ),
    .ddr_axi_s3_ar_valid  (flexnoc_ddr_axi_s3_ar_valid_sig   ),
    .ddr_axi_s3_aw_addr   (flexnoc_ddr_axi_s3_aw_addr_sig    ),
    .ddr_axi_s3_aw_burst  (flexnoc_ddr_axi_s3_aw_burst_sig   ),
    .ddr_axi_s3_aw_cache  (flexnoc_ddr_axi_s3_aw_cache_sig   ),
    .ddr_axi_s3_aw_id     (flexnoc_ddr_axi_s3_aw_id_sig      ),
    .ddr_axi_s3_aw_len    (flexnoc_ddr_axi_s3_aw_len_sig     ),
    .ddr_axi_s3_aw_lock   (flexnoc_ddr_axi_s3_aw_lock_sig    ),
    .ddr_axi_s3_aw_prot   (flexnoc_ddr_axi_s3_aw_prot_sig    ),
    .ddr_axi_s3_aw_ready  (memory_ss_ddr3_awready_sig        ),
    .ddr_axi_s3_aw_size   (flexnoc_ddr_axi_s3_aw_size_sig    ),
    .ddr_axi_s3_aw_valid  (flexnoc_ddr_axi_s3_aw_valid_sig   ),
    .ddr_axi_s3_b_id      (memory_ss_ddr3_bid_sig            ),
    .ddr_axi_s3_b_ready   (flexnoc_ddr_axi_s3_b_ready_sig    ),
    .ddr_axi_s3_b_resp    (memory_ss_ddr3_bresp_sig          ),
    .ddr_axi_s3_b_valid   (memory_ss_ddr3_bvalid_sig         ),
    .ddr_axi_s3_r_data    (memory_ss_ddr3_rdata_sig          ),
    .ddr_axi_s3_r_id      (memory_ss_ddr3_rid_sig            ),
    .ddr_axi_s3_r_last    (memory_ss_ddr3_rlast_sig          ),
    .ddr_axi_s3_r_ready   (flexnoc_ddr_axi_s3_r_ready_sig    ),
    .ddr_axi_s3_r_resp    (memory_ss_ddr3_rresp_sig          ),
    .ddr_axi_s3_r_valid   (memory_ss_ddr3_rvalid_sig         ),
    .ddr_axi_s3_w_data    (flexnoc_ddr_axi_s3_w_data_sig     ),
    .ddr_axi_s3_w_last    (flexnoc_ddr_axi_s3_w_last_sig     ),
    .ddr_axi_s3_w_ready   (memory_ss_ddr3_wready_sig         ),
    .ddr_axi_s3_w_strb    (flexnoc_ddr_axi_s3_w_strb_sig     ),
    .ddr_axi_s3_w_valid   (flexnoc_ddr_axi_s3_w_valid_sig    ),
    .ddr_axil_s0_ar_addr  (flexnoc_ddr_axil_s0_ar_addr_sig   ),
    .ddr_axil_s0_ar_prot  (flexnoc_ddr_axil_s0_ar_prot_sig   ),
    .ddr_axil_s0_ar_ready (memory_ss_cntl_arready_sig        ),
    .ddr_axil_s0_ar_valid (flexnoc_ddr_axil_s0_ar_valid_sig  ),
    .ddr_axil_s0_aw_addr  (flexnoc_ddr_axil_s0_aw_addr_sig   ),
    .ddr_axil_s0_aw_prot  (flexnoc_ddr_axil_s0_aw_prot_sig   ),
    .ddr_axil_s0_aw_ready (memory_ss_cntl_awready_sig        ),
    .ddr_axil_s0_aw_valid (flexnoc_ddr_axil_s0_aw_valid_sig  ),
    .ddr_axil_s0_b_ready  (flexnoc_ddr_axil_s0_b_ready_sig   ),
    .ddr_axil_s0_b_resp   (memory_ss_cntl_bresp_sig          ),
    .ddr_axil_s0_b_valid  (memory_ss_cntl_bvalid_sig         ),
    .ddr_axil_s0_r_data   (memory_ss_cntl_rdata_sig          ),
    .ddr_axil_s0_r_ready  (flexnoc_ddr_axil_s0_r_ready_sig   ),
    .ddr_axil_s0_r_resp   (memory_ss_cntl_rresp_sig          ),
    .ddr_axil_s0_r_valid  (memory_ss_cntl_rvalid_sig         ),
    .ddr_axil_s0_w_data   (flexnoc_ddr_axil_s0_w_data_sig    ),
    .ddr_axil_s0_w_ready  (memory_ss_cntl_wready_sig         ),
    .ddr_axil_s0_w_strb   (flexnoc_ddr_axil_s0_w_strb_sig    ),
    .ddr_axil_s0_w_valid  (flexnoc_ddr_axil_s0_w_valid_sig   ),
    .dma_axi_m0_ar_addr   (config_ss_dma_m0_araddr_sig       ),
    .dma_axi_m0_ar_burst  (config_ss_dma_m0_arburst_sig      ),
    .dma_axi_m0_ar_cache  (config_ss_dma_m0_arcache_sig      ),
    .dma_axi_m0_ar_id     ({ 1'b0,config_ss_dma_m0_arid_sig }),
    .dma_axi_m0_ar_len    (config_ss_dma_m0_arlen_sig[3:0]   ),
    .dma_axi_m0_ar_lock   (config_ss_dma_m0_arlock_sig       ),
    .dma_axi_m0_ar_prot   (config_ss_dma_m0_arprot_sig       ),
    .dma_axi_m0_ar_ready  (flexnoc_dma_axi_m0_ar_ready_sig   ),
    .dma_axi_m0_ar_size   (config_ss_dma_m0_arsize_sig       ),
    .dma_axi_m0_ar_valid  (config_ss_dma_m0_arvalid_sig      ),
    .dma_axi_m0_aw_addr   (config_ss_dma_m0_awaddr_sig       ),
    .dma_axi_m0_aw_burst  (config_ss_dma_m0_awburst_sig      ),
    .dma_axi_m0_aw_cache  (config_ss_dma_m0_awcache_sig      ),
    .dma_axi_m0_aw_id     ({ 1'b0,config_ss_dma_m0_awid_sig }),
    .dma_axi_m0_aw_len    (config_ss_dma_m0_awlen_sig[3:0]   ),
    .dma_axi_m0_aw_lock   (config_ss_dma_m0_awlock_sig       ),
    .dma_axi_m0_aw_prot   (config_ss_dma_m0_awprot_sig       ),
    .dma_axi_m0_aw_ready  (flexnoc_dma_axi_m0_aw_ready_sig   ),
    .dma_axi_m0_aw_size   (config_ss_dma_m0_awsize_sig       ),
    .dma_axi_m0_aw_valid  (config_ss_dma_m0_awvalid_sig      ),
    .dma_axi_m0_b_id      (flexnoc_dma_axi_m0_b_id_sig       ),
    .dma_axi_m0_b_ready   (config_ss_dma_m0_bready_sig       ),
    .dma_axi_m0_b_resp    (flexnoc_dma_axi_m0_b_resp_sig     ),
    .dma_axi_m0_b_valid   (flexnoc_dma_axi_m0_b_valid_sig    ),
    .dma_axi_m0_r_data    (flexnoc_dma_axi_m0_r_data_sig     ),
    .dma_axi_m0_r_id      (flexnoc_dma_axi_m0_r_id_sig       ),
    .dma_axi_m0_r_last    (flexnoc_dma_axi_m0_r_last_sig     ),
    .dma_axi_m0_r_ready   (config_ss_dma_m0_rready_sig       ),
    .dma_axi_m0_r_resp    (flexnoc_dma_axi_m0_r_resp_sig     ),
    .dma_axi_m0_r_valid   (flexnoc_dma_axi_m0_r_valid_sig    ),
    .dma_axi_m0_w_data    (config_ss_dma_m0_wdata_sig        ),
    .dma_axi_m0_w_last    (config_ss_dma_m0_wlast_sig        ),
    .dma_axi_m0_w_ready   (flexnoc_dma_axi_m0_w_ready_sig    ),
    .dma_axi_m0_w_strb    (config_ss_dma_m0_wstrb_sig        ),
    .dma_axi_m0_w_valid   (config_ss_dma_m0_wvalid_sig       ),
    .dma_axi_m1_ar_addr   (config_ss_dma_m1_araddr_sig       ),
    .dma_axi_m1_ar_burst  (config_ss_dma_m1_arburst_sig      ),
    .dma_axi_m1_ar_cache  (config_ss_dma_m1_arcache_sig      ),
    .dma_axi_m1_ar_id     ({ 1'b0,config_ss_dma_m1_arid_sig }),
    .dma_axi_m1_ar_len    (config_ss_dma_m1_arlen_sig[3:0]   ),
    .dma_axi_m1_ar_lock   (config_ss_dma_m1_arlock_sig       ),
    .dma_axi_m1_ar_prot   (config_ss_dma_m1_arprot_sig       ),
    .dma_axi_m1_ar_ready  (flexnoc_dma_axi_m1_ar_ready_sig   ),
    .dma_axi_m1_ar_size   (config_ss_dma_m1_arsize_sig       ),
    .dma_axi_m1_ar_valid  (config_ss_dma_m1_arvalid_sig      ),
    .dma_axi_m1_aw_addr   (config_ss_dma_m1_awaddr_sig       ),
    .dma_axi_m1_aw_burst  (config_ss_dma_m1_awburst_sig      ),
    .dma_axi_m1_aw_cache  (config_ss_dma_m1_awcache_sig      ),
    .dma_axi_m1_aw_id     ({ 1'b0,config_ss_dma_m1_awid_sig }),
    .dma_axi_m1_aw_len    (config_ss_dma_m1_awlen_sig[3:0]   ),
    .dma_axi_m1_aw_lock   (config_ss_dma_m1_awlock_sig       ),
    .dma_axi_m1_aw_prot   (config_ss_dma_m1_awprot_sig       ),
    .dma_axi_m1_aw_ready  (flexnoc_dma_axi_m1_aw_ready_sig   ),
    .dma_axi_m1_aw_size   (config_ss_dma_m1_awsize_sig       ),
    .dma_axi_m1_aw_valid  (config_ss_dma_m1_awvalid_sig      ),
    .dma_axi_m1_b_id      (flexnoc_dma_axi_m1_b_id_sig       ),
    .dma_axi_m1_b_ready   (config_ss_dma_m1_bready_sig       ),
    .dma_axi_m1_b_resp    (flexnoc_dma_axi_m1_b_resp_sig     ),
    .dma_axi_m1_b_valid   (flexnoc_dma_axi_m1_b_valid_sig    ),
    .dma_axi_m1_r_data    (flexnoc_dma_axi_m1_r_data_sig     ),
    .dma_axi_m1_r_id      (flexnoc_dma_axi_m1_r_id_sig       ),
    .dma_axi_m1_r_last    (flexnoc_dma_axi_m1_r_last_sig     ),
    .dma_axi_m1_r_ready   (config_ss_dma_m1_rready_sig       ),
    .dma_axi_m1_r_resp    (flexnoc_dma_axi_m1_r_resp_sig     ),
    .dma_axi_m1_r_valid   (flexnoc_dma_axi_m1_r_valid_sig    ),
    .dma_axi_m1_w_data    (config_ss_dma_m1_wdata_sig        ),
    .dma_axi_m1_w_last    (config_ss_dma_m1_wlast_sig        ),
    .dma_axi_m1_w_ready   (flexnoc_dma_axi_m1_w_ready_sig    ),
    .dma_axi_m1_w_strb    (config_ss_dma_m1_wstrb_sig        ),
    .dma_axi_m1_w_valid   (config_ss_dma_m1_wvalid_sig       ),
    .fpga_ahb_s0_haddr    (flexnoc_fpga_ahb_s0_haddr_sig     ),
    .fpga_ahb_s0_hburst   (flexnoc_fpga_ahb_s0_hburst_sig    ),
    .fpga_ahb_s0_hmastlock(flexnoc_fpga_ahb_s0_hmastlock_sig ),
    .fpga_ahb_s0_hprot    (flexnoc_fpga_ahb_s0_hprot_sig     ),
    .fpga_ahb_s0_hrdata   (config_ss_fpga_ahb_s0_hrdata      ),
    .fpga_ahb_s0_hready   (config_ss_fpga_ahb_s0_hready      ),
    .fpga_ahb_s0_hresp    (config_ss_fpga_ahb_s0_hresp       ),
    .fpga_ahb_s0_hsel     (flexnoc_fpga_ahb_s0_hsel_sig      ),
    .fpga_ahb_s0_hsize    (flexnoc_fpga_ahb_s0_hsize_sig     ),
    .fpga_ahb_s0_htrans   (flexnoc_fpga_ahb_s0_htrans_sig    ),
    .fpga_ahb_s0_hwbe     (flexnoc_fpga_ahb_s0_hwbe_sig      ),
    .fpga_ahb_s0_hwdata   (flexnoc_fpga_ahb_s0_hwdata_sig    ),
    .fpga_ahb_s0_hwrite   (flexnoc_fpga_ahb_s0_hwrite_sig    ),
    .fpga_axi_m0_ar_addr  (config_ss_axi_m0_ar_addr          ),
    .fpga_axi_m0_ar_burst (config_ss_axi_m0_ar_burst         ),
    .fpga_axi_m0_ar_cache (config_ss_axi_m0_ar_cache         ),
    .fpga_axi_m0_ar_id    (config_ss_axi_m0_ar_id            ),
    .fpga_axi_m0_ar_len   (config_ss_axi_m0_ar_len           ),
    .fpga_axi_m0_ar_lock  (config_ss_axi_m0_ar_lock          ),
    .fpga_axi_m0_ar_prot  (config_ss_axi_m0_ar_prot          ),
    .fpga_axi_m0_ar_ready (flexnoc_fpga_axi_m0_ar_ready_sig  ),
    .fpga_axi_m0_ar_size  (config_ss_axi_m0_ar_size          ),
    .fpga_axi_m0_ar_valid (config_ss_axi_m0_ar_valid         ),
    .fpga_axi_m0_aw_addr  (config_ss_axi_m0_aw_addr          ),
    .fpga_axi_m0_aw_burst (config_ss_axi_m0_aw_burst         ),
    .fpga_axi_m0_aw_cache (config_ss_axi_m0_aw_cache         ),
    .fpga_axi_m0_aw_id    (config_ss_axi_m0_aw_id            ),
    .fpga_axi_m0_aw_len   (config_ss_axi_m0_aw_len           ),
    .fpga_axi_m0_aw_lock  (config_ss_axi_m0_aw_lock          ),
    .fpga_axi_m0_aw_prot  (config_ss_axi_m0_aw_prot          ),
    .fpga_axi_m0_aw_ready (flexnoc_fpga_axi_m0_aw_ready_sig  ),
    .fpga_axi_m0_aw_size  (config_ss_axi_m0_aw_size          ),
    .fpga_axi_m0_aw_valid (config_ss_axi_m0_aw_valid         ),
    .fpga_axi_m0_b_id     (flexnoc_fpga_axi_m0_b_id_sig      ),
    .fpga_axi_m0_b_ready  (config_ss_axi_m0_b_ready          ),
    .fpga_axi_m0_b_resp   (flexnoc_fpga_axi_m0_b_resp_sig    ),
    .fpga_axi_m0_b_valid  (flexnoc_fpga_axi_m0_b_valid_sig   ),
    .fpga_axi_m0_r_data   (flexnoc_fpga_axi_m0_r_data_sig    ),
    .fpga_axi_m0_r_id     (flexnoc_fpga_axi_m0_r_id_sig      ),
    .fpga_axi_m0_r_last   (flexnoc_fpga_axi_m0_r_last_sig    ),
    .fpga_axi_m0_r_ready  (config_ss_axi_m0_r_ready          ),
    .fpga_axi_m0_r_resp   (flexnoc_fpga_axi_m0_r_resp_sig    ),
    .fpga_axi_m0_r_valid  (flexnoc_fpga_axi_m0_r_valid_sig   ),
    .fpga_axi_m0_w_data   (config_ss_axi_m0_w_data           ),
    .fpga_axi_m0_w_last   (config_ss_axi_m0_w_last           ),
    .fpga_axi_m0_w_ready  (flexnoc_fpga_axi_m0_w_ready_sig   ),
    .fpga_axi_m0_w_strb   (config_ss_axi_m0_w_strb           ),
    .fpga_axi_m0_w_valid  (config_ss_axi_m0_w_valid          ),
    .fpga_axi_m1_ar_addr  (config_ss_axi_m1_ar_addr          ),
    .fpga_axi_m1_ar_burst (config_ss_axi_m1_ar_burst         ),
    .fpga_axi_m1_ar_cache (config_ss_axi_m1_ar_cache         ),
    .fpga_axi_m1_ar_id    (config_ss_axi_m1_ar_id            ),
    .fpga_axi_m1_ar_len   (config_ss_axi_m1_ar_len           ),
    .fpga_axi_m1_ar_lock  (config_ss_axi_m1_ar_lock          ),
    .fpga_axi_m1_ar_prot  (config_ss_axi_m1_ar_prot          ),
    .fpga_axi_m1_ar_ready (flexnoc_fpga_axi_m1_ar_ready_sig  ),
    .fpga_axi_m1_ar_size  (config_ss_axi_m1_ar_size          ),
    .fpga_axi_m1_ar_valid (config_ss_axi_m1_ar_valid         ),
    .fpga_axi_m1_aw_addr  (config_ss_axi_m1_aw_addr          ),
    .fpga_axi_m1_aw_burst (config_ss_axi_m1_aw_burst         ),
    .fpga_axi_m1_aw_cache (config_ss_axi_m1_aw_cache         ),
    .fpga_axi_m1_aw_id    (config_ss_axi_m1_aw_id            ),
    .fpga_axi_m1_aw_len   (config_ss_axi_m1_aw_len           ),
    .fpga_axi_m1_aw_lock  (config_ss_axi_m1_aw_lock          ),
    .fpga_axi_m1_aw_prot  (config_ss_axi_m1_aw_prot          ),
    .fpga_axi_m1_aw_ready (flexnoc_fpga_axi_m1_aw_ready_sig  ),
    .fpga_axi_m1_aw_size  (config_ss_axi_m1_aw_size          ),
    .fpga_axi_m1_aw_valid (config_ss_axi_m1_aw_valid         ),
    .fpga_axi_m1_b_id     (flexnoc_fpga_axi_m1_b_id_sig      ),
    .fpga_axi_m1_b_ready  (config_ss_axi_m1_b_ready          ),
    .fpga_axi_m1_b_resp   (flexnoc_fpga_axi_m1_b_resp_sig    ),
    .fpga_axi_m1_b_valid  (flexnoc_fpga_axi_m1_b_valid_sig   ),
    .fpga_axi_m1_r_data   (flexnoc_fpga_axi_m1_r_data_sig    ),
    .fpga_axi_m1_r_id     (flexnoc_fpga_axi_m1_r_id_sig      ),
    .fpga_axi_m1_r_last   (flexnoc_fpga_axi_m1_r_last_sig    ),
    .fpga_axi_m1_r_ready  (config_ss_axi_m1_r_ready          ),
    .fpga_axi_m1_r_resp   (flexnoc_fpga_axi_m1_r_resp_sig    ),
    .fpga_axi_m1_r_valid  (flexnoc_fpga_axi_m1_r_valid_sig   ),
    .fpga_axi_m1_w_data   (config_ss_axi_m1_w_data           ),
    .fpga_axi_m1_w_last   (config_ss_axi_m1_w_last           ),
    .fpga_axi_m1_w_ready  (flexnoc_fpga_axi_m1_w_ready_sig   ),
    .fpga_axi_m1_w_strb   (config_ss_axi_m1_w_strb           ),
    .fpga_axi_m1_w_valid  (config_ss_axi_m1_w_valid          ),
    .fpga_clk_m0          (clk_fpga_fabric_m0                         ),
    .fpga_clk_m1          (clk_fpga_fabric_m1                         ),
    .fpga_clk_s0          (clk_fpga_fabric_s0                        ),
    .fpga_rstm0_n         (config_ss_rst_n_fpga0_sig         ),
    .fpga_rstm1_n         (config_ss_rst_n_fpga1_sig         ),
    .fpga_rsts0_n         (config_ss_rst_n_fpga_s_sig        ),
    .gbe_apb_s0_paddr     (flexnoc_gbe_apb_s0_paddr_sig      ),
    .gbe_apb_s0_penable   (flexnoc_gbe_apb_s0_penable_sig    ),
    .gbe_apb_s0_prdata    (config_ss_gbe_s0_prdata_sig       ),
    .gbe_apb_s0_pready    (1'b1                              ),
    .gbe_apb_s0_psel      (flexnoc_gbe_apb_s0_psel_sig       ),
    .gbe_apb_s0_pslverr   (config_ss_gbe_s0_pslverr_sig      ),
    .gbe_apb_s0_pwbe      (flexnoc_gbe_apb_s0_pwbe_sig       ),
    .gbe_apb_s0_pwdata    (flexnoc_gbe_apb_s0_pwdata_sig     ),
    .gbe_apb_s0_pwrite    (flexnoc_gbe_apb_s0_pwrite_sig     ),
    .gbe_axi_m0_ar_addr   (config_ss_gbe_m0_araddr_sig       ),
    .gbe_axi_m0_ar_burst  (config_ss_gbe_m0_arburst_sig      ),
    .gbe_axi_m0_ar_cache  (config_ss_gbe_m0_arcache_sig      ),
    .gbe_axi_m0_ar_id     (config_ss_gbe_m0_arid_sig         ),
    .gbe_axi_m0_ar_len    (config_ss_gbe_m0_arlen_sig[3:0]   ),
    .gbe_axi_m0_ar_lock   (config_ss_gbe_m0_arlock_sig[0]    ),
    .gbe_axi_m0_ar_prot   (config_ss_gbe_m0_arprot_sig       ),
    .gbe_axi_m0_ar_ready  (flexnoc_gbe_axi_m0_ar_ready_sig   ),
    .gbe_axi_m0_ar_size   (config_ss_gbe_m0_arsize_sig       ),
    .gbe_axi_m0_ar_valid  (config_ss_gbe_m0_arvalid_sig      ),
    .gbe_axi_m0_aw_addr   (config_ss_gbe_m0_awaddr_sig       ),
    .gbe_axi_m0_aw_burst  (config_ss_gbe_m0_awburst_sig      ),
    .gbe_axi_m0_aw_cache  (config_ss_gbe_m0_awcache_sig      ),
    .gbe_axi_m0_aw_id     (config_ss_gbe_m0_awid_sig         ),
    .gbe_axi_m0_aw_len    (config_ss_gbe_m0_awlen_sig[3:0]   ),
    .gbe_axi_m0_aw_lock   (config_ss_gbe_m0_awlock_sig[0]    ),
    .gbe_axi_m0_aw_prot   (config_ss_gbe_m0_awprot_sig       ),
    .gbe_axi_m0_aw_ready  (flexnoc_gbe_axi_m0_aw_ready_sig   ),
    .gbe_axi_m0_aw_size   (config_ss_gbe_m0_awsize_sig       ),
    .gbe_axi_m0_aw_valid  (config_ss_gbe_m0_awvalid_sig      ),
    .gbe_axi_m0_b_id      (flexnoc_gbe_axi_m0_b_id_sig       ),
    .gbe_axi_m0_b_ready   (config_ss_gbe_m0_bready_sig       ),
    .gbe_axi_m0_b_resp    (flexnoc_gbe_axi_m0_b_resp_sig     ),
    .gbe_axi_m0_b_valid   (flexnoc_gbe_axi_m0_b_valid_sig    ),
    .gbe_axi_m0_r_data    (flexnoc_gbe_axi_m0_r_data_sig     ),
    .gbe_axi_m0_r_id      (flexnoc_gbe_axi_m0_r_id_sig       ),
    .gbe_axi_m0_r_last    (flexnoc_gbe_axi_m0_r_last_sig     ),
    .gbe_axi_m0_r_ready   (config_ss_gbe_m0_rready_sig       ),
    .gbe_axi_m0_r_resp    (flexnoc_gbe_axi_m0_r_resp_sig     ),
    .gbe_axi_m0_r_valid   (flexnoc_gbe_axi_m0_r_valid_sig    ),
    .gbe_axi_m0_w_data    (config_ss_gbe_m0_wdata_sig        ),
    .gbe_axi_m0_w_last    (config_ss_gbe_m0_wlast_sig        ),
    .gbe_axi_m0_w_ready   (flexnoc_gbe_axi_m0_w_ready_sig    ),
    .gbe_axi_m0_w_strb    (config_ss_gbe_m0_wstrb_sig        ),
    .gbe_axi_m0_w_valid   (config_ss_gbe_m0_wvalid_sig       ),
    .pufcc_axi_m0_ar_addr (config_ss_pufcc_m0_ar_addr_sig    ),
    .pufcc_axi_m0_ar_burst(config_ss_pufcc_m0_ar_burst_sig   ),
    .pufcc_axi_m0_ar_cache(config_ss_pufcc_m0_ar_cache_sig   ),
    .pufcc_axi_m0_ar_id   (config_ss_pufcc_m0_ar_id_sig      ),
    .pufcc_axi_m0_ar_len  (config_ss_pufcc_m0_ar_len_sig[3:0]),
    .pufcc_axi_m0_ar_lock (config_ss_pufcc_m0_ar_lock_sig    ),
    .pufcc_axi_m0_ar_prot (config_ss_pufcc_m0_ar_prot_sig    ),
    .pufcc_axi_m0_ar_ready(flexnoc_pufcc_axi_m0_ar_ready_sig ),
    .pufcc_axi_m0_ar_size (config_ss_pufcc_m0_ar_size_sig    ),
    .pufcc_axi_m0_ar_valid(config_ss_pufcc_m0_ar_valid_sig   ),
    .pufcc_axi_m0_aw_addr (config_ss_pufcc_m0_aw_addr_sig    ),
    .pufcc_axi_m0_aw_burst(config_ss_pufcc_m0_aw_burst_sig   ),
    .pufcc_axi_m0_aw_cache(config_ss_pufcc_m0_aw_cache_sig   ),
    .pufcc_axi_m0_aw_id   (config_ss_pufcc_m0_aw_id_sig      ),
    .pufcc_axi_m0_aw_len  (config_ss_pufcc_m0_aw_len_sig[3:0]),
    .pufcc_axi_m0_aw_lock (config_ss_pufcc_m0_aw_lock_sig    ),
    .pufcc_axi_m0_aw_prot (config_ss_pufcc_m0_aw_prot_sig    ),
    .pufcc_axi_m0_aw_ready(flexnoc_pufcc_axi_m0_aw_ready_sig ),
    .pufcc_axi_m0_aw_size (config_ss_pufcc_m0_aw_size_sig    ),
    .pufcc_axi_m0_aw_valid(config_ss_pufcc_m0_aw_valid_sig   ),
    .pufcc_axi_m0_b_id    (flexnoc_pufcc_axi_m0_b_id_sig     ),
    .pufcc_axi_m0_b_ready (config_ss_pufcc_m0_b_ready_sig    ),
    .pufcc_axi_m0_b_resp  (flexnoc_pufcc_axi_m0_b_resp_sig   ),
    .pufcc_axi_m0_b_valid (flexnoc_pufcc_axi_m0_b_valid_sig  ),
    .pufcc_axi_m0_r_data  (flexnoc_pufcc_axi_m0_r_data_sig   ),
    .pufcc_axi_m0_r_id    (flexnoc_pufcc_axi_m0_r_id_sig     ),
    .pufcc_axi_m0_r_last  (flexnoc_pufcc_axi_m0_r_last_sig   ),
    .pufcc_axi_m0_r_ready (config_ss_pufcc_m0_r_ready_sig    ),
    .pufcc_axi_m0_r_resp  (flexnoc_pufcc_axi_m0_r_resp_sig   ),
    .pufcc_axi_m0_r_valid (flexnoc_pufcc_axi_m0_r_valid_sig  ),
    .pufcc_axi_m0_w_data  (config_ss_pufcc_m0_w_data_sig     ),
    .pufcc_axi_m0_w_last  (config_ss_pufcc_m0_w_last_sig     ),
    .pufcc_axi_m0_w_ready (flexnoc_pufcc_axi_m0_w_ready_sig  ),
    .pufcc_axi_m0_w_strb  (config_ss_pufcc_m0_w_strb_sig     ),
    .pufcc_axi_m0_w_valid (config_ss_pufcc_m0_w_valid_sig    ),
    .rst_133_n            (config_ss_rst_n_133_sig           ),
    .rst_266_n            (config_ss_rst_n_266_sig           ),
    .rst_533_n            (config_ss_rst_n_533_sig           ),
    .sram_axi_s0_ar_addr  (flexnoc_sram_axi_s0_ar_addr_sig   ),
    .sram_axi_s0_ar_burst (flexnoc_sram_axi_s0_ar_burst_sig  ),
    .sram_axi_s0_ar_cache (flexnoc_sram_axi_s0_ar_cache_sig  ),
    .sram_axi_s0_ar_id    (flexnoc_sram_axi_s0_ar_id_sig     ),
    .sram_axi_s0_ar_len   (flexnoc_sram_axi_s0_ar_len_sig    ),
    .sram_axi_s0_ar_lock  (flexnoc_sram_axi_s0_ar_lock_sig   ),
    .sram_axi_s0_ar_prot  (flexnoc_sram_axi_s0_ar_prot_sig   ),
    .sram_axi_s0_ar_ready (memory_ss_sramb0_arready_sig      ),
    .sram_axi_s0_ar_size  (flexnoc_sram_axi_s0_ar_size_sig   ),
    .sram_axi_s0_ar_valid (flexnoc_sram_axi_s0_ar_valid_sig  ),
    .sram_axi_s0_aw_addr  (flexnoc_sram_axi_s0_aw_addr_sig   ),
    .sram_axi_s0_aw_burst (flexnoc_sram_axi_s0_aw_burst_sig  ),
    .sram_axi_s0_aw_cache (flexnoc_sram_axi_s0_aw_cache_sig  ),
    .sram_axi_s0_aw_id    (flexnoc_sram_axi_s0_aw_id_sig     ),
    .sram_axi_s0_aw_len   (flexnoc_sram_axi_s0_aw_len_sig    ),
    .sram_axi_s0_aw_lock  (flexnoc_sram_axi_s0_aw_lock_sig   ),
    .sram_axi_s0_aw_prot  (flexnoc_sram_axi_s0_aw_prot_sig   ),
    .sram_axi_s0_aw_ready (memory_ss_sramb0_awready_sig      ),
    .sram_axi_s0_aw_size  (flexnoc_sram_axi_s0_aw_size_sig   ),
    .sram_axi_s0_aw_valid (flexnoc_sram_axi_s0_aw_valid_sig  ),
    .sram_axi_s0_b_id     (memory_ss_sramb0_bid_sig          ),
    .sram_axi_s0_b_ready  (flexnoc_sram_axi_s0_b_ready_sig   ),
    .sram_axi_s0_b_resp   (memory_ss_sramb0_bresp_sig        ),
    .sram_axi_s0_b_valid  (memory_ss_sramb0_bvalid_sig       ),
    .sram_axi_s0_r_data   (memory_ss_sramb0_rdata_sig        ),
    .sram_axi_s0_r_id     (memory_ss_sramb0_rid_sig          ),
    .sram_axi_s0_r_last   (memory_ss_sramb0_rlast_sig        ),
    .sram_axi_s0_r_ready  (flexnoc_sram_axi_s0_r_ready_sig   ),
    .sram_axi_s0_r_resp   (memory_ss_sramb0_rresp_sig        ),
    .sram_axi_s0_r_valid  (memory_ss_sramb0_rvalid_sig       ),
    .sram_axi_s0_w_data   (flexnoc_sram_axi_s0_w_data_sig    ),
    .sram_axi_s0_w_last   (flexnoc_sram_axi_s0_w_last_sig    ),
    .sram_axi_s0_w_ready  (memory_ss_sramb0_wready_sig       ),
    .sram_axi_s0_w_strb   (flexnoc_sram_axi_s0_w_strb_sig    ),
    .sram_axi_s0_w_valid  (flexnoc_sram_axi_s0_w_valid_sig   ),
    .sram_axi_s1_ar_addr  (flexnoc_sram_axi_s1_ar_addr_sig   ),
    .sram_axi_s1_ar_burst (flexnoc_sram_axi_s1_ar_burst_sig  ),
    .sram_axi_s1_ar_cache (flexnoc_sram_axi_s1_ar_cache_sig  ),
    .sram_axi_s1_ar_id    (flexnoc_sram_axi_s1_ar_id_sig     ),
    .sram_axi_s1_ar_len   (flexnoc_sram_axi_s1_ar_len_sig    ),
    .sram_axi_s1_ar_lock  (flexnoc_sram_axi_s1_ar_lock_sig   ),
    .sram_axi_s1_ar_prot  (flexnoc_sram_axi_s1_ar_prot_sig   ),
    .sram_axi_s1_ar_ready (memory_ss_sramb1_arready_sig      ),
    .sram_axi_s1_ar_size  (flexnoc_sram_axi_s1_ar_size_sig   ),
    .sram_axi_s1_ar_valid (flexnoc_sram_axi_s1_ar_valid_sig  ),
    .sram_axi_s1_aw_addr  (flexnoc_sram_axi_s1_aw_addr_sig   ),
    .sram_axi_s1_aw_burst (flexnoc_sram_axi_s1_aw_burst_sig  ),
    .sram_axi_s1_aw_cache (flexnoc_sram_axi_s1_aw_cache_sig  ),
    .sram_axi_s1_aw_id    (flexnoc_sram_axi_s1_aw_id_sig     ),
    .sram_axi_s1_aw_len   (flexnoc_sram_axi_s1_aw_len_sig    ),
    .sram_axi_s1_aw_lock  (flexnoc_sram_axi_s1_aw_lock_sig   ),
    .sram_axi_s1_aw_prot  (flexnoc_sram_axi_s1_aw_prot_sig   ),
    .sram_axi_s1_aw_ready (memory_ss_sramb1_awready_sig      ),
    .sram_axi_s1_aw_size  (flexnoc_sram_axi_s1_aw_size_sig   ),
    .sram_axi_s1_aw_valid (flexnoc_sram_axi_s1_aw_valid_sig  ),
    .sram_axi_s1_b_id     (memory_ss_sramb1_bid_sig          ),
    .sram_axi_s1_b_ready  (flexnoc_sram_axi_s1_b_ready_sig   ),
    .sram_axi_s1_b_resp   (memory_ss_sramb1_bresp_sig        ),
    .sram_axi_s1_b_valid  (memory_ss_sramb1_bvalid_sig       ),
    .sram_axi_s1_r_data   (memory_ss_sramb1_rdata_sig        ),
    .sram_axi_s1_r_id     (memory_ss_sramb1_rid_sig          ),
    .sram_axi_s1_r_last   (memory_ss_sramb1_rlast_sig        ),
    .sram_axi_s1_r_ready  (flexnoc_sram_axi_s1_r_ready_sig   ),
    .sram_axi_s1_r_resp   (memory_ss_sramb1_rresp_sig        ),
    .sram_axi_s1_r_valid  (memory_ss_sramb1_rvalid_sig       ),
    .sram_axi_s1_w_data   (flexnoc_sram_axi_s1_w_data_sig    ),
    .sram_axi_s1_w_last   (flexnoc_sram_axi_s1_w_last_sig    ),
    .sram_axi_s1_w_ready  (memory_ss_sramb1_wready_sig       ),
    .sram_axi_s1_w_strb   (flexnoc_sram_axi_s1_w_strb_sig    ),
    .sram_axi_s1_w_valid  (flexnoc_sram_axi_s1_w_valid_sig   ),
    .sram_axi_s2_ar_addr  (flexnoc_sram_axi_s2_ar_addr_sig   ),
    .sram_axi_s2_ar_burst (flexnoc_sram_axi_s2_ar_burst_sig  ),
    .sram_axi_s2_ar_cache (flexnoc_sram_axi_s2_ar_cache_sig  ),
    .sram_axi_s2_ar_id    (flexnoc_sram_axi_s2_ar_id_sig     ),
    .sram_axi_s2_ar_len   (flexnoc_sram_axi_s2_ar_len_sig    ),
    .sram_axi_s2_ar_lock  (flexnoc_sram_axi_s2_ar_lock_sig   ),
    .sram_axi_s2_ar_prot  (flexnoc_sram_axi_s2_ar_prot_sig   ),
    .sram_axi_s2_ar_ready (memory_ss_sramb2_arready_sig      ),
    .sram_axi_s2_ar_size  (flexnoc_sram_axi_s2_ar_size_sig   ),
    .sram_axi_s2_ar_valid (flexnoc_sram_axi_s2_ar_valid_sig  ),
    .sram_axi_s2_aw_addr  (flexnoc_sram_axi_s2_aw_addr_sig   ),
    .sram_axi_s2_aw_burst (flexnoc_sram_axi_s2_aw_burst_sig  ),
    .sram_axi_s2_aw_cache (flexnoc_sram_axi_s2_aw_cache_sig  ),
    .sram_axi_s2_aw_id    (flexnoc_sram_axi_s2_aw_id_sig     ),
    .sram_axi_s2_aw_len   (flexnoc_sram_axi_s2_aw_len_sig    ),
    .sram_axi_s2_aw_lock  (flexnoc_sram_axi_s2_aw_lock_sig   ),
    .sram_axi_s2_aw_prot  (flexnoc_sram_axi_s2_aw_prot_sig   ),
    .sram_axi_s2_aw_ready (memory_ss_sramb2_awready_sig      ),
    .sram_axi_s2_aw_size  (flexnoc_sram_axi_s2_aw_size_sig   ),
    .sram_axi_s2_aw_valid (flexnoc_sram_axi_s2_aw_valid_sig  ),
    .sram_axi_s2_b_id     (memory_ss_sramb2_bid_sig          ),
    .sram_axi_s2_b_ready  (flexnoc_sram_axi_s2_b_ready_sig   ),
    .sram_axi_s2_b_resp   (memory_ss_sramb2_bresp_sig        ),
    .sram_axi_s2_b_valid  (memory_ss_sramb2_bvalid_sig       ),
    .sram_axi_s2_r_data   (memory_ss_sramb2_rdata_sig        ),
    .sram_axi_s2_r_id     (memory_ss_sramb2_rid_sig          ),
    .sram_axi_s2_r_last   (memory_ss_sramb2_rlast_sig        ),
    .sram_axi_s2_r_ready  (flexnoc_sram_axi_s2_r_ready_sig   ),
    .sram_axi_s2_r_resp   (memory_ss_sramb2_rresp_sig        ),
    .sram_axi_s2_r_valid  (memory_ss_sramb2_rvalid_sig       ),
    .sram_axi_s2_w_data   (flexnoc_sram_axi_s2_w_data_sig    ),
    .sram_axi_s2_w_last   (flexnoc_sram_axi_s2_w_last_sig    ),
    .sram_axi_s2_w_ready  (memory_ss_sramb2_wready_sig       ),
    .sram_axi_s2_w_strb   (flexnoc_sram_axi_s2_w_strb_sig    ),
    .sram_axi_s2_w_valid  (flexnoc_sram_axi_s2_w_valid_sig   ),
    .sram_axi_s3_ar_addr  (flexnoc_sram_axi_s3_ar_addr_sig   ),
    .sram_axi_s3_ar_burst (flexnoc_sram_axi_s3_ar_burst_sig  ),
    .sram_axi_s3_ar_cache (flexnoc_sram_axi_s3_ar_cache_sig  ),
    .sram_axi_s3_ar_id    (flexnoc_sram_axi_s3_ar_id_sig     ),
    .sram_axi_s3_ar_len   (flexnoc_sram_axi_s3_ar_len_sig    ),
    .sram_axi_s3_ar_lock  (flexnoc_sram_axi_s3_ar_lock_sig   ),
    .sram_axi_s3_ar_prot  (flexnoc_sram_axi_s3_ar_prot_sig   ),
    .sram_axi_s3_ar_ready (memory_ss_sramb3_arready_sig      ),
    .sram_axi_s3_ar_size  (flexnoc_sram_axi_s3_ar_size_sig   ),
    .sram_axi_s3_ar_valid (flexnoc_sram_axi_s3_ar_valid_sig  ),
    .sram_axi_s3_aw_addr  (flexnoc_sram_axi_s3_aw_addr_sig   ),
    .sram_axi_s3_aw_burst (flexnoc_sram_axi_s3_aw_burst_sig  ),
    .sram_axi_s3_aw_cache (flexnoc_sram_axi_s3_aw_cache_sig  ),
    .sram_axi_s3_aw_id    (flexnoc_sram_axi_s3_aw_id_sig     ),
    .sram_axi_s3_aw_len   (flexnoc_sram_axi_s3_aw_len_sig    ),
    .sram_axi_s3_aw_lock  (flexnoc_sram_axi_s3_aw_lock_sig   ),
    .sram_axi_s3_aw_prot  (flexnoc_sram_axi_s3_aw_prot_sig   ),
    .sram_axi_s3_aw_ready (memory_ss_sramb3_awready_sig      ),
    .sram_axi_s3_aw_size  (flexnoc_sram_axi_s3_aw_size_sig   ),
    .sram_axi_s3_aw_valid (flexnoc_sram_axi_s3_aw_valid_sig  ),
    .sram_axi_s3_b_id     (memory_ss_sramb3_bid_sig          ),
    .sram_axi_s3_b_ready  (flexnoc_sram_axi_s3_b_ready_sig   ),
    .sram_axi_s3_b_resp   (memory_ss_sramb3_bresp_sig        ),
    .sram_axi_s3_b_valid  (memory_ss_sramb3_bvalid_sig       ),
    .sram_axi_s3_r_data   (memory_ss_sramb3_rdata_sig        ),
    .sram_axi_s3_r_id     (memory_ss_sramb3_rid_sig          ),
    .sram_axi_s3_r_last   (memory_ss_sramb3_rlast_sig        ),
    .sram_axi_s3_r_ready  (flexnoc_sram_axi_s3_r_ready_sig   ),
    .sram_axi_s3_r_resp   (memory_ss_sramb3_rresp_sig        ),
    .sram_axi_s3_r_valid  (memory_ss_sramb3_rvalid_sig       ),
    .sram_axi_s3_w_data   (flexnoc_sram_axi_s3_w_data_sig    ),
    .sram_axi_s3_w_last   (flexnoc_sram_axi_s3_w_last_sig    ),
    .sram_axi_s3_w_ready  (memory_ss_sramb3_wready_sig       ),
    .sram_axi_s3_w_strb   (flexnoc_sram_axi_s3_w_strb_sig    ),
    .sram_axi_s3_w_valid  (flexnoc_sram_axi_s3_w_valid_sig   ),
    .tm                   (testmode                          ),
    .usb_axi_m0_ar_addr   (config_ss_usb_m0_araddr_sig       ),
    .usb_axi_m0_ar_burst  (config_ss_usb_m0_arburst_sig      ),
    .usb_axi_m0_ar_cache  (config_ss_usb_m0_arcache_sig      ),
    .usb_axi_m0_ar_id     (config_ss_usb_m0_arid_sig         ),
    .usb_axi_m0_ar_len    (config_ss_usb_m0_arlen_sig        ),
    .usb_axi_m0_ar_lock   (config_ss_usb_m0_arlock_sig[0]    ),
    .usb_axi_m0_ar_prot   (config_ss_usb_m0_arprot_sig       ),
    .usb_axi_m0_ar_ready  (flexnoc_usb_axi_m0_ar_ready_sig   ),
    .usb_axi_m0_ar_size   (config_ss_usb_m0_arsize_sig       ),
    .usb_axi_m0_ar_valid  (config_ss_usb_m0_arvalid_sig      ),
    .usb_axi_m0_aw_addr   (config_ss_usb_m0_awaddr_sig       ),
    .usb_axi_m0_aw_burst  (config_ss_usb_m0_awburst_sig      ),
    .usb_axi_m0_aw_cache  (config_ss_usb_m0_awcache_sig      ),
    .usb_axi_m0_aw_id     (config_ss_usb_m0_awid_sig         ),
    .usb_axi_m0_aw_len    (config_ss_usb_m0_awlen_sig        ),
    .usb_axi_m0_aw_lock   (config_ss_usb_m0_awlock_sig[0]    ),
    .usb_axi_m0_aw_prot   (config_ss_usb_m0_awprot_sig       ),
    .usb_axi_m0_aw_ready  (flexnoc_usb_axi_m0_aw_ready_sig   ),
    .usb_axi_m0_aw_size   (config_ss_usb_m0_awsize_sig       ),
    .usb_axi_m0_aw_valid  (config_ss_usb_m0_awvalid_sig      ),
    .usb_axi_m0_b_id      (flexnoc_usb_axi_m0_b_id_sig       ),
    .usb_axi_m0_b_ready   (config_ss_usb_m0_bready_sig       ),
    .usb_axi_m0_b_resp    (flexnoc_usb_axi_m0_b_resp_sig     ),
    .usb_axi_m0_b_valid   (flexnoc_usb_axi_m0_b_valid_sig    ),
    .usb_axi_m0_r_data    (flexnoc_usb_axi_m0_r_data_sig     ),
    .usb_axi_m0_r_id      (flexnoc_usb_axi_m0_r_id_sig       ),
    .usb_axi_m0_r_last    (flexnoc_usb_axi_m0_r_last_sig     ),
    .usb_axi_m0_r_ready   (config_ss_usb_m0_rready_sig       ),
    .usb_axi_m0_r_resp    (flexnoc_usb_axi_m0_r_resp_sig     ),
    .usb_axi_m0_r_valid   (flexnoc_usb_axi_m0_r_valid_sig    ),
    .usb_axi_m0_w_data    (config_ss_usb_m0_wdata_sig        ),
    .usb_axi_m0_w_last    (config_ss_usb_m0_wlast_sig        ),
    .usb_axi_m0_w_ready   (flexnoc_usb_axi_m0_w_ready_sig    ),
    .usb_axi_m0_w_strb    (config_ss_usb_m0_wstrb_sig        ),
    .usb_axi_m0_w_valid   (config_ss_usb_m0_wvalid_sig       )
);


/*
soc_fpga_intf #(
    .FCB_CHAIN_NUM(FCB_CHAIN_NUM),
    .ICB_CHAIN_NUM(ICB_CHAIN_NUM)
) soc_fpga_intf_u (
    .clk_apb_ug               (config_ss_clk_apb_ug_sig          ),
    .clk_acpu                 (config_ss_clk_acpu_sig            ),    
    .rst_n_per                (rst_n_per                         ),
    .clk_fpga_fabric_m0       (clk_fpga_fabric_m0                ),
    .clk_fpga_fabric_m1       (clk_fpga_fabric_m1                ),
    .clk_fpga_fabric_s0       (clk_fpga_fabric_s0                ),
    .clk_fpga_fabric_fcb_pcb  (clk_fpga_fabric_fcb_pcb           ),
    .clk_fpga_fabric_irq      (clk_fpga_fabric_irq               ),
    .clk_fpga_fabric_dma      (clk_fpga_fabric_dma               ),
    .clk_fpga_fabric_ace      (clk_fpga_fabric_ace               ),
    .rst_n_fpga_fabric_m0     (rst_n_fpga_fabric_m0              ),
    .rst_n_fpga_fabric_m1     (rst_n_fpga_fabric_m1              ),
    .rst_n_fpga_fabric_s0     (rst_n_fpga_fabric_s0              ),
    .rst_n_fpga_fabric_fcb_pcb(rst_n_fpga_fabric_fcb_pcb         ),
    .rst_n_fpga_fabric_irq    (rst_n_fpga_fabric_irq             ),
    .rst_n_fpga_fabric_dma    (rst_n_fpga_fabric_dma             ),
    .rst_n_fpga_fabric_ace    (rst_n_fpga_fabric_ace             ),
    .rst_n_fpga_soc_m0        (config_ss_rst_n_fpga0_sig         ),
    .rst_n_fpga_soc_m1        (config_ss_rst_n_fpga1_sig         ),
    .rst_n_fpga_soc_s0        (config_ss_rst_n_fpga_s_sig        ),
    .rst_n_acpu               (config_ss_rst_n_acpu_bus_sig      ),
    
    .fcb_s0_paddr             (config_ss_FCB_apb_s0_paddr_sig    ),
    .fcb_s0_psel              (config_ss_FCB_apb_s0_psel_sig     ),
    .fcb_s0_penable           (config_ss_FCB_apb_s0_penable_sig  ),
    .fcb_s0_pwrite            (config_ss_FCB_apb_s0_pwrite_sig   ),
    .fcb_s0_pwbe              (flexnoc_FCB_apb_s0_pwbe_sig       ),
    .fcb_s0_pwdata            (config_ss_FCB_apb_s0_pwdata_sig   ),
    .fcb_s0_prdata            (soc_fpga_intf_fcb_s0_prdata_sig   ),
    .fcb_s0_pready            (soc_fpga_intf_fcb_s0_pready_sig   ),
    .fcb_s0_pslverr           (soc_fpga_intf_fcb_s0_pslverr_sig  ),
    
    .fcb_clk_o                (fcb_clk_o                         ),
    .fcb_data_o               (fcb_data_o                        ),
    .fcb_cmd_o                (fcb_cmd_o                         ),
    .fcb_clk_i                (fcb_clk_i                         ),
    .fcb_data_i               (fcb_data_i                        ),
    .fcb_rst_n                (fcb_rst_n                         ),
    .icb_clk_o                (icb_clk_o                         ),
    .icb_data_o               (icb_data_o                        ),
    .icb_cmd_o                (icb_cmd_o                         ),
    .icb_clk_i                (icb_clk_i                         ),
    .icb_data_i               (icb_data_i                        ),
    .icb_rst_n                (icb_rst_n                         ),
    .pl_data_o                (pl_data_o                         ),
    .pl_addr_o                (pl_addr_o                         ),
    .pl_ena_o                 (pl_ena_o                          ),
    .pl_clk_o                 (pl_clk_o                          ),
    .pl_ren_o                 (pl_ren_o                          ),
    .pl_init_o                (pl_init_o                         ),
    .pl_wen_o                 (pl_wen_o                          ),
    .pl_data_i                (pl_data_i                         ),
    .fpga_pll0_dskewcalin     (ccb_pll0_dskewcalin               ),
    .fpga_pll0_pllen          (ccb_pll0_pllen                    ),
    .fpga_pll0_dsmen          (ccb_pll0_dsmen                    ),
    .fpga_pll0_dskewfastcal   (ccb_pll0_dskewfastcal             ),
    .fpga_pll0_dskewcalen     (ccb_pll0_dskewcalen               ),
    .fpga_pll0_dskewcalcnt    (ccb_pll0_dskewcalcnt              ),
    .fpga_pll0_dskewcalbyp    (ccb_pll0_dskewcalbyp              ),
    .fpga_pll0_dacen          (ccb_pll0_dacen                    ),
    .fpga_pll0_refdiv         (ccb_pll0_refdiv                   ),
    .fpga_pll0_foutvcoen      (ccb_pll0_foutvcoen                ),
    .fpga_pll0_foutvcobyp     (ccb_pll0_foutvcobyp               ),
    .fpga_pll0_fouten         (ccb_pll0_fouten                   ),
    .fpga_pll0_frac           (ccb_pll0_frac                     ),
    .fpga_pll0_fbdiv          (ccb_pll0_fbdiv                    ),
    .fpga_pll0_postdiv3       (ccb_pll0_postdiv3                 ),
    .fpga_pll0_postdiv2       (ccb_pll0_postdiv2                 ),
    .fpga_pll0_postdiv1       (ccb_pll0_postdiv1                 ),
    .fpga_pll0_postdiv0       (ccb_pll0_postdiv0                 ),
    .fpga_pll0_lock           (ccb_pll0_lock                     ),
    .fpga_pll0_dskewcallock   (ccb_pll0_dskewcallock             ),
    .fpga_pll0_dskewcalout    (ccb_pll0_dskewcalout              ),
    .fpga_pll1_dskewcalin     (ccb_pll1_dskewcalin               ),
    .fpga_pll1_pllen          (ccb_pll1_pllen                    ),
    .fpga_pll1_dsmen          (ccb_pll1_dsmen                    ),
    .fpga_pll1_dskewfastcal   (ccb_pll1_dskewfastcal             ),
    .fpga_pll1_dskewcalen     (ccb_pll1_dskewcalen               ),
    .fpga_pll1_dskewcalcnt    (ccb_pll1_dskewcalcnt              ),
    .fpga_pll1_dskewcalbyp    (ccb_pll1_dskewcalbyp              ),
    .fpga_pll1_dacen          (ccb_pll1_dacen                    ),
    .fpga_pll1_refdiv         (ccb_pll1_refdiv                   ),
    .fpga_pll1_foutvcoen      (ccb_pll1_foutvcoen                ),
    .fpga_pll1_foutvcobyp     (ccb_pll1_foutvcobyp               ),
    .fpga_pll1_fouten         (ccb_pll1_fouten                   ),
    .fpga_pll1_frac           (ccb_pll1_frac                     ),
    .fpga_pll1_fbdiv          (ccb_pll1_fbdiv                    ),
    .fpga_pll1_postdiv3       (ccb_pll1_postdiv3                 ),
    .fpga_pll1_postdiv2       (ccb_pll1_postdiv2                 ),
    .fpga_pll1_postdiv1       (ccb_pll1_postdiv1                 ),
    .fpga_pll1_postdiv0       (ccb_pll1_postdiv0                 ),
    .fpga_pll1_lock           (ccb_pll1_lock                     ),
    .fpga_pll1_dskewcallock   (ccb_pll1_dskewcallock             ),
    .fpga_pll1_dskewcalout    (ccb_pll1_dskewcalout              ),
    .fpga_pll2_dskewcalin     (ccb_pll2_dskewcalin               ),
    .fpga_pll2_pllen          (ccb_pll2_pllen                    ),
    .fpga_pll2_dsmen          (ccb_pll2_dsmen                    ),
    .fpga_pll2_dskewfastcal   (ccb_pll2_dskewfastcal             ),
    .fpga_pll2_dskewcalen     (ccb_pll2_dskewcalen               ),
    .fpga_pll2_dskewcalcnt    (ccb_pll2_dskewcalcnt              ),
    .fpga_pll2_dskewcalbyp    (ccb_pll2_dskewcalbyp              ),
    .fpga_pll2_dacen          (ccb_pll2_dacen                    ),
    .fpga_pll2_refdiv         (ccb_pll2_refdiv                   ),
    .fpga_pll2_foutvcoen      (ccb_pll2_foutvcoen                ),
    .fpga_pll2_foutvcobyp     (ccb_pll2_foutvcobyp               ),
    .fpga_pll2_fouten         (ccb_pll2_fouten                   ),
    .fpga_pll2_frac           (ccb_pll2_frac                     ),
    .fpga_pll2_fbdiv          (ccb_pll2_fbdiv                    ),
    .fpga_pll2_postdiv3       (ccb_pll2_postdiv3                 ),
    .fpga_pll2_postdiv2       (ccb_pll2_postdiv2                 ),
    .fpga_pll2_postdiv1       (ccb_pll2_postdiv1                 ),
    .fpga_pll2_postdiv0       (ccb_pll2_postdiv0                 ),
    .fpga_pll2_lock           (ccb_pll2_lock                     ),
    .fpga_pll2_dskewcallock   (ccb_pll2_dskewcallock             ),
    .fpga_pll2_dskewcalout    (ccb_pll2_dskewcalout              ),
    .fpga_pll3_dskewcalin     (ccb_pll3_dskewcalin               ),
    .fpga_pll3_pllen          (ccb_pll3_pllen                    ),
    .fpga_pll3_dsmen          (ccb_pll3_dsmen                    ),
    .fpga_pll3_dskewfastcal   (ccb_pll3_dskewfastcal             ),
    .fpga_pll3_dskewcalen     (ccb_pll3_dskewcalen               ),
    .fpga_pll3_dskewcalcnt    (ccb_pll3_dskewcalcnt              ),
    .fpga_pll3_dskewcalbyp    (ccb_pll3_dskewcalbyp              ),
    .fpga_pll3_dacen          (ccb_pll3_dacen                    ),
    .fpga_pll3_refdiv         (ccb_pll3_refdiv                   ),
    .fpga_pll3_foutvcoen      (ccb_pll3_foutvcoen                ),
    .fpga_pll3_foutvcobyp     (ccb_pll3_foutvcobyp               ),
    .fpga_pll3_fouten         (ccb_pll3_fouten                   ),
    .fpga_pll3_frac           (ccb_pll3_frac                     ),
    .fpga_pll3_fbdiv          (ccb_pll3_fbdiv                    ),
    .fpga_pll3_postdiv3       (ccb_pll3_postdiv3                 ),
    .fpga_pll3_postdiv2       (ccb_pll3_postdiv2                 ),
    .fpga_pll3_postdiv1       (ccb_pll3_postdiv1                 ),
    .fpga_pll3_postdiv0       (ccb_pll3_postdiv0                 ),
    .fpga_pll3_lock           (ccb_pll3_lock                     ),
    .fpga_pll3_dskewcallock   (ccb_pll3_dskewcallock             ),
    .fpga_pll3_dskewcalout    (ccb_pll3_dskewcalout              ),
    
    .fpga_clk_ahb_s0_haddr    (fpga_ahb_s0_haddr                 ),
    .fpga_clk_ahb_s0_hburst   (fpga_ahb_s0_hburst                ),
    .fpga_clk_ahb_s0_hmastlock(fpga_ahb_s0_hmastlock             ),
    .fpga_clk_ahb_s0_hready   (fpga_ahb_s0_hready                ),
    .fpga_clk_ahb_s0_hprot    (fpga_ahb_s0_hprot                 ),
    .fpga_clk_ahb_s0_hrdata   (fpga_ahb_s0_hrdata                ),
    .fpga_clk_ahb_s0_hresp    (fpga_ahb_s0_hresp                 ),
    .fpga_clk_ahb_s0_hsel     (fpga_ahb_s0_hsel                  ),
    .fpga_clk_ahb_s0_hsize    (fpga_ahb_s0_hsize                 ),
    .fpga_clk_ahb_s0_htrans   (fpga_ahb_s0_htrans                ),
    .fpga_clk_ahb_s0_hwbe     (fpga_ahb_s0_hwbe                  ),
    .fpga_clk_ahb_s0_hwdata   (fpga_ahb_s0_hwdata                ),
    .fpga_clk_ahb_s0_hwrite   (fpga_ahb_s0_hwrite                ),
    
    .fpga_clk_axi_m0_ar_addr  (fpga_axi_m0_ar_addr               ),
    .fpga_clk_axi_m0_ar_burst (fpga_axi_m0_ar_burst              ),
    .fpga_clk_axi_m0_ar_cache (fpga_axi_m0_ar_cache              ),
    .fpga_clk_axi_m0_ar_id    (fpga_axi_m0_ar_id                 ),
    .fpga_clk_axi_m0_ar_len   (fpga_axi_m0_ar_len                ),
    .fpga_clk_axi_m0_ar_lock  (fpga_axi_m0_ar_lock               ),
    .fpga_clk_axi_m0_ar_prot  (fpga_axi_m0_ar_prot               ),
    .fpga_clk_axi_m0_ar_ready (fpga_axi_m0_ar_ready              ),
    .fpga_clk_axi_m0_ar_size  (fpga_axi_m0_ar_size               ),
    .fpga_clk_axi_m0_ar_valid (fpga_axi_m0_ar_valid              ),
    .fpga_clk_axi_m0_aw_addr  (fpga_axi_m0_aw_addr               ),
    .fpga_clk_axi_m0_aw_burst (fpga_axi_m0_aw_burst              ),
    .fpga_clk_axi_m0_aw_cache (fpga_axi_m0_aw_cache              ),
    .fpga_clk_axi_m0_aw_id    (fpga_axi_m0_aw_id                 ),
    .fpga_clk_axi_m0_aw_len   (fpga_axi_m0_aw_len                ),
    .fpga_clk_axi_m0_aw_lock  (fpga_axi_m0_aw_lock               ),
    .fpga_clk_axi_m0_aw_prot  (fpga_axi_m0_aw_prot               ),
    .fpga_clk_axi_m0_aw_ready (fpga_axi_m0_aw_ready              ),
    .fpga_clk_axi_m0_aw_size  (fpga_axi_m0_aw_size               ),
    .fpga_clk_axi_m0_aw_valid (fpga_axi_m0_aw_valid              ),
    .fpga_clk_axi_m0_b_id     (fpga_axi_m0_b_id                  ),
    .fpga_clk_axi_m0_b_ready  (fpga_axi_m0_b_ready               ),
    .fpga_clk_axi_m0_b_resp   (fpga_axi_m0_b_resp                ),
    .fpga_clk_axi_m0_b_valid  (fpga_axi_m0_b_valid               ),
    .fpga_clk_axi_m0_r_data   (fpga_axi_m0_r_data                ),
    .fpga_clk_axi_m0_r_id     (fpga_axi_m0_r_id                  ),
    .fpga_clk_axi_m0_r_last   (fpga_axi_m0_r_last                ),
    .fpga_clk_axi_m0_r_ready  (fpga_axi_m0_r_ready               ),
    .fpga_clk_axi_m0_r_resp   (fpga_axi_m0_r_resp                ),
    .fpga_clk_axi_m0_r_valid  (fpga_axi_m0_r_valid               ),
    .fpga_clk_axi_m0_w_data   (fpga_axi_m0_w_data                ),
    .fpga_clk_axi_m0_w_last   (fpga_axi_m0_w_last                ),
    .fpga_clk_axi_m0_w_ready  (fpga_axi_m0_w_ready               ),
    .fpga_clk_axi_m0_w_strb   (fpga_axi_m0_w_strb                ),
    .fpga_clk_axi_m0_w_valid  (fpga_axi_m0_w_valid               ),
    .fpga_clk_axi_m1_ar_addr  (fpga_axi_m1_ar_addr               ),
    .fpga_clk_axi_m1_ar_burst (fpga_axi_m1_ar_burst              ),
    .fpga_clk_axi_m1_ar_cache (fpga_axi_m1_ar_cache              ),
    .fpga_clk_axi_m1_ar_id    (fpga_axi_m1_ar_id                 ),
    .fpga_clk_axi_m1_ar_len   (fpga_axi_m1_ar_len                ),
    .fpga_clk_axi_m1_ar_lock  (fpga_axi_m1_ar_lock               ),
    .fpga_clk_axi_m1_ar_prot  (fpga_axi_m1_ar_prot               ),
    .fpga_clk_axi_m1_ar_ready (fpga_axi_m1_ar_ready              ),
    .fpga_clk_axi_m1_ar_size  (fpga_axi_m1_ar_size               ),
    .fpga_clk_axi_m1_ar_valid (fpga_axi_m1_ar_valid              ),
    .fpga_clk_axi_m1_aw_addr  (fpga_axi_m1_aw_addr               ),
    .fpga_clk_axi_m1_aw_burst (fpga_axi_m1_aw_burst              ),
    .fpga_clk_axi_m1_aw_cache (fpga_axi_m1_aw_cache              ),
    .fpga_clk_axi_m1_aw_id    (fpga_axi_m1_aw_id                 ),
    .fpga_clk_axi_m1_aw_len   (fpga_axi_m1_aw_len                ),
    .fpga_clk_axi_m1_aw_lock  (fpga_axi_m1_aw_lock               ),
    .fpga_clk_axi_m1_aw_prot  (fpga_axi_m1_aw_prot               ),
    .fpga_clk_axi_m1_aw_ready (fpga_axi_m1_aw_ready              ),
    .fpga_clk_axi_m1_aw_size  (fpga_axi_m1_aw_size               ),
    .fpga_clk_axi_m1_aw_valid (fpga_axi_m1_aw_valid              ),
    .fpga_clk_axi_m1_b_id     (fpga_axi_m1_b_id                  ),
    .fpga_clk_axi_m1_b_ready  (fpga_axi_m1_b_ready               ),
    .fpga_clk_axi_m1_b_resp   (fpga_axi_m1_b_resp                ),
    .fpga_clk_axi_m1_b_valid  (fpga_axi_m1_b_valid               ),
    .fpga_clk_axi_m1_r_data   (fpga_axi_m1_r_data                ),
    .fpga_clk_axi_m1_r_id     (fpga_axi_m1_r_id                  ),
    .fpga_clk_axi_m1_r_last   (fpga_axi_m1_r_last                ),
    .fpga_clk_axi_m1_r_ready  (fpga_axi_m1_r_ready               ),
    .fpga_clk_axi_m1_r_resp   (fpga_axi_m1_r_resp                ),
    .fpga_clk_axi_m1_r_valid  (fpga_axi_m1_r_valid               ),
    .fpga_clk_axi_m1_w_data   (fpga_axi_m1_w_data                ),
    .fpga_clk_axi_m1_w_last   (fpga_axi_m1_w_last                ),
    .fpga_clk_axi_m1_w_ready  (fpga_axi_m1_w_ready               ),
    .fpga_clk_axi_m1_w_strb   (fpga_axi_m1_w_strb                ),
    .fpga_clk_axi_m1_w_valid  (fpga_axi_m1_w_valid               ),
    
    .fpga_clk_irq_src         (fpga_irq_src                      ),
    .fpga_clk_irq_set         (fpga_irq_set                      ),
    
    .fpga_clk_dma_req         (dma_req_fpga                      ),
    .fpga_clk_dma_ack         (dma_ack_fpga                      ),
    
    .fpga_ace_vstart          (ace_vstart                        ),
    .fpga_ace_istart          (ace_istart                        ),
    .fpga_ace_divalid         (ace_divalid                       ),
    .fpga_ace_doready         (ace_doready                       ),
    .fpga_ace_dinop           (ace_dinop                         ),
    .fpga_ace_dovalid         (ace_dovalid                       ),
    .fpga_ace_vbreak          (ace_vbreak                        ),
    .fpga_ace_diready         (ace_diready                       ),
    .fpga_ace_doutop          (ace_doutop                        ),
    
    .soc_clk_ahb_s0_haddr     (config_ss_fpga_ahb_s0_haddr_sig   ),
    .soc_clk_ahb_s0_hburst    (config_ss_fpga_ahb_s0_hburst_sig  ),
    .soc_clk_ahb_s0_hmastlock (flexnoc_fpga_ahb_s0_hmastlock_sig ),
    .soc_clk_ahb_s0_hprot     (config_ss_fpga_ahb_s0_hprot_sig   ),
    .soc_clk_ahb_s0_hrdata    (soc_fpga_intf_fpga_ahb_s0_hrdata  ),
    .soc_clk_ahb_s0_hready    (soc_fpga_intf_fpga_ahb_s0_hready  ),
    .soc_clk_ahb_s0_hresp     (soc_fpga_intf_fpga_ahb_s0_hresp   ),
    .soc_clk_ahb_s0_hsel      (config_ss_fpga_ahb_s0_hsel_sig    ),
    .soc_clk_ahb_s0_hsize     (config_ss_fpga_ahb_s0_hsize_sig   ),
    .soc_clk_ahb_s0_htrans    (config_ss_fpga_ahb_s0_htrans_sig  ),
    .soc_clk_ahb_s0_hwbe      (config_ss_fpga_ahb_s0_hwbe_sig    ),
    .soc_clk_ahb_s0_hwdata    (config_ss_fpga_ahb_s0_hwdata_sig  ),
    .soc_clk_ahb_s0_hwrite    (config_ss_fpga_ahb_s0_hwrite_sig  ),
    
    .soc_clk_axi_m0_ar_addr   (soc_fpga_intf_axi_m0_ar_addr      ),
    .soc_clk_axi_m0_ar_burst  (soc_fpga_intf_axi_m0_ar_burst     ),
    .soc_clk_axi_m0_ar_cache  (soc_fpga_intf_axi_m0_ar_cache     ),
    .soc_clk_axi_m0_ar_id     (soc_fpga_intf_axi_m0_ar_id        ),
    .soc_clk_axi_m0_ar_len    (soc_fpga_intf_axi_m0_ar_len       ),
    .soc_clk_axi_m0_ar_lock   (soc_fpga_intf_axi_m0_ar_lock      ),
    .soc_clk_axi_m0_ar_prot   (soc_fpga_intf_axi_m0_ar_prot      ),
    .soc_clk_axi_m0_ar_ready  (config_ss_fpga_axi_m0_ar_ready_sig),
    .soc_clk_axi_m0_ar_size   (soc_fpga_intf_axi_m0_ar_size      ),
    .soc_clk_axi_m0_ar_valid  (soc_fpga_intf_axi_m0_ar_valid     ),
    .soc_clk_axi_m0_aw_addr   (soc_fpga_intf_axi_m0_aw_addr      ),
    .soc_clk_axi_m0_aw_burst  (soc_fpga_intf_axi_m0_aw_burst     ),
    .soc_clk_axi_m0_aw_cache  (soc_fpga_intf_axi_m0_aw_cache     ),
    .soc_clk_axi_m0_aw_id     (soc_fpga_intf_axi_m0_aw_id        ),
    .soc_clk_axi_m0_aw_len    (soc_fpga_intf_axi_m0_aw_len       ),
    .soc_clk_axi_m0_aw_lock   (soc_fpga_intf_axi_m0_aw_lock      ),
    .soc_clk_axi_m0_aw_prot   (soc_fpga_intf_axi_m0_aw_prot      ),
    .soc_clk_axi_m0_aw_ready  (config_ss_fpga_axi_m0_aw_ready_sig),
    .soc_clk_axi_m0_aw_size   (soc_fpga_intf_axi_m0_aw_size      ),
    .soc_clk_axi_m0_aw_valid  (soc_fpga_intf_axi_m0_aw_valid     ),
    .soc_clk_axi_m0_b_id      (config_ss_fpga_axi_m0_b_id_sig    ),
    .soc_clk_axi_m0_b_ready   (soc_fpga_intf_axi_m0_b_ready      ),
    .soc_clk_axi_m0_b_resp    (config_ss_fpga_axi_m0_b_resp_sig  ),
    .soc_clk_axi_m0_b_valid   (config_ss_fpga_axi_m0_b_valid_sig ),
    .soc_clk_axi_m0_r_data    (config_ss_fpga_axi_m0_r_data_sig  ),
    .soc_clk_axi_m0_r_id      (config_ss_fpga_axi_m0_r_id_sig    ),
    .soc_clk_axi_m0_r_last    (config_ss_fpga_axi_m0_r_last_sig  ),
    .soc_clk_axi_m0_r_ready   (soc_fpga_intf_axi_m0_r_ready      ),
    .soc_clk_axi_m0_r_resp    (config_ss_fpga_axi_m0_r_resp_sig  ),
    .soc_clk_axi_m0_r_valid   (config_ss_fpga_axi_m0_r_valid_sig ),
    .soc_clk_axi_m0_w_data    (soc_fpga_intf_axi_m0_w_data       ),
    .soc_clk_axi_m0_w_last    (soc_fpga_intf_axi_m0_w_last       ),
    .soc_clk_axi_m0_w_ready   (config_ss_fpga_axi_m0_w_ready_sig ),
    .soc_clk_axi_m0_w_strb    (soc_fpga_intf_axi_m0_w_strb       ),
    .soc_clk_axi_m0_w_valid   (soc_fpga_intf_axi_m0_w_valid      ),
    .soc_clk_axi_m1_ar_addr   (soc_fpga_intf_axi_m1_ar_addr      ),
    .soc_clk_axi_m1_ar_burst  (soc_fpga_intf_axi_m1_ar_burst     ),
    .soc_clk_axi_m1_ar_cache  (soc_fpga_intf_axi_m1_ar_cache     ),
    .soc_clk_axi_m1_ar_id     (soc_fpga_intf_axi_m1_ar_id        ),
    .soc_clk_axi_m1_ar_len    (soc_fpga_intf_axi_m1_ar_len       ),
    .soc_clk_axi_m1_ar_lock   (soc_fpga_intf_axi_m1_ar_lock      ),
    .soc_clk_axi_m1_ar_prot   (soc_fpga_intf_axi_m1_ar_prot      ),
    .soc_clk_axi_m1_ar_ready  (config_ss_fpga_axi_m1_ar_ready_sig),
    .soc_clk_axi_m1_ar_size   (soc_fpga_intf_axi_m1_ar_size      ),
    .soc_clk_axi_m1_ar_valid  (soc_fpga_intf_axi_m1_ar_valid     ),
    .soc_clk_axi_m1_aw_addr   (soc_fpga_intf_axi_m1_aw_addr      ),
    .soc_clk_axi_m1_aw_burst  (soc_fpga_intf_axi_m1_aw_burst     ),
    .soc_clk_axi_m1_aw_cache  (soc_fpga_intf_axi_m1_aw_cache     ),
    .soc_clk_axi_m1_aw_id     (soc_fpga_intf_axi_m1_aw_id        ),
    .soc_clk_axi_m1_aw_len    (soc_fpga_intf_axi_m1_aw_len       ),
    .soc_clk_axi_m1_aw_lock   (soc_fpga_intf_axi_m1_aw_lock      ),
    .soc_clk_axi_m1_aw_prot   (soc_fpga_intf_axi_m1_aw_prot      ),
    .soc_clk_axi_m1_aw_ready  (config_ss_fpga_axi_m1_aw_ready_sig),
    .soc_clk_axi_m1_aw_size   (soc_fpga_intf_axi_m1_aw_size      ),
    .soc_clk_axi_m1_aw_valid  (soc_fpga_intf_axi_m1_aw_valid     ),
    .soc_clk_axi_m1_b_id      (config_ss_fpga_axi_m1_b_id_sig    ),
    .soc_clk_axi_m1_b_ready   (soc_fpga_intf_axi_m1_b_ready      ),
    .soc_clk_axi_m1_b_resp    (config_ss_fpga_axi_m1_b_resp_sig  ),
    .soc_clk_axi_m1_b_valid   (config_ss_fpga_axi_m1_b_valid_sig ),
    .soc_clk_axi_m1_r_data    (config_ss_fpga_axi_m1_r_data_sig  ),
    .soc_clk_axi_m1_r_id      (config_ss_fpga_axi_m1_r_id_sig    ),
    .soc_clk_axi_m1_r_last    (config_ss_fpga_axi_m1_r_last_sig  ),
    .soc_clk_axi_m1_r_ready   (soc_fpga_intf_axi_m1_r_ready      ),
    .soc_clk_axi_m1_r_resp    (config_ss_fpga_axi_m1_r_resp_sig  ),
    .soc_clk_axi_m1_r_valid   (config_ss_fpga_axi_m1_r_valid_sig ),
    .soc_clk_axi_m1_w_data    (soc_fpga_intf_axi_m1_w_data       ),
    .soc_clk_axi_m1_w_last    (soc_fpga_intf_axi_m1_w_last       ),
    .soc_clk_axi_m1_w_ready   (config_ss_fpga_axi_m1_w_ready_sig ),
    .soc_clk_axi_m1_w_strb    (soc_fpga_intf_axi_m1_w_strb       ),
    .soc_clk_axi_m1_w_valid   (soc_fpga_intf_axi_m1_w_valid      ),
    
    .soc_clk_irq_src          (soc_fpga_intf_fpga_irq_src_sig    ),
    .soc_clk_irq_set          (soc_fpga_intf_fpga_irq_set_sig    ),
    
    .soc_clk_dma_req          (soc_fpga_intf_dma_req_fpga_sig    ),
    .soc_clk_dma_ack          (soc_fpga_intf_dma_ack_fpga_sig    ),
    
    .soc_ace_vstart           (acpu_ss_ace_vstart                ),
    .soc_ace_istart           (acpu_ss_ace_istart                ),
    .soc_ace_divalid          (acpu_ss_ace_divalid               ),
    .soc_ace_doready          (acpu_ss_ace_doready               ),
    .soc_ace_dinop            (acpu_ss_ace_dinop                 ),
    .soc_ace_dovalid          (acpu_ss_ace_dovalid               ),
    .soc_ace_vbreak           (acpu_ss_ace_vbreak                ),
    .soc_ace_diready          (acpu_ss_ace_diready               ),
    .soc_ace_doutop           (acpu_ss_ace_doutop                ),
    
    .clk_xtal_ref             (clk_xtal_ref                      ),
    .clk_osc                  (clk_osc                           ),
    .clk_fpga_ref1            (clk_fpga_ref1                     ),
    .clk_fpga_ref2            (clk_fpga_ref2                     ),
    .clk_fpga_ref3            (clk_fpga_ref3                     ),
    .clk_fpga_ref4            (clk_fpga_ref4                     ),
    .clk_fpga_pll0_ref        (clk_fpga_pll0_ref                 ),
    .clk_fpga_pll1_ref        (clk_fpga_pll1_ref                 ),
    .clk_fpga_pll2_ref        (clk_fpga_pll2_ref                 ),
    .clk_fpga_pll3_ref        (clk_fpga_pll3_ref                 ),
    .fpga_pll3_clk_sel        (fpga_pll3_clk_sel                 ),
    .fpga_pll2_clk_sel        (fpga_pll2_clk_sel                 ),
    .fpga_pll1_clk_sel        (fpga_pll1_clk_sel                 ),
    .fpga_pll0_clk_sel        (fpga_pll0_clk_sel                 ),

    .cfg_done                 (cfg_done                          )
);
*/
    // connections exported to local TOP
    assign rst_n_fpga0        = config_ss_rst_n_fpga0_sig;
    assign rst_n_fpga1        = config_ss_rst_n_fpga1_sig;
    assign rst_n_fpga_s       = config_ss_rst_n_fpga_s_sig;
    assign scl_o              = config_ss_scl_o_sig;
    assign spi_clk_oe         = config_ss_spi_clk_oe_sig;
    assign spi_clk_out        = config_ss_spi_clk_out_sig;
    assign gpio_pulldown      = config_ss_gpio_pulldown_sig;
    assign gpio_pullup        = config_ss_gpio_pullup_sig;
    assign rgmii_txd          = config_ss_rgmii_txd_sig;
    assign rgmii_tx_ctl       = config_ss_rgmii_tx_ctl_sig;
    assign mdio_mdc           = config_ss_mdio_mdc_sig;
    assign mdio_out           = config_ss_gbe_mdio_out_sig;
    assign mdio_en            = config_ss_gbe_mdio_en_sig;
    assign jtag_control       = config_ss_jtag_control_sig;
    assign acpu_jtag_tdo      = acpu_jtag_tdo_sig;
    assign bcpu_jtag_tdo      = config_ss_bcpu_jtag_tdo_sig;
    assign ace_isolation_ctl  = config_ss_ace_isolation_ctl_sig;
    assign irq_isolation_ctl  = config_ss_irq_isolation_ctl_sig;
    assign fcb_isolation_ctl  = config_ss_fcb_isolation_ctl_sig;
    assign ahb_isolation_ctl  = config_ss_ahb_isolation_ctl_sig;
    assign axi1_isolation_ctl = config_ss_axi1_isolation_ctl_sig;
    assign axi0_isolation_ctl = config_ss_axi0_isolation_ctl_sig;
    // ATB
    assign atid[7]            = 'h0;
    // temporary connection
    assign acpu_ss_ace_vstart  = 'h0;
    assign acpu_ss_ace_istart  = 'h0;
    assign acpu_ss_ace_divalid = 'h0;
    assign acpu_ss_ace_doready = 'h0;
    assign acpu_ss_ace_dinop   = 'h0;

 

endmodule
