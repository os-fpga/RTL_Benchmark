module irda_fir_flag_gen (clk, wb_rst_i, fir_tx4_enable, fir_tx8_enable, fir_gen_start, fir_flag, flag_gen_o, eof);
// generates PA/STA/STO flags
// fir_flag == 00 => 0 constant
// fir_flag == 01 => PA
// fir_flag == 10 => STA
// fir_flag == 11 => STO

input			clk;
input			wb_rst_i;
input			fir_tx8_enable;
input			fir_tx4_enable;
input			fir_gen_start;
input [1:0]	fir_flag;

output		flag_gen_o;
output		eof;  // end of flag signal

// mux outputs (not from flip flop)
reg			flag_gen_o;
reg			eof;

// internal registers
wire	[1:0]	fir_flag;
reg	[1:0]	flag;  // current flag
reg			start; // start flag

// internal signals logic
always @(posedge clk or posedge wb_rst_i)
begin
	if (wb_rst_i) begin
		flag <= #1 2'b00;
		start <= #1 0;
	end else if (fir_tx4_enable && fir_gen_start) begin
		flag <= #1 fir_flag;
		start <= #1 1;
	end
	else
		start <= #1 0;
end

// PA flag logic
reg	pa;
reg	[3:0] pa_count16;
reg	[3:0] pa_symbol_count;
reg	pa_end;

always @(posedge clk or posedge wb_rst_i)
begin
	if (wb_rst_i) begin
		pa <= #1 0;
		pa_count16 <= #1 0;
		pa_symbol_count <= #1 0;
		pa_end <= #1 0;
	end else begin
		if (fir_tx8_enable && ( flag == 2'b01) )
			if (start) begin
				pa <= #1 0;
				pa_count16 <= #1 0;
				pa_symbol_count <= #1 0;				
				pa_end <= #1 0;
			end else begin
				case (pa_symbol_count)
					0,8,10,12 : pa <= #1 1;
					default : pa <= #1 0;
				endcase
				if (pa_symbol_count == 15)
					pa_end <= #1 1;
				else
					pa_end <= #1 0;
				pa_symbol_count <= pa_symbol_count + 1;
			end
	end
end

// STx flags logic
reg	st;
reg	[4:0] st_symbol_count;
reg	st_end;

always @(posedge clk or posedge wb_rst_i)
begin
	if (wb_rst_i) begin
		st <= #1 0;
		st_symbol_count <= #1 0;
		st_end <= #1 0;
	end else begin
		if (fir_tx8_enable && ( flag[1] == 1'b1) ) // STA or STO
			if (start) begin
				st <= #1 0;
				st_symbol_count <= #1 0;				
				st_end <= #1 0;
			end else begin
				if (flag[0] == 1'b0)  // STA
					case (st_symbol_count)
						4,5,12,13,17,18,25,26 : st <= #1 1;
						default : st <= #1 0;
					endcase
				else // STO
					case (st_symbol_count)
						4,5,12,13,21,22,29,30 : st <= #1 1;
						default : st <= #1 0;
					endcase
				if (st_symbol_count == 31)
					st_end <= #1 1;
				else
					st_end <= #1 0;
				st_symbol_count <= st_symbol_count + 1;
			end
	end
end

// flag generator stream output
always @(flag or st or pa)
	case (flag)
		2'b00 : flag_gen_o = 0;
		2'b01 : flag_gen_o = pa;
		2'b10,
		2'b11 : flag_gen_o = st;
	endcase

// flag generator end of flag output
always @(flag or st_end or pa_end)
	case (flag)
		2'b00 : eof = 0;
		2'b01 : eof = pa_end;
		2'b10,
		2'b11 : eof = st_end;
	endcase

endmodule
