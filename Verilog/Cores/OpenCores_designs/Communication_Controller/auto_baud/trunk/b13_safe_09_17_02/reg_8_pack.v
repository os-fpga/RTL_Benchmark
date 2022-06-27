// ----------------------------------------------------------------------------
// reg_8_pack.v
// 
// AUTHOR         : John Clayton
// ----------------------------------------------------------------------------
// Release History
//   VERSION DATE        AUTHOR            DESCRIPTION
//   ------- ----------- ----------------- ------------------------------------
//   1.0     01/15/01    John Clayton      Initial Version
//                                         Designed according to 3GPP specs
//                                         3G TS 25.211-25.215 V3.2.0 (2000-03)
//   1.1     01/18/01    John Clayton      Removed sys_clk
//   1.11    03/28/01    John Clayton      Incorporated code review changes
//   1.12    08/06/01    John Clayton      Replaced "rblock_sel" vector with
//                                         a single select line "sel_i"
//                                         Removed CHANNEL_NUM_PP and
//                                         MAX_CHANNELS_PP.
//                                         Replaced rd and wr with single we_i.
//   1.13    04/16/01    John Clayton      Made reset asynchronous.
// ----------------------------------------------------------------------------
// PURPOSE: This module implements a set of eight addresses and a data bus of
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
//   SIZE_R4_PP           1..16    Number of bits in register   8
//   SIZE_R5_PP           1..16    Number of bits in register   8
//   SIZE_R6_PP           1..16    Number of bits in register   8
//   SIZE_R7_PP           1..16    Number of bits in register   8
//   READ_ONLY_REGS_PP    0..7     Number of regs which are read only    0
//   DATA_BUS_SIZE_PP     4..24    Sets the width of the data bus 16
//
// ----------------------------------------------------------------------------
// USABILITY FACTORS
//   Reset Strategy   : None.  Program the registers to obtain a known value.
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
// The reg_8_pack address vector "adr_i" selects among the eight locations
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
// A parameter allows setting the number of "read-only" locations.
// The convention for this parameter is the following:  The lower numbered N 
// registers become read-only locations, and the upper (8-N) registers remain 
// as R/W (storage registers,) for a setting of READ_ONLY_REGS_PP = N.
// Thus, for N=4, then r0,r1,r2 and r3 are "read-only" locations (no actual 
// registers are synthesized,) but r4, r5, r6 and r7 remain as registers.
//
// -FHDR-----------------------------------------------------------------------

module reg_8_pack(
clk_i,
rst_i,
sel_i,
we_i,
adr_i,
dat_io,
r0,
r1,
r2,
r3,
r4,
r5,
r6,
r7
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
parameter READ_ONLY_REGS_PP = 0;  // Determines how many regs are read only.
parameter DATA_BUS_SIZE_PP = 16;  // Sets the width of the data bus.

// I/O declarations
input clk_i;                      // System clock input
input rst_i;                      // Reset signal
input sel_i;                      // Reg block "chip select"
input we_i;                       // write enable signal
input [2:0] adr_i;                // Register address field

inout [DATA_BUS_SIZE_PP-1:0] dat_io;  // DSP data bus

inout [SIZE_R0_PP-1:0] r0;        // Register I/O
inout [SIZE_R1_PP-1:0] r1;        // Register I/O
inout [SIZE_R2_PP-1:0] r2;        // Register I/O
inout [SIZE_R3_PP-1:0] r3;        // Register I/O
inout [SIZE_R4_PP-1:0] r4;        // Register I/O
inout [SIZE_R5_PP-1:0] r5;        // Register I/O
inout [SIZE_R6_PP-1:0] r6;        // Register I/O
inout [SIZE_R7_PP-1:0] r7;        // Register I/O


// Internal declarations

// Local signals to hold register values
reg [SIZE_R0_PP-1:0] r0_local;
reg [SIZE_R1_PP-1:0] r1_local;
reg [SIZE_R2_PP-1:0] r2_local;
reg [SIZE_R3_PP-1:0] r3_local;
reg [SIZE_R4_PP-1:0] r4_local;
reg [SIZE_R5_PP-1:0] r5_local;
reg [SIZE_R6_PP-1:0] r6_local;
reg [SIZE_R7_PP-1:0] r7_local;

reg [DATA_BUS_SIZE_PP-1:0] data_out;


//---------------------------------------------------------------
// This is the writing side of the registers
always @(posedge clk_i or posedge rst_i)
  begin
    if (rst_i) begin    // Asynchronous reset
      r0_local <= 0;
      r1_local <= 0;
      r2_local <= 0;
      r3_local <= 0;
      r4_local <= 0;
      r5_local <= 0;
      r6_local <= 0;
      r7_local <= 0;
    end
    else if (we_i && sel_i)
      case (adr_i)
        3'b000 :
          if (SIZE_R0_PP > 1)
            r0_local <= dat_io[SIZE_R0_PP-1:0];
          else if (SIZE_R0_PP == 1)
            r0_local <= dat_io[0];
        3'b001 :
          if (SIZE_R1_PP > 1)
            r1_local <= dat_io[SIZE_R1_PP-1:0];
          else if (SIZE_R1_PP == 1)
            r1_local <= dat_io[0];
        3'b010 :
          if (SIZE_R2_PP > 1)
            r2_local <= dat_io[SIZE_R2_PP-1:0];
          else if (SIZE_R2_PP == 1)
            r2_local <= dat_io[0];
        3'b011 :
          if (SIZE_R3_PP > 1)
            r3_local <= dat_io[SIZE_R3_PP-1:0];
          else if (SIZE_R3_PP == 1)
            r3_local <= dat_io[0];
        3'b100 :
          if (SIZE_R4_PP > 1)
            r4_local <= dat_io[SIZE_R4_PP-1:0];
          else if (SIZE_R4_PP == 1)
            r4_local <= dat_io[0];
        3'b101 :
          if (SIZE_R5_PP > 1)
            r5_local <= dat_io[SIZE_R5_PP-1:0];
          else if (SIZE_R5_PP == 1)
            r5_local <= dat_io[0];
        3'b110 :
          if (SIZE_R6_PP > 1)
            r6_local <= dat_io[SIZE_R6_PP-1:0];
          else if (SIZE_R6_PP == 1)
            r6_local <= dat_io[0];
        3'b111 :
          if (SIZE_R7_PP > 1)
            r7_local <= dat_io[SIZE_R7_PP-1:0];
          else if (SIZE_R7_PP == 1)
            r7_local <= dat_io[0];
      endcase
  end // End of always block

// This is the reading side of the registers

always @(
         adr_i
         or r0_local
         or r1_local
         or r2_local
         or r3_local
         or r4_local
         or r5_local
         or r6_local
         or r7_local
         or r0
         or r1
         or r2
         or r3
         or r4
         or r5
         or r6
         or r7
        )
  begin
    case (adr_i)
    3'b000 : 
      data_out <= (READ_ONLY_REGS_PP > 0)?r0:r0_local;
    3'b001 : 
      data_out <= (READ_ONLY_REGS_PP > 1)?r1:r1_local;
    3'b010 : 
      data_out <= (READ_ONLY_REGS_PP > 2)?r2:r2_local;
    3'b011 : 
      data_out <= (READ_ONLY_REGS_PP > 3)?r3:r3_local;
    3'b100 : 
      data_out <= (READ_ONLY_REGS_PP > 4)?r4:r4_local;
    3'b101 : 
      data_out <= (READ_ONLY_REGS_PP > 5)?r5:r5_local;
    3'b110 : 
      data_out <= (READ_ONLY_REGS_PP > 6)?r6:r6_local;
    3'b111 : 
      data_out <= (READ_ONLY_REGS_PP > 7)?r7:r7_local;
    endcase
  end // End of always block


assign dat_io = (~we_i && sel_i)?data_out:{DATA_BUS_SIZE_PP{1'bz}};

assign r0 = (READ_ONLY_REGS_PP <= 0)?r0_local:{SIZE_R0_PP{1'bz}};
assign r1 = (READ_ONLY_REGS_PP <= 1)?r1_local:{SIZE_R1_PP{1'bz}};
assign r2 = (READ_ONLY_REGS_PP <= 2)?r2_local:{SIZE_R2_PP{1'bz}};
assign r3 = (READ_ONLY_REGS_PP <= 3)?r3_local:{SIZE_R3_PP{1'bz}};
assign r4 = (READ_ONLY_REGS_PP <= 4)?r4_local:{SIZE_R4_PP{1'bz}};
assign r5 = (READ_ONLY_REGS_PP <= 5)?r5_local:{SIZE_R5_PP{1'bz}};
assign r6 = (READ_ONLY_REGS_PP <= 6)?r6_local:{SIZE_R6_PP{1'bz}};
assign r7 = (READ_ONLY_REGS_PP <= 7)?r7_local:{SIZE_R7_PP{1'bz}};

endmodule
