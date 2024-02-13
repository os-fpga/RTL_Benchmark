
module co_sim_bytewrite_tdp_ram_nc;
 
    //---------------------------------------------------------------
    parameter NUM_COL = 4;
    parameter COL_WIDTH = 8;
    parameter ADDR_WIDTH = 10; // Addr Width in bits : 2**ADDR_WIDTH = RAM Depth
    parameter DATA_WIDTH = NUM_COL*COL_WIDTH; // Data Width in bits
    //---------------------------------------------------------------

	reg clkA;
	reg enaA;
	reg [NUM_COL-1:0] weA;
	reg [ADDR_WIDTH-1:0] addrA;
	reg [DATA_WIDTH-1:0] dinA;
	wire [DATA_WIDTH-1:0] doutA,doutA_net;
	reg clkB;
	reg enaB;
	reg [NUM_COL-1:0] weB;
	reg [ADDR_WIDTH-1:0] addrB;
	reg [DATA_WIDTH-1:0] dinB;
	wire [DATA_WIDTH-1:0] doutB, doutB_net;

    integer mismatch=0;
    integer cycle, i;

    bytewrite_tdp_ram_nc golden(.*);
    bytewrite_tdp_ram_nc_post_synth netlist(.*, .doutA(doutA_net), .doutB(doutB_net));



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
        for(integer i = 0; i<1024; i=i+1) begin 
            golden.ram_block[i] ='b0;
        end  
    end
    initial begin
    {enaA, weA, addrA, dinA, enaB, weB, addrB, dinB, cycle, i} = 0;
   
    

    repeat (1) @ (negedge clkA);
    
    for (integer i=0; i<1024; i=i+1)begin
        repeat (1) @ (negedge clkA)
        enaA = $random; enaB = $random; addrA <= $urandom_range(0,511); addrB <= $urandom_range(512,1023); weA <=$random; weB <=$random; dinA<= $random; dinB<= $random;
        cycle = cycle +1;
        
        compare(cycle);

    end
    for (integer i=0; i<1024; i=i+1)begin
        repeat (1) @ (negedge clkA)
        enaA = $random; enaB = $random; addrB <= $urandom_range(0,511); addrA <= $urandom_range(512,1023); weA <=$random; weB <=$random; dinA<= $random; dinB<= $random;
        cycle = cycle +1;
        
        compare(cycle);

    end
//     //reading
//     for (integer i=0; i<1024; i=i+1)begin
//         repeat (1) @ (negedge clkA)
//         write_addr <= $urandom_range(0,511); read_addr <= $urandom_range(512,1023); we <=0;
//         cycle = cycle +1;
        
//         compare(cycle);

//     end
// //repeat for ena 0
//     ena = 1'b0;
//     for (integer i=0; i<1024; i=i+1)begin
//         repeat (1) @ (negedge clkA)
//         write_addr <= $urandom_range(0,511); read_addr <= $urandom_range(512,1023); we <=4'b1111; din<= $random;
//         cycle = cycle +1;
        
//         compare(cycle);

//     end

   
//     for (integer i=0; i<1024; i=i+1)begin
//         repeat (1) @ (negedge clkA)
//         write_addr <= $urandom_range(0,511); read_addr <= $urandom_range(512,1023); we <=0;
//         cycle = cycle +1;
        
//         compare(cycle);

//     end

// //random
//       for (integer i=0; i<1024; i=i+1)begin
//         repeat (1) @ (negedge clkA)
//         ena = $random;
//         write_addr <= $urandom_range(0,511); read_addr <= $urandom_range(512,1023); we <=$random; din<= $random;
//         cycle = cycle +1;
        
//         compare(cycle);

//     end
    if(mismatch == 0)
        $display("\n**** All Comparison Matched ***\nSimulation Passed");
    else
        $display("%0d comparison(s) mismatched\nERROR: SIM: Simulation Failed", mismatch);
    

    repeat (10) @(negedge clkA); $finish;
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