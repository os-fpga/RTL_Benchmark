
module sync_sp_arst_re(clk, addr, rd, wd, we, re, ar);

input wire clk;
input wire we, re, ar;
input wire [3:0] addr;
input wire [15:0] wd;
output reg [15:0] rd;

reg [15:0] mem [0:15];

always @(posedge clk) begin
    if (we)
        mem[addr] <= wd;
end
always @(posedge clk, posedge ar) begin
    if (ar)
        rd <= 16'h55aa;
    else if (re)
        rd <= mem[addr];
end

endmodule
