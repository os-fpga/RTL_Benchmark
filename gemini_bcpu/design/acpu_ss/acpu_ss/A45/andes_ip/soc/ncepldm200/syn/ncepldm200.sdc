if {![info exists env(hclk_period)]} {
        set clk_period 10.0
} else {
        set clk_period $env(hclk_period)
}

if {![info exists clock_uncertainty]} {
	set clock_uncertainty 0.3
}

if {![info exists clock_transition]} {
	set clock_transition 0.1
}

if {![info exists tech_lib]} {
	set tech_lib "" 
	set driving_cell "" 
	set load_val 1
	set operating_cond ""
}

if {![info exists env(maxFanout)]} {
	set max_fanout 64
} else {
	set max_fanout $env(maxFanout)
}


# -------------------------------------------------------------
# Specify Clock Information
# -------------------------------------------------------------
# Define Clocks
create_clock -name CLK -period $clk_period \
   -waveform [list 0 [expr $clk_period / 2.0]] [get_ports clk]

# Specify Clock Skew
set_clock_uncertainty -setup $clock_uncertainty [all_clocks]

# Specify Clock Transition
set_clock_transition $clock_transition [all_clocks]

set ip_input_delay  [expr {($clk_period - $clock_uncertainty) * 0.667}]
set ip_output_delay $ip_input_delay


# -------------------------------------------------------------
# Define Input and Output Delays
# -------------------------------------------------------------
# Set Input Delays
set_input_delay -max $ip_input_delay -clock CLK [get_ports dmi_resetn]
set_input_delay -max $ip_input_delay -clock CLK [get_ports bus_resetn]
set_input_delay -max $ip_input_delay -clock CLK [get_ports hart_unavail*]
set_input_delay -max $ip_input_delay -clock CLK [get_ports rv_haddr*]
set_input_delay -max $ip_input_delay -clock CLK [get_ports rv_htrans*]
set_input_delay -max $ip_input_delay -clock CLK [get_ports rv_hwrite]
set_input_delay -max $ip_input_delay -clock CLK [get_ports rv_hsize*]
set_input_delay -max $ip_input_delay -clock CLK [get_ports rv_hburst*]
set_input_delay -max $ip_input_delay -clock CLK [get_ports rv_hprot*]
set_input_delay -max $ip_input_delay -clock CLK [get_ports rv_hwdata*]
set_input_delay -max $ip_input_delay -clock CLK [get_ports rv_hsel]
set_input_delay -max $ip_input_delay -clock CLK [get_ports rv_hready]

set_input_delay -max $ip_input_delay -clock CLK [get_ports rv_awid*]
set_input_delay -max $ip_input_delay -clock CLK [get_ports rv_awaddr*]
set_input_delay -max $ip_input_delay -clock CLK [get_ports rv_awlen*]
set_input_delay -max $ip_input_delay -clock CLK [get_ports rv_awsize*]
set_input_delay -max $ip_input_delay -clock CLK [get_ports rv_awburst*]
set_input_delay -max $ip_input_delay -clock CLK [get_ports rv_awlock]
set_input_delay -max $ip_input_delay -clock CLK [get_ports rv_awcache*]
set_input_delay -max $ip_input_delay -clock CLK [get_ports rv_awprot*]
set_input_delay -max $ip_input_delay -clock CLK [get_ports rv_awvalid]

set_input_delay -max $ip_input_delay -clock CLK [get_ports rv_wdata*]
set_input_delay -max $ip_input_delay -clock CLK [get_ports rv_wstrb*]
set_input_delay -max $ip_input_delay -clock CLK [get_ports rv_wlast]
set_input_delay -max $ip_input_delay -clock CLK [get_ports rv_wvalid]

set_input_delay -max $ip_input_delay -clock CLK [get_ports rv_bready]

set_input_delay -max $ip_input_delay -clock CLK [get_ports rv_arid*]
set_input_delay -max $ip_input_delay -clock CLK [get_ports rv_araddr*]
set_input_delay -max $ip_input_delay -clock CLK [get_ports rv_arlen*]
set_input_delay -max $ip_input_delay -clock CLK [get_ports rv_arsize*]
set_input_delay -max $ip_input_delay -clock CLK [get_ports rv_arburst*]
set_input_delay -max $ip_input_delay -clock CLK [get_ports rv_arlock]
set_input_delay -max $ip_input_delay -clock CLK [get_ports rv_arcache*]
set_input_delay -max $ip_input_delay -clock CLK [get_ports rv_arprot*]
set_input_delay -max $ip_input_delay -clock CLK [get_ports rv_arvalid]

set_input_delay -max $ip_input_delay -clock CLK [get_ports rv_rready]

set_input_delay -max $ip_input_delay -clock CLK [get_ports sys_awready]
set_input_delay -max $ip_input_delay -clock CLK [get_ports sys_wready]
set_input_delay -max $ip_input_delay -clock CLK [get_ports sys_bid*]
set_input_delay -max $ip_input_delay -clock CLK [get_ports sys_bresp]
set_input_delay -max $ip_input_delay -clock CLK [get_ports sys_bvalid]
set_input_delay -max $ip_input_delay -clock CLK [get_ports sys_arready]

set_input_delay -max $ip_input_delay -clock CLK [get_ports sys_hrdata]
set_input_delay -max $ip_input_delay -clock CLK [get_ports sys_hready]
set_input_delay -max $ip_input_delay -clock CLK [get_ports sys_hresp]
set_input_delay -max $ip_input_delay -clock CLK [get_ports sys_hgrant]

set_input_delay -max $ip_input_delay -clock CLK [get_ports dmi_haddr*]
set_input_delay -max $ip_input_delay -clock CLK [get_ports dmi_htrans*]
set_input_delay -max $ip_input_delay -clock CLK [get_ports dmi_hwrite*]
set_input_delay -max $ip_input_delay -clock CLK [get_ports dmi_hsize*]
set_input_delay -max $ip_input_delay -clock CLK [get_ports dmi_hburst*]
set_input_delay -max $ip_input_delay -clock CLK [get_ports dmi_hprot*]
set_input_delay -max $ip_input_delay -clock CLK [get_ports dmi_hwdata*]
set_input_delay -max $ip_input_delay -clock CLK [get_ports dmi_hsel]
set_input_delay -max $ip_input_delay -clock CLK [get_ports dmi_hready]

# Set Output Delays
set_output_delay -max $ip_output_delay -clock CLK [get_ports debugint]
set_output_delay -max $ip_output_delay -clock CLK [get_ports dmactive]
set_output_delay -max $ip_output_delay -clock CLK [get_ports ndmreset]
set_output_delay -max $ip_output_delay -clock CLK [get_ports rv_hrdata*]
set_output_delay -max $ip_output_delay -clock CLK [get_ports rv_hreadyout]
set_output_delay -max $ip_output_delay -clock CLK [get_ports rv_hresp*]
set_output_delay -max $ip_output_delay -clock CLK [get_ports dmi_hrdata*]
set_output_delay -max $ip_output_delay -clock CLK [get_ports dmi_hreadyout]
set_output_delay -max $ip_output_delay -clock CLK [get_ports dmi_hresp*]

set_output_delay -max $ip_output_delay -clock CLK [get_ports rv_awready]
set_output_delay -max $ip_output_delay -clock CLK [get_ports rv_wready]
set_output_delay -max $ip_output_delay -clock CLK [get_ports rv_bid*]
set_output_delay -max $ip_output_delay -clock CLK [get_ports rv_bresp]
set_output_delay -max $ip_output_delay -clock CLK [get_ports rv_bvalid]
set_output_delay -max $ip_output_delay -clock CLK [get_ports rv_arready]

set_output_delay -max $ip_output_delay -clock CLK [get_ports sys_awid*]
set_output_delay -max $ip_output_delay -clock CLK [get_ports sys_awaddr*]
set_output_delay -max $ip_output_delay -clock CLK [get_ports sys_awlen*]
set_output_delay -max $ip_output_delay -clock CLK [get_ports sys_awsize*]
set_output_delay -max $ip_output_delay -clock CLK [get_ports sys_awburst*]
set_output_delay -max $ip_output_delay -clock CLK [get_ports sys_awlock]
set_output_delay -max $ip_output_delay -clock CLK [get_ports sys_awcache*]
set_output_delay -max $ip_output_delay -clock CLK [get_ports sys_awprot*]
set_output_delay -max $ip_output_delay -clock CLK [get_ports sys_awvalid]

set_output_delay -max $ip_output_delay -clock CLK [get_ports sys_wdata*]
set_output_delay -max $ip_output_delay -clock CLK [get_ports sys_wstrb*]
set_output_delay -max $ip_output_delay -clock CLK [get_ports sys_wlast]
set_output_delay -max $ip_output_delay -clock CLK [get_ports sys_wvalid]

set_output_delay -max $ip_output_delay -clock CLK [get_ports sys_bready]

set_output_delay -max $ip_output_delay -clock CLK [get_ports sys_arid*]
set_output_delay -max $ip_output_delay -clock CLK [get_ports sys_araddr*]
set_output_delay -max $ip_output_delay -clock CLK [get_ports sys_arlen*]
set_output_delay -max $ip_output_delay -clock CLK [get_ports sys_arsize*]
set_output_delay -max $ip_output_delay -clock CLK [get_ports sys_arburst*]
set_output_delay -max $ip_output_delay -clock CLK [get_ports sys_arlock]
set_output_delay -max $ip_output_delay -clock CLK [get_ports sys_arcache*]
set_output_delay -max $ip_output_delay -clock CLK [get_ports sys_arprot*]
set_output_delay -max $ip_output_delay -clock CLK [get_ports sys_arvalid]

set_output_delay -max $ip_output_delay -clock CLK [get_ports sys_rready]

set_output_delay -max $ip_output_delay -clock CLK [get_ports sys_haddr]
set_output_delay -max $ip_output_delay -clock CLK [get_ports sys_htrans]
set_output_delay -max $ip_output_delay -clock CLK [get_ports sys_hwrite]
set_output_delay -max $ip_output_delay -clock CLK [get_ports sys_hsize]
set_output_delay -max $ip_output_delay -clock CLK [get_ports sys_hburst]
set_output_delay -max $ip_output_delay -clock CLK [get_ports sys_hprot]
set_output_delay -max $ip_output_delay -clock CLK [get_ports sys_hwdata]
set_output_delay -max $ip_output_delay -clock CLK [get_ports sys_hbusreq]

# -------------------------------------------------------------
# Set External Driver and Load
# -------------------------------------------------------------
set_driving_cell -library ${tech_lib} -lib_cell $driving_cell -no_design_rule [all_inputs]
set_load [expr $load_val * 16] [all_outputs]
set_max_fanout $max_fanout [current_design]


# -------------------------------------------------------------
# Specify Operating Conditions
# -------------------------------------------------------------
set_operating_conditions $operating_cond


# -------------------------------------------------------------
# Specify Wire-load Models
# -------------------------------------------------------------
# Set the Wire-load Mode
set_wire_load_mode enclosed


# -------------------------------------------------------------
# Set Timing Exceptions
# -------------------------------------------------------------
# Specify False Paths

# Specify Multi-Cycle Paths

# Specify Path Delays


