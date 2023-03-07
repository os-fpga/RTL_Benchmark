proc set_clk_margin {clk_margin} {

	if {$clk_margin == 0 } { 
		remove_clock_uncertainty [get_clocks]
    	} else {
		set_clock_uncertainty $clk_margin [get_clocks]
	}

}

if {![info exist clock_uncertainty]} {
	set clock_uncertainty 0.0
}

if {![info exist apr_margin]} {
	set apr_margin 0.3
}

### Create clock ###
set synthesis_margin [expr $clock_uncertainty + $apr_margin]

foreach bus_pin {"aclk*" "hclk*" "pclk*"} {
        if {[llength [get_ports -quiet $bus_pin]]} {
                set bus_clk_pin $bus_pin
                break
        }
}

if {$bus_clk_period == $core_clk_period} {
	set core_clk_list {CORE_CLK}
	set bus_clk_name CORE_CLK
	create_clock  -name CORE_CLK [list [get_ports core_clk] [get_ports $bus_clk_pin]] \
	              -period $core_clk_period \
	              -waveform [list 0 [expr $core_clk_period*0.5]]
} else {
	set core_clk_list {CORE_CLK BUS_CLK}
	set bus_clk_name BUS_CLK
	create_clock  -name CORE_CLK [get_ports core_clk] \
	              -period $core_clk_period \
	              -waveform [list 0 [expr $core_clk_period*0.5]]

	create_clock -name BUS_CLK [get_ports $bus_clk_pin] \
              -period $bus_clk_period \
              -waveform [list 0 [expr $bus_clk_period*0.5]]
}

if {$debug_module_support} {
        if {[llength [get_ports -quiet dbg_tck]]} {
		create_clock -name TAP_CLK [get_ports dbg_tck] \
                	-period [expr $tap_clk_period] \
			-waveform [list 0 [expr $tap_clk_period*0.5]]
	}
}

if {$machine_timer_support} {
        if {[llength [get_ports -quiet clk_32k]]} {
		create_clock -name RTC_CLK [get_ports clk_32k] \
			-period 31250000 \
			-waveform [list 0 [expr 31250000*0.5]]
	}
}

puts "synthesis_margin $synthesis_margin\n"

set_clk_margin $synthesis_margin 

set_clock_gating_check -setup 0

