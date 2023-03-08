ABS_PATH := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))

RTL_SRC := $(ABS_PATH)../../ip/dti/hdl/dataflow_controller.sv \
           $(ABS_PATH)../../ip/dti/hdl/datapath.sv \
           $(ABS_PATH)../../ip/dti/hdl/ddr_bist.sv \
           $(ABS_PATH)../../ip/dti/hdl/dfi_bridge.sv \
           $(ABS_PATH)../../ip/dti/hdl/dynamo_core.v \
           $(ABS_PATH)../../ip/dti/hdl/dynamo_sram_rcb.v \
           $(ABS_PATH)../../ip/dti/hdl/dynamo_sram.v \
           $(ABS_PATH)../../ip/dti/hdl/dynamo_sram_wcb.v \
           $(ABS_PATH)../../ip/dti/hdl/dynamo.v \
           $(ABS_PATH)../../ip/dti/hdl/port_bridge.sv \
           $(ABS_PATH)../../ip/dti/hdl/protocol_controller.sv \
           $(ABS_PATH)../../ip/dti/hdl/register_block.sv \
           $(ABS_PATH)../../ip/dti/libs/dti_tm16_phy/hdl/dti_cdc_data_sync_gf.v \
           $(ABS_PATH)../../ip/dti/libs/dti_tm16_phy/hdl/dti_clkinv.v \
           $(ABS_PATH)../../ip/dti/libs/dti_tm16_phy/hdl/dti_dfi_map.sv \
           $(ABS_PATH)../../ip/dti/libs/dti_tm16_phy/hdl/dti_gear_slice.sv \
           $(ABS_PATH)../../ip/dti/libs/dti_tm16_phy/hdl/dti_phy_ctl_blk.sv \
           $(ABS_PATH)../../ip/dti/libs/dti_tm16_phy/hdl/dti_phy_sync_ctrl.v \
           $(ABS_PATH)../../ip/dti/libs/dti_tm16_phy/hdl/dti_tm16_phy.v \
           $(ABS_PATH)../../ip/dti/libs/dti_tm16_phy/hdl/dti_cdc_data_sync_one.v \
           $(ABS_PATH)../../ip/dti/libs/dti_tm16_phy/hdl/dti_ddr_phy_leveling.sv \
           $(ABS_PATH)../../ip/dti/libs/dti_tm16_phy/hdl/dti_gear_ctrl.sv \
           $(ABS_PATH)../../ip/dti/libs/dti_tm16_phy/hdl/dti_mode_ctrl_map.sv \
           $(ABS_PATH)../../ip/dti/libs/dti_tm16_phy/hdl/dti_phy_sync_common.v \
           $(ABS_PATH)../../ip/dti/libs/dti_tm16_phy/hdl/dti_phy_sync_slice.v 

RTL_STUB := $(ABS_PATH)dynamo_stub.v

RTL_INC := $(ABS_PATH)../../ip/dti/inc \
           $(ABS_PATH)../../ip/dti/libs/dti_tm28hpcp_ddr4_phy \
           $(ABS_PATH)../../ip/dti/libs/dti_tm28hpcp_ddr4_phy/include \
           $(ABS_PATH)../../ip/dti/libs/dti_tm28hpcp_ddr4_phy/hdl


MODEL_SRC := $(ABS_PATH)../../ip/dti/libs/dti_mem/hdl/dti_2pr_tm16ffcll_576x64_t4bw2x_m_hc.v \
             $(ABS_PATH)../../ip/dti/libs/dti_mem/hdl/dti_2pr_tm16ffcll_576x72_t4bw2x_m_hc.v \
             $(ABS_PATH)../../ip/dti/libs/dti_tm16_phy/hdl/library/dll_tm16_96_9t_stdcells.v \
             $(ABS_PATH)../../ip/dti/libs/dti_tm16_phy/hdl/library/dti_tm16ffc_18ud15_lpd4_comp_jme.v \
             $(ABS_PATH)../../ip/dti/libs/dti_tm16_phy/hdl/library/dti_tm16glp_re_18ud15_lpd4_io_jme.v \
             $(ABS_PATH)../../ip/dti/libs/dti_tm16_phy/hdl/library/dti_tm16glp_re_18ud15_lpd4_vddo_jme.v \
             $(ABS_PATH)../../ip/dti/libs/dti_tm16_phy/hdl/library/tm16ffc_dlyc.v \
             $(ABS_PATH)../../ip/dti/libs/dti_tm16_phy/hdl/library/dly_16f_9t_96_ckbufx4.v \
             $(ABS_PATH)../../ip/dti/libs/dti_tm16_phy/hdl/library/dti_tm16ffc_18ud15_lpd4_testpad_jme.v \
             $(ABS_PATH)../../ip/dti/libs/dti_tm16_phy/hdl/library/dti_tm16glp_re_18ud15_lpd4_pwrdn_jme.v \
             $(ABS_PATH)../../ip/dti/libs/dti_tm16_phy/hdl/library/dti_tm16glp_re_18ud15_lpd4_vss_buf_jme.v \
             $(ABS_PATH)../../ip/dti/libs/dti_tm16_phy/hdl/library/tm16ffc_dly.v \
             $(ABS_PATH)../../ip/dti/libs/dti_tm16_phy/hdl/library/dly_16f_9t_96_llqx1.v \
             $(ABS_PATH)../../ip/dti/libs/dti_tm16_phy/hdl/library/dti_tm16ffcd4lp4_18d_ctl30s2ckr2_jm.v \
             $(ABS_PATH)../../ip/dti/libs/dti_tm16_phy/hdl/library/dti_tm16glp_re_18ud15_lpd4_refcutl_jme.v \
             $(ABS_PATH)../../ip/dti/libs/dti_tm16_phy/hdl/library/dti_tm16glp_re_18ud15_lpd4_vss_jme.v \
             $(ABS_PATH)../../ip/dti/libs/dti_tm16_phy/hdl/library/tm16ffc_fclq.v \
             $(ABS_PATH)../../ip/dti/libs/dti_tm16_phy/hdl/library/dly_16f_9t_96_soffqa01x1.v \
             $(ABS_PATH)../../ip/dti/libs/dti_tm16_phy/hdl/library/dti_tm16ffcd4lp4r2_18d_dq8_jm.v \
             $(ABS_PATH)../../ip/dti/libs/dti_tm16_phy/hdl/library/dti_tm16glp_re_18ud15_lpd4_refcutr_jme.v \
             $(ABS_PATH)../../ip/dti/libs/dti_tm16_phy/hdl/library/tm16ffc_dll_d4.v \
             $(ABS_PATH)../../ip/dti/libs/dti_tm16_phy/hdl/library/dti_tm16_96_9t_stdcells_rev1p0p1_nospec.v \
             $(ABS_PATH)../../ip/dti/libs/dti_tm16_phy/hdl/library/dti_tm16glp_re_18ud15_lpd4_filler5p04_jme.v \
             $(ABS_PATH)../../ip/dti/libs/dti_tm16_phy/hdl/library/dti_tm16glp_re_18ud15_lpd4_ref_jme.v \
             $(ABS_PATH)../../ip/dti/libs/dti_tm16_phy/hdl/library/tm16ffc_dlls_d4.v \
             $(ABS_PATH)../../ip/dti/libs/dti_tm16_phy/hdl/library/dti_tm16ffc_16f96_9t_stdcells_rev1p0p0_pwr.v \
             $(ABS_PATH)../../ip/dti/libs/dti_tm16_phy/hdl/library/dti_tm16glp_re_18ud15_lpd4_io_b_jme.v \
             $(ABS_PATH)../../ip/dti/libs/dti_tm16_phy/hdl/library/dti_tm16glp_re_18ud15_lpd4_vdd_jme.v \
             $(ABS_PATH)../../ip/dti/libs/dti_tm16_phy/hdl/library/tm16ffc_dly2x4.v 

LIB_SRC := $(ABS_PATH)../../ip/dti/syn/lib_files/libs_phy/dti_tm16ffc_18ud15_lpd4_comp_jme_ffgnp0p88vn40c.lib \
	   $(ABS_PATH)../../ip/dti/syn/lib_files/libs_phy/dti_tm16ffcd4lp4_18d_ctl30s2ckr2_jm_ffgnp0p88vn40c.lib \
	   $(ABS_PATH)../../ip/dti/syn/lib_files/libs_phy/dti_tm16ffc_18ud15_lpd4_comp_jme_ssgnp0p72vn40c.lib \
	   $(ABS_PATH)../../ip/dti/syn/lib_files/libs_phy/dti_tm16ffcd4lp4_18d_ctl30s2ckr2_jm_ssgnp0p72vn40c.lib \
	   $(ABS_PATH)../../ip/dti/syn/lib_files/libs_phy/dti_tm16ffc_18ud15_lpd4_testpad_jme_ffgnp0p88vn40c.lib \
	   $(ABS_PATH)../../ip/dti/syn/lib_files/libs_phy/dti_tm16ffcd4lp4r2_18d_dq8_jm_ffgnp0p88vn40c.lib \
	   $(ABS_PATH)../../ip/dti/syn/lib_files/libs_phy/dti_tm16ffc_18ud15_lpd4_testpad_jme_ssgnp0p72vn40c.lib \
	   $(ABS_PATH)../../ip/dti/syn/lib_files/libs_phy/dti_tm16ffcd4lp4r2_18d_dq8_jm_ssgnp0p72vn40c.lib \
	   $(ABS_PATH)../../ip/dti/syn/lib_files/libs_mem/dti_2pr_tm16ffcll_576x64_t4bw2x_m_hc_worstn40c.lib \
	   $(ABS_PATH)../../ip/dti/syn/lib_files/libs_mem/dti_2pr_tm16ffcll_576x72_t4bw2x_m_hc_worstn40c.lib 

LEF_SRC := $(ABS_PATH)../../ip/dti/syn/lib_files/libs_phy/dti_tm16ffc_18ud15_lpd4_comp_jme.lef \
	   $(ABS_PATH)../../ip/dti/syn/lib_files/libs_phy/dti_tm16ffcd4lp4_18d_ctl30s2ckr2_jm.lef \
	   $(ABS_PATH)../../ip/dti/syn/lib_files/libs_phy/dti_tm16ffc_18ud15_lpd4_testpad_jme.lef \
	   $(ABS_PATH)../../ip/dti/syn/lib_files/libs_phy/dti_tm16ffcd4lp4r2_18d_dq8_jm.lef \
	   $(ABS_PATH)../../ip/dti/syn/lib_files/libs_mem/dti_2pr_tm16ffcll_576x64_t4bw2x_m_hc_ant.lef \
	   $(ABS_PATH)../../ip/dti/syn/lib_files/libs_mem/dti_2pr_tm16ffcll_576x72_t4bw2x_m_hc_ant.lef \
	   $(ABS_PATH)../../ip/dti/syn/lib_files/libs_mem/dti_2pr_tm16ffcll_576x64_t4bw2x_m_hc.lef \
	   $(ABS_PATH)../../ip/dti/syn/lib_files/libs_mem/dti_2pr_tm16ffcll_576x72_t4bw2x_m_hc.lef 


DB_SRC :=  $(ABS_PATH)../../ip/dti/syn/lib_files/libs_phy/dti_tm16ffc_18ud15_lpd4_comp_jme_ffgnp0p88vn40c.db \
	   $(ABS_PATH)../../ip/dti/syn/lib_files/libs_phy/dti_tm16ffcd4lp4_18d_ctl30s2ckr2_jm_ffgnp0p88vn40c.db \
	   $(ABS_PATH)../../ip/dti/syn/lib_files/libs_phy/dti_tm16ffc_18ud15_lpd4_comp_jme_ssgnp0p72vn40c.db \
	   $(ABS_PATH)../../ip/dti/syn/lib_files/libs_phy/dti_tm16ffcd4lp4_18d_ctl30s2ckr2_jm_ssgnp0p72vn40c.db \
	   $(ABS_PATH)../../ip/dti/syn/lib_files/libs_phy/dti_tm16ffc_18ud15_lpd4_testpad_jme_ffgnp0p88vn40c.db \
	   $(ABS_PATH)../../ip/dti/syn/lib_files/libs_phy/dti_tm16ffcd4lp4r2_18d_dq8_jm_ffgnp0p88vn40c.db \
	   $(ABS_PATH)../../ip/dti/syn/lib_files/libs_phy/dti_tm16ffc_18ud15_lpd4_testpad_jme_ssgnp0p72vn40c.db \
	   $(ABS_PATH)../../ip/dti/syn/lib_files/libs_phy/dti_tm16ffcd4lp4r2_18d_dq8_jm_ssgnp0p72vn40c.db \
	   $(ABS_PATH)../../ip/dti/syn/lib_files/libs_mem/dti_2pr_tm16ffcll_576x64_t4bw2x_m_hc_worstn40c.db \
	   $(ABS_PATH)../../ip/dti/syn/lib_files/libs_mem/dti_2pr_tm16ffcll_576x72_t4bw2x_m_hc_worstn40c.db 


