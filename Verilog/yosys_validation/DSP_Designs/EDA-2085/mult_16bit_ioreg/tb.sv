module co_sim_dsp_mul_unsigned_reg;
	reg  [15:0] a;
	reg  [15:0] b;
	reg  clock0, reset ;
	wire  [31:0] out;

	wire  [31:0] out_netlist;

	integer mismatch=0;
	
mult_16bit_ioreg golden(.*);
mult_16bit_ioreg_post_synth netlist(.*, .out(out_netlist));

//clock initialization
initial begin
    clock0 = 1'b0;
    forever #5 clock0 = ~clock0;
end
initial begin
	reset = 0;
	@(negedge clock0);
	reset = 1;
	a=0;
	b=0;
	$display ("\n\n***Reset Test is applied***\n\n");
	display_stimulus();
	@(negedge clock0);
	@(negedge clock0);
	compare();
	$display ("\n\n***Reset Test is ended***\n\n");

	reset = 0;
	@(negedge clock0);

	$display ("\n\n*** Random Functionality Tests for multiplier with signed inputs are applied***\n\n");
	repeat (1000) begin
		a = $urandom( );
		b = $urandom( );
		display_stimulus();
		@(negedge clock0);
		@(negedge clock0);
		compare();
	end
	$display ("\n\n***Random Functionality Tests for multiplier with signed inputs are ended***\n\n");

	$display ("\n\n***Directed Functionality Test for multiplier is applied***\n\n");
	if(mismatch == 0)
        $display("\n**** All Comparison Matched ***\nSimulation Passed");
    else
        $display("%0d comparison(s) mismatched\nERROR: SIM: Simulation Failed", mismatch);
	$finish;
end
	

task compare();
 	$display("*** Comparing ***");
  	if(out !== out_netlist) begin
    	$display("Data Mismatch. Golden: %0d, Netlist: %0d, Time: %0t", out, out_netlist, $time);
    	mismatch = mismatch+1;
 	end
  	else
  		$display("Data Matched. Golden: %0d, Netlist: %0d, Time: %0t", out, out_netlist, $time);
endtask

task display_stimulus();
	$display ($time,," Test stimulus is: A=%0d, B=%0d", a, b);
	$display ($time,," Test stimulus is: A=%0d, B=%0d", a, b);
endtask

initial begin
    $dumpfile("tb.vcd");
    $dumpvars;
end
endmodule