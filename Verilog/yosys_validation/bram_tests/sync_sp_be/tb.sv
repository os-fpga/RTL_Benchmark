
module co_sync_sp_be;
    reg clk;
    reg [1:0] we;
    reg [3:0] addr;
    reg [15:0] wd;
    wire [15:0] rd, rd_net;

    integer mismatch=0;
    reg [6:0]cycle, i;

    sync_sp_be golden(.*);
    sync_sp_be_post_synth netlist(.*, .rd(rd_net));


    always #10 clk = ~clk;

    initial begin
    {clk, we, addr, wd, cycle, i} = 0;
  

    repeat (1) @ (negedge clk);
    //write 
    for (integer i=0; i<8; i=i+1)begin
        repeat (1) @ (negedge clk)
        addr <= i; we <=4'b11; wd<= $random;
        cycle = cycle +1;
      
        compare(cycle);

    end

    //reading 
    for (integer i=0; i<8; i=i+1)begin
        repeat (1) @ (negedge clk)
        addr <= i; we <=0;
        cycle = cycle +1;
      
        compare(cycle);

    end

//random
    for (integer i=0; i<8; i=i+1)begin
        repeat (1) @ (negedge clk)
        addr <= $random; we <=$random; wd<= $random;
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
    if(rd !== rd_net) begin
        $display("dout mismatch. Golden: %0h, Netlist: %0h, Time: %0t", rd, rd_net,$time);
        mismatch = mismatch+1;
    end
    else
        $display("dout Golden: %0h, Netlist: %0h, Time: %0t", rd, rd_net,$time);

    
    endtask


initial begin
    $dumpfile("tb.vcd");
    $dumpvars;
end
endmodule
