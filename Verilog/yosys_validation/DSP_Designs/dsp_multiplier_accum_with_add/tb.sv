module co_sim_dsp_multiplier_accum_with_add;
	reg signed [31:0] A, B, C, D;
	reg clk, reset, sel_c_or_p ;
	wire signed [63:0] P;
	wire signed [63:0] P_netlist;

	integer mismatch=0;

dsp_multiplier_accum_with_add golden(.*);
dsp_multiplier_accum_with_add_post_synth netlist(.*, .P(P_netlist));

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
	display_stimulus();
    @(negedge clk);
	@(negedge clk);
    compare();
    $display ("\n\n***Reset Test is ended***\n\n");
    @(negedge clk);

    $display ("\n\n*** Random Functionality Tests of output P=Bx(A+D)+C with sel_c_or_p=1 are applied***\n\n");
    repeat (700) begin
		reset = 0;
		input_randomized_data();
		display_stimulus();
		@(negedge clk);
		@(negedge clk);
      	compare();
    end   
	$display ("\n\n***Random Functionality Tests of output P=Bx(A+D)+C with sel_c_or_p=1 is ended***\n\n");

    reset =1;
	sel_c_or_p=1;
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

	$display ("\n\n***Directed Functionality Test of output P = P + Bx(A+D) with sel_c_or_p=0 is applied***\n\n");
	sel_c_or_p=0;
	A = 5;
	B = 2;
	C = 3;
	D = 4;
	display_stimulus();
    @(negedge clk);
	@(negedge clk);
    compare();
    $display ("\n\n***Directed Functionality Test of output P = P + Bx(A+D) with sel_c_or_p=0 is ended***\n\n");

	$display ("\n\n***Random Functionality Tests of output P = P + Bx(A+D) with sel_c_or_p=0 are applied***\n\n");
	repeat (700) begin
		input_randomized_data();
		display_stimulus();
		@(negedge clk);
      	compare();
      	$display ("\n\n***Random Functionality Tests of output P = P + Bx(A+D) with sel_c_or_p=0 are ended***\n\n");
    end

	$display ("\n\n***Directed Functionality Test of output P=Bx(A+D)+C with sel_c_or_p=1 is applied***\n\n");
	sel_c_or_p=1;
	A = 32'hffffffff;
	B = 32'hffffffff;
	C = 32'hffffffff;
	D = 32'hffffffff;
	display_stimulus();
    @(negedge clk);
	@(negedge clk);
    compare();
    $display ("\n\n***Directed Functionality Test of output P=Bx(A+D)+C with sel_c_or_p=1 is ended***\n\n");

	$display ("\n\n***Directed Functionality Test of output P=Bx(A+D)+C with sel_c_or_p=1 is applied***\n\n");
	sel_c_or_p=1;
	A = 32'h7fffffff;
	B = 32'h7fffffff;
	C = 32'h7fffffff;
	D = 32'h7fffffff;
	display_stimulus();
    @(negedge clk);
	@(negedge clk);
    compare();
    $display ("\n\n***Directed Functionality Test of output P=Bx(A+D)+C with sel_c_or_p=1 is ended***\n\n");

	$display ("\n\n***Directed Functionality Test of output P=Bx(A+D)+C with sel_c_or_p=1 is applied***\n\n");
	sel_c_or_p=1;
	A = 32'h80000000;
	B = 32'h80000000;
	C = 32'h80000000;
	D = 32'h80000000;
	display_stimulus();
    @(negedge clk);
	@(negedge clk);
    compare();
    $display ("\n\n***Directed Functionality Test of output P=Bx(A+D)+C with sel_c_or_p=1 is ended***\n\n");

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
	$display ($time,,"reset=%0b, clk=%0b, sel_c_or_p=%0d, A=%0d, B=%0d, C=%0d, D=%0d, P=%0d",reset, clk, sel_c_or_p, A, B, C, D, P);
	$display ($time,,"reset=%0b, clk=%0b, sel_c_or_p=%0d, A=%0d, B=%0d, C=%0d, D=%0d, P_netlist=%0d",reset, clk, sel_c_or_p, A, B, C, D, P_netlist);
endtask

initial begin
    $dumpfile("tb.vcd");
    $dumpvars;
end
endmodule