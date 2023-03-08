create_clock -period 10 clk_out1_proto
create_clock -period 18.8 clk_out2_proto
create_clock -period 73 clk_out4_proto
create_clock -period 38 clk_osc


set_clock_groups -exclusive -group {clk_out1_proto} -group {clk_out2_proto}
set_clock_groups -exclusive -group {clk_out1_proto} -group {clk_out4_proto}
set_clock_groups -exclusive -group {clk_out1_proto} -group {clk_osc}
set_clock_groups -exclusive -group {clk_out2_proto} -group {clk_out1_proto}
set_clock_groups -exclusive -group {clk_out2_proto} -group {clk_out4_proto}
set_clock_groups -exclusive -group {clk_out2_proto} -group {clk_osc}
set_clock_groups -exclusive -group {clk_out4_proto} -group {clk_out1_proto}
set_clock_groups -exclusive -group {clk_out4_proto} -group {clk_out2_proto}
set_clock_groups -exclusive -group {clk_out4_proto} -group {clk_osc}
set_clock_groups -exclusive -group {clk_osc} -group {clk_out1_proto}
set_clock_groups -exclusive -group {clk_osc} -group {clk_out2_proto}
set_clock_groups -exclusive -group {clk_osc} -group {clk_out4_proto}

