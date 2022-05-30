module SpwTCR_FSM_TIMER (
CLOCK,
RESETn,
enableTimer,
after128,
after64
);

parameter DIV_64  = 12'd1280;
parameter DIV_128 = 12'd2560;

//parameter DIV_64  = 12'd320;
//parameter DIV_128 = 12'd640;

input 		CLOCK;
input 		RESETn;
input 		enableTimer;
output logic 		after128;
output logic 		after64;

logic [11:0] 	counter;

always @(posedge CLOCK, negedge RESETn)
begin
	if (!RESETn)
		begin
		counter 		<= 12'd0;
		after64 		<= 1'b0;
		after128 	<= 1'b0;
		end
  else
		begin
		if (!enableTimer)
			begin
				counter 		<= 12'd0;
				after64 		<= 1'b0;
				after128 	<= 1'b0;
			end
		else
			begin
			if(counter == DIV_64)
				begin
					after64 		<= 1'b1;
					after128 	<= 1'b0;
					counter 		<= counter + 1'b1;
				end
			else if(counter == DIV_128)
				begin
					after64 		<= 1'b0;
					after128 	<= 1'b1;
					counter 		<= 12'd0;
				end
			else
				begin
					after64 		<= 1'b0;
					after128 	<= 1'b0;
					counter 		<= counter + 1'b1;
				end
			end
		end
end
endmodule 
