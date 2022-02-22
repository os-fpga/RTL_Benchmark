// $Header:   /pvcs/designs/power_sanity_designs/source/sudoku_check_wrapper/sudoku.v__   1.0   30 Mar 2006 08:52:48   rtai  $
//
//  Puzzles are stored in a binary vector top to bottom, left to right.
//
//	(msb)	[row 0, col 0] [row 0, col 1] ... [row 0, col 8] 
//			[row 1, col 0] ... 
//		
//				...			  				  [row 8, col 8]  (lsb)
//
//	4 bits per cell.  0 indicates an unknown value.  1..9 known values
//			A..F are unused.
//
//  Puzzle_io : bidir communication with parent hierarchy.  OE=1 sends
//		a solution to the parent.  OE=0 for reading a puzzle to solve.
//
//  Next_puzzle = 1 asks the parent hierarchy to show the next puzzle 
//		available for solving on the next positive clock edge.  It is 
//		OK to ask for multiple puzzles before offering a solution to any.
//
//  Solution = 1 asks the parent to verify the solution being shown on 
//      the puzzle_io port.
//
//  Give_up = 1 tells the parent to skip a puzzle without checking.
//
//  e.g.  next_puzzle = 1 (view puzzle A) 
//		next_puzzle = 1 (view puzzle B)
//		give_up = 1 (no answer will be offered for A)
//		next_puzzle = 1 (view puzzle C)
//		solution = 1 (verify answer for puzzle B)

module sudoku (
	clk,rst,
	puzzle_io,
	puzzle_oe,
	next_puzzle,
	solution,
	give_up	
);

input clk,rst;
inout [9*9*4-1:0] puzzle_io;
tri [9*9*4-1:0] puzzle_io;
output puzzle_oe;
output next_puzzle;
output solution,give_up;

// PLL signals
wire   clk_150;
wire   pll_locked;

// Input fifo signals
wire   ififo_rdreq;
wire   ififo_rdempty;
wire   ififo_rdfull;
wire   ififo_wrfull;
wire [9*9*4-1:0] ififo_dataout;

// Output fifo signals
wire   ofifo_wrreq;
wire   ofifo_rdempty;
wire   ofifo_wrfull;
wire [9*9*4-1:0] ofifo_datain;
wire [9*9*4-1:0] ofifo_dataout;

// Sudoku control signals
reg    sudoku_go;
wire   solution_wire;

//pll spll (.areset(rst),
//		  .inclk0(clk),
//		  .c0(clk_150),
//		  .locked(pll_locked));

fifo ififo (.aclr(rst),
			.data(puzzle_io),
			.wrclk(clk),
			.wrreq(next_puzzle),
			.rdclk(clk),
			.rdreq(ififo_rdreq),
			.q(ififo_dataout),
			.rdempty(ififo_rdempty),
			.rdfull(ififo_rdfull),
			.wrempty(),
			.wrfull(ififo_wrfull));

fifo ofifo (.aclr(rst),
			.data(ofifo_datain),
			.wrclk(clk),
			.wrreq(ofifo_wrreq),
			.rdclk(clk),
			.rdreq(puzzle_oe),
			.q(ofifo_dataout),
			.rdempty(ofifo_rdempty),
			.rdfull(),
			.wrempty(),
			.wrfull(ofifo_wrfull));

// sudoku_go is a latch that goes to 1 when the input fifo is filled for the
// first time and the pll has locked.
always @(posedge clk or posedge rst)
begin
    if (rst) sudoku_go <= 0;
    else if (pll_locked && ififo_rdfull) sudoku_go <= 1'b1;
end

sudoku_core sc (.clk(clk),
				.rst(rst),
				.go(sudoku_go),
				.puzzle_avail(!ififo_rdempty && !ofifo_wrfull),
				.puzzle_in(ififo_dataout),
				.puzzle_out(ofifo_datain),
				.read_puzzle(ififo_rdreq),
				.done_puzzle(ofifo_wrreq));

sudoku_solution ss (.puzzle_ans(ofifo_dataout),
					.solution(solution_wire));
defparam ss.WIDTH = 4;

// Generate output signals
assign puzzle_io = (puzzle_oe ? ofifo_dataout : 324'bz);
assign puzzle_oe = !ofifo_rdempty;
assign next_puzzle = !puzzle_oe && !ififo_wrfull && pll_locked;
assign solution = puzzle_oe && solution_wire;
assign give_up = puzzle_oe && !solution_wire;

endmodule
