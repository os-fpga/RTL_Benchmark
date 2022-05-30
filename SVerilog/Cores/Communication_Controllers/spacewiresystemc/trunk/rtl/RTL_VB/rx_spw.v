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

module RX_SPW (
			input  rx_din,
			input  rx_sin,

			input  rx_resetn,

			output rx_error,

			output reg rx_got_bit,
			output rx_got_null,
			output rx_got_nchar,
			output rx_got_time_code,
			output rx_got_fct,
			output rx_got_fct_fsm,

			output [8:0] rx_data_flag,
			output rx_buffer_write,

			output [7:0] rx_time_out,
			output rx_tick_out
		 );


	wire [5:0] counter_neg/* synthesis syn_replicate = 0 */;

	wire posedge_clk;
	wire negedge_clk;

	wire bit_c_0;//N
	wire bit_c_1;//P
	wire bit_c_2;//N
	wire bit_c_3;//P

	wire bit_d_0;//N
	wire bit_d_1;//P
	wire bit_d_2;//N
	wire bit_d_3;//P
	wire bit_d_4;//N
	wire bit_d_5;//P
	wire bit_d_6;//N
	wire bit_d_7;//P
	wire bit_d_8;//N
	wire bit_d_9;//P

	wire [1:0] state_data_process;

	wire is_control/* synthesis dont_replicate */;
	wire last_is_control;
	wire last_is_data;
	wire last_is_timec;

	wire [2:0] control_p_r/* synthesis dont_replicate */;
	wire [7:0] timecode/* synthesis dont_replicate */;

	wire [2:0] control_l_r/* synthesis dont_replicate */;

	wire [8:0] dta_timec_p/* synthesis dont_replicate */;

	reg ready_control;
	reg ready_data;

	wire ready_control_p_r;
	wire ready_data_p_r;

	wire parity_rec_c;
	wire parity_rec_d;

	wire parity_rec_c_gen;
	wire parity_rec_d_gen;

	wire rx_error_c;
	wire rx_error_d;

	wire posedge_p/* synthesis syn_replicate = 0 */;

	reg f_time;
	
	//CLOCK RECOVERY
	assign posedge_clk 	= posedge_p;
	assign negedge_clk 	= (f_time)?!posedge_p:1'b0;

	assign rx_time_out 	= timecode;

	buf (posedge_p,rx_din ^ rx_sin);


always@(posedge posedge_clk or negedge rx_resetn)
begin

	if(!rx_resetn)
	begin
		f_time 	  	<= 1'b0;
	end
	else
	begin
		f_time 	  	<= 1'b1;
	end
end

always@(*)
begin

	rx_got_bit = 1'b0;

	if(rx_din | rx_sin)
	begin
		rx_got_bit = 1'b1;
	end
end


always@(*)
begin
	ready_control = 1'b0;
	ready_data    = 1'b0;

	if(is_control && counter_neg == 6'd4 && !posedge_p)
	begin
		ready_control = 1'b1;
		ready_data    = 1'b0;
	end
	else if(!is_control && counter_neg == 6'd32 && !posedge_p)
	begin
		ready_control = 1'b0;
		ready_data    = 1'b1;
	end
end


rx_buffer_fsm buffer_fsm(
		.posedge_clk(posedge_clk),
		.rx_resetn(rx_resetn),
			
		.last_is_data(last_is_data),
		.last_is_timec(last_is_timec),
		.last_is_control(last_is_control),

		.rx_got_null(rx_got_null),
		.rx_got_nchar(rx_got_nchar),
		.rx_got_time_code(rx_got_time_code)
		);

rx_data_buffer_data_w  buffer_data_flag(
			.negedge_clk(negedge_clk),
			.rx_resetn(rx_resetn),

			.state_data_process(state_data_process),
			.control(control_p_r),
			.last_is_timec(last_is_timec),
			.last_is_data(last_is_data),
			.last_is_control(last_is_control),

			.rx_buffer_write(rx_buffer_write),
			.rx_tick_out(rx_tick_out)
			
			);


rx_control_data_rdy control_data_rdy(
				.posedge_clk(posedge_clk),
				.rx_resetn(rx_resetn),

				.rx_error_c(rx_error_c),
				.rx_error_d(rx_error_d),

				.control(control_p_r),
				.control_l_r(control_l_r[2:0]),

				.is_control(is_control),
				.counter_neg(counter_neg),
				
				.last_is_control(last_is_control),

				.rx_error(rx_error),
				.ready_control_p_r(ready_control_p_r),
				.ready_data_p_r(ready_data_p_r),
				.rx_got_fct_fsm(rx_got_fct_fsm)
			  );


rx_data_control_p data_control(
				.posedge_clk(posedge_clk),
				.rx_resetn(rx_resetn),

				.bit_c_3(bit_c_3),
				.bit_c_2(bit_c_2),
				.bit_c_1(bit_c_1),
				.bit_c_0(bit_c_0),

				.bit_d_9(bit_d_9),
				.bit_d_8(bit_d_8),
				.bit_d_0(bit_d_0),
				.bit_d_1(bit_d_1),
				.bit_d_2(bit_d_2),
				.bit_d_3(bit_d_3),
				.bit_d_4(bit_d_4),
				.bit_d_5(bit_d_5),
				.bit_d_6(bit_d_6),
				.bit_d_7(bit_d_7),
	
				.last_is_control(last_is_control),
				.last_is_data(last_is_data),

				.is_control(is_control),
				.counter_neg(counter_neg),

				.dta_timec_p(dta_timec_p),
				.parity_rec_d(parity_rec_d),
				.parity_rec_d_gen(parity_rec_d_gen),

				.control_p_r(control_p_r),
				.control_l_r(control_l_r),
				.parity_rec_c(parity_rec_c),
				.parity_rec_c_gen(parity_rec_c_gen)
			);


bit_capture_data capture_d(
			.negedge_clk(negedge_clk),
			.posedge_clk(posedge_clk),
			.rx_resetn(rx_resetn),
			
			.rx_din(rx_din),
			
			.bit_d_0(bit_d_0),//N
			.bit_d_1(bit_d_1),//P
			.bit_d_2(bit_d_2),//N
			.bit_d_3(bit_d_3),//P
			.bit_d_4(bit_d_4),//N
			.bit_d_5(bit_d_5),//P
			.bit_d_6(bit_d_6),//N
			.bit_d_7(bit_d_7),//P
			.bit_d_8(bit_d_8),//N
			.bit_d_9(bit_d_9)//P
		  );

bit_capture_control capture_c(
			.negedge_clk(negedge_clk),
			.posedge_clk(posedge_clk),
			.rx_resetn(rx_resetn),
			
			.rx_din(rx_din),
			
			.bit_c_0(bit_c_0),
			.bit_c_1(bit_c_1),
			.bit_c_2(bit_c_2),
			.bit_c_3(bit_c_3)
		  );

counter_neg cnt_neg(
			.negedge_clk(negedge_clk),
			.rx_resetn(rx_resetn),
			.rx_din(rx_din),	
			.is_control(is_control),
			.counter_neg(counter_neg)
		  );

rx_data_receive rx_dtarcv (
				.posedge_clk(posedge_clk),
				.rx_resetn(rx_resetn),
			
				.ready_control_p_r(ready_control_p_r),
				.ready_data_p_r(ready_data_p_r),
				.ready_control(ready_control),
				.ready_data(ready_data),

				.parity_rec_c(parity_rec_c),
				.parity_rec_d(parity_rec_d),

				.parity_rec_c_gen(parity_rec_c_gen),
				.parity_rec_d_gen(parity_rec_d_gen),

				.control_p_r(control_p_r),
				.dta_timec_p(dta_timec_p),

				.control_l_r(control_l_r),
				.state_data_process(state_data_process),

				.last_is_control(last_is_control),
				.last_is_data(last_is_data),
				.last_is_timec(last_is_timec),

				.rx_error_c(rx_error_c),
				.rx_error_d(rx_error_d),
				.rx_got_fct(rx_got_fct),

				.rx_data_flag(rx_data_flag),

				.timecode(timecode)
		      );

endmodule
