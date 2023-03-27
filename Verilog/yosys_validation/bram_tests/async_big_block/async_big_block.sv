
module async_big_block(clk, ra, wa, rd, wd, we);

localparam ABITS = 11;
localparam DBITS = 10;

input wire clk;
input wire we;
input wire [ABITS-1:0] ra, wa;
input wire [DBITS-1:0] wd;
output wire [DBITS-1:0] rd;

reg [DBITS-1:0] mem [0:2**ABITS-1];

always @(posedge clk)
    if (we)
        mem[wa] <= wd;

assign rd = mem[ra];

endmodule
