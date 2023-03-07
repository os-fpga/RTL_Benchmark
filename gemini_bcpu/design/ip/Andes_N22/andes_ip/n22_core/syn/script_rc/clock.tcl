proc set_clk_margin {clk_margin gck_margin debug_module_support } {
	clock_uncertainty $clk_margin [find / -clock CORE_CLK]

	if {[llength [find / -clock BUS_CLK]]} {
		clock_uncertainty $clk_margin [find / -clock BUS_CLK]
	}

	if {$debug_module_support} {
		clock_uncertainty $clk_margin [find / -clock TAP_CLK]
	}
#        if {[llength [find / -pin *RC_CG_HIER_INST*/ck_in]]} {
#            clock_uncertainty $gck_margin [find / -pin *RC_CG_HIER_INST*/ck_in]
#        }

}

if {![info exist clock_uncertainty]} {
	set clock_uncertainty 0
}

if {![info exist apr_margin]} {
	set apr_margin 300
}

set synthesis_margin [expr $clock_uncertainty + $apr_margin]
set gck_synthesis_margin [expr $clock_uncertainty + 1.5 * $apr_margin]

#- Create clock -#

set ahb_bus_clk_pin "hclk*"
set axi_bus_clk_pin "aclk*"
if {$bus_clk_period == $core_clk_period} {
	set core_clk_list CORE_CLK
	set bus_clk_name CORE_CLK
	define_clock -name CORE_CLK -period [expr $core_clk_period] \
		[list [find /designs/$DESIGN -port core_clk] \
		      [find /designs/$DESIGN -port $ahb_bus_clk_pin] \
		      [find /designs/$DESIGN -port $axi_bus_clk_pin]]
} else {
	set core_clk_list [list "CORE_CLK" "BUS_CLK"]
	set bus_clk_name BUS_CLK
	define_clock -name CORE_CLK -period [expr $core_clk_period] \
		[list [find /designs/$DESIGN -port core_clk]]
	define_clock -name BUS_CLK -period [expr $bus_clk_period] \
		[list [find /designs/$DESIGN -port $ahb_bus_clk_pin] \
		      [find /designs/$DESIGN -port $axi_bus_clk_pin]]
}
if {$debug_module_support} {
     define_clock -name TAP_CLK [find /designs/$DESIGN -port dbg_tck] \
                   -period [expr $tap_clk_period]
}

if {$machine_timer_support} {
     define_clock -name RTC_CLK [find /designs/$DESIGN -port mtime_clk] -period 31250000
}


puts "synthesis_margin $synthesis_margin\n"
puts "gck_synthesis_margin $gck_synthesis_margin\n"

set_clk_margin $synthesis_margin $gck_synthesis_margin $debug_module_support

#- Case Analysis -#
#set_attribute timing_case_logic_value 0 [find /designs/$DESIGN -port scan_test]
#set_attribute timing_case_logic_value 0 [find /designs/$DESIGN -port scan_enable]
