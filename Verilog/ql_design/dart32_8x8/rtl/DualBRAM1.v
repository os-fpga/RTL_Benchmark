`timescale 1ns / 1ps
/* Dual-Port RAM with synchronous read (read through)
 */
module DualBRAM1 #(
    parameter WIDTH = 36,
    parameter LOG_DEP = 6
)
(
    input clock,
    input enable,
    input wen,
    input  [LOG_DEP-1:0] waddr,
    input  [LOG_DEP-1:0] raddr,
    input  [WIDTH-1:0] din,
    output reg [WIDTH-1:0] dout,
    output reg [WIDTH-1:0] wdout
);
    localparam DEPTH = 1 << LOG_DEP;
    
    // Infer Block RAM
    reg         [WIDTH-1:0] ram [DEPTH-1:0];
    reg         [WIDTH-1:0] ram1 [DEPTH-1:0];
    //reg      [LOG_DEP-1: 0] read_addr;
    //reg      [LOG_DEP-1: 0] write_addr;
    //reg      [WIDTH-1:0] dout;
    //reg      [WIDTH-1:0] wdout;
    wire     wen_int;
    
    assign wen_int = enable & wen;
    
    // synthesis attribute RAM_STYLE of ram is block
    always @(posedge clock)
    begin
      if (wen_int)
        ram[waddr]  <= din;
      dout = ram[raddr];  
    end
    
    always @(posedge clock)
    begin
      if (wen_int)
        ram1[waddr]  <= din;
      wdout = ram1[waddr];  
    end
    
endmodule

