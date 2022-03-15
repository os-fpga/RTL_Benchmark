/*
--------------------------------------------------------------------------------

Module: hive_uart_tx

Function: 
- Forms the TX side of a DATA_W,n,STOP_BITS RS232 UART.

Instantiates:
- Nothing.

Notes:
- Rising edge of baud_i is employed.
- baud_i / OSR = uart baud (bit) rate.
- baud_i mist be synchronous to clk_i.
- Serial data is non-inverted; quiescent serial state is high (assumes 
  external inverting buffer).
- Bits are in this order (@ serial port of this module, line s/b inverted): 
  - 1 start bit (low), 
  - DATA_W data bits (LSB first, MSB last), 
  - 1 or more stop bits (high).
- The parallel data interface may be connected to a FIFO or similar.
- Parameterized data width.
- Parameterized oversampling rate.
- Parameterized stop bits.

--------------------------------------------------------------------------------
*/

module hive_uart_tx
	#(
	parameter								DATA_W				= 8,		// parallel data width (bits)
	parameter								OSR		 			= 16,		// BAUD clock oversample rate (3 or larger)
	parameter								STOP_BITS 			= 1		// number of stop bits
	)
	(
	// clocks & resets
	input		logic							clk_i,							// clock
	input		logic							rst_i,							// async. reset, active hi
	// timing interface
	input		logic							baud_i,							// baud clock
	// parallel interface	
	input		logic	[DATA_W-1:0]		tx_data_i,						// data
	output	logic							tx_rdy_o,						// ready for data, active hi
	input		logic							tx_wr_i,							// data write, active high
	// serial interface
	output	logic							tx_o								// serial data
	);


	/*
	----------------------
	-- internal signals --
	----------------------
	*/
	localparam								PHASE_W				= $clog2( OSR );
	localparam								PHASE_MAX 			= OSR-1;
	localparam								BIT_MAX 				= DATA_W+STOP_BITS;
	localparam								BIT_W 				= $clog2( BIT_MAX );
	//
	logic				[1:0]					baud_sr;
	logic										baud_f;
	logic				[DATA_W-1:0]		tx_data_r;
	//
	logic				[PHASE_W-1:0]		phase_c;
	logic										bit_done_f;
	//
	logic				[BIT_W-1:0]			bit_c;
	logic										word_done_f;
	//
	logic				[DATA_W:0]			tx_data_sr;
	logic										load_f;
	//
	typedef enum
		{
		st_idle,
		st_wait,
		st_load,
		st_data
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
	
	// register parallel data
	always_ff @ ( posedge clk_i or posedge rst_i ) begin
		if ( rst_i ) begin
			tx_data_r <= '0;
			tx_rdy_o <= 'b1;
		end else begin
			if ( tx_wr_i ) begin
				tx_data_r <= tx_data_i;
				tx_rdy_o <= '0;
			end else if ( load_f ) begin
				tx_rdy_o <= 'b1;
			end
		end
	end


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
	always_comb bit_done_f   = ( ( phase_c == PHASE_MAX ) & baud_f );
	always_comb word_done_f  = ( ( bit_c == BIT_MAX ) & bit_done_f );


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
				if ( ~tx_rdy_o ) begin
					state_m <= st_wait;  // proceed
				end
			end
			st_wait : begin  // wait for baud sync
				if ( baud_f ) begin
					state_m <= st_load;  // proceed
				end
			end
			st_load : begin  // load
				state_m <= st_data;  // proceed
			end
			st_data : begin  // data bits
				if ( word_done_f ) begin
					if ( ~tx_rdy_o ) begin
						state_m <= st_load;  // do again
					end else begin
						state_m <= st_idle;  // done
					end
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
	
	// decode flags
	always_comb load_f = ( state_m == st_load );


	/*
	---------------------
	-- data conversion --
	---------------------
	*/
	
	// parallel => serial conversion
	always_ff @ ( posedge clk_i or posedge rst_i ) begin
		if ( rst_i ) begin
			tx_data_sr <= '1;
		end else begin
			if ( load_f ) begin
				tx_data_sr <= { tx_data_r, 1'b0 };
			end else if ( bit_done_f ) begin
				tx_data_sr <= { 1'b1, tx_data_sr[DATA_W:1] };
			end
		end
	end


	/*
	------------
	-- output --
	------------
	*/

	// outputs
	always_comb tx_o = tx_data_sr[0];


endmodule
