module accum_output_shifted_rounded (clk, reset, subtract_i, load_acc_i, shift_right_i, round_i, A, B, P);

//localparam MIN_SIGNED_VALUE   = 2 ** 37;
	input clk, reset, subtract_i, load_acc_i;
	input [5:0] shift_right_i;
	input round_i;//, saturate_i;
	input signed [19:0] A;
	input signed [17:0] B;
	output reg signed [63:0] P;
	reg signed [63:0] out, out_shift;
	reg signed [19:0] i1;
	reg signed [17:0] i2;
	reg subtract_i_reg;
	reg [5:0] shift_right_i_reg;
	reg round_i_reg;
	reg signed [63:0] mul, add_or_sub;
	always @(posedge clk) begin
		if(reset == 1) begin
			i1 <= 0;
			i2 <= 0;
			subtract_i_reg <= 0;
			shift_right_i_reg <= 0;
			round_i_reg <= 0;
			//saturate_i_reg <= 0;
		end
		else begin
			i1 <= A;
			i2 <= B;
			subtract_i_reg <= subtract_i;
			shift_right_i_reg <= shift_right_i;
			round_i_reg <= round_i;
			//saturate_i_reg <= saturate_i;
		end
	end
	always @(posedge clk) begin
		if (reset ==1 )
			P <= 0;
		else if (load_acc_i)
			P <= out;
		else
			P <= P;
	end

	always @ (*)  begin
		mul  = i1 * i2;
	end

	always @ (posedge clk)  begin
		if (reset)
			add_or_sub <= 0;
		else if (load_acc_i) begin
			if (subtract_i_reg)
				add_or_sub <= P - mul;
			else
				add_or_sub <= P + mul;
		end
		else
			add_or_sub <= add_or_sub;
	end

	always @ (*)  begin
		out_shift = add_or_sub >>shift_right_i_reg;
		if (shift_right_i_reg != 0) begin
			if (round_i_reg == 1 && add_or_sub[shift_right_i_reg -1]==1) begin
				out = out_shift + 1'b1;
			end
			else
				out = out_shift;
		end
		/*else if (saturate_i_reg == 1 ) begin
			if (out_shift < $signed(- 137438953472 ))		//underflow
				out =  64'h8000000000000000;
			else if (out_shift > $signed(137438953471))	//overflow
				out = 64'h01fffffffff;
			else
				out = out_shift;
		end*/
		else
			out = out_shift;

	end

endmodule