/*
--------------------------------------------------------------------------------

Module: hive_uart_rx

Function: 
- Forms the RX side of a DATA_W,n,1 RS232 UART.

Instantiates:
- Nothing.

Notes:
- Rising edge of baud_i is employed.
- baud_i / OSR = uart baud (bit) rate.
- baud_i must be synchronous to clk_i.
- Serial data is non-inverted; quiescent serial state is high (assumes 
  external inverting buffer).
- Bits are in this order (@ serial port of this module, line s/b inverted): 
  - 1 start bit (low), 
  - DATA_W data bits (LSB first, MSB last), 
  - 1 or more stop bits (high).
- The parallel data interface may be connected to a FIFO or similar.
- Start & stop errors are presented simultaneously with the write pulse so 
  external logic can decide whether or not to accept the data.
- Start & stop errors are an indication of noise on the line / incorrect baud
  rate.
- Bad buffer error happens when external data store doesn't take RX data
  before another byte arrives (data loss).
- Parameterized data width.
- Parameterized oversampling rate.
- Parameterized input resync depth.

--------------------------------------------------------------------------------
*/

module hive_uart_rx
	#(
	parameter								DATA_W				= 8,		// parallel data width (bits)
	parameter								OSR 					= 16,		// BAUD oversample rate (3 or larger)
	parameter								SYNC_W 				= 2		// number of resync regs (1 or larger)
	)
	(
	// clocks & resets
	input		logic							clk_i,							// clock
	input		logic							rst_i,							// async. reset, active hi
	// timing interface
	input		logic							baud_i,							// baud clock
	// parallel interface	
	output	logic	[DATA_W-1:0]		rx_data_o,						// data
	output	logic							rx_rdy_o,						// ready with data, active hi
	input		logic							rx_rd_i,							// data read, active hi
	// serial interface
	input		logic							rx_i,								// serial data
	// debug
	output	logic							rx_bad_start_o,				// bad start bit, active hi
	output	logic							rx_bad_stop_o,					// bad stop bit, active hi
	output	logic							rx_bad_buf_o					// bad buffering, active hi
	);


	/*
	----------------------
	-- internal signals --
	----------------------
	*/
	localparam								PHASE_W				= $clog2( OSR );
	localparam								PHASE_MID 			= OSR/2;
	localparam								PHASE_MAX 			= OSR-1;
	localparam								BIT_MAX 				= DATA_W+1;
	localparam								BIT_W 				= $clog2( BIT_MAX );
	//
	logic				[SYNC_W-1:0]		sync_sr;
	logic										rx;
	logic				[1:0]					baud_sr;
	logic										baud_f;
	//
	logic				[PHASE_W-1:0]		phase_c;
	logic										sample_f, bit_done_f;
	//
	logic				[BIT_W-1:0]			bit_c;
	logic										word_done_f;
	//
	logic				[DATA_W+1:0]		rx_data_sr;
	//
	typedef enum
		{
		st_idle,
		st_data,
		st_load,
		st_wait
		} STATE_T;
	STATE_T									state_m, state;


	/*
	================
	== code start ==
	================
	*/


	/*
	-----------
	-- input --
	-----------
	*/
	
	// register rx_i to resync
	always_ff @ ( posedge clk_i or posedge rst_i ) begin
		if ( rst_i ) begin
			sync_sr <= '1;  // note: preset!
		end else begin
			sync_sr <= SYNC_W'( { sync_sr, rx_i } );
		end
	end

	// assign
	always_comb rx = sync_sr[SYNC_W-1];
	

	// register to detect edges
	always_ff @ ( posedge clk_i or posedge rst_i ) begin
		if ( rst_i ) begin
			baud_sr <= '0;
		end else begin
			baud_sr <= { baud_sr[0], baud_i };
		end
	end

	// decode rising edge
	always_comb baud_f = ( baud_sr == 2'b01 );
	

	/*
	--------------
	-- counters --
	--------------
	*/

	// form the phase_c & bit_c up-counters
	always_ff @ ( posedge clk_i or posedge rst_i ) begin
		if ( rst_i ) begin
			phase_c <= '0;
			bit_c <= '0;
		end else begin
			if ( state_m != st_data ) begin
				phase_c <= '0;
				bit_c <= '0;
			end else if ( bit_done_f ) begin
				phase_c <= '0;
				bit_c <= bit_c + 1'b1;
			end else if ( baud_f ) begin
				phase_c <= phase_c + 1'b1;
			end
		end
	end

	// decode flags
	always_comb sample_f = ( ( phase_c == PHASE_MID ) & baud_f );
	always_comb bit_done_f   = ( ( phase_c == PHASE_MAX ) & baud_f );
	always_comb word_done_f  = ( ( bit_c == BIT_MAX ) & sample_f );


	/*
	-------------------
	-- state machine --
	-------------------
	*/

	// state mux
	always_comb begin
		state_m <= state;  // default: stay in current state
		case ( state )
			st_idle : begin  // idle
				if ( ~rx ) begin
					state_m <= st_data;  // proceed
				end
			end
			st_data : begin  // data bits
				if ( word_done_f ) begin
					state_m <= st_load;  // load
				end
			end
			st_load, st_wait : begin
				if ( rx ) begin
					state_m <= st_idle;  // done
				end else begin
					state_m <= st_wait;  // bad stop bit
				end
			end
			default : begin  // for fault tolerance
				state_m <= st_idle;
			end
		endcase
	end

	// register state
	always_ff @ ( posedge clk_i or posedge rst_i ) begin
		if ( rst_i ) begin
			state <= st_idle;
		end else begin
			state <= state_m;
		end
	end


	/*
	---------------------
	-- data conversion --
	---------------------
	*/
	
	// serial => parallel conversion
	always_ff @ ( posedge clk_i or posedge rst_i ) begin
		if ( rst_i ) begin
			rx_data_sr <= '0;
		end else begin
			if ( sample_f ) begin
				rx_data_sr <= { rx, rx_data_sr[DATA_W+1:1] };
			end
		end
	end


	/*
	------------
	-- output --
	------------
	*/

	// register outputs
	always_ff @ ( posedge clk_i or posedge rst_i ) begin
		if ( rst_i ) begin
			rx_data_o <= '0;
			rx_rdy_o <= '0;
			rx_bad_start_o <= '0;
			rx_bad_stop_o <= '0;
			rx_bad_buf_o <= '0;
		end else begin
			if ( state == st_load ) begin
				rx_data_o <= rx_data_sr[DATA_W:1];
				rx_rdy_o <= 'b1;
				rx_bad_start_o <= rx_data_sr[0];
				rx_bad_stop_o <= ~rx_data_sr[DATA_W+1];
				rx_bad_buf_o <= ( ~rx_rd_i & rx_rdy_o );
			end else begin
				rx_rdy_o <= ~rx_rd_i & rx_rdy_o;
			end
		end
	end

endmodule
