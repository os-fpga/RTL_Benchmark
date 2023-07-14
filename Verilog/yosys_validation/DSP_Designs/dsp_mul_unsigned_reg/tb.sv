module co_sim_dsp_mul_unsigned_reg;
	reg  [19:0] A;
	reg  [17:0] B;
	reg clk, reset ;
	wire  [37:0] P;
	wire  [37:0] P_netlist;

	integer mismatch=0;

dsp_mul_unsigned_reg golden(.*);
dsp_mul_unsigned_reg_post_synth netlist(.*, .P(P_netlist));

//clock initialization
initial begin
    clk = 1'b0;
    forever #5 clk = ~clk;
end
initial begin
	reset = 0;
	@(negedge clk);
	reset = 1;
	A=0;
	B=0;
	$display ("\n\n***Reset Test is applied***\n\n");
	display_stimulus();
	@(negedge clk);
	@(negedge clk);
	compare();
	$display ("\n\n***Reset Test is ended***\n\n");

	reset = 0;
	@(negedge clk);

	$display ("\n\n*** Random Functionality Tests for multiplier with signed inputs are applied***\n\n");
	repeat (1000) begin
		A = $urandom( );
		B = $urandom( );
		display_stimulus();
		@(negedge clk);
		@(negedge clk);
		compare();
	end
	$display ("\n\n***Random Functionality Tests for multiplier with signed inputs are ended***\n\n");

	reset =1;
	A=0;
	B=0;
	$display ("\n\n***Reset Test is applied***\n\n");
	display_stimulus();
	@(negedge clk);
	@(negedge clk);
	compare();
	$display ("\n\n***Reset Test is ended***\n\n");
	
	reset=0;
	@(negedge clk);
	$display ("\n\n***Reset Value is set zero again***\n\n");

	$display ("\n\n***Directed Functionality Test for multiplier is applied***\n\n");
	A = 20'hfffff;
	B = 18'h3ffff;
	display_stimulus();
	@(negedge clk);
	@(negedge clk);
	compare();
	$display ("\n\n***Directed Functionality Test for multiplier is ended***\n\n");
	
	if(mismatch == 0)
        $display("\n**** All Comparison Matched ***\nSimulation Passed");
    else
        $display("%0d comparison(s) mismatched\nERROR: SIM: Simulation Failed", mismatch);
	$finish;
end
	

task compare();
 	$display("*** Comparing ***");
  	if(P !== P_netlist) begin
    	$display("Data Mismatch. Golden: %0d, Netlist: %0d, Time: %0t", P, P_netlist, $time);
    	mismatch = mismatch+1;
 	end
  	else
  		$display("Data Matched. Golden: %0d, Netlist: %0d, Time: %0t", P, P_netlist, $time);
endtask

task display_stimulus();
	$display ($time,," Test stimulus is: A=%0d, B=%0d", A, B);
	$display ($time,," Test stimulus is: A=%0d, B=%0d", A, B);
endtask

initial begin
    $dumpfile("tb.vcd");
    $dumpvars;
end
endmodule