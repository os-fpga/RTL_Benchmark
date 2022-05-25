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
module fifo_tx
#(
	parameter integer DWIDTH = 9,
	parameter integer AWIDTH = 6
)

(
	input clock, reset, wr_en, rd_en,
	input [DWIDTH-1:0] data_in/* synthesis syn_noprune */,
	output reg f_full,write_tx,f_empty,
	output [DWIDTH-1:0] data_out/* synthesis syn_noprune */,
	output reg [AWIDTH-1:0] counter/* synthesis syn_noprune */
);
	reg [AWIDTH-1:0] wr_ptr/* synthesis syn_noprune */;
	reg [AWIDTH-1:0] rd_ptr/* synthesis syn_noprune */;

	reg  [1:0] state_data_write;
	reg  [1:0] next_state_data_write;

	reg  [1:0] state_data_read;
	reg  [1:0] next_state_data_read;

	//reg [AWIDTH-1:0] counter_writer/* synthesis syn_noprune */;
	//reg [AWIDTH-1:0] counter_reader/* synthesis syn_noprune */;


/****************************************/

always@(*)
begin
	next_state_data_write = state_data_write;

	case(state_data_write)
	2'd0:
	begin
		if(wr_en && !f_full)
		begin
			next_state_data_write = 2'd1;
		end
		else 
		begin
			next_state_data_write = 2'd0;
		end
	end
	2'd1:
	begin
		if(wr_en)
		begin
			next_state_data_write = 2'd1;
		end
		else 
		begin
			next_state_data_write = 2'd2;
		end
	end
	2'd2:
	begin
		next_state_data_write = 2'd0;
	end
	default:
	begin
		next_state_data_write = 2'd0;
	end
	endcase
end

/****************************************/

always@(*)
begin
	next_state_data_read = state_data_read;

	case(state_data_read)
	2'd0:
	begin
		if(counter > 6'd0)
		begin
			next_state_data_read = 2'd1;
		end
		else 
		begin
			next_state_data_read = 2'd0;
		end
	end
	2'd1:
	begin
		if(rd_en && !f_empty)
		begin
			next_state_data_read = 2'd2;
		end
		else 
		begin
			next_state_data_read = 2'd1;
		end
	end
	2'd2:
	begin
		if(rd_en)
		begin
			next_state_data_read = 2'd2;
		end
		else 
		begin
			next_state_data_read = 2'd3;
		end
	end
	2'd3:
	begin
		next_state_data_read = 2'd0;
	end
	default:
	begin
		next_state_data_read = 2'd0;
	end
	endcase
end

//Write pointer
	always@(posedge clock or negedge reset)
	begin
		if (!reset)
		begin
			wr_ptr      <= {(AWIDTH){1'b0}};
			state_data_write <= 2'd0;
		end
		else
		begin

			state_data_write <= next_state_data_write;

			case(state_data_write)
			2'd0:
			begin
				wr_ptr <= wr_ptr;
			end
			2'd1:
			begin
				wr_ptr <= wr_ptr;
			end
			2'd2:
			begin
				wr_ptr <= wr_ptr + 6'd1;
			end
			default:
			begin
				wr_ptr <= wr_ptr;
			end
			endcase
		end
	end

//FULL - EMPTY COUNTER
always@(posedge clock or negedge reset)
begin
	if (!reset)
	begin
		f_full  <= 1'b0;
		f_empty <= 1'b0;
		counter <= {(AWIDTH){1'b0}};
	end
	else
	begin

		if(state_data_write == 2'd2)
		begin
			counter <= counter + 6'd1;
		end
		else
		begin
			if(counter > 6'd0 && state_data_read == 2'd3)
				counter <= counter - 6'd1;
			else
				counter <= counter;	
		end

		if(counter == 6'd63)
		begin
			f_full  <= 1'b1;
		end
		else
		begin
			f_full  <= 1'b0;
		end

		if(counter == 6'd0)
		begin
			f_empty <= 1'b1;
		end
		else
		begin
			f_empty <= 1'b0;
		end
	end
end


//Read pointer
always@(posedge clock or negedge reset)
begin
	if (!reset)
	begin
		rd_ptr     <= {(AWIDTH){1'b0}};
		write_tx   <= 1'b0;
		state_data_read <= 2'd0;
	end
	else
	begin
		state_data_read <= next_state_data_read;
		case(state_data_read)
		2'd0:
		begin
			write_tx<= 1'b0;
		end
		2'd1:
		begin
			if(rd_en && !f_empty)
			begin
				rd_ptr     <= rd_ptr + 6'd1;
			end
			else
			begin
				rd_ptr     <= rd_ptr;				
			end

			write_tx<= 1'b1;
		end
		2'd2:
		begin
			write_tx<= 1'b0;
		end
		2'd3:
		begin
			write_tx<= 1'b0;
		end
		default:
		begin
			rd_ptr     <= rd_ptr;
		end
		endcase
	end
end

mem_data mem_dta_fifo_tx(

		.clock(clock), 
		.reset(reset), 

		.data_in(data_in),
		.wr_ptr(wr_ptr),
		.rd_ptr(rd_ptr),
		.data_out(data_out)
);

endmodule
