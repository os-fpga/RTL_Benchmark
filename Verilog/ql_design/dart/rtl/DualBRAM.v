`timescale 1ns / 1ps
/* Dual-Port RAM with synchronous read (read through)
 */
module DualBRAM #(
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
    output [WIDTH-1:0] dout,
    output [WIDTH-1:0] wdout
);
    localparam DEPTH = 1 << LOG_DEP;
    
    // Infer Block RAM
    reg         [WIDTH-1:0] ram [DEPTH-1:0];
    reg      [LOG_DEP-1: 0] read_addr;
    reg      [LOG_DEP-1: 0] write_addr;
    
    // synthesis attribute RAM_STYLE of ram is block
    always @(posedge clock)
    begin
        if (enable)
        begin
            if (wen)
                ram[waddr]  <= din;
        
            read_addr <= raddr;
            write_addr <= waddr;
        end
    end
    
    assign dout = ram[read_addr];
    assign wdout = ram[write_addr];
endmodule

