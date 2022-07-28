module fifo_tb ();
parameter DATA_WIDTH = 8;
// Limit depth to 8
parameter ADDR_WIDTH = 3; 

reg clk, rst, rd_en, wr_en;
reg [DATA_WIDTH-1:0] data_in ;
wire [DATA_WIDTH-1:0] data_out ;
wire empty, full;
integer i;

initial begin
  $monitor ("%g wr:%h wr_data:%h rd:%h rd_data:%h", 
    $time, wr_en, data_in,  rd_en, data_out);
  clk = 0;
  rst = 0;
  rd_en = 0;
  wr_en = 0;
  data_in = 0;
  #5 rst = 1;
  #5 rst = 0;
  @ (negedge clk);
  wr_en = 1;
  // We are causing over flow
  for (i = 0 ; i < 10; i = i + 1) begin
     data_in  = i;
     @ (negedge clk);
  end
  wr_en  = 0;
  @ (negedge clk);
  rd_en = 1;
  // We are causing under flow 
  for (i = 0 ; i < 10; i = i + 1) begin
     @ (negedge clk);
  end
  rd_en = 0;
  #100 $finish;
end  

always #1 clk = !clk;

syn_fifo #(DATA_WIDTH,ADDR_WIDTH) fifo(
.clk      (clk)     , // Clock input
.rst      (rst)     , // Active high reset
.wr_cs    (1'b1)    , // Write chip select
.rd_cs    (1'b1)    , // Read chipe select
.data_in  (data_in) , // Data input
.rd_en    (rd_en)   , // Read enable
.wr_en    (wr_en)   , // Write Enable
.data_out (data_out), // Data Output
.empty    (empty)   , // FIFO empty
.full     (full)      // FIFO full
);   

endmodule
