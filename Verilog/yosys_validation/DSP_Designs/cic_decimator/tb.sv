module co_sim_cic_decimator #(parameter width = 12);
	reg               clk;
	reg               rst;
	reg        [15:0] decimation_ratio;
	reg signed [7:0]  d_in;
	wire signed [7:0]  d_out;
	wire 			   d_clk;
	wire signed [7:0]  d_out_netlist;
	wire 			   d_clk_netlist;
	
	//reg signed [8:0] x_read;
	integer mismatch=0;
	
	cic_decimator  CIC(.clk(clk),
						   .rst(rst),
						   .decimation_ratio(decimation_ratio),
						   .d_in(d_in),
						   .d_out(d_out),
						   .d_clk(d_clk));
	cic_decimator_post_synth netlist(.clk(clk),
						   .rst(rst),
						   .decimation_ratio(decimation_ratio),
						   .d_in(d_in),
						   .d_out(d_out_netlist),
						   .d_clk(d_clk_netlist));
		   
//clock initialization
initial begin
    clk = 1'b0;
    forever #5 clk = ~clk;
end
initial begin
	rst = 1'b1;
	d_in <= 8'b0;
	decimation_ratio <= 16'd0;
	#40;
	compare();
	#40;
	rst <= 1'b0;
	compare();
	decimation_ratio <= 16'd4;
	d_in <= 8'b0;

		repeat(10) @(negedge clk);
			rst <= 1'b1;
			compare();
			@(negedge clk);
			rst <= 1'b0;
			compare();
		repeat(5) @(negedge clk);
		repeat (100)
			begin
				d_in <= $random();
				@(negedge clk);
			end
		repeat(100) @(negedge clk);
		if(mismatch == 0)
        	$display("\n**** All Comparison Matched ***\nSimulation Passed");
    	else
        	$display("%0d comparison(s) mismatched\nERROR: SIM: Simulation Failed", mismatch);
		$finish;
	end

	always @(negedge d_clk)
	begin
		compare();
	end

	task compare();
		$display("*** Comparing ***");
		if((d_out !== d_out_netlist) || (d_clk !== d_clk_netlist)) begin
		  $display("Comparison Data Mismatch. Golden d_out: %0d, Netlist d_out_netlist: %0d, Time: %0t", d_out, d_out_netlist, $time);
		  $display("Comparison Data Mismatch. Golden d_clk: %0d, Netlist d_clk_netlist: %0d, Time: %0t", d_clk, d_clk_netlist, $time);
		  mismatch = mismatch+1;
	   end
		else begin
			$display("Data Matched. Golden d_out: %0d, Netlist d_out_netlist: %0d, Time: %0t", d_out, d_out_netlist, $time);
			$display("Data Matched. Golden d_clk: %0d, Netlist d_clk_netlist: %0d, Time: %0t", d_clk, d_clk_netlist, $time);
		end
  endtask


initial begin
    $dumpfile("tb.vcd");
    $dumpvars;
end
endmodule
