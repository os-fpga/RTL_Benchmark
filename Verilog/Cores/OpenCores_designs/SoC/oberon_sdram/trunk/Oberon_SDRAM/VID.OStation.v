`timescale 1ns / 1ps
// 1024x768 display controller NW/PR 24.1.2014
// OberonStation (externally-clocked) ver PR 7.8.15/03.10.15

module VID(
    input clk, pclk, inv, ce,
    input [31:0] viddata,
    output reg req,  // SRAM read request
    output hsync, vsync,  // to display
    output [5:0] RGB);

initial req = 1'b1;

localparam Org = 18'b1101_1111_1111_0000_00;  // DFF00: adr of vcnt=1023
reg [10:0] hcnt;
reg [9:0] vcnt;
reg [4:0] hword;  // from hcnt, but latched in the clk domain
reg [31:0] vidbuf, pixbuf;
reg hblank;
wire hend, vend, vblank, xfer, vid;

assign hend = (hcnt == 1343), vend = (vcnt == 801);
assign vblank = (vcnt[8] & vcnt[9]);  // (vcnt >= 768)
assign hsync = ~((hcnt >= 1080+6) & (hcnt < 1184+6));  // -ve polarity
assign vsync = (vcnt >= 771) & (vcnt < 776);  // +ve polarity
assign xfer = (hcnt[4:0] == 6);  // data delay > hcnt cycle + req cycle
assign vid = (pixbuf[0] ^ inv) & ~hblank & ~vblank;
assign RGB = {6{vid}};
//wire vidadr = Org + {3'b0, ~vcnt, hword};

always @(posedge pclk) if(ce) begin  // pixel clock domain
  hcnt <= hend ? 0 : hcnt+1;
  vcnt <= hend ? (vend ? 0 : (vcnt+1)) : vcnt;
  hblank <= xfer ? hcnt[10] : hblank;  // hcnt >= 1024
  pixbuf <= xfer ? vidbuf : {1'b0, pixbuf[31:1]};
end

always @(posedge clk) if(ce) begin  // CPU (SRAM) clock domain
  hword <= hcnt[9:5];
  req <= ~vblank & ~hcnt[10] & (hcnt[5] ^ hword[0]);  // i.e. adr changed
  vidbuf <= req ? viddata : vidbuf;
end

endmodule
