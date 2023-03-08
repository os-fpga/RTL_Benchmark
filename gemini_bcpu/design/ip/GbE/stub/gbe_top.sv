module gbe_top (
    // Clocks and resets
    input  logic        clk_apb       ,
    input  logic        rst_n_apb     ,
    input  logic        clk_eth_core  ,
    input  logic        rst_n_eth_core,
    // AXI interface
    output logic [31:0] m0_araddr     ,
    output logic [ 1:0] m0_arburst    ,
    output logic [ 3:0] m0_arcache    ,
    output logic [ 2:0] m0_arid       ,
    output logic [ 7:0] m0_arlen      ,
    output logic        m0_arlock     ,
    output logic [ 2:0] m0_arprot     ,
    input  logic        m0_arready    ,
    output logic [ 2:0] m0_arsize     ,
    output logic        m0_arvalid    ,
    output logic [31:0] m0_awaddr     ,
    output logic [ 1:0] m0_awburst    ,
    output logic [ 3:0] m0_awcache    ,
    output logic [ 2:0] m0_awid       ,
    output logic [ 7:0] m0_awlen      ,
    output logic        m0_awlock     ,
    output logic [ 2:0] m0_awprot     ,
    input  logic        m0_awready    ,
    output logic [ 2:0] m0_awsize     ,
    output logic        m0_awvalid    ,
    input  logic [ 2:0] m0_bid        ,
    output logic        m0_bready     ,
    input  logic [ 1:0] m0_bresp      ,
    input  logic        m0_bvalid     ,
    input  logic [31:0] m0_rdata      ,
    input  logic [ 2:0] m0_rid        ,
    input  logic        m0_rlast      ,
    output logic        m0_rready     ,
    input  logic [ 1:0] m0_rresp      ,
    input  logic        m0_rvalid     ,
    output logic [31:0] m0_wdata      ,
    output logic        m0_wlast      ,
    input  logic        m0_wready     ,
    output logic [ 3:0] m0_wstrb      ,
    output logic        m0_wvalid     ,
    // APB interface
    input  logic [31:0] s0_paddr      ,
    input  logic        s0_psel       ,
    input  logic        s0_penable    ,
    input  logic        s0_pwrite     ,
    input  logic [31:0] s0_pwdata     ,
    output logic [31:0] s0_prdata     ,
    output logic        s0_pready     ,
    output logic        s0_pslverr    ,
    // Etherner interface
    output logic [ 3:0] rgmii_txd     ,
    output logic        rgmii_tx_ctl  ,
    input  logic [ 3:0] rgmii_rxd     ,
    input  logic        rgmii_rx_ctl  ,
    input  logic        rgmii_rxc     ,
    output logic        mdio_mdc      ,
    inout  wire         mdio_data     ,
    output logic        irq
);

    assign m0_araddr    = 'h0;
    assign m0_arburst   = 'h0;
    assign m0_arcache   = 'h0;
    assign m0_arid      = 'h0;
    assign m0_arlen     = 'h0;
    assign m0_arlock    = 'h0;
    assign m0_arprot    = 'h0;
    assign m0_arsize    = 'h0;
    assign m0_arvalid   = 'h0;
    assign m0_awaddr    = 'h0;
    assign m0_awburst   = 'h0;
    assign m0_awcache   = 'h0;
    assign m0_awid      = 'h0;
    assign m0_awlen     = 'h0;
    assign m0_awlock    = 'h0;
    assign m0_awprot    = 'h0;
    assign m0_awsize    = 'h0;
    assign m0_awvalid   = 'h0;
    assign m0_bready    = 'h0;
    assign m0_rready    = 'h0;
    assign m0_wdata     = 'h0;
    assign m0_wlast     = 'h0;
    assign m0_wstrb     = 'h0;
    assign m0_wvalid    = 'h0;
    assign s0_prdata    = 'h0;
    assign s0_pready    = 'h0;
    assign s0_pslverr   = 'h0;
    assign rgmii_txd    = 'h0;
    assign rgmii_tx_ctl = 'h0;
    assign mdio_mdc     = 'h0;
    assign mdio_data    = 'h0;
    assign irq          = 'h0;

endmodule 