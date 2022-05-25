# clk
set_property LOC AD12 [ get_ports sys_diff_clock_clk_p]
set_property IOSTANDARD DIFF_SSTL15 [ get_ports sys_diff_clock_clk_p]
# rst
set_property LOC AB7 [ get_ports glbl_rst]
set_property IOSTANDARD LVCMOS15 [ get_ports glbl_rst]
# led
set_property LOC AB8 [ get_ports led_8bits_tri_o[0]]
set_property IOSTANDARD LVCMOS15 [ get_ports led_8bits_tri_o[0]]

set_property LOC AA8 [ get_ports led_8bits_tri_o[1]]
set_property IOSTANDARD LVCMOS15 [ get_ports led_8bits_tri_o[1]]

set_property LOC AC9 [ get_ports led_8bits_tri_o[2]]
set_property IOSTANDARD LVCMOS15 [ get_ports led_8bits_tri_o[2]]

set_property LOC AB9 [ get_ports led_8bits_tri_o[3]]
set_property IOSTANDARD LVCMOS15 [ get_ports led_8bits_tri_o[3]]

set_property LOC AE26 [ get_ports led_8bits_tri_o[4]]
set_property IOSTANDARD LVCMOS25 [ get_ports led_8bits_tri_o[4]]

set_property LOC G19 [ get_ports led_8bits_tri_o[5]]
set_property IOSTANDARD LVCMOS25 [ get_ports led_8bits_tri_o[5]]

set_property LOC E18 [ get_ports led_8bits_tri_o[6]]
set_property IOSTANDARD LVCMOS25 [ get_ports led_8bits_tri_o[6]]

set_property LOC F16 [ get_ports led_8bits_tri_o[7]]
set_property IOSTANDARD LVCMOS25 [ get_ports led_8bits_tri_o[7]]
# uart
set_property LOC M19 [ get_ports rs232_uart_rxd]
set_property IOSTANDARD LVCMOS25 [ get_ports rs232_uart_rxd]

set_property LOC K24 [ get_ports rs232_uart_txd]
set_property IOSTANDARD LVCMOS25 [ get_ports rs232_uart_txd]
# PHY-MDIO
set_property PACKAGE_PIN R23      [get_ports mdc]
set_property IOSTANDARD  LVCMOS25 [get_ports mdc]
set_property PACKAGE_PIN J21      [get_ports mdio]
set_property IOSTANDARD  LVCMOS25 [get_ports mdio]
# PHY-RGMII
set_property PACKAGE_PIN U28      [get_ports rgmii_rxd[3]]
set_property PACKAGE_PIN T25      [get_ports rgmii_rxd[2]]
set_property PACKAGE_PIN U25      [get_ports rgmii_rxd[1]]
set_property PACKAGE_PIN U30      [get_ports rgmii_rxd[0]]
set_property IOSTANDARD  LVCMOS25 [get_ports rgmii_rxd[3]]
set_property IOSTANDARD  LVCMOS25 [get_ports rgmii_rxd[2]]
set_property IOSTANDARD  LVCMOS25 [get_ports rgmii_rxd[1]]
set_property IOSTANDARD  LVCMOS25 [get_ports rgmii_rxd[0]]

set_property PACKAGE_PIN L28      [get_ports rgmii_txd[3]]
set_property PACKAGE_PIN M29      [get_ports rgmii_txd[2]]
set_property PACKAGE_PIN N25      [get_ports rgmii_txd[1]]
set_property PACKAGE_PIN N27      [get_ports rgmii_txd[0]]
set_property IOSTANDARD  LVCMOS25 [get_ports rgmii_txd[3]]
set_property IOSTANDARD  LVCMOS25 [get_ports rgmii_txd[2]]
set_property IOSTANDARD  LVCMOS25 [get_ports rgmii_txd[1]]
set_property IOSTANDARD  LVCMOS25 [get_ports rgmii_txd[0]]

set_property PACKAGE_PIN M27      [get_ports rgmii_tx_ctl]
set_property PACKAGE_PIN K30      [get_ports rgmii_txc]
set_property IOSTANDARD  LVCMOS25 [get_ports rgmii_tx_ctl]
set_property IOSTANDARD  LVCMOS25 [get_ports rgmii_txc]

set_property PACKAGE_PIN R28      [get_ports rgmii_rx_ctl]
set_property IOSTANDARD  LVCMOS25 [get_ports rgmii_rx_ctl]

set_property PACKAGE_PIN U27      [get_ports rgmii_rxc]
set_property IOSTANDARD  LVCMOS25 [get_ports rgmii_rxc]
# PHY-RST
set_property PACKAGE_PIN L20      [get_ports phy_resetn]
set_property IOSTANDARD  LVCMOS25 [get_ports phy_resetn]
