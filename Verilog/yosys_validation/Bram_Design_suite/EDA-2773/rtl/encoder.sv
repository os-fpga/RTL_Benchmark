module encoder #(parameter WIDTH=32)
(
input clk,
input rst,
input [WIDTH-1:0] data_in,
output reg [WIDTH-1:0] data_out
);

reg [WIDTH-1:0 ] data_out_wire;

always@(posedge clk)
begin 
if(rst)
data_out<=0;
else
data_out<=data_out_wire;
end


always@(*)
begin

if (data_in==32'd0)
data_out_wire=32'd1423;
else
if (data_in==32'd123)
data_out_wire=~32'd1423;
else
if (data_in==32'd1023)
data_out_wire=32'd0023 + 32'b11111111100000000111000000000000;
else
if (data_in==32'd10023)
data_out_wire=32'd0023 - 32'b11111111100001000111000000100000;
else
if (data_in==32'd7000)
data_out_wire=~32'd4000;
else
data_out_wire=0;
end


endmodule


 







