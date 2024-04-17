
module co_sim_dual_port_rom
#(parameter DATA_WIDTH=32, parameter ADDR_WIDTH=10);

    reg [(ADDR_WIDTH-1):0] addr_a, addr_b;
	reg clk;
	wire [(DATA_WIDTH-1):0] q_a, q_b, q_a_net, q_b_net;

    integer mismatch=0;
    reg [6:0] i;

    dual_port_rom golden(.*);
    dual_port_rom_post_synth netlist(.*, .q_a(q_a_net), .q_b(q_b_net));


    always #10 clk = ~clk;
    // initial begin
    //     for(integer i = 0; i<1024; i=i+1) begin 
    //         golden.rom[i] ='b0;
    //     end  
    // end
    initial begin
    {clk, addr_a, addr_b, i} = 0;

    repeat (1) @ (negedge clk);
    for (integer i=0; i<ADDR_WIDTH; i=i+1)begin
        repeat (1) @ (negedge clk)
        addr_a <= i; addr_b <= i;
       
        compare();

    end

    for (integer i=0; i<ADDR_WIDTH; i=i+1)begin
        repeat (1) @ (negedge clk)
        addr_a <= $urandom_range(0,ADDR_WIDTH-1); addr_b <= $urandom_range(0,ADDR_WIDTH-1);
       
        compare();

    end

    if(mismatch == 0)
        $display("\n**** All Comparison Matched ***\nSimulation Passed");
    else
        $display("%0d comparison(s) mismatched\nERROR: SIM: Simulation Failed", mismatch);
    

    repeat (10) @(negedge clk); $finish;
    end

    task compare();
    if(q_a !== q_a_net) begin
        $display("q_a mismatch. Golden: %0h, Netlist: %0h, Time: %0t", q_a, q_a_net,$time);
        mismatch = mismatch+1;
    end
    if(q_b !== q_b_net) begin
        $display("q_b mismatch. Golden: %0h, Netlist: %0h, Time: %0t", q_b, q_b_net,$time);
    end
    
    endtask


initial begin
    $dumpfile("tb.vcd");
    $dumpvars;
end
endmodule