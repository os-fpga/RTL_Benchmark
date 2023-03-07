#- Timing Constraint -#

#- ideal_path -#
set reset_list [list "*core_reset*" "por_rstn" "rtc_rstn" "slv_reset_n"]

foreach sig $reset_list {
	if {[llength [get_ports -quiet $sig]]} {
	        set_multicycle_path -setup 2 -from [get_ports $sig]
	        set_multicycle_path -hold  1 -from [get_ports $sig]
	}

}

if {$machine_timer_support} {
        if {[llength [get_clocks -quiet RTC_CLK]]} {
		if {!$bus_async && $bus_clk_period == $core_clk_period} {
			set_max_delay $core_clk_period -from [get_clocks CORE_CLK] -to [get_clocks RTC_CLK]
    			set_max_delay $core_clk_period -from [get_clocks RTC_CLK] -to [get_clocks CORE_CLK]
    			set_min_delay 0 -from [get_clocks CORE_CLK] -to [get_clocks RTC_CLK]
    			set_min_delay 0 -from [get_clocks RTC_CLK] -to [get_clocks CORE_CLK]
		} else {
			set_max_delay $core_clk_period -from [get_clocks CORE_CLK] -to [get_clocks RTC_CLK]
    			set_max_delay $core_clk_period -from [get_clocks RTC_CLK] -to [get_clocks CORE_CLK]
			set_max_delay $bus_clk_period -from [get_clocks BUS_CLK] -to [get_clocks RTC_CLK]
    			set_max_delay $bus_clk_period -from [get_clocks RTC_CLK] -to [get_clocks BUS_CLK]
    			set_min_delay 0 -from [get_clocks CORE_CLK] -to [get_clocks RTC_CLK]
    			set_min_delay 0 -from [get_clocks RTC_CLK] -to [get_clocks CORE_CLK]
    			set_min_delay 0 -from [get_clocks BUS_CLK] -to [get_clocks RTC_CLK]
    			set_min_delay 0 -from [get_clocks RTC_CLK] -to [get_clocks BUS_CLK]
		}
	}
}

if {[info exists NDS_IO_ILM_TL_UL]} {
    if {$ilm_clk_ratio != 1} { 
        set_multicycle_path -setup [expr $ilm_clk_ratio    ] -start -from  [get_clocks CORE_CLK] -to [get_clocks ILM_TL_UL_CLK]
        set_multicycle_path -hold  [expr $ilm_clk_ratio - 1] -start -from  [get_clocks CORE_CLK] -to [get_clocks ILM_TL_UL_CLK]
        set_multicycle_path -setup [expr $ilm_clk_ratio    ] -end   -from  [get_clocks ILM_TL_UL_CLK] -to [get_clocks CORE_CLK]
        set_multicycle_path -hold  [expr $ilm_clk_ratio - 1] -end   -from  [get_clocks ILM_TL_UL_CLK] -to [get_clocks CORE_CLK]
    }
}

if {!$bus_async} {
    if {$bus_clk_period != $core_clk_period} {
	set busclk_coreclk_ratio [expr int($bus_clk_period/$core_clk_period)]
	set_multicycle_path -setup [expr $busclk_coreclk_ratio    ] -start -from [get_clocks CORE_CLK] -to [get_clocks BUS_CLK]
	set_multicycle_path -hold  [expr $busclk_coreclk_ratio - 1] -start -from [get_clocks CORE_CLK] -to [get_clocks BUS_CLK]
	set_multicycle_path -setup [expr $busclk_coreclk_ratio    ] -end   -from [get_clocks BUS_CLK] -to [get_clocks CORE_CLK]
	set_multicycle_path -hold  [expr $busclk_coreclk_ratio - 1] -end   -from [get_clocks BUS_CLK] -to [get_clocks CORE_CLK]
    }
} else {
    if {$core_clk_period > $bus_clk_period} {
        set_max_delay $bus_clk_period -from [get_clocks CORE_CLK] -to [get_clocks BUS_CLK]
        set_max_delay $bus_clk_period -from [get_clocks BUS_CLK] -to [get_clocks CORE_CLK]
    } else {
        set_max_delay $core_clk_period -from [get_clocks CORE_CLK] -to [get_clocks BUS_CLK]
        set_max_delay $core_clk_period -from [get_clocks BUS_CLK] -to [get_clocks CORE_CLK]
    }
    set_min_delay 0 -from [get_clocks CORE_CLK] -to [get_clocks BUS_CLK]
    set_min_delay 0 -from [get_clocks BUS_CLK] -to [get_clocks CORE_CLK]
}

#if {$ilm_clk_ratio != 1} {
##	CORE to ILM not multicycle path
#	set_multicycle_path -setup 2                         -start -from [get_clocks CORE_CLK] -to [get_clocks ILM_CLK ]
#	set_multicycle_path -hold  1                         -start -from [get_clocks CORE_CLK] -to [get_clocks ILM_CLK ]
#	set_multicycle_path -setup [expr $ilm_clk_ratio    ] -end   -from [get_clocks ILM_CLK ] -to [get_clocks CORE_CLK]
#	set_multicycle_path -hold  [expr $ilm_clk_ratio - 1] -end   -from [get_clocks ILM_CLK ] -to [get_clocks CORE_CLK]
#	puts "set_multicycle_path for ILM_CLK to CORE_CLK\n"
#}
#
#if {$dlm_clk_ratio != 1} {
##	CORE to DLM not multicycle path
#	set_multicycle_path -setup 2                         -start -from [get_clocks CORE_CLK] -to [get_clocks DLM_CLK ]
#	set_multicycle_path -hold  1                         -start -from [get_clocks CORE_CLK] -to [get_clocks DLM_CLK ]
#	set_multicycle_path -setup [expr $dlm_clk_ratio    ] -end   -from [get_clocks DLM_CLK ] -to [get_clocks CORE_CLK]
#	set_multicycle_path -hold  [expr $dlm_clk_ratio - 1] -end   -from [get_clocks DLM_CLK ] -to [get_clocks CORE_CLK]
#	puts "set_multicycle_path for DLM_CLK to CORE_CLK\n"
#}

#- gpr probe -#
set gpr_false_list [list "*probe_gpr_index*" "*probe_current_pc*" "*probe_selected_gpr_value*"]

foreach sig $gpr_false_list {
	if {[llength [get_ports -quiet $sig]]} {
		set_false_path -through [get_ports $sig]
	}

}

### Extra constraint
set_dont_touch [get_cells -hier "kv_cpuid"]
if {[llength [get_cells -hier *gen_dlm.u_dlm*]]} {
	ungroup -flatten [get_cells -hier *gen_dlm.u_dlm*]
}


