//author :Renliang Gu
//Email: gurenliang@gmail.com
//note: if there are some errors, please feel free to contact me. Thank you very much!


//Next step, add ff_data control to show the IP is busy

//version 0.3, declared a new variable data_av, and use it to start sending frame.
//version 0.3, delete the usage of pre_buf, and rename the pre to preaddlt
//version 0.3, add the option of frameID mode, by include common.v and judge the macro-varible frameIDfromRx
//This module is used to receive data from the demodulate module and send the data to the Ethernet PHY chip

`include "common.v"

`define tx_crc_offset	(`data_offset+((`uframelen+8)*`num_uframe/4)+2)	//index of first bit of crc
`define tx_total_len	(`tx_crc_offset + (4<<1))

`define txdata_len		   (((`uframelen+8)*`num_uframe/4)+2)
`define less_than_a_nibble 1	//0.25*8=2
`define last_cycle_val	2		//0.25*8=2

`define preaddlt_len	(`data_offset<<2)

module TxModule(reset, phy_txd, phy_txen, phy_txclk, phy_txer,
				ff_clk, ff_en, ff_data,

				`ifdef frameIDfromRx
					frameid, 
				`endif
				
				start,
				test1, test2, test3, test4);
	parameter nibble_idx_len = 	(`tx_total_len<=  2)? 1 : (`tx_total_len<=  4)? 2 :
								(`tx_total_len<=  8)? 3 : (`tx_total_len<= 16)? 4 :
								(`tx_total_len<= 32)? 5 : (`tx_total_len<= 64)? 6 :
								(`tx_total_len<=128)? 7 : (`tx_total_len<=256)? 8 :
								(`tx_total_len<=512)? 9 : (`tx_total_len<=1024)? 10 :
								(`tx_total_len<=2048)? 11 : 12;
	parameter ff_idx_len = 	(`txdata_len<=  2)? 1 : (`txdata_len<=  4)? 2 :
							(`txdata_len<=  8)? 3 : (`txdata_len<= 16)? 4 :
							(`txdata_len<= 32)? 5 : (`txdata_len<= 64)? 6 :
							(`txdata_len<=128)? 7 : (`txdata_len<=256)? 8 :
							(`txdata_len<=512)? 9 : (`txdata_len<=1024)? 10 : 11;

	input phy_txclk, reset;
	input ff_clk, ff_en, ff_data;	//ff_clk should be 207.83333KHz
	
	`ifdef frameIDfromRx
		input[`frameidlen-1:0] frameid;			//get the frameid information from RxModule
		reg[`frameidlen-1:0] frameid_buf[0:1];
	`endif
	`ifdef frameIDcount
		reg[`frameidlen-1:0] frameid=0;
	`endif
	reg[`frameidlen-1:0] frameid_reg;
	
	input  start;					//decide whether should give out the "need-data" ethernet package
	output [3:0] phy_txd;			//MII
	output phy_txen, phy_txer;
	
	output test1, test2, test3, test4;
	reg test1;//, test2, test3, test4;
	
	reg[3:0] phy_txd;
	reg phy_txen;
	
	reg[`preaddlt_len-1:0] preaddlt;
	
	reg[3:0] txdata_buf[0:`txdata_len*2-1];	//two buffer helps to step over different frame seamlessly
	reg[ff_idx_len:0] txdata_buf_reader_address;
		
	reg[nibble_idx_len-1:0] nibble_idx;
	wire data_av;
	
	reg Enable_Crc, Initialize_Crc;		//declare the variables for the CRC module
	wire [3:0] Data_Crc;
	wire CrcError;
	wire [31:0] Crc;
	
	wire txIDX;
	reg[1:0] cycle;
	reg ffIDX, ffIDX1, ffIDX2;
	reg[ff_idx_len-1:0] ff_idx;
	reg[2:0] ff_d;
	
	// Declare state register
	reg	[2:0]txState;
	parameter s_idle = 3'h0, s_preamble = 3'h1, s_address = 3'h2, s_data = 3'h3, s_crc =3'h4;
	
	assign test2 = txState[2];
	assign test3 = txState[1];
	assign test4 = txState[0];
	
	always @ (posedge ff_clk) begin		//receive data from demodulate module every bit one by one
		if(ff_en & start) begin
			`ifdef frameIDfromRx
				if((ff_idx==0)&&(cycle==0)) frameid_buf[ffIDX] <= frameid;
			`endif
			
			cycle <= cycle + 1;			 
			if((cycle==3)||
				((cycle == `last_cycle_val-1)&&(ff_idx==(`txdata_len-1-`less_than_a_nibble)))) begin
				
				txdata_buf[ffIDX*`txdata_len+ff_idx] <= ({ff_data,ff_d}>>(3-cycle));
				if (ff_idx == (`txdata_len-1-`less_than_a_nibble)) begin
					ffIDX <= ~ffIDX;
					ff_idx <= 0;
					cycle <= 0;
					//every time a frame being sent, frameID increases one
					`ifdef frameIDcount
						frameid <= frameid + 1;
					`endif
				end
				else begin
					ff_idx <= ff_idx + 1;
				end
				
			end else begin
				ff_d <= {ff_data, ff_d[2:1]};
			end
		end
		else begin
			ff_idx <= 0;
			cycle <= 0;
		end
	end
	
	assign phy_txer = 1'b0;
	assign data_av = ffIDX1 ^ ffIDX2;
	assign txIDX = ~ffIDX;
	
	always @ (negedge phy_txclk) begin 	//state machine run to send out the MAC frame
		ffIDX2 <= ffIDX1;
		ffIDX1 <= ffIDX;
	end
	
	// Determine the next state
	always @ (negedge phy_txclk) begin	//state machine run to send out the MAC frame
		if (reset)
			txState <= s_idle;
		else begin
			case (txState)
				s_idle: begin		//wait to be trigged
					test1 <= ~test1;
					if(data_av) begin	//once be trigged, prepare the data to send
						txState <= s_preamble;
					end
					else txState <= s_idle;
				end
				
				s_preamble:			//send the preambles
					if(nibble_idx == `da_offset-1)
						txState <= s_address;
					else
						txState <= s_preamble;
						
				s_address: begin		//send the destination address, source address and type
					if(nibble_idx== `data_offset-1)
						txState <= s_data;
					else
						txState <= s_address;
				end
				s_data:					//send data to PHY, every time four bits, lower bits go first
					//test2 <= ~test2;
					if (nibble_idx == `tx_crc_offset-1)
						txState <= s_crc;
					else txState <= s_data;
				
				s_crc:
					if (nibble_idx == `tx_total_len-1)
						txState <= s_idle;
					else txState <= s_crc;
				
				default: 
					txState <= s_idle;
			endcase
		end
	end
	
	always @ (negedge phy_txclk) begin 	//state machine run to send out the MAC frame
		if (reset)
			nibble_idx <= 0;
		else if(txState==s_idle)
			nibble_idx <= 0;
		else
			nibble_idx <= nibble_idx + 1;
	end
	
	always @ (negedge phy_txclk) begin 	//state machine run to send out the MAC frame
		if (reset)
			phy_txd <= 4'h0;
		else 
			case (txState)
				s_idle: begin
					//already stored MAC preamble, dest address and source address from right to left. 
					//decide whether should ask PC for new frame
					/*if(empty) preaddlt <= {16'h0008, `MAC_ADD, `PC_MAC_ADD, `Preamble};	
					else*/
					`ifdef frameIDfromRx
						preaddlt <= {frameid_buf[txIDX], 16'h0000, `MAC_ADD, `PC_MAC_ADD, `Preamble};
					`endif
					`ifdef frameIDcount
						preaddlt <= {frameid, 16'h0000, `MAC_ADD, `PC_MAC_ADD, `Preamble};
					`endif
				end
				s_preamble:
					{preaddlt[`preaddlt_len-5:0], phy_txd} <= preaddlt;
				s_address: begin
					{preaddlt[`preaddlt_len-5:0], phy_txd} <= preaddlt;
					txdata_buf_reader_address <= (txIDX*(`txdata_len));
				end
				s_data: begin
					txdata_buf_reader_address <= (txIDX*(`txdata_len))+nibble_idx-`data_offset+1;
					phy_txd <= txdata_buf[txdata_buf_reader_address];
				end
				s_crc: begin
					phy_txd[3] <= ~Crc[28];	//Special, the usage of the CRC_Module
					phy_txd[2] <= ~Crc[29];
					phy_txd[1] <= ~Crc[30];
					phy_txd[0] <= ~Crc[31];
				end
				default:
					phy_txd <= 4'h0;
			endcase
	end
	
	always @ (negedge phy_txclk) begin 	//state machine run to send out the MAC frame
		if (reset)
			phy_txen <= 1'b0;
		else if((txState==s_preamble)||(txState==s_address)||(txState==s_data)||(txState==s_crc))
			phy_txen <= 1'b1;
		else
			phy_txen <= 1'b0;
	end
	
	always @ (negedge phy_txclk) begin 	//state machine run to send out the MAC frame
		if (reset)
			Initialize_Crc <= 1'b0;
		else if(txState==s_preamble)
			Initialize_Crc <= 1'b1;		//prepare the CRC_Module for the following addresses
		else
			Initialize_Crc <= 1'b0;
	end
	
	always @ (negedge phy_txclk) begin 	//state machine run to send out the MAC frame
		if (reset)
			Enable_Crc <= 1'b0;
		else if((txState==s_address)||(txState==s_data))
			Enable_Crc <= 1'b1;		//enable the CRC_Module
		else
			Enable_Crc <= 1'b0;
	end

	assign Data_Crc[0] = phy_txd[3];	//input prepare for CRC_Module
	assign Data_Crc[1] = phy_txd[2];
	assign Data_Crc[2] = phy_txd[1];
	assign Data_Crc[3] = phy_txd[0];
	
	// Connecting module Crc
	CRC_Module txcrc (.Clk(phy_txclk), .Reset(reset), .Data(Data_Crc), .Enable(Enable_Crc), .Initialize(Initialize_Crc), 
               .Crc(Crc), .CrcError(CrcError));
              
endmodule