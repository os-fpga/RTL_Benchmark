set core_clk_period 20.000
set bus_clk_period  20.000
set tap_clk_period  20.000
set test_clk_period 200.000
set clock_uncertainty 0.000
set apr_margin 0.300
set max_trans 0.400
set report_power 1
if {![info exists ::env(NDS_PKG_IRT)]} {
    set compile_itr 5
} else {
    set compile_itr $env(NDS_PKG_IRT)
}
set ungroup_core 0
set syn_define NDS_SYN
set nds_platform ae250
