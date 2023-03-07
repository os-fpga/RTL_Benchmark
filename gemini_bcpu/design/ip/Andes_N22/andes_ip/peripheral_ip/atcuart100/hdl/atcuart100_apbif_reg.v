// Copyright (C) 2021, Andes Technology Corp. Confidential Proprietary

`include "atcuart100_config.vh"
`include "atcuart100_const.vh"

module atcuart100_apbif_reg (
	  pclk,
	  presetn,
	  psel,
	  penable,
	  paddr,
	  pwdata,
	  pwrite,
	  prdata,
`ifdef ATCUART100_UCLK_PCLK_SAME
`else
	  uclk,
	  urstn,
`endif
	  rxfifo_dataout,
	  rxfifo_read,
	  txfifo_datain,
	  txfifo_write,
	  dll_reg,
	  dlm_reg,
	  rxfifo_threshold,
	  txfifo_threshold,
	  dma_mode,
	  fcr_txfifo_rst,
	  fcr_rxfifo_rst,
	  uart_fifo_enable,
	  fifo_enable,
	  mcr_auto_flow,
	  mcr_loop_mode,
	  mcr_out2,
	  mcr_out1,
	  mcr_rts,
	  mcr_dtr,
	  rx_timeout_intr,
	  tx_shift_empty,
	  txfifo_empty,
	  txfifo_full,
	  lsr_overrun,
	  rxfifo_empty,
	  rx_dr_intr,
	  msr_dcd,
	  msr_ri,
	  msr_dsr,
	  msr_cts,
	  msr_ddcd_wen,
	  msr_teri_wen,
	  msr_ddsr_wen,
	  msr_dcts_wen,
	  baud_initial,
	  oversample,
	  lcr_break,
	  lcr_parity_stick,
	  lcr_parity_even,
	  lcr_parity_enable,
	  lcr_stopbit,
	  lcr_wordlength,
	  stfifo_dataout,
	  stfifo_error,
	  rx_over_clr,
	  lsr_read,
	  uart_intr
);

input				pclk;
input				presetn;
input				psel;
input				penable;
input	[5:2]			paddr;
input	[31:0]			pwdata;
input				pwrite;
output	[31:0]			prdata;

`ifdef ATCUART100_UCLK_PCLK_SAME
`else
input				uclk;
input				urstn;
`endif

input	[7:0]			rxfifo_dataout;
output				rxfifo_read;
output	[7:0]			txfifo_datain;
output				txfifo_write;
output	[7:0]			dll_reg;
output	[7:0]			dlm_reg;
output	[1:0]			rxfifo_threshold;
output	[1:0]			txfifo_threshold;
output				dma_mode;
output				fcr_txfifo_rst;
output				fcr_rxfifo_rst;
output				uart_fifo_enable;
output				fifo_enable;
output				mcr_auto_flow;
output				mcr_loop_mode;
output				mcr_out2;
output				mcr_out1;
output				mcr_rts;
output				mcr_dtr;
input				rx_timeout_intr;
input				tx_shift_empty;
input				txfifo_empty;
input				txfifo_full;
input				lsr_overrun;
input				rxfifo_empty;
input				rx_dr_intr;
input				msr_dcd;
input				msr_ri;
input				msr_dsr;
input				msr_cts;
input				msr_ddcd_wen;
input				msr_teri_wen;
input				msr_ddsr_wen;
input				msr_dcts_wen;
output				baud_initial;
output	[4:1]			oversample;
output				lcr_break;
output				lcr_parity_stick;
output				lcr_parity_even;
output				lcr_parity_enable;
output				lcr_stopbit;
output	[1:0]			lcr_wordlength;
input	[2:0]			stfifo_dataout;
input				stfifo_error;
output				rx_over_clr;
output				lsr_read;

output				uart_intr;

wire		s0;
wire		s1;
wire		s2;
wire		s3;
wire		s4;
wire		s5;
wire		s6;
wire		s7;
wire		s8;
wire		s9;
wire		s10;
wire		s11;
wire		s12;

reg	[31:0]	prdata;
reg	[4:1]	s13;
reg	[3:0]	s14;
reg	[7:0]	dll_reg;
reg	[7:0]	dlm_reg;
reg	[7:0]	s15;
wire	[7:0]	s16;
reg	[7:0]	s17;
reg	[5:0]	s18;
wire	[7:0]	s19;
wire	[7:0]	s20;
reg	[7:0]	s21;

wire	[3:1]	s22;
wire		s23;

wire				s24;
wire				s25;
wire				s26;
wire				s27;
wire				s28;
wire				s29;
wire				s30;
wire				s31;
`ifdef ATCUART100_UCLK_PCLK_SAME
wire				s32;
reg				s33;
`else
wire				s34;
wire				s35;
wire				s36;
wire	[6:0]			s37;
`endif
wire				s38;
wire				s39;
wire				s40;
wire				s41;
wire				s42;
wire				s43;
reg				s44;
reg				s45;
wire				s46;
wire				s47;
wire				s48;
wire				s49;
wire				s50;
wire				s51;
wire				lsr_overrun;
wire				s52;
wire				s53;
reg				s54;
reg				s55;
reg				s56;
reg				s57;
wire				s58;

assign s0  = ({paddr, 2'h0} == 6'h14);
assign s1   = ({paddr, 2'h0} == 6'h20) & (s43 == 1'b0);
assign s2   = ({paddr, 2'h0} == 6'h24) & (s43 == 1'b0);
assign s3   = ({paddr, 2'h0} == 6'h20) & (s43 == 1'b1);
assign s4   = ({paddr, 2'h0} == 6'h24) & (s43 == 1'b1);
assign s5   = ({paddr, 2'h0} == 6'h28);
assign s6   = ({paddr, 2'h0} == 6'h28);
assign s7   = ({paddr, 2'h0} == 6'h2c);
assign s8   = ({paddr, 2'h0} == 6'h30);
assign s9   = ({paddr, 2'h0} == 6'h34);
assign s10   = ({paddr, 2'h0} == 6'h38);
assign s11   = ({paddr, 2'h0} == 6'h3c);

assign s12 = psel & pwrite & penable;

always @( * )
begin
	if (psel & (~pwrite))
		case(paddr)
			4'h0:	prdata = `ATCUART100_PRODUCT_ID;
			4'h4:	prdata = {28'h0, `ATCUART100_HWCFG};
			4'h5:	prdata = {27'h0, s13, 1'b0};
			4'h8: begin
				if (s43)
					prdata = {24'h0, dll_reg};
				else
					prdata = {24'h0, rxfifo_dataout};
			end
			4'h9: begin
				if (s43)
					prdata = {24'h0, dlm_reg};
				else
					prdata = {28'h0, s14};
			end
			4'ha:	prdata = {24'h0, s16};
			4'hb:	prdata = {24'h0, s17};
			4'hc:	prdata = {26'h0, s18};
			4'hd:	prdata = {24'h0, s19};
			4'he:	prdata = {24'h0, s20};
			4'hf:	prdata = {24'h0, s21};
			default:	prdata = 32'h0000;
		endcase
	else
		prdata = 32'h0000;
end


assign s24 = s12 & s0;
always @(negedge presetn or posedge pclk)
begin
	if (~presetn)
		s13 <= 4'h8;
	else if (s24)
		s13 <= ((pwdata[4:3] == 2'h0) & (pwdata[2:0] != 3'h0)) ? 4'h4 : pwdata[4:1];
end

`ifdef ATCUART100_UCLK_PCLK_SAME
assign oversample = s13;

`else
nds_sync_p2p_data #(
        .DATA_BIT (4),
        .RESET_DATA_VALUE (4'h8)
) oscr_reg_syn (
	.a_reset_n(presetn),
	.a_clk(pclk),
	.a_pulse(s24),
	.a_data(s13),
	.b_reset_n(urstn),
	.b_clk(uclk),
	.b_pulse(),
	.b_data(oversample),
	.b_level(),
	.b_level_d1()
);

`endif

assign rxfifo_read = psel & (~pwrite) & penable & s1 & ~rxfifo_empty;
assign txfifo_write = s12 & s1 & ~txfifo_full;
assign txfifo_datain = pwdata[7:0];

always @(negedge presetn or posedge pclk)
begin
	if (~presetn)
		s14 <= 4'h0;
	else if (s12 & s2)
		s14 <= pwdata[3:0];
end

assign s39 		= s14[3] & s58;
assign s40 		= s14[2] & s53;
assign s41 	= s14[1] & s45;
assign s42 		= s14[0] & rx_dr_intr;
assign s38 	= s14[0] & rx_timeout_intr;

assign s26 = s12 & s3;
always @(negedge presetn or posedge pclk)
begin
	if (~presetn)
		dll_reg <= 8'h1;
	else if (s26)
		dll_reg <= pwdata[7:0];
end

assign s27 = s12 & s4;
always @(negedge presetn or posedge pclk)
begin
	if (~presetn)
		dlm_reg <= 8'h0;
	else if (s27)
		dlm_reg <= pwdata[7:0];
end

`ifdef ATCUART100_UCLK_PCLK_SAME
assign s32 = (s26 | s27);
always @(negedge presetn or posedge pclk)
begin
	if (~presetn)
		s33 <= 1'b0;
	else if (s32)
		s33 <= 1'b1;
	else
		s33 <= 1'b0;
end

assign baud_initial = s33;

`else
nds_sync_p2p dll_wen_syn (
	.a_reset_n(presetn),
	.a_clk(pclk),
	.a_pulse(s26),
	.b_reset_n(urstn),
	.b_clk(uclk),
	.b_pulse(s34),
	.b_level(),
	.b_level_d1()
);

nds_sync_p2p dlm_wen_syn (
	.a_reset_n(presetn),
	.a_clk(pclk),
	.a_pulse(s27),
	.b_reset_n(urstn),
	.b_clk(uclk),
	.b_pulse(s35),
	.b_level(),
	.b_level_d1()
);

assign baud_initial = (s34 | s35);
`endif

always @(negedge presetn or posedge pclk)
begin
	if (~presetn)
		s44 <= 1'b1;
	else
		s44 <= txfifo_empty;
end

assign s28 = psel & (~pwrite) & penable & s5;
always @(negedge presetn or posedge pclk)
begin
	if (~presetn)
		s45 <= 1'b1;
	else if (txfifo_empty & (~s44))
		s45 <= 1'b1;
	else if ((s28 & (s22 == 3'b001)) | ((~txfifo_empty) & s44))
		s45 <= 1'b0;
end

assign s23 = (s40 || s42 || s38 || s41 || s39);
assign s22 = (s40   		? 3'b011 :
		      (s42   	? 3'b010 :
		      (s38   	? 3'b110 :
		      (s41   	? 3'b001 :
		      (s39   		? 3'b000 : 3'b000)))));

assign s16 = {{2{s15[0]}}, 2'h0, s22, ~s23};
assign s29 = s12 & s6;

always @(negedge presetn or posedge pclk)
begin
	if (~presetn)
		s15 <= 8'h0;
	else if (s29)
		s15 <= pwdata[7:0];
	else begin
		s15[7:3] <= s15[7:3];
		s15[2:1] <= 2'h0;
		s15[0] <= s15[0];
	end
end

assign rxfifo_threshold = s15[7:6];
assign txfifo_threshold = s15[5:4];
assign dma_mode = s15[3];
assign fcr_txfifo_rst = s15[2];
assign fcr_rxfifo_rst = s15[1];
assign fifo_enable = s15[0];

`ifdef ATCUART100_UCLK_PCLK_SAME
assign uart_fifo_enable = s15[0];

`else

nds_sync_l2l fcr_reg_syn (
	.b_reset_n(urstn),
	.b_clk(uclk),
	.a_signal(fifo_enable),
	.b_signal(uart_fifo_enable),
	.b_signal_rising_edge_pulse(),
	.b_signal_falling_edge_pulse(),
	.b_signal_edge_pulse()
);

`endif

assign s25 = s12 & s7;

always @(negedge presetn or posedge pclk)
begin
	if (~presetn)
		s17 <= 8'h0;
	else if (s25)
		s17 <= pwdata[7:0];
end

assign s43          = s17[7];
`ifdef ATCUART100_UCLK_PCLK_SAME
assign lcr_break         = s17[6];
assign lcr_parity_stick  = s17[5];
assign lcr_parity_even   = s17[4];
assign lcr_parity_enable = s17[3];
assign lcr_stopbit       = s17[2];
assign lcr_wordlength    = s17[1:0];

`else

nds_sync_p2p_data #(.DATA_BIT(7)) lcr_wen_syn (
	.a_reset_n(presetn),
	.a_clk(pclk),
	.a_pulse(s25),
	.a_data(s17[6:0]),
	.b_reset_n(urstn),
	.b_clk(uclk),
	.b_pulse(s36),
	.b_data(s37),
	.b_level(),
	.b_level_d1()
);

assign lcr_break         = s37[6];
assign lcr_parity_stick  = s37[5];
assign lcr_parity_even   = s37[4];
assign lcr_parity_enable = s37[3];
assign lcr_stopbit       = s37[2];
assign lcr_wordlength    = s37[1:0];

`endif

always @(negedge presetn or posedge pclk)
begin
	if (~presetn)
		s18 <= 6'h0;
	else if (s12 & s8)
		s18 <= pwdata[5:0];
end

assign mcr_auto_flow = s18[5];
assign mcr_loop_mode = s18[4];
assign mcr_out2      = s18[3];
assign mcr_out1      = s18[2];
assign mcr_rts       = s18[1];
assign mcr_dtr       = s18[0];

assign s46 = stfifo_error;
assign s47 = (tx_shift_empty & txfifo_empty);
assign s48 = txfifo_empty;
assign s49 = stfifo_dataout[2];
assign s50 = stfifo_dataout[1];
assign s51 = stfifo_dataout[0];
assign s52 = (~rxfifo_empty);
assign s19 = {s46, s47, s48, s49, s50, s51, lsr_overrun, s52};
assign s53 = (s49 | s50 | s51 | lsr_overrun);

assign s30 = psel & (~pwrite) & penable & s9;
assign lsr_read = s30;
`ifdef ATCUART100_UCLK_PCLK_SAME
assign rx_over_clr = s30;

`else
nds_sync_p2p lsr_read_syn (
	.a_reset_n(presetn),
	.a_clk(pclk),
	.a_pulse(s30),
	.b_reset_n(urstn),
	.b_clk(uclk),
	.b_pulse(rx_over_clr),
	.b_level(),
	.b_level_d1()
);

`endif

assign s31 = psel & (~pwrite) & penable & s10;

always @(negedge presetn or posedge pclk)
begin
	if (~presetn)
		s54 <= 1'b0;
	else if (msr_ddcd_wen)
		s54 <= 1'b1;
	else if (s31)
		s54 <= 1'b0;
end

always @(negedge presetn or posedge pclk)
begin
	if (~presetn)
		s55 <= 1'b0;
	else if (msr_teri_wen)
		s55 <= 1'b1;
	else if (s31)
		s55 <= 1'b0;
end

always @(negedge presetn or posedge pclk)
begin
	if (~presetn)
		s56 <= 1'b0;
	else if (msr_ddsr_wen)
		s56 <= 1'b1;
	else if (s31)
		s56 <= 1'b0;
end

always @(negedge presetn or posedge pclk)
begin
	if (~presetn)
		s57 <= 1'b0;
	else if (mcr_auto_flow)
		s57 <= 1'b0;
	else if (msr_dcts_wen)
		s57 <= 1'b1;
	else if (s31)
		s57 <= 1'b0;
end

assign s20 = {msr_dcd, msr_ri, msr_dsr, msr_cts, s54, s55, s56, s57};
assign s58 = (s54 | s55 | s56 | s57);

always @(negedge presetn or posedge pclk)
begin
	if (~presetn)
		s21 <= 8'h0;
	else if (s12 & s11)
		s21 <= pwdata[7:0];
end

assign uart_intr = s23;

endmodule

