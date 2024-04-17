module sim_route_sp_ram;
	bit [31:0] data;
	bit [9:0] addr;
	bit we;
    wire [31:0] q,q_netlist;
    reg clk;

	integer mismatch=0;

	sp_ram golden(data,addr,we,clk,q);

	sp_ram_post_synth netlist(.*,.q(q_netlist));
	

always #1 clk = ~clk;

initial begin
    clk = 1'b0;
	we=1;
	data=8'b11111111;
	@(negedge clk);
	display_stimulus();
	@(negedge clk);
	compare();
	
	for (integer i=0; i<16; i=i+1) begin
		addr=i;
		data=$random;
		@(negedge clk);
		display_stimulus();
		@(negedge clk);
		compare();
	end

	we=0;
	for (integer i=0; i<16; i=i+1) begin
		addr=i;
		@(negedge clk);
		display_stimulus();
		@(negedge clk);
		compare();
	end

	repeat(10)@(negedge clk);

	if(mismatch == 0)
        $display("\n**** All Comparison Matched ***\nSimulation Passed");
    else
        $display("%0d comparison(s) mismatched\nError: Simulation Failed", mismatch);
	$finish;
end
	

task compare();
 	$display("*** Comparing ***");
  	if(q !== q_netlist) begin
    	$display("Data Mismatch. Golden: %0d, Netlist: %0d, Time: %0t", q, q_netlist, $time);
    	mismatch = mismatch+1;
 	end
  	else
  		$display("Data Matched. Golden: %0d, Netlist: %0d, Time: %0t", q, q_netlist, $time);
endtask

task display_stimulus();
	$display ($time,," Test stimulus is: q=%0d q_netlist=%0d", q, q_netlist);
endtask

initial begin
    $dumpfile("tb.vcd");
    $dumpvars(0,sim_route_sp_ram);
end
endmodule 
