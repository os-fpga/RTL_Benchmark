# ----------------------------------
# Sub-system
# ----------------------------------
#if {$platform == "ae250"} {
	add_include_path "$NDS_HOME/andes_ip/n22_core/top/hdl" 
	add_include_path "$NDS_HOME/andes_ip/n22_core/syn/config" 

	read_verilog -sv "$NDS_HOME/andes_ip/n22_core/top/hdl/${platform}_cpu_subsystem.v"
	read_verilog -sv "$NDS_HOME/andes_ip/n22_core/top/hdl/n22_core_top.v"
	read_verilog -sv "$NDS_HOME/andes_ip/n22_core/top/hdl/n22_core.v"

#} else {	# ae350
#	add_include_path "$NDS_HOME/andes_ip/vc_mpcore/top/hdl" 
#	add_include_path "$NDS_HOME/andes_ip/n22_core/syn/config" 
#
#	read_verilog -sv "$NDS_HOME/andes_ip/vc_mpcore/top/hdl/${platform}_cpu_subsystem.v"
#	read_verilog -sv "$NDS_HOME/andes_ip/n22_core/top/hdl/n22_core.v"
#	read_verilog -sv "$NDS_HOME/andes_ip/vc_mpcore/n22_core_top/top/hdl/n22_core_top.v"
#}
#if {$l2c_support} {
#	read_verilog -sv "$NDS_HOME/andes_ip/vc_mpcore/l2c/top/hdl/vc_l2c_top.v"
#	read_verilog -sv "$NDS_HOME/andes_ip/vc_mpcore/l2c/hdl/vc_l2c.v"
#	read_verilog -sv "$NDS_HOME/andes_ip/vc_mpcore/l2c/hdl/vc_l2c_ctl_slv_ahbif.v"
#	read_verilog -sv "$NDS_HOME/andes_ip/vc_mpcore/l2c/hdl/vc_l2c_ctl_slv_rf.v"
#	read_verilog -sv "$NDS_HOME/andes_ip/vc_mpcore/l2c/hdl/vc_l2c_drc.v"
#	read_verilog -sv "$NDS_HOME/andes_ip/vc_mpcore/l2c/hdl/vc_l2c_goc.v"
#	read_verilog -sv "$NDS_HOME/andes_ip/vc_mpcore/l2c/hdl/vc_l2c_l1r.v"
#	read_verilog -sv "$NDS_HOME/andes_ip/vc_mpcore/l2c/hdl/vc_l2c_l1t.v"
#	read_verilog -sv "$NDS_HOME/andes_ip/vc_mpcore/l2c/hdl/vc_l2c_l2biu.v"
#	read_verilog -sv "$NDS_HOME/andes_ip/vc_mpcore/l2c/hdl/vc_l2c_l2d.v"
#	read_verilog -sv "$NDS_HOME/andes_ip/vc_mpcore/l2c/hdl/vc_l2c_l2t.v"
#	read_verilog -sv "$NDS_HOME/andes_ip/vc_mpcore/l2c/hdl/vc_l2c_mux_fifo.v"
#	read_verilog -sv "$NDS_HOME/andes_ip/vc_mpcore/l2c/hdl/vc_l2c_mux_fifo_dout.v"
#	read_verilog -sv "$NDS_HOME/andes_ip/vc_mpcore/l2c/hdl/vc_l2c_prand_way.v"
#	read_verilog -sv "$NDS_HOME/andes_ip/vc_mpcore/l2c/hdl/vc_l2c_rr_arbiter.v"
#	read_verilog -sv "$NDS_HOME/andes_ip/vc_mpcore/l2c/hdl/vc_l2c_cctl.v"
#} 

set n22_core_rtl_v		[glob -nocomplain $NDS_HOME/andes_ip/n22_core/ucore/hdl/*.v]
set n22_core_rtl_vh		[glob -nocomplain $NDS_HOME/andes_ip/n22_core/ucore/hdl/*.vh]

	foreach n22_rtl_code "$n22_core_rtl_v $n22_core_rtl_vh" {
		read_verilog -sv $n22_rtl_code
	}
	
#read_verilog -sv "$NDS_HOME/andes_ip/n22_core/ucore/hdl/vc_fastmul.v"
#read_verilog -sv "$NDS_HOME/andes_ip/n22_core/ucore/hdl/vc_fastmul_recode.v"
#read_verilog -sv "$NDS_HOME/andes_ip/n22_core/ucore/hdl/vc_fastmul_cmp42.v"
#read_verilog -sv "$NDS_HOME/andes_ip/n22_core/ucore/hdl/vc_fastmul_cmp112.v"
#read_verilog -sv "$NDS_HOME/andes_ip/n22_core/ucore/hdl/vc_alu.v"
#read_verilog -sv "$NDS_HOME/andes_ip/n22_core/ucore/hdl/vc_csr.v"
#read_verilog -sv "$NDS_HOME/andes_ip/n22_core/ucore/hdl/vc_dcu.v"
#read_verilog -sv "$NDS_HOME/andes_ip/n22_core/ucore/hdl/vc_dtag.v"
#read_verilog -sv "$NDS_HOME/andes_ip/n22_core/ucore/hdl/vc_dlm.v"
#read_verilog -sv "$NDS_HOME/andes_ip/n22_core/ucore/hdl/vc_icu.v"
#read_verilog -sv "$NDS_HOME/andes_ip/n22_core/ucore/hdl/vc_ifu.v"
#read_verilog -sv "$NDS_HOME/andes_ip/n22_core/ucore/hdl/vc_ilm.v"
#read_verilog -sv "$NDS_HOME/andes_ip/n22_core/ucore/hdl/vc_ipipe.v"
#read_verilog -sv "$NDS_HOME/andes_ip/n22_core/ucore/hdl/vc_lsu.v"
#read_verilog -sv "$NDS_HOME/andes_ip/n22_core/ucore/hdl/vc_mdu.v"
#read_verilog -sv "$NDS_HOME/andes_ip/n22_core/ucore/hdl/vc_rf.v"
#read_verilog -sv "$NDS_HOME/andes_ip/n22_core/ucore/hdl/vc_trigm.v"
#read_verilog -sv "$NDS_HOME/andes_ip/n22_core/ucore/hdl/vc_slv_port.v"
#read_verilog -sv "$NDS_HOME/andes_ip/n22_core/ucore/hdl/vc_lru.v"
#read_verilog -sv "$NDS_HOME/andes_ip/n22_core/ucore/hdl/vc_eccdec32.v"
#read_verilog -sv "$NDS_HOME/andes_ip/n22_core/ucore/hdl/vc_eccdec64.v"
#read_verilog -sv "$NDS_HOME/andes_ip/n22_core/ucore/hdl/vc_eccenc32.v"
#read_verilog -sv "$NDS_HOME/andes_ip/n22_core/ucore/hdl/vc_eccenc64.v"
#read_verilog -sv "$NDS_HOME/andes_ip/n22_core/ucore/hdl/vc_pardec32.v"
#read_verilog -sv "$NDS_HOME/andes_ip/n22_core/ucore/hdl/vc_pardec64.v"
#read_verilog -sv "$NDS_HOME/andes_ip/n22_core/ucore/hdl/vc_parenc32.v"
#read_verilog -sv "$NDS_HOME/andes_ip/n22_core/ucore/hdl/vc_parenc64.v"
#read_verilog -sv "$NDS_HOME/andes_ip/n22_core/ucore/hdl/vc_mmu.v"
#read_verilog -sv "$NDS_HOME/andes_ip/n22_core/ucore/hdl/vc_pmp_cfg.v"
#
#read_verilog -sv "$NDS_HOME/andes_ip/n22_core/biu/hdl/vc_biu.v"
#read_verilog -sv "$NDS_HOME/andes_ip/n22_core/biu/hdl/vc_biu_ahb_wrapper.v"
#read_verilog -sv "$NDS_HOME/andes_ip/n22_core/biu/hdl/vc_biu_axi_wrapper.v"
#read_verilog -sv "$NDS_HOME/andes_ip/n22_core/biu/hdl/vc_biu_path.v"
#read_verilog -sv "$NDS_HOME/andes_ip/n22_core/biu/hdl/vc_biu_sync.v"
#read_verilog -sv "$NDS_HOME/andes_ip/n22_core/biu/hdl/vc_biu_sync_fifo.v"
#
#if {$ace_support} {
#	read_verilog -sv "$NDS_HOME/andes_ip/n22_core/ucore/hdl/vc_ace_port.v"
#	source flist/flist_ace.tcl
#}

#read_verilog -sv "$NDS_HOME/andes_ip/peripheral_ip/atcsizedn100/hdl/atcsizedn100.v"
#read_verilog -sv "$NDS_HOME/andes_ip/peripheral_ip/atcsizeup100/hdl/atcsizeup100.v"
read_verilog -sv "$NDS_HOME/andes_ip/peripheral_ip/atcrambrg200/hdl/atcrambrg200.v"
if {[file isdirectory "$NDS_HOME/andes_ip/peripheral_ip/atcbusdec250"]} {
read_verilog -sv "$NDS_HOME/andes_ip/peripheral_ip/atcbusdec250/hdl/atcbusdec250.v"
}

read_verilog -sv "$NDS_HOME/andes_ip/peripheral_ip/atchl2h200/hdl/atchl2h200.v"

#read_verilog -sv "$NDS_HOME/andes_ip/peripheral_ip/atcaxi2ahb100/hdl/atcaxi2ahb100.v"
read_verilog -sv "$NDS_HOME/andes_ip/macro/nds_sync_fifo_afe.v"

#read_verilog -sv "$NDS_HOME/andes_ip/n22_core/memory/fpga_xilinx/vc_btb_ram.v"
read_verilog -sv "$NDS_HOME/andes_ip/n22_core/memory/fpga_xilinx/n22_dlm_ram.v"
read_verilog -sv "$NDS_HOME/andes_ip/n22_core/memory/fpga_xilinx/n22_ilm_ram.v"

if {$NDS_ICACHE_SIZE_KB != 0} {
	read_verilog -sv "$NDS_HOME/andes_ip/n22_core/memory/fpga_xilinx/n22_icache_ram.v"
}

#if {$NDS_DCACHE_SIZE_KB != 0} {
#	read_verilog -sv "$NDS_HOME/andes_ip/n22_core/memory/fpga_xilinx/vc_dcache_ram.v"
#}

#if {$mmu_support} {
#	read_verilog -sv "$NDS_HOME/andes_ip/n22_core/memory/fpga_xilinx/vc_stlb_ram.v"
#}
#if {$platform == "ae350"} {
#	if {$NDS_DCACHE_SIZE_KB != 0} {
#		if {$NDS_HART_BIU_BUS == "acu"} {
#			read_verilog -sv "$NDS_HOME/andes_ip/n22_core/memory/fpga_xilinx/vc_dtag_ram.v"
#		}
#	}
#	if {$NDS_L2C_CACHE_SIZE_KB != 0} {
#		if {$NDS_L2C_SUPPORT == "yes"} {
#			read_verilog -sv "$NDS_HOME/andes_ip/vc_mpcore/l2c/memory/fpga_xilinx/vc_l2c_ram.v"
#		}
#	}
#}
#if {$platform == "ae250"} {
	read_verilog -sv "$NDS_HOME/andes_ip/${platform}/top/hdl/${platform}_cpu_uncore.v"
#} else {	# ae350
#	# read_verilog -sv "$NDS_HOME/andes_ip/${platform}/top/hdl/${platform}_cpu_uncore.v"
#	read_verilog -sv "$NDS_HOME/andes_ip/peripheral_ip/atcbusdec350/hdl/atcbusdec350.v"
#}

#if {$NDS_FPU_TYPE != "none"} {
#	read_verilog -sv "$NDS_HOME/andes_ip/n22_core/fpu/hdl/vc_fpu_rf.v"
#	read_verilog -sv "$NDS_HOME/andes_ip/n22_core/fpu/hdl/vc_fpu_mul.v"
#	read_verilog -sv "$NDS_HOME/andes_ip/n22_core/fpu/hdl/vc_fpipe.v"
#	read_verilog -sv "$NDS_HOME/andes_ip/n22_core/fpu/hdl/vc_fpu.v"
#	read_verilog -sv "$NDS_HOME/andes_ip/n22_core/fpu/hdl/vc_fpu_dsu.v"
#	read_verilog -sv "$NDS_HOME/andes_ip/n22_core/fpu/hdl/vc_csa3_2.v"
#	read_verilog -sv "$NDS_HOME/andes_ip/n22_core/fpu/hdl/vc_fpu_eu.v"
#}
if {[file exists "$NDS_HOME/andes_ip/soc/nceeic100/hdl/nceeic100.v"]} {
read_verilog -sv "$NDS_HOME/andes_ip/soc/nceeic100/hdl/nceeic100.v"
}
if {[file exists "$NDS_HOME/andes_ip/n22_core/memory/fpga_xilinx/n22_eic_ram.v"]} {
read_verilog -sv "$NDS_HOME/andes_ip/n22_core/memory/fpga_xilinx/n22_eic_ram.v"
}
if {[file exists "$NDS_HOME/andes_ip/peripheral_ip/atcsyncdn100/hdl/atcsyncdn100.v"]} {
read_verilog -sv "$NDS_HOME/andes_ip/peripheral_ip/atcsyncdn100/hdl/atcsyncdn100.v"
}

