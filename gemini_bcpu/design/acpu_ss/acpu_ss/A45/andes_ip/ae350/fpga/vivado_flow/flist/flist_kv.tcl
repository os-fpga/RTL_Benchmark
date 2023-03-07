# ----------------------------------
# Sub-system
# ----------------------------------
add_include_path "$NDS_HOME/andes_ip/kv_core/top/hdl" 
add_include_path "$NDS_HOME/andes_ip/kv_core/syn/config" 
add_include_path "$NDS_HOME/andes_ip/kv_core/fpga/ila" 

if {$cluster_support} {
	if {$NDS_NHART == 8} {
		read_verilog -sv "$NDS_HOME/andes_ip/kv_core/cluster/hdl/a45_l2_interconnect_8c.v"
	} else {
		read_verilog -sv "$NDS_HOME/andes_ip/kv_core/cluster/hdl/a45_l2_interconnect.v"
	}
	read_verilog -sv "$NDS_HOME/andes_ip/kv_core/cluster/hdl/a45_l2_mem.v"
	read_verilog -sv "$NDS_HOME/andes_ip/kv_core/cluster/hdl/a45_l2_mem_cache.v"
	read_verilog -sv "$NDS_HOME/andes_ip/kv_core/cluster/hdl/a45_l2_mmio.v"
	read_verilog -sv "$NDS_HOME/andes_ip/kv_core/cluster/hdl/a45_l2_iocp.v"
	read_verilog -sv "$NDS_HOME/andes_ip/kv_core/top/hdl/a45_l2_top.v"
	read_verilog -sv "$NDS_HOME/andes_ip/kv_core/top/hdl/a45_l2.v"
	read_verilog -sv "$NDS_HOME/andes_ip/kv_core/top/hdl/a45_cluster.v"
	read_verilog -sv "$NDS_HOME/andes_ip/kv_core/top/hdl/${platform}_cpu_cluster_subsystem.v"
} else {
	read_verilog -sv "$NDS_HOME/andes_ip/kv_core/top/hdl/${platform}_cpu_subsystem.v"
}

read_verilog -sv "$NDS_HOME/andes_ip/kv_core/top/hdl/a45_core_top.v"
read_verilog -sv "$NDS_HOME/andes_ip/kv_core/top/hdl/a45_core.v"
read_verilog -sv "$NDS_HOME/andes_ip/kv_core/top/hdl/kv_core.v"
read_verilog -sv "$NDS_HOME/andes_ip/kv_core/top/hdl/kv_core_brg.v"
read_verilog -sv "$NDS_HOME/andes_ip/kv_core/top/hdl/kv_cpuid.v"


set kv_core_ucore_v		[glob -nocomplain $NDS_HOME/andes_ip/kv_core/ucore/hdl/*.v]
set kv_core_biu_v		[glob -nocomplain $NDS_HOME/andes_ip/kv_core/biu/hdl/*.v]
set kv_core_fpu_v		[glob -nocomplain $NDS_HOME/andes_ip/kv_core/fpu/hdl/*.v]
set kv_core_tilelink_v		[glob -nocomplain $NDS_HOME/andes_ip/kv_core/tilelink/hdl/*.v]
set kv_core_macro_v		[glob -nocomplain $NDS_HOME/andes_ip/kv_core/macro/hdl/*.v]

if {[string equal $NDS_RVV_SUPPORT "yes"]} {
    set kv_core_vpu_v		[glob -nocomplain $NDS_HOME/andes_ip/kv_core/vpu/hdl/*.v]
    foreach kv_rtl_code $kv_core_vpu_v {
	    read_verilog -sv $kv_rtl_code
    }
}

if {[string equal $NDS_ACE_SUPPORT "yes"]} {
    source flist/flist_ace.tcl
    foreach kv_rtl_code "$kv_core_ucore_v $kv_core_biu_v $kv_core_fpu_v $kv_core_tilelink_v $kv_core_macro_v" {
	    read_verilog -sv $kv_rtl_code
    }
} else {
    set kv_core_ace_v	[glob -nocomplain $NDS_HOME/andes_ip/kv_core/ace/hdl/*.v]
    foreach kv_rtl_code "$kv_core_ucore_v $kv_core_biu_v $kv_core_fpu_v $kv_core_tilelink_v $kv_core_macro_v $kv_core_ace_v" {
	    read_verilog -sv $kv_rtl_code
    }
}

read_verilog -sv "$NDS_HOME/andes_ip/macro/nds_sync_fifo_afe.v"

read_verilog -sv "$NDS_HOME/andes_ip/kv_core/memory/fpga_xilinx/kv_btb_ram.v"

if {$NDS_ILM_SIZE_KB != 0} {
	if {[string equal $NDS_ILM_ECC_TYPE "ecc"]} {
		read_verilog -sv "$NDS_HOME/andes_ip/kv_core/memory/fpga_xilinx/kv_ilm_ecc_ram.v"
	} else {
		read_verilog -sv "$NDS_HOME/andes_ip/kv_core/memory/fpga_xilinx/kv_ilm_ram.v"
	}
}

if {$NDS_DLM_SIZE_KB != 0} {
	if {$NDS_DLM_WAIT_CYCLE != 0} {
		if {[string equal $NDS_DLM_ECC_TYPE "ecc"]} {
			read_verilog -sv "$NDS_HOME/andes_ip/kv_core/memory/fpga_xilinx/kv_dlm_wait_ecc_ram.v"
		} else {
			read_verilog -sv "$NDS_HOME/andes_ip/kv_core/memory/fpga_xilinx/kv_dlm_wait_ram.v"
		}
	} else {
		if {[string equal $NDS_DLM_ECC_TYPE "ecc"]} {
			read_verilog -sv "$NDS_HOME/andes_ip/kv_core/memory/fpga_xilinx/kv_dlm_ecc_ram.v"
		} else {
			read_verilog -sv "$NDS_HOME/andes_ip/kv_core/memory/fpga_xilinx/kv_dlm_ram.v"
		}
	}
}

if {$NDS_ICACHE_SIZE_KB != 0} {
	if {[string equal $NDS_ICACHE_ECC_TYPE "parity"]} {
		read_verilog -sv "$NDS_HOME/andes_ip/kv_core/memory/fpga_xilinx/kv_icache_tag_par_ram.v"
		read_verilog -sv "$NDS_HOME/andes_ip/kv_core/memory/fpga_xilinx/kv_icache_data_par_ram.v"
	} elseif {[string equal $NDS_ICACHE_ECC_TYPE "ecc"]} { 
		read_verilog -sv "$NDS_HOME/andes_ip/kv_core/memory/fpga_xilinx/kv_icache_tag_ecc_ram.v"
		read_verilog -sv "$NDS_HOME/andes_ip/kv_core/memory/fpga_xilinx/kv_icache_data_ecc_ram.v"
	} else {
		read_verilog -sv "$NDS_HOME/andes_ip/kv_core/memory/fpga_xilinx/kv_icache_tag_ram.v"
		read_verilog -sv "$NDS_HOME/andes_ip/kv_core/memory/fpga_xilinx/kv_icache_data_ram.v"
	}
}

if {$NDS_DCACHE_SIZE_KB != 0} {
	if {[string equal $NDS_DCACHE_ECC_TYPE "ecc"]} {
		read_verilog -sv "$NDS_HOME/andes_ip/kv_core/memory/fpga_xilinx/kv_dcache_tag_ecc_ram.v"
		read_verilog -sv "$NDS_HOME/andes_ip/kv_core/memory/fpga_xilinx/kv_dcache_data_ecc_ram.v"
	} else {
		read_verilog -sv "$NDS_HOME/andes_ip/kv_core/memory/fpga_xilinx/kv_dcache_tag_ram.v"
		read_verilog -sv "$NDS_HOME/andes_ip/kv_core/memory/fpga_xilinx/kv_dcache_data_ram.v"
	}
}

if {$cluster_support} {
	set ip_rtl_v    [glob -nocomplain $NDS_HOME/andes_ip/kv_core/l2c/hdl/*.v]
	foreach ip_rtl_code "$ip_rtl_v" {
		read_verilog -sv $ip_rtl_code
	}

	if {$NDS_L2C_CACHE_SIZE_KB != 0} {
		read_verilog -sv "$NDS_HOME/andes_ip/kv_core/memory/fpga_xilinx/kv_l2c_bank_ram.v"
		read_verilog -sv "$NDS_HOME/andes_ip/kv_core/memory/fpga_xilinx/kv_l2c_data_ram.v"
		read_verilog -sv "$NDS_HOME/andes_ip/kv_core/memory/fpga_xilinx/kv_l2c_tag_ram.v"
		read_verilog -sv "$NDS_HOME/andes_ip/kv_core/memory/fpga_xilinx/kv_dcache_wpt_ram.v"
	}

	if {[string match "*YES" $NDS_CM_SUPPORT_INT]} {
		set ip_rtl_v    [glob -nocomplain $NDS_HOME/andes_ip/kv_core/cm/hdl/*.v]
		foreach ip_rtl_code "$ip_rtl_v" {
			read_verilog -sv $ip_rtl_code
		}
	}
}

if {$mmu_support} {
	read_verilog -sv "$NDS_HOME/andes_ip/kv_core/memory/fpga_xilinx/kv_stlb_ram.v"
	read_verilog -sv "$NDS_HOME/andes_ip/kv_core/memory/fpga_xilinx/kv_stlb_tag_ecc_ram.v"
	read_verilog -sv "$NDS_HOME/andes_ip/kv_core/memory/fpga_xilinx/kv_stlb_data_ecc_ram.v"
}

read_verilog -sv "$NDS_HOME/andes_ip/peripheral_ip/atcbmc301/hdl/atcbmc301.v"
read_verilog -sv "$NDS_HOME/andes_ip/peripheral_ip/atcbmc301/hdl/atcbmc301_ds_addr_ctrl.v"
read_verilog -sv "$NDS_HOME/andes_ip/peripheral_ip/atcbmc301/hdl/atcbmc301_ds_axi.v"
read_verilog -sv "$NDS_HOME/andes_ip/peripheral_ip/atcbmc301/hdl/atcbmc301_ds_rdata_ctrl.v"
read_verilog -sv "$NDS_HOME/andes_ip/peripheral_ip/atcbmc301/hdl/atcbmc301_ds_wdata_bresp_ctrl.v"
read_verilog -sv "$NDS_HOME/andes_ip/peripheral_ip/atcbmc301/hdl/atcbmc301_us_axi.v"
read_verilog -sv "$NDS_HOME/andes_ip/peripheral_ip/atcbmc301/hdl/atcbmc301_us_read_addr_ctrl.v"
read_verilog -sv "$NDS_HOME/andes_ip/peripheral_ip/atcbmc301/hdl/atcbmc301_us_resp_ctrl.v"
read_verilog -sv "$NDS_HOME/andes_ip/peripheral_ip/atcbmc301/hdl/atcbmc301_us_wdata_ctrl.v"
read_verilog -sv "$NDS_HOME/andes_ip/peripheral_ip/atcbmc301/hdl/atcbmc301_us_write_addr_ctrl.v"
read_verilog -sv "$NDS_HOME/andes_ip/peripheral_ip/atcbusdec301/hdl/atcbusdec301.v"
if {[file exists $NDS_HOME/andes_ip/peripheral_ip/atcrambrg500/hdl/atcrambrg500.v]} {
	read_verilog -sv "$NDS_HOME/andes_ip/peripheral_ip/atcrambrg500/hdl/atcrambrg500.v"
}
if {[file exists $NDS_HOME/andes_ip/peripheral_ip/atcsizeup300/hdl/atcsizeup300.v]} {
	read_verilog -sv "$NDS_HOME/andes_ip/peripheral_ip/atcsizeup300/hdl/atcsizeup300.v"
}
read_verilog -sv "$NDS_HOME/andes_ip/peripheral_ip/atcaxi2ahb200/hdl/atcaxi2ahb200.v"
if {[file exists $NDS_HOME/andes_ip/peripheral_ip/atcbusdec302/hdl/atcbusdec302.v]} {
	read_verilog -sv "$NDS_HOME/andes_ip/peripheral_ip/atcbusdec302/hdl/atcbusdec302.v"
}
read_verilog -sv "$NDS_HOME/andes_ip/peripheral_ip/atcrambrg300/hdl/atcrambrg300.v"
read_verilog -sv "$NDS_HOME/andes_ip/macro/nds_async_fifo_afe.v"

set ip_path	"atcbmc500"
set ip_rtl_v	[glob -nocomplain $NDS_HOME/andes_ip/peripheral_ip/$ip_path/hdl/*.v]
foreach ip_rtl_code "$ip_rtl_v" {
	read_verilog -sv $ip_rtl_code
}

set ip_path	"atctlc2axi500"
set ip_rtl_v	[glob -nocomplain $NDS_HOME/andes_ip/peripheral_ip/$ip_path/hdl/*.v]
foreach ip_rtl_code "$ip_rtl_v" {
	read_verilog -sv $ip_rtl_code
}

set ip_path	"atcsizedn500"
set ip_rtl_v	[glob -nocomplain $NDS_HOME/andes_ip/peripheral_ip/$ip_path/hdl/*.v]
foreach ip_rtl_code "$ip_rtl_v" {
	read_verilog -sv $ip_rtl_code
}

set ip_path	"atcaxi2tluh500"
set ip_rtl_v	[glob -nocomplain $NDS_HOME/andes_ip/peripheral_ip/$ip_path/hdl/*.v]
foreach ip_rtl_code "$ip_rtl_v" {
	read_verilog -sv $ip_rtl_code
}


