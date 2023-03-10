
module co_sim_asym_ram_sdp_wide_sync_read;
    
reg clk, write_enable, read_enable;
reg [7:0] write_addr;
reg [5:0] read_addr;
reg [7:0] write_data;
wire [31:0] read_data, read_data_net;

    integer mismatch=0;
    reg [6:0]cycle, i;

    asym_ram_sdp_wide_sync_read golden(
          .clk (clk ),
          .write_enable (write_enable ),
          .read_enable (read_enable ),
          .write_addr (write_addr ),
          .read_addr (read_addr ),
          .write_data (write_data ),
          .read_data  ( read_data)
        );
      
    asym_ram_sdp_wide_sync_read_post_synth netlist(
        .clk (clk ),
        .write_enable (write_enable ),
        .read_enable (read_enable ),
        .write_addr (write_addr ),
        .read_addr (read_addr ),
        .write_data (write_data ),   
    .read_data(read_data_net));


     //clock//
    initial begin
        clk = 1'b0;
        forever #10 clk = ~clk;
    end

    initial begin
    {write_enable, read_enable, write_addr, read_addr, write_data, cycle, i} = 0;
 

    //write 
    for (integer i=0; i<5; i=i+1)begin
        repeat (1) @ (negedge clk)
        write_addr <= i; write_enable <=1'b1; write_data<= $random;
        cycle = cycle +1;
   
        compare(cycle);

    end

    //reading 
    for (integer i=0; i<5; i=i+1)begin
        repeat (1) @ (negedge clk)
        read_addr <= i; read_enable<=1;write_enable <=1'b0;
        cycle = cycle +1;
   
        compare(cycle);

    end

        //Random
    for (integer i=0; i<1024; i=i+1)begin
        repeat (1) @ (negedge clk)
        write_addr <= $random; write_enable <=$random; write_data<= $random;
        cycle = cycle +1;
   
        compare(cycle);

    end

   
    for (integer i=0; i<1024; i=i+1)begin
        repeat (1) @ (negedge clk)
        read_addr <= $random; read_enable<=$random;
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
    else
       $display("dout Golden: %0h, Netlist: %0h, Time: %0t", read_data, read_data_net,$time);
    endtask


    initial begin
        $dumpfile("tb.vcd");
        $dumpvars;
    end
endmodule