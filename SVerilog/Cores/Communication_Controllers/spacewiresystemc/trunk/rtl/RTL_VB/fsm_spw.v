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

module FSM_SPW (
		input  pclk,
		input  resetn,

		//fsm status control
		input  auto_start,
		input  link_start,
		input  link_disable,

		//rx status input control
		input  rx_error,
		input  rx_credit_error,
		input  rx_got_bit,
		input  rx_got_null,
		input  rx_got_nchar,
		input  rx_got_time_code,
		input  rx_got_fct,
		output reg rx_resetn,

		//tx status control
		output reg enable_tx,
		output reg send_null_tx,
		output reg send_fct_tx,

		output [5:0] fsm_state

	      );

localparam [5:0]  error_reset   = 6'b00_0000,
		  error_wait    = 6'b00_0001,
		  ready         = 6'b00_0010,
		  started       = 6'b00_0100,
		  connecting    = 6'b00_1000,
		  run           = 6'b01_0000;

	reg [5:0] state_fsm;
	reg [5:0] next_state_fsm;

	reg [11:0] after128us;
	reg [11:0] after64us;
	reg [11:0] after850ns;

	reg got_bit_internal;

	reg get_rx_got_fct_a, get_rx_got_fct_b;
	reg get_rx_error_a, get_rx_error_b;
	reg get_rx_got_null_a, get_rx_got_null_b;

	reg get_rx_got_nchar_a, get_rx_got_nchar_b;
	reg get_rx_got_time_code_a, get_rx_got_time_code_b;
	reg get_rx_credit_error_a, get_rx_credit_error_b;

//
assign fsm_state    = state_fsm;

always@(*)
begin

	next_state_fsm = state_fsm;

	case(state_fsm)
	error_reset:
	begin

		if(after64us == 12'd639)
		begin
			next_state_fsm = error_wait;
		end
		else
		begin
			next_state_fsm = error_reset;
		end

	end
	error_wait:
	begin

		if(after128us == 12'd1279)
		begin
			next_state_fsm = ready;
		end
		else if(get_rx_error_a | get_rx_got_fct_a | get_rx_got_nchar_a | rx_got_time_code)
		begin
			next_state_fsm = error_reset;
		end

	end
	ready:
	begin

		if(get_rx_error_a | get_rx_got_fct_a | get_rx_got_nchar_a | get_rx_got_time_code_a)
		begin
			next_state_fsm = error_reset;
		end
		else if(((!link_disable) & (link_start |(auto_start & get_rx_got_null_a)))==1'b1)
		begin
			next_state_fsm = started;
		end

	end
	started:
	begin

		if(get_rx_error_a | get_rx_got_fct_a | get_rx_got_nchar_a | get_rx_got_time_code_a | after128us == 12'd1279)
		begin
			next_state_fsm = error_reset;
		end
		else if((get_rx_got_null_a & rx_got_bit)== 1'b1)
		begin
			next_state_fsm = connecting;
		end

	end
	connecting:
	begin

		if(get_rx_error_a | get_rx_got_nchar_a | get_rx_got_time_code_a | after128us == 12'd1279)
		begin
			next_state_fsm = error_reset;
		end
		else if(get_rx_got_fct_a)
		begin
			next_state_fsm = run;
		end

	end
	run:
	begin

		if(get_rx_error_a | get_rx_credit_error_a | link_disable  | after850ns == 12'd85)
		begin
			next_state_fsm = error_reset;
		end
		else
		begin
			next_state_fsm = run;
		end

	end
	endcase
end

always@(posedge pclk or negedge resetn)
begin
	if(!resetn)
	begin
		state_fsm <= error_reset;

		rx_resetn <= 1'b0;

		enable_tx    <= 1'b0;
		send_null_tx <= 1'b0;
		send_fct_tx  <= 1'b0;

		get_rx_got_fct_a  <= 1'b0; 
		get_rx_got_fct_b  <= 1'b0;
		get_rx_error_a    <= 1'b0; 
		get_rx_error_b    <= 1'b0;
		get_rx_got_null_a <= 1'b0;
		get_rx_got_null_b <= 1'b0;


		get_rx_got_nchar_a     <= 1'b0; 
		get_rx_got_nchar_b     <= 1'b0;
		get_rx_got_time_code_a <= 1'b0;
		get_rx_got_time_code_b <= 1'b0;
		get_rx_credit_error_a  <= 1'b0; 
		get_rx_credit_error_b  <= 1'b0;

	end
	else
	begin

		get_rx_got_fct_b <= rx_got_fct;
		get_rx_got_fct_a <= get_rx_got_fct_b;

		get_rx_error_b <= rx_error;
		get_rx_error_a <= get_rx_error_b;

		get_rx_got_null_b <= rx_got_null;
		get_rx_got_null_a <= get_rx_got_null_b;

		get_rx_got_nchar_b <= rx_got_nchar;
		get_rx_got_nchar_a <= get_rx_got_nchar_b;

		get_rx_got_time_code_b <= rx_got_time_code;
		get_rx_got_time_code_a <= get_rx_got_time_code_b;

		get_rx_credit_error_b <= rx_credit_error;
		get_rx_credit_error_a <= get_rx_credit_error_b;

		state_fsm <= next_state_fsm;

		case(state_fsm)
		error_reset:
		begin
			enable_tx<= 1'b0;
			send_null_tx<= 1'b0;
			send_fct_tx<= 1'b0;
			
			if(after64us == 12'd639)
				rx_resetn <= 1'b1;
			else
				rx_resetn <= 1'b0;
		end
		error_wait:
		begin
			rx_resetn <= 1'b1;
			enable_tx<= 1'b0;
			send_null_tx<= 1'b0;
			send_fct_tx<= 1'b0;
		end
		ready:
		begin
			rx_resetn <= 1'b1;
			enable_tx<= 1'b1;
			send_null_tx<= 1'b0;
			send_fct_tx<= 1'b0;
		end
		started:
		begin
			rx_resetn <= 1'b1;
			enable_tx<= 1'b1;
			send_null_tx<= 1'b1;
			send_fct_tx<= 1'b0;
		end
		connecting:
		begin
			rx_resetn <= 1'b1;
			enable_tx<= 1'b1;
			send_null_tx<= 1'b1;
			send_fct_tx<= 1'b1;
		end
		run:
		begin
			rx_resetn <= 1'b1;
			enable_tx<= 1'b1;
			send_null_tx<= 1'b1;
			send_fct_tx<= 1'b1;
		end
		endcase
		
	end
end

always@(posedge pclk)
begin

	if(!resetn || state_fsm == error_reset)
	begin
		after128us <= 12'd0;
	end
	else
	begin

		if(next_state_fsm == connecting && state_fsm == started)
		begin
			after128us <= 12'd0;
		end
		else if(state_fsm == error_wait || state_fsm == started || state_fsm == connecting)
		begin
			if(after128us < 12'd1279)
				after128us <= after128us + 12'd1;
			else
				after128us <= 12'd0;
		end
		else
		begin
				after128us <= 12'd0;
		end
	end

end

always@(posedge pclk)
begin

	if(!resetn)
	begin
		after64us <= 12'd0;
	end
	else
	begin
		if(state_fsm == error_reset && (auto_start | link_start))
		begin
			if(after64us < 12'd639)
				after64us <= after64us + 12'd1;
			else
				after64us <= 12'd0;
		end
		else
		begin
			after64us <= 12'd0;
		end
	end

end

always@(posedge pclk)
begin
	if(!resetn)
	begin
		got_bit_internal <= 1'b0;
	end
	else
	begin
		if(rx_got_bit)
			got_bit_internal <= 1'b1;
		else 
			got_bit_internal <= 1'b0;
	end
end

always@(posedge pclk)
begin

	if(!resetn | got_bit_internal)
	begin
		after850ns <= 12'd0;
	end
	else
	begin
		if(state_fsm != run)
		begin
			after850ns <= 12'd0;
		end
		else
		begin
			if(after850ns < 12'd85 && state_fsm == run)
				after850ns <= after850ns + 12'd1;
			else
				after850ns <= after850ns;

		end
	end

end

endmodule
