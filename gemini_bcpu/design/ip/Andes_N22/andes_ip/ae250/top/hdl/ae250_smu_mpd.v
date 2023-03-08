// Copyright (C) 2021, Andes Technology Corp. Confidential Proprietary

`include "ae250_smu_config.vh"
`include "ae250_smu_const.vh"

module ae250_smu_mpd (
	  T_osch,
	  main_rstn,
	  pclk,
	  presetn,
	  clk_32k,
	  rtc_rstn,
	  wrsr_wen,
	  pwdata,
	  wrsr_hw_32k,
	  wrsr_extw_32k,
	  wrsr_alm_32k,
	  wrsr_dbg_32k,
	  wrsr_hw,
	  wrsr_extw,
	  wrsr_alm,
	  wrsr_dbg,
	  standby_cmd_reg,
	  standby_cmd_clr,
	  smu2core_standby_req,
	  smu2core_wakeup_ok,
	  core2smu_wfi_mode,
	  clock_ratio_reg,
	  smu_core_clk_sel,
`ifdef NDS_FPGA
	  smu_core_clk_2_hclk_ratio, // synthesis syn_keep=1	// Reset value must be 2'b00 to match the clock mux default
	  smu_hclk_2_pclk_ratio, // synthesis syn_keep=1	// Reset value must be 2'b00 to match the clock mux default
`else
	  smu_core_clk_2_hclk_ratio,
	  smu_hclk_2_pclk_ratio,
`endif
	  T_hw_rstn,
	  hw_rst_d2

);

input				T_osch;
input				main_rstn;
input				pclk;
input				presetn;
input				clk_32k;
input				rtc_rstn;

input				wrsr_wen;
input	[31:0]			pwdata;
input				wrsr_hw_32k;
input				wrsr_extw_32k;
input				wrsr_alm_32k;
input				wrsr_dbg_32k;
output				wrsr_hw;
output				wrsr_extw;
output				wrsr_alm;
output				wrsr_dbg;
input				standby_cmd_reg;
output				standby_cmd_clr;
output				smu2core_standby_req;
output				smu2core_wakeup_ok;
input				core2smu_wfi_mode;
input	[3:0]			clock_ratio_reg;

output				smu_core_clk_sel;
`ifdef NDS_FPGA
(* KEEP = "TRUE" *)  output	[1:0]   smu_core_clk_2_hclk_ratio;// synthesis syn_keep=1	// Reset value must be 2'b00 to match the clock mux default
(* KEEP = "TRUE" *)  output	[1:0]	smu_hclk_2_pclk_ratio;// synthesis syn_keep=1	// Reset value must be 2'b00 to match the clock mux default
`else
output	[1:0]   smu_core_clk_2_hclk_ratio;
output	[1:0]	smu_hclk_2_pclk_ratio;
`endif
input				T_hw_rstn;
output				hw_rst_d2;

parameter  STDBY_IDLE        = 2'b00,
           STDBY_WAIT_STDBY  = 2'b01,
           STDBY_STANDBY     = 2'b11,
           STDBY_WAIT_NSTDBY = 2'b10;

reg	[1:0]	smu_core_clk_2_hclk_ratio;
reg	[1:0]	smu_hclk_2_pclk_ratio;
wire		standby_cmd;
wire		core2smu_wfi_mode_d2_r;
reg	[1:0]	standby_cs_r, standby_ns;
wire		standby_clr;
wire		standby_active;
reg	[5:0]	standby_cnt_r;
wire	[5:0]	standby_cnt_r_add_one = standby_cnt_r + 6'd1;

wire		wakeup_event;
wire		clk_wakeup_event;
wire		wrsr_wakeup_event;
reg		wrsr_wakeup_event_r;
wire		wrsr_wakeup_event_r_d2;

reg		smu2core_wakeup_ok_r;

reg	[3:0]	clock_ratio_out_pclk_r;
reg		clock_ratio_diff_pclk_r;
wire		clock_ratio_diff_d2_r;
reg		clock_ratio_diff_d3_r;
reg		is_stand_r;
wire		is_stand_d2_pclk_r;

wire		hw_rst;

nds_sync_l2l standby_cmd_reg_syn (
	.b_reset_n			(main_rstn),
	.b_clk				(T_osch),
	.a_signal			(standby_cmd_reg),
	.b_signal			(standby_cmd),
	.b_signal_rising_edge_pulse	(),
	.b_signal_falling_edge_pulse	(),
	.b_signal_edge_pulse		()
);

nds_sync_l2l standby_cmd_clr_syn (
	.b_reset_n			(presetn),
	.b_clk				(pclk),
	.a_signal			(standby_cmd),
	.b_signal			(standby_cmd_clr),
	.b_signal_rising_edge_pulse	(),
	.b_signal_falling_edge_pulse	(),
	.b_signal_edge_pulse		()
);

nds_sync_l2l core2smu_wfi_mode_syn (
	.b_reset_n			(main_rstn),
	.b_clk				(T_osch),
	.a_signal			(core2smu_wfi_mode),
	.b_signal			(core2smu_wfi_mode_d2_r),
	.b_signal_rising_edge_pulse	(),
	.b_signal_falling_edge_pulse	(),
	.b_signal_edge_pulse		()
);


always @*
begin
	case(standby_cs_r)
		STDBY_WAIT_STDBY: begin
			if (core2smu_wfi_mode_d2_r)
				standby_ns = STDBY_STANDBY;
			else
				standby_ns = STDBY_WAIT_STDBY;
		end
		STDBY_STANDBY: begin
			if (wakeup_event)
				standby_ns = STDBY_WAIT_NSTDBY;
			else
				standby_ns = STDBY_STANDBY;
		end
		STDBY_WAIT_NSTDBY: begin
			if (~core2smu_wfi_mode_d2_r)
				standby_ns = STDBY_IDLE;
			else
				standby_ns = STDBY_WAIT_NSTDBY;
		end
		default: begin
			if (standby_cmd)
				standby_ns = STDBY_WAIT_STDBY;
			else if (core2smu_wfi_mode_d2_r)
				standby_ns = STDBY_STANDBY;
			else
				standby_ns = STDBY_IDLE;
		end
	endcase
end

always @(negedge main_rstn or posedge T_osch)
begin
	if (!main_rstn)
		standby_cs_r <= STDBY_IDLE;
	else
		standby_cs_r <= standby_ns;
end

assign smu2core_standby_req = (standby_cs_r == STDBY_WAIT_STDBY);

always @(negedge main_rstn or posedge T_osch)
begin
	if (!main_rstn)
		smu2core_wakeup_ok_r <= 1'b0;
	else
		smu2core_wakeup_ok_r <= (standby_cs_r == STDBY_WAIT_NSTDBY);
end
assign smu2core_wakeup_ok = smu2core_wakeup_ok_r;

assign wrsr_wakeup_event = wrsr_wakeup_event_r_d2;
assign clk_wakeup_event = (standby_cs_r == STDBY_STANDBY) & clock_ratio_diff_d3_r & (&standby_cnt_r);
assign wakeup_event = clk_wakeup_event | wrsr_wakeup_event;


assign standby_clr = ((standby_ns == STDBY_STANDBY)&(standby_cs_r != STDBY_STANDBY));
assign standby_active = ((standby_cs_r == STDBY_STANDBY) & clock_ratio_diff_d3_r);

always @(negedge main_rstn or posedge T_osch)
begin
	if (!main_rstn)
		standby_cnt_r <= 6'h00;
	else if (standby_clr)
		standby_cnt_r <= 6'h00;
	else if (standby_active)
		standby_cnt_r <= standby_cnt_r_add_one;
	else
		standby_cnt_r <= standby_cnt_r;
end

always @(negedge main_rstn or posedge T_osch)
begin
	if (!main_rstn)
		is_stand_r <= 1'b0;
	else
		is_stand_r <= (standby_cs_r == STDBY_STANDBY);
end

nds_sync_l2l is_stand_r_syn (
	.b_reset_n			(presetn),
	.b_clk				(pclk),
	.a_signal			(is_stand_r),
	.b_signal			(is_stand_d2_pclk_r),
	.b_signal_rising_edge_pulse	(),
	.b_signal_falling_edge_pulse	(),
	.b_signal_edge_pulse		()
);

always @(negedge presetn or posedge pclk)
begin
	if (!presetn)
		clock_ratio_out_pclk_r <= `AE250_SMU_CLKR_DEFAULT;
	else if (clock_ratio_out_pclk_r != clock_ratio_reg)
		clock_ratio_out_pclk_r <= clock_ratio_reg;
	else
		clock_ratio_out_pclk_r <= clock_ratio_out_pclk_r;
end

always @(negedge presetn or posedge pclk)
begin
	if (!presetn)
		clock_ratio_diff_pclk_r <= 1'b0;
	else
		clock_ratio_diff_pclk_r <= (clock_ratio_out_pclk_r != clock_ratio_reg);
end

nds_sync_l2l clock_ratio_diff_syn (
	.b_reset_n			(main_rstn),
	.b_clk				(T_osch),
	.a_signal			(clock_ratio_diff_pclk_r),
	.b_signal			(clock_ratio_diff_d2_r),
	.b_signal_rising_edge_pulse	(),
	.b_signal_falling_edge_pulse	(),
	.b_signal_edge_pulse		()
);

always @(negedge main_rstn or posedge T_osch)
begin
	if (!main_rstn)
		clock_ratio_diff_d3_r <= 1'b0;
	else if ((~(|standby_cnt_r)) & clock_ratio_diff_d2_r)
		clock_ratio_diff_d3_r <= 1'b1;
	else if (clk_wakeup_event)
		clock_ratio_diff_d3_r <= 1'b0;
	else
		clock_ratio_diff_d3_r <= clock_ratio_diff_d3_r;
end

assign smu_core_clk_sel	= clock_ratio_out_pclk_r[0];
always @*
begin
	case(clock_ratio_out_pclk_r[3:1])
		3'b000: smu_core_clk_2_hclk_ratio = 2'b00;
		3'b001: smu_core_clk_2_hclk_ratio = 2'b00;
		3'b010: smu_core_clk_2_hclk_ratio = 2'b00;
		3'b011: smu_core_clk_2_hclk_ratio = 2'b01;
		3'b100: smu_core_clk_2_hclk_ratio = 2'b01;
		default: smu_core_clk_2_hclk_ratio = 2'b00;
	endcase
end
always @*
begin
	case(clock_ratio_out_pclk_r[3:1])
		3'b000: smu_hclk_2_pclk_ratio = 2'b00;
		3'b001: smu_hclk_2_pclk_ratio = 2'b01;
		3'b010: smu_hclk_2_pclk_ratio = 2'b10;
		3'b011: smu_hclk_2_pclk_ratio = 2'b00;
		3'b100: smu_hclk_2_pclk_ratio = 2'b01;
		default: smu_hclk_2_pclk_ratio = 2'b00;
	endcase
end
nds_sync_l2l wrsr_hw_osch_syn (
	.b_reset_n			(presetn),
	.b_clk				(pclk),
	.a_signal			(wrsr_hw_32k),
	.b_signal			(wrsr_hw),
	.b_signal_rising_edge_pulse	(),
	.b_signal_falling_edge_pulse	(),
	.b_signal_edge_pulse		()
);

nds_sync_l2l wrsr_extw_32k_syn (
	.b_reset_n			(presetn),
	.b_clk				(pclk),
	.a_signal			(wrsr_extw_32k),
	.b_signal			(wrsr_extw),
	.b_signal_rising_edge_pulse	(),
	.b_signal_falling_edge_pulse	(),
	.b_signal_edge_pulse		()
);

nds_sync_l2l wrsr_alm_32k_syn (
	.b_reset_n			(presetn),
	.b_clk				(pclk),
	.a_signal			(wrsr_alm_32k),
	.b_signal			(wrsr_alm),
	.b_signal_rising_edge_pulse	(),
	.b_signal_falling_edge_pulse	(),
	.b_signal_edge_pulse		()
);

nds_sync_l2l wrsr_dbg_32k_syn (
	.b_reset_n			(presetn),
	.b_clk				(pclk),
	.a_signal			(wrsr_dbg_32k),
	.b_signal			(wrsr_dbg),
	.b_signal_rising_edge_pulse	(),
	.b_signal_falling_edge_pulse	(),
	.b_signal_edge_pulse		()
);

always @(negedge rtc_rstn or posedge clk_32k)
begin
	if (!rtc_rstn)
		wrsr_wakeup_event_r <= 1'b0;
	else
		wrsr_wakeup_event_r <= (wrsr_extw_32k | wrsr_alm_32k | wrsr_dbg_32k);
end
nds_sync_l2l wrsr_wakeup_event_syn (
	.b_reset_n			(main_rstn),
	.b_clk				(T_osch),
	.a_signal			(wrsr_wakeup_event_r),
	.b_signal			(wrsr_wakeup_event_r_d2),
	.b_signal_rising_edge_pulse	(),
	.b_signal_falling_edge_pulse	(),
	.b_signal_edge_pulse		()
);

assign hw_rst = ~T_hw_rstn;
nds_sync_l2l hw_rstn_syn (
	.b_reset_n			(rtc_rstn),
	.b_clk				(clk_32k),
	.a_signal			(hw_rst),
	.b_signal			(hw_rst_d2),
	.b_signal_rising_edge_pulse	(),
	.b_signal_falling_edge_pulse	(),
	.b_signal_edge_pulse		()
);

endmodule

