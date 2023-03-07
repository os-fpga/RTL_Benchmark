if {![info exists env(hclk_period)]} {
	set hclk_period 20.0
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


# -------------------------------------------------------------
# Create clock 
# -------------------------------------------------------------
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
set_input_delay -max [expr $hclk_period * 1/3] -clock HCLK [get_ports hresetn]
set_input_delay -max [expr $hclk_period * 1/3] -clock HCLK [get_ports hm*htrans*]
set_input_delay -max [expr $hclk_period * 1/3] -clock HCLK [get_ports hm*hwrite*]
set_input_delay -max [expr $hclk_period * 1/3] -clock HCLK [get_ports hm*haddr*]
set_input_delay -max [expr $hclk_period * 1/3] -clock HCLK [get_ports hm*hburst*]
set_input_delay -max [expr $hclk_period * 1/3] -clock HCLK [get_ports hm*hsize*]
set_input_delay -max [expr $hclk_period * 1/3] -clock HCLK [get_ports hm*hprot*]
set_input_delay -max [expr $hclk_period * 1/3] -clock HCLK [get_ports hm*hwdata*]
set_input_delay -max [expr $hclk_period * 2/5] -clock HCLK [get_ports hs*hready*]
set_input_delay -max [expr $hclk_period * 1/3] -clock HCLK [get_ports hs*hresp*]
set_input_delay -max [expr $hclk_period * 1/3] -clock HCLK [get_ports hs*hrdata*]

# Set Output Delays
set_output_delay -max [expr $hclk_period * 1/3] -clock HCLK [get_ports  hm*hrdata*]
set_output_delay -max [expr $hclk_period * 1/3] -clock HCLK [get_ports  hm*hready*]
set_output_delay -max [expr $hclk_period * 1/3] -clock HCLK [get_ports  hm*hresp*]
set_output_delay -max [expr $hclk_period * 2/3] -clock HCLK [get_ports  bmc_intr]

set_output_delay -max [expr $hclk_period * 1/3] -clock HCLK [get_ports  hs*hsel]
set_output_delay -max [expr $hclk_period * 1/3] -clock HCLK [get_ports  hs*hburst*]
set_output_delay -max [expr $hclk_period * 1/3] -clock HCLK [get_ports  hs*haddr*]
set_output_delay -max [expr $hclk_period * 1/3] -clock HCLK [get_ports  hs*htrans*]
set_output_delay -max [expr $hclk_period * 1/3] -clock HCLK [get_ports  hs*hsize*]
set_output_delay -max [expr $hclk_period * 1/3] -clock HCLK [get_ports  hs*hwrite*]
set_output_delay -max [expr $hclk_period * 1/3] -clock HCLK [get_ports  hs*hwdata*]
set_output_delay -max [expr $hclk_period * 1/3] -clock HCLK [get_ports  hs*hprot*]
set_output_delay -max [expr $hclk_period * 1/3] -clock HCLK [get_ports  bmc_hs*_hready]


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


