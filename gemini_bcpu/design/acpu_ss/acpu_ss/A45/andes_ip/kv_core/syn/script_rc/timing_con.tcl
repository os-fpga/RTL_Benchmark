#- Timing Constraint -#
# dc::set_ideal_network -no_propagate [find / -net rsg_core_reset_n]

#- Global signal -#

set false_list [list "*core_reset*" "por_rstn" "rtc_rstn" "areset*"]

foreach sig $false_list {
	if {[llength [find / -port $sig]]} {
		path_disable -from [find / -port $sig]
	}
}

set core_clk_period_ns [expr $core_clk_period / 1000]
set bus_clk_period_ns  [expr $bus_clk_period / 1000]

#- machine timer -#
if {$machine_timer_support} {
    if {!$bus_async && ($bus_clk_period == $core_clk_period)} {
	set_max_delay $core_clk_period_ns -from [get_clocks CORE_CLK] -to [get_clocks RTC_CLK]
    	set_max_delay $core_clk_period_ns -from [get_clocks RTC_CLK] -to [get_clocks CORE_CLK]
    	set_min_delay 0 -from [get_clocks CORE_CLK] -to [get_clocks RTC_CLK]
    	set_min_delay 0 -from [get_clocks RTC_CLK] -to [get_clocks CORE_CLK]
    } else {
	set_max_delay $core_clk_period_ns -from [get_clocks CORE_CLK] -to [get_clocks RTC_CLK]
    	set_max_delay $core_clk_period_ns -from [get_clocks RTC_CLK] -to [get_clocks CORE_CLK]
	set_max_delay $bus_clk_period_ns -from [get_clocks BUS_CLK] -to [get_clocks RTC_CLK]
    	set_max_delay $bus_clk_period_ns -from [get_clocks RTC_CLK] -to [get_clocks BUS_CLK]
    	set_min_delay 0 -from [get_clocks CORE_CLK] -to [get_clocks RTC_CLK]
    	set_min_delay 0 -from [get_clocks RTC_CLK] -to [get_clocks CORE_CLK]
    	set_min_delay 0 -from [get_clocks BUS_CLK] -to [get_clocks RTC_CLK]
    	set_min_delay 0 -from [get_clocks RTC_CLK] -to [get_clocks BUS_CLK]
    }

}

if {[info exists NDS_IO_ILM_TL_UL]} {
    if {$ilm_clk_ratio != 1} {
	set_multicycle_path -setup [expr $ilm_clk_ratio   ] -start -from  [get_clocks CORE_CLK] -to [get_clocks ILM_TL_UL_CLK]
	set_multicycle_path -hold  [expr $ilm_clk_ratio -1] -start -from  [get_clocks CORE_CLK] -to [get_clocks ILM_TL_UL_CLK]
	set_multicycle_path -setup [expr $ilm_clk_ratio   ] -end   -from  [get_clocks ILM_TL_UL_CLK] -to [get_clocks CORE_CLK]
	set_multicycle_path -hold  [expr $ilm_clk_ratio -1] -end   -from  [get_clocks ILM_TL_UL_CLK] -to [get_clocks CORE_CLK]
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
        set_max_delay $bus_clk_period_ns -from [get_clocks CORE_CLK] -to [get_clocks BUS_CLK]
        set_max_delay $bus_clk_period_ns -from [get_clocks BUS_CLK] -to [get_clocks CORE_CLK]
    } else {
        set_max_delay $core_clk_period_ns -from [get_clocks CORE_CLK] -to [get_clocks BUS_CLK]
        set_max_delay $core_clk_period_ns -from [get_clocks BUS_CLK] -to [get_clocks CORE_CLK]
    }
    set_min_delay 0 -from [get_clocks CORE_CLK] -to [get_clocks BUS_CLK]
    set_min_delay 0 -from [get_clocks BUS_CLK] -to [get_clocks CORE_CLK]
}

#if {$ilm_clk_ratio != 1} ##	CORE to ILM not multicycle path
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
	if {[llength [find / -port $sig]]} {
		path_disable -through [find / -port $sig]
	}
}

### Extra constraint
set_attribute preserve size_ok [find / -instance *kv_cpuid*]

if {[llength [find / -instance *gen_dlm.u_dlm*]]} {
	ungroup -flatten [find / -instance *gen_dlm.u_dlm*]
}

