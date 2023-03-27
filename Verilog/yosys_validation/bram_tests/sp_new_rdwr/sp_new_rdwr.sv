
module sp_new_rdwr(clk, addr, rd, wd, we);

input wire clk;
input wire we;
input wire [3:0] addr;
input wire [15:0] wd;
output reg [15:0] rd;

reg [15:0] mem [0:15];

always @(negedge clk) begin
    if (we) begin
        mem[addr] <= wd;
        rd <= wd;
    end else
        rd <= mem[addr];
end

endmodule
