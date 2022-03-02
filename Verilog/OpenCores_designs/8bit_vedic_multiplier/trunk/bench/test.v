module test;

	reg [7:0] a,b;
	wire [15:0] prod;
	reg clk;

	vedic8x8 U0(a,b,prod);

	initial begin
		clk = 0;
		#500;
		$finish;
	end

	always@(posedge clk) begin
		a = $random;
		b = $random;
		#20;
	end

	always #10 clk = !clk;

	reg [7:0] a_reg,b_reg;

	always@(posedge clk) begin
		a_reg <= a;
		b_reg <= b;
	end

	always@(posedge clk)begin
		if((a_reg > 0) && (b_reg > 0)) begin
			if(prod == a_reg *b_reg)
				$display("%d x %d = %d, Test Passed", a_reg, b_reg, prod);
			else
				$display("%d x %d = %d, Test Failed", a_reg, b_reg, prod);
		end
	end

endmodule
