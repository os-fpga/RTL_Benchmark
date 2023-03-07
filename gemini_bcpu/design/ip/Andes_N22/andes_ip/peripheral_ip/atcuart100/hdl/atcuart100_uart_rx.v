// Copyright (C) 2021, Andes Technology Corp. Confidential Proprietary

`include "atcuart100_config.vh"
`include "atcuart100_const.vh"

module atcuart100_uart_rx (
	  uclk,
	  urstn,
	  baud_mx,
	  uart_sin,
	  unloop_sout,
	  rxfifo_datain,
	  rxfifo_write,
	  uart_rx_busy,
	  parity_err,
	  framing_err,
	  rx_break,
	  uart_timeout_wen,
	  uart_loop_mode,
	  uart_fifo_enable,
	  rxfifo_empty_uclk,
	  rxfifo_read_uclk,
	  oversample,
	  lcr_parity_stick,
	  lcr_parity_even,
	  lcr_parity_enable,
	  lcr_stopbit,
	  lcr_wordlength
);

input				uclk;
input				urstn;
input				baud_mx;

input				uart_sin;
input				unloop_sout;
output	[7:0]			rxfifo_datain;
output				rxfifo_write;
output				uart_rx_busy;
output				parity_err;
output				framing_err;
output				rx_break;
output				uart_timeout_wen;

input				uart_loop_mode;
input				uart_fifo_enable;
input				rxfifo_empty_uclk;
input				rxfifo_read_uclk;
input	[4:1]			oversample;
input				lcr_parity_stick;
input				lcr_parity_even;
input				lcr_parity_enable;
input				lcr_stopbit;
input	[1:0]			lcr_wordlength;

parameter  RX_TO_START	= 5'b00101,
           RX_TO_DATA0	= 5'b01000,
           RX_TO_DATA1	= 5'b01001,
           RX_TO_DATA2	= 5'b01010,
           RX_TO_DATA3	= 5'b01011,
           RX_TO_DATA4	= 5'b01100,
           RX_TO_DATA5	= 5'b01101,
           RX_TO_DATA6	= 5'b01110,
           RX_TO_DATA7	= 5'b01111,
           RX_TO_PARITY	= 5'b00111,
           RX_TO_STOP1	= 5'b00011,
           RX_TO_STOP15	= 5'b00010,
           RX_TO_STOP2	= 5'b00001,

           RX_START_1H	= 5'b10100,
           RX_START_2H	= 5'b10101,

           RX_DATA0	= 5'b11000,
           RX_DATA1	= 5'b11001,
           RX_DATA2	= 5'b11010,
           RX_DATA3	= 5'b11011,
           RX_DATA4	= 5'b11100,
           RX_DATA5	= 5'b11101,
           RX_DATA6	= 5'b11110,
           RX_DATA7	= 5'b11111,

           RX_PARITY	= 5'b10111,
           RX_STOP1	= 5'b10011,
           RX_STOP15	= 5'b10010,
           RX_STOP2	= 5'b10001;

parameter  BIT_PERIOD_INITIAL	= 4'h1;

wire				s0;
reg	[4:0]			s1, s2;
wire				s3;
reg	[4:0]			s4, s5;
wire				s6;
wire				s7;
wire				s8;
wire				s9;
wire				s10;
wire				s11;
wire				s12;
reg				s13, s14;
reg	[7:0]			s15, s16;
wire				s17;
wire				s18;
wire				s19;
wire				s20;
reg				s21, s22;
wire				s23;
reg				s24, s25;
wire				s26;
wire				s27;
reg				s28, s29;
wire				rx_break;
reg	[1:0]			s30, s31;
wire				s32;
wire				s33;
wire				s34;
wire				s35;
wire				s36;
reg				s37;
wire				s38;
wire				s39;
wire 				s40;
wire 				s41;
wire 				s42;
wire				s43;


always @( * )
begin
	case(s1)
		RX_START_1H: begin
			if (!s11)
				s2 = RX_TO_START;
			else if (s7)
				s2 = RX_START_2H;
			else
				s2 = RX_START_1H;
		end
		RX_START_2H: begin
			if (s6)
				s2 = RX_DATA0;
			else
				s2 = RX_START_2H;
		end
		RX_DATA0: begin
			if (s6)
				s2 = RX_DATA1;
			else
				s2 = RX_DATA0;
		end
		RX_DATA1: begin
			if (s6)
				s2 = RX_DATA2;
			else
				s2 = RX_DATA1;
		end
		RX_DATA2: begin
			if (s6)
				s2 = RX_DATA3;
			else
				s2 = RX_DATA2;
		end
		RX_DATA3: begin
			if (s6)
				s2 = RX_DATA4;
			else
				s2 = RX_DATA3;
		end
		RX_DATA4: begin
			if (s6)
				if (lcr_wordlength != 2'h0)
					s2 = RX_DATA5;
				else if (lcr_parity_enable)
					s2 = RX_PARITY;
				else
					s2 = RX_STOP1;
			else
				s2 = RX_DATA4;
		end
		RX_DATA5: begin
			if (s6)
				if (lcr_wordlength != 2'h1)
					s2 = RX_DATA6;
				else if (lcr_parity_enable)
					s2 = RX_PARITY;
				else
					s2 = RX_STOP1;
			else
				s2 = RX_DATA5;
		end
		RX_DATA6: begin
			if (s6)
				if (lcr_wordlength != 2'h2)
					s2 = RX_DATA7;
				else if (lcr_parity_enable)
					s2 = RX_PARITY;
				else
					s2 = RX_STOP1;
			else
				s2 = RX_DATA6;
		end
		RX_DATA7: begin
			if (s6)
				if (lcr_parity_enable)
					s2 = RX_PARITY;
				else
					s2 = RX_STOP1;
			else
				s2 = RX_DATA7;
		end
		RX_PARITY: begin
			if (s6)
				s2 = RX_STOP1;
			else
				s2 = RX_PARITY;
		end
		RX_STOP1: begin
			if (lcr_stopbit)
				if (s6)
					if (lcr_wordlength == 2'h0)
						s2 = RX_STOP15;
					else
						s2 = RX_STOP2;
				else
					s2 = RX_STOP1;
			else
				if (s12 && (!rx_break) && s9)
					s2 = RX_START_1H;
				else if (s6)
					s2 = RX_TO_START;
				else
					s2 = RX_STOP1;
		end
		RX_STOP15: begin
			if (s12 && (!rx_break))
				s2 = RX_START_1H;
			else if (s7)
				s2 = RX_TO_START;
			else
				s2 = RX_STOP15;
		end
		RX_STOP2: begin
			if (s12 && (!rx_break))
				s2 = RX_START_1H;
			else if (s6)
				s2 = RX_TO_START;
			else
				s2 = RX_STOP2;
		end
		RX_TO_DATA0: begin
			if (s12)
				s2 = RX_START_1H;
			else if (s38)
				s2 = RX_TO_START;
			else if (s6)
				s2 = RX_TO_DATA1;
			else
				s2 = RX_TO_DATA0;
		end
		RX_TO_DATA1: begin
			if (s12)
				s2 = RX_START_1H;
			else if (s38)
				s2 = RX_TO_START;
			else if (s6)
				s2 = RX_TO_DATA2;
			else
				s2 = RX_TO_DATA1;
		end
		RX_TO_DATA2: begin
			if (s12)
				s2 = RX_START_1H;
			else if (s38)
				s2 = RX_TO_START;
			else if (s6)
				s2 = RX_TO_DATA3;
			else
				s2 = RX_TO_DATA2;
		end
		RX_TO_DATA3: begin
			if (s12)
				s2 = RX_START_1H;
			else if (s38)
				s2 = RX_TO_START;
			else if (s6)
				s2 = RX_TO_DATA4;
			else
				s2 = RX_TO_DATA3;
		end
		RX_TO_DATA4: begin
			if (s12)
				s2 = RX_START_1H;
			else if (s38)
				s2 = RX_TO_START;
			else if (s6)
				if (lcr_wordlength != 2'h0)
					s2 = RX_TO_DATA5;
				else if (lcr_parity_enable)
					s2 = RX_TO_PARITY;
				else
					s2 = RX_TO_STOP1;
			else
				s2 = RX_TO_DATA4;
		end
		RX_TO_DATA5: begin
			if (s12)
				s2 = RX_START_1H;
			else if (s38)
				s2 = RX_TO_START;
			else if (s6)
				if (lcr_wordlength != 2'h1)
					s2 = RX_TO_DATA6;
				else if (lcr_parity_enable)
					s2 = RX_TO_PARITY;
				else
					s2 = RX_TO_STOP1;
			else
				s2 = RX_TO_DATA5;
		end
		RX_TO_DATA6: begin
			if (s12)
				s2 = RX_START_1H;
			else if (s38)
				s2 = RX_TO_START;
			else if (s6)
				if (lcr_wordlength != 2'h2)
					s2 = RX_TO_DATA7;
				else if (lcr_parity_enable)
					s2 = RX_TO_PARITY;
				else
					s2 = RX_TO_STOP1;
			else
				s2 = RX_TO_DATA6;
		end
		RX_TO_DATA7: begin
			if (s12)
				s2 = RX_START_1H;
			else if (s38)
				s2 = RX_TO_START;
			else if (s6)
				if (lcr_parity_enable)
					s2 = RX_TO_PARITY;
				else
					s2 = RX_TO_STOP1;
			else
				s2 = RX_TO_DATA7;
		end
		RX_TO_PARITY: begin
			if (s12)
				s2 = RX_START_1H;
			else if (s38)
				s2 = RX_TO_START;
			else if (s6)
				s2 = RX_TO_STOP1;
			else
				s2 = RX_TO_PARITY;
		end
		RX_TO_STOP1: begin
			if (s12)
				s2 = RX_START_1H;
			else if (s38)
				s2 = RX_TO_START;
			else if (lcr_stopbit)
				if (s6)
					if (lcr_wordlength == 2'h0)
						s2 = RX_TO_STOP15;
					else
						s2 = RX_TO_STOP2;
				else
					s2 = RX_TO_STOP1;
			else
				if (s6)
					s2 = RX_TO_START;
				else
					s2 = RX_TO_STOP1;
		end
		RX_TO_STOP15: begin
			if (s12)
				s2 = RX_START_1H;
			else if (s38)
				s2 = RX_TO_START;
			else if (s7)
				s2 = RX_TO_START;
			else
				s2 = RX_TO_STOP15;
		end
		RX_TO_STOP2: begin
			if (s12)
				s2 = RX_START_1H;
			else if (s38)
				s2 = RX_TO_START;
			else if (s6)
				s2 = RX_TO_START;
			else
				s2 = RX_TO_STOP2;
		end
		default: begin
			if (s12)
				s2 = RX_START_1H;
			else if (s38)
				s2 = RX_TO_START;
			else if (s6 && uart_fifo_enable)
				s2 = RX_TO_DATA0;
			else
				s2 = RX_TO_START;
		end
	endcase
end

wire [3:0]	s44 = s4[3:0] + 4'h1;

assign s3 = (s6 | ((s1 != RX_START_1H) & (s2 == RX_START_1H)));
always @( * )
begin
	if (s3)
		s5 = {1'b0, BIT_PERIOD_INITIAL};
	else if (s7)
		s5 = {1'b1, BIT_PERIOD_INITIAL};
	else
		s5 = {s4[4], s44};
end

assign s6       =   s4[4]  && ((oversample == 4'h0) ? (s4[3:0] == 4'h0) : (s4[3:0] >= oversample));
assign s7  = (!s4[4]) && ((oversample == 4'h0) ? (s4[3:0] == 4'h0) : (s4[3:0] >= oversample));
assign s8  = (!s4[4]) && ((oversample == 4'h0) ? (s4[3:0] == 4'h8) : (s4[3:0] == {1'b0, oversample[4:2]}));
assign s9 = s4[4];

nds_sync_l2l #(.RESET_VALUE (1'b1)) uart_sin_syn (
	.b_reset_n(urstn),
	.b_clk(uclk),
	.a_signal(uart_sin),
	.b_signal(s10),
	.b_signal_rising_edge_pulse(),
	.b_signal_falling_edge_pulse(),
	.b_signal_edge_pulse()
);

assign s0 = (uart_loop_mode ? unloop_sout : s10);
assign s11 = (s0 == 1'b0);

always @( * )
begin
	if (s26 | s27)
		s14 = s0;
	else if (s36 && (!s33) && (!s35))
		s14 = s0;
	else
		s14 = s13;
end

assign s12 = s11 & s13;

assign s18 = ((s2 == RX_START_1H) & (s1 != RX_START_1H));
assign s17 = ((s1 == RX_DATA0) | (s1 == RX_DATA1) | (s1 == RX_DATA2) | (s1 == RX_DATA3) |
			  (s1 == RX_DATA4) | (s1 == RX_DATA5) | (s1 == RX_DATA6) | (s1 == RX_DATA7)) & s7;

always @( * )
begin
	if (s18)
		s16 = {3'h0, s15[4:0]};
	else if (s17)
		s16 = ((s1 == RX_DATA0) ? {s15[7:1], s0} :
			       ((s1 == RX_DATA1) ? {s15[7:2], s0, s15[0]} :
			       ((s1 == RX_DATA2) ? {s15[7:3], s0, s15[1:0]} :
			       ((s1 == RX_DATA3) ? {s15[7:4], s0, s15[2:0]} :
			       ((s1 == RX_DATA4) ? {s15[7:5], s0, s15[3:0]} :
			       ((s1 == RX_DATA5) ? {s15[7:6], s0, s15[4:0]} :
			       ((s1 == RX_DATA6) ? {s15[7],   s0, s15[5:0]} : {s0, s15[6:0]})))))));
	else
		s16 = s15;
end

assign rxfifo_datain = s15;

assign rxfifo_write = baud_mx &&
		(lcr_stopbit ? (((s1 == RX_STOP15) & s8) | (s1 == RX_STOP2) & s7) :
       			       ( (s1 == RX_STOP1)  & s7 ));

assign s19 = (^rxfifo_datain);

assign s20 = (lcr_parity_stick ? (~lcr_parity_even) : (~(s19 ^ lcr_parity_even)));

always @( * )
begin
	if (s18 | (!lcr_parity_enable))
		s22 = 1'b0;
	else if ((s1 == RX_PARITY) && s7)
		s22 = (s0 != s20);
	else
		s22 = s21;
end

assign parity_err = s21;


assign s23 = ( (((s1 == RX_STOP1)|(s1 == RX_STOP2)) & s7) | ((s1 == RX_STOP15) & s8) );

always @( * )
begin
	if (s18)
		s25 = 1'b0;
	else if (s23)
		s25 = (~s0) | s24;
	else
		s25 = s24;
end

assign framing_err = (~s0) | s24;

assign s26 = s33 & ((s1 == RX_STOP15) ? s8 : s7);
assign s27 = (s35 & (~s33));

always @( * )
begin
	if (s18)
		s29 = 1'b1;
	else if (s26)
		s29 = (~s0) & s28;
	else if (s27)
		s29 = (~s0);
	else
		s29 = s28;
end

assign rx_break = (~s0) & s28;

assign s32 = (lcr_stopbit ? (((s1 == RX_TO_STOP15) & s7) | (s1 == RX_TO_STOP2) & s6) :
					 ((s1 == RX_TO_STOP1)  & s6));

assign s38 = (~uart_fifo_enable) | rxfifo_empty_uclk | rxfifo_write | rxfifo_read_uclk | s37;

always @*
begin
	if (s38)
		s31 = 2'h0;
	else if (s32)
		s31 = s30 + 2'h1;
	else
		s31 = s30;
end

assign s43 = baud_mx & uart_rx_busy;
assign uart_timeout_wen = ((s30 == 2'b11) & s32 & baud_mx);
assign s40 = s34 & s38 & s39;
assign s41 = s40 | s43;

always @(negedge urstn or posedge uclk)
begin
	if (!urstn) begin
		s1      <= RX_TO_START;
	end else if (s41) begin
		s1      <= s2;
	end
end

assign s42 = s38 | s43;

always @( negedge urstn or posedge uclk )
begin
	if (!urstn)
		s30     <= 2'h0;
	else if (s42)
		s30     <= s31;
end

always @(negedge urstn or posedge uclk)
begin
	if (!urstn) begin
		s4  <= {1'b0, BIT_PERIOD_INITIAL};
		s13 <= 1'b1;
		s15       <= 8'h0;
		s21      <= 1'b0;
		s24     <= 1'b0;
		s28        <= 1'b0;
	end else if (s43) begin
		s4  <= s5;
		s13 <= s14;
		s15       <= s16;
		s21      <= s22;
		s24     <= s25;
		s28        <= s29;
	end
end

always @( negedge urstn or posedge uclk )
begin
	if (!urstn)
		s37 <= 1'b0;
	else if (rxfifo_read_uclk)
		s37 <= 1'b0;
	else if (uart_timeout_wen)
		s37 <= 1'b1;
end

assign s33 = s12 | (s1 == RX_START_1H) | (s1 == RX_START_2H) |
	                        	 (s1 == RX_DATA0)    | (s1 == RX_DATA1)    |
					 (s1 == RX_DATA2)    | (s1 == RX_DATA3)    |
					 (s1 == RX_DATA4)    | (s1 == RX_DATA5)    |
					 (s1 == RX_DATA6)    | (s1 == RX_DATA7)    |
					 (s1 == RX_PARITY)   | (s1 == RX_STOP1)    |
					 (s1 == RX_STOP15)   | (s1 == RX_STOP2);

assign s34 = (uart_fifo_enable & (~rxfifo_empty_uclk) &
			((s1 != RX_START_1H) & (s1 != RX_START_2H) &
			 (s1 != RX_DATA0)    & (s1 != RX_DATA1)    &
			 (s1 != RX_DATA2)    & (s1 != RX_DATA3)    &
			 (s1 != RX_DATA4)    & (s1 != RX_DATA5)    &
			 (s1 != RX_DATA6)    & (s1 != RX_DATA7)    &
			 (s1 != RX_PARITY)   & (s1 != RX_STOP1)    &
			 (s1 != RX_STOP15)   & (s1 != RX_STOP2)));

assign s39 = ((s2 != RX_START_1H) & (s2 != RX_START_2H) &
			   (s2 != RX_DATA0)    & (s2 != RX_DATA1)    &
			   (s2 != RX_DATA2)    & (s2 != RX_DATA3)    &
			   (s2 != RX_DATA4)    & (s2 != RX_DATA5)    &
			   (s2 != RX_DATA6)    & (s2 != RX_DATA7)    &
			   (s2 != RX_PARITY)   & (s2 != RX_STOP1)    &
			   (s2 != RX_STOP15)   & (s2 != RX_STOP2));
assign s35   = s28;
assign s36 = (~s13);

assign uart_rx_busy = s33 | s34 | s35 | s36;

endmodule

