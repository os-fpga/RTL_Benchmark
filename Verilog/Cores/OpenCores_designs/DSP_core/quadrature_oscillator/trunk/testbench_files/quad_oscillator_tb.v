// Impulse response of quad_oscillator.v test bench file
module quad_oscillator_tb;

reg clk, rst;
reg signed [15:0] x;

quad_oscillator osc1(.clk(clk), .rst(rst), .x(x));

initial // Clock generator
  begin
    clk = 0;
    forever #10 clk = !clk;
  end
  
initial // Reset generator
  begin
    rst = 0;
	 x = 16'd0;
    #20 rst = 1;
	 #10 rst = 0;
	 #100 x = 16'd256;
	 #15 x = 16'd0;
  end
    
endmodule 