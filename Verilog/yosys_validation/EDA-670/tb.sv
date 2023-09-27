
module co_sim_bytewrite_sdp_ram_rf;
    //--------------------------------------------------------------------------
    parameter NUM_COL = 4; // 4 columns of 1 byte each make : 32 bits
    parameter COL_WIDTH = 7; //1 byte
    parameter ADDR_WIDTH = 10; // Addr Width in bits : 2 *ADDR_WIDTH = RAM Depth ---> 2^10 = 1024
    parameter DATA_WIDTH = NUM_COL*COL_WIDTH; // Data Width in bits
    //--------------------------------------------------------------------------

    reg clk;
    reg ena;
    reg [NUM_COL-1:0] we;
    reg [ADDR_WIDTH-1:0] read_addr,write_addr;
    reg [DATA_WIDTH-1:0] din;
    wire [DATA_WIDTH-1:0] dout, dout_net;

    integer mismatch=0;
    reg [6:0]cycle, i;

    bytewrite_sdp_ram_rf golden(.*);
    bytewrite_sdp_ram_rf_post_synth netlist(.*, .dout(dout_net));
    initial begin
        for(integer i = 0; i<1024; i=i+1) begin 
            golden.ram[i] ='b0;
        end  
    end

    always #10 clk = ~clk;

    initial begin
    {clk, ena, we, write_addr, read_addr ,din, cycle, i} = 0;

 

    repeat (1) @ (negedge clk);
    ena = 1'b1;
    //write 
    for (integer i=0; i<1024; i=i+1)begin
        repeat (1) @ (negedge clk)
        write_addr <= $urandom_range(0,511); we <=4'b1111; din<= $random;
        read_addr <= $urandom_range(512,1023);
        cycle = cycle +1;
       
        compare(cycle);

    end
       repeat (1) @ (negedge clk);
    ena = 1'b1;
    //read 
    for (integer i=0; i<1024; i=i+1)begin
        repeat (1) @ (negedge clk)
        read_addr <= $urandom_range(0,511); we <=4'b0000; din<= $random;
        write_addr <= $urandom_range(512,1023);
        cycle = cycle +1;
       
        compare(cycle);

    end
//random
    repeat (1) @ (negedge clk);
    
    
    for (integer i=0; i<1024; i=i+1)begin
        repeat (1) @ (negedge clk)
        ena = $random;
        write_addr <= $urandom_range(512,1023); we <=$random; din<= $random;
        read_addr <= $urandom_range(0,511);
        cycle = cycle +1;
       
        compare(cycle);

    end

       for (integer i=0; i<1024; i=i+1)begin
        repeat (1) @ (negedge clk)
        ena = $random;
        read_addr <= $urandom_range(512,1023); we <=$random; din<= $random;
        write_addr <= $urandom_range(0,511);
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
