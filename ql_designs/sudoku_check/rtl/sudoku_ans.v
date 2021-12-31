// $Header:   /pvcs/designs/power_sanity_designs/source/sudoku_check_wrapper/sudoku_ans.v__   1.0   30 Mar 2006 08:52:56   rtai  $

module sudoku_ans (
	puzzle_mask_bin,
	puzzle_ans_bin);

input [9*9*9-1:0]  puzzle_mask_bin;
output [9*9*9-1:0] puzzle_ans_bin;

wire [9*9*9*9-1:0] partial_x;
wire [9*9*9*9-1:0] partial_y;
wire [9*9*9*9-1:0] partial_z;
wire [9*9*9*9-1:0] partial_sq;

sudoku_partials sp(.in(puzzle_mask_bin),
				   .match_bit(1'b1),
				   .partial_x(partial_x),
				   .partial_y(partial_y),
				   .partial_z(partial_z),
				   .partial_sq(partial_sq));

genvar i;

generate
	for (i=0; i < 9*9*9; i=i+1)
	begin : ANS
		assign puzzle_ans_bin[i] = (&partial_x[i*9+9-1:i*9]) |
								   (&partial_y[i*9+9-1:i*9]) |
								   (&partial_z[i*9+9-1:i*9]) |
								   (&partial_sq[i*9+9-1:i*9]);
	end
endgenerate

endmodule
