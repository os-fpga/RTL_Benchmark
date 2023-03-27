
module co_sim_asym_ram_sdp_write_wider_dc_logic;
    
//Read
parameter WIDTHB = 8;
parameter SIZEB = 512;
parameter ADDRWIDTHB = 9;
//write
parameter WIDTHA = 16;
parameter SIZEA = 256;
parameter ADDRWIDTHA = 8;

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

    asym_ram_sdp_write_wider_dc_logic golden(
          .clkA (clkA ),
          .clkB (clkB ),
          .weA (weA ),
          .enaA (enaA ),
          .enaB ( enaB ),
          .addrA (addrA ),
          .addrB (addrB ),
          .diA (diA ),
          .doB  ( doB)
        );
      
    asym_ram_sdp_write_wider_dc_logic_post_synth netlist(
        .clkA (clkA ),
        .clkB (clkB ),
        .weA (weA ),
        .enaA (enaA ),
        .enaB ( enaB ),
        .addrA (addrA ),
        .addrB (addrB ),
        .diA (diA ),    
        .doB(doB_net));


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
    enaB = 1'b1;
    enaA = 1'b0;
    weA =0;
    //reading 
    for (integer i=0; i<5; i=i+1)begin
        repeat (1) @ (negedge clkB)
        addrB <= i; 
        cycle = cycle +1;
        compare(cycle);

    end


    repeat (1) @ (negedge clkA);
    enaA = 1'b1;
    enaB = 1'b0;
    //write 
    for (integer i=0; i<5; i=i+1)begin
        repeat (1) @ (negedge clkA)
        addrA <= i; weA <=1'b1; diA<= $random;
        cycle = cycle +1;
      
        compare(cycle);

    end
    enaB = 1'b1;
    enaA = 1'b0;
    weA =0;
    //reading 
    for (integer i=0; i<5; i=i+1)begin
        repeat (1) @ (negedge clkB)
        addrB <= i; 
        cycle = cycle +1;
      
        compare(cycle);

    end
    

    //random 
    repeat (1) @ (negedge clkA);
    
 
    for (integer i=0; i<1024; i=i+1)begin
        repeat (1) @ (negedge clkA)
        enaA <= $random;
        enaB <= $random;
        addrA <= $urandom_range(0,511); addrB <= $urandom_range(512,1023);  weA <=$random; diA<= $random;
        cycle = cycle +1;
      
        compare(cycle);

    end
    
    if(mismatch == 0)
        $display("\n**** All Comparison Matched ***\nSimulation Passed");
    else
        $display("%0d comparison(s) mismatched\nERROR: SIM: Simulation Failed", mismatch);
    

    repeat (10) @(negedge clkA);
    repeat (10) @(negedge clkB); $finish;
    end

    task compare(input integer cycle);
    //$display("\n Comparison at cycle %0d", cycle);
    if(doB !== doB_net) begin
        $display("doB mismatch. Golden: %0h, Netlist: %0h, Time: %0t", doB, doB_net,$time);
        mismatch = mismatch+1;
    end
    
    endtask


initial begin
    $dumpfile("tb.vcd");
    $dumpvars;
end
endmodule