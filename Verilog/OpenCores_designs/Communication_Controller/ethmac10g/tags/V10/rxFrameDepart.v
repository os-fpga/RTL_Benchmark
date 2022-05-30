`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:    19:45:58 12/13/05
// Design Name:    
// Module Name:    rxFrameDepart
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

`define START      8'hfb
`define TERMINATE  8'hfd  	
`define SFD        8'b10101011
`define SEQUENCE   8'h9c
`define ERROR      8'hfe
`define ALLONES    8'hff
`define ALLZEROS   8'h00

module rxFrameDepart(rxclk, reset, rxclk_180, rxd64, rxc8, start_da, start_lt, tagged_frame,
                     bits_more, small_bits_more, tagged_len, small_frame, end_data_cnt,inband_fcs, 
							end_small_cnt, da_addr, lt_data, crc_code, end_fcs, crc_valid, length_error,
						   get_sfd, get_efd, get_error_code,receiving, rxc_fifo, receiving_frame);
    input rxclk;
    input reset;
    input rxclk_180;
    input [63:0] rxd64;
    input [7:0] rxc8;

	 input start_da;
	 input start_lt;
	 input tagged_frame;
	 input [2:0] bits_more;
	 input [2:0] small_bits_more;
	 input small_frame;
	 input end_data_cnt;
	 input end_small_cnt;
	 input inband_fcs;
	 input receiving;
	 input receiving_frame;

	 output[7:0]  rxc_fifo;
	 output[47:0] da_addr; //destination address won't be changed until start_da was changed again
	 output[15:0] lt_data; //(Length/Type) field won't be changed until start_lt was changed again
	 output[15:0] tagged_len;
	 output[31:0] crc_code;
	 output       end_fcs;
	 output[7:0]  crc_valid;
	 output       length_error;

	 output       get_sfd;
	 output       get_efd;
	 output       get_error_code;

	 parameter TP = 1;

	 //////////////////////////////////////////
	 // Get Control Characters
	 //////////////////////////////////////////
	 wire get_sfd;
	 wire[7:0] get_t_chk;
	 wire get_efd;
	 wire get_error_code;
	 wire[7:0] get_e_chk;

	 //1. SFD 
	 assign get_sfd = ~(rxd64[63:56] ^ `START) & ~(rxd64[7:0] ^ `SFD) & ~(rxc8 ^ 8'h80);

 	 //2. EFD
	 assign get_t_chk[0] = rxc8[0] & (rxd64[7:0] ~^ `TERMINATE );
	 assign get_t_chk[1] = rxc8[1] & (rxd64[15:8] ~^ `TERMINATE );
	 assign get_t_chk[2] = rxc8[2] & (rxd64[23:16] ~^ `TERMINATE );
	 assign get_t_chk[3] = rxc8[3] & (rxd64[31:24] ~^ `TERMINATE );
	 assign get_t_chk[4] = rxc8[4] & (rxd64[39:32] ~^ `TERMINATE );		
	 assign get_t_chk[5] = rxc8[5] & (rxd64[47:40] ~^ `TERMINATE );
	 assign get_t_chk[6] = rxc8[6] & (rxd64[55:48] ~^ `TERMINATE );
	 assign get_t_chk[7] = rxc8[7] & (rxd64[63:56] ~^ `TERMINATE );
	 assign get_efd = | get_t_chk;

	 //3. Error Character
	 assign get_e_chk[0] = rxc8[0] & (rxd64[7:0]  ^`TERMINATE);
	 assign get_e_chk[1] = rxc8[1] & (rxd64[15:8] ^`TERMINATE);
	 assign get_e_chk[2] = rxc8[2] & (rxd64[23:16]^`TERMINATE);
	 assign get_e_chk[3] = rxc8[3] & (rxd64[31:24]^`TERMINATE);
	 assign get_e_chk[4] = rxc8[4] & (rxd64[39:32]^`TERMINATE);		
	 assign get_e_chk[5] = rxc8[5] & (rxd64[47:40]^`TERMINATE);
	 assign get_e_chk[6] = rxc8[6] & (rxd64[55:48]^`TERMINATE);
	 assign get_e_chk[7] = rxc8[7] & (rxd64[63:56]^`TERMINATE);
	 assign get_error_code = | get_e_chk;
    
	 //////////////////////////////////////
	 // Get Destination Address
	 //////////////////////////////////////

	 reg[47:0] da_addr; 
	 always@(posedge rxclk_180 or posedge reset)begin
       if (reset) 
	       da_addr <=#TP 0;
   	 else if (start_da) 
	       da_addr <=#TP rxd64[63:16];
		 else	
		    da_addr <=#TP da_addr;
    end

	//////////////////////////////////////
	// Get Length/Type Field
	//////////////////////////////////////

	 reg[15:0] lt_data; 
	 always@(posedge rxclk_180 or posedge reset)begin
       if (reset) 
	       lt_data <=#TP 0;
   	 else if (start_lt) 
	       lt_data <=#TP rxd64[31:16];
       else if(~receiving_frame)
		    lt_data <=#TP 16'h0500;
		 else
		    lt_data <=#TP lt_data;
    end

  ///////////////////////////////////////
  // Get Tagged Frame Length
  ///////////////////////////////////////

	 reg tagged_frame_d1;
	 always@(posedge rxclk_180) begin
	        tagged_frame_d1<=#TP tagged_frame;
	 end

	 reg[15:0] tagged_len;
	 always@(posedge rxclk_180 or posedge reset) begin
	        if (reset)
               tagged_len <=#TP 0;
			  else if(~tagged_frame_d1 & tagged_frame)
			      tagged_len <=#TP rxd64[63:48]; 
           else if(~receiving_frame)
			      tagged_len <=#TP 16'h0500;
			  else
			      tagged_len <=#TP tagged_len;
	 end

  ////////////////////////////////////////
  // Get FCS Field and Part of DATA
  ////////////////////////////////////////
	 
	 wire [7:0]special;

    wire[31:0] crc_code;	
	 wire       end_fcs;
	 wire[7:0]  crc_valid;
	 wire       length_error; 
	 wire[7:0]  tmp_crc_data[31:0];
	 wire[31:0] crc_code_tmp1;
	 wire[31:0] crc_code_tmp;
	 wire[4:0]  shift_tmp;
	 wire       next_cycle;
	 reg        end_data_cnt_d1;

	 always@(posedge rxclk or posedge reset) begin
	    if (reset)
		    end_data_cnt_d1<= #TP 0;
		 else 
		    end_data_cnt_d1<= #TP end_data_cnt;
 	 end

	 reg[31:0] crc_code_tmp_d1;
	 always@(posedge rxclk or posedge reset) begin
	    if (reset)
		    crc_code_tmp_d1<= #TP 0;
		 else
			 crc_code_tmp_d1 <=#TP crc_code_tmp;
	 end	
	 
	 assign shift_tmp = (8-bits_more)<<3;
	 assign special = `ALLONES >> bits_more;
	 assign crc_code_tmp1 = rxd64[63:32] >> shift_tmp;	
	 assign next_cycle = bits_more[2]&(bits_more[1] | bits_more[0]);				 
	 assign crc_valid = end_data_cnt? ~special: `ALLONES;
	 assign end_fcs = end_data_cnt_d1;
	 //timing constraint should be added here to make length_error be valid earlier than end_fcs
	 assign length_error = (end_data_cnt    &(((bits_more == 0) & ~get_t_chk[3])  |
	                                          ((bits_more == 1) & ~get_t_chk[2])  |
	                                          ((bits_more == 2) & ~get_t_chk[1])  |
	                                          ((bits_more == 3) & ~get_t_chk[0])))|
	                       (end_data_cnt_d1 &(((bits_more == 4) & ~get_t_chk[7])  |
	                                          ((bits_more == 5) & ~get_t_chk[6])  |
	                                          ((bits_more == 6) & ~get_t_chk[5])  |
	                                          ((bits_more == 7) & ~get_t_chk[4])));

	 assign tmp_crc_data[31] = {rxd64[7],rxd64[15],rxd64[23],rxd64[31],rxd64[39],rxd64[47],rxd64[55],rxd64[63]};
	 assign tmp_crc_data[30] = {rxd64[6],rxd64[14],rxd64[22],rxd64[30],rxd64[38],rxd64[46],rxd64[54],rxd64[62]};
	 assign tmp_crc_data[29] = {rxd64[5],rxd64[13],rxd64[21],rxd64[29],rxd64[37],rxd64[45],rxd64[53],rxd64[61]};
	 assign tmp_crc_data[28] = {rxd64[4],rxd64[12],rxd64[20],rxd64[28],rxd64[36],rxd64[44],rxd64[52],rxd64[60]};
	 assign tmp_crc_data[27] = {rxd64[3],rxd64[11],rxd64[19],rxd64[27],rxd64[35],rxd64[43],rxd64[51],rxd64[59]};
	 assign tmp_crc_data[26] = {rxd64[2],rxd64[10],rxd64[18],rxd64[26],rxd64[34],rxd64[42],rxd64[50],rxd64[58]};
	 assign tmp_crc_data[25] = {rxd64[1],rxd64[9],rxd64[17],rxd64[25],rxd64[33],rxd64[41],rxd64[49],rxd64[57]};
	 assign tmp_crc_data[24] = {rxd64[0],rxd64[8],rxd64[16],rxd64[24],rxd64[32],rxd64[40],rxd64[48],rxd64[56]};
	 assign tmp_crc_data[23] = {1'b0,rxd64[7],rxd64[15],rxd64[23],rxd64[31],rxd64[39],rxd64[47],rxd64[55]};
	 assign tmp_crc_data[22] = {1'b0,rxd64[6],rxd64[14],rxd64[22],rxd64[30],rxd64[38],rxd64[46],rxd64[54]};
	 assign tmp_crc_data[21] = {1'b0,rxd64[5],rxd64[13],rxd64[21],rxd64[29],rxd64[37],rxd64[45],rxd64[53]};
	 assign tmp_crc_data[20] = {1'b0,rxd64[4],rxd64[12],rxd64[20],rxd64[28],rxd64[36],rxd64[44],rxd64[52]};
	 assign tmp_crc_data[19] = {1'b0,rxd64[3],rxd64[11],rxd64[19],rxd64[27],rxd64[35],rxd64[43],rxd64[51]};
	 assign tmp_crc_data[18] = {1'b0,rxd64[2],rxd64[10],rxd64[18],rxd64[26],rxd64[34],rxd64[42],rxd64[50]};
	 assign tmp_crc_data[17] = {1'b0,rxd64[1],rxd64[9],rxd64[17],rxd64[25],rxd64[33],rxd64[41],rxd64[49]};
	 assign tmp_crc_data[16] = {1'b0,rxd64[0],rxd64[8],rxd64[16],rxd64[24],rxd64[32],rxd64[40],rxd64[48]};
	 assign tmp_crc_data[15] = {1'b0,1'b0,rxd64[7],rxd64[15],rxd64[23],rxd64[31],rxd64[39],rxd64[47]};
	 assign tmp_crc_data[14] = {1'b0,1'b0,rxd64[6],rxd64[14],rxd64[22],rxd64[30],rxd64[38],rxd64[46]};
	 assign tmp_crc_data[13] = {1'b0,1'b0,rxd64[5],rxd64[13],rxd64[21],rxd64[29],rxd64[37],rxd64[45]};
	 assign tmp_crc_data[12] = {1'b0,1'b0,rxd64[4],rxd64[12],rxd64[20],rxd64[28],rxd64[36],rxd64[44]};
	 assign tmp_crc_data[11] = {1'b0,1'b0,rxd64[3],rxd64[11],rxd64[19],rxd64[27],rxd64[35],rxd64[43]};
	 assign tmp_crc_data[10] = {1'b0,1'b0,rxd64[2],rxd64[10],rxd64[18],rxd64[26],rxd64[34],rxd64[42]};
	 assign tmp_crc_data[9] = {1'b0,1'b0,rxd64[1],rxd64[9],rxd64[17],rxd64[25],rxd64[33],rxd64[41]};
	 assign tmp_crc_data[8] = {1'b0,1'b0,rxd64[0],rxd64[8],rxd64[16],rxd64[24],rxd64[32],rxd64[40]};
	 assign tmp_crc_data[7] = {1'b0,1'b0,1'b0,rxd64[7],rxd64[15],rxd64[23],rxd64[31],rxd64[39]};
	 assign tmp_crc_data[6] = {1'b0,1'b0,1'b0,rxd64[6],rxd64[14],rxd64[22],rxd64[30],rxd64[38]};
	 assign tmp_crc_data[5] = {1'b0,1'b0,1'b0,rxd64[5],rxd64[13],rxd64[21],rxd64[29],rxd64[37]};
	 assign tmp_crc_data[4] = {1'b0,1'b0,1'b0,rxd64[4],rxd64[12],rxd64[20],rxd64[28],rxd64[36]};
	 assign tmp_crc_data[3] = {1'b0,1'b0,1'b0,rxd64[3],rxd64[11],rxd64[19],rxd64[27],rxd64[35]};
	 assign tmp_crc_data[2] = {1'b0,1'b0,1'b0,rxd64[2],rxd64[10],rxd64[18],rxd64[26],rxd64[34]};
	 assign tmp_crc_data[1] = {1'b0,1'b0,1'b0,rxd64[1],rxd64[9],rxd64[17],rxd64[25],rxd64[33]};
	 assign tmp_crc_data[0] = {1'b0,1'b0,1'b0,rxd64[0],rxd64[8],rxd64[16],rxd64[24],rxd64[32]};

	 M8_1E crc31(.E(end_data_cnt), .S(bits_more), .D(tmp_crc_data[31]), .O(crc_code_tmp[31]));
	 M8_1E crc30(.E(end_data_cnt), .S(bits_more), .D(tmp_crc_data[30]), .O(crc_code_tmp[30]));
	 M8_1E crc29(.E(end_data_cnt), .S(bits_more), .D(tmp_crc_data[29]), .O(crc_code_tmp[29]));
	 M8_1E crc28(.E(end_data_cnt), .S(bits_more), .D(tmp_crc_data[28]), .O(crc_code_tmp[28]));
	 M8_1E crc27(.E(end_data_cnt), .S(bits_more), .D(tmp_crc_data[27]), .O(crc_code_tmp[27]));
	 M8_1E crc26(.E(end_data_cnt), .S(bits_more), .D(tmp_crc_data[26]), .O(crc_code_tmp[26]));
	 M8_1E crc25(.E(end_data_cnt), .S(bits_more), .D(tmp_crc_data[25]), .O(crc_code_tmp[25]));
	 M8_1E crc24(.E(end_data_cnt), .S(bits_more), .D(tmp_crc_data[24]), .O(crc_code_tmp[24]));
	 M8_1E crc23(.E(end_data_cnt), .S(bits_more), .D(tmp_crc_data[23]), .O(crc_code_tmp[23]));
	 M8_1E crc22(.E(end_data_cnt), .S(bits_more), .D(tmp_crc_data[22]), .O(crc_code_tmp[22]));
	 M8_1E crc21(.E(end_data_cnt), .S(bits_more), .D(tmp_crc_data[21]), .O(crc_code_tmp[21]));
	 M8_1E crc20(.E(end_data_cnt), .S(bits_more), .D(tmp_crc_data[20]), .O(crc_code_tmp[20]));
	 M8_1E crc19(.E(end_data_cnt), .S(bits_more), .D(tmp_crc_data[19]), .O(crc_code_tmp[19]));
	 M8_1E crc18(.E(end_data_cnt), .S(bits_more), .D(tmp_crc_data[18]), .O(crc_code_tmp[18]));
	 M8_1E crc17(.E(end_data_cnt), .S(bits_more), .D(tmp_crc_data[17]), .O(crc_code_tmp[17]));
	 M8_1E crc16(.E(end_data_cnt), .S(bits_more), .D(tmp_crc_data[16]), .O(crc_code_tmp[16]));
	 M8_1E crc15(.E(end_data_cnt), .S(bits_more), .D(tmp_crc_data[15]), .O(crc_code_tmp[15]));
	 M8_1E crc14(.E(end_data_cnt), .S(bits_more), .D(tmp_crc_data[14]), .O(crc_code_tmp[14]));
	 M8_1E crc13(.E(end_data_cnt), .S(bits_more), .D(tmp_crc_data[13]), .O(crc_code_tmp[13]));
	 M8_1E crc12(.E(end_data_cnt), .S(bits_more), .D(tmp_crc_data[12]), .O(crc_code_tmp[12]));
	 M8_1E crc11(.E(end_data_cnt), .S(bits_more), .D(tmp_crc_data[11]), .O(crc_code_tmp[11]));
	 M8_1E crc10(.E(end_data_cnt), .S(bits_more), .D(tmp_crc_data[10]), .O(crc_code_tmp[10]));
	 M8_1E crc9(.E(end_data_cnt), .S(bits_more), .D(tmp_crc_data[9]), .O(crc_code_tmp[9]));
	 M8_1E crc8(.E(end_data_cnt), .S(bits_more), .D(tmp_crc_data[8]), .O(crc_code_tmp[8]));
	 M8_1E crc7(.E(end_data_cnt), .S(bits_more), .D(tmp_crc_data[7]), .O(crc_code_tmp[7]));
	 M8_1E crc6(.E(end_data_cnt), .S(bits_more), .D(tmp_crc_data[6]), .O(crc_code_tmp[6]));
	 M8_1E crc5(.E(end_data_cnt), .S(bits_more), .D(tmp_crc_data[5]), .O(crc_code_tmp[5]));
	 M8_1E crc4(.E(end_data_cnt), .S(bits_more), .D(tmp_crc_data[4]), .O(crc_code_tmp[4]));
	 M8_1E crc3(.E(end_data_cnt), .S(bits_more), .D(tmp_crc_data[3]), .O(crc_code_tmp[3]));
	 M8_1E crc2(.E(end_data_cnt), .S(bits_more), .D(tmp_crc_data[2]), .O(crc_code_tmp[2]));
	 M8_1E crc1(.E(end_data_cnt), .S(bits_more), .D(tmp_crc_data[1]), .O(crc_code_tmp[1]));
	 M8_1E crc0(.E(end_data_cnt), .S(bits_more), .D(tmp_crc_data[0]), .O(crc_code_tmp[0]));

	 assign crc_code =next_cycle ? (crc_code_tmp_d1 | crc_code_tmp1): crc_code_tmp; 

  /////////////////////////////////////////////////////////////////////////////////
  //                       Generate proper rxc to FIFO									//
  /////////////////////////////////////////////////////////////////////////////////

  // FCS is provided by client, inband_fcs is valid   
  //    receiving            end_data_cnt		            	end_fcs
  // frame: |<------ Data ------>|<-- bits_more -->|<-- FCS -->|<--------
  // rxc  :	|<------------------- all_one -------------------->|<--------all_zero
  //                             |<--- 8bits, with 1s & 0s --->|

  // FCS is provided by logic, inband_fcs is invalid
  //	  receiving            end_data_cnt                   end_fcs
  // frame: |<------ Data ------>|<-- bits_more -->|<-- FCS -->|
  // rxc  : |<-------------- all_one ------------->|<----- all_zero
  //										|<-- 8bits, with 1s & 0s --->|

  //    receiving          end_small_cnt													end_fcs
  // frame: |<------ Data ------>|<-- small_bits_more -->|<-- PAD -->|<-- FCS -->|
  // rxc  : |<----------------- all_one ---------------->|<----- all_zero
  //										|<-------- 1s --------->|<----- 0s 
	 wire [7:0]rxc_pad;
	 wire [7:0]rxc_end_data;
	 wire [7:0]rxc_fcs;
	 wire [7:0]rxc_final[2:0];
	 wire [7:0]rxc_fifo; //rxc send to fifo

	 assign rxc_pad = ~(`ALLONES >> small_bits_more);
	 assign rxc_end_data = ~special;
	 assign rxc_fcs =~(bits_more[2]?(`ALLONES >> {1'b0,bits_more[1:0]}) : (`ALLONES >> {1'b1,bits_more[1:0]}));

	 assign rxc_final[0] = receiving? (((end_data_cnt & ~next_cycle) | (end_data_cnt_d1 & next_cycle))? rxc_fcs: `ALLONES): `ALLZEROS;
	 assign rxc_final[1] = receiving? (end_data_cnt? rxc_end_data: `ALLONES): `ALLZEROS;
	 assign rxc_final[2] = receiving? (end_small_cnt?rxc_pad: `ALLONES): `ALLZEROS;
    assign rxc_fifo = inband_fcs? rxc_final[0]: (small_frame? rxc_final[2]: rxc_final[1]);
                          
endmodule