// Copyright (C) 2021, Andes Technology Corp. Confidential Proprietary

`include "atcuart100_config.vh"
`include "atcuart100_const.vh"

module atcuart100_rxctrl (
	  uclk,
	  urstn,
	  pclk,
	  presetn,
	  fifo_enable,
	  dma_mode,
	  rxfifo_threshold,
	  fcr_rxfifo_rst,
	  auto_rts,
	  rxfifo_dataout,
	  rxfifo_read,
	  rxfifo_empty,
	  lsr_overrun,
	  stfifo_dataout,
	  stfifo_error,
	  rx_over_clr,
	  lsr_read,
	  parity_err,
	  framing_err,
	  rx_break,
	  rxfifo_datain,
	  rxfifo_write,
	  uart_rx_busy,
	  uart_timeout_wen,
	  rxfifo_empty_uclk,
	  rxfifo_read_uclk,
	  rx_active,
	  rx_dr_intr,
	  rx_timeout_intr,
	  dma_rx_req,
	  dma_rx_ack
);

localparam [31:0] RX_FIFO_DEPTH = (1<<`ATCUART100_FIFO_DEPTH_BIT);

input				uclk;
input				urstn;
input				pclk;
input				presetn;

input				fifo_enable;
input				dma_mode;
input	[1:0]			rxfifo_threshold;
input				fcr_rxfifo_rst;
output				auto_rts;
output	[7:0]			rxfifo_dataout;
input				rxfifo_read;
output				rxfifo_empty;
output				lsr_overrun;
output	[2:0]			stfifo_dataout;
output				stfifo_error;
input				rx_over_clr;
input				lsr_read;

input				parity_err;
input				framing_err;
input				rx_break;
input	[7:0]			rxfifo_datain;
input				rxfifo_write;
input				uart_rx_busy;
input				uart_timeout_wen;
output				rxfifo_empty_uclk;
output				rxfifo_read_uclk;
output				rx_active;
output				rx_dr_intr;
output				rx_timeout_intr;

output				dma_rx_req;
input				dma_rx_ack;

wire	[2:0]				s0;
wire	[2:0]				s1;
wire					s2;
wire					s3;
wire	[10:0]				s4;
wire	[10:0]				s5;
reg					s6;
wire					rxfifo_empty;
wire					s7;
wire					s8;
wire	[`ATCUART100_FIFO_DEPTH_BIT:0]	s9;
wire					s10;
reg					s11;

wire	[`ATCUART100_FIFO_DEPTH_BIT:0]	wr_ptr;
wire	[`ATCUART100_FIFO_DEPTH_BIT:0]	rd_ptr;

reg					s12;
`ifdef ATCUART100_UCLK_PCLK_SAME
`else
wire	[10:0]				s13;
wire	[10:0]				s14;
wire					s15;
reg					s16;
wire					s17;
reg	[2:0]				s18;
wire					s19;
`endif
reg					s20;
reg	[`ATCUART100_FIFO_DEPTH_BIT:0]	s21;

wire					s22;
wire					s23;
reg					s24;
reg					s25;

assign auto_rts           = ~s23;
assign rx_active          = uart_rx_busy;
assign s2 = (~s7) & rxfifo_write;
assign s0      = {rx_break, framing_err, parity_err};
assign rx_dr_intr         = fifo_enable ? s22 : (~rxfifo_empty);

always @(negedge urstn or posedge uclk)
begin
	if (~urstn)
		s6 <= 1'b0;
	else if (s7 & rxfifo_write)
		s6 <= 1'b1;
	else if (rx_over_clr)
		s6 <= 1'b0;
end

`ifdef ATCUART100_UCLK_PCLK_SAME
assign lsr_overrun = s6;
assign s10 = uart_timeout_wen;

`else
nds_sync_l2l lsr_overrun_syn (
	.b_reset_n(presetn),
	.b_clk(pclk),
	.a_signal(s6),
	.b_signal(lsr_overrun),
	.b_signal_rising_edge_pulse(),
	.b_signal_falling_edge_pulse(),
	.b_signal_edge_pulse()
);

nds_sync_p2p uart_timeout_wen_syn (
	.a_reset_n(urstn),
	.a_clk(uclk),
	.a_pulse(uart_timeout_wen),
	.b_reset_n(presetn),
	.b_clk(pclk),
	.b_pulse(s10),
	.b_level(),
	.b_level_d1()
);

`endif

always @(negedge presetn or posedge pclk)
begin
	if (~presetn)
		s11 <= 1'b0;
	else if (~fifo_enable)
		s11 <= 1'b0;
	else if (rxfifo_read)
		s11 <= 1'b0;
	else if (s10)
		s11 <= 1'b1;
end

assign rx_timeout_intr = s11;

always @(negedge presetn or posedge pclk)
begin
	if (~presetn)
		s20 <= 1'b0;
	else if ((~fifo_enable) | fcr_rxfifo_rst)
		s20 <= 1'b0;
	else if (s3 & (|s1))
		s20 <= 1'b1;
	else if (rxfifo_read & (rd_ptr == s21))
		s20 <= 1'b0;
end

always @(negedge presetn or posedge pclk)
begin
	if (~presetn)
		s21 <= {(`ATCUART100_FIFO_DEPTH_BIT + 1){1'b0}};
	else if ((~fifo_enable) | fcr_rxfifo_rst)
		s21 <= {(`ATCUART100_FIFO_DEPTH_BIT + 1){1'b0}};
	else if (s3 & (|s1))
		s21 <= wr_ptr;
end

assign stfifo_error = s20;

nds_sync_fifo_clr #(
        .DATA_WIDTH (11),
        .FIFO_DEPTH (RX_FIFO_DEPTH),
        .POINTER_INDEX_WIDTH ((`ATCUART100_FIFO_DEPTH_BIT + 1))
) uart_rxfifo (
	.reset_n(presetn),
	.clk(pclk),
	.wr(s3),
	.wr_data(s4),
	.rd(rxfifo_read),
	.rd_data(s5),
	.empty(rxfifo_empty),
	.full(s8),
	.fifo_clr(fcr_rxfifo_rst),
	.wr_ptr(wr_ptr),
	.rd_ptr(rd_ptr)
);

assign rxfifo_dataout = s5[7:0];

always @(negedge presetn or posedge pclk)
begin
	if (~presetn)
		s12 <= 1'b0;
	else if (rxfifo_read | rxfifo_empty)
		s12 <= 1'b0;
	else if (lsr_read)
		s12 <= 1'b1;
end

assign stfifo_dataout = ((rxfifo_empty | s12) ? 3'h0 : s5[10:8]);

assign s9  = {s8, {wr_ptr[`ATCUART100_FIFO_DEPTH_BIT-1:0] - rd_ptr[`ATCUART100_FIFO_DEPTH_BIT-1:0]}};

`ifdef ATCUART100_UCLK_PCLK_SAME
assign rxfifo_empty_uclk = rxfifo_empty;
assign rxfifo_read_uclk  = rxfifo_read;

assign s1        = s0;
assign s3  = s2;
assign s4 = {s0, rxfifo_datain};
assign s7        = s8;

`else
assign s13 = {s0, rxfifo_datain};
wire   s26 = s3 | (~s15 & fcr_rxfifo_rst);
nds_async_buff #(.DATA_WIDTH (11)) rx_buffer (
	.w_reset_n(urstn),
	.r_reset_n(presetn),
	.w_clk(uclk),
	.r_clk(pclk),
	.wr(s2),
	.wr_data(s13),
	.rd(s26),
	.rd_data(s14),
	.empty(s15),
	.full(s17)
);

always @(negedge presetn or posedge pclk)
begin
	if (~presetn)
		s16 <= 1'b1;
	else if (s3 | fcr_rxfifo_rst)
		s16 <= 1'b1;
	else
		s16 <= s15;
end

always @(negedge presetn or posedge pclk)
begin
	if (~presetn)
		s18 <= 3'h0;
	else if (~s15)
		s18 <= s4[10:8];
end

assign s1        = s18;
assign s4 = s14;
assign s3  = (~s16) & (~s8);
assign s7        = s17;

nds_sync_l2l #(.RESET_VALUE (1'b1)) rxfifo_empty_syn (
	.b_reset_n(urstn),
	.b_clk(uclk),
	.a_signal(rxfifo_empty),
	.b_signal(s19),
	.b_signal_rising_edge_pulse(),
	.b_signal_falling_edge_pulse(),
	.b_signal_edge_pulse()
);

assign rxfifo_empty_uclk = s19 & (~s17);

nds_sync_p2p rxfifo_read_syn (
	.a_reset_n(presetn),
	.a_clk(pclk),
	.a_pulse(rxfifo_read),
	.b_reset_n(urstn),
	.b_clk(uclk),
	.b_pulse(rxfifo_read_uclk),
	.b_level(),
	.b_level_d1()
);

`endif

assign s23 = ((rxfifo_threshold == 2'h0) ? (~rxfifo_empty) :
                            ((rxfifo_threshold == 2'h1) ? (|s9[`ATCUART100_FIFO_DEPTH_BIT:`ATCUART100_FIFO_DEPTH_BIT-2]) :
                            ((rxfifo_threshold == 2'h2) ? (|s9[`ATCUART100_FIFO_DEPTH_BIT:`ATCUART100_FIFO_DEPTH_BIT-1]) :
                                                           (s9[`ATCUART100_FIFO_DEPTH_BIT] | (&s9[`ATCUART100_FIFO_DEPTH_BIT-1:`ATCUART100_FIFO_DEPTH_BIT-3]))
                            )));

assign s22 = s23;

always @(negedge presetn or posedge pclk)
begin
	if (~presetn)
		s24 <= 1'b0;
	else if (~(dma_mode & fifo_enable))
		s24 <= 1'b0;
	else if (s24)
		s24 <= (~rxfifo_empty);
	else
		s24 <= (s22 | s10);
end

always @(negedge presetn or posedge pclk)
begin
	if (~presetn)
		s25 <= 1'b0;
	else if (dma_rx_ack)
		s25 <= 1'b0;
	else if (dma_mode & fifo_enable)
		s25 <= (s25 | s22 | s10 | (s24 & (~rxfifo_empty)));
	else
		s25 <= (s25 | (~rxfifo_empty));
end

assign dma_rx_req = s25;

endmodule
