// Copyright (C) 2022, Andes Technology Corp. Confidential Proprietary

`include "atcuart100_config.vh"
`include "atcuart100_const.vh"

module atcuart100_uart_tx (
	  uclk,
	  urstn,
	  baud_mx,
	  uart_sout,
	  unloop_sout,
	  txfifo_dataout,
	  tx_data_ready,
	  txfifo_read,
	  uart_tx_busy,
	  uart_loop_mode,
	  oversample,
	  lcr_break,
	  lcr_parity_stick,
	  lcr_parity_even,
	  lcr_parity_enable,
	  lcr_stopbit,
	  lcr_wordlength
);

input				uclk;
input				urstn;
input				baud_mx;

output				uart_sout;
output				unloop_sout;
input	[7:0]			txfifo_dataout;
input				tx_data_ready;
output				txfifo_read;
output				uart_tx_busy;

input				uart_loop_mode;
input	[4:1]			oversample;
input				lcr_break;
input				lcr_parity_stick;
input				lcr_parity_even;
input				lcr_parity_enable;
input				lcr_stopbit;
input	[1:0]			lcr_wordlength;

parameter  TX_IDLE	= 4'b0000,
           TX_START	= 4'b0100,

           TX_DATA0	= 4'b1000,
           TX_DATA1	= 4'b1001,
           TX_DATA2	= 4'b1010,
           TX_DATA3	= 4'b1011,
           TX_DATA4	= 4'b1100,
           TX_DATA5	= 4'b1101,
           TX_DATA6	= 4'b1110,
           TX_DATA7	= 4'b1111,

           TX_PARITY	= 4'b0111,
           TX_STOP1	= 4'b0011,
           TX_STOP15	= 4'b0010,
           TX_STOP2	= 4'b0001;

parameter  BIT_PERIOD_INITIAL	= 4'h1;

reg	[3:0]			s0, s1;
reg	[4:0]			s2, s3;
wire				s4;
wire				s5;
wire				s6;
wire				s7;
wire				s8;
wire				s9;
`ifdef ATCUART100_UCLK_PCLK_SAME
reg	[7:0]			s10, s11;
`else
reg				s12, s13;
`endif
reg				s14, s15;
wire				s16;
reg				s17;


always @( * )
begin
	case(s0)
		TX_START: begin
			if (s4)
				s1 = TX_DATA0;
			else
				s1 = TX_START;
		end
		TX_DATA0: begin
			if (s4)
				s1 = TX_DATA1;
			else
				s1 = TX_DATA0;
		end
		TX_DATA1: begin
			if (s4)
				s1 = TX_DATA2;
			else
				s1 = TX_DATA1;
		end
		TX_DATA2: begin
			if (s4)
				s1 = TX_DATA3;
			else
				s1 = TX_DATA2;
		end
		TX_DATA3: begin
			if (s4)
				s1 = TX_DATA4;
			else
				s1 = TX_DATA3;
		end
		TX_DATA4: begin
			if (s4)
				if (lcr_wordlength != 2'h0)
					s1 = TX_DATA5;
				else if (lcr_parity_enable)
					s1 = TX_PARITY;
				else
					s1 = TX_STOP1;
			else
				s1 = TX_DATA4;
		end
		TX_DATA5: begin
			if (s4)
				if (lcr_wordlength != 2'h1)
					s1 = TX_DATA6;
				else if (lcr_parity_enable)
					s1 = TX_PARITY;
				else
					s1 = TX_STOP1;
			else
				s1 = TX_DATA5;
		end
		TX_DATA6: begin
			if (s4)
				if (lcr_wordlength != 2'h2)
					s1 = TX_DATA7;
				else if (lcr_parity_enable)
					s1 = TX_PARITY;
				else
					s1 = TX_STOP1;
			else
				s1 = TX_DATA6;
		end
		TX_DATA7: begin
			if (s4)
				if (lcr_parity_enable)
					s1 = TX_PARITY;
				else
					s1 = TX_STOP1;
			else
				s1 = TX_DATA7;
		end
		TX_PARITY: begin
			if (s4)
				s1 = TX_STOP1;
			else
				s1 = TX_PARITY;
		end
		TX_STOP1: begin
			if (s4)
				if (lcr_stopbit)
					if (lcr_wordlength == 2'h0)
						s1 = TX_STOP15;
					else
						s1 = TX_STOP2;
				else
					if (tx_data_ready)
						s1 = TX_START;
					else
						s1 = TX_IDLE;
			else
				s1 = TX_STOP1;
		end
		TX_STOP15: begin
			if (s5)
				if (tx_data_ready)
					s1 = TX_START;
				else
					s1 = TX_IDLE;
			else
				s1 = TX_STOP15;
		end
		TX_STOP2: begin
			if (s4)
				if (tx_data_ready)
					s1 = TX_START;
				else
					s1 = TX_IDLE;
			else
				s1 = TX_STOP2;
		end
		default: begin
			if (tx_data_ready)
				s1 = TX_START;
			else
				s1 = TX_IDLE;
		end
	endcase
end


wire [3:0]	s18 = s2[3:0] + 4'h1;

always @( * )
begin
	if (s4 | ((s0 != TX_START) & (s1 == TX_START)))
		s3 = {1'b0, BIT_PERIOD_INITIAL};
	else if (s5)
		s3 = {1'b1, BIT_PERIOD_INITIAL};
	else
		s3 = {s2[4], s18};
end

assign s4      =   s2[4]  & ((oversample == 4'h0) ? (s2[3:0] == 4'h0) : (s2[3:0] >= oversample));
assign s5 = (~s2[4]) & ((oversample == 4'h0) ? (s2[3:0] == 4'h0) : (s2[3:0] >= oversample));
assign s6 = (~s2[4]) & ((oversample == 4'h0) ? (s2[3:0] == 4'h8) : (s2[3:0] == {1'b0, oversample[4:2]}));

assign s8 = ((s0 == TX_DATA0) | (s0 == TX_DATA1) | (s0 == TX_DATA2) | (s0 == TX_DATA3) |
			  (s0 == TX_DATA4) | (s0 == TX_DATA5) | (s0 == TX_DATA6) | (s0 == TX_DATA7)) & s4;
`ifdef ATCUART100_UCLK_PCLK_SAME
assign s7 = ((s1 == TX_START) & (s0 != TX_START));

always @( * )
begin
	if (s7)
		s11 = txfifo_dataout;
	else if (s8)
		s11 = {s10[7], s10[7:1]};
	else
		s11 = s10;
end

assign s9   = s10[0];

`else
assign s7 = (lcr_stopbit ? (((s0 == TX_STOP15) & s6) | ((s0 == TX_STOP2) & s5)) : ((s0 == TX_STOP1) & s5));
always @( * )
begin
	if (s1 == TX_DATA0)
		s13 = txfifo_dataout[0];
	else if (s1 == TX_DATA1)
		s13 = txfifo_dataout[1];
	else if (s1 == TX_DATA2)
		s13 = txfifo_dataout[2];
	else if (s1 == TX_DATA3)
		s13 = txfifo_dataout[3];
	else if (s1 == TX_DATA4)
		s13 = txfifo_dataout[4];
	else if (s1 == TX_DATA5)
		s13 = txfifo_dataout[5];
	else if (s1 == TX_DATA6)
		s13 = txfifo_dataout[6];
	else
		s13 = txfifo_dataout[7];
end

assign s9 = s12;

`endif
assign txfifo_read    = s7 & baud_mx;

always @( * )
begin
	if ((s1 == TX_START) & (s0 != TX_START))
		s15 = 1'b0;
	else if (s8)
		s15 = (s14 ^ s9);
	else
		s15 = s14;
end

assign s16 = (lcr_parity_stick ? (~lcr_parity_even) : (~(s14 ^ lcr_parity_even)));

always @( * )
begin
	if (lcr_break)
		s17 = 1'b0;
	else if ((s0 == TX_DATA0) | (s0 == TX_DATA1) | (s0 == TX_DATA2) | (s0 == TX_DATA3) |
		 (s0 == TX_DATA4) | (s0 == TX_DATA5) | (s0 == TX_DATA6) | (s0 == TX_DATA7))
		s17 = s9;
	else if ((s0 == TX_IDLE) | (s0 == TX_STOP1) | (s0 == TX_STOP15) | (s0 == TX_STOP2))
		s17 = 1'b1;
	else if ((s0 == TX_PARITY))
		s17 = s16;
	else
		s17 = 1'b0;
end

assign uart_sout = (uart_loop_mode ? 1'b1 : s17);
assign unloop_sout = s17;

always @(negedge urstn or posedge uclk)
begin
	if (~urstn) begin
		s0     <= TX_IDLE;
	end else if ((baud_mx & (tx_data_ready | uart_tx_busy))) begin
		s0     <= s1;
	end
end
always @(negedge urstn or posedge uclk)
begin
	if (~urstn) begin
		s2 <= {1'b0, BIT_PERIOD_INITIAL};
`ifdef ATCUART100_UCLK_PCLK_SAME
		s10      <= 8'h0;
`else
		s12  <= 1'b0;
`endif
		s14    <= 1'b0;
	end else if ((baud_mx & (tx_data_ready | uart_tx_busy))) begin
		s2 <= s3;
`ifdef ATCUART100_UCLK_PCLK_SAME
		s10      <= s11;
`else
		s12  <= s13;
`endif
		s14    <= s15;
	end
end

assign uart_tx_busy = (s0 != TX_IDLE);

endmodule

