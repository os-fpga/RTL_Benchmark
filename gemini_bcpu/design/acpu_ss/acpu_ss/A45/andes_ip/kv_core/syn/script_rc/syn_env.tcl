### Synthesis Environment Setting ###

set NDS_HOME $env(NDS_HOME)

### Parse Config
source $NDS_HOME/andes_ip/kv_core/syn/script_rc/parseConfig.tcl
parseConfig config.inc

if {[string equal $NDS_MULTIPLIER "fast"]} {
	set fastmul_support 1
} else {
	set fastmul_support 0
}

# machine timer support
set machine_timer_support 1

### Specify the core Core hierarchy in SOC_HIER
set SOC_HIER ""

set TOP_MODULE ${SOC_HIER}

if {[info exists root_design] && [string equal $root_design "kv_core_top"]} {
    set CORE_MODULE ${TOP_MODULE}a45_core/kv_core
} else {
    set CORE_MODULE ${TOP_MODULE}u_kv_core_top*/a45_core/kv_core
}

set IPIPE_MODULE	${CORE_MODULE}/kv_ipipe
set IFU_MODULE		${CORE_MODULE}/kv_ifu
set LSU_MODULE		${CORE_MODULE}/kv_lsu
set FASTMUL_MODULE	${CORE_MODULE}/kv_fastmul
set BIU_MODULE		${CORE_MODULE}/kv_biu
set FPU_MODULE		${CORE_MODULE}/*kv_fpu
