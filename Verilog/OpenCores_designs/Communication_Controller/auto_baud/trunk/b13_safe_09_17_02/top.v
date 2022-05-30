//-----------------------------------------------------------------------------
//
// Author: John Clayton
// Date  : Aug.   20, 2002
// Update: Aug.   20, 2002 Obtained this file from "build_12" project.
// Update: Sep.   12, 2002 Tested rs232_syscon with tracking autobaud circuit
//                         inside it, so that the whole system can run at
//                         different clock speeds.  Synchronizing to high
//                         baud rates at low clock speeds doesn't work (as
//                         expected!)
//
// Description
//-----------------------------------------------------------------------------
// This targets an XC2S200 board which was created for educational purposes.
//
// There are:
//    8  LEDs (led[7:0])
//    4  switches (switch[3:0])
//    1  clock of 32.000 MHz clock, present on GCLK1
//    1  clock of 49.152 MHz clock, present on GCLK0
//    4  lines of ps2 clock input (port A in documentation notes)
//    4  lines of ps2 data input (port A in documentation notes)
//    16 lines of LCD panel control (port B in documentation notes)
//    2  lines of rs232 serial connection (port C in documentation notes)
//-----------------------------------------------------------------------------
//
// NOTE: This build is for testing out an automatic BAUD rate generator
//
// The following 'include line must be used with Synplify to create EDIF
// The line must be commented for ModelSim.
//`include "d:\synplicity\synplify_70\lib\xilinx\virtex.v"

module top (
  sys_clk_0,
  sys_clk_1,
  switch,
  led,
  lcd_drive,
  rs232_rxd,
  rs232_txd,
  port_e,
  port_f,
  dat_o
  );

// I/O declarations
input sys_clk_0;      // 49.152 MHz
input sys_clk_1;      // 32.000 MHz
input [3:0] switch;
input rs232_rxd;
input [13:0] port_f;

output [7:0] led;
output [15:0] lcd_drive;
output rs232_txd;
output [13:0] port_e;
output [15:0] dat_o;

// Internal signal declarations

wire [4:0] r0_wire;  // "Read" regs.  Used to "hold" pin locations, so that
                     // the synthesis tools do not complain about these pins
                     // being present in the constraints file and not in the
                     // design...

wire [13:0] input_f = ~port_f;  // Port f input inverted (bcd thumbwheel)

     // System Clock signals
wire sys_clk_variable;
wire sys_clk_variable_half;
wire sys_clk_lcd;
//wire sys_clk_half;
wire [8:0] sys_clk_freq;
reg  [3:0] clk_count0;  // Counter used to generate clock
reg  [3:0] clk_count1;  // Counter used to generate clock

     // Signals from risc processor
wire [15:0] risc_aux_adr;     // AUX (expansion) bus
wire        risc_aux_we;      // AUX we
wire [15:0] risc_prog_dat;    // Program data
wire [12:0] risc_prog_adr;    // (Up to 8k words possible)
wire [8:0]  risc_ram_adr;     // RAM file address
wire [7:0]  risc_ram_dat_o;   // RAM file data
wire [7:0]  risc_ram_dat_i;   // RAM file data
wire        risc_ram_we;      // RAM we
wire        risc_stb;         // Clock enable for risc processor

     // Signals from rs232_syscon
wire [15:0] adr;        // A side address
wire [7:0] dat;         // A side data
wire we;
wire stb;
wire rst;
wire master_br;

    // Address decode signals
wire       code_space;  // High for access to code space (AUX bus)
wire       rgb_space;   // High for access to rgb space (AUX bus)
wire       io_space;    // High for access to I/O space (AUX bus)
wire [2:0] io_sel;      // 1 of these is active high for I/O space accesses

    // Hardware breakpoint and single stepping signals
wire [12:0] break_prog_adr;  // For hardware breakpoint on prog. adr
wire [13:0] break_prog_dat;  // For hardware breakpoint on prog. dat
wire [ 1:0] break_enable;    // bit 1: enables dat BP, bit 0: enables adr BP
wire        breakpoint;      // 1 = any breakpoint condition encountered.
reg  [ 5:0] step_count;      // Number of steps remaining to execute
wire [ 5:0] clocks_to_step;  // Desired number of steps to execute
wire        begin_stepping;       // Automatically resets itself when written!
wire        stepping_active;      // 1 during single stepping
wire        reset_single_stepper; // 1 during breakpoint or reset
wire [ 1:0] processor_control; // Contains two signals (renamed below)
wire        run_free;          // Allows processor to run constantly
wire        forced_reset;      // Forces the processor into reset
wire        bus_rdy;           // 1 = processor can execute this clock cycle.


    // A side RAM signals
wire [7:0] code_ram_dat_o;
wire [2:0] rgb_ram_dat_o;
wire [7:0] regfile_ram_dat_o;

    // B side (Peripheral side) RAM signals
wire [2:0]  pixel_dat;
wire [13:0] pixel_adr;   // (12288 pixels addressed)

    // Other...
wire reset = switch[0];  // Simply a renaming exercise

//--------------------------------------------------------------------------
// Clock generation
//--------------------------------------------------------------------------

clock_multiply
  clock_block
  (
   .clkin(sys_clk_0),
   .reset(1'b0),
   .clk2x(),
   .clk4x(sys_clk_4x),
   .locked()
   );

// This uses up a GCLK resource.
always @(posedge sys_clk_variable)
begin: clock_block_1
  clk_count1 <= clk_count1 + 1;
end
assign sys_clk_variable_half = clk_count1[0];

//--------------------------------------------------------------------------
// Instantiations
//--------------------------------------------------------------------------

// This is for monitoring signals using a logic analyzer
assign dat_o = {
                0
//                sys_clk_lcd,
//                sys_clk_variable_half  // DDS frequency is output here.
                };

assign port_e = 0;        // Don't drive the stepper for now.

// This block generates a divided version of the fast clock
// (It is put into a separate module to facilitate adding timing
//  constraints to it...)
clock_divider #(3)
  clock_block_0
  (
   .clk_i(sys_clk_4x),
   .clk_o(sys_clk_lcd)
   );


// This block generates a variable frequency system clock
assign sys_clk_freq = input_f[7:0] + 1;
square_wave_dds #(
                  9       // DDS counter length
                  )
dds1
   (
    .clk(sys_clk_4x),
    .clk_en(switch[3]),
    .reset(reset),
    .frequency(sys_clk_freq),
    .clk_out(sys_clk_variable)
    );


// This block runs the flat panel display (5x5 pixels)
vga_128_by_92 lcd_block (
  .lcd_clk(sys_clk_lcd),
  .lcd_reset(reset),
  .pixel_dat_i(pixel_dat),
  .pixel_adr_o(pixel_adr),
  .lcd_drive(lcd_drive)
  );

// This block is the risc microcontroller
assign risc_stb = (bus_rdy || rst);
risc16f84_clk2x 
  processor1
  (
   .prog_dat_i(risc_prog_dat[13:0]),  // [13:0] ROM read data
   .prog_adr_o(risc_prog_adr),        // [12:0] ROM address
   .ram_dat_i(risc_ram_dat_i),        // [7:0] RAM read data
   .ram_dat_o(risc_ram_dat_o),        // [7:0] RAM write data
   .ram_adr_o(risc_ram_adr),          // [8:0] RAM address
   .ram_we_o(risc_ram_we),            // RAM write strobe (H active)
   .aux_adr_o(risc_aux_adr),    // [15:0] Auxiliary address bus
   .aux_dat_io(dat),            // [7:0] AUX data (shared w/rs232_syscon)
   .aux_we_o(risc_aux_we),      // Auxiliary write strobe (H active)
   .int0_i(1'b0),               // PORT-B(0) INT
   .reset_i(rst),               // Power-on reset (H active)
   .clk_en_i(risc_stb),         // Clock enable for all clocked logic
   .clk_i(sys_clk_variable_half)      // Clock input
   );


// This block is the rs232 user interface for debugging, programming etc.
rs232_syscon #(
               4,             // Number of Hex digits for addresses.
               2,             // Number of Hex digits for data.
               2,             // Number of Hex digits for quantity.
               16,            // Characters in the input buffer
               4,             // Bits in the buffer pointer
               63,            // Clocks before watchdog timer expires
               6,             // Bits in watchdog timer
               8,             // Number of data fields displayed per line
               3,             // Number of bits in the fields counter
               2              // Number of bits in the digits counter
               )
  syscon_1 (                  // instance name
  .clk_i(sys_clk_variable_half),
  .reset_i(reset),
  .master_bg_i(master_br),
  .ack_i(code_space || rgb_space || ram_space || io_space),
  .err_i(1'b0),
  .master_adr_i(risc_aux_adr),
  .master_stb_i(risc_stb),
  .master_we_i(risc_aux_we),
  .rs232_rxd_i(rs232_rxd),
  .dat_io(dat),
  .rst_o(rst),
  .master_br_o(master_br),
  .stb_o(stb),
  .cyc_o(),
  .adr_o(adr),
  .we_o(we),
  .rs232_txd_o(rs232_txd)
  );

// RAM decodes

// In this project, the address bus (adr) is 16 bits wide.  This provides
// enough address range to address the entire program space of the processor
// plus the entire screen memory of the LCD panel at 128 by 92 resolution.
// (There are only 12288 pixels!)
//
// The processor is able to access this address space indirectly, by setting
// up the address first within its aux_adr_lo and aux_adr_hi registers, then
// issuing reads/writes to the aux_dat location.
//
// In this way, the processor is able to load data into its own code space,
// by way of the dual port RAM...  Of course, the user must be careful not
// to currupt the code which is running on the processor during this process!

//   AUX Addr.   Width   Purpose
//----------------------------------------------------------
//  0000 - 01ff  8-bit   processor code space block 0.
//  0200 - 03ff  8-bit   processor code space block 1.
//  0400 - 05ff  8-bit   processor code space block 2.
//  0600 - 07ff  8-bit   processor code space block 3.
//  4000 - 4fff  3-bit   display panel pixels block 0 (4096 pixels).
//  5000 - 5fff  3-bit   display panel pixels block 1 (4096 pixels).
//  6000 - 6fff  3-bit   display panel pixels block 2 (4096 pixels).
//  ff00 - ffff  8-bit   peripheral I/O register space

assign code_space = ((adr[15:14] == 0) && stb);         // 1st 16k
assign rgb_space  = ((adr[15:14] == 1) && stb);         // 2nd 16k
assign ram_space  = ((adr[15:9] == 7'b1000000) && stb); // 512 bytes at 8000h
assign io_space   = ((adr[15:8]  == 8'hff) && stb); // last 256 bytes
assign io_sel   = (io_space)?(1 << adr[4:3]):0;

assign r0_wire = {sys_clk_1,switch};   // Holds possibly unused inputs

reg_8_pack #(
             5,               // Size of r0
             1,               // Size of r1
             8,               // Size of r2
             5,               // Size of r3
             8,               // Size of r4
             6,               // Size of r5
             2,               // Size of r6
             8,               // Size of r7
             1,               // Read only regs.
             8                // Size of the data bus.
             )
  reg_8_pack_1                // Instance name
  (
   .clk_i(sys_clk_variable_half),
   .rst_i(reset),
   .sel_i(io_sel[0]),
   .we_i(we),
   .adr_i(adr[2:0]),  // byte addressed...
   .dat_io(dat),
   .r0(r0_wire),
   .r1(),
   .r2(break_prog_adr[7:0]),
   .r3(break_prog_adr[12:8]),
   .r4(break_prog_dat[7:0]),
   .r5(break_prog_dat[13:8]),
   .r6(break_enable),
   .r7(led)
   );

reg_8_pack #(
             8,               // Size of r0
             6,               // Size of r1
             1,               // Size of r2
             1,               // Size of r3
             1,               // Size of r4
             1,               // Size of r5
             1,               // Size of r6
             1,               // Size of r7
             2,               // Read only regs.
             8                // Size of the data bus.
             )
  reg_8_pack_2                // Instance name
  (
   .clk_i(sys_clk_variable_half),
   .rst_i(reset),
   .sel_i(io_sel[2]),
   .we_i(we),
   .adr_i(adr[2:0]),  // byte addressed...
   .dat_io(dat),
   .r0(port_f[7:0]),
   .r1(port_f[13:8]),
   .r2(),
   .r3(),
   .r4(),
   .r5(),
   .r6(),
   .r7()
   );


// The following register set and logic is to control single stepping the
// processor.  Actually, stepping in groups of 2, 3, 4 or more is permitted.
// Also, a breakpoint will reset the stepping counter.
// If running free, a breakpoint will reset the "run_free" and "forced_reset"
// bits.
reg_4_pack_clrset #(
             1,               // Size of r0
             1,               // Size of r1
             6,               // Size of r2
             2,               // Size of r3
             0,               // Read only regs.
             8                // Size of the data bus.
             )
  reg_4_pack_clrset_1         // Instance name
  (
   .clk_i(sys_clk_variable_half),
   .rst_i(reset),
   .sel_i(io_sel[1]),
   .we_i(we),
   .adr_i(adr[1:0]),  // byte addressed... byte accessible only
   .clr_i({2'b0,begin_stepping,breakpoint}),
   .set_i(4'b0),
   .dat_io(dat),
   .r0(),
   .r1(begin_stepping),
   .r2(clocks_to_step),
   .r3(processor_control)
   );

assign run_free = processor_control[1];  // Not free running at power up
assign forced_reset = processor_control[0];

// This part generates the bus_rdy signal for the processor.
// This is how single stepping is implemented.  Actually, execution in
// steps of 2,3 or more instructions at a time is also allowed.
assign reset_single_stepper = reset || breakpoint;
always @(posedge sys_clk_variable_half or posedge reset_single_stepper)
begin
  if (reset_single_stepper) step_count <= 0;  // Asynchronous reset
  else
  begin // Clock edge
    if (begin_stepping) step_count <= clocks_to_step;
    else if (stepping_active) step_count <= step_count - 1;
  end
end
assign stepping_active = (step_count > 0);
assign bus_rdy = (stepping_active || run_free) && (~breakpoint);
assign breakpoint = (
             (break_enable[0] && (break_prog_adr == risc_prog_adr))
          || (break_enable[1] && (break_prog_dat == risc_prog_dat[13:0]))
                     );

//---------------------------------------------------------------------
// 2048 bytes of program RAM (2048 x 8 on A, 1024 x 16 on B)
assign dat = (code_space && ~we)?code_ram_dat_o:{8{1'bZ}};

ramb16_s8_s16
  code_space_ram
  (
   .dat_o_s8a(code_ram_dat_o),
   .dat_i_s8a(dat),
   .adr_i_s8a(adr[10:0]),
   .clk_i_s8a(sys_clk_variable),
   .rst_i_s8a(reset),
   .we_i_s8a(we & code_space),
   .dat_o_s16b(risc_prog_dat),
   .dat_i_s16b(16'b0),           // Processor only reads instruction words...
   .adr_i_s16b(risc_prog_adr[9:0]),
   .clk_i_s16b(sys_clk_variable),
   .rst_i_s16b(reset),
   .we_i_s16b(1'b0)              // Processor only reads instruction words...
   );
  


// 12k of 3-bit RAM (12288 x 3)
// Each location corresponds to one pixel on a display of 128x96 pixels.
// Each data word [2:0] is blue,green,red.
assign dat[2:0] = (rgb_space && ~we)?rgb_ram_dat_o:{3{1'bZ}};

ramb12_s3_s3
  rgb_space_ram
  (
   .dat_o_s3a(rgb_ram_dat_o),
   .dat_i_s3a(dat[2:0]),
   .adr_i_s3a(adr[13:0]),
   .clk_i_s3a(sys_clk_variable),
   .rst_i_s3a(reset),
   .we_i_s3a(we & rgb_space),
   .dat_o_s3b(pixel_dat),
   .dat_i_s3b(3'b000),           // Display only reads pixel data...
   .adr_i_s3b(pixel_adr),
   .clk_i_s3b(sys_clk_lcd),
   .rst_i_s3b(reset),
   .we_i_s3b(1'b0)               // Display only reads pixel data...
   );

// 512 bytes of register file RAM for the risc16f84 processor.
// These are memory mapped into the AUX bus on the A port of the RAM,
// to facilitate debugging (One can examine the contents of registers from
// the rs232_syscon command prompt!)
assign dat = (ram_space && ~we)?regfile_ram_dat_o:{8{1'bZ}};

RAMB4_S8_S8 
  risc16f84_regs 
  (
  .DOA(regfile_ram_dat_o),
  .DIA(dat),
  .ADDRA(adr[8:0]),
  .CLKA(sys_clk_variable),
  .ENA(ram_space),
  .RSTA(reset),
  .WEA(we),
  .DOB(risc_ram_dat_i),
  .DIB(risc_ram_dat_o),
  .ADDRB(risc_ram_adr),
  .CLKB(sys_clk_variable),
  .ENB(1'b1),
  .RSTB(reset),
  .WEB(risc_ram_we)
  );



//--------------------------------------------------------------------------
// Module code
//--------------------------------------------------------------------------


endmodule

