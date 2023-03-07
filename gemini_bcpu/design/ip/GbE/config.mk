ABS_PATH := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))

RTL_INC := $(ABS_PATH) \
           $(ABS_PATH)hdl

RTL_STUB := $(ABS_PATH)stub/gbe_top.sv

MODEL_SRC := $(ABS_PATH)../../../lib/mem/dti_dp_tm16fcll_512x32_4ww2xoe_m_hc/dti_dp_tm16fcll_512x32_4ww2xoe_m_hc.v 

RTL_SRC :=$(ABS_PATH)/gbe_top.sv \
          $(ABS_PATH)hdl/gem_gxl.v \
          $(ABS_PATH)hdl/gem_ss.v \
          $(ABS_PATH)hdl/gem_top.v \
          $(ABS_PATH)hdl/gem_mii_bridge.v \
          $(ABS_PATH)hdl/gem_stripe.v \
          $(ABS_PATH)hdl/gem_filter.v \
          $(ABS_PATH)hdl/gem_rx_decode.v \
          $(ABS_PATH)hdl/gem_rx_pfc_counter.v \
          $(ABS_PATH)hdl/gem_rx.v \
          $(ABS_PATH)hdl/gem_tx_state.v \
          $(ABS_PATH)hdl/gem_tx.v \
          $(ABS_PATH)hdl/gem_tx_wrap.v \
          $(ABS_PATH)hdl/gem_loop.v \
          $(ABS_PATH)hdl/gem_mac.v \
          $(ABS_PATH)hdl/gem_ext_fifo_mux.v \
          $(ABS_PATH)hdl/gem_registers.v \
          $(ABS_PATH)hdl/gem_reg_rx_q_flush.v \
          $(ABS_PATH)hdl/gem_reg_enst.v \
          $(ABS_PATH)hdl/gem_reg_phy_man.v \
          $(ABS_PATH)hdl/gem_reg_int.v \
          $(ABS_PATH)hdl/gem_reg_nwc.v \
          $(ABS_PATH)hdl/gem_reg_sched.v \
          $(ABS_PATH)hdl/gem_reg_sched_ctrl.v \
          $(ABS_PATH)hdl/gem_reg_filters.v \
          $(ABS_PATH)hdl/gem_reg_int_sts.v \
          $(ABS_PATH)hdl/gem_reg_stats.v \
          $(ABS_PATH)hdl/gem_reg_designcfg_dbg.v \
          $(ABS_PATH)hdl/gem_pclk_syncs.v \
          $(ABS_PATH)hdl/gem_reg_top.v \
          $(ABS_PATH)hdl/gem_screener_top.v \
          $(ABS_PATH)hdl/gem_tx_fifo_if.v \
          $(ABS_PATH)hdl/gem_mac_lockup_detect.v \
          $(ABS_PATH)hdl/gem_tx_lockup_detect.v \
          $(ABS_PATH)hdl/gem_rx_lockup_detect.v \
          $(ABS_PATH)hdl/gem_pulse_tsync.v \
          $(ABS_PATH)hdl/gem_rx_per_queue_flush.v \
          $(ABS_PATH)hdl/gem_rx_per_scr2_rate_lim.v \
          $(ABS_PATH)hdl/gem_par_chk_regen.v \
          $(ABS_PATH)hdl/rgmii.v \
          $(ABS_PATH)hdl/gem_screener_type1.v \
          $(ABS_PATH)hdl/gem_screener_type2.v \
          $(ABS_PATH)hdl/gem_reg_scrn.v \
          $(ABS_PATH)hdl/cdnsdru_datasync_v1.v \
          $(ABS_PATH)hdl/gem_bus_sync.v \
          $(ABS_PATH)hdl/edma_pbuf_ahb_tx_wr.v \
          $(ABS_PATH)hdl/edma_pbuf_ahb_tx_rd.v \
          $(ABS_PATH)hdl/edma_pbuf_ahb_fe_arb.v \
          $(ABS_PATH)hdl/edma_pbuf_ahb_fe_mux.v \
          $(ABS_PATH)hdl/edma_gen_async_fifo_look_ahead.v \
          $(ABS_PATH)hdl/edma_gen_timer_v0.v \
          $(ABS_PATH)hdl/edma_gen_async_fifo.v \
          $(ABS_PATH)hdl/edma_gear_change_async.v \
          $(ABS_PATH)hdl/edma_spram_tx_mac_buffer.v \
          $(ABS_PATH)hdl/edma_pbuf_ahb_top.v \
          $(ABS_PATH)hdl/edma_spram_controller.v \
          $(ABS_PATH)hdl/edma_pbuf_ahb_tx.v \
          $(ABS_PATH)hdl/edma_pbuf_ahb_fe.v \
          $(ABS_PATH)hdl/edma_gen_fifo.v \
          $(ABS_PATH)hdl/edma_sync_toggle_detect.v \
          $(ABS_PATH)hdl/edma_toggle_generate.v \
          $(ABS_PATH)hdl/edma_toggle_detect.v \
          $(ABS_PATH)hdl/edma_tx_sched.v \
          $(ABS_PATH)hdl/edma_tx_sched_ets_count.v \
          $(ABS_PATH)hdl/edma_pbuf_tx_enst.v \
          $(ABS_PATH)hdl/edma_pbuf_tx_enst_fsm.v \
          $(ABS_PATH)hdl/edma_pbuf_tx_enst_fc.v \
          $(ABS_PATH)hdl/edma_axi_arbiter.v \
          $(ABS_PATH)hdl/gem_mmsl.v \
          $(ABS_PATH)hdl/gem_mmsl_ver.v \
          $(ABS_PATH)hdl/gem_mmsl_tx_proc.v \
          $(ABS_PATH)hdl/gem_mmsl_rx_proc.v \
          $(ABS_PATH)hdl/gem_mmsl_rx_exp_flt.v \
          $(ABS_PATH)hdl/gem_mmsl_reg.v \
          $(ABS_PATH)hdl/gem_mmsl_reg_int_sts.v \
          $(ABS_PATH)hdl/gem_mmsl_apb_switch.v \
          $(ABS_PATH)hdl/gem_mmsl_rx_output_driver.v \
          $(ABS_PATH)hdl/gem_mmsl_rx_group16_sys.v \
          $(ABS_PATH)hdl/gem_mmsl_rx_smd_decode.v \
          $(ABS_PATH)hdl/cdnsdru_asf_fault_log_rpt_v2.v \
          $(ABS_PATH)hdl/cdnsdru_asf_fault_log_rpt_csr_v2.v \
          $(ABS_PATH)hdl/edma_tx_lockup_detect.v \
          $(ABS_PATH)hdl/edma_rx_lockup_detect.v \
          $(ABS_PATH)hdl/edma_gen_cnt_to.v \
          $(ABS_PATH)hdl/cdnsdru_asf_trans_timeout_v1.v \
          $(ABS_PATH)hdl/edma_arith_par.v \
          $(ABS_PATH)hdl/edma_lockup_detect.v \
          $(ABS_PATH)hdl/cdnsdru_asf_sram_protect_v1.v \
          $(ABS_PATH)hdl/edma_hclk_syncs.v \
          $(ABS_PATH)hdl/edma_pbuf_rx.v \
          $(ABS_PATH)hdl/edma_pbuf_rx_wr.v \
          $(ABS_PATH)hdl/edma_pbuf_rx_rd.v \
          $(ABS_PATH)hdl/edma_pbuf_rx_align.v \
          $(ABS_PATH)hdl/edma_pbuf_tx_tcp.v \
          $(ABS_PATH)hdl/edma_pbuf_tx_align.v \
          $(ABS_PATH)hdl/edma_pkt_decode.v \
          $(ABS_PATH)hdl/edma_csum.v \
          $(ABS_PATH)hdl/edma_field_decode.v \
          $(ABS_PATH)hdl/edma_gen_fifo_2rp.v \
          $(ABS_PATH)hdl/edma_pbuf_dpram_width_upsize.v \
          $(ABS_PATH)hdl/edma_pbuf_dpram_width_downsize.v \
          $(ABS_PATH)hdl/gem_reg_dma.v \
          $(ABS_PATH)hdl/gem_pclk_syncs_sram_stats.v \
          $(ABS_PATH)hdl/edma_pbuf_axi_top.v \
          $(ABS_PATH)hdl/edma_pbuf_axi_fe.v \
          $(ABS_PATH)hdl/edma_pbuf_axi_fe_tx.v \
          $(ABS_PATH)hdl/edma_pbuf_axi_fe_rx.v \
          $(ABS_PATH)hdl/edma_pbuf_axi_fe_desc_buff.v \
          $(ABS_PATH)hdl/edma_pbuf_axi_fe_hdr_parse.v \
          $(ABS_PATH)hdl/edma_pbuf_axi_tx.v \
          $(ABS_PATH)hdl/edma_pbuf_axi_tx_wr.v \
          $(ABS_PATH)hdl/edma_pbuf_axi_tx_rd.v \
          $(ABS_PATH)hdl/gem_tsu.v \
          $(ABS_PATH)hdl/gem_reg_tsu.v \
          $(ABS_PATH)/gem_gxl_defs.v

LIB_SRC := $(ABS_PATH)../../../lib/mem/dti_dp_tm16fcll_512x32_4ww2xoe_m_hc/dti_dp_tm16fcll_512x32_4ww2xoe_m_hc_best.lib \
           $(ABS_PATH)../../../lib/mem/dti_dp_tm16fcll_512x32_4ww2xoe_m_hc/dti_dp_tm16fcll_512x32_4ww2xoe_m_hc_bestzero.lib \
           $(ABS_PATH)../../../lib/mem/dti_dp_tm16fcll_512x32_4ww2xoe_m_hc/dti_dp_tm16fcll_512x32_4ww2xoe_m_hc_ffg.lib \
           $(ABS_PATH)../../../lib/mem/dti_dp_tm16fcll_512x32_4ww2xoe_m_hc/dti_dp_tm16fcll_512x32_4ww2xoe_m_hc_leak.lib \
           $(ABS_PATH)../../../lib/mem/dti_dp_tm16fcll_512x32_4ww2xoe_m_hc/dti_dp_tm16fcll_512x32_4ww2xoe_m_hc_mbist.lib \
           $(ABS_PATH)../../../lib/mem/dti_dp_tm16fcll_512x32_4ww2xoe_m_hc/dti_dp_tm16fcll_512x32_4ww2xoe_m_hc_ssg0c.lib \
           $(ABS_PATH)../../../lib/mem/dti_dp_tm16fcll_512x32_4ww2xoe_m_hc/dti_dp_tm16fcll_512x32_4ww2xoe_m_hc_ssg125c.lib \
           $(ABS_PATH)../../../lib/mem/dti_dp_tm16fcll_512x32_4ww2xoe_m_hc/dti_dp_tm16fcll_512x32_4ww2xoe_m_hc_ssgn40c.lib \
           $(ABS_PATH)../../../lib/mem/dti_dp_tm16fcll_512x32_4ww2xoe_m_hc/dti_dp_tm16fcll_512x32_4ww2xoe_m_hc_ttth.lib \
           $(ABS_PATH)../../../lib/mem/dti_dp_tm16fcll_512x32_4ww2xoe_m_hc/dti_dp_tm16fcll_512x32_4ww2xoe_m_hc_typ.lib \
           $(ABS_PATH)../../../lib/mem/dti_dp_tm16fcll_512x32_4ww2xoe_m_hc/dti_dp_tm16fcll_512x32_4ww2xoe_m_hc_typ85crv.lib \
           $(ABS_PATH)../../../lib/mem/dti_dp_tm16fcll_512x32_4ww2xoe_m_hc/dti_dp_tm16fcll_512x32_4ww2xoe_m_hc_worst.lib \
           $(ABS_PATH)../../../lib/mem/dti_dp_tm16fcll_512x32_4ww2xoe_m_hc/dti_dp_tm16fcll_512x32_4ww2xoe_m_hc_worstn40c.lib \
           $(ABS_PATH)../../../lib/mem/dti_dp_tm16fcll_512x32_4ww2xoe_m_hc/dti_dp_tm16fcll_512x32_4ww2xoe_m_hc_worstzero.lib

LEF_SRC :=  $(ABS_PATH)../../../lib/mem/dti_dp_tm16fcll_512x32_4ww2xoe_m_hc/dti_dp_tm16fcll_512x32_4ww2xoe_m_hc.lef \
            $(ABS_PATH)../../../lib/mem/dti_dp_tm16fcll_512x32_4ww2xoe_m_hc/dti_dp_tm16fcll_512x32_4ww2xoe_m_hc_ant.lef