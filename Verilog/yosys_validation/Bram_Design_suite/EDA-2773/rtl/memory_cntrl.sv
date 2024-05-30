module memory_cntrl 
#(parameter WIDTH = 32,
parameter ADDR = 10,
parameter DATA = 32)
( 
input clk,
input rst,
input [WIDTH-1:0] data_in,
output [WIDTH-1:0] data_out);

localparam s0=2'b00,s1=2'b01,s2=2'b10,s3=2'b11;

reg [1:0] state;
reg reset_mem;
reg [ADDR-1:0] wr_addr;
reg [ADDR-1:0] rd_addr;
reg [DATA-1:0] wr_data_mem;
reg rd_en;
reg wr_en;

always@(posedge clk)
   begin 
      if(rst) begin 
         reset_mem<=1;
         state<=s0;
         wr_addr<=0;
         rd_addr<=0;
         wr_en<=0;
         rd_en<=0;
      end
      else 
      case(state) //synopsys full_case
         s0: 
            begin
               wr_data_mem<=0;
               if (wr_addr==10'b1111111111) begin
                  state<=s1;
                  wr_addr<=1;
                  wr_en<=0;
                  reset_mem<=0;  
               end
               else
                begin 
                 state<=s0;
                 wr_addr<=wr_addr+1;
                 wr_en<=1;
                 wr_data_mem<=data_in;
               end
            end
         s1:
            begin
               rd_en<=1;
               rd_addr<=rd_addr+1;
               // wr_en<=1;
               // wr_addr<=wr_addr+1;
               state<=s1;
            end
         default: state<=s0;
      endcase
   end



memory mem(
.clk(clk),
.rst(reset_mem),
.wr_addr(wr_addr),
.wr_data_in(wr_data_mem),
.wr_en(wr_en),
.rd_addr(rd_addr),
.rd_en(rd_en),
.rd_data_out(data_out));
 

endmodule


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


  
