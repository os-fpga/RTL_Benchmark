
module co_sim_rams_sp_wf_rst_en_1024x16;
    reg clk;
    reg we;
    reg en;
    reg rst;
    reg [9:0] addr;
    reg [15:0] di;
    wire [15:0] dout,dout_net;

    integer mismatch=0;
    reg [6:0]cycle, i;

    rams_sp_wf_rst_en_1024x16 golden(.*);
    rams_sp_wf_rst_en_1024x16_post_synth netlist(.*, .dout(dout_net));


    always #10 clk = ~clk;

    initial begin
    {clk, we,en, rst, addr ,di, cycle, i} = 0;
  

    repeat (1) @ (negedge clk);
    rst = 1'b1;

    repeat (1) @ (negedge clk);
    en = 1'b1;
    rst = 1'b0;
    //write, but will read zero as those locations are not written yet and are initialized to zero (always reading irrespective of we)
    for (integer i=0; i<1024; i=i+1)begin
        repeat (1) @ (negedge clk)
        addr <= i; we <=1; di<= $random;
        cycle = cycle +1;
        compare(cycle);

    end
    en = 1'b0;
    //not writing
    for (integer i=0; i<1024; i=i+1)begin
        repeat (1) @ (negedge clk)
        addr <= i; we <=0;
        cycle = cycle +1;
        compare(cycle);

    end

     //random
    for (integer i=0; i<1024; i=i+1)begin
        repeat (1) @ (negedge clk)
        we<=$random; en<=$random; rst<=$random; addr<=$random; di<=$random;
        cycle = cycle +1;
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
