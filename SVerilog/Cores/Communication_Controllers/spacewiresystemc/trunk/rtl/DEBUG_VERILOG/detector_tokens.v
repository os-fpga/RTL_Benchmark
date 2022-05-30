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
module detector_tokens(
								input  rx_din,
								input  rx_sin,
								input  rx_resetn,
								//input clock_sys,
								//output reg rx_buffer_write,
								output reg [13:0] info
							 );
			
	wire rx_error;
	reg rx_got_bit;
	reg rx_got_null;
	reg rx_got_nchar;
	reg rx_got_time_code;
	reg rx_got_fct;
			
	wire  [5:0] counter_neg;

	reg  [1:0] state_data_process;
	reg  [1:0] next_state_data_process;
	reg control_bit_found;

	wire posedge_clk;
	wire negedge_clk;

	wire bit_c_0;//N
	wire bit_c_1;//P
	wire bit_c_2;//N
	wire bit_c_3;//P
	wire bit_c_ex;//P

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

	wire is_control;
	reg is_data;

	reg last_is_control;
	reg last_is_data;
	//reg last_is_timec;

	reg last_was_control;
	reg last_was_data;
	reg last_was_timec;

	reg [3:0] control;
	reg [3:0] control_r;
	reg [3:0] control_p_r;
	reg [9:0] data;
	reg [9:0] timecode;

	reg [9:0] dta_timec;
	reg [9:0] dta_timec_p;

	reg [3:0] control_l_r;
	reg [9:0] data_l_r;

	reg parity_rec_c;
	reg parity_rec_d;

	reg rx_error_c;
	reg rx_error_d;

	reg ready_control;
	reg ready_data;

	reg parity_rec_c_gen;
	reg parity_rec_d_gen;

	reg ready_control_p;
	reg ready_data_p;

	reg ready_control_p_r;
	reg ready_data_p_r;

	wire posedge_p;

	reg f_time;
	
	//CLOCK RECOVERY
	assign posedge_clk 	= posedge_p;
	assign negedge_clk 	= (f_time)?!posedge_p:1'b0;

	assign rx_error		= rx_error_c | rx_error_d;

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

	if(is_control && counter_neg[5:0] == 6'd4 && !posedge_p)
	begin
		ready_control = 1'b1;
		ready_data    = 1'b0;
	end
	else if(is_control && counter_neg[5:0] == 6'd32 && !posedge_p)
	begin
		ready_control = 1'b0;
		ready_data    = 1'b1;
	end
end

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

always@(*)
begin

	next_state_data_process = state_data_process;

	case(state_data_process)
	2'd0:
	begin
		if(ready_control_p_r || ready_data_p_r)
		begin
			next_state_data_process = 2'd1;
		end
		else 
		begin
			next_state_data_process = 2'd0;
		end
	end
	2'd1:
	begin
		next_state_data_process = 2'd0;
	end
	default:
	begin
		next_state_data_process = 2'd0;
	end
	endcase
end

always@(posedge negedge_clk or negedge rx_resetn)
begin
	if(!rx_resetn)
	begin
		rx_got_null 	  <= 1'b0;
		rx_got_nchar 	  <= 1'b0;
		rx_got_time_code  <= 1'b0;			
		rx_got_fct 	  <= 1'b0;
	end
	else
	begin
		if(control_l_r[2:0] != 3'd7 && control[2:0] == 3'd4 && last_is_control)
		begin
			rx_got_fct 	  <= 1'b1;
			rx_got_null 	  <= 1'b0;
			rx_got_nchar 	  <= 1'b0;
			rx_got_time_code  <= 1'b0;			
		end
		else if(control[2:0] != 3'd7 && last_is_data)
		begin
			rx_got_nchar 	  <= 1'b1;
			rx_got_null 	  <= 1'b0;
			rx_got_time_code  <= 1'b0;			
			rx_got_fct 	  <= 1'b0;
		end
		else if(control[2:0] == 3'd7 && last_is_data)
		begin
			rx_got_time_code  <= 1'b1;
			rx_got_null 	  <= 1'b0;
			rx_got_nchar 	  <= 1'b0;			
			rx_got_fct 	  <= 1'b0;
		end
		else if(control_l_r[2:0] == 3'd7 && control[2:0] == 3'd4 && last_is_control)
		begin
			rx_got_null 	  <= 1'b1;
			rx_got_nchar 	  <= 1'b0;
			rx_got_time_code  <= 1'b0;			
			rx_got_fct 	  <= 1'b0;
		end
		else
		begin
			rx_got_null 	  <= rx_got_null;
			rx_got_nchar 	  <= rx_got_nchar;
			rx_got_time_code  <= rx_got_time_code;			
			rx_got_fct 	  <= rx_got_fct;
		end
	end
end


always@(posedge negedge_clk or negedge rx_resetn)
begin
	if(!rx_resetn)
	begin
		ready_control_p_r <= 1'b0;
		ready_data_p_r  <=  1'b0;
	end
	else
	begin

		if(counter_neg[5:0] == 6'd4 && is_control)
		begin
			ready_control_p_r <= 1'b1;
		end
		else if(counter_neg[5:0] == 6'd32)
		begin
			ready_data_p_r <= 1'b1;
		end
		else
		begin
			ready_control_p_r <= 1'b0;
			ready_data_p_r <= 1'b0;
		end
	end
end

always@(posedge posedge_clk or negedge rx_resetn )
begin
	if(!rx_resetn)
	begin
		control_r	   	<= 4'd0;
		parity_rec_c	  	<= 1'b0;
		parity_rec_c_gen 	<= 1'b0;
	end
	else
	begin
		control_r	  <= {bit_c_3,bit_c_2,bit_c_1,bit_c_0};
		parity_rec_c	  <= bit_c_3;

		if(last_is_control)
		begin
			parity_rec_c_gen <= !(bit_c_2^control[0]^control[1]);
		end
		else if(last_is_data)
		begin
			parity_rec_c_gen <= !(bit_c_2^data[7]^data[6]^data[5]^data[4]^data[3]^data[2]^data[1]^data[0]);
		end
	end
end

always@(posedge posedge_clk or negedge rx_resetn )
begin
	if(!rx_resetn)
	begin
		dta_timec	   	<= 10'd0;
		parity_rec_d 	  	<= 1'b0;
		parity_rec_d_gen	<= 1'b0;
	end
	else
	begin
		dta_timec	  <= {bit_d_9,bit_d_8,bit_d_0,bit_d_1,bit_d_2,bit_d_3,bit_d_4,bit_d_5,bit_d_6,bit_d_7};
		parity_rec_d 	  <= bit_d_9;

		if(last_is_control)
		begin
			parity_rec_d_gen <= !(bit_d_8^control[0]^control[1]);
		end
		else if(last_is_data)
		begin
			parity_rec_d_gen <= !(bit_d_8^data[7]^data[6]^data[5]^data[4]^data[3]^data[2]^data[1]^data[0]);
		end
	end
end

always@(posedge posedge_clk or negedge rx_resetn )
begin

	if(!rx_resetn)
	begin
		control_l_r      <= 4'd0;
		control	   	 <= 4'd0;
		data 	         <=  10'd0;

		last_is_control  <=  1'b0;
		last_is_data 	 <=  1'b0;
		//last_is_timec 	 <=  1'b0;

		state_data_process <= 2'd0;
		info <= 14'd0;

		rx_error_c <= 1'b0;
		rx_error_d <= 1'b0;
	end
	else
	begin

		state_data_process <= next_state_data_process;

		case(state_data_process)
		2'd0:
		begin

			if(ready_control_p_r)
			begin
				control 	 <= control_p_r;
				control_l_r 	 <= control;

				last_is_control 	 <= 1'b1;
				last_is_data    	 <= 1'b0;
				//last_is_timec   	 <= 1'b0;

			end
			else if(ready_data_p_r)
			begin
				if(control[2:0] != 3'd7)
				begin
					data        	<= {dta_timec_p[9],dta_timec_p[8],dta_timec_p[7],dta_timec_p[6],dta_timec_p[5],dta_timec_p[4],dta_timec_p[3],dta_timec_p[2],dta_timec_p[1],dta_timec_p[0]};
								
					last_is_control  	<=1'b0;
					last_is_data     	<=1'b1;
					//last_is_timec    	<=1'b0;
				end
				else if(control[2:0] == 3'd7)
				begin
					
					last_is_control  	<= 1'b0;
					last_is_data     	<= 1'b0;
					//last_is_timec    	<= 1'b1;
				end
			end
			else
			begin
			
			end
			
		end
		2'd1:
		begin
				if(ready_control_p_r)
				begin

					if(parity_rec_c_gen != parity_rec_c)
					begin
						rx_error_c <= 1'b1;
					end
					else
						rx_error_c <= rx_error_c;

				end
				else if(ready_data_p_r)
				begin

					if(parity_rec_d_gen != parity_rec_d)
					begin
						rx_error_d <= 1'b1;
					end
					else
						rx_error_d <= rx_error_d;
			

				end
				info <= {control_l_r,control,rx_error,rx_got_bit,rx_got_null,rx_got_nchar,rx_got_time_code,rx_got_fct};
		end
		default:
		begin
					
		end
		endcase	
	end
end		 
							 
endmodule
