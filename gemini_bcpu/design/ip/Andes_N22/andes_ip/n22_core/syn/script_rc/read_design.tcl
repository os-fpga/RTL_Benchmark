### Read cpu core rtl ###

set NDS_HOME	$env(NDS_HOME)

set RTL_PATH       $env(NDS_HOME)/andes_ip/n22_core
set CFG_PATH       $RTL_PATH/top/hdl
set MACRO_PATH     $env(NDS_HOME)/andes_ip/macro

if {![info exist syn_define]} {
        set syn_define "NDS_SYN"
}

read_hdl -sv -define $syn_define "$NDS_HOME/andes_ip/n22_core/top/hdl/ae250_cpu_subsystem.v"
read_hdl -sv -define $syn_define "$NDS_HOME/andes_ip/n22_core/top/hdl/n22_core_top.v"
read_hdl -sv -define $syn_define "$NDS_HOME/andes_ip/n22_core/top/hdl/n22_core.v"
read_hdl -sv -define $syn_define "$NDS_HOME/andes_ip/ae250/top/hdl/ae250_cpu_to_ahb32.v"
read_hdl -sv -define $syn_define "$NDS_HOME/andes_ip/ae250/top/hdl/ae250_cpu_to_ahb.v"
read_hdl -sv -define $syn_define "$NDS_HOME/andes_ip/ae250/top/hdl/ae250_slv_to_lm.v"
read_hdl -sv -define $syn_define "$NDS_HOME/andes_ip/ae250/top/hdl/ae250_cpu_uncore.v"
read_hdl -sv -define $syn_define "$NDS_HOME/andes_ip/ae250/top/hdl/ae250_debug_subsystem.v"
if {[file isdirectory "$NDS_HOME/andes_ip/peripheral_ip/atcbusdec250"]} {
read_hdl -sv -define $syn_define "$NDS_HOME/andes_ip/peripheral_ip/atcbusdec250/hdl/atcbusdec250.v"
}

read_hdl -sv -define $syn_define "$NDS_HOME/andes_ip/peripheral_ip/atchl2h200/hdl/atchl2h200.v"
read_hdl -sv -define $syn_define "$NDS_HOME/andes_ip/peripheral_ip/atcrambrg200/hdl/atcrambrg200.v"
read_hdl -sv -define $syn_define "$NDS_HOME/andes_ip/macro/nds_sync_fifo_afe.v"
read_hdl -sv -define $syn_define "$NDS_HOME/andes_ip/macro/nds_sync_l2l.v"

if {[file isdirectory "$NDS_HOME/andes_ip/soc/ncejdtm200"]} {
read_hdl -sv -define $syn_define "$NDS_HOME/andes_ip/soc/ncejdtm200/hdl/ncejdtm200.v"
read_hdl -sv -define $syn_define "$NDS_HOME/andes_ip/soc/ncejdtm200/hdl/ncejdtm200_dmi.v"
read_hdl -sv -define $syn_define "$NDS_HOME/andes_ip/soc/ncejdtm200/hdl/ncejdtm200_tap.v"
}
if {[file isdirectory "$NDS_HOME/andes_ip/soc/ncepldm200"]} {
read_hdl -sv -define $syn_define "$NDS_HOME/andes_ip/soc/ncepldm200/hdl/ncepldm200.v"
}
if {[file isdirectory "$NDS_HOME/andes_ip/soc/nceplmt100"]} {
read_hdl -sv -define $syn_define "$NDS_HOME/andes_ip/soc/nceplmt100/hdl/nceplmt100_busif.v"
read_hdl -sv -define $syn_define "$NDS_HOME/andes_ip/soc/nceplmt100/hdl/nceplmt100_rtc.v"
read_hdl -sv -define $syn_define "$NDS_HOME/andes_ip/soc/nceplmt100/hdl/nceplmt100.v"
}
if {[file isdirectory "$NDS_HOME/andes_ip/soc/nceplic100"]} {
read_hdl -sv -define $syn_define "$NDS_HOME/andes_ip/soc/nceplic100/hdl/nceplic100_busif.v"
read_hdl -sv -define $syn_define "$NDS_HOME/andes_ip/soc/nceplic100/hdl/nceplic100_core.v"
read_hdl -sv -define $syn_define "$NDS_HOME/andes_ip/soc/nceplic100/hdl/nceplic100.v"
read_hdl -sv -define $syn_define "$NDS_HOME/andes_ip/macro/nds_sync_fifo_ll.v"
}

set n22_core_rtl_v		[glob -nocomplain $NDS_HOME/andes_ip/n22_core/ucore/hdl/*.v]

foreach core_design_name $n22_core_rtl_v {
read_hdl -sv -define $syn_define $core_design_name
}

if {$NDS_DLM_SIZE_KB != 0} {
	read_hdl -sv -define $syn_define "$NDS_HOME/andes_ip/n22_core/memory/syn/n22_dlm_ram.v"
}

if {$NDS_ILM_SIZE_KB != 0} {
	read_hdl -sv -define $syn_define "$NDS_HOME/andes_ip/n22_core/memory/syn/n22_ilm_ram.v"
}

if {[string match "btb*" $NDS_BRANCH_PREDICTION]} {
	read_hdl -sv -define $syn_define "$NDS_HOME/andes_ip/n22_core/memory/syn/n22_btb_ram.v"
}

if {$NDS_ICACHE_SIZE_KB != 0} {
	read_hdl -sv -define $syn_define "$NDS_HOME/andes_ip/n22_core/memory/syn/n22_icache_ram.v"
}

if {$NDS_DCACHE_SIZE_KB != 0} {
	read_hdl -sv -define $syn_define "$NDS_HOME/andes_ip/n22_core/memory/syn/n22_dcache_ram.v"
}
if {$NDS_DCACHE_SIZE_KB != 0} {
	if {[string equal $NDS_BIU_BUS "acu"]} {
	read_hdl -sv -define $syn_define "$NDS_HOME/andes_ip/n22_core/memory/syn/n22_dtag_ram.v"
	}
}
if {[string match "*sv*" $NDS_MMU_SCHEME]} {
	read_hdl -sv -define $syn_define "$NDS_HOME/andes_ip/n22_core/memory/syn/n22_stlb_ram.v"
}

if {[file exists "$NDS_HOME/andes_ip/soc/nceeic100/hdl/nceeic100.v"]} {
	read_hdl -sv -define $syn_define "$NDS_HOME/andes_ip/soc/nceeic100/hdl/nceeic100.v"
}
if {[file exists "$NDS_HOME/andes_ip/n22_core/memory/syn/n22_eic_ram.v"]} {
	read_hdl -sv -define $syn_define "$NDS_HOME/andes_ip/n22_core/memory/syn/n22_eic_ram.v"
}
if {[file exists "$NDS_HOME/andes_ip/peripheral_ip/atcsyncdn100/hdl/atcsyncdn100.v"]} {
	read_hdl -sv -define $syn_define "$NDS_HOME/andes_ip/peripheral_ip/atcsyncdn100/hdl/atcsyncdn100.v"
}


