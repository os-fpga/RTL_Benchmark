module two_sdp(rAddr1, wAddr1, din1, dout1, clk1, we1, rAddr2, wAddr2, din2, dout2, clk2, we2);
  input wire [15:0] din1;
  output reg [15:0] dout1;
  input wire [7:0] din2;
  output reg [7:0] dout2;
  input wire [9:0] rAddr1, wAddr1;
  input wire [10:0] rAddr2, wAddr2;
  input wire clk1, clk2, we1, we2;

  reg [15:0] ram1 [1023:0]; // data width is 16 
  reg [7:0] ram2 [2047:0]; // data width is 8

  always @(posedge clk1)
  begin
    if (we1)
      ram1[wAddr1] <= din1;
    else
      dout1 = ram1[rAddr1];
  end

  always @(posedge clk2)
  begin
    if (we2)
      ram2[wAddr2] <= din2;
    else
      dout2 = ram2[rAddr2];
  end
endmodule 
