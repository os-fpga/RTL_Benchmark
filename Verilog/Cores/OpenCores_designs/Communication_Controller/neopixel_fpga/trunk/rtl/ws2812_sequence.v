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
`ifndef WS2812_DATA_SEQUENCE_H
`define WS2812_DATA_SEQUENCE_H
module ws2812_sequence(clk, resetn, enable, din, dout, done);
  /*
   * e.g. 12 MHz = 83,33ns = 0.083us cycles
   *
   * 0,45 us => 450 ns
   *
   * T0H = 0,4 us = 400 ns ~ cycles * 5 = 416.65 ns
   * T0L = 0.85 us = 850 ns ~ cycles * 10 = 833.3 ns
   *
   * T0H + T0L = 1250 ns ~ 1249.95 ns
   *
   * T1H = 0.8us = 800 ns ~ cycles * 10 = 833.3 ns
   * T1L = 0.45us = 450 ns ~ cycles * 5 = 416.65 ns
   *
   * T0H + T0L = 1250 ns ~ 1249.95 ns
   *
   * RES above 50 us = 50000ns ~ cycles * 610 = 50831 ns
   * +/- 150 ns
   *
   * with 12 MHz = 1249.95 = +/- 0.05 ns
   *
   *  ______
   * | T0H  |__T0L___|
   *
   *  ______
   * | T1H  |__T1L___|
   *
   * |____Treset ____|
   *
   */
  localparam GRB_WIDTH = 24;

  parameter SYSTEM_CLOCK_FREQ = 12_000_000;
  parameter T0H_TIME = 0.4e-6; // 400 ns
  parameter T0L_TIME = 0.85e-6; // 850 ns
  localparam  CLK_HZ = $itor(SYSTEM_CLOCK_FREQ);
  localparam CLK_CYCLE = (1/CLK_HZ);

  localparam T0H_CYCLES = $rtoi((T0H_TIME)/CLK_CYCLE+0.5);//5;
  localparam T0L_CYCLES = $rtoi((T0L_TIME)/CLK_CYCLE+0.5);//10;

  localparam T1H_CYCLES = T0L_CYCLES;
  localparam T1L_CYCLES = T0H_CYCLES;

  localparam SEQUENCE_CYCLE = T0H_CYCLES + T0L_CYCLES;

  localparam TRESET_CYCLES = $rtoi((50e-6)/CLK_CYCLE+0.5);//610; // ~ 50us

  localparam CYCLE_BITS = $clog2(SEQUENCE_CYCLE);

  input clk;
  input resetn;
  input enable;

  /* |G7|...|G0|R7|...|R0|B7|..|B0| */
  input wire [GRB_WIDTH -1:0] din;

  output reg dout = 1'b0;
  output reg done = 1'b0;

  reg [GRB_WIDTH - 1:0] data_in = 0;
  reg [CYCLE_BITS-1:0] dout_cycle_cnt = 0;
  reg [$clog2(GRB_WIDTH-1):0] dout_bit_cycle_cnt = 0;
  reg dbit = 0;


  // states
  localparam S_RESET = 0;
  localparam S_IDLE = 1;
  localparam S_SEQUENCE_OUT = 2;

  localparam S_TXH_DATA_SEQUENCE = 3;
  localparam S_TXL_DATA_SEQUENCE = 4;

  reg [2:0] state = S_RESET;

  initial begin
    $display("CLK_HZ: ", CLK_HZ);
    $display("CLK_CYCLE: ", CLK_CYCLE);
    $display("T0H_CYCLES: ", T0H_CYCLES);
    $display("T0L_CYCLES: ", T0L_CYCLES);
    $display("SEQUENCE_CYCLE: ", SEQUENCE_CYCLE);
    $display("CYCLE_BITS: ", CYCLE_BITS);
    $display("$clog2(GRB_WIDTH): ", $clog2(GRB_WIDTH));
    $display("TRESET_CYCLES: ", TRESET_CYCLES);
  end

  always @(posedge clk) begin
    if (~resetn) begin
      done <= 0;
      dout <= 0;
      state <= S_RESET;
    end else begin
      case (state)

        S_RESET: begin
          state <= S_IDLE;
        end

        S_IDLE: begin
          done <= 0;
          dout_bit_cycle_cnt <= 0;
          dout_cycle_cnt <= 0;
          dout <= 0;
          if (enable) begin
            data_in <= din;
            state <= S_SEQUENCE_OUT;
          end else
            state <= S_IDLE;
        end

      S_SEQUENCE_OUT: begin
        dout_bit_cycle_cnt <= dout_bit_cycle_cnt + 1;
        if (dout_bit_cycle_cnt == GRB_WIDTH) begin
          done <= 1;
          state <= S_IDLE;
        end else begin
          dout_cycle_cnt <= 1;
          data_in <= {data_in[GRB_WIDTH -2: 0], 1'b0};
          dbit <= data_in[GRB_WIDTH -1];
          state <= S_TXH_DATA_SEQUENCE;
        end
      end

      S_TXH_DATA_SEQUENCE: begin
        dout_cycle_cnt <= dout_cycle_cnt + 1;
        if (dout_cycle_cnt < (dbit ? T1H_CYCLES[CYCLE_BITS-1:0] : T0H_CYCLES[CYCLE_BITS-1:0])) begin
          dout <= 1;
          state <= S_TXH_DATA_SEQUENCE;
        end
        else begin
          dout_cycle_cnt <= 1;
          state <= S_TXL_DATA_SEQUENCE;
        end
      end

      S_TXL_DATA_SEQUENCE: begin
        dout_cycle_cnt <= dout_cycle_cnt + 1;
        if ((dout_cycle_cnt < (dbit ? T1L_CYCLES[CYCLE_BITS-1:0] -1: T0L_CYCLES[CYCLE_BITS-1:0] -1))) begin
          dout <= 0;
          state <= S_TXL_DATA_SEQUENCE;
        end
        else
          state <= S_SEQUENCE_OUT;
      end

      // fall-through reset
      default: begin
        state <= S_RESET;
      end
    endcase
  end
end

endmodule
`endif
