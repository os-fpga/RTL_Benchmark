module ram_simple_dp_synch_wf_1024x32 (clk, we,re, read_addr, write_addr, din, dout);
    input clk, we, re;
    input [9:0] read_addr, write_addr;
    input [31:0] din;
    output reg [31:0] dout;
    
    reg [31:0] ram [1023:0];

    always @(posedge clk)
    begin
        if (we)
            ram[write_addr] <= din;
        if (re) begin
            dout <= ram[read_addr];
            if (we && read_addr == write_addr)
                dout <= din;
        end
    end

endmodule