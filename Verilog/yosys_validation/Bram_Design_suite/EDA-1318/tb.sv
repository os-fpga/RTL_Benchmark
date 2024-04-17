module two_sdp_tb;

  // Parameters

  // Ports
  reg clk1 = 0;
  reg clk2 = 0;
  reg [15:0] din1;
  reg [7:0] din2;
  wire [15:0] dout1;
  wire [7:0] dout2;
  reg [9:0] rAddr1;
  reg [10:0] rAddr2;
  reg [9:0] wAddr1;
  reg [10:0] wAddr2;
  reg we1 = 0;
  reg we2 = 0;
  wire [15:0] dout1_net;
  wire [7:0] dout2_net;

  two_sdp  golden(
    .clk1 (clk1 ),
    .clk2 (clk2 ),
    .din1 (din1 ),
    .din2 (din2 ),
    .dout1 (dout1 ),
    .dout2 (dout2 ),
    .rAddr1 (rAddr1 ),
    .rAddr2 (rAddr2 ),
    .wAddr1 (wAddr1 ),
    .wAddr2 (wAddr2 ),
    .we1 (we1 ),
    .we2  ( we2)
  );

  two_sdp_post_synth Netlist(
    .clk1 (clk1 ),
    .clk2 (clk2 ),
    .din1 (din1 ),
    .din2 (din2 ),
    .dout1 (dout1_net ),
    .dout2 (dout2_net ),
    .rAddr1 (rAddr1 ),
    .rAddr2 (rAddr2 ),
    .wAddr1 (wAddr1 ),
    .wAddr2 (wAddr2 ),
    .we1 (we1 ),
    .we2  ( we2)
  );

  initial begin
    for(integer i = 0; i<1024; i=i+1) begin 
        golden.ram1[i] = 16'b0;
    end  
end

initial begin
    for(integer i = 0; i<2048; i=i+1) begin 
        golden.ram2[i] = 8'b0;
    end  
end
  integer mismatch=0;
  reg [6:0]cycle, i;
  always
  #5  clk1 = ! clk1 ;
always
  #5  clk2 = ! clk2 ;


  initial begin

    {we1,we2, rAddr1,rAddr2, wAddr1, wAddr2, din1, din2,cycle, i} = 0;
 
    // Write
    for (integer i=0; i<512; i=i+1)begin
        repeat (1) @ (negedge clk1)

        wAddr1 <= i; wAddr2 <= i; we1 <=1'b1; we2 <=1'b1;  din1<= {$random}; din1<= {$random};
        cycle = cycle +1;
      
        compare(cycle);

    end
    // Read
    for (integer i=0; i<512; i=i+1)begin
        repeat (1) @ (negedge clk2)

        rAddr1 <= i; rAddr2 <= i; we1 <=1'b0; we2 <=1'b0;  din1<= {$random}; din1<= {$random};
        cycle = cycle +1;
      
        compare(cycle);

    end
    
//random
    for (integer i=0; i<512; i=i+1)begin
        repeat (1) @ (negedge clk1)
        wAddr1 <= $urandom_range(0,255); wAddr2 <= $urandom_range(256,511); we1 <= {$random}; we2 <= {$random}; rAddr1 <= $urandom_range(0,255); rAddr2 <= $urandom_range(256,511); din1<= {$random}; din2<= {$random};
        cycle = cycle +1;
       
        compare(cycle);
    end
    
    if(mismatch == 0)
        $display("\n**** All Comparison Matched ***\nSimulation Passed");
    else
        $display("%0d comparison(s) mismatched\nERROR: SIM: Simulation Failed", mismatch);
    

    repeat (10) @(negedge clk2); $finish;
    end

    task compare(input integer cycle);begin
    //$display("\n Comparison at cycle %0d", cycle);
    if(dout1 !== dout1_net) begin
        $display("dout1 mismatch. Golden: %0h, Netlist: %0h, Time: %0t", dout1, dout2_net,$time);
        mismatch = mismatch+1;
    end

     if(dout2 !== dout2_net) begin
        $display("dout2 mismatch. Golden: %0h, Netlist: %0h, Time: %0t", dout2, dout2_net,$time);
        mismatch = mismatch+1;
    end
end
    
    endtask

    initial begin
        $dumpfile("tb.vcd");
        $dumpvars;
    end

endmodule
 
