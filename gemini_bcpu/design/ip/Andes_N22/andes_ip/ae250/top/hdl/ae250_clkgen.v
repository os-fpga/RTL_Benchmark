// Copyright (C) 2021, Andes Technology Corp. Confidential Proprietary

module ae250_clkgen (
		  T_osch,
		  main_rstn,
		  main_rstn_csync,
		  hresetn,
		  smu_core_clk_sel,
	`ifdef NDS_FPGA
		  smu_core_clk_2_hclk_ratio,
		  smu_hclk_2_pclk_ratio,
	`else
		  scan_test,
		  scan_enable,
		  test_clk,
		  smu_core_clk_2_hclk_ratio,
		  smu_hclk_2_pclk_ratio,
	`endif
		  smu_core_clk_en,
		  smu_hclk_en,
		  smu_pclk_en,
	`ifdef NDS_FPGA
		  core_clk,  // synthesis syn_keep=1 */;
		  hclk,      // synthesis syn_keep=1 */;
		  pclk,      // synthesis syn_keep=1 */;
		  uart_clk,  // synthesis syn_keep=1 */;
		  spi_clk,   // synthesis syn_keep=1 */;
	`else
		  core_clk,
		  hclk,
		  pclk,
		  uart_clk,
		  spi_clk,
	`endif
		  pclk_uart1,
		  pclk_uart2,
		  pclk_spi1,
		  pclk_spi2,
		  pclk_gpio,
		  pclk_pit,
		  pclk_i2c,
		  pclk_wdt,
		  apb2ahb_clken,
		  ahb2core_clken,
		  root_clk,
		  apb2core_clken
);

input		T_osch;
input		main_rstn;
input		main_rstn_csync;
input		hresetn;
input		smu_core_clk_sel;
`ifdef NDS_FPGA
input	[1:0]	smu_core_clk_2_hclk_ratio /* synthesis syn_keep=1 */;		
input	[1:0]	smu_hclk_2_pclk_ratio 	  /* synthesis syn_keep=1 */;		
`else
input		scan_test;
input		scan_enable;
input		test_clk;
input	[1:0]	smu_core_clk_2_hclk_ratio ;
input	[1:0]	smu_hclk_2_pclk_ratio 	  ;
`endif
input		smu_core_clk_en;
input		smu_hclk_en;
input	[8:0]	smu_pclk_en;

`ifdef NDS_FPGA
output		core_clk		/* synthesis syn_keep=1 */;
output		hclk			/* synthesis syn_keep=1 */;
output		pclk			/* synthesis syn_keep=1 */;
output		uart_clk		/* synthesis syn_keep=1 */;
output		spi_clk			/* synthesis syn_keep=1 */;
`else
output		core_clk;
output		hclk;
output		pclk;
output		uart_clk;
output		spi_clk;
`endif
output		pclk_uart1;
output		pclk_uart2;
output		pclk_spi1;
output		pclk_spi2;
output		pclk_gpio;
output		pclk_pit;
output		pclk_i2c;
output		pclk_wdt;
output		apb2ahb_clken;
output		ahb2core_clken;
output		root_clk;
output		apb2core_clken;

`ifdef SYNTHESIS
`elsif NDS_FPGA
wire   root_clk_dly = root_clk;
wire   main_rstn_csync_dly = main_rstn_csync;
`else
reg    root_clk_dly;
reg    main_rstn_csync_dly;
always @(root_clk) begin
       root_clk_dly <= root_clk;
end
always @(main_rstn_csync) begin
	main_rstn_csync_dly <= main_rstn_csync;
end
`endif


`ifdef NDS_FPGA

wire		clkfb_in;
wire		fast_clk;
wire		slow_clk;
wire		root_clk;
wire		hclk_pri;
wire		pclk_pri;

reg		osch_div2;

reg	[1:0]	root_clk_cnt;
reg		div_n_hclk;
reg	[1:0]	smu_core_clk_2_hclk_ratio_sync;
wire		hclk_div_n_select_sync;

reg		div_n_pclk;
reg	[1:0]	smu_hclk_2_pclk_ratio_sync;

wire            pclk_div_n_select_sync;

reg		ahb2core_clken;
reg		apb2ahb_clken;
reg		apb2core_clken;

reg		gen_clkmux_clk_en;

wire		clk_60m, clk_30m, clk_40m, clk_20m_0, clk_20m_1, clk_66m, clk_10m;

mmcm1 ae250_fpga_clkgen (
	.resetn		(main_rstn		),
	.clk_in1	(T_osch			),
	.clkfb_in	(clkfb_in		),
	.clkfb_out	(clkfb_in		),
	.clk_out1	(clk_60m		),
	.clk_out2	(clk_30m		),
	.clk_out3	(clk_40m		),
	.clk_out4	(clk_20m_0		),
	.clk_out5	(clk_20m_1		),
	.clk_out6	(clk_66m		),
	.clk_out7	(clk_10m		)
);

	`ifdef AE250_CORE_CLK_40MHZ
assign fast_clk		= clk_40m;
assign slow_clk		= clk_20m_0;
	`else
		`ifdef AE250_CORE_CLK_20MHZ
assign fast_clk		= clk_20m_0;
assign slow_clk		= clk_10m;
		`else
assign fast_clk		= clk_60m;
assign slow_clk		= clk_30m;
		`endif
	`endif

assign uart_clk		= clk_20m_1;

`ifdef AE250_SPI_CLK_40MHZ
assign spi_clk		= clk_40m;
`else
assign spi_clk		= clk_66m;
`endif

BUFGCTRL ROOT_CLK_MUX_INST (
	.I0		(fast_clk		),
	.I1		(slow_clk		),
	.CE0		(1'b1			),
	.CE1		(1'b1			),
	.S0		(~smu_core_clk_sel	),
	.S1		( smu_core_clk_sel	),
	.IGNORE0	(1'b0			),
	.IGNORE1	(1'b0			),
	.O		(root_clk		)
);

BUFGCTRL CORE_CLK_MUX_INST (
	.I0		(fast_clk		),
	.I1		(slow_clk		),
	.CE0		(gen_clkmux_clk_en & smu_core_clk_en	),
	.CE1		(gen_clkmux_clk_en & smu_core_clk_en	),
	.S0		(~smu_core_clk_sel	),
	.S1		( smu_core_clk_sel	),
	.IGNORE0	(1'b0			),
	.IGNORE1	(1'b0			),
	.O		(core_clk		)
);

BUFGCTRL HCLK_MUX_INST (
	.I0		(root_clk		),
	.I1		(div_n_hclk		),
	.CE0		(gen_clkmux_clk_en & smu_hclk_en	),
	.CE1		(gen_clkmux_clk_en & smu_hclk_en	),
	.S0		(~hclk_div_n_select_sync),
	.S1		( hclk_div_n_select_sync),
	.IGNORE0	(1'b0			),
	.IGNORE1	(1'b0			),
	.O		(hclk			)
);

BUFGCTRL PCLK_MUX_INST (
	.I0		(root_clk		),
	.I1		(div_n_pclk		),
	.CE0		(gen_clkmux_clk_en & smu_pclk_en[0]),
	.CE1		(gen_clkmux_clk_en & smu_pclk_en[0]),
	.S0		(~pclk_div_n_select_sync),
	.S1		( pclk_div_n_select_sync),
	.IGNORE0	(1'b0			),
	.IGNORE1	(1'b0			),
	.O		(pclk			)
);


assign pclk_uart1 = pclk;
assign pclk_uart2 = pclk;
assign pclk_spi1  = pclk;
assign pclk_spi2  = pclk;
assign pclk_gpio  = pclk;
assign pclk_pit   = pclk;
assign pclk_i2c   = pclk;
assign pclk_wdt   = pclk;

wire	[1:0] root_clk_cnt_nx;
assign	root_clk_cnt_nx = root_clk_cnt + 2'b1;
always @(posedge root_clk or negedge main_rstn_csync) begin
	if (!main_rstn_csync)
		root_clk_cnt	<= 2'b0;
	else
		root_clk_cnt	<= root_clk_cnt_nx;
end

wire		clock_ratio_change;
assign clock_ratio_change =
	(smu_core_clk_2_hclk_ratio_sync != smu_core_clk_2_hclk_ratio) |
	(smu_hclk_2_pclk_ratio_sync != smu_hclk_2_pclk_ratio);

always @(posedge root_clk or negedge main_rstn_csync) begin
	if (!main_rstn_csync)
		gen_clkmux_clk_en <= 1'b1;
	else if ((clock_ratio_change | ~gen_clkmux_clk_en) & root_clk_cnt == 2'b11)
		gen_clkmux_clk_en <= ~gen_clkmux_clk_en;

end

wire	      hclk_inv_cond;
wire	      ahb2core_clken_low_cond;
wire	      ahb2core_clken_high_cond;


assign hclk_inv_cond = ~smu_core_clk_2_hclk_ratio_sync[1] |
		       (smu_core_clk_2_hclk_ratio_sync[1] & ~root_clk_cnt[0]);

always @(posedge root_clk or negedge main_rstn_csync) begin
	if (!main_rstn_csync)
		div_n_hclk <= 1'b0;
	else if (hclk_inv_cond)
		div_n_hclk <= ~div_n_hclk;
end

always @(posedge root_clk or negedge main_rstn_csync) begin
	if (!main_rstn_csync)
		smu_core_clk_2_hclk_ratio_sync <= 2'b00;
	else if ((smu_core_clk_2_hclk_ratio_sync != smu_core_clk_2_hclk_ratio) & (root_clk_cnt == 2'b11))
		smu_core_clk_2_hclk_ratio_sync <= smu_core_clk_2_hclk_ratio;
end

assign ahb2core_clken_low_cond = ahb2core_clken & (smu_core_clk_2_hclk_ratio_sync != 2'b00);
assign ahb2core_clken_high_cond =
	((smu_core_clk_2_hclk_ratio_sync == 2'b00) & (root_clk_cnt == 2'b00)) |
	((smu_core_clk_2_hclk_ratio_sync == 2'b01) & (root_clk_cnt[0])) |
	((smu_core_clk_2_hclk_ratio_sync == 2'b10) & (root_clk_cnt[1:0] == 2'b11));

always @(posedge root_clk or negedge main_rstn_csync) begin
	if (!main_rstn_csync)
		ahb2core_clken <= 1'b0;
	else if (ahb2core_clken_low_cond)
		ahb2core_clken <= 1'b0;
	else if (ahb2core_clken_high_cond)
		ahb2core_clken <= 1'b1;
end

assign hclk_div_n_select_sync = smu_core_clk_2_hclk_ratio_sync != 2'b00;


wire          pclk_inv_cond;
wire          apb2ahb_clken_low_cond;
wire          apb2ahb_clken_high_cond;

wire	[1:0] core_clk_2_pclk_ratio_sync;

assign	      core_clk_2_pclk_ratio_sync = (smu_core_clk_2_hclk_ratio_sync == 2'b0) ? smu_hclk_2_pclk_ratio_sync :
										      smu_hclk_2_pclk_ratio_sync + 2'b01;

assign pclk_inv_cond = (~core_clk_2_pclk_ratio_sync[1]) |
		       ((core_clk_2_pclk_ratio_sync == 2'b10) & (root_clk_cnt[0] == 1'b0));

always @(posedge root_clk or negedge main_rstn_csync) begin
	if (!main_rstn_csync)
		div_n_pclk <= 1'b0;
	else if (pclk_inv_cond)
		div_n_pclk <= ~div_n_pclk;
end
always @(posedge root_clk or negedge main_rstn_csync) begin
	if (!main_rstn_csync)
		smu_hclk_2_pclk_ratio_sync <= 2'b00;
	else if ((smu_hclk_2_pclk_ratio_sync != smu_hclk_2_pclk_ratio) & (root_clk_cnt == 2'b11))
		smu_hclk_2_pclk_ratio_sync <= smu_hclk_2_pclk_ratio;
end
assign apb2ahb_clken_low_cond = (smu_core_clk_2_hclk_ratio_sync == 2'b00) ?
					(apb2ahb_clken & (smu_hclk_2_pclk_ratio_sync != 2'b00)) :
					(apb2ahb_clken & (smu_hclk_2_pclk_ratio_sync != 2'b00) & root_clk_cnt == 2'b00);

assign apb2ahb_clken_high_cond = (smu_core_clk_2_hclk_ratio_sync == 2'b00) ?
                                  ((smu_hclk_2_pclk_ratio_sync == 2'b00) & (root_clk_cnt == 2'b00)) |
				  ((smu_hclk_2_pclk_ratio_sync == 2'b01) & ((root_clk_cnt == 2'b01) | (root_clk_cnt == 2'b11))) |
				  ((smu_hclk_2_pclk_ratio_sync == 2'b10) & (root_clk_cnt == 2'b11)) :
				  ((smu_hclk_2_pclk_ratio_sync == 2'b00) & (root_clk_cnt == 2'b00)) |
				  ((smu_hclk_2_pclk_ratio_sync == 2'b01) & (root_clk_cnt == 2'b10));

always @(posedge root_clk or negedge main_rstn_csync) begin
	if (!main_rstn_csync)
		apb2ahb_clken <= 1'b0;
	else if (apb2ahb_clken_low_cond)
		apb2ahb_clken <= 1'b0;
	else if (apb2ahb_clken_high_cond)
		apb2ahb_clken <= 1'b1;
end
assign pclk_div_n_select_sync = core_clk_2_pclk_ratio_sync != 2'b00;

wire	      apb2core_clken_low_cond;
wire	      apb2core_clken_high_cond;

assign apb2core_clken_low_cond = (apb2core_clken & (core_clk_2_pclk_ratio_sync != 2'b00));
assign apb2core_clken_high_cond = ((core_clk_2_pclk_ratio_sync == 2'b00) & (root_clk_cnt == 2'b00)) |
				  ((core_clk_2_pclk_ratio_sync == 2'b01) & (root_clk_cnt[0])) |
				  ((core_clk_2_pclk_ratio_sync == 2'b10) & (root_clk_cnt[1:0] == 2'b11));
always @(posedge root_clk or negedge main_rstn_csync) begin
	if (!main_rstn_csync)
		apb2core_clken <= 1'b0;
	else if (apb2core_clken_low_cond)
		apb2core_clken <= 1'b0;
	else if (apb2core_clken_high_cond)
		apb2core_clken <= 1'b1;
end
`else
	`ifdef SYNTHESIS
assign		core_clk = T_osch;
assign		hclk = T_osch;
assign		pclk = T_osch;
assign		pclk_uart1 = T_osch;
assign		pclk_uart2 = T_osch;
assign		pclk_spi1 = T_osch;
assign		pclk_spi2 = T_osch;
assign		pclk_gpio = T_osch;
assign		pclk_pit = T_osch;
assign		pclk_i2c = T_osch;
assign		pclk_wdt = T_osch;
assign		apb2ahb_clken = 1'b1;
assign		ahb2core_clken = 1'b1;
assign		root_clk = T_osch;
assign		uart_clk = T_osch;
assign		spi_clk = T_osch;
assign		apb2core_clken = 1'b1;
	`else
wire		root_clk_premux;
wire		hclk_pri;
wire		pclk_pri;

wire		osch_div2_mux_test;
wire		pclk_mux_test;
wire		hclk_mux_test;

reg		osch_div2;

reg	[1:0]	smu_core_clk_2_hclk_ratio_sync;
reg	[1:0]	smu_hclk_2_pclk_ratio_sync;

wire		core_clk_en;
wire		hclk_clk_en;
wire		pclk_clk_en;

always @(posedge T_osch or negedge main_rstn) begin
	if (!main_rstn)
		osch_div2	<= 1'b0;
	else
		osch_div2	<= ~osch_div2;
end

assign	osch_div2_mux_test = scan_test ? test_clk : osch_div2;
defparam u_core_clk_mux.ASYNC_CLK_MUX = "no";
async_clkmux u_core_clk_mux (
	.reset0_n	(main_rstn		),
	.reset1_n	(main_rstn		),
	.clk_in0	(T_osch			),
	.clk_in1	(osch_div2_mux_test	),
	.test_mode	(scan_enable		),
	.select		(smu_core_clk_sel	),
	.clk_out	(root_clk_premux	)
);

wire	root_clk_src = scan_test ? test_clk : root_clk_premux;
assign	root_clk = root_clk_src;

reg             hclk_div;
reg       [1:0] pclk_div;
wire      [1:0] pclk_div_addend;
wire      [1:0] pclk_div_nx = pclk_div + pclk_div_addend;
reg       [2:0] root_clk_cnt;
wire      [2:0] root_clk_cnt_nx = root_clk_cnt + 3'd1;
reg             uart_clk;

wire            root_clk_div4 = root_clk_cnt[1];

always @(posedge root_clk_src or negedge main_rstn_csync) begin
	if (!main_rstn_csync)
		hclk_div <= 1'b1;
	else
		hclk_div <= ~hclk_div;
end
always @(posedge root_clk_src or negedge main_rstn_csync) begin
	if (!main_rstn_csync)
		pclk_div <= 2'd2;
	else
		pclk_div <= pclk_div_nx;
end

always @(posedge root_clk_src or negedge main_rstn_csync) begin
	if (!main_rstn_csync)
		root_clk_cnt <= 3'd0;
	else
		root_clk_cnt <= root_clk_cnt_nx;
end

always @(posedge root_clk_src or negedge main_rstn_csync) begin
	if (!main_rstn_csync)
		uart_clk <= 1'b0;
	else
		uart_clk <= root_clk_div4;
end


assign pclk_div_addend =
	((smu_core_clk_2_hclk_ratio_sync == 2'd0) & (smu_hclk_2_pclk_ratio_sync == 2'd2)) ? 2'd1 :
        ((smu_core_clk_2_hclk_ratio_sync == 2'd1) & (smu_hclk_2_pclk_ratio_sync == 2'd1)) ? 2'd1 : 2'd2;

reg   [2:0] root_clk_cnt_dly;
always @(root_clk_cnt) begin
	root_clk_cnt_dly <= root_clk_cnt;
end

reg             clock_stable;
wire            clock_stable_nx;
wire            clock_unstable;

wire            all_clocks_aligned = &root_clk_cnt_dly;
wire            clock_ratio_change;


always @(posedge root_clk_dly or negedge main_rstn_csync_dly) begin
	if (!main_rstn_csync_dly)
		clock_stable <= 1'b0;
	else
		clock_stable <= clock_stable_nx;
end

always @(posedge root_clk_dly or negedge main_rstn_csync_dly) begin
	if (!main_rstn_csync_dly) begin
		smu_core_clk_2_hclk_ratio_sync <= 2'd0;
		smu_hclk_2_pclk_ratio_sync     <= 2'd0;
	end
	else if (clock_ratio_change) begin
		smu_core_clk_2_hclk_ratio_sync <= smu_core_clk_2_hclk_ratio;
		smu_hclk_2_pclk_ratio_sync     <= smu_hclk_2_pclk_ratio;
	end
end

assign clock_ratio_change = clock_stable & all_clocks_aligned &
	((smu_core_clk_2_hclk_ratio_sync != smu_core_clk_2_hclk_ratio) |
	 (smu_hclk_2_pclk_ratio_sync != smu_hclk_2_pclk_ratio));

assign clock_stable_nx    = clock_ratio_change  ? 1'b0 :
                            &all_clocks_aligned ? 1'b1 : clock_stable;

assign  clock_unstable = ( clock_stable &  clock_ratio_change)
                       | (~clock_stable & ~all_clocks_aligned);

assign  core_clk_en = smu_core_clk_en & ~clock_unstable;

wire	core_clk_src;
assign	core_clk = core_clk_src;

gck gck_core_clk(
	.clk_out	(core_clk_src		),
	.clk_en		(core_clk_en		),
	.clk_in		(root_clk_dly		),
	.test_en	(scan_enable		)
);

reg      [1:0] core_clk_cnt;
wire     [1:0] core_clk_cnt_nx = core_clk_cnt + 2'd1;

always @(posedge core_clk_src or negedge main_rstn_csync_dly) begin
	if (!main_rstn_csync_dly)
		core_clk_cnt <= 2'd3;
	else
		core_clk_cnt <= core_clk_cnt_nx;
end

assign ahb2core_clken =
	(smu_core_clk_2_hclk_ratio_sync == 2'd0) |
	((smu_core_clk_2_hclk_ratio_sync == 2'd1) & core_clk_cnt[0]);

assign apb2core_clken =
	((smu_core_clk_2_hclk_ratio_sync == 2'd0) & (smu_hclk_2_pclk_ratio_sync == 2'd0)) |
	((smu_core_clk_2_hclk_ratio_sync == 2'd0) & (smu_hclk_2_pclk_ratio_sync == 2'd1) & (core_clk_cnt[0] == 1'd1)) |
	((smu_core_clk_2_hclk_ratio_sync == 2'd0) & (smu_hclk_2_pclk_ratio_sync == 2'd2) & (core_clk_cnt    == 2'd3)) |
	((smu_core_clk_2_hclk_ratio_sync == 2'd1) & (smu_hclk_2_pclk_ratio_sync == 2'd0) & (core_clk_cnt[0] == 1'd1)) |
	((smu_core_clk_2_hclk_ratio_sync == 2'd1) & (smu_hclk_2_pclk_ratio_sync == 2'd1) & (core_clk_cnt    == 2'd3));

wire         hclk_mux_in0 = root_clk_dly;
wire         hclk_mux_in1 = hclk_div;
wire         hclk_mux_sel = (smu_core_clk_2_hclk_ratio_sync != 2'd0);

defparam u_hclk_mux.ASYNC_CLK_MUX = "no";
async_clkmux u_hclk_mux (
	.reset0_n	(main_rstn_csync	),
	.reset1_n	(main_rstn_csync	),
	.clk_in0	(hclk_mux_in0		),
	.clk_in1	(hclk_mux_in1		),
	.test_mode	(scan_enable		),
	.select		(hclk_mux_sel		),
	.clk_out	(hclk_pri		)
);

assign	hclk_mux_test	= scan_test ? test_clk : hclk_pri;

assign  hclk_clk_en = smu_hclk_en & ~clock_unstable;

wire	hclk_src;
assign	hclk = hclk_src;

gck gck_hclk (
	.clk_out	(hclk_src		),
	.clk_en		(hclk_clk_en		),
	.clk_in		(hclk_mux_test		),
	.test_en	(scan_enable		)
);

reg    [1:0] hclk_cnt;
wire   [1:0] hclk_cnt_nx = hclk_cnt + 2'd1;
always @(posedge hclk_src or negedge main_rstn_csync_dly) begin
	if (!main_rstn_csync_dly)
		hclk_cnt <= 2'd3;
	else
		hclk_cnt <= hclk_cnt_nx;
end

assign apb2ahb_clken =  (smu_hclk_2_pclk_ratio_sync == 2'd0)
                     | ((smu_hclk_2_pclk_ratio_sync == 2'd1) & (hclk_cnt[0] == 1'b1))
                     | ((smu_hclk_2_pclk_ratio_sync == 2'd2) & (hclk_cnt    == 2'd3));


wire          pclk_mux_in0 = root_clk_dly;
wire          pclk_mux_in1 = pclk_div[1];
wire          pclk_mux_sel = (smu_core_clk_2_hclk_ratio_sync != 2'b0) | (smu_hclk_2_pclk_ratio_sync != 2'b0);


defparam u_pclk_a1_mux.ASYNC_CLK_MUX = "no";
async_clkmux u_pclk_a1_mux (
	.reset0_n	(main_rstn_csync	),
	.reset1_n	(main_rstn_csync	),
	.clk_in0	(pclk_mux_in0		),
	.clk_in1	(pclk_mux_in1		),
	.test_mode	(scan_enable		),
	.select		(pclk_mux_sel		),
	.clk_out	(pclk_pri		)
);

assign	pclk_mux_test	= scan_test ? test_clk : pclk_pri;
assign  pclk_clk_en     = smu_pclk_en[0] & ~clock_unstable;

gck gck_pclk (
	.clk_out	(pclk			),
	.clk_en		(pclk_clk_en		),
	.clk_in		(pclk_mux_test		),
	.test_en	(scan_enable		)
);

gck gck_pclk_uart1 (
	.clk_out	(pclk_uart1		),
	.clk_en		(smu_pclk_en[1]		),
	.clk_in		(pclk_mux_test		),
	.test_en	(scan_enable		)
);
gck gck_pclk_uart2 (
	.clk_out	(pclk_uart2		),
	.clk_en		(smu_pclk_en[2]		),
	.clk_in		(pclk_mux_test		),
	.test_en	(scan_enable		)
);
gck gck_pclk_spi1 (
	.clk_out	(pclk_spi1		),
	.clk_en		(smu_pclk_en[3]		),
	.clk_in		(pclk_mux_test		),
	.test_en	(scan_enable		)
);
gck gck_pclk_spi2 (
	.clk_out	(pclk_spi2		),
	.clk_en		(smu_pclk_en[4]		),
	.clk_in		(pclk_mux_test		),
	.test_en	(scan_enable		)
);
gck gck_pclk_gpio (
	.clk_out	(pclk_gpio		),
	.clk_en		(smu_pclk_en[5]		),
	.clk_in		(pclk_mux_test		),
	.test_en	(scan_enable		)
);
gck gck_pclk_pit (
	.clk_out	(pclk_pit		),
	.clk_en		(smu_pclk_en[6]		),
	.clk_in		(pclk_mux_test		),
	.test_en	(scan_enable		)
);
gck gck_pclk_i2c (
	.clk_out	(pclk_i2c		),
	.clk_en		(smu_pclk_en[7]		),
	.clk_in		(pclk_mux_test		),
	.test_en	(scan_enable		)
);
gck gck_pclk_wdt (
	.clk_out	(pclk_wdt		),
	.clk_en		(smu_pclk_en[8]		),
	.clk_in		(pclk_mux_test		),
	.test_en	(scan_enable		)
);

assign	spi_clk = T_osch;

	`endif
`endif
endmodule
