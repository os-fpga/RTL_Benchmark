//author :Renliang Gu
//Email: gurenliang@gmail.com
//note: if there are some errors, please feel free to contact me. Thank you very much!

//version 0.4, the test_feedback is created, main task is to test the top module, EthernetModule.v
//				the ff_data_source is feed back to ff_data_sink

module test_feedback(reset, clk_in, 
					phy_rxd, phy_rxen, phy_rxclk, phy_rxer,
					phy_txd, phy_txen, phy_txclk, phy_txer,
					phy_reset, phy_col, phy_linksts, phy_crs,
					test1, test2, test3, test4
					);
	input reset, clk_in;
	output phy_reset, test1, test2, test3, test4;
	
	input[3:0] phy_rxd;			//MII interface for the phy chip
	input phy_rxclk, phy_rxer;
	
	output[3:0] phy_txd;
	output phy_txer, phy_txen;
	
	//declare them as inout port because when powerup reset, they act as output pins to config DM9161
	//after reset, phy_txclk and phy_rxen must be input ports
	inout phy_txclk, phy_col, phy_rxen, phy_linksts, phy_crs;
	
	wire ff_en, ff_data;
	wire clk_10K, ff_clk;
	
	EthernetModule EthernetModule_inst(.reset(reset), .clk_10K(clk_10K), 
					.ff_clk(ff_clk), .ff_en_source(ff_en), .ff_en_sink(1'b1), 
					.ff_data_source(ff_data), .ff_data_sink(ff_data),  //ff_clk should be a 270.33KHz clock
					.phy_rxd(phy_rxd), .phy_rxen(phy_rxen), .phy_rxclk(phy_rxclk), .phy_rxer(phy_rxer),
					.phy_txd(phy_txd), .phy_txen(phy_txen), .phy_txclk(phy_txclk), .phy_txer(phy_txer),
					.phy_reset(phy_reset), .phy_col(phy_col), .phy_linksts(phy_linksts), .phy_crs(phy_crs),
					.test1(test1), .test2(test2), .test3(test3), .test4(test4)
					);
					
	pll	pll_inst (
	.inclk0 ( clk_in ),
	.c0 ( clk_10K ),
	.c1 ( ff_clk )
	);

endmodule
