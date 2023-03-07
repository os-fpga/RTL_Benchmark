#- Timing Constraint -#

#- ideal_path -#
set false_list [list "hart0_core_reset_n" "por_rstn" "rtc_rstn" "test_mode"]

foreach sig $false_list {
	if {[llength [get_ports -quiet $sig]]} {
	        set_false_path -from [get_ports $sig]
	}

}

#- JDTM -#
if {$debug_module_support} {
        if {[llength [get_clocks -quiet TAP_CLK]]} {
		set clk_list [concat $core_clk_list]
		set_false_path -from [get_clocks TAP_CLK] -to [get_clocks $clk_list]
		set_false_path -from [get_clocks $clk_list] -to [get_clocks TAP_CLK]
	}
}

if {$machine_timer_support} {
        if {[llength [get_clocks -quiet RTC_CLK]]} {
		set clk_list [concat $core_clk_list]
		set_false_path -from [get_clocks RTC_CLK] -to [get_clocks $clk_list]
		set_false_path -from [get_clocks $clk_list] -to [get_clocks RTC_CLK]
	}
}

#- multicycle path
if {$bus_clk_period != $core_clk_period} {
set busclk_coreclk_ratio [expr int($bus_clk_period/$core_clk_period)]
set_multicycle_path -setup [expr $busclk_coreclk_ratio    ] -end   -from [get_clocks BUS_CLK] -to [get_clocks CORE_CLK]
set_multicycle_path -hold  [expr $busclk_coreclk_ratio - 1] -end   -from [get_clocks BUS_CLK] -to [get_clocks CORE_CLK]
set_multicycle_path -setup [expr $busclk_coreclk_ratio    ] -start -from [get_clocks CORE_CLK] -to [get_clocks BUS_CLK]
set_multicycle_path -hold  [expr $busclk_coreclk_ratio - 1] -start -from [get_clocks CORE_CLK] -to [get_clocks BUS_CLK]
}
