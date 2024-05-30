//`include "../../rtl/design1_5_5_top.v"
// `include "../../design1_5_5_top_netlist.v"
module memory_tb;
  // Parameters
localparam  DATA = 32;
localparam  ADDR = 10;

//Ports
reg  clk;
reg  rst;
reg [ADDR-1:0] wr_addr;
reg [DATA-1:0] wr_data_in;
reg  wr_en;
reg [ADDR-1:0] rd_addr;
reg  rd_en;
wire [DATA-1:0] rd_data_out,rd_data_out_netlist;
reg [6:0]cycle, i;



memory # (
  .DATA(DATA),
  .ADDR(ADDR)
)
golden (
  .clk(clk),
  .rst(rst),
  .wr_addr(wr_addr),
  .wr_data_in(wr_data_in),
  .wr_en(wr_en),
  .rd_addr(rd_addr),
  .rd_en(rd_en),
  .rd_data_out(rd_data_out)
);

initial begin
	for(integer i = 0; i<1024; i=i+1) begin 
		golden.mem[i] ='b0;
	end  
end

	integer mismatch=0;
    `ifdef PNR
    `else
     memory_post_synth netlist(
		.clk(clk),
		.rst(rst),
		.wr_addr(wr_addr),
		.wr_data_in(wr_data_in),
		.wr_en(wr_en),
		.rd_addr(rd_addr),
		.rd_en(rd_en),
		.rd_data_out(rd_data_out_netlist)
	  );
    `endif

//clock initialization
initial begin
    clk = 1'b0;
    forever #5 clk = ~clk;
end

initial begin
    {clk, wr_en,rd_en, rst, wr_addr,rd_addr,wr_data_in, cycle, i} = 0;
  

    repeat (1) @ (negedge clk);
    rst = 1'b1;

    repeat (1) @ (negedge clk);
    rd_en = 1'b1;
    rst = 1'b0;
    //write, but will read zero as those locations are not written yet and are initialized to zero (always reading irrespective of wr_en)
    for (integer i=0; i<1024; i=i+1)begin
        repeat (1) @ (negedge clk)
        wr_addr <= i; wr_en <=1;rd_en <=0; wr_data_in<= $random;
        cycle = cycle +1;
        compare(cycle);

    end
    wr_en = 1'b0;
    //not writing
    for (integer i=0; i<1024; i=i+1)begin
        repeat (1) @ (negedge clk)
        rd_addr <= i; rd_en <=1;
        cycle = cycle +1;
        compare(cycle);

    end
	for (integer i=0; i<1024; i=i+1)begin
        repeat (1) @ (negedge clk)
        rd_addr <= i; rd_en <=0;wr_en <=0; rst <= !rst;
        cycle = cycle +1;
        compare(cycle);

    end

    //random
    for (integer i=0; i<4096; i=i+1)begin
        repeat (1) @ (negedge clk)
        wr_en<=$random; rd_en<=$random; rst<=$random; rd_addr<=$random;wr_addr<=$random; ;wr_data_in<=$random;
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
    if(rd_data_out !== rd_data_out_netlist) begin
        $display("rd_data_out mismatch. Golden: %0h, rd_data_out_netlist: %0h, Time: %0t", rd_data_out, rd_data_out_netlist,$time);
        mismatch = mismatch+1;
    end
    
    endtask


initial begin
    $dumpfile("tb.vcd");
    $dumpvars;
end

endmodule