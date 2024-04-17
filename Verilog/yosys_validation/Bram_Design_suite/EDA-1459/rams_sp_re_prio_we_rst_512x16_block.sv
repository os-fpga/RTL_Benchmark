
module rams_sp_re_prio_we_rst_512x16_block (clk, rst, byp_set, we, re, addr, di, dout);
input clk, rst, byp_set;
input we, re;
input [8:0] addr;
input [15:0] di;
output reg [15:0] dout;

(* ram_style = "block" *)
reg [15:0] RAM [511:0];
// reg [31:0] dout;

always @(posedge clk)
    begin
        if (we)
            RAM[addr] <= di;
        if (re)begin
            if (rst )
                dout <= 1;
            else
                dout <= RAM[addr];
        end
    end

endmodule