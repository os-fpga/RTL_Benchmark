
module rams_sp_reg_addr_1024x32 (clk, we, addr, di, dout);
input clk;
input we;
input [9:0] addr;
input [31:0] di;
output [31:0] dout;

// reg [9:0] addr_reg;
reg [31:0] RAM [1023:0];
reg [31:0] dout;

initial begin
    $readmemh("mem1.mem", RAM);
    end

always @(posedge clk)
    begin
        if (we)
        begin
            RAM[addr] <= di;
            // addr_reg <= addr;
            dout <= di;
        end
        else dout <= RAM[addr];
    end


// assign dout = RAM[addr_reg]; // read with registered addr
endmodule