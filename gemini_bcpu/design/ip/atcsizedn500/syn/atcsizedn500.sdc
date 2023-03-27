if {![info exists env(clk_period)]} {
	set clk_period 20.0
} else {
	set clk_period $env(clk_period)
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
create_clock -name CLK -period $clk_period \
	-waveform [list 0 [expr $clk_period / 2.0]] [get_ports clk]

# Specify Clock Skew
set_clock_uncertainty -setup $clock_uncertainty [all_clocks]

# Specify Clock Transition
set_clock_transition $clock_transition [all_clocks]


# -------------------------------------------------------------
# Define Input and Output Delays
# -------------------------------------------------------------
# Set Input Delays
	set input_delay_ratio 0.6 
	set_input_delay -max [expr ($clk_period - $clock_uncertainty) * $input_delay_ratio] -clock CLK [get_ports resetn]
	set_input_delay -max [expr ($clk_period - $clock_uncertainty) * $input_delay_ratio] -clock CLK [get_ports us_a_address]
	set_input_delay -max [expr ($clk_period - $clock_uncertainty) * $input_delay_ratio] -clock CLK [get_ports us_a_opcode]
	set_input_delay -max [expr ($clk_period - $clock_uncertainty) * $input_delay_ratio] -clock CLK [get_ports us_a_param]
	set_input_delay -max [expr ($clk_period - $clock_uncertainty) * $input_delay_ratio] -clock CLK [get_ports us_a_user]
	set_input_delay -max [expr ($clk_period - $clock_uncertainty) * $input_delay_ratio] -clock CLK [get_ports us_a_corrupt]
	set_input_delay -max [expr ($clk_period - $clock_uncertainty) * $input_delay_ratio] -clock CLK [get_ports us_a_mask]
	set_input_delay -max [expr ($clk_period - $clock_uncertainty) * $input_delay_ratio] -clock CLK [get_ports us_a_data]
	set_input_delay -max [expr ($clk_period - $clock_uncertainty) * $input_delay_ratio] -clock CLK [get_ports us_a_source]
	set_input_delay -max [expr ($clk_period - $clock_uncertainty) * $input_delay_ratio] -clock CLK [get_ports us_a_size]
	set_input_delay -max [expr ($clk_period - $clock_uncertainty) * $input_delay_ratio] -clock CLK [get_ports us_a_valid]

	set_input_delay -max [expr ($clk_period - $clock_uncertainty) * $input_delay_ratio] -clock CLK [get_ports us_c_address]
	set_input_delay -max [expr ($clk_period - $clock_uncertainty) * $input_delay_ratio] -clock CLK [get_ports us_c_opcode]
	set_input_delay -max [expr ($clk_period - $clock_uncertainty) * $input_delay_ratio] -clock CLK [get_ports us_c_param]
	set_input_delay -max [expr ($clk_period - $clock_uncertainty) * $input_delay_ratio] -clock CLK [get_ports us_c_user]
	set_input_delay -max [expr ($clk_period - $clock_uncertainty) * $input_delay_ratio] -clock CLK [get_ports us_c_corrupt]
	set_input_delay -max [expr ($clk_period - $clock_uncertainty) * $input_delay_ratio] -clock CLK [get_ports us_c_data]
	set_input_delay -max [expr ($clk_period - $clock_uncertainty) * $input_delay_ratio] -clock CLK [get_ports us_c_source]
	set_input_delay -max [expr ($clk_period - $clock_uncertainty) * $input_delay_ratio] -clock CLK [get_ports us_c_size]
	set_input_delay -max [expr ($clk_period - $clock_uncertainty) * $input_delay_ratio] -clock CLK [get_ports us_c_valid]
	
	set_input_delay -max [expr ($clk_period - $clock_uncertainty) * $input_delay_ratio] -clock CLK [get_ports us_d_ready]

	set_input_delay -max [expr ($clk_period - $clock_uncertainty) * $input_delay_ratio] -clock CLK [get_ports us_e_user]
	set_input_delay -max [expr ($clk_period - $clock_uncertainty) * $input_delay_ratio] -clock CLK [get_ports us_e_sink]
	set_input_delay -max [expr ($clk_period - $clock_uncertainty) * $input_delay_ratio] -clock CLK [get_ports us_e_valid]

	set_input_delay -max [expr ($clk_period - $clock_uncertainty) * $input_delay_ratio] -clock CLK [get_ports ds_a_ready]
	set_input_delay -max [expr ($clk_period - $clock_uncertainty) * $input_delay_ratio] -clock CLK [get_ports ds_c_ready]

	set_input_delay -max [expr ($clk_period - $clock_uncertainty) * $input_delay_ratio] -clock CLK [get_ports ds_b_address]
	set_input_delay -max [expr ($clk_period - $clock_uncertainty) * $input_delay_ratio] -clock CLK [get_ports ds_b_opcode]
	set_input_delay -max [expr ($clk_period - $clock_uncertainty) * $input_delay_ratio] -clock CLK [get_ports ds_b_param]
	set_input_delay -max [expr ($clk_period - $clock_uncertainty) * $input_delay_ratio] -clock CLK [get_ports ds_b_user]
	set_input_delay -max [expr ($clk_period - $clock_uncertainty) * $input_delay_ratio] -clock CLK [get_ports ds_b_corrupt]
	set_input_delay -max [expr ($clk_period - $clock_uncertainty) * $input_delay_ratio] -clock CLK [get_ports ds_b_mask]
	set_input_delay -max [expr ($clk_period - $clock_uncertainty) * $input_delay_ratio] -clock CLK [get_ports ds_b_data]
	set_input_delay -max [expr ($clk_period - $clock_uncertainty) * $input_delay_ratio] -clock CLK [get_ports ds_b_source]
	set_input_delay -max [expr ($clk_period - $clock_uncertainty) * $input_delay_ratio] -clock CLK [get_ports ds_b_size]
	set_input_delay -max [expr ($clk_period - $clock_uncertainty) * $input_delay_ratio] -clock CLK [get_ports ds_b_valid]

	set_input_delay -max [expr ($clk_period - $clock_uncertainty) * $input_delay_ratio] -clock CLK [get_ports ds_d_opcode]
	set_input_delay -max [expr ($clk_period - $clock_uncertainty) * $input_delay_ratio] -clock CLK [get_ports ds_d_param]
	set_input_delay -max [expr ($clk_period - $clock_uncertainty) * $input_delay_ratio] -clock CLK [get_ports ds_d_user]
	set_input_delay -max [expr ($clk_period - $clock_uncertainty) * $input_delay_ratio] -clock CLK [get_ports ds_d_corrupt]
	set_input_delay -max [expr ($clk_period - $clock_uncertainty) * $input_delay_ratio] -clock CLK [get_ports ds_d_denied]
	set_input_delay -max [expr ($clk_period - $clock_uncertainty) * $input_delay_ratio] -clock CLK [get_ports ds_d_data]
	set_input_delay -max [expr ($clk_period - $clock_uncertainty) * $input_delay_ratio] -clock CLK [get_ports ds_d_source]
	set_input_delay -max [expr ($clk_period - $clock_uncertainty) * $input_delay_ratio] -clock CLK [get_ports ds_d_sink]
	set_input_delay -max [expr ($clk_period - $clock_uncertainty) * $input_delay_ratio] -clock CLK [get_ports ds_d_size]
	set_input_delay -max [expr ($clk_period - $clock_uncertainty) * $input_delay_ratio] -clock CLK [get_ports ds_d_valid]
# Set Output Delays
	set output_delay_ratio 0.70
	set_output_delay -max [expr ($clk_period - $clock_uncertainty) * $output_delay_ratio] -clock CLK [get_ports ds_a_address]
	set_output_delay -max [expr ($clk_period - $clock_uncertainty) * $output_delay_ratio] -clock CLK [get_ports ds_a_opcode]
	set_output_delay -max [expr ($clk_period - $clock_uncertainty) * $output_delay_ratio] -clock CLK [get_ports ds_a_param]
	set_output_delay -max [expr ($clk_period - $clock_uncertainty) * $output_delay_ratio] -clock CLK [get_ports ds_a_user]
	set_output_delay -max [expr ($clk_period - $clock_uncertainty) * $output_delay_ratio] -clock CLK [get_ports ds_a_corrupt]
	set_output_delay -max [expr ($clk_period - $clock_uncertainty) * $output_delay_ratio] -clock CLK [get_ports ds_a_mask]
	set_output_delay -max [expr ($clk_period - $clock_uncertainty) * $output_delay_ratio] -clock CLK [get_ports ds_a_data]
	set_output_delay -max [expr ($clk_period - $clock_uncertainty) * $output_delay_ratio] -clock CLK [get_ports ds_a_source]
	set_output_delay -max [expr ($clk_period - $clock_uncertainty) * $output_delay_ratio] -clock CLK [get_ports ds_a_size]
	set_output_delay -max [expr ($clk_period - $clock_uncertainty) * $output_delay_ratio] -clock CLK [get_ports ds_a_valid]

	set_output_delay -max [expr ($clk_period - $clock_uncertainty) * $output_delay_ratio] -clock CLK [get_ports ds_c_address]
	set_output_delay -max [expr ($clk_period - $clock_uncertainty) * $output_delay_ratio] -clock CLK [get_ports ds_c_opcode]
	set_output_delay -max [expr ($clk_period - $clock_uncertainty) * $output_delay_ratio] -clock CLK [get_ports ds_c_param]
	set_output_delay -max [expr ($clk_period - $clock_uncertainty) * $output_delay_ratio] -clock CLK [get_ports ds_c_user]
	set_output_delay -max [expr ($clk_period - $clock_uncertainty) * $output_delay_ratio] -clock CLK [get_ports ds_c_corrupt]
	set_output_delay -max [expr ($clk_period - $clock_uncertainty) * $output_delay_ratio] -clock CLK [get_ports ds_c_data]
	set_output_delay -max [expr ($clk_period - $clock_uncertainty) * $output_delay_ratio] -clock CLK [get_ports ds_c_source]
	set_output_delay -max [expr ($clk_period - $clock_uncertainty) * $output_delay_ratio] -clock CLK [get_ports ds_c_size]
	set_output_delay -max [expr ($clk_period - $clock_uncertainty) * $output_delay_ratio] -clock CLK [get_ports ds_c_valid]
	
	set_output_delay -max [expr ($clk_period - $clock_uncertainty) * $output_delay_ratio] -clock CLK [get_ports ds_d_ready]

	set_output_delay -max [expr ($clk_period - $clock_uncertainty) * $output_delay_ratio] -clock CLK [get_ports ds_e_user]
	set_output_delay -max [expr ($clk_period - $clock_uncertainty) * $output_delay_ratio] -clock CLK [get_ports ds_e_sink]
	set_output_delay -max [expr ($clk_period - $clock_uncertainty) * $output_delay_ratio] -clock CLK [get_ports ds_e_valid]

	set_output_delay -max [expr ($clk_period - $clock_uncertainty) * $output_delay_ratio] -clock CLK [get_ports us_a_ready]
	set_output_delay -max [expr ($clk_period - $clock_uncertainty) * $output_delay_ratio] -clock CLK [get_ports us_c_ready]

	set_output_delay -max [expr ($clk_period - $clock_uncertainty) * $output_delay_ratio] -clock CLK [get_ports us_b_address]
	set_output_delay -max [expr ($clk_period - $clock_uncertainty) * $output_delay_ratio] -clock CLK [get_ports us_b_opcode]
	set_output_delay -max [expr ($clk_period - $clock_uncertainty) * $output_delay_ratio] -clock CLK [get_ports us_b_param]
	set_output_delay -max [expr ($clk_period - $clock_uncertainty) * $output_delay_ratio] -clock CLK [get_ports us_b_user]
	set_output_delay -max [expr ($clk_period - $clock_uncertainty) * $output_delay_ratio] -clock CLK [get_ports us_b_corrupt]
	set_output_delay -max [expr ($clk_period - $clock_uncertainty) * $output_delay_ratio] -clock CLK [get_ports us_b_mask]
	set_output_delay -max [expr ($clk_period - $clock_uncertainty) * $output_delay_ratio] -clock CLK [get_ports us_b_data]
	set_output_delay -max [expr ($clk_period - $clock_uncertainty) * $output_delay_ratio] -clock CLK [get_ports us_b_source]
	set_output_delay -max [expr ($clk_period - $clock_uncertainty) * $output_delay_ratio] -clock CLK [get_ports us_b_size]
	set_output_delay -max [expr ($clk_period - $clock_uncertainty) * $output_delay_ratio] -clock CLK [get_ports us_b_valid]

	set_output_delay -max [expr ($clk_period - $clock_uncertainty) * $output_delay_ratio] -clock CLK [get_ports us_d_opcode]
	set_output_delay -max [expr ($clk_period - $clock_uncertainty) * $output_delay_ratio] -clock CLK [get_ports us_d_param]
	set_output_delay -max [expr ($clk_period - $clock_uncertainty) * $output_delay_ratio] -clock CLK [get_ports us_d_user]
	set_output_delay -max [expr ($clk_period - $clock_uncertainty) * $output_delay_ratio] -clock CLK [get_ports us_d_corrupt]
	set_output_delay -max [expr ($clk_period - $clock_uncertainty) * $output_delay_ratio] -clock CLK [get_ports us_d_denied]
	set_output_delay -max [expr ($clk_period - $clock_uncertainty) * $output_delay_ratio] -clock CLK [get_ports us_d_data]
	set_output_delay -max [expr ($clk_period - $clock_uncertainty) * $output_delay_ratio] -clock CLK [get_ports us_d_source]
	set_output_delay -max [expr ($clk_period - $clock_uncertainty) * $output_delay_ratio] -clock CLK [get_ports us_d_sink]
	set_output_delay -max [expr ($clk_period - $clock_uncertainty) * $output_delay_ratio] -clock CLK [get_ports us_d_size]
	set_output_delay -max [expr ($clk_period - $clock_uncertainty) * $output_delay_ratio] -clock CLK [get_ports us_d_valid]

    set_max_delay [expr (($clk_period - $clock_uncertainty) * ($input_delay_ratio + $output_delay_ratio)) + ($clk_period * 0.15) + $clock_uncertainty] \
                                                -from [get_ports us_a_valid]    -to       [get_ports ds_a_valid]
    set_max_delay [expr (($clk_period - $clock_uncertainty) * ($input_delay_ratio + $output_delay_ratio)) + ($clk_period * 0.15) + $clock_uncertainty] \
						-from [get_ports us_a_address]  -to       [get_ports ds_a_address]
    set_max_delay [expr (($clk_period - $clock_uncertainty) * ($input_delay_ratio + $output_delay_ratio)) + ($clk_period * 0.15) + $clock_uncertainty] \
                                                -from [get_ports us_a_opcode]   -to       [get_ports ds_a_opcode]
    set_max_delay [expr (($clk_period - $clock_uncertainty) * ($input_delay_ratio + $output_delay_ratio)) + ($clk_period * 0.15) + $clock_uncertainty] \
                                                -from [get_ports us_a_param]    -to       [get_ports ds_a_param]
    set_max_delay [expr (($clk_period - $clock_uncertainty) * ($input_delay_ratio + $output_delay_ratio)) + ($clk_period * 0.15) + $clock_uncertainty] \
                                                -from [get_ports us_a_user]     -to       [get_ports ds_a_user]
    set_max_delay [expr (($clk_period - $clock_uncertainty) * ($input_delay_ratio + $output_delay_ratio)) + ($clk_period * 0.15) + $clock_uncertainty] \
                                                -from [get_ports us_a_corrupt]  -to       [get_ports ds_a_corrupt]
    set_max_delay [expr (($clk_period - $clock_uncertainty) * ($input_delay_ratio + $output_delay_ratio)) + ($clk_period * 0.15) + $clock_uncertainty] \
                                                -from [list [get_ports us_a_mask]    \
							    [get_ports us_a_address] \
							    [get_ports us_a_valid]   \
							    [get_ports us_a_source]] \
										-to       [get_ports ds_a_mask]
    set_max_delay [expr (($clk_period - $clock_uncertainty) * ($input_delay_ratio + $output_delay_ratio)) + ($clk_period * 0.15) + $clock_uncertainty] \
                                                -from [list [get_ports us_a_data]    \
							    [get_ports us_a_address] \
							    [get_ports us_a_valid]   \
							    [get_ports us_a_source]] \
										-to       [get_ports ds_a_data]
    set_max_delay [expr (($clk_period - $clock_uncertainty) * ($input_delay_ratio + $output_delay_ratio)) + ($clk_period * 0.15) + $clock_uncertainty] \
                                                -from [get_ports us_a_source]   -to [list [get_ports ds_a_source] [get_ports us_a_ready]]
    set_max_delay [expr (($clk_period - $clock_uncertainty) * ($input_delay_ratio + $output_delay_ratio)) + ($clk_period * 0.15) + $clock_uncertainty] \
                                                -from [get_ports us_a_size]     -to       [get_ports ds_a_size]


    set_max_delay [expr (($clk_period - $clock_uncertainty) * ($input_delay_ratio + $output_delay_ratio)) + ($clk_period * 0.15) + $clock_uncertainty] \
                                                -from [get_ports us_c_valid]    -to       [get_ports ds_c_valid]
    set_max_delay [expr (($clk_period - $clock_uncertainty) * ($input_delay_ratio + $output_delay_ratio)) + ($clk_period * 0.15) + $clock_uncertainty] \
						-from [get_ports us_c_address]  -to       [get_ports ds_c_address]
    set_max_delay [expr (($clk_period - $clock_uncertainty) * ($input_delay_ratio + $output_delay_ratio)) + ($clk_period * 0.15) + $clock_uncertainty] \
                                                -from [get_ports us_c_opcode]   -to       [get_ports ds_c_opcode]
    set_max_delay [expr (($clk_period - $clock_uncertainty) * ($input_delay_ratio + $output_delay_ratio)) + ($clk_period * 0.15) + $clock_uncertainty] \
                                                -from [get_ports us_c_param]    -to       [get_ports ds_c_param]
    set_max_delay [expr (($clk_period - $clock_uncertainty) * ($input_delay_ratio + $output_delay_ratio)) + ($clk_period * 0.15) + $clock_uncertainty] \
                                                -from [get_ports us_c_user]     -to       [get_ports ds_c_user]
    set_max_delay [expr (($clk_period - $clock_uncertainty) * ($input_delay_ratio + $output_delay_ratio)) + ($clk_period * 0.15) + $clock_uncertainty] \
                                                -from [get_ports us_c_corrupt]  -to       [get_ports ds_c_corrupt]
    set_max_delay [expr (($clk_period - $clock_uncertainty) * ($input_delay_ratio + $output_delay_ratio)) + ($clk_period * 0.15) + $clock_uncertainty] \
                                                -from [list [get_ports us_c_data]    \
							    [get_ports us_c_opcode] \
							    [get_ports us_c_address] \
							    [get_ports us_c_valid]   \
							    [get_ports us_c_source]] \
										-to       [get_ports ds_c_data]
    set_max_delay [expr (($clk_period - $clock_uncertainty) * ($input_delay_ratio + $output_delay_ratio)) + ($clk_period * 0.15) + $clock_uncertainty] \
                                                -from [get_ports us_c_source]   -to       [get_ports ds_c_source]
    set_max_delay [expr (($clk_period - $clock_uncertainty) * ($input_delay_ratio + $output_delay_ratio)) + ($clk_period * 0.15) + $clock_uncertainty] \
                                                -from [get_ports us_c_size]     -to       [get_ports ds_c_size]
    set_max_delay [expr (($clk_period - $clock_uncertainty) * ($input_delay_ratio + $output_delay_ratio)) + ($clk_period * 0.15) + $clock_uncertainty] \
                                                -from [list [get_ports us_c_opcode] \
							    [get_ports us_c_source]] \
										-to        [get_ports us_c_ready]


    set_max_delay [expr (($clk_period - $clock_uncertainty) * ($input_delay_ratio + $output_delay_ratio)) + ($clk_period * 0.15) + $clock_uncertainty] \
                                                -from                               [get_ports us_d_ready]     -to       [get_ports ds_d_ready]
    set_max_delay [expr (($clk_period - $clock_uncertainty) * ($input_delay_ratio + $output_delay_ratio)) + ($clk_period * 0.15) + $clock_uncertainty] \
                                                -from [list [get_ports ds_b_source] [get_ports us_b_ready]]    -to       [get_ports ds_b_ready]
    set_max_delay [expr (($clk_period - $clock_uncertainty) * ($input_delay_ratio + $output_delay_ratio)) + ($clk_period * 0.15) + $clock_uncertainty] \
                                                -from [get_ports us_e_sink]     -to       [get_ports ds_e_sink]
    set_max_delay [expr (($clk_period - $clock_uncertainty) * ($input_delay_ratio + $output_delay_ratio)) + ($clk_period * 0.15) + $clock_uncertainty] \
                                                -from [get_ports us_e_user]     -to       [get_ports ds_e_user]
    set_max_delay [expr (($clk_period - $clock_uncertainty) * ($input_delay_ratio + $output_delay_ratio)) + ($clk_period * 0.15) + $clock_uncertainty] \
                                                -from [get_ports us_e_valid]    -to       [get_ports ds_e_valid]
    set_max_delay [expr (($clk_period - $clock_uncertainty) * ($input_delay_ratio + $output_delay_ratio)) + ($clk_period * 0.15) + $clock_uncertainty] \
                                                -from [get_ports ds_e_ready]    -to       [get_ports us_e_ready]

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


