
module co_sim_SBox;
reg clk;               //system clock
reg reset;             //asynch active low reset
reg valid_in;          //valid input signal
reg [7:0] addr;        //SBox input byte
wire [7:0] dout, dout_net;    //SBox output

    integer mismatch=0;
    reg [6:0] i;

    SBox golden(.*);
    SBox_post_synth netlist(.*, .dout(dout_net));


    always #10 clk = ~clk;

    initial begin
    {clk, reset, addr ,valid_in, i} = 0;
  

    repeat (1) @ (negedge clk);
    reset = 1'b0;
    repeat (1) @ (negedge clk);
    repeat (1) @ (negedge clk);
    repeat (1) @ (negedge clk);
    reset = 1'b1;
   
    for (integer i=0; i<1024; i=i+1)begin
        repeat (1) @ (negedge clk)
        addr <= $random; valid_in <=$random; 
        compare();

    end
    
    if(mismatch == 0)
        $display("\n**** All Comparison Matched ***\nSimulation Passed");
    else
        $display("%0d comparison(s) mismatched\nERROR: SIM: Simulation Failed", mismatch);
    

    repeat (10) @(negedge clk); $finish;
    end

    task compare();
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
