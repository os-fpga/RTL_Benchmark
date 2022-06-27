`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:    17:21:58 11/24/05
// Design Name:    
// Module Name:    rxNumCounter
// Project Name:   
// Target Device:  
// Tool versions:  
// Description:   This module only deals with cycles with 64bits
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module rxNumCounter(rxclk, reset, start_data_cnt, start_tagged_cnt, small_frame, 
                    integer_cnt, small_integer_cnt, end_data_cnt, tagged_frame, 
						  end_small_cnt, end_tagged_cnt);
    
	 input rxclk;            //receive clk	 
    input reset;				 //globe reset

    input start_data_cnt;	 //start to count	data field
    input start_tagged_cnt; //start to count tagged frame	

    input small_frame;
	 input tagged_frame;

	 input[12:0] integer_cnt;      //number of 64bits DATA field contains
	 input[12:0] small_integer_cnt;//number of 64bits real DATA field contains(without pad part)

    output end_data_cnt;   //end of data field(only 64bits aligned data)
	 output end_small_cnt;  //end of true data field of small frame(only 64bits aligned data)
	 output end_tagged_cnt; //end of true data field of tagged frame(only 64bits aligned data) 
    
	 wire   end_cnt;
	 wire[12:0] data_cnt;
	 wire[12:0] tagged_data_cnt;
	 wire end_normal_data_cnt;

	 // Data counter
    // used in rxReceiveData field, 
    // this counter is used for frames whose length is larger than 64
    // Of course it also count actual bytes of frames whose length is shorter than 64.
    counter data_counter(.clk(rxclk), .reset(reset), .load(end_cnt), .en(start_data_cnt), .value(data_cnt));
	 defparam data_counter.WIDTH = 13;
    
    counter tagged_counter(.clk(rxclk), .reset(reset), .load(end_tagged_cnt), .en(start_tagged_cnt), .value(tagged_data_cnt));
	 defparam tagged_counter.WIDTH = 13;

	 assign end_cnt = end_data_cnt | start_tagged_cnt | ~start_data_cnt;

	 assign end_normal_data_cnt = (data_cnt == integer_cnt);

	 assign end_small_cnt = small_frame & (data_cnt == small_integer_cnt);

	 assign end_tagged_cnt = tagged_frame & (tagged_data_cnt == integer_cnt);

	 assign end_data_cnt = end_tagged_cnt | end_normal_data_cnt;

endmodule
