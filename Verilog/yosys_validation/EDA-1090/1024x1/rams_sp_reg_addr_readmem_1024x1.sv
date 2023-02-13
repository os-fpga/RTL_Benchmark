module rams_sp_reg_addr_readmem_1024x1 (clk, we, addr, di, dout);
input clk;
input we;
input [9:0] addr;
input [0:0] di;
output [0:0] dout;

// reg [9:0] addr_reg;
reg [0:0] RAM [1023:0];
reg [0:0] dout;

initial begin
    $readmemh("/nfs_scratch/scratch/FV/awais/Synthesis/v1/yosys_verific_rs/RTL_Benchmark/Verilog/yosys_validation/EDA-1090/1024x1/mem.init", RAM);
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