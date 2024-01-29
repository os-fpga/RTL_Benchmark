module rams_sp_reg_addr_readmem_1024x18 (clk, we, addr, di, dout);
input clk;
input we;
input [9:0] addr;
input [17:0] di;
output [17:0] dout;

// reg [9:0] addr_reg;
reg [17:0] RAM [1023:0];
reg [17:0] dout=0;

initial begin
    $readmemb("mem.init", RAM);
    end

always @(posedge clk)
    begin
        if (we)
        begin
            RAM[addr] <= di;
            dout <= di;
        end
        else dout <= RAM[addr];
    end
endmodule
