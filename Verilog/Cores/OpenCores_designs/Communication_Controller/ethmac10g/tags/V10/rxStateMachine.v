`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:    09:59:01 11/21/05
// Design Name:    
// Module Name:    rxStateMachine
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
module rxStateMachine(rxclk, reset, recv_enable, get_sfd, local_invalid, len_invalid, end_data_cnt, end_tagged_cnt,
       tagged_frame, length_error, end_fcs, crc_check_valid, crc_check_invalid, start_da, start_lt, inband_fcs,
		 start_data_cnt, start_tagged_cnt, receiving, recv_end, good_frame_get, bad_frame_get, get_error_code, small_frame
		 , end_small_cnt,receiving_frame);
   
	 input rxclk;
    input reset;
   
	 input recv_enable;
	 input inband_fcs;
	 
	 //PRE & SFD
	 input get_sfd; // SFD has been received;
	
	 //DA field 
	 input local_invalid;// The Frame's DA field is not Local MAC;
	
	 //Length/Type field
	 input len_invalid;// Indicate if Length field is valid;
    input end_data_cnt;// Indicate end of receiving DATA field(not jumbo frame);
	 input end_tagged_cnt;// Indicate end of receiving DATA field of tagged Frame;
	 input end_small_cnt; // Indicate end of receiving small data field
	 input tagged_frame;// Indicate current frame is a jumbo_frame;
	 input small_frame; // Indicate current frame is a small frame;
	 input length_error;//Indicate Length received is not equal to the Length in LT field;
	 
	 //FCS field
	 input end_fcs;//Indicate end of receiving FCS field;
	 input crc_check_valid;//Indicate the frame passed CRC Check;
	 input crc_check_invalid;//Indicate the frame failed in CRC Check;
	 input get_error_code;
	
	 //DA field
	 output start_da;// Start to receive Destination Address;
   
	 //Length/Type field
	 output start_lt;// Start to receive Length/Type field;
	
	 //DATA field
    output start_data_cnt;// Start to receive DATA field;
	 output start_tagged_cnt;// Start to receive DATA field, but the frame is a tagged frame.
    //Receive process control
	 output receiving;// Rx Engine is receiving valid part of frame;
	 output receiving_frame; //Rx Engine is working, not in IDLE state and Check state.
	 output recv_end; // Receive process ends, either because formal ending or faults happen;
	 output good_frame_get;// A good frame has been received;
	 output bad_frame_get; // A bad frame has been received; 
	 
	 parameter IDLE = 0, rxReceiveDA = 1, rxReceiveLT = 2, rxReceiveData = 3;
	 parameter rxReceiveFCS = 4, rxWaitCheck = 5;
	 parameter TP =1;

	 wire    start_da;
	 wire    start_lt;
	 wire 	start_data_cnt;
	 wire    start_tagged_cnt;
	 wire    receiving_data;
	 wire    receiving_frame;
	 wire    receiving;
	 wire    recv_end;
	 wire    good_frame_get;
	 wire    bad_frame_get;
	 
	 reg[2:0] rxstate, rxstate_next;

	 always@(rxstate, get_sfd, local_invalid, len_invalid, recv_enable,
	         tagged_frame, end_data_cnt, end_tagged_cnt, get_error_code,
				end_fcs, length_error, crc_check_valid,crc_check_invalid, reset)begin
	      if (reset) begin
			   rxstate_next <=#TP IDLE;
			end
			else begin	 
			    case (rxstate)
			      IDLE: begin 
			       		if (get_sfd & recv_enable)
				       		rxstate_next <=#TP rxReceiveDA;
					end
           		rxReceiveDA: begin	  
				   		rxstate_next <=#TP rxReceiveLT;
					end
            	rxReceiveLT: begin			 
					 		rxstate_next <=#TP rxReceiveData;
            	end
					rxReceiveData: begin
					 		if (local_invalid | len_invalid | get_error_code) 
					     		rxstate_next <=#TP rxWaitCheck;
					 		else if (end_data_cnt | end_tagged_cnt) 
					     		rxstate_next <=#TP rxReceiveFCS;
					 
					end
					rxReceiveFCS: begin	 //length_error should have high priority to end_fcs
				   		if (length_error)
							   rxstate_next <=#TP IDLE;
							else if (end_fcs)
    					  		rxstate_next <=#TP rxWaitCheck;
				 	end
			    	rxWaitCheck: begin
					 		if (crc_check_valid)
					     		rxstate_next <=#TP IDLE;
					 		else if (local_invalid | len_invalid | length_error | crc_check_invalid)
					     		rxstate_next <=#TP IDLE;
				  end   
			   endcase
		   end
  	   end

	 always@(posedge rxclk or posedge reset) begin
	       if (reset)
			    rxstate <=#TP IDLE;
          else
			    rxstate <=#TP rxstate_next;
	 end

	 reg end_small_cnt_d1;
	 reg end_small_cnt_d2;
	 always@(posedge rxclk or posedge reset) begin
	       if (reset)begin
			    end_small_cnt_d1 <= 0;
				 end_small_cnt_d2 <= 0;
			 end
			 else begin
				 end_small_cnt_d1 <=end_small_cnt;
             if (end_small_cnt_d1)
				    end_small_cnt_d2 <= 1'b1;
             else
				    end_small_cnt_d2 <= #TP end_small_cnt_d2;
			 end
	 end

	 assign start_da = (rxstate == rxReceiveDA);
	 assign start_lt = (rxstate == rxReceiveLT);
	 assign start_data_cnt = (rxstate == rxReceiveData) & (~tagged_frame);
	 assign start_tagged_cnt = (rxstate == rxReceiveData) & tagged_frame;
	 assign receiving_data = (~rxstate[2]&(rxstate[0] | rxstate[1])); // in DA,LT,DATA status
	 assign receiving_frame = receiving_data |(rxstate[2]&~rxstate[1]&~rxstate[0]); //in DA,LT,Data,FCS status
	 assign receiving_small = start_da | start_lt | ((rxstate == rxReceiveData) & ~end_small_cnt_d2);
	 assign receiving = inband_fcs? receiving_frame:(small_frame? receiving_small:receiving_data);
    assign recv_end = ~receiving_frame;
	 assign bad_frame_get = ((rxstate == rxReceiveFCS) & length_error) | ((rxstate == rxWaitCheck) & (local_invalid | len_invalid | length_error | crc_check_invalid));
	 assign good_frame_get = (rxstate == rxWaitCheck) & crc_check_valid;
endmodule
