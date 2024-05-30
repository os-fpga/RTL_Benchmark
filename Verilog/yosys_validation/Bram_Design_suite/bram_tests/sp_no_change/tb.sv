
module co_sp_no_change;

    reg  [15:0] wd;
    reg  [3:0] addr;
    reg  we,clk; // two clocks
    wire [15:0] rd, rd_net;

    integer mismatch=0;
    reg [6:0] cycle, i;

    sp_no_change golden(.*);
    sp_no_change_post_synth netlist(.*, .rd(rd_net));


    //clock//
    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    initial begin
    {we, addr, wd, cycle, i} = 0;
 

    repeat (1) @ (negedge clk);
    //write 
    for (integer i=0; i<8; i=i+1)begin
        repeat (1) @ (negedge clk)
        addr <= $urandom_range(0,7);  we <=1'b1; wd<= i;
        cycle = cycle +1;
       
        compare(cycle);

    end

    //reading 
    for (integer i=0; i<8; i=i+1)begin
        repeat (1) @ (negedge clk)
        addr <= $urandom_range(0,7); we <=0;
        cycle = cycle +1;
       
        compare(cycle);

    end

    //writes
    for (integer i=0; i<8; i=i+1)begin
        repeat (1) @ (negedge clk)
        addr <= $urandom_range(0,7); we <=1'b1; wd<= 'h25;
        cycle = cycle +1;
       
        compare(cycle);

    end

    if(mismatch == 0)
        $display("\n**** All Comparison Matched ***\nSimulation Passed");
    else
        $display("%0d comparison(s) mismatched\nERROR: SIM: Simulation Failed", mismatch);
    

    repeat (10) @(negedge clk); $finish;
    end

    task compare(input integer cycle);
    //$display("\n Comparison at cycle %0d", cycle);
    if(rd !== rd_net) begin
        $display("dout1 mismatch. Golden: %0h, Netlist: %0h, Time: %0t", rd, rd_net,$time);
        mismatch = mismatch+1;
    end
    endtask


initial begin
    $dumpfile("tb.vcd");
    $dumpvars;
end
endmodule