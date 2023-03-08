// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

`include "atcuart100_config.vh"
`include "atcuart100_const.vh"

module atcuart100_modem (
	  pclk,
	  presetn,
`ifdef ATCUART100_UCLK_PCLK_SAME
`else
	  uclk,
	  urstn,
`endif
	  uart_ctsn,
	  uart_dsrn,
	  uart_rin,
	  uart_dcdn,
	  uart_dtrn,
	  uart_rtsn,
	  uart_out1n,
	  uart_out2n,
	  mcr_auto_flow,
	  mcr_loop_mode,
	  mcr_out2,
	  mcr_out1,
	  mcr_rts,
	  mcr_dtr,
	  msr_dcts_wen,
	  msr_ddsr_wen,
	  msr_teri_wen,
	  msr_ddcd_wen,
	  msr_cts,
	  msr_dsr,
	  msr_ri,
	  msr_dcd,
	  auto_rts,
	  uart_loop_mode,
	  uart_auto_cts
);

input				pclk;
input				presetn;
`ifdef ATCUART100_UCLK_PCLK_SAME
`else
input				uclk;
input				urstn;
`endif

input				uart_ctsn;
input				uart_dsrn;
input				uart_rin;
input				uart_dcdn;
output				uart_dtrn;
output				uart_rtsn;
output				uart_out1n;
output				uart_out2n;
input				mcr_auto_flow;
input				mcr_loop_mode;
input				mcr_out2;
input				mcr_out1;
input				mcr_rts;
input				mcr_dtr;
output				msr_dcts_wen;
output				msr_ddsr_wen;
output				msr_teri_wen;
output				msr_ddcd_wen;
output				msr_cts;
output				msr_dsr;
output				msr_ri;
output				msr_dcd;
input				auto_rts;
output				uart_loop_mode;
output				uart_auto_cts;

wire				s0;
wire				s1;
wire				s2;
wire				s3;
reg				s4;
wire				s5;
wire				s6;
reg				s7;
wire				s8;
wire				s9;
reg				s10;
wire				s11;
wire				s12;
reg				s13;

`ifdef ATCUART100_UCLK_PCLK_SAME
`else
reg				s14;
`endif

nds_sync_l2l #(.RESET_VALUE (1'b1)) uart_ctsn_syn (
	.b_reset_n(presetn),
	.b_clk(pclk),
	.a_signal(uart_ctsn),
	.b_signal(s0),
	.b_signal_rising_edge_pulse(),
	.b_signal_falling_edge_pulse(),
	.b_signal_edge_pulse()
);

`ifdef ATCUART100_UCLK_PCLK_SAME
assign uart_loop_mode = mcr_loop_mode;
assign uart_auto_cts = s2;
`else
nds_sync_l2l uart_loop_mode_syn (
	.b_reset_n(urstn),
	.b_clk(uclk),
	.a_signal(mcr_loop_mode),
	.b_signal(uart_loop_mode),
	.b_signal_rising_edge_pulse(),
	.b_signal_falling_edge_pulse(),
	.b_signal_edge_pulse()
);

always @(negedge presetn or posedge pclk)
begin
	if (~presetn)
		s14 <= 1'b1;
	else
		s14 <= s2;
end

nds_sync_l2l #(.RESET_VALUE (1'b1)) auto_cts_syn (
	.b_reset_n(urstn),
	.b_clk(uclk),
	.a_signal(s14),
	.b_signal(uart_auto_cts),
	.b_signal_rising_edge_pulse(),
	.b_signal_falling_edge_pulse(),
	.b_signal_edge_pulse()
);
`endif

assign s3 = mcr_loop_mode ? s1 : (~s0);
assign s2 = mcr_auto_flow ? s3 : 1'b1;

always @(negedge presetn or posedge pclk)
begin
	if (~presetn)
		s4 <= 1'b0;
	else
		s4 <= s3;
end

assign msr_dcts_wen = s3 ^ s4;
assign msr_cts      = s3;

assign s1 = (mcr_auto_flow & mcr_rts) ? auto_rts : mcr_rts;
assign uart_rtsn = mcr_loop_mode ? 1'b1 : (~s1);


nds_sync_l2l #(.RESET_VALUE (1'b1)) uart_dsrn_syn (
	.b_reset_n(presetn),
	.b_clk(pclk),
	.a_signal(uart_dsrn),
	.b_signal(s5),
	.b_signal_rising_edge_pulse(),
	.b_signal_falling_edge_pulse(),
	.b_signal_edge_pulse()
);

assign s6 = mcr_loop_mode ? mcr_dtr : (~s5);

always @(negedge presetn or posedge pclk)
begin
	if (~presetn)
		s7 <= 1'b0;
	else
		s7 <= s6;
end

assign msr_ddsr_wen = s6 ^ s7;
assign msr_dsr      = s6;

assign uart_dtrn = mcr_loop_mode ? 1'b1 : (~mcr_dtr);

nds_sync_l2l #(.RESET_VALUE (1'b1)) uart_rin_syn (
	.b_reset_n(presetn),
	.b_clk(pclk),
	.a_signal(uart_rin),
	.b_signal(s8),
	.b_signal_rising_edge_pulse(),
	.b_signal_falling_edge_pulse(),
	.b_signal_edge_pulse()
);

assign s9 = mcr_loop_mode ? mcr_out1 : (~s8);

always @(negedge presetn or posedge pclk)
begin
	if (~presetn)
		s10 <= 1'b0;
	else
		s10 <= s9;
end

assign msr_teri_wen = (~s9) & s10;
assign msr_ri      = s9;

assign uart_out1n = mcr_loop_mode ? 1'b1 : (~mcr_out1);

nds_sync_l2l #(.RESET_VALUE (1'b1)) uart_dcdn_syn (
	.b_reset_n(presetn),
	.b_clk(pclk),
	.a_signal(uart_dcdn),
	.b_signal(s11),
	.b_signal_rising_edge_pulse(),
	.b_signal_falling_edge_pulse(),
	.b_signal_edge_pulse()
);

assign s12 = mcr_loop_mode ? mcr_out2 : (~s11);

always @(negedge presetn or posedge pclk)
begin
	if (~presetn)
		s13 <= 1'b0;
	else
		s13 <= s12;
end

assign msr_ddcd_wen = s12 ^ s13;
assign msr_dcd      = s12;

assign uart_out2n = mcr_loop_mode ? 1'b1 : (~mcr_out2);

endmodule

