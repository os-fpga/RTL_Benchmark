
tclmode

##########################################
# Reference script for Cadence Conformal #
##########################################

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


# -----------------------
# IP/Environment settings
# -----------------------
source "$script_path/ip_env.tcl"


# -----------------------
# Formal checker settings
# -----------------------
source "$script_path/formal_setup_lec.tcl"

set_log_file lec.log -replace
set_dofile_abort exit


# ---------------------------
# Read the technology library
# ---------------------------
read_library -both -sensitive $lib_model -append


# ---------------------------------------------------------------------
# Notranslate rules ask Conformal to read these modules as black boxes.
# This is to skip non-synthesisable behavior codes in the library.
# ---------------------------------------------------------------------
set non_trans_m ""

if {$mem_model != ""} {
	foreach file_name [glob -type f $mem_model] {
		set fh_r [open $file_name r]
		while {![eof $fh_r]} {
			set line [gets $fh_r]
			if {[regexp {module \s*(\w+)} $line match module_name]} {
				set non_trans_m "$non_trans_m $module_name"
				break
			}
		}
		close $fh_r 
	}

	add_notranslate_modules $non_trans_m -library -both
	read_library -both -sensitive $mem_model -append
}



# ----------------------
# Read the golden design
# ----------------------
source "$ip_top/syn/flist.tcl"

# Prepare the include path
add_search_path $env(ip_def_search_path) -design -golden

if {[info exists incdir]} {
	add_search_path [join $incdir " "] -design -golden
}

if {[file exists "$ip_top/hdl"]} {
	add_search_path "$ip_top/hdl" -design -golden

	if {[file exists "$ip_top/hdl/include"]} {
		add_search_path "$ip_top/hdl/include" -design -golden
	}
}

# Prepare the macro definitions
if {[info exists syn_define]} {
	set syn_define [join [split "$syn_define" " +"] " -define "]
	set syn_define "-define $syn_define"
} else {
	set syn_define ""
}

# Load the clock-gating cell
if {[info exists load_gck_cell]} {
	if {[file exists "gck_autogen.v"]} {
		read_design -verilog2k "gck_autogen.v" -sensitive -golden $syn_define -noelaborate
	} else {
		read_design -verilog2k "$NDS_HOME/andes_ip/macro/gck.v" -sensitive -golden $syn_define -noelaborate
	}
}

# Load the sub-modules
if {[info exists sub_module_netlist]} {
	foreach sub_design $sub_module_netlist {
		if {[file exists "$ip_database/$sub_design.vg"]} {
			read_design -verilog2k "$ip_database/${sub_design}.vg" -sensitive -golden $syn_define -append -noelaborate
		}
	}
}

# Load the RTL
read_design -verilog2k [join $hdl_file_list " "] -sensitive -golden $syn_define -append



# -----------------------
# Read the revised design
# -----------------------
read_design -verilog netlist/$design_name.vg -sensitive -revised


set_root_module $design_name -both


# -----------------
# Conformal options
# -----------------
set_undriven_signal 0 -both
set_flatten_model -nodff_to_dlat_feedback -seq_constant -gated_clock -seq_constant_x_to 0 -enable_analyze_hier_compare
set_multiplier_option -auto -cdp_info -verbose


set_system_mode lec


remodel -seq_constant -seq_constant_feedback -repeat
analyze_datapath -eff high -quality 30 -verbose
analyze_setup -verbose

add_compared_points -all
compare
analyze_abort -compare


# ----------------
# Generate reports
# ----------------
report_compare_data -class abort nonequivalent	>  $report_path/lec_compare.rpt
report_unmapped_point				>  $report_path/lec_unmapped.rpt
diagnose -noneq					>  $report_path/lec_diagnose.rpt
report_black_box -detail			>  $report_path/lec_bbox.rpt


exit
