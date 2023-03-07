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



logic        rxdpram_wea  ;
logic        rxdpram_ena  ;
logic [ 8:0] rxdpram_addra;
logic [31:0] rxdpram_dia  ;
logic        rxdpram_enb  ;
logic [ 8:0] rxdpram_addrb;
logic [31:0] rxdpram_dob  ;
logic        rxdpram_web  ;

logic        txdpram_wea  ;
logic        txdpram_ena  ;
logic [ 8:0] txdpram_addra;
logic [31:0] txdpram_dia  ;
logic        txdpram_enb  ;
logic [ 8:0] txdpram_addrb;
logic [31:0] txdpram_dob  ;
logic        txdpram_web  ;

logic        rx_b_oe_r    ;
logic        tx_b_oe_r    ;

wire         vdd_w        ;
wire         vss_w        ;

//*****************************************************************************
//             GbE declaration
//*****************************************************************************

gem_gxl gem_top_u (
	.tx_clk_sig                (tx_clk_sig   ), // Slightly delayed version of tx_clk
	.tx_clk                    (tx_clk       ),
	.rx_clk                    (rx_clk       ),
	.n_tx_clk                  (n_tx_clk     ),
	.n_rx_clk                  (n_rx_clk     ),
	.n_txreset                 (n_txreset    ),
	.n_rxreset                 (n_rxreset    ),
	.n_ntxreset                (n_ntxreset   ),
	.n_nrxreset                (n_nrxreset   ),
	.ethernet_int              (ethernet_int ),
	//APB
	.pclk                      (pclk         ),
	.n_preset                  (n_preset     ),
	.paddr                     (paddr        ),
	.prdata                    (prdata       ),
	.pwdata                    (pwdata       ),
	.pwrite                    (pwrite       ),
	.penable                   (penable      ),
	.psel                      (psel         ),
	.perr                      (perr         ),
	//AXI
	.aclk                      (aclk         ),
	.n_areset                  (n_areset     ),
	.awid                      (awid         ), // tied low
	.awaddr                    (awaddr       ),
	.awlen                     (awlen        ),
	.awsize                    (awsize       ),
	.awburst                   (awburst      ), // tied to 2’b01
	.awlock                    (awlock       ), // tied low
	.awvalid                   (awvalid      ),
	.awready                   (awready      ),
	.wdata                     (wdata        ),
	.wstrb                     (wstrb        ),
	.wlast                     (wlast        ),
	.wready                    (wready       ),
	.wvalid                    (wvalid       ),
	.bid                       (bid          ), // Not used by IP
	.bresp                     (bresp        ),
	.bvalid                    (bvalid       ),
	.bready                    (bready       ),
	.arid                      (arid         ), // tied low
	.araddr                    (araddr       ),
	.arlen                     (arlen        ),
	.arsize                    (arsize       ),
	.arburst                   (arburst      ), // tied to 2’b01.
	.arlock                    (arlock       ), // tied low
	.arcache                   (arcache      ),
	.arprot                    (arprot       ),
	.arvalid                   (arvalid      ),
	.arready                   (arready      ),
	.rdata                     (rdata        ),
	.rresp                     (rresp        ),
	.rlast                     (rlast        ),
	.rvalid                    (rvalid       ),
	.rready                    (rready       ),
	.rid                       (rid          ), // Not used by IP
	.awcache                   (awcache      ),
	.awprot                    (awprot       ),
	.arqos                     (             ), // Not used by SoC
	.awqos                     (             ), // Not used by SoC
	.wid                       (             ), // tied low

	.rgmii_txd                 (rgmii_txd    ),
	.rgmii_tx_ctl              (rgmii_tx_ctl ),
	.rgmii_rxd                 (rgmii_rxd    ),
	.rgmii_rx_ctl              (rgmii_rx_ctl ),
	.rgmii_link_status         (             ), // Not used by SoC
	.rgmii_speed               (             ), // Not used by SoC
	.rgmii_duplex_out          (             ), // Not used by SoC
	.tx_er                     (             ), // Not used by SoC
	.rx_er                     (1'b0         ),
	.col                       (1'b0         ),
	.crs                       (1'b0         ),
	.mdc                       (mdc          ),
	.mdio_in                   (mdio_in      ),
	.mdio_out                  (mdio_out     ),
	.mdio_en                   (mdio_en      ),
	.loopback                  (             ), // Not used by SoC
	.half_duplex               (             ), // Not used by SoC
	.speed_mode                (             ), // Not used by SoC
	.ext_interrupt_in          (1'b0         ),
	.tx_pause                  (1'b0         ),
	.tx_pause_zero             (1'b0         ),
	.tx_pfc_sel                (1'b0         ),
	.tx_pfc_pause              (8'b0         ),
	.tx_pfc_pause_zero         (8'b0         ),
	.pfc_negotiate             (             ), // Not used by SoC
	.rx_pfc_paused             (             ), // Not used by SoC
	.wol                       (             ), // Not used by SoC
	.ext_match1                (1'b0         ),
	.ext_match2                (1'b0         ),
	.ext_match3                (1'b0         ),
	.ext_match4                (1'b0         ),
	.ext_da                    (             ), // Not used by SoC
	.ext_da_stb                (             ), // Not used by SoC
	.ext_sa                    (             ), // Not used by SoC
	.ext_sa_stb                (             ), // Not used by SoC
	.ext_type                  (             ), // Not used by SoC
	.ext_type_stb              (             ), // Not used by SoC
	.ext_ip_sa                 (             ), // Not used by SoC
	.ext_ip_sa_stb             (             ), // Not used by SoC
	.ext_ip_da                 (             ), // Not used by SoC
	.ext_ip_da_stb             (             ), // Not used by SoC
	.ext_source_port           (             ), // Not used by SoC
	.ext_sp_stb                (             ), // Not used by SoC
	.ext_dest_port             (             ), // Not used by SoC
	.ext_dp_stb                (             ), // Not used by SoC
	.ext_ipv6                  (             ), // Not used by SoC
	.ext_vlan_tag1             (             ), // Not used by SoC
	.ext_vlan_tag1_stb         (             ), // Not used by SoC
	.ext_vlan_tag2             (             ), // Not used by SoC
	.ext_vlan_tag2_stb         (             ), // Not used by SoC
	.gem_tsu_ms                (1'b1         ), //
	.gem_tsu_inc_ctrl          (2'b11        ),
	.tsu_timer_cnt             (             ), // Not used by SoC
	.tsu_timer_cmp_val         (             ), // Not used by SoC
	.sof_tx                    (             ), // Not used by SoC
	.sync_frame_tx             (             ),
	.delay_req_tx              (             ),
	.pdelay_req_tx             (             ),
	.pdelay_resp_tx            (             ),
	.sof_rx                    (             ),
	.sync_frame_rx             (             ),
	.delay_req_rx              (             ),
	.pdelay_req_rx             (             ),
	.pdelay_resp_rx            (             ),
	.dma_bus_width             (             ), // Not used by SoC
	.trigger_dma_tx_start      (1'b0         ), // ??
	//DPRAM
	.rxdpram_wea               (rxdpram_wea  ),
	.rxdpram_ena               (rxdpram_ena  ),
	.rxdpram_addra             (rxdpram_addra),
	.rxdpram_dia               (rxdpram_dia  ),
	.rxdpram_web               (rxdpram_web  ), // tied low
	.rxdpram_enb               (rxdpram_enb  ),
	.rxdpram_addrb             (rxdpram_addrb),
	.rxdpram_dob               (rxdpram_dob  ),

	.txdpram_wea               (txdpram_wea  ),
	.txdpram_ena               (txdpram_ena  ),
	.txdpram_addra             (txdpram_addra),
	.txdpram_dia               (txdpram_dia  ),
	.txdpram_web               (txdpram_web  ), // tied low
	.txdpram_enb               (txdpram_enb  ),
	.txdpram_addrb             (txdpram_addrb),
	.txdpram_dob               (txdpram_dob  ),

	.rx_databuf_wr_q0          (             ), // Not used by SoC
	.halfduplex_flow_control_en(1'b0         ), // Not used by SoC
	.asf_trans_to_err          (             ), // Not used by SoC
	.asf_protocol_err          (             ), // Not used by SoC
	.asf_int_nonfatal          (             ), // Not used by SoC
	.asf_int_fatal             (             ), // Not used by SoC
	.loopback_local            (             )  // Not used by SoC
);


//*****************************************************************************
//            DPRAM declaration
//*****************************************************************************

always @(posedge aclk, negedge n_areset) begin
	if (!n_areset) rx_b_oe_r <= 1'b0;
	else           rx_b_oe_r <= !rxdpram_web && rxdpram_enb;
end

dti_dp_tm16fcll_512x32_4ww2xoe_m_hc mem_512x32_rx_u (
	.VDD    (vdd_w        ),
	.VSS    (vss_w        ),
	.DO_A   (             ),
	.A_A    (rxdpram_addra),
	.DI_A   (rxdpram_dia  ),
	.CE_N_A (~rxdpram_ena ),
	.GWE_N_A(~rxdpram_wea ),
	.OE_N_A (1'b1         ),
	.T_RWM_A(3'b011       ),
	.CLK_A  (rx_clk       ),
	
	.DO_B   (rxdpram_dob  ),
	.A_B    (rxdpram_addrb),
	.DI_B   (32'b0        ),
	.CE_N_B (~rxdpram_enb ),
	.GWE_N_B(~rxdpram_web ),
	.OE_N_B (~rx_b_oe_r   ),
	.T_RWM_B(3'b011       ),
	.CLK_B  (aclk         )
);

always @(posedge tx_clk, negedge n_txreset) begin
	if (!n_txreset) tx_b_oe_r <= 1'b0;
	else            tx_b_oe_r <= !txdpram_web && txdpram_enb;
end

dti_dp_tm16fcll_512x32_4ww2xoe_m_hc mem_512x32_tx_u (
	.VDD    (vdd_w        ),
	.VSS    (vss_w        ),
	.DO_A   (             ),
	.A_A    (txdpram_addra),
	.DI_A   (txdpram_dia  ),
	.CE_N_A (~txdpram_ena ),
	.GWE_N_A(~txdpram_wea ),
	.OE_N_A (1'b1         ),
	.T_RWM_A(3'b011       ),
	.CLK_A  (aclk         ),
	
	.DO_B   (txdpram_dob  ),
	.A_B    (txdpram_addrb),
	.DI_B   (32'b0        ),
	.CE_N_B (~txdpram_enb ),
	.GWE_N_B(~txdpram_web ),
	.OE_N_B (~tx_b_oe_r   ),
	.T_RWM_B(3'b011       ),
	.CLK_B  (tx_clk       )
);



endmodule