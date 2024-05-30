module memory #(
parameter DATA = 32,
parameter ADDR = 10
)
(
input clk,
input rst,
input [ADDR-1:0] wr_addr,
input [DATA-1:0] wr_data_in,
input wr_en,

input [ADDR-1:0] rd_addr,
input rd_en,
output reg [DATA-1:0] rd_data_out);


reg [DATA-1:0] mem [(2**ADDR)-1:0];

always@(posedge clk) begin
   if(wr_en) begin
      mem[wr_addr] <= wr_data_in;
      end
   end
   
always@(posedge clk) begin
   if(rst) begin 
      rd_data_out<=0; end
   else begin
      if(rd_en) begin
         rd_data_out<=mem[rd_addr];
      end
   end
end
endmodule 
