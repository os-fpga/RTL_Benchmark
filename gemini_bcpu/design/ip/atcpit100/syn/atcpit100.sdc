if {![info exists env(pclk_period)]} {
	set pclk_period 20.0
} else {
	set pclk_period $env(pclk_period)
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
set_input_delay -max [expr $pclk_period * 0.7] -clock PCLK [get_ports psel]
set_input_delay -max [expr $pclk_period * 0.7] -clock PCLK [get_ports paddr*]
set_input_delay -max [expr $pclk_period * 0.7] -clock PCLK [get_ports penable]
set_input_delay -max [expr $pclk_period * 0.7] -clock PCLK [get_ports pwrite]
set_input_delay -max [expr $pclk_period * 0.7] -clock PCLK [get_ports pwdata*]
set_input_delay -max [expr $pclk_period * 0.7] -clock PCLK [get_ports presetn]
set_input_delay -max [expr $pclk_period * 0.7] -clock PCLK [get_ports extclk]
set_input_delay -max [expr $pclk_period * 0.7] -clock PCLK [get_ports pit_pause]

# Set Output Delays
set_output_delay -max [expr $pclk_period * 0.7] -clock PCLK [get_ports prdata*]
set_output_delay -max [expr $pclk_period * 0.7] -clock PCLK [get_ports pit_intr]
set_output_delay -max [expr $pclk_period * 0.7] -clock PCLK [get_ports ch*_pwm]
set_output_delay -max [expr $pclk_period * 0.7] -clock PCLK [get_ports ch*_pwmoe]


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
set_multicycle_path 2 -setup -from [get_ports paddr*] -to [get_ports prdata*]
set_multicycle_path 1 -hold -from [get_ports paddr*] -to [get_ports prdata*]
set_multicycle_path 2 -setup -from [get_ports psel] -to [get_ports prdata*]
set_multicycle_path 1 -hold -from [get_ports psel] -to [get_ports prdata*]
set_multicycle_path 2 -setup -from [get_ports pwrite] -to [get_ports prdata*]
set_multicycle_path 1 -hold -from [get_ports pwrite] -to [get_ports prdata*]


# Specify Path Delays


