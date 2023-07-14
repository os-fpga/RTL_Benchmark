module co_sim_input_to_adder_and_mul_A_input_wrt_feedback_i;
	reg signed [19:0] A;
	reg signed [17:0] B;
	reg signed [19:0] coef_0_i, coef_1_i, coef_2_i, coef_3_i;
	reg [2:0] feedback_i;
	reg [3:0] acc_fir;
	reg clk, reset, subtract_i ;
	wire signed [37:0] P;
	wire signed [37:0] P_netlist;

	integer mismatch=0;

input_to_adder_and_mul_A_input_wrt_feedback_i golden(.*);
input_to_adder_and_mul_A_input_wrt_feedback_i_post_synth netlist(.*, .P(P_netlist));

//clock initialization
initial begin
    clk = 1'b0;
    forever #5 clk = ~clk;
end
initial begin
	reset = 0;
	A=0;
	B=0;
	coef_0_i = 0;
	coef_1_i = 0;
	coef_2_i = 0;
	coef_3_i = 0;
	acc_fir = 0;
	feedback_i = 0;
	subtract_i = 0;
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
	A = 20'h7ffff;
	B = 18'h1ffff;
	display_stimulus();
	@(negedge clk);
	@(negedge clk);
	compare();
	$display ("\n\n***Directed Functionality Test for P = P + A*B is ended***\n\n");

	$display ("\n\n***Directed Functionality Test is applied for P = P + A*B***\n\n");
	A = 20'h80000;
	B = 18'h40000;
	display_stimulus();
	@(negedge clk);
	@(negedge clk);
	compare();
	$display ("\n\n***Directed Functionality Test for P = P + A*B is ended***\n\n");

	$display ("\n\n*** Random Functionality Tests with signed inputs are applied for P = P + A*B***\n\n");
	A = $random( );
	B = $random( );
	@(negedge clk);
	repeat (300) begin
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
	@(negedge clk);
	compare();
	$display ("\n\n***Reset Test is ended***\n\n");

	subtract_i = 1;
	reset=0;
	@(negedge clk);
	$display ("\n\n***Reset Value is set zero again***\n\n");

	$display ("\n\n*** Random Functionality Tests with signed inputs are applied for P = P - A*B***\n\n");
	A = $random( );
	B = $random( );
	@(negedge clk);
	repeat (300) begin
		display_stimulus();
		@(negedge clk);
		compare();
	end
	$display ("\n\n*** Random Functionality Tests with signed inputs for P = P - A*B is ended***\n\n");

	feedback_i = 3'd2;
	acc_fir = 1;

	$display ("\n\n*** Random Functionality Tests with signed inputs are applied for P = P - A*B with feedback_i = 3'd2 and acc_fir = 1***\n\n");
	A = $random( );
	B = $random( );
	@(negedge clk);
	repeat (300) begin
		display_stimulus();
		@(negedge clk);
		compare();
	end
	$display ("\n\n*** Random Functionality Tests with signed inputs for P = P - A*B with feedback_i = 3'd2 and acc_fir = 1 is ended***\n\n");

	feedback_i = 3'd3;

	$display ("\n\n*** Random Functionality Tests with signed inputs are applied for P = P - A*B with feedback_i = 3'd3 and acc_fir = 1***\n\n");
	A = $random( );
	B = $random( );
	@(negedge clk);
	repeat (300) begin
		display_stimulus();
		@(negedge clk);
		compare();
	end
	$display ("\n\n*** Random Functionality Tests with signed inputs for P = P - A*B with feedback_i = 3'd3 and acc_fir = 1 is ended***\n\n");


	$display ("\n\n*** Full Randomized Test is applied***\n\n");
	A = $random( );
	B = $random( );
	feedback_i= $urandom( );
	acc_fir = $urandom( );
	subtract_i =$urandom( );
	@(negedge clk);
	repeat (300) begin
		display_stimulus();
		@(negedge clk);#10;
		compare();
	end
	$display ("\n\n*** Full Randomized Test is ended***\n\n");



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