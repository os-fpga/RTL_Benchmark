// ----------------------------------------------------------------------------
// FILE NAME      : xilinx_block_ram_8_16.v
// ----------------------------------------------------------------------------
// Release History
//   VERSION DATE     AUTHOR       DESCRIPTION
//   ------- -------- ------------ --------------------------------------------
//   0.00    04-11-02 John Clayton copied this file from
//                                 "xilinx_block_ram_16_16.v"
// ----------------------------------------------------------------------------
// PURPOSE: This module instantiates the Dual Port "block RAM" available within
//          the Xilinx Virtex or SpartanII FPGA.
//
//          All of the modules are dual-ported.  If you do not need one of the
//          ports, just connect the inputs to constants, and leave the outputs
//          unconnected.  They will show up as "dangling" in the Xilinx place
//          and route software, but it is only a warning, and the blocks still
//          work fine.  If you don't like that warning, build some new memory
//          blocks which instantiate single-ported constructs.
//
//
//          There are several modules:
//
//               ramb8_s8_s16   --  512x16 ( 2 block rams)
//              ramb16_s8_s16   -- 1024x16 ( 4 block rams)
//
// You can easily make larger modules, by just copying the last one, changing
// the name to reflect a larger size, adjusting the address lines to reflect
// one additional bit, and changing the two modules inside to be the previous
// size (which is half as large...)
// Of course, this method only handles sizes which are powers of 2 in size...
// Also, you must have enough block rams inside your part, obviously.
//
// To initialize the contents of the RAMs, try using constraints in your .ucf
// file.  Such as:
//
// INST foo/bar INIT_00=fedcba9876543210;
//
// ----------------------------------------------------------------------------
// Parameters
//   NAME                 RANGE    DESCRIPTION                DEFAULT
//   -------------------- -------- -------------------------- -----------------
//   None.
//
// ----------------------------------------------------------------------------
// REUSE ISSUES
//   Reset Strategy   : None
//   Clock Domains    : sys_clk 
//   Critical Timing  : None.
//   Test Features    : None
//   Asynchronous I/F : None
//   Scan Methodology : N/A
//   Instantiations   : RAMB4_S8_S16 FPGA Virtex Primitive
//   Other        :
// ----------------------------------------------------------------------------


// The following 'include' line must be used with Synplicity to create EDIF.
// The line must be commented for ModelSim.
//`include "C:\synplicity\synplify\lib\xilinx\virtex.v"


module ramb8_s8_s16(
dat_o_s8a,
adr_i_s8a,
dat_i_s8a,
rst_i_s8a,
we_i_s8a,
clk_i_s8a,
dat_o_s16b,
adr_i_s16b,
dat_i_s16b,
rst_i_s16b,
we_i_s16b,
clk_i_s16b
);
  
// I/O Declarations
output [7:0] dat_o_s8a;             // A port data output
input [9:0] adr_i_s8a;              // A port address
input [7:0] dat_i_s8a;              // A port data input
input rst_i_s8a;                    // A port reset
input we_i_s8a;                     // A port write enable
input clk_i_s8a;                    // A port clock

output [15:0] dat_o_s16b;            // B port data output
input [8:0] adr_i_s16b;              // B port address
input [15:0] dat_i_s16b;             // B port data input
input rst_i_s16b;                    // B port reset
input we_i_s16b;                     // B port write enable
input clk_i_s16b;                    // B port clock

// Local signals
wire [7:0] dat_o_s8a_0;
wire [7:0] dat_o_s8a_1;
wire [15:0] dat_o_s16b_0;
wire [15:0] dat_o_s16b_1;

// "First half"
RAMB4_S8_S16 r0 (
  .DOA(dat_o_s8a_0),
  .ADDRA(adr_i_s8a[8:0]),
  .CLKA(clk_i_s8a),
  .DIA(dat_i_s8a),
  .ENA(~adr_i_s8a[9]),
  .RSTA(rst_i_s8a),
  .WEA(we_i_s8a),         // In combination with .ena
  .DOB(dat_o_s16b_0),
  .ADDRB(adr_i_s16b[7:0]),
  .CLKB(clk_i_s16b),
  .DIB(dat_i_s16b),
  .ENB(~adr_i_s16b[8]),
  .RSTB(rst_i_s16b),
  .WEB(we_i_s16b)         // In combination with .enb
  );


// "Second half"
RAMB4_S8_S16 r1 (
  .DOA(dat_o_s8a_1),
  .ADDRA(adr_i_s8a[8:0]),
  .CLKA(clk_i_s8a),
  .DIA(dat_i_s8a),
  .ENA(adr_i_s8a[9]),
  .RSTA(rst_i_s8a),
  .WEA(we_i_s8a),         // In combination with .ena
  .DOB(dat_o_s16b_1),
  .ADDRB(adr_i_s16b[7:0]),
  .CLKB(clk_i_s16b),
  .DIB(dat_i_s16b),
  .ENB(adr_i_s16b[8]),
  .RSTB(rst_i_s16b),
  .WEB(we_i_s16b)         // In combination with .enb
  );

// This mux selects which A data is read from the block.
assign dat_o_s8a = adr_i_s8a[9]?dat_o_s8a_1:dat_o_s8a_0;
// This mux selects which B data is read from the block.
assign dat_o_s16b = adr_i_s16b[8]?dat_o_s16b_1:dat_o_s16b_0;


// The defparam initializes memory contents only for simulation.
// The "synopsys translate off/on" statements cause the synthesis tool
// (from Synopsys) to ignore the defparams...
// I left these in here so that simulations would start out with a known
// state for the memory contents of all modules in this file... (All
// of the block RAM modules in this file are build from this basic module.)

// synopsys translate_off
defparam ram_0.INIT_00 =
  256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam ram_0.INIT_01 =
  256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam ram_0.INIT_02 =
  256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam ram_0.INIT_03 =
  256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam ram_0.INIT_04 =
  256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam ram_0.INIT_05 =
  256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam ram_0.INIT_06 =
  256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam ram_0.INIT_07 =
  256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam ram_0.INIT_08 =
  256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam ram_0.INIT_09 =
  256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam ram_0.INIT_0A =
  256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam ram_0.INIT_0B =
  256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam ram_0.INIT_0C =
  256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam ram_0.INIT_0D =
  256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam ram_0.INIT_0E =
  256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam ram_0.INIT_0F =
  256'h0000000000000000000000000000000000000000000000000000000000000000;
  
defparam ram_1.INIT_00 =
  256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam ram_1.INIT_01 =
  256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam ram_1.INIT_02 =
  256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam ram_1.INIT_03 =
  256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam ram_1.INIT_04 =
  256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam ram_1.INIT_05 =
  256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam ram_1.INIT_06 =
  256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam ram_1.INIT_07 =
  256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam ram_1.INIT_08 =
  256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam ram_1.INIT_09 =
  256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam ram_1.INIT_0A =
  256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam ram_1.INIT_0B =
  256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam ram_1.INIT_0C =
  256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam ram_1.INIT_0D =
  256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam ram_1.INIT_0E =
   256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam ram_1.INIT_0F =
  256'h0000000000000000000000000000000000000000000000000000000000000000;
//synopsys translate_on


endmodule



// ----------------------------------------------------------------------------

module ramb16_s8_s16(
dat_o_s8a,
adr_i_s8a,
dat_i_s8a,
rst_i_s8a,
we_i_s8a,
clk_i_s8a,
dat_o_s16b,
adr_i_s16b,
dat_i_s16b,
rst_i_s16b,
we_i_s16b,
clk_i_s16b
);
  
// I/O Declarations
output [7:0] dat_o_s8a;             // A port data output
input [10:0] adr_i_s8a;             // A port address
input [7:0] dat_i_s8a;              // A port data input
input rst_i_s8a;                    // A port reset
input we_i_s8a;                     // A port write enable
input clk_i_s8a;                    // A port clock

output [15:0] dat_o_s16b;            // B port data output
input [9:0] adr_i_s16b;              // B port address
input [15:0] dat_i_s16b;             // B port data input
input rst_i_s16b;                    // B port reset
input we_i_s16b;                     // B port write enable
input clk_i_s16b;                    // B port clock


// Local signals
wire [7:0] dat_o_s8a_0;
wire [7:0] dat_o_s8a_1;
wire [15:0] dat_o_s16b_0;
wire [15:0] dat_o_s16b_1;


// "Even half"
ramb8_s8_s16 r0 (
  .dat_o_s8a(dat_o_s8a_0),
  .adr_i_s8a(adr_i_s8a[9:0]),
  .clk_i_s8a(clk_i_s8a),
  .dat_i_s8a(dat_i_s8a),
  .rst_i_s8a(rst_i_s8a),
  .we_i_s8a(we_i_s8a && ~adr_i_s8a[10]),
  .dat_o_s16b(dat_o_s16b_0),
  .adr_i_s16b(adr_i_s16b[8:0]),
  .clk_i_s16b(clk_i_s16b),
  .dat_i_s16b(dat_i_s16b),
  .rst_i_s16b(rst_i_s16b),
  .we_i_s16b(we_i_s16b && ~adr_i_s16b[9])
  );


// "Odd half"
ramb8_s8_s16 r1 (
  .dat_o_s8a(dat_o_s8a_1),
  .adr_i_s8a(adr_i_s8a[9:0]),
  .clk_i_s8a(clk_i_s8a),
  .dat_i_s8a(dat_i_s8a),
  .rst_i_s8a(rst_i_s8a),
  .we_i_s8a(we_i_s8a && adr_i_s8a[10]),
  .dat_o_s16b(dat_o_s16b_1),
  .adr_i_s16b(adr_i_s16b[8:0]),
  .clk_i_s16b(clk_i_s16b),
  .dat_i_s16b(dat_i_s16b),
  .rst_i_s16b(rst_i_s16b),
  .we_i_s16b(we_i_s16b && adr_i_s16b[9])
  );

// This mux selects which A data is read from the block.
assign dat_o_s8a = adr_i_s8a[10]?dat_o_s8a_1:dat_o_s8a_0;
// This mux selects which B data is read from the block.
assign dat_o_s16b = adr_i_s16b[9]?dat_o_s16b_1:dat_o_s16b_0;



endmodule

