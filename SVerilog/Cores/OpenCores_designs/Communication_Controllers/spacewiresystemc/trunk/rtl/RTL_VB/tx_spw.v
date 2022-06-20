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
//e.g.DATA_WIDTH	[32,16]	: width of the DATA : 32:
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

module TX_SPW (
		input pclk_tx,
		//
		input [8:0] data_tx_i,
		input txwrite_tx,
		//
		input [7:0] timecode_tx_i,
		input tickin_tx,
		//
		input enable_tx,
		input send_null_tx,
		input send_fct_tx,
 
		//
		input gotfct_tx,
		input send_fct_now,
		//
		//
		output ready_tx_data,
		output ready_tx_timecode,

		output tx_dout_e,
		output tx_sout_e

		);
	wire [13:0] timecode_s;

	wire [5:0]  last_type;
	wire txdata_flagctrl_tx_last;

	wire [8:0]  tx_data_in;
	wire [8:0]  tx_data_in_0;
	wire process_data;
	wire process_data_0;

	wire last_timein_control_flag_tx;

	wire [7:0]  tx_tcode_in;
	wire tcode_rdy_trnsp;

	wire fct_counter_p;
	wire [2:0] fct_flag_p;

	wire get_data;
	wire get_data_0;

	wire char_sent;
	wire fct_sent;

	wire tx_dout;
	wire tx_sout;

tx_fsm_m  tx_fsm(
		.pclk_tx(pclk_tx),
	
		.enable_tx(enable_tx),
		.send_null_tx(send_null_tx),
		.send_fct_tx(send_fct_tx),

		.get_data(get_data),
		.get_data_0(get_data_0),

		.tx_data_in(tx_data_in),
		.tx_data_in_0(tx_data_in_0),
		.process_data(process_data),
		.process_data_0(process_data_0),

		.tx_tcode_in(tx_tcode_in),
		.tcode_rdy_trnsp(tcode_rdy_trnsp),
		
		.ready_tx_data(ready_tx_data),
		.ready_tx_timecode(ready_tx_timecode),

		.fct_great_than_zero(fct_counter_p),

		.gotfct_tx(gotfct_tx),
		.send_fct_now(send_fct_now),

		.tx_dout_e(tx_dout_e),
		.tx_sout_e(tx_sout_e)

	);

tx_data_send tx_data_snd(
			.pclk_tx(pclk_tx),
			.send_null_tx(send_null_tx),
			.enable_tx(enable_tx),

			.get_data(get_data),
			.get_data_0(get_data_0),

			.timecode_tx_i(timecode_tx_i),
			.tickin_tx(tickin_tx),

			.data_tx_i(data_tx_i),
			.txwrite_tx(txwrite_tx),

			.fct_counter_p(fct_counter_p),

			.tx_data_in(tx_data_in),
			.tx_data_in_0(tx_data_in_0),

			.process_data(process_data),
			.process_data_0(process_data_0),

			.tx_tcode_in(tx_tcode_in),
			.tcode_rdy_trnsp(tcode_rdy_trnsp)
);
endmodule
