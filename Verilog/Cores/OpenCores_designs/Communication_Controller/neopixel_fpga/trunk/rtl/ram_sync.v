/*
 *  FpgaNeoPixel - A spi to ws2812 machine
 *
 *  Copyright (C) 2020  Hirosh Dabui <hirosh@dabui.de>
 *
 *  Permission to use, copy, modify, and/or distribute this software for any
 *  purpose with or without fee is hereby granted, provided that the above
 *  copyright notice and this permission notice appear in all copies.
 *
 *  THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 *  WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 *  MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 *  ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 *  WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 *  ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 *  OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 *
 */
module ram_sync(clk, addr, din, dout, we);
parameter ADDRESS_LINES = 1024;
parameter DATA_WIDTH = 24;

input clk;
input [$clog2(ADDRESS_LINES)-1:0] addr;
input [DATA_WIDTH-1:0] din;
output reg[DATA_WIDTH-1:0] dout;

input we;

reg [DATA_WIDTH-1:0] mem [(ADDRESS_LINES)-1:0];

always @(posedge clk) begin
  if (we)
    mem[addr] <= din;

  dout <= mem[addr];
end

endmodule

