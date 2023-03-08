
if {![info exists env(pclk_period)]} {
	set pclk_period 20.0
} else {
	set pclk_period $env(pclk_period)
}

if {![info exists env(rtc_clk_period)]} {
	set rtc_clk_period 30517.6
} else {
	set rtc_clk_period $env(rtc_clk_period)
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

create_clock -name RTC_CLK -period $rtc_clk_period \
   -waveform [list 0 [expr $rtc_clk_period / 2.0]] [get_ports rtc_clk]

# Specify Clock Skew
set_clock_uncertainty -setup $clock_uncertainty [all_clocks]

# Specify Clock Transition
set_clock_transition $clock_transition [all_clocks]


# -------------------------------------------------------------
# Define Input and Output Delays
# -------------------------------------------------------------
# Set Input Delays
set_input_delay -max [expr $pclk_period * 0.7] -clock PCLK [get_ports presetn]
set_input_delay -max [expr $pclk_period * 0.7] -clock PCLK [get_ports psel]
set_input_delay -max [expr $pclk_period * 0.7] -clock PCLK [get_ports penable]
set_input_delay -max [expr $pclk_period * 0.7] -clock PCLK [get_ports paddr*]
set_input_delay -max [expr $pclk_period * 0.7] -clock PCLK [get_ports pwrite]
set_input_delay -max [expr $pclk_period * 0.7] -clock PCLK [get_ports pwdata*]

set_input_delay -max [expr $rtc_clk_period * 0.7] -clock RTC_CLK [get_ports rtc_rstn]

# Set Output Delays
set_output_delay -max [expr $pclk_period * 0.7] -clock PCLK [get_ports prdata*]
set_output_delay -max [expr $pclk_period * 0.7] -clock PCLK [get_ports rtc_int_hsec]
set_output_delay -max [expr $pclk_period * 0.7] -clock PCLK [get_ports rtc_int_sec]
set_output_delay -max [expr $pclk_period * 0.7] -clock PCLK [get_ports rtc_int_min]
set_output_delay -max [expr $pclk_period * 0.7] -clock PCLK [get_ports rtc_int_hour]
set_output_delay -max [expr $pclk_period * 0.7] -clock PCLK [get_ports rtc_int_day]
set_output_delay -max [expr $pclk_period * 0.7] -clock PCLK [get_ports rtc_int_alarm]

set_output_delay -max [expr $rtc_clk_period * 0.7] -clock RTC_CLK [get_ports alarm_wakeup]
set_output_delay -max [expr $rtc_clk_period * 0.7] -clock RTC_CLK [get_ports freq_test_en]
set_output_delay -max [expr $rtc_clk_period * 0.7] -clock RTC_CLK [get_ports freq_test_out]

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
set_false_path -from [get_clocks "PCLK"] -to [get_clocks "RTC_CLK"]
set_false_path -from [get_clocks "RTC_CLK"] -to [get_clocks "PCLK"]

# Specify Multi-Cycle Paths

# Specify Path Delays


