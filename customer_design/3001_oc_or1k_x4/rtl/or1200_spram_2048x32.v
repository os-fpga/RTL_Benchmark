

module or1200_spram_2048x32(

  // Generic synchronous single-port RAM interface
  clk, rst, ce, we, oe, addr, di, doq
);

//
// Default address and data buses width
//
parameter aw = 11;
parameter dw = 32;



//
// Generic synchronous single-port RAM interface
//
input			clk;	// Clock
input			rst;	// Reset
input			ce;	// Chip enable input
input			we;	// Write enable input
input			oe;	// Output enable input
input 	[aw-1:0]	addr;	// address bus inputs
input	[dw-1:0]	di;	// input data bus
output	reg [dw-1:0]	doq;	// output data bus

//
// Internal wires and registers
//



///
// Generic RAM's registers and wires
//
reg	[dw-1:0]	mem [(1<<aw)-1:0]/* synthesis syn_ramstyle="block_ram" */;	// RAM content
reg	[aw-1:0]	addr_reg;		// RAM address register

//
// Data output drivers
//

always @(posedge clk)
    doq = (oe) ? mem[addr] : {dw{1'b0}};

//
// RAM address register
//
always @(posedge clk or posedge rst)
  if (rst)
    addr_reg <= #1 {aw{1'b0}};
  else if (ce)
    addr_reg <= #1 addr;

//
// RAM write
//
always @(posedge clk)
  if (ce && we)
    mem[addr] <= #1 di;


endmodule


