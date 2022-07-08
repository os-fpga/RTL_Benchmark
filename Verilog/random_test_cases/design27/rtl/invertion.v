module invertion
#(parameter WIDTH=32) 
(
input clk,
input rst,
input [WIDTH-1:0] data_in,
output [WIDTH-1:0] data_out);

reg [7:0] data_out_reg;
wire [7:0] data_out_wire;

assign data_out_wire[7:0] = ((~data_in[7:0]) | (~data_in[15:8]));

always@(posedge clk)
begin
if (rst)
begin 
data_out_reg[7:0]<=0;
end
else 
begin 
data_out_reg[7:0]<= data_in[31:24] ^ data_in[23:16];

end
end

assign data_out[31:16] = (data_in[31:16] == data_in[15:0])? ~data_in[15:0]: ^data_in[31:16];

assign data_out[15:0] = {data_out_reg,data_out_wire};


endmodule

