module co_sim_dsp_mul_unsigned_comb;
	reg [143:0] A;
	reg [143:0] B;
	wire [143:0] Result;

	wire [143:0] Result_netlist;

	integer mismatch=0;

matrix_mult_3x3 golden(.*);
matrix_mult_3x3_post_synth netlist(.*, .Result(Result_netlist));

initial begin
	A=0;
	B=0;
	$display ("\n\n*** Random Functionality Tests for multiplier with signed inputs are applied***\n\n");
	repeat (1000) begin
		A = $urandom( );
		B = $urandom( );
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
  	if(Result !== Result_netlist) begin
    	$display("Data Mismatch. Golden: %0d, Netlist: %0d, Time: %0t", Result, Result_netlist, $time);
    	mismatch = mismatch+1;
 	end
  	else
  		$display("Data Matched. Golden: %0d, Netlist: %0d, Time: %0t", Result, Result_netlist, $time);
endtask

task display_stimulus();
	$display ($time,," Test stimulus is: A=%0d, B=%0d", A, B);
endtask

initial begin
    $dumpfile("tb.vcd");
    $dumpvars;
end
endmodule