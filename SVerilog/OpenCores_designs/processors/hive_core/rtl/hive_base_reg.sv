/*
--------------------------------------------------------------------------------

Module: hive_base_reg

Function: 
- Single base processor register w/ multiple type & input options (synchronous).

Instantiates: 
- (1x) in_cond.sv

Notes:
- Init value for each latched bit.
- WR/RD_MASK[i]=1 indicates live bit.
- WR/RD_MASK[i]=0 indicates dead bit (zero).
- Zero out associted mask bits to kill read/write logic.
- For completely dead read or write side, pick "LOOP" or "THRU" 
  mode to minimize register side strobe logic.
- Optional resync of inputs.
- Optional edge detection (none/rise/fall/change) of inputs.
- Input data mask & conditioning logic follows WR_MASK for 
  WR_MODE == "COW1" else RD_MASK.
- Register side rd/wr strobes are active on the clock where output
  data is updated / input data is read.
- rbus_rd_data_o is driven to zero if there is no address match.
- rbus_rd_data_o is driven by data if there is an address match, 
  regardless of the state of rbus_rd_i.
- Use large OR gate to combine multiple register set read data.

WR_MODE:
- "LOOP" : read data
- "THRU" : direct connect
- "REGS" : clocked register
- "LTCH" : latch on write
- "COW1" : set on input one, clear on write one

RD_MODE:
- "LOOP" : write data
- "THRU" : direct connect
- "REGS" : clocked register
- "LTCH" : latch on read
- "CORD" : set on input one, clear on read


--------------------------------------------------------------------------------
*/


module hive_base_reg
	#(
	parameter										DATA_W			= 8,		// data width (bits)
	parameter										ADDR_W			= 4,		// address width (bits)
	parameter	[ADDR_W-1:0]					ADDR				= 0,		// address this register responds to
	parameter										SYNC_W			= 2,		// resync registers, 2 min
	parameter										WR_MODE			= "THRU",	// modes are: "LOOP", "THRU", "REGS", "LTCH", "COW1"
	parameter										RD_MODE			= "THRU",	// modes are: "LOOP", "THRU", "REGS", "LTCH", "CORD"
	parameter	[DATA_W-1:0]					WR_MASK			= '1,		// 1=live bit, 0=dead (0)
	parameter	[DATA_W-1:0]					RD_MASK			= '1,		// 1=live bit, 0=dead (0)
	parameter	[DATA_W-1:0]					SYNC_MASK		= '0,		// 1=sync (double clock) input bit, 0=no resync
	parameter	[DATA_W-1:0]					RISE_MASK		= '0,		// 1=rising edge sensitive input bit
	parameter	[DATA_W-1:0]					FALL_MASK		= '0,		// 1=falling edge sensitive input bit
	parameter	[DATA_W-1:0]					RESET_VAL		= '0		// reset value of latched data
	)
	(
	// clocks & resets
	input			logic								clk_i,						// clock
	input			logic								rst_i,						// async. reset, active high
	// rbus interface
	input			logic	[ADDR_W-1:0]			rbus_addr_i,				// address
	input			logic								rbus_wr_i,					// write enable, active high
	input			logic								rbus_rd_i,					// read enable, active high
	input			logic	[DATA_W-1:0]			rbus_wr_data_i,			// write data
	output		logic	[DATA_W-1:0]			rbus_rd_data_o,			// read data
	// register interface
	output		logic								reg_wr_o,					// reg write active, active high
	output		logic								reg_rd_o,					// reg read active, active high
	output		logic	[DATA_W-1:0]			reg_data_o,					// reg data out
	input			logic	[DATA_W-1:0]			reg_data_i					// reg data in
	);


	/*
	----------------------
	-- internal signals --
	----------------------
	*/
	localparam	[DATA_W-1:0]					IN_MASK = ( WR_MODE == "COW1" ) ? WR_MASK : RD_MASK;
	logic												addr_match, rd_match, wr_match;
	logic												addr_f, rd_f, wr_f;
	genvar											i;
	logic			[DATA_W-1:0]					in_data, wr_data, rd_data;


	/*
	================
	== code start ==
	================
	*/


	// input conditioning
	in_cond
	#(
	.DATA_W			( DATA_W ),
	.SYNC_W			( SYNC_W ),
	.LIVE_MASK		( IN_MASK ),
	.SYNC_MASK		( SYNC_MASK ),
	.RISE_MASK		( RISE_MASK ),
	.FALL_MASK		( FALL_MASK )
	)
	reg_in_cond
	(
	.*,
	.data_i			( reg_data_i ),
	.data_o			( in_data )
	);
	

	// check for address match & strobes
	always_comb addr_match = ( rbus_addr_i == ADDR[ADDR_W-1:0] );
	always_comb rd_match   = ( rbus_rd_i & addr_match );
	always_comb wr_match   = ( rbus_wr_i & addr_match );


	// register address match flag
	always_ff @ ( posedge clk_i or posedge rst_i ) begin
		if ( rst_i ) begin
			addr_f <= '0;
		end else begin
			addr_f <= addr_match;
		end
	end


	// decode write & read strobes
	generate
		case ( WR_MODE )
			"REGS", "LTCH", "COW1" : begin
				always_comb wr_f = wr_match;
				always_ff @ ( posedge clk_i or posedge rst_i ) begin
					if ( rst_i ) begin
						reg_wr_o <= '0;
					end else begin
						reg_wr_o <= wr_f;
					end
				end
			end
			default : begin
				always_comb wr_f = wr_match;
				always_comb reg_wr_o = wr_f;
			end
		endcase
		//
		case ( RD_MODE )
			"REGS", "LTCH" : begin
				always_comb rd_f = rd_match;
				always_ff @ ( posedge clk_i or posedge rst_i ) begin
					if ( rst_i ) begin
						reg_rd_o <= '0;
					end else begin
						reg_rd_o <= rd_f;
					end
				end
			end
			"CORD" : begin
				always_ff @ ( posedge clk_i or posedge rst_i ) begin
					if ( rst_i ) begin
						rd_f <= '0;
						reg_rd_o <= '0;
					end else begin
						rd_f <= rd_match;
						reg_rd_o <= rd_f;
					end
				end
			end
			default : begin
				always_comb rd_f = rd_match;
				always_comb reg_rd_o = rd_f;
			end
		endcase
	endgenerate


	// write logic
	generate
		for ( i=0; i<DATA_W; i=i+1 ) begin : output_loop
			if ( WR_MASK[i] ) begin  // live bit
				case ( WR_MODE )
					"LOOP" : begin
						always_comb wr_data[i] = rd_data[i];
					end
					"THRU" : begin
						always_comb wr_data[i] = rbus_wr_data_i[i];
					end
					"REGS" : begin
						always_ff @ ( posedge clk_i or posedge rst_i ) begin
							if ( rst_i ) begin
								wr_data[i] <= RESET_VAL[i];
							end else begin
								wr_data[i] <= rbus_wr_data_i[i];
							end
						end
					end
					"LTCH" : begin
						always_ff @ ( posedge clk_i or posedge rst_i ) begin
							if ( rst_i ) begin
								wr_data[i] <= RESET_VAL[i];
							end else begin
								if ( wr_f ) begin
									wr_data[i] <= rbus_wr_data_i[i];
								end
							end
						end
					end
					"COW1" : begin
						always_ff @ ( posedge clk_i or posedge rst_i ) begin
							if ( rst_i ) begin
								wr_data[i] <= RESET_VAL[i];
							end else begin
								if ( wr_f ) begin
									wr_data[i] <= ( wr_data[i] & ~rbus_wr_data_i[i] ) | in_data[i];
								end else begin
									wr_data[i] <= wr_data[i] | in_data[i];
								end
							end
						end
					end
					default : begin  // unknown mode!
						initial $display ( "WR_MODE %s does not exist!", WR_MODE );
					end
				endcase
			end else begin  // dead bit
				always_comb wr_data[i] = '0;
			end
		end
	endgenerate


	// read logic
	generate
		for ( i=0; i<DATA_W; i=i+1 ) begin : read_loop
			if ( RD_MASK[i] ) begin  // live bit
				case ( RD_MODE )
					"LOOP" : begin
						always_comb rd_data[i] = wr_data[i];
					end
					"THRU" : begin
						always_comb rd_data[i] = in_data[i];
					end
					"REGS" : begin
						always_ff @ ( posedge clk_i or posedge rst_i ) begin
							if ( rst_i ) begin
								rd_data[i] <= RESET_VAL[i];
							end else begin
								rd_data[i] <= in_data[i];
							end
						end
					end
					"LTCH" : begin
						always_ff @ ( posedge clk_i or posedge rst_i ) begin
							if ( rst_i ) begin
								rd_data[i] <= RESET_VAL[i];
							end else begin
								if ( rd_f ) begin
									rd_data[i] <= in_data[i];
								end
							end
						end
					end
					"CORD" : begin
						always_ff @ ( posedge clk_i or posedge rst_i ) begin
							if ( rst_i ) begin
								rd_data[i] <= RESET_VAL[i];
							end else begin
								if ( rd_f ) begin
									rd_data[i] <= in_data[i];
								end else begin
									rd_data[i] <= rd_data[i] | in_data[i];
								end
							end
						end
					end
					default : begin  // unknown mode!
						initial $display ( "RD_MODE %s does not exist!", RD_MODE );
					end
				endcase
			end else begin  // dead bit
				always_comb rd_data[i] = '0;
			end
		end
	endgenerate


	// decode data outputs
	always_comb reg_data_o = wr_data;
	always_comb rbus_rd_data_o = ( addr_f ) ? rd_data : '0;


endmodule
