
module co_sim_ram_pipeline_block;

    reg clk1;
    reg clk2;
    reg we, en1, en2;
    reg [9:0] addr1;
    reg [9:0] addr2;
    reg [15:0] di;
    wire [15:0] res1, res1_net;
    wire [15:0] res2, res2_net;

    integer mismatch=0;
    reg [6:0]cycle, i;

    ram_pipeline_block  golden (
      .clk1 (clk1 ),
      .clk2 (clk2 ),
      .we (we ),
      . en1 ( en1 ),
      . en2 ( en2 ),
      .addr1 (addr1 ),
      .addr2 (addr2 ),
      .di (di ),
      .res1 (res1 ),
      .res2  ( res2)
    );
  
    ram_pipeline_block_post_synth netlist (
      .addr1 (addr1 ),
      .addr2 (addr2 ),
      .clk1 (clk1 ),
      .clk2 (clk2 ),
      .di (di ),
      .en1 (en1 ),
      .en2 (en2 ),
      .res1 (res1_net ),
      .res2 (res2_net ),
      .we  ( we)
    );
  
    initial begin
        for(integer i = 0; i<513; i=i+1) begin 
            golden.RAM[i] ='b0;
        end  
    end
    //clock//
    initial begin
        clk1 = 1'b0;
        forever #10 clk1 = ~clk1;
    end
    initial begin
        clk2 = 1'b0;
        forever #5 clk2 = ~clk2;
    end

    initial begin
        
    {we,en1, en2,addr1, addr2, di, cycle, i} = 0;
 
 
    repeat (1) @ (negedge clk1);
    
    for (integer i=0; i<1024; i=i+1)begin
        repeat (1) @ (negedge clk1)

        addr1 <= i; addr2 <= {$random} % 1024; en1<=1'b1; en2<=1'b1; we <=1'b1;  di<= {$random};
        cycle = cycle +1;
      
        compare(cycle);

    end

     for (integer i=0; i<1024; i=i+1)begin
        repeat (1) @ (negedge clk2)
        addr1 <= i; addr2 <= i; we <=1'b0; 
        cycle = cycle +1;
      
        compare(cycle);
    end
    repeat (1) @ (negedge clk1)
    en1<=1'b0; en2<=1'b0;
    for (integer i=0; i<1024; i=i+1)begin
        repeat (1) @ (negedge clk1)
        addr1 <= i; addr2 <= i; we <=1'b0; 
        cycle = cycle +1;
      
        compare(cycle);
    end

     for (integer i=0; i<1024; i=i+1)begin
        repeat (1) @ (negedge clk2)
        addr1 <= {$random}; addr2 <= {$random}; en1<={$random}; en2<={$random}; we <={$random}; di<= {$random}; 
        cycle = cycle +1;
      
        compare(cycle);
    end

   
    if(mismatch == 0)
        $display("\n**** All Comparison Matched ***\nSimulation Passed");
    else
        $display("%0d comparison(s) mismatched\nError: Simulation Failed", mismatch);
    

    repeat (10) @(negedge clk1); $finish;
    end

    task compare(input integer cycle);begin
    //$display("\n Comparison at cycle %0d", cycle);
    if(res1 !== res1_net) begin
        $display("res1 mismatch. Golden: %0h, Netlist: %0h, Time: %0t", res1, res1_net,$time);
        mismatch = mismatch+1;
    end

     if(res2 !== res2_net) begin
        $display("res2 mismatch. Golden: %0h, Netlist: %0h, Time: %0t", res2, res2_net,$time);
        mismatch = mismatch+1;
    end
    end
    
    endtask


initial begin
    $dumpfile("tb.vcd");
    $dumpvars;
end
endmodule