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

module clock_reduce(
			input clk,
			input reset_n,
			input [2:0] clock_sel,

			output  clk_reduced,
			output  clk_100_reduced
			
		   );


reg [10:0] counter;
reg [10:0] counter_100;

assign clk_reduced     = clk_reduced_p | clk_reduced_n;
assign clk_100_reduced = clk_100_reduced_p | clk_100_reduced_n;


reg clk_reduced_i;
reg clk_100_reduced_i;


reg clk_reduced_p;
reg clk_100_reduced_p;

reg clk_reduced_n;
reg clk_100_reduced_n;

always@(*)
begin

	clk_reduced_p = 1'b0;
	
	if(clk_reduced_i)
	begin
		clk_reduced_p = 1'b1;
	end
	
end


always@(*)
begin

	clk_reduced_n = 1'b1;
	
	if(!clk_reduced_i)
	begin
		clk_reduced_n = 1'b0;
	end
	
end

always@(*)
begin

	clk_100_reduced_p = 1'b0;
	
	if(clk_100_reduced_i)
	begin
		clk_100_reduced_p = 1'b1;
	end
	
end


always@(*)
begin

	clk_100_reduced_n = 1'b1;
	
	if(!clk_100_reduced_i)
	begin
		clk_100_reduced_n = 1'b0;
	end
	
end

always@(posedge clk)
begin

	if(!reset_n)
	begin

		counter <= 11'd0;
		counter_100 <= 11'd0;
		clk_reduced_i <= 1'b0;
		clk_100_reduced_i <= 1'b0;
	end
	else
	begin
	
	
		case(clock_sel)
		3'd0://2mhz - 500 ns
		begin
			if(counter >=11'd0 && counter <=11'd99 )
			begin
				clk_reduced_i <= 1'b1;
				counter <= counter + 11'd1;
			end
			else if(counter >=11'd100 && counter <=11'd199 )
			begin
				clk_reduced_i <= 1'b0;
				counter <= counter + 11'd1;
			end
			else
			begin
				clk_reduced_i <= 1'b1;
				counter <= 11'd0;
			end
		end
		3'd1://5mhz
		begin
				
			if(counter >=11'd0 && counter <=11'd39 )
			begin
				clk_reduced_i <= 1'b1;
				counter <= counter + 11'd1;
			end
			else if(counter >=11'd40 && counter <=11'd79 )
			begin
				clk_reduced_i <= 1'b0;
				counter <= counter + 11'd1;
			end
			else
			begin
				clk_reduced_i <= 1'b1;
				counter <= 11'd0;
			end
		end
		3'd2://10mhz
		begin
			if(counter >=11'd0 && counter <=11'd19 )
			begin
				clk_reduced_i <= 1'b1;
				counter <= counter + 11'd1;
			end
			else if(counter >=11'd20 && counter <=11'd39 )
			begin
				clk_reduced_i <= 1'b0;
				counter <= counter + 11'd1;
			end
			else
			begin
				clk_reduced_i <= 1'b1;
				counter <= 11'd0;
			end
		end
		3'd3://50mhz
		begin
			if(counter >=11'd0 && counter <=11'd3 )
			begin
				clk_reduced_i <= 1'b1;
				counter <= counter + 11'd1;
			end
			else if(counter >=11'd4 && counter <=11'd7)
			begin
				clk_reduced_i <= 1'b0;
				counter <= counter + 11'd1;
			end
			else
			begin
				clk_reduced_i <= 1'b1;
				counter <= 11'd0;
			end
		end
		3'd4://100mhz
		begin
			if(counter >=11'd0 && counter <=11'd1 )
			begin
				clk_reduced_i <= 1'b1;
				counter <= counter + 11'd1;
			end
			else if(counter >=11'd2 && counter <=11'd4)
			begin
				clk_reduced_i <= 1'b0;
				counter <= counter + 11'd1;
			end
			else
			begin
				clk_reduced_i <= 1'b1;
				counter <= 11'd0;
			end
		end
		3'd5://150mhz
		begin
			if(counter >=11'd0 && counter <=11'd1 )
			begin
				clk_reduced_i <= 1'b1;
				counter <= counter + 11'd1;
			end
			else if(counter >=11'd2 && counter <=11'd3)
			begin
				clk_reduced_i <= 1'b0;
				counter <= counter + 11'd1;
			end
			else
			begin
				clk_reduced_i <= 1'b1;
				counter <= 11'd0;
			end
		end
		3'd6://200mhz
		begin
			if(counter >=11'd0 && counter <=11'd1 )
			begin
				clk_reduced_i <= 1'b1;
				counter <= counter + 11'd1;
			end
			else if(counter == 11'd2)
			begin
				clk_reduced_i <= 1'b0;
				counter <= counter + 11'd1;
			end
			else
			begin
				clk_reduced_i <= 1'b1;
				counter <= 11'd0;
			end
		end
		3'd7://300mhz
		begin
			if(counter ==11'd0 )
			begin
				clk_reduced_i <= 1'b1;
				counter <= counter + 11'd1;
			end
			else if(counter ==11'd1)
			begin
				clk_reduced_i <= 1'b0;
				counter <= counter + 11'd1;
			end
			else
			begin
				clk_reduced_i <= 1'b1;
				counter <= 11'd0;
			end
		end
		endcase
		
		if(counter_100 >=11'd0 && counter_100 <=11'd1 )
		begin
			clk_100_reduced_i <= 1'b1;
			counter_100 <= counter_100 + 11'd1;
		end
		else if(counter_100 >=11'd2 && counter_100 <=11'd4)
		begin
			clk_100_reduced_i <= 1'b0;
			counter_100 <= counter_100 + 11'd1;
		end
		else
		begin
			clk_100_reduced_i <= 1'b1;
			counter_100 <= 11'd0;
		end
		
	end

end

endmodule
