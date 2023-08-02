
module co_sim_axi_ram;
   // Width of data bus in bits
    parameter DATA_WIDTH = 32;
    // Width of address bus in bits
    parameter ADDR_WIDTH = 16;
    // Width of wstrb (width of data bus in words)
    parameter STRB_WIDTH = (DATA_WIDTH/8);
    // Width of ID signal
    parameter ID_WIDTH = 8;
    // Extra pipeline register on output
    parameter PIPELINE_OUTPUT = 0;
	parameter VALID_ADDR_WIDTH = ADDR_WIDTH - $clog2(STRB_WIDTH);
	reg                   clk;

	reg                   rst;

	reg [ID_WIDTH-1:0]    s_axi_awid;
	reg [ADDR_WIDTH-1:0]  s_axi_awaddr;
	reg [7:0]             s_axi_awlen;
	reg [2:0]             s_axi_awsize;
	reg [1:0]             s_axi_awburst;
	reg                   s_axi_awlock;
	reg [3:0]             s_axi_awcache;
	reg [2:0]             s_axi_awprot;
	reg                   s_axi_awvalid;
	wire                  s_axi_awready, s_axi_awready_net;
	reg [DATA_WIDTH-1:0]  s_axi_wdata;
	reg [STRB_WIDTH-1:0]  s_axi_wstrb;
	reg                   s_axi_wlast;
	reg                   s_axi_wvalid;
	wire                   s_axi_wready,s_axi_wready_net;
	wire [ID_WIDTH-1:0]    s_axi_bid, s_axi_bid_net;
	wire [1:0]             s_axi_bresp, s_axi_bresp_net;
	wire                   s_axi_bvalid, s_axi_bvalid_net;
	reg                   s_axi_bready;
	reg [ID_WIDTH-1:0]    s_axi_arid;
	reg [ADDR_WIDTH-1:0]  s_axi_araddr;
	reg [7:0]             s_axi_arlen;
	reg [2:0]             s_axi_arsize;
	reg [1:0]             s_axi_arburst;
	reg                   s_axi_arlock;
	reg [3:0]             s_axi_arcache;
	reg [2:0]             s_axi_arprot;
	reg                   s_axi_arvalid;
	wire                    s_axi_arready, s_axi_arready_net;
	wire [ID_WIDTH-1:0]    s_axi_rid, s_axi_rid_net;
	wire [DATA_WIDTH-1:0]  s_axi_rdata, s_axi_rdata_net;
	wire [1:0]             s_axi_rresp, s_axi_rresp_net;
	wire                   s_axi_rlast, s_axi_rlast_net;
	wire                   s_axi_rvalid, s_axi_rvalid_net;
	reg                   s_axi_rready;


	integer mismatch=0;

axi_ram golden(.*);
axi_ram_post_synth netlist(.*, .s_axi_awready(s_axi_awready_net), .s_axi_wready(s_axi_wready_net), .s_axi_bid(s_axi_bid_net), .s_axi_bresp(s_axi_bresp_net), .s_axi_bvalid(s_axi_bvalid_net), .s_axi_arready(s_axi_arready_net), .s_axi_rid(s_axi_rid_net), .s_axi_rdata(s_axi_rdata_net), .s_axi_rresp(s_axi_rresp_net), .s_axi_rlast(s_axi_rlast_net), .s_axi_rvalid(s_axi_rvalid_net));

//clock initialization
initial begin
    clk = 1'b0;
    forever #5 clk = ~clk;
end
initial begin
	rst <= 'b1;
	{s_axi_awid,s_axi_awaddr,s_axi_awlen,s_axi_awsize,s_axi_awburst,s_axi_awlock,s_axi_awcache,s_axi_awprot,s_axi_awvalid,s_axi_wdata,s_axi_wstrb,s_axi_wlast,s_axi_wvalid,s_axi_bready,s_axi_arid,s_axi_araddr,s_axi_arlen,s_axi_arsize,s_axi_arburst,s_axi_arlock,s_axi_arcache,s_axi_arprot,s_axi_arvalid,s_axi_rready}<= 'd0;
	repeat(10)@(negedge clk);
	rst <= 'b0;
	repeat(10)@(negedge clk);
	compare();
	s_axi_awvalid <= 1'b1;
	s_axi_awid <= 'd0;
	s_axi_awaddr <= 'd12;
	s_axi_wdata <= 'd123;
	s_axi_arlen <= 'd2;
	s_axi_awsize <= 'd3;
	s_axi_awburst <= 'd1;
	s_axi_wvalid <= 'd1;
	s_axi_wstrb <= 4'b1111;
	s_axi_arvalid <= 1'b1;
	repeat(10)@(negedge clk);

	rst <= 'b1;
	repeat(10)@(negedge clk);
	rst<=0;
	compare();
	{s_axi_awid,s_axi_awaddr,s_axi_awlen,s_axi_awsize,s_axi_awburst,s_axi_awlock,s_axi_awcache,s_axi_awprot,s_axi_awvalid,s_axi_wdata,s_axi_wstrb,s_axi_wlast,s_axi_wvalid,s_axi_bready,s_axi_arid,s_axi_arlen,s_axi_arsize,s_axi_arburst,s_axi_arlock,s_axi_arcache,s_axi_arprot,s_axi_rready}<= $random;
	s_axi_araddr <= 0;
	s_axi_arvalid <=1;
	repeat(10)@(negedge clk);
	compare();
	{s_axi_awid,s_axi_awaddr,s_axi_awlen,s_axi_awsize,s_axi_awburst,s_axi_awlock,s_axi_awcache,s_axi_awprot,s_axi_awvalid,s_axi_wdata,s_axi_wstrb,s_axi_wlast,s_axi_wvalid,s_axi_bready,s_axi_arid,s_axi_arlen,s_axi_arsize,s_axi_arburst,s_axi_arlock,s_axi_arcache,s_axi_arprot,s_axi_rready}<= $random;
	repeat(10)@(negedge clk);
	compare();
	{s_axi_awid,s_axi_awaddr,s_axi_awlen,s_axi_awsize,s_axi_awburst,s_axi_awlock,s_axi_awcache,s_axi_awprot,s_axi_awvalid,s_axi_wdata,s_axi_wstrb,s_axi_wlast,s_axi_wvalid,s_axi_bready,s_axi_arid,s_axi_araddr,s_axi_arlen,s_axi_arsize,s_axi_arburst,s_axi_arlock,s_axi_arcache,s_axi_arprot,s_axi_rready}<= $random;
	s_axi_arvalid <=1;
	repeat(10)@(negedge clk);
	compare();
	for (integer i=0; i<10; i=i+1)begin
	
			{s_axi_awid,s_axi_awaddr,s_axi_awlen,s_axi_awsize,s_axi_awburst,s_axi_awlock,s_axi_awcache,s_axi_awprot,s_axi_awvalid,s_axi_wdata,s_axi_wstrb,s_axi_wlast,s_axi_wvalid,s_axi_bready,s_axi_arid,s_axi_araddr,s_axi_arlen,s_axi_arsize,s_axi_arburst,s_axi_arlock,s_axi_arcache,s_axi_arprot,s_axi_arvalid,s_axi_rready}<= $random;
			repeat (1) @ (negedge clk)
			repeat (1) @ (negedge clk)
			repeat (1) @ (negedge clk)
			repeat (1) @ (negedge clk)
			compare();
	end

	if(mismatch == 0)
			$display("\n**** All Comparison Matched ***\nSimulation Passed");
	else
			$display("%0d comparison(s) mismatched\nERROR: SIM: Simulation Failed", mismatch);
	$finish;
end
	

task compare();
 	$display("*** Comparing ***");
  if(s_axi_awready !== s_axi_awready_net) begin
    	$display("s_axi_awready Mismatch. Golden RTL: %0d, Netlist: %0d, Time: %0t", s_axi_awready, s_axi_awready_net, $time);
    	mismatch = mismatch+1;
 	end
  else
  		$display("s_axi_awready Matched. Golden RTL: %0d, Netlist: %0d,  Time: %0t", s_axi_awready, s_axi_awready_net, $time);

	if(s_axi_wready !== s_axi_wready_net) begin
    	$display("s_axi_wready Mismatch. Golden RTL: %0d, Netlist: %0d, Time: %0t", s_axi_wready, s_axi_wready_net, $time);
    	mismatch = mismatch+1;
 	end
  else
  		$display("s_axi_wready Matched. Golden RTL: %0d, Netlist: %0d,  Time: %0t", s_axi_wready, s_axi_wready_net, $time);

	if(s_axi_bid !== s_axi_bid_net) begin
    	$display("s_axi_bid Mismatch. Golden RTL: %0d, Netlist: %0d, Time: %0t", s_axi_bid, s_axi_bid_net, $time);
    	mismatch = mismatch+1;
 	end
  else
  		$display("s_axi_bid Matched. Golden RTL: %0d, Netlist: %0d,  Time: %0t", s_axi_bid, s_axi_bid_net, $time);

	if(s_axi_bresp !== s_axi_bresp_net) begin
    	$display("s_axi_bresp Mismatch. Golden RTL: %0d, Netlist: %0d, Time: %0t", s_axi_bresp, s_axi_bresp_net, $time);
    	mismatch = mismatch+1;
 	end
  else
  		$display("s_axi_bresp Matched. Golden RTL: %0d, Netlist: %0d,  Time: %0t", s_axi_bresp, s_axi_bresp_net, $time);

	if(s_axi_bvalid !== s_axi_bvalid_net) begin
    	$display("s_axi_bvalid Mismatch. Golden RTL: %0d, Netlist: %0d, Time: %0t", s_axi_bvalid, s_axi_bvalid_net, $time);
    	mismatch = mismatch+1;
 	end
  else
  		$display("s_axi_bvalid Matched. Golden RTL: %0d, Netlist: %0d,  Time: %0t", s_axi_bvalid, s_axi_bvalid_net, $time);

	if(s_axi_arready !== s_axi_arready_net) begin
    	$display("s_axi_arready Mismatch. Golden RTL: %0d, Netlist: %0d, Time: %0t", s_axi_arready, s_axi_arready_net, $time);
    	mismatch = mismatch+1;
 	end
  else
  		$display("s_axi_arready Matched. Golden RTL: %0d, Netlist: %0d,  Time: %0t", s_axi_arready, s_axi_arready_net, $time);

	if(s_axi_rid !== s_axi_rid_net) begin
    	$display("s_axi_rid Mismatch. Golden RTL: %0d, Netlist: %0d, Time: %0t", s_axi_rid, s_axi_rid_net, $time);
    	mismatch = mismatch+1;
 	end
  else
  		$display("s_axi_rid Matched. Golden RTL: %0d, Netlist: %0d,  Time: %0t", s_axi_rid, s_axi_rid_net, $time);

	if(s_axi_rdata !== s_axi_rdata_net) begin
    	$display("s_axi_rdata Mismatch. Golden RTL: %0d, Netlist: %0d, Time: %0t", s_axi_rdata, s_axi_rdata_net, $time);
    	mismatch = mismatch+1;
 	end
  else
  		$display("s_axi_rdata Matched. Golden RTL: %0d, Netlist: %0d,  Time: %0t", s_axi_rdata, s_axi_rdata_net, $time);

	if(s_axi_rresp !== s_axi_rresp_net) begin
    	$display("s_axi_rresp Mismatch. Golden RTL: %0d, Netlist: %0d, Time: %0t", s_axi_rresp, s_axi_rresp_net, $time);
    	mismatch = mismatch+1;
 	end
  else
  		$display("s_axi_rresp Matched. Golden RTL: %0d, Netlist: %0d,  Time: %0t", s_axi_rresp, s_axi_rresp_net, $time);

	if(s_axi_rlast !== s_axi_rlast_net) begin
    	$display("s_axi_rlast Mismatch. Golden RTL: %0d, Netlist: %0d, Time: %0t", s_axi_rlast, s_axi_rlast_net, $time);
    	mismatch = mismatch+1;
 	end
  else
  		$display("s_axi_rlast Matched. Golden RTL: %0d, Netlist: %0d,  Time: %0t", s_axi_rlast, s_axi_rlast_net, $time);

	if(s_axi_rvalid !== s_axi_rvalid_net) begin
    	$display("s_axi_rvalid Mismatch. Golden RTL: %0d, Netlist: %0d, Time: %0t", s_axi_rvalid, s_axi_rvalid_net, $time);
    	mismatch = mismatch+1;
 	end
  else
  		$display("s_axi_rvalid Matched. Golden RTL: %0d, Netlist: %0d,  Time: %0t", s_axi_rvalid, s_axi_rvalid_net, $time);

	// if(mem_peripheral_rd_Data_debug !== mem_peripheral_rd_Data_debug_net) begin
  //   	$display("mem_peripheral_rd_Data_debug Mismatch. Golden RTL: %0d, Netlist: %0d, Time: %0t", mem_peripheral_rd_Data_debug, mem_peripheral_rd_Data_debug_net, $time);
  //   	mismatch = mismatch+1;
 	// end
  // else
  // 		$display("mem_peripheral_rd_Data_debug Matched. Golden RTL: %0d, Netlist: %0d,  Time: %0t", mem_peripheral_rd_Data_debug, mem_peripheral_rd_Data_debug_net, $time);

	// if(mem_peripheral_busy_debug !== mem_peripheral_busy_debug_net) begin
  //   	$display("mem_peripheral_busy_debug Mismatch. Golden RTL: %0d, Netlist: %0d, Time: %0t", mem_peripheral_busy_debug, mem_peripheral_busy_debug_net, $time);
  //   	mismatch = mismatch+1;
 	// end
  // else
  // 		$display("mem_peripheral_busy_debug Matched. Golden RTL: %0d, Netlist: %0d,  Time: %0t", mem_peripheral_busy_debug, mem_peripheral_busy_debug_net, $time);
endtask



initial begin
    $dumpfile("tb.vcd");
    $dumpvars;
end
endmodule
