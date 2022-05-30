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
`include "simple_spi_slave.v"
`include "ram_sync.v"
`include "ws2812_sequence.v"

module ws2812_ctl(clk, resetn, dout, sck,
                  mosi, miso, cs, ready);
input clk;
input resetn;
output dout;

input cs;
input sck;
input mosi;
output miso;
output reg ready;

reg [9:0] ram_addr;
reg [9:0] rx_word_counter;
reg [23:0] ram_din;
wire [23:0] ram_dout;
reg  ram_we = 0;

reg [23:0] din;
reg enable = 0;
wire done;

wire spi_done;
reg [23:0] spi_rx_data;
wire [31:0] rx_data;

// fifo write states
localparam SYSTEM_CLOCK_FREQ = 12_000_000;
localparam S_RESET                = 0;
localparam S_WAIT4_SPI_DATA       = 1;
localparam S_STORE_FIFO_DATA      = 2;
localparam S_PREPARE_FIFO         = 3;

// fifo read and burst states
localparam S_CHECK4_FIFO_DATA     = 4;
localparam S_GET_FIFO_DATA        = 5;
localparam S_BURST_WS2812_SEQ     = 6;
localparam S_SEQ_DONE             = 7;

reg [2:0] state = S_RESET;

spi_slave spi_slave_i(.resetn(resetn), .clk(clk), .sck(sck),
                      .mosi(mosi), .miso(miso), .cs(cs),
                      .done(spi_done), .rx_data(rx_data));

ram_sync #(.ADDRESS_LINES(1024), .DATA_WIDTH(24))
                ram_sync_i(.clk(clk), .addr(ram_addr),
                  .din(ram_din), .dout(ram_dout), .we(ram_we));

ws2812_sequence #(.SYSTEM_CLOCK_FREQ(SYSTEM_CLOCK_FREQ))
                ws2812_sequence_i(.clk(clk),
                  .din(din),
                  .resetn(resetn),
                  .enable(enable),
                  .dout(dout),
                  .done(done)
                );

always @(posedge clk)
  ready <= ~( &(~ram_addr) && state == S_WAIT4_SPI_DATA);

always @(posedge clk) begin
  if (~resetn) begin
    state <= S_RESET;
  end else begin
    case (state)

      S_RESET: begin
        enable <= 0;
        rx_word_counter <= 0;
        ram_addr <= 0;
        ram_we <= 0;
        spi_rx_data <= 0;
        state <= S_WAIT4_SPI_DATA;
      end

      S_WAIT4_SPI_DATA: begin
        if (spi_done) begin
          spi_rx_data <= rx_data[23:0];
          if (rx_data == 32'h dead_beaf) begin
            rx_word_counter <= ram_addr;
            ram_addr <= 0;
            state <= S_CHECK4_FIFO_DATA;
          end else begin
            state <= S_STORE_FIFO_DATA;
          end
        end else
          state <= S_WAIT4_SPI_DATA;
      end

      S_STORE_FIFO_DATA: begin
        ram_we <= 1;
        ram_din <= spi_rx_data;
        state <= S_PREPARE_FIFO;
      end

      S_PREPARE_FIFO: begin
        ram_we <= 0;
        ram_addr <= ram_addr + 1;
        state <= S_WAIT4_SPI_DATA;
      end

      S_CHECK4_FIFO_DATA: begin
        ram_we <= 0;
        enable <= 0;
        if (ram_addr == (rx_word_counter)) begin
          spi_rx_data <= 0;
          rx_word_counter <= 0;
          ram_addr <= 0;
          ram_we <= 0;
          state <= S_WAIT4_SPI_DATA;
        end else
          state <= S_GET_FIFO_DATA;
      end

      S_GET_FIFO_DATA: begin
        din <= ram_dout;
        state <= S_BURST_WS2812_SEQ;
      end

      S_BURST_WS2812_SEQ: begin
        enable <= 1;
        state <= S_SEQ_DONE;
      end

      S_SEQ_DONE: begin
          enable <= 0;
        if (done) begin
         ram_addr <= ram_addr + 1;
          state <= S_CHECK4_FIFO_DATA;
        end else
          state <= S_SEQ_DONE;
      end

    default: begin
        state <= S_RESET;
      end
    endcase
  end end

endmodule

