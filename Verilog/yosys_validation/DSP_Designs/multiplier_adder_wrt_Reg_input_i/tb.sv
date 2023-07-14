module co_sim_multiplier_adder_wrt_Reg_input_i;
	reg signed [19:0] A;
	reg signed [17:0] B;
	reg clk, reset, subtract_i, Reg_input_i ;
	reg [3:0] acc_fir;
	reg signed [19:0] shift_out;
	wire signed [37:0] P;
	wire signed [37:0] P_netlist;

	integer mismatch=0;

multiplier_adder_wrt_Reg_input_i golden(.*);
multiplier_adder_wrt_Reg_input_i_post_synth netlist(.*, .P(P_netlist));

//clock initialization
initial begin
    clk = 1'b0;
    forever #5 clk = ~clk;
end
initial begin
	reset = 0;
	A=0;
	B=0;
	acc_fir=0;
	subtract_i = 0;
	Reg_input_i =1;
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

	$display ("\n\n***Directed Functionality Test is applied for P = (A << acc_fir) + A*B***\n\n");
	A = 20'h7ffff;
	B = 18'h1ffff;
	@(negedge clk);
	display_stimulus();
	@(negedge clk);
	compare();
	$display ("\n\n***Directed Functionality Test for  P = (A << acc_fir) + A*B is ended***\n\n");

	$display ("\n\n***Directed Functionality Test is applied for P = (A << acc_fir) + A*B***\n\n");
	A = 20'h80000;
	B = 18'h40000;
	@(negedge clk);
	display_stimulus();
	@(negedge clk);
	compare();
	$display ("\n\n***Directed Functionality Test for  P = (A << acc_fir) + A*B is ended***\n\n");

	$display ("\n\n***Directed Functionality Test is applied for P = (A << acc_fir) + A*B***\n\n");
	A = 20'hfffff;
	B = 18'h3ffff;
	@(negedge clk);
	display_stimulus();
	@(negedge clk);
	compare();
	$display ("\n\n***Directed Functionality Test for  P = (A << acc_fir) + A*B is ended***\n\n");

	$display ("\n\n*** Random Functionality Tests with signed inputs are applied for  P = (A << acc_fir) + A*B***\n\n");
	A = $random( );
	B = $random( );
	acc_fir = $urandom( );
	@(negedge clk);
	repeat (300) begin
		display_stimulus();
		@(negedge clk);
		compare();
	end
	$display ("\n\n***Random Functionality Tests with signed inputs for  P = (A << acc_fir) + A*B are ended***\n\n");

	reset =1;
	A=0;
	B=0;
	$display ("\n\n***Reset Test is applied***\n\n");
	display_stimulus();
	@(negedge clk);
	@(negedge clk);
	compare();
	$display ("\n\n***Reset Test is ended***\n\n");

	subtract_i = 1;
	reset=0;
	@(negedge clk);
	$display ("\n\n***Reset Value is set zero again***\n\n");

	$display ("\n\n*** Random Functionality Tests with signed inputs are applied for  P = (A << acc_fir) - A*B***\n\n");
	A = $random( );
	B = $random( );
	acc_fir = $urandom( );
	@(negedge clk);
	repeat (300) begin
		display_stimulus();
		@(negedge clk);
		compare();
	end
	$display ("\n\n***Random Functionality Tests with signed inputs for  P = (A << acc_fir) - A*B are ended***\n\n");

	subtract_i = 0;
	Reg_input_i = 0;
	@(negedge clk);
	$display ("\n\n***Directed Functionality Test is applied for P = (A << acc_fir) + A*B with Reg_input_i=0***\n\n");
	A = 5;
	B = 2;
	acc_fir = 2;
	display_stimulus();
	@(negedge clk);
	compare();
	$display ("\n\n***Directed Functionality Test for  P = (A << acc_fir) + A*B is ended with Reg_input_i=0***\n\n");

	$display ("\n\n*** Random Functionality Tests with signed inputs are applied for  P = (A << acc_fir) + A*B  with Reg_input_i=0***\n\n");
	A = $random( );
	B = $random( );
	acc_fir = $urandom( );
	repeat (300) begin
		display_stimulus();
		@(negedge clk);
		compare();
	end
	$display ("\n\n***Random Functionality Tests with signed inputs for  P = (A << acc_fir) + A*B with Reg_input_i=0 are ended***\n\n");

	subtract_i = 1;
	$display ("\n\n*** Random Functionality Tests with signed inputs are applied for  P = (A << acc_fir) - A*B with Reg_input_i=0***\n\n");
	A = $random( );
	B = $random( );
	acc_fir = $urandom( );
	repeat (300) begin
		display_stimulus();
		@(negedge clk);
		compare();
	end
	$display ("\n\n***Random Functionality Tests with signed inputs for  P = (A << acc_fir) - A*B with Reg_input_i=0 are ended***\n\n");

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