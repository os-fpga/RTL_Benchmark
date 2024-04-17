 
module co_sim_Log2highacc;

reg [23:0] DIN;
reg clk;
wire [11:0] DOUT, DOUT_net;




integer mismatch =0;
reg [24:0]cycle, i;


Log2highacc golden(.DIN(DIN),
		  .clk(clk),
		  .DOUT(DOUT));
		  
Log2highacc_post_synth netlist(.DIN(DIN),
				.clk(clk),
				.DOUT(DOUT_net));
		  

    always #10 clk = ~clk;

    initial begin
    {clk, DIN, cycle, i} = 0;
    
  
    repeat (2) @(negedge clk);
    DIN = 24'h1;
    compare();
    repeat (2) @(negedge clk);
    DIN = 24'h2;
    compare();
    repeat (2) @(negedge clk);
    DIN = 24'h13;
    compare();
    repeat (5) @(negedge clk);
    DIN = 24'h14;
    compare();
    repeat (2) @(negedge clk);
    DIN = 24'h20;
    compare();
    repeat (10) @(negedge clk);
    DIN = 24'h7;
    compare();
    
 
  
     if(mismatch == 0)
        $display("\n**** All Comparison Matched ***\nSimulation Passed");
     else
        $display("%0d comparison(s) mismatched\nError: Simulation Failed", mismatch);
    

    repeat (10) @(negedge clk); 
    $finish;
    end

    task compare();
    if(DOUT !== DOUT_net) begin
        $display("dout mismatch. Golden: %0h, Netlist: %0h, Time: %0t, DIN=%b", DOUT, DOUT_net,$time,golden.DIN);
        mismatch = mismatch+1;
    end
    
    endtask

endmodule
    

    