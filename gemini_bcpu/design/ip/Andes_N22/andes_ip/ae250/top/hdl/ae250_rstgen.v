// Copyright (C) 2021, Andes Technology Corp. Confidential Proprietary

module ae250_rstgen (
		  dbg_srst_req,
		  T_osch,
		  uart_clk,
		  spi_clk,
		  pclk,
		  hclk,
		  core_clk,
		  root_clk,
		  T_hw_rstn,
		  sw_rstn,
		  wdt_rstn,
		  rtc_rstn,
		  test_mode,
		  test_rstn,
		  T_por_b,
		  init_calib_complete,
		  main_rstn,
		  main_rstn_csync,
		  uart_rstn,
		  spi_rstn,
		  presetn,
		  hresetn,
		  core_resetn,
		  smu_rstgen_core0_resetn,
		  por_b_psync,
		  por_rstn
);
input		dbg_srst_req;
input		T_osch;
input		uart_clk;
input		spi_clk;
input		pclk;
input		hclk;
input		core_clk;
input		root_clk;
input		T_hw_rstn;
input		sw_rstn;
input		wdt_rstn;
input		rtc_rstn;
input		test_mode;
input		test_rstn;
input		T_por_b;
input           init_calib_complete;


output		main_rstn;
output		main_rstn_csync;
output		uart_rstn;
output		spi_rstn;
output		presetn;
output		hresetn;
output		core_resetn;
input		smu_rstgen_core0_resetn;
output		por_b_psync;
output		por_rstn;

reg		main_rstn_sync1;
reg		main_rstn_sync2;
reg		main_rstn_csync1;
reg		main_rstn_csync2;
reg		sw_wdt_rstn;
reg	[2:0]	sw_wdt_cnt;
wire	[2:0]	sw_wdt_cnt_sub_one = sw_wdt_cnt - 3'd1;
reg		uart_rstn_sync1;
reg		uart_rstn_sync2;
reg		spi_rstn_sync1;
reg		spi_rstn_sync2;
reg		presetn_sync1;
reg		presetn_sync2;
reg		hresetn_sync1;
reg		hresetn_sync2;
reg             core_resetn_sync1;
reg             core_resetn_sync2;
reg		por_b_psync1;
reg		por_b_psync2;
reg	[3:0]	clock_stable_cnt;
wire	[3:0]	clock_stable_cnt_add_one = clock_stable_cnt + 4'd1;
reg		main_rstn_delay;
wire		por_hw_rstn;
wire		mix_rstn;
wire		por_b_tmux;
reg		hw_rstn_sync1;
reg		hw_rstn_sync2;
wire		hw_rstn_osch;
reg		hw_rstn_delay;
reg	[3:0]	hw_rstn_stable_cnt;
wire	[3:0]	hw_rstn_stable_cnt_add_one = hw_rstn_stable_cnt + 4'd1;
wire		por_rstn;

assign	por_rstn = por_b_tmux;

assign	por_hw_rstn	= por_b_tmux & rtc_rstn;
assign	main_rstn_csync	= test_mode ? test_rstn : main_rstn_csync2;
assign	spi_rstn	= test_mode ? test_rstn : spi_rstn_sync2;
assign	core_resetn	= test_mode ? test_rstn : core_resetn_sync2;
assign	por_b_tmux	= test_mode ? test_rstn : T_por_b;
assign	por_b_psync	= test_mode ? test_rstn : por_b_psync2;
assign	mix_rstn	= main_rstn_delay & hw_rstn_delay & ~dbg_srst_req & sw_wdt_rstn & init_calib_complete;

wire	main_rstn_src	= test_mode ? test_rstn : main_rstn_sync2;
wire	uart_rstn_src	= test_mode ? test_rstn : uart_rstn_sync2;
wire	presetn_src	= test_mode ? test_rstn : presetn_sync2;
wire	hresetn_src	= test_mode ? test_rstn : hresetn_sync2;

wire    core_resetn_src = hresetn_src & smu_rstgen_core0_resetn;

assign	main_rstn = main_rstn_src;
assign	uart_rstn = uart_rstn_src;
assign	presetn = presetn_src;
assign	hresetn = hresetn_src;

always @(posedge T_osch or negedge por_hw_rstn) begin
	if (!por_hw_rstn) begin
		main_rstn_sync1	<= 1'b0;
		main_rstn_sync2	<= 1'b0;
	end
	else begin
		main_rstn_sync1	<= 1'b1;
		main_rstn_sync2	<= main_rstn_sync1;
	end
end

always @(posedge root_clk or negedge main_rstn_src) begin
	if (!main_rstn_src) begin
		main_rstn_csync1 <= 1'b0;
		main_rstn_csync2 <= 1'b0;
	end
	else begin
		main_rstn_csync1 <= 1'b1;
		main_rstn_csync2 <= main_rstn_csync1;
	end
end

always @(posedge T_osch or negedge main_rstn_src) begin
	if (!main_rstn_src) begin
		clock_stable_cnt <= 4'h0;
	end
	else if (clock_stable_cnt != 4'hf) begin
		clock_stable_cnt <= clock_stable_cnt_add_one;
	end
end

always @(posedge T_osch or negedge main_rstn_src) begin
	if (!main_rstn_src) begin
		main_rstn_delay	<= 1'b0;
	end
	else begin
		main_rstn_delay <= (clock_stable_cnt == 4'hf);
	end
end

assign	hw_rstn_osch = hw_rstn_sync2;
always @(posedge T_osch or negedge T_hw_rstn) begin
	if (!T_hw_rstn) begin
		hw_rstn_sync1	<= 1'b0;
		hw_rstn_sync2	<= 1'b0;
	end
	else begin
		hw_rstn_sync1	<= 1'b1;
		hw_rstn_sync2	<= hw_rstn_sync1;
	end
end

always @(posedge T_osch or negedge hw_rstn_osch) begin
	if (!hw_rstn_osch) begin
		hw_rstn_stable_cnt <= 4'h0;
	end
	else if (hw_rstn_stable_cnt != 4'hf) begin
		hw_rstn_stable_cnt <= hw_rstn_stable_cnt_add_one;
	end
end

always @(posedge T_osch or negedge hw_rstn_osch) begin
	if (!hw_rstn_osch) begin
		hw_rstn_delay <= 1'b0;
	end
	else begin
		hw_rstn_delay <= (hw_rstn_stable_cnt == 4'hf);
	end
end

always @(posedge pclk or negedge por_b_tmux) begin
	if (!por_b_tmux) begin
		por_b_psync1	<= 1'b0;
		por_b_psync2	<= 1'b0;
	end
	else begin
		por_b_psync1	<= 1'b1;
		por_b_psync2	<= por_b_psync1;
	end
end

always @(posedge pclk or negedge main_rstn_csync2) begin
	if (!main_rstn_csync2)
		sw_wdt_rstn	<= 1'b1;
	else if (!sw_rstn | !wdt_rstn)
		sw_wdt_rstn	<= 1'b0;
	else if (sw_wdt_cnt == 3'h0)
		sw_wdt_rstn	<= 1'b1;
end

always @(posedge pclk or negedge main_rstn_csync2) begin
	if (!main_rstn_csync2)
		sw_wdt_cnt	<= 3'h0;
	else if (!sw_rstn | !wdt_rstn)
		sw_wdt_cnt	<= 3'h7;
	else if (|sw_wdt_cnt)
		sw_wdt_cnt	<= sw_wdt_cnt_sub_one;
end

always @(posedge uart_clk or negedge mix_rstn) begin
	if (!mix_rstn) begin
		uart_rstn_sync1	<= 1'b0;
		uart_rstn_sync2	<= 1'b0;
	end
	else begin
		uart_rstn_sync1	<= 1'b1;
		uart_rstn_sync2	<= uart_rstn_sync1;
	end
end

always @(posedge spi_clk or negedge mix_rstn) begin
	if (!mix_rstn) begin
		spi_rstn_sync1 <= 1'b0;
		spi_rstn_sync2 <= 1'b0;
	end
	else begin
		spi_rstn_sync1 <= 1'b1;
		spi_rstn_sync2 <= spi_rstn_sync1;
	end
end

always @(posedge pclk or negedge uart_rstn_src) begin
	if (!uart_rstn_src) begin
		presetn_sync1	<= 1'b0;
		presetn_sync2	<= 1'b0;
	end
	else begin
		presetn_sync1	<= 1'b1;
		presetn_sync2	<= presetn_sync1;
	end
end

always @(posedge hclk or negedge presetn_src) begin
	if (!presetn_src) begin
		hresetn_sync1	<= 1'b0;
		hresetn_sync2	<= 1'b0;
	end
	else begin
		hresetn_sync1	<= 1'b1;
		hresetn_sync2	<= hresetn_sync1;
	end
end

always @(posedge core_clk or negedge core_resetn_src) begin
	if (!core_resetn_src) begin
		core_resetn_sync1 <= 1'b0;
		core_resetn_sync2 <= 1'b0;
	end
	else begin
		core_resetn_sync1 <= 1'b1;
		core_resetn_sync2 <= core_resetn_sync1;
	end
end

endmodule
