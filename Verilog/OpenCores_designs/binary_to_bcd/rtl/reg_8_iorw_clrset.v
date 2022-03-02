// ----------------------------------------------------------------------------
// reg_8_iorw_clrset.v
// 
// AUTHOR         : John Clayton
// ----------------------------------------------------------------------------
// Release History
//   VERSION DATE        AUTHOR            DESCRIPTION
//   ------- ----------- ----------------- ------------------------------------
//   1.0     01/24/03    John Clayton      Initial Version
// ----------------------------------------------------------------------------
// PURPOSE: This module implements a set of eight addresses and a data bus of
//          the given width.  Outputs of the registers are provided, and separate
//          inputs are provided.  Each bit of the rd_i signal bus determines
//          whether the read contents are obtained from the input pins
//          (rdi[x] == high) or from the register outputs (rdi[x] == low.)
// ----------------------------------------------------------------------------
// Parameters
//   NAME                 RANGE    DESCRIPTION                DEFAULT
//   -------------------- -------- -------------------------- -----------------
//   SIZE_R0_PP           1..16    Number of bits in register   8
//   SIZE_R1_PP           1..16    Number of bits in register   8
//   SIZE_R2_PP           1..16    Number of bits in register   8
//   SIZE_R3_PP           1..16    Number of bits in register   8
//   SIZE_R4_PP           1..16    Number of bits in register   8
//   SIZE_R5_PP           1..16    Number of bits in register   8
//   SIZE_R6_PP           1..16    Number of bits in register   8
//   SIZE_R7_PP           1..16    Number of bits in register   8
//   DATA_BUS_SIZE_PP     4..24    Sets the width of the data bus 16
//
// ----------------------------------------------------------------------------
// USABILITY FACTORS
//   Reset Strategy   : Asynchronous
//   Clock Domains    : clk_i
//   Critical Timing  : None
//   Test Features    : None
//   Asynchronous I/F : None
//   Scan Methodology : None
//   Instantiations   : N/A
//   Other            : N/A
// ----------------------------------------------------------------------------
// NOTES
// 
// The address vector "adr_i" selects among the eight locations
// present in the module.  In order to read data from a register location, the
// we_i line must be inactive (low), and the "sel_i" signal must also be
// active (high.)  Then, the unit will drive the data bus.
//
// Writing is similar - drive we_i active (high), make sel_i high, drive the
// write data onto the data bus, and provide a "posedge clk_i" to store the
// data into the selected register.
//
// The registers are composed of d-flip-flops (DFFs), clocked by clk_i.
//
// An input signal, rd_i, allows for setting the number of read only locations.
// Raising a bit of rd_i has the effect of unselecting the internal storage for
// the corresponding register, and selecting the data coming into the unit on the
// input pins of the corresponding register.
//
// The multiplexing of input data can be made constant, or kept as a signal so
// that register locations can change their behavior dynamically.
//
// The registers can be set to all ones, or else cleared to all zeros by the
// set_i and clr_i input busses.  These signals, if raised to a logic high will
// change the contents of the register on the next rising clock edge.
// (synchronous set/clear operation.)
// This feature is especially useful for single bit registers which are used
// as flags to begin an operation, and which are subsequently cleared by the
// hardware.
//
// In the case where both set and clear are active at the same time, the clear
// input is given priority.  Also, the signals for set_i and clr_i are given
// priority over any attempted write operations from the bus.
//



module reg_8_iorw_clrset (
clk_i,
rst_i,
clr_i,
set_i,
sel_i,
we_i,
adr_i,
rd_i,
dat_io,
r0_i,
r1_i,
r2_i,
r3_i,
r4_i,
r5_i,
r6_i,
r7_i,
r0_o,
r1_o,
r2_o,
r3_o,
r4_o,
r5_o,
r6_o,
r7_o
);
// Parameter declarations

parameter SIZE_R0_PP = 8;         // Determines size of register in bits.
parameter SIZE_R1_PP = 8;         // Determines size of register in bits.
parameter SIZE_R2_PP = 8;         // Determines size of register in bits.
parameter SIZE_R3_PP = 8;         // Determines size of register in bits.
parameter SIZE_R4_PP = 8;         // Determines size of register in bits.
parameter SIZE_R5_PP = 8;         // Determines size of register in bits.
parameter SIZE_R6_PP = 8;         // Determines size of register in bits.
parameter SIZE_R7_PP = 8;         // Determines size of register in bits.
parameter DATA_BUS_SIZE_PP = 16;  // Sets the width of the data bus.

// I/O declarations
input clk_i;                      // System clock input
input rst_i;                      // Reset signal
input [7:0] clr_i;                // synchronous clear inputs
input [7:0] set_i;                // synchronous set inputs
input sel_i;                      // Reg block "chip select"
input we_i;                       // write enable signal
input [2:0] adr_i;                // Register address field
input [7:0] rd_i;                 // Each bit determines whether the corresponding
                                  // register is read or read/write.

inout [DATA_BUS_SIZE_PP-1:0] dat_io;  // data bus

input  [SIZE_R0_PP-1:0] r0_i;     // Register I
input  [SIZE_R1_PP-1:0] r1_i;     // Register I
input  [SIZE_R2_PP-1:0] r2_i;     // Register I
input  [SIZE_R3_PP-1:0] r3_i;     // Register I
input  [SIZE_R4_PP-1:0] r4_i;     // Register I
input  [SIZE_R5_PP-1:0] r5_i;     // Register I
input  [SIZE_R6_PP-1:0] r6_i;     // Register I
input  [SIZE_R7_PP-1:0] r7_i;     // Register I

output [SIZE_R0_PP-1:0] r0_o;     // Register O
output [SIZE_R1_PP-1:0] r1_o;     // Register O
output [SIZE_R2_PP-1:0] r2_o;     // Register O
output [SIZE_R3_PP-1:0] r3_o;     // Register O
output [SIZE_R4_PP-1:0] r4_o;     // Register O
output [SIZE_R5_PP-1:0] r5_o;     // Register O
output [SIZE_R6_PP-1:0] r6_o;     // Register O
output [SIZE_R7_PP-1:0] r7_o;     // Register O

// Internal declarations
wire   [SIZE_R0_PP-1:0] r0_local;
wire   [SIZE_R1_PP-1:0] r1_local;
wire   [SIZE_R2_PP-1:0] r2_local;
wire   [SIZE_R3_PP-1:0] r3_local;
wire   [SIZE_R4_PP-1:0] r4_local;
wire   [SIZE_R5_PP-1:0] r5_local;
wire   [SIZE_R6_PP-1:0] r6_local;
wire   [SIZE_R7_PP-1:0] r7_local;

//---------------------------------------------------------------


reg_8_io_clrset #(
             SIZE_R0_PP,        // Size of r0
             SIZE_R1_PP,        // Size of r1
             SIZE_R2_PP,        // Size of r2
             SIZE_R3_PP,        // Size of r3
             SIZE_R4_PP,        // Size of r4
             SIZE_R5_PP,        // Size of r5
             SIZE_R6_PP,        // Size of r6
             SIZE_R7_PP,        // Size of r7
             DATA_BUS_SIZE_PP   // Size of the data bus.
             )
  reg_8_packer                  // Instance name
  (
   .clk_i(clk_i),
   .rst_i(rst_i),
   .clr_i(clr_i),
   .set_i(set_i),
   .sel_i(sel_i),
   .we_i(we_i),
   .adr_i(adr_i),
   .dat_io(dat_io),
   .r0_i(r0_local),
   .r1_i(r1_local),
   .r2_i(r2_local),
   .r3_i(r3_local),
   .r4_i(r4_local),
   .r5_i(r5_local),
   .r6_i(r6_local),
   .r7_i(r7_local),
   .r0_o(r0_o),
   .r1_o(r1_o),
   .r2_o(r2_o),
   .r3_o(r3_o),
   .r4_o(r4_o),
   .r5_o(r5_o),
   .r6_o(r6_o),
   .r7_o(r7_o)
   );

// This is the input side of the register block
assign r0_local = (rd_i[0])?r0_i:r0_o;
assign r1_local = (rd_i[1])?r1_i:r1_o;
assign r2_local = (rd_i[2])?r2_i:r2_o;
assign r3_local = (rd_i[3])?r3_i:r3_o;
assign r4_local = (rd_i[4])?r4_i:r4_o;
assign r5_local = (rd_i[5])?r5_i:r5_o;
assign r6_local = (rd_i[6])?r6_i:r6_o;
assign r7_local = (rd_i[7])?r7_i:r7_o;

endmodule
