#- Input/Output delay -#

#- Input driving & output load -#
set loading_pin_exist [regexp {([A-Za-z0-9_]+)/([A-Za-z0-9_]+)} $loading_cell match loading_cell loading_pin]
set driving_pin_exist [regexp {([A-Za-z0-9_]+)/([A-Za-z0-9_]+)} $driving_cell match driving_cell driving_pin]
if {![llength [find lib_cell $tech_lib/$loading_cell]]} {
        puts "Error: Can't find $loading_cell"
        puts "       Please check the variable loading_cell in file .synopsys_dc.setup"
        exit
}
if {$loading_pin_exist} {
        if {![llength [filter [find lib_pin $tech_lib/$loading_cell/$loading_pin] -regexp {@port_direction == in}]]} {
                puts "Error: Can't find input pin name '$loading_pin' in $loading_cell"
                puts "       Please check the variable loading_cell in file .synopsys_dc.setup"
                exit
        }
        set loading_cell_path "${tech_lib}/$loading_cell/$loading_pin"
} else {
        set loading_cell_path [get_object_name [filter [find lib_pin $tech_lib/$loading_cell/*] -regexp {@port_direction == in}]]
}

if {![llength [find lib_cell $tech_lib/$driving_cell]]} {
        puts "Error: Can't find $driving_cell"
        puts "       Please check the variable driving_cell in file .synopsys_dc.setup"
        exit
}
if {$driving_pin_exist} {
        if {![llength [filter [find lib_pin $tech_lib/$driving_cell/$driving_pin] -regexp {@port_direction == out}]]} {
                puts "Error: Can't find output pin name '$driving_pin' in $driving_cell"
                puts "       Please check the variable driving_cell in file .synopsys_dc.setup"
                exit
        }
}

set_load [expr [load_of $loading_cell_path] * 16] [all_outputs]
set_driving_cell -lib_cell $driving_cell -library ${tech_lib} -no_design_rule [all_inputs]

#- false path -#
set_input_delay 0 -clock [get_clocks CORE_CLK] [get_ports hart0_core_reset_n*]
if {[llength [get_ports -quiet por_rstn*]]} {
	set_input_delay 0 -clock [get_clocks CORE_CLK] [get_ports por_rstn*]
}
if {[llength [get_ports -quiet rtc_rstn*]]} {
	set_input_delay 0 -clock [get_clocks CORE_CLK] [get_ports rtc_rstn*]
}
if {[llength [get_ports -quiet test_mode*]]} {
	set_input_delay 0 -clock [get_clocks CORE_CLK] [get_ports test_mode*]
}

if {[llength [get_ports -quiet ahb_bus_clk_en]]} {
    set estrb_ratio          0.25
    set estrb_coreclk_delay [expr $core_clk_period * $estrb_ratio]

    set_input_delay [expr $estrb_coreclk_delay] -clock [get_clocks CORE_CLK] [get_ports ahb_bus_clk_en*] 
}

##set core_ratio 0.5
##set core_output_delay [expr {($core_clk_period - $synthesis_margin) * $core_ratio}]
##
##set_output_delay $core_output_delay -clock [get_clocks CORE_CLK] [get_ports hart0_core_wfi_mode]
##set_output_delay $core_output_delay -clock [get_clocks CORE_CLK] [get_ports stoptime]


#- BUS_CLK domain -#
#- The synthesis_margin is subtracted from bus_clk_period for compensating clock uncertainty -#
##set bus_ratio    0.667
set bus_ratio    0.3
set bus_input_delay  [expr {($bus_clk_period - $synthesis_margin) * $bus_ratio}]
set bus_output_delay  [expr {($bus_clk_period - $synthesis_margin) * $bus_ratio}]


#- AHB -#
if {[llength [get_ports -quiet hclk]]} {
    if {[llength [get_ports -quiet hgrant*]]} {
        set_input_delay  $bus_input_delay -clock [get_clocks $bus_clk_name] [get_ports hgrant*]
        set_output_delay $bus_output_delay -clock [get_clocks $bus_clk_name] [get_ports hbusreq*]
    }
    set_input_delay  0             -clock [get_clocks $bus_clk_name] [get_ports hresetn]
    set_input_delay  $bus_input_delay -clock [get_clocks $bus_clk_name] [get_ports hrdata*]
    set_input_delay  $bus_input_delay -clock [get_clocks $bus_clk_name] [get_ports hresp*]
    set_input_delay  $bus_input_delay -clock [get_clocks $bus_clk_name] [get_ports hready*]
 
    set_output_delay $bus_output_delay -clock [get_clocks $bus_clk_name] [get_ports haddr*]
    set_output_delay $bus_output_delay -clock [get_clocks $bus_clk_name] [get_ports hburst*]
    if {[llength [get_ports -quiet hlock*]]} {
    set_output_delay $bus_output_delay -clock [get_clocks $bus_clk_name] [get_ports hlock*]
    }
    set_output_delay $bus_output_delay -clock [get_clocks $bus_clk_name] [get_ports hprot*]
    set_output_delay $bus_output_delay -clock [get_clocks $bus_clk_name] [get_ports hsize*]

    set_output_delay $bus_output_delay -clock [get_clocks $bus_clk_name] [get_ports htrans*]
    set_output_delay $bus_output_delay -clock [get_clocks $bus_clk_name] [get_ports hwdata*]
    set_output_delay $bus_output_delay -clock [get_clocks $bus_clk_name] [get_ports hwrite*]

    if {[llength [get_ports -quiet slv_hready*]]} {
    set_input_delay  $bus_input_delay -clock [get_clocks $bus_clk_name] [get_ports slv_hsel*]
    set_input_delay  $bus_input_delay -clock [get_clocks $bus_clk_name] [get_ports slv_hready]
    set_input_delay  $bus_input_delay -clock [get_clocks $bus_clk_name] [get_ports slv_haddr*]
    set_input_delay  $bus_input_delay -clock [get_clocks $bus_clk_name] [get_ports slv_hburst*]
    set_input_delay  $bus_input_delay -clock [get_clocks $bus_clk_name] [get_ports slv_hsize*]
    set_input_delay  $bus_input_delay -clock [get_clocks $bus_clk_name] [get_ports slv_htrans*]
    set_input_delay  $bus_input_delay -clock [get_clocks $bus_clk_name] [get_ports slv_hwdata*]
    set_input_delay  $bus_input_delay -clock [get_clocks $bus_clk_name] [get_ports slv_hwrite*]

    set_output_delay $bus_output_delay -clock [get_clocks $bus_clk_name] [get_ports slv_hrdata*]
    set_output_delay $bus_output_delay -clock [get_clocks $bus_clk_name] [get_ports slv_hreadyout*]
    }

    if {[llength [get_ports -quiet dm_sys_hready*]]} {
    set_input_delay  $bus_input_delay -clock [get_clocks $bus_clk_name]  [get_ports dm_sys_hrdata*]
    set_input_delay  $bus_input_delay -clock [get_clocks $bus_clk_name]  [get_ports dm_sys_hresp*]
    set_input_delay  $bus_input_delay -clock [get_clocks $bus_clk_name]  [get_ports dm_sys_hready*]
    
    set_output_delay $bus_output_delay -clock [get_clocks $bus_clk_name] [get_ports dm_sys_haddr*]
    set_output_delay $bus_output_delay -clock [get_clocks $bus_clk_name] [get_ports dm_sys_hburst*]
    set_output_delay $bus_output_delay -clock [get_clocks $bus_clk_name] [get_ports dm_sys_hbusreq*]
    set_output_delay $bus_output_delay -clock [get_clocks $bus_clk_name] [get_ports dm_sys_hprot*]
    set_output_delay $bus_output_delay -clock [get_clocks $bus_clk_name] [get_ports dm_sys_hsize*]
    set_output_delay $bus_output_delay -clock [get_clocks $bus_clk_name] [get_ports dm_sys_htrans*]
    set_output_delay $bus_output_delay -clock [get_clocks $bus_clk_name] [get_ports dm_sys_hwrite*]
    set_output_delay $bus_output_delay -clock [get_clocks $bus_clk_name] [get_ports dm_sys_hwdata*]
    }
}

#- APB -#
if {[llength [get_ports -quiet pclk]]} {
    set_input_delay  0             -clock [get_clocks $bus_clk_name] [get_ports preset_n]
    set_input_delay  $bus_input_delay -clock [get_clocks $bus_clk_name] [get_ports prdata*]
    set_output_delay $bus_output_delay -clock [get_clocks $bus_clk_name] [get_ports paddr*]
    set_output_delay $bus_output_delay -clock [get_clocks $bus_clk_name] [get_ports psel*]
    set_output_delay $bus_output_delay -clock [get_clocks $bus_clk_name] [get_ports pwdata*]
    set_output_delay $bus_output_delay -clock [get_clocks $bus_clk_name] [get_ports penable*]
    set_output_delay $bus_output_delay -clock [get_clocks $bus_clk_name] [get_ports pwrite*]

    set_input_delay  $bus_input_delay -clock [get_clocks $bus_clk_name] [get_ports pready*]
    set_input_delay  $bus_input_delay -clock [get_clocks $bus_clk_name] [get_ports pslverr*]
    set_output_delay $bus_output_delay -clock [get_clocks $bus_clk_name] [get_ports pprot*]
    set_output_delay $bus_output_delay -clock [get_clocks $bus_clk_name] [get_ports pstrb*]
    if {[llength [get_ports -quiet pdebug_access*]]} {
        set_output_delay $bus_output_delay -clock [get_clocks $bus_clk_name] [get_ports pdebug_access*]
    }
}


##- Interrupt related or asynchronous path -#
set ff_ratio 0.25
set ff_io_delay [expr {($core_clk_period - $synthesis_margin) * $ff_ratio}]

# Synchronous Input 
set sync_input_list {"hart0_nmi" "meip" "meiid*" "mtip" "msip" "seip" "debugint" "hart0_reset_vector*" "hart0_icache_disable_init" "hart0_dcache_disable_init" "int_src*" "dbg_wakeup_ack"}

foreach sig $sync_input_list {
        if {[llength [get_ports -quiet $sig]]} {
		set_input_delay 0 -clock [get_clocks CORE_CLK] [get_ports $sig]
        }
}

# Synchronous Output
set sync_output_list {"hart0_core_wfi_mode" "hart_unavail" "hart_halted" "hart_under_reset" "stoptime" "meiack" "dbg_srst_req" "dbg_wakeup_req"}

foreach sig $sync_output_list {
        if {[llength [get_ports -quiet $sig]]} {
		set_output_delay $ff_io_delay -clock [get_clocks CORE_CLK] [get_ports $sig]
	}
}

# TCK Input 
set tck_input_ratio     0.68
set tck_input_io_delay [expr {$tap_clk_period * $tck_input_ratio}]

set tck_output_ratio     0.19
set tck_output_io_delay [expr {$tap_clk_period * $tck_output_ratio}]

set tck_input_list {"pin_tdi_in" "pin_tdo_in" "pin_tms_in" "pin_trst_in"}
foreach sig $tck_input_list {
        if {[llength [get_ports -quiet $sig]]} {
                set_input_delay $tck_input_io_delay -clock [get_clocks TAP_CLK] [get_ports $sig]
        }
}

# TCK Output
set tck_output_list {"pin_tdi_out" "pin_tdi_out_en" "pin_tdo_out" "pin_tdo_out_en" "pin_tms_out" "pin_tms_out_en" "pin_trst_out" "pin_trst_out_en"}
foreach sig $tck_output_list {
        if {[llength [get_ports -quiet $sig]]} {
                set_output_delay $tck_output_io_delay -clock [get_clocks TAP_CLK] [get_ports $sig]
        }
}

set nceeic_output_list {"ilm_haddr*" "ilm_hwdata*" "ilm_hburst*" "ilm_hprot*" "ilm_hsize*" "ilm_htrans*" "ilm_hwrite"}
set nceeic_input_list {"ilm_hrdata*" "ilm_hready" "ilm_hresp*"}
foreach sig $nceeic_input_list {
        if {[llength [get_ports -quiet $sig]]} {
                set_input_delay $bus_input_delay -clock [get_clocks $bus_clk_name] [get_ports $sig]
	}
}

foreach sig $nceeic_output_list {
        if {[llength [get_ports -quiet $sig]]} {
                set_output_delay $bus_output_delay -clock [get_clocks $bus_clk_name] [get_ports $sig]
        }
}


