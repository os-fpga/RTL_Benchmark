
module co_sim_asym_ram_sdp_wide_sync_read_via_part_selection;
    
reg clk, write_enable, read_enable;
reg [1:0] byte_lane;
reg [7:0] write_addr;
reg [5:0] read_addr;
reg [7:0] write_data;
wire [31:0] read_data, read_data_net;

    integer mismatch=0;
    reg [6:0]cycle, i;

    asym_ram_sdp_wide_sync_read_via_part_selection golden(
          .clk (clk ),
          .write_enable (write_enable ),
          .read_enable (read_enable ),
          .byte_lane (byte_lane ),
          .write_addr (write_addr ),
          .read_addr (read_addr ),
          .write_data (write_data ),
          .read_data  ( read_data)
        );
      
    asym_ram_sdp_wide_sync_read_via_part_selection_post_synth netlist( 
    .clk (clk ),
    .write_enable (write_enable ),
    .read_enable (read_enable ),
    .byte_lane (byte_lane ),
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
        for(integer i = 0; i<256; i=i+1) begin 
            golden.mem[i] ='b0;
        end  
    end
    initial begin
    {write_enable, byte_lane, read_enable, write_addr, read_addr, write_data, cycle, i} = 0;


    //write 
    for (integer i=0; i<1024; i=i+1)begin
        repeat (1) @ (negedge clk)
        write_addr <= $urandom_range(0,127); read_addr <= $urandom_range(32,63); write_enable <=1'b1; byte_lane<= 2'b10; write_data<= $random;
        cycle = cycle +1;
   
        compare(cycle);

    end

    //reading 
    for (integer i=0; i<1024; i=i+1)begin
        repeat (1) @ (negedge clk)
        read_addr <= $urandom_range(0,31); read_enable<=1; write_addr <= $urandom_range(128,255);
        cycle = cycle +1;
   
        compare(cycle);

    end
    //Random 
    for (integer i=0; i<1024; i=i+1)begin
        repeat (1) @ (negedge clk)
        write_addr <= $urandom_range(0,255); write_enable <=$random; byte_lane<= $random; write_data<= $random; read_enable<=0;
        cycle = cycle +1;
   
        compare(cycle);

    end

    //reading 
    for (integer i=0; i<1024; i=i+1)begin
        repeat (1) @ (negedge clk)
        write_addr <= $urandom_range(128,255); write_enable <=$random; byte_lane<= $random; write_data<= $random; read_addr <= $urandom_range(0,31); read_enable<=$random;
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