# !!!tri_mode_ethernet_mac_0_user_phytiming.xdc 

set rx_clk_var [get_clocks -of [get_ports rgmii_rxc]]

## If the interface timing constraints cannot be met then these can be relaxed by adjusting the values in this
## xdc file which is set to be processed after all other xdc files
## this also allows for the IODELAY tap delay setting to be adjusted without needing to modify the xdc's
## provided with the core
## All commands in this file can be used directly in the tcl command window if the synthesized or implemented design is open.

# The RGMII receive interface requirement allows a 1ns setup and 1ns hold - this is met but only just so constraints are relaxed
#set_input_delay -clock [get_clocks tri_mode_ethernet_mac_0_rgmii_rx_clk] -max -1.5 [get_ports {rgmii_rxd[*] rgmii_rx_ctl}]
#set_input_delay -clock [get_clocks tri_mode_ethernet_mac_0_rgmii_rx_clk] -min -2.8 [get_ports {rgmii_rxd[*] rgmii_rx_ctl}]
#set_input_delay -clock [get_clocks tri_mode_ethernet_mac_0_rgmii_rx_clk] -clock_fall -max -1.5 -add_delay [get_ports {rgmii_rxd[*] rgmii_rx_ctl}]
#set_input_delay -clock [get_clocks tri_mode_ethernet_mac_0_rgmii_rx_clk] -clock_fall -min -2.8 -add_delay [get_ports {rgmii_rxd[*] rgmii_rx_ctl}]

# the following properties can be adjusted if requried to adjuct the IO timing
# the value shown is the default used by the IP
# increasing this value will improve the hold timing but will also add jitter.
#set_property IDELAY_VALUE 12 [get_cells {trimac_fifo_block/trimac_sup_block/tri_mode_ethernet_mac_i/*/rgmii_interface/delay_rgmii_rx* trimac_fifo_block/trimac_sup_block/tri_mode_ethernet_mac_i/*/rgmii_interface/rxdata_bus[*].delay_rgmii_rx*}]


