
module co_sim_ram_simple_dp_sync_reg_read_1024x64;

    reg clk, we;
    reg [9:0] read_addr, write_addr;
    reg [63:0] din;
    wire [63:0] dout, dout_net;

    integer mismatch=0, match=0;
    reg [6:0]cycle, i;

    ram_simple_dp_sync_reg_read_1024x64  golden (
      .clk (clk ),
      . we ( we ),
      .read_addr (read_addr ),
      . write_addr ( write_addr ),
      .din (din ),
      .dout  ( dout)
    );

    ram_simple_dp_sync_reg_read_1024x64_post_synth netlist (
        .clk (clk ),
        .din (din ),
        .dout (dout_net ),
        .read_addr (read_addr ),
        .we (we ),
        .write_addr  ( write_addr)
    );

    initial begin
        for(integer i = 0; i<1024; i=i+1) begin 
            golden.ram[i] ='b0;
        end  
    end
    always #10 clk = ~clk;

    initial begin
    {clk, we, read_addr, write_addr, din, cycle, i} = 0;


    repeat (1) @ (negedge clk);
    //write and reads simulatneously from registered read addr(during we high) and write addr 
    for (integer i=0; i<1024; i=i+1)begin
        repeat (1) @ (negedge clk)
        read_addr <= $urandom_range(0,511); write_addr <= $urandom_range(512,1023); we <=1'b1; din<= $random;
        cycle = cycle +1;
       
        compare(cycle);

    end

    //not writing and reading simulatneously from last registered addr during we high
    for (integer i=0; i<1024; i=i+1)begin
        repeat (1) @ (negedge clk)
        read_addr <= $urandom_range(0,511); write_addr <= $urandom_range(512,1023); we <=0;
        cycle = cycle +1;
       
        compare(cycle);

    end

    //random registtered addr
    for (integer i=0; i<1024; i=i+1)begin
        repeat (1) @ (negedge clk)
        read_addr <= $urandom_range(0,511); write_addr <= $urandom_range(512,1023); we <=1'b1; din<= $random;
        cycle = cycle +1;
       
        compare(cycle);

    end

    //read from only last registered addr
    for (integer i=0; i<1024; i=i+1)begin
        repeat (1) @ (negedge clk)
        read_addr <= $urandom_range(0,511); write_addr <= $urandom_range(512,1023); we <=0;
        cycle = cycle +1;
       
        compare(cycle);

    end

    for (integer i=0; i<1024; i=i+1)begin
        repeat (1) @ (negedge clk)
        read_addr <= $urandom_range(0,511); write_addr <= $urandom_range(512,1023); we <=$random; din<= $random;
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
    if(dout == dout_net) begin
        $display("dout matched. Golden: %0h, Netlist: %0h, Time: %0t", dout, dout_net,$time);
        match = match+1;
    end
    
    endtask


initial begin
    $dumpfile("tb.vcd");
    $dumpvars;
end
endmodule