
`timescale 1ns/1ns
module module_tb;

	reg CLK;

	wire RESET;
	wire RX;
	wire START;
	wire [7:0] DATA_TX;
	wire [11:0] WORK_FR;
	wire TX;
	wire [7:0] DATA_RX;
	wire PARITY_RX;
	wire READY_TX;
	wire READY;

	integer i;
	integer a;
	//assign DATA_TX = DATA_RX;

	initial
	 begin
	    $dumpfile("module_tb.vcd");
	    $dumpvars(0,module_tb);
	    $global_init;
	    i=0;
	    a=10;
	 end

	initial CLK = 1'b0;
	always #(a) CLK = ~CLK;

	UART DUT(
			.CLK(CLK),
			.RESET(RESET),
			.RX(RX),
			.START(START),
			.DATA_TX(DATA_TX),
			.WORK_FR(WORK_FR),
			.TX(TX),
			.DATA_RX(DATA_RX),
			.PARITY_RX(PARITY_RX),
			.READY_TX(READY_TX),
			.READY(READY)
		);


	always@(posedge CLK)
		$reset_uart;

	always@(posedge CLK)
		$run_sim;

	//FLAG USED TO FINISH SIMULATION PROGRAM 
	always@(posedge CLK)
	begin
		wait(i == 1);
		$finish();
	end

endmodule
