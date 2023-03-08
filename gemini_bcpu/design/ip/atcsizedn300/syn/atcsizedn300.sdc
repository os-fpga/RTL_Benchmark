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

if {![info exists input_ratio]} {
	set input_ratio  0.6
}

if {![info exists output_ratio]} {
	set output_ratio 0.6
}

if {![info exists internal_ratio]} {
	set internal_ratio 0.2
}

# -------------------------------------------------------------
# Specify Clock Information
# -------------------------------------------------------------
# Define Clocks
create_clock -name ACLK -period $aclk_period \
   -waveform [list 0 [expr $aclk_period / 2.0]] [get_ports aclk]

# Specify Clock Skew
set_clock_uncertainty -setup $clock_uncertainty [all_clocks]

# Specify Clock Transition
set_clock_transition $clock_transition [all_clocks]


# -------------------------------------------------------------
# Define Input and Output Delays
# -------------------------------------------------------------
set input_delay  [expr ($aclk_period - $clock_uncertainty) * $input_ratio]
set output_delay [expr ($aclk_period - $clock_uncertainty) * $output_ratio]

# Set Input Delays
set_input_delay -max $input_delay -clock ACLK [get_ports ds_arready]
set_input_delay -max $input_delay -clock ACLK [get_ports ds_awready]
set_input_delay -max $input_delay -clock ACLK [get_ports ds_bresp]
set_input_delay -max $input_delay -clock ACLK [get_ports ds_bvalid]
set_input_delay -max $input_delay -clock ACLK [get_ports ds_rdata]
set_input_delay -max $input_delay -clock ACLK [get_ports ds_rlast]
set_input_delay -max $input_delay -clock ACLK [get_ports ds_rresp]
set_input_delay -max $input_delay -clock ACLK [get_ports ds_rvalid]
set_input_delay -max $input_delay -clock ACLK [get_ports ds_wready]
set_input_delay -max $input_delay -clock ACLK [get_ports us_araddr]
set_input_delay -max $input_delay -clock ACLK [get_ports us_arburst]
set_input_delay -max $input_delay -clock ACLK [get_ports us_arcache]
set_input_delay -max $input_delay -clock ACLK [get_ports us_arid]
set_input_delay -max $input_delay -clock ACLK [get_ports us_arlen]
set_input_delay -max $input_delay -clock ACLK [get_ports us_arlock]
set_input_delay -max $input_delay -clock ACLK [get_ports us_arprot]
set_input_delay -max $input_delay -clock ACLK [get_ports us_arsize]
set_input_delay -max $input_delay -clock ACLK [get_ports us_arvalid]
set_input_delay -max $input_delay -clock ACLK [get_ports us_awaddr]
set_input_delay -max $input_delay -clock ACLK [get_ports us_awburst]
set_input_delay -max $input_delay -clock ACLK [get_ports us_awcache]
set_input_delay -max $input_delay -clock ACLK [get_ports us_awid]
set_input_delay -max $input_delay -clock ACLK [get_ports us_awlen]
set_input_delay -max $input_delay -clock ACLK [get_ports us_awlock]
set_input_delay -max $input_delay -clock ACLK [get_ports us_awprot]
set_input_delay -max $input_delay -clock ACLK [get_ports us_awsize]
set_input_delay -max $input_delay -clock ACLK [get_ports us_awvalid]
set_input_delay -max $input_delay -clock ACLK [get_ports us_bready]
set_input_delay -max $input_delay -clock ACLK [get_ports us_rready]
set_input_delay -max $input_delay -clock ACLK [get_ports us_wdata]
set_input_delay -max $input_delay -clock ACLK [get_ports us_wlast]
set_input_delay -max $input_delay -clock ACLK [get_ports us_wstrb]
set_input_delay -max $input_delay -clock ACLK [get_ports us_wvalid]

# Set Output Delays
set_output_delay -max $output_delay -clock ACLK [get_ports ds_araddr]
set_output_delay -max $output_delay -clock ACLK [get_ports ds_arburst]
set_output_delay -max $output_delay -clock ACLK [get_ports ds_arcache]
set_output_delay -max $output_delay -clock ACLK [get_ports ds_arlen]
set_output_delay -max $output_delay -clock ACLK [get_ports ds_arlock]
set_output_delay -max $output_delay -clock ACLK [get_ports ds_arprot]
set_output_delay -max $output_delay -clock ACLK [get_ports ds_arsize]
set_output_delay -max $output_delay -clock ACLK [get_ports ds_arvalid]
set_output_delay -max $output_delay -clock ACLK [get_ports ds_awaddr]
set_output_delay -max $output_delay -clock ACLK [get_ports ds_awburst]
set_output_delay -max $output_delay -clock ACLK [get_ports ds_awcache]
set_output_delay -max $output_delay -clock ACLK [get_ports ds_awlen]
set_output_delay -max $output_delay -clock ACLK [get_ports ds_awlock]
set_output_delay -max $output_delay -clock ACLK [get_ports ds_awprot]
set_output_delay -max $output_delay -clock ACLK [get_ports ds_awsize]
set_output_delay -max $output_delay -clock ACLK [get_ports ds_awvalid]
set_output_delay -max $output_delay -clock ACLK [get_ports ds_bready]
set_output_delay -max $output_delay -clock ACLK [get_ports ds_rready]
set_output_delay -max $output_delay -clock ACLK [get_ports ds_wdata]
set_output_delay -max $output_delay -clock ACLK [get_ports ds_wlast]
set_output_delay -max $output_delay -clock ACLK [get_ports ds_wstrb]
set_output_delay -max $output_delay -clock ACLK [get_ports ds_wvalid]
set_output_delay -max $output_delay -clock ACLK [get_ports us_arready]
set_output_delay -max $output_delay -clock ACLK [get_ports us_awready]
set_output_delay -max $output_delay -clock ACLK [get_ports us_bid]
set_output_delay -max $output_delay -clock ACLK [get_ports us_bresp]
set_output_delay -max $output_delay -clock ACLK [get_ports us_bvalid]
set_output_delay -max $output_delay -clock ACLK [get_ports us_rdata]
set_output_delay -max $output_delay -clock ACLK [get_ports us_rid]
set_output_delay -max $output_delay -clock ACLK [get_ports us_rlast]
set_output_delay -max $output_delay -clock ACLK [get_ports us_rresp]
set_output_delay -max $output_delay -clock ACLK [get_ports us_rvalid]
set_output_delay -max $output_delay -clock ACLK [get_ports us_wready]

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
