module co_sim_dsp_mul_complex_eq ();
 reg [15:0] a, b;
 wire [31:0] z, z1, z2;

 wire [31:0] z_netlist, z1_netlist, z2_netlist;

 integer mismatch=0;

 dsp_mul_complex_eq rtl(.*);
 dsp_mul_complex_eq_post_synth netlist(.*, .z(z_netlist) ,. z1(z1_netlist) ,. z2(z2_netlist));

 initial begin

    a = 16'b0;
    b = 16'b0;
    display_stimulus();
    #50
    compare();
    
    a = 16'b0000000000000000;
    b = 16'b0000011000000010;
    display_stimulus();
    #50
    compare();
    
    a = 16'b1111111111111111;
    b = 16'b1111111111111111;
    display_stimulus();
    #50
    compare();

    a = 16'b1111111111111111;
    b = 16'b1111111000000000;
    display_stimulus();
    #50
    compare();

    repeat (100) begin
        a =  $random( );
        b =  $random( );
        display_stimulus();
        #50
        compare();

        if(mismatch == 0)
            $display("\n**** All Comparison Matched ***\nSimulation Passed");
        else
            $display("%0d comparison(s) mismatched\nERROR: SIM: Simulation Failed", mismatch);
	    $finish;
    end

 end

task compare();
 	$display("*** Comparing ***");
  	if ((z !== z_netlist) || (z1 !== z1_netlist) || (z2 !== z2_netlist) ) begin
    	$display("Data Mismatch. Golden z: %0d, Netlist z: %0d, Time: %0t", z, z_netlist, $time);
        $display("Data Mismatch. Golden z1: %0d, Netlist z1: %0d, Time: %0t", z1, z1_netlist, $time);
        $display("Data Mismatch. Golden z2: %0d, Netlist z2: %0d, Time: %0t", z2, z2_netlist, $time);
    	mismatch = mismatch+1;
 	end
  	else begin
  		$display("Data Matched. Golden z: %0d, Netlist z: %0d, Time: %0t", z, z_netlist, $time);
        $display("Data Matched. Golden z1: %0d, Netlist z1: %0d, Time: %0t", z1, z1_netlist, $time);
        $display("Data Matched. Golden z2: %0d, Netlist z2: %0d, Time: %0t", z2, z2_netlist, $time);
      end
endtask

task display_stimulus();
	$display ($time,," Test stimulus is: a=%0d, b=%0d", a, b);
endtask


initial begin
    $dumpfile("tb.vcd");
    $dumpvars;
end
endmodule

