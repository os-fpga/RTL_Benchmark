parameter WIDTH = 32;

module large_adder (
input clk,
input rst,
input [WIDTH-1:0] data_in,
output [WIDTH-1:0] data_out);
 
reg [WIDTH-1:0] add_out_reg_0;
reg [WIDTH-1:0] add_out_reg_1;
reg [WIDTH-1:0] add_out_reg_2;

always@(posedge clk)
begin
if(rst)
begin
add_out_reg_0<=0;
add_out_reg_1<=0;
add_out_reg_2<=0;
end
else
begin
add_out_reg_0<=(data_in[WIDTH-1:WIDTH-8] + data_in[WIDTH-8-1:WIDTH-16])-(data_in[WIDTH-16-1:WIDTH-24] + data_in[WIDTH-24-1:0]);
add_out_reg_1<=(data_in[WIDTH-1:WIDTH-16] - data_in[WIDTH-16-1:0]); 
add_out_reg_2<=(data_in[WIDTH-1:WIDTH-16] + data_in[WIDTH-16-1:0]);
end
end
assign data_out = add_out_reg_0 * add_out_reg_1 + add_out_reg_2;

endmodule




