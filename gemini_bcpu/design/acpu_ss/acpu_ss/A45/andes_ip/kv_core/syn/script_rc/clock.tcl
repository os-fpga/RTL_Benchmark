proc set_clk_margin {clk_margin gck_margin has_vpu has_ilm_tl_ul ilm_clk_ratio} {
	clock_uncertainty $clk_margin [find / -clock CORE_CLK]
	if {$has_vpu} {
		clock_uncertainty $clk_margin [find / -clock VPU_CLK]
	}
	if {$has_ilm_tl_ul} {
		set clk_tl_ul_margin [expr $clk_margin * $ilm_clk_ratio]
		clock_uncertainty $clk_tl_ul_margin [find / -clock ILM_TL_UL_CLK]
	}
}

if {![info exists clock_uncertainty]} {
	set clock_uncertainty 0
}

if {![info exists apr_margin]} {
	set apr_margin 300
}

set synthesis_margin [expr $clock_uncertainty + $apr_margin]
set gck_synthesis_margin [expr $clock_uncertainty + 1.5 * $apr_margin]

#- Create clock -#

set ahb_bus_clk_pin "hclk*"
set axi_bus_clk_pin "aclk*"
if {!$bus_async && ($bus_clk_period == $core_clk_period)} {
	set core_clk_list {CORE_CLK}
	set bus_clk_name CORE_CLK
	define_clock -name CORE_CLK -period [expr $core_clk_period] \
	[list [find /designs/$DESIGN -port core_clk*] \
	      [find /designs/$DESIGN -port dc_clk*] \
	      [find /designs/$DESIGN -port lm_clk*] \
	      [find /designs/$DESIGN -port $ahb_bus_clk_pin] \
	      [find /designs/$DESIGN -port $axi_bus_clk_pin]]
} else {
	set core_clk_list [list "CORE_CLK" "BUS_CLK"]
	set bus_clk_name BUS_CLK
	define_clock -name CORE_CLK -period [expr $core_clk_period] \
		[list [find /designs/$DESIGN -port core_clk*] \
	              [find /designs/$DESIGN -port dc_clk*] \
	              [find /designs/$DESIGN -port lm_clk*]]
	define_clock -name BUS_CLK -period [expr $bus_clk_period] \
		[list [find /designs/$DESIGN -port $ahb_bus_clk_pin] \
		      [find /designs/$DESIGN -port $axi_bus_clk_pin]]
}

#if {[info exists NDS_ILM_CLK_RATIO]} {
#        set ilm_clk_ratio $NDS_ILM_CLK_RATIO
#} else {
#        set ilm_clk_ratio 1
#}
#
#if {[info exists NDS_DLM_CLK_RATIO]} {
#        set dlm_clk_ratio $NDS_DLM_CLK_RATIO
#} else {
#        set dlm_clk_ratio 1
#}
#
#puts "ilm_clk_ratio $ilm_clk_ratio\n"
#puts "dlm_clk_ratio $dlm_clk_ratio\n"
#
#create_generated_clock [get_pins kv_core_top*/u_ilm_clkgen/clk_out]  -name ILM_CLK  -divide_by $ilm_clk_ratio -source [find /designs/$DESIGN -port lm_clk*]
#create_generated_clock [get_pins kv_core_top*/u_dlm_clkgen/clk_out]  -name DLM_CLK  -divide_by $dlm_clk_ratio -source [find /designs/$DESIGN -port lm_clk*]
#clock_uncertainty $synthesis_margin [find / -clock ILM_CLK]
#clock_uncertainty $synthesis_margin [find / -clock DLM_CLK]

if {$machine_timer_support} {
     define_clock -name RTC_CLK [find /designs/$DESIGN -port mtime_clk] -period 31250000
}

if {$has_vpu} {
     create_generated_clock [get_pins $VPU_MODULE/core_clk]  -name VPU_CLK  -divide_by 1 -source [get_ports core_clk]
}

if {$has_ilm_tl_ul} {
     create_generated_clock [get_pins u_clock_gen/clk_out]  -name ILM_TL_UL_CLK  -divide_by [expr $ilm_clk_ratio] -source [get_ports lm_clk]
}


puts "synthesis_margin $synthesis_margin\n"
puts "gck_synthesis_margin $gck_synthesis_margin\n"

set_clk_margin $synthesis_margin $gck_synthesis_margin $has_vpu $has_ilm_tl_ul $ilm_clk_ratio

#- Case Analysis -#
#set_attribute timing_case_logic_value 0 [find /designs/$DESIGN -port scan_test]
#set_attribute timing_case_logic_value 0 [find /designs/$DESIGN -port scan_enable]
