//author :Renliang Gu
//Email: gurenliang@gmail.com
//note: if there are some errors, please feel free to contact me. Thank you very much!

//Next step, reduce the resource consumed

//version 0.5, defined many parameter to configure the IP core, making it easier to use.
//vertion 0.4, add the function for TxModule to get start in a configurable ff_clk time after 
//				RxModule receiving the first frame. To modify the delay time just to 
//				change the value of the macro-variable delay_cnt_config.
//version 0.3, changed the changes made by version 0.2 back
//version 0.2, set empty when ff_data_buf_index's less significant bits is 3'b111 or 3'b000

`include "common.v"

`define IDXlen			3		//2^IDXlen should be the number of cyclic queue
`define queue_len		(1<<3)	//define the length of the cyclic queue

`define rx_crc_offset	(`data_offset+(`uframelen*`num_uframe/4))	//index of first bit of crc
`define rx_total_len	(`rx_crc_offset + (4<<1))
`define rxdata_len		(`uframelen*`num_uframe/4)

`define delay_cnt_config	8	//the initiation value for the delay_cnt

module RxModule(phy_rxd, phy_rxen, phy_rxclk, phy_rxer,
				ff_clk, ff_data, ff_en, 
				
				`ifdef frameIDfromRx
					frameid, 
				`endif
				
				start,
				test1, test2, test3, test4
				);
	input phy_rxen, phy_rxclk, phy_rxer;	//MII interface
	input [3:0] phy_rxd;
	
	input ff_clk;			//270.8333KHz
	output ff_data, ff_en;
	
	`ifdef frameIDfromRx
		output[`frameidlen-1:0] frameid;
		reg[`frameidlen-1:0] frameid;
	`endif
	
	output start;			//to tell TxModule that buf in RxModule needs data
	output test1, test2, test3, test4;
	reg test1, test2;
	
	parameter delay_cnt_len =   (`delay_cnt_config <    2) ? 1 : (`delay_cnt_config <    4) ? 2 :
								(`delay_cnt_config <    8) ? 3 : (`delay_cnt_config <   16) ? 4 :
								(`delay_cnt_config <   32) ? 5 : (`delay_cnt_config <   64) ? 6 :
								(`delay_cnt_config <  128) ? 7 : 8;
	parameter nibble_idx_len = 	(`rx_total_len<=   2)?  1 : (`rx_total_len<=   4)?  2 :
								(`rx_total_len<=   8)?  3 : (`rx_total_len<=  16)?  4 :
								(`rx_total_len<=  32)?  5 : (`rx_total_len<=  64)?  6 :
								(`rx_total_len<= 128)?  7 : (`rx_total_len<= 256)?  8 :
								(`rx_total_len<= 512)?  9 : (`rx_total_len<=1024)? 10 : 
								(`rx_total_len<=2048)? 11 : 12;
	parameter ff_idx_len = 	(`rxdata_len<=   2)? 1 : (`rxdata_len<=   4)? 2 :
							(`rxdata_len<=   8)? 3 : (`rxdata_len<=  16)? 4 :
							(`rxdata_len<=  32)? 5 : (`rxdata_len<=  64)? 6 :
							(`rxdata_len<= 128)? 7 : (`rxdata_len<= 256)? 8 :
							(`rxdata_len<= 512)? 9 : (`rxdata_len<=1024)?10 :
							(`rxdata_len<=2048)?11 : 12;							
	parameter frameid_idx_len = ((`frameidlen>>2)<=  2)? 1 : ((`frameidlen>>2)<=  4)? 2 :
								((`frameidlen>>2)<=  8)? 3 : ((`frameidlen>>2)<= 16)? 4 :
								((`frameidlen>>2)<= 32)? 5 : ((`frameidlen>>2)<= 64)? 6 : 
								((`frameidlen>>2)<= 64)? 7 : 8;
	parameter ff_cnt_len  =	(`uframelen <    2) ? 1 : (`uframelen <    4) ? 2 :
							(`uframelen <    8) ? 3 : (`uframelen <   16) ? 4 :
							(`uframelen <   32) ? 5 : (`uframelen <   64) ? 6 :
							(`uframelen <  128) ? 7 : (`uframelen <  256) ? 8 :
							(`uframelen <  512) ? 9 : (`uframelen < 1024) ? 10:
							(`uframelen < 2048) ? 11: (`uframelen < 4096) ? 12:
							(`uframelen < 8192) ? 13: 14;
	
	reg ff_data;
	reg ff_en;

	reg[ff_cnt_len-1:0] ff_cnt;
	reg[2:0] ff_d;
	
	reg start=1'b0;
	reg start_intra=1'b0;
	reg[delay_cnt_len-1:0] delay_cnt;
	
	reg[3:0] gap_cnt;
	reg[1:0] gap_len_ctl;
	reg[1:0] cycle;
	
	reg[3:0] rxdata_buf [0:(`rxdata_len*`queue_len+1)];	//more ram for special usage
	wire[ff_idx_len+`IDXlen-1:0] rxdata_buf_writer_address;
	reg[ff_idx_len+`IDXlen-1:0] rxdata_buf_reader_address;
	
	reg[`frameidlen-1:0] frameid_buf[0:(`queue_len-1)];
	
	reg[nibble_idx_len-1:0] nibble_idx;
	reg[ff_idx_len-1:0] ff_idx;
	
	reg[`IDXlen-1:0] rxIDX, ffIDX;
	
	reg bad_da;
	reg queue_empty;
	
	reg[2:0] rxState = 0;
	parameter s_preamble = 0, s_address = 1, s_typelen = 2, 
				s_frameid = 3, s_data = 4, s_crc = 5;
	reg[1:0] ff_state = 0;
	parameter ffs_idle = 0, ffs_transfer = 1, ffs_gap = 2;
	
	wire[47:0] mac_add;
	wire[3:0] da[0:11];
	assign mac_add = `MAC_ADD;
	assign da[ 0] = mac_add[ 3: 0];
	assign da[ 1] = mac_add[ 7: 4];
	assign da[ 2] = mac_add[11: 8];
	assign da[ 3] = mac_add[15:12];
	assign da[ 4] = mac_add[19:16];
	assign da[ 5] = mac_add[23:20];
	assign da[ 6] = mac_add[27:24];
	assign da[ 7] = mac_add[31:28];
	assign da[ 8] = mac_add[35:32];
	assign da[ 9] = mac_add[39:36];
	assign da[10] = mac_add[43:40];
	assign da[11] = mac_add[47:44];
	
	assign test4 = start_intra;
	assign test3 = start;

	always@(posedge phy_rxclk)begin			//control the increasing of nibble_idx;
		if(phy_rxen & ~phy_rxer)			//data is valid and no error
			nibble_idx <= nibble_idx + 1;
		else
			nibble_idx <= 0;
	end
	
	always@(posedge phy_rxclk)begin
		if(phy_rxen & ~phy_rxer)
			case (rxState)
				s_preamble:
					if(nibble_idx == `da_offset-1)		rxState <= s_address;
					else 								rxState <= s_preamble;
				
				s_address: 
					if(nibble_idx == `typelen_offset-1)	rxState <= s_typelen;
					else								rxState <= s_address;
				
				s_typelen:
					if(nibble_idx == `frameid_offset-1)	rxState <= s_frameid;
					else								rxState <= s_typelen;
				
				s_frameid:
					if(nibble_idx == `data_offset-1)	rxState <= s_data;
					else								rxState <= s_frameid;
			
				s_data:
					if(nibble_idx == `rx_crc_offset-1)		rxState <= s_crc;
					else								rxState <= s_data;
	
				s_crc:
					if(nibble_idx == `rx_total_len-1)		rxState <= s_preamble;
					else								rxState <= s_crc;
					
				default: 								rxState <= rxState;
			endcase
		else
			rxState <= s_preamble;
	end
	
	assign rxdata_buf_writer_address = rxIDX*`rxdata_len + nibble_idx - `data_offset;
	
	always@(posedge phy_rxclk)begin			//receive data from Ethernet including the preamble, SFD and CRC
		if(phy_rxen & ~phy_rxer) begin		//data is valid and no error
			case (rxState)
				s_preamble: test1 <= ~test1;
				s_address:
					if((phy_rxd!=da[nibble_idx-`da_offset])&(nibble_idx < `sa_offset))
						bad_da <= 1;
	
				s_frameid: begin
					if(nibble_idx==`frameid_offset) begin 
						rxIDX <= phy_rxd[2:0];
						frameid_buf[phy_rxd[2:0]][(`frameidlen-1):(`frameidlen-4)]  <= phy_rxd;
					end else
						frameid_buf[rxIDX] <= {phy_rxd, frameid_buf[rxIDX][(`frameidlen-1):4]};
				end
				
				s_data: begin
					//test2 <= ~test2;
					rxdata_buf[rxdata_buf_writer_address] <= phy_rxd;
				end
			endcase
		end	else if ((nibble_idx == `rx_total_len ) & (!bad_da)) begin
		//one frame has been transfered over, the destinate address is right and then been put into the buffer
			start_intra <= 1;
		end	else
			bad_da <= 0;
	end
	
	always@(negedge ff_clk) begin
		case(ff_state)
			ffs_idle: begin			//wait the first frame to come
				gap_len_ctl <= 0;
				if(start_intra)	ff_state <= ffs_transfer;
				else ff_state <= ffs_idle;
			end
				
			ffs_transfer: begin
				if(ff_cnt == `uframelen-1)begin	//every `uframelen bit need a gap
					ff_state <= ffs_gap;
					gap_len_ctl <= gap_len_ctl + 1;
				end	
				else ff_state <= ffs_transfer;
			end
			ffs_gap: begin
				if(((gap_len_ctl == 0)&(gap_cnt == 8)) | ((gap_len_ctl != 0)&(gap_cnt == 7)))
					ff_state <=ffs_transfer;
				else ff_state <= ffs_gap;
			end
		endcase
	end
	
	always@(negedge ff_clk) begin				//flow the data out of the buffer
		case(ff_state)
			ffs_idle: begin
				ff_cnt <= 0;
				delay_cnt <= 0;
				cycle <= 0;
				ff_en <= 0;
				ff_idx <= 0;
				ffIDX <= rxIDX + 1;
				start <= 0;
				rxdata_buf_reader_address <= ffIDX*`rxdata_len+ff_idx;
			end
						
			ffs_transfer: begin
				`ifdef frameIDfromRx
					frameid <= frameid_buf[ffIDX];
				`endif
				if(delay_cnt == `delay_cnt_config) start <= 1;
				delay_cnt <= delay_cnt + 1;
				gap_cnt <= 0;
				ff_cnt <= ff_cnt + 1;
				cycle <= cycle + 1;
				ff_en <= 1;
				
				if(cycle==0) begin
					{ff_d[2:0],ff_data} <= rxdata_buf[rxdata_buf_reader_address];
					if(ff_idx == `rxdata_len-1)begin
						if(ffIDX!=rxIDX) begin
							queue_empty <= 0;
							if(queue_empty) begin
								ffIDX <= rxIDX + ((`delay_cnt_config==0)? 1:2) ;
								rxdata_buf_reader_address <= (rxIDX + ((`delay_cnt_config==0)? 1:2))*`rxdata_len;
							end
							else begin
								ffIDX <= ffIDX + 1;
								rxdata_buf_reader_address <= (ffIDX+1)*`rxdata_len;
							end
						end else begin
							rxdata_buf_reader_address <= ffIDX*`rxdata_len;
							queue_empty <= 1;
						end
						ff_idx <= 0;
					end
					else begin
						ff_idx <= ff_idx + 1;	
						rxdata_buf_reader_address <= ffIDX*`rxdata_len+ff_idx+1;
					end
				end else
					{ff_d[1:0],ff_data} <= ff_d;
			end
			
			ffs_gap: begin		//the 8.25 bit gap is implement by (3*8+9)/4
				ff_en <= 0;
				ff_data <= 0;
				ff_cnt <= 0;
				gap_cnt <= gap_cnt + 1;
			end
		endcase
	end
endmodule