/*
//=================================================================//
//=
//= 	SpwTCR
//=
//=	Author: Tiago da Costa Rodrigues
//=	E-Mail: tiagofee@gmail.com
//=	Licence: LGPL
//=
//=	Description: TOP module with submodules connections.
//=
//=   
//=	
//=	Version History:
//=	0.1: 10/01/2016 - First Version
//=
//=================================================================//
*/
module SPW_TOP(
CLOCK,
RESETn,
LINK_START,
LINK_DISABLE,
AUTOSTART,
CURRENTSTATE,
FLAGS,
DATA_I,
WR_DATA,
TX_FULL,
DATA_O,
RD_DATA,
RX_EMPTY,
TICK_OUT,
TIME_OUT,
TICK_IN,
TIME_IN,
TX_CLK_DIV,
SPILL_ENABLE,
Din, 
Sin,
Dout,
Sout
);



//control Interface
input  					CLOCK;
input  					RESETn;
input  					LINK_START;
input  					LINK_DISABLE;
input  					AUTOSTART;
output logic [2:0] 	CURRENTSTATE;
output logic [10:0]	FLAGS;
input  		 [8:0]	DATA_I;
input 					WR_DATA;
output logic			TX_FULL;
output logic [8:0]	DATA_O;
input 					RD_DATA;
output logic			RX_EMPTY;
input 					Din;
input 					Sin;
output logic 			TICK_OUT;
output logic [7:0] 	TIME_OUT;
output logic 			Dout;
output logic 			Sout;
input 					TICK_IN;
input 		 [7:0]	TIME_IN;
input 		 [6:0]	TX_CLK_DIV;
input						SPILL_ENABLE;

//Wires
logic 			resetTx_w;
logic 			enableTx_w;
logic 			sendNULLs_w;
logic 			sendFCTs_w;
logic 			sendNChars_w;
logic 			sendTimeCodes_w;
logic 			startupRate_w;
logic 			resetRx_w;
logic  			enableRx_w;
logic  			gotBit_w;
logic  			gotFCT_w;
logic  			gotNChar_w; 
logic  			gotTimeCode_w; 
logic  			gotNULL_w;
logic  			creditError_w;
logic  			rxError_w;
logic 			gotData_w;
logic 			gotEEP_w;
logic 			gotEOP_w;
logic 			creditErr_w;
logic 			creditError_tx_w;
logic 			creditError_rx_w;
logic 			rx_fifo_empty_w;
logic 			rx_fifo_full_w;
logic 			rx_fifo_read_w;
logic 			rx_fifo_write_w;
logic 			tx_fifo_empty_w;
logic 			tx_fifo_full_w;
logic 			tx_fifo_read_w;
logic 			tx_fifo_write_w;
logic 			tx_clock_en_w;
logic				clk_rx_w;
logic 			enableTimer_w;
logic 			after128_w;
logic 			after64_w;
logic				sendFctReq_w;
logic 			sendFctAck_w;
logic				almost_full_w;
logic [8:0]		rx_fifo_data_i_w;
logic [8:0]		rx_fifo_data_o_w;
logic [8:0]		tx_fifo_data_i_w;
logic [8:0]		tx_fifo_data_o_w;
logic 			data_req_w;
logic 			data_ack_w;

//Assignments
assign TX_FULL 	= tx_fifo_full_w;
assign RX_EMPTY 	= rx_fifo_empty_w;
//Error handle
assign FLAGS = {rxError_w, creditError_tx_w, creditError_rx_w, gotTimeCode_w, gotFCT_w, gotData_w, gotEEP_w, gotEOP_w, gotNChar_w, gotNULL_w, gotBit_w};

assign creditError_w = creditError_tx_w | creditError_rx_w;
SpwTCR_FSM FSM( 

	  .CLOCK(CLOCK),
	  .RESETn(RESETn),
	  .LINK_START(LINK_START),
	  .LINK_DISABLE(LINK_DISABLE),
	  .AUTOSTART(AUTOSTART),
	  .CURRENTSTATE(CURRENTSTATE),
	  .after128(after128_w),
	  .after64(after64_w),
	  .enableTimer(enableTimer_w),
	  .resetTx(resetTx_w),
	  .enableTx(enableTx_w),
	  .sendNULLs(sendNULLs_w),
	  .sendFCTs(sendFCTs_w),
	  .sendNChars(sendNChars_w),
	  .sendTimeCodes(sendTimeCodes_w),
	  .startupRate(startupRate_w),
	  .resetRx(resetRx_w),
	  .enableRx(enableRx_w),
	  .gotFCT(gotFCT_w), 
	  .gotNChar(gotNChar_w), 
	  .gotTimeCode(gotTimeCode_w), 
	  .gotNULL(gotNULL_w), 
	  .creditError(creditError_w),
	  .rxError(rxError_w)
  );

SpwTCR_FSM_TIMER FSM_TIMER(
.CLOCK(CLOCK),
.RESETn(RESETn),
.enableTimer(enableTimer_w),
.after128(after128_w),
.after64(after64_w)
);
 
SpwTCR_RX_CLOCK_RECOVER RX_CLOCK_RECOVER(
.Din(Din), 
.Sin(Sin), 
.clk_rx(clk_rx_w)
);

SpwTCR_RX_FIFO RX_FIFO(
.clk(CLOCK),
.RESETn(RESETn),
.data_req(RD_DATA), 
.we(rx_fifo_write_w),
.data_i(rx_fifo_data_i_w), 
.data_o(DATA_O),
.full(rx_fifo_full_w), 
.almost_full(almost_full_w),
.empty(rx_fifo_empty_w)
);


SpwTCR_RX RX(
.Din(Din), 
.Sin(Sin),
.CLK_RX(clk_rx_w),
.CLOCK(CLOCK),
.RESETn(RESETn & resetRx_w),
.TICK_OUT(TICK_OUT),
.TIME_OUT(TIME_OUT),
.RX_DATA(rx_fifo_data_i_w),
.BUFFER_WRITE(rx_fifo_write_w),
.BUFFER_READY(!rx_fifo_full_w),
.almost_full(almost_full_w),
.enableRx(enableRx_w),
.gotBit(gotBit_w),
.gotFCT(gotFCT_w), 
.gotNChar(gotNChar_w), 
.gotTimeCode(gotTimeCode_w), 
.gotNULL(gotNULL_w),
.gotData(gotData_w),
.gotEEP(gotEEP_w),
.gotEOP(gotEOP_w),
.creditErr(creditError_rx_w),
.rxError(rxError_w),
.sendFctReq(sendFctReq_w),
.sendFctAck(sendFctAck_w)
);

SpwTCR_TX_FIFO TX_FIFO(
.CLOCK(CLOCK),
.RESETn(RESETn),
.data_req(data_req_w), 
.we(WR_DATA), .data_i(DATA_I), 
.data_o(tx_fifo_data_o_w), 
.data_ack(data_ack_w), 
.full(tx_fifo_full_w), 
.empty(tx_fifo_empty_w)
);


SpwTCR_TX_CLOCK TX_CLOCK (
.CLOCK(CLOCK),
.RESETn(RESETn),
.TX_CLK_DIV(TX_CLK_DIV),
.startupRate(startupRate_w),
.CLK_EN(tx_clock_en_w)
);	


SpwTCR_TX TX(
.CLOCK(CLOCK),
.RESETn(RESETn),
.CLK_EN(tx_clock_en_w),
.resetTx(RESETn & resetTx_w),
.enableTx(enableTx_w),
.sendNULLs(sendNULLs_w),
.sendFCTs(sendFCTs_w),
.sendNChars(sendNChars_w),
.sendTimeCodes(sendTimeCodes_w),
.creditErr(creditError_tx_w),
.TICK_IN(TICK_IN),
.TIME_IN(TIME_IN),
.sendFctReq(sendFctReq_w),
.sendFctAck(sendFctAck_w),
.spillEnable(SPILL_ENABLE),
.gotFCT(gotFCT_w),
.data_ack(data_ack_w),
.data(tx_fifo_data_o_w),
.data_req(data_req_w),
.Dout(Dout),
.Sout(Sout)
);

endmodule
