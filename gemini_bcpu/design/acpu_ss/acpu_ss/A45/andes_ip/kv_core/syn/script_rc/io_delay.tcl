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
set E	"E"
if {![llength [find / -libcell $loading_cell]]} {
	puts "${E}rror: Can't find $loading_cell"
	puts "       Please check variable loading_cell in syn_setup_rc.tcl"
	exit
}
if ($loading_pin_exist) {
	if {![llength [filter [find / -libpin $tech_lib/$loading_cell/$loading_pin] -regexp {@port_direction == in}]]} {
		puts "${E}rror: Can't find input pin name '$loading_pin' in $loading_cell"
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
	puts "${E}rror: Can't find $driving_cell"
	puts "       Please check variable driving_cell in syn_setup_rc.tcl"
	exit
}
if ($driving_pin_exist) {
	if {![llength [filter [find / -libpin $tech_lib/$driving_cell/$driving_pin] -regexp {@port_direction == out}]]} {
		puts "${E}rror: Can't find output pin name '$driving_pin' in $driving_cell"
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
external_delay -input 0 -clock [find / -clock CORE_CLK] [find / -port *core_reset*]
external_delay -input 0 -clock [find / -clock CORE_CLK] [find / -port test_mode]
external_delay -input 0 -clock [find / -clock CORE_CLK] [find / -port scan_enable]
if {[llength [find / -port *hart_id*]]} {
	external_delay -input 0 -clock [find / -clock CORE_CLK] [find / -port *hart_id*]
}
if {![string equal $PLATFORM "ae250"]} {
	external_delay -input 0 -clock [find / -clock CORE_CLK] [find / -port test_rstn]
}
if {[llength [find / -port por_rstn]]} {
	external_delay -input 0 -clock [find / -clock CORE_CLK] [find / -port por_rstn]
}
if {[llength [find / -port rtc_rstn]]} {
	external_delay -input 0 -clock [find / -clock RTC_CLK] [find / -port rtc_rstn]
}

set estrb_ratio          0.667
set estrb_coreclk_delay  [expr ($core_clk_period - $synthesis_margin) * $estrb_ratio]

if {[llength [find / -port bus2core_clken]]} {
	external_delay -input $estrb_coreclk_delay -clock [find / -clock CORE_CLK] [find / -port bus2core_clken]
}
if {[llength [find / -port *bus_clk_en]]} {
	external_delay -input $estrb_coreclk_delay -clock [find / -clock CORE_CLK] [find / -port *bus_clk_en]
}

# --- BUS_CLK domain --- #
#- The synthesis_margin is subtracted from bus_clk_period for compensating clock uncertainty -#

set bus_ratio     0.667
set bus_io_delay  [expr {($bus_clk_period - $synthesis_margin) * $bus_ratio}]
# input external delay + input external delay + clock_uncertainty + internal delay, only for feed-through path
set bus_max_i2o_delay  [expr {($bus_clk_period - $synthesis_margin) * $bus_ratio * 2 + $synthesis_margin + ($bus_clk_period - $synthesis_margin) * (1 - $bus_ratio)}]

#- AHB -#
if {[llength [find / -port hresetn]]} {
	external_delay -input  0                    -clock [find / -clock CORE_CLK] [find / -port hresetn]
}

if {[string equal $NDS_BIU_BUS "ahb"]} {
	if {[string equal $NDS_BIU_PATH_X2 "yes"]} {
		set interface_list {"i_" "d_"}
	} else {
		set interface_list {""}
	}

	foreach ifname $interface_list {
		if {[llength [find / -port ${ifname}hgrant]]} {
			external_delay -input  $bus_io_delay -clock [find / -clock $bus_clk_name] [find / -port ${ifname}hgrant]
			external_delay -output $bus_io_delay -clock [find / -clock $bus_clk_name] [find / -port ${ifname}hbusreq]
		}
		external_delay -input  $bus_io_delay -clock [find / -clock $bus_clk_name] [find / -port ${ifname}hrdata*]
		external_delay -input  $bus_io_delay -clock [find / -clock $bus_clk_name] [find / -port ${ifname}hresp*]
		external_delay -input  $bus_io_delay -clock [find / -clock $bus_clk_name] [find / -port ${ifname}hready]

		external_delay -output $bus_io_delay -clock [find / -clock $bus_clk_name] [find / -port ${ifname}haddr*]
		external_delay -output $bus_io_delay -clock [find / -clock $bus_clk_name] [find / -port ${ifname}hburst*]
		external_delay -output $bus_io_delay -clock [find / -clock $bus_clk_name] [find / -port ${ifname}hprot*]
		external_delay -output $bus_io_delay -clock [find / -clock $bus_clk_name] [find / -port ${ifname}hsize*]

		external_delay -output $bus_io_delay -clock [find / -clock $bus_clk_name] [find / -port ${ifname}htrans*]
		external_delay -output $bus_io_delay -clock [find / -clock $bus_clk_name] [find / -port ${ifname}hwdata*]
		external_delay -output $bus_io_delay -clock [find / -clock $bus_clk_name] [find / -port ${ifname}hwrite]
	}
# bmch feed-through path
	set through_output_list {"haddr*" "hburst*" "hprot*" "hsize*" "htrans*" "hwdata*" "hwrite*"}
	if {[string equal $NDS_BIU_PATH_X2 "yes"]} {
		if {[llength [find / -pin u_ahb_bmc_x2/hs2_bmc_hready]]} {
			foreach sig $through_output_list {
				set_max_delay $bus_max_i2o_delay -from [find / -port i_hready] -through [find / -pin u_ahb_bmc_x2/hs2_bmc_hready] -to [find / -port i_$sig]
				set_max_delay $bus_max_i2o_delay -from [find / -port i_hresp*] -through [find / -pin u_ahb_bmc_x2/hs2_hresp*]     -to [find / -port i_$sig]
			}
		}
		if {[llength [find / -pin u_ahb_bmc_x2/hs3_bmc_hready]]} {
			foreach sig $through_output_list {
				set_max_delay $bus_max_i2o_delay -from [find / -port d_hready] -through [find / -pin u_ahb_bmc_x2/hs3_bmc_hready] -to [find / -port d_$sig]
				set_max_delay $bus_max_i2o_delay -from [find / -port d_hresp*] -through [find / -pin u_ahb_bmc_x2/hs3_hresp*]     -to [find / -port d_$sig]
			}
		}
	} else {
		if {[llength [find / -pin u_ahb_bmc_x1/hs2_bmc_hready]]} {
			foreach sig $through_output_list {
				set_max_delay $bus_max_i2o_delay -from [find / -port hready] -through [find / -pin u_ahb_bmc_x1/hs2_bmc_hready] -to [find / -port $sig]
				set_max_delay $bus_max_i2o_delay -from [find / -port hresp*] -through [find / -pin u_ahb_bmc_x1/hs2_hresp*]     -to [find / -port $sig]
			}
		}
	}
}

#- AXI -#
if {[llength [find / -port aresetn]]} {
	external_delay -input  0                    -clock [find / -clock CORE_CLK] [find / -port aresetn]
}

if {[string equal $NDS_BIU_BUS "axi"]} {
	if {[string equal $NDS_BIU_PATH_X2 "yes"]} {
		set interface_list {"i_" "d_"}
	} else {
		set interface_list {""}
	}
	foreach ifname $interface_list {
		if {[llength [find / -port ${ifname}arvalid]]} {
			external_delay -input  $bus_io_delay -clock [find / -clock $bus_clk_name] [find / -port ${ifname}arready]
			external_delay -input  $bus_io_delay -clock [find / -clock $bus_clk_name] [find / -port ${ifname}awready]
			external_delay -input  $bus_io_delay -clock [find / -clock $bus_clk_name] [find / -port ${ifname}bid*]
			external_delay -input  $bus_io_delay -clock [find / -clock $bus_clk_name] [find / -port ${ifname}bresp*]
			external_delay -input  $bus_io_delay -clock [find / -clock $bus_clk_name] [find / -port ${ifname}bvalid]
			external_delay -input  $bus_io_delay -clock [find / -clock $bus_clk_name] [find / -port ${ifname}rdata*]
			external_delay -input  $bus_io_delay -clock [find / -clock $bus_clk_name] [find / -port ${ifname}rid*]
			external_delay -input  $bus_io_delay -clock [find / -clock $bus_clk_name] [find / -port ${ifname}rlast]
			external_delay -input  $bus_io_delay -clock [find / -clock $bus_clk_name] [find / -port ${ifname}rresp*]
			external_delay -input  $bus_io_delay -clock [find / -clock $bus_clk_name] [find / -port ${ifname}rvalid]
			external_delay -input  $bus_io_delay -clock [find / -clock $bus_clk_name] [find / -port ${ifname}wready]

			external_delay -output $bus_io_delay -clock [find / -clock $bus_clk_name] [find / -port ${ifname}araddr*]
			external_delay -output $bus_io_delay -clock [find / -clock $bus_clk_name] [find / -port ${ifname}arburst*]
			external_delay -output $bus_io_delay -clock [find / -clock $bus_clk_name] [find / -port ${ifname}arcache*]
			external_delay -output $bus_io_delay -clock [find / -clock $bus_clk_name] [find / -port ${ifname}arid*]
			external_delay -output $bus_io_delay -clock [find / -clock $bus_clk_name] [find / -port ${ifname}arlen*]
			external_delay -output $bus_io_delay -clock [find / -clock $bus_clk_name] [find / -port ${ifname}arlock]
			external_delay -output $bus_io_delay -clock [find / -clock $bus_clk_name] [find / -port ${ifname}arprot*]
			external_delay -output $bus_io_delay -clock [find / -clock $bus_clk_name] [find / -port ${ifname}arsize*]
			external_delay -output $bus_io_delay -clock [find / -clock $bus_clk_name] [find / -port ${ifname}arvalid]
			external_delay -output $bus_io_delay -clock [find / -clock $bus_clk_name] [find / -port ${ifname}awaddr*]
			external_delay -output $bus_io_delay -clock [find / -clock $bus_clk_name] [find / -port ${ifname}awburst*]
			external_delay -output $bus_io_delay -clock [find / -clock $bus_clk_name] [find / -port ${ifname}awcache*]
			external_delay -output $bus_io_delay -clock [find / -clock $bus_clk_name] [find / -port ${ifname}awid*]
			external_delay -output $bus_io_delay -clock [find / -clock $bus_clk_name] [find / -port ${ifname}awlen*]
			external_delay -output $bus_io_delay -clock [find / -clock $bus_clk_name] [find / -port ${ifname}awlock]
			external_delay -output $bus_io_delay -clock [find / -clock $bus_clk_name] [find / -port ${ifname}awprot*]
			external_delay -output $bus_io_delay -clock [find / -clock $bus_clk_name] [find / -port ${ifname}awsize*]
			external_delay -output $bus_io_delay -clock [find / -clock $bus_clk_name] [find / -port ${ifname}awvalid]
			external_delay -output $bus_io_delay -clock [find / -clock $bus_clk_name] [find / -port ${ifname}bready]
			external_delay -output $bus_io_delay -clock [find / -clock $bus_clk_name] [find / -port ${ifname}rready]
			external_delay -output $bus_io_delay -clock [find / -clock $bus_clk_name] [find / -port ${ifname}wdata*]
			external_delay -output $bus_io_delay -clock [find / -clock $bus_clk_name] [find / -port ${ifname}wlast]
			external_delay -output $bus_io_delay -clock [find / -clock $bus_clk_name] [find / -port ${ifname}wstrb*]
			external_delay -output $bus_io_delay -clock [find / -clock $bus_clk_name] [find / -port ${ifname}wvalid]
		}
	}
}

#- LM Slave Port -#

if {[llength [find / -port *slv_clk_en]]} {
	external_delay -input $estrb_coreclk_delay -clock [find / -clock CORE_CLK] [find / -port *slv_clk_en]
}
if {[llength [find / -port *slv_reset_n]]} {
	external_delay -input 0                    -clock [find / -clock CORE_CLK] [find / -port *slv_reset_n]
}

#- LM Slave Port AHB -#
if {[llength [find / -port *slv_hready]]} {
	external_delay -input  $bus_io_delay -clock [find / -clock $bus_clk_name] [find / -port *slv_hsel*]
	external_delay -input  $bus_io_delay -clock [find / -clock $bus_clk_name] [find / -port *slv_htrans*]
	external_delay -input  $bus_io_delay -clock [find / -clock $bus_clk_name] [find / -port *slv_hready]
	external_delay -input  $bus_io_delay -clock [find / -clock $bus_clk_name] [find / -port *slv_haddr*]
	external_delay -input  $bus_io_delay -clock [find / -clock $bus_clk_name] [find / -port *slv_hburst*]
	external_delay -input  $bus_io_delay -clock [find / -clock $bus_clk_name] [find / -port *slv_hsize*]
	external_delay -input  $bus_io_delay -clock [find / -clock $bus_clk_name] [find / -port *slv_hprot*]
	external_delay -input  $bus_io_delay -clock [find / -clock $bus_clk_name] [find / -port *slv_hwdata*]
	external_delay -input  $bus_io_delay -clock [find / -clock $bus_clk_name] [find / -port *slv_hwrite]
	external_delay -output $bus_io_delay -clock [find / -clock $bus_clk_name] [find / -port *slv_hrdata*]
	external_delay -output $bus_io_delay -clock [find / -clock $bus_clk_name] [find / -port *slv_hresp**]
	external_delay -output $bus_io_delay -clock [find / -clock $bus_clk_name] [find / -port *slv_hreadyout]
}

if {[llength [find / -port *slv_huser*]]} {
	external_delay -input  $bus_io_delay -clock [find / -clock $bus_clk_name] [find / -port "*slv_huser*"]
}

#- LM Slave Port AXI (ae350_cpu_subsystem) -#
set sync_input_list {"slvp_resetn*" "slv_araddr*" "slv_arburst*" "slv_arcache*" "slv_arid*" "slv_arlen*" "slv_arlock" "slv_arprot*" "slv_arsize*" "slv_arvalid" "slv_awaddr*" "slv_awburst*" "slv_awcache*" "slv_awid*" "slv_awlen*" "slv_awlock" "slv_awprot*" "slv_awsize*" "slv_awvalid" "slv_bready" "slv_rready" "slv_wdata*" "slv_wlast" "slv_wstrb*" "slv_wvalid"}
set sync_output_list {"slv_arready" "slv_awready" "slv_bid*" "slv_bresp*" "slv_bvalid" "slv_rdata*" "slv_rid*" "slv_rlast" "slv_rresp*" "slv_rvalid" "slv_wready"}

foreach sig $sync_input_list {
	if {[llength [find / -port $sig]]} {
		external_delay -input  $bus_io_delay -clock [find / -clock $bus_clk_name] [find / -port $sig]
	}
}
foreach sig $sync_output_list {
	if {[llength [find / -port $sig]]} {
		external_delay -output $bus_io_delay -clock [find / -clock $bus_clk_name] [find / -port $sig]
	}
}

#- I/DLM AHBLITE -#
set sync_input_list {"hrdata*" "hresp" "hready"}
set sync_output_list {"haddr*" "hburst*" "hmastlock*" "hprot*" "hsize*" "htrans*" "hwdata*" "hwrite"}
set interface_list {"ilm_" "dlm_"}
foreach ifname $interface_list {
	if {[llength [find / -port ${ifname}hready]] == 0} {
		continue
	}
	foreach sig $sync_input_list {
		external_delay -input  $bus_io_delay -clock [find / -clock $bus_clk_name] [find / -port ${ifname}${sig}]
	}
	foreach sig $sync_output_list {
		external_delay -output  $bus_io_delay -clock [find / -clock $bus_clk_name] [find / -port ${ifname}${sig}]
	}
}

#- DMI interface -#
if {[llength [find / -port -quiet dmi_hready]]} {
	external_delay -input  0             -clock [find / -clock $bus_clk_name] [find / -port dmi_resetn*]
	external_delay -input  $bus_io_delay -clock [find / -clock $bus_clk_name] [find / -port dmi_haddr*]
	external_delay -input  $bus_io_delay -clock [find / -clock $bus_clk_name] [find / -port dmi_hburst*]
	external_delay -input  $bus_io_delay -clock [find / -clock $bus_clk_name] [find / -port dmi_hprot*]
	external_delay -input  $bus_io_delay -clock [find / -clock $bus_clk_name] [find / -port dmi_hready]
	external_delay -input  $bus_io_delay -clock [find / -clock $bus_clk_name] [find / -port dmi_hsel*]
	external_delay -input  $bus_io_delay -clock [find / -clock $bus_clk_name] [find / -port dmi_hsize*]
	external_delay -input  $bus_io_delay -clock [find / -clock $bus_clk_name] [find / -port dmi_htrans*]
	external_delay -input  $bus_io_delay -clock [find / -clock $bus_clk_name] [find / -port dmi_hwdata*]
	external_delay -input  $bus_io_delay -clock [find / -clock $bus_clk_name] [find / -port dmi_hwrite*]
	external_delay -output $bus_io_delay -clock [find / -clock $bus_clk_name] [find / -port dmactive*]
	external_delay -output $bus_io_delay -clock [find / -clock $bus_clk_name] [find / -port dmi_hrdata*]
	external_delay -output $bus_io_delay -clock [find / -clock $bus_clk_name] [find / -port dmi_hreadyout]
	external_delay -output $bus_io_delay -clock [find / -clock $bus_clk_name] [find / -port dmi_hresp*]
}

#- Direct Bus Interface -#
if {[llength [find / -port dm_sys_rready]]} {
	set sync_input_list {"dm_sys_awready" "dm_sys_wready" "dm_sys_bid*" "dm_sys_bresp*" "dm_sys_bvalid" "dm_sys_arready" "dm_sys_rid*" "dm_sys_rdata*" "dm_sys_rresp*" "dm_sys_rlast" "dm_sys_rvalid"}
	set sync_output_list {"dm_sys_awid*" "dm_sys_awaddr*" "dm_sys_awlen*" "dm_sys_awsize*" "dm_sys_awburst*" "dm_sys_awlock*" "dm_sys_awcache*" "dm_sys_awprot*" "dm_sys_awvalid" "dm_sys_wdata*" "dm_sys_wstrb*" "dm_sys_wlast" "dm_sys_wvalid" "dm_sys_bready" "dm_sys_arid*" "dm_sys_araddr*" "dm_sys_arlen*" "dm_sys_arsize*" "dm_sys_arburst*" "dm_sys_arlock*" "dm_sys_arcache*" "dm_sys_arprot*" "dm_sys_arvalid" "dm_sys_rready"}
} 
if {[llength [find / -port dm_sys_hready]]} {
	set sync_output_list {"dm_sys_haddr*" "dm_sys_hburst*" "dm_sys_hbusreq" "dm_sys_hprot*" "dm_sys_hsize*" "dm_sys_htrans*" "dm_sys_hwrite" "dm_sys_hwdata*"}
	set sync_input_list {"dm_sys_hgrant" "dm_sys_hrdata*" "dm_sys_hresp*" "dm_sys_hready"}
}

foreach sig $sync_input_list {
        if {[llength [find / -port $sig]]} {
		external_delay -input  $bus_io_delay -clock [find / -clock $bus_clk_name] [find / -port $sig]
        }
}

foreach sig $sync_output_list {
        if {[llength [find / -port $sig]]} {
		external_delay -output $bus_io_delay -clock [find / -clock $bus_clk_name] [find / -port $sig]
        }
}

# --- CORE_CLK domain --- #
#- reset vector -#
set reset_vector_ratio     0.5
set reset_vector_io_delay [expr {($core_clk_period - $synthesis_margin) * $reset_vector_ratio}]

if {[llength [find / -port *reset_vector*]]} {
	external_delay -input $reset_vector_io_delay -clock [find / -clock CORE_CLK] [find / -port *reset_vector*]
}

set ff_ratio     0.667
set ff_io_delay [expr {($core_clk_period - $synthesis_margin) * $ff_ratio}]

#- debug module -#
if {[llength [find / -port *debugint]]} {
	external_delay -input  $ff_io_delay -clock [find / -clock CORE_CLK] [find / -port *debugint]
	external_delay -input  $ff_io_delay -clock [find / -clock CORE_CLK] [find / -port *resethaltreq]
	external_delay -output $ff_io_delay -clock [find / -clock CORE_CLK] [find / -port hart*_unavail]
	external_delay -output $ff_io_delay -clock [find / -clock CORE_CLK] [find / -port hart*_halted]
	external_delay -output $ff_io_delay -clock [find / -clock CORE_CLK] [find / -port hart*_under_reset]
	external_delay -output $ff_io_delay -clock [find / -clock CORE_CLK] [find / -port *stoptime]
}

if {[llength [find / -port dbg_srst_req]]} {
	external_delay -output $ff_io_delay -clock [find / -clock CORE_CLK] [find / -port dbg_srst_req]
}
if {[llength [find / -port dbg_wakeup_req]]} {
	external_delay -output $ff_io_delay -clock [find / -clock CORE_CLK] [find / -port dbg_wakeup_req]
}

#- Trace -#
set nds_trace_interface_input_list {
	"*hart0_gen1_trace_enabled*"
	"*hart0_trace_enabled*"
	"*hart0_trace_stall*"
}
foreach sig $nds_trace_interface_input_list {
	if {[llength [find / -port $sig]]} {
		external_delay -input [expr $ff_io_delay] -clock [find / -clock CORE_CLK] [find / -port $sig]
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
        if {[llength [find / -port $sig]]} {
                external_delay -output  $ff_io_delay -clock [find / -clock CORE_CLK] [find / -port $sig]
        }
}
#- icache_disable_init and dcache_disable_init -#
if {[llength [find / -port *cache_disable_init]]} {
	external_delay -input  $ff_io_delay -clock [find / -clock CORE_CLK] [find / -port *cache_disable_init]
}

#- interrupt related -#
set sync_input_list {"*nmi" "*meip" "*meiid*" "*mtip" "*msip" "*seip" "*seiid*" "*ueip" "*ueiid*" "int_src*"}

foreach sig $sync_input_list {
        if {[llength [find / -port $sig]]} {
                external_delay -input $ff_io_delay -clock [find / -clock CORE_CLK] [find / -port $sig]
        }
}

set sync_output_list {"*core_wfi_mode" "*meiack" "*seiack" "*ueiack" "lm_local_int"}

foreach sig $sync_output_list {
        if {[llength [find / -port $sig]]} {
                external_delay -output $ff_io_delay -clock [find / -clock CORE_CLK] [find / -port $sig]
        }
}

if {[string equal $NDS_ACE_SUPPORT "yes"]} {
    source ./script_rc/ace_io_delay.tcl
}

if {[llength [find / -port cpu_cp_wdata_ready]]} {
	external_delay -input  $ff_io_delay -clock [find / -clock CORE_CLK] [find / -port cp_cpu_rdata[*]]
	external_delay -input  $ff_io_delay -clock [find / -clock CORE_CLK] [find / -port cp_cpu_rdata_valid]
	external_delay -output $ff_io_delay -clock [find / -clock CORE_CLK] [find / -port cp_cpu_rdata_ready]
	external_delay -output $ff_io_delay -clock [find / -clock CORE_CLK] [find / -port cpu_cp_wdata[*]]
	external_delay -output $ff_io_delay -clock [find / -clock CORE_CLK] [find / -port cpu_cp_wdata_valid]
	external_delay -input  $ff_io_delay -clock [find / -clock CORE_CLK] [find / -port cpu_cp_wdata_ready]
}

if {[llength [find / -port hart*_wakeup_event*]]} {
	external_delay -output $ff_io_delay -clock [find / -clock CORE_CLK] [find / -port hart*_wakeup_event*]
}

if {[llength [find / -port *probe_gpr_index*]]} {
	external_delay -input  0 -clock [find / -clock CORE_CLK] [find / -port *probe_gpr_index*]
	external_delay -output 0 -clock [find / -clock CORE_CLK] [find / -port *probe_current_pc*]
	external_delay -output 0 -clock [find / -clock CORE_CLK] [find / -port *probe_selected_gpr_value*]
}
