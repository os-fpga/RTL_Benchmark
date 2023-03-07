
#######################################################
# Reference synthesis script for Cadence RTL Compiler #
#######################################################

if {![info exists env(NDS_HOME)]} {
	puts "ERROR! Environment variable \"NDS_HOME\" must be defined before synthesis."
	exit 1
}

set NDS_HOME $env(NDS_HOME)


# Get the design name from the environment setting
if {![info exists env(DESIGN_NAME)]} {
	puts "ERROR! Environment variable \"DESIGN_NAME\" must be defined before synthesis."
	exit 2
}

set design_name $env(DESIGN_NAME)


# Set the search path of TCL scripts
if {![info exists env(SCRIPT_PATH)]} {
	puts "ERROR! Environment variable \"SCRIPT_PATH\" must be defined before synthesis."
	exit 3
}

set script_path $env(SCRIPT_PATH)


# IP/Environment settings
source "$script_path/ip_env.tcl"


# Synthesizer-dependent settings
source "$script_path/syn_setup_genus.tcl"


# Clean up the report/output directories
file delete -force $report_path $output_path
file mkdir $report_path $output_path


# Generic synthesis flow for Cadence RTL Compiler
source "$script_path/syn_run_genus.tcl"

if {![file exists $ip_database]} {
	file mkdir $ip_database
}

file copy -force "$output_path/$design_name.vg" "$ip_database/$design_name.vg"
file copy -force "$output_path/$design_name.sdc" "$ip_database/$design_name.sdc"

# Exiting the Synthesizer
puts "============================"
puts "Synthesis Finished ........."
puts "============================"
quit

