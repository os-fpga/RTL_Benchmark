ABS_PATH := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))

RTL_INC := $(ABS_PATH)/rtl/ \
           $(ABS_PATH)/phy_behav/ \
           $(ABS_PATH)/rtl/usbhs/cusb2 \
           $(ABS_PATH)/rtl/usbhs/adma

RTL_STUB :=  $(ABS_PATH)/stub/usb_top.sv

MODEL_SRC := $(ABS_PATH)/../../../lib/mem/dti_dp_tm16fcll_512x32_4ww2xoe_m_hc/dti_dp_tm16fcll_512x32_4ww2xoe_m_hc.v \
             $(ABS_PATH)/../../../lib/mem/dti_1pr_tm16fcll_128x56_4ww2x_m_shd/dti_1pr_tm16fcll_128x56_4ww2x_m_shd.v \
             $(ABS_PATH)/phy_behav/cdn_sd1000_t16ffc_01_vc176_2xa1xd3xe2y2r_behav_model.sv \
             $(ABS_PATH)/phy_behav/cdn_sd1000_t16ffc_01_vc176_2xa1xd3xe2y2r.sv

RTL_SRC := $(ABS_PATH)/rtl/usbhs/meta/cdnsdru_datasync_synth_example.sv \
           $(ABS_PATH)/rtl/usbhs/meta/cdnsdru_datasync_v1.v \
           $(ABS_PATH)/rtl/usbhs/meta/cdnsusbhs_dff_sync.v \
           $(ABS_PATH)/rtl/usbhs/meta/cdnsusbhs_dffn_sync.v \
           $(ABS_PATH)/rtl/usbhs/meta/cdnsusbhs_bit_sync.v \
           $(ABS_PATH)/rtl/usbhs/meta/cdnsusbhs_data_sync.v \
           $(ABS_PATH)/rtl/usbhs/meta/cdnsusbhs_data_sync_rx.v \
           $(ABS_PATH)/rtl/usbhs/meta/cdnsusbhs_data_sync_tx.v \
           $(ABS_PATH)/rtl/usbhs/meta/cdnsusbhs_load_sync.v \
           $(ABS_PATH)/rtl/usbhs/meta/cdnsusbhs_load_sync_rx.v \
           $(ABS_PATH)/rtl/usbhs/meta/cdnsusbhs_load_sync_tx.v \
           $(ABS_PATH)/rtl/usbhs/meta/cdnsusbhs_signal_sync.v \
           $(ABS_PATH)/rtl/usbhs/meta/cdnsusbhs_signal_sync_rx.v \
           $(ABS_PATH)/rtl/usbhs/meta/cdnsusbhs_signal_sync_tx.v \
           $(ABS_PATH)/rtl/usbhs/cusb2/cdnsusbhs_ep0usb.v \
           $(ABS_PATH)/rtl/usbhs/cusb2/cdnsusbhs_ep0up.v \
           $(ABS_PATH)/rtl/usbhs/cusb2/cdnsusbhs_ep0.v \
           $(ABS_PATH)/rtl/usbhs/cusb2/cdnsusbhs_epinusb.v \
           $(ABS_PATH)/rtl/usbhs/cusb2/cdnsusbhs_epinup.v \
           $(ABS_PATH)/rtl/usbhs/cusb2/cdnsusbhs_epin.v \
           $(ABS_PATH)/rtl/usbhs/cusb2/cdnsusbhs_epoutusb.v \
           $(ABS_PATH)/rtl/usbhs/cusb2/cdnsusbhs_epoutup.v \
           $(ABS_PATH)/rtl/usbhs/cusb2/cdnsusbhs_epout.v \
           $(ABS_PATH)/rtl/usbhs/cusb2/cdnsusbhs_devfsm.v \
           $(ABS_PATH)/rtl/usbhs/cusb2/cdnsusbhs_portctrl.v \
           $(ABS_PATH)/rtl/usbhs/cusb2/cdnsusbhs_adpctrl.v \
           $(ABS_PATH)/rtl/usbhs/cusb2/cdnsusbhs_ifctrlusb.v \
           $(ABS_PATH)/rtl/usbhs/cusb2/cdnsusbhs_ifctrlup.v \
           $(ABS_PATH)/rtl/usbhs/cusb2/cdnsusbhs_rxtxctrl.v \
           $(ABS_PATH)/rtl/usbhs/cusb2/cdnsusbhs_sfrs.v \
           $(ABS_PATH)/rtl/usbhs/cusb2/cdnsusbhs_cusb2.v \
           $(ABS_PATH)/rtl/usbhs/adma/cdnsusbhs_adma.v \
           $(ABS_PATH)/rtl/usbhs/adma/cdnsusbhs_adma_logic.v \
           $(ABS_PATH)/rtl/usbhs/adma/cdnsusbhs_adma_sfr.v \
           $(ABS_PATH)/rtl/usbhs/adma/cdnsusbhs_adma_top.v \
           $(ABS_PATH)/rtl/usbhs/adma/cdnsusbhs_cusb2_adma.v \
           $(ABS_PATH)/rtl/usbhs/core/cdnsusbhs_aximwrap_ot.v \
           $(ABS_PATH)/rtl/usbhs/core/cdnsusbhs_common_gen_fifo.v \
           $(ABS_PATH)/rtl/usbhs/core/cdnsusbhs_ocp2axi_ms.v \
           $(ABS_PATH)/rtl/usbhs/core/cdnsusbhs_ocp2axi_sl.v \
           $(ABS_PATH)/rtl/usbhs/core/cdnsusbhs_wudetutmi.v \
           $(ABS_PATH)/rtl/usbhs/core/cdnsusbhs_wudet5k.v \
           $(ABS_PATH)/rtl/usbhs/core/cdnsusbhs_wudet.v \
           $(ABS_PATH)/rtl/usbhs/core/cdnsusbhs_upwrap.v \
           $(ABS_PATH)/rtl/usbhs/core/cdnsusbhs_upmux.v \
           $(ABS_PATH)/rtl/usbhs/core/cdnsusbhs_usbwrap.v \
           $(ABS_PATH)/rtl/usbhs/core/cdnsusbhs_clkgate.v \
           $(ABS_PATH)/../primitives/clkgate.sv \
           $(ABS_PATH)/rtl/usbhs/core/cdnsusbhs_usbhs.v \
           $(ABS_PATH)/rtl/usbhs_phy/cdnsusbhs_reset_ctrl.v \
           $(ABS_PATH)/rtl/usbhs_phy/cdnsusbhs_clock_ctrl.v \
           $(ABS_PATH)/rtl/usbhs_phy/cdnsusbhs_bistctrl.v \
           ${ABS_PATH}/rtl/usbhs_phy/cdnsusbhs_usbhs_phy.v \
           $(ABS_PATH)/rtl/usbhs_phy/cdnsusbhs_usb2_phy_wrapper.v \
           ${ABS_PATH}/rtl/usbhs_ram/cdnsusbhs_dpram_in_buf.v \
           ${ABS_PATH}/rtl/usbhs_ram/cdnsusbhs_dpram_out_buf.v \
           ${ABS_PATH}/rtl/usbhs_ram/cdnsusbhs_spram_buf.v \
           ${ABS_PATH}/rtl/usbhs_ram/cdnsusbhs_usbhs_ram.v \
           $(ABS_PATH)/rtl/chip_usbhs/cdnsusbhs_clocks_mux.v \
           $(ABS_PATH)/rtl/chip_usbhs/cdnsusbhs_utmi_glu.v \
           $(ABS_PATH)/rtl/chip_usbhs/cdnsusbhs_bufg.v \
           $(ABS_PATH)/rtl/chip_usbhs/cdnsusbhs_chip_usbhs.v

LIB_SRC := $(ABS_PATH)/lib/cdn_sd1000_t16ffc_01_vc176_2xa1xd3xe2y2r_ffgnp_0p88v_0p88v_125c_cworst_CCworst.lib.gz \
           $(ABS_PATH)/lib/cdn_sd1000_t16ffc_01_vc176_2xa1xd3xe2y2r_ffgnp_0p88v_0p88v_125c_rcworst_CCworst.lib.gz \
           $(ABS_PATH)/lib/cdn_sd1000_t16ffc_01_vc176_2xa1xd3xe2y2r_ffgnp_0p88v_0p88v_125c_rcbest_CCbest.lib.gz \
           $(ABS_PATH)/lib/cdn_sd1000_t16ffc_01_vc176_2xa1xd3xe2y2r_ffgnp_0p88v_0p88v_m40c_rcbest_CCbest.lib.gz \
           $(ABS_PATH)/lib/cdn_sd1000_t16ffc_01_vc176_2xa1xd3xe2y2r_ffgnp_0p88v_0p88v_m40c_cworst_CCworst.lib.gz \
           $(ABS_PATH)/lib/cdn_sd1000_t16ffc_01_vc176_2xa1xd3xe2y2r_ssgnp_0p72v_0p72v_m40c_cworst_CCworst.lib.gz \
           $(ABS_PATH)/lib/cdn_sd1000_t16ffc_01_vc176_2xa1xd3xe2y2r_ffgnp_0p88v_0p88v_m40c_rcworst_CCworst.lib.gz \
           $(ABS_PATH)/lib/cdn_sd1000_t16ffc_01_vc176_2xa1xd3xe2y2r_ssgnp_0p72v_0p72v_m40c_rcworst_CCworst.lib.gz \
           $(ABS_PATH)/lib/cdn_sd1000_t16ffc_01_vc176_2xa1xd3xe2y2r_ffgnp_0p88v_0p88v_125c_cbest_CCbest.lib.gz \
           $(ABS_PATH)/lib/cdn_sd1000_t16ffc_01_vc176_2xa1xd3xe2y2r_ssgnp_0p72v_0p72v_m40c_rcworst_CCworst_T.lib.gz \
           $(ABS_PATH)/lib/cdn_sd1000_t16ffc_01_vc176_2xa1xd3xe2y2r_ffgnp_0p88v_0p88v_m40c_cbest_CCbest.lib.gz \
           $(ABS_PATH)/lib/cdn_sd1000_t16ffc_01_vc176_2xa1xd3xe2y2r_ssgnp_0p72v_0p72v_125c_cworst_CCworst.lib.gz \
           $(ABS_PATH)/lib/cdn_sd1000_t16ffc_01_vc176_2xa1xd3xe2y2r_ssgnp_0p72v_0p72v_m40c_cworst_CCworst_T.lib.gz \
           $(ABS_PATH)/lib/cdn_sd1000_t16ffc_01_vc176_2xa1xd3xe2y2r_ssgnp_0p72v_0p72v_125c_cworst_CCworst_T.lib.gz \
           $(ABS_PATH)/lib/cdn_sd1000_t16ffc_01_vc176_2xa1xd3xe2y2r_ssgnp_0p72v_0p72v_125c_rcworst_CCworst_T.lib.gz \
           $(ABS_PATH)/lib/cdn_sd1000_t16ffc_01_vc176_2xa1xd3xe2y2r_ssgnp_0p72v_0p72v_125c_rcworst_CCworst.lib.gz

LEF_SRC := $(ABS_PATH)/lef/cdn_sd1000_t16ffc_01_vc176_2xa1xd3xe2y2r.lef \
           $(ABS_PATH)/lef/cdn_sd1000_t16ffc_01_vc176_2xa1xd3xe2y2r.nocutobs.lef
