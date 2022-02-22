// Single-Port Block RAM Read-First Mode
// File: rams_sp_wrf.v
module rams_sp_rf (clk, we, en, addr, di, dout);
input clk;
input we;
input en;
input [9:0] addr;
input [15:0] di;
output [15:0] dout;

reg [15:0] RAM [1023:0];
reg [15:0] dout;

always @(posedge clk)
    begin
        if (en)
        begin
            if (we)
            begin
                RAM[addr] <= di;
            end
                dout <= RAM[addr];
        end
    end
endmodule