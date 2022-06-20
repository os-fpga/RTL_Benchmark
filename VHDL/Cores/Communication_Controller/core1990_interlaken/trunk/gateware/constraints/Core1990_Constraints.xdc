###############################################################################
## This the constraints file for the Core1990 Interlaken project
##
## Family       - virtex7
## Part         - xc7vx485t
## Package      - ffg1761
## Speed grade  - -2
## Transceiver  - X1Y2 (GTX)
##
###############################################################################
## Physical Constraints (geographical constraints)
###############################################################################

## Pin locations of the transceiver and system clock

set_property PACKAGE_PIN AK34 [get_ports USER_CLK_IN_P]
set_property IOSTANDARD LVDS [get_ports USER_CLK_IN_P]

set_property PACKAGE_PIN AJ32 [get_ports USER_SMA_CLK_OUT_P]
set_property IOSTANDARD LVDS [get_ports USER_SMA_CLK_OUT_P]


set_property PACKAGE_PIN AK8 [get_ports GTREFCLK_IN_P]
set_property PACKAGE_PIN E19 [get_ports System_Clock_In_P]
set_property IOSTANDARD LVDS [get_ports System_Clock_In_P]

set_property PACKAGE_PIN AL6 [get_ports RX_In_P]
set_property PACKAGE_PIN AM4 [get_ports TX_Out_P]

## Pin locations and configuration of the status leds
set_property PACKAGE_PIN AM39 [get_ports Valid_out]
set_property IOSTANDARD LVCMOS18 [get_ports Valid_out]

set_property PACKAGE_PIN AN39 [get_ports Lock_Out]
set_property IOSTANDARD LVCMOS18 [get_ports Lock_Out]

###############################################################################
## Timing constraints
###############################################################################

## Clocks and their speed
create_clock -period 8.000 -name tc_GTREFCLK_IN_P [get_ports GTREFCLK_IN_P]

## Clock relations
set_max_delay -datapath_only -from [get_clocks clkout0*] -to [get_clocks clk_out1_clk_40MHz*] 25.000
set_max_delay -datapath_only -from [get_clocks clk_out1_clk_40MHz*] -to [get_clocks clkout0*] 25.000
set_max_delay -datapath_only -from [get_clocks clkout0*] -to [get_clocks clk_out2_clk_40MHz*] 8.333
set_max_delay -datapath_only -from [get_clocks clk_out2_clk_40MHz*] -to [get_clocks clkout0*] 8.333

###############################################################################
## Resets and False paths
###############################################################################


###############################################################################
