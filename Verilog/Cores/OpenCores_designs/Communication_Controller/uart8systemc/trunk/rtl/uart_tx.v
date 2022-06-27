
`timescale 1ns/1ns

module uart_tx#(
			parameter integer WIDTH = 12 
	       )
	      (
		input PCLK,
		input RESET,
		input [7:0] DATA_TX_I,
		input [11:0] WORK_FR,
		input START,
		output TX_O,
		output reg READY_TX
	      );

localparam [11:0] TX_IDLE   = 12'b0000_0000_0000,
	   	  TX_START  = 12'b0000_0000_0001,	
	   	  TX_BIT_1  = 12'b0000_0000_0010,
	   	  TX_BIT_2  = 12'b0000_0000_0100,
	   	  TX_BIT_3  = 12'b0000_0000_1000,
           	  TX_BIT_4  = 12'b0000_0001_0000,
	    	  TX_BIT_5  = 12'b0000_0010_0000,
	   	  TX_BIT_6  = 12'b0000_0100_0000,
             	  TX_BIT_7  = 12'b0000_1000_0000,
      	   	  TX_BIT_8  = 12'b0001_0000_0000,
	   	  TX_PARITY = 12'b0010_0000_0000,
	   	  TX_STOP   = 12'b0100_0000_0000;
	   
	reg [11:0] state_tx;
	reg [11:0] next_state_tx;

	reg [WIDTH-1:0] DELAY_COUNTER;
	




assign TX_O = (state_tx == TX_START)?1'b0:
	      (state_tx == TX_BIT_1)?DATA_TX_I[0:0]:
	      (state_tx == TX_BIT_2)?DATA_TX_I[1:1]:
	      (state_tx == TX_BIT_3)?DATA_TX_I[2:2]:
	      (state_tx == TX_BIT_4)?DATA_TX_I[3:3]:
	      (state_tx == TX_BIT_5)?DATA_TX_I[4:4]:
	      (state_tx == TX_BIT_6)?DATA_TX_I[5:5]:
	      (state_tx == TX_BIT_7)?DATA_TX_I[6:6]:
	      (state_tx == TX_BIT_8)?DATA_TX_I[7:7]:
	      (state_tx == TX_PARITY)?DATA_TX_I[0:0]^DATA_TX_I[1:1]^DATA_TX_I[2:2]^DATA_TX_I[3:3]^DATA_TX_I[4:4]^DATA_TX_I[5:5]^DATA_TX_I[6:6]^DATA_TX_I[7:7]:
	      (state_tx == TX_STOP)?1'b1:1'b1;

always@(*)
begin

	next_state_tx = state_tx;

	case(state_tx)
	TX_IDLE:
	begin
		if(START == 1'b0)
		begin
			next_state_tx = TX_IDLE;
		end
		else 
		begin
			next_state_tx = TX_START;
		end
	end
	TX_START:
	begin
		if(DELAY_COUNTER != WORK_FR)
		begin
			next_state_tx = TX_START;
		end
		else
		begin
			next_state_tx = TX_BIT_1;
		end
		
	end
	TX_BIT_1:
	begin
		if(DELAY_COUNTER != WORK_FR)
		begin
			next_state_tx = TX_BIT_1;
		end
		else
		begin
			next_state_tx = TX_BIT_2;
		end

	end
	TX_BIT_2:
	begin

		if(DELAY_COUNTER != WORK_FR)
		begin
			next_state_tx = TX_BIT_2;
		end
		else
		begin
			next_state_tx = TX_BIT_3;
		end

	end
	TX_BIT_3:
	begin

		if(DELAY_COUNTER != WORK_FR)
		begin
			next_state_tx = TX_BIT_3;
		end
		else
		begin
			next_state_tx = TX_BIT_4;
		end		
	end
	TX_BIT_4:
	begin

		if(DELAY_COUNTER != WORK_FR)
		begin
			next_state_tx = TX_BIT_4;
		end
		else
		begin
			next_state_tx = TX_BIT_5;
		end		
	end
	TX_BIT_5:
	begin

		if(DELAY_COUNTER != WORK_FR)
		begin
			next_state_tx = TX_BIT_5;
		end
		else
		begin
			next_state_tx = TX_BIT_6;
		end		
	end
	TX_BIT_6:
	begin

		if(DELAY_COUNTER != WORK_FR)
		begin
			next_state_tx = TX_BIT_6;
		end
		else
		begin
			next_state_tx = TX_BIT_7;
		end		
	end
	TX_BIT_7:
	begin

		if(DELAY_COUNTER != WORK_FR)
		begin
			next_state_tx = TX_BIT_7;
		end
		else
		begin
			next_state_tx = TX_BIT_8;
		end		
	end
	TX_BIT_8:
	begin

		if(DELAY_COUNTER != WORK_FR)
		begin
			next_state_tx = TX_BIT_8;
		end
		else
		begin
			next_state_tx = TX_PARITY;
		end		
	end
	TX_PARITY:
	begin

		if(DELAY_COUNTER != WORK_FR)
		begin
			next_state_tx = TX_PARITY;
		end
		else
		begin
			next_state_tx = TX_STOP;
		end		
	end
	TX_STOP:
	begin

		if(DELAY_COUNTER != WORK_FR)
		begin
			next_state_tx = TX_STOP;
		end
		else
		begin
			next_state_tx = TX_IDLE;
		end
				
	end
	default:
	begin
		next_state_tx = TX_IDLE;
	end
	endcase
end



always@(posedge PCLK)
begin
	if(RESET)
	begin
		READY_TX <= 1'b1;
		DELAY_COUNTER<= {WIDTH{1'b0}};
		state_tx <= TX_IDLE;
	end
	else
	begin
		state_tx <= next_state_tx;

		case(state_tx)
		TX_IDLE:
		begin
			if(START == 1'b0)
			begin
				READY_TX<= 1'b1;
				DELAY_COUNTER<= {WIDTH{1'b0}};	
			end
			else
			begin
				READY_TX<= 1'b0;
				DELAY_COUNTER <= DELAY_COUNTER + 1'b1;
			end
		end
		TX_START:
		begin
			if(DELAY_COUNTER < WORK_FR)
			begin
				DELAY_COUNTER <= DELAY_COUNTER + 1'b1;
			end
			else 
			begin
				DELAY_COUNTER<= {WIDTH{1'b0}};
			end
		end
		TX_BIT_1:
		begin
			if(DELAY_COUNTER < WORK_FR)
			begin
				DELAY_COUNTER <= DELAY_COUNTER + 1'b1;
			end
			else 
			begin
				DELAY_COUNTER<= {WIDTH{1'b0}};
			end
		end
		TX_BIT_2:
		begin
			if(DELAY_COUNTER < WORK_FR)
			begin
				DELAY_COUNTER <= DELAY_COUNTER + 1'b1;
			end
			else 
			begin
				DELAY_COUNTER<= {WIDTH{1'b0}};
			end
		end
		TX_BIT_3:
		begin
			if(DELAY_COUNTER < WORK_FR)
			begin
				DELAY_COUNTER <= DELAY_COUNTER + 1'b1;
			end
			else 
			begin
				DELAY_COUNTER<= {WIDTH{1'b0}};
			end
		end
		TX_BIT_4:
		begin
			if(DELAY_COUNTER < WORK_FR)
			begin
				DELAY_COUNTER <= DELAY_COUNTER + 1'b1;
			end
			else 
			begin
				DELAY_COUNTER<= {WIDTH{1'b0}};
			end
		end
		TX_BIT_5:
		begin
			if(DELAY_COUNTER < WORK_FR)
			begin
				DELAY_COUNTER <= DELAY_COUNTER + 1'b1;
			end
			else 
			begin
				DELAY_COUNTER<= {WIDTH{1'b0}};
			end
		end
		TX_BIT_6:
		begin
			if(DELAY_COUNTER < WORK_FR)
			begin
				DELAY_COUNTER <= DELAY_COUNTER + 1'b1;
			end
			else 
			begin
				DELAY_COUNTER<= {WIDTH{1'b0}};
			end
		end
		TX_BIT_7:
		begin
			if(DELAY_COUNTER < WORK_FR)
			begin
				DELAY_COUNTER <= DELAY_COUNTER + 1'b1;
			end
			else 
			begin
				DELAY_COUNTER<= {WIDTH{1'b0}};
			end
		end
		TX_BIT_8:
		begin
			if(DELAY_COUNTER < WORK_FR)
			begin
				DELAY_COUNTER <= DELAY_COUNTER + 1'b1;
			end
			else 
			begin
				DELAY_COUNTER <= {WIDTH{1'b0}};
			end
		end
		TX_PARITY:
		begin
			if(DELAY_COUNTER < WORK_FR)
			begin
				DELAY_COUNTER <= DELAY_COUNTER + 1'b1;
			end
			else 
			begin
				DELAY_COUNTER <= {WIDTH{1'b0}};
			end
		end
		TX_STOP:
		begin
			if(DELAY_COUNTER < WORK_FR)
			begin
				DELAY_COUNTER <= DELAY_COUNTER + 1'b1;
			end
			else 
			begin
				DELAY_COUNTER<= {WIDTH{1'b0}};
			end
		end
		default:
		begin
			DELAY_COUNTER<= {WIDTH{1'b1}};
		end
		endcase
	end
end


endmodule
