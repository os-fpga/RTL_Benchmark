//-----------------------------------------------------------------------------
//
// Author: John Clayton
// Update: June   5, 2001 Typed this file in from the Xilinx file "rec019.html"
//
// Description
//-----------------------------------------------------------------------------
// This module uses the Virtex "DLL" structure to generate a 2x and 4x clock.
//
//-----------------------------------------------------------------------------

module clock_multiply (
                       clkin,
                       reset,
                       clk2x,
                       clk4x,
                       locked
                       );
                     
input  clkin;
input  reset;
output clk2x;
output clk4x;
output locked;

wire clkin_w;
wire reset_w;
wire clk2x_dll;
wire clk4x_dll;
wire locked2x;
wire locked2x_delay;
wire reset4x;
wire logic1;

assign logic1 = 1'b1;

IBUFG clkpad (
              .I(clkin),
              .O(clkin_w)
              );

IBUF  rstpad (
              .I(reset),
              .O(reset_w)
              );

CLKDLL dll2x (
              .CLKIN(clkin_w),
              .CLKFB(clk2x),
              .RST(reset_w),
              .CLK0(),
              .CLK90(),
              .CLK180(),
              .CLK270(),
              .CLK2X(clk2x_dll),
              .CLKDV(),
              .LOCKED(locked2x)
              );

BUFG  clk2xg (
              .I(clk2x_dll),
              .O(clk2x)
              );

SRL16 rstsrl (
              .D(locked2x),
              .CLK(clk2x),
              .Q(locked2x_delay),
              .A3(logic1),
              .A2(logic1),
              .A1(logic1),
              .A0(logic1)
              );

assign reset4x = !locked2x_delay;

CLKDLL dll4x (
              .CLKIN(clk2x),
              .CLKFB(clk4x),
              .RST(reset4x),
              .CLK0(),
              .CLK90(),
              .CLK180(),
              .CLK270(),
              .CLK2X(clk4x_dll),
              .CLKDV(),
              .LOCKED(locked_dll)
              );

BUFG  clk4xg (
              .I(clk4x_dll),
              .O(clk4x)
              );

OBUF  lckpad (
              .I(locked_dll),
              .O(locked)
              );

endmodule
