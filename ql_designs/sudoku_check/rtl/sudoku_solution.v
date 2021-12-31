// $Header:   /pvcs/designs/power_sanity_designs/source/sudoku_check_wrapper/sudoku_solution.v__   1.0   30 Mar 2006 08:54:08   rtai  $

module sudoku_solution (
	puzzle_ans,
	solution);

parameter WIDTH = 4; //default to puzzle_ans_hex width of 4
                     //width of 9 for puzzle_ans_bin.

input [9*9*WIDTH-1:0] puzzle_ans;
output 				  solution;

wire [9*9-1:0] 		  non_zero;

assign solution = & non_zero;
	  
genvar i;

generate
	for (i=0; i < 9*9; i=i+1)
	begin : NZ
		assign non_zero[i] = | puzzle_ans[i*WIDTH+WIDTH-1:i*WIDTH];
	end
endgenerate

endmodule
