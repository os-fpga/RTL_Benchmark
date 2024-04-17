
module top_tb;

  // Parameters
  localparam  DATA_WIDTH = 4;
  localparam  ADDR_WIDTH = 13;

  //Ports
  reg [(ADDR_WIDTH-1):0] addr_a=0;
  reg  [(ADDR_WIDTH-1):0]addr_b=0;
  reg  clk=0;
  wire [(DATA_WIDTH-1):0] q_a;
  wire [(DATA_WIDTH-1):0]q_b;

  wire [(DATA_WIDTH-1):0] q_a_net;
  wire [(DATA_WIDTH-1):0]q_b_net;
  integer mismatch=0;
  reg [6:0] i=0;
  top golden (
    .addr_a(addr_a),
    .addr_b(addr_b),
    .clk(clk),
    .q_a(q_a),
    .q_b(q_b)
  );

  top_post_synth netlist(
    .addr_a(addr_a),
    .addr_b(addr_b),
    .clk(clk),
    .q_a(q_a_net),
    .q_b(q_b_net)
  );

always #5  clk = ! clk ;


initial begin
    
repeat (1) @ (negedge clk);
    for (integer i=0; i< 2048; i=i+1)begin
        repeat (1) @ (negedge clk)
        addr_a <= i; addr_b <= i;
       
        compare();

    end

    for (integer i=0; i<2048; i=i+1)begin
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
