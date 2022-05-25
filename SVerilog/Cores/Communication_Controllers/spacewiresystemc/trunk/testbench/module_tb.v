`timescale 1ns/1ns
`default_nettype none

module module_tb;

	reg CLK_SIM;
	reg CLK_SYS_RX;

	`ifdef VERILOG_A

		/*SPWTCR*/
		wire CLOCK;
		reg CLK;
		wire RESETn;
		wire LINK_START;
		wire LINK_DISABLE;
		wire AUTOSTART;
		wire [2:0] CURRENTSTATE;
		wire [10:0] FLAGS;
		wire [8:0] DATA_I;
		wire WR_DATA;
		wire TX_FULL;
		wire [8:0] DATA_O;
		wire RD_DATA;
		wire RX_EMPTY;
		wire TICK_OUT;
		wire [7:0] TIME_OUT;
		wire TICK_IN;
		wire [7:0] TIME_IN;
		wire [6:0] TX_CLK_DIV;
		wire SPILL_ENABLE;
		wire Din; 
		wire Sin;
		wire Dout;
		wire Sout;

		wire [3:0] SPW_SC_FSM;
		wire [3:0] SPW_SC_FSM_OUT;
		wire RX_CLOCK_RECOVERY_SC;
		wire TX_CLOCK_RECOVERY_VLOG;
		wire TX_CLOCK_OUT;
		wire TX_CLOCK_OUT_SC;

		integer i;
		integer time_clk_ns;

		assign SPILL_ENABLE = 1'b1;

		initial
		 begin
			$dumpfile("module_tb.vcd");
			$dumpvars(0,module_tb);
			$global_init;
			i=0;
			time_clk_ns = 500;
		 end

		assign RX_CLOCK_RECOVERY_SC = Din ^ Sin;
		assign TX_CLOCK_OUT_SC = TX_CLOCK_OUT;
		assign SPW_SC_FSM_OUT = SPW_SC_FSM;

		assign TX_CLOCK_RECOVERY_VLOG = Dout ^ Sout;

		assign CLOCK = CLK;

		initial CLK = 1'b0;
		always #(10) CLK = ~CLK;

		SPW_TOP DUT_TCR (
				.CLOCK(CLOCK),
				.RESETn(RESETn),
				.LINK_START(LINK_START),
				.LINK_DISABLE(LINK_DISABLE),
				.AUTOSTART(AUTOSTART),
				.CURRENTSTATE(CURRENTSTATE),
				.FLAGS(FLAGS),
				.DATA_I(DATA_I),
				.WR_DATA(WR_DATA),
				.TX_FULL(TX_FULL),
				.DATA_O(DATA_O),
				.RD_DATA(RD_DATA),
				.RX_EMPTY(RX_EMPTY),
				.TICK_OUT(TICK_OUT),
				.TIME_OUT(TIME_OUT),
				.TICK_IN(TICK_IN),
				.TIME_IN(TIME_IN),
				.TX_CLK_DIV(TX_CLK_DIV),
				.SPILL_ENABLE(SPILL_ENABLE),
				.Din(Din), 
				.Sin(Sin),
				.Dout(Dout),
				.Sout(Sout)
			);

			always@(posedge CLK)
				$global_reset;

			always@(posedge CLK)
				$write_tx_spw;

			always@(posedge CLK)
				$receive_rx_spw;
			//
			always@(posedge CLK)
				$run_sim;

			//FLAG USED TO FINISH SIMULATION PROGRAM 
			always@(posedge CLK)
			begin
				wait(i == 1);
				$finish();
			end
	`endif

	`ifdef VERILOG_B
		assign TOP_SIN = TOP_SOUT;
		assign TOP_DIN = TOP_DOUT;
	 	

		integer time_clk_ns;

		reg PCLK;
		reg PCLK_FIFO;
		reg PPLLCLK;

		wire RESETN;

		wire TOP_SIN;
		wire TOP_DIN;

		wire AUTO_START;
		wire LINK_START;
		wire LINK_DISABLE;

		wire TOP_TX_WRITE;
		wire [8:0] TOP_TX_DATA;

		wire TOP_TX_TICK;
		wire [7:0] TOP_TX_TIME;

		wire CREDIT_ERROR_RX;
		wire TOP_SEND_FCT_NOW;

		wire [8:0] DATARX_FLAG;
		wire BUFFER_READ;

		wire [7:0] TIME_OUT;
		wire TICK_OUT;

		wire TOP_DOUT;
		wire TOP_SOUT;

		wire TOP_TX_READY;
		wire TOP_TX_READY_TICK;

		wire [5:0] TOP_FSM;
		wire [5:0] COUNTER_FIFO_RX;
		wire [5:0] COUNTER_FIFO_TX;

		wire TX_CLOCK_RECOVERY_VLOG;
		wire [3:0] SPW_SC_FSM;
		wire [3:0] SPW_SC_FSM_OUT;

		wire [31:0] counter;
		wire [3:0] global_counter_actual;
		wire [13:0] data_took_is;
		wire din_out;
		wire sin_out;

		wire F_FULL,F_EMPTY,F_FULL_RX,F_EMPTY_RX; 

		assign TX_CLOCK_RECOVERY_VLOG = TOP_DOUT ^ TOP_SOUT;
		assign SPW_SC_FSM_OUT = SPW_SC_FSM;

		integer i;

		initial
		begin
			$dumpfile("module_tb.vcd");
			$dumpvars(0,module_tb);
			$global_init;
			i=0;
			time_clk_ns = 500;
		 end

		initial PCLK = 1'b0;
		always #(5) PCLK = ~PCLK;

		initial PCLK_FIFO = 1'b0;
		always #(10) PCLK_FIFO = ~PCLK_FIFO;

		initial PPLLCLK = 1'b0;
		always #(time_clk_ns/2) PPLLCLK = ~PPLLCLK;

		initial CLK_SIM = 1'b0;
		always #(1) CLK_SIM = ~CLK_SIM;

		initial CLK_SYS_RX = 1'b0;
		always #(4) CLK_SYS_RX = ~CLK_SYS_RX;
		
		spw_ulight_con_top_x DUT_ULIGHT(
					.ppll_100_MHZ(PCLK),
					.ppllclk(PPLLCLK),
					.reset_spw_n_b(RESETN),

					.top_sin(TOP_SIN),
					.top_din(TOP_DIN),

					.top_auto_start(AUTO_START),
					.top_link_start(LINK_START),
					.top_link_disable(LINK_DISABLE),

					.top_tx_write(TOP_TX_WRITE),
					.top_tx_data(TOP_TX_DATA),

					.top_tx_tick(TOP_TX_TICK),
					.top_tx_time(TOP_TX_TIME),

					.datarx_flag(DATARX_FLAG),
					.read_rx_fifo_en(BUFFER_READ),

					.time_out(TIME_OUT),
					.tick_out(TICK_OUT),

					.top_dout(TOP_DOUT),
					.top_sout(TOP_SOUT),

					.f_full(F_FULL),
					.f_empty(F_EMPTY),
					.f_full_rx(F_FULL_RX),
					.f_empty_rx(F_EMPTY_RX),
					.top_tx_ready_tick(TOP_TX_READY_TICK),

					.top_fsm(TOP_FSM),
					.counter_fifo_tx(COUNTER_FIFO_TX),
					.counter_fifo_rx(COUNTER_FIFO_RX)
				      );

		

	//
	always@(posedge PCLK_FIFO)
		$write_tx_fsm_spw_ultra_light;
	//
	always@(posedge PCLK_FIFO)
		$write_tx_data_spw_ultra_light;

	always@(posedge PCLK_FIFO)
		$write_tx_time_code_spw_ultra_light;
	//
	always@(posedge PCLK_FIFO)
		$receive_rx_data_spw_ultra_light;
		
	always@(posedge TICK_OUT)
		$receive_rx_time_code_spw_ultra_light;

	//
	always@(posedge PCLK , negedge PCLK)
		$global_reset;
	
	//
	always@(posedge CLK_SIM)
		$run_sim;

	//FLAG USED TO FINISH SIMULATION PROGRAM 
	always@(posedge CLK_SIM)
	begin
		wait(i == 1);
		$finish();
	end

	`endif


endmodule
