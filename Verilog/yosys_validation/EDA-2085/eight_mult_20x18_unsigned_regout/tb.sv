module co_sim_dsp_mul_unsigned_reg;
	reg  [19:0] A;
	reg  [17:0] B;
	reg  clock0, reset ;
	wire  [37:0] Y;
	reg id;
	wire  [37:0] Y_netlist;

	integer mismatch=0;
	
eight_mult_20x18_unsigned_regout golden(.*);
eight_mult_20x18_unsigned_regout_post_synth netlist(.*, .Y(Y_netlist));

//clock initialization
initial begin
    clock0 = 1'b0;
    forever #5 clock0 = ~clock0;
end
initial begin
	reset = 0;
	@(negedge clock0);
	reset = 1;
	A=0;
	B=0;
	id=0;
	$display ("\n\n***Reset Test is applied***\n\n");
	display_stimulus();
	@(negedge clock0);
	@(negedge clock0);
	compare();
	$display ("\n\n***Reset Test is ended***\n\n");

	reset = 0;
	@(negedge clock0);

	$display ("\n\n*** Random Functionality Tests for multiplier with signed inputs are applied***\n\n");
	repeat (1000) begin
		A = $urandom( );
		B = $urandom( );
		display_stimulus();
		@(negedge clock0);
		@(negedge clock0);
		compare();
	end
	$display ("\n\n***Random Functionality Tests for multiplier with signed inputs are ended***\n\n");

	reset =1;
	A=0;
	B=0;
	$display ("\n\n***Reset Test is applied***\n\n");
	display_stimulus();
	@(negedge clock0);
	@(negedge clock0);
	compare();
	$display ("\n\n***Reset Test is ended***\n\n");
	
	reset=0;
	@(negedge clock0);
	$display ("\n\n***Reset Value is set zero again***\n\n");

	$display ("\n\n***Directed Functionality Test for multiplier is applied***\n\n");
	A = 20'hfffff;
	B = 18'h3ffff;
	display_stimulus();
	@(negedge clock0);
	@(negedge clock0);
	compare();
	$display ("\n\n***Directed Functionality Test for multiplier is ended***\n\n");
	
	@(negedge clock0);
	reset = 1;
	A=0;
	B=0;
	id=1;
	$display ("\n\n***Reset Test is applied***\n\n");
	display_stimulus();
	@(negedge clock0);
	@(negedge clock0);
	compare();
	$display ("\n\n***Reset Test is ended***\n\n");

	reset = 0;
	@(negedge clock0);

	$display ("\n\n*** Random Functionality Tests for multiplier with signed inputs are applied***\n\n");
	repeat (1000) begin
		A = $urandom( );
		B = $urandom( );
		display_stimulus();
		@(negedge clock0);
		@(negedge clock0);
		compare();
	end
	$display ("\n\n***Random Functionality Tests for multiplier with signed inputs are ended***\n\n");

	reset =1;
	A=0;
	B=0;
	$display ("\n\n***Reset Test is applied***\n\n");
	display_stimulus();
	@(negedge clock0);
	@(negedge clock0);
	compare();
	$display ("\n\n***Reset Test is ended***\n\n");
	
	reset=0;
	@(negedge clock0);
	$display ("\n\n***Reset Value is set zero again***\n\n");

	$display ("\n\n***Directed Functionality Test for multiplier is applied***\n\n");
	A = 20'hfffff;
	B = 18'h3ffff;
	display_stimulus();
	@(negedge clock0);
	@(negedge clock0);
	compare();

	$display ("\n\n***Directed Functionality Test for multiplier is applied***\n\n");
	if(mismatch == 0)
        $display("\n**** All Comparison Matched ***\nSimulation Passed");
    else
        $display("%0d comparison(s) mismatched\nERROR: SIM: Simulation Failed", mismatch);
	$finish;
end
	

task compare();
 	$display("*** Comparing ***");
  	if(Y !== Y_netlist) begin
    	$display("Data Mismatch. Golden: %0d, Netlist: %0d, Time: %0t", Y, Y_netlist, $time);
    	mismatch = mismatch+1;
 	end
  	else
  		$display("Data Matched. Golden: %0d, Netlist: %0d, Time: %0t", Y, Y_netlist, $time);
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