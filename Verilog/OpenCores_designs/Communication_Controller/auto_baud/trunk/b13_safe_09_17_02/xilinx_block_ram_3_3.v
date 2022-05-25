// ----------------------------------------------------------------------------
// FILE NAME      : xilinx_block_ram_3_3.v
// ----------------------------------------------------------------------------
// Release History
//   VERSION DATE     AUTHOR       DESCRIPTION
//   ------- -------- ------------ --------------------------------------------
//   0.00    09-04-01 John Clayton copied this file from
//                                 "xilinx_block_ram_8_16.v"
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
//              ramb4_s3_s3     --  4096x3 ( 3 block rams)
//              ramb12_s3_s3    -- 12288x3 ( 9 block rams)
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


module ramb4_s3_s3(
  dat_o_s3a,
  dat_i_s3a,
  adr_i_s3a,
  clk_i_s3a,
  rst_i_s3a,
  we_i_s3a,
  dat_o_s3b,
  dat_i_s3b,
  adr_i_s3b,
  clk_i_s3b,
  rst_i_s3b,
  we_i_s3b
  );
  
// I/O Declarations
output [2:0] dat_o_s3a;             // A port data output
input  [2:0] dat_i_s3a;             // A port data input
input  [11:0] adr_i_s3a;            // A port address
input  rst_i_s3a;                   // A port reset
input  we_i_s3a;                    // A port write enable
input  clk_i_s3a;                   // A port clock

output [2:0] dat_o_s3b;             // B port data output
input  [2:0] dat_i_s3b;             // B port data input
input  [11:0] adr_i_s3b;            // B port address
input  rst_i_s3b;                   // B port reset
input  we_i_s3b;                    // B port write enable
input  clk_i_s3b;                   // B port clock

// "Zeroth bit"
RAMB4_S1_S1 b0 (
  .DOA(dat_o_s3a[0]),
  .DIA(dat_i_s3a[0]),
  .ADDRA(adr_i_s3a),
  .CLKA(clk_i_s3a),
  .ENA(1'b1),
  .RSTA(rst_i_s3a),
  .WEA(we_i_s3a),
  .DOB(dat_o_s3b[0]),
  .DIB(dat_i_s3b[0]),
  .ADDRB(adr_i_s3b),
  .CLKB(clk_i_s3b),
  .ENB(1'b1),
  .RSTB(rst_i_s3b),
  .WEB(we_i_s3b)
  );

// "First bit"
RAMB4_S1_S1 b1 (
  .DOA(dat_o_s3a[1]),
  .DIA(dat_i_s3a[1]),
  .ADDRA(adr_i_s3a),
  .CLKA(clk_i_s3a),
  .ENA(1'b1),
  .RSTA(rst_i_s3a),
  .WEA(we_i_s3a),
  .DOB(dat_o_s3b[1]),
  .DIB(dat_i_s3b[1]),
  .ADDRB(adr_i_s3b),
  .CLKB(clk_i_s3b),
  .ENB(1'b1),
  .RSTB(rst_i_s3b),
  .WEB(we_i_s3b)
  );

// "Second bit"
RAMB4_S1_S1 b2 (
  .DOA(dat_o_s3a[2]),
  .DIA(dat_i_s3a[2]),
  .ADDRA(adr_i_s3a),
  .CLKA(clk_i_s3a),
  .ENA(1'b1),
  .RSTA(rst_i_s3a),
  .WEA(we_i_s3a),
  .DOB(dat_o_s3b[2]),
  .DIB(dat_i_s3b[2]),
  .ADDRB(adr_i_s3b),
  .CLKB(clk_i_s3b),
  .ENB(1'b1),
  .RSTB(rst_i_s3b),
  .WEB(we_i_s3b)
  );


// The defparam initializes memory contents only for simulation.
// The "synopsys translate off/on" statements cause the synthesis tool
// (from Synopsys) to ignore the defparams...
// I left these in here so that simulations would start out with a known
// state for the memory contents of all modules in this file... (All
// of the block RAM modules in this file are build from this basic module.)

// synopsys translate_off
defparam b0.INIT_00 =
  256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam b0.INIT_01 =
  256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam b0.INIT_02 =
  256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam b0.INIT_03 =
  256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam b0.INIT_04 =
  256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam b0.INIT_05 =
  256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam b0.INIT_06 =
  256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam b0.INIT_07 =
  256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam b0.INIT_08 =
  256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam b0.INIT_09 =
  256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam b0.INIT_0A =
  256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam b0.INIT_0B =
  256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam b0.INIT_0C =
  256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam b0.INIT_0D =
  256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam b0.INIT_0E =
  256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam b0.INIT_0F =
  256'h0000000000000000000000000000000000000000000000000000000000000000;
  
defparam b1.INIT_00 =
  256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam b1.INIT_01 =
  256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam b1.INIT_02 =
  256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam b1.INIT_03 =
  256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam b1.INIT_04 =
  256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam b1.INIT_05 =
  256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam b1.INIT_06 =
  256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam b1.INIT_07 =
  256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam b1.INIT_08 =
  256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam b1.INIT_09 =
  256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam b1.INIT_0A =
  256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam b1.INIT_0B =
  256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam b1.INIT_0C =
  256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam b1.INIT_0D =
  256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam b1.INIT_0E =
   256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam b1.INIT_0F =
  256'h0000000000000000000000000000000000000000000000000000000000000000;
  
defparam b2.INIT_00 =
  256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam b2.INIT_01 =
  256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam b2.INIT_02 =
  256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam b2.INIT_03 =
  256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam b2.INIT_04 =
  256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam b2.INIT_05 =
  256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam b2.INIT_06 =
  256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam b2.INIT_07 =
  256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam b2.INIT_08 =
  256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam b2.INIT_09 =
  256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam b2.INIT_0A =
  256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam b2.INIT_0B =
  256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam b2.INIT_0C =
  256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam b2.INIT_0D =
  256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam b2.INIT_0E =
   256'h0000000000000000000000000000000000000000000000000000000000000000;
defparam b2.INIT_0F =
  256'h0000000000000000000000000000000000000000000000000000000000000000;
//synopsys translate_on


endmodule



// ----------------------------------------------------------------------------

module ramb12_s3_s3(
  dat_o_s3a,
  dat_i_s3a,
  adr_i_s3a,
  clk_i_s3a,
  rst_i_s3a,
  we_i_s3a,
  dat_o_s3b,
  dat_i_s3b,
  adr_i_s3b,
  clk_i_s3b,
  rst_i_s3b,
  we_i_s3b
  );
  
// I/O Declarations
output [2:0] dat_o_s3a;              // A port data output
input  [2:0] dat_i_s3a;              // A port data input
input  [13:0] adr_i_s3a;             // A port address
input  rst_i_s3a;                    // A port reset
input  we_i_s3a;                     // A port write enable
input  clk_i_s3a;                    // A port clock

output [2:0] dat_o_s3b;              // B port data output
input  [2:0] dat_i_s3b;              // B port data input
input  [13:0] adr_i_s3b;             // B port address
input  rst_i_s3b;                    // B port reset
input  we_i_s3b;                     // B port write enable
input  clk_i_s3b;                    // B port clock


// Local signals
wire [2:0] dat_o_s3a_0;
wire [2:0] dat_o_s3a_1;
wire [2:0] dat_o_s3a_2;
wire [2:0] dat_o_s3b_0;
wire [2:0] dat_o_s3b_1;
wire [2:0] dat_o_s3b_2;


// "Zeroth third"
ramb4_s3_s3 r0 (
  .dat_o_s3a(dat_o_s3a_0),
  .dat_i_s3a(dat_i_s3a),
  .adr_i_s3a(adr_i_s3a[11:0]),
  .clk_i_s3a(clk_i_s3a),
  .rst_i_s3a(rst_i_s3a),
  .we_i_s3a(we_i_s3a && ~adr_i_s3a[12] && ~adr_i_s3a[13]),
  .dat_o_s3b(dat_o_s3b_0),
  .dat_i_s3b(dat_i_s3b),
  .adr_i_s3b(adr_i_s3b[11:0]),
  .clk_i_s3b(clk_i_s3b),
  .rst_i_s3b(rst_i_s3b),
  .we_i_s3b(we_i_s3b && ~adr_i_s3b[12] && ~adr_i_s3b[13])
  );

// "First third"
ramb4_s3_s3 r1 (
  .dat_o_s3a(dat_o_s3a_1),
  .dat_i_s3a(dat_i_s3a),
  .adr_i_s3a(adr_i_s3a[11:0]),
  .clk_i_s3a(clk_i_s3a),
  .rst_i_s3a(rst_i_s3a),
  .we_i_s3a(we_i_s3a && adr_i_s3a[12] && ~adr_i_s3a[13]),
  .dat_o_s3b(dat_o_s3b_1),
  .dat_i_s3b(dat_i_s3b),
  .adr_i_s3b(adr_i_s3b[11:0]),
  .clk_i_s3b(clk_i_s3b),
  .rst_i_s3b(rst_i_s3b),
  .we_i_s3b(we_i_s3b && adr_i_s3b[12] && ~adr_i_s3b[13])
  );

// "Second third"
ramb4_s3_s3 r2 (
  .dat_o_s3a(dat_o_s3a_2),
  .dat_i_s3a(dat_i_s3a),
  .adr_i_s3a(adr_i_s3a[11:0]),
  .clk_i_s3a(clk_i_s3a),
  .rst_i_s3a(rst_i_s3a),
  .we_i_s3a(we_i_s3a && ~adr_i_s3a[12] && adr_i_s3a[13]),
  .dat_o_s3b(dat_o_s3b_2),
  .dat_i_s3b(dat_i_s3b),
  .adr_i_s3b(adr_i_s3b[11:0]),
  .clk_i_s3b(clk_i_s3b),
  .rst_i_s3b(rst_i_s3b),
  .we_i_s3b(we_i_s3b && ~adr_i_s3b[12] && adr_i_s3b[13])
  );


// This mux selects which A data is read from the block.
assign dat_o_s3a = 
       adr_i_s3a[13]?dat_o_s3a_2:adr_i_s3a[12]?dat_o_s3a_1:dat_o_s3a_0;
// This mux selects which B data is read from the block.
assign dat_o_s3b = 
       adr_i_s3b[13]?dat_o_s3b_2:adr_i_s3b[12]?dat_o_s3b_1:dat_o_s3b_0;



endmodule

