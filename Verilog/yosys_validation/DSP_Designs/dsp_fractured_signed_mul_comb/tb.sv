
module co_sim_dsp_fractured_signed_mul_comb;
	reg signed [9:0] A, A_fmode;
	reg signed [8:0] B, B_fmode;
	wire signed [37:0] P;
	wire signed [37:0] P_netlist;

	integer mismatch=0;

dsp_fractured_signed_mul_comb golden(.*);
dsp_fractured_signed_mul_comb_post_synth netlist(.*, .P(P_netlist));

initial begin
	{A, B, A_fmode, B_fmode} = 'd0;
	$display("\n\n*** Random Functionality Tests for multiplier with signed inputs are applied***\n\n");
	repeat (1000) begin
		A = $random( );
		B = $random( );
		A_fmode = $random( );
		B_fmode = $random( );
		#10;
		display_stimulus();
		compare();
		#10;
	end
	$display("\n\n***Random Functionality Tests for multiplier with signed inputs are ended***\n\n");

	{A, B, A_fmode, B_fmode} = 'd0;

	$display("\n\n***Directed Functionality Test for multiplier is applied***\n\n");
	A = 10'h3ff;
	B = 9'h1ff;
	A_fmode = 10'h3ff;
	B_fmode = 9'h1ff;
	#10;
	display_stimulus();
	compare();
	$display("\n\n***Directed Functionality Test for multiplier is ended***\n\n");
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