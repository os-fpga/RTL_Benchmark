module irda_fir_bit_sync (clk, wb_rst_i, bs_restart, rx_i, fast_enable, bs_o);
// synchronizes to bit level. the 40Mhz clock is used to sample on the third clock of each bit
// syncronyzation starts on bs_restart

input		clk;
input		wb_rst_i;
input		bs_restart;
input		rx_i;		// input from the led
input		fast_enable; // 40Mhz clock

output	bs_o;	// bit output

reg		bs_o;

// Bit synchronizer FSM

parameter st0=0, st1=1, st2=2, st3=3, st4=4, st5=5, st6=6, st7=7, st8=8, st9=9;

reg	[3:0]	state;

always @(posedge clk or posedge wb_rst_i)
begin
	if (wb_rst_i) begin
		state <= #1 st0;
		bs_o <= #1 0;
	end else if (bs_restart) begin
		state <= #1 st0;
		bs_o <= #1 0;
	end else if (fast_enable) begin
	case (state)
		st0 : if (rx_i==0) state <= #1 st1;
		st1 : if (rx_i==1) state <= #1 st2;
		st2 : if (rx_i==1) state <= #1 st3; else state <= #1 st0;
		st3 : if (rx_i==1) begin
					state <= #1 st4;
					bs_o <= #1 1;
				end else
					state <= #1 st0;
		st4 : state <= #1 st5;
		st5 : state <= #1 st6;
		st6 : state <= #1 st7;
		st7 : state <= #1 st8;
		st8 : begin
					state <= #1 st9;
					bs_o <= #1 rx_i;
				end
		st9 : state <= #1 st5;
		default :
			state <= #1 st0;
	endcase
	end
end

endmodule
