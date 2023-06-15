create_clock -period 7.000 CLK
create_clock -period 9.0 clk_core
create_clock -period 5.0 clk_wishbone_data
create_clock -period 8.0 clk_wishbone_inst

set_clock_groups -exclusive -group {CLK} -group {clk_core}
set_clock_groups -exclusive -group {CLK} -group {clk_wishbone_data}
set_clock_groups -exclusive -group {CLK} -group {clk_wishbone_inst}

set_clock_groups -exclusive -group {clk_core} -group {CLK}
set_clock_groups -exclusive -group {clk_core} -group {clk_wishbone_data}
set_clock_groups -exclusive -group {clk_core} -group {clk_wishbone_inst}

set_clock_groups -exclusive -group {clk_wishbone_data} -group {CLK}
set_clock_groups -exclusive -group {clk_wishbone_data} -group {clk_core}
set_clock_groups -exclusive -group {clk_wishbone_data} -group {clk_wishbone_inst}

set_clock_groups -exclusive -group {clk_wishbone_inst} -group {CLK}
set_clock_groups -exclusive -group {clk_wishbone_inst} -group {clk_core}
set_clock_groups -exclusive -group {clk_wishbone_inst} -group {clk_wishbone_data}
