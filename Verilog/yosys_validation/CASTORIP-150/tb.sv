
class random_contraint;
	rand bit [15:0] a, b;
	rand bit reset;
endclass

module co_sim_mac_32_arst;

	reg clock0, reset;
	reg signed [15:0] a, b;
	wire signed [31:0] out, out_net;

    integer mismatch=0;
    reg [6:0]cycle, i;

    mac_32_arst golden(.*);
    mac_32_arst_post_synth netlist(.*, .out(out_net));


    always #10 clock0 = ~clock0;

    initial begin
    
    random_contraint my_rand;
    my_rand = new();

    {clock0, reset, a, b, cycle, i} = 0;   
 
    repeat (1) @ (negedge clock0);
	//reset = 1'b1;
   
//random
    $display("a <= my_rand.a; b <= my_rand.b; reset <= 1'b0;");
    for (integer i=0; i<512; i=i+1)begin
        repeat (1) @ (negedge clock0)
        my_rand.randomize();
        a <= my_rand.a; b <= my_rand.b; reset <= 1'b0;
        cycle = cycle +1;
       
        compare(cycle);
    end

    $display("a <= my_rand.a; b <= my_rand.b; reset <= my_rand.reset;");
    for (integer i=0; i<512; i=i+1)begin
        repeat (1) @ (negedge clock0)
        my_rand.randomize();
        a <= my_rand.a; b <= my_rand.b; reset <= my_rand.reset;
        cycle = cycle +1;
       
        compare(cycle);
    end

    if(mismatch == 0)
        $display("\n**** All Comparison Matched ***\nSimulation Passed");
    else
        $display("%0d comparison(s) mismatched\nError: Simulation Failed", mismatch);
    

    repeat (10) @(negedge clock0); $finish;
    end

    task compare(input integer cycle);
    //$display("\n Comparison at cycle %0d", cycle);
    if(out !== out_net) begin
        $display("out mismatch. Golden: %0h, Netlist: %0h, Time: %0t, a: %d, b: %d, out_net: %d", out, out_net, $time, a, b, out_net);
        mismatch = mismatch+1;
    end
	else
        $display("Golden: %0h, Netlist: %0h, Time: %0t", out, out_net, $time);
    endtask


initial begin
    $dumpfile("tb.vcd");
    $dumpvars;
end
endmodule
