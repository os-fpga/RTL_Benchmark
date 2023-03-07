	set optional_hdl_file_list [list\
		"$NDS_HOME/andes_ip/peripheral_ip/atcbmc300/hdl/atcbmc300.v" \
		"$NDS_HOME/andes_ip/peripheral_ip/atcbmc300/hdl/atcbmc300_us_axi.v" \
	        "$NDS_HOME/andes_ip/peripheral_ip/atcbmc300/hdl/atcbmc300_ds_axi.v" \
		"$NDS_HOME/andes_ip/peripheral_ip/atcbmc300/hdl/atcbmc300_us_read_addr_ctrl.v" \
	        "$NDS_HOME/andes_ip/peripheral_ip/atcbmc300/hdl/atcbmc300_us_write_addr_ctrl.v" \
		"$NDS_HOME/andes_ip/peripheral_ip/atcbmc300/hdl/atcbmc300_us_wdata_ctrl.v" \
		"$NDS_HOME/andes_ip/peripheral_ip/atcbmc300/hdl/atcbmc300_us_resp_ctrl.v" \
		"$NDS_HOME/andes_ip/peripheral_ip/atcbmc300/hdl/atcbmc300_ds_addr_ctrl.v" \
		"$NDS_HOME/andes_ip/peripheral_ip/atcbmc300/hdl/atcbmc300_ds_wdata_bresp_ctrl.v" \
		"$NDS_HOME/andes_ip/peripheral_ip/atcbmc300/hdl/atcbmc300_ds_rdata_ctrl.v" \
		"$NDS_HOME/andes_ip/peripheral_ip/atcbmc300/hdl/atcbmc300_internal_slave.v" \
		"$NDS_HOME/andes_ip/peripheral_ip/atcmstmux100/hdl/atcmstmux100.v" \
		"$NDS_HOME/andes_ip/peripheral_ip/atcmstmux100/hdl/atcmstmux100_exec.v" \
		"$NDS_HOME/andes_ip/peripheral_ip/atcmstmux100/hdl/atcmstmux100_mst_ctrl.v" \
		"$NDS_HOME/andes_ip/peripheral_ip/atcmstmux100/hdl/atcmstmux100_mux.v" \
		"$NDS_HOME/andes_ip/peripheral_ip/atcahb2axi200/hdl/atcahb2axi200.v" \
		"$NDS_HOME/andes_ip/peripheral_ip/atcahb2axi200/hdl/atcahb2axi200_ahb2fifo.v" \
		"$NDS_HOME/andes_ip/peripheral_ip/atcahb2axi200/hdl/atcahb2axi200_fifo2axi.v" \
		"$NDS_HOME/andes_ip/peripheral_ip/atcaxi2ahb200/hdl/atcaxi2ahb200.v" \
		"$NDS_HOME/andes_ip/peripheral_ip/atcaxi2ahb200/hdl/fifo2ahb.v" \
		"$NDS_HOME/andes_ip/peripheral_ip/atcsizeup300/hdl/atcsizeup300.v" \
		"$NDS_HOME/andes_ip/peripheral_ip/atcsizedn300/hdl/atcsizedn300.v" \
		"$NDS_HOME/andes_ip/peripheral_ip/atcsizedn300/hdl/atcsizedn300_addr_downsizer.v" \
	        "$NDS_HOME/andes_ip/peripheral_ip/atcsizedn300/hdl/atcsizedn300_data_downsizer.v" \
		"$NDS_HOME/andes_ip/peripheral_ip/atcbusdec200/hdl/atcbusdec200.v" \
		"$NDS_HOME/andes_ip/peripheral_ip/atcexmon300/hdl/atcexmon300.v" \
		"$NDS_HOME/andes_ip/peripheral_ip/atcexmon300/hdl/atcexmon300_arb_fp.v" \
		"$NDS_HOME/andes_ip/peripheral_ip/atcexmon300/hdl/atcexmon300_bin2mask.v" \
		"$NDS_HOME/andes_ip/peripheral_ip/atcexmon300/hdl/atcexmon300_bin2size.v" \
		"$NDS_HOME/andes_ip/peripheral_ip/atcexmon300/hdl/atcexmon300_ent.v" \
		"$NDS_HOME/andes_ip/peripheral_ip/atcexmon300/hdl/atcexmon300_lfsr.v" \
		"$NDS_HOME/andes_ip/peripheral_ip/atcexmon300/hdl/atcexmon300_pending_cnt.v" \
		"$NDS_HOME/andes_ip/macro/nds_sync_fifo_data.v" \
		"$NDS_HOME/andes_ip/macro/nds_async_fifo_afe.v" \
		"$NDS_HOME/andes_ip/macro/nds_async_buff.v" \
		"$NDS_HOME/andes_ip/macro/nds_sync_fifo_afe.v" \
		"$NDS_HOME/andes_ip/soc/ncepldm200/hdl/ncepldm200.v" \
		"$NDS_HOME/andes_ip/soc/nceplic100/hdl/nceplic100.v" \
		"$NDS_HOME/andes_ip/soc/nceplmt100/hdl/nceplmt100.v" \
		"$NDS_HOME/andes_ip/soc/nceplmt100/hdl/nceplmt100_busif.v" \
		"$NDS_HOME/andes_ip/soc/nceplmt100/hdl/nceplmt100_rtc.v" \
		"$NDS_HOME/andes_ip/soc/ncejdtm200/hdl/ncejdtm200.v" \
		"$NDS_HOME/andes_ip/soc/ncejdtm200/hdl/ncejdtm200_dmi.v" \
		"$NDS_HOME/andes_ip/soc/ncejdtm200/hdl/ncejdtm200_tap.v" \
		"$NDS_HOME/andes_ip/soc/ncedbglock100/hdl/ncedbglock100.v" \
		"$NDS_HOME/andes_ip/ae350/top/hdl/ae350_ram_subsystem.v" \
		"$NDS_HOME/andes_ip/peripheral_ip/atcrambrg300/hdl/atcrambrg300.v" \
		"$NDS_HOME/andes_ip/ae350/top/hdl/sample_ae350_smu.v" \
		"$NDS_HOME/andes_ip/ae350/top/hdl/sample_ae350_smu_apbif.v" \
		"$NDS_HOME/andes_ip/ae350/top/hdl/sample_ae350_smu_pcs.v" \
		"$NDS_HOME/andes_ip/ae350/top/hdl/sample_ae350_smu_pcs_core.v" \
		"$NDS_HOME/andes_ip/ae350/memory/syn/ae350_rambrg_ram.v" \
	]
        set hdl_file_list [list\
		"$NDS_HOME/andes_ip/ae350/top/hdl/ae350_chip.v" \
		"$NDS_HOME/andes_ip/ae350/top/hdl/ae350_pin.v" \
		"$NDS_HOME/andes_ip/ae350/top/hdl/ae350_pad_lib.v" \
		"$NDS_HOME/andes_ip/ae350/top/hdl/sample_ae350_clkgen.v" \
		"$NDS_HOME/andes_ip/ae350/top/hdl/sample_ae350_rstgen.v" \
		"$NDS_HOME/andes_ip/ae350/top/hdl/ae350_aopd_pin.v" \
		"$NDS_HOME/andes_ip/ae350/top/hdl/sample_ae350_aopd_clkgen.v" \
		"$NDS_HOME/andes_ip/ae350/top/hdl/sample_ae350_aopd_rstgen.v" \
		"$NDS_HOME/andes_ip/ae350/top/hdl/ae350_aopd_testgen.v" \
		"$NDS_HOME/andes_ip/ae350/top/hdl/ae350_aopd.v" \
		"$NDS_HOME/andes_ip/ae350/top/hdl/ae350_bus_connector.v" \
		"$NDS_HOME/andes_ip/ae350/top/hdl/ae350_apb_subsystem.v" \
		"$NDS_HOME/andes_ip/ae350/top/hdl/ae350_ahb_subsystem.v" \
		"$NDS_HOME/andes_ip/ae350/top/hdl/rst_sync.v" \
		"$NDS_HOME/andes_ip/ae350/top/hdl/pd_clk_ctrl.v" \
		"$NDS_HOME/andes_ip/ae350/top/hdl/pd_vol_ctrl.v" \
		"$NDS_HOME/andes_ip/ae350/top/hdl/ae350_vol_ctrl.v" \
		"$NDS_HOME/andes_ip/macro/gck.v" \
		"$NDS_HOME/andes_ip/macro/async_clkmux.v" \
		"$NDS_HOME/andes_ip/macro/nds_lib.v" \
		"$NDS_HOME/andes_ip/macro/nds_rst_sync.v" \
		"$NDS_HOME/andes_ip/macro/nds_sync_l2l.v" \
		"$NDS_HOME/andes_ip/macro/nds_sync_p2p.v" \
		"$NDS_HOME/andes_ip/macro/nds_sync_p2p_data.v" \
        ]
	set sub_module_netlist [list\
		"ae350_cpu_subsystem" \
		"ae350_cpu_cluster_subsystem" \
		"atcapbbrg100" \
		"atcdmac300" \
		"atcgpio100" \
		"atciic100" \
		"atcpit100" \
		"atcrtc100" \
		"atcspi200" \
		"atcuart100" \
		"atcwdt200" \
		"atflcdc100" \
		"atfmac100" \
		"atfsdc010" \
		"atfsmc020" \
		"atfssp020" \
	]

	set incdir [list \
		"$NDS_HOME/andes_ip/kv_core/top/hdl" \
		"$NDS_HOME/andes_ip/ae350/top/hdl/include" \
		"$NDS_HOME/andes_ip/ae350/define" \
        ]
	set optional_incdir [list \
		"$NDS_HOME/andes_ip/peripheral_ip/atcapbbrg100/hdl/include" \
		"$NDS_HOME/andes_ip/peripheral_ip/atcbmc300/hdl/include" \
		"$NDS_HOME/andes_ip/peripheral_ip/atcbusdec200/hdl/include" \
		"$NDS_HOME/andes_ip/peripheral_ip/atcdmac300/hdl/include" \
		"$NDS_HOME/andes_ip/peripheral_ip/atcgpio100/hdl/include" \
		"$NDS_HOME/andes_ip/peripheral_ip/atciic100/hdl/include" \
		"$NDS_HOME/andes_ip/peripheral_ip/atcmstmux100/hdl/include" \
		"$NDS_HOME/andes_ip/peripheral_ip/atcmstmux100_1/hdl/include" \
		"$NDS_HOME/andes_ip/peripheral_ip/atcpit100/hdl/include" \
		"$NDS_HOME/andes_ip/peripheral_ip/atcrtc100/hdl/include" \
		"$NDS_HOME/andes_ip/peripheral_ip/atcspi200/hdl/include" \
		"$NDS_HOME/andes_ip/peripheral_ip/atcuart100/hdl/include" \
		"$NDS_HOME/andes_ip/peripheral_ip/atcwdt200/hdl/include" \
		"$NDS_HOME/andes_ip/peripheral_ip/atflcdc100/hdl/include" \
		"$NDS_HOME/andes_ip/peripheral_ip/atfmac100/hdl/include" \
		"$NDS_HOME/andes_ip/peripheral_ip/atfsdc010/hdl/include" \
		"$NDS_HOME/andes_ip/peripheral_ip/atfsmc020/hdl/include" \
		"$NDS_HOME/andes_ip/peripheral_ip/atfssp020/hdl/include" \
	]

        foreach x $optional_hdl_file_list {
                if {[file exists $x]} {
                        lappend hdl_file_list $x
                }
        }
        foreach y $optional_incdir {
                if {[file exists $y]} {
                        lappend incdir $y
                }
        }
