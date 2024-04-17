
module rams_sp_wf_rst_en_1024x16 (clk, we, en, rst, addr, di, dout);
input clk;
input we;
input en;
input rst;
input [9:0] addr;
input [15:0] di;
output [15:0] dout;

reg [15:0] RAM [1023:0];
reg [15:0] dout;

always @(posedge clk)
    begin
        if(en) begin
            if (rst)
                dout <= 0;
            else if (we)
            begin
                RAM[addr] <= di;
                dout <= di;
            end
            else
                dout <= RAM[addr];
        end
    end
endmodule
