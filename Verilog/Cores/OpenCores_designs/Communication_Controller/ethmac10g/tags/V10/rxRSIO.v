`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:    09:22:59 12/22/05
// Design Name:    
// Module Name:    rxRSIO
// Project Name:   
// Target Device:  
// Tool versions:  
// Description:
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////
`define START  8'hdf
`define PREAMBLE 8'h55
`define SEQUENCE 8'h59

module rxRSIO(rxclk_2x, reset, rxd, rxc, rxd64, rxc8, local_fault, remote_fault);
    input rxclk_2x;
	 input reset;
    input [0:31] rxd;
    input [0:3] rxc;			 
    output [63:0] rxd64;
    output [7:0] rxc8;
	 output local_fault;
	 output remote_fault;

	 parameter TP =1;

	 wire local_fault, remote_fault;
	 wire get_align, get_seq;

	 assign get_align = ((rxd[0:7]==`START) & rxc[0]) & ((rxd[8:15]==`PREAMBLE) & ~rxc[1]);
    assign get_seq = (rxd[0:7] == `SEQUENCE) & (rxd[8:29] == 0) & (rxc[0:3]== 4'h8) & rxd[31];
    assign local_fault = get_seq & ~rxd[30];
    assign remote_fault = get_seq & rxd[30];

	 reg ddr_read_en;
	 always@(posedge rxclk_2x or posedge reset) begin
	       if (reset)
			    ddr_read_en<=#TP 0;
			 else if (get_align)
			    ddr_read_en <=#TP 0;
			 else
			    ddr_read_en<=#TP ~ddr_read_en;
	 end

//rxd ddr io registers
FDCE rxd64_0 (.Q(rxd64[0]), .C(rxclk_2x), .CE(~ddr_read_en), .CLR(reset), .D(rxd[7]));    defparam rxd64_0.INIT = 1'b0;
FDCE rxd64_1 (.Q(rxd64[1]), .C(rxclk_2x), .CE(~ddr_read_en), .CLR(reset), .D(rxd[6]));	   defparam rxd64_1.INIT = 1'b0;
FDCE rxd64_2 (.Q(rxd64[2]), .C(rxclk_2x), .CE(~ddr_read_en), .CLR(reset), .D(rxd[5]));		defparam rxd64_2.INIT = 1'b0;
FDCE rxd64_3 (.Q(rxd64[3]), .C(rxclk_2x), .CE(~ddr_read_en), .CLR(reset), .D(rxd[4]));		defparam rxd64_3.INIT = 1'b0;
FDCE rxd64_4 (.Q(rxd64[4]), .C(rxclk_2x), .CE(~ddr_read_en), .CLR(reset), .D(rxd[3]));		defparam rxd64_4.INIT = 1'b0;
FDCE rxd64_5 (.Q(rxd64[5]), .C(rxclk_2x), .CE(~ddr_read_en), .CLR(reset), .D(rxd[2]));		defparam rxd64_5.INIT = 1'b0;
FDCE rxd64_6 (.Q(rxd64[6]), .C(rxclk_2x), .CE(~ddr_read_en), .CLR(reset), .D(rxd[1]));		defparam rxd64_6.INIT = 1'b0;
FDCE rxd64_7 (.Q(rxd64[7]), .C(rxclk_2x), .CE(~ddr_read_en), .CLR(reset), .D(rxd[0]));		defparam rxd64_7.INIT = 1'b0;
FDCE rxd64_8 (.Q(rxd64[8]), .C(rxclk_2x), .CE(~ddr_read_en), .CLR(reset), .D(rxd[15]));	defparam rxd64_8.INIT = 1'b0;
FDCE rxd64_9 (.Q(rxd64[9]), .C(rxclk_2x), .CE(~ddr_read_en), .CLR(reset), .D(rxd[14]));	defparam rxd64_9.INIT = 1'b0;
FDCE rxd64_10 (.Q(rxd64[10]), .C(rxclk_2x), .CE(~ddr_read_en), .CLR(reset), .D(rxd[13]));	defparam rxd64_10.INIT = 1'b0;
FDCE rxd64_11 (.Q(rxd64[11]), .C(rxclk_2x), .CE(~ddr_read_en), .CLR(reset), .D(rxd[12]));	defparam rxd64_11.INIT = 1'b0;
FDCE rxd64_12 (.Q(rxd64[12]), .C(rxclk_2x), .CE(~ddr_read_en), .CLR(reset), .D(rxd[11]));	defparam rxd64_12.INIT = 1'b0;
FDCE rxd64_13 (.Q(rxd64[13]), .C(rxclk_2x), .CE(~ddr_read_en), .CLR(reset), .D(rxd[10]));	defparam rxd64_13.INIT = 1'b0;
FDCE rxd64_14 (.Q(rxd64[14]), .C(rxclk_2x), .CE(~ddr_read_en), .CLR(reset), .D(rxd[9]));	defparam rxd64_14.INIT = 1'b0;
FDCE rxd64_15 (.Q(rxd64[15]), .C(rxclk_2x), .CE(~ddr_read_en), .CLR(reset), .D(rxd[8]));	defparam rxd64_15.INIT = 1'b0;
FDCE rxd64_16 (.Q(rxd64[16]), .C(rxclk_2x), .CE(~ddr_read_en), .CLR(reset), .D(rxd[23]));	defparam rxd64_16.INIT = 1'b0;
FDCE rxd64_17 (.Q(rxd64[17]), .C(rxclk_2x), .CE(~ddr_read_en), .CLR(reset), .D(rxd[22]));	defparam rxd64_17.INIT = 1'b0;
FDCE rxd64_18 (.Q(rxd64[18]), .C(rxclk_2x), .CE(~ddr_read_en), .CLR(reset), .D(rxd[21]));	defparam rxd64_18.INIT = 1'b0;
FDCE rxd64_19 (.Q(rxd64[19]), .C(rxclk_2x), .CE(~ddr_read_en), .CLR(reset), .D(rxd[20]));	defparam rxd64_19.INIT = 1'b0;
FDCE rxd64_20 (.Q(rxd64[20]), .C(rxclk_2x), .CE(~ddr_read_en), .CLR(reset), .D(rxd[19]));	defparam rxd64_20.INIT = 1'b0;
FDCE rxd64_21 (.Q(rxd64[21]), .C(rxclk_2x), .CE(~ddr_read_en), .CLR(reset), .D(rxd[18]));	defparam rxd64_21.INIT = 1'b0;
FDCE rxd64_22 (.Q(rxd64[22]), .C(rxclk_2x), .CE(~ddr_read_en), .CLR(reset), .D(rxd[17]));	defparam rxd64_22.INIT = 1'b0;
FDCE rxd64_23 (.Q(rxd64[23]), .C(rxclk_2x), .CE(~ddr_read_en), .CLR(reset), .D(rxd[16]));	defparam rxd64_23.INIT = 1'b0;
FDCE rxd64_24 (.Q(rxd64[24]), .C(rxclk_2x), .CE(~ddr_read_en), .CLR(reset), .D(rxd[31]));	defparam rxd64_24.INIT = 1'b0;
FDCE rxd64_25 (.Q(rxd64[25]), .C(rxclk_2x), .CE(~ddr_read_en), .CLR(reset), .D(rxd[30]));	defparam rxd64_25.INIT = 1'b0;
FDCE rxd64_26 (.Q(rxd64[26]), .C(rxclk_2x), .CE(~ddr_read_en), .CLR(reset), .D(rxd[29]));	defparam rxd64_26.INIT = 1'b0;
FDCE rxd64_27 (.Q(rxd64[27]), .C(rxclk_2x), .CE(~ddr_read_en), .CLR(reset), .D(rxd[28]));	defparam rxd64_27.INIT = 1'b0;
FDCE rxd64_28 (.Q(rxd64[28]), .C(rxclk_2x), .CE(~ddr_read_en), .CLR(reset), .D(rxd[27]));	defparam rxd64_28.INIT = 1'b0;
FDCE rxd64_29 (.Q(rxd64[29]), .C(rxclk_2x), .CE(~ddr_read_en), .CLR(reset), .D(rxd[26]));	defparam rxd64_29.INIT = 1'b0;
FDCE rxd64_30 (.Q(rxd64[30]), .C(rxclk_2x), .CE(~ddr_read_en), .CLR(reset), .D(rxd[25]));	defparam rxd64_30.INIT = 1'b0;
FDCE rxd64_31 (.Q(rxd64[31]), .C(rxclk_2x), .CE(~ddr_read_en), .CLR(reset), .D(rxd[24]));	defparam rxd64_31.INIT = 1'b0;
FDCE rxd64_32 (.Q(rxd64[32]), .C(rxclk_2x), .CE(ddr_read_en), .CLR(reset), .D(rxd[7]));	defparam rxd64_32.INIT = 1'b0;
FDCE rxd64_33 (.Q(rxd64[33]), .C(rxclk_2x), .CE(ddr_read_en), .CLR(reset), .D(rxd[6]));	defparam rxd64_33.INIT = 1'b0;
FDCE rxd64_34 (.Q(rxd64[34]), .C(rxclk_2x), .CE(ddr_read_en), .CLR(reset), .D(rxd[5]));	defparam rxd64_34.INIT = 1'b0;
FDCE rxd64_35 (.Q(rxd64[35]), .C(rxclk_2x), .CE(ddr_read_en), .CLR(reset), .D(rxd[4]));	defparam rxd64_35.INIT = 1'b0;
FDCE rxd64_36 (.Q(rxd64[36]), .C(rxclk_2x), .CE(ddr_read_en), .CLR(reset), .D(rxd[3]));	defparam rxd64_36.INIT = 1'b0;
FDCE rxd64_37 (.Q(rxd64[37]), .C(rxclk_2x), .CE(ddr_read_en), .CLR(reset), .D(rxd[2]));	defparam rxd64_37.INIT = 1'b0;
FDCE rxd64_38 (.Q(rxd64[38]), .C(rxclk_2x), .CE(ddr_read_en), .CLR(reset), .D(rxd[1]));	defparam rxd64_38.INIT = 1'b0;
FDCE rxd64_39 (.Q(rxd64[39]), .C(rxclk_2x), .CE(ddr_read_en), .CLR(reset), .D(rxd[0]));	defparam rxd64_39.INIT = 1'b0;
FDCE rxd64_40 (.Q(rxd64[40]), .C(rxclk_2x), .CE(ddr_read_en), .CLR(reset), .D(rxd[15]));	defparam rxd64_40.INIT = 1'b0;
FDCE rxd64_41 (.Q(rxd64[41]), .C(rxclk_2x), .CE(ddr_read_en), .CLR(reset), .D(rxd[14]));	defparam rxd64_41.INIT = 1'b0;
FDCE rxd64_42 (.Q(rxd64[42]), .C(rxclk_2x), .CE(ddr_read_en), .CLR(reset), .D(rxd[13]));	defparam rxd64_42.INIT = 1'b0;
FDCE rxd64_43 (.Q(rxd64[43]), .C(rxclk_2x), .CE(ddr_read_en), .CLR(reset), .D(rxd[12]));	defparam rxd64_43.INIT = 1'b0;
FDCE rxd64_44 (.Q(rxd64[44]), .C(rxclk_2x), .CE(ddr_read_en), .CLR(reset), .D(rxd[11]));	defparam rxd64_44.INIT = 1'b0;
FDCE rxd64_45 (.Q(rxd64[45]), .C(rxclk_2x), .CE(ddr_read_en), .CLR(reset), .D(rxd[10]));	defparam rxd64_45.INIT = 1'b0;
FDCE rxd64_46 (.Q(rxd64[46]), .C(rxclk_2x), .CE(ddr_read_en), .CLR(reset), .D(rxd[9]));	defparam rxd64_46.INIT = 1'b0;
FDCE rxd64_47 (.Q(rxd64[47]), .C(rxclk_2x), .CE(ddr_read_en), .CLR(reset), .D(rxd[8]));	defparam rxd64_47.INIT = 1'b0;
FDCE rxd64_48 (.Q(rxd64[48]), .C(rxclk_2x), .CE(ddr_read_en), .CLR(reset), .D(rxd[23]));	defparam rxd64_48.INIT = 1'b0;
FDCE rxd64_49 (.Q(rxd64[49]), .C(rxclk_2x), .CE(ddr_read_en), .CLR(reset), .D(rxd[22]));	defparam rxd64_49.INIT = 1'b0;
FDCE rxd64_50 (.Q(rxd64[50]), .C(rxclk_2x), .CE(ddr_read_en), .CLR(reset), .D(rxd[21]));	defparam rxd64_50.INIT = 1'b0;
FDCE rxd64_51 (.Q(rxd64[51]), .C(rxclk_2x), .CE(ddr_read_en), .CLR(reset), .D(rxd[20]));	defparam rxd64_51.INIT = 1'b0;
FDCE rxd64_52 (.Q(rxd64[52]), .C(rxclk_2x), .CE(ddr_read_en), .CLR(reset), .D(rxd[19]));	defparam rxd64_52.INIT = 1'b0;
FDCE rxd64_53 (.Q(rxd64[53]), .C(rxclk_2x), .CE(ddr_read_en), .CLR(reset), .D(rxd[18]));	defparam rxd64_53.INIT = 1'b0;
FDCE rxd64_54 (.Q(rxd64[54]), .C(rxclk_2x), .CE(ddr_read_en), .CLR(reset), .D(rxd[17]));	defparam rxd64_54.INIT = 1'b0;
FDCE rxd64_55 (.Q(rxd64[55]), .C(rxclk_2x), .CE(ddr_read_en), .CLR(reset), .D(rxd[16]));	defparam rxd64_55.INIT = 1'b0;
FDCE rxd64_56 (.Q(rxd64[56]), .C(rxclk_2x), .CE(ddr_read_en), .CLR(reset), .D(rxd[31]));	defparam rxd64_56.INIT = 1'b0;
FDCE rxd64_57 (.Q(rxd64[57]), .C(rxclk_2x), .CE(ddr_read_en), .CLR(reset), .D(rxd[30]));	defparam rxd64_57.INIT = 1'b0;
FDCE rxd64_58 (.Q(rxd64[58]), .C(rxclk_2x), .CE(ddr_read_en), .CLR(reset), .D(rxd[29]));	defparam rxd64_58.INIT = 1'b0;
FDCE rxd64_59 (.Q(rxd64[59]), .C(rxclk_2x), .CE(ddr_read_en), .CLR(reset), .D(rxd[28]));	defparam rxd64_59.INIT = 1'b0;
FDCE rxd64_60 (.Q(rxd64[60]), .C(rxclk_2x), .CE(ddr_read_en), .CLR(reset), .D(rxd[27]));	defparam rxd64_60.INIT = 1'b0;
FDCE rxd64_61 (.Q(rxd64[61]), .C(rxclk_2x), .CE(ddr_read_en), .CLR(reset), .D(rxd[26]));	defparam rxd64_61.INIT = 1'b0;
FDCE rxd64_62 (.Q(rxd64[62]), .C(rxclk_2x), .CE(ddr_read_en), .CLR(reset), .D(rxd[25]));	defparam rxd64_62.INIT = 1'b0;
FDCE rxd64_63 (.Q(rxd64[63]), .C(rxclk_2x), .CE(ddr_read_en), .CLR(reset), .D(rxd[24]));	defparam rxd64_63.INIT = 1'b0;

//rxc ddr io registers
FDCE rxc8_0 (.Q(rxc8[0]), .C(rxclk_2x), .CE(~ddr_read_en), .CLR(reset), .D(rxc[3]));	 defparam rxc8_0.INIT = 1'b0;
FDCE rxc8_1 (.Q(rxc8[1]), .C(rxclk_2x), .CE(~ddr_read_en), .CLR(reset), .D(rxc[2]));	 defparam rxc8_1.INIT = 1'b0;
FDCE rxc8_2 (.Q(rxc8[2]), .C(rxclk_2x), .CE(~ddr_read_en), .CLR(reset), .D(rxc[1]));	 defparam rxc8_2.INIT = 1'b0;
FDCE rxc8_3 (.Q(rxc8[3]), .C(rxclk_2x), .CE(~ddr_read_en), .CLR(reset), .D(rxc[0]));	 defparam rxc8_3.INIT = 1'b0;
FDCE rxc8_4 (.Q(rxc8[4]), .C(rxclk_2x), .CE(ddr_read_en), .CLR(reset), .D(rxc[3]));		 defparam rxc8_4.INIT = 1'b0;
FDCE rxc8_5 (.Q(rxc8[5]), .C(rxclk_2x), .CE(ddr_read_en), .CLR(reset), .D(rxc[2]));		 defparam rxc8_5.INIT = 1'b0;
FDCE rxc8_6 (.Q(rxc8[6]), .C(rxclk_2x), .CE(ddr_read_en), .CLR(reset), .D(rxc[1]));		 defparam rxc8_6.INIT = 1'b0;
FDCE rxc8_7 (.Q(rxc8[7]), .C(rxclk_2x), .CE(ddr_read_en), .CLR(reset), .D(rxc[0]));		 defparam rxc8_7.INIT = 1'b0;


endmodule
