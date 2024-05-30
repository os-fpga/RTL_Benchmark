module large_mux 
#(parameter WIDTH=32)
(
    input clk,
    input rst,
    input [WIDTH-1:0] data_in,
    output reg [WIDTH-1:0] data_out
);
 
reg [WIDTH-1:0] data_out_reg;
 
// Output logic: either reset or update data_out from data_out_reg
always @(posedge clk or posedge rst) begin
    if (rst)
        data_out <= 0;
    else
        data_out <= data_out_reg;
end
 
// Handle data_in translation into data_out_reg
always @(posedge clk) begin
    case(data_in[3:0])  // Focus on the lower 4 bits
        4'b0000: data_out_reg = {24'b0, data_in[7:0]};
        4'b0001: data_out_reg = {16'b0, data_in[15:8], 8'b0};
        4'b0010: data_out_reg = {8'b0, data_in[23:16], 16'b0};
        4'b0011: data_out_reg = {data_in[31:24], 24'b0};
 
        4'b0100: data_out_reg = {16'b0, data_in[15:8], 8'b0};
        4'b0101: data_out_reg = {8'b0, data_in[23:16], 16'b0};
        4'b0110: data_out_reg = {data_in[31:24], 24'b0};
        4'b0111: data_out_reg = {24'b0, data_in[7:0]};
 
        4'b1000: data_out_reg = {8'b0, data_in[23:16], 16'b0};
        4'b1001: data_out_reg = {data_in[31:24], 24'b0};
        4'b1010: data_out_reg = {24'b0, data_in[7:0]};
        4'b1011: data_out_reg = {16'b0, data_in[15:8], 8'b0};
 
        4'b1100: data_out_reg = {data_in[31:24], 24'b0};
        4'b1101: data_out_reg = {24'b0, data_in[7:0]};
        4'b1110: data_out_reg = {16'b0, data_in[15:8], 8'b0};
        4'b1111: data_out_reg = {8'b0, data_in[23:16], 16'b0};
 
        default: data_out_reg = 32'd0;
    endcase
end
 
endmodule