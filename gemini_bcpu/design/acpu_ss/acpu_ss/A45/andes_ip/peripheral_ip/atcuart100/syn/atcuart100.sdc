
if {[sizeof_collection [get_ports -quiet uclk]]} {
	set uclk_pclk_same 0
} else {
	set uclk_pclk_same 1
}

if {![info exists env(pclk_period)]} {
	set pclk_period 20.0
} else {
	set pclk_period $env(pclk_period)
}

if {$uclk_pclk_same} {
	set uclk_period $pclk_period
} else {
	if {![info exists env(uclk_period)]} {
		set uclk_period $pclk_period
	} else {
		set uclk_period $env(uclk_period)
	}
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

if {$uclk_pclk_same} {
} else {
	create_clock -name UCLK -period $uclk_period \
		-waveform [list 0 [expr $uclk_period / 2.0]] [get_ports uclk]
}

# Specify Clock Skew
set_clock_uncertainty -setup $clock_uncertainty [all_clocks]

# Specify Clock Transition
set_clock_transition $clock_transition [all_clocks]


# -------------------------------------------------------------
# Define Input and Output Delays
# -------------------------------------------------------------
# Set Input Delays
set_input_delay -max [expr $pclk_period * 0.7] -clock PCLK [get_ports dma_rx_ack]
set_input_delay -max [expr $pclk_period * 0.7] -clock PCLK [get_ports dma_tx_ack]
set_input_delay -max [expr $pclk_period * 0.7] -clock PCLK [get_ports presetn]
set_input_delay -max [expr $pclk_period * 0.7] -clock PCLK [get_ports psel]
set_input_delay -max [expr $pclk_period * 0.7] -clock PCLK [get_ports penable]
set_input_delay -max [expr $pclk_period * 0.7] -clock PCLK [get_ports paddr*]
set_input_delay -max [expr $pclk_period * 0.7] -clock PCLK [get_ports pwrite]
set_input_delay -max [expr $pclk_period * 0.7] -clock PCLK [get_ports pwdata*]

if {$uclk_pclk_same} {
	set_input_delay -max [expr $uclk_period * 0.7] -clock PCLK [get_ports uart_ctsn]
	set_input_delay -max [expr $uclk_period * 0.7] -clock PCLK [get_ports uart_dcdn]
	set_input_delay -max [expr $uclk_period * 0.7] -clock PCLK [get_ports uart_dsrn]
	set_input_delay -max [expr $uclk_period * 0.7] -clock PCLK [get_ports uart_rin]
	set_input_delay -max [expr $uclk_period * 0.7] -clock PCLK [get_ports uart_sin]
} else {
	set_input_delay -max [expr $uclk_period * 0.7] -clock UCLK [get_ports urstn]
	set_input_delay -max [expr $uclk_period * 0.7] -clock UCLK [get_ports uart_ctsn]
	set_input_delay -max [expr $uclk_period * 0.7] -clock UCLK [get_ports uart_dcdn]
	set_input_delay -max [expr $uclk_period * 0.7] -clock UCLK [get_ports uart_dsrn]
	set_input_delay -max [expr $uclk_period * 0.7] -clock UCLK [get_ports uart_rin]
	set_input_delay -max [expr $uclk_period * 0.7] -clock UCLK [get_ports uart_sin]
}

# Set Output Delays
set_output_delay -max [expr $pclk_period * 0.7] -clock PCLK [get_ports dma_rx_req]
set_output_delay -max [expr $pclk_period * 0.7] -clock PCLK [get_ports dma_tx_req]
set_output_delay -max [expr $pclk_period * 0.7] -clock PCLK [get_ports prdata*]

set_output_delay -max [expr $pclk_period * 0.7] -clock PCLK [get_ports uart_dtrn]
set_output_delay -max [expr $pclk_period * 0.7] -clock PCLK [get_ports uart_intr]
set_output_delay -max [expr $pclk_period * 0.7] -clock PCLK [get_ports uart_out1n]
set_output_delay -max [expr $pclk_period * 0.7] -clock PCLK [get_ports uart_out2n]
set_output_delay -max [expr $pclk_period * 0.7] -clock PCLK [get_ports uart_rtsn]

if {$uclk_pclk_same} {
	set_output_delay -max [expr $uclk_period * 0.7] -clock PCLK [get_ports uart_sout]
} else {
	set_output_delay -max [expr $uclk_period * 0.7] -clock UCLK [get_ports uart_sout]
}


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
if {$uclk_pclk_same} {
} else {
	set_false_path -from [get_clocks PCLK] -to [get_clocks UCLK]
	set_false_path -from [get_clocks UCLK] -to [get_clocks PCLK]
}

# Specify Multi-Cycle Paths
set_multicycle_path 2 -setup -from [get_ports paddr*] -to [get_ports prdata*]
set_multicycle_path 1 -hold -from [get_ports paddr*] -to [get_ports prdata*]
set_multicycle_path 2 -setup -from [get_ports psel] -to [get_ports prdata*]
set_multicycle_path 1 -hold -from [get_ports psel] -to [get_ports prdata*]
set_multicycle_path 2 -setup -from [get_ports pwrite] -to [get_ports prdata*]
set_multicycle_path 1 -hold -from [get_ports pwrite] -to [get_ports prdata*]

# Specify Path Delays


