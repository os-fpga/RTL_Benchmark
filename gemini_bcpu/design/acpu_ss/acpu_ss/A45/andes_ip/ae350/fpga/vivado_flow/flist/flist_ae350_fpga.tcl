set NDS_HOME $env(NDS_HOME)

# ----------------------------------
# Definitaion
# ----------------------------------
#read_verilog -sv "./fpga_config.inc"

# ----------------------------------
# RAM
# ----------------------------------
#read_verilog -sv "$NDS_HOME/vendor_ip/xilinx_ip/xc7k/mem/eilm131072x32.v"
#read_verilog -sv "$NDS_HOME/vendor_ip/xilinx_ip/xc7k/mem/eilmosc131072x32.v"
#read_verilog -sv "$NDS_HOME/vendor_ip/xilinx_ip/xc7k/mem/eilm32768x128.v"
#read_verilog -sv "$NDS_HOME/vendor_ip/xilinx_ip/xc7k/mem/ram131072x32.v"
#read_verilog -sv "$NDS_HOME/vendor_ip/xilinx_ip/xc7k/mem/ram65536x32.v"

# ----------------------------------
# AEX50
# ----------------------------------
read_verilog -sv "$NDS_HOME/andes_ip/${platform}/top/hdl/${platform}_chip.v"
read_verilog -sv "$NDS_HOME/andes_ip/${platform}/top/hdl/sample_${platform}_clkgen.v"
read_verilog -sv "$NDS_HOME/andes_ip/${platform}/top/hdl/sample_${platform}_rstgen.v"
read_verilog -sv "$NDS_HOME/andes_ip/${platform}/top/hdl/${platform}_pin.v"
read_verilog -sv "$NDS_HOME/andes_ip/${platform}/top/hdl/${platform}_pad_lib.v"
read_verilog -sv "$NDS_HOME/andes_ip/${platform}/top/hdl/${platform}_aopd_pin.v"
read_verilog -sv "$NDS_HOME/andes_ip/${platform}/top/hdl/sample_${platform}_aopd_clkgen.v"
read_verilog -sv "$NDS_HOME/andes_ip/${platform}/top/hdl/sample_${platform}_aopd_rstgen.v"
read_verilog -sv "$NDS_HOME/andes_ip/${platform}/top/hdl/${platform}_aopd_testgen.v"
read_verilog -sv "$NDS_HOME/andes_ip/${platform}/top/hdl/${platform}_aopd.v"
if {$ae350_core_clk_dfs} {
read_verilog -sv "$NDS_HOME/andes_ip/${platform}/top/hdl/sample_${platform}_dfs_ctrl_bridge.v"
read_verilog -sv "$NDS_HOME/andes_ip/${platform}/top/hdl/sample_${platform}_dfs_wrapper.v"
}

read_verilog -sv "$NDS_HOME/andes_ip/${platform}/top/hdl/rst_sync.v"
read_verilog -sv "$NDS_HOME/andes_ip/${platform}/top/hdl/pd_clk_ctrl.v"
read_verilog -sv "$NDS_HOME/andes_ip/${platform}/top/hdl/pd_vol_ctrl.v"
read_verilog -sv "$NDS_HOME/andes_ip/${platform}/top/hdl/${platform}_vol_ctrl.v"

read_verilog -sv "$NDS_HOME/andes_ip/${platform}/top/hdl/${platform}_ahb_subsystem.v"
read_verilog -sv "$NDS_HOME/andes_ip/${platform}/top/hdl/${platform}_apb_subsystem.v"
read_verilog -sv "$NDS_HOME/andes_ip/${platform}/top/hdl/${platform}_ram_subsystem.v"

read_verilog -sv "$NDS_HOME/andes_ip/${platform}/top/hdl/${platform}_bus_connector.v"

# ----------------------------------
# Macro cells
# ----------------------------------
read_verilog -sv "$NDS_HOME/andes_ip/macro/async_clkmux.v"
read_verilog -sv "$NDS_HOME/andes_ip/macro/edm_tck_inv.v"
read_verilog -sv "$NDS_HOME/andes_ip/macro/gck.v"
read_verilog -sv "$NDS_HOME/andes_ip/macro/nds_async_buff.v"
read_verilog -sv "$NDS_HOME/andes_ip/macro/nds_async_fifo_afe.v"
read_verilog -sv "$NDS_HOME/andes_ip/macro/nds_async_fifo_clr.v"
read_verilog -sv "$NDS_HOME/andes_ip/macro/nds_async_fifo_data.v"
read_verilog -sv "$NDS_HOME/andes_ip/macro/nds_dffsr.v"
read_verilog -sv "$NDS_HOME/andes_ip/macro/nds_lib.v"
read_verilog -sv "$NDS_HOME/andes_ip/macro/nds_rst_sync.v"
read_verilog -sv "$NDS_HOME/andes_ip/macro/nds_sync_fifo1_data.v"
read_verilog -sv "$NDS_HOME/andes_ip/macro/nds_sync_fifo_afe.v"
read_verilog -sv "$NDS_HOME/andes_ip/macro/nds_sync_fifo_clr.v"
read_verilog -sv "$NDS_HOME/andes_ip/macro/nds_sync_fifo_data.v"
read_verilog -sv "$NDS_HOME/andes_ip/macro/nds_sync_fifo_ll.v"
read_verilog -sv "$NDS_HOME/andes_ip/macro/nds_sync_l2l.v"
read_verilog -sv "$NDS_HOME/andes_ip/macro/nds_sync_p2p.v"
read_verilog -sv "$NDS_HOME/andes_ip/macro/nds_sync_p2p_cl.v"
read_verilog -sv "$NDS_HOME/andes_ip/macro/nds_sync_p2p_data.v"
read_verilog -sv "$NDS_HOME/andes_ip/macro/nds_sync_p2p_data_cl.v"

# ----------------------------------
# Bus Matrix
# ----------------------------------
set ip_path	"atcbmc300"
set ip_rtl_v	[glob -nocomplain $NDS_HOME/andes_ip/peripheral_ip/$ip_path/hdl/*.v]
foreach ip_rtl_code "$ip_rtl_v" {
	read_verilog -sv $ip_rtl_code
}

# ----------------------------------
# APB Bridge
# ----------------------------------
read_verilog -sv "$NDS_HOME/andes_ip/peripheral_ip/atcapbbrg100/hdl/atcapbbrg100.v"

# ----------------------------------
# APB Decoder
# ----------------------------------
# read_verilog -sv "$NDS_HOME/andes_ip/peripheral_ip/atcapbdec100/hdl/atcapbdec100.v"

# ----------------------------------
# SPI
# ----------------------------------
if {$spi_support} {
	read_verilog -sv "$NDS_HOME/andes_ip/peripheral_ip/atcspi200/hdl/atcspi200.v"
	read_verilog -sv "$NDS_HOME/andes_ip/peripheral_ip/atcspi200/hdl/atcspi200_ahbif_ctrl.v"
	read_verilog -sv "$NDS_HOME/andes_ip/peripheral_ip/atcspi200/hdl/atcspi200_eilmif_ctrl.v"
	read_verilog -sv "$NDS_HOME/andes_ip/peripheral_ip/atcspi200/hdl/atcspi200_regif.v"
	read_verilog -sv "$NDS_HOME/andes_ip/peripheral_ip/atcspi200/hdl/atcspi200_reg.v"
	read_verilog -sv "$NDS_HOME/andes_ip/peripheral_ip/atcspi200/hdl/atcspi200_regif_ctrl.v"
	read_verilog -sv "$NDS_HOME/andes_ip/peripheral_ip/atcspi200/hdl/atcspi200_arbiter.v"
	read_verilog -sv "$NDS_HOME/andes_ip/peripheral_ip/atcspi200/hdl/atcspi200_ctrl.v"
	read_verilog -sv "$NDS_HOME/andes_ip/peripheral_ip/atcspi200/hdl/atcspi200_spiif.v"
	read_verilog -sv "$NDS_HOME/andes_ip/peripheral_ip/atcspi200/hdl/atcspi200_fifo.v"
	read_verilog -sv "$NDS_HOME/andes_ip/peripheral_ip/atcspi200/hdl/atcspi200_sync.v"
}

# ----------------------------------
# I2C
# ----------------------------------
if {$iic_support} {
	read_verilog -sv "$NDS_HOME/andes_ip/peripheral_ip/atciic100/hdl/atciic100.v"
	read_verilog -sv "$NDS_HOME/andes_ip/peripheral_ip/atciic100/hdl/atciic100_apbslv.v"
	read_verilog -sv "$NDS_HOME/andes_ip/peripheral_ip/atciic100/hdl/atciic100_ctrl.v"
	read_verilog -sv "$NDS_HOME/andes_ip/peripheral_ip/atciic100/hdl/atciic100_fifo.v"
	read_verilog -sv "$NDS_HOME/andes_ip/peripheral_ip/atciic100/hdl/atciic100_gsf.v"
}

# ----------------------------------
# UART
# ----------------------------------
if {$uart_support} {
	read_verilog -sv "$NDS_HOME/andes_ip/peripheral_ip/atcuart100/hdl/atcuart100.v"
	read_verilog -sv "$NDS_HOME/andes_ip/peripheral_ip/atcuart100/hdl/atcuart100_apbif_reg.v"
	read_verilog -sv "$NDS_HOME/andes_ip/peripheral_ip/atcuart100/hdl/atcuart100_baud.v"
	read_verilog -sv "$NDS_HOME/andes_ip/peripheral_ip/atcuart100/hdl/atcuart100_modem.v"
	read_verilog -sv "$NDS_HOME/andes_ip/peripheral_ip/atcuart100/hdl/atcuart100_rxctrl.v"
	read_verilog -sv "$NDS_HOME/andes_ip/peripheral_ip/atcuart100/hdl/atcuart100_txctrl.v"
	read_verilog -sv "$NDS_HOME/andes_ip/peripheral_ip/atcuart100/hdl/atcuart100_uart_rx.v"
	read_verilog -sv "$NDS_HOME/andes_ip/peripheral_ip/atcuart100/hdl/atcuart100_uart_tx.v"
}

# ----------------------------------
# WDT
# ----------------------------------
read_verilog -sv "$NDS_HOME/andes_ip/peripheral_ip/atcwdt200/hdl/atcwdt200.v"

# ----------------------------------
# GPIO
# ----------------------------------
read_verilog -sv "$NDS_HOME/andes_ip/peripheral_ip/atcgpio100/hdl/atcgpio100.v"
read_verilog -sv "$NDS_HOME/andes_ip/peripheral_ip/atcgpio100/hdl/atcgpio100_apbslv.v"
read_verilog -sv "$NDS_HOME/andes_ip/peripheral_ip/atcgpio100/hdl/atcgpio100_gpio.v"

# ----------------------------------
# PIT
# ----------------------------------
read_verilog -sv "$NDS_HOME/andes_ip/peripheral_ip/atcpit100/hdl/atcpit100.v"
read_verilog -sv "$NDS_HOME/andes_ip/peripheral_ip/atcpit100/hdl/atcpit100_apbslv.v"
read_verilog -sv "$NDS_HOME/andes_ip/peripheral_ip/atcpit100/hdl/atcpit100_ch.v"
read_verilog -sv "$NDS_HOME/andes_ip/peripheral_ip/atcpit100/hdl/atcpit100_cntr.v"

# ----------------------------------
# RTC
# ----------------------------------
read_verilog -sv "$NDS_HOME/andes_ip/peripheral_ip/atcrtc100/hdl/atcrtc100.v"
read_verilog -sv "$NDS_HOME/andes_ip/peripheral_ip/atcrtc100/hdl/atcrtc100_apbif.v"
read_verilog -sv "$NDS_HOME/andes_ip/peripheral_ip/atcrtc100/hdl/atcrtc100_counter.v"
read_verilog -sv "$NDS_HOME/andes_ip/peripheral_ip/atcrtc100/hdl/atcrtc100_pulsegen.v"

# ----------------------------------
# SMU
# ----------------------------------
read_verilog -sv "$NDS_HOME/andes_ip/ae350/top/hdl/sample_ae350_smu.v"
read_verilog -sv "$NDS_HOME/andes_ip/ae350/top/hdl/sample_ae350_smu_apbif.v"
read_verilog -sv "$NDS_HOME/andes_ip/ae350/top/hdl/sample_ae350_smu_pcs.v"
read_verilog -sv "$NDS_HOME/andes_ip/ae350/top/hdl/sample_ae350_smu_pcs_core.v"

# ----------------------------------
# Device Tree ROM
# ----------------------------------
if {$dtrom_support} {
	read_verilog -sv "$NDS_HOME/andes_ip/peripheral_ip/sample_dtrom/hdl/sample_dtrom.v"
}

# ----------------------------------
# ATCDMACX00
# ----------------------------------
if {$dmac_support} {
	set ip_path		"atcdmac300"
	set ip_rtl_v	[glob -nocomplain $NDS_HOME/andes_ip/peripheral_ip/$ip_path/hdl/*.v]
	foreach ip_rtl_code "$ip_rtl_v" {
		read_verilog -sv $ip_rtl_code
	}
}
# ----------------------------------
# ATCSIZEDN300
# ----------------------------------
read_verilog -sv "$NDS_HOME/andes_ip/peripheral_ip/atcsizedn300/hdl/atcsizedn300.v"
read_verilog -sv "$NDS_HOME/andes_ip/peripheral_ip/atcsizedn300/hdl/atcsizedn300_addr_downsizer.v"
read_verilog -sv "$NDS_HOME/andes_ip/peripheral_ip/atcsizedn300/hdl/atcsizedn300_data_downsizer.v"


read_verilog -sv "$NDS_HOME/andes_ip/peripheral_ip/atcexmon300/hdl/atcexmon300.v"
read_verilog -sv "$NDS_HOME/andes_ip/peripheral_ip/atcexmon300/hdl/atcexmon300_arb_fp.v"
read_verilog -sv "$NDS_HOME/andes_ip/peripheral_ip/atcexmon300/hdl/atcexmon300_bin2mask.v"
read_verilog -sv "$NDS_HOME/andes_ip/peripheral_ip/atcexmon300/hdl/atcexmon300_bin2size.v"
read_verilog -sv "$NDS_HOME/andes_ip/peripheral_ip/atcexmon300/hdl/atcexmon300_ent.v"
read_verilog -sv "$NDS_HOME/andes_ip/peripheral_ip/atcexmon300/hdl/atcexmon300_lfsr.v"
read_verilog -sv "$NDS_HOME/andes_ip/peripheral_ip/atcexmon300/hdl/atcexmon300_pending_cnt.v"

# ----------------------------------
# ATCAXI2AHB200
# ----------------------------------
read_verilog -sv "$NDS_HOME/andes_ip/peripheral_ip/atcaxi2ahb200/hdl/atcaxi2ahb200.v"
read_verilog -sv "$NDS_HOME/andes_ip/peripheral_ip/atcaxi2ahb200/hdl/fifo2ahb.v"

# ----------------------------------
# ATCBUSDEC200
# ----------------------------------
read_verilog -sv "$NDS_HOME/andes_ip/peripheral_ip/atcbusdec200/hdl/atcbusdec200.v"









	read_verilog -sv "$NDS_HOME/andes_ip/${platform}/memory/fpga_xilinx/${platform}_rambrg_ram.v"


# ----------------------------------
# PLIC
# ----------------------------------
if {[file isdirectory "$NDS_HOME/andes_ip/soc/nceplic100"]} {
# Vivado 2016 bugs
set_msg_config -suppress -id "Synth 8-5788" -string "gateway_interrupt_inflight_reg in module nceplic100"
set_msg_config -suppress -id "Synth 8-5788" -string "interrupt_pending_reg_reg in module nceplic100"
set_msg_config -suppress -id "Synth 8-5788" -string "target_enable_reg_reg in module nceplic100"
set_msg_config -suppress -id "Synth 8-5788" -string "claim_mask_reg in module nceplic100"
set_msg_config -suppress -id "Synth 8-5788" -string "target_preempted_priority_stack_reg_reg in module nceplic100"
	
read_verilog -sv "$NDS_HOME/andes_ip/soc/nceplic100/hdl/nceplic100.v"
read_verilog -sv "$NDS_HOME/andes_ip/soc/nceplic100/hdl/nceplic100_core.v"
read_verilog -sv "$NDS_HOME/andes_ip/soc/nceplic100/hdl/nceplic100_busif.v"
}

# ----------------------------------
# Debug Subsystem
# ----------------------------------
# PLDM200
if {[file isdirectory "$NDS_HOME/andes_ip/soc/ncepldm200"]} {
read_verilog -sv "$NDS_HOME/andes_ip/soc/ncepldm200/hdl/ncepldm200.v"
}
# JDTM200
if {[file isdirectory $NDS_HOME/andes_ip/soc/ncejdtm200]} {
    read_verilog -sv  [glob $NDS_HOME/andes_ip/soc/ncejdtm200/hdl/*.v]
}
# DBGLOCK100
if {[file isdirectory $NDS_HOME/andes_ip/soc/ncedbglock100]} {
    read_verilog -sv  [glob $NDS_HOME/andes_ip/soc/ncedbglock100/hdl/*.v]
}

# ----------------------------------
# PLMT
# ----------------------------------
if {[file isdirectory "$NDS_HOME/andes_ip/soc/nceplmt100"]} {
read_verilog -sv "$NDS_HOME/andes_ip/soc/nceplmt100/hdl/nceplmt100.v"
read_verilog -sv "$NDS_HOME/andes_ip/soc/nceplmt100/hdl/nceplmt100_busif.v"
read_verilog -sv "$NDS_HOME/andes_ip/soc/nceplmt100/hdl/nceplmt100_rtc.v"
}

# ----------------------------------
# NCEL2C
# ----------------------------------
if {[file isdirectory "$NDS_HOME/andes_ip/soc/ncel2c500"]} {
    read_verilog -sv  [glob $NDS_HOME/andes_ip/soc/ncel2c500/hdl/*.v]
}

