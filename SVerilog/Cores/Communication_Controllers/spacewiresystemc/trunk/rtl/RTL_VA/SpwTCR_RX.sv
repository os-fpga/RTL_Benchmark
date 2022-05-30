module SpwTCR_RX(
Din, 
Sin,
CLK_RX,
CLOCK,
RESETn,
TICK_OUT,
TIME_OUT,
RX_DATA,
BUFFER_WRITE,
BUFFER_READY,
almost_full,
enableRx,
gotBit,
gotFCT, 
gotNChar, 
gotTimeCode, 
gotNULL,
gotData,
gotEEP,
gotEOP,
creditErr,
rxError,
sendFctReq,
sendFctAck
);

input 					Din;
input 					Sin;
input 					CLK_RX;
input 					CLOCK;
input						RESETn;
output logic 			TICK_OUT;
output logic [7:0] 	TIME_OUT;
output logic [8:0] 	RX_DATA;
output logic 			BUFFER_WRITE;
input 					BUFFER_READY;
input						almost_full;
input 					enableRx;
output logic 			gotBit;
output logic 			gotFCT; 
output logic 			gotNChar; 
output logic 			gotTimeCode; 
output logic 			gotNULL;
output logic 			gotData;
output logic 			gotEEP;
output logic 			gotEOP;
output logic			creditErr;
output logic 			rxError;
output logic			sendFctReq;
input 					sendFctAck;

logic 			tick_out_w;
logic [7:0] 	time_out_w;
logic [8:0] 	rx_data_w;
logic 			buffer_write_w;
logic 			gotBit_w;
logic 			gotFCT_w; 
logic 			gotNChar_w;
logic 			gotNChar_sys_w; 
logic 			gotTimeCode_w;
logic 			gotNULL_w;
logic 			gotData_w;
logic				gotEEP_w;
logic 			gotEOP_w;
logic 			creditErr_w;
logic 			rxError_w;
logic				rxError_fsm_w;
logic 			sendFctReq_w;
logic 			clk_rx_w;
logic 			disconnect_w;
/*
ALTIOBUF_iobuf_in_p4i CLK_BUFF ( 
	.datain(CLK_RX),
	.dataout(clk_rx_w)
) ;
*/
assign clk_rx_w = CLK_RX;
assign gotNChar = gotNChar_sys_w;

assign rxError_fsm_w = (rxError_w | disconnect_w);

SpwTCR_RX_sync RX_sync(
.CLOCK(CLOCK),
.RESETn(RESETn),
.TICK_OUT(tick_out_w),
.TIME_OUT(time_out_w),
.RX_DATA(rx_data_w),
.BUFFER_WRITE(buffer_write_w),
.gotBit(gotBit_w),
.gotFCT(gotFCT_w), 
.gotNChar(gotNChar_w), 
.gotTimeCode(gotTimeCode_w), 
.gotNULL(gotNULL_w),
.gotData(gotData_w),
.gotEEP(gotEEP_w),
.gotEOP(gotEOP_w),
.creditErr(creditErr_w),
.rxError(rxError_fsm_w),
.sendFctReq(sendFctReq_w),

.TICK_OUT_sys(TICK_OUT),
.TIME_OUT_sys(TIME_OUT),
.RX_DATA_sys(RX_DATA),
.BUFFER_WRITE_sys(BUFFER_WRITE),
.gotBit_sys(gotBit),
.gotFCT_sys(gotFCT), 
.gotNChar_sys(gotNChar_sys_w), 
.gotTimeCode_sys(gotTimeCode), 
.gotNULL_sys(gotNULL),
.gotData_sys(gotData),
.gotEEP_sys(gotEEP),
.gotEOP_sys(gotEOP),
.creditErr_sys(creditErr),
.rxError_sys(rxError),
.sendFctReq_sys(sendFctReq)

);

SpwTCR_RX_receiver RX_receiver(
.Din(Din),
.CLK_RX(clk_rx_w),
.disconnect_in(disconnect_w),
.TICK_OUT(tick_out_w),
.TIME_OUT(time_out_w),
.RX_DATA(rx_data_w),
.BUFFER_WRITE(buffer_write_w),
.BUFFER_READY(BUFFER_READY),
.RESETn(RESETn),
.enableRx(enableRx),
.gotBit(gotBit_w),
.gotFCT(gotFCT_w), 
.gotNChar(gotNChar_w), 
.gotTimeCode(gotTimeCode_w), 
.gotNULL(gotNULL_w),
.gotData(gotData_w),
.gotEEP(gotEEP_w),
.gotEOP(gotEOP_w),
.rxError(rxError_w)
);

SpwTCR_RXTX_credit RX_credit(
.CLOCK(CLOCK),
.RESETn(RESETn),
.enableRx(enableRx),
.gotNChar(gotNChar_sys_w),
.almost_full(almost_full),
.fifo_ready(BUFFER_READY),
.sendFctReq(sendFctReq_w),
.sendFctAck(sendFctAck),
.creditErr(creditErr_w)
);

SpwTCR_RX_TIMEOUT RX_TIMEOUT(
.CLOCK(CLOCK), 
.RESETn(RESETn),
.enable(gotBit_w), 
.Din(Din), 
.Sin(Sin), 
.disconnect(disconnect_w)
);

endmodule


module SpwTCR_RX_sync(
CLOCK,
RESETn,

TICK_OUT,
TIME_OUT,
RX_DATA,
BUFFER_WRITE,
gotBit,
gotFCT, 
gotNChar, 
gotTimeCode, 
gotNULL,
gotData,
gotEEP,
gotEOP,
creditErr,
rxError,
sendFctReq,

TICK_OUT_sys,
TIME_OUT_sys,
RX_DATA_sys,
BUFFER_WRITE_sys,
gotBit_sys,
gotFCT_sys, 
gotNChar_sys, 
gotTimeCode_sys, 
gotNULL_sys,
gotData_sys,
gotEEP_sys,
gotEOP_sys,
creditErr_sys,
rxError_sys,
sendFctReq_sys

);


input 			CLOCK;
input 			RESETn;


input 			TICK_OUT;
input [7:0] 	TIME_OUT;
input [8:0] 	RX_DATA;
input 			BUFFER_WRITE;
input				gotBit;
input 			gotFCT; 
input 			gotNChar; 
input 			gotTimeCode; 
input 			gotNULL;
input 			gotData;
input 			gotEEP;
input 			gotEOP;
input				creditErr;
input 			rxError;
input				sendFctReq;

output logic			TICK_OUT_sys;
output logic [7:0]	TIME_OUT_sys;
output logic [8:0]	RX_DATA_sys;
output logic			BUFFER_WRITE_sys;
output logic			gotBit_sys;
output logic			gotFCT_sys; 
output logic			gotNChar_sys; 
output logic			gotTimeCode_sys; 
output logic			gotNULL_sys;
output logic			gotData_sys;
output logic			gotEEP_sys;
output logic			gotEOP_sys;
output logic			creditErr_sys;
output logic			rxError_sys;
output logic			sendFctReq_sys;


//registers

logic			BUFFER_WRITE_sync1;
logic			gotFCT_sync1;
logic			gotNChar_sync1; 
logic			gotTimeCode_sync1; 
logic			gotData_sync1;
logic			gotEEP_sync1;
logic			gotEOP_sync1;
logic			TICK_OUT_sync1;
logic	[7:0] TIME_OUT_sync1;
logic	[8:0] RX_DATA_sync1;
logic			gotBit_sync1;
logic			gotNULL_sync1;
logic			creditErr_sync1;
logic			rxError_sync1;
logic			sendFctReq_sync1;
logic			BUFFER_WRITE_sync2;
logic			gotFCT_sync2;
logic			gotNChar_sync2; 
logic			gotTimeCode_sync2; 
logic			gotData_sync2;
logic			gotEEP_sync2;
logic			gotEOP_sync2;


// Sync CLOCK_RX to CLOCK SYS
always @(posedge CLOCK, negedge RESETn)
begin
if(!RESETn)
	begin
	TICK_OUT_sys 			<= 1'b0;
	TIME_OUT_sys 			<= 8'd0;
	RX_DATA_sys 			<= 9'd0;
	BUFFER_WRITE_sys 		<= 1'b0;
	gotBit_sys 				<= 1'b0;
	gotFCT_sys 				<= 1'b0;
	gotNChar_sys 			<= 1'b0; 
	gotTimeCode_sys 		<= 1'b0; 
	gotNULL_sys 			<= 1'b0;
	gotData_sys 			<= 1'b0;
	gotEEP_sys 				<= 1'b0;
	gotEOP_sys 				<= 1'b0;
	creditErr_sys 			<= 1'b0;
	rxError_sys 			<= 1'b0;
	sendFctReq_sys 		<= 1'b0;
	TICK_OUT_sync1 		<= 1'b0;
	TIME_OUT_sync1 		<= 8'd0;
	RX_DATA_sync1 			<= 9'd0;
	BUFFER_WRITE_sync1 	<= 1'b0;
	gotBit_sync1 			<= 1'b0;
	gotFCT_sync1 			<= 1'b0;
	gotNChar_sync1 		<= 1'b0; 
	gotTimeCode_sync1 	<= 1'b0; 
	gotNULL_sync1 			<= 1'b0;
	gotData_sync1 			<= 1'b0;
	gotEEP_sync1 			<= 1'b0;
	gotEOP_sync1 			<= 1'b0;
	creditErr_sync1 		<= 1'b0;
	rxError_sync1 			<= 1'b0;
	sendFctReq_sync1 		<= 1'b0;
	
	BUFFER_WRITE_sync2 	<= 1'b0;
	gotFCT_sync2 			<= 1'b0;
	gotNChar_sync2 		<= 1'b0;
	gotTimeCode_sync2 	<= 1'b0;
	gotData_sync2 			<= 1'b0;
	gotEEP_sync2 			<= 1'b0;
	gotEOP_sync2 			<= 1'b0;
	end
else
	begin
	BUFFER_WRITE_sync1 	<= BUFFER_WRITE;	
	gotFCT_sync1 			<= gotFCT;
	gotNChar_sync1 		<= gotNChar; 
	gotTimeCode_sync1 	<= gotTimeCode; 
	gotData_sync1 			<= gotData;
	gotEEP_sync1 			<= gotEEP;
	gotEOP_sync1 			<= gotEOP;
	
	//sync2 to generate edge detection
	BUFFER_WRITE_sync2 	<= BUFFER_WRITE_sync1;
	gotFCT_sync2 			<= gotFCT_sync1;
	gotNChar_sync2 		<= gotNChar_sync1; 
	gotTimeCode_sync2 	<= gotTimeCode_sync1; 
	gotData_sync2 			<= gotData_sync1;
	gotEEP_sync2 			<= gotEEP_sync1;
	gotEOP_sync2 			<= gotEOP_sync1;
	
	//edge detection
	BUFFER_WRITE_sys 		<= BUFFER_WRITE_sync1 	& !BUFFER_WRITE_sync2;
	gotFCT_sys 				<= gotFCT_sync1 			& !gotFCT_sync2;
	gotNChar_sys 			<= gotNChar_sync1 		& !gotNChar_sync2; 
	gotTimeCode_sys 		<= gotTimeCode_sync1 	& !gotTimeCode_sync2; 
	gotData_sys 			<= gotData_sync1 			& !gotData_sync2;
	gotEEP_sys 				<= gotEEP_sync1 			& !gotEEP_sync2;
	gotEOP_sys 				<= gotEOP_sync1 			& !gotEOP_sync2;
	
	//avoid  metastability 
	TICK_OUT_sync1 		<= TICK_OUT;
	TIME_OUT_sync1 		<= TIME_OUT;
	RX_DATA_sync1 			<= RX_DATA;
	gotBit_sync1 			<= gotBit;
	gotNULL_sync1 			<= gotNULL;	
	creditErr_sync1 		<= creditErr;
	rxError_sync1 			<= rxError;
	sendFctReq_sync1 		<= sendFctReq;
	
	TICK_OUT_sys 			<= TICK_OUT_sync1;
	TIME_OUT_sys 			<= TIME_OUT_sync1;
	RX_DATA_sys 			<= RX_DATA_sync1;
	gotBit_sys 				<= gotBit_sync1;
	gotNULL_sys 			<= gotNULL_sync1;
	creditErr_sys 			<= creditErr_sync1;
	rxError_sys 			<= rxError_sync1;
	sendFctReq_sys 		<= sendFctReq_sync1;
	
	end

end
endmodule



module SpwTCR_RX_receiver(
Din, 
CLK_RX,
disconnect_in,
TICK_OUT,
TIME_OUT,
RX_DATA,
BUFFER_WRITE,
BUFFER_READY,
RESETn,
enableRx,
gotBit,
gotFCT, 
gotNChar, 
gotTimeCode, 
gotNULL,
gotData,
gotEEP,
gotEOP,
rxError
);

input 					Din;
input 					CLK_RX;
input						disconnect_in;
output logic 			TICK_OUT;
output logic [7:0] 	TIME_OUT;
output logic [8:0] 	RX_DATA;
output logic 			BUFFER_WRITE;
input 					BUFFER_READY;
input 					RESETn;
input 					enableRx;
output logic 			gotBit;
output logic 			gotFCT; 
output logic 			gotNChar; 
output logic 			gotTimeCode; 
output logic 			gotNULL;
output logic 			gotData;
output logic 			gotEEP;
output logic 			gotEOP;
output logic 			rxError;




logic [4:0] 	A;
logic [5:0] 	B;
logic [10:0] 	STORE_REG;
logic [9:0] 	BUFFER_DIN;
logic 			clock_edge;
logic 			parity_error;
logic [1:0] 	counter_cycle;
logic 			rx_ready;
logic 			rx_ready1;
logic 			gotNULL_r;
logic [3:0]		counter_start;
logic [7:0] 	last_time_out;
logic 			current_packet;

logic flag_data, flag_timecode, flag_eep, flag_eop, flag_null, flag_fct;

enum logic [3:0] {
	WAIT,
	FIND_NULL,
	START, 
	CONTROL_AQ, 
	DATA_AQ, 
	GOT_ESC, 
	PRE_NULL, 
	PRE_TIME, 
	DISCONNECT_ERR, 
	PARITY_ERR, 
	ESC_ERR
} state, nextState;

//Din Shif register MUX, clock_edge depends on detection of firt NULL
assign BUFFER_DIN = (clock_edge) ? STORE_REG[10:1] : STORE_REG[9:0];

// B: store data input (Din) on negedge CLOCK RX
always @(negedge CLK_RX, negedge RESETn)
begin
	if(!RESETn)
		begin
			B <= 6'd0;
		end
	else
		begin
			if (!enableRx)
				B <= 6'd0;
			else
				B <={B[4:0],Din}; //Shift Regiter with Data received on negedge CLOCK RX
		end
end


//Din detection on rising edge of clock RX
// A: store data input on rising edge
// STORE_REG: store A and B reg from posedge reg A and negedge reg B
always @(posedge CLK_RX, negedge RESETn)
begin
	if(!RESETn)
		begin
		A 				<= 5'd0;
		STORE_REG 	<= 11'd0;
		end
	else 
		begin
			if (!enableRx)
				begin
					A 				<= 5'd0;
					STORE_REG 	<= 11'd0;
				end
			else
				begin
					A <= {A[3:0],Din}; //Shift Regiter with Data received on posedge CLOCK RX
					STORE_REG <= {B[5],A[4],B[4],A[3],B[3],A[2],B[2],A[1],B[1],A[0],B[0]}; //merge posedge end negedge Data Received
				end
		end
end

// RX_FSM that detect chars that was received
always @(posedge CLK_RX, negedge RESETn)
begin
	if(!RESETn)
		begin
		state <= WAIT;
		end
	else 
		begin
		if (!enableRx)
			begin
			state <= WAIT;
			end
		else
			begin
			state <= nextState;
			end
		end
end

always @ (*)
begin
case (state)
	WAIT: //Wait 8 bits arrives than will search Fist Null
		if(counter_start==4'd3)
			nextState = FIND_NULL;
		else
			nextState = WAIT;
	//ECSS-ST-50-12C: 8.5.3.2.e	
	//Search the 9'b011101000 sequence	
	FIND_NULL:	
		if(disconnect_in)
			nextState = DISCONNECT_ERR;
		else if (STORE_REG[9:1] == 9'b011101000)
			begin
			if (STORE_REG[0] == 1'b1 & rx_ready) 
				nextState = CONTROL_AQ;
			else
				nextState = ESC_ERR;				
			end
		else if (STORE_REG[10:2] == 9'b011101000)
			begin
			if (STORE_REG[1] == 1'b1 & rx_ready)
				nextState = CONTROL_AQ;
			else
				nextState = ESC_ERR;				
			end
		else
			nextState = FIND_NULL;	
	START: //Fist stage after each character is detected, define if a NChar or a Control char is arriving
		if(disconnect_in)
			nextState = DISCONNECT_ERR;
		else if (BUFFER_DIN[0] == 1'b1 & rx_ready)
			nextState = CONTROL_AQ;
		else if (BUFFER_DIN[0] == 1'b0 & rx_ready)
			nextState = DATA_AQ;
		else
			nextState = START;
	CONTROL_AQ:
		if(disconnect_in)
			nextState = DISCONNECT_ERR;
		else if (parity_error)
			nextState = PARITY_ERR;
		else if (BUFFER_DIN[1:0] == 2'b11)
			nextState = GOT_ESC;
		else
			nextState = START;
	GOT_ESC:
		if(disconnect_in)
			nextState = DISCONNECT_ERR;
		else if (BUFFER_DIN[1:0] == 2'b01)
			nextState = PRE_NULL;
		else if (BUFFER_DIN[1:0] == 2'b10)
			nextState = PRE_TIME;
		else
			nextState = ESC_ERR;
	PRE_NULL:
		if(disconnect_in)
			nextState = DISCONNECT_ERR;
		else if (BUFFER_DIN[1:0] == 2'b00)
			nextState = START;
		else
			nextState = ESC_ERR;
	PRE_TIME:
		if(disconnect_in)
			nextState = DISCONNECT_ERR;
		else if ((counter_cycle == 2'b00) & parity_error)
			nextState = PARITY_ERR;
		else if (counter_cycle == 2'b11)
			nextState = START;
		else
			nextState = PRE_TIME;
	DATA_AQ:
		if(disconnect_in)
			nextState = DISCONNECT_ERR;
		else if (counter_cycle == 2'b11)
			nextState = START;
		else
			nextState = DATA_AQ;
	default:
		nextState = state;
endcase
end

always @(posedge CLK_RX, negedge RESETn)
begin
	if(!RESETn)
		begin
		counter_start 	<= 4'd0;
		end
	else
		begin
		if(!enableRx)
			begin
			counter_start 	<= 4'd0;
			end
		else
			begin
			case(state)
				WAIT:
					if(gotBit)
						counter_start <= counter_start + 1'b1;
					else
						counter_start <= 4'd0;
				default:
					counter_start <= 4'd0;
			endcase
			end
		end
end

always @(negedge CLK_RX, negedge RESETn)
begin
	if(!RESETn)
		begin
		flag_data 		<= 1'b0;
		flag_timecode	<= 1'b0;
		flag_eep			<= 1'b0;
		flag_eop			<= 1'b0;
		flag_null		<= 1'b0;
		flag_fct			<= 1'b0;
		end
	else
		begin
		if(!enableRx)
			begin
			flag_data 		<= 1'b0;
			flag_timecode	<= 1'b0;
			flag_eep			<= 1'b0;
			flag_eop			<= 1'b0;
			flag_null		<= 1'b0;
			flag_fct			<= 1'b0;
			end
		else
			begin
			case (state)
				FIND_NULL:
					begin
						flag_data 		<= 1'b0;
						flag_timecode	<= 1'b0;
						flag_eep			<= 1'b0;
						flag_eop			<= 1'b0;
						flag_fct			<= 1'b0;
						if (STORE_REG[9:2] == 8'b01110100 | STORE_REG[10:3] == 8'b01110100)
							flag_null		<= 1'b1;
						else
							flag_null		<= 1'b0;
					end	
				PRE_TIME:
					begin
					flag_data 		<= 1'b0;
					flag_timecode	<= 1'b1;
					flag_eep			<= 1'b0;
					flag_eop			<= 1'b0;
					flag_null		<= 1'b0;
					flag_fct			<= 1'b0;
					end
				DATA_AQ:
					begin
					flag_data 		<= 1'b1;
					flag_timecode	<= 1'b0;
					flag_eep			<= 1'b0;
					flag_eop			<= 1'b0;
					flag_null		<= 1'b0;
					flag_fct			<= 1'b0;
					end
				PRE_NULL:
					begin
					flag_data 		<= 1'b0;
					flag_timecode	<= 1'b0;
					flag_eep			<= 1'b0;
					flag_eop			<= 1'b0;
					flag_null		<= 1'b1;
					flag_fct			<= 1'b0;
					end
				CONTROL_AQ:
					begin
					flag_data 		<= 1'b0;
					flag_null		<= 1'b0;
					flag_timecode	<= 1'b0;
					if(BUFFER_DIN[1:0] == 2'b00)
						begin
						flag_eep			<= 1'b0;
						flag_eop			<= 1'b0;
						flag_fct			<= 1'b1;
						end
					else if(BUFFER_DIN[1:0] == 2'b01)
						begin
						flag_eep			<= 1'b0;
						flag_eop			<= 1'b1;
						flag_fct			<= 1'b0;
						end
					else if(BUFFER_DIN[1:0] == 2'b10)
						begin
						flag_eep			<= 1'b1;
						flag_eop			<= 1'b0;
						flag_fct			<= 1'b0;
						end
					else
						begin
						flag_eep			<= 1'b0;
						flag_eop			<= 1'b0;
						flag_fct			<= 1'b0;
						end
					end
				default:
					begin
					flag_data 		<= flag_data;
					flag_timecode	<= flag_timecode;
					flag_eep			<= flag_eep;
					flag_eop			<= flag_eop;
					flag_null		<= flag_null;
					flag_fct			<= flag_fct;
					end
			endcase
		end
	end
end

always @(negedge CLK_RX, negedge RESETn)
begin
	if(!RESETn)
		begin
		parity_error <= 1'b0;
		end
	else 
		begin
		if (!enableRx)
			begin
			parity_error <= 1'b0;
			end
		else
			begin
			case(state)
				START:
				if(gotNULL)
					begin
						if(flag_null | flag_eep | flag_eop | flag_fct)
							parity_error <= !(^BUFFER_DIN[3:0]);
						else if(flag_data | flag_timecode)
							parity_error <= !(^BUFFER_DIN[9:0]);
						else
							parity_error <= 1'b0;
					end
				else
					parity_error <= 1'b0;
				default:
					parity_error <= 1'b0;
			endcase
			end
		end
end

always @(posedge CLK_RX, negedge RESETn)
begin
	if(!RESETn)
		begin
		counter_cycle 	<= 2'b00;
		rx_ready			<= 1'b0;
		rx_ready1 		<= 1'b0;
		end
	else
	begin
		if(!enableRx)
			begin
			counter_cycle 	<= 2'b00;
			rx_ready			<= 1'b0;
			rx_ready1 		<= 1'b0;
			end
		else
			begin
			rx_ready1			<= gotBit;
			rx_ready 		<= rx_ready1;
			case(state)
				PRE_TIME, DATA_AQ:
					counter_cycle <= counter_cycle + 1'b1;
				default:
					counter_cycle <= counter_cycle;
			endcase
			end
		end
end

always @(posedge CLK_RX, negedge RESETn)
begin
	if(!RESETn)
		begin
		gotData	<= 1'b0;
		gotEEP	<= 1'b0;
		gotEOP	<= 1'b0;
		gotFCT	<= 1'b0;
		gotTimeCode 	<= 1'b0;
		gotBit	<= 1'b0;
		end
	else
		begin
		if (!enableRx)
			begin
			gotData	<= 1'b0;
			gotEEP	<= 1'b0;
			gotEOP	<= 1'b0;
			gotFCT	<= 1'b0;
			gotTimeCode 	<= 1'b0;
			gotBit	<= 1'b0;
			end
		else
			begin
			case(state)
				START:
					begin
					if(flag_null | flag_eep | flag_eop | flag_fct)
						begin
						gotData	<= 1'b0;
						gotEEP	<= flag_eep & (^BUFFER_DIN[3:0]);
						gotEOP	<= flag_eop & (^BUFFER_DIN[3:0]);
						gotFCT	<= gotNULL & flag_fct & (^BUFFER_DIN[3:0]);
						gotTimeCode 	<= 1'b0;
						end
					else if(flag_data | flag_timecode)
						begin
						gotData	<= flag_data & (^BUFFER_DIN[9:0]);
						gotEEP	<= 1'b0;
						gotEOP	<= 1'b0;
						gotFCT	<= 1'b0;
						gotTimeCode 	<= gotNULL & flag_timecode & (^BUFFER_DIN[9:0]);
						end
					else
						begin
						gotData	<= 1'b0;
						gotEEP	<= 1'b0;
						gotEOP	<= 1'b0;
						gotFCT	<= 1'b0;
						gotTimeCode 	<= 1'b0;
						end
					end
				default:
					begin
					gotData	<= 1'b0;
					gotEEP	<= 1'b0;
					gotEOP	<= 1'b0;
					gotFCT	<= 1'b0;
					gotTimeCode 	<= 1'b0;
					end
			endcase
			
			gotBit <= 1'b1;
			end
		end
end

always @(posedge CLK_RX, negedge RESETn)
begin
	if(!RESETn)
		begin
		gotNULL_r	<= 1'b0;
		clock_edge  <= 1'b0;
		end
	else
		begin
		if (!enableRx)
			begin
			gotNULL_r	<= 1'b0;
			clock_edge  <= 1'b0;
			end
		else
			begin
			case(state)
			FIND_NULL:
					begin
					if (STORE_REG[9:1] == 9'b011101000)
						begin
						clock_edge <= 1'b0;
						gotNULL_r  <= 1'b1;
						end
					else if (STORE_REG[10:2] == 9'b011101000)
						begin
						clock_edge <= 1'b1;
						gotNULL_r  <= 1'b1;
						end
					else
						begin
						gotNULL_r  <= gotNULL_r;
						clock_edge <= clock_edge;
						end					
					end
				START:
					begin
					clock_edge <= clock_edge;
					
					if(flag_null | flag_eep | flag_eop | flag_fct)
						begin
						gotNULL_r	<= flag_null & (^BUFFER_DIN[3:0]);
						end
					else
						begin
						gotNULL_r	<= 1'b0;
						end
					end
				default:
					begin
					gotNULL_r	<= 1'b0;
					clock_edge <= clock_edge;
					end
			endcase
			end
		end	
end


always @(negedge CLK_RX, negedge RESETn)
begin
	if(!RESETn)
		begin
		RX_DATA 			<= 9'd0;
		TIME_OUT 		<= 8'd0;
		last_time_out 	<= 8'd0;
		end	
	else 
	begin
		if (!enableRx)
			begin
			RX_DATA 			<= 9'd0;
			TIME_OUT 		<= 8'd0;
			last_time_out 	<= 8'd0;
			end	
		else
			begin
			case(state)
				PRE_TIME:
					begin
					RX_DATA 		<= RX_DATA;
					if(counter_cycle == 2'd3)
						begin
						last_time_out <= TIME_OUT;
						
						TIME_OUT[0] 	<= BUFFER_DIN[7];
						TIME_OUT[1] 	<= BUFFER_DIN[6];
						TIME_OUT[2] 	<= BUFFER_DIN[5];
						TIME_OUT[3] 	<= BUFFER_DIN[4];
						TIME_OUT[4] 	<= BUFFER_DIN[3];
						TIME_OUT[5] 	<= BUFFER_DIN[2];
						TIME_OUT[6] 	<= BUFFER_DIN[1];
						TIME_OUT[7] 	<= BUFFER_DIN[0];
						end
					else
						begin
						TIME_OUT 	<= TIME_OUT;
						last_time_out <= last_time_out;
						end
					end
					
				DATA_AQ:
					begin
					TIME_OUT 		<= TIME_OUT;
					last_time_out  <= last_time_out;
					if(counter_cycle == 2'd3)
						begin
						RX_DATA[0] 	<= BUFFER_DIN[7];
						RX_DATA[1] 	<= BUFFER_DIN[6];
						RX_DATA[2] 	<= BUFFER_DIN[5];
						RX_DATA[3] 	<= BUFFER_DIN[4];
						RX_DATA[4] 	<= BUFFER_DIN[3];
						RX_DATA[5] 	<= BUFFER_DIN[2];
						RX_DATA[6] 	<= BUFFER_DIN[1];
						RX_DATA[7] 	<= BUFFER_DIN[0];
						RX_DATA[8] 	<= 1'b0;
						end		
					else
						RX_DATA 	<= RX_DATA;
					end
				CONTROL_AQ:
					begin
					TIME_OUT 		<= TIME_OUT;
					last_time_out <= last_time_out;
					if(BUFFER_DIN[1:0] == 2'b01) //EOP
						begin
						RX_DATA 	<= 9'b1_00000000;
						end		
					else if(BUFFER_DIN[1:0] == 2'b10) //EEP
						begin
						RX_DATA 	<= 9'b1_00000001;
						end	
					else
						RX_DATA 	<= RX_DATA;
					end
				DISCONNECT_ERR, PARITY_ERR, ESC_ERR:
					begin
						RX_DATA 	<= 9'b1_00000001; //EEP
					end
				default:
					begin
					RX_DATA 			<= RX_DATA;
					TIME_OUT 		<= TIME_OUT;
					last_time_out	<= last_time_out;
					end
			endcase
			end
		end
end

always @(posedge CLK_RX, negedge RESETn)
begin
	if(!RESETn)
		begin
		gotNULL <= 1'b0;
		end
	else 
		begin
		if (!enableRx)
			begin
			gotNULL <= 1'b0;
			end
		else
			begin
			if(!gotNULL)
				gotNULL <= gotNULL_r;
			else
				gotNULL <= gotNULL;
		end
	end
end


always @(posedge CLK_RX, negedge RESETn)
begin
	if(!RESETn)
		begin
		current_packet <= 1'b0;
		end
	else
	begin
	if (!enableRx)
		begin
		current_packet <= 1'b0;
		end
	else
		begin
			if(gotData)
				current_packet <= 1'b1;
			else if(gotEEP | gotEOP )
				current_packet <= 1'b0;
			else
				current_packet <= current_packet;
		end
	end
end

		

assign gotNChar = gotNULL & (gotData | gotEEP | gotEOP);
assign rxError = ((state == DISCONNECT_ERR) | (state == ESC_ERR) | (state == PARITY_ERR));
assign BUFFER_WRITE = (BUFFER_READY & (gotData | ((gotEEP | gotEOP | rxError)& current_packet)));


always @(posedge CLK_RX, negedge RESETn)
begin
	if(!RESETn)
		begin
		TICK_OUT <= 1'b0;
		end
	else 
	begin
		if (!enableRx)
			begin
			TICK_OUT <= 1'b0;
			end
		else	
			begin
				if(TIME_OUT[5:0] == (last_time_out[5:0]+1'b1))
					TICK_OUT <= gotTimeCode;
				else
					TICK_OUT <= 1'b0;
			end
		end
			
end
		
endmodule




module SpwTCR_RXTX_credit(
CLOCK,
RESETn,
enableRx,
gotNChar,
almost_full,
fifo_ready,
sendFctReq,
sendFctAck,
creditErr
);

input 			CLOCK;
input				RESETn;
input 			enableRx;
input 			gotNChar;
input 			almost_full;
input 			fifo_ready;
output reg 	sendFctReq;
input 			sendFctAck;
output reg 	creditErr;

reg [6:0]		credit_rx;

wire enableRx_fall;
reg enableRx_delay;
localparam [1:0]	FCT_WAIT 	= 2'b01,
						FCT_REQ 	= 2'b11,
						FCT_ACK 	= 2'b10;
reg [1:0] FctSt, NextFctSt;

always @(posedge CLOCK, negedge RESETn)
begin
	if(!RESETn)
		begin
		FctSt 		<= FCT_WAIT;
		end
	else
		begin
		if (enableRx_fall)
			begin
			FctSt 		<= FCT_WAIT;
			end
		else
			begin
			FctSt 		<= NextFctSt;
			end
		end
end

always @ (*)
begin
	case (FctSt)
		FCT_WAIT:
			begin
			if(credit_rx <= 7'd48 & !almost_full & fifo_ready & !sendFctAck)
				NextFctSt = FCT_REQ;
			else
				NextFctSt = FCT_WAIT;
			end
		FCT_REQ:
			begin
			if(sendFctAck)
				NextFctSt = FCT_ACK;
			else
				NextFctSt = FCT_REQ;
			end
		FCT_ACK:
			begin
			NextFctSt = FCT_WAIT;
			end
		default:
			begin
			NextFctSt = FctSt;
			end
	endcase
end

assign sendFctReq = (FctSt == FCT_REQ) ? 1'b1: 1'b0;

always @(posedge CLOCK, negedge RESETn)
begin
	if(!RESETn)
		begin
		credit_rx <= 7'd0;
		end
	else
		begin
		if (enableRx_fall)
			begin
			credit_rx <= 7'd0;
			end
		else
			begin
			if(gotNChar & (credit_rx != 7'd0))
				credit_rx <= credit_rx-1'b1;
			else if(!gotNChar & (FctSt == FCT_ACK))
				credit_rx <= credit_rx+7'd8;
			else if(gotNChar & (FctSt == FCT_ACK))
				credit_rx <= credit_rx+7'd7;
			else
				credit_rx <= credit_rx;
			end
		end
end

assign creditErr = (((gotNChar & credit_rx == 7'd0)) | (credit_rx > 7'd56));

always @(posedge CLOCK, negedge RESETn)
begin
	if(!RESETn)
		begin
		enableRx_delay 		<= 1'b0;
		end
	else
		begin
		enableRx_delay 		<= enableRx;
		end
end

assign enableRx_fall = !enableRx & enableRx_delay;
	
endmodule



module SpwTCR_RX_TIMEOUT (
CLOCK, 
RESETn,
enable, 
Din, 
Sin, 
disconnect
);

//parameter COUNTER_LIMIT = 189; // 950ns - 200Mhz (nominal 850ns, accept (727ns - 1000ns)
parameter COUNTER_LIMIT = 9'd179;
parameter COUNTER_WIDTH = 9;

input           CLOCK; 
input           RESETn; 
input           enable;
input           Din; 
input           Sin; 
output logic    disconnect;

logic [COUNTER_WIDTH-1:0] 	counter;

enum logic [1:0] {
	RESET 		= 2'b01,
	COUNT 		= 2'b11,
	DISCONNECT 	= 2'b10
	} 	state, nextState;
	

logic di_1, di_2;
logic si_1, si_2;

logic ds_edge;

always @(posedge CLOCK, negedge RESETn)
begin
	if (!RESETn)
		begin
		di_1 <= 1'b0;
    di_2 <= 1'b0;
    si_1 <= 1'b0;
    si_2 <= 1'b0;
		end
	else
		begin
		if(!enable)
			begin
			di_1 <= 1'b0;
			di_2 <= 1'b0;
			si_1 <= 1'b0;
			si_2 <= 1'b0;
			end
		else
			begin
			di_1 <= Din;
			di_2 <= di_1;

			si_1 <= Sin;
			si_2 <= si_1;
			end
		end
end
		
//assign ds_edge = (rx_clk_ff2 & !rx_clk_ff1) | (!rx_clk_ff2 & rx_clk_ff1) ;
assign ds_edge = (di_1 != di_2) | (si_1 != si_2);

always @(posedge CLOCK, negedge RESETn)
begin
	if (!RESETn)
		begin
		state <= RESET;
		end
	else
		begin
		if(!enable)
			begin
			state <= RESET;
			end
		else
			begin
			state <= nextState;
			end
		end
end

always @ (*)
begin
case (state)
	RESET:
		if(enable)
			nextState = COUNT;
		else
			nextState = RESET;
	COUNT:
		if(ds_edge | !enable)
			nextState = RESET;
		else if(counter == COUNTER_LIMIT)
			nextState = DISCONNECT;
		else
			nextState = COUNT;
	default:
		nextState = state;
endcase
end


always @(posedge CLOCK, negedge RESETn)
begin
	if (!RESETn)
		begin
		counter 		<= {COUNTER_WIDTH{1'b0}};
		end
  else
		begin
		if(!enable)
			begin
			counter 		<= {COUNTER_WIDTH{1'b0}};
			end
		else
			begin
			case (state)
				COUNT:
					counter 	<= counter + 1'b1;
				default:
					counter 	<= {COUNTER_WIDTH{1'b0}};
			endcase
			end
		end
end

assign disconnect = (state == DISCONNECT) ? 1'b1 : 1'b0;

endmodule





module SpwTCR_TX_FIFO(
input CLOCK, RESETn, data_req, we, 
input [8:0] data_i, 
output logic [8:0] data_o, 
output logic data_ack, full, empty
);

logic read_fifo;
logic write_fifo;
logic we_ff1;
logic we_ff2;
logic [8:0] data_i_sync;
enum logic [1:0] {
	DATA_WAIT 	= 2'b01,
	READ_DATA 	= 2'b11,
	DATA_READY 	= 2'b10
	} DataSt, NextDataSt;
always @(posedge CLOCK, negedge RESETn)
begin
if(!RESETn)
	begin
	DataSt <= DATA_WAIT;
	end
else
	begin
	DataSt <= NextDataSt;
	end
end 

always @ (*)
begin
case (DataSt)
	DATA_WAIT:
		begin
		if(data_req & !empty)
			NextDataSt = READ_DATA;
		else
			NextDataSt = DATA_WAIT;
		end
	READ_DATA:
		begin
			NextDataSt = DATA_READY;
		end
	DATA_READY:
		begin
		if(!data_req)
			NextDataSt = DATA_WAIT;
		else
			NextDataSt = DATA_READY;
		end
	default:
		NextDataSt = DataSt;
endcase
end

assign data_ack  = (DataSt == DATA_READY) ? 1'b1 : 1'b0;
assign read_fifo = (DataSt == READ_DATA)  ? 1'b1 : 1'b0;
	
always @(posedge CLOCK, negedge RESETn)
begin
if(!RESETn)
	begin
	we_ff1 <= 1'b0;
	we_ff2 <= 1'b0;
	data_i_sync <= 9'd0;
	end
else
	begin
	we_ff1 <= we;
	we_ff2 <= we_ff1;
	data_i_sync <= data_i;
	end
end 
assign write_fifo = !we_ff2 & we_ff1;
/*	
FIFO	FIFO_inst (
	.data (data_i_sync),
	.rdclk (CLOCK ),
	.rdreq (read_fifo ),
	.wrclk (CLOCK ),
	.wrreq (write_fifo),
	.q (data_o ),
	.rdempty (empty ),
	.rdusedw (  ),
	.wrfull (full ),
	.wrusedw (  )
	);
*/
FIFO	FIFO_inst (
	.data (data_i_sync),
	.rdclk (CLOCK ),
	.rd_rst_n(RESETn),
	.rdreq (read_fifo ),
	.wrclk (CLOCK ),
	.wr_rst_n(RESETn),
	.wrreq (write_fifo),
	.q (data_o ),
	.rdempty (empty),
	.rdusedw (  ),
	.wrfull (full),
	.wrusedw (  )
	);
endmodule



module SpwTCR_TX_CLOCK (
CLOCK,
RESETn,
TX_CLK_DIV,
startupRate,
CLK_EN
);

parameter STARTUP_DIV = 7'd19; //Divider that define 10mbps Initial Rate CLOCK /(STARTUP_DIV+1)=10
//parameter STARTUP_DIV = 7'd4;


input 			CLOCK;
input 			RESETn;
input [6:0] 	TX_CLK_DIV; //Clock Divider CLK_TX = CLOCK/(TX_CLK_DIV+1)
input				startupRate; // Enable Startup Rate of 10Mbps
output logic 			CLK_EN; // Pulse enable the goes to TX module and defines TX rate

logic [6:0] 	counter; // aux counter that defines divider, start from max value and decrement until zero

always @(posedge CLOCK, negedge RESETn)
begin
	if (!RESETn)
		begin
		counter <= 7'd0;
		CLK_EN  <= 1'b0;
		end
  else
		begin
		if(counter == 7'd0) //when counter is zero, update values of counter
			begin
			if(startupRate) // 10Mps startup rate
				begin
				counter <= STARTUP_DIV; //Initial counter Startup Rate
				end
			else
				begin
				counter <= TX_CLK_DIV; //Initial counter on Run State
				//counter <= STARTUP_DIV;
				end
			CLK_EN  <= 1'b1; // Generate a Pulse
			end
		else
			begin
			counter <= counter - 1'b1; // Decrements Counter
			CLK_EN  <= 1'b0;				// Pulse is disable until counter decrements, only in zero value CLK_EN = 1
			end
		end
end
endmodule





module SpwTCR_TX(
CLOCK,
RESETn,
CLK_EN,
resetTx,
enableTx,
sendNULLs,
sendFCTs,
sendNChars,
sendTimeCodes,
creditErr,
TICK_IN,
TIME_IN,
sendFctReq,
sendFctAck,
spillEnable,
gotFCT,
data_ack,
data,
data_req,
Dout,
Sout
);

input 			CLOCK;
input				RESETn;
input 			CLK_EN;
input 			resetTx;
input 			enableTx;
input 			sendNULLs;
input 			sendFCTs;
input 			sendNChars;
input 			sendTimeCodes;
output logic    creditErr;
input 			TICK_IN;
input [7:0]		TIME_IN;
input 			sendFctReq;
output logic 	sendFctAck;
input 			spillEnable;
input 			gotFCT; 
input 			data_ack;
input [8:0] 	data;
output logic 			data_req;
output logic 			Dout;
output logic 			Sout;
		
enum logic [8:0] {
	CHAR_START 			= 9'b000000001, //State after reset
	CHAR_FCT 			= 9'b000000010, // FCT char
	CHAR_EOP 			= 9'b000000100, // EOP char
	CHAR_FCT_NULL 		= 9'b000001000, // FCT part of NULL (ESC+FCT)
	CHAR_EEP 			= 9'b000010000, // EOP char
	CHAR_ESC_TIME 		= 9'b000100000, // ESC part of Timecode (ESC+DATA)
	CHAR_ESC_NULL 		= 9'b001000000, // ESC part of NULL (ESC+FCT)
	CHAR_DATA 			= 9'b010000000, // DATA char
	CHAR_TIME 			= 9'b100000000  // DATA part of Timecode (ESC+DATA)
} State, NextState;

enum logic [2:0] {
	DATA_WAIT 			= 3'b001,
	DATA_READY 			= 3'b011,
	DATA_SPILL			= 3'b010,
	DATA_SPILL_OFF 	= 3'b000,
	DATA_STORE 			= 3'b100
	} DataSt, NextDataSt;

enum logic [1:0] {
	SPILL_CHECK 			= 2'b01,
	SPILL_RUN 			= 2'b11,
	SPILL_OFF			= 2'b10
	} SpillSt;
	
logic 			tick_in_w;
logic [8:0] 	data_reg;
logic [7:0] 	timecode_reg;
logic [3:0] 	counter_data;  //defines cycles of DATA
logic [1:0]		counter_s;		//defines cycles of "4" bits characters
logic [6:0] 	credit_tx;
logic 			first_cycle;
logic				second_cycle;
logic 		 	w_shif_reg;
logic [7:0] 	data_shif_reg;
logic [1:0]		control_shift_reg;
logic 			pre_parity;
logic [1:0] 	w_parity_control;
logic 			txEnabled;
logic 			firstFCT;
logic 			tick_in_rise;
logic 			tick_in_ff1;
logic 			tick_in_ff2;
logic 			current_packet;
logic				spill;
logic				resetTx_delay;	//reset delay only for Sout
enum logic [1:0] {
	FCT_WAIT 	= 2'b01,
	FCT_REQ 	= 2'b11,
	FCT_ACK 	= 2'b10
	} 	FctSt, NextFctSt;

logic gotFCT_1;
logic gotFCT_2;
logic gotFCT_rise;

assign txEnabled = enableTx & CLK_EN;

always @(posedge CLOCK)
begin
if(!resetTx)
	begin
	resetTx_delay <= 1'b0;
	end
else
	begin
	resetTx_delay <= 1'b1;
	end
end 


always @(posedge CLOCK, negedge resetTx)
begin
if(!resetTx)
	begin
	DataSt <= DATA_WAIT;
	end
else if(enableTx)
	begin
	DataSt <= NextDataSt;
	end
end 

always @ (*)
begin
case (DataSt)
	DATA_WAIT:
		begin
		if(data_ack & !spill)
			NextDataSt = DATA_STORE;
		else if(data_ack & spill)
			NextDataSt = DATA_SPILL;
		else
			NextDataSt = DATA_WAIT;
		end
	DATA_SPILL:
		begin
		if(data[8]==1'b1 & (data[0]==1'b1 | data[0]==1'b0))
			NextDataSt = DATA_SPILL_OFF;
		else
			NextDataSt = DATA_WAIT;
		end
	DATA_SPILL_OFF:
		begin
		NextDataSt = DATA_WAIT;
		end
	DATA_STORE:
		begin
		NextDataSt = DATA_READY;
		end
	DATA_READY:
		begin
		if((State == CHAR_DATA | State == CHAR_EOP | State == CHAR_EEP) & first_cycle)
			NextDataSt = DATA_WAIT;
		else
			NextDataSt = DataSt;
		end
	default:
		NextDataSt = DataSt;
endcase
end

assign data_req = (DataSt == DATA_WAIT) ? 1'b1 : 1'b0;

always @(posedge CLOCK, negedge resetTx)
begin
if(!resetTx)
	begin
	data_reg 			<= 9'd0;
	end
else if(enableTx)
	begin
	case (DataSt)
	DATA_STORE:
		begin
		data_reg 	<= data;
		end
	default:
		begin
		data_reg		<= data_reg;
		end
endcase
	end
end

//====================================================
// timecode_reg store timecode from input port in the rise of tick_in signal
always @(posedge CLOCK, negedge resetTx)
begin
if(!resetTx)
	begin
   timecode_reg 	<= 8'd0;
	end
else if(enableTx)
	begin
	if(tick_in_rise)	
		timecode_reg 	<= TIME_IN;
	else
		timecode_reg 	<= timecode_reg;
	end
end

//====================================================
// timecode_reg store timecode from input port in the rise of tick_in signal
always @(posedge CLOCK, negedge resetTx)
begin
if(!resetTx)
	begin
	counter_data 	<= 4'd0;
	counter_s 		<= 2'd0;
	second_cycle 	<= 1'b0;
	end
else if(txEnabled)
	begin
	second_cycle 	<= first_cycle;
	case (State)
		CHAR_DATA, CHAR_TIME:
			begin
			if(counter_data == 4'd9)
				counter_data 	<= 4'd0;
			else	
				counter_data 	<= counter_data + 1'b1;
			counter_s 		<= 2'd0;
			end
			
		CHAR_START:
			begin
			counter_data 	<= 4'd0;
			counter_s 		<= 2'd0;
			end
		default:
			begin
			counter_data 	<= 4'd0;
			counter_s 		<= counter_s + 1'b1;
			end
	endcase
	end
end


always @(posedge CLOCK, negedge resetTx)
begin
if(!resetTx)
	begin
	data_shif_reg <= 8'd0;
	end
else if(txEnabled)
	begin
	case (State)
		CHAR_ESC_TIME:
			begin
			data_shif_reg <= timecode_reg;
			end
		CHAR_DATA:
			if(counter_data == 4'd0)
				data_shif_reg <= data_reg[7:0];
			else if (counter_data > 4'd1)
				data_shif_reg <= data_shif_reg >> 1;
			else
				data_shif_reg <= data_shif_reg;
		CHAR_TIME:
			if (counter_data > 4'd1)
				data_shif_reg <= data_shif_reg >> 1;
			else
				data_shif_reg <= data_shif_reg;
		default:
				data_shif_reg <= data_reg[7:0];
	endcase
	end
end

always @(posedge CLOCK, negedge resetTx)
begin
if(!resetTx)
	begin
	pre_parity <= 1'b0;
	end
else if(txEnabled)
	begin
	if(second_cycle)
		begin
		case (State)
			CHAR_DATA, CHAR_TIME:
				begin
				pre_parity <= ^data_shif_reg;
				end
			CHAR_EEP, CHAR_EOP:
				begin
				pre_parity <= 1'b1;
				end
			default: //ESC or FCT
				pre_parity <= 1'b0;
		endcase
		end
	end
end


always @(posedge CLOCK, negedge resetTx)
begin
if(!resetTx)
	begin
	control_shift_reg <= 2'b00;
	end
else if(txEnabled)
	begin
		if(counter_s == 2'd0)
		begin
			case (State)
				CHAR_ESC_NULL, CHAR_ESC_TIME:
					control_shift_reg <= 2'b11;
				CHAR_FCT, CHAR_FCT_NULL:
					control_shift_reg <= 2'b00;
				CHAR_EEP:
					control_shift_reg <= 2'b10;
				CHAR_EOP:
					control_shift_reg <= 2'b01;
				default: //	CHAR_ESC_NULL, CHAR_ESC_TIME;
					control_shift_reg <= control_shift_reg;
			endcase
		end
		else if (counter_s == 2'd2)
		begin
			control_shift_reg <= control_shift_reg << 1;
		end
		else
		begin
			control_shift_reg <= control_shift_reg;
		end
	end
end

always @ (*)
begin
case (State)
	CHAR_DATA, CHAR_TIME:
		w_shif_reg = data_shif_reg[0];
	default: //	CHAR_ESC_NULL, CHAR_ESC_TIME;
		w_shif_reg = control_shift_reg[1];
endcase
end

always @(posedge CLOCK, negedge resetTx)
begin
if(!resetTx)
	begin
	State <= CHAR_START;
	end
else if(txEnabled)
	begin
	State <= NextState;
	end
end

always @ (*)
begin
	case (State)
		CHAR_START:
			if(sendNULLs)
				NextState = CHAR_ESC_NULL;
			else
				NextState = CHAR_START;
		CHAR_FCT_NULL:
			if(counter_s < 2'd3)
				NextState = CHAR_FCT_NULL;
			else if(tick_in_w & sendTimeCodes & firstFCT) 
				NextState = CHAR_ESC_TIME;
			else if (sendFCTs &  (FctSt == FCT_REQ))
				NextState = CHAR_FCT;
			else if(!firstFCT)
				NextState = CHAR_ESC_NULL;
			else if (sendNChars & data_reg[8]==1'b0 & (DataSt == DATA_READY) & credit_tx > 7'd0)
				NextState = CHAR_DATA;
			else if (sendNChars & {data_reg[8],data_reg[0]}==2'b10 & (DataSt == DATA_READY) & credit_tx > 7'd0)
				NextState = CHAR_EOP;
			else if (sendNChars & {data_reg[8],data_reg[0]}==2'b11 & (DataSt == DATA_READY) & credit_tx > 7'd0)
				NextState = CHAR_EEP;	
			else if (sendNULLs)
				NextState = CHAR_ESC_NULL;
			else
				NextState = CHAR_START;
		CHAR_EOP, CHAR_EEP, CHAR_FCT:
			if(counter_s < 2'd3)
				NextState = State;
			else if(tick_in_w & sendTimeCodes) 
				NextState = CHAR_ESC_TIME;
			else if (sendFCTs &  (FctSt == FCT_REQ))
				NextState = CHAR_FCT;
			else if (sendNChars & data_reg[8]==1'b0 & (DataSt == DATA_READY) & credit_tx > 7'd0)
				NextState = CHAR_DATA;
			else if (sendNChars & {data_reg[8],data_reg[0]}==2'b10 & (DataSt == DATA_READY) & credit_tx > 7'd0)
				NextState = CHAR_EOP;
			else if (sendNChars & {data_reg[8],data_reg[0]}==2'b11 & (DataSt == DATA_READY) & credit_tx > 7'd0)
				NextState = CHAR_EEP;	
			else if (sendNULLs)
				NextState = CHAR_ESC_NULL;
			else
				NextState = CHAR_START;
		CHAR_DATA, CHAR_TIME:
			if(counter_data < 4'd9)
				NextState = State;
			else if(tick_in_w)
				NextState = CHAR_ESC_TIME;
			else if (sendFCTs &  (FctSt == FCT_REQ))
				NextState = CHAR_FCT;
			else if (sendNChars & data_reg[8]==1'b0 & (DataSt == DATA_READY) & credit_tx > 7'd0)
				NextState = CHAR_DATA;
			else if (sendNChars & {data_reg[8],data_reg[0]}==2'b10 & (DataSt == DATA_READY) & credit_tx > 7'd0)
				NextState = CHAR_EOP;
			else if (sendNChars & {data_reg[8],data_reg[0]}==2'b11 & (DataSt == DATA_READY) & credit_tx > 7'd0)
				NextState = CHAR_EEP;	
			else if (sendNULLs)
				NextState = CHAR_ESC_NULL;
			else
				NextState = CHAR_START;
		CHAR_ESC_TIME:
			if(counter_s == 2'd3)
				NextState = CHAR_TIME;
			else
				NextState = CHAR_ESC_TIME;
		CHAR_ESC_NULL:
			if(counter_s ==  2'd3)
				NextState = CHAR_FCT_NULL;
			else
				NextState = CHAR_ESC_NULL;
		default:
				NextState = State;
			
	endcase
end

always @ (*)
begin
case (State)
	CHAR_DATA, CHAR_TIME:
		w_parity_control = {1'b0, ~(pre_parity ^ 1'b0)};
	default: //	CHAR_ESC_NULL, CHAR_ESC_TIME;
		w_parity_control = {1'b1, ~(pre_parity ^ 1'b1)};
endcase
end

always @(posedge CLOCK, negedge resetTx)
begin
if(!resetTx)
	begin
		Dout <= 1'b0;
	end
else if(txEnabled)	
begin
		case (State)
			CHAR_START:
				begin
				Dout <= 1'b0;
				end
			default:
				begin
				if(first_cycle)
					begin
					Dout <= w_parity_control[0];
					end
				else if (second_cycle)
					begin
					Dout <= w_parity_control[1];
					end
				else
					begin
					Dout <= w_shif_reg;
					end
				end
		endcase	
end
end

always @(posedge CLOCK)
begin
if(!resetTx_delay)
	begin
		Sout <= 1'b0;
	end
else if(txEnabled)	
begin
		case (State)
			CHAR_START:
				begin
				Sout <= 1'b0;
				end
			default:
				begin
				if(first_cycle)
					begin
					if(Dout == w_parity_control[0])
						Sout <= ~Sout;
					else
						Sout <= Sout;
					end
				else if (second_cycle)
					begin
					if(Dout == w_parity_control[1])
						Sout <= ~Sout;
					else
						Sout <= Sout;
					end
				else
					begin
					if(Dout == w_shif_reg)
						Sout <= ~Sout;
					else
						Sout <= Sout;
					end
				end
		endcase	
end
end


assign first_cycle = ((counter_s == 0 & (State !=	CHAR_TIME & State != CHAR_DATA)) | (counter_data==0 & (State ==	CHAR_TIME | State == CHAR_DATA))) ? 1'b1 : 1'b0;

always @(posedge CLOCK, negedge resetTx)
begin
	if(!resetTx)
		begin
		FctSt 		<= FCT_WAIT;
		end
	else if (enableTx)
		begin
		FctSt 		<= NextFctSt;
		end
end

always @ (*)
begin
	case (FctSt)
		FCT_WAIT:
			begin
			if(sendFctReq)
				NextFctSt = FCT_REQ;
			else
				NextFctSt = FCT_WAIT;
			end
		FCT_REQ:
			begin
			if((State == CHAR_FCT) & first_cycle)
				NextFctSt = FCT_ACK;
			else
				NextFctSt = FCT_REQ;
			end
		FCT_ACK:
			begin
			if(!sendFctReq)
				NextFctSt = FCT_WAIT;
			else
				NextFctSt = FCT_ACK;
			end
		default:
			begin
			NextFctSt = FctSt;
			end
	endcase
end

assign sendFctAck = (FctSt == FCT_ACK) ? 1'b1: 1'b0;


//credit Tx
always @(posedge CLOCK, negedge resetTx)
begin
	if(!resetTx)
		begin
		gotFCT_1 		<= 1'b0;
        gotFCT_2 		<= 1'b0;
        gotFCT_rise 	<= 1'b0;
		end
	else if (enableTx)
		begin
        gotFCT_1 		<= gotFCT;
        gotFCT_2 		<= gotFCT_1 ;
        gotFCT_rise 	<= !gotFCT_2 & gotFCT_1;
		end
end

always @(posedge CLOCK, negedge resetTx)
begin
	if(!resetTx)
		begin
		credit_tx 		<= 7'd0;
		end
	else if (enableTx)
		begin
        if(((State == CHAR_DATA | State == CHAR_EOP | State == CHAR_EEP)& first_cycle) & !gotFCT_rise)
		    credit_tx 		<= credit_tx - 1'b1;
        else if(((State == CHAR_DATA | State == CHAR_EOP | State == CHAR_EEP)& first_cycle) & gotFCT_rise)
            credit_tx 		<= credit_tx + 7'd7;
        else if(!((State == CHAR_DATA | State == CHAR_EOP | State == CHAR_EEP)& first_cycle) & gotFCT_rise)
            credit_tx 		<= credit_tx + 7'd8;
        else
            credit_tx 		<= credit_tx;
		end
end

assign creditErr = (credit_tx > 7'd56) ? 1'b1: 1'b0;



always @(posedge CLOCK, negedge resetTx)
begin
	if(!resetTx)
		begin
		firstFCT <= 1'b0;
		end
	else if (enableTx)
	begin
		if(!firstFCT & (State == CHAR_FCT))
			firstFCT <= 1'b1;
		else
			firstFCT <= firstFCT;
	end
end

always @(posedge CLOCK, negedge resetTx)
begin
	if(!resetTx)
		begin
		  tick_in_ff1 		<= 1'b0;
        tick_in_ff2 		<= 1'b0;
		end
	else if (enableTx)
		begin
        tick_in_ff1 		<= TICK_IN;
        tick_in_ff2 		<= tick_in_ff1;
		end
end

assign tick_in_rise = tick_in_ff1 & !tick_in_ff2;

always @(posedge CLOCK, negedge resetTx)
begin
	if(!resetTx)
		begin
		  tick_in_w <= 1'b0;
		end
	else if (enableTx)
		begin
			if(tick_in_rise)
				tick_in_w <= 1'b1;
			else if((State == CHAR_ESC_TIME) & first_cycle)
				tick_in_w <= 1'b0;
			else
				tick_in_w <= tick_in_w;	

		end
end

always @(posedge CLOCK, negedge RESETn)
begin
	if(!RESETn)
		begin
		current_packet <= 1'b0;
		end
	else if (enableTx)
	begin
		if((State == CHAR_DATA) & first_cycle) //First CHAR_DATA sent
			current_packet <= 1'b1;
		else if((State == CHAR_EOP | State == CHAR_EEP)& (counter_s == 2'd3)) //last cycle of EOP/EEP
			current_packet <= 1'b0;
		else
			current_packet <= current_packet;
	end
end

always @(posedge CLOCK, negedge resetTx)
begin
	if(!resetTx)
		begin
		  SpillSt <= SPILL_CHECK;
		end
	else if (enableTx)
		begin
		case (SpillSt)
		  SPILL_CHECK:
		  begin
		    if(spillEnable & current_packet)
		      SpillSt <= SPILL_RUN;
		    else
		      SpillSt <= SPILL_OFF;
		    end
		   SPILL_RUN:
		   begin
		     if(DataSt == DATA_SPILL_OFF)
		       SpillSt <= SPILL_OFF;
		    else
		      SpillSt <= SPILL_RUN;
		    end
		  default:
		    begin
		    SpillSt <= SPILL_OFF;
		    end
		   endcase
		end
end
assign spill = (SpillSt == SPILL_RUN) ? 1'b1 : 1'b0;

endmodule
