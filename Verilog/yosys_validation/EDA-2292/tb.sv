
module co_sim_ram_simple_dp_dc_with_re_512x32;

     reg  [31:0] din;
    reg  [8:0] read_addr, write_addr;       // two addresses
    reg  we,re, read_clock, write_clock; // two clocks
    wire [31:0] dout, dout_net;

    integer mismatch=0;
    reg [6:0]cycle, i;

    ram_simple_dp_dc_with_re_512x32 golden(.*);
    ram_simple_dp_dc_with_re_512x32_post_synth netlist(.*, .dout(dout_net));


    //clock//
    initial begin
        read_clock = 1'b0;
        forever #10 read_clock = ~read_clock;
    end
    initial begin
        write_clock = 1'b0;
        forever #5 write_clock = ~write_clock;
    end
    initial begin
        for(integer i = 0; i<513; i=i+1) begin 
            golden.ram[i] ='b0;
        end 
    end
    initial begin

    {we,re, read_addr, write_addr, din, cycle, i} = 0; 
    re=1;
    repeat (1) @ (negedge write_clock);
    for (integer i=0; i<512; i=i+1)begin
        repeat (1) @ (negedge write_clock)
        read_addr <= $urandom_range(0,255); write_addr <= $urandom_range(256,511); we <=1'b1; re<=0; din<= i;
        cycle = cycle +1;
      
        compare(cycle);

    end

    for (integer i=0; i<512; i=i+1)begin
        repeat (1) @ (negedge read_clock)
        read_addr <= $urandom_range(256,511); write_addr <= $urandom_range(0,255); we <=1; re <=1; din<= i;
        cycle = cycle +1;
      
        compare(cycle);

    end


    for (integer i=0; i<512; i=i+1)begin
        repeat (1) @ (negedge read_clock)
        read_addr <= $urandom_range(0,255); write_addr <= $urandom_range(256,511); we <=1'b0;re<=1; din<= 'h25;
        cycle = cycle +1;
      
        compare(cycle);

    end

    for (integer i=0; i<512; i=i+1)begin
        repeat (1) @ (negedge read_clock)
        read_addr <= $urandom_range(0,255); write_addr <= $urandom_range(256,511); we <=1'b1;re<=0; din<= 'h25;
        cycle = cycle +1;
      
        compare(cycle);

    end


//random
    for (integer i=0; i<512; i=i+1)begin
        repeat (1) @ (negedge write_clock)
        read_addr <= $urandom_range(0,255); write_addr <= $urandom_range(256,511); we <= {$random};  re <= {$random};  din<= {$random}; 
        cycle = cycle +1;
       
        compare(cycle);
    end

    // end
    if(mismatch == 0)
        $display("\n**** All Comparison Matched ***\nSimulation Passed");
    else
        $display("%0d comparison(s) mismatched\nERROR: SIM: Simulation Failed", mismatch);
    

    repeat (10) @(negedge read_clock); $finish;
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
