module rams_sp_reg_addr_readmem_1024x9 (clk, we, addr, di, dout);
input clk;
input we;
input [9:0] addr;
input [8:0] di;
output [8:0] dout;

// reg [9:0] addr_reg;
reg [8:0] RAM [1023:0];
reg [8:0] dout=0;

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
