//-----------------------------------------------------------------------------
//
// Author: John Clayton
// Date  : Aug.   18, 2003
// Update: Aug.   18, 2003 Obtained this file from "build_16" project.
//                         Removed extraneous code.
// Update: Nov.   24, 2003 Added "binary_to_bcd" instantiation and tested it.
// Update: Nov.   25, 2003 Added "bcd_to_binary" instantiation and tested it.
//                         Modified the register structure to provide for
//                         different test modes, including digit blanking
//                         which adjusts to displaying BCD digits or hex.
//                         Removed VGA LCD panel display driver and clock DLL
//                         circuitry preparatory to publishing this work.
//
// Description
//-----------------------------------------------------------------------------
// This targets an XC2S200E board which was created for educational purposes.
//
// There are:
//    8  LEDs (led[7:0])
//    4  switches (switch[3:0])
//    1  clock, present on GCLK1
//    1  clock, present on GCLK0
//    Many different I/O lines.  See PNDKR-1E reference manual for more details
//-----------------------------------------------------------------------------
//
// NOTE: This build is for developing a "binary-to-BCD" converter for use in
//       displaying numerals in base-10 so that people can read and interpret the
//       numbers more readily than they could if the numbers were displayed in
//       binary or hexadecimal format.  Also, a "BCD-to-binary" converter is
//       tested in this build.
//
// The following 'include line must be used with Synplify to create EDIF
// The line must be commented for ModelSim.
//`include "d:\synplicity\synplify_70\lib\xilinx\virtex.v"


`define SLOW_CE_TIMEOUT     12000    // 250us clock enable, based on 48MHz clock

module top (
  clk_0,
  clk_1,           // Unused
  switch,
  led,
  extra,           // extra pads
  A,
  rs232_0_o,       // rs232 is "B" port
  rs232_0_i,       // COM0 is serial debugger...
  rs232_1_o,       // COM1 is simple loopback
  rs232_1_i,
  C,               // LCD panel driver port, unused here
  D,               // Huge 48 bit IO port, unused here
  E,               // 18 bit IO port, used for some debugging
  F                // 18 bit IO port, used to drive LED display
  );

// I/O declarations
input clk_0;      // 48 MHz
input clk_1;
input [3:0] switch;
input rs232_0_i;
input rs232_1_i;
input [7:0] A;

output [12:0] extra;
output [7:0] led;
output [15:0] C;
output [47:0] D;
output [17:0] E;
output [17:0] F;
output rs232_0_o;
output rs232_1_o;

// Internal signal declarations

wire [4:0] r0_wire;  // "Read" regs.  Used to "hold" pin locations, so that
                     // the synthesis tools do not complain about these pins
                     // being present in the constraints file and not in the
                     // design...

     // System Clock signals
reg  [13:0] slow_ce_timer; // counter used to generate slow clock enables
wire slow_ce;              // a slow clock enable pulse

     // Signals from rs232_syscon
wire [15:0] adr;        // A side address
wire [7:0] dat;         // A side data
wire we;
wire stb;
wire rst;
wire master_br;

    // Address decode signals
wire       io_space;    // High for access to I/O space (AUX bus)
wire [3:0] io_sel;      // 1 of these is active high for I/O space accesses

    // LED display signals
wire [27:0] led_data;     // one nibble per digit
wire [7:0]  led_segments; // decimal point to be ignored...
wire [6:0]  led_commons;  // one per digit
wire [3:0]  led_bars;     // one cathode per display bar
wire [6:0]  led_digit_on; // used for digit blanking
wire [6:0]  led_digit_force_on; // used for digit blanking

    // Binary-BCD conversion signals
wire [15:0] binary_source; // Register data used to test conversions
wire start_slow_bcd;       // Start signal that lasts for many clocks
wire start_fast_bcd;       // Start signal that lasts for one clock
wire start_pulse_bcd;      // The final selected start signal
wire done_bcd;
wire start_slow_bin;       // Start signal that lasts for many clocks
wire start_fast_bin;       // Start signal that lasts for one clock
wire start_pulse_bin;      // The final selected start signal
wire done_bin;
wire [23:0] bcd_data;      // 6 digits of BCD data
wire [15:0] bin_data;      // 4 digits of binary data
wire start_fast_reset;     // Reset used to clear registers after 1 clock
wire [2:0] convert_mode;   // [0] bypasses second converter.
                           // [1] is "autorun" for first converter
                           // [2] is "autorun" for second converter

    // Other...
wire reset = switch[0];  // Simply a renaming exercise

wire [7:0]  a_led;       // For displaying data on LEDs
wire [7:0]  reg_led;     // For displaying register on LEDs

// For debugging
wire [5:0] debug;

//--------------------------------------------------------------------------
// Clock generation
//--------------------------------------------------------------------------

// Generate a 250us clock enable signal for use by the LED display
always @(posedge clk_0)
begin
  if (reset || slow_ce) slow_ce_timer <= 0;
  else slow_ce_timer <= slow_ce_timer + 1;
end
assign slow_ce = (slow_ce_timer == `SLOW_CE_TIMEOUT);

//--------------------------------------------------------------------------
// Module instantiations and code
//--------------------------------------------------------------------------

// Assign values to ports
assign rs232_1_o = rs232_1_i;  // RS232 loopback on COM1
assign extra = 13'hzzzz;
assign C = 16'hzzzz;
assign D = 48'hzzzzzzzzzzzz;
assign E = {18'hzzzzz,debug};  // Lazily concatenate debug signals to lsbs
                               // of port E.  Whatever the size of the debug
                               // signals, they just "shove over" the extra
                               // "z" signals, and the synthesizer drops
                               // the extra ones anyway.

// Here are the debug signals
assign debug = {start_fast_bin,start_slow_bin,done_bin};


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
  .clk_i(clk_0),
  .reset_i(reset),
  .master_bg_i(master_br),
  .ack_i(io_space),
  .err_i(1'b0),
  .master_adr_i(),
  .master_stb_i(),
  .master_we_i(),
  .rs232_rxd_i(rs232_0_i),
  .dat_io(dat),
  .rst_o(rst),
  .master_br_o(master_br),
  .stb_o(stb),
  .cyc_o(),
  .adr_o(adr),
  .we_o(we),
  .rs232_txd_o(rs232_0_o)
  );

assign io_space   = ((adr[15:8]  == 8'hff) && stb); // last 256 bytes
assign io_sel   = (io_space)?(1 << adr[4:3]):0;

// Some signals are included in this XOR so that the optimizer will not
// erroneously optimize logic away "because no outputs are connected."
// Basically, I want the switch inputs to be used no matter what.
assign a_led = (switch==4'b0100)?8'haa:debug;
assign led = ~(reg_led ^ a_led);  // LEDS are active low, so invert

reg_8_iorw_clrset #(
             8,                        // Size of r0
             8,                        // Size of r1
             8,                        // Size of r2
             1,                        // Size of r3
             1,                        // Size of r4
             8,                        // Size of r5
             7,                        // Size of r6
             8,                        // Size of r7
             8                         // Size of the data bus.
             )
  reg_8_block1                // Instance name
  (
   .clk_i(clk_0),
   .rst_i(reset),
   .clr_i(8'b00000000),
   .set_i(8'b00000000),
   .sel_i(io_sel[0]),
   .we_i(we),
   .rd_i(8'b00000111),        // Determines direction of ports
   .adr_i(adr[2:0]),
   .dat_io(dat),
   .r0_i(8'h55),
   .r1_i(8'haa),
   .r2_i(A),
   .r3_o(),
   .r4_o(),
   .r5_o({led_bars,led_data[27:24]}),
   .r6_o(led_digit_force_on),
   .r7_o(reg_led)
   );

reg_8_iorw_clrset #(
             3,                        // Size of r0
             2,                        // Size of r1
             8,                        // Size of r2
             2,                        // Size of r3
             2,                        // Size of r4
             2,                        // Size of r5
             8,                        // Size of r6
             8,                        // Size of r7
             8                         // Size of the data bus.
             )
  reg_8_block2                // Instance name
  (
   .clk_i(clk_0),
   .rst_i(reset),
   .clr_i({4'b0000,start_fast_reset,3'b000}),
   .set_i(8'b00000000),
   .sel_i(io_sel[1]),
   .we_i(we),
   .rd_i(8'b00000000),        // Determines direction of ports
   .adr_i(adr[2:0]),
   .dat_io(dat),
   .r0_o(convert_mode),
   .r1_o({start_slow_bin,start_slow_bcd}),
   .r2_o(),
   .r3_o({start_fast_bin,start_fast_bcd}),
   .r4_o(),
   .r5_o(),
   .r6_o(binary_source[15:8]),
   .r7_o(binary_source[7:0])
   );
assign start_fast_reset = start_fast_bin || start_fast_bcd;


assign start_pulse_bcd = convert_mode[1]?done_bcd:start_fast_bcd;
binary_to_bcd #(
     16,            // Binary input bits
     6,             // BCD output digits
     4              // Width of bit counter
     )
  binary_to_bcd_1
  (
   .clk_i(clk_0),
   .ce_i(1'b1),
   .rst_i(rst),
   .start_i(start_pulse_bcd || start_slow_bcd),
   .dat_binary_i(binary_source),
   .dat_bcd_o(bcd_data),
   .done_o(done_bcd)
  );


assign start_pulse_bin = convert_mode[2]?done_bin:start_fast_bin;
bcd_to_binary #(
     6,             // Digits of BCD input
     16,            // Binary output bits
     4              // Width of bit counter
     )
  bcd_to_binary_1
  (
   .clk_i(clk_0),
   .ce_i(1'b1),
   .rst_i(rst),
   .start_i(start_pulse_bin || start_slow_bin),
   .dat_bcd_i(bcd_data),
   .dat_binary_o(bin_data),
   .done_o(done_bin)
  );

// The LED data is either the BCD data or the binary data, depending upon
// the state of convert_mode[0]...
// Also, the digits are blanked appropriately depending upon the mode.
// BCD mode displays 5 digits, while binary displays only 4 digits.
// Truly, only 5 BCD digits are needed to represent "65535" which is the
// largest 16-bit binary number.  However, in order to test the behaviour
// of these modules with extra BCD digits, a sixth digit is actually present.
// It can be forced to display by setting the register for "led_digit_force_on"
// When it does display, it will always be zero, since it is an "extra" digit,
// and it is not really needed during the conversions.

assign led_data[23:0] = convert_mode[0]?bcd_data:{8'h00,bin_data};
assign led_digit_on = led_digit_force_on | (convert_mode[0]?7'b0011111:7'b0001111);
led_display_driver #(
      7,               // Digits in LED display
      8,               // Duty cycle
      1,               // Common cathode, segment high=on...
      0,               // Common cathode, no external drive transistors
      3,               // timer runs for this # clock enables per digit
      2,               // width of digit timer
      3                // width of digit counter
      )
  led_muxer_1
  (
   .clk_i(clk_0),
   .ce_i(slow_ce),
   .rst_i(reset),
   .data_i(led_data),
   .point_i(7'b0000000),
   .digit_on_i(led_digit_on),
   .segment_o(led_segments),
   .common_o(led_commons)
   );

// Assign output for LED display
assign F = {led_bars,led_commons,led_segments[6:0]};



endmodule

