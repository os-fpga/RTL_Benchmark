### Read cpu core rtl ###
define_design_lib nds_core -path ./work

set RTL_PATH       $env(NDS_HOME)/andes_ip/n22_core
set CFG_PATH       $RTL_PATH/top/hdl
set MACRO_PATH     $env(NDS_HOME)/andes_ip/macro

set AE250_EXTRA	   $env(NDS_HOME)/andes_ip/ae250/top/hdl/include

set search_path " $search_path $CFG_PATH $AE250_EXTRA"

if {![info exists syn_define]} {
	set syn_define "NDS_SYN"
}

analyze -lib nds_core -define $syn_define -format sverilog [list config.inc global.inc ae250_config.vh $NDS_HOME/andes_ip/n22_core/top/hdl/ae250_cpu_subsystem.v]
analyze -lib nds_core -define $syn_define -format sverilog [list config.inc global.inc $NDS_HOME/andes_ip/n22_core/top/hdl/n22_core_top.v]
analyze -lib nds_core -define $syn_define -format sverilog [list config.inc global.inc $NDS_HOME/andes_ip/n22_core/top/hdl/n22_core.v]
analyze -lib nds_core -define $syn_define -format sverilog [list config.inc global.inc $NDS_HOME/andes_ip/ae250/top/hdl/ae250_cpu_to_ahb32.v]
analyze -lib nds_core -define $syn_define -format sverilog [list config.inc global.inc $NDS_HOME/andes_ip/ae250/top/hdl/ae250_cpu_to_ahb.v]
analyze -lib nds_core -define $syn_define -format sverilog [list config.inc global.inc $NDS_HOME/andes_ip/ae250/top/hdl/ae250_slv_to_lm.v]
analyze -lib nds_core -define $syn_define -format sverilog [list config.inc global.inc $NDS_HOME/andes_ip/ae250/top/hdl/ae250_cpu_uncore.v]
analyze -lib nds_core -define $syn_define -format sverilog [list config.inc global.inc $NDS_HOME/andes_ip/ae250/top/hdl/ae250_debug_subsystem.v]
if {[file isdirectory "$NDS_HOME/andes_ip/peripheral_ip/atcbusdec250"]} {
analyze -lib nds_core -define $syn_define -format sverilog [list config.inc global.inc $NDS_HOME/andes_ip/peripheral_ip/atcbusdec250/hdl/atcbusdec250.v]
}
analyze -lib nds_core -define $syn_define -format sverilog [list config.inc global.inc $NDS_HOME/andes_ip/peripheral_ip/atchl2h200/hdl/atchl2h200.v]
analyze -lib nds_core -define $syn_define -format sverilog [list config.inc global.inc $NDS_HOME/andes_ip/peripheral_ip/atcrambrg200/hdl/atcrambrg200.v]
analyze -lib nds_core -define $syn_define -format sverilog [list config.inc global.inc $NDS_HOME/andes_ip/macro/nds_sync_fifo_afe.v]
analyze -lib nds_core -define $syn_define -format sverilog [list config.inc global.inc $NDS_HOME/andes_ip/macro/nds_sync_l2l.v]

if {[file isdirectory "$NDS_HOME/andes_ip/soc/ncejdtm200"]} {
analyze -lib nds_core -define $syn_define -format sverilog [list config.inc global.inc $NDS_HOME/andes_ip/soc/ncejdtm200/hdl/ncejdtm200.v]
analyze -lib nds_core -define $syn_define -format sverilog [list config.inc global.inc $NDS_HOME/andes_ip/soc/ncejdtm200/hdl/ncejdtm200_dmi.v]
analyze -lib nds_core -define $syn_define -format sverilog [list config.inc global.inc $NDS_HOME/andes_ip/soc/ncejdtm200/hdl/ncejdtm200_tap.v]
}
if {[file isdirectory "$NDS_HOME/andes_ip/soc/ncepldm200"]} {
analyze -lib nds_core -define $syn_define -format sverilog [list config.inc global.inc $NDS_HOME/andes_ip/soc/ncepldm200/hdl/ncepldm200.v]
}
if {[file isdirectory "$NDS_HOME/andes_ip/soc/nceplmt100"]} {
analyze -lib nds_core -define $syn_define -format sverilog [list config.inc global.inc $NDS_HOME/andes_ip/soc/nceplmt100/hdl/nceplmt100.v]
analyze -lib nds_core -define $syn_define -format sverilog [list config.inc global.inc $NDS_HOME/andes_ip/soc/nceplmt100/hdl/nceplmt100_rtc.v]
analyze -lib nds_core -define $syn_define -format sverilog [list config.inc global.inc $NDS_HOME/andes_ip/soc/nceplmt100/hdl/nceplmt100_busif.v]
}
if {[file isdirectory "$NDS_HOME/andes_ip/soc/nceplic100"]} {
analyze -lib nds_core -define $syn_define -format sverilog [list config.inc global.inc $NDS_HOME/andes_ip/soc/nceplic100/hdl/nceplic100.v]
analyze -lib nds_core -define $syn_define -format sverilog [list config.inc global.inc $NDS_HOME/andes_ip/soc/nceplic100/hdl/nceplic100_busif.v]
analyze -lib nds_core -define $syn_define -format sverilog [list config.inc global.inc $NDS_HOME/andes_ip/soc/nceplic100/hdl/nceplic100_core.v]
}
analyze -lib nds_core -define $syn_define -format sverilog [list config.inc global.inc $NDS_HOME/andes_ip/macro/nds_sync_fifo_ll.v]

set n22_core_rtl_v		[glob -nocomplain $NDS_HOME/andes_ip/n22_core/ucore/hdl/*.v]

foreach core_design_name $n22_core_rtl_v {
analyze -lib nds_core -define $syn_define -format sverilog [list config.inc global.inc $core_design_name]
}

if {$NDS_DLM_SIZE_KB != 0} {
	analyze -lib nds_core -define $syn_define -format sverilog [list config.inc global.inc $NDS_HOME/andes_ip/n22_core/memory/syn/n22_dlm_ram.v]
}

if {$NDS_ILM_SIZE_KB != 0} {
	analyze -lib nds_core -define $syn_define -format sverilog [list config.inc global.inc $NDS_HOME/andes_ip/n22_core/memory/syn/n22_ilm_ram.v]
}

if {[string match "*btb*" $NDS_BRANCH_PREDICTION]} {
	analyze -lib nds_core -define $syn_define -format sverilog [list config.inc global.inc $NDS_HOME/andes_ip/n22_core/memory/syn/n22_btb_ram.v]
}

if {$NDS_ICACHE_SIZE_KB != 0} {
	analyze -lib nds_core -define $syn_define -format sverilog [list config.inc global.inc $NDS_HOME/andes_ip/n22_core/memory/syn/n22_icache_ram.v]
}

if {$NDS_DCACHE_SIZE_KB != 0} {
	analyze -lib nds_core -define $syn_define -format sverilog [list config.inc global.inc $NDS_HOME/andes_ip/n22_core/memory/syn/n22_dcache_ram.v]
}
if {$NDS_DCACHE_SIZE_KB != 0} {
	analyze -lib nds_core -define $syn_define -format sverilog [list config.inc global.inc $NDS_HOME/andes_ip/n22_core/memory/syn/n22_dcache_ram.v]
}
if {$NDS_DCACHE_SIZE_KB != 0} {
	if {[string equal $NDS_BIU_BUS "acu"]} {
	analyze -lib nds_core -define $syn_define -format sverilog [list config.inc global.inc $NDS_HOME/andes_ip/n22_core/memory/syn/n22_dtag_ram.v]
	}
}
if {[string match "*sv*" $NDS_MMU_SCHEME]} {
	analyze -lib nds_core -define $syn_define -format sverilog [list config.inc global.inc $NDS_HOME/andes_ip/n22_core/memory/syn/n22_stlb_ram.v]
}

if {[file exists $NDS_HOME/andes_ip/soc/nceeic100/hdl/nceeic100.v]} {
	analyze -lib nds_core -define $syn_define -format sverilog [list config.inc global.inc $NDS_HOME/andes_ip/soc/nceeic100/hdl/nceeic100.v]
}
if {[file exists $NDS_HOME/andes_ip/soc/nceeic050/hdl/nceeic050.v]} {
	analyze -lib nds_core -define $syn_define -format sverilog [list config.inc global.inc $NDS_HOME/andes_ip/soc/nceeic050/hdl/nceeic050.v]
}
if {[file exists $NDS_HOME/andes_ip/n22_core/memory/syn/n22_eic_ram.v]} {
	analyze -lib nds_core -define $syn_define -format sverilog [list config.inc global.inc $NDS_HOME/andes_ip/n22_core/memory/syn/n22_eic_ram.v]
}
if {[file exists $NDS_HOME/andes_ip/peripheral_ip/atcsyncdn100/hdl/atcsyncdn100.v]} {
	analyze -lib nds_core -define $syn_define -format sverilog [list config.inc global.inc $NDS_HOME/andes_ip/peripheral_ip/atcsyncdn100/hdl/atcsyncdn100.v]
}

elaborate $root_design -lib nds_core > ./log/elaborate.log
link

current_design $root_design

if {[info exists wire_load_group]} {
    set_wire_load_selection_group -max -library $tech_lib $wire_load_group
}

