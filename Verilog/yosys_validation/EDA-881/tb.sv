
module co_sim_rams_sp_reg_addr_1024x36;
    reg clk;
    reg we;
    reg [9:0] addr;
    reg [35:0] di;
    wire [35:0] dout, dout_net;

    integer mismatch=0;
    reg [6:0]cycle, i;

    rams_sp_reg_addr_1024x36 golden(.*);
    rams_sp_reg_addr_1024x36_post_synth netlist(.*, .dout(dout_net));


    always #10 clk = ~clk;

    initial begin
    {clk, we, addr ,di, cycle, i} = 0;

    
    // repeat (1) @ (negedge clk);

    //write and simulatnously reads from registered address
    for (integer i=0; i<1024; i=i+1)begin
        repeat (1) @ (negedge clk)
        addr <= i; we <=1; di<= $random;
        cycle = cycle +1;
        #1;
        compare(cycle);

    end

    //not writing and reading from the last registered addr
    for (integer i=0; i<1024; i=i+1)begin
        repeat (1) @ (negedge clk)
        addr <= i; we <=0;
        cycle = cycle +1;
        #1;
        compare(cycle);

    end

//write and simulatnously reads from registered address when we was 1
     for (integer i=0; i<1024; i=i+1)begin
        repeat (1) @ (negedge clk)
        addr <= i; we <=1; di<= $random;
        repeat (1) @ (negedge clk)
        addr <= i; we <=0; di<= $random;
        cycle = cycle +2;
        #1;
        compare(cycle);

    end
    if(mismatch == 0)
        $display("\n**** All Comparison Matched ***\nSimulation Passed");
    else
        $display("%0d comparison(s) mismatched\nError: Simulation Failed", mismatch);
    

    repeat (10) @(negedge clk); $finish;
    end

    task compare(input integer cycle);
    //$display("\n Comparison at cycle %0d", cycle);
    if(dout !== dout_net) begin
        $display("dout mismatch. Golden: %0h, Netlist: %0h, Time: %0t", dout, dout_net,$time);
        mismatch = mismatch+1;
    end
    
    endtask


initial begin
    $dumpfile("tb.vcd");
    $dumpvars;
end
endmodule