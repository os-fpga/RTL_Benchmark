// Copyright (C) 2021, Andes Technology Corp. Confidential Proprietary

`include "ae250_smu_config.vh"
`include "ae250_smu_const.vh"

module ae250_smu_aopd_core (
	  clk_32k,
	  rtc_rstn,
	  pclk,
	  dbg_tck,
	  tckc_rstn,
	  pwdata,
	  aopd_prstn,
	  mpd_prstn,
	  hw_rst_d2,
	  wdt_rstn,
	  sw_rstn,
	  core2smu_wfi_mode,
	  rtc_alarm_wakeup,
	  T_wakeup_in,
	  wrsr_wen,
	  wr_mask_wen,
	  wr_mask_reg,
	  mpd_pwr_dis_wr_reg,
`ifdef AE250_SMU_SCRATCH_SUPPORT
	  scratch_wen,
	  scratch_reg,
`endif
	  wrsr_apor,
	  wrsr_mpor,
	  wrsr_hw_32k,
	  wrsr_wdt,
	  wrsr_sw,
	  wrsr_extw_32k,
	  wrsr_alm_32k,
	  wrsr_dbg_32k,
	  mpd_pwr_off,
	  mpd_iso_en
);

input				clk_32k;
input				rtc_rstn;
input				pclk;
input				dbg_tck;
input				tckc_rstn;

input	[31:0]			pwdata;
input				aopd_prstn;
input				mpd_prstn;
input				hw_rst_d2;
input				wdt_rstn;
input				sw_rstn;

input				core2smu_wfi_mode;
input				rtc_alarm_wakeup;
input				T_wakeup_in;

input				wrsr_wen;
input				wr_mask_wen;
output	[10:8]			wr_mask_reg;
input				mpd_pwr_dis_wr_reg;

`ifdef AE250_SMU_SCRATCH_SUPPORT
input				scratch_wen;
output	[`AE250_SMU_SCRATCH_BIT-1:0]	scratch_reg;
`endif
output				wrsr_apor;
output				wrsr_mpor;
output				wrsr_hw_32k;
output				wrsr_wdt;
output				wrsr_sw;
output				wrsr_extw_32k;
output				wrsr_alm_32k;
output				wrsr_dbg_32k;

output				mpd_pwr_off;
output				mpd_iso_en;

parameter  PWR_NORMAL	= 2'b00,
           PWR_ISO_EN	= 2'b01,
           PWR_OFF	= 2'b11,
           PWR_ON	= 2'b10;

wire		dbg_wakeup;
wire		dbg_wakeup_d2;

reg		wrsr_apor_r;
reg		wrsr_mpor_r;
reg		wrsr_hw_r;
reg		wrsr_wdt_r;
reg		wrsr_sw_r;
reg		wrsr_extw_r;
reg		wrsr_alm_r;
reg		wrsr_dbg_r;

reg		wrsr_hw_clr_r;
reg		wrsr_extw_clr_r;
reg		wrsr_alm_clr_r;
reg		wrsr_dbg_clr_r;
wire		wrsr_hw_clr_32k;
wire		wrsr_extw_clr_32k;
wire		wrsr_alm_clr_32k;
wire		wrsr_dbg_clr_32k;

wire		core2smu_wfi_mode_d2_r;
wire		sleeping;
wire		wakeup_syn_in;
wire		wakeup_syn_out;
reg		wakeup_syn_out_d1;

reg	[10:8]	wr_mask_reg;
wire	[10:8]	wr_mask;

wire		mpd_pwr_dis_wr_d2_r;
wire		mpd_prstn_d2;
reg		mpd_pwr_off_r;
reg		mpd_iso_en_r;
wire		wakeup_event;

reg	[1:0]	mpd_pwr_cs_r, mpd_pwr_ns;
`ifdef AE250_SMU_SCRATCH_SUPPORT
reg	[`AE250_SMU_SCRATCH_BIT-1:0]	scratch_reg;
`endif


always @(negedge aopd_prstn or posedge pclk)
begin
	if (!aopd_prstn)
		wrsr_apor_r <= 1'b1;
	else if (wrsr_wen & pwdata[0])
		wrsr_apor_r <= 1'b0;
	else
		wrsr_apor_r <= wrsr_apor_r;
end
assign wrsr_apor = wrsr_apor_r;

always @(negedge mpd_prstn or posedge pclk)
begin
	if (!mpd_prstn)
		wrsr_mpor_r <= 1'b1;
	else if (wrsr_wen & pwdata[1])
		wrsr_mpor_r <= 1'b0;
	else
		wrsr_mpor_r <= wrsr_mpor_r;
end
assign wrsr_mpor = wrsr_mpor_r;

always @(negedge aopd_prstn or posedge pclk)
begin
	if (!aopd_prstn)
		wrsr_hw_clr_r <= 1'b0;
	else if (wrsr_wen & pwdata[2])
		wrsr_hw_clr_r <= ~wrsr_hw_clr_r;
	else
		wrsr_hw_clr_r <= wrsr_hw_clr_r;
end

nds_sync_l2l wrsr_hw_clr_syn (
	.b_reset_n			(rtc_rstn),
	.b_clk				(clk_32k),
	.a_signal			(wrsr_hw_clr_r),
	.b_signal			(),
	.b_signal_rising_edge_pulse	(),
	.b_signal_falling_edge_pulse	(),
	.b_signal_edge_pulse		(wrsr_hw_clr_32k)
);

always @(negedge rtc_rstn or posedge clk_32k)
begin
	if (!rtc_rstn)
		wrsr_hw_r <= 1'b0;
	else if (hw_rst_d2)
		wrsr_hw_r <= 1'b1;
	else if (wrsr_hw_clr_32k)
		wrsr_hw_r <= 1'b0;
	else
		wrsr_hw_r <= wrsr_hw_r;
end
assign wrsr_hw_32k = wrsr_hw_r;

always @(negedge aopd_prstn or posedge pclk)
begin
	if (!aopd_prstn)
		wrsr_wdt_r <= 1'b0;
	else if (!wdt_rstn)
		wrsr_wdt_r <= 1'b1;
	else if (wrsr_wen & pwdata[3])
		wrsr_wdt_r <= 1'b0;
	else
		wrsr_wdt_r <= wrsr_wdt_r;
end
assign wrsr_wdt = wrsr_wdt_r;

always @(negedge aopd_prstn or posedge pclk)
begin
	if (!aopd_prstn)
		wrsr_sw_r <= 1'b0;
	else if (!sw_rstn)
		wrsr_sw_r <= 1'b1;
	else if (wrsr_wen & pwdata[4])
		wrsr_sw_r <= 1'b0;
	else
		wrsr_sw_r <= wrsr_sw_r;
end
assign wrsr_sw = wrsr_sw_r;

nds_sync_l2l core2smu_standby_syn_32k (
	.b_reset_n			(rtc_rstn),
	.b_clk				(clk_32k),
	.a_signal			(core2smu_wfi_mode),
	.b_signal			(core2smu_wfi_mode_d2_r),
	.b_signal_rising_edge_pulse	(),
	.b_signal_falling_edge_pulse	(),
	.b_signal_edge_pulse		()
);

assign sleeping = (core2smu_wfi_mode_d2_r | mpd_pwr_off_r);

`ifdef AE250_SMU_EXT_WAKEUP_HIGH
assign wakeup_syn_in = T_wakeup_in;
`else
assign wakeup_syn_in = ~T_wakeup_in;
`endif
nds_sync_l2l wakeup_in_syn (
	.b_reset_n			(rtc_rstn),
	.b_clk				(clk_32k),
	.a_signal			(wakeup_syn_in),
	.b_signal			(wakeup_syn_out),
	.b_signal_rising_edge_pulse	(),
	.b_signal_falling_edge_pulse	(),
	.b_signal_edge_pulse		()
);

always @(negedge rtc_rstn or posedge clk_32k)
begin
	if (!rtc_rstn)
		wakeup_syn_out_d1 <= 1'b0;
	else
		wakeup_syn_out_d1 <= wakeup_syn_out;
end

always @(negedge aopd_prstn or posedge pclk)
begin
	if (!aopd_prstn)
		wrsr_extw_clr_r <= 1'b0;
	else if (wrsr_wen & pwdata[8])
		wrsr_extw_clr_r <= ~wrsr_extw_clr_r;
	else
		wrsr_extw_clr_r <= wrsr_extw_clr_r;
end

nds_sync_l2l wrsr_extw_clr_syn (
	.b_reset_n			(rtc_rstn),
	.b_clk				(clk_32k),
	.a_signal			(wrsr_extw_clr_r),
	.b_signal			(),
	.b_signal_rising_edge_pulse	(),
	.b_signal_falling_edge_pulse	(),
	.b_signal_edge_pulse		(wrsr_extw_clr_32k)
);

always @(negedge rtc_rstn or posedge clk_32k)
begin
	if (!rtc_rstn)
		wrsr_extw_r <= 1'b0;
	else if (sleeping & wakeup_syn_out & wakeup_syn_out_d1 & (~wr_mask[8]))
		wrsr_extw_r <= 1'b1;
	else if (wrsr_extw_clr_32k)
		wrsr_extw_r <= 1'b0;
	else
		wrsr_extw_r <= wrsr_extw_r;
end
assign wrsr_extw_32k = wrsr_extw_r;

always @(negedge aopd_prstn or posedge pclk)
begin
	if (!aopd_prstn)
		wrsr_alm_clr_r <= 1'b0;
	else if (wrsr_wen & pwdata[9])
		wrsr_alm_clr_r <= ~wrsr_alm_clr_r;
	else
		wrsr_alm_clr_r <= wrsr_alm_clr_r;
end

nds_sync_l2l wrsr_alm_clr_syn (
	.b_reset_n			(rtc_rstn),
	.b_clk				(clk_32k),
	.a_signal			(wrsr_alm_clr_r),
	.b_signal			(),
	.b_signal_rising_edge_pulse	(),
	.b_signal_falling_edge_pulse	(),
	.b_signal_edge_pulse		(wrsr_alm_clr_32k)
);

always @(negedge rtc_rstn or posedge clk_32k)
begin
	if (!rtc_rstn)
		wrsr_alm_r <= 1'b0;
	else if (sleeping & rtc_alarm_wakeup & (~wr_mask[9]))
		wrsr_alm_r <= 1'b1;
	else if (wrsr_alm_clr_32k)
		wrsr_alm_r <= 1'b0;
	else
		wrsr_alm_r <= wrsr_alm_r;
end
assign wrsr_alm_32k = wrsr_alm_r;

nds_sync_l2l mpd_pwr_off_tckc_syn (
	.b_reset_n			(tckc_rstn),
	.b_clk				(dbg_tck),
	.a_signal			(sleeping),
	.b_signal			(dbg_wakeup),
	.b_signal_rising_edge_pulse	(),
	.b_signal_falling_edge_pulse	(),
	.b_signal_edge_pulse		()
);

nds_sync_l2l mpd_pwr_off_clk32k_syn (
	.b_reset_n			(rtc_rstn),
	.b_clk				(clk_32k),
	.a_signal			(dbg_wakeup),
	.b_signal			(dbg_wakeup_d2),
	.b_signal_rising_edge_pulse	(),
	.b_signal_falling_edge_pulse	(),
	.b_signal_edge_pulse		()
);

always @(negedge aopd_prstn or posedge pclk)
begin
	if (!aopd_prstn)
		wrsr_dbg_clr_r <= 1'b0;
	else if (wrsr_wen & pwdata[10])
		wrsr_dbg_clr_r <= ~wrsr_dbg_clr_r;
	else
		wrsr_dbg_clr_r <= wrsr_dbg_clr_r;
end

nds_sync_l2l wrsr_dbg_clr_syn (
	.b_reset_n			(rtc_rstn),
	.b_clk				(clk_32k),
	.a_signal			(wrsr_dbg_clr_r),
	.b_signal			(),
	.b_signal_rising_edge_pulse	(),
	.b_signal_falling_edge_pulse	(),
	.b_signal_edge_pulse		(wrsr_dbg_clr_32k)
);

always @(negedge rtc_rstn or posedge clk_32k)
begin
	if (!rtc_rstn)
		wrsr_dbg_r <= 1'b0;
	else if (sleeping & dbg_wakeup_d2 & (~wr_mask[10]))
		wrsr_dbg_r <= 1'b1;
	else if (wrsr_dbg_clr_32k)
		wrsr_dbg_r <= 1'b0;
	else
		wrsr_dbg_r <= wrsr_dbg_r;
end
assign wrsr_dbg_32k = wrsr_dbg_r;

always @(negedge aopd_prstn or posedge pclk)
begin
	if (!aopd_prstn)
		wr_mask_reg <= 3'h0;
	else if (wr_mask_wen)
		wr_mask_reg <= pwdata[10:8];
end

defparam wr_mask_reg_syn.DATA_BIT = 3;
nds_sync_p2p_data wr_mask_reg_syn (
	.a_reset_n(aopd_prstn),
	.a_clk(pclk),
	.a_pulse(wr_mask_wen),
	.a_data(wr_mask_reg),
	.b_reset_n(rtc_rstn),
	.b_clk(clk_32k),
	.b_pulse(),
	.b_data(wr_mask),
	.b_level(),
	.b_level_d1()
);


nds_sync_l2l mpd_pwr_dis_wr_syn (
	.b_reset_n			(rtc_rstn),
	.b_clk				(clk_32k),
	.a_signal			(mpd_pwr_dis_wr_reg),
	.b_signal			(mpd_pwr_dis_wr_d2_r),
	.b_signal_rising_edge_pulse	(),
	.b_signal_falling_edge_pulse	(),
	.b_signal_edge_pulse		()
);

nds_sync_l2l mpd_prstn_syn (
	.b_reset_n			(rtc_rstn),
	.b_clk				(clk_32k),
	.a_signal			(mpd_prstn),
	.b_signal			(mpd_prstn_d2),
	.b_signal_rising_edge_pulse	(),
	.b_signal_falling_edge_pulse	(),
	.b_signal_edge_pulse		()
);

assign wakeup_event = (wrsr_extw_32k | wrsr_alm_32k | wrsr_dbg_32k);

always @*
begin
	case(mpd_pwr_cs_r)
		PWR_ISO_EN: begin
			mpd_pwr_ns = PWR_OFF;
		end
		PWR_OFF: begin
			if (wakeup_event & mpd_pwr_off_r)
				mpd_pwr_ns = PWR_ON;
			else
				mpd_pwr_ns = PWR_OFF;
		end
		PWR_ON: begin
			if (mpd_prstn_d2)
				mpd_pwr_ns = PWR_NORMAL;
			else
				mpd_pwr_ns = PWR_ON;
		end
		default: begin
			if (mpd_pwr_dis_wr_d2_r & (~mpd_pwr_off_r))
				mpd_pwr_ns = PWR_ISO_EN;
			else
				mpd_pwr_ns = PWR_NORMAL;
		end
	endcase
end

always @(negedge rtc_rstn or posedge clk_32k)
begin
	if (!rtc_rstn)
		mpd_pwr_cs_r <= PWR_NORMAL;
	else
		mpd_pwr_cs_r <= mpd_pwr_ns;
end

always @(negedge rtc_rstn or posedge clk_32k)
begin
	if (!rtc_rstn)
		mpd_pwr_off_r <= 1'b0;
	else
		mpd_pwr_off_r <= (mpd_pwr_cs_r == PWR_OFF);
end

always @(negedge rtc_rstn or posedge clk_32k)
begin
	if (!rtc_rstn)
		mpd_iso_en_r <= 1'b0;
	else
		mpd_iso_en_r <= (mpd_pwr_cs_r != PWR_NORMAL);
end

`ifdef AE250_SMU_MDP_PWR_OFF_HIGH
assign mpd_pwr_off = mpd_pwr_off_r;
`else
assign mpd_pwr_off = ~mpd_pwr_off_r;
`endif
assign mpd_iso_en = mpd_iso_en_r;

`ifdef AE250_SMU_SCRATCH_SUPPORT
always @(negedge aopd_prstn or posedge pclk)
begin
	if (!aopd_prstn)
		scratch_reg <= `AE250_SMU_SCRATCH_DEFAULT;
	else if (scratch_wen)
		scratch_reg <= pwdata[`AE250_SMU_SCRATCH_BIT-1:0];
end
`endif


endmodule

