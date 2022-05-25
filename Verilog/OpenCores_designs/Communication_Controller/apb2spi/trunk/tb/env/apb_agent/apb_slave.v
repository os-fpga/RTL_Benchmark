`timescale 1ns/1ps

module apb_slave(input [3:0] paddr,
		input pwrite,
		input [1:0] psel,
		input penable,
		output reg pready,
		input [31:0] pwdata,
		output reg [31:0] prdata,
		input pclk,
		input presetn);

		reg [31:0] spcr,spdr,wr_data;
		
		always@(posedge pclk or negedge presetn)
		if(!presetn)
			pready <= 1'b0;
		else if(penable==1'b1)	
			pready <= 1'b1;

		always@(posedge pclk or negedge presetn)
		if(!presetn)
			spcr <= 32'h0;
		else if(psel==2'b01 && pready && penable && pwrite && paddr==4'b0001)
			spcr <= pwdata;

		always@(posedge pclk or negedge presetn)
		if(!presetn)
			spdr <= 32'h0;
		else if(psel==2'b01 && pready && penable && pwrite && paddr==4'b0010)
			spdr <= pwdata;

		always@(posedge pclk or negedge presetn)
		if(!presetn)
			wr_data <= 32'h0;
		else if(psel==2'b01 && pready && penable && pwrite && paddr==4'b0011)
			wr_data <= pwdata;

		always@(posedge pclk or negedge presetn)
		if(!presetn)
			prdata <= 32'h0;
		else if(psel==2'b01 && pready && penable && !pwrite && paddr==4'b0001)
			prdata <= spcr;
		else if(psel==2'b01 && pready && penable && !pwrite && paddr==4'b0010)
			prdata <= spdr;
		else if(psel==2'b01 && pready && penable && !pwrite && paddr==4'b0011)
			prdata <= wr_data;

endmodule
		
