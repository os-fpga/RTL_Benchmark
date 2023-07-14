module co_sim_dct ();
	reg [2:0] sel;
  	wire [15:0] y; 
	wire [15:0] y_netlist;

	integer mismatch=0;

dct golden(.*);
dct_post_synth netlist(.* ,. y(y_netlist));

initial begin

	$display ("\n\n***Directed Functionality Test is applied ***\n\n");
	sel = 0;
	#15;
	display_stimulus();
	compare();
	$display ("\n\n***Directed Functionality Test is ended***\n\n");

	$display ("\n\n***Directed Functionality Test is applied ***\n\n");
	sel = 6;
	#15;
	display_stimulus();
	compare();
	$display ("\n\n***Directed Functionality Test is ended***\n\n");



	$display ("\n\n*** Random Functionality Tests are applied***\n\n");
	
	repeat (600) begin
		sel = $random( );
		#15;
		display_stimulus();
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
	$display ($time,," Test stimulus is: sel=%0d", sel);
endtask

initial begin
    $dumpfile("tb.vcd");
    $dumpvars;
end
endmodule