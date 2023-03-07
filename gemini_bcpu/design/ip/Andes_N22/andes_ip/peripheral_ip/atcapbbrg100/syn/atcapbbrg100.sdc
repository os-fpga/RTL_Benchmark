if {![info exists env(hclk_period)]} {
	set hclk_period 20.0
} else {
	set hclk_period $env(hclk_period)
}

if {![info exists env(pclk_period)]} {
	set pclk_period 20.0
} else {
	set pclk_period $env(pclk_period)
}

set clk_ratio [expr round($pclk_period / $hclk_period)]

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

if {[sizeof_collection [get_ports -quiet pprot]]} {
	set apb4_support 1
} else {
	set apb4_support 0
}


# -------------------------------------------------------------
# Specify Clock Information
# -------------------------------------------------------------
# Define Clocks
create_clock -name HCLK -period $hclk_period \
	-waveform [list 0 [expr $hclk_period / 2.0]] [get_ports hclk]
create_clock -name PCLK -period $pclk_period \
	-waveform [list 0 [expr $pclk_period / 2.0]] [get_ports pclk]

# Specify Clock Skew
set_clock_uncertainty -setup $clock_uncertainty [all_clocks]

# Specify Clock Transition
set_clock_transition $clock_transition [all_clocks]


# -------------------------------------------------------------
# Define Input and Output Delays
# -------------------------------------------------------------
# Set Input Delays
set_input_delay -max [expr $pclk_period * 0.7] -clock PCLK [get_ports presetn]
set_input_delay -max [expr $pclk_period * 0.6] -clock PCLK [get_ports ps*_prdata]
set_input_delay -max [expr $pclk_period * 0.6] -clock PCLK [get_ports ps*_pready]
set_input_delay -max [expr $pclk_period * 0.6] -clock PCLK [get_ports ps*_pslverr]
set_input_delay -max [expr $hclk_period * 0.7] -clock HCLK [get_ports hresetn]
set_input_delay -max [expr $hclk_period * 0.7] -clock HCLK [get_ports hsel]
set_input_delay -max [expr $hclk_period * 0.7] -clock HCLK [get_ports htrans]
set_input_delay -max [expr $hclk_period * 0.3] -clock HCLK [get_ports haddr]
set_input_delay -max [expr $hclk_period * 0.7] -clock HCLK [get_ports hready_in]
set_input_delay -max [expr $hclk_period * 0.7] -clock HCLK [get_ports hwrite]
set_input_delay -max [expr $hclk_period * 0.7] -clock HCLK [get_ports hwdata]
set_input_delay -max [expr $hclk_period * 0.7] -clock HCLK [get_ports hsize]
set_input_delay -max [expr $hclk_period * 0.7] -clock HCLK [get_ports hprot]
set_input_delay -max [expr $hclk_period * 0.3] -clock HCLK [get_ports apb2ahb_clken]

# Set Output Delays
set_output_delay -max [expr $pclk_period * 0.7 / $clk_ratio] -clock PCLK [get_ports paddr]
set_output_delay -max [expr $pclk_period * 0.7 / $clk_ratio] -clock PCLK [get_ports penable]
set_output_delay -max [expr $pclk_period * 0.7 / $clk_ratio] -clock PCLK [get_ports pwrite]
set_output_delay -max [expr $pclk_period * 0.7 / $clk_ratio] -clock PCLK [get_ports pwdata]
set_output_delay -max [expr $pclk_period * 0.7 / $clk_ratio] -clock PCLK [get_ports ps*_psel]
if {$apb4_support} {
set_output_delay -max [expr $pclk_period * 0.7 / $clk_ratio] -clock PCLK [get_ports pprot]
set_output_delay -max [expr $pclk_period * 0.7 / $clk_ratio] -clock PCLK [get_ports pstrb]
}
set_output_delay -max [expr $hclk_period * 0.3] -clock HCLK [get_ports hrdata]
set_output_delay -max [expr $hclk_period * 0.3] -clock HCLK [get_ports hready]
set_output_delay -max [expr $hclk_period * 0.3] -clock HCLK [get_ports hresp]

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
if {$clk_ratio >= 2} {
	set_multicycle_path -setup $clk_ratio -from [get_clocks PCLK] -to [get_clocks HCLK]
	set_multicycle_path -hold  [expr $clk_ratio - 1] -from [get_clocks PCLK] -to [get_clocks HCLK]

#	# HCLK -> u_cmd_fifo/rd_data -> hready
#	set_multicycle_path -setup $clk_ratio -through [get_pins u_cmd_fifo/rd_data] -to [get_ports hready]
#	set_multicycle_path -hold [expr $clk_ratio - 1] -through [get_pins u_cmd_fifo/rd_data] -to [get_ports hready]

	# HCLK -> u_cmd_fifo/rd_data -> hrdata
	set_multicycle_path -setup $clk_ratio -through [get_pins u_cmd_fifo/rd_data] -to [get_ports hrdata]
	set_multicycle_path -hold [expr $clk_ratio - 1] -through [get_pins u_cmd_fifo/rd_data] -to [get_ports hrdata]

	# HCLK -> u_cmd_fifo/rd_data -> ps*_psel
	set_multicycle_path -setup $clk_ratio -through [get_pins u_cmd_fifo/rd_data] -to [get_ports ps*_psel]
	set_multicycle_path -hold [expr $clk_ratio - 1] -through [get_pins u_cmd_fifo/rd_data] -to [get_ports ps*_psel]
}

# Specify Path Delays


