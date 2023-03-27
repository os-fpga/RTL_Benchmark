//-----------------------------------------------------------------------------
//	RapidSilicon
//	Author:	Michael Wood
//	Date:	3/9/2022
//-----------------------------------------------------------------------------
module arbiter(
input clk,
input resetn,
input wr_req,
input rd_req,
input done,
output reg wr_granted,
output reg rd_granted);
  
	always@(posedge clk, negedge resetn)
	begin
		if(!resetn) begin
			wr_granted <= 1'b0;
			rd_granted <= 1'b0;
		end
		else begin
			if(~wr_granted && ~rd_granted) // In IDLE
			begin
				if(wr_req) // Transition to write
				begin
					wr_granted <= 1'b1;
					rd_granted <= 1'b0;
				end
				else if(!wr_req && rd_req) // Transition to Read
				begin
					wr_granted <= 1'b0;
					rd_granted <= 1'b1;
				end
				else	// Stay Idle
				begin
				  wr_granted <= 1'b0;
				  rd_granted <= 1'b0;
				end
			end
			else if(wr_granted && ~rd_granted) // In write
			begin
				if(~wr_req && ~rd_req && done)	// Transtion to Idle
				begin
				  wr_granted <= 1'b0;
				  rd_granted <= 1'b0;
				end
				else if(rd_req && done) // Transition to Read
				begin
				  wr_granted <= 1'b0;
				  rd_granted <= 1'b1;
				end
				else // Stay in Write
				begin
				  wr_granted <= 1'b1;
				  rd_granted <= 1'b0;
				end
			end
			else if(~wr_granted && rd_granted) // In read
			begin
				if(~wr_req && ~rd_req && done) // Transition to Idle
			  	begin
			  		wr_granted <= 1'b0;
			  		rd_granted <= 1'b0;
			  	end
			  	else if(wr_req && done)// Transition to Write
			  	begin
			  		wr_granted <= 1'b1;
			  		rd_granted <= 1'b0;
			  	end
			  	else // Stay in Read
			  	begin
			  		wr_granted <= 1'b0;
			  		rd_granted <= 1'b1;
			  	end
			end
			else
			begin
			  		wr_granted <= 1'b0;
			  		rd_granted <= 1'b0;
			end
		end
	end
endmodule
