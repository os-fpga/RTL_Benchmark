// ----------------------------------------------------------------------------
// reg_4_pack_clrset.v
// 
// AUTHOR         : John Clayton
// ----------------------------------------------------------------------------
// Release History
//   VERSION DATE        AUTHOR            DESCRIPTION
//   ------- ----------- ----------------- ------------------------------------
//   1.0     08/27/01    John Clayton      Created this file from 
//                                         "reg_4_pack.v"
//   1.1     04/16/02    John Clayton      Made reset asynchronous
// ----------------------------------------------------------------------------
// PURPOSE: This module implements a set of four addresses and a data bus of
//          the given width.  These addresses can be either R/W 
//          (full registers) or they can be Read-Only (no storage provided).
//          See NOTES below for further details of operation.
// ----------------------------------------------------------------------------
// Parameters
//   NAME                 RANGE    DESCRIPTION                DEFAULT
//   -------------------- -------- -------------------------- -----------------
//   SIZE_R0_PP           1..16    Number of bits in register   8
//   SIZE_R1_PP           1..16    Number of bits in register   8
//   SIZE_R2_PP           1..16    Number of bits in register   8
//   SIZE_R3_PP           1..16    Number of bits in register   8
//   READ_ONLY_REGS_PP    0..3     Number of regs which are read only    0
//   DATA_BUS_SIZE_PP     4..??    Sets the width of the data bus 16
//
// ----------------------------------------------------------------------------
// USABILITY FACTORS
//   Reset Strategy   : active high, synchronous to rising edge of clk_i
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
// The reg_4_pack_clrset address vector "adr_i" selects among four locations
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
// There is a preset/clear function added into this module, controlled by
// the "pre" and "clr" input vectors.  A "1" in the corresponding bit
// position has the effect of presetting or clearing the associated register.
// The order of priority is as follows:  rst, clr, set, then normal read
// and write operations.  The clr and set operations are synchronous.  They
// occur at the rising clock edge.
//
// A parameter allows setting the number of "read-only" locations.
// The convention for this parameter is the following:  The lower numbered N 
// registers become read-only locations, and the upper (4-N) registers remain 
// as R/W (storage registers,) for a setting of READ_ONLY_REGS_PP = N.
// Thus, for N=2, then r0 and r1 are "read-only" locations (no actual 
// registers are synthesized,) but r2 and r3 remain as read/write registers.
//
// -FHDR-----------------------------------------------------------------------

//`resetall
//`timescale 1ns/100ps

module reg_4_pack_clrset(
clk_i,
rst_i,
sel_i,
we_i,
adr_i,
clr_i,
set_i,
dat_io,
r0,
r1,
r2,
r3
);
// Parameter declarations

parameter SIZE_R0_PP = 8;         // Determines size of register in bits.
parameter SIZE_R1_PP = 8;         // Determines size of register in bits.
parameter SIZE_R2_PP = 8;         // Determines size of register in bits.
parameter SIZE_R3_PP = 8;         // Determines size of register in bits.
parameter READ_ONLY_REGS_PP = 0;  // Determines how many regs are read only.
parameter DATA_BUS_SIZE_PP = 16;  // Sets the width of the data bus.

// I/O declarations
input clk_i;                      // System clock input
input rst_i;                      // Reset signal
input sel_i;                      // Reg block "chip select"
input we_i;                       // write enable signal
input [1:0] adr_i;                // Register address field
input [3:0] clr_i;                // Each bit clears one register
input [3:0] set_i;                // Each bit sets one register

inout [DATA_BUS_SIZE_PP-1:0] dat_io;  // DSP data bus

inout [SIZE_R0_PP-1:0] r0;        // Register I/O
inout [SIZE_R1_PP-1:0] r1;        // Register I/O
inout [SIZE_R2_PP-1:0] r2;        // Register I/O
inout [SIZE_R3_PP-1:0] r3;        // Register I/O


// Internal declarations

// Local signals to hold register values
reg [SIZE_R0_PP-1:0] r0_local;
reg [SIZE_R1_PP-1:0] r1_local;
reg [SIZE_R2_PP-1:0] r2_local;
reg [SIZE_R3_PP-1:0] r3_local;

reg [DATA_BUS_SIZE_PP-1:0] data_out;


//---------------------------------------------------------------
// This is the writing side of the registers
always @(posedge clk_i or posedge rst_i)
begin
  if (rst_i)       // Asynchronous reset
  begin
    r0_local <= 0;
    r1_local <= 0;
    r2_local <= 0;
    r3_local <= 0;
  end
  else
  begin            // Clock edge
    if (we_i && sel_i)
      case (adr_i)
        2'b00 :
          if (SIZE_R0_PP > 1) r0_local <= dat_io[SIZE_R0_PP-1:0];
          else if (SIZE_R0_PP == 1) r0_local <= dat_io[0];
        2'b01 :
          if (SIZE_R1_PP > 1) r1_local <= dat_io[SIZE_R1_PP-1:0];
          else if (SIZE_R1_PP == 1) r1_local <= dat_io[0];
        2'b10 :
          if (SIZE_R2_PP > 1) r2_local <= dat_io[SIZE_R2_PP-1:0];
          else if (SIZE_R2_PP == 1) r2_local <= dat_io[0];
        2'b11 :
          if (SIZE_R3_PP > 1) r3_local <= dat_io[SIZE_R3_PP-1:0];
          else if (SIZE_R3_PP == 1) r3_local <= dat_io[0];
      endcase
    if (set_i[0] | clr_i[0]) r0_local <= {SIZE_R0_PP{set_i[0]}};
    if (set_i[1] | clr_i[1]) r1_local <= {SIZE_R0_PP{set_i[1]}};
    if (set_i[2] | clr_i[2]) r2_local <= {SIZE_R0_PP{set_i[2]}};
    if (set_i[3] | clr_i[3]) r3_local <= {SIZE_R0_PP{set_i[3]}};
  end

end // End of always block

// This is the reading side of the registers

always @(
         adr_i
         or r0_local
         or r1_local
         or r2_local
         or r3_local
         or r0
         or r1
         or r2
         or r3
        )
  begin
    case (adr_i)
    2'b00 : 
      data_out <= (READ_ONLY_REGS_PP > 0)?r0:r0_local;
    2'b01 : 
      data_out <= (READ_ONLY_REGS_PP > 1)?r1:r1_local;
    2'b10 : 
      data_out <= (READ_ONLY_REGS_PP > 2)?r2:r2_local;
    2'b11 : 
      data_out <= (READ_ONLY_REGS_PP > 3)?r3:r3_local;
    endcase
  end // End of always block


assign dat_io = (~we_i && sel_i)?data_out:{DATA_BUS_SIZE_PP{1'bz}};

assign r0 = (READ_ONLY_REGS_PP <= 0)?r0_local:{SIZE_R0_PP{1'bz}};
assign r1 = (READ_ONLY_REGS_PP <= 1)?r1_local:{SIZE_R1_PP{1'bz}};
assign r2 = (READ_ONLY_REGS_PP <= 2)?r2_local:{SIZE_R2_PP{1'bz}};
assign r3 = (READ_ONLY_REGS_PP <= 3)?r3_local:{SIZE_R3_PP{1'bz}};

endmodule
