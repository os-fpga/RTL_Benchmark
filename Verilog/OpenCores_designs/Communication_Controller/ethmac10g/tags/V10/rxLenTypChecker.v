`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:    21:23:10 11/21/05
// Design Name:    
// Module Name:    rxLenTypChecker
// Project Name:   
// Target Device:  
// Tool versions:  
// Description:
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:	Length/Type:
// 1. <64:  Length, we should remove PAD
// 2. >=64, <= 1518:	Length, valid frame, we don't need remove PAD(0x2E, 0x5DC)
// 3. >=1518: <9k+18: Length, jumbo frame, if supported (0x5DC, 0x2400)
//	4. >9k+18, = 0x8100: Type, Tagged frame
// 5. >9k+18, = 0x8808: Type, pause frame

// |<------------------------------ Data Field ---------------------------->|
// |<------------- True Data Field --------------> <-----Padded bits------->|
// |____________________________|_________________|
// |	    					        |			        |
// |	 small_integer_cnt * 64   | small_bits_more |  
// |____________________________|_________________|____
// |___________________________________________________|_____________________
// |		                  			                   |			  	          |
// |	             integer_cnt * 64                    |       bits_more    |
// |___________________________________________________|____________________|


////////////////////////////////////////////////////////////////////////////////

module rxLenTypChecker(lt_data, tagged_len, jumbo_enable, tagged_frame, pause_frame, small_frame,
                       len_invalid, integer_cnt, small_integer_cnt, bits_more, inband_fcs,
							  small_bits_more, vlan_enable );
    	 
	 input[15:0]  lt_data;	    //Length or Type field of a frame
	 input[15:0]  tagged_len;   //Actual length carried with tagged frame  
    input        jumbo_enable; //Enable jumbo frame recieving
	 input        inband_fcs;	 //In-band FCS
	 input        vlan_enable;  //VLAN mode enable bit

	 output       pause_frame;	 //Indicate that current frame is a pause frame (a kind of control frame)	
	 output       small_frame; 
	 output       len_invalid;	 //Indicate that current frame is not an valid frame

	 output[12:0] integer_cnt;	 //number of 64bits DATA field contains
	 output[12:0] small_integer_cnt;	//number of 64bits real DATA field contains(without pad part)
	 
	 output       tagged_frame;	 //number of 64bits DATA field of tagged frame contains
	 
	 output[2:0]  bits_more;	 //number that is less than 64bits(whole data field)
	 output[2:0]  small_bits_more; //number that is less than 64bits(unpadded data field) 

    wire[15:0]   current_len;
	 wire[15:0]   current_cnt;
	 wire         small_frame;
	 wire         tagged_frame;

	 parameter TP =1 ;

	 assign current_len = tagged_frame?(tagged_len+2):(lt_data-2);	 //Data field length

	 assign current_cnt = current_len >> 3; //the number of 64bits data field has

	 assign padded_frame = (current_len[15:6]==0) & (~current_len[5] | (current_len[5] & ~current_len[4]));

	 assign small_frame = padded_frame & ~inband_fcs;  //padded frame

	 assign bits_more = padded_frame? 4 :current_len[2:0];	// bits that is not 64bits enough

	 assign small_bits_more = current_len[2:0];// for situation smaller than 64

	 assign integer_cnt = padded_frame? 5 :current_cnt[12:0];

	 assign small_integer_cnt = current_cnt[12:0];
	
	 assign tagged_frame = (lt_data==16'h8100) & vlan_enable; 

	 assign pause_frame = (lt_data==16'h8808);

	 assign len_invalid = ((~jumbo_enable & (lt_data > 1500)) & ~(tagged_frame|pause_frame)) | (~vlan_enable & tagged_frame);
	 //not a large frame(except LT is type interpretion) when jumbo is not enabled, not a tagged frame when vlan is not enbaled
endmodule
