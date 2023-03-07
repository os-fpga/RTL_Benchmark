### Synthesis Environment Setting ###

set NDS_HOME $env(NDS_HOME)

### Parse Config
source $NDS_HOME/andes_ip/n22_core/syn/script/parseConfig.tcl
parseConfig $NDS_HOME/andes_ip/n22_core/top/hdl/config.inc

# Debug Module Support
set debug_module_support 1

# machine timer support
set machine_timer_support 1

