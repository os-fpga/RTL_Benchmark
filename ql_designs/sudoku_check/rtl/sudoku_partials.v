// $Header:   /pvcs/designs/power_sanity_designs/source/sudoku_check_wrapper/sudoku_partials.v__   1.0   30 Mar 2006 08:53:58   rtai  $

module sudoku_partials (
	in,
	match_bit,
	partial_x,
	partial_y,
	partial_z,
	partial_sq);

input [9*9*9-1:0]  in;
input 			   match_bit;

output [9*9*9*9-1:0] partial_x;
output [9*9*9*9-1:0] partial_y;
output [9*9*9*9-1:0] partial_z;
output [9*9*9*9-1:0] partial_sq;

genvar i;
genvar xi;
genvar yi;
genvar zi;

generate
	for (i=0; i < 9*9*9; i=i+1)
	begin : X1
		for (xi=0; xi < 9; xi=xi+1)
		begin : X2
			if (i/(9*9) == xi)
			begin
			assign partial_x[i*9+xi] = match_bit;
			end
			else
			begin
				assign partial_x[i*9+xi] = in[i-(i/(9*9))*9*9+xi*9*9];
			end
		end 
	end
endgenerate

generate
	for (i=0; i < 9*9*9; i=i+1)
	begin : Y1
		for (yi=0; yi < 9; yi=yi+1)
		begin : Y2
			if ((i/9)%9 == yi)
			begin
			assign partial_y[i*9+yi] = match_bit;
			end
			else
			begin
				assign partial_y[i*9+yi] = in[i-((i/9)%9)*9+yi*9];
			end
		end
	end
endgenerate

generate
	for (i=0; i < 9*9*9; i=i+1)
	begin : Z1
		for (zi=0; zi < 9; zi=zi+1)
		begin : Z2
			if (i%9 == zi)
			begin
			assign partial_z[i*9+zi] = match_bit;
			end
			else
			begin
				assign partial_z[i*9+zi] = in[i-(i%9)+zi];
			end
		end
	end
endgenerate

generate
	for (i=0; i < 9*9*9; i=i+1)
	begin : SQ1
		for (xi=((i/(9*9))/3)*3; xi < ((i/(9*9))/3)*3+3; xi=xi+1)
		begin : SQ2
			for (yi=(((i/9)%9)/3)*3; yi < (((i/9)%9)/3)*3+3; yi=yi+1)
			begin : SQ3
				if (i/(9*9) == xi && (i/9)%9 == yi)
				begin
				assign partial_sq[i*9+(xi%3)*3+(yi%3)] = match_bit;
				end
				else
				begin
					assign partial_sq[i*9+(xi%3)*3+(yi%3)] = in[i-(i/(9*9))*9*9+xi*9*9-((i/9)%9)*9+yi*9];
				end
			end
		end
	end
endgenerate

endmodule
