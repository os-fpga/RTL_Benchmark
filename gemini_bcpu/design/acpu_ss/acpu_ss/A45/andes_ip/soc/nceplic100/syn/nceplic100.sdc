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
# Specify Clock Information
# -------------------------------------------------------------
# Define Clocks
create_clock -name HCLK -period $hclk_period \
	-waveform [list 0 [expr $hclk_period / 2.0]] [get_ports clk]

# Specify Clock Skew
set_clock_uncertainty -setup $clock_uncertainty [all_clocks]

# Specify Clock Transition
set_clock_transition $clock_transition [all_clocks]
set bus_io_delay_ratio  0.667
set bus_io_delay        [expr ($hclk_period - $clock_uncertainty) * $bus_io_delay_ratio]

# -------------------------------------------------------------
# Define Input and Output Delays
# -------------------------------------------------------------
# Set Input Delays
set_input_delay -max [expr $bus_io_delay] -clock HCLK [get_ports reset_n]
	# AHB
set_input_delay -max [expr $bus_io_delay] -clock HCLK [get_ports hsel]
set_input_delay -max [expr $bus_io_delay] -clock HCLK [get_ports htrans]
set_input_delay -max [expr $bus_io_delay] -clock HCLK [get_ports haddr]
set_input_delay -max [expr $bus_io_delay] -clock HCLK [get_ports hready]
set_input_delay -max [expr $bus_io_delay] -clock HCLK [get_ports hwrite]
set_input_delay -max [expr $bus_io_delay] -clock HCLK [get_ports hwdata]
set_input_delay -max [expr $bus_io_delay] -clock HCLK [get_ports hsize]
	# AXI
set_input_delay -max [expr $bus_io_delay] -clock HCLK [get_ports araddr*]
set_input_delay -max [expr $bus_io_delay] -clock HCLK [get_ports arcache*]
set_input_delay -max [expr $bus_io_delay] -clock HCLK [get_ports arid*]
set_input_delay -max [expr $bus_io_delay] -clock HCLK [get_ports arlen*]
set_input_delay -max [expr $bus_io_delay] -clock HCLK [get_ports arlock*]
set_input_delay -max [expr $bus_io_delay] -clock HCLK [get_ports arprot*]
set_input_delay -max [expr $bus_io_delay] -clock HCLK [get_ports arsize*]
set_input_delay -max [expr $bus_io_delay] -clock HCLK [get_ports arvalid*]

set_input_delay -max [expr $bus_io_delay] -clock HCLK [get_ports awaddr*]
set_input_delay -max [expr $bus_io_delay] -clock HCLK [get_ports awcache*]
set_input_delay -max [expr $bus_io_delay] -clock HCLK [get_ports awid*]
set_input_delay -max [expr $bus_io_delay] -clock HCLK [get_ports awlen*]
set_input_delay -max [expr $bus_io_delay] -clock HCLK [get_ports awlock*]
set_input_delay -max [expr $bus_io_delay] -clock HCLK [get_ports awprot*]
set_input_delay -max [expr $bus_io_delay] -clock HCLK [get_ports awsize*]
set_input_delay -max [expr $bus_io_delay] -clock HCLK [get_ports awvalid*]

set_input_delay -max [expr $bus_io_delay] -clock HCLK [get_ports bready*]
set_input_delay -max [expr $bus_io_delay] -clock HCLK [get_ports rready*]
set_input_delay -max [expr $bus_io_delay] -clock HCLK [get_ports wdata*]
#set_input_delay -max [expr $bus_io_delay] -clock HCLK [get_ports wid*]
set_input_delay -max [expr $bus_io_delay] -clock HCLK [get_ports wlast*]
set_input_delay -max [expr $bus_io_delay] -clock HCLK [get_ports wstrb*]
set_input_delay -max [expr $bus_io_delay] -clock HCLK [get_ports wvalid*]

set_input_delay -max [expr $bus_io_delay] -clock HCLK [get_ports int_src]
set_input_delay -max [expr $bus_io_delay] -clock HCLK [get_ports *eiack]
# Set Output Delays
set_output_delay -max [expr $bus_io_delay] -clock HCLK [get_ports *eip]
set_output_delay -max [expr $bus_io_delay] -clock HCLK [get_ports *eiid*]
	# AHB
set_output_delay -max [expr $bus_io_delay] -clock HCLK [get_ports hrdata]
set_output_delay -max [expr $bus_io_delay] -clock HCLK [get_ports hreadyout]
set_output_delay -max [expr $bus_io_delay] -clock HCLK [get_ports hresp]
	# AXI
set_output_delay -max [expr $bus_io_delay] -clock HCLK [get_ports arready*]
set_output_delay -max [expr $bus_io_delay] -clock HCLK [get_ports awready*]
set_output_delay -max [expr $bus_io_delay] -clock HCLK [get_ports bid*]
set_output_delay -max [expr $bus_io_delay] -clock HCLK [get_ports bvalid*]
set_output_delay -max [expr $bus_io_delay] -clock HCLK [get_ports bresp*]
set_output_delay -max [expr $bus_io_delay] -clock HCLK [get_ports rvalid*]
set_output_delay -max [expr $bus_io_delay] -clock HCLK [get_ports rdata*]
set_output_delay -max [expr $bus_io_delay] -clock HCLK [get_ports rid*]
set_output_delay -max [expr $bus_io_delay] -clock HCLK [get_ports rresp*]
set_output_delay -max [expr $bus_io_delay] -clock HCLK [get_ports rlast*]
set_output_delay -max [expr $bus_io_delay] -clock HCLK [get_ports wready*]

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


