
class random_contraint;
    rand bit weA, weB;
    rand bit [8:0] addrA, addrB;

    constraint my_range { (weA == 1 && weB == 1) -> (addrA != addrB);   }
endclass

module co_sim_ram_true_dp_512x32;

    reg clk, weA, weB;
    reg [8:0] addrA, addrB;
    reg [31:0] dinA, dinB;
    wire [31:0] doutA, doutB, doutA_net, doutB_net;

    integer mismatch=0;
    reg [6:0]cycle, i;

    ram_true_dp_512x32 golden(.*);
    ram_true_dp_512x32_post_synth netlist(.*, .doutA(doutA_net), .doutB(doutB_net));


    always #10 clk = ~clk;

    initial begin
    
    random_contraint my_rand;
    my_rand = new();

    {clk, weA,weB, addrA,addrB, dinA, dinB, cycle, i} = 0;   
 
    repeat (1) @ (negedge clk);
   

    for (integer i=0; i<512; i=i+1)begin
        repeat (1) @ (negedge clk)
         my_rand.randomize();
        addrA <= i; addrB <= my_rand.addrB; weA <=1'b1; weB <=1'b1; dinA<= {$random}; dinB<= {$random};
        cycle = cycle +1;
       
        compare(cycle);

    end

     for (integer i=0; i<512; i=i+1)begin
        repeat (1) @ (negedge clk)
        addrA <= i; addrB <= i; weA <=1'b1; weB <=1'b0; dinA<= {$random}; dinB<= {$random};
        cycle = cycle +1;
       
        compare(cycle);
    end


   for (integer i=0; i<512; i=i+1)begin
        repeat (1) @ (negedge clk)
        addrA <= i; addrB <= i; weA <=1'b0; weB <=1'b0; dinA<= {$random}; dinB<= {$random};
        cycle = cycle +1;
       
        compare(cycle);
    end

//random
    for (integer i=0; i<512; i=i+1)begin
        repeat (1) @ (negedge clk)
        my_rand.randomize();
        addrA <= my_rand.addrA; addrB <= my_rand.addrB; weA <=my_rand.weA; weB <=my_rand.weB; dinA<= {$random}; dinB<= {$random};
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