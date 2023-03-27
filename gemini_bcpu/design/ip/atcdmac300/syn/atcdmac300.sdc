if {![info exists env(aclk_period)]} {
	set aclk_period 10.0
} else {
	set aclk_period $env(aclk_period)
}

if {![info exists env(pclk_period)]} {
	set pclk_period 10.0
} else {
	set pclk_period $env(pclk_period)
}

if {![info exists env(clock_uncertainty)]} {
	set clock_uncertainty 0.3
} else {
	set clock_uncertainty $env(clock_uncertainty)
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
# Create clock 
# -------------------------------------------------------------
create_clock -name PCLK -period $pclk_period \
	-waveform [list 0 [expr $pclk_period / 2.0]] [get_ports pclk]

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
set apb_input_delay  [expr ($pclk_period - $clock_uncertainty) * $input_ratio]
set apb_output_delay [expr ($pclk_period - $clock_uncertainty) * $output_ratio]

# Set Input Delays
set_input_delay -max $apb_input_delay -clock PCLK [get_ports paddr*]
set_input_delay -max $apb_input_delay -clock PCLK [get_ports penable]
set_input_delay -max $apb_input_delay -clock PCLK [get_ports presetn]
set_input_delay -max $apb_input_delay -clock PCLK [get_ports psel]
set_input_delay -max $apb_input_delay -clock PCLK [get_ports pwdata*]
set_input_delay -max $apb_input_delay -clock PCLK [get_ports pwrite*]

set_input_delay -max $axi_input_delay -clock ACLK [get_ports aresetn]
set_input_delay -max $axi_input_delay -clock ACLK [get_ports m*_awready*]
set_input_delay -max $axi_input_delay -clock ACLK [get_ports m*_wready*]
set_input_delay -max $axi_input_delay -clock ACLK [get_ports m*_bresp*]
set_input_delay -max $axi_input_delay -clock ACLK [get_ports m*_bvalid*]
set_input_delay -max $axi_input_delay -clock ACLK [get_ports m*_arready*]
set_input_delay -max $axi_input_delay -clock ACLK [get_ports m*_rresp*]
set_input_delay -max $axi_input_delay -clock ACLK [get_ports m*_rlast*]
set_input_delay -max $axi_input_delay -clock ACLK [get_ports m*_rvalid*]
set_input_delay -max $axi_input_delay -clock ACLK [get_ports m*_rdata*]
set_input_delay -max $axi_input_delay -clock ACLK [get_ports dma_req*]

# Set Output Delays
set_output_delay -max $apb_output_delay -clock PCLK [get_ports prdata*]
set_output_delay -max $apb_output_delay -clock PCLK [get_ports pready]
set_output_delay -max $apb_output_delay -clock PCLK [get_ports pslverr]

set_output_delay -max $axi_output_delay -clock ACLK [get_ports m*_awaddr*]
set_output_delay -max $axi_output_delay -clock ACLK [get_ports m*_awlen*]
set_output_delay -max $axi_output_delay -clock ACLK [get_ports m*_awsize*]
set_output_delay -max $axi_output_delay -clock ACLK [get_ports m*_awburst*]
set_output_delay -max $axi_output_delay -clock ACLK [get_ports m*_awlock*]
set_output_delay -max $axi_output_delay -clock ACLK [get_ports m*_awcache*]
set_output_delay -max $axi_output_delay -clock ACLK [get_ports m*_awprot*]
set_output_delay -max $axi_output_delay -clock ACLK [get_ports m*_awvalid*]
set_output_delay -max $axi_output_delay -clock ACLK [get_ports m*_wstrb*]
set_output_delay -max $axi_output_delay -clock ACLK [get_ports m*_wlast*]
set_output_delay -max $axi_output_delay -clock ACLK [get_ports m*_wvalid*]
set_output_delay -max $axi_output_delay -clock ACLK [get_ports m*_wdata*]
set_output_delay -max $axi_output_delay -clock ACLK [get_ports m*_bready*]
set_output_delay -max $axi_output_delay -clock ACLK [get_ports m*_araddr*]
set_output_delay -max $axi_output_delay -clock ACLK [get_ports m*_arlen*]
set_output_delay -max $axi_output_delay -clock ACLK [get_ports m*_arsize*]
set_output_delay -max $axi_output_delay -clock ACLK [get_ports m*_arburst*]
set_output_delay -max $axi_output_delay -clock ACLK [get_ports m*_arlock*]
set_output_delay -max $axi_output_delay -clock ACLK [get_ports m*_arcache*]
set_output_delay -max $axi_output_delay -clock ACLK [get_ports m*_arprot*]
set_output_delay -max $axi_output_delay -clock ACLK [get_ports m*_arvalid*]
set_output_delay -max $axi_output_delay -clock ACLK [get_ports m*_rready*]
set_output_delay -max $axi_output_delay -clock ACLK [get_ports dma_ack*]
set_output_delay -max $axi_output_delay -clock ACLK [get_ports dma_int]


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
set_false_path -from [get_clocks PCLK] -to [get_clocks ACLK]
set_false_path -from [get_clocks ACLK] -to [get_clocks PCLK]

# Specify Multi-Cycle Paths

# Specify Path Delays


