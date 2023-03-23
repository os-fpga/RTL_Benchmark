
module sync_sp_write_first(clk, addr, rd, wd, we, re);

input wire clk;
input wire we, re;
input wire [3:0] addr;
input wire [15:0] wd;
output reg [15:0] rd;

reg [15:0] mem [0:15];

always @(posedge clk) begin
    if (we)
        mem[addr] <= wd;
    if (re)
		if(we)
			rd <= wd;
		else
			rd <= mem[addr];
end

endmodule
