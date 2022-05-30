/*
	Name:	Felipe Fernandes da Costa
	
*/

`timescale 1ns/1ns

module UART(

	   input CLK,
	   input RESET,
	   input RX,

	   input START,
	   input [7:0] DATA_TX,

	   input [11:0] WORK_FR,
		
	   output TX,
	   output [7:0] DATA_RX,
	   output PARITY_RX,
		
	   output READY_TX,
	   output READY
		
	  );


	uart_rx RX0 (
			.PCLK(CLK),
			.RESET(RESET),
			.RX_I(RX),
			.DATA_RX_O(DATA_RX),
			.WORK_FR(WORK_FR),
			.READY(READY),
			.PARITY_RX(PARITY_RX)
		      );


	uart_tx TX0 (
			.PCLK(CLK),
			.RESET(RESET),
			.START(START),
			.WORK_FR(WORK_FR),
			.DATA_TX_I(DATA_TX),
			.READY_TX(READY_TX),
			.TX_O(TX)
		    );

endmodule
