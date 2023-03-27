// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

`include "atcwdt200_config.vh"
`include "atcwdt200_const.vh"

module atcwdt200 (
	  extclk,
	  wdt_pause,
	  wdt_rst,
	  wdt_int,
	  pclk,
	  presetn,
	  psel,
	  penable,
	  paddr,
	  pwrite,
	  pwdata,
	  prdata
);
`ifdef ATCWDT200_32BIT_TIMER
	parameter COUNTER_WIDTH = 32;
	parameter INT_TIME_WIDTH = 4;
`else
	parameter COUNTER_WIDTH = 16;
	parameter INT_TIME_WIDTH = 3;
`endif

parameter ST_INTTIME = 1'h0;
parameter ST_RSTTIME = 1'h1;

input			extclk;
input			wdt_pause;
output			wdt_rst;
output			wdt_int;

input			pclk;
input			presetn;
input			psel;
input			penable;
input	[4:2]		paddr;
input			pwrite;
input	[31:0]		pwdata;
output	[31:0]		prdata;

wire			wdt_rst;
wire			wdt_int;

reg	[4:2]		s0;

wire	[31:0]		prdata;
wire			s1;

reg	[2:0]		s2;
reg	[INT_TIME_WIDTH-1:0]	s3;
reg			s4;
reg			s5;
reg			s6;
reg			s7;
reg			s8;
reg			s9;
reg			s10;

wire	[3:0]		s11;
wire	[2:0]		s12;
wire	[INT_TIME_WIDTH-1:0]		s13;
wire			s14;
wire			s15;
wire			s16;
wire			s17;
wire			s18;
wire			s19;
wire			s20;

wire			s21;
wire			s22;
wire			s23;
wire			s24;
wire			s25;

reg	[COUNTER_WIDTH-1:0] s26;

wire	[31:0]              s27;
wire	[COUNTER_WIDTH-1:0] s28;

reg			s29;
reg			s30;
reg			s31;

wire			s32;
wire			s33;
wire			s34;
wire			s35;
wire			s36;
wire			s37;
wire			s38;
wire			s39;
wire			s40;
wire			s41;

always @(posedge pclk or negedge presetn) begin
	if (~presetn) begin
		s0	<= 3'h0;
	end else if (psel) begin
		s0	<= paddr;
	end
end

always @(posedge pclk or negedge presetn) begin
	if (~presetn) begin
		s2	<= 3'b0;
		s3	<= {INT_TIME_WIDTH{1'b0}};
		s4	<= 1'h0;
		s5	<= 1'h0;
		s6	<= 1'h0;
	end
	else if (s1 & s22 & s10) begin
		s2	<= s12;
		s3	<= s13;
		s4	<= s14;
		s5	<= s15;
		s6	<= s16;
	end
end

always @(posedge pclk or negedge presetn) begin
	if (~presetn) begin
		s7	<= 1'h0;
	end
	else if ((s1 & s22 & s10) | s38) begin
		s7	<= s17;
	end
end

always @(posedge pclk or negedge presetn) begin
	if (~presetn) begin
		s8	<= 1'h0;
	end
	else if ((s1 & s25) | s39) begin
		s8	<= s18;
	end
end

always @(posedge pclk or negedge presetn) begin
	if (~presetn) begin
		s9	<= 1'h0;
	end
	else if (s40) begin
		s9	<= s19;
	end
end

always @(posedge pclk or negedge presetn) begin
	if (~presetn) begin
		s10		<= 1'h0;
	end
	else if (s1) begin
		s10		<= s20;
	end
end

always @(posedge pclk or negedge presetn) begin
	if (~presetn) begin
		s26		<= {COUNTER_WIDTH{1'h0}};
	end
	else if (s34) begin
		s26		<= s28;
	end
end

`ifdef ATCWDT200_32BIT_TIMER
	assign s11	= s3;
	assign s27	= s26;
`else
	assign s11	= {1'b0, s3};
	assign s27	= {16'b0, s26};
`endif

always @(posedge pclk or negedge presetn) begin
	if (~presetn) begin
		s30		<= ST_INTTIME;
	end
	else if (~s41 & (s7 | s33)) begin
		s30		<= s31;
	end
end

assign wdt_rst = s9 & s4;
assign wdt_int = s8 & s5;

assign prdata =
	({32{s21}} & `ATCWDT200_PRODUCT_ID) |
	({32{s22}} & {21'h0, s2, s11, s4, s5, s6, s7}) |
	({32{s25}} & {31'h0, s8});

assign s1 = psel & penable & pwrite;

assign s12	= pwdata[10:8];
assign s13	= pwdata[INT_TIME_WIDTH+3:4];
assign s14		= pwdata[3];
assign s15		= pwdata[2];
assign s16		= pwdata[1];
assign s17		= ~s38 & pwdata[0];
assign s18	= s39 | (s8 & ~pwdata[0]);
assign s19	= 1'h1;
assign s20		= ~s10 & s24 & (pwdata[15:0] == `ATCWDT200_WP_NUM);

assign s21	= ({s0, 2'h0} == 5'h0);
assign s22	= ({s0, 2'h0} == 5'h10);
assign s23	= ({s0, 2'h0} == 5'h14);
assign s24	= ({s0, 2'h0} == 5'h18);
assign s25	= ({s0, 2'h0} == 5'h1c);

assign s28 = (s33 | s36)? {COUNTER_WIDTH{1'b0}} : (s26 + {{COUNTER_WIDTH-1{1'b0}},1'b1});

always @(*) begin
	if (s30 == ST_INTTIME) begin
		case (s11)
			4'h0:	s29 = s27[6];
			4'h1:	s29 = s27[8];
			4'h2:	s29 = s27[10];
			4'h3:	s29 = s27[11];
			4'h4:	s29 = s27[12];
			4'h5:	s29 = s27[13];
			4'h6:	s29 = s27[14];
			4'h7:	s29 = s27[15];
			4'h8:	s29 = s27[17];
			4'h9:	s29 = s27[19];
			4'ha:	s29 = s27[21];
			4'hb:	s29 = s27[23];
			4'hc:	s29 = s27[25];
			4'hd:	s29 = s27[27];
			4'he:	s29 = s27[29];
			4'hf:	s29 = s27[31];
		endcase
	end
	else begin
		case (s2)
			3'h0:	s29 = s27[7];
			3'h1:	s29 = s27[8];
			3'h2:	s29 = s27[9];
			3'h3:	s29 = s27[10];
			3'h4:	s29 = s27[11];
			3'h5:	s29 = s27[12];
			3'h6:	s29 = s27[13];
			3'h7:	s29 = s27[14];
		endcase
	end
end
always @(*) begin
	if (s30 == ST_INTTIME) begin
		if (s36 & ~s33) begin
			s31 = ST_RSTTIME;
		end
		else begin
			s31 = ST_INTTIME;
		end
	end
	else begin
		if (s33) begin
			s31 = ST_INTTIME;
		end
		else begin
			s31 = ST_RSTTIME;
		end
	end
end
assign s33 = s10 & s1 & s23 & (pwdata[15:0] == `ATCWDT200_RESTART_NUM);
assign s35 = (s30 == ST_INTTIME) ? 1'b1 : s4;
assign s34 = ~s41 & ((s7 & s35 & (s32 | s6)) | s33 | s36);
assign s36 = s7 & (s30 == ST_INTTIME) & s29;
assign s37 = s7 & (s30 == ST_RSTTIME) & s29;
assign s38 = s37;
assign s39 = s36 & ~s41;
assign s40 = s37 & ~s41;

nds_sync_l2l u_sync_l2l_extclk (
	.b_reset_n			(presetn),
	.b_clk				(pclk),
	.a_signal			(extclk),
	.b_signal			(),
	.b_signal_rising_edge_pulse	(s32),
	.b_signal_falling_edge_pulse	(),
	.b_signal_edge_pulse		()
);

nds_sync_l2l u_sync_wdt_pause (
	.b_reset_n			(presetn),
	.b_clk				(pclk),
	.a_signal			(wdt_pause),
	.b_signal			(s41),
	.b_signal_rising_edge_pulse	(),
	.b_signal_falling_edge_pulse	(),
	.b_signal_edge_pulse		()
);

endmodule
