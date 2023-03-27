module gbe_top (
	input  logic        tx_clk_sig  ,
	input  logic        tx_clk      ,
	input  logic        rx_clk      ,
	input  logic        n_tx_clk    ,
	input  logic        n_rx_clk    ,
	input  logic        n_txreset   ,
	input  logic        n_rxreset   ,
	input  logic        n_ntxreset  ,
	input  logic        n_nrxreset  ,
	output logic        ethernet_int,
	//apb
	input  logic        pclk        ,
	input  logic        n_preset    ,
	input  logic [11:2] paddr       ,
	output logic [31:0] prdata      ,
	input  logic [31:0] pwdata      ,
	input  logic        pwrite      ,
	input  logic        penable     ,
	input  logic        psel        ,
	output logic        perr        ,
	// AXI interface signals.
	input  logic        aclk        ,
	input  logic        n_areset    ,
	output logic [ 3:0] awid        ,
	output logic [31:0] awaddr      ,
	output logic [ 7:0] awlen       ,
	output logic [ 2:0] awsize      ,
	output logic [ 1:0] awburst     ,
	output logic [ 1:0] awlock      ,
	output logic [ 3:0] awcache     ,
	output logic [ 2:0] awprot      ,
	output logic        awvalid     ,
	input  logic        awready     ,
	output logic [31:0] wdata       ,
	output logic [ 3:0] wstrb       ,
	output logic        wlast       ,
	input  logic        wready      ,
	output logic        wvalid      ,
	input  logic [ 3:0] bid         ,
	input  logic [ 1:0] bresp       ,
	input  logic        bvalid      ,
	output logic        bready      ,
	output logic [ 3:0] arid        ,
	output logic [31:0] araddr      ,
	output logic [ 7:0] arlen       ,
	output logic [ 2:0] arsize      ,
	output logic [ 1:0] arburst     ,
	output logic [ 1:0] arlock      ,
	output logic [ 3:0] arcache     ,
	output logic [ 2:0] arprot      ,
	output logic        arvalid     ,
	input  logic        arready     ,
	input  logic [ 3:0] rid         ,
	input  logic [31:0] rdata       ,
	input  logic [ 1:0] rresp       ,
	input  logic        rlast       ,
	input  logic        rvalid      ,
	output logic        rready      ,
	//GMII
	output logic [ 3:0] rgmii_txd   ,
	output logic        rgmii_tx_ctl,
	input  logic [ 3:0] rgmii_rxd   ,
	input  logic        rgmii_rx_ctl,
	output logic        mdc         ,
	input  logic        mdio_in     ,
	output logic        mdio_out    ,
	output logic        mdio_en
);
	/*output logic        */ assign ethernet_int='d0;
	/*output logic [31:0] */ assign prdata      ='d0;
	/*output logic        */ assign perr        ='d0;
	/*output logic [ 3:0] */ assign awid        ='d0;
	/*output logic [31:0] */ assign awaddr      ='d0;
	/*output logic [ 7:0] */ assign awlen       ='d0;
	/*output logic [ 2:0] */ assign awsize      ='d0;
	/*output logic [ 1:0] */ assign awburst     ='d0;
	/*output logic [ 1:0] */ assign awlock      ='d0;
	/*output logic [ 3:0] */ assign awcache     ='d0;
	/*output logic [ 2:0] */ assign awprot      ='d0;
	/*output logic        */ assign awvalid     ='d0;
	/*output logic [31:0] */ assign wdata       ='d0;
	/*output logic [ 3:0] */ assign wstrb       ='d0;
	/*output logic        */ assign wlast       ='d0;
	/*output logic        */ assign wvalid      ='d0;
	/*output logic        */ assign bready      ='d0;
	/*output logic [ 3:0] */ assign arid        ='d0;
	/*output logic [31:0] */ assign araddr      ='d0;
	/*output logic [ 7:0] */ assign arlen       ='d0;
	/*output logic [ 2:0] */ assign arsize      ='d0;
	/*output logic [ 1:0] */ assign arburst     ='d0;
	/*output logic [ 1:0] */ assign arlock      ='d0;
	/*output logic [ 3:0] */ assign arcache     ='d0;
	/*output logic [ 2:0] */ assign arprot      ='d0;
	/*output logic        */ assign arvalid     ='d0;
	/*output logic        */ assign rready      ='d0;
	/*output logic [ 3:0] */ assign rgmii_txd   ='d0;
	/*output logic        */ assign rgmii_tx_ctl='d0;
	/*output logic        */ assign mdc         ='d0;
	/*output logic        */ assign mdio_out    ='d0;
	/*output logic        */ assign mdio_en     ='d0;




endmodule
