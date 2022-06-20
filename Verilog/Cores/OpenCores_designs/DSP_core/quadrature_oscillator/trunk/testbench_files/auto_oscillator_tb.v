// auto_oscillator.v test bench file
module auto_oscillator_tb;

reg clk, rst;
reg start;

auto_oscillator a_osc1(.clk(clk), .rst(rst), .start(start));

initial // Clock generator
  begin
    clk = 0;
    forever #10 clk = !clk;
  end
  
initial // Reset generator
  begin
    rst = 0;
	 start = 0;
    #20 rst = 1;
	 #10 rst = 0;
	 #100 start = 1;
  end
    
endmodule 