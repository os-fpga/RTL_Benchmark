module co_sim_dsp_eight_mult #
    (parameter WIDTH = 9);
    reg clk, areset;
    reg signed [WIDTH-1:0] a0, a1, a2, a3;
	reg signed [WIDTH-1:0] b0, b1, b2, b3;
	reg signed [WIDTH-1:0] a4, a5, a6, a7;
	reg signed [WIDTH-1:0] b4, b5, b6, b7;
	wire signed [2*WIDTH+2:0] result;

    wire signed [2*WIDTH+2:0] result_netlist;

	integer mismatch=0;

dsp_eight_mult golden(.*);
dsp_eight_mult netlist(.* ,. result(result_netlist));

//clock initialization
initial begin
    clk = 1'b0;
    forever #5 clk = ~clk;
end
initial begin
	areset = 0;
	a0=0;
    a1=0;
    a2=0;
    a3=0;
	b0=0;
    b1=0;
    b2=0;
    b3=0;
	a4=0;
    a5=0;
    a6=0;
    a7=0;
	b4=0;
    b5=0;
    b6=0;
    b7=0;
	@(negedge clk);
	areset = 1;
	$display ("\n\n***Reset Test is applied***\n\n");
	display_stimulus();
	@(negedge clk);
	@(negedge clk);
	compare();
	$display ("\n\n***Reset Test is ended***\n\n");

	areset = 0;
	@(negedge clk);

	$display ("\n\n***Directed Functionality Test is applied ***\n\n");
	a0 = 1;
    a1 = 5;
    a2 = 2;
    a3 = 4;
	a4 = 1;
    a5 = 5;
    a6 = 2;
    a7 = 4;
	b0 = 2;
    b1 = 3;
    b2 = 6;
    b3 = 7;
	b4 = 7;
	b5 = 7;
	b6 = 7;
	b7 = 7;
	display_stimulus();
	repeat (4) @(negedge clk);
	compare();
	$display ("\n\n***Directed Functionality Test is ended***\n\n");

	$display ("\n\n***Directed Functionality Test is applied ***\n\n");
	a0 = 18'h1ffff;
    a1 = 18'h1ffff;
    a2 = 18'h1ffff;
    a3 = 18'h20000;
	b0 = 18'h1ffff;
    b1 = 18'h20000;
    b2 = 18'h1ffff;
    b3 = 18'h1ffff;
	display_stimulus();
	repeat (4) @(negedge clk);
	compare();
	$display ("\n\n***Directed Functionality Test is ended***\n\n");

	$display ("\n\n***Directed Functionality Test is applied ***\n\n");
	a0 = 18'h1ffff;
    a1 = 18'h1ffff;
    a2 = 18'h1ffff;
    a3 = 18'h1ffff;
    b0 = 18'h1ffff;
    b1 = 18'h1ffff;
    b2 = 18'h1ffff;
    b3 = 18'h1ffff;
	display_stimulus();
	repeat (4) @(negedge clk);
	compare();
	$display ("\n\n***Directed Functionality Test is ended***\n\n");

	$display ("\n\n***Directed Functionality Test is applied ***\n\n");
	a0 = 18'h20000;
    a1 = 18'h20000;
    a2 = 18'h20000;
    a3 = 18'h20000;
    b0 = 18'h20000;
    b1 = 18'h20000;
    b2 = 18'h20000;
    b3 = 18'h20000;
	display_stimulus();
	repeat (4) @(negedge clk);
	compare();
	$display ("\n\n***Directed Functionality Test is ended***\n\n");


	$display ("\n\n*** Random Functionality Tests are applied***\n\n");
	a0 = $random( );
    a1 = $random( );
	a2 = $random( );
    a3 = $random( );
	b0 = $random( );
	b1 = $random( );
    b2 = $random( );
	b3 = $random( );
	a4 = $random( );
    a5 = $random( );
    a6 = $random( );
    a7 = $random( );
	b4 = $random( );
	b5 = $random( );
    b6 = $random( );
	b7 = $random( );
	repeat (600) begin
		display_stimulus();
		@(negedge clk);
		compare();
	end
	$display ("\n\n***Random Functionality Tests are ended***\n\n");

	$display ("\n\n*** Random Functionality Tests are applied***\n\n");
	repeat (600) begin
		a0 = $random( );
        a1 = $random( );
	    a2 = $random( );
        a3 = $random( );
	    b0 = $random( );
	    b1 = $random( );
        b2 = $random( );
	    b3 = $random( );
		a4 = $random( );
    	a5 = $random( );
    	a6 = $random( );
    	a7 = $random( );
		b4 = $random( );
		b5 = $random( );
    	b6 = $random( );
		b7 = $random( );
		display_stimulus();
		@(negedge clk);
		compare();
	end
	$display ("\n\n***Random Functionality Tests are ended***\n\n");

	if(mismatch == 0)
        $display("\n**** All Comparison Matched ***\nSimulation Passed");
    else
        $display("%0d comparison(s) mismatched\nERROR: SIM: Simulation Failed", mismatch);
	#100;
	$finish;
end
	

task compare();
 	$display("*** Comparing ***");
  	if(result !== result_netlist) begin
    	$display("Data Mismatch. Golden: %0d, Netlist: %0d, Time: %0t", result, result_netlist, $time);
    	mismatch = mismatch+1;
 	end
  	else
  		$display("Data Matched. Golden: %0d, Netlist: %0d, Time: %0t", result, result_netlist, $time);
endtask

task display_stimulus();
	$display ($time,," Test stimulus is: a0=%0d, a1=%0d, a2=%0d, a3=%0d, b0=%0d, b1=%0d, b2=%0d, b3=%0d", a0, a1, a2, a3, b0, b1, b2, b3);
endtask

initial begin
    $dumpfile("tb.vcd");
    $dumpvars;
end
endmodule