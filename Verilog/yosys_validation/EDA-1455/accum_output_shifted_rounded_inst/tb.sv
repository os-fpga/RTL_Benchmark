module co_sim_accum_output_shifted_rounded_inst;
	reg  [19:0] a;
	reg  [17:0] b;
	reg  [5:0] shift_right;
	reg clk, reset;
	wire  [37:0] z_out;
	reg  [37:0] expected_out;
	reg  [63:0] expected_out2;
	wire  [37:0] z_out_netlist;

	integer mismatch=0;

accum_output_shifted_rounded_inst golden(.*);
accum_output_shifted_rounded_inst_post_synth netlist(.*, .z_out(z_out_netlist));

//clock initialization
initial begin
    clk = 1'b0;
    forever #5 clk = ~clk;
end
initial begin
	{reset, a, b, shift_right, expected_out, expected_out2} = 'd0;
	@(negedge clk);
	reset = 1;
	$display ("\n\n***Reset Test is applied***\n\n");
	display_stimulus();
	@(negedge clk);
	@(negedge clk);
	compare();
	$display ("\n\n***Reset Test is ended***\n\n");

	reset = 0;
	@(negedge clk);

	$display ("\n\n***Directed Functionality Test is applied for shifted right and rounded output of z_out = z_out + a*b***\n\n");
	a = 20'h7;
	b = 18'h3;
	shift_right = 6'h0;
	expected_out2 = (a*b) + expected_out2;
	expected_out = expected_out2>>shift_right;
	display_stimulus();
	@(negedge clk);
	compare();
	$display ("\n\n***Directed Functionality Test for shifted right and rounded output of z_out = z_out + a*b is ended***\n\n");

	$display ("\n\n***Directed Functionality Test is applied for shifted right and rounded output of z_out = z_out + a*b***\n\n");
	a = 20'h1;
	b = 18'h2;
	shift_right = 6'h3;
	expected_out2 = (a*b) + expected_out2;
	expected_out = expected_out2>>shift_right;

	display_stimulus();
	@(negedge clk);
	compare();
	$display ("\n\n***Directed Functionality Test for shifted right and rounded output of z_out = z_out + a*b is ended***\n\n");

	$display ("\n\n***Directed Functionality Test is applied for shifted right and rounded output of z_out = z_out + a*b***\n\n");
	a = 20'h80000;
	b = 18'h20000;
	expected_out2 = (a*b) + expected_out2;
	expected_out = expected_out2>>shift_right;
	display_stimulus();
	@(negedge clk);
	compare();
	$display ("\n\n***Directed Functionality Test for shifted right and rounded output of z_out = z_out + a*b is ended***\n\n");

	$display ("\n\n*** Random Functionality Tests with random inputs are applied for shifted right and rounded output of z_out = z_out + a*b***\n\n");
	
	repeat (600) begin
		a = $urandom( );
		b = $urandom( );
		shift_right = $urandom( );
		expected_out2 = (a*b) + expected_out2;
		expected_out = expected_out2>>shift_right;
		display_stimulus();
		@(negedge clk);
		compare();
	end
	$display ("\n\n***Random Functionality Tests with random inputs for shifted right and rounded output of z_out = z_out + a*b are ended***\n\n");

    if(mismatch == 0)
        $display("\n**** All Comparison Matched ***\nSimulation Passed");
    else
        $display("%0d comparison(s) mismatched\nERROR: SIM: Simulation Failed", mismatch);
	$finish;
end
	

task compare();
	if (expected_out2[shift_right -1]==1) begin //Rounding logic
		expected_out = expected_out + 1'b1;
	end
 	$display("*** Comparing ***");
  	if(z_out !== z_out_netlist || z_out_netlist !== expected_out || z_out !== expected_out) begin
    	$display("Data Mismatch. Golden RTL: %0d, Netlist: %0d, Expected output: %0d, Time: %0t", z_out, z_out_netlist, expected_out, $time);
    	mismatch = mismatch+1;
 	end
  	else
  		$display("Data Matched. Golden RTL: %0d, Netlist: %0d,  Expected output: %0d, Time: %0t", z_out, z_out_netlist, expected_out, $time);
endtask

task display_stimulus();
	$display ($time,," Test stimulus is: a=%0d, b=%0d, shift_right=%0d", a, b, shift_right);
endtask

initial begin
    $dumpfile("tb.vcd");
    $dumpvars;
end
endmodule