`timescale 1ns / 1ps
`ifndef TESTBENCH
`define size 5
`endif
`include "johnson_counter.v"
module tb;
  
  reg clk;
  reg rstn;
  wire [`size-1:0] out;
  
  johnson_counter 	u0 (.clk (clk),
                .rstn (rstn),
                .out (out));
  
  always #10 clk = ~clk;
  
  initial begin
    {clk, rstn} <= 0;

    $dumpfile("dump.vcd");
    $dumpvars();

    $monitor ("T=%0t out=%b", $time, out);
    repeat (2) @(posedge clk);
    rstn <= 1;
    repeat (15) @(posedge clk);
    $finish;
  end
endmodule
