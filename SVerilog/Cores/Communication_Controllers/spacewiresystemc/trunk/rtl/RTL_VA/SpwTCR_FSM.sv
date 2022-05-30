module SpwTCR_FSM ( 
  CLOCK,
  RESETn,
  LINK_START,
  LINK_DISABLE,
  AUTOSTART,
  CURRENTSTATE,
  after128,
  after64,
  enableTimer,
  resetTx,
  enableTx,
  sendNULLs,
  sendFCTs,
  sendNChars,
  sendTimeCodes,
  startupRate,
  resetRx,
  enableRx,
  gotFCT, 
  gotNChar, 
  gotTimeCode, 
  gotNULL, 
  creditError,
  rxError
  );

//control Interface
input  			CLOCK;	//Global Clock
input  			RESETn;	//Global Reset
input  			LINK_START;	//8.5.3.1.3 and 8.6
input  			LINK_DISABLE;
input  			AUTOSTART;
output reg [2:0] 	CURRENTSTATE;	// Output with current state
//Timer Interface
input  			after128;	// pulse after 12.8us - from FSM_TIMER module
input  			after64;		// pulse after 6.4us - from FSM_TIMER module
output reg 	enableTimer; //Start timer of FSM_TIMER module when HIGH, disable and restart timer when LOW

//TX Interface
output reg  			resetTx;
output reg  			enableTx;
output reg  			sendNULLs;
output reg  			sendFCTs;
output reg  			sendNChars;
output reg  			sendTimeCodes;
//TX Clock Interface
output reg 			startupRate;
//Rx Interface 
output reg  			resetRx;
output reg  			enableRx;
input  			gotFCT;
input  			gotNChar; 
input  			gotTimeCode; 
input  			gotNULL;
input  			creditError;
input  			rxError;

localparam [2:0] 	ERROR_RESET   = 3'b000,
						ERROR_WAIT    = 3'b001,
                  READY         = 3'b011,
                  STARTED       = 3'b010,
                  CONNECTING    = 3'b100,
                  RUN           = 3'b101;
/*
enum logic [2:0] {ERROR_RESET   = 3'b000,
                  ERROR_WAIT    = 3'b001,
                  READY         = 3'b011,
                  STARTED       = 3'b010,
                  CONNECTING    = 3'b100,
                  RUN           = 3'b101
                  } State, NextState;
*/

reg  [2:0] State, NextState;
reg StateFirstClk;
                  
always @(posedge CLOCK, negedge RESETn)
  if (!RESETn) 
    State <= ERROR_RESET;
  else 
    State <= NextState;
    
always @(*) 
  begin
    NextState = State; //default
    case (State)
      ERROR_RESET: 
        if (after64) 
          NextState = ERROR_WAIT;
      ERROR_WAIT: 
        if (after128) 
          NextState = READY;
        else if(rxError | (gotNULL & (gotFCT | gotNChar | gotTimeCode)) )
          NextState = ERROR_RESET;
      READY: 
        if ((LINK_START | (AUTOSTART & gotNULL)) & !LINK_DISABLE) 
          NextState = STARTED;
        else if(rxError | (gotNULL & (gotFCT | gotNChar | gotTimeCode)) )
          NextState = ERROR_RESET;
      STARTED: 
        if (gotNULL) 
          NextState = CONNECTING;
        else if(rxError | gotFCT | gotNChar | gotTimeCode | after128 )
          NextState = ERROR_RESET;
      CONNECTING: 
        if (gotFCT) 
          NextState = RUN;
        else if(rxError | gotNChar | gotTimeCode | after128 )
          NextState = ERROR_RESET;
      RUN: 
        if ( rxError | creditError | LINK_DISABLE ) 
          NextState = ERROR_RESET;
    endcase
end
    
always @ (*) 
  begin
    case (State)
      ERROR_RESET:
      begin
          enableTx      = 1'b0;
          enableRx      = 1'b0;
          sendNULLs     = 1'b0;
          sendFCTs      = 1'b0;
          sendTimeCodes = 1'b0;
          sendNChars    = 1'b0;
        end 

      ERROR_WAIT: 
        begin
          enableTx      = 1'b0;
          enableRx      = 1'b1;
          sendNULLs     = 1'b0;
          sendFCTs      = 1'b0;
          sendTimeCodes = 1'b0;
          sendNChars    = 1'b0;
        end
      READY: 
        begin
          enableTx      = 1'b0;
          enableRx      = 1'b1;
          sendNULLs     = 1'b0;
          sendFCTs      = 1'b0;
          sendTimeCodes = 1'b0;
          sendNChars    = 1'b0;
        end
      STARTED: 
        begin
          enableTx      = 1'b1;
          enableRx      = 1'b1;
          sendNULLs     = 1'b1;
          sendFCTs      = 1'b0;
          sendTimeCodes = 1'b0;
          sendNChars    = 1'b0;
        end
      CONNECTING: 
        begin
          enableTx      = 1'b1;
          enableRx      = 1'b1;
          sendNULLs     = 1'b1;
          sendFCTs      = 1'b1;
          sendTimeCodes = 1'b0;
          sendNChars    = 1'b0;
        end
      RUN: 
        begin
          enableTx      = 1'b1;
          enableRx      = 1'b1;
          sendNULLs     = 1'b1;
          sendFCTs      = 1'b1;
          sendTimeCodes = 1'b1;
          sendNChars    = 1'b1;
        end
      default:
      begin
          enableTx      = 1'b0;
          enableRx      = 1'b0;
          sendNULLs     = 1'b0;
          sendFCTs      = 1'b0;
          sendTimeCodes = 1'b0;
          sendNChars    = 1'b0;
        end 
    endcase
  end    
 
assign CURRENTSTATE = State;  

always @(posedge CLOCK, negedge RESETn)
begin
  if (!RESETn) 
	begin
	 StateFirstClk 	<= 1'b1;
	end
  else
	if(NextState != State)
		begin
		StateFirstClk 	<= 1'b1;
		end
	else
		begin
		StateFirstClk 	<= 1'b0;
		end
end

assign enableTimer = (State == ERROR_RESET | State == ERROR_WAIT | State == STARTED | State == CONNECTING ) ? 1'b1 : 1'b0;
assign resetTx = ((State == ERROR_RESET & StateFirstClk) | (State == ERROR_WAIT & StateFirstClk) | (State == READY & StateFirstClk) ) ? 1'b0 : 1'b1;   
assign resetRx = ((State == ERROR_RESET & StateFirstClk))? 1'b0 : 1'b1; 
assign startupRate = (State != RUN) ? 1'b1 : 1'b0;   



endmodule 
