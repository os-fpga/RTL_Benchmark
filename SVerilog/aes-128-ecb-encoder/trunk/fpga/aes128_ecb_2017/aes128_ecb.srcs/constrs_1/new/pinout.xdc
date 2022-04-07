set_property PACKAGE_PIN AD12 [get_ports CLK_IN_P]
set_property PACKAGE_PIN AD11 [get_ports CLK_IN_N]

set_property PACKAGE_PIN AB7 [get_ports rst_i]
set_property IOSTANDARD LVCMOS18 [get_ports rst_i]

set_property PACKAGE_PIN K24 [get_ports uart_tx]
set_property IOSTANDARD LVCMOS25 [get_ports uart_tx]

set_property PACKAGE_PIN M19 [get_ports uart_rx]
set_property IOSTANDARD LVCMOS25 [get_ports uart_rx]

set_property IOSTANDARD LVCMOS15 [get_ports rst_o]
set_property PACKAGE_PIN AB8 [get_ports rst_o]

set_property IOSTANDARD LVCMOS25 [get_ports clk_o]
set_property PACKAGE_PIN AE26 [get_ports clk_o]

set_property IOSTANDARD LVCMOS15 [get_ports key_set_complete_o]
set_property PACKAGE_PIN AA8 [get_ports key_set_complete_o]

set_property IOSTANDARD LVCMOS15 [get_ports startup_pause_complete]
set_property PACKAGE_PIN AC9 [get_ports startup_pause_complete]
