//+FHDR------------------------------------------------------------------------
//Copyright (c) 2013 Latin Group American Integhrated Circuit, Inc. All rights reserved
//GLADIC Open Source RTL
//-----------------------------------------------------------------------------
//FILE NAME	 :
//DEPARTMENT	 : IC Design / Verification
//AUTHOR	 : Felipe Fernandes da Costa
//AUTHOR’S EMAIL :
//-----------------------------------------------------------------------------
//RELEASE HISTORY
//VERSION DATE AUTHOR DESCRIPTION
//1.0 YYYY-MM-DD name
//-----------------------------------------------------------------------------
//KEYWORDS : General file searching keywords, leave blank if none.
//-----------------------------------------------------------------------------
//PURPOSE  : ECSS_E_ST_50_12C_31_july_2008
//-----------------------------------------------------------------------------
//PARAMETERS
//PARAM NAME		RANGE	: DESCRIPTION : DEFAULT : UNITS
//e.g.DATA_WIDTH	[32,16]	: width of the data : 32:
//-----------------------------------------------------------------------------
//REUSE ISSUES
//Reset Strategy	:
//Clock Domains		:
//Critical Timing	:
//Test Features		:
//Asynchronous I/F	:
//Scan Methodology	:
//Instantiations	:
//Synthesizable (y/n)	:
//Other			:
//-FHDR------------------------------------------------------------------------

`timescale 1ns/1ns

module top_spw_ultra_light(

	input pclk,
	input ppllclk,
	input resetn,

	input top_sin,
	input top_din,

	input top_auto_start,
	input top_link_start,
	input top_link_disable,

	input top_tx_write,
	input [8:0] top_tx_data,

	input top_tx_tick,
	input [7:0] top_tx_time,

	input credit_error_rx,
	input top_send_fct_now,

	output [8:0] datarx_flag,
	output buffer_write,

	output [7:0] time_out,
	output tick_out,

	output top_dout,
	output top_sout,

	output top_tx_ready,
	output top_tx_ready_tick,

	output [5:0] top_fsm

	);

	wire resetn_rx;
	wire error_rx;

	wire got_bit_rx;
	wire got_null_rx;
	wire got_nchar_rx;
	wire got_time_code_rx;
	wire got_fct_rx;

	wire enable_tx;
	wire send_null_tx;
	wire send_fct_tx;

	wire got_fct_flag_fsm;

	FSM_SPW FSM(
			.pclk(pclk),
			.resetn(resetn),

			.auto_start(top_auto_start),
			.link_start(top_link_start),
			.link_disable(top_link_disable),

			.rx_error(error_rx),
			.rx_credit_error(credit_error_rx),
			.rx_got_bit(got_bit_rx),
			.rx_got_null(got_null_rx),
			.rx_got_nchar(got_nchar_rx),
			.rx_got_time_code(got_time_code_rx),
			.rx_got_fct(got_fct_flag_fsm),
			.rx_resetn(resetn_rx),

			.enable_tx(enable_tx),
			.send_null_tx(send_null_tx),
			.send_fct_tx(send_fct_tx),

			.fsm_state(top_fsm)
	
			);


	RX_SPW RX(
			.rx_din(top_din),
			.rx_sin(top_sin),
			.rx_resetn(resetn_rx),

			.rx_error(error_rx),
			.rx_got_bit(got_bit_rx),
			.rx_got_null(got_null_rx),
			.rx_got_nchar(got_nchar_rx),
			.rx_got_time_code(got_time_code_rx),
			.rx_got_fct(got_fct_rx),
			.rx_got_fct_fsm(got_fct_flag_fsm),

			.rx_data_flag(datarx_flag),
			.rx_buffer_write(buffer_write),

			.rx_time_out(time_out),
			.rx_tick_out(tick_out)

 			 );

	TX_SPW        TX(
			.pclk_tx(ppllclk),

			.data_tx_i(top_tx_data),
			.txwrite_tx(top_tx_write),
		
			.timecode_tx_i(top_tx_time),
			.tickin_tx(top_tx_tick),
		
			.enable_tx(enable_tx),
			.send_null_tx(send_null_tx),
			.send_fct_tx(send_fct_tx),

			.gotfct_tx(got_fct_rx),
			.send_fct_now(top_send_fct_now),
		
			.tx_dout_e(top_dout),
			.tx_sout_e(top_sout),

			.ready_tx_data(top_tx_ready),
			.ready_tx_timecode(top_tx_ready_tick)
			);

endmodule
