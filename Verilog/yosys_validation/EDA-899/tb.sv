module co_sim_asym_ram_sdp_read_wider_dc;
    
parameter WIDTHA = 4;
parameter SIZEA = 1024;
parameter ADDRWIDTHA = 10;
parameter WIDTHB = 16;
parameter SIZEB = 256;
parameter ADDRWIDTHB = 8;

reg clkA;
reg clkB;
reg weA;
reg enaA, enaB;
reg [ADDRWIDTHA-1:0] addrA;
reg [ADDRWIDTHB-1:0] addrB;
reg [WIDTHA-1:0] diA;
wire [WIDTHB-1:0] doB, doB_net;

    integer mismatch=0;
    reg [6:0]cycle, i;

    asym_ram_sdp_read_wider_dc golden(.*);
    asym_ram_sdp_read_wider_dc_post_synth netlist(.*, .doB(doB_net));
    initial begin
        for(integer i = 0; i<1024; i=i+1) begin 
            golden.RAM[i] ='b0;
        end  
    end

     //clock//
    initial begin
        clkA = 1'b0;
        forever #10 clkA = ~clkA;
    end
    initial begin
        clkB = 1'b0;
        forever #5 clkB = ~clkB;
    end

    initial begin
    {enaA, enaB, weA, addrA, addrB, diA, cycle, i} = 0;

    repeat (1) @ (negedge clkA);
    enaA = 1'b1;
    enaB = 1'b0;
    //write 
    for (integer i=0; i<1024; i=i+1)begin
        repeat (1) @ (negedge clkA)
        addrA <= $urandom_range(1,1023); weA <=1'b1; diA<= $random;
        cycle = cycle +1;
        compare(cycle);

    end
    repeat (1) @ (negedge clkB);
    addrB <= 2; addrA <= 0; weA <=1'b1; diA<= $random;
    repeat (1) @ (negedge clkA);
    enaB = 1'b1;
    enaA = 1'b0;
    weA =0;
    //reading 
    for (integer i=0; i<1024; i=i+1)begin
        repeat (1) @ (negedge clkB)
        addrB <= i; 
        cycle = cycle +1;
        compare(cycle);

    end

      //write 
    for (integer i=0; i<1024; i=i+1)begin
        repeat (1) @ (negedge clkA)
        addrB <= 1023;addrA <= $urandom_range(0,1022); weA <=$random; diA<= $random;
        cycle = cycle +1;
        compare(cycle);

    end

    repeat (1) @ (negedge clkA);
    enaB = 1'b1;
    enaA = 1'b1;
    weA =0;
    //reading 
    for (integer i=0; i<1024; i=i+1)begin
        repeat (1) @ (negedge clkB)
        addrB <= $random; 
        cycle = cycle +1;
        compare(cycle);

    end

    
    if(mismatch == 0)
        $display("\n**** All Comparison Matched ***\nSimulation Passed");
    else
        $display("%0d comparison(s) mismatched\nError: Simulation Failed", mismatch);
    

    repeat (10) @(negedge clkA); $finish;
    end

    task compare(input integer cycle);
    //$display("\n Comparison at cycle %0d", cycle);
    if(doB !== doB_net) begin
        $display("dout mismatch. Golden: %0h, Netlist: %0h, Time: %0t", doB, doB_net,$time);
        mismatch = mismatch+1;
    end
    
    endtask

    initial begin
        $dumpfile("tb.vcd");
        $dumpvars;
    end
endmodule