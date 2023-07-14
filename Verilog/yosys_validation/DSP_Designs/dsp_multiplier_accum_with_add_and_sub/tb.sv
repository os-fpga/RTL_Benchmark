module co_sim_dsp_multiplier_accum_with_add_and_sub;

	reg signed [29:0] A;
	reg signed [17:0] B;
	reg signed [47:0] C;
	reg signed [26:0] D;
	reg clk, reset, sel_c_or_p ;
	reg INMODE;
	reg ALUMODE;
	wire signed [47:0] P;
	wire signed [47:0] P_netlist;

	integer mismatch=0;

dsp_multiplier_accum_with_add_and_sub golden(.*);
dsp_multiplier_accum_with_add_and_sub_post_synth netlist(.*, .P(P_netlist));

//clock initialization
initial begin
    clk = 1'b0;
    forever #5 clk = ~clk;
end

initial begin
    reset =1;
    $display ("\n\n***Reset Test is applied***\n\n");
	A=0;
	B=0;
	C=0;
	D=0;
    sel_c_or_p=1;
    INMODE = 1;
    ALUMODE = 1;
	display_stimulus();
    @(negedge clk);
	@(negedge clk);
	compare();
    $display ("\n\n***Reset Test is ended***\n\n");
    reset = 0;
    @(negedge clk);

    $display ("\n\n*** Random Functionality Tests of output P=Bx(A+D)+C with sel_c_or_p = 1, INMODE = 1 and ALUMODE = 1 are applied***\n\n");
    repeat (200) begin
		input_randomized_data();
		display_stimulus();
		@(negedge clk);
		@(negedge clk);
      	compare();
    end
    $display ("\n\n***Random Functionality Tests of output P=Bx(A+D)+C with sel_c_or_p = 1, INMODE = 1 and ALUMODE = 1 are ended***\n\n");

    reset =1;
	sel_c_or_p=1;
	INMODE = 0;
	ALUMODE = 0;
	A=0;
	B=0;
	C=0;
	D=0;
	$display ("\n\n***Reset Test is applied***\n\n");
	display_stimulus();
	@(negedge clk);
	@(negedge clk);
    compare();
    $display ("\n\n***Reset Test is ended***\n\n");
		
	reset=0;
	$display ("\n\n***Reset Value is set zero again***\n\n");

	$display ("\n\n***Directed Functionality Test of output P = P - Bx(A+D) with sel_c_or_p = 0, INMODE = 1 and ALUMODE = 1 is applied***\n\n");
	sel_c_or_p=0;
	INMODE = 1;
	ALUMODE = 1;
	A = 5;
	B = 2;
	C = 3;
	D = 4;
	display_stimulus();
    @(negedge clk);
	@(negedge clk);
    compare();
    $display ("\n\n***Directed Functionality Test of output P = P - Bx(A+D) with sel_c_or_p = 0, INMODE = 1 and ALUMODE = 1 is ended***\n\n");

	$display ("\n\n***Random Functionality Tests of output P = P + Bx(A+D) with sel_c_or_p = 0, INMODE = 1 and ALUMODE = 1 are applied***\n\n");	
	repeat (200) begin
		input_randomized_data();
		display_stimulus();
		@(negedge clk);
      	compare();
    end
	$display ("\n\n***Random Functionality Tests of output P = P + Bx(A+D) with sel_c_or_p = 0, INMODE = 1 and ALUMODE = 1 are ended***\n\n");

	$display ("\n\n***Directed Functionality Test of output P=Bx(A+D)+C with sel_c_or_p = 1, INMODE = 1 and ALUMODE = 1 is applied***\n\n");
	sel_c_or_p=1;
	A = 30'h1fffffff;
	B = 18'h1ffff;
	C = 48'h7fffffffffff;
	D = 27'h3ffffff;
	display_stimulus();
    @(negedge clk);
	@(negedge clk);
    compare();
    $display ("\n\n***Directed Functionality Test of output P=Bx(A+D)+C with sel_c_or_p = 1, INMODE = 1 and ALUMODE = 1 is ended***\n\n");

	INMODE = 0;
	ALUMODE = 0;
	$display ("\n\n*** Random Functionality Tests of output P=Bx(A-D)-C with sel_c_or_p = 1, INMODE = 0 and ALUMODE = 0 are applied***\n\n");
    repeat (200) begin
		input_randomized_data();
		display_stimulus();
		@(negedge clk);
		@(negedge clk);
      	compare();
    end
    $display ("\n\n***Random Functionality Tests of output P=Bx(A-D)-C with sel_c_or_p = 1, INMODE = 0 and ALUMODE = 0 are ended***\n\n");

	INMODE = 0;
	ALUMODE = 1;
	$display ("\n\n*** Random Functionality Tests of output P=Bx(A-D)+C with sel_c_or_p = 1, INMODE = 0 and ALUMODE = 1 are applied***\n\n");
    repeat (200) begin
		input_randomized_data();
		display_stimulus();
		@(negedge clk);
		@(negedge clk);
      	compare();
    end
    $display ("\n\n***Random Functionality Tests of output P=Bx(A-D)+C with sel_c_or_p = 1, INMODE = 0 and ALUMODE = 1 are ended***\n\n");

	INMODE = 1;
	ALUMODE = 0;
	$display ("\n\n*** Random Functionality Tests of output P=Bx(A+D)-C with sel_c_or_p = 1, INMODE = 1 and ALUMODE = 0 are applied***\n\n");
    repeat (200) begin
		input_randomized_data();
		display_stimulus();
		@(negedge clk);
		@(negedge clk);
      	compare();
    end
    $display ("\n\n***Random Functionality Tests of output P=Bx(A+D)-C with sel_c_or_p = 1, INMODE = 1 and ALUMODE = 0 are ended***\n\n");

	sel_c_or_p = 0;
	$display ("\n\n***Random Functionality Tests of output P = P - Bx(A+D) with sel_c_or_p = 0, INMODE = 1 and ALUMODE = 0 are applied***\n\n");	
	repeat (200) begin
		input_randomized_data();
		display_stimulus();
		@(negedge clk);
      	compare();
    end
	$display ("\n\n***Random Functionality Tests of output P = P - Bx(A+D) with sel_c_or_p = 0, INMODE = 1 and ALUMODE = 0 are ended***\n\n");

	INMODE = 0;
	ALUMODE = 0;
	$display ("\n\n***Random Functionality Tests of output P = P - Bx(A-D) with sel_c_or_p = 0, INMODE = 0 and ALUMODE = 0 are applied***\n\n");	
	repeat (200) begin
		input_randomized_data();
		display_stimulus();
		@(negedge clk);
      	compare();
    end
	$display ("\n\n***Random Functionality Tests of output P = P - Bx(A-D) with sel_c_or_p = 0, INMODE = 0 and ALUMODE = 0 are ended***\n\n");

	INMODE = 0;
	ALUMODE = 1;
	$display ("\n\n***Random Functionality Tests of output P = P + Bx(A-D) with sel_c_or_p = 0, INMODE = 0 and ALUMODE = 1 are applied***\n\n");	
	repeat (200) begin
		input_randomized_data();
		display_stimulus();
		@(negedge clk);
      	compare();
    end
	$display ("\n\n***Random Functionality Tests of output P = P + Bx(A-D) with sel_c_or_p = 0, INMODE = 0 and ALUMODE = 1 are ended***\n\n");
	
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

task input_randomized_data();
	A = $random( );
	B = $random( );
	C = $random( );
	D = $random( );
endtask

task display_stimulus();
	$display ($time,,"reset=%0b, clk=%0b, sel_c_or_p=%0d, INMODE=%0d, ALUMODE=%0d, A=%0d, B=%0d, C=%0d, D=%0d, P=%0d",reset, clk, sel_c_or_p, INMODE, ALUMODE, A, B, C, D, P);
	$display ($time,,"reset=%0b, clk=%0b, sel_c_or_p=%0d, INMODE=%0d, ALUMODE=%0d, A=%0d, B=%0d, C=%0d, D=%0d, P_netlist=%0d",reset, clk, sel_c_or_p, INMODE, ALUMODE, A, B, C, D, P_netlist);
endtask

initial begin
    $dumpfile("tb.vcd");
    $dumpvars;
end
endmodule