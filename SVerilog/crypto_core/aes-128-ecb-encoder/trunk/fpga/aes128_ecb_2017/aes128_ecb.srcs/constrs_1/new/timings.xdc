
set_property BITSTREAM.CONFIG.CONFIGRATE 33 [current_design]
set_property CONFIG_VOLTAGE 2.5 [current_design]
set_property CONFIG_MODE BPI16 [current_design]

set_property CFGBVS VCCO [current_design]

set_property BITSTREAM.CONFIG.EXTMASTERCCLK_EN DIV-2 [current_design]
set_property BITSTREAM.CONFIG.BPI_SYNC_MODE TYPE2 [current_design]


create_generated_clock -name clk_gen -source [get_pins clkgen/clk_in1_p] -divide_by 2 -add -master_clock CLK_IN_P [get_pins clkgen/clk_out1]
set_input_delay -clock [get_clocks clk_gen] 1.000 [get_ports uart_rx]
set_output_delay -clock [get_clocks clk_gen] 1.000 [get_ports uart_tx]
