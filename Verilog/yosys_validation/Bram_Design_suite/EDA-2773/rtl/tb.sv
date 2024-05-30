//`include "../../rtl/design1_5_5_top.v"
// `include "../../design1_5_5_top_netlist.v"
module co_sim_design122_12_5_top #(parameter WIDTH=32, CHANNEL=12);
	reg clk, reset;
	reg  [WIDTH-1:0] inpt;
	wire  [WIDTH-1:0] outpt;
	wire  [WIDTH-1:0] out_netlist;

	integer mismatch=0;

design122_12_5_top golden (.clk(clk),.rst(reset),.in(inpt),.out(outpt));
    `ifdef PNR
    `else
    design122_12_5_top_post_synth netlist(.clk(clk),.rst(reset),.in(inpt),.out(out_netlist));
    `endif

//clock initialization
initial begin
    clk = 1'b0;
    forever #1 clk = ~clk;
end


// initial begin
//     reset = 1'b1;
//     #10
//     reset = 1'b0;
// end

initial begin
	reset = 1;
	inpt=0;
	@(negedge clk);
	// reset = 1;
	// inpt=0;
	$display ("\n\n***Reset Test is applied***\n\n");
	display_stimulus();
	@(negedge clk);
	@(negedge clk);
	compare();
	$display ("\n\n***Reset Test is ended***\n\n");

	reset = 0;
	@(negedge clk);

	$display ("\n\n*** Random Functionality Tests for multiplier with  inputs are applied***\n\n");
	repeat (1000) begin
		inpt = $random( );
		display_stimulus();
		@(negedge clk);
		@(negedge clk);
		compare();
	end
	$display ("\n\n***Random Functionality Tests for multiplier with  inputs are ended***\n\n");

	reset =1;
	inpt=0;
	$display ("\n\n***Reset Test is applied***\n\n");
	display_stimulus();
	@(negedge clk);
	@(negedge clk);
	compare();
	$display ("\n\n***Reset Test is ended***\n\n");
	
	reset=0;
	@(negedge clk);
	$display ("\n\n***Reset Value is set zero again***\n\n");

	$display ("\n\n***Directed Functionality Test for multiplier is applied***\n\n");
	inpt = 32'habcdefab;
	display_stimulus();
	@(negedge clk);
	@(negedge clk);
	compare();
	$display ("\n\n***Directed Functionality Test for multiplier is ended***\n\n");

	if(mismatch == 0)
    	$display("\n**** All Comparison Matched ***\n");
  	else
    	$display("%0d comparison(s) mismatched\nERROR: SIM: Simulation Failed", mismatch);
	$finish;
end
	

task compare();
 	
  	if(outpt !== out_netlist) begin
    	$display("Data Mismatch. Golden: %0d, Netlist: %0d, Time: %0t", outpt, out_netlist, $time);
    	mismatch = mismatch+1;
 	end
  	else
  		$display("Data Matched. Golden: %0d, Netlist: %0d, Time: %0t", outpt, out_netlist, $time);
endtask

task display_stimulus();
	$display ($time,," Test stimulus is: inpt=%0d", inpt);
	$display ($time,," Test stimulus is: inpt=%0d", inpt);
endtask


initial begin
    $dumpfile("tb.vcd");
    $dumpvars;
end
endmodule