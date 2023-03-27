`include "config.inc"
`include "sample_ae350_smu_const.vh"

`ifdef NDS_FPGA
	`define USE_CLK_RATIO_LOGIC
`else
	`ifndef SYNTHESIS
		`define USE_CLK_RATIO_LOGIC
	`endif
`endif

module sample_ae350_clkgen (
		  root_clk,
		  test_mode,
		  test_clk,
	`ifdef NDS_FPGA
	`else
		  scan_test,
		  scan_enable,
	`endif
		  system_clock_ratio,
		  pcs0_frq_scale_req,
		  pcs0_frq_scale,
		  pcs0_frq_clkon,
		  pcs0_frq_scale_ack,
		  pcs1_frq_scale_req,
		  pcs1_frq_scale,
		  pcs1_frq_clkon,
		  pcs1_frq_scale_ack,
		  pcs2_frq_scale_req,
		  pcs2_frq_scale,
		  pcs2_frq_clkon,
		  pcs2_frq_scale_ack,
		  pcs3_frq_scale_req,
		  pcs3_frq_scale,
		  pcs3_frq_clkon,
		  pcs3_frq_scale_ack,
		  pcs4_frq_scale_req,
		  pcs4_frq_scale,
		  pcs4_frq_clkon,
		  pcs4_frq_scale_ack,
		  pcs5_frq_scale_req,
		  pcs5_frq_scale,
		  pcs5_frq_clkon,
		  pcs5_frq_scale_ack,
		  pcs6_frq_scale_req,
		  pcs6_frq_scale,
		  pcs6_frq_clkon,
		  pcs6_frq_scale_ack,
		  pcs7_frq_scale_req,
		  pcs7_frq_scale,
		  pcs7_frq_clkon,
		  pcs7_frq_scale_ack,
		  pcs8_frq_scale_req,
		  pcs8_frq_scale,
		  pcs8_frq_clkon,
		  pcs8_frq_scale_ack,
		  pcs9_frq_scale_req,
		  pcs9_frq_scale,
		  pcs9_frq_clkon,
		  pcs9_frq_scale_ack,
		  pcs10_frq_scale_req,
		  pcs10_frq_scale,
		  pcs10_frq_clkon,
		  pcs10_frq_scale_ack,
		  T_tck,
		  T_oscl,
		  aopd_dbg_tck,
		  aopd_clk_32k,
		  aopd_pclk,
		  dm_clk,
		  core_clk,
		  l2_clk,
		  dc_clk,
		  lm_clk,
		  clk_32k,
		  T_osch,
		  main_rstn,
		  main_rstn_csync,
		  aopd_por_dbg_rstn,
		  hresetn,
		  aclk,
		  hclk,
		  pclk,
		  uart_clk,
		  spi_clk,
		  sdc_clk,
		  pclk_uart1,
		  pclk_uart2,
		  pclk_spi1,
		  pclk_spi2,
		  pclk_gpio,
		  pclk_pit,
		  pclk_i2c,
		  pclk_wdt,
		  apb2ahb_clken,
		  ahb2core_clken,
		  axi2core_clken,
		  apb2core_clken
);

	localparam NHART = 1;


output		root_clk;
input		test_mode;
input		test_clk;
`ifdef NDS_FPGA
`else
input		scan_test;
input		scan_enable;
`endif

input	[3:0]	system_clock_ratio;
input		pcs0_frq_scale_req;
input	[2:0]	pcs0_frq_scale;
input	[31:0]	pcs0_frq_clkon;
output		pcs0_frq_scale_ack;
input		pcs1_frq_scale_req;
input	[2:0]	pcs1_frq_scale;
input	[31:0]	pcs1_frq_clkon;
output		pcs1_frq_scale_ack;
input		pcs2_frq_scale_req;
input	[2:0]	pcs2_frq_scale;
input	[31:0]	pcs2_frq_clkon;
output		pcs2_frq_scale_ack;
input		pcs3_frq_scale_req;
input	[2:0]	pcs3_frq_scale;
input	[31:0]	pcs3_frq_clkon;
output		pcs3_frq_scale_ack;
input		pcs4_frq_scale_req;
input	[2:0]	pcs4_frq_scale;
input	[31:0]	pcs4_frq_clkon;
output		pcs4_frq_scale_ack;
input		pcs5_frq_scale_req;
input	[2:0]	pcs5_frq_scale;
input	[31:0]	pcs5_frq_clkon;
output		pcs5_frq_scale_ack;
input		pcs6_frq_scale_req;
input	[2:0]	pcs6_frq_scale;
input	[31:0]	pcs6_frq_clkon;
output		pcs6_frq_scale_ack;
input		pcs7_frq_scale_req;
input	[2:0]	pcs7_frq_scale;
input	[31:0]	pcs7_frq_clkon;
output		pcs7_frq_scale_ack;
input		pcs8_frq_scale_req;
input	[2:0]	pcs8_frq_scale;
input	[31:0]	pcs8_frq_clkon;
output		pcs8_frq_scale_ack;
input		pcs9_frq_scale_req;
input	[2:0]	pcs9_frq_scale;
input	[31:0]	pcs9_frq_clkon;
output		pcs9_frq_scale_ack;
input		pcs10_frq_scale_req;
input	[2:0]	pcs10_frq_scale;
input	[31:0]	pcs10_frq_clkon;
output		pcs10_frq_scale_ack;

input		T_tck;
input		T_oscl;
output		aopd_dbg_tck;
output		aopd_clk_32k;
output		aopd_pclk;

output		dm_clk;

output	[(NHART-1):0]	core_clk;
output			l2_clk;
output	[(NHART-1):0]	dc_clk;
output	[(NHART-1):0]	lm_clk;



output		clk_32k;
input		T_osch;
input		main_rstn;
input		main_rstn_csync;
input		aopd_por_dbg_rstn;
input		hresetn;

output		aclk;
output		hclk;
output		pclk;
output		uart_clk;
output		spi_clk;
output		sdc_clk;

output		pclk_uart1;
output		pclk_uart2;
output		pclk_spi1;
output		pclk_spi2;
output		pclk_gpio;
output		pclk_pit;
output		pclk_i2c;
output		pclk_wdt;
output		apb2ahb_clken;
output		ahb2core_clken;
output		axi2core_clken;
output		apb2core_clken;

wire    [7:0]   clk_en_aclk_sync_dfs;
        assign  clk_en_aclk_sync_dfs = {8{1'b1}};


wire [7:0]	root_dfs_clk;

`ifdef SYNTHESIS
`elsif NDS_FPGA
`else
reg    root_clk_dly;
reg    main_rstn_csync_dly;
always @(root_clk) begin
       root_clk_dly <= root_clk;
end
always @(main_rstn_csync) begin
	main_rstn_csync_dly <= main_rstn_csync;
end
`endif

localparam CLKR_DEFAULT = `SAMPLE_AE350_SMU_CLKR_DEFAULT;
wire            clock_unstable;
wire		pclk_mux_test;

reg	[2:0]	reg_bus_ratio;
reg		reg_sysclk_sel;
always @(posedge root_clk or negedge main_rstn_csync)
begin
	if (!main_rstn_csync) begin
		reg_bus_ratio <= CLKR_DEFAULT[3:1];
		reg_sysclk_sel <= CLKR_DEFAULT[0];
	end
	else begin
		reg_bus_ratio <= system_clock_ratio[3:1];
		reg_sysclk_sel <= system_clock_ratio[0];
	end
end
wire	smu_core_clk_sel = reg_sysclk_sel;


`ifdef USE_CLK_RATIO_LOGIC
reg	[1:0]	smu_core_clk_2_hclk_ratio;
reg	[1:0]	smu_hclk_2_pclk_ratio;
always @* begin
	case(reg_bus_ratio)
		3'b000: smu_core_clk_2_hclk_ratio = 2'b00;
		3'b001: smu_core_clk_2_hclk_ratio = 2'b00;
		3'b010: smu_core_clk_2_hclk_ratio = 2'b00;
		3'b011: smu_core_clk_2_hclk_ratio = 2'b01;
		3'b100: smu_core_clk_2_hclk_ratio = 2'b01;
		default: smu_core_clk_2_hclk_ratio = 2'b00;
	endcase
end
always @* begin
	case(reg_bus_ratio)
		3'b000: smu_hclk_2_pclk_ratio = 2'b00;
		3'b001: smu_hclk_2_pclk_ratio = 2'b01;
		3'b010: smu_hclk_2_pclk_ratio = 2'b10;
		3'b011: smu_hclk_2_pclk_ratio = 2'b00;
		3'b100: smu_hclk_2_pclk_ratio = 2'b01;
		default: smu_hclk_2_pclk_ratio = 2'b00;
	endcase
end
`endif

`ifdef NDS_FPGA
	assign clock_unstable = 1'b0;
`else
	`ifdef SYNTHESIS
		assign clock_unstable = 1'b0;
	`endif
`endif

wire	[(NHART-1):0] core_clk;
wire	[(NHART-1):0] dc_clk;
wire	[(NHART-1):0] lm_clk;

assign	pcs0_frq_scale_ack = 1'b0;

wire [7:0] pd_clock_unstable;
genvar i;
    assign pd_clock_unstable = {8{clock_unstable}};


wire	[10:1]	pcs_clk_en;
pd_clk_ctrl pd1_clk_ctrl(.clk_en(pcs_clk_en[1]), .clk(root_clk), .rstn(aopd_por_dbg_rstn), .clock_unstable(clock_unstable),
		 	.frq_scale_ack(pcs1_frq_scale_ack), .frq_scale_req(pcs1_frq_scale_req), .frq_scale(pcs1_frq_scale));
pd_clk_ctrl pd2_clk_ctrl(.clk_en(pcs_clk_en[2]), .clk(root_clk), .rstn(aopd_por_dbg_rstn), .clock_unstable(clock_unstable),
		 	.frq_scale_ack(pcs2_frq_scale_ack), .frq_scale_req(pcs2_frq_scale_req), .frq_scale(pcs2_frq_scale));
pd_clk_ctrl pd3_clk_ctrl(.clk_en(pcs_clk_en[3]), .clk(root_dfs_clk[0]), .rstn(aopd_por_dbg_rstn), .clock_unstable(pd_clock_unstable[0]),
		 	.frq_scale_ack(pcs3_frq_scale_ack), .frq_scale_req(pcs3_frq_scale_req), .frq_scale(pcs3_frq_scale));
pd_clk_ctrl pd4_clk_ctrl(.clk_en(pcs_clk_en[4]), .clk(root_dfs_clk[1]), .rstn(aopd_por_dbg_rstn), .clock_unstable(pd_clock_unstable[1]),
		 	.frq_scale_ack(pcs4_frq_scale_ack), .frq_scale_req(pcs4_frq_scale_req), .frq_scale(pcs4_frq_scale));
pd_clk_ctrl pd5_clk_ctrl(.clk_en(pcs_clk_en[5]), .clk(root_dfs_clk[2]), .rstn(aopd_por_dbg_rstn), .clock_unstable(pd_clock_unstable[2]),
		 	.frq_scale_ack(pcs5_frq_scale_ack), .frq_scale_req(pcs5_frq_scale_req), .frq_scale(pcs5_frq_scale));
pd_clk_ctrl pd6_clk_ctrl(.clk_en(pcs_clk_en[6]), .clk(root_dfs_clk[3]), .rstn(aopd_por_dbg_rstn), .clock_unstable(pd_clock_unstable[3]),
		 	.frq_scale_ack(pcs6_frq_scale_ack), .frq_scale_req(pcs6_frq_scale_req), .frq_scale(pcs6_frq_scale));
pd_clk_ctrl pd7_clk_ctrl(.clk_en(pcs_clk_en[7]), .clk(root_dfs_clk[4]), .rstn(aopd_por_dbg_rstn), .clock_unstable(pd_clock_unstable[4]),
		 	.frq_scale_ack(pcs7_frq_scale_ack), .frq_scale_req(pcs7_frq_scale_req), .frq_scale(pcs7_frq_scale));
pd_clk_ctrl pd8_clk_ctrl(.clk_en(pcs_clk_en[8]), .clk(root_dfs_clk[5]), .rstn(aopd_por_dbg_rstn), .clock_unstable(pd_clock_unstable[5]),
		 	.frq_scale_ack(pcs8_frq_scale_ack), .frq_scale_req(pcs8_frq_scale_req), .frq_scale(pcs8_frq_scale));
pd_clk_ctrl pd9_clk_ctrl(.clk_en(pcs_clk_en[9]), .clk(root_dfs_clk[6]), .rstn(aopd_por_dbg_rstn), .clock_unstable(pd_clock_unstable[6]),
		 	.frq_scale_ack(pcs9_frq_scale_ack), .frq_scale_req(pcs9_frq_scale_req), .frq_scale(pcs9_frq_scale));
pd_clk_ctrl pd10_clk_ctrl(.clk_en(pcs_clk_en[10]), .clk(root_dfs_clk[7]), .rstn(aopd_por_dbg_rstn), .clock_unstable(pd_clock_unstable[7]),
		 	.frq_scale_ack(pcs10_frq_scale_ack),.frq_scale_req(pcs10_frq_scale_req),.frq_scale(pcs10_frq_scale));

wire	[7:0]	core_clkon;
wire	[7:0]	core_clkon_ack;
pd_clk_ctrl core0_clkon(.clk_en(core_clkon[0]), .clk(root_dfs_clk[0]), .rstn(aopd_por_dbg_rstn), .clock_unstable(pd_clock_unstable[0]),
		 	.frq_scale_ack(core_clkon_ack[0]), .frq_scale_req(pcs3_frq_scale_req), .frq_scale({2'd0, pcs3_frq_clkon[0]}));
pd_clk_ctrl core1_clkon(.clk_en(core_clkon[1]), .clk(root_dfs_clk[1]), .rstn(aopd_por_dbg_rstn), .clock_unstable(pd_clock_unstable[1]),
		 	.frq_scale_ack(core_clkon_ack[1]), .frq_scale_req(pcs4_frq_scale_req), .frq_scale({2'd0, pcs4_frq_clkon[0]}));
pd_clk_ctrl core2_clkon(.clk_en(core_clkon[2]), .clk(root_dfs_clk[2]), .rstn(aopd_por_dbg_rstn), .clock_unstable(pd_clock_unstable[2]),
		 	.frq_scale_ack(core_clkon_ack[2]), .frq_scale_req(pcs5_frq_scale_req), .frq_scale({2'd0, pcs5_frq_clkon[0]}));
pd_clk_ctrl core3_clkon(.clk_en(core_clkon[3]), .clk(root_dfs_clk[3]), .rstn(aopd_por_dbg_rstn), .clock_unstable(pd_clock_unstable[3]),
		 	.frq_scale_ack(core_clkon_ack[3]), .frq_scale_req(pcs6_frq_scale_req), .frq_scale({2'd0, pcs6_frq_clkon[0]}));
pd_clk_ctrl core4_clkon(.clk_en(core_clkon[4]), .clk(root_dfs_clk[4]), .rstn(aopd_por_dbg_rstn), .clock_unstable(pd_clock_unstable[4]),
		 	.frq_scale_ack(core_clkon_ack[4]), .frq_scale_req(pcs7_frq_scale_req), .frq_scale({2'd0, pcs7_frq_clkon[0]}));
pd_clk_ctrl core5_clkon(.clk_en(core_clkon[5]), .clk(root_dfs_clk[5]), .rstn(aopd_por_dbg_rstn), .clock_unstable(pd_clock_unstable[5]),
		 	.frq_scale_ack(core_clkon_ack[5]), .frq_scale_req(pcs8_frq_scale_req), .frq_scale({2'd0, pcs8_frq_clkon[0]}));
pd_clk_ctrl core6_clkon(.clk_en(core_clkon[6]), .clk(root_dfs_clk[6]), .rstn(aopd_por_dbg_rstn), .clock_unstable(pd_clock_unstable[6]),
		 	.frq_scale_ack(core_clkon_ack[6]), .frq_scale_req(pcs9_frq_scale_req), .frq_scale({2'd0, pcs9_frq_clkon[0]}));
pd_clk_ctrl core7_clkon(.clk_en(core_clkon[7]), .clk(root_dfs_clk[7]), .rstn(aopd_por_dbg_rstn), .clock_unstable(pd_clock_unstable[7]),
		 	.frq_scale_ack(core_clkon_ack[7]), .frq_scale_req(pcs10_frq_scale_req),.frq_scale({2'd0, pcs10_frq_clkon[0]}));

wire	[7:0]	dc_clkon;
wire	[7:0]	dc_clkon_ack;
pd_clk_ctrl dc0_clkon(.clk_en(dc_clkon[0]), .clk(root_dfs_clk[0]), .rstn(aopd_por_dbg_rstn), .clock_unstable(pd_clock_unstable[0]),
		      .frq_scale_ack(dc_clkon_ack[0]), .frq_scale_req(pcs3_frq_scale_req), .frq_scale({2'd0, pcs3_frq_clkon[13]}));
pd_clk_ctrl dc1_clkon(.clk_en(dc_clkon[1]), .clk(root_dfs_clk[1]), .rstn(aopd_por_dbg_rstn), .clock_unstable(pd_clock_unstable[1]),
	      	      .frq_scale_ack(dc_clkon_ack[1]), .frq_scale_req(pcs4_frq_scale_req), .frq_scale({2'd0, pcs4_frq_clkon[13]}));
pd_clk_ctrl dc2_clkon(.clk_en(dc_clkon[2]), .clk(root_dfs_clk[2]), .rstn(aopd_por_dbg_rstn), .clock_unstable(pd_clock_unstable[2]),
	      	      .frq_scale_ack(dc_clkon_ack[2]), .frq_scale_req(pcs5_frq_scale_req), .frq_scale({2'd0, pcs5_frq_clkon[13]}));
pd_clk_ctrl dc3_clkon(.clk_en(dc_clkon[3]), .clk(root_dfs_clk[3]), .rstn(aopd_por_dbg_rstn), .clock_unstable(pd_clock_unstable[3]),
		      .frq_scale_ack(dc_clkon_ack[3]), .frq_scale_req(pcs6_frq_scale_req), .frq_scale({2'd0, pcs6_frq_clkon[13]}));
pd_clk_ctrl dc4_clkon(.clk_en(dc_clkon[4]), .clk(root_dfs_clk[4]), .rstn(aopd_por_dbg_rstn), .clock_unstable(pd_clock_unstable[4]),
		      .frq_scale_ack(dc_clkon_ack[4]), .frq_scale_req(pcs7_frq_scale_req), .frq_scale({2'd0, pcs7_frq_clkon[13]}));
pd_clk_ctrl dc5_clkon(.clk_en(dc_clkon[5]), .clk(root_dfs_clk[5]), .rstn(aopd_por_dbg_rstn), .clock_unstable(pd_clock_unstable[5]),
		      .frq_scale_ack(dc_clkon_ack[5]), .frq_scale_req(pcs8_frq_scale_req), .frq_scale({2'd0, pcs8_frq_clkon[13]}));
pd_clk_ctrl dc6_clkon(.clk_en(dc_clkon[6]), .clk(root_dfs_clk[6]), .rstn(aopd_por_dbg_rstn), .clock_unstable(pd_clock_unstable[6]),
		      .frq_scale_ack(dc_clkon_ack[6]), .frq_scale_req(pcs9_frq_scale_req), .frq_scale({2'd0, pcs9_frq_clkon[13]}));
pd_clk_ctrl dc7_clkon(.clk_en(dc_clkon[7]), .clk(root_dfs_clk[7]), .rstn(aopd_por_dbg_rstn), .clock_unstable(pd_clock_unstable[7]),
		      .frq_scale_ack(dc_clkon_ack[7]), .frq_scale_req(pcs10_frq_scale_req),.frq_scale({2'd0, pcs10_frq_clkon[13]}));

wire	[7:0]	lm_clkon;
wire	[7:0]	lm_clkon_ack;
pd_clk_ctrl lm0_clkon(.clk_en(lm_clkon[0]), .clk(root_dfs_clk[0]), .rstn(aopd_por_dbg_rstn), .clock_unstable(pd_clock_unstable[0]),
		      .frq_scale_ack(lm_clkon_ack[0]), .frq_scale_req(pcs3_frq_scale_req), .frq_scale({2'd0, pcs3_frq_clkon[12]}));
pd_clk_ctrl lm1_clkon(.clk_en(lm_clkon[1]), .clk(root_dfs_clk[1]), .rstn(aopd_por_dbg_rstn), .clock_unstable(pd_clock_unstable[1]),
	      	      .frq_scale_ack(lm_clkon_ack[1]), .frq_scale_req(pcs4_frq_scale_req), .frq_scale({2'd0, pcs4_frq_clkon[12]}));
pd_clk_ctrl lm2_clkon(.clk_en(lm_clkon[2]), .clk(root_dfs_clk[2]), .rstn(aopd_por_dbg_rstn), .clock_unstable(pd_clock_unstable[2]),
	      	      .frq_scale_ack(lm_clkon_ack[2]), .frq_scale_req(pcs5_frq_scale_req), .frq_scale({2'd0, pcs5_frq_clkon[12]}));
pd_clk_ctrl lm3_clkon(.clk_en(lm_clkon[3]), .clk(root_dfs_clk[3]), .rstn(aopd_por_dbg_rstn), .clock_unstable(pd_clock_unstable[3]),
		      .frq_scale_ack(lm_clkon_ack[3]), .frq_scale_req(pcs6_frq_scale_req), .frq_scale({2'd0, pcs6_frq_clkon[12]}));
pd_clk_ctrl lm4_clkon(.clk_en(lm_clkon[4]), .clk(root_dfs_clk[4]), .rstn(aopd_por_dbg_rstn), .clock_unstable(pd_clock_unstable[4]),
		      .frq_scale_ack(lm_clkon_ack[4]), .frq_scale_req(pcs7_frq_scale_req), .frq_scale({2'd0, pcs7_frq_clkon[12]}));
pd_clk_ctrl lm5_clkon(.clk_en(lm_clkon[5]), .clk(root_dfs_clk[5]), .rstn(aopd_por_dbg_rstn), .clock_unstable(pd_clock_unstable[5]),
		      .frq_scale_ack(lm_clkon_ack[5]), .frq_scale_req(pcs8_frq_scale_req), .frq_scale({2'd0, pcs8_frq_clkon[12]}));
pd_clk_ctrl lm6_clkon(.clk_en(lm_clkon[6]), .clk(root_dfs_clk[6]), .rstn(aopd_por_dbg_rstn), .clock_unstable(pd_clock_unstable[6]),
		      .frq_scale_ack(lm_clkon_ack[6]), .frq_scale_req(pcs9_frq_scale_req), .frq_scale({2'd0, pcs9_frq_clkon[12]}));
pd_clk_ctrl lm7_clkon(.clk_en(lm_clkon[7]), .clk(root_dfs_clk[7]), .rstn(aopd_por_dbg_rstn), .clock_unstable(pd_clock_unstable[7]),
		      .frq_scale_ack(lm_clkon_ack[7]), .frq_scale_req(pcs10_frq_scale_req),.frq_scale({2'd0, pcs10_frq_clkon[12]}));

wire	[7:0]	l2c_clkon;
wire	[7:0]	l2c_freq_scale;
wire	[7:0]	l2c_clkon_ack;

assign	l2c_freq_scale[0] = pcs3_frq_clkon[0] | pcs3_frq_clkon[12] | pcs3_frq_clkon[13];
assign	l2c_freq_scale[1] = pcs4_frq_clkon[0] | pcs4_frq_clkon[12] | pcs4_frq_clkon[13];
assign	l2c_freq_scale[2] = pcs5_frq_clkon[0] | pcs5_frq_clkon[12] | pcs5_frq_clkon[13];
assign	l2c_freq_scale[3] = pcs6_frq_clkon[0] | pcs6_frq_clkon[12] | pcs6_frq_clkon[13];
assign	l2c_freq_scale[4] = pcs7_frq_clkon[0] | pcs7_frq_clkon[12] | pcs7_frq_clkon[13];
assign	l2c_freq_scale[5] = pcs8_frq_clkon[0] | pcs8_frq_clkon[12] | pcs8_frq_clkon[13];
assign	l2c_freq_scale[6] = pcs9_frq_clkon[0] | pcs9_frq_clkon[12] | pcs9_frq_clkon[13];
assign	l2c_freq_scale[7] = pcs10_frq_clkon[0]| pcs10_frq_clkon[12]| pcs10_frq_clkon[13];

pd_clk_ctrl l2c0_clkon(.clk_en(l2c_clkon[0]), .clk(root_clk), .rstn(aopd_por_dbg_rstn), .clock_unstable(clock_unstable),
		      .frq_scale_ack(l2c_clkon_ack[0]), .frq_scale_req(pcs3_frq_scale_req), .frq_scale({2'd0, l2c_freq_scale[0]}));
pd_clk_ctrl l2c1_clkon(.clk_en(l2c_clkon[1]), .clk(root_clk), .rstn(aopd_por_dbg_rstn), .clock_unstable(clock_unstable),
	      	      .frq_scale_ack(l2c_clkon_ack[1]), .frq_scale_req(pcs4_frq_scale_req), .frq_scale({2'd0, l2c_freq_scale[1]}));
pd_clk_ctrl l2c2_clkon(.clk_en(l2c_clkon[2]), .clk(root_clk), .rstn(aopd_por_dbg_rstn), .clock_unstable(clock_unstable),
	      	      .frq_scale_ack(l2c_clkon_ack[2]), .frq_scale_req(pcs5_frq_scale_req), .frq_scale({2'd0, l2c_freq_scale[2]}));
pd_clk_ctrl l2c3_clkon(.clk_en(l2c_clkon[3]), .clk(root_clk), .rstn(aopd_por_dbg_rstn), .clock_unstable(clock_unstable),
		      .frq_scale_ack(l2c_clkon_ack[3]), .frq_scale_req(pcs6_frq_scale_req), .frq_scale({2'd0, l2c_freq_scale[3]}));
pd_clk_ctrl l2c4_clkon(.clk_en(l2c_clkon[4]), .clk(root_clk), .rstn(aopd_por_dbg_rstn), .clock_unstable(clock_unstable),
		      .frq_scale_ack(l2c_clkon_ack[4]), .frq_scale_req(pcs7_frq_scale_req), .frq_scale({2'd0, l2c_freq_scale[4]}));
pd_clk_ctrl l2c5_clkon(.clk_en(l2c_clkon[5]), .clk(root_clk), .rstn(aopd_por_dbg_rstn), .clock_unstable(clock_unstable),
		      .frq_scale_ack(l2c_clkon_ack[5]), .frq_scale_req(pcs8_frq_scale_req), .frq_scale({2'd0, l2c_freq_scale[5]}));
pd_clk_ctrl l2c6_clkon(.clk_en(l2c_clkon[6]), .clk(root_clk), .rstn(aopd_por_dbg_rstn), .clock_unstable(clock_unstable),
		      .frq_scale_ack(l2c_clkon_ack[6]), .frq_scale_req(pcs9_frq_scale_req), .frq_scale({2'd0, l2c_freq_scale[6]}));
pd_clk_ctrl l2c7_clkon(.clk_en(l2c_clkon[7]), .clk(root_clk), .rstn(aopd_por_dbg_rstn), .clock_unstable(clock_unstable),
		      .frq_scale_ack(l2c_clkon_ack[7]), .frq_scale_req(pcs10_frq_scale_req),.frq_scale({2'd0, l2c_freq_scale[7]}));

wire	aclkon;
wire	hclkon;
wire	pclkon;

wire	aclkon_ack;
wire	hclkon_ack;
wire	pclkon_ack;

pd_clk_ctrl pd_aclkon(.clk_en(aclkon), .clk(root_clk), .rstn(aopd_por_dbg_rstn), .clock_unstable(clock_unstable),
	             .frq_scale_ack(aclkon_ack), .frq_scale_req(pcs2_frq_scale_req), .frq_scale({2'd0, pcs2_frq_clkon[11]}));
pd_clk_ctrl pd_hclkon(.clk_en(hclkon), .clk(root_clk), .rstn(aopd_por_dbg_rstn), .clock_unstable(clock_unstable),
	             .frq_scale_ack(hclkon_ack), .frq_scale_req(pcs2_frq_scale_req), .frq_scale({2'd0, pcs2_frq_clkon[1]}));
pd_clk_ctrl pd_pclkon(.clk_en(pclkon), .clk(root_clk), .rstn(aopd_por_dbg_rstn), .clock_unstable(clock_unstable),
	             .frq_scale_ack(pclkon_ack), .frq_scale_req(pcs2_frq_scale_req), .frq_scale({2'd0, pcs2_frq_clkon[2]}));

sample_ae350_aopd_clkgen sample_ae350_aopd_clkgen (
	.test_mode(test_mode   ),
	.test_clk (test_clk    ),
	.clk_32k  (aopd_clk_32k),
	.T_oscl   (T_oscl      ),
	.dbg_tck  (aopd_dbg_tck),
	.T_tck    (T_tck       )
);

wire	smu_debug_clk_en = pcs_clk_en[1];
wire	smu_aclk_en = pcs_clk_en[2] & aclkon;
wire	smu_hclk_en = pcs_clk_en[2] & hclkon;
wire	smu_pclk_en = pcs_clk_en[2] & pclkon;
wire	smu_pclk_uart1_en = pcs_clk_en[2] & pclkon;
wire	smu_pclk_uart2_en = pcs_clk_en[2] & pclkon;
wire	smu_pclk_spi1_en  = pcs_clk_en[2] & pclkon;
wire	smu_pclk_spi2_en  = pcs_clk_en[2] & pclkon;
wire	smu_pclk_gpio_en  = pcs_clk_en[2] & pclkon;
wire	smu_pclk_i2c_en   = pcs_clk_en[2] & pclkon;
wire	smu_pclk_wdt_en   = pcs_clk_en[2] & pclkon;
wire	smu_pclk_pit_en   = pcs_clk_en[2] & pclkon;

`ifdef NDS_FPGA
wire		clkfb_in;
wire		fast_clk;
wire		slow_clk;
wire		root_clk;
wire		hclk_pri;
wire		pclk_pri;

reg		osch_div2;

reg	[1:0]	root_clk_cnt;
reg		div_n_hclk;
reg	[1:0]	smu_core_clk_2_hclk_ratio_sync;
wire		hclk_div_n_select_sync;

reg		div_n_pclk;
reg	[1:0]	smu_hclk_2_pclk_ratio_sync;

wire            pclk_div_n_select_sync;

reg		ahb2core_clken;
reg		apb2ahb_clken;
reg		apb2core_clken;

reg		gen_clkmux_clk_en;

wire		clk_30m, clk_40m, clk_20m_0, clk_20m_1, spi_clk_66m, clk_60m_sdc;

wire		root_clk_dly = root_clk;
wire		main_rstn_csync_dly = main_rstn_csync;


	`ifdef AE350_CORE_CLK_66MHZ
wire            core_clk_66m;
mmcm1_66m ae350_fpga_clkgen (
	.resetn		(main_rstn		),
	.clk_in1	(T_osch			),
	.clkfb_in	(clkfb_in		),
	.clkfb_out	(clkfb_in		),
	.clk_out1	(core_clk_66m		),
	.clk_out2	(clk_30m		),
	.clk_out3	(clk_40m		),
	.clk_out4	(clk_20m_0		),
	.clk_out5	(clk_20m_1		),
	.clk_out6	(spi_clk_66m		),
	.clk_out7	(clk_60m_sdc		)
);
	`else
wire		clk_60m;
mmcm1 ae350_fpga_clkgen (
	.resetn		(main_rstn		),
	.clk_in1	(T_osch			),
	.clkfb_in	(clkfb_in		),
	.clkfb_out	(clkfb_in		),
	.clk_out1	(clk_60m		),
	.clk_out2	(clk_30m		),
	.clk_out3	(clk_40m		),
	.clk_out4	(clk_20m_0		),
	.clk_out5	(clk_20m_1		),
	.clk_out6	(spi_clk_66m		),
	.clk_out7	(clk_60m_sdc		)
);
	`endif

	`ifdef AE350_CORE_CLK_40MHZ
assign fast_clk		= clk_40m;
assign slow_clk		= clk_20m_0;
	`else
		`ifdef AE350_CORE_CLK_66MHZ
assign fast_clk		= core_clk_66m;
assign slow_clk		= clk_30m;
		`else
assign fast_clk		= clk_60m;
assign slow_clk		= clk_30m;
		`endif
	`endif

assign uart_clk		= clk_20m_1;
assign spi_clk		= spi_clk_66m;
assign sdc_clk		= clk_60m_sdc;



wire gen_debug_clkmux_en = gen_clkmux_clk_en & smu_debug_clk_en;
wire gen_hclk_clkmux_en  = gen_clkmux_clk_en & smu_hclk_en;
wire gen_aclk_clkmux_en  = gen_clkmux_clk_en & smu_aclk_en;
wire gen_pclk_clkmux_en  = gen_clkmux_clk_en & smu_pclk_en;

wire gen_core0_clkmux_en = gen_clkmux_clk_en & (pcs_clk_en[3] & core_clkon[0] & clk_en_aclk_sync_dfs[0]);
wire gen_core1_clkmux_en = gen_clkmux_clk_en & (pcs_clk_en[4] & core_clkon[1] & clk_en_aclk_sync_dfs[1]);
wire gen_core2_clkmux_en = gen_clkmux_clk_en & (pcs_clk_en[5] & core_clkon[2] & clk_en_aclk_sync_dfs[2]);
wire gen_core3_clkmux_en = gen_clkmux_clk_en & (pcs_clk_en[6] & core_clkon[3] & clk_en_aclk_sync_dfs[3]);
wire gen_core4_clkmux_en = gen_clkmux_clk_en & (pcs_clk_en[7] & core_clkon[4] & clk_en_aclk_sync_dfs[4]);
wire gen_core5_clkmux_en = gen_clkmux_clk_en & (pcs_clk_en[8] & core_clkon[5] & clk_en_aclk_sync_dfs[5]);
wire gen_core6_clkmux_en = gen_clkmux_clk_en & (pcs_clk_en[9] & core_clkon[6] & clk_en_aclk_sync_dfs[6]);
wire gen_core7_clkmux_en = gen_clkmux_clk_en & (pcs_clk_en[10]& core_clkon[7] & clk_en_aclk_sync_dfs[7]);

wire	[7:0] gen_core_clkmux_en = {gen_core7_clkmux_en, gen_core6_clkmux_en, gen_core5_clkmux_en, gen_core4_clkmux_en,
                                    gen_core3_clkmux_en, gen_core2_clkmux_en, gen_core1_clkmux_en, gen_core0_clkmux_en};

wire gen_dc0_clkmux_en = gen_clkmux_clk_en & (pcs_clk_en[3] & dc_clkon[0] & clk_en_aclk_sync_dfs[0]);
wire gen_dc1_clkmux_en = gen_clkmux_clk_en & (pcs_clk_en[4] & dc_clkon[1] & clk_en_aclk_sync_dfs[1]);
wire gen_dc2_clkmux_en = gen_clkmux_clk_en & (pcs_clk_en[5] & dc_clkon[2] & clk_en_aclk_sync_dfs[2]);
wire gen_dc3_clkmux_en = gen_clkmux_clk_en & (pcs_clk_en[6] & dc_clkon[3] & clk_en_aclk_sync_dfs[3]);
wire gen_dc4_clkmux_en = gen_clkmux_clk_en & (pcs_clk_en[7] & dc_clkon[4] & clk_en_aclk_sync_dfs[4]);
wire gen_dc5_clkmux_en = gen_clkmux_clk_en & (pcs_clk_en[8] & dc_clkon[5] & clk_en_aclk_sync_dfs[5]);
wire gen_dc6_clkmux_en = gen_clkmux_clk_en & (pcs_clk_en[9] & dc_clkon[6] & clk_en_aclk_sync_dfs[6]);
wire gen_dc7_clkmux_en = gen_clkmux_clk_en & (pcs_clk_en[10]& dc_clkon[7] & clk_en_aclk_sync_dfs[7]);

wire	[7:0] gen_dc_clkmux_en = {gen_dc7_clkmux_en, gen_dc6_clkmux_en, gen_dc5_clkmux_en, gen_dc4_clkmux_en,
                                  gen_dc3_clkmux_en, gen_dc2_clkmux_en, gen_dc1_clkmux_en, gen_dc0_clkmux_en};

wire gen_lm0_clkmux_en = gen_clkmux_clk_en & (pcs_clk_en[3] & lm_clkon[0] & clk_en_aclk_sync_dfs[0]);
wire gen_lm1_clkmux_en = gen_clkmux_clk_en & (pcs_clk_en[4] & lm_clkon[1] & clk_en_aclk_sync_dfs[1]);
wire gen_lm2_clkmux_en = gen_clkmux_clk_en & (pcs_clk_en[5] & lm_clkon[2] & clk_en_aclk_sync_dfs[2]);
wire gen_lm3_clkmux_en = gen_clkmux_clk_en & (pcs_clk_en[6] & lm_clkon[3] & clk_en_aclk_sync_dfs[3]);
wire gen_lm4_clkmux_en = gen_clkmux_clk_en & (pcs_clk_en[7] & lm_clkon[4] & clk_en_aclk_sync_dfs[4]);
wire gen_lm5_clkmux_en = gen_clkmux_clk_en & (pcs_clk_en[8] & lm_clkon[5] & clk_en_aclk_sync_dfs[5]);
wire gen_lm6_clkmux_en = gen_clkmux_clk_en & (pcs_clk_en[9] & lm_clkon[6] & clk_en_aclk_sync_dfs[6]);
wire gen_lm7_clkmux_en = gen_clkmux_clk_en & (pcs_clk_en[10]& lm_clkon[7] & clk_en_aclk_sync_dfs[7]);

wire	[7:0] gen_lm_clkmux_en = {gen_lm7_clkmux_en, gen_lm6_clkmux_en, gen_lm5_clkmux_en, gen_lm4_clkmux_en,
                                  gen_lm3_clkmux_en, gen_lm2_clkmux_en, gen_lm1_clkmux_en, gen_lm0_clkmux_en};

wire gen_l2c0_clkmux_en = gen_clkmux_clk_en & (smu_aclk_en & l2c_clkon[0]);
wire gen_l2c1_clkmux_en = gen_clkmux_clk_en & (smu_aclk_en & l2c_clkon[1]);
wire gen_l2c2_clkmux_en = gen_clkmux_clk_en & (smu_aclk_en & l2c_clkon[2]);
wire gen_l2c3_clkmux_en = gen_clkmux_clk_en & (smu_aclk_en & l2c_clkon[3]);
wire gen_l2c4_clkmux_en = gen_clkmux_clk_en & (smu_aclk_en & l2c_clkon[4]);
wire gen_l2c5_clkmux_en = gen_clkmux_clk_en & (smu_aclk_en & l2c_clkon[5]);
wire gen_l2c6_clkmux_en = gen_clkmux_clk_en & (smu_aclk_en & l2c_clkon[6]);
wire gen_l2c7_clkmux_en = gen_clkmux_clk_en & (smu_aclk_en & l2c_clkon[7]);

wire	[7:0] gen_l2c_clkmux_en = {gen_l2c7_clkmux_en, gen_l2c6_clkmux_en, gen_l2c5_clkmux_en, gen_l2c4_clkmux_en,
                                   gen_l2c3_clkmux_en, gen_l2c2_clkmux_en, gen_l2c1_clkmux_en, gen_l2c0_clkmux_en};
wire	gen_l2_clkmux_en = (|gen_l2c_clkmux_en[NHART-1:0]);

BUFGCTRL ROOT_CLK_MUX_INST (
	.I0		(fast_clk		),
	.I1		(slow_clk		),
	.CE0		(1'b1			),
	.CE1		(1'b1			),
	.S0		(~smu_core_clk_sel	),
	.S1		( smu_core_clk_sel	),
	.IGNORE0	(1'b0			),
	.IGNORE1	(1'b0			),
	.O		(root_clk		)
);







        assign root_dfs_clk = {8{root_clk}};

        genvar i_bufg;
        generate
        for (i_bufg = 0; i_bufg < NHART; i_bufg = i_bufg + 1) begin: gen_bufg

        	BUFGCTRL CORE_CLK_MUX_INST (
        		.I0		(fast_clk		),
        		.I1		(slow_clk		),
        		.CE0		(gen_core_clkmux_en[i_bufg]),
        		.CE1		(gen_core_clkmux_en[i_bufg]),
        		.S0		(~smu_core_clk_sel	),
        		.S1		( smu_core_clk_sel	),
        		.IGNORE0	(1'b0			),
        		.IGNORE1	(1'b0			),
        		.O		(core_clk[i_bufg]	)
        	);

        	BUFGCTRL DC_CLK_MUX_INST (
        		.I0		(fast_clk		),
        		.I1		(slow_clk		),
        		.CE0		(gen_dc_clkmux_en[i_bufg]),
        		.CE1		(gen_dc_clkmux_en[i_bufg]),
        		.S0		(~smu_core_clk_sel	),
        		.S1		( smu_core_clk_sel	),
        		.IGNORE0	(1'b0			),
        		.IGNORE1	(1'b0			),
        		.O		(dc_clk[i_bufg]		)
        	);

        	BUFGCTRL LM_CLK_MUX_INST (
        		.I0		(fast_clk		),
        		.I1		(slow_clk		),
        		.CE0		(gen_lm_clkmux_en[i_bufg]),
        		.CE1		(gen_lm_clkmux_en[i_bufg]),
        		.S0		(~smu_core_clk_sel	),
        		.S1		( smu_core_clk_sel	),
        		.IGNORE0	(1'b0			),
        		.IGNORE1	(1'b0			),
        		.O		(lm_clk[i_bufg]		)
        	);

        end
        endgenerate



BUFGCTRL L2_CLK_MUX_INST (
	.I0		(fast_clk		),
	.I1		(slow_clk		),
	.CE0		(gen_l2_clkmux_en	),
	.CE1		(gen_l2_clkmux_en	),
	.S0		(~smu_core_clk_sel	),
	.S1		( smu_core_clk_sel	),
	.IGNORE0	(1'b0			),
	.IGNORE1	(1'b0			),
	.O		(l2_clk			)
);

BUFGCTRL DEBUG_CLK_MUX_INST (
	.I0		(fast_clk		),
	.I1		(slow_clk		),
	.CE0		(gen_debug_clkmux_en    ),
	.CE1		(gen_debug_clkmux_en    ),
	.S0		(~smu_core_clk_sel	),
	.S1		( smu_core_clk_sel	),
	.IGNORE0	(1'b0			),
	.IGNORE1	(1'b0			),
	.O		(dm_clk			)
);

BUFGCTRL ACLK_MUX_INST (
	.I0		(fast_clk		),
	.I1		(slow_clk		),
	.CE0		(gen_aclk_clkmux_en     ),
	.CE1		(gen_aclk_clkmux_en     ),
	.S0		(~smu_core_clk_sel	),
	.S1		( smu_core_clk_sel	),
	.IGNORE0	(1'b0			),
	.IGNORE1	(1'b0			),
	.O		(aclk		)
);

BUFGCTRL HCLK_MUX_INST (
	.I0		(root_clk		),
	.I1		(div_n_hclk		),
	.CE0		(gen_hclk_clkmux_en     ),
	.CE1		(gen_hclk_clkmux_en     ),
	.S0		(~hclk_div_n_select_sync),
	.S1		( hclk_div_n_select_sync),
	.IGNORE0	(1'b0			),
	.IGNORE1	(1'b0			),
	.O		(hclk			)
);

BUFGCTRL PCLK_MUX_INST (
	.I0		(root_clk		),
	.I1		(div_n_pclk		),
	.CE0		(gen_pclk_clkmux_en     ),
	.CE1		(gen_pclk_clkmux_en     ),
	.S0		(~pclk_div_n_select_sync),
	.S1		( pclk_div_n_select_sync),
	.IGNORE0	(1'b0			),
	.IGNORE1	(1'b0			),
	.O		(pclk			)
);


wire	aopd_root_clk;
BUFGCTRL AOPD_ROOT_CLK_MUX_INST (
	.I0		(fast_clk		),
	.I1		(slow_clk		),
	.CE0		(1'b1			),
	.CE1		(1'b1			),
	.S0		(~smu_core_clk_sel	),
	.S1		( smu_core_clk_sel	),
	.IGNORE0	(1'b0			),
	.IGNORE1	(1'b0			),
	.O		(aopd_root_clk		)
);

BUFGCTRL AOPD_PCLK_MUX_INST (
	.I0		(aopd_root_clk		),
	.I1		(div_n_pclk		),
	.CE0		(gen_clkmux_clk_en	),
	.CE1		(gen_clkmux_clk_en	),
	.S0		(~pclk_div_n_select_sync),
	.S1		( pclk_div_n_select_sync),
	.IGNORE0	(1'b0			),
	.IGNORE1	(1'b0			),
	.O		(aopd_pclk		)
);


assign pclk_uart1 = pclk;
assign pclk_uart2 = pclk;
assign pclk_spi1  = pclk;
assign pclk_spi2  = pclk;
assign pclk_gpio  = pclk;
assign pclk_pit   = pclk;
assign pclk_i2c   = pclk;
assign pclk_wdt   = pclk;

assign clk_32k	  = aopd_clk_32k;

wire	[1:0] root_clk_cnt_nx;
assign	root_clk_cnt_nx = root_clk_cnt + 2'b1;
always @(posedge root_clk or negedge main_rstn_csync) begin
	if (!main_rstn_csync)
		root_clk_cnt	<= 2'b0;
	else
		root_clk_cnt	<= root_clk_cnt_nx;
end

wire		clock_ratio_change;
assign clock_ratio_change =
	(smu_core_clk_2_hclk_ratio_sync != smu_core_clk_2_hclk_ratio) |
	(smu_hclk_2_pclk_ratio_sync != smu_hclk_2_pclk_ratio);

always @(posedge root_clk or negedge main_rstn_csync) begin
	if (!main_rstn_csync)
		gen_clkmux_clk_en <= 1'b1;
	else if ((clock_ratio_change | ~gen_clkmux_clk_en) & root_clk_cnt == 2'b11)
		gen_clkmux_clk_en <= ~gen_clkmux_clk_en;

end

wire	      hclk_inv_cond;
wire	      ahb2core_clken_low_cond;
wire	      ahb2core_clken_high_cond;


assign hclk_inv_cond = ~smu_core_clk_2_hclk_ratio_sync[1] |
		       (smu_core_clk_2_hclk_ratio_sync[1] & ~root_clk_cnt[0]);

always @(posedge root_clk or negedge main_rstn_csync) begin
	if (!main_rstn_csync)
		div_n_hclk <= 1'b0;
	else if (hclk_inv_cond)
		div_n_hclk <= ~div_n_hclk;
end

always @(posedge root_clk or negedge main_rstn_csync) begin
	if (!main_rstn_csync)
		smu_core_clk_2_hclk_ratio_sync <= 2'b00;
	else if ((smu_core_clk_2_hclk_ratio_sync != smu_core_clk_2_hclk_ratio) & (root_clk_cnt == 2'b11))
		smu_core_clk_2_hclk_ratio_sync <= smu_core_clk_2_hclk_ratio;
end

assign ahb2core_clken_low_cond = ahb2core_clken & (smu_core_clk_2_hclk_ratio_sync != 2'b00);
assign ahb2core_clken_high_cond =
	((smu_core_clk_2_hclk_ratio_sync == 2'b00) & (root_clk_cnt == 2'b00)) |
	((smu_core_clk_2_hclk_ratio_sync == 2'b01) & (root_clk_cnt[0])) |
	((smu_core_clk_2_hclk_ratio_sync == 2'b10) & (root_clk_cnt[1:0] == 2'b11));

always @(posedge root_clk or negedge main_rstn_csync) begin
	if (!main_rstn_csync)
		ahb2core_clken <= 1'b0;
	else if (ahb2core_clken_low_cond)
		ahb2core_clken <= 1'b0;
	else if (ahb2core_clken_high_cond)
		ahb2core_clken <= 1'b1;
end

assign hclk_div_n_select_sync = smu_core_clk_2_hclk_ratio_sync != 2'b00;


wire          pclk_inv_cond;
wire          apb2ahb_clken_low_cond;
wire          apb2ahb_clken_high_cond;

wire	[1:0] core_clk_2_pclk_ratio_sync;

assign	      core_clk_2_pclk_ratio_sync = (smu_core_clk_2_hclk_ratio_sync == 2'b0) ? smu_hclk_2_pclk_ratio_sync :
										      smu_hclk_2_pclk_ratio_sync + 2'b01;

assign pclk_inv_cond = (~core_clk_2_pclk_ratio_sync[1]) |
		       ((core_clk_2_pclk_ratio_sync == 2'b10) & (root_clk_cnt[0] == 1'b0));

always @(posedge root_clk or negedge main_rstn_csync) begin
	if (!main_rstn_csync)
		div_n_pclk <= 1'b0;
	else if (pclk_inv_cond)
		div_n_pclk <= ~div_n_pclk;
end
always @(posedge root_clk or negedge main_rstn_csync) begin
	if (!main_rstn_csync)
		smu_hclk_2_pclk_ratio_sync <= 2'b00;
	else if ((smu_hclk_2_pclk_ratio_sync != smu_hclk_2_pclk_ratio) & (root_clk_cnt == 2'b11))
		smu_hclk_2_pclk_ratio_sync <= smu_hclk_2_pclk_ratio;
end
assign apb2ahb_clken_low_cond = (smu_core_clk_2_hclk_ratio_sync == 2'b00) ?
					(apb2ahb_clken & (smu_hclk_2_pclk_ratio_sync != 2'b00)) :
					(apb2ahb_clken & (smu_hclk_2_pclk_ratio_sync != 2'b00) & root_clk_cnt == 2'b00);

assign apb2ahb_clken_high_cond = (smu_core_clk_2_hclk_ratio_sync == 2'b00) ?
                                  ((smu_hclk_2_pclk_ratio_sync == 2'b00) & (root_clk_cnt == 2'b00)) |
				  ((smu_hclk_2_pclk_ratio_sync == 2'b01) & ((root_clk_cnt == 2'b01) | (root_clk_cnt == 2'b11))) |
				  ((smu_hclk_2_pclk_ratio_sync == 2'b10) & (root_clk_cnt == 2'b11)) :
				  ((smu_hclk_2_pclk_ratio_sync == 2'b00) & (root_clk_cnt == 2'b00)) |
				  ((smu_hclk_2_pclk_ratio_sync == 2'b01) & (root_clk_cnt == 2'b10));

always @(posedge root_clk or negedge main_rstn_csync) begin
	if (!main_rstn_csync)
		apb2ahb_clken <= 1'b0;
	else if (apb2ahb_clken_low_cond)
		apb2ahb_clken <= 1'b0;
	else if (apb2ahb_clken_high_cond)
		apb2ahb_clken <= 1'b1;
end
assign pclk_div_n_select_sync = core_clk_2_pclk_ratio_sync != 2'b00;

wire	      apb2core_clken_low_cond;
wire	      apb2core_clken_high_cond;

assign apb2core_clken_low_cond = (apb2core_clken & (core_clk_2_pclk_ratio_sync != 2'b00));
assign apb2core_clken_high_cond = ((core_clk_2_pclk_ratio_sync == 2'b00) & (root_clk_cnt == 2'b00)) |
				  ((core_clk_2_pclk_ratio_sync == 2'b01) & (root_clk_cnt[0])) |
				  ((core_clk_2_pclk_ratio_sync == 2'b10) & (root_clk_cnt[1:0] == 2'b11));
always @(posedge root_clk or negedge main_rstn_csync) begin
	if (!main_rstn_csync)
		apb2core_clken <= 1'b0;
	else if (apb2core_clken_low_cond)
		apb2core_clken <= 1'b0;
	else if (apb2core_clken_high_cond)
		apb2core_clken <= 1'b1;
end

assign axi2core_clken = 1'b1;

`else
	`ifdef SYNTHESIS

assign		aopd_pclk = T_osch;
assign		clk_32k = T_oscl;
assign		dm_clk = T_osch;
assign		core_clk = {NHART{T_osch}};
assign		dc_clk   = {NHART{T_osch}};
assign		lm_clk   = {NHART{T_osch}};
assign		aclk = T_osch;
assign		hclk = T_osch;
assign		pclk = T_osch;
assign		pclk_uart1 = T_osch;
assign		pclk_uart2 = T_osch;
assign		pclk_spi1 = T_osch;
assign		pclk_spi2 = T_osch;
assign		pclk_gpio = T_osch;
assign		pclk_pit = T_osch;
assign		pclk_i2c = T_osch;
assign		pclk_wdt = T_osch;
assign		apb2ahb_clken = 1'b1;
assign		ahb2core_clken = 1'b1;
assign		axi2core_clken = 1'b1;
assign		root_clk = T_osch;
assign		root_dfs_clk = {8{T_osch}};
assign		uart_clk = T_osch;
assign		spi_clk = T_osch;
assign		sdc_clk = T_osch;
assign		apb2core_clken = 1'b1;
assign		l2_clk   = T_osch;
	`else
wire		root_clk_premux;
wire		hclk_pri;
wire		pclk_pri;

wire		osch_div2_mux_test;
wire		hclk_mux_test;

reg		osch_div2;

reg	[1:0]	smu_core_clk_2_hclk_ratio_sync;
reg	[1:0]	smu_hclk_2_pclk_ratio_sync;

wire		hclk_clk_en;
wire		pclk_clk_en;
wire		pclk_uart1_clk_en;
wire		pclk_uart2_clk_en;
wire		pclk_spi1_clk_en;
wire		pclk_spi2_clk_en;
wire		pclk_gpio_clk_en;
wire		pclk_i2c_clk_en;
wire		pclk_wdt_clk_en;
wire		pclk_pit_clk_en;


always @(posedge T_osch or negedge main_rstn) begin
	if (!main_rstn)
		osch_div2	<= 1'b0;
	else
		osch_div2	<= ~osch_div2;
end

assign	osch_div2_mux_test = scan_test ? test_clk : osch_div2;
async_clkmux #(.ASYNC_CLK_MUX ("no")) u_core_clk_mux (
	.reset0_n	(main_rstn		),
	.reset1_n	(main_rstn		),
	.clk_in0	(T_osch			),
	.clk_in1	(osch_div2_mux_test	),
	.test_mode	(scan_enable		),
	.select		(smu_core_clk_sel	),
	.clk_out	(root_clk_premux	)
);

wire	root_clk_src = scan_test ? test_clk : root_clk_premux;
assign	root_clk = root_clk_src;

reg             hclk_div;
reg       [1:0] pclk_div;
wire      [1:0] pclk_div_addend;
wire      [1:0] pclk_div_nx = pclk_div + pclk_div_addend;
reg       [2:0] root_clk_cnt;
wire      [2:0] root_clk_cnt_nx = root_clk_cnt + 3'd1;
reg             uart_clk;

wire            root_clk_div4 = root_clk_cnt[1];

always @(posedge root_clk_src or negedge main_rstn_csync) begin
	if (!main_rstn_csync)
		hclk_div <= 1'b1;
	else
		hclk_div <= ~hclk_div;
end
always @(posedge root_clk_src or negedge main_rstn_csync) begin
	if (!main_rstn_csync)
		pclk_div <= 2'd2;
	else
		pclk_div <= pclk_div_nx;
end

always @(posedge root_clk_src or negedge main_rstn_csync) begin
	if (!main_rstn_csync)
		root_clk_cnt <= 3'd0;
	else
		root_clk_cnt <= root_clk_cnt_nx;
end

always @(posedge root_clk_src or negedge main_rstn_csync) begin
	if (!main_rstn_csync)
		uart_clk <= 1'b0;
	else
		uart_clk <= root_clk_div4;
end


assign pclk_div_addend =
	((smu_core_clk_2_hclk_ratio_sync == 2'd0) & (smu_hclk_2_pclk_ratio_sync == 2'd2)) ? 2'd1 :
        ((smu_core_clk_2_hclk_ratio_sync == 2'd1) & (smu_hclk_2_pclk_ratio_sync == 2'd1)) ? 2'd1 : 2'd2;

reg   [2:0] root_clk_cnt_dly;
always @(root_clk_cnt) begin
	root_clk_cnt_dly <= root_clk_cnt;
end

reg             clock_stable;
wire            clock_stable_nx;

wire            all_clocks_aligned = &root_clk_cnt_dly;
wire            clock_ratio_change;


always @(posedge root_clk_dly or negedge main_rstn_csync_dly) begin
	if (!main_rstn_csync_dly)
		clock_stable <= 1'b0;
	else
		clock_stable <= clock_stable_nx;
end

always @(posedge root_clk_dly or negedge main_rstn_csync_dly) begin
	if (!main_rstn_csync_dly) begin
		smu_core_clk_2_hclk_ratio_sync <= 2'd0;
		smu_hclk_2_pclk_ratio_sync     <= 2'd0;
	end
	else if (clock_ratio_change) begin
		smu_core_clk_2_hclk_ratio_sync <= smu_core_clk_2_hclk_ratio;
		smu_hclk_2_pclk_ratio_sync     <= smu_hclk_2_pclk_ratio;
	end
end

assign clock_ratio_change = clock_stable & all_clocks_aligned &
	((smu_core_clk_2_hclk_ratio_sync != smu_core_clk_2_hclk_ratio) |
	 (smu_hclk_2_pclk_ratio_sync != smu_hclk_2_pclk_ratio));

assign clock_stable_nx    = clock_ratio_change  ? 1'b0 :
                            &all_clocks_aligned ? 1'b1 : clock_stable;

assign  clock_unstable = ( clock_stable &  clock_ratio_change)
                       | (~clock_stable & ~all_clocks_aligned);

wire  aclk_en = smu_aclk_en;

wire	aclk_src;
assign	aclk = aclk_src;

gck gck_aclk(
	.clk_out	(aclk_src		),
	.clk_en		(aclk_en		),
	.clk_in		(root_clk_dly		),
	.test_en	(scan_enable		)
);

reg      [1:0] core_clk_cnt;
wire     [1:0] core_clk_cnt_nx = core_clk_cnt + 2'd1;

always @(posedge aclk_src or negedge main_rstn_csync_dly) begin
	if (!main_rstn_csync_dly)
		core_clk_cnt <= 2'd3;
	else
		core_clk_cnt <= core_clk_cnt_nx;
end

assign ahb2core_clken =
	(smu_core_clk_2_hclk_ratio_sync == 2'd0) |
	((smu_core_clk_2_hclk_ratio_sync == 2'd1) & core_clk_cnt[0]);

assign apb2core_clken =
	((smu_core_clk_2_hclk_ratio_sync == 2'd0) & (smu_hclk_2_pclk_ratio_sync == 2'd0)) |
	((smu_core_clk_2_hclk_ratio_sync == 2'd0) & (smu_hclk_2_pclk_ratio_sync == 2'd1) & (core_clk_cnt[0] == 1'd1)) |
	((smu_core_clk_2_hclk_ratio_sync == 2'd0) & (smu_hclk_2_pclk_ratio_sync == 2'd2) & (core_clk_cnt    == 2'd3)) |
	((smu_core_clk_2_hclk_ratio_sync == 2'd1) & (smu_hclk_2_pclk_ratio_sync == 2'd0) & (core_clk_cnt[0] == 1'd1)) |
	((smu_core_clk_2_hclk_ratio_sync == 2'd1) & (smu_hclk_2_pclk_ratio_sync == 2'd1) & (core_clk_cnt    == 2'd3));

assign axi2core_clken = 1'b1;

wire         hclk_mux_in0 = root_clk_dly;
wire         hclk_mux_in1 = hclk_div;
wire         hclk_mux_sel = (smu_core_clk_2_hclk_ratio_sync != 2'd0);

async_clkmux #(.ASYNC_CLK_MUX ("no")) u_hclk_mux (
	.reset0_n	(main_rstn_csync	),
	.reset1_n	(main_rstn_csync	),
	.clk_in0	(hclk_mux_in0		),
	.clk_in1	(hclk_mux_in1		),
	.test_mode	(scan_enable		),
	.select		(hclk_mux_sel		),
	.clk_out	(hclk_pri		)
);

assign	hclk_mux_test	= scan_test ? test_clk : hclk_pri;

assign  hclk_clk_en = smu_hclk_en & ~clock_unstable;

wire	hclk_src;
assign	hclk = hclk_src;

gck gck_hclk (
	.clk_out	(hclk_src		),
	.clk_en		(hclk_clk_en		),
	.clk_in		(hclk_mux_test		),
	.test_en	(scan_enable		)
);

reg    [1:0] hclk_cnt;
wire   [1:0] hclk_cnt_nx = hclk_cnt + 2'd1;
always @(posedge hclk_src or negedge main_rstn_csync_dly) begin
	if (!main_rstn_csync_dly)
		hclk_cnt <= 2'd3;
	else
		hclk_cnt <= hclk_cnt_nx;
end

assign apb2ahb_clken =  (smu_hclk_2_pclk_ratio_sync == 2'd0)
                     | ((smu_hclk_2_pclk_ratio_sync == 2'd1) & (hclk_cnt[0] == 1'b1))
                     | ((smu_hclk_2_pclk_ratio_sync == 2'd2) & (hclk_cnt    == 2'd3));


wire          pclk_mux_in0 = root_clk_dly;
wire          pclk_mux_in1 = pclk_div[1];
wire          pclk_mux_sel = (smu_core_clk_2_hclk_ratio_sync != 2'b0) | (smu_hclk_2_pclk_ratio_sync != 2'b0);

async_clkmux #(.ASYNC_CLK_MUX ("no")) u_pclk_a1_mux (
	.reset0_n	(main_rstn_csync	),
	.reset1_n	(main_rstn_csync	),
	.clk_in0	(pclk_mux_in0		),
	.clk_in1	(pclk_mux_in1		),
	.test_mode	(scan_enable		),
	.select		(pclk_mux_sel		),
	.clk_out	(pclk_pri		)
);

assign pclk_mux_test = scan_test ? test_clk : pclk_pri;
assign pclk_clk_en   = smu_pclk_en & ~clock_unstable;
assign pclk_uart1_clk_en = smu_pclk_uart1_en & ~clock_unstable;
assign pclk_uart2_clk_en = smu_pclk_uart2_en & ~clock_unstable;
assign pclk_spi1_clk_en  = smu_pclk_spi1_en  & ~clock_unstable;
assign pclk_spi2_clk_en  = smu_pclk_spi1_en  & ~clock_unstable;
assign pclk_gpio_clk_en  = smu_pclk_gpio_en  & ~clock_unstable;
assign pclk_i2c_clk_en   = smu_pclk_i2c_en   & ~clock_unstable;
assign pclk_wdt_clk_en   = smu_pclk_wdt_en   & ~clock_unstable;
assign pclk_pit_clk_en   = smu_pclk_pit_en   & ~clock_unstable;

gck gck_pclk (
	.clk_out	(pclk			),
	.clk_en		(pclk_clk_en		),
	.clk_in		(pclk_mux_test		),
	.test_en	(scan_enable		)
);

gck gck_pclk_uart1 (
	.clk_out	(pclk_uart1		),
	.clk_en		(pclk_uart1_clk_en	),
	.clk_in		(pclk_mux_test		),
	.test_en	(scan_enable		)
);
gck gck_pclk_uart2 (
	.clk_out	(pclk_uart2		),
	.clk_en		(pclk_uart2_clk_en	),
	.clk_in		(pclk_mux_test		),
	.test_en	(scan_enable		)
);
gck gck_pclk_spi1 (
	.clk_out	(pclk_spi1		),
	.clk_en		(pclk_spi1_clk_en	),
	.clk_in		(pclk_mux_test		),
	.test_en	(scan_enable		)
);
gck gck_pclk_spi2 (
	.clk_out	(pclk_spi2		),
	.clk_en		(pclk_spi2_clk_en	),
	.clk_in		(pclk_mux_test		),
	.test_en	(scan_enable		)
);
gck gck_pclk_gpio (
	.clk_out	(pclk_gpio		),
	.clk_en		(pclk_gpio_clk_en	),
	.clk_in		(pclk_mux_test		),
	.test_en	(scan_enable		)
);
gck gck_pclk_i2c (
	.clk_out	(pclk_i2c		),
	.clk_en		(pclk_i2c_clk_en	),
	.clk_in		(pclk_mux_test		),
	.test_en	(scan_enable		)
);
gck gck_pclk_wdt (
	.clk_out	(pclk_wdt		),
	.clk_en		(pclk_wdt_clk_en	),
	.clk_in		(pclk_mux_test		),
	.test_en	(scan_enable		)
);
gck gck_pclk_pit (
	.clk_out	(pclk_pit		),
	.clk_en		(pclk_pit_clk_en	),
	.clk_in		(pclk_mux_test		),
	.test_en	(scan_enable		)
);


assign aopd_pclk = pclk_mux_test;

gck gck_spi_clk (
	.clk_out	(spi_clk		),
	.clk_en		(pcs_clk_en[2]		),
	.clk_in		(T_osch			),
	.test_en	(scan_enable		)
);

gck gck_sdc_clk (
	.clk_out	(sdc_clk		),
	.clk_en		(pcs_clk_en[2]		),
	.clk_in		(T_osch			),
	.test_en	(scan_enable		)
);

gck gck_clk_32k (
	.clk_out	(clk_32k		),
	.clk_en		(pcs_clk_en[2]		),
	.clk_in		(T_oscl			),
	.test_en	(scan_enable		)
);


wire	dm_clk_en;
wire	dm_clk_src;
assign dm_clk_en = pcs_clk_en[1];
assign dm_clk    = dm_clk_src;

gck gck_dm_clk(
	.clk_out	(dm_clk_src		),
	.clk_en		(dm_clk_en		),
	.clk_in		(root_clk_dly		),
	.test_en	(scan_enable		)
);


wire	[(NHART-1):0] core_clk_en;
wire	[(NHART-1):0] core_clk_src;
wire	[(NHART-1):0] dc_clk_en;
wire	[(NHART-1):0] dc_clk_src;
wire	[(NHART-1):0] lm_clk_en;
wire	[(NHART-1):0] lm_clk_src;
wire    [(NHART-1):0] l2c_clk_en;
wire		      l2_clk_src;
wire                  l2_clk_en;

genvar i_clk;
generate
for (i_clk = 0; i_clk < NHART; i_clk = i_clk +1) begin: gen_simulation_clk
            wire gck_core_clk_in = root_clk_dly;
            wire gck_dc_clk_in   = root_clk_dly;
            wire gck_lm_clk_in   = root_clk_dly;

	assign core_clk_en[i_clk] = (pcs_clk_en[(i_clk+3)] & core_clkon[i_clk] & clk_en_aclk_sync_dfs[i_clk]);
	assign core_clk[i_clk]    = core_clk_src[i_clk];
	gck gck_core_clk(
		.clk_out	(core_clk_src[i_clk]	),
		.clk_en		(core_clk_en[i_clk]	),
		.clk_in		(gck_core_clk_in	),
		.test_en	(scan_enable		)
	);

	assign dc_clk_en[i_clk] = (pcs_clk_en[(i_clk+3)] & dc_clkon[i_clk] & clk_en_aclk_sync_dfs[i_clk]);
	assign dc_clk[i_clk]    = dc_clk_src[i_clk];
	gck gck_dc_clk(
		.clk_out	(dc_clk_src[i_clk]	),
		.clk_en		(dc_clk_en[i_clk]	),
		.clk_in		(gck_dc_clk_in		),
		.test_en	(scan_enable		)
	);

	assign lm_clk_en[i_clk] = (pcs_clk_en[(i_clk+3)] & lm_clkon[i_clk] & clk_en_aclk_sync_dfs[i_clk]);
	assign lm_clk[i_clk]    = lm_clk_src[i_clk];
	gck gck_lm_clk(
		.clk_out	(lm_clk_src[i_clk]	),
		.clk_en		(lm_clk_en[i_clk]	),
		.clk_in		(gck_lm_clk_in		),
		.test_en	(scan_enable		)
	);

	assign l2c_clk_en[i_clk] = (smu_aclk_en & l2c_clkon[i_clk]);

end
endgenerate

assign l2_clk_en = (|l2c_clk_en[NHART-1:0]);
assign l2_clk    = l2_clk_src;
gck gck_l2_clk(
	.clk_out	(l2_clk_src		),
	.clk_en		(l2_clk_en        ),
	.clk_in		(root_clk_dly		),
	.test_en	(scan_enable		)
);

            assign root_dfs_clk = {8{root_clk}};

	`endif
`endif
endmodule
