	set hdl_file_list [list\
		"$NDS_HOME/andes_ip/macro/gck.v" \
		"$NDS_HOME/andes_ip/macro/async_clkmux.v" \
		"$NDS_HOME/andes_ip/macro/nds_lib.v" \
		"$NDS_HOME/andes_ip/macro/nds_sync_l2l.v" \
		"$NDS_HOME/andes_ip/macro/nds_sync_p2p.v" \
		"$NDS_HOME/andes_ip/macro/nds_sync_p2p_data.v" \
		"$NDS_HOME/andes_ip/ae250/top/hdl/ae250_chip.v" \
		"$NDS_HOME/andes_ip/ae250/top/hdl/ae250_pin.v" \
		"$NDS_HOME/andes_ip/ae250/top/hdl/ae250_pad_lib.v" \
		"$NDS_HOME/andes_ip/ae250/top/hdl/ae250_clkgen.v" \
		"$NDS_HOME/andes_ip/ae250/top/hdl/ae250_rstgen.v" \
		"$NDS_HOME/andes_ip/ae250/top/hdl/ae250_testgen.v" \
		"$NDS_HOME/andes_ip/ae250/top/hdl/ae250_smu.v" \
		"$NDS_HOME/andes_ip/ae250/top/hdl/ae250_smu_aopd_core.v" \
		"$NDS_HOME/andes_ip/ae250/top/hdl/ae250_smu_aopd_top.v" \
		"$NDS_HOME/andes_ip/ae250/top/hdl/ae250_smu_mpd.v" \
		"$NDS_HOME/andes_ip/ae250/top/hdl/ae250_smu_pd.v" \
		"$NDS_HOME/andes_ip/ae250/top/hdl/ae250_smu_apbif.v" \
		"$NDS_HOME/andes_ip/ae250/top/hdl/ae250_aopd_pin.v" \
		"$NDS_HOME/andes_ip/ae250/top/hdl/ae250_aopd_clkgen.v" \
		"$NDS_HOME/andes_ip/ae250/top/hdl/ae250_aopd_rstgen.v" \
		"$NDS_HOME/andes_ip/ae250/top/hdl/ae250_aopd_testgen.v" \
		"$NDS_HOME/andes_ip/ae250/top/hdl/ae250_debug_subsystem.v" \
		"$NDS_HOME/andes_ip/ae250/top/hdl/ae250_ram_subsystem.v" \
		"$NDS_HOME/andes_ip/peripheral_ip/atcrambrg200/hdl/atcrambrg200.v" \
		"$NDS_HOME/andes_ip/ae250/memory/syn/ae250_rambrg_ram.v" \
	]

if {[file isdirectory "$NDS_HOME/andes_ip/soc/ncepldm200"]} {
	lappend hdl_file_list "$NDS_HOME/andes_ip/soc/ncepldm200/hdl/ncepldm200.v"
}

if {[file isdirectory "$NDS_HOME/andes_ip/soc/nceplic100"]} {
	lappend hdl_flie_list "$NDS_HOME/andes_ip/soc/nceplic100/hdl/nceplic100.v"
}

if {[file isdirectory "$NDS_HOME/andes_ip/soc/nceplmt100"]} {
	lappend hdl_flie_list "$NDS_HOME/andes_ip/soc/nceplmt100/hdl/nceplmt100.v"
	lappend hdl_flie_list "$NDS_HOME/andes_ip/soc/nceplmt100/hdl/nceplmt100_ahbif.v"
	lappend hdl_flie_list "$NDS_HOME/andes_ip/soc/nceplmt100/hdl/nceplmt100_rtc.v"
}

if {[file isdirectory "$NDS_HOME/andes_ip/soc/ncejdtm200"]} {
	lappend hdl_flie_list "$NDS_HOME/andes_ip/soc/ncejdtm200/hdl/ncejdtm200.v"
	lappend hdl_flie_list "$NDS_HOME/andes_ip/soc/ncejdtm200/hdl/ncejdtm200_dmi.v"
	lappend hdl_flie_list "$NDS_HOME/andes_ip/soc/ncejdtm200/hdl/ncejdtm200_tap.v"
}

	set sub_module_netlist [list\
		"ae250_cpu_subsystem" \
		"atcapbbrg100" \
		"atcbmc200" \
		"atcgpio100" \
		"atcpit100" \
		"atcrtc100" \
		"atcspi200" \
		"atcuart100" \
		"atcwdt200" \
	]

if {[file isdirectory "$NDS_HOME/andes_ip/peripheral_ip/atcdmac100"]} {
	lappend sub_module_netlist "atcdmac100" \
}

if {[file isdirectory "$NDS_HOME/andes_ip/peripheral_ip/atciic100"]} {
	lappend sub_module_netlist "atciic100"
}

	set incdir [list \
		"$NDS_HOME/andes_ip/vc_core/top/hdl" \
		"$NDS_HOME/andes_ip/ae250/top/hdl/include" \
		"$NDS_HOME/andes_ip/ae250/define" \
		"$NDS_HOME/andes_ip/peripheral_ip/atcapbbrg100/hdl/include" \
		"$NDS_HOME/andes_ip/peripheral_ip/atcbmc200/hdl/include" \
		"$NDS_HOME/andes_ip/peripheral_ip/atcgpio100/hdl/include" \
		"$NDS_HOME/andes_ip/peripheral_ip/atcpit100/hdl/include" \
		"$NDS_HOME/andes_ip/peripheral_ip/atcrtc100/hdl/include" \
		"$NDS_HOME/andes_ip/peripheral_ip/atcspi200/hdl/include" \
		"$NDS_HOME/andes_ip/peripheral_ip/atcuart100/hdl/include" \
		"$NDS_HOME/andes_ip/peripheral_ip/atcwdt200/hdl/include" \
	]

if {[file isdirectory "$NDS_HOME/andes_ip/peripheral_ip/atcdmac100"]} {
	lappend incdir "$NDS_HOME/andes_ip/peripheral_ip/atcdmac100/hdl/include" \
}

if {[file isdirectory "$NDS_HOME/andes_ip/peripheral_ip/atciic100"]} {
	lappend incdir "$NDS_HOME/andes_ip/peripheral_ip/atciic100/hdl/include"
}
