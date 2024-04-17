
module sync_sp_be(clk, addr, rd, wd, we);

input wire clk;
input wire [1:0] we;
input wire [3:0] addr;
input wire [15:0] wd;
output reg [15:0] rd;

reg [15:0] mem [0:15];

always @(negedge clk) begin
    if (we[0])
        mem[addr][7:0] <= wd[7:0];
    if (we[1])
        mem[addr][15:8] <= wd[15:8];
    rd <= mem[addr];
end

endmodule
