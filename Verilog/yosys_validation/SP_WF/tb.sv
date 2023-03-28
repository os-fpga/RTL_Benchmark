
module co_sim_rams_sp_wf_1024x7;

reg clk = 0;
reg we = 0;
reg [9:0] addr;
reg [31:0] di;
wire [31:0] dout,dout_net;

    integer mismatch=0;
    reg [6:0]cycle, i;

    rams_sp_wf_1024x7 golden(.*);
    rams_sp_wf_1024x7_post_synth netlist(.*, .dout(dout_net));


    always #10 clk = ~clk;

    initial begin

    {clk, we, addr, di, cycle, i} = 0;

     

    repeat (1) @ (negedge clk);
    for (integer i=0; i<512; i=i+1)begin
        repeat (1) @ (negedge clk)
        addr <= $urandom_range(0,511);we <=1'b1; di<= $random;
        cycle = cycle +1;
     
        compare(cycle);

    end

    for (integer i=0; i<512; i=i+1)begin
        repeat (1) @ (negedge clk)
        addr <= $urandom_range(0,511); we <=0; 
        cycle = cycle +1;
     
        compare(cycle);

    end

    for (integer i=0; i<1024; i=i+1)begin
        repeat (1) @ (negedge clk)
        addr <= $random; we <=$random; di<= $random;
        cycle = cycle +1;
     
        compare(cycle);

    end


//random

    if(mismatch == 0)
        $display("\n**** All Comparison Matched ***\nSimulation Passed");
    else
        $display("%0d comparison(s) mismatched\nERROR: SIM: Simulation Failed", mismatch);
    

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