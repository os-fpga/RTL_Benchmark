#- Timing Constraint -#
# dc::set_ideal_network -no_propagate [find / -net rsg_core_reset_n]

#- Global signal -#

set false_list [list "hart0_core_reset_n" "por_rstn" "rtc_rstn" "test_mode"]

foreach sig $false_list {
	if {[llength [find / -port $sig]]} {
		path_disable -from [find / -port $sig]
	}
}

#- debug module -#
if {$debug_module_support} {
	foreach clk_list $core_clk_list {
	        if {[llength [find / -clock TAP_CLK]]} {
			path_disable -from [find / -clock TAP_CLK] -to [find / -clock $clk_list]
			path_disable -from [find / -clock $clk_list] -to [find / -clock TAP_CLK]
		}
	}
}

#- machine timer -#
if {$machine_timer_support} {
	foreach clk_list $core_clk_list {
	        if {[llength [find / -clock RTC_CLK]]} {
			path_disable -from [find / -clock RTC_CLK] -to [find / -clock $clk_list]
			path_disable -from [find / -clock $clk_list] -to [find / -clock RTC_CLK]
		}
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

