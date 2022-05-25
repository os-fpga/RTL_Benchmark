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
module spi_slave(resetn, clk, sck, mosi, miso, cs, done, rx_data);
input clk;
input resetn;

input cs;
input sck;
input mosi;
output miso;
output reg done = 0;
output reg[31:0]  rx_data = 0;

reg [4:0] bit_counter = 0;
reg [2:0] rx_done_ccd = 0;
reg [31:0] r_rx = 0;
reg rx_done = 0;

assign miso = 0;

always @(posedge clk) rx_done_ccd <= {rx_done_ccd[1:0], rx_done};

always @(posedge clk)
begin
  if (rx_done_ccd[2:1] == 2'b01) begin
    done <= 1;
    rx_data <= r_rx;
  end else
    done <= 0;
end

always @(posedge sck)
begin
  if (cs) begin
    bit_counter <= 0;
  end else begin
    r_rx <= {r_rx[30:0], mosi};
    bit_counter <= bit_counter + 1;
    rx_done <= (bit_counter == 31);
  end
end
endmodule
