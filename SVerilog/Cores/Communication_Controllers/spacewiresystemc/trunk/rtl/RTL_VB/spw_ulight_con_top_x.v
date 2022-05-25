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

module spw_ulight_con_top_x(
				input ppll_100_MHZ,
				input ppllclk,
				input reset_spw_n_b,
									
				input top_sin,
				input top_din,
										
				input top_auto_start,
				input top_link_start,
				input top_link_disable,

				input top_tx_write,
				input [8:0] top_tx_data,

				input top_tx_tick,
				input [7:0] top_tx_time,

				input read_rx_fifo_en,

				output [8:0] datarx_flag,

				output tick_out,
				output [7:0] time_out,

				output top_dout,
				output top_sout,

				output f_full,
				output f_empty,
				output f_full_rx,
				output f_empty_rx,
				output top_tx_ready_tick,

				output [5:0]top_fsm,

				output [5:0]counter_fifo_tx,
				output [5:0]counter_fifo_rx			
				//output [13:0] data_info
			);
	
	

	wire [8:0] datarx_flag_axi;
	wire [8:0] datarx_flag_w;
	wire buffer_write_w;
	
	//wire [7:0] time_out_axi;
	
	//wire [13:0] monitor_x_axi;
	//wire [13:0] data_x;
	//wire rx_buffer_write_mon_x;

	wire credit_error_rx_w,top_send_fct_now_w;
	
	wire top_tx_write_w,top_tx_ready_w;
	wire [8:0] top_tx_data_w;
	wire tx_reset_n;

	assign tx_reset_n = (!reset_spw_n_b | top_fsm != 6'd16)?1'b0:1'b1;

	//assign time_out = time_out_w;
	assign datarx_flag = datarx_flag_axi;
	//assign data_info = data_x;
	
	top_spw_ultra_light SPW(

					.pclk(ppll_100_MHZ),
					.ppllclk(ppllclk),
					.resetn(reset_spw_n_b),

					.top_sin(top_sin),
					.top_din(top_din),

					.top_auto_start(top_auto_start),
					.top_link_start(top_link_start),
					.top_link_disable(top_link_disable),

					.top_tx_write(top_tx_write_w),
					.top_tx_data(top_tx_data_w),

					.top_tx_tick(top_tx_tick),
					.top_tx_time(top_tx_time),

					.credit_error_rx(credit_error_rx_w),
					.top_send_fct_now(top_send_fct_now_w),

					.datarx_flag(datarx_flag_w),
					.buffer_write(buffer_write_w),

					.time_out(time_out),
					.tick_out(tick_out),

					.top_dout(top_dout),
					.top_sout(top_sout),

					.top_tx_ready(top_tx_ready_w),
					.top_tx_ready_tick(top_tx_ready_tick),

					.top_fsm(top_fsm)
				);


			fifo_rx	 rx_data(
					 .clock(ppll_100_MHZ), 
					 .reset(tx_reset_n), 
					 .wr_en(buffer_write_w), 
					 .rd_en(read_rx_fifo_en),
					 .data_in(datarx_flag_w),
					 .f_full(f_full_rx), 
					 .f_empty(f_empty_rx), 
					 .open_slot_fct(top_send_fct_now_w),
					 .overflow_credit_error(credit_error_rx_w),					
					 .data_out(datarx_flag_axi),
					 .counter(counter_fifo_rx)
					 );
								
		
			fifo_tx tx_data(
					 .clock(ppll_100_MHZ), 
					 .reset(tx_reset_n), 
					 .wr_en(top_tx_write), 
					 .rd_en(top_tx_ready_w),
					 .data_in(top_tx_data),
					 .f_full(f_full), 
					 .f_empty(f_empty), 					
					 .write_tx(top_tx_write_w),
					 .data_out(top_tx_data_w),
					 .counter(counter_fifo_tx)
					 );						
							 
endmodule
