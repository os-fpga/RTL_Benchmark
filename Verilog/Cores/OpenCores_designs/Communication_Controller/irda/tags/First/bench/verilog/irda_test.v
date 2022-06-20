`include "irda_defines.v"

module irda_test;

reg				clk;
reg				wb_rst_i;
reg	[3:0]		wb_addr_i;
reg	[31:0]	wb_dat_i;
wire	[31:0]	wb_dat_o;
reg				wb_we_i;
reg				wb_stb_i;
reg				wb_cyc_i;
reg				dma_ack_t;
reg				dma_ack_r;
reg				rx_i;

reg	[3:0]		wb1_addr_i;
reg	[31:0]	wb1_dat_i;
wire	[31:0]	wb1_dat_o;
reg				wb1_we_i;
reg				wb1_stb_i;
reg				wb1_cyc_i;
reg				dma1_ack_t;
reg				dma1_ack_r;
irda_top top(clk, wb_rst_i, wb_addr_i, wb_dat_i, wb_dat_o, wb_we_i, wb_stb_i, wb_cyc_i, 
	wb_ack_o, int_o, dma_req_t, dma_ack_t, dma_req_r, dma_ack_r,
	tx_o, rx_i);

irda_top toprx(clk, wb_rst_i, wb1_addr_i, wb1_dat_i, wb1_dat_o, wb1_we_i, wb1_stb_i, wb1_cyc_i,
					wb1_ack_o, int1_o, dma1_req_o, dma1_ack_t, dma1_req_r, dma1_ack_r,
	tx1_o, rx1_i);

assign 			rx1_i = tx_o; // connect the cores

// SIMULATES A WISHBONE IRDA_MASTER CONTROLLER CYCLE
task cycle;    // transmitter
input				we;
input	[3:0]		addr;
input	[31:0]	dat;		
begin
	@(posedge clk)
	wb_addr_i <= #1 addr;
	wb_we_i <= #1 we;
	wb_dat_i <= #1 dat;
	wb_stb_i <= #1 1;
	wb_cyc_i <= #1 1;
	@(posedge clk);
	while(~wb_ack_o)	@(posedge clk);
	#1;
	wb_we_i <= #1 0;
	wb_stb_i<= #1 0;
	wb_cyc_i<= #1 0;
end
endtask // cycle

task cycle1;    // transmitter
input				we;
input	[3:0]		addr;
input	[31:0]	dat;		
begin
	@(posedge clk)
	wb1_addr_i <= #1 addr;
	wb1_we_i <= #1 we;
	wb1_dat_i <= #1 dat;
	wb1_stb_i <= #1 1;
	wb1_cyc_i <= #1 1;
	@(posedge clk);
	while(~wb1_ack_o)	@(posedge clk);
	#1;
	wb1_we_i <= #1 0;
	wb1_stb_i<= #1 0;
	wb1_cyc_i<= #1 0;
end
endtask // cycle1

initial
	clk = 0;

always
	#5 clk = ~clk;

//always
//	@(posedge top.mir_tx.mir_txbit_enable) $display($time, "  > %b", top.mir_tx.mir_tx_o);

// MAIN TEST ROUTINE
initial
begin
//	$monitor(">> %d, %b", $time, top.mir_tx_o);
	#1		wb_rst_i = 1;
	#10	wb_rst_i = 0;
			wb_stb_i = 0;
			wb_cyc_i = 0;
			wb_we_i = 0;
			cycle(1, `IRDA_MASTER, 32'b00011011);
			cycle(1, `IRDA_F_CDR, 32'd200000);
			cycle(1, `IRDA_F_FCR, 32'b10000011);
//			cycle(1, `IRDA_F_LCR, 32'b00);
//			cycle(1, `IRDA_TRANSMITTER, 32'hA7F1F5CC);
//	$display("%m, %t, Sending %b", $time, 32'hA7F1F5CC);
	cycle(1, `IRDA_F_LCR, 32'b10); // set count outgoing data mode
	cycle(1, `IRDA_F_OFDLR, 16'd3); // 5 bytes to send
	
			cycle(1, `IRDA_TRANSMITTER, 32'h44332211);
			cycle(1, `IRDA_TRANSMITTER, 32'h88776655);
			#300;
			wait (top.mir_tx.state == 0);	
			cycle(1, `IRDA_TRANSMITTER, 32'hA7F1F5CC);
			#300;
			wait (top.mir_tx.state == 0);
			#200;
	$finish;
end // initial begin

// for the rx irda
initial
  begin
	  #10	wb1_stb_i = 0;
			wb1_cyc_i = 0;
			wb1_we_i = 0;
			cycle1(1, `IRDA_MASTER, 32'b00011001);
			cycle1(1, `IRDA_F_CDR, 32'd200000);
			cycle1(1, `IRDA_F_FCR, 32'b10000011);
			cycle1(1, `IRDA_F_LCR, 32'b00);
end

endmodule
