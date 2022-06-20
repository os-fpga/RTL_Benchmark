module irda_mir_rx (clk, wb_rst_i, rx_i, mir_rxbit_enable, mir_rx_restart,
			rxfifo_dat_i, rxfifo_add, mir_crc_error, mir_ifdlr_o, mir_sto_detected, mir_rx_error );

/// ADD BREAK SUPPORT

input 		  clk;
input 		  wb_rst_i;
input 		  rx_i;			// input stream
input 		  mir_rxbit_enable;
input 		  mir_rx_restart;

output [31:0] rxfifo_dat_i;
output 		  rxfifo_add;
output 		  mir_crc_error;
output [15:0] mir_ifdlr_o;
output 		  mir_sto_detected;
output 		  mir_rx_error;

reg [31:0] 	  rxfifo_dat_i;
reg 			  rxfifo_add;
reg 			  mir_crc_error;
reg 			  bds_restart;
reg 			  std_restart;
reg 			  clrcrc;

wire [15:0]   mir_ifdlr_o;

// STx signal detector
irda_mir_st_det st_det(
		.clk(					clk					),
		.wb_rst_i(			wb_rst_i				),
		.rx_i(				rx_i					),
		.mir_rxbit_enable(mir_rxbit_enable	),
		.std_restart(		std_restart			),
		.std_is_good_bit(	std_is_good_bit	),
		.std_st_detected(	std_st_detected	),
		.std_o(				std_o					)
	);

// Break condition detector
irda_mir_break_det br_det(
		.clk(						clk					),
		.wb_rst_i(				wb_rst_i				),
		.mir_rxbit_enable(	mir_rxbit_enable	),
		.rx_i(					rx_i					),
		.brd_o(					brd_o					)
	);

// Bit de-stuffer module
irda_mir_bit_destuffer bds(
		.clk(					clk					),
		.wb_rst_i(			wb_rst_i				),
		.bds_i(				bds_i					),
		.bds_restart(		bds_restart			),
		.mir_rxbit_enable(mir_rxbit_enable	),
		.std_is_good_bit(	std_is_good_bit	),
		.bds_is_data_bit(	bds_is_data_bit	),
		.bds_o(				bds_o					)
	);

// CRC-CCITT16 with parallel output
wire [15:0] crc16_par_o;

irda_crc_rx_ccitt16 crc_rx(
		.clk(					clk					),
		.wb_rst_i(			wb_rst_i				),
		.clrcrc(				clrcrc				),
		.txdin(				txdin					),
		.crcndata(			1'b0					),
		.mir_rxbit_enable(mir_rxbit_enable	),
		.bds_is_data_bit( bds_is_data_bit	),
		.txdout(				txdout				),
		.bdcrc(				bdcrc					),
		.crc16_par_o(		crc16_par_o			)
	);

// shift register for 16 bits to hold incoming crc at the end of frame
wire [15:0] par_o;

assign 		txdin = bds_o;
assign 		bds_i = std_o;

// IRDA_RECEIVER FSM
reg [2:0] 	counter8;
parameter 	st_idle=0, st_stx_detected=1, st_data=2, st_sto_detected=3;
reg [30:0] 	temp31; // 31-bit temporary register for incoming data storage
reg [4:0] 	bit_pos; //
reg [1:0] 	rxstate;
reg [18:0] 	bitcount;

always @(posedge clk or posedge wb_rst_i)
begin
	if (wb_rst_i) begin
		rxstate 			  <= #1 st_idle;
		counter8 		  <= #1 0;
		bit_pos 			  <= #1 0;
		rxfifo_dat_i 	  <= #1 0;
		temp31 			  <= #1 0;
		mir_crc_error 	  <= #1 0;
		bitcount 		  <= #1 0;
		rxfifo_add 		  <= #1 0;
		std_restart 	  <= #1 1;
		clrcrc 			  <= #1 0;
		bds_restart 	  <= #1 0;	
	end
	else if (brd_o | mir_rx_restart) begin
		rxstate 			  <= #1 st_idle;
		counter8 		  <= #1 0;
		bit_pos 			  <= #1 0;
		rxfifo_dat_i 	  <= #1 0;
		temp31 			  <= #1 0;
		mir_crc_error 	  <= #1 0;
		bitcount 		  <= #1 0;
		rxfifo_add 		  <= #1 0;
		clrcrc 			  <= #1 0;
		std_restart 	  <= #1 1;
		bds_restart      <= #1 1;
	end
	else if (mir_rxbit_enable)
	case (rxstate)
		st_idle :
		  begin
			  std_restart <= #1 0;
			  bds_restart <= #1 0;
			  if (std_st_detected)
			  begin
				  clrcrc 	  <= #1 1;
				  rxstate 	  <= #1 st_stx_detected;
				  counter8 	  <= #1 7;
			  end
			  mir_crc_error 	 <= #1 0;
			  bitcount 			 <= #1 0;
		  end
		st_stx_detected :
		  begin
			  if (counter8!=0)
				 counter8 	  <= #1 counter8 - 1;
			  else
				if (std_st_detected)
				  counter8 	  <= #1 7;
				else begin
					rxstate 	  <= #1 st_data;
					bit_pos 	  <= #1 0;
					temp31 	  <= #1 0;
					clrcrc 	  <= #1 0;
				end
		  end
	  st_data :
		  begin
			  clrcrc <= #1 0;
			  //// DEBUG
			  $display("%m, %t Received #%d: %b", $time, bit_pos, bds_o); 
			  //// END DEBUG
				if (std_st_detected) begin  /// end of frame (STO) detected
					/// DEBUG
					$display("%m, %t, Pushing %b", $time,{bds_o, temp31} );
					/// END DEBUG
					rxstate 			 <= #1 st_sto_detected;
					rxfifo_dat_i 	 <= #1 {bds_o, temp31}; // push to fifo
					rxfifo_add 		 <= #1 1;
				end else
				if (bds_is_data_bit) begin  // if good bit
					bitcount <= #1 bitcount + 1;
					if (bit_pos==31) begin // the temporary word is full
						/// DEBUG
						$display("%m, %t, Pushing %b", $time,{bds_o, temp31} );
						/// END DEBUG						
						 rxfifo_dat_i 	 <= #1 {bds_o, temp31}; // push to fifo
						rxfifo_add 		 <= #1 1;
						bit_pos 			 <= #1 0;
						temp31 			 <= #1 0;
					end else begin 
						temp31[bit_pos] 	 <= #1 bds_o;
						bit_pos 				 <= #1 bit_pos + 1;
						rxfifo_add 			 <= #1 0;
						rxfifo_dat_i 		 <= #1 0;
					end
				end else begin
					rxfifo_add 		 <= #1 0;
					rxfifo_dat_i 	 <= #1 0;
				end // else: !if(bds_is_data_bit)
		  end
		st_sto_detected :
			begin
				rxfifo_add 	  <= #1 0;
				if (crc16_par_o==16'b0001_1101_0000_1111) begin // if the crc is correct
					mir_crc_error 	  <= #1 0;
				end else begin
					mir_crc_error 	  <= #1 1;
				end
				rxstate <= #1 st_idle;
			end
		default :
			rxstate <= #1 st_idle; // should never get here
	endcase

end

assign mir_ifdlr_o = bitcount[18:3];
assign mir_sto_detected = (rxstate == st_sto_detected);
assign mir_rx_error = brd_o;

endmodule
