
`timescale 1ns/1ns

module uart_rx#(
		parameter integer WIDTH = 12
	      )
	      (
 		//external input
		input PCLK,
		input RESET,
		input RX_I,
		input [11:0] WORK_FR,
		output reg [7:0] DATA_RX_O,
		output reg PARITY_RX,
		output READY
	      );

localparam [3:0] RX_IDLE   	 = 4'b0000,
	   	 RX_DETECT_START = 4'b0001,	
	   	 RX_TAKE_DATA    = 4'b0010,
	   	 RX_TAKE_PARITY  = 4'b0100,
	   	 RX_HIGH_DETECT  = 4'b1000;

		reg [3:0] state_rx;
		reg [3:0] next_state_rx; 

		reg [WIDTH-1:0] COUNTER;
		reg [3:0] DATA_COUNTER;

		reg AUX;
		

assign READY  = (state_rx == RX_HIGH_DETECT & COUNTER == 12'd2)?1'b1:1'b0;


always@(*)
begin

	next_state_rx = state_rx;

	case(state_rx)
	RX_IDLE:
	begin
		if(RX_I)
		begin
			next_state_rx = RX_IDLE;			
		end
		else
		begin
			next_state_rx = RX_DETECT_START;
		end

	end
	RX_DETECT_START:
	begin

		if(COUNTER == WORK_FR && AUX == 1'b0)
		begin
			next_state_rx = RX_TAKE_DATA;
		end
		else if(COUNTER != WORK_FR)
		begin
			next_state_rx = RX_DETECT_START;
		end
		else
		begin
			next_state_rx = RX_IDLE;
		end

	end
	RX_TAKE_DATA:
	begin

		if(COUNTER != WORK_FR && DATA_COUNTER != 4'b1000)
		begin
			next_state_rx = RX_TAKE_DATA;
		end
		else if(COUNTER == WORK_FR && DATA_COUNTER != 4'b1000)
		begin
			next_state_rx = RX_TAKE_DATA;
		end
		else if(COUNTER == WORK_FR && DATA_COUNTER == 4'b1000)
		begin
			next_state_rx = RX_TAKE_PARITY;
		end
	end
	RX_TAKE_PARITY:
	begin

		if(COUNTER != WORK_FR)
		begin
			next_state_rx = RX_TAKE_PARITY;
		end
		else
		begin
			next_state_rx = RX_HIGH_DETECT;
		end
	end
	RX_HIGH_DETECT:
	begin

		if(COUNTER != WORK_FR)
		begin
			next_state_rx = RX_HIGH_DETECT;
		end
		else if(COUNTER == WORK_FR && AUX == 1'b0)
		begin
			next_state_rx = RX_HIGH_DETECT;
		end
		else
		begin
			next_state_rx = RX_IDLE;
		end		
	end
	default:
	begin
		next_state_rx = RX_IDLE;
	end
	endcase

end


always@(posedge PCLK)
begin

	if(RESET)
	begin
		state_rx <= RX_IDLE;
		COUNTER<= {WIDTH{1'b0}};
		DATA_COUNTER<= 4'd0;
		DATA_RX_O<=8'd0;
		AUX<= 1'b1;
	end
	else
	begin
		state_rx <= next_state_rx;

		case(state_rx)
		RX_IDLE:
		begin			
			if(RX_I)
			begin
				COUNTER<= {WIDTH{1'b0}};
				DATA_COUNTER<= 4'd0;
			end
			else
			begin
				COUNTER<= COUNTER + 1'b1;	
			end
		end	
		RX_DETECT_START:
		begin
				
			if(COUNTER == WORK_FR/2'd2)
			begin
				AUX <= RX_I;
				COUNTER<= COUNTER + 1'b1;
			end
			else if(COUNTER < WORK_FR)
			begin
				COUNTER<= COUNTER + 1'b1;
			end
			else
			begin
				COUNTER<= {WIDTH{1'b0}};
			end
		end
		RX_TAKE_DATA:
		begin

			if(DATA_COUNTER != 4'b1000 && COUNTER == WORK_FR/2'd2)
			begin
				DATA_COUNTER<= DATA_COUNTER+1'b1;
				DATA_RX_O[DATA_COUNTER[2:0]]<=RX_I;
				COUNTER<= COUNTER + 1'b1;
			end
			else if(COUNTER < WORK_FR)
			begin
				COUNTER<= COUNTER + 1'b1;
			end
			else
			begin
				COUNTER<= {WIDTH{1'b0}};
			end
		end
		RX_TAKE_PARITY:
		begin

			if(COUNTER == WORK_FR/2'd2)
			begin
				PARITY_RX <= RX_I;
				COUNTER <= COUNTER + 1'b1;
			end
			else if(COUNTER < WORK_FR)
			begin			
				COUNTER <= COUNTER + 1'b1;
			end
			else
			begin
				COUNTER<= {WIDTH{1'b0}};
				AUX <= 1'b0;
			end

		end
		RX_HIGH_DETECT:
		begin

			if(COUNTER == WORK_FR/2'd2)
			begin
				AUX <= RX_I;
				COUNTER<= COUNTER + 1'b1;
			end
			else if(COUNTER < WORK_FR)
			begin
				COUNTER<= COUNTER + 1'b1;
			end
			else
			begin
				COUNTER<= {WIDTH{1'b0}};
			end
			DATA_COUNTER<= 4'd0;
		end
		default:
		begin
			DATA_COUNTER<= 4'd0;
			COUNTER<= {WIDTH{1'b0}};
		end

		endcase
	end
end


endmodule
