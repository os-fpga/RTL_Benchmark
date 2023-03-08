
module co_sim_asym_ram_sdp_wide_write;
    
reg clk, read_enable;
reg [3:0] write_enable;
reg [5:0] write_addr;
reg [7:0] read_addr;
reg [31:0] write_data;
wire [7:0] read_data, read_data_net;

    integer mismatch=0;
    reg [6:0]cycle, i;

    asym_ram_sdp_wide_write golden(.*);
    asym_ram_sdp_wide_write_post_synth netlist(.*, .read_data(read_data_net));


     //clock//
    initial begin
        clk = 1'b0;
        forever #10 clk = ~clk;
    end

    initial begin
    {write_enable, read_enable, write_addr, read_addr, write_data, cycle, i} = 0;

    //write 
    for (integer i=0; i<1024; i=i+1)begin
        repeat (1) @ (negedge clk)
        write_addr <= $urandom_range(0,31); read_addr <= $urandom_range(128,255); write_enable <=4'b1111; write_data<= $random;
        cycle = cycle +1;
      
        compare(cycle);

    end

    //reading 
    for (integer i=0; i<1024; i=i+1)begin
        repeat (1) @ (negedge clk)
        write_addr <= $urandom_range(32,63); read_addr <= $urandom_range(0,127); read_enable<=1;
        cycle = cycle +1;
      
        compare(cycle);

    end

        //random 
    for (integer i=0; i<1024; i=i+1)begin
        repeat (1) @ (negedge clk)
        write_addr <= $urandom_range(32,63); read_addr <= $urandom_range(0,127); write_enable <=$random; write_data<= $random;
        cycle = cycle +1;
      
        compare(cycle);

    end

    for (integer i=0; i<1024; i=i+1)begin
        repeat (1) @ (negedge clk)
        write_addr <= $urandom_range(32,63); read_addr <= $urandom_range(0,127); read_enable<=$random;
        cycle = cycle +1;
      
        compare(cycle);

    end

    for (integer i=0; i<1024; i=i+1)begin
        repeat (1) @ (negedge clk)
        write_addr <= $urandom_range(0,31); read_addr <= $urandom_range(128,255); read_enable<=$random; write_enable <=$random; write_data<= $random;
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
    if(read_data !== read_data_net) begin
        $display("dout mismatch. Golden: %0h, Netlist: %0h, Time: %0t", read_data, read_data_net,$time);
        mismatch = mismatch+1;
    end
    
    endtask


initial begin
    $dumpfile("tb.vcd");
    $dumpvars;
end
endmodule