//author :gurenliang 
//Email: gurenliang@gmail.com
//note: if there are some errors, you are welcome to contact me. It would be the best appreciation to me.


//version 0.3 correct some minor errors
//version 0.3 add the option of frameID mode, by include common.v and judge the macro-varible frameIDfromRx
//The top layer module provided full functions
`include "common.v"

module EthernetModule(reset, clk_10K, 
					ff_clk, ff_en_source, ff_en_sink, ff_data_source, ff_data_sink,  //ff_clk should be a 270.33KHz clock
					phy_rxd, phy_rxen, phy_rxclk, phy_rxer,
					phy_txd, phy_txen, phy_txclk, phy_txer,
					phy_reset, phy_col, phy_linksts, phy_crs,
					test1, test2, test3, test4
					);
	input reset, clk_10K, ff_clk;
	output phy_reset, test1, test2, test3, test4;
	
	input ff_en_sink, ff_data_sink;		//sink is used to receive data from the demodulate module
	output ff_en_source, ff_data_source;//source is used to provide the modulation module with data get from ethernet
	
	input[3:0] phy_rxd;			//MII interface for the phy chip
	input phy_rxclk, phy_rxer;
	
	output[3:0] phy_txd;
	output phy_txer, phy_txen;
	
	//declare them as inout port because when powerup reset, they act as output pins to config DM9161
	//after reset, phy_txclk and phy_rxen must be input ports
	inout phy_txclk, phy_col, phy_rxen, phy_linksts, phy_crs;
	
	wire out_en;	
	wire rxen_in, txclk_in;
	
	`ifdef frameIDfromRx
		wire[23:0] frameid;		//share the frameid between TxModule and RxModule
	`endif
	
	wire empty, start;
	
	InitModule initModule_inst(.init_clk(clk_10K), .reset(reset), .phy_reset(phy_reset), .out_en(out_en));
	
	tri_state  tri_state_inst1(.d_in(txclk_in	), .d_out(1'b0), .out_en(out_en), .ioport(phy_txclk));
	tri_state  tri_state_inst2(.d_in(			), .d_out(1'b0), .out_en(out_en), .ioport(phy_col));
	tri_state  tri_state_inst3(.d_in(rxen_in	), .d_out(1'b0), .out_en(out_en), .ioport(phy_rxen));
	tri_state  tri_state_inst4(.d_in(			), .d_out(1'b0), .out_en(out_en), .ioport(phy_linksts));
	tri_state  tri_state_inst5(.d_in(			), .d_out(1'b1), .out_en(out_en), .ioport(phy_crs));
		
	TxModule TxModule_inst(.reset(out_en),
				.phy_txd(phy_txd), .phy_txen(phy_txen), .phy_txclk(txclk_in), .phy_txer(phy_txer),
				.ff_clk(ff_clk), .ff_en(ff_en_sink), .ff_data(ff_data_sink), 
				`ifdef frameIDfromRx
				.frameid(frameid), 
				`endif
				.start(start),
				.test1(), .test2(), .test3(), .test4());
				//.test1(test1), .test2(test2), .test3(test3), .test4(test4));

	RxModule RxModule_inst(.phy_rxd(phy_rxd), .phy_rxen(rxen_in), .phy_rxclk(phy_rxclk), .phy_rxer(phy_rxer),
				.ff_clk(ff_clk), .ff_data(ff_data_source), .ff_en(ff_en_source), 
				`ifdef frameIDfromRx
				.frameid(frameid), 
				`endif
				.start(start),
				//.test1(), .test2(), .test3(), .test4());
				.test1(test1), .test2(test2), .test3(test3), .test4(test4));
				
endmodule
