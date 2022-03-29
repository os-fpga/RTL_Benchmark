`timescale 1 ns/100 ps // time unit = 1ns; precision = 1/10 ns
/* Distributed RAM
 * DistroRAM.v
 *
 * Implement a small dual-port RAM using distributed RAM
 */
module DistroRAM (
    clock,
    wen,
    waddr,
    raddr,
    din,
    wdout,
    rdout
);
    parameter WIDTH = 8;
    parameter LOG_DEP = 3;
    localparam DEPTH = 1 << LOG_DEP;

    input                   clock;
    input                   wen;
    input    [LOG_DEP-1: 0] waddr;
    input    [LOG_DEP-1: 0] raddr;
    input      [WIDTH-1: 0] din;
    output     [WIDTH-1: 0] wdout;
    output     [WIDTH-1: 0] rdout;

    // Infer distributed RAM
    reg        [WIDTH-1: 0] ram [DEPTH-1: 0];

    // synthesis attribute RAM_STYLE of ram is distributed
    always @(posedge clock)
    begin
        if (wen)
            ram[waddr] <= din;
    end

    assign wdout = ram[waddr];
    assign rdout = ram[raddr];

endmodule

