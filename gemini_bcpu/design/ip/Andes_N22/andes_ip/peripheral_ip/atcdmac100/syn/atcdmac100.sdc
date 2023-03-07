
if {![info exists env(hclk_period)]} {
	set hclk_period 20.0
} else {
	set hclk_period $env(hclk_period)
}

if {![info exists clock_uncertainty]} {
	set clock_uncertainty 0.05
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
create_clock -name HCLK -period $hclk_period \
	-waveform [list 0 [expr $hclk_period / 2.0]] [get_ports hclk]

# Specify Clock Skew
set_clock_uncertainty -setup $clock_uncertainty [all_clocks]

# Specify Clock Transition
set_clock_transition $clock_transition [all_clocks]


# -------------------------------------------------------------
# Define Input and Output Delays
# -------------------------------------------------------------
# Set Input Delays
set_input_delay -max [expr $hclk_period * 0.58] -clock HCLK [get_ports dma_req*]
set_input_delay -max [expr $hclk_period * 0.58] -clock HCLK [get_ports hsel]
set_input_delay -max [expr $hclk_period * 0.58] -clock HCLK \
	[remove_from_collection [get_ports haddr*] [get_ports haddr_mst*]]
set_input_delay -max [expr $hclk_period * 0.58] -clock HCLK \
	[remove_from_collection [get_ports hburst*] [get_ports hburst_mst*]]
set_input_delay -max [expr $hclk_period * 0.58] -clock HCLK [get_ports hgrant_mst*]
set_input_delay -max [expr $hclk_period * 0.58] -clock HCLK [get_ports hrdata_mst*]
set_input_delay -max [expr $hclk_period * 0.58] -clock HCLK [get_ports hready_mst]
set_input_delay -max [expr $hclk_period * 0.58] -clock HCLK [get_ports hreadyin]
set_input_delay -max [expr $hclk_period * 0.58] -clock HCLK [get_ports hresetn]
set_input_delay -max [expr $hclk_period * 0.58] -clock HCLK [get_ports hresp_mst*]
set_input_delay -max [expr $hclk_period * 0.58] -clock HCLK \
	[remove_from_collection [get_ports hsize*] [get_ports hsize_mst*]]
set_input_delay -max [expr $hclk_period * 0.58] -clock HCLK \
	[remove_from_collection [get_ports htrans*] [get_ports htrans_mst*]]
set_input_delay -max [expr $hclk_period * 0.58] -clock HCLK [get_ports hwrite]
set_input_delay -max [expr $hclk_period * 0.58] -clock HCLK \
	[remove_from_collection [get_ports hwdata*] [get_ports hwdata_mst*]]

# Set Output Delays
set_output_delay -max [expr $hclk_period * 0.58] -clock HCLK [get_ports dma_ack*]
set_output_delay -max [expr $hclk_period * 0.58] -clock HCLK [get_ports dma_int]
set_output_delay -max [expr $hclk_period * 0.58] -clock HCLK [get_ports haddr_mst*]
set_output_delay -max [expr $hclk_period * 0.58] -clock HCLK [get_ports hburst_mst*]
set_output_delay -max [expr $hclk_period * 0.58] -clock HCLK [get_ports hbusreq_mst]
set_output_delay -max [expr $hclk_period * 0.58] -clock HCLK [get_ports hlock_mst]
set_output_delay -max [expr $hclk_period * 0.58] -clock HCLK [get_ports hprot_mst*]
set_output_delay -max [expr $hclk_period * 0.58] -clock HCLK \
	[remove_from_collection [get_ports hrdata*] [get_ports hrdata_mst*]]
set_output_delay -max [expr $hclk_period * 0.58] -clock HCLK [get_ports hready]
set_output_delay -max [expr $hclk_period * 0.58] -clock HCLK \
	[remove_from_collection [get_ports hresp*] [get_ports hresp_mst*]]
set_output_delay -max [expr $hclk_period * 0.58] -clock HCLK [get_ports hsize_mst*]
set_output_delay -max [expr $hclk_period * 0.58] -clock HCLK [get_ports htrans_mst*]
set_output_delay -max [expr $hclk_period * 0.58] -clock HCLK [get_ports hwdata_mst*]
set_output_delay -max [expr $hclk_period * 0.58] -clock HCLK [get_ports hwrite_mst]

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
set_false_path -from [get_ports hresetn]
set_ideal_network [get_ports hclk]

# Specify Multi-Cycle Paths

# Specify Path Delays


