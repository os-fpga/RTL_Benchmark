create_clock -period 5.000 CLK
create_clock -period 14.0 clk_core

set_clock_groups -exclusive -group {CLK} -group {clk_core}

set_clock_groups -exclusive -group {clk_core} -group {CLK}

