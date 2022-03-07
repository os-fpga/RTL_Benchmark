timeunit 1ns;
timeprecision 1ns;

module isqrt_dbd_tb;

	bit clk = 0;
	bit [31:0] data = 0;
	wire [15:0] q;
	
	always #10ns clk++;
	
	initial begin
		repeat(10) @(posedge clk);
		
		Test(32'd241125431);
		
		repeat(10) @(posedge clk);
		$stop(2);
	end

	isqrt_dbd dut(.*);
	
	task Test(bit [31:0] value);
		int q_ref;
		data = value;
		
		repeat(100) @(posedge clk);
		q_ref = longint'($sqrt(value));
		$display("x = %d, rtl: %d, ref: %d", value, q, q_ref);
	endtask
endmodule :isqrt_dbd_tb
