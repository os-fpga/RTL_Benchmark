module rams_sp_reg_addr_readmem_512x8 (clk, we, addr, di, dout);
input clk;
input we;
input [8:0] addr;
input [7:0] di;
output [7:0] dout;

// reg [9:0] addr_reg;
reg [7:0] RAM [511:0];
reg [7:0] dout;

initial begin
    $readmemh("/nfs_scratch/scratch/FV/awais/Synthesis/v1/yosys_verific_rs/RTL_Benchmark/Verilog/yosys_validation/EDA-1090/512x8/mem.init", RAM);
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