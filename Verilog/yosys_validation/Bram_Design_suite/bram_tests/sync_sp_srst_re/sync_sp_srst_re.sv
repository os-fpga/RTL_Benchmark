
module sync_sp_srst_re(clk, addr, rd, wd, we, re, sr);

input wire clk;
input wire we, re, sr;
input wire [3:0] addr;
input wire [15:0] wd;
output reg [15:0] rd;

reg [15:0] mem [0:15];

always @(posedge clk) begin
    if (we)
        mem[addr] <= wd;
end
always @(posedge clk) begin
    if (re) begin
        if (sr)
            rd <= 16'h55aa;
        else
            rd <= mem[addr];
    end
end

endmodule
