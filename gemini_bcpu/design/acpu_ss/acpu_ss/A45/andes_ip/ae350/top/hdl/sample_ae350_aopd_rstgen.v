
module sample_ae350_aopd_rstgen (
		  clk_32k,
		  pclk,
		  dbg_tck,
		  T_aopd_por_b,
		  test_mode,
		  test_rstn,
		  hw_rstn_delay,
		  dbg_srst_req,
		  rtc_rstn,
		  aopd_por_b_psync,
		  aopd_por_b_tsync,
		  aopd_por_dbg_b_psync
);
input		clk_32k;
input		pclk;
input		dbg_tck;
input		T_aopd_por_b;
input		test_mode;
input		test_rstn;
input		hw_rstn_delay;
input		dbg_srst_req;

output		rtc_rstn;
output		aopd_por_b_psync;
output		aopd_por_b_tsync;
output		aopd_por_dbg_b_psync;

reg		rtc_rstn_32ksync1;
reg		rtc_rstn_32ksync2;
reg		aopd_por_b_psync1;
reg		aopd_por_b_psync2;
reg		aopd_por_b_tsync1;
reg		aopd_por_b_tsync2;
reg		aopd_por_dbg_b_psync1;
reg		aopd_por_dbg_b_psync2;

wire	por_dbg_mix_rstn;

wire	rtc_rstn_src	 = test_mode ? test_rstn : rtc_rstn_32ksync2;
assign	aopd_por_b_psync = test_mode ? test_rstn : aopd_por_b_psync2;
assign	aopd_por_b_tsync = test_mode ? test_rstn : aopd_por_b_tsync2;
assign	aopd_por_dbg_b_psync = test_mode ? test_rstn : aopd_por_dbg_b_psync2;

assign	rtc_rstn = rtc_rstn_src;

assign	por_dbg_mix_rstn = rtc_rstn_src & ~dbg_srst_req & hw_rstn_delay;

always @(posedge clk_32k or negedge T_aopd_por_b) begin
	if (!T_aopd_por_b) begin
		rtc_rstn_32ksync1	<= 1'b0;
		rtc_rstn_32ksync2	<= 1'b0;
	end
	else begin
		rtc_rstn_32ksync1	<= 1'b1;
		rtc_rstn_32ksync2	<= rtc_rstn_32ksync1;
	end
end

always @(posedge pclk or negedge por_dbg_mix_rstn) begin
	if (!por_dbg_mix_rstn) begin
		aopd_por_dbg_b_psync1 <= 1'b0;
		aopd_por_dbg_b_psync2 <= 1'b0;
	end
	else begin
		aopd_por_dbg_b_psync1 <= 1'b1;
		aopd_por_dbg_b_psync2 <= aopd_por_dbg_b_psync1;
	end
end

always @(posedge pclk or negedge rtc_rstn_src) begin
	if (!rtc_rstn_src) begin
		aopd_por_b_psync1 <= 1'b0;
		aopd_por_b_psync2 <= 1'b0;
	end
	else begin
		aopd_por_b_psync1 <= 1'b1;
		aopd_por_b_psync2 <= aopd_por_b_psync1;
	end
end

always @(posedge dbg_tck or negedge rtc_rstn_src) begin
	if (!rtc_rstn_src) begin
		aopd_por_b_tsync1 <= 1'b0;
		aopd_por_b_tsync2 <= 1'b0;
	end
	else begin
		aopd_por_b_tsync1 <= 1'b1;
		aopd_por_b_tsync2 <= aopd_por_b_tsync1;
	end
end

endmodule
