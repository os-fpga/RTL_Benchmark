set core_clk_period 20.000
set bus_clk_period  20.000
set test_clk_period 200.000
set ilm_clk_ratio 2
set clock_uncertainty 0.000
set apr_margin 0.300
set max_trans 0.400
set synthesis_derate 1
set synthesis_upf 0
set main_power_voltage	0.81
set main_ground_voltage	0.0
set report_power 1
if {![info exists ::env(NDS_PKG_IRT)]} {
    set compile_itr 5
} else {
    set compile_itr $env(NDS_PKG_IRT)
}
set syn_define NDS_SYN
set nds_platform ae350
