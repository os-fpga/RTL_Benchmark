
module rams_sp_reg_addr_1024x36 (clk, we, addr, di, dout);
input clk;
input we;
input [9:0] addr;
input [35:0] di;
output [35:0] dout;

reg [9:0] addr_reg;
reg [35:0] RAM [1023:0];
// reg [31:0] dout;

always @(posedge clk)
    begin
        if (we)
        begin
            RAM[addr] <= di;
            addr_reg <= addr;
        end
    end

assign dout = RAM[addr_reg]; // read with registered addr
endmodule