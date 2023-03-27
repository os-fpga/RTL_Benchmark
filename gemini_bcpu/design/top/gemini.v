//-----------------------------------------------------------------------------
//	RapidSilicon
//	Author:	Pankil Patel
//	Date:	6/5/2022
//-----------------------------------------------------------------------------
`include "castor_define.sv"
`include "ahb_if.sv"

module gemini (
	inout				RST_N,
	inout				XIN,
	inout				REF_CLK_1,
	inout				REF_CLK_2,
	inout				REF_CLK_3,
	inout				REF_CLK_4,
	inout				TESTMODE,
	inout				BOOTM0,
	inout				BOOTM1,
	inout				BOOTM2,
	inout				CLKSEL_0,
	inout				CLKSEL_1,
	inout				JTAG_TDI,
	inout				JTAG_TDO,
	inout				JTAG_TMS,
	inout				JTAG_TCK,
	inout				JTAG_TRSTN,
//FPGA Dedicated GPIO
	inout				GPIO_A_0,
	inout				GPIO_A_1,
	inout				GPIO_A_2,
	inout				GPIO_A_3,
	inout				GPIO_A_4,
	inout				GPIO_A_5,
	inout				GPIO_A_6,
	inout				GPIO_A_7,
	inout				GPIO_A_8,
	inout				GPIO_A_9,
	inout				GPIO_A_10,
	inout				GPIO_A_11,
	inout				GPIO_A_12,
	inout				GPIO_A_13,
	inout				GPIO_A_14,
	inout				GPIO_A_15,
//GPIO and Alt func IO
	inout				GPIO_B_0,
	inout				GPIO_B_1,
	inout				GPIO_B_2,
	inout				GPIO_B_3,
	inout				GPIO_B_4,
	inout				GPIO_B_5,
	inout				GPIO_B_6,
	inout				GPIO_B_7,
	inout				GPIO_B_8,
	inout				GPIO_B_9,
	inout				GPIO_B_10,
	inout				GPIO_B_11,
	inout				GPIO_B_12,
	inout				GPIO_B_13,
	inout				GPIO_B_14,
	inout				GPIO_B_15,
	inout				GPIO_C_0,
	inout				GPIO_C_1,
	inout				GPIO_C_2,
	inout				GPIO_C_3,
	inout				GPIO_C_4,
	inout				GPIO_C_5,
	inout				GPIO_C_6,
	inout				GPIO_C_7,
	inout				GPIO_C_8,
	inout				GPIO_C_9,
	inout				GPIO_C_10,
	inout				GPIO_C_11,
	inout				GPIO_C_12,
	inout				GPIO_C_13,
	inout				GPIO_C_14,
	inout				GPIO_C_15,
	inout				I2C_SCL,
	inout				SPI_SCLK,
	inout				GPT_RTC,
//RGMII IO
	inout				MDIO_MDC,
	inout				MDIO_DATA,
	inout				RGMII_TXD0,
	inout				RGMII_TXD1,
	inout				RGMII_TXD2,
	inout				RGMII_TXD3,
	inout				RGMII_TX_CTL,
	inout				RGMII_TXC,
	inout				RGMII_RXD0,
	inout				RGMII_RXD1,
	inout				RGMII_RXD2,
	inout				RGMII_RXD3,
	inout				RGMII_RX_CTL,
	inout				RGMII_RXC,
//USB IO
	inout				USB_DP,
	inout				USB_DN,
	inout				USB_XTAL_OUT,
	inout				USB_XTAL_IN,
//DDR IO
	inout				PAD_MEM_DQS_N_0,
	inout				PAD_MEM_DQS_N_1,
	inout				PAD_MEM_DQS_N_2,
	inout				PAD_MEM_DQS_N_3,
	inout				PAD_MEM_DQS_0,
	inout				PAD_MEM_DQS_1,
	inout				PAD_MEM_DQS_2,
	inout				PAD_MEM_DQS_3,
	inout				PAD_MEM_DQ_0,
	inout				PAD_MEM_DQ_1,
	inout				PAD_MEM_DQ_2,
	inout				PAD_MEM_DQ_3,
	inout				PAD_MEM_DQ_4,
	inout				PAD_MEM_DQ_5,
	inout				PAD_MEM_DQ_6,
	inout				PAD_MEM_DQ_7,
	inout				PAD_MEM_DQ_8,
	inout				PAD_MEM_DQ_9,
	inout				PAD_MEM_DQ_10,
	inout				PAD_MEM_DQ_11,
	inout				PAD_MEM_DQ_12,
	inout				PAD_MEM_DQ_13,
	inout				PAD_MEM_DQ_14,
	inout				PAD_MEM_DQ_15,
	inout				PAD_MEM_DQ_16,
	inout				PAD_MEM_DQ_17,
	inout				PAD_MEM_DQ_18,
	inout				PAD_MEM_DQ_19,
	inout				PAD_MEM_DQ_20,
	inout				PAD_MEM_DQ_21,
	inout				PAD_MEM_DQ_22,
	inout				PAD_MEM_DQ_23,
	inout				PAD_MEM_DQ_24,
	inout				PAD_MEM_DQ_25,
	inout				PAD_MEM_DQ_26,
	inout				PAD_MEM_DQ_27,
	inout				PAD_MEM_DQ_28,
	inout				PAD_MEM_DQ_29,
	inout				PAD_MEM_DQ_30,
	inout				PAD_MEM_DQ_31,
	inout				PAD_MEM_DM_0,
	inout				PAD_MEM_DM_1,
	inout				PAD_MEM_DM_2,
	inout				PAD_MEM_DM_3,
	inout				PAD_MEM_CLK_0,
	inout				PAD_MEM_CLK_1,
	inout				PAD_MEM_CLK_N_0,
	inout				PAD_MEM_CLK_N_1,
	inout				PAD_MEM_CTL_0,
	inout				PAD_MEM_CTL_1,
	inout				PAD_MEM_CTL_2,
	inout				PAD_MEM_CTL_3,
	inout				PAD_MEM_CTL_4,
	inout				PAD_MEM_CTL_5,
	inout				PAD_MEM_CTL_6,
	inout				PAD_MEM_CTL_7,
	inout				PAD_MEM_CTL_8,
	inout				PAD_MEM_CTL_9,
	inout				PAD_MEM_CTL_10,
	inout				PAD_MEM_CTL_11,
	inout				PAD_MEM_CTL_12,
	inout				PAD_MEM_CTL_13,
	inout				PAD_MEM_CTL_14,
	inout				PAD_MEM_CTL_15,
	inout				PAD_MEM_CTL_16,
	inout				PAD_MEM_CTL_17,
	inout				PAD_MEM_CTL_18,
	inout				PAD_MEM_CTL_19,
	inout				PAD_MEM_CTL_20,
	inout				PAD_MEM_CTL_21,
	inout				PAD_MEM_CTL_22,
	inout				PAD_MEM_CTL_23,
	inout				PAD_MEM_CTL_24,
	inout				PAD_MEM_CTL_25,
	inout				PAD_MEM_CTL_26,
	inout				PAD_MEM_CTL_27,
	inout				PAD_MEM_CTL_28,
	inout				PAD_MEM_CTL_29
	);
// ahb_if.init #(.AW(32),
//          .DW(32)) fpga_ahb_s0()  ;

wire 	[ 2:0] 			soc_pll_ctl_dskewcalcnt    ;
wire 	[11:0] 			soc_pll_ctl_dskewcalin     ;
wire 	[ 3:0] 			soc_pll_ctl_fouten         ;
wire 	[ 4:0] 			soc_pll_ctl_foutvcobyp     ;
wire 	[ 5:0] 			soc_pll_ctl_refdiv         ;
wire 	[23:0] 			soc_pll_ctl_frac           ;
wire 	[ 3:0] 			soc_pll_ctl_postdiv0       ;
wire 	[ 3:0] 			soc_pll_ctl_postdiv1       ;
wire 	[ 3:0] 			soc_pll_ctl_postdiv2       ;
wire 	[ 3:0] 			soc_pll_ctl_postdiv3       ;
wire 	[11:0] 			soc_pll_ctl_fbdiv          ;
wire 	[31:0] 			gpio_pulldown              ;
wire 	[31:0] 			gpio_pullup                ;
wire 	[31:0] 			fcb_out                    ;
wire 	[31:0] 			pad_pu                     ;
wire 	[31:0] 			pad_pd                     ;
wire 	[31:0] 			pad_i                      ;
wire 	[31:0] 			pad_oen                    ;
wire 	[31:0] 			pad_ds0                    ;
wire 	[31:0] 			pad_ds1                    ;
wire 	[ 1:0] 			jtag_control               ;
wire 	[15:0] 			atdata                     ;
wire 	[ 7:0] 			atid                       ;
wire 	[18:0] 			mem_a                      ;
wire 	[ 1:0] 			mem_ba                     ;
wire 	[ 1:0] 			mem_bg                     ;
wire 	[ 1:0] 			mem_cke                    ;
wire 	[ 1:0] 			mem_clk                    ;
wire 	[ 1:0] 			mem_clk_n                  ;
wire 	[ 1:0] 			mem_cs                     ;
wire 	[ 1:0] 			mem_odt                    ;
wire 	[11:0] 			fpga_irq_set               ;
wire 	[ 3:0] 			dma_ack_fpga               ;
wire 	[31:0] 			pwdata                     ;
wire 	[31:0] 			fpga_ahb_s0_haddr          ;
wire 	[ 2:0] 			fpga_ahb_s0_hburst         ;
wire 	       			fpga_ahb_s0_hmastlock      ;
wire 	[ 3:0] 			fpga_ahb_s0_hprot          ;
wire 	[31:0] 			fpga_ahb_s0_hrdata         ;
wire 	       			fpga_ahb_s0_hready         ;
wire 	       			fpga_ahb_s0_hresp          ;
wire 	       			fpga_ahb_s0_hsel           ;
wire 	[ 2:0] 			fpga_ahb_s0_hsize          ;
wire 	[ 1:0] 			fpga_ahb_s0_htrans         ;
wire 	[ 3:0] 			fpga_ahb_s0_hwbe           ;
wire 	[31:0] 			fpga_ahb_s0_hwdata         ;
wire 	       			fpga_ahb_s0_hwrite         ;
wire 	[31:0] 			fpga_axi_m0_ar_addr        ;
wire 	[ 1:0] 			fpga_axi_m0_ar_burst       ;
wire 	[ 3:0] 			fpga_axi_m0_ar_cache       ;
wire 	[ 3:0] 			fpga_axi_m0_ar_id          ;
wire 	[ 2:0] 			fpga_axi_m0_ar_len         ;
wire 	       			fpga_axi_m0_ar_lock        ;
wire 	[ 2:0] 			fpga_axi_m0_ar_prot        ;
wire 	       			fpga_axi_m0_ar_ready       ;
wire 	[ 2:0] 			fpga_axi_m0_ar_size        ;
wire 	       			fpga_axi_m0_ar_valid       ;
wire 	[31:0] 			fpga_axi_m0_aw_addr        ;
wire 	[ 1:0] 			fpga_axi_m0_aw_burst       ;
wire 	[ 3:0] 			fpga_axi_m0_aw_cache       ;
wire 	[ 3:0] 			fpga_axi_m0_aw_id          ;
wire 	[ 2:0] 			fpga_axi_m0_aw_len         ;
wire 	       			fpga_axi_m0_aw_lock        ;
wire 	[ 2:0] 			fpga_axi_m0_aw_prot        ;
wire 	       			fpga_axi_m0_aw_ready       ;
wire 	[ 2:0] 			fpga_axi_m0_aw_size        ;
wire 	       			fpga_axi_m0_aw_valid       ;
wire 	[ 3:0] 			fpga_axi_m0_b_id           ;
wire 	       			fpga_axi_m0_b_ready        ;
wire 	[ 1:0] 			fpga_axi_m0_b_resp         ;
wire 	       			fpga_axi_m0_b_valid        ;
wire 	[63:0] 			fpga_axi_m0_r_data         ;
wire 	[ 3:0] 			fpga_axi_m0_r_id           ;
wire 	       			fpga_axi_m0_r_last         ;
wire 	       			fpga_axi_m0_r_ready        ;
wire 	[ 1:0] 			fpga_axi_m0_r_resp         ;
wire 	       			fpga_axi_m0_r_valid        ;
wire 	[63:0] 			fpga_axi_m0_w_data         ;
wire 	       			fpga_axi_m0_w_last         ;
wire 	       			fpga_axi_m0_w_ready        ;
wire 	[ 7:0] 			fpga_axi_m0_w_strb         ;
wire 	       			fpga_axi_m0_w_valid        ;
wire 	[31:0] 			fpga_axi_m1_ar_addr        ;
wire 	[ 1:0] 			fpga_axi_m1_ar_burst       ;
wire 	[ 3:0] 			fpga_axi_m1_ar_cache       ;
wire 	[ 3:0] 			fpga_axi_m1_ar_id          ;
wire 	[ 3:0] 			fpga_axi_m1_ar_len         ;
wire 	       			fpga_axi_m1_ar_lock        ;
wire 	[ 2:0] 			fpga_axi_m1_ar_prot        ;
wire 	       			fpga_axi_m1_ar_ready       ;
wire 	[ 2:0] 			fpga_axi_m1_ar_size        ;
wire 	       			fpga_axi_m1_ar_valid       ;
wire 	[31:0] 			fpga_axi_m1_aw_addr        ;
wire 	[ 1:0] 			fpga_axi_m1_aw_burst       ;
wire 	[ 3:0] 			fpga_axi_m1_aw_cache       ;
wire 	[ 3:0] 			fpga_axi_m1_aw_id          ;
wire 	[ 3:0] 			fpga_axi_m1_aw_len         ;
wire 	       			fpga_axi_m1_aw_lock        ;
wire 	[ 2:0] 			fpga_axi_m1_aw_prot        ;
wire 	       			fpga_axi_m1_aw_ready       ;
wire 	[ 2:0] 			fpga_axi_m1_aw_size        ;
wire 	       			fpga_axi_m1_aw_valid       ;
wire 	[ 3:0] 			fpga_axi_m1_b_id           ;
wire 	       			fpga_axi_m1_b_ready        ;
wire 	[ 1:0] 			fpga_axi_m1_b_resp         ;
wire 	       			fpga_axi_m1_b_valid        ;
wire 	[31:0] 			fpga_axi_m1_r_data         ;
wire 	[ 3:0] 			fpga_axi_m1_r_id           ;
wire 	       			fpga_axi_m1_r_last         ;
wire 	       			fpga_axi_m1_r_ready        ;
wire 	[ 1:0] 			fpga_axi_m1_r_resp         ;
wire 	       			fpga_axi_m1_r_valid        ;
wire 	[31:0] 			fpga_axi_m1_w_data         ;
wire 	       			fpga_axi_m1_w_last         ;
wire 	       			fpga_axi_m1_w_ready        ;
wire 	[ 3:0] 			fpga_axi_m1_w_strb         ;
wire 	       			fpga_axi_m1_w_valid        ;


	/*********** Gear Box *******************/
/*
	generate
	for (genvar i=0; i < `FAB_GBOX_NUM; i+1)  begin:
	 //gbox_top #(.PAR_GBOX_DWID(`GBOX_DWID) ) u_gbox_top
	 gbox_top u_gbox_top
	 ( 
	   .rst_n (rst_n) , 
	   .fast_clk ( ), 
	   .fast_data_in (pad2core_data),  // high speed serial data in from LVDS IO
	   .slow_clk( f2gbox_clk[i]) ,      // 
	   .slow_data_in (fab2gbox_dbus) ,  // slow data bus from Fabric
	   .fast_data_out ( gbox2io_bit_out[i]) , // high speed serial data out to LVDS IO
	   .slow_data_out ( gbox2fab_dbus[i] ) ; // slow data bus to Fabric
	  );
	 end
	endgenerate
*/
	/*********** Castor Top Module *******************/	
	castor_top	castor_inst(
   .rst_n                    (rst_n),
   .cfg_rst_n                (cfg_rst_n),
   .scan_rst_n               (scan_rst_n),
   .cfg_tbufen_reset_n       (cfg_tbufen_reset_n),
   .scan_en                  (scan_en),
   .scan_mode                (scan_mode),
   .scan_clk                 (scan_clk),
   .clk                	     (clk),
   .scan_read                (scan_read),
   .scan_write               (scan_write),
   .scan_i   		     (scan_i),
   .scan_cfg_done            (scan_cfg_done),
   .cfg_blsr_region_0_wen    (cfg_blsr_region_0_wen),
   .cfg_blsr_region_0_ren    (cfg_blsr_region_0_ren),
   .cfg_blsr_region_0_clk    (cfg_blsr_region_0_clk),
   .cfg_wlsr_region_0_ren    (cfg_wlsr_region_0_ren),
   .cfg_wlsr_region_0_wen    (cfg_wlsr_region_0_wen),
   .cfg_wlsr_region_0_clk    (cfg_wlsr_region_0_clk),
   .cfg_blsr_head_region_0   (cfg_blsr_head_region_0),
   .cfg_wlsr_head_region_0   (cfg_wlsr_head_region_0),
   .cfg_done                 (cfg_done),
   .cfg_tbufen_set_n         (cfg_tbufen_set_n),
   .cfg_wlen_r               (cfg_wlen_r),
   .pl_init	             (pl_init	),
   .pl_ena	             (pl_ena	),
   .pl_wen     		     (pl_wen),
   .pl_ren	             (pl_ren	),
   .pl_addr   		     (pl_addr),
   .pl_data   	 	     (pl_data),
   .a2f_irq_set              (a2f_irq_set),
   .a2f_dma_ack              (a2f_dma_ack),
   .gbox2fab_dbus	     (gbox2fab_dbus),
   .pl_data_out              (pl_data_out),
   .f2a_irq_src              (f2a_irq_src),
   .f2a_dma_req              (f2a_dma_req),
   .fab2gbox_dbus            (fab2gbox_dbus),
   .f2gbox_clk               (f2gbox_clk),
   .fab_io_ie                (fab_io_ie),
   .fab_io_oe                (fab_io_oe),
   .fab_io_pe                (fab_io_pe),
   .fab_io_pud               (fab_io_pud),
   .fab_io_aic               (fab_io_aic),
   .fab_io_ds                (fab_io_ds),
   .fab_io_sr                (fab_io_sr),
   .fab_io_mc                (fab_io_mc),
   .w_blsr_tail              (w_blsr_tail),
   .cfg_blsr_tail_region_0   (cfg_blsr_tail_region_0),
   .cfg_wlsr_tail_region_0   (cfg_wlsr_tail_region_0),
   .scan_o  		     (scan_o)
) ;
	/*********** SOC Subsystem ***********/	
assign fpga_axi_m0_ar_addr[31:0] = 32'b0;
assign fpga_axi_m0_ar_burst[1:0] = 2'b0;
assign fpga_axi_m0_ar_cache[3:0] = 4'b0;
assign fpga_axi_m0_ar_id[3:0] = 4'b0;
assign fpga_axi_m0_ar_len[2:0] = 3'b0;
assign fpga_axi_m0_ar_lock = 1'b0;
assign fpga_axi_m0_ar_prot[2:0] = 3'b0;
assign fpga_axi_m0_ar_size[2:0] = 3'b0;
assign fpga_axi_m0_ar_valid = 1'b0;
assign fpga_axi_m0_aw_addr[31:0] = 32'b0;
assign fpga_axi_m0_aw_burst[1:0] = 2'b0;
assign fpga_axi_m0_aw_cache[3:0] = 4'b0;
assign fpga_axi_m0_aw_id[3:0] = 4'b0;
assign fpga_axi_m0_aw_len[2:0] = 3'b0;
assign fpga_axi_m0_aw_lock = 1'b0;
assign fpga_axi_m0_aw_prot[2:0] = 3'b0;
assign fpga_axi_m0_aw_size[2:0] = 3'b0;
assign fpga_axi_m0_aw_valid = 1'b0;
assign fpga_axi_m0_b_ready = 1'b0;
assign fpga_axi_m0_r_ready = 1'b0;
assign fpga_axi_m0_w_data[63:0] = 64'b0;
assign fpga_axi_m0_w_last = 1'b0;
assign fpga_axi_m0_w_strb[7:0] = 8'b0;
assign fpga_axi_m0_w_valid = 1'b0;
assign fpga_axi_m1_ar_addr[31:0] = 32'b0;
assign fpga_axi_m1_ar_burst[1:0] = 2'b0;
assign fpga_axi_m1_ar_cache[3:0] = 4'b0;
assign fpga_axi_m1_ar_id[3:0] = 4'b0;
assign fpga_axi_m1_ar_len[3:0] = 4'b0;
assign fpga_axi_m1_ar_lock = 1'b0;
assign fpga_axi_m1_ar_prot[2:0] = 3'b0;
assign fpga_axi_m1_ar_size[2:0] = 3'b0;
assign fpga_axi_m1_ar_valid = 1'b0;
assign fpga_axi_m1_aw_addr[31:0] = 32'b0;
assign fpga_axi_m1_aw_burst[1:0] = 2'b0;
assign fpga_axi_m1_aw_cache[3:0] = 4'b0;
assign fpga_axi_m1_aw_id[3:0] = 4'b0;
assign fpga_axi_m1_aw_len[3:0] = 4'b0;
assign fpga_axi_m1_aw_lock = 1'b0;
assign fpga_axi_m1_aw_prot[2:0] = 3'b0;
assign fpga_axi_m1_aw_size[2:0] = 3'b0;
assign fpga_axi_m1_aw_valid = 1'b0;
assign fpga_axi_m1_b_ready = 1'b0;
assign fpga_axi_m1_r_ready = 1'b0;
assign fpga_axi_m1_w_data[31:0] = 32'b0;
assign fpga_axi_m1_w_last = 1'b0;
assign fpga_axi_m1_w_strb[3:0] = 4'b0;
assign fpga_axi_m1_w_valid = 1'b0;

	soc_ss	soc_inst(
   // input OSC clock
   .clk_osc                    (1'b0                    ), //To be Fixed
   // input PLL clocks
   .clk_soc_pll0               (1'b0               ),	//To be Fixed or removed
   .clk_soc_pll1               (1'b0               ),	//To be Fixed or removed
   // input FPGA clocks
   .clk_fpga0                  (1'b0               ),
   .clk_fpga1                  (1'b0               ),
   .clk_fpga_s                 (1'b0               ),
   .rst_n_fpga0                (               ),
   .rst_n_fpga1                (               ),
   .rst_n_fpga_s               (               ),
   // pll control signals
   .soc_pll_ctl_dacen          (soc_pll_ctl_dacen          ),
   .soc_pll_ctl_dskewcalbyp    (soc_pll_ctl_dskewcalbyp    ),
   .soc_pll_ctl_dskewcalcnt    (soc_pll_ctl_dskewcalcnt    ),
   .soc_pll_ctl_dskewcalen     (soc_pll_ctl_dskewcalen     ),
   .soc_pll_ctl_dskewcalin     (soc_pll_ctl_dskewcalin     ),
   .soc_pll_ctl_dskewfastcal   (soc_pll_ctl_dskewfastcal   ),
   .soc_pll_ctl_dsmen          (soc_pll_ctl_dsmen          ),
   .soc_pll_ctl_pllen          (soc_pll_ctl_pllen          ),
   .soc_pll_ctl_fouten         (soc_pll_ctl_fouten         ),
   .soc_pll_ctl_foutvcobyp     (soc_pll_ctl_foutvcobyp     ),
   .soc_pll_ctl_foutvcoen      (soc_pll_ctl_foutvcoen      ),
   .soc_pll_ctl_refdiv         (soc_pll_ctl_refdiv         ),
   .soc_pll_ctl_frac           (soc_pll_ctl_frac           ),
   .soc_pll_ctl_postdiv0       (soc_pll_ctl_postdiv0       ),
   .soc_pll_ctl_postdiv1       (soc_pll_ctl_postdiv1       ),
   .soc_pll_ctl_postdiv2       (soc_pll_ctl_postdiv2       ),
   .soc_pll_ctl_postdiv3       (soc_pll_ctl_postdiv3       ),
   .soc_pll_ctl_fbdiv          (soc_pll_ctl_fbdiv          ),
    // pll status signals
   .soc_pll_status_dskewcalout (12'b0 ),
   .soc_pll_status_dskewcallock(1'b0),
   .soc_pll_status_lock        (1'b0),
    // I2C interface signals
   .scl_o                      (scl_o                      ),
    // QSPI interface signals
   .spi_clk_oe                 (spi_clk_oe                 ),
   .spi_clk_out                (spi_clk_out                ),
    // GPIO interface signals
   .gpio_pulldown              (gpio_pulldown              ),
   .gpio_pullup                (gpio_pullup                ),
   .pit_pause                  (1'b0                  ),
    // GbE interface signals
   .mdio_mdc                   (mdio_mdc                   ),
    // USB interface signals
   .usb_dp                     (USB_DP               ),
   .usb_dn                     (               ),
   .usb_xtal_in                (1'b0               ),
   .usb_xtal_out               (usb_xtal_out               ),
    // FCB interface signals
   .fcb_out                    (fcb_out                    ),
    // PAD control
   .pad_c                      (32'b0                      ),
   .pad_pu                     (pad_pu                     ),
   .pad_pd                     (pad_pd                     ),
   .pad_i                      (pad_i                      ),
   .pad_oen                    (pad_oen                    ),
   .pad_ds0                    (pad_ds0                    ),
   .pad_ds1                    (pad_ds1                    ),
    // JTAG intf
   .jtag_control               (jtag_control               ),
   .acpu_jtag_tck              (1'b0              ),
   .acpu_jtag_tdi              (1'b0              ),
   .acpu_jtag_tdo              (acpu_jtag_tdo              ),
   .acpu_jtag_tms              (1'b0              ),
   .bcpu_jtag_tck              (1'b0              ),
   .bcpu_jtag_tdi              (1'b0              ),
   .bcpu_jtag_tdo              (bcpu_jtag_tdo              ),
   .bcpu_jtag_tms              (1'b0              ),
    // ATB interface
   .atclk                      (1'b0                   ),
   .atclken                    (1'b0                   ),
   .atresetn                   (1'b0                   ),
   .atbytes                    (atbytes                    ),
   .atdata                     (atdata                     ),
   .atid                       (atid                       ),
   .atready                    (1'b0                    ),
   .atvalid                    (atvalid                    ),
   .afvalid                    (1'b0                    ),
   .afready                    (afready                    ),
    // DDR interface
   .mem_a                      (mem_a                      ),
   .mem_act_n                  (mem_act_n                  ),
   .mem_ba                     (mem_ba                     ),
   .mem_bg                     (mem_bg                     ),
   .mem_cke                    (mem_cke                    ),
   .mem_clk                    (mem_clk                    ),
   .mem_clk_n                  (mem_clk_n                  ),
   .mem_cs                     (mem_cs                     ),
   .mem_odt                    (mem_odt                    ),
   .mem_reset_n                (mem_reset_n                ),
   .dm                         (                        ),
   .dq                         (                         ),
   .dqs                        (                       ),
   .dqs_n                      (                     ),
    // FPGA signals
    //interrupts
   .fpga_irq_src               (16'b0               ),
   .fpga_irq_set               (fpga_irq_set               ),
    // DMA request/acknowledge pairs for FPGA hardware handshake
   .dma_req_fpga               (4'b0               ),
   .dma_ack_fpga               (dma_ack_fpga               ),

    // FPGA AHB Slave
   .fpga_ahb_s0_haddr          (fpga_ahb_s0_haddr          ),
   .fpga_ahb_s0_hburst         (fpga_ahb_s0_hburst         ),
   .fpga_ahb_s0_hmastlock      (fpga_ahb_s0_hmastlock      ),
   .fpga_ahb_s0_hprot          (fpga_ahb_s0_hprot          ),
   .fpga_ahb_s0_hrdata         (32'b0         ),
   .fpga_ahb_s0_hready         (1'b0         ),
   .fpga_ahb_s0_hresp          (1'b0         ),
   .fpga_ahb_s0_hsel           (fpga_ahb_s0_hsel           ),
   .fpga_ahb_s0_hsize          (fpga_ahb_s0_hsize          ),
   .fpga_ahb_s0_htrans         (fpga_ahb_s0_htrans         ),
   .fpga_ahb_s0_hwbe           (fpga_ahb_s0_hwbe           ),
   .fpga_ahb_s0_hwdata         (fpga_ahb_s0_hwdata         ),
   .fpga_ahb_s0_hwrite         (fpga_ahb_s0_hwrite         ),
    // FPGA AXI Master 0
   .fpga_axi_m0_ar_addr        (fpga_axi_m0_ar_addr        ),
   .fpga_axi_m0_ar_burst       (fpga_axi_m0_ar_burst       ),
   .fpga_axi_m0_ar_cache       (fpga_axi_m0_ar_cache       ),
   .fpga_axi_m0_ar_id          (fpga_axi_m0_ar_id          ),
   .fpga_axi_m0_ar_len         (fpga_axi_m0_ar_len         ),
   .fpga_axi_m0_ar_lock        (fpga_axi_m0_ar_lock        ),
   .fpga_axi_m0_ar_prot        (fpga_axi_m0_ar_prot        ),
   .fpga_axi_m0_ar_ready       (fpga_axi_m0_ar_ready       ),
   .fpga_axi_m0_ar_size        (fpga_axi_m0_ar_size        ),
   .fpga_axi_m0_ar_valid       (fpga_axi_m0_ar_valid       ),
   .fpga_axi_m0_aw_addr        (fpga_axi_m0_aw_addr        ),
   .fpga_axi_m0_aw_burst       (fpga_axi_m0_aw_burst       ),
   .fpga_axi_m0_aw_cache       (fpga_axi_m0_aw_cache       ),
   .fpga_axi_m0_aw_id          (fpga_axi_m0_aw_id          ),
   .fpga_axi_m0_aw_len         (fpga_axi_m0_aw_len         ),
   .fpga_axi_m0_aw_lock        (fpga_axi_m0_aw_lock        ),
   .fpga_axi_m0_aw_prot        (fpga_axi_m0_aw_prot        ),
   .fpga_axi_m0_aw_ready       (fpga_axi_m0_aw_ready       ),
   .fpga_axi_m0_aw_size        (fpga_axi_m0_aw_size        ),
   .fpga_axi_m0_aw_valid       (fpga_axi_m0_aw_valid       ),
   .fpga_axi_m0_b_id           (fpga_axi_m0_b_id           ),
   .fpga_axi_m0_b_ready        (fpga_axi_m0_b_ready        ),
   .fpga_axi_m0_b_resp         (fpga_axi_m0_b_resp         ),
   .fpga_axi_m0_b_valid        (fpga_axi_m0_b_valid        ),
   .fpga_axi_m0_r_data         (fpga_axi_m0_r_data         ),
   .fpga_axi_m0_r_id           (fpga_axi_m0_r_id           ),
   .fpga_axi_m0_r_last         (fpga_axi_m0_r_last         ),
   .fpga_axi_m0_r_ready        (fpga_axi_m0_r_ready        ),
   .fpga_axi_m0_r_resp         (fpga_axi_m0_r_resp         ),
   .fpga_axi_m0_r_valid        (fpga_axi_m0_r_valid        ),
   .fpga_axi_m0_w_data         (fpga_axi_m0_w_data         ),
   .fpga_axi_m0_w_last         (fpga_axi_m0_w_last         ),
   .fpga_axi_m0_w_ready        (fpga_axi_m0_w_ready        ),
   .fpga_axi_m0_w_strb         (fpga_axi_m0_w_strb         ),
   .fpga_axi_m0_w_valid        (fpga_axi_m0_w_valid        ),
    // FPGA AXI Master 0
   .fpga_axi_m1_ar_addr        (fpga_axi_m1_ar_addr        ),
   .fpga_axi_m1_ar_burst       (fpga_axi_m1_ar_burst       ),
   .fpga_axi_m1_ar_cache       (fpga_axi_m1_ar_cache       ),
   .fpga_axi_m1_ar_id          (fpga_axi_m1_ar_id          ),
   .fpga_axi_m1_ar_len         (fpga_axi_m1_ar_len         ),
   .fpga_axi_m1_ar_lock        (fpga_axi_m1_ar_lock        ),
   .fpga_axi_m1_ar_prot        (fpga_axi_m1_ar_prot        ),
   .fpga_axi_m1_ar_ready       (fpga_axi_m1_ar_ready       ),
   .fpga_axi_m1_ar_size        (fpga_axi_m1_ar_size        ),
   .fpga_axi_m1_ar_valid       (fpga_axi_m1_ar_valid       ),
   .fpga_axi_m1_aw_addr        (fpga_axi_m1_aw_addr        ),
   .fpga_axi_m1_aw_burst       (fpga_axi_m1_aw_burst       ),
   .fpga_axi_m1_aw_cache       (fpga_axi_m1_aw_cache       ),
   .fpga_axi_m1_aw_id          (fpga_axi_m1_aw_id          ),
   .fpga_axi_m1_aw_len         (fpga_axi_m1_aw_len         ),
   .fpga_axi_m1_aw_lock        (fpga_axi_m1_aw_lock        ),
   .fpga_axi_m1_aw_prot        (fpga_axi_m1_aw_prot        ),
   .fpga_axi_m1_aw_ready       (fpga_axi_m1_aw_ready       ),
   .fpga_axi_m1_aw_size        (fpga_axi_m1_aw_size        ),
   .fpga_axi_m1_aw_valid       (fpga_axi_m1_aw_valid       ),
   .fpga_axi_m1_b_id           (fpga_axi_m1_b_id           ),
   .fpga_axi_m1_b_ready        (fpga_axi_m1_b_ready        ),
   .fpga_axi_m1_b_resp         (fpga_axi_m1_b_resp         ),
   .fpga_axi_m1_b_valid        (fpga_axi_m1_b_valid        ),
   .fpga_axi_m1_r_data         (fpga_axi_m1_r_data         ),
   .fpga_axi_m1_r_id           (fpga_axi_m1_r_id           ),
   .fpga_axi_m1_r_last         (fpga_axi_m1_r_last         ),
   .fpga_axi_m1_r_ready        (fpga_axi_m1_r_ready        ),
   .fpga_axi_m1_r_resp         (fpga_axi_m1_r_resp         ),
   .fpga_axi_m1_r_valid        (fpga_axi_m1_r_valid        ),
   .fpga_axi_m1_w_data         (fpga_axi_m1_w_data         ),
   .fpga_axi_m1_w_last         (fpga_axi_m1_w_last         ),
   .fpga_axi_m1_w_ready        (fpga_axi_m1_w_ready        ),
   .fpga_axi_m1_w_strb         (fpga_axi_m1_w_strb         ),
   .fpga_axi_m1_w_valid        (fpga_axi_m1_w_valid        ),
    //FPGA configuration interface
   .clb_sel                    (clb_sel                    ),
   .pwdata                     (pwdata                     ),
   .pready                     (1'b0                     ),
    // isolation cells control
   .ace_isolation_ctl          (ace_isolation_ctl          ),
   .irq_isolation_ctl          (irq_isolation_ctl          ),
   .fcb_isolation_ctl          (fcb_isolation_ctl          ),
   .ahb_isolation_ctl          (ahb_isolation_ctl          ),
   .axi1_isolation_ctl         (axi1_isolation_ctl         ),
   .axi0_isolation_ctl	       (axi0_isolation_ctl	   )
	);


//	soc_ss	soc_inst(
//    // input clock control
//   .clk_sel0                   (clk_sel0                   ),
//   .clk_sel1                   (clk_sel1                   ),
//   // input OSC clock
//   .clk_osc                    (clk_osc                    ),
//   // input ref PLL clock
//   .clk_xtal_ref               (clk_xtal_ref               ),
//   // input PLL clocks
//   .clk_soc_pll0           (pll_clk_0),
//   .clk_soc_pll1           (pll_clk_1),
//   // input power on reset
//   .rst_n_poweron              (rst_n_poweron              ),
//   // input FPGA clocks
//   .clk_fpga0              (config_ss_env_intf.clk_fpga0_intf.clock),
//   .clk_fpga1              (config_ss_env_intf.clk_fpga1_intf.clock),
//   .clk_fpga_s             (config_ss_env_intf.clk_fpga_s_intf.clock),
//   .rst_n_fpga0                (rst_n_fpga0                ),
//   .rst_n_fpga1                (rst_n_fpga1                ),
//   .rst_n_fpga_s               (rst_n_fpga_s               ),
//   // test mode
//   .test_mode              (config_ss_env_intf.test_mode),
//   // pll control signals
//   .soc_pll_ctl_dacen         (config_ss_env_intf.rs_pll_intf.ctl_dacen),
//   .soc_pll_ctl_dskewcalbyp   (config_ss_env_intf.rs_pll_intf.ctl_dskewcalbyp ),
//   .soc_pll_ctl_dskewcalcnt   (config_ss_env_intf.rs_pll_intf.ctl_dskewcalcnt ),
//   .soc_pll_ctl_dskewcalen    (config_ss_env_intf.rs_pll_intf.ctl_dskewcalen  ),
//   .soc_pll_ctl_dskewcalin    (config_ss_env_intf.rs_pll_intf.ctl_dskewcalin  ),
//   .soc_pll_ctl_dskewfastcal  (config_ss_env_intf.rs_pll_intf.ctl_dskewfastcal),
//   .soc_pll_ctl_dsmen         (config_ss_env_intf.rs_pll_intf.ctl_dsmen       ),
//   .soc_pll_ctl_pllen         (config_ss_env_intf.rs_pll_intf.ctl_pllen       ),
//   .soc_pll_ctl_fouten        (config_ss_env_intf.rs_pll_intf.ctl_fouten      ),
//   .soc_pll_ctl_foutvcobyp    (config_ss_env_intf.rs_pll_intf.ctl_foutvcobyp  ),
//   .soc_pll_ctl_foutvcoen     (config_ss_env_intf.rs_pll_intf.ctl_foutvcoen   ),
//   .soc_pll_ctl_refdiv        (config_ss_env_intf.rs_pll_intf.ctl_refdiv      ),
//   .soc_pll_ctl_frac          (config_ss_env_intf.rs_pll_intf.ctl_frac        ),
//   .soc_pll_ctl_postdiv0      (config_ss_env_intf.rs_pll_intf.ctl_postdiv0    ),
//   .soc_pll_ctl_postdiv1      (config_ss_env_intf.rs_pll_intf.ctl_postdiv1    ),
//   .soc_pll_ctl_postdiv2      (config_ss_env_intf.rs_pll_intf.ctl_postdiv2    ),
//   .soc_pll_ctl_postdiv3      (config_ss_env_intf.rs_pll_intf.ctl_postdiv3    ),
//   .soc_pll_ctl_fbdiv         (config_ss_env_intf.rs_pll_intf.ctl_fbdiv       ),
//    // pll status signals
//   .soc_pll_status_dskewcalout (config_ss_env_intf.rs_pll_intf.status_dskewcalout ),
//   .soc_pll_status_dskewcallock(config_ss_env_intf.rs_pll_intf.status_dskewcallock),
//   .soc_pll_status_lock        (config_ss_env_intf.rs_pll_intf.status_lock        ),
//    // I2C interface signals
//   .scl_o                      (scl_o                      ),
//   .scl_i                      (scl_i                      ),
//    // QSPI interface signals
//   .spi_clk_in                 (spi_clk_in                 ),
//   .spi_clk_oe                 (spi_clk_oe                 ),
//   .spi_clk_out                (spi_clk_out                ),
//    // GPIO interface signals
//   .gpio_pulldown              (gpio_pulldown              ),
//   .gpio_pullup                (gpio_pullup                ),
//    // GPT interface signals
//   .rtc_clk                    (rtc_clk                    ),
//   .pit_pause                  (pit_pause                  ),
//    // GbE interface signals
//   .rgmii_txd                  (rgmii_txd                  ),
//   .rgmii_tx_ctl               (rgmii_tx_ctl               ),
//   .rgmii_rxd                  (rgmii_rxd                  ),
//   .rgmii_rx_ctl               (rgmii_rx_ctl               ),
//   .rgmii_rxc                  (rgmii_rxc                  ),
//   .mdio_mdc                   (mdio_mdc                   ),
//   .mdio_data                  (mdio_data                  ),
//    // USB interface signals
//   .usb_dp                     (usb_dp                     ),
//   .usb_dn                     (usb_dn                     ),
//   .usb_xtal_in                (usb_xtal_in                ),
//   .usb_xtal_out               (usb_xtal_out               ),
//    // FCB interface signals
//   .fcb_out                    (fcb_out                    ),
//    // PAD control
//   .pad_c                      (pad_c                      ),
//   .pad_pu                     (pad_pu                     ),
//   .pad_pd                     (pad_pd                     ),
//   .pad_i                      (pad_i                      ),
//   .pad_oen                    (pad_oen                    ),
//   .pad_ds0                    (pad_ds0                    ),
//   .pad_ds1                    (pad_ds1                    ),
//    // JTAG intf
//   .jtag_control               (jtag_control               ),
//   .acpu_jtag_tck              (acpu_jtag_tck              ),
//   .acpu_jtag_tdi              (acpu_jtag_tdi              ),
//   .acpu_jtag_tdo              (acpu_jtag_tdo              ),
//   .acpu_jtag_tms              (acpu_jtag_tms              ),
//   .bcpu_jtag_tck              (bcpu_jtag_tck              ),
//   .bcpu_jtag_tdi              (bcpu_jtag_tdi              ),
//   .bcpu_jtag_tdo              (bcpu_jtag_tdo              ),
//   .bcpu_jtag_tms              (bcpu_jtag_tms              ),
//    // ATB interface
//   .atclk                      (atclk                      ),
//   .atclken                    (atclken                    ),
//   .atresetn                   (atresetn                   ),
//   .atbytes                    (atbytes                    ),
//   .atdata                     (atdata                     ),
//   .atid                       (atid                       ),
//   .atready                    (atready                    ),
//   .atvalid                    (atvalid                    ),
//   .afvalid                    (afvalid                    ),
//   .afready                    (afready                    ),
//    // DDR interface
//   .mem_a                      (mem_a                      ),
//   .mem_act_n                  (mem_act_n                  ),
//   .mem_ba                     (mem_ba                     ),
//   .mem_bg                     (mem_bg                     ),
//   .mem_cke                    (mem_cke                    ),
//   .mem_clk                    (mem_clk                    ),
//   .mem_clk_n                  (mem_clk_n                  ),
//   .mem_cs                     (mem_cs                     ),
//   .mem_odt                    (mem_odt                    ),
//   .mem_reset_n                (mem_reset_n                ),
//   .dm                         (dm                         ),
//   .dq                         (dq                         ),
//   .dqs                        (dqs                        ),
//   .dqs_n                      (dqs_n                      ),
//    // FPGA signals
//    //interrupts
//   .fpga_irq_src               (f2a_irq_src),  // from fab
//   .fpga_irq_set               (a2f_irq_set),
//    // DMA request/acknowledge pairs for FPGA hardware handshake
//   .dma_req_fpga               (f2a_dma_req ),
//   .dma_ack_fpga               (a2f_dma_ack ),
//    // FPGA AHB Slave
//   .fpga_ahb_s0_haddr          (fpga_ahb_s0.haddr ), 
//   .fpga_ahb_s0_hburst         (fpga_ahb_s0.hburst ),
//   .fpga_ahb_s0_hmastlock      (fpga_ahb_s0.hmastlock ),
//   .fpga_ahb_s0_hprot          (fpga_ahb_s0.hprot ),
//   .fpga_ahb_s0_hrdata         (fpga_ahb_s0.hrdata  ), // from Fab
//   .fpga_ahb_s0_hready         (fpga_ahb_s0.hready  ), // from Fab
//   .fpga_ahb_s0_hresp          (fpga_ahb_s0.hresp  ), // from Fab
//   .fpga_ahb_s0_hsel           (fpga_ahb_s0.hsel ),
//   .fpga_ahb_s0_hsize          (fpga_ahb_s0.hsize ),
//   .fpga_ahb_s0_htrans         (fpga_ahb_s0.htrans ),
//   .fpga_ahb_s0_hwbe           (fpga_ahb_s0.hwbe ),
//   .fpga_ahb_s0_hwdata         (fpga_ahb_s0.hwdata ),
//   .fpga_ahb_s0_hwrite         (fpga_ahb_s0.hwrite ),
//   // fpga axi master 0
//   .fpga_axi_m0_ar_addr        (fpga_axi_m0_ar.araddr  ), // from Fab
//   .fpga_axi_m0_ar_burst       (fpga_axi_m0_ar.arburst  ), // from Fab
//   .fpga_axi_m0_ar_cache       (fpga_axi_m0_ar.arcache  ), // from Fab
//   .fpga_axi_m0_ar_id          (fpga_axi_m0_ar.arid  ), // from Fab
//   .fpga_axi_m0_ar_len         (fpga_axi_m0_ar.arlen  ), // from Fab
//   .fpga_axi_m0_ar_lock        (fpga_axi_m0_ar.arlock  ), // from Fab
//   .fpga_axi_m0_ar_prot        (fpga_axi_m0_ar.arprot  ), // from Fab
//   .fpga_axi_m0_ar_ready       (fpga_axi_m0_ar.arready ),
//   .fpga_axi_m0_ar_size        (fpga_axi_m0_ar.arsize  ), // from Fab
//   .fpga_axi_m0_ar_valid       (fpga_axi_m0_ar.arvalid  ), // from Fab
//   .fpga_axi_m0_aw_addr        (fpga_axi_m0_aw.awaddr  ), // from Fab
//   .fpga_axi_m0_aw_burst       (fpga_axi_m0_aw.awburst  ), // from Fab
//   .fpga_axi_m0_aw_cache       (fpga_axi_m0_aw.awcache  ), // from Fab
//   .fpga_axi_m0_aw_id          (fpga_axi_m0_aw.awid  ), // from Fab
//   .fpga_axi_m0_aw_len         (fpga_axi_m0_aw.awlen  ), // from Fab
//   .fpga_axi_m0_aw_lock        (fpga_axi_m0_aw.awlock  ), // from Fab
//   .fpga_axi_m0_aw_prot        (fpga_axi_m0_aw.awprot  ), // from Fab
//   .fpga_axi_m0_aw_ready       (fpga_axi_m0_aw.wready ),
//   .fpga_axi_m0_aw_size        (fpga_axi_m0_aw.awsize  ), // from Fab
//   .fpga_axi_m0_aw_valid       (fpga_axi_m0_aw.awvalid  ), // from Fab
//   .fpga_axi_m0_b_id           (fpga_axi_m0_aw.bid ),
//   .fpga_axi_m0_b_ready        (fpga_axi_m0_aw.bready  ), // from Fab
//   .fpga_axi_m0_b_resp         (fpga_axi_m0_aw.bresp ),
//   .fpga_axi_m0_b_valid        (fpga_axi_m0_aw.bvalid ),
//   .fpga_axi_m0_r_data         (fpga_axi_m0_ar.rdata ),
//   .fpga_axi_m0_r_id           (fpga_axi_m0_ar.rid ),
//   .fpga_axi_m0_r_last         (fpga_axi_m0_ar.rlast ),
//   .fpga_axi_m0_r_ready        (fpga_axi_m0_ar.rready  ), // from Fab
//   .fpga_axi_m0_r_resp         (fpga_axi_m0_ar.rresp ),
//   .fpga_axi_m0_r_valid        (fpga_axi_m0_ar.rvalid ),
//   .fpga_axi_m0_w_data         (fpga_axi_m0_aw.wdata  ), // from Fab
//   .fpga_axi_m0_w_last         (fpga_axi_m0_aw.wlast  ), // from Fab
//   .fpga_axi_m0_w_ready        (fpga_axi_m0_aw.wready ),
//   .fpga_axi_m0_w_strb         (fpga_axi_m0_aw.wstrb  ), // from Fab
//   .fpga_axi_m0_w_valid        (fpga_axi_m0_aw.wvalid ), // from Fab
//   // FPGA AXI Master 1
//   .fpga_axi_m1_ar_addr        (fpga_axi_m1_ar.araddr  ), // from Fab
//   .fpga_axi_m1_ar_burst       (fpga_axi_m1_ar.arburst  ), // from Fab
//   .fpga_axi_m1_ar_cache       (fpga_axi_m1_ar.arcache  ), // from Fab
//   .fpga_axi_m1_ar_id          (fpga_axi_m1_ar.arid  ), // from Fab
//   .fpga_axi_m1_ar_len         (fpga_axi_m1_ar.arlen  ), // from Fab
//   .fpga_axi_m1_ar_lock        (fpga_axi_m1_ar.arlock  ), // from Fab
//   .fpga_axi_m1_ar_prot        (fpga_axi_m1_ar.arprot  ), // from Fab
//   .fpga_axi_m1_ar_ready       (fpga_axi_m1_ar.arready ),
//   .fpga_axi_m1_ar_size        (fpga_axi_m1_ar.arsize  ), // from Fab
//   .fpga_axi_m1_ar_valid       (fpga_axi_m1_ar.arvalid  ), // from Fab
//   .fpga_axi_m1_aw_addr        (fpga_axi_m1_aw.awaddr  ), // from Fab
//   .fpga_axi_m1_aw_burst       (fpga_axi_m1_aw.awburst  ), // from Fab
//   .fpga_axi_m1_aw_cache       (fpga_axi_m1_aw.awcache  ), // from Fab
//   .fpga_axi_m1_aw_id          (fpga_axi_m1_aw.awid  ), // from Fab
//   .fpga_axi_m1_aw_len         (fpga_axi_m1_aw.awlen  ), // from Fab
//   .fpga_axi_m1_aw_lock        (fpga_axi_m1_aw.awlock  ), // from Fab
//   .fpga_axi_m1_aw_prot        (fpga_axi_m1_aw.awprot  ), // from Fab
//   .fpga_axi_m1_aw_ready       (fpga_axi_m1_aw.wready ),
//   .fpga_axi_m1_aw_size        (fpga_axi_m1_aw.awsize  ), // from Fab
//   .fpga_axi_m1_aw_valid       (fpga_axi_m1_aw.awvalid  ), // from Fab
//   .fpga_axi_m1_b_id           (fpga_axi_m1_aw.bid ),
//   .fpga_axi_m1_b_ready        (fpga_axi_m1_aw.bready  ), // from Fab
//   .fpga_axi_m1_b_resp         (fpga_axi_m1_aw.bresp ),
//   .fpga_axi_m1_b_valid        (fpga_axi_m1_aw.bvalid ),
//   .fpga_axi_m1_r_data         (fpga_axi_m1_ar.rdata ),
//   .fpga_axi_m1_r_id           (fpga_axi_m1_ar.rid ),
//   .fpga_axi_m1_r_last         (fpga_axi_m1_ar.rlast ),
//   .fpga_axi_m1_r_ready        (fpga_axi_m1_ar.rready  ), // from Fab
//   .fpga_axi_m1_r_resp         (fpga_axi_m1_ar.rresp ),
//   .fpga_axi_m1_r_valid        (fpga_axi_m1_ar.rvalid ),
//   .fpga_axi_m1_w_data         (fpga_axi_m1_aw.wdata  ), // from Fab
//   .fpga_axi_m1_w_last         (fpga_axi_m1_aw.wlast  ), // from Fab
//   .fpga_axi_m1_w_ready        (fpga_axi_m1_aw.wready ),
//   .fpga_axi_m1_w_strb         (fpga_axi_m1_aw.wstrb  ), // from Fab
//   .fpga_axi_m1_w_valid        (fpga_axi_m1_aw.wvalid ), // from Fab
//    //FPGA configuration interface
//   .clb_sel                    (clb_sel                    ),
//   .pwdata                     (pwdata                     ),
//   .pready                     (pready                     ),
//    // isolation cells control
//   .ace_isolation_ctl          (ace_isolation_ctl          ),
//   .irq_isolation_ctl          (irq_isolation_ctl          ),
//   .fcb_isolation_ctl          (fcb_isolation_ctl          ),
//   .ahb_isolation_ctl          (ahb_isolation_ctl          ),
//   .axi1_isolation_ctl         (axi1_isolation_ctl         ),
//   .axi0_isolation_ctl	       (axi0_isolation_ctl	   )
//	);
	/*********** PLL ***********/	
/*generate
for (genvar i=0; i < `PLL_NUM ; i+1)  begin

pllts16ffcfracf u_pll (
	.rst_por ,  // NA
	.dacen (pll_dacen[i]),
	.dskewcalbyp (pll_dskewcalbyp[i]),
	.dskewcalcnt (pll_dskewcalcnt[i]) ,
	.dskewcalen (pll_dskewcalen[i]) ,
	.dskewcalin (pll_dskewcalin[i]),
	.dskewfastcal (pll_dskewfastcal[i]) ,
	.dsmen (pll_dsmen[i]),
	.fbdiv (pll_fbdiv[i])  ,
	.foutcmlen (pll_foutcmlen[i]) ,
	.foutdiffen (pll_foutdiffen[i]),
	.fouten( pll_fouten[i]),
	.foutvcobyp (pll_foutvcobyp[i]),
	.foutvcoen (pll_foutvcoen[i]) ,
    .frac (pll_frac[i]) ,
    .fref( ref_clk[i]) ,
    .frefcmlen (pll_frefcmlen[i]) ,
    .frefcmln (pll_frefcmln[i]) ,
    .frefcmlp (pll_frefcmlp[i]) ,
    .pllen (pll_pllen[i]) ,
	.postdiv0 (pll_postdiv0[i])    , 
	.postdiv1 (pll_postdiv1[i])    , 
	.postdiv2 (pll_postdiv2[i])    , 
	.postdiv3 (pll_postdiv3[i])    , 
	.postdiv4 (pll_postdiv4[i])    , 
	.refdiv (pll_refdiv[i]) , 
//*****************************
	.clksscg (pll_clksscg[i]) ,
	.dskewcallock(pll_dskewcallock[i])  ,
	.dskewcalout (pll_dskewcalout[i]) ,
	.fout(pll_fout[i])  ,
    .foutcmln (pll_foutcmln[i]) ,
    .foutcmlp (pll_foutcmlp[i]) ,
    .foutdiffn (pll_foutdiffn[i]) ,
    .foutdiffp (pll_foutdiffp[i]) ,
	.foutvco (pll_foutvco[i]) ,
	.lock (pll_lock[i])
);
 end
endgenerate
*/
	/*********** Mode contoller ***********/	
/*	mode_ctrl	mode_ctrl_inst(
			.testmode	(testmode),
			.scanmode	(),
			.bscanmode	(),
			.funcmode	()
	);

*/
	/*********** PADS Module *******************/	
/*	pads		pads_inst(
			.RST_N (RST_N),
			.XIN (XIN),
			.REF_CLK_1 (REF_CLK_1),
			.REF_CLK_2 (REF_CLK_2),
			.REF_CLK_3 (REF_CLK_3),
			.REF_CLK_4 (REF_CLK_4),
			.TESTMODE (TESTMODE),
			.BOOTM0 (BOOTM0),
			.BOOTM1 (BOOTM1),
			.BOOTM2 (BOOTM2),
			.CLKSEL_0 (CLKSEL_0),
			.CLKSEL_1 (CLKSEL_1),
			.JTAG_TDI (JTAG_TDI),
			.JTAG_TDO (JTAG_TDO),
			.JTAG_TMS (JTAG_TMS),
			.JTAG_TCK (JTAG_TCK),
			.JTAG_TRSTN (JTAG_TRSTN),
			.GPIO_B_0 (GPIO_B_0),
			.GPIO_B_1 (GPIO_B_1),
			.GPIO_B_2 (GPIO_B_2),
			.GPIO_B_3 (GPIO_B_3),
			.GPIO_B_4 (GPIO_B_4),
			.GPIO_B_5 (GPIO_B_5),
			.GPIO_B_6 (GPIO_B_6),
			.GPIO_B_7 (GPIO_B_7),
			.GPIO_B_8 (GPIO_B_8),
			.GPIO_B_9 (GPIO_B_9),
			.GPIO_B_10 (GPIO_B_10),
			.GPIO_B_11 (GPIO_B_11),
			.GPIO_B_12 (GPIO_B_12),
			.GPIO_B_13 (GPIO_B_13),
			.GPIO_B_14 (GPIO_B_14),
			.GPIO_B_15 (GPIO_B_15),
			.GPIO_C_0 (GPIO_C_0),
			.GPIO_C_1 (GPIO_C_1),
			.GPIO_C_2 (GPIO_C_2),
			.GPIO_C_3 (GPIO_C_3),
			.GPIO_C_4 (GPIO_C_4),
			.GPIO_C_5 (GPIO_C_5),
			.GPIO_C_6 (GPIO_C_6),
			.GPIO_C_7 (GPIO_C_7),
			.GPIO_C_8 (GPIO_C_8),
			.GPIO_C_9 (GPIO_C_9),
			.GPIO_C_10 (GPIO_C_10),
			.GPIO_C_11 (GPIO_C_11),
			.GPIO_C_12 (GPIO_C_12),
			.GPIO_C_13 (GPIO_C_13),
			.GPIO_C_14 (GPIO_C_14),
			.GPIO_C_15 (GPIO_C_15),
			.I2C_SCL (I2C_SCL),
			.SPI_SCLK (SPI_SCLK),
			.GPT_RTC (GPT_RTC),
			.MDIO_MDC (MDIO_MDC),
			.MDIO_DATA (MDIO_DATA),
			.RGMII_TXD0 (RGMII_TXD0),
			.RGMII_TXD1 (RGMII_TXD1),
			.RGMII_TXD2 (RGMII_TXD2),
			.RGMII_TXD3 (RGMII_TXD3),
			.RGMII_TX_CTL (RGMII_TX_CTL),
			.RGMII_TXC (RGMII_TXC),
			.RGMII_RXD0 (RGMII_RXD0),
			.RGMII_RXD1 (RGMII_RXD1),
			.RGMII_RXD2 (RGMII_RXD2),
			.RGMII_RXD3 (RGMII_RXD3),
			.RGMII_RX_CTL (RGMII_RX_CTL),
			.RGMII_RXC (RGMII_RXC),
			.por (por),
			.xin (xin),
			.testmode (testmode),
			.bootm (bootm),
			.clksel (clksel),
			.jtag_tdi (jtag_tdi),
			.jtag_tdo (1'b0),
			.jtag_tdo_oe (1'b0),
			.jtag_tms (jtag_tms),
			.jtag_tck (jtag_tck),
			.jtag_trstn (jtag_trstn),
			.i2c_scl (i2c_scl),
			.spi_clk (spi_clk),
			.rtc_clk (rtc_clk),
			.rgmii_txd (rgmii_txd),
			.rgmii_tx_ctl (rgmii_tx_ctl),
			.rgmii_txc (1'b0),
			.rgmii_rxd (rgmii_rxd),
			.rgmii_rx_ctl (rgmii_rx_ctl),
			.rgmii_rxc (rgmii_rxc),	
			.mdio_data (mdio_data),
			.gpio_b_in (16'b0),
			.gpio_b_out (gpio_b_out),
			.gpio_b_oe (16'b0),
			.gpio_c_in (16'b0),
			.gpio_c_out (gpio_c_out),
			.gpio_c_oe (16'b0)
	);
*/
endmodule
