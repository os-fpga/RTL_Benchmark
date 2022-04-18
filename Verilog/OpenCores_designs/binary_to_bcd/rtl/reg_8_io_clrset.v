// ----------------------------------------------------------------------------
// reg_8_io_clrset.v
// 
// AUTHOR         : John Clayton
// ----------------------------------------------------------------------------
// Release History
//   VERSION DATE        AUTHOR            DESCRIPTION
//   ------- ----------- ----------------- ------------------------------------
//   1.0     12/06/02    John Clayton      Initial Version
// ----------------------------------------------------------------------------
// PURPOSE: This module implements a set of eight addresses and a data bus of
//          the given width.  These addresses have write ports and read ports
//          associated with them.
//          See NOTES below for further details of operation.
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
// ----------------------------------------------------------------------------

module reg_8_io_clrset(
clk_i,
rst_i,
clr_i,
set_i,
sel_i,
we_i,
adr_i,
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

inout [DATA_BUS_SIZE_PP-1:0] dat_io;  // DSP data bus

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

reg  [SIZE_R0_PP-1:0] r0_o;     // Register O
reg  [SIZE_R1_PP-1:0] r1_o;     // Register O
reg  [SIZE_R2_PP-1:0] r2_o;     // Register O
reg  [SIZE_R3_PP-1:0] r3_o;     // Register O
reg  [SIZE_R4_PP-1:0] r4_o;     // Register O
reg  [SIZE_R5_PP-1:0] r5_o;     // Register O
reg  [SIZE_R6_PP-1:0] r6_o;     // Register O
reg  [SIZE_R7_PP-1:0] r7_o;     // Register O

// Internal declarations

reg  [7:0] read_dat;

//---------------------------------------------------------------
// Generate a select bus (1 high out of N)


// This is the writing side of the registers
always @(posedge clk_i or posedge rst_i)
  begin
    if (rst_i) begin    // Asynchronous reset
      r0_o <= 0;
      r1_o <= 0;
      r2_o <= 0;
      r3_o <= 0;
      r4_o <= 0;
      r5_o <= 0;
      r6_o <= 0;
      r7_o <= 0;
    end
    else   // clock edge
    begin
      if (we_i && sel_i)
      case (adr_i)
        0:
          if (SIZE_R0_PP >  1) r0_o <= dat_io[SIZE_R0_PP-1:0];
          else if (SIZE_R0_PP == 1) r0_o <= dat_io[0];
        1:
          if (SIZE_R1_PP > 1)  r1_o <= dat_io[SIZE_R1_PP-1:0];
          else if (SIZE_R1_PP == 1) r1_o <= dat_io[0];
        2:
          if (SIZE_R2_PP > 1)  r2_o <= dat_io[SIZE_R2_PP-1:0];
          else if (SIZE_R2_PP == 1) r2_o <= dat_io[0];
        3:
          if (SIZE_R3_PP > 1)  r3_o <= dat_io[SIZE_R3_PP-1:0];
          else if (SIZE_R3_PP == 1) r3_o <= dat_io[0];
        4:
          if (SIZE_R4_PP > 1)  r4_o <= dat_io[SIZE_R4_PP-1:0];
          else if (SIZE_R4_PP == 1) r4_o <= dat_io[0];
        5:
          if (SIZE_R5_PP > 1)  r5_o <= dat_io[SIZE_R5_PP-1:0];
          else if (SIZE_R5_PP == 1) r5_o <= dat_io[0];
        6:
          if (SIZE_R6_PP > 1)  r6_o <= dat_io[SIZE_R6_PP-1:0];
          else if (SIZE_R6_PP == 1) r6_o <= dat_io[0];
        7:
          if (SIZE_R7_PP > 1)  r7_o <= dat_io[SIZE_R7_PP-1:0];
          else if (SIZE_R7_PP == 1) r7_o <= dat_io[0];
      endcase
      
      // Priority is given to the clr_i, then set_i, then the bus (above)...
      if  (set_i[0] || clr_i[0]) r0_o <= {SIZE_R0_PP{~clr_i[0]}};
      if  (set_i[1] || clr_i[1]) r1_o <= {SIZE_R1_PP{~clr_i[1]}};
      if  (set_i[2] || clr_i[2]) r2_o <= {SIZE_R2_PP{~clr_i[2]}};
      if  (set_i[3] || clr_i[3]) r3_o <= {SIZE_R3_PP{~clr_i[3]}};
      if  (set_i[4] || clr_i[4]) r4_o <= {SIZE_R4_PP{~clr_i[4]}};
      if  (set_i[5] || clr_i[5]) r5_o <= {SIZE_R5_PP{~clr_i[5]}};
      if  (set_i[6] || clr_i[6]) r6_o <= {SIZE_R6_PP{~clr_i[6]}};
      if  (set_i[7] || clr_i[7]) r7_o <= {SIZE_R7_PP{~clr_i[7]}};
    end
  end // End of always block

always @(
            r0_i
         or r1_i
         or r2_i
         or r3_i
         or r4_i
         or r5_i
         or r6_i
         or r7_i
         or adr_i
         )
begin
  case (adr_i)
    0 : read_dat <= r0_i;
    1 : read_dat <= r1_i;
    2 : read_dat <= r2_i;
    3 : read_dat <= r3_i;
    4 : read_dat <= r4_i;
    5 : read_dat <= r5_i;
    6 : read_dat <= r6_i;
    7 : read_dat <= r7_i;
  endcase
end

assign dat_io = (~we_i && sel_i)?read_dat:{DATA_BUS_SIZE_PP{1'bz}};

endmodule
