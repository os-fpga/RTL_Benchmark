
module co_sim_ram_simple_dp_sync_reg_read_4096x32;

    reg clk, we;
    reg [11:0] read_addr, write_addr;
    reg [31:0] din;
    wire [31:0] dout, dout_net;

    integer mismatch=0;
    reg [6:0]cycle, i;

    ram_simple_dp_sync_reg_read_4096x32 golden(.*);
    ram_simple_dp_sync_reg_read_4096x32_post_synth netlist(.*, .dout(dout_net));


    always #10 clk = ~clk;

    initial begin
    {clk, we, read_addr, write_addr, din, cycle, i} = 0;
 

    repeat (1) @ (negedge clk);
    //write and reads simulatneously from same read and write addr 
    for (integer i=0; i<4096; i=i+1)begin
        repeat (1) @ (negedge clk)
        read_addr <= $urandom_range(0,2047); write_addr <= $urandom_range(2048,4095); we <=1'b1; din<= $random;
        cycle = cycle +1;
      
        compare(cycle);

    end

    //not writing and reading simulatneously from given addr
    for (integer i=0; i<4096; i=i+1)begin
        repeat (1) @ (negedge clk)
        write_addr <= $urandom_range(0,2047); read_addr <= $urandom_range(2048,4095); we <=0;
        cycle = cycle +1;
      
        compare(cycle);

    end

    //read from random and write to all
    for (integer i=0; i<4096; i=i+1)begin
        repeat (1) @ (negedge clk)
        write_addr <= $urandom_range(0,2047); read_addr <= $urandom_range(2048,4095); we <=1'b1; din<= $random;
        cycle = cycle +1;
      
        compare(cycle);

    end

    //read from all
    for (integer i=0; i<4096; i=i+1)begin
        repeat (1) @ (negedge clk)
        read_addr <= $urandom_range(0,2047); write_addr <= $urandom_range(2048,4095);  we <=0;
        cycle = cycle +1;
      
        compare(cycle);

    end

     for (integer i=0; i<4096; i=i+1)begin
        repeat (1) @ (negedge clk)
        read_addr <= $urandom_range(0,2047); write_addr <= $urandom_range(2048,4095);  we <=$random; din<= $random;
        cycle = cycle +1;
      
        compare(cycle);

    end

    for (integer i=0; i<4096; i=i+1)begin
        repeat (1) @ (negedge clk)
        write_addr <= $urandom_range(0,2047); read_addr <= $urandom_range(2048,4095);  we <=$random; din<= $random;
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