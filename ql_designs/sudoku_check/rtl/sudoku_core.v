// $Header:   /pvcs/designs/power_sanity_designs/source/sudoku_check_wrapper/sudoku_core.v__   1.0   30 Mar 2006 08:53:26   rtai  $
//
//	Puzzles are stored in a binary vector top to bottom, left to right.
//
//	(msb)	[row 0, col 0] [row 0, col 1] ... [row 0, col 8] 
//			[row 1, col 0] ... 
//		
//				...			  				  [row 8, col 8]  (lsb)
//
//	4 bits per cell.  0 indicates an unknown value.  1..9 known values
//			A..F are unused.
//
//	puzzle_in/puzzle_out : Input and output buses.
//
//	puzzle_avail : Input indicating that there is a puzzle available 
//		to be read in and that there is a memory location available to
//		write an answer out.
//
//	read_puzzle : Output to acknowledge that the puzzle on puzzle_in has been
//		read in and requests another puzzle be placed on puzzle_in
//
//	done_puzzle : Output to tell parent that the data on puzzle_out is ready
//		to be read.  The data may have a solution or the core may have given
//		up.  This line only means that the core can do nothing else.
  
module sudoku_core (
	clk,rst,go,
	puzzle_avail,
	puzzle_in,
	puzzle_out,
	read_puzzle,
	done_puzzle);

input clk,rst,go;
input puzzle_avail;
input [9*9*4-1:0] puzzle_in;
output [9*9*4-1:0] puzzle_out;
output read_puzzle, done_puzzle;

reg [9*9*4-1:0] puzzle_reg_hex;
wire [9*9*9-1:0] puzzle_reg_bin;
reg [9*9*9-1:0] puzzle_reg_bin_pipe;
wire [9*9*9-1:0] puzzle_mask_bin;
reg [9*9*9-1:0] puzzle_mask_bin_pipe;
reg [9*9*9-1:0] puzzle_reg_bin_pipe_stall1;
wire [9*9*9-1:0] puzzle_mask_bin2;
reg [9*9*9-1:0] puzzle_mask_bin2_pipe;
reg [9*9*9-1:0] puzzle_reg_bin_pipe_stall2;
wire [9*9*9-1:0] puzzle_ans_bin;
reg [9*9*9-1:0] puzzle_ans_bin_pipe;
reg [9*9*9-1:0] puzzle_reg_bin_pipe_stall3;
wire [9*9*4-1:0] puzzle_ans_hex;
reg [9*9*4-1:0] puzzle_ans_hex_pipe;

parameter NUM_PIPE_STGS = 6;

reg priming_pipe;
reg [2:0] waiting_for_puzzle;
reg [2:0] puzzle_at_end_of_pipe;
reg forward;
wire forward_wire;
reg retreating;
//wire retreating_wire;
reg no_zeros;
wire no_zeros_wire;

always @(posedge clk or posedge rst) begin
	if (rst) puzzle_reg_hex <= 0;
	else if (read_puzzle) puzzle_reg_hex <= puzzle_in;
	else puzzle_reg_hex <= puzzle_ans_hex_pipe;
end

assign puzzle_out = puzzle_ans_hex_pipe;
assign read_puzzle = done_puzzle || (go && priming_pipe);
assign done_puzzle = (!forward || no_zeros || retreating) && !priming_pipe && puzzle_avail && (waiting_for_puzzle == puzzle_at_end_of_pipe);

//assign retreating_wire = | ((~puzzle_ans_bin_pipe) & puzzle_reg_bin_pipe_stall3);
assign forward_wire = | ((~puzzle_reg_bin_pipe_stall3) & puzzle_ans_bin_pipe);

sudoku_solution ss(.puzzle_ans(puzzle_ans_bin_pipe),
				   .solution(no_zeros_wire));
defparam ss.WIDTH = 9;

always @(posedge clk or posedge rst) begin
	if (rst)
	begin
		retreating <= 0;
		forward <= 0;
		no_zeros <= 0;
	end
	else
	begin
//		retreating <= retreating_wire;
		forward <= forward_wire;
		no_zeros <= no_zeros_wire;
	end
end

always @(posedge clk or posedge rst) begin
	if (rst) waiting_for_puzzle <= 0;
	else if (done_puzzle)
	begin
		if (waiting_for_puzzle == NUM_PIPE_STGS-1) waiting_for_puzzle <= 0;
		else waiting_for_puzzle <= waiting_for_puzzle + 1'b1;
	end
end

always @(posedge clk or posedge rst) begin
	if (rst) puzzle_at_end_of_pipe <= 0;
	else if (go)
	begin
		if (puzzle_at_end_of_pipe == NUM_PIPE_STGS-1) puzzle_at_end_of_pipe <= 0;
		else puzzle_at_end_of_pipe <= puzzle_at_end_of_pipe + 1'b1;
	end
end

always @(posedge clk or posedge rst) begin
	if (rst) priming_pipe <= 1'b1;
	else if (priming_pipe && puzzle_at_end_of_pipe == NUM_PIPE_STGS-1) priming_pipe <= 0;
end

// Convert to puzzle_reg_bin from puzzle_reg_hex
sudoku_hex2bin sh2b(.hex(puzzle_reg_hex),
					.bin(puzzle_reg_bin));

always @(posedge clk or posedge rst) begin
	if (rst)
	begin
		puzzle_reg_bin_pipe <= 0;
		puzzle_reg_bin_pipe_stall1 <= 0;
		puzzle_reg_bin_pipe_stall2 <= 0;
		puzzle_reg_bin_pipe_stall3 <= 0;
	end
	else
	begin
		puzzle_reg_bin_pipe <= puzzle_reg_bin;
		puzzle_reg_bin_pipe_stall1 <= puzzle_reg_bin_pipe;
		puzzle_reg_bin_pipe_stall2 <= puzzle_reg_bin_pipe_stall1;
		puzzle_reg_bin_pipe_stall3 <= puzzle_reg_bin_pipe_stall2;
	end
end

// Calculate puzzle_mask_bin from puzzle_reg_bin
sudoku_mask sm(.puzzle_reg_bin(puzzle_reg_bin_pipe),
			   .puzzle_mask_bin(puzzle_mask_bin));

always @(posedge clk or posedge rst) begin
	if (rst) puzzle_mask_bin_pipe <= 0;
	else puzzle_mask_bin_pipe <= puzzle_mask_bin;
end

sudoku_mask_stg2 sm2(.puzzle_mask_bin(puzzle_mask_bin_pipe),
					 .puzzle_mask_bin2(puzzle_mask_bin2));

always @(posedge clk or posedge rst) begin
	if (rst) puzzle_mask_bin2_pipe <= 0;
	else puzzle_mask_bin2_pipe <= puzzle_mask_bin2;
end

// Calculate puzzle_ans_bin from the puzzle_mask_bin
sudoku_ans sa(.puzzle_mask_bin(puzzle_mask_bin2_pipe),
			  .puzzle_ans_bin(puzzle_ans_bin));

always @(posedge clk or posedge rst) begin
	if (rst) puzzle_ans_bin_pipe <= 0;
	else puzzle_ans_bin_pipe <= puzzle_ans_bin;
end

// Convert to puzzle_ans_hex from puzzle_ans_bin
sudoku_bin2hex sb2h(.bin(puzzle_ans_bin_pipe),
					.hex(puzzle_ans_hex));

always @(posedge clk or posedge rst) begin
	if (rst) puzzle_ans_hex_pipe <= 0;
	else puzzle_ans_hex_pipe <= puzzle_ans_hex;
end

endmodule
