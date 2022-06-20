`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:    16:35:47 11/21/05
// Design Name:    
// Module Name:    rxReceiveEngine
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
module rxReceiveEngine(rxclk_in, reset_in, rxd64, rxc8, rxStatRegPlus,reset_out,
                          cfgRxRegData, rx_data, rx_data_valid, rx_good_frame, link_fault, 
                          rx_bad_frame, rxCfgofRS, rxTxLinkFaul);
    input rxclk_in;
    input reset_in;
    input [63:0] rxd64;
    input [7:0] rxc8;
	 output reset_out;
    output [12:0] rxStatRegPlus;	
    input [52:0] cfgRxRegData;
    output [63:0] rx_data;
    output [7:0] rx_data_valid;
    output rx_good_frame;
    output rx_bad_frame;
	 input [1:0] link_fault;
	 output[2:0] rxCfgofRS;
    output [1:0] rxTxLinkFaul;

    wire rxclk;
	 wire rxclk_180;
	 wire rxclk_2x;
	 wire locked;
	 wire reset_dcm;
	 wire reset;

	 wire [47:0]MAC_Addr;	//MAC Address used in receiving control frame.
    wire      vlan_enable; //VLAN Enable
	 wire      recv_enable; //Receiver Enable
	 wire      inband_fcs;	//In-band FCS Enable, when this bit is '1', the MAC will pass FCS up to client
	 wire      jumbo_enable;//Jumbo Frame Enable
	 wire      recv_rst;		//Receiver reset

	 wire start_da, start_lt;
	 wire tagged_frame, small_frame;
	 wire [15:0] tagged_len;
	 wire end_data_cnt, end_small_cnt, end_tagged_cnt, end_fcs;
	 wire pause_frame;
	 wire [47:0] da_addr;
	 wire [15:0] lt_data;
	 wire [31:0] crc_code;
	 wire [7:0]  crc_valid;
	 wire [7:0]  rxc_fifo;
	 wire length_error;
	 wire get_sfd, get_efd, get_error_code;
	 wire receiving;
	 wire receiving_frame;

	 wire local_invalid;
	 wire broad_valid;
	 wire multi_valid;

	 
	 wire len_invalid;
	 wire [12:0] integer_cnt, small_integer_cnt;	 
	 wire [2:0] bits_more, small_bits_more;
	 wire good_frame_get, bad_frame_get;

	 wire crc_check_valid=0;
	 wire crc_check_invalid=0;


	 //////////////////////////////////////////
	 // Read Receiver Configuration Word
	 //////////////////////////////////////////

	 assign  MAC_Addr = {cfgRxRegData[52:37], cfgRxRegData[31:0]};
	 assign  vlan_enable = cfgRxRegData[36];
	 assign  recv_enable = cfgRxRegData[35];
	 assign  inband_fcs  = cfgRxRegData[34];
	 assign  jumbo_enable = cfgRxRegData[33];
	 assign  recv_rst = cfgRxRegData[32];
    assign  reset_dcm = reset_in | recv_rst;
	 assign  reset = ~locked;
	 assign  reset_out = reset;
	 
	 /////////////////////////////////////////
	 // Write Configuration Words	of RS 
	 /////////////////////////////////////////

	 assign rxCfgofRS[0] = ~link_fault[0] & link_fault[1]; //get local fault
	 assign rxCfgofRS[1] = link_fault[0] & link_fault[1];  //get remote fault
	 assign rxCfgofRS[2] = locked;  //Receive DCM locked
	 
	 ////////////////////////////////////////
	 // Receive Clock Generator
	 //////////////////////////////////////// 

	 rxClkgen rxclk_gen(.rxclk_in(rxclk_in),
	                    .reset(reset_dcm),
							  .rxclk(rxclk), 
							  .rxclk_180(rxclk_180),
							  .rxclk_2x(rxclk_2x), 
							  .locked(locked)
							  );

	 ///////////////////////////////////////
	 // Upper Interface with client
	 ///////////////////////////////////////

	 rxFIFOMgnt upperinterface(.rxclk_180(rxclk_180), .reset(reset), .rxd64(rxd64), .rxc_fifo(rxc_fifo), .receiving(receiving), 
	                           .recv_end(recv_end), .rx_data_valid(rx_data_valid), .inband_fcs(inband_fcs),
										.rx_data(rx_data));

	 ///////////////////////////////////////
	 // Reception Frame Spliter
	 ///////////////////////////////////////

	 rxFrameDepart frame_spliter(.rxclk(rxclk), .reset(reset), .rxclk_180(rxclk_180), .rxd64(rxd64), .rxc8(rxc8),.inband_fcs(inband_fcs), 
	                             .start_da(start_da), .start_lt(start_lt), .tagged_frame(tagged_frame),.bits_more(bits_more),
										  .small_bits_more(small_bits_more), .tagged_len(tagged_len), .small_frame(small_frame), 
										  .end_data_cnt(end_data_cnt), .end_small_cnt(end_small_cnt),.da_addr(da_addr),.lt_data(lt_data),
										  .crc_code(crc_code),.end_fcs(end_fcs), .crc_valid(crc_valid), .length_error(length_error),
						              .get_sfd(get_sfd), .get_efd(get_efd), .get_error_code(get_error_code),.receiving(receiving), 
										  .rxc_fifo(rxc_fifo),.receiving_frame(receiving_frame)
										 );

	 //////////////////////////////////////
	 // Destination Address Checker
	 //////////////////////////////////////

	 rxDAchecker  dachecker(.local_invalid(local_invalid), .broad_valid(broad_valid), .multi_valid(multi_valid), .MAC_Addr(MAC_Addr),
	                        .da_addr(da_addr));
	              defparam dachecker.Multicast = 48'h0180C2000001;
	              defparam dachecker.Broadcast = 48'hffffffffffff;

    /////////////////////////////////////
	 // Length/Type field checker
	 /////////////////////////////////////

	 rxLenTypChecker lenchecker(.lt_data(lt_data), .tagged_len(tagged_len), .jumbo_enable(jumbo_enable), .tagged_frame(tagged_frame),
	                            .pause_frame(pause_frame), .small_frame(small_frame), .len_invalid(len_invalid), .vlan_enable(vlan_enable),
										 .integer_cnt(integer_cnt), .small_integer_cnt(small_integer_cnt), .inband_fcs(inband_fcs),
										 .bits_more(bits_more), .small_bits_more(small_bits_more)
										 );		

	 /////////////////////////////////////
	 // Counters used in Receive Engine
	 /////////////////////////////////////

    rxNumCounter counters(.rxclk(rxclk), .reset(reset), .start_data_cnt(start_data_cnt), .start_tagged_cnt(start_tagged_cnt), .small_frame(small_frame),
                          .integer_cnt(integer_cnt), .small_integer_cnt(small_integer_cnt), .tagged_frame(tagged_frame),
								  .end_data_cnt(end_data_cnt), .end_small_cnt(end_small_cnt), .end_tagged_cnt(end_tagged_cnt)
								  );
 
	 /////////////////////////////////////
	 // State Machine in Receive Process
	 /////////////////////////////////////

    rxStateMachine statemachine(.rxclk(rxclk), .reset(reset), .recv_enable(recv_enable), .get_sfd(get_sfd), .local_invalid(local_invalid), .len_invalid(len_invalid),
	                             .end_data_cnt(end_data_cnt), .end_tagged_cnt(end_tagged_cnt), .tagged_frame(tagged_frame),
										  .length_error(length_error), .end_fcs(end_fcs), .crc_check_valid(crc_check_valid), .get_error_code(get_error_code), 
										  .crc_check_invalid(crc_check_invalid), .start_da(start_da), .start_lt(start_lt), .inband_fcs(inband_fcs),
										  .start_data_cnt(start_data_cnt), .start_tagged_cnt(start_tagged_cnt), .receiving(receiving),
										  .recv_end(recv_end), .good_frame_get(good_frame_get), .bad_frame_get(bad_frame_get), .small_frame(small_frame),
										  .end_small_cnt(end_small_cnt),.receiving_frame(receiving_frame)
										  );
	 assign rx_good_frame = good_frame_get;
	 assign rx_bad_frame = bad_frame_get;  
					   
endmodule
