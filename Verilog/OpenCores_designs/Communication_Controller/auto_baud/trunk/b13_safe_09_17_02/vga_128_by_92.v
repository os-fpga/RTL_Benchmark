//---------------------------------------------------------------------------
// VGA resolution panel driver, for 128 by 92 "5x5" pixels.
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
// Date  : Mar. 29, 2001
// Update: April 4, 2001  Copied this file from "lcd_3.v"
// Update: May   3, 2001  Re-copied from "lcd_2.v" (better logic)
//                        Stripped out extraneous stuff.
// Update: May   3, 2001  Added synchronous reset signals, also added
//                        "ball_x_enable" and "ball_y_enable" signals.
//                        Changed all occurrences of "block" in code to "ball"
// Update: Apr. 11, 2002  Copied this file from "lcd_test_pongball_crosshair.v"
//                        Removed the pongball, and added ports for pixel RAM.
// Update: Apr. 15, 2002  Removed the fixed block of color and graph lines.
//                        There is only 1 bit of intensity info for R,G,B.
// Update: May   2, 2002  Copied this file from "vga_128_by_92.v" and removed
//                        the crosshairs, since they are not needed at this
//                        type of resolution.  Adjusted V_MODULO down from
//                        540 to 512, to eliminate the vertical flicker that
//                        was evident after removing the crosshairs logic.
//
//-----------------------------------------------------------------------------
// Description:
//
// This module drives an LCD panel (from an IBM 700C Thinkpad laptop)
//
// The LCD panel requires 16 signals to be driven.
// There are four signals each for red, green and blue.
// There is one sync signal.
// There is one clock signal.
// And there are two control signals: backlight_on and backlight_bright.
//
// The clock used for the LCD is "lcd_clk" of 49.152 MHz clock, on GCLK0
//
// The 5x5 "macropixels" display according to RAM response to "pixel_adr_o"
// "macro_pixel_clk" advances the address.  Pixel address zero corresponds
// to the pixel in the upper right hand corner of the screen.  Pixels are
// numbered from left to right, top to bottom, in rows of 128 each.  There
// are 96 rows.  Each pixel is a patch of 25 VGA pixels.  This was done in
// order to conserve memory by reducing the number of pixels displayed.
//
//-----------------------------------------------------------------------------


`define H_MODULO 704            // Horizontal pixel times before H-retrace
`define V_MODULO 512            // Vertical line times before V-retrace
`define H_PIXELS 640            // Actual number of pixels horizontally
`define V_PIXELS 480            // Actual number of pixels vertically

`define COORDINATES_SIZE 10     // Size of crosshair coordinates in bits
`define CROSSHAIR_SIZE 7        // Size of crosshair "leg" in pixels
                                // (not including central pixel)

`define MACROPIXEL_SIZE 5       // Size of macropixel in terms of VGA pixels


module vga_128_by_92 (
  lcd_clk,
  lcd_reset,
  pixel_dat_i,
  pixel_adr_o,
  lcd_drive
  );
  
// I/O declarations
input  lcd_clk;                    // 49.152 MHz
input  lcd_reset;                  // synchronous reset
input  [2:0]  pixel_dat_i;         // [0] = red, [1] = green, [2] = blue
output [13:0] pixel_adr_o;         // Address for Pixel RAM.
output [15:0] lcd_drive;           // Signals used to drive LCD panel


// Internal signal declarations


// For the LCD part
reg [3:0] lcd_red;
reg [3:0] lcd_green;
reg [3:0] lcd_blue;
wire lcd_sync;
wire lcd_backlight_on = 1;
wire lcd_backlight_bright = 1;
wire v_clk;
wire h_pulse;
wire v_pulse;

// For generating images
wire macro_h_reset;      // Resets the horizontal counter
wire macro_v_reset;      // Resets the vertical counter
wire macro_pixel_clk;    // H = next macropixel at rising edge of lcd_clk
wire macro_line_clk;     // H = next macropixel line at rising edge of lcd_clk

reg [2:0] macro_h_count; // Determines when to activate macro_pixel_clk
reg [2:0] macro_v_count; // Determines when to activate macro_line_clk
reg [13:0] pixel_adr_o;  // Address for macropixel RAM
reg [9:0] v_count;       // Indicates current VGA scan line
reg [9:0] h_count;       // Indicates current VGA horizontal pixel number


//--------------------------------------------------------------------------
// Module code


//----------LCD part-----------------------------------

// This "Rubber bands" together the output signals. (concatenation).
assign lcd_drive = {lcd_backlight_bright,
                    lcd_backlight_on,
                    lcd_sync,
                    lcd_clk,
                    ~lcd_blue,             // Values are active low.
                    ~lcd_green,            // Values are active low.
                    ~lcd_red};             // Values are active low.

// Horizontal counter
always @(posedge lcd_clk or posedge lcd_reset)
begin
  if (lcd_reset) h_count <= 0;  // Asynchronous reset
  else
  begin
    if (h_count == `H_MODULO-1) h_count <=0;
    else h_count <= h_count + 1;
  end
end
assign v_clk = (h_count == `H_MODULO-1);

// Vertical counter
always @(posedge lcd_clk or posedge lcd_reset)
begin
  if (lcd_reset) v_count <=0; // Asynchronous reset
  else if (v_clk)
  begin
    if (v_count == `V_MODULO-1) v_count <= 0;
    else v_count <= v_count + 1;
  end
end

// Create horizontal sync pulses, punctuated by periods of "high"
//   which corresponds to "vertical retrace time."
assign h_pulse = h_count >= `H_PIXELS;
assign v_pulse = v_count >= `V_PIXELS;
assign lcd_sync = (h_pulse || v_pulse);


// Macropixel logic
assign macro_h_reset = h_pulse || lcd_reset;
assign macro_v_reset = v_pulse || lcd_reset;

always @(posedge lcd_clk or posedge macro_h_reset)
begin
  if (macro_h_reset) macro_h_count <= 0;  // asynchronous reset
  else
  begin  // Clock edge
    if (macro_h_count == (`MACROPIXEL_SIZE-1)) macro_h_count <= 0;
    else macro_h_count <= macro_h_count + 1;
  end
end
assign macro_pixel_clk = (macro_h_count == (`MACROPIXEL_SIZE-1));

always @(posedge lcd_clk or posedge macro_v_reset)
begin
  if (macro_v_reset) macro_v_count <= 0;  // asynchronous reset
  else
  begin // Clock edge
    if (v_clk)
    begin
      if (macro_v_count == (`MACROPIXEL_SIZE-1)) macro_v_count <= 0;
      else macro_v_count <= macro_v_count + 1;
    end
  end
end
assign macro_line_clk = ((macro_v_count == (`MACROPIXEL_SIZE-1)) && v_clk);

always @(posedge lcd_clk or posedge macro_h_reset)
begin
  if (macro_h_reset) pixel_adr_o[6:0] <= 0;  // Asynchronous reset
  else if (macro_pixel_clk) pixel_adr_o[6:0] <= pixel_adr_o[6:0] + 1;
end

always @(posedge lcd_clk or posedge macro_v_reset)
begin
  if (macro_v_reset) pixel_adr_o[13:7] <= 0; // Asynchronous reset
  else
  begin  // Clock edge
    if (macro_line_clk) pixel_adr_o[13:7] <= pixel_adr_o[13:7] + 1;
  end
end

// Color testing pattern
always @(pixel_dat_i)
begin
  // Start with pixel color as default "video plane"
  lcd_red   <= pixel_dat_i[0];
  lcd_green <= pixel_dat_i[1];
  lcd_blue  <= pixel_dat_i[2];
end


endmodule

//`undef H_MODULO
//`undef V_MODULO
//`undef H_PIXELS
//`undef V_PIXELS
