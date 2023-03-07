if {![info exists env(aclk_period)]} {
	set aclk_period 10.0
} else {
	set aclk_period $env(aclk_period)
}

if {![info exists env(hclk_period)]} {
	set hclk_period 10.0
} else {
	set hclk_period $env(hclk_period)
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
create_clock -name HCLK -period $hclk_period \
	-waveform [list 0 [expr $hclk_period / 2.0]] [get_ports hclk]

create_clock -name ACLK -period $aclk_period \
	-waveform [list 0 [expr $aclk_period / 2.0]] [get_ports aclk]

# Specify Clock Skew
set_clock_uncertainty -setup $clock_uncertainty [all_clocks]

# Specify Clock Transition
set_clock_transition $clock_transition [all_clocks]


# -------------------------------------------------------------
# Define Input and Output Delays
# -------------------------------------------------------------
set axi_input_delay  [expr ($aclk_period - $clock_uncertainty) * $input_ratio]
set axi_output_delay [expr ($aclk_period - $clock_uncertainty) * $output_ratio]
set ahb_input_delay  [expr ($hclk_period - $clock_uncertainty) * $input_ratio]
set ahb_output_delay [expr ($hclk_period - $clock_uncertainty) * $output_ratio]

# Set Input Delays
set_input_delay -max $axi_input_delay -clock ACLK [get_ports aresetn]
set_input_delay -max $axi_input_delay -clock ACLK [get_ports awaddr*]
set_input_delay -max $axi_input_delay -clock ACLK [get_ports awburst*]
set_input_delay -max $axi_input_delay -clock ACLK [get_ports awsize*]
set_input_delay -max $axi_input_delay -clock ACLK [get_ports awcache*]
set_input_delay -max $axi_input_delay -clock ACLK [get_ports awlen*]
set_input_delay -max $axi_input_delay -clock ACLK [get_ports awprot*]
set_input_delay -max $axi_input_delay -clock ACLK [get_ports awlock*]
set_input_delay -max $axi_input_delay -clock ACLK [get_ports awid*]
set_input_delay -max $axi_input_delay -clock ACLK [get_ports awvalid*]
set_input_delay -max $axi_input_delay -clock ACLK [get_ports araddr*]
set_input_delay -max $axi_input_delay -clock ACLK [get_ports arburst*]
set_input_delay -max $axi_input_delay -clock ACLK [get_ports arsize*]
set_input_delay -max $axi_input_delay -clock ACLK [get_ports arlen*]
set_input_delay -max $axi_input_delay -clock ACLK [get_ports arcache*]
set_input_delay -max $axi_input_delay -clock ACLK [get_ports arprot*]
set_input_delay -max $axi_input_delay -clock ACLK [get_ports arlock*]
set_input_delay -max $axi_input_delay -clock ACLK [get_ports arid*]
set_input_delay -max $axi_input_delay -clock ACLK [get_ports arvalid*]
set_input_delay -max $axi_input_delay -clock ACLK [get_ports wdata*]
set_input_delay -max $axi_input_delay -clock ACLK [get_ports wlast*]
set_input_delay -max $axi_input_delay -clock ACLK [get_ports wstrb*]
set_input_delay -max $axi_input_delay -clock ACLK [get_ports wvalid*]
set_input_delay -max $axi_input_delay -clock ACLK [get_ports bready*]
set_input_delay -max $axi_input_delay -clock ACLK [get_ports rready*]

set_input_delay -max $ahb_input_delay -clock HCLK [get_ports hresetn]
set_input_delay -max $ahb_input_delay -clock HCLK [get_ports hready*]
set_input_delay -max $ahb_input_delay -clock HCLK [get_ports hrdata*]
set_input_delay -max $ahb_input_delay -clock HCLK [get_ports hresp*]

# Set Output Delays
set_output_delay -max $ahb_output_delay -clock HCLK [get_ports hwrite]
set_output_delay -max $ahb_output_delay -clock HCLK [get_ports haddr*]
set_output_delay -max $ahb_output_delay -clock HCLK [get_ports hburst*]
set_output_delay -max $ahb_output_delay -clock HCLK [get_ports htrans*]
set_output_delay -max $ahb_output_delay -clock HCLK [get_ports hsize*]
set_output_delay -max $ahb_output_delay -clock HCLK [get_ports hprot*]
set_output_delay -max $ahb_output_delay -clock HCLK [get_ports hwdata*]

set_output_delay -max $axi_output_delay -clock ACLK [get_ports rid*]
set_output_delay -max $axi_output_delay -clock ACLK [get_ports rlast*]
set_output_delay -max $axi_output_delay -clock ACLK [get_ports bid*]
set_output_delay -max $axi_output_delay -clock ACLK [get_ports rdata*]
set_output_delay -max $axi_output_delay -clock ACLK [get_ports rresp*]
set_output_delay -max $axi_output_delay -clock ACLK [get_ports bresp*]
set_output_delay -max $axi_output_delay -clock ACLK [get_ports arready*] 
set_output_delay -max $axi_output_delay -clock ACLK [get_ports awready*]
set_output_delay -max $axi_output_delay -clock ACLK [get_ports wready*]
set_output_delay -max $axi_output_delay -clock ACLK [get_ports rvalid*]
set_output_delay -max $axi_output_delay -clock ACLK [get_ports bvalid*]


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
set_false_path -from [get_clocks HCLK] -to [get_clocks ACLK]
set_false_path -from [get_clocks ACLK] -to [get_clocks HCLK]

# Specify Multi-Cycle Paths

# Specify Path Delays

