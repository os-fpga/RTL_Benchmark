module ram_simple_dp_sync_reg_read_4096x64 (clk, we, read_addr, write_addr, din, dout);
    input clk, we;
    input [11:0] read_addr, write_addr;
    input [63:0] din;
    output reg [63:0] dout;
    
    reg [11:0] read_addr_reg;
    reg [63:0] ram [4095:0];

    always @(posedge clk)
    begin
        if (we) begin
            ram[write_addr] <= din;
            
        end
        else begin
            read_addr_reg <= read_addr;
            dout <= ram[read_addr_reg];
        end
    end


endmodule 
