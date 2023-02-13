module co_sim_ram_true_dp_rf_1024x32;

    reg clk, weA, weB;
    reg [9:0] addrA, addrB;
    reg [17:0] dinA, dinB;
    wire [17:0] doutA, doutB, doutA_net, doutB_net;

    integer mismatch=0;
    reg [6:0]cycle, i;

    ram_true_dp_rf_1024x32 golden(.*);
    ram_true_dp_rf_1024x32_post_synth netlist(.*, .doutA(doutA_net), .doutB(doutB_net));


    always #10 clk = ~clk;
    initial begin


    {clk, clk1, weA,weB, addrA,addrB, dinA, dinB, cycle, i} = 0;
 
    repeat (1) @ (negedge clk);
    
    for (integer i=0; i<512; i=i+1)begin
        repeat (1) @ (negedge clk)

        addrA <= $urandom_range(0,511); addrB <= $urandom_range(512,1023); weA <=1'b1; weB <=1'b1; dinA<= {$random}; dinB<= {$random};
        cycle = cycle +1;
      
        compare(cycle);

    end

     for (integer i=0; i<512; i=i+1)begin
        repeat (1) @ (negedge clk)
        addrA <= $urandom_range(0,511); addrB <= $urandom_range(512,1023); weA <=1'b1; weB <=1'b0; dinA<= {$random}; dinB<= {$random};
        cycle = cycle +1;
      
        compare(cycle);
    end

    for (integer i=0; i<512; i=i+1)begin
        repeat (1) @ (negedge clk)
        addrB <= $urandom_range(0,511); addrA <= $urandom_range(512,1023); weA <=1'b1; weB <=1'b1; dinA<= {$random}; dinB<= {$random};
        cycle = cycle +1;
      
        compare(cycle);
    end

   for (integer i=0; i<512; i=i+1)begin
        repeat (1) @ (negedge clk)
        addrA <= $urandom_range(0,511); addrB <= $urandom_range(512,1023); weA <=1'b0; weB <=1'b0;  dinA<= {$random}; dinB<= {$random};
        cycle = cycle +1;
      
        compare(cycle);
    end

    //random
    for (integer i=0; i<512; i=i+1)begin
        repeat (1) @ (negedge clk)
        addrA <= $urandom_range(0,511); addrB <= $urandom_range(512,1023); weA <={$random}; weB <={$random}; dinA<= {$random}; dinB<= {$random};
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
    if(doutA !== doutA_net) begin
        $display("doutA mismatch. Golden: %0h, Netlist: %0h, Time: %0t", doutA, doutA_net,$time);
        mismatch = mismatch+1;
    end

     if(doutB !== doutB_net) begin
        $display("doutB mismatch. Golden: %0h, Netlist: %0h, Time: %0t", doutB, doutB_net,$time);
        mismatch = mismatch+1;
    end
    
    
    endtask


initial begin
    $dumpfile("tb.vcd");
    $dumpvars;
end
endmodule