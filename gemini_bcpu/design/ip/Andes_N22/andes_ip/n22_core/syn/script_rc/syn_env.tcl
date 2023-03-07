set NDS_HOME $env(NDS_HOME)
source $NDS_HOME/andes_ip/n22_core/syn/script_rc/parseConfig.tcl
parseConfig $NDS_HOME/andes_ip/n22_core/top/hdl/config.inc

if {[string equal $NDS_MULTIPLIER "fast"]} {
	set fastmul_support 1
} else {
	set fastmul_support 0
}

# Debug Module Support
set debug_module_support 1

# machine timer support
set machine_timer_support 1

