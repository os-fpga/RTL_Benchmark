module ram_simple_dp_sync_reg_read_4096x32 (clk, we, read_addr, write_addr, din, dout);
    input clk, we;
    input [11:0] read_addr, write_addr;
    input [31:0] din;
    output reg [31:0] dout;
    
    reg [31:0] ram [4095:0];
    reg [11:0] read_addr_reg;

    always @(posedge clk)
    begin
        read_addr_reg <= read_addr;
        if (we)
            ram[write_addr] <= din;
        else 
            dout <= ram[read_addr_reg];
    end


endmodule