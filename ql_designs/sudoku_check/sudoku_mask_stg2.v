// $Header:   /pvcs/designs/power_sanity_designs/source/sudoku_check_wrapper/sudoku_mask_stg2.v__   1.0   30 Mar 2006 08:53:48   rtai  $

module sudoku_mask_stg2 (
	puzzle_mask_bin,
	puzzle_mask_bin2);

input [9*9*9-1:0]  puzzle_mask_bin;
output [9*9*9-1:0] puzzle_mask_bin2;

wire [9*9*9*3*9-1:0] partial_line_x;
wire [9*9*9*3*9-1:0] partial_sq_x;
wire [9*9*9*3*9-1:0] partial_line_y;
wire [9*9*9*3*9-1:0] partial_sq_y;

genvar i;
genvar xi;
genvar yi;

generate
	for (i=0; i < 9*9*9; i=i+1)
	begin : LX1
		for (xi=0; xi < 9; xi=xi+1)
		begin : LX2
			for (yi=(((i/9)%9)/3)*3; yi < (((i/9)%9)/3)*3+3; yi=yi+1)
			begin : LX3
				if ((i/9)%9 == yi)
				begin
					assign partial_line_x[i*3*9+(yi%3)*9+xi] = 1'b0;
				end
				else if ((i/(9*9))/3 == xi/3)
				begin
					assign partial_line_x[i*3*9+(yi%3)*9+xi] = 1'b1;
				end
				else
				begin
					assign partial_line_x[i*3*9+(yi%3)*9+xi] = puzzle_mask_bin[i-(i/(9*9))*9*9+xi*9*9-((i/9)%9)*9+yi*9];
				end
			end
		end
	end
endgenerate

generate
	for (i=0; i < 9*9*9; i=i+1)
	begin : SQX1
		for (xi=0; xi < 9; xi=xi+1)
		begin : SQX2
			for (yi=(((i/9)%9)/3)*3; yi < (((i/9)%9)/3)*3+3; yi=yi+1)
			begin : SQX3
				if ((i/9)%9 == yi)
				begin
					assign partial_sq_x[i*3*9+xi/3*9+(xi%3)*3+yi%3] = 1'b1;
				end
				else if ((i/(9*9))/3 == xi/3)
				begin
					assign partial_sq_x[i*3*9+xi/3*9+(xi%3)*3+yi%3] = 1'b0;
				end
				else
				begin
					assign partial_sq_x[i*3*9+xi/3*9+(xi%3)*3+yi%3] = puzzle_mask_bin[i-(i/(9*9))*9*9+xi*9*9-((i/9)%9)*9+yi*9];
				end
			end
		end
	end
endgenerate

generate
	for (i=0; i < 9*9*9; i=i+1)
	begin : LY1
		for (yi=0; yi < 9; yi=yi+1)
		begin : LY2
			for (xi=((i/(9*9))/3)*3; xi < ((i/(9*9))/3)*3+3; xi=xi+1)
			begin : LY3
				if ((i/(9*9)) == xi)
				begin
					assign partial_line_y[i*3*9+(xi%3)*9+yi] = 1'b0;
				end
				else if (((i/9)%9)/3 == yi/3)
				begin
					assign partial_line_y[i*3*9+(xi%3)*9+yi] = 1'b1;
				end
				else
				begin
					assign partial_line_y[i*3*9+(xi%3)*9+yi] = puzzle_mask_bin[i-(i/(9*9))*9*9+xi*9*9-((i/9)%9)*9+yi*9];
				end
			end
		end
	end
endgenerate

generate
	for (i=0; i < 9*9*9; i=i+1)
	begin : SQY1
		for (yi=0; yi < 9; yi=yi+1)
		begin : SQY2
			for (xi=((i/(9*9))/3)*3; xi < ((i/(9*9))/3)*3+3; xi=xi+1)
			begin : SQY3
				if ((i/(9*9)) == xi)
				begin
					assign partial_sq_y[i*3*9+yi/3*9+(yi%3)*3+xi%3] = 1'b1;
				end
				else if (((i/9)%9)/3 == yi/3)
				begin
					assign partial_sq_y[i*3*9+yi/3*9+(yi%3)*3+xi%3] = 1'b0;
				end
				else
				begin
					assign partial_sq_y[i*3*9+yi/3*9+(yi%3)*3+xi%3] = puzzle_mask_bin[i-(i/(9*9))*9*9+xi*9*9-((i/9)%9)*9+yi*9];
				end
			end
		end
	end
endgenerate

generate
	for (i=0; i < 9*9*9; i=i+1)
	begin : ANS
		assign puzzle_mask_bin2[i] = puzzle_mask_bin[i] |
									 (&partial_line_x[i*3*9+3*9-1:i*3*9+2*9]) |
									 (&partial_line_x[i*3*9+2*9-1:i*3*9+1*9]) |
									 (&partial_line_x[i*3*9+  9-1:i*3*9    ]) |
									 (&partial_sq_x[i*3*9+3*9-1:i*3*9+2*9]) |
									 (&partial_sq_x[i*3*9+2*9-1:i*3*9+1*9]) |
									 (&partial_sq_x[i*3*9+  9-1:i*3*9    ]) |
									 (&partial_line_y[i*3*9+3*9-1:i*3*9+2*9]) |
									 (&partial_line_y[i*3*9+2*9-1:i*3*9+1*9]) |
									 (&partial_line_y[i*3*9+  9-1:i*3*9    ]) |
									 (&partial_sq_y[i*3*9+3*9-1:i*3*9+2*9]) |
									 (&partial_sq_y[i*3*9+2*9-1:i*3*9+1*9]) |
									 (&partial_sq_y[i*3*9+  9-1:i*3*9    ]);
	end
endgenerate

endmodule
