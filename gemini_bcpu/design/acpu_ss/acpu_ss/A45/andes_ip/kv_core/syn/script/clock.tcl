proc set_clk_margin {clk_margin gck_margin gck_autogen_clk_in has_gck ilm_clk_ratio} {

	if {$clk_margin == 0 } { 
		remove_clock_uncertainty [get_clocks]
	} else {
		set_clock_uncertainty $clk_margin [get_clocks]
		if {[llength [get_clocks -quiet ILM_TL_UL_CLK]]} {
			set clk_margin_x2 [expr $clk_margin * $ilm_clk_ratio]
			set_clock_uncertainty $clk_margin_x2 [get_clocks ILM_TL_UL_CLK]
		}
	}

	#- Manual gated cell -#
	if {$has_gck} {
		if {$gck_margin > $clk_margin} {
			set_clock_gating_check -setup [expr $gck_margin - $clk_margin]
		}
	}
}


if {![info exists clock_uncertainty]} {
	set clock_uncertainty 0.0
}

if {![info exists apr_margin]} {
	set apr_margin 0.3
}

### Create clock ###
set synthesis_margin [expr $clock_uncertainty + $apr_margin]
set gck_synthesis_margin [expr $clock_uncertainty + 1.0 * $apr_margin]

foreach bus_pin {"aclk*" "hclk*"} {
        if {[llength [get_ports -quiet $bus_pin]]} {
                set bus_clk_pin $bus_pin
                break
        }
}
if {![info exists bus_clk_pin]} {
	set bus_clk_pin ""
	set bus_clk_period $core_clk_period
}

if {!$bus_async && $bus_clk_period == $core_clk_period} {
	set core_clk_list {CORE_CLK}
	set bus_clk_name CORE_CLK
	create_clock  -name CORE_CLK [get_ports -quiet "core_clk* dc_clk* lm_clk* $bus_clk_pin"] \
	              -period $core_clk_period \
	              -waveform [list 0 [expr $core_clk_period*0.5]]
} else {
	set core_clk_list {CORE_CLK BUS_CLK}
	set bus_clk_name BUS_CLK
	create_clock  -name CORE_CLK [get_ports -quiet "core_clk* dc_clk* lm_clk*"] \
	              -period $core_clk_period \
	              -waveform [list 0 [expr $core_clk_period*0.5]]

	create_clock -name BUS_CLK [get_ports $bus_clk_pin] \
              -period $bus_clk_period \
              -waveform [list 0 [expr $bus_clk_period*0.5]]
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

#create_generated_clock [get_pins kv_core_top*/u_ilm_clkgen/clk_out]  -name ILM_CLK  -divide_by $ilm_clk_ratio -source [get_ports lm_clk*]
#create_generated_clock [get_pins kv_core_top*/u_dlm_clkgen/clk_out]  -name DLM_CLK  -divide_by $dlm_clk_ratio -source [get_ports lm_clk*]

if {$machine_timer_support} {
        if {[llength [get_ports -quiet mtime_clk]]} {
		create_clock -name RTC_CLK [get_ports mtime_clk] \
			-period 31250000 \
			-waveform [list 0 [expr 31250000*0.5]]
	}
}

if {$has_vpu} {
    create_generated_clock [get_pins $VPU_MODULE/core_clk]  -name VPU_CLK  -divide_by 1 -source [get_ports core_clk]
}

if {$has_ilm_tl_ul} {
     create_generated_clock [get_pins u_clock_gen/clk_out]  -name ILM_TL_UL_CLK  -divide_by [expr $ilm_clk_ratio] -source [get_ports lm_clk]
}

puts "synthesis_margin $synthesis_margin\n"
puts "gck_synthesis_margin $gck_synthesis_margin\n"

set_clk_margin $synthesis_margin $gck_synthesis_margin $gck_autogen_clk_in $has_vpu $ilm_clk_ratio

set_clock_gating_check -setup 0

