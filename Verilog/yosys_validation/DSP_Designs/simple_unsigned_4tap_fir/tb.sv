module co_sim_simple_unsigned_4tap_fir#(
    parameter INPUT_WIDTH = 14,
    parameter OUTPUT_WIDTH = 28) ();
    reg clk, reset;
    reg [INPUT_WIDTH-1:0] x;
    wire [OUTPUT_WIDTH-1:0] y;
	wire [OUTPUT_WIDTH-1:0] y_netlist;

	integer mismatch=0;

simple_unsigned_4tap_fir golden(.*);
simple_unsigned_4tap_fir_post_synth netlist(.* ,. y(y_netlist));

//clock initialization
initial begin
    clk = 1'b0;
    forever #5 clk = ~clk;
end
initial begin
	reset = 0;
	x=0;
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

	$display ("\n\n***Directed Functionality Test is applied ***\n\n");
	x = 1;
	display_stimulus();
	repeat (4) @(negedge clk);
	compare();
	$display ("\n\n***Directed Functionality Test is ended***\n\n");

	$display ("\n\n***Directed Functionality Test is applied ***\n\n");
	x = 2;
	display_stimulus();
	repeat (4) @(negedge clk);
	compare();
	$display ("\n\n***Directed Functionality Test is ended***\n\n");

	$display ("\n\n***Directed Functionality Test is applied ***\n\n");
	x = 3;
	display_stimulus();
	repeat (4) @(negedge clk);
	compare();
	$display ("\n\n***Directed Functionality Test is ended***\n\n");

	$display ("\n\n***Directed Functionality Test is applied ***\n\n");
	x = 14'h3fff;
	display_stimulus();
	repeat (4) @(negedge clk);
	compare();
	$display ("\n\n***Directed Functionality Test is ended***\n\n");


	$display ("\n\n*** Random Functionality Tests are applied***\n\n");
	x = $random( );
	repeat (600) begin
		display_stimulus();
		repeat (4) @(negedge clk);
		compare();
	end
	$display ("\n\n***Random Functionality Tests are ended***\n\n");

	$display ("\n\n*** Random Functionality Tests are applied***\n\n");
	repeat (600) begin
		x = $random( );
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
  	if(y !== y_netlist) begin
    	$display("Data Mismatch. Golden: %0d, Netlist: %0d, Time: %0t", y, y_netlist, $time);
    	mismatch = mismatch+1;
 	end
  	else
  		$display("Data Matched. Golden: %0d, Netlist: %0d, Time: %0t", y, y_netlist, $time);
endtask

task display_stimulus();
	$display ($time,," Test stimulus is: x=%0d", x);
endtask

initial begin
    $dumpfile("tb.vcd");
    $dumpvars;
end
endmodule