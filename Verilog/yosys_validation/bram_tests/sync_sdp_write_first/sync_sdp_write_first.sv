module sync_sdp_write_first(clk, ra, wa, rd, wd, we);

localparam ABITS = 6;
localparam DBITS = 16;

input wire clk;
input wire we;
input wire [ABITS-1:0] ra, wa;
input wire [DBITS-1:0] wd;
output reg [DBITS-1:0] rd;

reg [DBITS-1:0] mem [0:2**ABITS-1];

always @(negedge clk)
    if (we)
        mem[wa] <= wd;

always @(negedge clk) begin
    rd <= mem[ra];
    if (we && ra == wa)
        rd <= wd;
end

endmodule
