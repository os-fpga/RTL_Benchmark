module co_sim_dsp_mul_unsigned_reg_inf_dsp19x2;
	reg  [9:0] A1;
	reg  [8:0] B1;
	reg  [9:0] A2;
	reg  [8:0] B2;
	reg clk, reset ;
	wire  [37:0] P;
	wire  [37:0] P_netlist;

	integer mismatch=0;

dsp_mul_unsigned_reg_inf_dsp19x2 golden(.*);
dsp_mul_unsigned_reg_inf_dsp19x2_post_synth netlist(.*, .P(P_netlist));

//clock initialization
initial begin
    clk = 1'b0;
    forever #5 clk = ~clk;
end
initial begin
	reset = 0;
	@(negedge clk);
	reset = 1;
	A1=0;
	A2=0;
	B1=0;
	B2=0;
	$display ("\n\n***Reset Test is applied***\n\n");
	display_stimulus();
	@(negedge clk);
	@(negedge clk);
	compare();
	$display ("\n\n***Reset Test is ended***\n\n");

	reset = 0;
	@(negedge clk);

	$display ("\n\n*** Random Functionality Tests for multiplier with signed inputs are applied***\n\n");
	repeat (1000) begin
		A1 = $urandom( );
		B1 = $urandom( );
		A2 = $urandom( );
		B2 = $urandom( );
		display_stimulus();
		@(negedge clk);
		@(negedge clk);
		compare();
	end
	$display ("\n\n***Random Functionality Tests for multiplier with signed inputs are ended***\n\n");

	reset =1;
	A1=0;
	B1=0;
	A2=0;
	B2=0;
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
	A1 = 10'hff;
	B1 = 9'h3f;
	A2 = 10'hff;
	B2 = 9'h3f;
	display_stimulus();
	@(negedge clk);
	@(negedge clk);
	compare();
	$display ("\n\n***Directed Functionality Test for multiplier is ended***\n\n");
	
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
	$display ($time,," Test stimulus is: A=%0d, B=%0d", A1, B1);
	$display ($time,," Test stimulus is: A=%0d, B=%0d", A2, B2);
endtask

initial begin
    $dumpfile("tb.vcd");
    $dumpvars;
end
endmodule