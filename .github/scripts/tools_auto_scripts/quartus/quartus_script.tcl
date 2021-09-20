# = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
# Script Name   : Quartus.tcl
# Description   : This script designed to run Quartus PAR flow
# = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
set need_to_close_project 0
set project_exist 0

# Check that the right project is open
project_new -overwrite -revision $::env(PROJECT_NAME) $::env(PROJECT_NAME)

# Make assignments
set_global_assignment -name NUM_PARALLEL_PROCESSORS 8	
set_global_assignment -name FAMILY $::env(QUARTUS_FAMILY)
set_global_assignment -name DEVICE $::env(QUARTUS_ARCH)
set_global_assignment -name ORIGINAL_QUARTUS_VERSION 18.1.0
set_global_assignment -name SDC_FILE $::env(QUARTUS_SDC_GEN)
set_global_assignment -name TOP_LEVEL_ENTITY $::env(DESIGN_TOP)
foreach verilog_header_file [glob -nocomplain -directory "$::env(CGA_ROOT)/$::env(DESIGN_DIR)" "*.vh"] {
set_global_assignment -name VERILOG_FILE $verilog_header_file
}
foreach sverilog_header_file [glob -nocomplain -directory "$::env(CGA_ROOT)/$::env(DESIGN_DIR)" "*.svh"] {
set_global_assignment -name SYSTEMVERILOG_FILE $sverilog_header_file
}
foreach verilog_file [glob -nocomplain -directory "$::env(CGA_ROOT)/$::env(DESIGN_DIR)" "*.v"] {
set_global_assignment -name VERILOG_FILE $verilog_file
}
foreach sverilog_file [glob -nocomplain -directory "$::env(CGA_ROOT)/$::env(DESIGN_DIR)" "*.sv"] {
set_global_assignment -name SYSTEMVERILOG_FILE $sverilog_file
}
if {$::env(STRATEGY)=="performance"} {
set_global_assignment -name OPTIMIZATION_MODE "AGGRESSIVE PERFORMANCE"    
} elseif {$::env(STRATEGY)=="area"} {
set_global_assignment -name OPTIMIZATION_MODE "AGGRESSIVE AREA"    
}
set_global_assignment -name PROJECT_OUTPUT_DIRECTORY $::env(QUARTUS_GEN_LOG_PATH)
set_global_assignment -name MIN_CORE_JUNCTION_TEMP "-40"
set_global_assignment -name MAX_CORE_JUNCTION_TEMP 100
set_global_assignment -name ERROR_CHECK_FREQUENCY_DIVISOR 256
set_global_assignment -name EDA_SIMULATION_TOOL "ModelSim-Altera (Verilog)"
set_global_assignment -name EDA_TIME_SCALE "1 ps" -section_id eda_simulation
set_global_assignment -name EDA_OUTPUT_DATA_FORMAT "VERILOG HDL" -section_id eda_simulation

# Commit assignments
export_assignments

load_package flow
execute_flow -compile
	

