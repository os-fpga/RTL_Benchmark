// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

module ae350_vol_ctrl (

input		pcs0_iso			/* synthesis syn_keep=1 */,
input		pcs0_reten			/* synthesis syn_keep=1 */,
input		pcs0_vol_scale_req		/* synthesis syn_keep=1 */,
input	[2:0]	pcs0_vol_scale		/* synthesis syn_keep=1 */,
output		pcs0_vol_scale_ack		/* synthesis syn_keep=1 */,
output		pd0_vol_on			/* synthesis syn_keep=1 */,
input		pcs1_iso			/* synthesis syn_keep=1 */,
input		pcs1_reten			/* synthesis syn_keep=1 */,
input		pcs1_vol_scale_req		/* synthesis syn_keep=1 */,
input	[2:0]	pcs1_vol_scale		/* synthesis syn_keep=1 */,
output		pcs1_vol_scale_ack		/* synthesis syn_keep=1 */,
output		pd1_vol_on			/* synthesis syn_keep=1 */,
input		pcs2_iso			/* synthesis syn_keep=1 */,
input		pcs2_reten			/* synthesis syn_keep=1 */,
input		pcs2_vol_scale_req		/* synthesis syn_keep=1 */,
input	[2:0]	pcs2_vol_scale		/* synthesis syn_keep=1 */,
output		pcs2_vol_scale_ack		/* synthesis syn_keep=1 */,
output		pd2_vol_on			/* synthesis syn_keep=1 */,
input		pcs3_iso			/* synthesis syn_keep=1 */,
input		pcs3_reten			/* synthesis syn_keep=1 */,
input		pcs3_vol_scale_req		/* synthesis syn_keep=1 */,
input	[2:0]	pcs3_vol_scale		/* synthesis syn_keep=1 */,
output		pcs3_vol_scale_ack		/* synthesis syn_keep=1 */,
output		pd3_vol_on			/* synthesis syn_keep=1 */,
input		pcs4_iso			/* synthesis syn_keep=1 */,
input		pcs4_reten			/* synthesis syn_keep=1 */,
input		pcs4_vol_scale_req		/* synthesis syn_keep=1 */,
input	[2:0]	pcs4_vol_scale		/* synthesis syn_keep=1 */,
output		pcs4_vol_scale_ack		/* synthesis syn_keep=1 */,
output		pd4_vol_on			/* synthesis syn_keep=1 */,
input		pcs5_iso			/* synthesis syn_keep=1 */,
input		pcs5_reten			/* synthesis syn_keep=1 */,
input		pcs5_vol_scale_req		/* synthesis syn_keep=1 */,
input	[2:0]	pcs5_vol_scale		/* synthesis syn_keep=1 */,
output		pcs5_vol_scale_ack		/* synthesis syn_keep=1 */,
output		pd5_vol_on			/* synthesis syn_keep=1 */,
input		pcs6_iso			/* synthesis syn_keep=1 */,
input		pcs6_reten			/* synthesis syn_keep=1 */,
input		pcs6_vol_scale_req		/* synthesis syn_keep=1 */,
input	[2:0]	pcs6_vol_scale		/* synthesis syn_keep=1 */,
output		pcs6_vol_scale_ack		/* synthesis syn_keep=1 */,
output		pd6_vol_on			/* synthesis syn_keep=1 */,
input		pcs7_iso			/* synthesis syn_keep=1 */,
input		pcs7_reten			/* synthesis syn_keep=1 */,
input		pcs7_vol_scale_req		/* synthesis syn_keep=1 */,
input	[2:0]	pcs7_vol_scale		/* synthesis syn_keep=1 */,
output		pcs7_vol_scale_ack		/* synthesis syn_keep=1 */,
output		pd7_vol_on			/* synthesis syn_keep=1 */,
input		pcs8_iso			/* synthesis syn_keep=1 */,
input		pcs8_reten			/* synthesis syn_keep=1 */,
input		pcs8_vol_scale_req		/* synthesis syn_keep=1 */,
input	[2:0]	pcs8_vol_scale		/* synthesis syn_keep=1 */,
output		pcs8_vol_scale_ack		/* synthesis syn_keep=1 */,
output		pd8_vol_on			/* synthesis syn_keep=1 */,
input		pcs9_iso			/* synthesis syn_keep=1 */,
input		pcs9_reten			/* synthesis syn_keep=1 */,
input		pcs9_vol_scale_req		/* synthesis syn_keep=1 */,
input	[2:0]	pcs9_vol_scale		/* synthesis syn_keep=1 */,
output		pcs9_vol_scale_ack		/* synthesis syn_keep=1 */,
output		pd9_vol_on			/* synthesis syn_keep=1 */,
input		pcs10_iso			/* synthesis syn_keep=1 */,
input		pcs10_reten			/* synthesis syn_keep=1 */,
input		pcs10_vol_scale_req		/* synthesis syn_keep=1 */,
input	[2:0]	pcs10_vol_scale		/* synthesis syn_keep=1 */,
output		pcs10_vol_scale_ack		/* synthesis syn_keep=1 */,
output		pd10_vol_on			/* synthesis syn_keep=1 */,
input		aopd_clk_32k,
input		aopd_rtc_rstn
);


wire voltage1_unstable = 1'b0;
pd_vol_ctrl pd1_vol_ctrl(.vol_on(pd1_vol_on), .clk(aopd_clk_32k), .rstn(aopd_rtc_rstn), .voltage_unstable(voltage1_unstable),
		 	.vol_scale_ack(pcs1_vol_scale_ack), .vol_scale_req(pcs1_vol_scale_req), .vol_scale(pcs1_vol_scale));
wire voltage2_unstable = 1'b0;
pd_vol_ctrl pd2_vol_ctrl(.vol_on(pd2_vol_on), .clk(aopd_clk_32k), .rstn(aopd_rtc_rstn), .voltage_unstable(voltage2_unstable),
		 	.vol_scale_ack(pcs2_vol_scale_ack), .vol_scale_req(pcs2_vol_scale_req), .vol_scale(pcs2_vol_scale));
wire voltage3_unstable = 1'b0;
pd_vol_ctrl pd3_vol_ctrl(.vol_on(pd3_vol_on), .clk(aopd_clk_32k), .rstn(aopd_rtc_rstn), .voltage_unstable(voltage3_unstable),
		 	.vol_scale_ack(pcs3_vol_scale_ack), .vol_scale_req(pcs3_vol_scale_req), .vol_scale(pcs3_vol_scale));
wire voltage4_unstable = 1'b0;
pd_vol_ctrl pd4_vol_ctrl(.vol_on(pd4_vol_on), .clk(aopd_clk_32k), .rstn(aopd_rtc_rstn), .voltage_unstable(voltage4_unstable),
		 	.vol_scale_ack(pcs4_vol_scale_ack), .vol_scale_req(pcs4_vol_scale_req), .vol_scale(pcs4_vol_scale));
wire voltage5_unstable = 1'b0;
pd_vol_ctrl pd5_vol_ctrl(.vol_on(pd5_vol_on), .clk(aopd_clk_32k), .rstn(aopd_rtc_rstn), .voltage_unstable(voltage5_unstable),
		 	.vol_scale_ack(pcs5_vol_scale_ack), .vol_scale_req(pcs5_vol_scale_req), .vol_scale(pcs5_vol_scale));
wire voltage6_unstable = 1'b0;
pd_vol_ctrl pd6_vol_ctrl(.vol_on(pd6_vol_on), .clk(aopd_clk_32k), .rstn(aopd_rtc_rstn), .voltage_unstable(voltage6_unstable),
		 	.vol_scale_ack(pcs6_vol_scale_ack), .vol_scale_req(pcs6_vol_scale_req), .vol_scale(pcs6_vol_scale));
wire voltage7_unstable = 1'b0;
pd_vol_ctrl pd7_vol_ctrl(.vol_on(pd7_vol_on), .clk(aopd_clk_32k), .rstn(aopd_rtc_rstn), .voltage_unstable(voltage7_unstable),
		 	.vol_scale_ack(pcs7_vol_scale_ack), .vol_scale_req(pcs7_vol_scale_req), .vol_scale(pcs7_vol_scale));
wire voltage8_unstable = 1'b0;
pd_vol_ctrl pd8_vol_ctrl(.vol_on(pd8_vol_on), .clk(aopd_clk_32k), .rstn(aopd_rtc_rstn), .voltage_unstable(voltage8_unstable),
		 	.vol_scale_ack(pcs8_vol_scale_ack), .vol_scale_req(pcs8_vol_scale_req), .vol_scale(pcs8_vol_scale));
wire voltage9_unstable = 1'b0;
pd_vol_ctrl pd9_vol_ctrl(.vol_on(pd9_vol_on), .clk(aopd_clk_32k), .rstn(aopd_rtc_rstn), .voltage_unstable(voltage9_unstable),
		 	.vol_scale_ack(pcs9_vol_scale_ack), .vol_scale_req(pcs9_vol_scale_req), .vol_scale(pcs9_vol_scale));
wire voltage10_unstable = 1'b0;
pd_vol_ctrl pd10_vol_ctrl(.vol_on(pd10_vol_on), .clk(aopd_clk_32k), .rstn(aopd_rtc_rstn), .voltage_unstable(voltage10_unstable),
		 	.vol_scale_ack(pcs10_vol_scale_ack), .vol_scale_req(pcs10_vol_scale_req), .vol_scale(pcs10_vol_scale));
assign		pcs0_vol_scale_ack = 1'b0		/* synthesis syn_keep=1 */;
assign		pd0_vol_on = 1'b1			/* synthesis syn_keep=1 */;

endmodule

