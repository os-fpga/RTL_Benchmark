#- Input/Output delay -#
set eilm_support 0
set edlm_support 0
set cop_support 0
set ex9_hw_support 0
set ex9_hw_rom_support 0
set mmu_support 0

#- Input driving & output load -#
set loading_pin_exist [regexp {([A-Za-z0-9_]+)/([A-Za-z0-9_]+)} $loading_cell match loading_cell loading_pin]
set driving_pin_exist [regexp {([A-Za-z0-9_]+)/([A-Za-z0-9_]+)} $driving_cell match driving_cell driving_pin]
if {![llength [find / -libcell $loading_cell]]} {
	puts "Error: Can't find $loading_cell"
	puts "       Please check variable loading_cell in syn_setup_rc.tcl"
	exit
}
if ($loading_pin_exist) {
	if {![llength [filter [find / -libpin $tech_lib/$loading_cell/$loading_pin] -regexp {@port_direction == in}]]} {
		puts "Error: Can't find input pin name '$loading_pin' in $loading_cell"
		puts "       Please check variable loading_cell in syn_setup_rc.tcl"
		exit
	}
	set loading_input_pin [find / -libcell $loading_cell]/$loading_pin
} else {
	foreach libpin [find [find / -libcell $loading_cell] -libpin *] {
		if {[get_attribute input $libpin] == "true"} {
			set loading_input_pin $libpin;
		}
	}
}
if {![llength [find / -libcell $driving_cell]]} {
	puts "Error: Can't find $driving_cell"
	puts "       Please check variable driving_cell in syn_setup_rc.tcl"
	exit
}
if ($driving_pin_exist) {
	if {![llength [filter [find / -libpin $tech_lib/$driving_cell/$driving_pin] -regexp {@port_direction == out}]]} {
		puts "Error: Can't find output pin name '$driving_pin' in $driving_cell"
		puts "       Please check variable driving_pin in syn_setup_rc.tcl"
		exit
	}
	set driving_output_pin [find / -libcell $driving_cell]/$driving_pin
} else {
	foreach libpin [find [find / -libcell $driving_cell] -libpin *] {
		if {[get_attribute output $libpin] == "true"} {
			set driving_output_pin $libpin
		}
	}
}

set_attribute external_pin_cap [expr 16 * [get_attr load $loading_input_pin]] /designs/$DESIGN/ports_out/*
set_attribute external_driver $driving_output_pin /designs/$DESIGN/ports_in/*

#- false path -#
external_delay -input 0 -clock [find / -clock CORE_CLK] [find / -port hart0_core_reset_n] 
if {[llength [find / -port por_rstn]]} {
external_delay -input 0 -clock [find / -clock TAP_CLK] [find / -port por_rstn] 
}
if {[llength [find / -port rtc_rstn]]} {
external_delay -input 0 -clock [find / -clock RTC_CLK] [find / -port rtc_rstn] 
}
if {[llength [find / -port test_mode]]} {
external_delay -input 0 -clock [find / -clock CORE_CLK] [find / -port test_mode] 
}

set estrb_ratio          0.25
set estrb_coreclk_delay  [expr $core_clk_period * $estrb_ratio]

external_delay -input [expr $estrb_coreclk_delay] -clock [find / -clock CORE_CLK] [find / -port ahb_bus_clk_en]

# --- BUS_CLK domain --- #
#- The synthesis_margin is subtracted from bus_clk_period for compensating clock uncertainty -#
#- AHB -#

#set bus_ratio     0.667
set bus_ratio    0.3
set bus_io_delay  [expr {($bus_clk_period - $synthesis_margin) * $bus_ratio}]

if {[llength [find / -port hresetn]]} {
external_delay -input  0                    -clock [find / -clock $bus_clk_name] [find / -port hresetn]
}
set sync_input_list { "hgrant*" "hrdata*" "hresp*" "hready*"}
set sync_output_list { "hbusreq*" "haddr*" "hburst*" "hlock*" "hprot*" "hsize*" "htrans*" "hwdata*" "hwrite*"}

foreach sig $sync_input_list {
        if {[llength [find / -port $sig]]} {
		external_delay -input  [expr $bus_io_delay] -clock [find / -clock $bus_clk_name] [find / -port $sig]    
        }
}

foreach sig $sync_output_list {
        if {[llength [find / -port $sig]]} {
		external_delay -output [expr $bus_io_delay] -clock [find / -clock $bus_clk_name] [find / -port $sig]   
        }
}

set slv_input_list {"slv_hsel*" "slv_hready" "slv_haddr*" "slv_hburst*" "slv_hsize*" "slv_htrans*" "slv_hwdata*" "slv_hwrite*" "slv_hlock*" "slv_hprot*"}
set slv_output_list {"slv_hrdata*" "slv_hreadyout*" "slv_hresp*"}


foreach sig $slv_input_list {
        if {[llength [find / -port $sig]]} {
		external_delay -input  [expr $bus_io_delay] -clock [find / -clock $bus_clk_name] [find / -port $sig]    
        }
}

foreach sig $slv_output_list {
        if {[llength [find / -port $sig]]} {
		external_delay -output [expr $bus_io_delay] -clock [find / -clock $bus_clk_name] [find / -port $sig]   
        }
}


set dbg_input_list {"dm_sys_hrdata*" "dm_sys_hresp*" "dm_sys_hready*" "dm_sys_hgrant*"}
set dbg_output_list {"dm_sys_haddr*" "dm_sys_hburst*" "dm_sys_hbusreq*" "dm_sys_hprot*" "dm_sys_hsize*" "dm_sys_htrans*" "dm_sys_hwrite*" "dm_sys_hwdata*"}


foreach sig $dbg_input_list {
        if {[llength [find / -port $sig]]} {
		external_delay -input  [expr $bus_io_delay] -clock [find / -clock $bus_clk_name] [find / -port $sig]    
        }
}

foreach sig $dbg_output_list {
        if {[llength [find / -port $sig]]} {
		external_delay -output [expr $bus_io_delay] -clock [find / -clock $bus_clk_name] [find / -port $sig]   
        }
}


set ff_ratio     0.25
set ff_io_delay [expr {($core_clk_period - $synthesis_margin) * $ff_ratio}]

# Synchronous Input 
set sync_input_list {"hart0_nmi" "meip" "meiid*" "mtip" "msip" "seip" "debugint" "hart0_reset_vector*" "hart0_icache_disable_init" "hart0_dcache_disable_init" "int_src*" "dbg_wakeup_ack"}

foreach sig $sync_input_list {
        if {[llength [find / -port $sig]]} {
                external_delay -input [expr $ff_io_delay] -clock [find / -clock CORE_CLK] [find / -port $sig]
        }
}

# Synchronous Output
set sync_output_list {"hart0_core_wfi_mode" "hart_unavail" "hart_halted" "hart_under_reset" "stoptime" "meiack" "dbg_srst_req" "dbg_wakeup_req"}

foreach sig $sync_output_list {
        if {[llength [find / -port $sig]]} {
                external_delay -output [expr $ff_io_delay] -clock [find / -clock CORE_CLK] [find / -port $sig]
        }
}

# TCK Input 
set tck_input_ratio     0.68
set tck_input_io_delay [expr {$tap_clk_period * $tck_input_ratio}]

set tck_output_ratio     0.19
set tck_output_io_delay [expr {$tap_clk_period * $tck_output_ratio}]

set tck_input_list {"pin_tdi_in" "pin_tdo_in" "pin_tms_in" "pin_trst_in"}
foreach sig $tck_input_list {
        if {[llength [find / -port $sig]]} {
                external_delay -input [expr $tck_input_io_delay] -clock [find / -clock TAP_CLK] [find / -port $sig]
        }
}

# TCK Output
set tck_output_list {"pin_tdi_out" "pin_tdi_out_en" "pin_tdo_out" "pin_tdo_out_en" "pin_tms_out" "pin_tms_out_en" "pin_trst_out" "pin_trst_out_en"}
foreach sig $tck_output_list {
        if {[llength [find / -port $sig]]} {
                external_delay -output [expr $tck_output_io_delay] -clock [find / -clock TAP_CLK] [find / -port $sig]
        }
}

# nceeic100 interface delay
set nceeic_output_list {"ilm_haddr*" "ilm_hwdata*" "ilm_hburst*" "ilm_hprot*" "ilm_hsize*" "ilm_htrans*" "ilm_hwrite"}
set nceeic_input_list {"ilm_hrdata*" "ilm_hready" "ilm_hresp*"}
foreach sig $nceeic_input_list {
        if {[llength [find / -port $sig]]} {
		external_delay -input  [expr $bus_io_delay] -clock [find / -clock $bus_clk_name] [find / -port $sig]    
        }
}

foreach sig $nceeic_output_list {
        if {[llength [find / -port $sig]]} {
		external_delay -output [expr $bus_io_delay] -clock [find / -clock $bus_clk_name] [find / -port $sig]   
        }
}

