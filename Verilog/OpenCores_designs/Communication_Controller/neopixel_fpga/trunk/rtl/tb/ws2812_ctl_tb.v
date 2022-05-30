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
`include "ws2812_sequence.v"
module testbench;
localparam CLK_HZ = 12_000_000;
reg clk;
reg resetn;
wire dout;

reg cs;
reg sck;
reg mosi;
wire miso;
wire ready;


reg [4095:0] vcdfile;
always #5 clk = (clk === 1'b0);

always #40 sck = (sck === 1'b0);

ws2812_ctl uut(      
                .clk(clk),
                .resetn(reset),
                .dout(dout),
                .sck(sck),
                .mosi(mosi),
                .miso(miso),
                .cs(cs),
                .ready(ready),
                   );

	initial begin
		if ($value$plusargs("vcd=%s", vcdfile)) begin
			$dumpfile(vcdfile);
			$dumpvars(0, testbench);
		end
	end

  integer i = 0;
  integer j = 0;
  reg [31:0] data = 0;
  initial begin
    cs = 1;
    sck = 1;
    resetn = 0;
    #200 resetn = 1;
    repeat(5)@(posedge sck);

    for (i = 0; i < 10; i = i + 1)
    begin
/*
      cs = 0;
      data = 32'hdeadbeaf;
      for (j = 0; j < 32; j = j+1)
      begin
        mosi = data[31-j];
        repeat(1)@(posedge sck);
      end
      cs = 1;
      repeat(2)@(posedge sck);
*/
      cs = 0;
      data = 32'h80_000001;
      for (j = 0; j < 32; j = j+1)
      begin
        mosi = data[31-j];
        repeat(1)@(negedge sck);
      end
      cs = 1;

      repeat(2)@(posedge sck);

      /*
      cs = 0;
      data = 32'h00_000002;
      for (j = 0; j < 32; j = j+1)
      begin
        mosi = data[31-j];
        repeat(1)@(posedge sck);
      end
      cs = 1;

      repeat(2)@(posedge sck);

      cs = 0;
      data = 32'h00_000003;
      for (j = 0; j < 32; j = j+1)
      begin
        mosi = data[31-j];
        repeat(1)@(posedge sck);
      end
      cs = 1;
*/

      repeat(2)@(posedge sck);

      cs = 0;
      data = 32'hdeadbeaf;
      for (j = 0; j < 32; j = j+1)
      begin
        mosi = data[31-j];
        repeat(1)@(negedge sck);
      end
      cs = 1;
    repeat(1000)@(posedge sck);
    end


		$finish;
	end
endmodule
