module co_sim_dsp_mul_unsigned_reg_with_accum_shifted_output_inf_dsp19x2;
	reg [9:0] A, A1;
	reg [8:0] B, B1;
	reg clk, reset, subtract;
	reg [5:0] shift_right;
	wire [37:0] P;
	wire [37:0] P_netlist;

	integer mismatch=0;

dsp_mul_unsigned_reg_with_accum_shifted_output_inf_dsp19x2 golden(.*);
dsp_mul_unsigned_reg_with_accum_shifted_output_inf_dsp19x2_post_synth netlist(.*, .P(P_netlist));

//clock initialization
initial begin
    clk = 1'b0;
    forever #5 clk = ~clk;
end
initial begin
	reset = 0;
	{A, A1, B, B1, shift_right} = 'd0;
	subtract = 0;
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

	$display ("\n\n***Directed Functionality Test is applied for P = P + A*B***\n\n");
	A = 10'h3ff;
	B = 9'h1ff;
	shift_right = 6'h1;
	A1 = 10'h3ff;
	B1 = 9'h1ff;
	display_stimulus();
	@(negedge clk);
	compare();
	$display ("\n\n***Directed Functionality Test for P = P + A*B is ended***\n\n");

	$display ("\n\n***Directed Functionality Test is applied for P = P + A*B***\n\n");
	A = 10'h3ff;
	B = 9'h1ff;
	A1 = 10'h3ff;
	B1 = 9'h1ff;
	shift_right = 6'h3f;
	display_stimulus();
	@(negedge clk);
	compare();
	$display ("\n\n***Directed Functionality Test for P = P + A*B is ended***\n\n");

	$display ("\n\n***Directed Functionality Test is applied for P = P + A*B***\n\n");
	A = 10'h1ff;
	B = 9'h0ff;
	A1 = 10'h1ff;
	B1 = 9'h0ff;
	shift_right = 6'h0f;
	display_stimulus();
	@(negedge clk);
	compare();
	$display ("\n\n***Directed Functionality Test for P = P + A*B is ended***\n\n");

	$display ("\n\n*** Random Functionality Tests with signed inputs are applied for P = P + A*B***\n\n");
	{A, B, A1, B1, shift_right} = $urandom( );
	@(negedge clk);
	repeat (600) begin
		display_stimulus();
		@(negedge clk);
		compare();
	end
	$display ("\n\n***Random Functionality Tests with signed inputs for P = P + A*B are ended***\n\n");

	reset =1;
	A=0;
	B=0;
	$display ("\n\n***Reset Test is applied***\n\n");
	display_stimulus();
	@(negedge clk);
	@(negedge clk);
	compare();
	$display ("\n\n***Reset Test is ended***\n\n");

	subtract = 1;
	reset=0;
	@(negedge clk);
	$display ("\n\n***Reset Value is set zero again***\n\n");

	$display ("\n\n*** Random Functionality Tests with signed inputs are applied for P = P - A*B***\n\n");
	A = $urandom( );
	B = $urandom( );
	A1 = $urandom( );
	B1 = $urandom( );
	shift_right = $urandom( );
	@(negedge clk);
	repeat (600) begin
		display_stimulus();
		@(negedge clk);
		compare();
	end
	if(mismatch == 0)
        $display("\n**** All Comparison Matched ***\nSimulation Passed");
    else
        $display("%0d comparison(s) mismatched\nERROR: SIM: Simulation Failed", mismatch);
	$finish;
end
	

task compare();
 	
  	if(P !== P_netlist) begin
    	$display("Data Mismatch. Golden: %0d, Netlist: %0d, Time: %0t", P, P_netlist, $time);
    	mismatch = mismatch+1;
 	end
  	else
  		$display("Data Matched. Golden: %0d, Netlist: %0d, Time: %0t", P, P_netlist, $time);
endtask

task display_stimulus();
	$display ($time,," Test stimulus is: A=%0d, B=%0d, shift_right=%0d", A, B, shift_right);
endtask

initial begin
    $dumpfile("tb.vcd");
    $dumpvars;
end
endmodule