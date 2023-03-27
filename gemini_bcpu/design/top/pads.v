//-----------------------------------------------------------------------------
//	RapidSilicon
//	Author:	Pankil Patel
//	Date:	6/5/2022
//-----------------------------------------------------------------------------
module pads (
	inout				RST_N,
	inout				XIN,
	inout				REF_CLK_1,
	inout				REF_CLK_2,
	inout				REF_CLK_3,
	inout				REF_CLK_4,
	inout				TESTMODE,
	inout				BOOTM0,
	inout				BOOTM1,
	inout				BOOTM2,
	inout				CLKSEL_0,
	inout				CLKSEL_1,
	inout				JTAG_TDI,
	inout				JTAG_TDO,
	inout				JTAG_TMS,
	inout				JTAG_TCK,
	inout				JTAG_TRSTN,
//GPIO and Alt func IO
	inout				GPIO_B_0,
	inout				GPIO_B_1,
	inout				GPIO_B_2,
	inout				GPIO_B_3,
	inout				GPIO_B_4,
	inout				GPIO_B_5,
	inout				GPIO_B_6,
	inout				GPIO_B_7,
	inout				GPIO_B_8,
	inout				GPIO_B_9,
	inout				GPIO_B_10,
	inout				GPIO_B_11,
	inout				GPIO_B_12,
	inout				GPIO_B_13,
	inout				GPIO_B_14,
	inout				GPIO_B_15,
	inout				GPIO_C_0,
	inout				GPIO_C_1,
	inout				GPIO_C_2,
	inout				GPIO_C_3,
	inout				GPIO_C_4,
	inout				GPIO_C_5,
	inout				GPIO_C_6,
	inout				GPIO_C_7,
	inout				GPIO_C_8,
	inout				GPIO_C_9,
	inout				GPIO_C_10,
	inout				GPIO_C_11,
	inout				GPIO_C_12,
	inout				GPIO_C_13,
	inout				GPIO_C_14,
	inout				GPIO_C_15,
	inout				I2C_SCL ,
	inout				SPI_SCLK ,
	inout				GPT_RTC,
//RGMII IO
	inout				MDIO_MDC,
	inout				MDIO_DATA,
	inout				RGMII_TXD0,
	inout				RGMII_TXD1,
	inout				RGMII_TXD2,
	inout				RGMII_TXD3,
	inout				RGMII_TX_CTL ,
	inout				RGMII_TXC,
	inout				RGMII_RXD0,
	inout				RGMII_RXD1,
	inout				RGMII_RXD2,
	inout				RGMII_RXD3,
	inout				RGMII_RX_CTL,
	inout				RGMII_RXC,

	output				por,
	output				xin,
	output				ref_clk_1,
	output				ref_clk_2,
	output				ref_clk_3,
	output				ref_clk_4,
	output				testmode,
	output	[2:0]			bootm,
	output	[1:0]			clksel,
	output				jtag_tdi,
	input				jtag_tdo,
	input				jtag_tdo_oe,
	output				jtag_tms,
	output				jtag_tck,
	output				jtag_trstn,
	output				i2c_scl,
	output				spi_clk,
	output				rtc_clk,
	input	[3:0]			rgmii_txd,
	input				rgmii_tx_ctl,
	input				rgmii_txc,
	output	[3:0]			rgmii_rxd,
	output				rgmii_rx_ctl,
	output				rgmii_rxc,
	output				mdio_data,
	input	[15:0]			gpio_b_in,
	output	[15:0]			gpio_b_out,
	input	[15:0]			gpio_b_oe,
	input	[15:0]			gpio_c_in,
	output	[15:0]			gpio_c_out,
	input	[15:0]			gpio_c_oe
	);


	AF_IO_H	RST_N_INST		(.PAD (RST_N), .DIN (1'b0), .DOUT (por), .OE(1'b0), .PUD(1'b0), .PE(1'b0), .DS0(1'b0), .DS1(1'b0));
	AF_IO_H XIN_INST		(.PAD (XIN), .DIN (1'b0), .DOUT(xin), .OE(1'b0),.PUD(1'b0),.PE(1'b0),.DS0(1'b0),.DS1(1'b0));
	AF_IO_H REF_CLK_1_INST		(.PAD (REF_CLK_1), .DIN (1'b0), .DOUT(ref_clk_1), .OE(1'b0),.PUD(1'b0),.PE(1'b0),.DS0(1'b0),.DS1(1'b0));
	AF_IO_H REF_CLK_2_INST		(.PAD (REF_CLK_2), .DIN (1'b0), .DOUT(ref_clk_2), .OE(1'b0),.PUD(1'b0),.PE(1'b0),.DS0(1'b0),.DS1(1'b0));
	AF_IO_H REF_CLK_3_INST		(.PAD (REF_CLK_3), .DIN (1'b0), .DOUT(ref_clk_3), .OE(1'b0),.PUD(1'b0),.PE(1'b0),.DS0(1'b0),.DS1(1'b0));
	AF_IO_H REF_CLK_4_INST		(.PAD (REF_CLK_4), .DIN (1'b0), .DOUT(ref_clk_4), .OE(1'b0),.PUD(1'b0),.PE(1'b0),.DS0(1'b0),.DS1(1'b0));
	AF_IO_H TESTMODE_INST 		(.PAD (TESTMODE), .DIN (1'b0), .DOUT(testmode), .OE(1'b0),.PUD(1'b0),.PE(1'b0),.DS0(1'b0),.DS1(1'b0));
	AF_IO_H BOOTM0_INST 		(.PAD (BOOTM0), .DIN (1'b0), .DOUT(bootm[0]), .OE(1'b0),.PUD(1'b0),.PE(1'b0),.DS0(1'b0),.DS1(1'b0));
	AF_IO_H BOOTM1_INST 		(.PAD (BOOTM1), .DIN (1'b0), .DOUT(bootm[1]), .OE(1'b0),.PUD(1'b0),.PE(1'b0),.DS0(1'b0),.DS1(1'b0));
	AF_IO_H BOOTM2_INST 		(.PAD (BOOTM2), .DIN (1'b0), .DOUT(bootm[2]), .OE(1'b0),.PUD(1'b0),.PE(1'b0),.DS0(1'b0),.DS1(1'b0));
	AF_IO_H CLKSEL_0_INST 		(.PAD (CLKSEL_0), .DIN (1'b0), .DOUT(clksel[0]), .OE(1'b0),.PUD(1'b0),.PE(1'b0),.DS0(1'b0),.DS1(1'b0));
	AF_IO_H CLKSEL_1_INST 		(.PAD (CLKSEL_1), .DIN (1'b0), .DOUT(clksel[1]), .OE(1'b0),.PUD(1'b0),.PE(1'b0),.DS0(1'b0),.DS1(1'b0));

	AF_IO_H JTAG_TDI_INST		(.PAD (JTAG_TDI), .DIN (1'b0), .DOUT(jtag_tdi), .OE(1'b0),.PUD(1'b0),.PE(1'b0),.DS0(1'b0),.DS1(1'b0));
	AF_IO_H JTAG_TDO_INST		(.PAD (JTAG_TDO), .DIN (jtag_tdo), .DOUT(), .OE(jtag_tdo_oe),.PUD(1'b0),.PE(1'b0),.DS0(1'b0),.DS1(1'b0));
	AF_IO_H JTAG_TMS_INST		(.PAD (JTAG_TMS), .DIN (1'b0), .DOUT(jtag_tms), .OE(1'b0),.PUD(1'b0),.PE(1'b0),.DS0(1'b0),.DS1(1'b0));
	AF_IO_H JTAG_TCK_INST		(.PAD (JTAG_TCK), .DIN (1'b0), .DOUT(jtag_tck), .OE(1'b0),.PUD(1'b0),.PE(1'b0),.DS0(1'b0),.DS1(1'b0));
	AF_IO_H JTAG_TRSTN_INST		(.PAD (JTAG_TRSTN), .DIN (1'b0), .DOUT(jtag_trstn), .OE(1'b0),.PUD(1'b0),.PE(1'b0),.DS0(1'b0),.DS1(1'b0));

	AF_IO_H GPIO_B_0_INST		(.PAD (GPIO_B_0), .DIN (gpio_b_in[0]), .DOUT (gpio_b_out[0]), .OE(gpio_b_oe[0]), .PUD(1'b0), .PE(1'b0), .DS0(1'b0), .DS1(1'b0));
	AF_IO_H GPIO_B_1_INST		(.PAD (GPIO_B_1), .DIN (gpio_b_in[1]), .DOUT (gpio_b_out[1]), .OE(gpio_b_oe[1]), .PUD(1'b0), .PE(1'b0), .DS0(1'b0), .DS1(1'b0));
	AF_IO_H GPIO_B_2_INST		(.PAD (GPIO_B_2), .DIN (gpio_b_in[2]), .DOUT (gpio_b_out[2]), .OE(gpio_b_oe[2]), .PUD(1'b0), .PE(1'b0), .DS0(1'b0), .DS1(1'b0));
	AF_IO_H GPIO_B_3_INST		(.PAD (GPIO_B_3), .DIN (gpio_b_in[3]), .DOUT (gpio_b_out[3]), .OE(gpio_b_oe[3]), .PUD(1'b0), .PE(1'b0), .DS0(1'b0), .DS1(1'b0));
	AF_IO_H GPIO_B_4_INST		(.PAD (GPIO_B_4), .DIN (gpio_b_in[4]), .DOUT (gpio_b_out[4]), .OE(gpio_b_oe[4]), .PUD(1'b0), .PE(1'b0), .DS0(1'b0), .DS1(1'b0));
	AF_IO_H GPIO_B_5_INST		(.PAD (GPIO_B_5), .DIN (gpio_b_in[5]), .DOUT (gpio_b_out[5]), .OE(gpio_b_oe[5]), .PUD(1'b0), .PE(1'b0), .DS0(1'b0), .DS1(1'b0));
	AF_IO_H GPIO_B_6_INST		(.PAD (GPIO_B_6), .DIN (gpio_b_in[6]), .DOUT (gpio_b_out[6]), .OE(gpio_b_oe[6]), .PUD(1'b0), .PE(1'b0), .DS0(1'b0), .DS1(1'b0));
	AF_IO_H GPIO_B_7_INST		(.PAD (GPIO_B_7), .DIN (gpio_b_in[7]), .DOUT (gpio_b_out[7]), .OE(gpio_b_oe[7]), .PUD(1'b0), .PE(1'b0), .DS0(1'b0), .DS1(1'b0));
	AF_IO_H GPIO_B_8_INST		(.PAD (GPIO_B_8), .DIN (gpio_b_in[8]), .DOUT (gpio_b_out[8]), .OE(gpio_b_oe[8]), .PUD(1'b0), .PE(1'b0), .DS0(1'b0), .DS1(1'b0));
	AF_IO_H GPIO_B_9_INST		(.PAD (GPIO_B_9), .DIN (gpio_b_in[9]), .DOUT (gpio_b_out[9]), .OE(gpio_b_oe[9]), .PUD(1'b0), .PE(1'b0), .DS0(1'b0), .DS1(1'b0));
	AF_IO_H GPIO_B_10_INST		(.PAD (GPIO_B_10), .DIN (gpio_b_in[10]), .DOUT (gpio_b_out[10]), .OE(gpio_b_oe[10]), .PUD(1'b0), .PE(1'b0), .DS0(1'b0), .DS1(1'b0));
	AF_IO_H GPIO_B_11_INST		(.PAD (GPIO_B_11), .DIN (gpio_b_in[11]), .DOUT (gpio_b_out[11]), .OE(gpio_b_oe[11]), .PUD(1'b0), .PE(1'b0), .DS0(1'b0), .DS1(1'b0));
	AF_IO_H GPIO_B_12_INST		(.PAD (GPIO_B_12), .DIN (gpio_b_in[12]), .DOUT (gpio_b_out[12]), .OE(gpio_b_oe[12]), .PUD(1'b0), .PE(1'b0), .DS0(1'b0), .DS1(1'b0));
	AF_IO_H GPIO_B_13_INST		(.PAD (GPIO_B_13), .DIN (gpio_b_in[13]), .DOUT (gpio_b_out[13]), .OE(gpio_b_oe[13]), .PUD(1'b0), .PE(1'b0), .DS0(1'b0), .DS1(1'b0));
	AF_IO_H GPIO_B_14_INST		(.PAD (GPIO_B_14), .DIN (gpio_b_in[14]), .DOUT (gpio_b_out[14]), .OE(gpio_b_oe[14]), .PUD(1'b0), .PE(1'b0), .DS0(1'b0), .DS1(1'b0));
	AF_IO_H GPIO_B_15_INST		(.PAD (GPIO_B_15), .DIN (gpio_b_in[15]), .DOUT (gpio_b_out[15]), .OE(gpio_b_oe[15]), .PUD(1'b0), .PE(1'b0), .DS0(1'b0), .DS1(1'b0));
	AF_IO_H GPIO_C_0_INST		(.PAD (GPIO_C_0), .DIN (gpio_c_in[0]), .DOUT (gpio_c_out[0]), .OE(gpio_c_oe[0]), .PUD(1'b0), .PE(1'b0), .DS0(1'b0), .DS1(1'b0));
	AF_IO_H GPIO_C_1_INST		(.PAD (GPIO_C_1), .DIN (gpio_c_in[1]), .DOUT (gpio_c_out[1]), .OE(gpio_c_oe[1]), .PUD(1'b0), .PE(1'b0), .DS0(1'b0), .DS1(1'b0));
	AF_IO_H GPIO_C_2_INST		(.PAD (GPIO_C_2), .DIN (gpio_c_in[2]), .DOUT (gpio_c_out[2]), .OE(gpio_c_oe[2]), .PUD(1'b0), .PE(1'b0), .DS0(1'b0), .DS1(1'b0));
	AF_IO_H GPIO_C_3_INST		(.PAD (GPIO_C_3), .DIN (gpio_c_in[3]), .DOUT (gpio_c_out[3]), .OE(gpio_c_oe[3]), .PUD(1'b0), .PE(1'b0), .DS0(1'b0), .DS1(1'b0));
	AF_IO_H GPIO_C_4_INST		(.PAD (GPIO_C_4), .DIN (gpio_c_in[4]), .DOUT (gpio_c_out[4]), .OE(gpio_c_oe[4]), .PUD(1'b0), .PE(1'b0), .DS0(1'b0), .DS1(1'b0));
	AF_IO_H GPIO_C_5_INST		(.PAD (GPIO_C_5), .DIN (gpio_c_in[5]), .DOUT (gpio_c_out[5]), .OE(gpio_c_oe[5]), .PUD(1'b0), .PE(1'b0), .DS0(1'b0), .DS1(1'b0));
	AF_IO_H GPIO_C_6_INST		(.PAD (GPIO_C_6), .DIN (gpio_c_in[6]), .DOUT (gpio_c_out[6]), .OE(gpio_c_oe[6]), .PUD(1'b0), .PE(1'b0), .DS0(1'b0), .DS1(1'b0));
	AF_IO_H GPIO_C_7_INST		(.PAD (GPIO_C_7), .DIN (gpio_c_in[7]), .DOUT (gpio_c_out[7]), .OE(gpio_c_oe[7]), .PUD(1'b0), .PE(1'b0), .DS0(1'b0), .DS1(1'b0));
	AF_IO_H GPIO_C_8_INST		(.PAD (GPIO_C_8), .DIN (gpio_c_in[8]), .DOUT (gpio_c_out[8]), .OE(gpio_c_oe[8]), .PUD(1'b0), .PE(1'b0), .DS0(1'b0), .DS1(1'b0));
	AF_IO_H GPIO_C_9_INST		(.PAD (GPIO_C_9), .DIN (gpio_c_in[9]), .DOUT (gpio_c_out[9]), .OE(gpio_c_oe[9]),.PUD(1'b0),.PE(1'b0),.DS0(1'b0),.DS1(1'b0));
	AF_IO_H GPIO_C_10_INST		(.PAD (GPIO_C_10), .DIN (gpio_c_in[10]), .DOUT (gpio_c_out[10]), .OE(gpio_c_oe[10]),.PUD(1'b0),.PE(1'b0),.DS0(1'b0),.DS1(1'b0));
	AF_IO_H GPIO_C_11_INST		(.PAD (GPIO_C_11), .DIN (gpio_c_in[11]), .DOUT (gpio_c_out[11]), .OE(gpio_c_oe[11]),.PUD(1'b0),.PE(1'b0),.DS0(1'b0),.DS1(1'b0));
	AF_IO_H GPIO_C_12_INST		(.PAD (GPIO_C_12), .DIN (gpio_c_in[12]), .DOUT (gpio_c_out[12]), .OE(gpio_c_oe[12]),.PUD(1'b0),.PE(1'b0),.DS0(1'b0),.DS1(1'b0));
	AF_IO_H GPIO_C_13_INST		(.PAD (GPIO_C_13), .DIN (gpio_c_in[13]), .DOUT (gpio_c_out[13]), .OE(gpio_c_oe[13]),.PUD(1'b0),.PE(1'b0),.DS0(1'b0),.DS1(1'b0));
	AF_IO_H GPIO_C_14_INST		(.PAD (GPIO_C_14), .DIN (gpio_c_in[14]), .DOUT (gpio_c_out[14]), .OE(gpio_c_oe[14]),.PUD(1'b0),.PE(1'b0),.DS0(1'b0),.DS1(1'b0));
	AF_IO_H GPIO_C_15_INST		(.PAD (GPIO_C_15), .DIN (gpio_c_in[15]), .DOUT (gpio_c_out[15]), .OE(gpio_c_oe[15]),.PUD(1'b0),.PE(1'b0),.DS0(1'b0),.DS1(1'b0));
	AF_IO_H I2C_SCL_INST		(.PAD (I2C_SCL), .DIN (1'b0), .DOUT(i2c_scl), .OE(1'b0),.PUD(1'b0),.PE(1'b0),.DS0(1'b0),.DS1(1'b0));
	AF_IO_H SPI_SCLK_INST		(.PAD (SPI_SCLK), .DIN (1'b0), .DOUT(spi_clk), .OE(1'b0),.PUD(1'b0),.PE(1'b0),.DS0(1'b0),.DS1(1'b0));
	AF_IO_H GPT_RTC_INST		(.PAD (GPT_RTC), .DIN (1'b0), .DOUT(rtc_clk), .OE(1'b0),.PUD(1'b0),.PE(1'b0),.DS0(1'b0),.DS1(1'b0));
	AF_IO_H MDIO_MDC_INST		(.PAD (MDIO_MDC), .DIN (1'b0), .DOUT(), .OE(1'b0),.PUD(1'b0),.PE(1'b0),.DS0(1'b0),.DS1(1'b0));
	AF_IO_H MDIO_DATA_INST		(.PAD (MDIO_DATA), .DIN (1'b0), .DOUT(mdio_data), .OE(1'b0),.PUD(1'b0),.PE(1'b0),.DS0(1'b0),.DS1(1'b0));

	AF_IO_H RGMII_TXD_0_INST		(.PAD (RGMII_TXD0), .DIN (rgmii_txd[0]), .DOUT (), .OE(1'b1), .PUD(1'b0), .PE(1'b0), .DS0(1'b0), .DS1(1'b0));
	AF_IO_H RGMII_TXD_1_INST		(.PAD (RGMII_TXD1), .DIN (rgmii_txd[1]), .DOUT (), .OE(1'b1), .PUD(1'b0), .PE(1'b0), .DS0(1'b0), .DS1(1'b0));
	AF_IO_H RGMII_TXD_2_INST		(.PAD (RGMII_TXD2), .DIN (rgmii_txd[2]), .DOUT (), .OE(1'b1), .PUD(1'b0), .PE(1'b0), .DS0(1'b0), .DS1(1'b0));
	AF_IO_H RGMII_TXD_3_INST		(.PAD (RGMII_TXD3), .DIN (rgmii_txd[3]), .DOUT (), .OE(1'b1), .PUD(1'b0), .PE(1'b0), .DS0(1'b0), .DS1(1'b0));
	AF_IO_H RGMII_TX_CTL_INST		(.PAD (RGMII_TX_CTL), .DIN (rgmii_tx_ctl), .DOUT (), .OE(1'b1), .PUD(1'b0), .PE(1'b0), .DS0(1'b0), .DS1(1'b0));
	AF_IO_H RGMII_TXC_INST		(.PAD (RGMII_TX_CTL), .DIN (rgmii_txc), .DOUT (), .OE(1'b1), .PUD(1'b0), .PE(1'b0), .DS0(1'b0), .DS1(1'b0));

	AF_IO_H RGMII_RXD_0_INST		(.PAD (RGMII_RXD0), .DOUT (rgmii_rxd[0]), .DIN (1'b0), .OE(1'b0), .PUD(1'b0), .PE(1'b0), .DS0(1'b0), .DS1(1'b0));
	AF_IO_H RGMII_RXD_1_INST		(.PAD (RGMII_RXD1), .DOUT (rgmii_rxd[1]), .DIN (1'b0), .OE(1'b0), .PUD(1'b0), .PE(1'b0), .DS0(1'b0), .DS1(1'b0));
	AF_IO_H RGMII_RXD_2_INST		(.PAD (RGMII_RXD2), .DOUT (rgmii_rxd[2]), .DIN (1'b0), .OE(1'b0), .PUD(1'b0), .PE(1'b0), .DS0(1'b0), .DS1(1'b0));
	AF_IO_H RGMII_RXD_3_INST		(.PAD (RGMII_RXD3), .DOUT (rgmii_rxd[3]), .DIN (1'b0), .OE(1'b0), .PUD(1'b0), .PE(1'b0), .DS0(1'b0), .DS1(1'b0));
	AF_IO_H RGMII_RX_CTL_INST		(.PAD (RGMII_RX_CTL), .DOUT (rgmii_rx_ctl), .DIN (1'b0), .OE(1'b0), .PUD(1'b0), .PE(1'b0), .DS0(1'b0), .DS1(1'b0));
	AF_IO_H RGMII_RXC_INST		(.PAD (RGMII_RX_CTL), .DOUT (rgmii_rxc), .DIN (1'b0), .OE(1'b0), .PUD(1'b0), .PE(1'b0), .DS0(1'b0), .DS1(1'b0));

endmodule