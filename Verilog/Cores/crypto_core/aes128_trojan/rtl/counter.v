`timescale 1ns/1ps 

module counter(clk,counter_out);
input clk;
output reg [3:0]counter_out; 

reg [23:0]count; 

initial begin
	counter_out = 4'b0000;
	count = 24'd0;
end

always@(posedge clk) begin
	if(count == 24'd50000000) begin
		counter_out <= counter_out + 1'b1;
		count <= 24'd0;
	end else count <= count + 1'b1;
end
endmodule
