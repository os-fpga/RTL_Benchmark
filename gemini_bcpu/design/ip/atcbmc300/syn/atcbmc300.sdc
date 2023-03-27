if {![info exists env(aclk_period)]} {
	set aclk_period 20.0
} else {
	set aclk_period $env(aclk_period)
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
# Create clock 
# -------------------------------------------------------------
create_clock -name ACLK -period $aclk_period \
	-waveform [list 0 [expr $aclk_period / 2.0]] [get_ports aclk]

# Specify Clock Skew
set_clock_uncertainty -setup $clock_uncertainty [all_clocks]

# Specify Clock Transition
set_clock_transition $clock_transition [all_clocks]


# -------------------------------------------------------------
# Define Input and Output Delays
# -------------------------------------------------------------
# Set Input Delays
	set input_delay_ratio 0.6 
	set_input_delay -max [expr ($aclk_period - $clock_uncertainty) * $input_delay_ratio] -clock ACLK [get_ports aresetn]
	set_input_delay -max [expr ($aclk_period - $clock_uncertainty) * $input_delay_ratio] -clock ACLK [get_ports us*_awaddr]
	set_input_delay -max [expr ($aclk_period - $clock_uncertainty) * $input_delay_ratio] -clock ACLK [get_ports us*_awburst]
	set_input_delay -max [expr ($aclk_period - $clock_uncertainty) * $input_delay_ratio] -clock ACLK [get_ports us*_awcache]
	set_input_delay -max [expr ($aclk_period - $clock_uncertainty) * $input_delay_ratio] -clock ACLK [get_ports us*_awid]
	set_input_delay -max [expr ($aclk_period - $clock_uncertainty) * $input_delay_ratio] -clock ACLK [get_ports us*_awlen]
	set_input_delay -max [expr ($aclk_period - $clock_uncertainty) * $input_delay_ratio] -clock ACLK [get_ports us*_awlock]
	set_input_delay -max [expr ($aclk_period - $clock_uncertainty) * $input_delay_ratio] -clock ACLK [get_ports us*_awprot]
	set_input_delay -max [expr ($aclk_period - $clock_uncertainty) * $input_delay_ratio] -clock ACLK [get_ports us*_awsize]
	set_input_delay -max [expr ($aclk_period - $clock_uncertainty) * $input_delay_ratio] -clock ACLK [get_ports us*_awvalid]
	set_input_delay -max [expr ($aclk_period - $clock_uncertainty) * $input_delay_ratio] -clock ACLK [get_ports us*_araddr]
	set_input_delay -max [expr ($aclk_period - $clock_uncertainty) * $input_delay_ratio] -clock ACLK [get_ports us*_arburst]
	set_input_delay -max [expr ($aclk_period - $clock_uncertainty) * $input_delay_ratio] -clock ACLK [get_ports us*_arcache]
	set_input_delay -max [expr ($aclk_period - $clock_uncertainty) * $input_delay_ratio] -clock ACLK [get_ports us*_arid]
	set_input_delay -max [expr ($aclk_period - $clock_uncertainty) * $input_delay_ratio] -clock ACLK [get_ports us*_arlen]
	set_input_delay -max [expr ($aclk_period - $clock_uncertainty) * $input_delay_ratio] -clock ACLK [get_ports us*_arlock]
	set_input_delay -max [expr ($aclk_period - $clock_uncertainty) * $input_delay_ratio] -clock ACLK [get_ports us*_arprot]
	set_input_delay -max [expr ($aclk_period - $clock_uncertainty) * $input_delay_ratio] -clock ACLK [get_ports us*_arsize]
	set_input_delay -max [expr ($aclk_period - $clock_uncertainty) * $input_delay_ratio] -clock ACLK [get_ports us*_arvalid]
	set_input_delay -max [expr ($aclk_period - $clock_uncertainty) * $input_delay_ratio] -clock ACLK [get_ports us*_wdata]
	set_input_delay -max [expr ($aclk_period - $clock_uncertainty) * $input_delay_ratio] -clock ACLK [get_ports us*_wlast]
	set_input_delay -max [expr ($aclk_period - $clock_uncertainty) * $input_delay_ratio] -clock ACLK [get_ports us*_wstrb]
	set_input_delay -max [expr ($aclk_period - $clock_uncertainty) * $input_delay_ratio] -clock ACLK [get_ports us*_wvalid]
	set_input_delay -max [expr ($aclk_period - $clock_uncertainty) * $input_delay_ratio] -clock ACLK [get_ports us*_bready]
	set_input_delay -max [expr ($aclk_period - $clock_uncertainty) * $input_delay_ratio] -clock ACLK [get_ports us*_rready]
	set_input_delay -max [expr ($aclk_period - $clock_uncertainty) * $input_delay_ratio] -clock ACLK [get_ports ds*_arready]
	set_input_delay -max [expr ($aclk_period - $clock_uncertainty) * $input_delay_ratio] -clock ACLK [get_ports ds*_awready]
	set_input_delay -max [expr ($aclk_period - $clock_uncertainty) * $input_delay_ratio] -clock ACLK [get_ports ds*_bid]
	set_input_delay -max [expr ($aclk_period - $clock_uncertainty) * $input_delay_ratio] -clock ACLK [get_ports ds*_bresp]
	set_input_delay -max [expr ($aclk_period - $clock_uncertainty) * $input_delay_ratio] -clock ACLK [get_ports ds*_bvalid]
	set_input_delay -max [expr ($aclk_period - $clock_uncertainty) * $input_delay_ratio] -clock ACLK [get_ports ds*_rdata]
	set_input_delay -max [expr ($aclk_period - $clock_uncertainty) * $input_delay_ratio] -clock ACLK [get_ports ds*_rid]
	set_input_delay -max [expr ($aclk_period - $clock_uncertainty) * $input_delay_ratio] -clock ACLK [get_ports ds*_rlast]
	set_input_delay -max [expr ($aclk_period - $clock_uncertainty) * $input_delay_ratio] -clock ACLK [get_ports ds*_rresp]
	set_input_delay -max [expr ($aclk_period - $clock_uncertainty) * $input_delay_ratio] -clock ACLK [get_ports ds*_rvalid]
	set_input_delay -max [expr ($aclk_period - $clock_uncertainty) * $input_delay_ratio] -clock ACLK [get_ports ds*_wready]

# Set Output Delays
	set output_delay_ratio 0.70
	set_output_delay -max [expr ($aclk_period - $clock_uncertainty) * $output_delay_ratio] -clock ACLK [get_ports ds*_araddr]
	set_output_delay -max [expr ($aclk_period - $clock_uncertainty) * $output_delay_ratio] -clock ACLK [get_ports ds*_arburst]
	set_output_delay -max [expr ($aclk_period - $clock_uncertainty) * $output_delay_ratio] -clock ACLK [get_ports ds*_arcache]
	set_output_delay -max [expr ($aclk_period - $clock_uncertainty) * $output_delay_ratio] -clock ACLK [get_ports ds*_arid]
	set_output_delay -max [expr ($aclk_period - $clock_uncertainty) * $output_delay_ratio] -clock ACLK [get_ports ds*_arlen]
	set_output_delay -max [expr ($aclk_period - $clock_uncertainty) * $output_delay_ratio] -clock ACLK [get_ports ds*_arlock]
	set_output_delay -max [expr ($aclk_period - $clock_uncertainty) * $output_delay_ratio] -clock ACLK [get_ports ds*_arprot]
	set_output_delay -max [expr ($aclk_period - $clock_uncertainty) * $output_delay_ratio] -clock ACLK [get_ports ds*_arsize]
	set_output_delay -max [expr ($aclk_period - $clock_uncertainty) * $output_delay_ratio] -clock ACLK [get_ports ds*_arvalid]
	set_output_delay -max [expr ($aclk_period - $clock_uncertainty) * $output_delay_ratio] -clock ACLK [get_ports ds*_awaddr]
	set_output_delay -max [expr ($aclk_period - $clock_uncertainty) * $output_delay_ratio] -clock ACLK [get_ports ds*_awburst]
	set_output_delay -max [expr ($aclk_period - $clock_uncertainty) * $output_delay_ratio] -clock ACLK [get_ports ds*_awcache]
	set_output_delay -max [expr ($aclk_period - $clock_uncertainty) * $output_delay_ratio] -clock ACLK [get_ports ds*_awid]
	set_output_delay -max [expr ($aclk_period - $clock_uncertainty) * $output_delay_ratio] -clock ACLK [get_ports ds*_awlen]
	set_output_delay -max [expr ($aclk_period - $clock_uncertainty) * $output_delay_ratio] -clock ACLK [get_ports ds*_awlock]
	set_output_delay -max [expr ($aclk_period - $clock_uncertainty) * $output_delay_ratio] -clock ACLK [get_ports ds*_awprot]
	set_output_delay -max [expr ($aclk_period - $clock_uncertainty) * $output_delay_ratio] -clock ACLK [get_ports ds*_awsize]
	set_output_delay -max [expr ($aclk_period - $clock_uncertainty) * $output_delay_ratio] -clock ACLK [get_ports ds*_awvalid]
	set_output_delay -max [expr ($aclk_period - $clock_uncertainty) * $output_delay_ratio] -clock ACLK [get_ports ds*_bready]
	set_output_delay -max [expr ($aclk_period - $clock_uncertainty) * $output_delay_ratio] -clock ACLK [get_ports ds*_rready]
	set_output_delay -max [expr ($aclk_period - $clock_uncertainty) * $output_delay_ratio] -clock ACLK [get_ports ds*_wdata]
	set_output_delay -max [expr ($aclk_period - $clock_uncertainty) * $output_delay_ratio] -clock ACLK [get_ports ds*_wlast]
	set_output_delay -max [expr ($aclk_period - $clock_uncertainty) * $output_delay_ratio] -clock ACLK [get_ports ds*_wstrb]
	set_output_delay -max [expr ($aclk_period - $clock_uncertainty) * $output_delay_ratio] -clock ACLK [get_ports ds*_wvalid]
	set_output_delay -max [expr ($aclk_period - $clock_uncertainty) * $output_delay_ratio] -clock ACLK [get_ports us*_arready]
	set_output_delay -max [expr ($aclk_period - $clock_uncertainty) * $output_delay_ratio] -clock ACLK [get_ports us*_awready]
	set_output_delay -max [expr ($aclk_period - $clock_uncertainty) * $output_delay_ratio] -clock ACLK [get_ports us*_bid]
	set_output_delay -max [expr ($aclk_period - $clock_uncertainty) * $output_delay_ratio] -clock ACLK [get_ports us*_bresp]
	set_output_delay -max [expr ($aclk_period - $clock_uncertainty) * $output_delay_ratio] -clock ACLK [get_ports us*_bvalid]
	set_output_delay -max [expr ($aclk_period - $clock_uncertainty) * $output_delay_ratio] -clock ACLK [get_ports us*_rdata]
	set_output_delay -max [expr ($aclk_period - $clock_uncertainty) * $output_delay_ratio] -clock ACLK [get_ports us*_rid]
	set_output_delay -max [expr ($aclk_period - $clock_uncertainty) * $output_delay_ratio] -clock ACLK [get_ports us*_rlast]
	set_output_delay -max [expr ($aclk_period - $clock_uncertainty) * $output_delay_ratio] -clock ACLK [get_ports us*_rresp]
	set_output_delay -max [expr ($aclk_period - $clock_uncertainty) * $output_delay_ratio] -clock ACLK [get_ports us*_rvalid]
	set_output_delay -max [expr ($aclk_period - $clock_uncertainty) * $output_delay_ratio] -clock ACLK [get_ports us*_wready]

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


