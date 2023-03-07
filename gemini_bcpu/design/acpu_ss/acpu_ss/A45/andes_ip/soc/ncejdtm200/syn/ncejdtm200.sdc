if {![info exists env(hclk_period)]} {
        set hclk_period 10.0
} else {
        set hclk_period $env(hclk_period)
}

if {![info exists env(jdtm_clk_period)]} {
        set jdtm_clk_period 33.0
} else {
        set jdtm_clk_period $env(jdtm_clk_period)
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
create_clock -name TCK [get_ports tck]  -period [expr $jdtm_clk_period]

create_clock -name HCLK -period $hclk_period \
   -waveform [list 0 [expr $hclk_period / 2.0]] [get_ports dmi_hclk]

# Specify Clock Skew
set_clock_uncertainty -setup $clock_uncertainty [all_clocks]

# Specify Clock Transition
set_clock_transition $clock_transition [all_clocks]


# -------------------------------------------------------------
# Define Input and Output Delays
# -------------------------------------------------------------
# Set Input Delays
set_input_delay -max [expr $jdtm_clk_period * 2/3] -clock TCK [get_ports test_mode]
set_input_delay -max [expr $jdtm_clk_period * 2/3] -clock TCK [get_ports pwr_rst_n]
set_input_delay -max [expr $jdtm_clk_period * 2/3] -clock TCK [get_ports tms]
set_input_delay -max [expr $jdtm_clk_period * 2/3] -clock TCK [get_ports tdi]

set_input_delay -max [expr $hclk_period * 0.7] -clock HCLK [get_ports dmi_hrdata*]
set_input_delay -max [expr $hclk_period * 0.7] -clock HCLK [get_ports dmi_hready]
set_input_delay -max [expr $hclk_period * 0.7] -clock HCLK [get_ports dmi_hresp]

# Set Output Delays
set_output_delay -max [expr $jdtm_clk_period * 1/3] -clock TCK [get_ports dbg_wakeup_req]
set_output_delay -max [expr $jdtm_clk_period * 1/3] -clock TCK [get_ports tms_out_en]
set_output_delay -max [expr $jdtm_clk_period * 1/3] -clock TCK [get_ports tdo]

set_output_delay -max [expr $hclk_period * 0.7] -clock HCLK [get_ports dmi_hresetn]
set_output_delay -max [expr $hclk_period * 0.7] -clock HCLK [get_ports dmi_hsel]
set_output_delay -max [expr $hclk_period * 0.7] -clock HCLK [get_ports dmi_htrans*]
set_output_delay -max [expr $hclk_period * 0.7] -clock HCLK [get_ports dmi_haddr*]
set_output_delay -max [expr $hclk_period * 0.7] -clock HCLK [get_ports dmi_hsize*]
set_output_delay -max [expr $hclk_period * 0.7] -clock HCLK [get_ports dmi_hburst*]
set_output_delay -max [expr $hclk_period * 0.7] -clock HCLK [get_ports dmi_hprot*]
set_output_delay -max [expr $hclk_period * 0.7] -clock HCLK [get_ports dmi_hwdata*]
set_output_delay -max [expr $hclk_period * 0.7] -clock HCLK [get_ports dmi_hwrite*]


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
set_false_path -from [get_clocks "HCLK"] -to [get_clocks "TCK"]
set_false_path -from [get_clocks "TCK"]  -to [get_clocks "HCLK"]

# Specify Multi-Cycle Paths

# Specify Path Delays


