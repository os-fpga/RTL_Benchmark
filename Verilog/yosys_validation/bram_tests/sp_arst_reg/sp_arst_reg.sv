
module sp_arst_reg(clk, addr, rd, wd, we, re, ar);

input wire clk;
input wire we, re, ar;
input wire [9:0] addr;
input wire [15:0] wd;
output reg [15:0] rd;

reg [15:0] mem [0:15];

initial rd = 16'hxxxx;

always @(posedge clk) begin
    if (we)
        mem[addr] <= wd;
end
always @(posedge clk, posedge ar) begin
    if (ar)
        rd <= 16'h0000;
    else if (re)
        rd <= mem[addr];
end

endmodule
