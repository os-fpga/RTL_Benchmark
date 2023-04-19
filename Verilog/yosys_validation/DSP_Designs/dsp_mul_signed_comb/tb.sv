
module co_sim_dsp_mul_signed_comb;
	reg signed [19:0] A;
	reg signed [17:0] B;
	wire signed [37:0] P;
	wire signed [37:0] P_netlist;

	integer mismatch=0;

dsp_mul_signed_comb golden(.*);
dsp_mul_signed_comb_post_synth netlist(.*, .P(P_netlist));

initial begin
	A=0;
	B=0;
	$display ("\n\n*** Random Functionality Tests for multiplier with signed inputs are applied***\n\n");
	repeat (1000) begin
		A = $random( );
		B = $random( );
		#10;
		display_stimulus();
		compare();
		#10;
	end
	$display ("\n\n***Random Functionality Tests for multiplier with signed inputs are ended***\n\n");

	A=0;
	B=0;

	$display ("\n\n***Directed Functionality Test for multiplier is applied***\n\n");
	A = 20'hfffff;
	B = 18'h3ffff;
	#10;
	display_stimulus();
	compare();
	$display ("\n\n***Directed Functionality Test for multiplier is ended***\n\n");
	#100;
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
endtask

initial begin
    $dumpfile("tb.vcd");
    $dumpvars;
end
endmodule