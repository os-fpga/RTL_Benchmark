module large_mux 
#(parameter WIDTH=32)
(
input clk,
input rst,
input [WIDTH-1:0] data_in,
output reg [WIDTH-1:0] data_out);

//reg [WIDTH-1:0] data_out = 32'd0;

always@(*) begin 
casex(data_in)
32'hxxxxxxx0:data_out[31:0] = {24'b0,data_in[7:0]};
32'hxxxxxxx1:data_out[31:0] = {16'b0,data_in[15:8],8'b0};
32'hxxxxxxx2:data_out[31:0] = {8'b0,data_in[23:16],16'b0};
32'hxxxxxxx3:data_out[31:0] = {data_in[31:24],24'b0};

32'hxxxxxx0x:data_out[31:0] = {16'b0,data_in[15:8],8'b0};
32'hxxxxxx1x:data_out[31:0] = {8'b0,data_in[23:16],16'b0};
32'hxxxxxx2x:data_out[31:0] = {data_in[31:24],24'b0};
32'hxxxxxx3x:data_out[31:0] = {24'b0,data_in[7:0]};

32'hxxxxx0xx:data_out[31:0] = {8'b0,data_in[23:16],16'b0};
32'hxxxxx1xx:data_out[31:0] = {data_in[31:24],24'b0};
32'hxxxxx2xx:data_out[31:0] = {24'b0,data_in[7:0]};
32'hxxxxx3xx:data_out[31:0] = {16'b0,data_in[15:8],8'b0};

32'hxxxx0xxx:data_out[31:0] = {data_in[31:24],24'b0};
32'hxxxx1xxx:data_out[31:0] = {24'b0,data_in[7:0]};
32'hxxxx2xxx:data_out[31:0] = {16'b0,data_in[15:8],8'b0};
32'hxxxx3xxx:data_out[31:0] = {8'b0,data_in[23:16],16'b0};

default: data_out[31:0]= 32'd0;
endcase
end
endmodule






