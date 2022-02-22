/****************************************************************************
          Register File

   - Has two read ports (a and b) and one write port (c)
   - sel chooses the register to be read/written
****************************************************************************/
module reg_file(clk,resetn, 
	a_reg, a_readdataout, a_en,
	b_reg, b_readdataout, b_en,
	c_reg, c_writedatain, c_we);

parameter WIDTH=32;
parameter NUMREGS=32;
parameter LOG2NUMREGS=5;

input clk;
input resetn;

input a_en;
input b_en;

input [LOG2NUMREGS-1:0] a_reg,b_reg,c_reg;
output [WIDTH-1:0] a_readdataout, b_readdataout;
input [WIDTH-1:0] c_writedatain;
input c_we;

	t_dpram_sclka	#(.AWIDTH(LOG2NUMREGS), .DWIDTH(WIDTH), .DEPTH(NUMREGS))
      reg_file1(
				.we_a (c_we&(|c_reg)),
        .we_b (1'b0),
				.clk (clk),
				.addr_a (c_reg[LOG2NUMREGS-1:0]),
				.addr_b (a_reg[LOG2NUMREGS-1:0]),
				.data_a (c_writedatain),
        .data_b (32'hffffffff),
        .q_a (),
				.q_b (a_readdataout)
        );

	t_dpram_sclka	#(.AWIDTH(LOG2NUMREGS), .DWIDTH(WIDTH), .DEPTH(NUMREGS))
      reg_file2(
				.we_a (c_we&(|c_reg)),
        .we_b (1'b0),
				.clk (clk),
				.addr_a (c_reg[LOG2NUMREGS-1:0]),
				.addr_b (b_reg[LOG2NUMREGS-1:0]),
				.data_a (c_writedatain),
        .data_b (32'hffffffff),
        .q_a (),
				.q_b (b_readdataout)
        );

endmodule

