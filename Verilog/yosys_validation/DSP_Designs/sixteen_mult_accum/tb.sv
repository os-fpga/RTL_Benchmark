module co_sim_sixteen_mult_accum #
    (parameter WIDTH = 18);
    reg clk, areset;
    reg signed [WIDTH-1:0] a0, a1, a2, a3;
	reg signed [WIDTH-1:0] b0, b1, b2, b3;
	wire signed [2*WIDTH+2:0] w;

    wire signed [2*WIDTH+2:0] w_netlist;

	integer mismatch=0;

sixteen_mult_accum golden(.*);
sixteen_mult_accum netlist(.* ,. w(w_netlist));

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
	b0 = 2;
    b1 = 3;
    b2 = 6;
    b3 = 7;
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
  	if(w !== w_netlist) begin
    	$display("Data Mismatch. Golden: %0d, Netlist: %0d, Time: %0t", w, w_netlist, $time);
    	mismatch = mismatch+1;
 	end
  	else
  		$display("Data Matched. Golden: %0d, Netlist: %0d, Time: %0t", w, w_netlist, $time);
endtask

task display_stimulus();
	$display ($time,," Test stimulus is: a0=%0d, a1=%0d, a2=%0d, a3=%0d, b0=%0d, b1=%0d, b2=%0d, b3=%0d", a0, a1, a2, a3, b0, b1, b2, b3);
endtask

initial begin
    $dumpfile("tb.vcd");
    $dumpvars;
end
endmodule