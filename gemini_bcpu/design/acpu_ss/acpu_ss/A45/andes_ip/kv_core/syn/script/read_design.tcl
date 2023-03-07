### Read cpu core rtl ###
define_design_lib nds_core -path ./work

if {![info exists syn_define]} {
	set syn_define "NDS_SYN"
}

analyze -lib nds_core -define $syn_define -format sverilog [list config.inc global.inc  $NDS_HOME/andes_ip/kv_core/top/hdl/${PLATFORM}_cpu_subsystem.v]
	
if {[string equal $PLATFORM "ae350"]} {
	analyze -lib nds_core -define $syn_define -format sverilog [list config.inc global.inc  $NDS_HOME/andes_ip/peripheral_ip/atcbmc301/hdl/atcbmc301.v]
	analyze -lib nds_core -define $syn_define -format sverilog [list config.inc global.inc  $NDS_HOME/andes_ip/peripheral_ip/atcbmc301/hdl/atcbmc301_ds_addr_ctrl.v]
	analyze -lib nds_core -define $syn_define -format sverilog [list config.inc global.inc  $NDS_HOME/andes_ip/peripheral_ip/atcbmc301/hdl/atcbmc301_ds_axi.v]
	analyze -lib nds_core -define $syn_define -format sverilog [list config.inc global.inc  $NDS_HOME/andes_ip/peripheral_ip/atcbmc301/hdl/atcbmc301_ds_rdata_ctrl.v]
	analyze -lib nds_core -define $syn_define -format sverilog [list config.inc global.inc  $NDS_HOME/andes_ip/peripheral_ip/atcbmc301/hdl/atcbmc301_ds_wdata_bresp_ctrl.v]
	analyze -lib nds_core -define $syn_define -format sverilog [list config.inc global.inc  $NDS_HOME/andes_ip/peripheral_ip/atcbmc301/hdl/atcbmc301_us_axi.v]
	analyze -lib nds_core -define $syn_define -format sverilog [list config.inc global.inc  $NDS_HOME/andes_ip/peripheral_ip/atcbmc301/hdl/atcbmc301_us_read_addr_ctrl.v]
	analyze -lib nds_core -define $syn_define -format sverilog [list config.inc global.inc  $NDS_HOME/andes_ip/peripheral_ip/atcbmc301/hdl/atcbmc301_us_resp_ctrl.v]
	analyze -lib nds_core -define $syn_define -format sverilog [list config.inc global.inc  $NDS_HOME/andes_ip/peripheral_ip/atcbmc301/hdl/atcbmc301_us_wdata_ctrl.v]
	analyze -lib nds_core -define $syn_define -format sverilog [list config.inc global.inc  $NDS_HOME/andes_ip/peripheral_ip/atcbmc301/hdl/atcbmc301_us_write_addr_ctrl.v]
	analyze -lib nds_core -define $syn_define -format sverilog [list config.inc global.inc  $NDS_HOME/andes_ip/peripheral_ip/atcbusdec301/hdl/atcbusdec301.v]
	if {[file exists $NDS_HOME/andes_ip/peripheral_ip/atcsizedn300/hdl/atcsizedn300.v]} {
		analyze -lib nds_core -define $syn_define -format sverilog [list config.inc global.inc  $NDS_HOME/andes_ip/peripheral_ip/atcsizedn300/hdl/atcsizedn300.v]
		analyze -lib nds_core -define $syn_define -format sverilog [list config.inc global.inc  $NDS_HOME/andes_ip/peripheral_ip/atcsizedn300/hdl/atcsizedn300_addr_downsizer.v]
		analyze -lib nds_core -define $syn_define -format sverilog [list config.inc global.inc  $NDS_HOME/andes_ip/peripheral_ip/atcsizedn300/hdl/atcsizedn300_data_downsizer.v]
	}
	if {[file exists $NDS_HOME/andes_ip/peripheral_ip/atcsizeup300/hdl/atcsizeup300.v]} {
		analyze -lib nds_core -define $syn_define -format sverilog [list config.inc global.inc  $NDS_HOME/andes_ip/peripheral_ip/atcsizeup300/hdl/atcsizeup300.v]
	}
	analyze -lib nds_core -define $syn_define -format sverilog [list config.inc global.inc  $NDS_HOME/andes_ip/peripheral_ip/atcaxi2ahb200/hdl/atcaxi2ahb200.v]
	analyze -lib nds_core -define $syn_define -format sverilog [list config.inc global.inc  $NDS_HOME/andes_ip/peripheral_ip/atcaxi2ahb200/hdl/fifo2ahb.v]
}

if {[file exists $NDS_HOME/andes_ip/peripheral_ip/atcsizedn500/hdl/atcsizedn500.v]} {
	analyze -lib nds_core -define $syn_define -format sverilog [list config.inc global.inc  $NDS_HOME/andes_ip/peripheral_ip/atcsizedn500/hdl/atcsizedn500.v]
	analyze -lib nds_core -define $syn_define -format sverilog [list config.inc global.inc  $NDS_HOME/andes_ip/peripheral_ip/atcsizedn500/hdl/atcsizedn500_bin2onehot.v]
	analyze -lib nds_core -define $syn_define -format sverilog [list config.inc global.inc  $NDS_HOME/andes_ip/peripheral_ip/atcsizedn500/hdl/atcsizedn500_mux_onehot.v]
}

if {[file exists $NDS_HOME/andes_ip/peripheral_ip/atcrambrg500/hdl/atcrambrg500.v]} {
	analyze -lib nds_core -define $syn_define -format sverilog [list config.inc global.inc  $NDS_HOME/andes_ip/peripheral_ip/atcrambrg500/hdl/atcrambrg500.v]
}

analyze -lib nds_core -define $syn_define -format sverilog [list config.inc global.inc  $NDS_HOME/andes_ip/macro/nds_async_fifo_afe.v]

analyze -lib nds_core -define $syn_define -format sverilog [list config.inc global.inc  $NDS_HOME/andes_ip/macro/nds_sync_fifo_afe.v]
analyze -lib nds_core -define $syn_define -format sverilog [list config.inc global.inc  $NDS_HOME/andes_ip/macro/nds_sync_l2l.v]

analyze -lib nds_core -define $syn_define -format sverilog [list config.inc global.inc  $NDS_HOME/andes_ip/soc/ncejdtm200/hdl/ncejdtm200.v]
analyze -lib nds_core -define $syn_define -format sverilog [list config.inc global.inc  $NDS_HOME/andes_ip/soc/ncejdtm200/hdl/ncejdtm200_dmi.v]
analyze -lib nds_core -define $syn_define -format sverilog [list config.inc global.inc  $NDS_HOME/andes_ip/soc/ncejdtm200/hdl/ncejdtm200_tap.v]
if {[file exists $NDS_HOME/andes_ip/soc/ncedbglock100/hdl/ncedbglock100.v]} {
	analyze -lib nds_core -define $syn_define -format sverilog [list config.inc global.inc  $NDS_HOME/andes_ip/soc/ncedbglock100/hdl/ncedbglock100.v]
}
analyze -lib nds_core -define $syn_define -format sverilog [list config.inc global.inc  $NDS_HOME/andes_ip/soc/ncepldm200/hdl/ncepldm200.v]
analyze -lib nds_core -define $syn_define -format sverilog [list config.inc global.inc  $NDS_HOME/andes_ip/soc/nceplmt100/hdl/nceplmt100.v]
analyze -lib nds_core -define $syn_define -format sverilog [list config.inc global.inc  $NDS_HOME/andes_ip/soc/nceplmt100/hdl/nceplmt100_rtc.v]
analyze -lib nds_core -define $syn_define -format sverilog [list config.inc global.inc  $NDS_HOME/andes_ip/soc/nceplmt100/hdl/nceplmt100_busif.v]
analyze -lib nds_core -define $syn_define -format sverilog [list config.inc global.inc  $NDS_HOME/andes_ip/soc/nceplic100/hdl/nceplic100.v]
analyze -lib nds_core -define $syn_define -format sverilog [list config.inc global.inc  $NDS_HOME/andes_ip/soc/nceplic100/hdl/nceplic100_busif.v]
analyze -lib nds_core -define $syn_define -format sverilog [list config.inc global.inc  $NDS_HOME/andes_ip/soc/nceplic100/hdl/nceplic100_core.v]
analyze -lib nds_core -define $syn_define -format sverilog [list config.inc global.inc  $NDS_HOME/andes_ip/macro/nds_sync_fifo_ll.v]
analyze -lib nds_core -define $syn_define -format sverilog [list config.inc global.inc  $NDS_HOME/andes_ip/macro/nds_rst_sync.v]
analyze -lib nds_core -define $syn_define -format sverilog [list config.inc global.inc  $NDS_HOME/andes_ip/kv_core/top/hdl/a45_core_top.v]
analyze -lib nds_core -define $syn_define -format sverilog [list config.inc global.inc  $NDS_HOME/andes_ip/kv_core/top/hdl/a45_core.v]
analyze -lib nds_core -define $syn_define -format sverilog [list config.inc global.inc  $NDS_HOME/andes_ip/kv_core/top/hdl/kv_core.v]
analyze -lib nds_core -define $syn_define -format sverilog [list config.inc global.inc  $NDS_HOME/andes_ip/kv_core/top/hdl/kv_cpuid.v]
#analyze -lib nds_core -define $syn_define -format sverilog [list config.inc global.inc  $NDS_HOME/andes_ip/kv_core/top/hdl/kv_dlm_clkgen.v]
#analyze -lib nds_core -define $syn_define -format sverilog [list config.inc global.inc  $NDS_HOME/andes_ip/kv_core/top/hdl/kv_ilm_clkgen.v]

set kv_core_ucore_v		[glob -nocomplain $NDS_HOME/andes_ip/kv_core/ucore/hdl/*.v]
set kv_core_biu_v		[glob -nocomplain $NDS_HOME/andes_ip/kv_core/biu/hdl/*.v]
set kv_core_macro_v		[glob -nocomplain $NDS_HOME/andes_ip/kv_core/macro/hdl/*.v]
set kv_core_tilelink_v		[glob -nocomplain $NDS_HOME/andes_ip/kv_core/tilelink/hdl/*.v]
set kv_core_ace_v		[glob -nocomplain $NDS_HOME/andes_ip/kv_core/ace/hdl/*.v]

foreach kv_rtl_code "$kv_core_ucore_v $kv_core_biu_v $kv_core_macro_v $kv_core_tilelink_v $kv_core_ace_v" {
	analyze -lib nds_core -define $syn_define -format sverilog [list config.inc global.inc  $kv_rtl_code]
}

set kv_tlc2axi_v                [glob -nocomplain $NDS_HOME/andes_ip/peripheral_ip/atctlc2axi500/hdl/*.v]
foreach kv_tlc2axi_code "$kv_tlc2axi_v" {
	analyze -lib nds_core -define $syn_define -format sverilog [list config.inc global.inc  $kv_tlc2axi_code]
}

set kv_exmon_v                [glob -nocomplain $NDS_HOME/andes_ip/peripheral_ip/atcexmon300/hdl/*.v]
foreach kv_exmon_code "$kv_exmon_v" {
	analyze -lib nds_core -define $syn_define -format sverilog [list config.inc global.inc  $kv_exmon_code]
}


if {[file exists $NDS_HOME/andes_ip/kv_core/memory/syn/kv_ram_wrapper.v]} {
	analyze -lib nds_core -define $syn_define -format sverilog [list config.inc global.inc  $NDS_HOME/andes_ip/kv_core/memory/syn/kv_ram_wrapper.v]
}

if {$NDS_DLM_WAIT_CYCLE != 0} {
	if {[string equal $NDS_DLM_ECC_TYPE "ecc"]} {
		analyze -lib nds_core -define $syn_define -format sverilog [list config.inc global.inc  $NDS_HOME/andes_ip/kv_core/memory/syn/kv_dlm_wait_ecc_ram.v]
        } else {
		analyze -lib nds_core -define $syn_define -format sverilog [list config.inc global.inc  $NDS_HOME/andes_ip/kv_core/memory/syn/kv_dlm_wait_ram.v]
	}
}

if {$NDS_DLM_SIZE_KB != 0} {
	if {[string equal $NDS_DLM_ECC_TYPE "ecc"]} {
		analyze -lib nds_core -define $syn_define -format sverilog [list config.inc global.inc  $NDS_HOME/andes_ip/kv_core/memory/syn/kv_dlm_ecc_ram.v]
        } else {
		analyze -lib nds_core -define $syn_define -format sverilog [list config.inc global.inc  $NDS_HOME/andes_ip/kv_core/memory/syn/kv_dlm_ram.v]
	}
}

if {$NDS_ILM_SIZE_KB != 0} {
	if {[string equal $NDS_ILM_ECC_TYPE "ecc"]} {
		analyze -lib nds_core -define $syn_define -format sverilog [list config.inc global.inc  $NDS_HOME/andes_ip/kv_core/memory/syn/kv_ilm_ecc_ram.v]
	} else {
		analyze -lib nds_core -define $syn_define -format sverilog [list config.inc global.inc  $NDS_HOME/andes_ip/kv_core/memory/syn/kv_ilm_ram.v]
	}
}

if {[string match "*btb*" $NDS_BRANCH_PREDICTION]} {
	analyze -lib nds_core -define $syn_define -format sverilog [list config.inc global.inc  $NDS_HOME/andes_ip/kv_core/memory/syn/kv_btb_ram.v]
}

if {$NDS_ICACHE_SIZE_KB != 0} {
	if {[string equal $NDS_ICACHE_ECC_TYPE "parity"]} {
		analyze -lib nds_core -define $syn_define -format sverilog [list config.inc global.inc  $NDS_HOME/andes_ip/kv_core/memory/syn/kv_icache_tag_par_ram.v]
		analyze -lib nds_core -define $syn_define -format sverilog [list config.inc global.inc  $NDS_HOME/andes_ip/kv_core/memory/syn/kv_icache_data_par_ram.v]
	} elseif {[string equal $NDS_ICACHE_ECC_TYPE "ecc"]} {
		analyze -lib nds_core -define $syn_define -format sverilog [list config.inc global.inc  $NDS_HOME/andes_ip/kv_core/memory/syn/kv_icache_tag_ecc_ram.v]
		analyze -lib nds_core -define $syn_define -format sverilog [list config.inc global.inc  $NDS_HOME/andes_ip/kv_core/memory/syn/kv_icache_data_ecc_ram.v]
	} else {
		analyze -lib nds_core -define $syn_define -format sverilog [list config.inc global.inc  $NDS_HOME/andes_ip/kv_core/memory/syn/kv_icache_tag_ram.v]
		analyze -lib nds_core -define $syn_define -format sverilog [list config.inc global.inc  $NDS_HOME/andes_ip/kv_core/memory/syn/kv_icache_data_ram.v]
	}
}

if {$NDS_DCACHE_SIZE_KB != 0} {
	if {[string equal $NDS_DCACHE_ECC_TYPE "ecc"]} {
		analyze -lib nds_core -define $syn_define -format sverilog [list config.inc global.inc  $NDS_HOME/andes_ip/kv_core/memory/syn/kv_dcache_tag_ecc_ram.v]
		analyze -lib nds_core -define $syn_define -format sverilog [list config.inc global.inc  $NDS_HOME/andes_ip/kv_core/memory/syn/kv_dcache_data_ecc_ram.v]
	} else {
		analyze -lib nds_core -define $syn_define -format sverilog [list config.inc global.inc  $NDS_HOME/andes_ip/kv_core/memory/syn/kv_dcache_tag_ram.v]
		analyze -lib nds_core -define $syn_define -format sverilog [list config.inc global.inc  $NDS_HOME/andes_ip/kv_core/memory/syn/kv_dcache_data_ram.v]
	}
}

if {[string match "*sv*" $NDS_MMU_SCHEME]} {
	analyze -lib nds_core -define $syn_define -format sverilog [list config.inc global.inc  $NDS_HOME/andes_ip/kv_core/memory/syn/kv_stlb_ram.v]
	analyze -lib nds_core -define $syn_define -format sverilog [list config.inc global.inc  $NDS_HOME/andes_ip/kv_core/memory/syn/kv_stlb_tag_ecc_ram.v]
	analyze -lib nds_core -define $syn_define -format sverilog [list config.inc global.inc  $NDS_HOME/andes_ip/kv_core/memory/syn/kv_stlb_data_ecc_ram.v]
}

if {[regexp {(s|d)p} $NDS_FPU_TYPE]} {
	set kv_core_fpu_v		[glob -nocomplain $NDS_HOME/andes_ip/kv_core/fpu/hdl/*.v]
	foreach kv_rtl_code "$kv_core_fpu_v" {
		analyze -lib nds_core -define $syn_define -format sverilog [list config.inc global.inc  $kv_rtl_code]
	}
} else {
	analyze -lib nds_core -define $syn_define -format sverilog [list config.inc global.inc  $NDS_HOME/andes_ip/kv_core/fpu/hdl/kv_fpu_stub.v]
	analyze -lib nds_core -define $syn_define -format sverilog [list config.inc global.inc  $NDS_HOME/andes_ip/kv_core/fpu/hdl/kv_frf_stub.v]
}

if {[info exists NDS_DSP_SUPPORT]} {
    if {[string equal $NDS_DSP_SUPPORT "yes"]} {
        set dsp_support 1
    } else {
        set dsp_support 0
    }
} else {
        set dsp_support 0
}

if {$dsp_support} {
	set kv_core_dsp_v		[glob -nocomplain $NDS_HOME/andes_ip/kv_core/dsp/hdl/*.v]
	foreach kv_rtl_code "$kv_core_dsp_v" {
	        analyze -lib nds_core -define $syn_define -format sverilog [list config.inc global.inc  $kv_rtl_code]
	}
}

if {[string equal $NDS_ACE_SUPPORT "yes"]} {
    source ./script/ace_flist.tcl
        analyze -lib nds_core -define $syn_define -format sverilog $ace_file_list
}


source -verbose ./script/gck_autogen.tcl

if {[file exists ./script/gck_autogen.v]} {
	analyze -lib nds_core -format verilog ./script/gck_autogen.v
} else {
	analyze -lib nds_core -define $syn_define -format sverilog [list config.inc global.inc  $$NDS_HOME/andes_ip/macro/gck.v]
}

elaborate $root_design -lib nds_core > ./log/elaborate.log
link

current_design $root_design

if {[info exists wire_load_group]} {
    set_wire_load_selection_group -max -library $tech_lib $wire_load_group
}

