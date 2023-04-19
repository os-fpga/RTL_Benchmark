module co_sim_complex_multiplier #(parameter A_WIDTH = 20, B_WIDTH = 18);
	reg clk, reset;
 	reg signed [ A_WIDTH-1:0] ar, ai;
 	reg signed [ B_WIDTH-1:0] br, bi;
 	wire signed [ A_WIDTH + B_WIDTH:0] pr, pi;
	
 	wire signed [ A_WIDTH + B_WIDTH:0] pr_netlist, pi_netlist;
	

	integer mismatch=0;

complex_multiplier golden(.*);
complex_multiplier_post_synth netlist(.*, .pr(pr_netlist) ,. pi(pi_netlist));

//clock initialization
initial begin
    clk = 1'b0;
    forever #5 clk = ~clk;
end
initial begin
	reset = 0;
	@(negedge clk);
	reset = 1;
	ar=0;
	ai=0;
	bi=0;
	br=0;
	$display ("\n\n***Reset Test is applied***\n\n");
	display_stimulus();
	@(negedge clk);
	@(negedge clk);
	@(negedge clk);
	@(negedge clk);
	compare();
	$display ("\n\n***Reset Test is ended***\n\n");

	reset = 0;
	@(negedge clk);

	$display ("\n\n*** Random Functionality Tests for multiplier with signed inputs are applied***\n\n");
	repeat (1000) begin
		ar = $random( );
		br = $random( );
		ai = $random( );
		bi = $random( );
		display_stimulus();
		@(negedge clk);
		@(negedge clk);
		@(negedge clk);
		@(negedge clk);
		compare();
	end
	$display ("\n\n***Random Functionality Tests for multiplier with signed inputs are ended***\n\n");

	reset =1;
	ar=0;
	br=0;
	ai=0;
	bi=0;
	$display ("\n\n***Reset Test is applied***\n\n");
	display_stimulus();
	@(negedge clk);
	@(negedge clk);
	@(negedge clk);
	@(negedge clk);
	compare();
	$display ("\n\n***Reset Test is ended***\n\n");
	
	reset=0;
	@(negedge clk);
	$display ("\n\n***Reset Value is set zero again***\n\n");

	$display ("\n\n***Directed Functionality Test for multiplier is applied***\n\n");
	ar = 20'h7ffff;
	br = 18'h1ffff;
	ai = 20'h7ffff;
	bi = 18'h1ffff;
	display_stimulus();
	@(negedge clk);
	@(negedge clk);
	@(negedge clk);
	@(negedge clk);
	compare();
	$display ("\n\n***Directed Functionality Test for multiplier is ended***\n\n");

	$display ("\n\n***Directed Functionality Test for multiplier is applied***\n\n");
	ar = 20'h80000;
	br = 18'h20000;
	ai = 20'h80000;
	bi = 18'h20000;
	display_stimulus();
	@(negedge clk);
	@(negedge clk);
	@(negedge clk);
	@(negedge clk);
	compare();
	$display ("\n\n***Directed Functionality Test for multiplier is ended***\n\n");

	$display ("\n\n***Directed Functionality Test for multiplier is applied***\n\n");
	ar = 20'hfffff;
	br = 18'h3ffff;
	ai = 20'hfffff;
	bi = 18'h3ffff;
	display_stimulus();
	@(negedge clk);
	@(negedge clk);
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
  	if((pr !== pr_netlist) || (pi !== pi_netlist)) begin
    	$display("Data Mismatch. pr Golden: %0d, pr Netlist: %0d, Time: %0t", pr, pr_netlist, $time);
		$display("Data Mismatch. pi Golden: %0d, pi Netlist: %0d, Time: %0t", pi, pi_netlist, $time);
    	mismatch = mismatch+1;
 	end
  	else begin
		$display("Data Matched. pr Golden: %0d, pr Netlist: %0d, Time: %0t", pr, pr_netlist, $time);
  		$display("Data Matched. pi Golden: %0d, pi Netlist: %0d, Time: %0t", pi, pi_netlist, $time);
	end
endtask

task display_stimulus();
	$display ($time,," Test stimulus is: ar=%0d, br=%0d, ai=%0d, bi=%0d", ar, br, ai, bi);
endtask

initial begin
    $dumpfile("tb.vcd");
    $dumpvars;
end
endmodule