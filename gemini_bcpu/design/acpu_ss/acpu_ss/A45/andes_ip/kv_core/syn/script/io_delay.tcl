#- Input/Output delay -#

#- Input driving & output load -#
set loading_pin_exist [regexp {([A-Za-z0-9_]+)/([A-Za-z0-9_]+)} $loading_cell match loading_cell loading_pin]
set driving_pin_exist [regexp {([A-Za-z0-9_]+)/([A-Za-z0-9_]+)} $driving_cell match driving_cell driving_pin]
set E	"E"
if {![llength [find lib_cell $tech_lib/$loading_cell]]} {
        puts "${E}rror: Can't find $loading_cell"
        puts "       Please check the variable loading_cell in file syn_setup_dc.tcl"
        exit
}
if {$loading_pin_exist} {
        if {![llength [filter [find lib_pin $tech_lib/$loading_cell/$loading_pin] -regexp {@port_direction == in}]]} {
                puts "${E}rror: Can't find input pin name '$loading_pin' in $loading_cell"
                puts "       Please check the variable loading_cell in file syn_setup_dc.tcl"
                exit
        }
        set loading_cell_path "${tech_lib}/$loading_cell/$loading_pin"
} else {
        set loading_cell_path [get_object_name [filter [find lib_pin $tech_lib/$loading_cell/*] -regexp {@port_direction == in}]]
}

if {![llength [find lib_cell $tech_lib/$driving_cell]]} {
        puts "${E}rror: Can't find $driving_cell"
        puts "       Please check the variable driving_cell in file syn_setup_dc.tcl"
        exit
}
if {$driving_pin_exist} {
        if {![llength [filter [find lib_pin $tech_lib/$driving_cell/$driving_pin] -regexp {@port_direction == out}]]} {
                puts "${E}rror: Can't find output pin name '$driving_pin' in $driving_cell"
                puts "       Please check the variable driving_cell in file syn_setup_dc.tcl"
                exit
        }
}

set_load [expr [load_of $loading_cell_path] * 16] [all_outputs]
set_driving_cell -lib_cell $driving_cell -library ${tech_lib} -no_design_rule [all_inputs]

#- false path -#
set_input_delay 0 -clock [get_clocks CORE_CLK] [get_ports *core_reset*]
set_input_delay 0 -clock [get_clocks CORE_CLK] [get_ports test_mode]
set_input_delay 0 -clock [get_clocks CORE_CLK] [get_ports scan_enable]
if {[llength [get_ports -quiet *hart_id*]]} {
	set_input_delay 0 -clock [get_clocks CORE_CLK] [get_ports *hart_id*]
}
if {![string equal $PLATFORM "ae250"]} {
	set_input_delay 0 -clock [get_clocks CORE_CLK] [get_ports test_rstn]
}
if {[llength [get_ports -quiet por_rstn*]]} {
	set_input_delay 0 -clock [get_clocks CORE_CLK] [get_ports por_rstn]
}
if {[llength [get_ports -quiet rtc_rstn*]]} {
	set_input_delay 0 -clock [get_clocks RTC_CLK] [get_ports rtc_rstn]
}

set estrb_ratio          0.25
set estrb_coreclk_delay [expr $core_clk_period * $estrb_ratio]

if {[llength [get_ports -quiet bus2core_clken]]} {
    set_input_delay $estrb_coreclk_delay -clock [get_clocks CORE_CLK] [get_ports bus2core_clken*] 
}
if {[llength [get_ports -quiet *bus_clk_en]]} {
    set_input_delay $estrb_coreclk_delay -clock [get_clocks CORE_CLK] [get_ports *bus_clk_en] 
}

#- BUS_CLK domain -#
#- The synthesis_margin is subtracted from bus_clk_period for compensating clock uncertainty -#

set bus_ratio    0.667
set bus_io_delay  [expr {($bus_clk_period - $synthesis_margin) * $bus_ratio}]
# input external delay + input external delay + clock_uncertainty + internal delay, only for feed-through path
set bus_max_i2o_delay  [expr {($bus_clk_period - $synthesis_margin) * $bus_ratio * 2 + $synthesis_margin + ($bus_clk_period - $synthesis_margin) * (1 - $bus_ratio)}]

#- AHB -#
if {[llength [get_ports -quiet hresetn]]} {
	set_input_delay  0                -clock [get_clocks $bus_clk_name] [get_ports hresetn]
}
	
if {[string equal $NDS_BIU_BUS "ahb"]} {
	if {[string equal $NDS_BIU_PATH_X2 "yes"]} {
		set interface_list {"i_" "d_"}
	} else {
		set interface_list {""}
	}

	foreach ifname $interface_list {
		if {[llength [get_ports -quiet ${ifname}hgrant]]} {
			set_input_delay  $bus_io_delay  -clock [get_clocks $bus_clk_name] [get_ports ${ifname}hgrant]
			set_output_delay $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports ${ifname}hbusreq]
		}
		set_input_delay  $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports ${ifname}hrdata*]
		set_input_delay  $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports ${ifname}hresp*]
		set_input_delay  $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports ${ifname}hready]
		
		set_output_delay $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports ${ifname}haddr*]
		set_output_delay $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports ${ifname}hburst*]
		set_output_delay $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports ${ifname}hprot*]
		set_output_delay $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports ${ifname}hsize*]
		
		set_output_delay $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports ${ifname}htrans*]
		set_output_delay $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports ${ifname}hwdata*]
		set_output_delay $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports ${ifname}hwrite]
	}
# bmch feed through path
	set through_output_list {"haddr*" "hburst*" "hprot*" "hsize*" "htrans*" "hwdata*" "hwrite*"}
	if {[string equal $NDS_BIU_PATH_X2 "yes"]} {
		if {[llength [get_pins -quiet u_ahb_bmc_x2/hs2_bmc_hready]]} {
			foreach sig $through_output_list {
				set_max_delay $bus_max_i2o_delay -from [get_ports i_hready] -through [get_pins u_ahb_bmc_x2/hs2_bmc_hready] -to [get_ports i_$sig]
				set_max_delay $bus_max_i2o_delay -from [get_ports i_hresp*] -through [get_pins u_ahb_bmc_x2/hs2_hresp*]     -to [get_ports i_$sig]
			}
		}
		if {[llength [get_pins -quiet u_ahb_bmc_x2/hs3_bmc_hready]]} {
			foreach sig $through_output_list {
				set_max_delay $bus_max_i2o_delay -from [get_ports d_hready] -through [get_pins u_ahb_bmc_x2/hs3_bmc_hready] -to [get_ports d_$sig]
				set_max_delay $bus_max_i2o_delay -from [get_ports d_hresp*] -through [get_pins u_ahb_bmc_x2/hs3_hresp*]     -to [get_ports d_$sig]
			}
		}
	} else {
		if {[llength [get_pins -quiet u_ahb_bmc_x1/hs2_bmc_hready]]} {
			foreach sig $through_output_list {
				set_max_delay $bus_max_i2o_delay -from [get_ports hready] -through [get_pins u_ahb_bmc_x1/hs2_bmc_hready] -to [get_ports $sig]
				set_max_delay $bus_max_i2o_delay -from [get_ports hresp*] -through [get_pins u_ahb_bmc_x1/hs2_hresp*]     -to [get_ports $sig]
			}
		}
	}
}

if {[llength [get_ports -quiet aresetn]]} {
	set_input_delay  0                -clock [get_clocks $bus_clk_name] [get_ports aresetn]
}

if {[string equal $NDS_BIU_BUS "axi"]} {
	if {[string equal $NDS_BIU_PATH_X2 "yes"]} {
		set interface_list {"i_" "d_"}
	} else {
		set interface_list {""}
	}

	foreach ifname $interface_list {
		if {[llength [get_ports -quiet ${ifname}arvalid]]} {
			set_input_delay  $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports ${ifname}arready]
			set_input_delay  $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports ${ifname}awready]
			set_input_delay  $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports ${ifname}bid*]
			set_input_delay  $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports ${ifname}bresp*]
			set_input_delay  $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports ${ifname}bvalid]
			set_input_delay  $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports ${ifname}rdata*]
			set_input_delay  $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports ${ifname}rid*]
			set_input_delay  $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports ${ifname}rlast]
			set_input_delay  $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports ${ifname}rresp*]
			set_input_delay  $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports ${ifname}rvalid]
			set_input_delay  $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports ${ifname}wready]
			
			set_output_delay $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports ${ifname}araddr*]
			set_output_delay $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports ${ifname}arburst*]
			set_output_delay $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports ${ifname}arcache*]
			set_output_delay $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports ${ifname}arid*]
			set_output_delay $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports ${ifname}arlen*]
			set_output_delay $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports ${ifname}arlock*]
			set_output_delay $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports ${ifname}arprot*]
			set_output_delay $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports ${ifname}arsize*]
			set_output_delay $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports ${ifname}arvalid]
			set_output_delay $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports ${ifname}awaddr*]
			set_output_delay $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports ${ifname}awburst*]
			set_output_delay $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports ${ifname}awcache*]
			set_output_delay $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports ${ifname}awid*]
			set_output_delay $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports ${ifname}awlen*]
			set_output_delay $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports ${ifname}awlock*]
			set_output_delay $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports ${ifname}awprot*]
			set_output_delay $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports ${ifname}awsize*]
			set_output_delay $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports ${ifname}awvalid]
			set_output_delay $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports ${ifname}bready]
			set_output_delay $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports ${ifname}rready]
			set_output_delay $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports ${ifname}wdata*]
			set_output_delay $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports ${ifname}wlast]
			set_output_delay $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports ${ifname}wstrb*]
			set_output_delay $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports ${ifname}wvalid]
		}
	}
}

#- LM Slave Port -#
if {[llength [get_ports -quiet *slv_clk_en]]} {
        set_input_delay $estrb_coreclk_delay -clock  [get_clocks CORE_CLK] [get_ports *slv_clk_en]
}
if {[llength [get_ports -quiet *slv_reset_n]]} {
        set_input_delay  0                   -clock  [get_clocks CORE_CLK] [get_ports *slv_reset_n]
}

#- LM Slave Port AHB -#
if {[llength [get_ports -quiet *slv_hready*]]} {
        set_input_delay  $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports *slv_hsel*]
        set_input_delay  $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports *slv_htrans*]
        set_input_delay  $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports *slv_hready]
        set_input_delay  $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports *slv_haddr*]
        set_input_delay  $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports *slv_hburst*]
        set_input_delay  $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports *slv_hsize*]
        set_input_delay  $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports *slv_hprot*]
        set_input_delay  $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports *slv_hwdata*]
        set_input_delay  $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports *slv_hwrite*]

        set_output_delay $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports *slv_hrdata*]
        set_output_delay $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports *slv_hresp*]
        set_output_delay $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports *slv_hreadyout*]
}
if {[llength [get_ports -quiet *slv_huser*]]} {
        set_input_delay $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports *slv_huser*]
}

#- LM Slave Port AXI (ae350_cpu_subsystem) -#
set sync_input_list {"slvp_resetn*" "slv_araddr*" "slv_arburst*" "slv_arcache*" "slv_arid*" "slv_arlen*" "slv_arlock" "slv_arprot*" "slv_arsize*" "slv_arvalid" "slv_awaddr*" "slv_awburst*" "slv_awcache*" "slv_awid*" "slv_awlen*" "slv_awlock" "slv_awprot*" "slv_awsize*" "slv_awvalid" "slv_bready" "slv_rready" "slv_wdata*" "slv_wlast" "slv_wstrb*" "slv_wvalid"}
set sync_output_list {"slv_arready" "slv_awready" "slv_bid*" "slv_bresp*" "slv_bvalid" "slv_rdata*" "slv_rid*" "slv_rlast" "slv_rresp*" "slv_rvalid" "slv_wready"}

foreach sig $sync_input_list {
        if {[llength [get_ports -quiet $sig]]} {
                set_input_delay  $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports -quiet $sig]
        }
}
foreach sig $sync_output_list {
        if {[llength [get_ports -quiet $sig]]} {
                set_output_delay  $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports -quiet $sig]
        }
}

#- I/DLM AHBLITE -#
set sync_input_list {"hrdata*" "hresp" "hready"}
set sync_output_list {"haddr*" "hburst*" "hmastlock*" "hprot*" "hsize*" "htrans*" "hwdata*" "hwrite"}
set interface_list {"ilm_" "dlm_"}
foreach ifname $interface_list {
	if {[llength [get_ports -quiet ${ifname}hready]] == 0} {
		continue
	}
	foreach sig $sync_input_list {
		set_input_delay  $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports ${ifname}${sig}]
	}
	foreach sig $sync_output_list {
		set_output_delay  $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports ${ifname}${sig}]
	}
}

#- DMI interface -#
if {[llength [get_ports -quiet dmi_hready]]} {
	set_input_delay  0                -clock [get_clocks $bus_clk_name] [get_ports dmi_resetn*]
	set_input_delay  $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports dmi_haddr*]
	set_input_delay  $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports dmi_hburst*]
	set_input_delay  $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports dmi_hprot*]
	set_input_delay  $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports dmi_hready]
	set_input_delay  $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports dmi_hsel*]
	set_input_delay  $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports dmi_hsize*]
	set_input_delay  $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports dmi_htrans*]
	set_input_delay  $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports dmi_hwdata*]
	set_input_delay  $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports dmi_hwrite*]
	set_output_delay $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports dmactive*]
	set_output_delay $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports dmi_hrdata*]
	set_output_delay $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports dmi_hreadyout]
	set_output_delay $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports dmi_hresp*]
}

#- Direct Bus Interface: AHB -#
if {[llength [get_ports -quiet dm_sys_hready]]} {
        set_input_delay  $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports dm_sys_hgrant]
        set_input_delay  $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports dm_sys_hrdata*]
        set_input_delay  $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports dm_sys_hresp*]
        set_input_delay  $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports dm_sys_hready]
        
        set_output_delay $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports dm_sys_haddr*]
        set_output_delay $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports dm_sys_hburst*]
        set_output_delay $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports dm_sys_hbusreq]
        set_output_delay $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports dm_sys_hprot*]
        set_output_delay $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports dm_sys_hsize*]
        set_output_delay $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports dm_sys_htrans*]
        set_output_delay $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports dm_sys_hwrite]
        set_output_delay $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports dm_sys_hwdata*]
}

#- Direct Bus Interface: AXI -#
if {[llength [get_ports -quiet dm_sys_rvalid*]]} {
        set_input_delay  $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports dm_sys_arready]
        set_input_delay  $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports dm_sys_bid*]
        set_input_delay  $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports dm_sys_awready]
        set_input_delay  $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports dm_sys_bresp*]
        set_input_delay  $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports dm_sys_bvalid]
        set_input_delay  $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports dm_sys_rdata*]
        set_input_delay  $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports dm_sys_rid*]
        set_input_delay  $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports dm_sys_rlast]
        set_input_delay  $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports dm_sys_rresp*]
        set_input_delay  $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports dm_sys_rvalid]
        set_input_delay  $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports dm_sys_wready]

        set_output_delay $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports dm_sys_araddr*]
        set_output_delay $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports dm_sys_arburst*]
        set_output_delay $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports dm_sys_arcache*]
        set_output_delay $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports dm_sys_arid*]
        set_output_delay $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports dm_sys_arlen*]
        set_output_delay $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports dm_sys_arlock*]
        set_output_delay $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports dm_sys_arprot*]
        set_output_delay $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports dm_sys_arsize*]
        set_output_delay $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports dm_sys_arvalid]
        set_output_delay $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports dm_sys_awaddr*]
        set_output_delay $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports dm_sys_awburst*]
        set_output_delay $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports dm_sys_awcache*]
        set_output_delay $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports dm_sys_awid*]
        set_output_delay $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports dm_sys_awlen*]
        set_output_delay $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports dm_sys_awlock*]
        set_output_delay $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports dm_sys_awprot*]
        set_output_delay $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports dm_sys_awsize*]
        set_output_delay $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports dm_sys_awvalid]
        set_output_delay $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports dm_sys_bready]
        set_output_delay $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports dm_sys_rready]
        set_output_delay $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports dm_sys_wdata*]
        set_output_delay $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports dm_sys_wlast]
        set_output_delay $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports dm_sys_wstrb*]
        set_output_delay $bus_io_delay -clock [get_clocks $bus_clk_name] [get_ports dm_sys_wvalid]
}

# --- CORE_CLK domain --- #
#- reset vector -#
set reset_vector_ratio 0.5
set reset_vector_io_delay [expr {($core_clk_period - $synthesis_margin) * $reset_vector_ratio}]

if {[llength [get_ports -quiet *reset_vector*]]} {
	set_input_delay $reset_vector_io_delay -clock [get_clocks CORE_CLK] [get_ports *reset_vector*]
}

set ff_ratio 0.667
set ff_io_delay [expr {($core_clk_period - $synthesis_margin) * $ff_ratio}]

#- debug module -#
if {[llength [get_ports -quiet *debugint]]} {
	set_input_delay  $ff_io_delay -clock [get_clocks CORE_CLK] [get_ports *debugint]
	set_input_delay  $ff_io_delay -clock [get_clocks CORE_CLK] [get_ports *resethaltreq]
	set_output_delay $ff_io_delay -clock [get_clocks CORE_CLK] [get_ports hart*_unavail]
	set_output_delay $ff_io_delay -clock [get_clocks CORE_CLK] [get_ports hart*_halted]
	set_output_delay $ff_io_delay -clock [get_clocks CORE_CLK] [get_ports hart*_under_reset]
	set_output_delay $ff_io_delay -clock [get_clocks CORE_CLK] [get_ports *stoptime]
}

if {[llength [get_ports -quiet dbg_srst_req]]} {
	set_output_delay $ff_io_delay -clock [get_clocks CORE_CLK] [get_ports dbg_srst_req]
}
if {[llength [get_ports -quiet dbg_wakeup_req]]} {
	set_output_delay $ff_io_delay -clock [get_clocks CORE_CLK] [get_ports dbg_wakeup_req]
}

#- Trace -#
set nds_trace_interface_input_list {
	"*hart0_gen1_trace_enabled*"
	"*hart0_trace_enabled*"
	"*hart0_trace_stall*"
}
foreach sig $nds_trace_interface_input_list {
        if {[llength [get_ports -quiet $sig]]} {
		set_input_delay $ff_io_delay -clock [get_clocks -quiet CORE_CLK] [get_ports -quiet $sig]
        }
}

set nds_trace_interface_output_list {
	"*hart0_gen1_trace_cause*"
	"*hart0_gen1_trace_iaddr*"
	"*hart0_gen1_trace_iexception*"
	"*hart0_gen1_trace_instr*"
	"*hart0_gen1_trace_interrupt*"
	"*hart0_gen1_trace_ivalid*"
	"*hart0_gen1_trace_priv*"
	"*hart0_gen1_trace_tval*"
	"*hart0_trace_cause*"
	"*hart0_trace_halted*"
	"*hart0_trace_iaddr*"
	"*hart0_trace_ilastsize*"
	"*hart0_trace_iretire*"
	"*hart0_trace_itype*"
	"*hart0_trace_priv*"
	"*hart0_trace_reset*"
	"*hart0_trace_trigger*"
	"*hart0_trace_tval*"
}
foreach sig $nds_trace_interface_output_list {
        if {[llength [get_ports -quiet $sig]]} {
                set_output_delay  $ff_io_delay -clock [get_clocks -quiet CORE_CLK] [get_ports -quiet $sig]
        }
}

#- icache_disable_init and dcache_disable_init -#
if {[llength [get_ports -quiet *cache_disable_init]]} {
	set_input_delay $ff_io_delay -clock [get_clocks CORE_CLK] [get_ports *cache_disable_init]
}

#- interrupt related -#
set sync_input_list {"*nmi" "*meip" "*meiid*" "*mtip" "*msip" "*seip" "*seiid*" "*ueip" "*ueiid*" "int_src*"}

foreach sig $sync_input_list {
        if {[llength [get_ports -quiet $sig]]} {
		set_input_delay $ff_io_delay -clock [get_clocks CORE_CLK] [get_ports $sig]
        }
}

set sync_output_list {"*core_wfi_mode"  "*meiack" "*seiack" "*ueiack" "lm_local_int"}

foreach sig $sync_output_list {
        if {[llength [get_ports -quiet $sig]]} {
		set_output_delay $ff_io_delay -clock [get_clocks CORE_CLK] [get_ports $sig]
	}
}

if {[string equal $NDS_ACE_SUPPORT "yes"]} {
    source ./script/ace_io_delay.tcl
}


if {[llength [get_ports -quiet cpu_cp_wdata_ready]]} {
        set_input_delay  $ff_io_delay -clock [get_clocks CORE_CLK] [get_ports cp_cpu_rdata[*]]
        set_output_delay $ff_io_delay -clock [get_clocks CORE_CLK] [get_ports cp_cpu_rdata_ready]
        set_input_delay  $ff_io_delay -clock [get_clocks CORE_CLK] [get_ports cp_cpu_rdata_valid]
        set_output_delay $ff_io_delay -clock [get_clocks CORE_CLK] [get_ports cpu_cp_wdata[*]]
        set_input_delay  $ff_io_delay -clock [get_clocks CORE_CLK] [get_ports cpu_cp_wdata_ready]
        set_output_delay $ff_io_delay -clock [get_clocks CORE_CLK] [get_ports cpu_cp_wdata_valid]
}

if {[llength [get_ports -quiet hart*_wakeup_event*]]} {
	set_output_delay $ff_io_delay -clock [get_clocks CORE_CLK] [get_ports hart*_wakeup_event*]
}

if {[llength [get_ports -quiet *probe_gpr_index*]]} {
       set_input_delay   0 -clock [get_clocks CORE_CLK] [get_ports *probe_gpr_index*]
        set_output_delay 0 -clock [get_clocks CORE_CLK] [get_ports *probe_current_pc*]
        set_output_delay 0 -clock [get_clocks CORE_CLK] [get_ports *probe_selected_gpr_value*]
}
