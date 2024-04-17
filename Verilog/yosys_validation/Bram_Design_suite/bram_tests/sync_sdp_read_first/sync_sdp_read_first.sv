
module sync_sdp_read_first(clk, write_addr, read_addr, rd, wd, we, re);

input wire clk;
input wire we, re;
input wire [3:0] read_addr, write_addr;
input wire [15:0] wd;
output reg [15:0] rd;

reg [15:0] mem [0:15];

always @(posedge clk) begin
    if (we)
        mem[write_addr] <= wd;
    if (re)
        rd <= mem[read_addr];
end

endmodule
