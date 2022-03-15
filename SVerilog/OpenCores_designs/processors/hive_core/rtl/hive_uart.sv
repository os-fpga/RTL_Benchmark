/*
--------------------------------------------------------------------------------

Module: hive_uart

Function: 
- TX/RX DATA_W,n,1 RS232 UART.

Instantiates:
- (1x) ramp_tri_sq.sv
- (1x) hive_uart_tx.sv
- (1x) hive_uart_rx.sv
- (1x) hive_base_reg.sv

Notes:
- See individual components for details.
- Serial loopback does not disconnect serial TX interface.
- Baud rate is fixed, baud clock is calculated from the input parameters.
- Common baud rates are 2400, 3600, and 2x multiples of these:
  - 2400, 4800, 9600, 19200, 38400, 76800, 153600
  - 3600, 7200, 14400, 28800, 57600, 115200

--------------------------------------------------------------------------------
*/

module hive_uart
	(
	// clocks & resets
	input		logic							clk_i,							// clock
	input		logic							rst_i,							// async. reset, active hi
	// rbus interface
	input		logic	[RBUS_ADDR_W-1:0]	rbus_addr_i,					// address
	input		logic							rbus_wr_i,						// data write enable, active high
	input		logic							rbus_rd_i,						// data read enable, active high
	input		logic	[ALU_W-1:0]			rbus_wr_data_i,				// write data
	output	logic	[ALU_W-1:0]			rbus_rd_data_o,				// read data
	// serial interface
	output	logic							uart_tx_o,						// serial data
	input		logic							uart_rx_i,						// serial data
	// debug
	input		logic							loop_i							// serial loopback enable, active hi
	);


	/*
	----------------------
	-- internal signals --
	----------------------
	*/	
	import hive_params::*; 
	import hive_defines::*; 
	//
	// calculations to set DDS parameters
	//
	localparam								FREQ_W				= 8;  // sets maximum error
	localparam								BAUD_HZ				= UART_BAUD*UART_OSR;
	localparam								N						= CLK_HZ/BAUD_HZ;
	localparam								RAMP_W				= $clog2(N)+FREQ_W-1;
	localparam								FREQ					= (2**RAMP_W)/N;
	//
	logic										baud;
	logic			[UART_DATA_W-1:0]		tx_data, rx_data;
	logic										tx_rdy, rx_rdy;
	logic										tx_wr, rx_rd;


	
	/*
	================
	== code start ==
	================
	*/


	// baud generator
	ramp_tri_sq
	#(
	.FREQ_W				( FREQ_W ),
	.RAMP_W				( RAMP_W ),
	.SGN_O				( 0 )
	)
	ramp_tri_sq_inst
	(
	.*,
	.en_i					( 1'b1 ),
	.sync_i				(  ),  // unused
	.freq_i				( FREQ ),
	.ramp_o				(  ),  // unused
	.tri_o				(  ),  // unused
	.sq_o					( baud )
	);


	// tx side
	hive_uart_tx
	#(
	.DATA_W				( UART_DATA_W ),
	.OSR 					( UART_OSR ),
	.STOP_BITS			( UART_STOP_BITS )
	)
	hive_uart_tx_inst
	(
	.*,
	.baud_i				( baud ),
	.tx_data_i			( tx_data ),
	.tx_rdy_o			( tx_rdy ),
	.tx_wr_i				( tx_wr ),
	.tx_o					( uart_tx_o )
	);


	// rx side
	hive_uart_rx
	#(
	.DATA_W				( UART_DATA_W ),
	.OSR 					( UART_OSR ),
	.SYNC_W	 			( SYNC_W )
	)
	hive_uart_rx_inst
	(
	.*,
	.baud_i				( baud ),
	.rx_data_o			( rx_data ),
	.rx_rdy_o			( rx_rdy ),
	.rx_rd_i				( rx_rd ),
	.rx_i					( loop_i ? uart_tx_o : uart_rx_i ),
	.rx_bad_start_o	(  ),
	.rx_bad_stop_o		(  ),
	.rx_bad_buf_o		(  )
	);


	// rbus registers
	hive_base_reg
	#(
	.DATA_W			( ALU_W ),
	.ADDR_W			( RBUS_ADDR_W ),
	.ADDR				( `UART_ADDR ),
	.WR_MODE			( "THRU" ),
	.RD_MODE			( "THRU" ),
	.WR_MASK			( { UART_DATA_W{ 1'b1 } } ),
	.RD_MASK			( { 2+UART_DATA_W{ 1'b1 } } )
	)
	uart_reg
	(
	.*,
	.reg_wr_o		( tx_wr ),
	.reg_rd_o		( rx_rd ),
	.reg_data_o		( tx_data ),
	.reg_data_i		( { tx_rdy, rx_rdy, rx_data } )
	);

	
endmodule
