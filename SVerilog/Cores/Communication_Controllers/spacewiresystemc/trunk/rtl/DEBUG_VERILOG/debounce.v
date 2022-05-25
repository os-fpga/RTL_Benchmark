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
module debounce_db(
		    input CLK,
		    input PB,  

		    output reg PB_state, 
		    output reg PB_down
		  );

		  reg aux_pb;
		  reg [15:0] counter;
		  //assign PB_state = (counter >= 400)?PB_state:1'b1;
always@(*)
begin

	PB_state = 1'b1;
	
	if(CLK)
	begin
		if(aux_pb)
			PB_state = 1'b0;
	end
	else if(!CLK)
	begin
		if(aux_pb)
			PB_state = 1'b0;
	end
end

always@(posedge CLK)
begin

	if(PB)
	begin
		aux_pb  <= 1'b0;
		counter <= 16'd0;
		PB_down <= 1'b0;
	end
	else
	begin
	
		if(counter >= 400)
		begin
			aux_pb  <= 1'b1;
			PB_down <= 1'b1;
		end
		else 
			counter <= counter + 16'd1;
	
	end


end
		  

endmodule
