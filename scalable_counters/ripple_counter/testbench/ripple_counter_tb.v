`timescale 1ns / 1ps
`ifndef TESTBENCH
`define size 5
`endif
`include "ripple_counter.v"

module test;

  reg clk, reset;
  wire [`size-1:0] q;
  
  // Instantiate the design
  ripple_counter rcc (q, clk, reset);
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars();
    
    // Initialize the clk
    clk = 1'b0;
    
    // Reset the counter
    reset = 1'b1;
    #10 reset = 1'b0;
    
    #1500;
    reset = 1'b1;
    #10 reset = 1'b0;
    
    #50;
    $finish;
  end
  
  always #5 clk = ~clk;

endmodule
