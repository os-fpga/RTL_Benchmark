//---------------------------------------------------------------------------
// 7-segment LED display driver, for multi-digit displays, common cathode or
// common anode.
//
//
// Description: See description below (which suffices for IP core
//                                     specification document.)
//
// Copyright (C) 2002 John Clayton and OPENCORES.ORG (this Verilog version)
//
// This source file may be used and distributed without restriction provided
// that this copyright statement is not removed from the file and that any
// derivative work contains the original copyright notice and the associated
// disclaimer.
//
// This source file is free software; you can redistribute it and/or modify
// it under the terms of the GNU Lesser General Public License as published
// by the Free Software Foundation;  either version 2.1 of the License, or
// (at your option) any later version.
//
// This source is distributed in the hope that it will be useful, but WITHOUT
// ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or 
// FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public
// License for more details.
//
// You should have received a copy of the GNU Lesser General Public License
// along with this source.
// If not, download it from http://www.opencores.org/lgpl.shtml
//
//-----------------------------------------------------------------------------
//
// Author: John Clayton
// Date  : Nov. 19, 2003
// Update: Nov. 19, 2003  Copied this file from "vga_crosshair.v" and modified
//                        it.
//
//-----------------------------------------------------------------------------
// Description:
//
// This module drives a multiplexed LED display (7-segment type, CC or CA)
//
// There is no data memory inside this module.  Data is displayed whenever
// it is present on the input pins, (if the digit is illuminated at all
// during its timeslot.)
//
// The module is parameterized, so the user can specify the number of digits in
// the display, as well as the polarity of the output signals used to drive the
// display.
//
// The LED display requires seven signals for the segments, and the numerical
// information is multiplexed onto these lines, and each digit gets a timeslot.
// The digits are displayed in sequence, and the corresponding "common" line is
// appropriately driven in order to light up the LEDs for each digit during its
// timeslot.
//
// This module provides polarity reversal on the segment signals so that common
// cathode or common anode displays may be used.
// The segment polarity is selected by the parameter "SEGMENT_DRIVE_PP."
// If SEGMENT_DRIVE_PP is equal to zero, then the display is assumed to be
// common anode, so that segment_o must sink current to light segments.
// If SEGMENT_DRIVE_PP is equal to one, then the display is assumed to be
// common cathode, so that segment_o must source current to light segments.
//
// The output polarity of the common_o lines can also be reversed.  This setting
// is determined by the COMMON_DRIVE_PP parameter.  If COMMON_DRIVE_PP is zero,
// then the common_o lines will cycle a low value through to illuminate the
// appropriate digit.  (1 low of N common_o outputs).
// If COMMON_DRIVE_PP is one, then the common_o lines will cycle a high value
// through to illuminate the appropriate digit. (1 high of N common_o outputs).
// The value of this parameter was intentially made independent of the value
// of SEGMENT_DRIVE_PP, in order to allow for the possible use of external
// drive transistors on the common_o lines.  Using external transistors
// may require an inversion to get the polarity correct.
//
// Each individual digit can be enabled or disabled at any time by using the
// "digit_on_i" inputs.  This allows selected digits to be "blanked" by logic,
// rendering for example a 7 digit display as two separate 3 digit displays,
// with one dark digit separating the two portions of the display.
// This feature can also be used for leading zero blanking.
//
// The data input to the module is 4-bits per digit.  Appropriate decoding is
// provided inside this module to display crude hexadecimal letters [a..f] for
// data values greater than 9.  Using BCD (binary coded decimal) at the inputs
// will simply have the effect of restricting the display to the digits [0..9].
//
// Because all of the current from the 7 segments feeds back into the common
// line, there may be a need for external "digit" transistors to sink or source
// enough current to brightly light up the segments in each digit of the
// LED display.  For example, Xilinx SpartanII FPGAs can source and sink 24mA
// on each pin (maximum selectable drive level).  If the LED display requires
// 5mA per segment LED, then displaying the digit "8" will require 35mA, which
// is well in excess of the 24mA allowed for each pin.  In this case, the
// external transistor may be needed.  The common_polarity_i lines can
// be used to set the output polarity for whatever driver logic is present.
// When all common_polarity_i bits are zero, then the common_o lines are set
// for a "1 high out of N" configuration.  Thus, for a common cathode display
// with no external transistors, set common_polarity_i to all ones.
//
// A timer inside this module determines how much time is allotted for each
// digit timeslot.  The timer advances each "clk_i" positive edge, until the
// timer reaches DIGIT_TIMEOUT_PP-1.  At that time, the timer resets itself,
// and the digit counter advances, which has the effect of illuminating the
// next digit.  The digits timeslots advance rapidly enough that the human
// eye, with its persistence of vision, cannot tell that the display is really
// only lighting up one digit at a time.  All of the digits appear to be lit!
// The full cycle of digit timeslots should repeat at least 30 times per second
// in order to fool the human eye, and 60 times per second is even better.
// Beyond 120 times per second, faster cycling probably won't make much
// difference to people.
//
// The width of the common_o bus is determined by the parameter DIGITS_PP.
//
// The digit counter within this module cycles through the digits of the
// display, lighting each one in its timeslot, then recycling back to zero
// after it reaches DUTY_CYCLE_PP-1.
// DUTY_CYCLE_PP determines the duty cycle for illuminating digits.  Obviously
// the more digits there are to illuminate, then the smaller fraction of time
// is allotted to illuminate each individual digit.
// The value of DUTY_CYCLE_PP can be set greater than the actual number of
// digits in order to reduce the duty cycle, thereby dimming the LED display.
// During the time when the digit count is greater than DIGITS_PP-1 none of
// the common_o lines will be activated, so that the entire LED display will
// remain dark until the digit counter resets to zero again.
//
// Multiplexed decimal points are supported by the "point_i" input bus.
// A one in the LSB of decimal_i lights up the least significant decimal
// point, and so forth .
//
// The user is responsible for wiring up the LED display to the correct I/O
// pins of the device, and for insuring that the current drive capability is
// correct, or that external transistors are used if needed.  Don't forget to
// use current limiting resistors on the LEDs...  It is not recommended to put
// the resistors into the common_o lines, since this causes different displayed
// numbers to appear with different intensities (due to the various amounts
// of current sent through the common line.)  Instead, put the current limiting
// resistors on the actual segment_o lines.  Since the display is multiplexed,
// each digit only lights up for a fraction of the time.  The current limiting
// resistors can be scaled down accordingly, so that the display has a good
// level of brightness.  If a 180 ohm resistor is used for an LED that is
// constantly ON, then for a four digit display, possibly a 45ohm resistor
// would do the job...
//
// Mapping of segment_o lines to actual segments on the display:
//
//        [0]
//       -----
//      |     |
//   [1]|     |[2]
//      | [3] |
//       -----
//      |     |
//   [4]|     |[5]
//      | [6] |
//       -----  o <-----  decimal point [7]
//
//
//  0   1   2   3   4   5   6   7   8   9   A   B   C   D   E   F
//  -       -   -       -   -   -   -   -   -       -       -   -  
// | |   |   |   | | | |   |     | | | | | | | |   |     | |   |    
//          -   -   -   -   -       -   -   -   -       -   -   -   
// | |   | |     |   |   | | |   | | |   | | | | | |   | | |   |   
//  -       -   -       -   -       -   -       -   -   -   -      
//
//-----------------------------------------------------------------------------


module led_display_driver (
  clk_i,
  ce_i,
  rst_i,
  data_i,
  point_i,
  digit_on_i,
  segment_o,
  common_o
  );
// Timer defaults set up for 1MHz clock
parameter DIGITS_PP        = 4;     // # of digits in LED display.
parameter DUTY_CYCLE_PP    = 8;     // # of digit timeslots
parameter SEGMENT_DRIVE_PP = 0;     // 0 = sink from segments (Common Anode)
                                    // 1 = source to segments (Common Cathode)
parameter COMMON_DRIVE_PP  = 1;     // 0 = 1 common low, others high
                                    // 1 = 1 common high, others low
parameter DIGIT_TIMEOUT_PP = 512;   // Clock cycles per digit timeslot
parameter DIGIT_TIMER_WIDTH_PP = 9; // Bit width of digit timer
parameter DIGIT_COUNT_WIDTH_PP = 3; // Bit width of digit counter

// I/O declarations
input  clk_i;                      // clock signal
input  ce_i;                       // clock enable input
input  rst_i;                      // synchronous reset
input  [4*DIGITS_PP-1:0] data_i;   // data input bus
input  [DIGITS_PP-1:0] point_i;    // Decimal point input bus
input  [DIGITS_PP-1:0] digit_on_i; // Polarity of common_o...
output [7:0] segment_o;            // (includes decimal point segment)
output [DIGITS_PP-1:0] common_o;   // One output per display digit...


// Internal signal declarations

reg [DIGIT_TIMER_WIDTH_PP-1:0] digit_timer;
reg [DIGIT_COUNT_WIDTH_PP-1:0] digit_count;

wire digit_clk_en;
wire [3:0] hex_digit;
reg  [6:0] number_segments;
wire decimal_point;

//--------------------------------------------------------------------------
// Module code


//----------MUX part-----------------------------------

assign hex_digit = data_i >> {digit_count,2'b0};
assign decimal_point = point_i >> digit_count;


// Digit timer
always @(posedge clk_i)
begin
  if (rst_i) digit_timer <= 0;  // Synchronous reset
  else if (ce_i)
  begin
    if (digit_timer == DIGIT_TIMEOUT_PP-1) digit_timer <=0;
    else digit_timer <= digit_timer + 1;
  end
end
assign digit_clk_en = (digit_timer == DIGIT_TIMEOUT_PP-1) && ce_i;

// Digit counter
always @(posedge clk_i)
begin
  if (rst_i) digit_count <=0;  // Synchronous reset
  else if (digit_clk_en)
  begin
    if (digit_count == DUTY_CYCLE_PP-1) digit_count <= 0;
    else digit_count <= digit_count + 1;
  end
end

// Create common_o outputs
// One high... then selectively invert.
assign common_o = (COMMON_DRIVE_PP==1'b1)?
                     ((1'b1 << digit_count) & digit_on_i):
                    ~((1'b1 << digit_count) & digit_on_i);

// Create segment outputs
always @(hex_digit)
begin
  case(hex_digit)
    4'h0 : number_segments <= 7'b1110111;
    4'h1 : number_segments <= 7'b0100100;
    4'h2 : number_segments <= 7'b1011101;
    4'h3 : number_segments <= 7'b1101101;
    4'h4 : number_segments <= 7'b0101110;
    4'h5 : number_segments <= 7'b1101011;
    4'h6 : number_segments <= 7'b1111011;
    4'h7 : number_segments <= 7'b0100101;
    4'h8 : number_segments <= 7'b1111111;
    4'h9 : number_segments <= 7'b1101111;
    4'hA : number_segments <= 7'b0111111;
    4'hB : number_segments <= 7'b1111010;
    4'hC : number_segments <= 7'b1010011;
    4'hD : number_segments <= 7'b1111100;
    4'hE : number_segments <= 7'b1011011;
    4'hF : number_segments <= 7'b0011011;
  endcase
end

// Assign final polarity adjusted segment outputs
assign segment_o = (SEGMENT_DRIVE_PP==1'b1)? {decimal_point,number_segments}:
                                            ~{decimal_point,number_segments};

endmodule

