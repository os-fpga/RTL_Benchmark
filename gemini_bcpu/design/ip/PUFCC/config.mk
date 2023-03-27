ABS_PATH := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))

RTL_SRC :=  $(ABS_PATH)rtl/top/pscc_clksw_mux.v \
			$(ABS_PATH)rtl/top/pscc_rstgen_mux.v \
			$(ABS_PATH)rtl/top/pscc_rstgen.v \
			$(ABS_PATH)rtl/top/pscc_scan_mux.v \
			$(ABS_PATH)rtl/pscc_core_enc.v.e \
			$(ABS_PATH)rtl/top/pscc_top.v \
			$(ABS_PATH)pufcc.sv


RTL_INC :=  $(ABS_PATH) \
			$(ABS_PATH)behv/EGP512X32

RTL_STUB :=$(ABS_PATH)pufcc.sv \
           $(ABS_PATH)stub/pscc_top_stub.v

MODEL_SRC := $(ABS_PATH)behv/EGP512X32/EGP512X32.v \
			 $(ABS_PATH)behv/EGP512X32UA016CW01.v \
			 $(ABS_PATH)../../../lib/mem/dti_sp_tm16fcll_576x32_4ww2xoe_m_shd/dti_sp_tm16fcll_576x32_4ww2xoe_m_shd.v \
			 $(ABS_PATH)../../../lib/mem/dti_sp_tm16fcll_122x32_4ww2xoe_m_shd/dti_sp_tm16fcll_122x32_4ww2xoe_m_shd.v \
			 $(ABS_PATH)../../../lib/mem/dti_sp_tm16fcll_1432x32_4ww2xoe_m_shd/dti_sp_tm16fcll_1432x32_4ww2xoe_m_shd.v \
			 $(ABS_PATH)behv/pufrt_hmc_peri_enc.v.e

LIB_SRC  := $(ABS_PATH)../../../lib/mem/pscc_EGP512X32UA016CW01/EGP512X32UA016CW01_ff.lib \
			$(ABS_PATH)../../../lib/mem/pscc_EGP512X32UA016CW01/EGP512X32UA016CW01_ss.lib \
			$(ABS_PATH)../../../lib/mem/pscc_EGP512X32UA016CW01/EGP512X32UA016CW01_tt.lib \
			$(ABS_PATH)../../../lib/mem/dti_sp_tm16fcll_576x32_4ww2xoe_m_shd/dti_sp_tm16fcll_576x32_4ww2xoe_m_shd_best.lib \
			$(ABS_PATH)../../../lib/mem/dti_sp_tm16fcll_576x32_4ww2xoe_m_shd/dti_sp_tm16fcll_576x32_4ww2xoe_m_shd_bestzero.lib \
			$(ABS_PATH)../../../lib/mem/dti_sp_tm16fcll_576x32_4ww2xoe_m_shd/dti_sp_tm16fcll_576x32_4ww2xoe_m_shd_ffg.lib \
			$(ABS_PATH)../../../lib/mem/dti_sp_tm16fcll_576x32_4ww2xoe_m_shd/dti_sp_tm16fcll_576x32_4ww2xoe_m_shd_ffgnp125.lib \
			$(ABS_PATH)../../../lib/mem/dti_sp_tm16fcll_576x32_4ww2xoe_m_shd/dti_sp_tm16fcll_576x32_4ww2xoe_m_shd_leak.lib \
			$(ABS_PATH)../../../lib/mem/dti_sp_tm16fcll_576x32_4ww2xoe_m_shd/dti_sp_tm16fcll_576x32_4ww2xoe_m_shd_mbist.lib \
			$(ABS_PATH)../../../lib/mem/dti_sp_tm16fcll_576x32_4ww2xoe_m_shd/dti_sp_tm16fcll_576x32_4ww2xoe_m_shd_ssg0c.lib \
			$(ABS_PATH)../../../lib/mem/dti_sp_tm16fcll_576x32_4ww2xoe_m_shd/dti_sp_tm16fcll_576x32_4ww2xoe_m_shd_ssg125c.lib \
			$(ABS_PATH)../../../lib/mem/dti_sp_tm16fcll_576x32_4ww2xoe_m_shd/dti_sp_tm16fcll_576x32_4ww2xoe_m_shd_ssgn40c.lib \
			$(ABS_PATH)../../../lib/mem/dti_sp_tm16fcll_576x32_4ww2xoe_m_shd/dti_sp_tm16fcll_576x32_4ww2xoe_m_shd_ssgnpn40c.lib \
			$(ABS_PATH)../../../lib/mem/dti_sp_tm16fcll_576x32_4ww2xoe_m_shd/dti_sp_tm16fcll_576x32_4ww2xoe_m_shd_ttth.lib \
			$(ABS_PATH)../../../lib/mem/dti_sp_tm16fcll_576x32_4ww2xoe_m_shd/dti_sp_tm16fcll_576x32_4ww2xoe_m_shd_typ.lib \
			$(ABS_PATH)../../../lib/mem/dti_sp_tm16fcll_576x32_4ww2xoe_m_shd/dti_sp_tm16fcll_576x32_4ww2xoe_m_shd_typ85crv.lib \
			$(ABS_PATH)../../../lib/mem/dti_sp_tm16fcll_576x32_4ww2xoe_m_shd/dti_sp_tm16fcll_576x32_4ww2xoe_m_shd_worst.lib \
			$(ABS_PATH)../../../lib/mem/dti_sp_tm16fcll_576x32_4ww2xoe_m_shd/dti_sp_tm16fcll_576x32_4ww2xoe_m_shd_worstn40c.lib \
			$(ABS_PATH)../../../lib/mem/dti_sp_tm16fcll_576x32_4ww2xoe_m_shd/dti_sp_tm16fcll_576x32_4ww2xoe_m_shd_worstzero.lib \
			$(ABS_PATH)../../../lib/mem/dti_sp_tm16fcll_122x32_4ww2xoe_m_shd/dti_sp_tm16fcll_122x32_4ww2xoe_m_shd_best.lib \
			$(ABS_PATH)../../../lib/mem/dti_sp_tm16fcll_122x32_4ww2xoe_m_shd/dti_sp_tm16fcll_122x32_4ww2xoe_m_shd_bestzero.lib \
			$(ABS_PATH)../../../lib/mem/dti_sp_tm16fcll_122x32_4ww2xoe_m_shd/dti_sp_tm16fcll_122x32_4ww2xoe_m_shd_ffg.lib \
			$(ABS_PATH)../../../lib/mem/dti_sp_tm16fcll_122x32_4ww2xoe_m_shd/dti_sp_tm16fcll_122x32_4ww2xoe_m_shd_ffgnp125.lib \
			$(ABS_PATH)../../../lib/mem/dti_sp_tm16fcll_122x32_4ww2xoe_m_shd/dti_sp_tm16fcll_122x32_4ww2xoe_m_shd_leak.lib \
			$(ABS_PATH)../../../lib/mem/dti_sp_tm16fcll_122x32_4ww2xoe_m_shd/dti_sp_tm16fcll_122x32_4ww2xoe_m_shd_mbist.lib \
			$(ABS_PATH)../../../lib/mem/dti_sp_tm16fcll_122x32_4ww2xoe_m_shd/dti_sp_tm16fcll_122x32_4ww2xoe_m_shd_ssg0c.lib \
			$(ABS_PATH)../../../lib/mem/dti_sp_tm16fcll_122x32_4ww2xoe_m_shd/dti_sp_tm16fcll_122x32_4ww2xoe_m_shd_ssg125c.lib \
			$(ABS_PATH)../../../lib/mem/dti_sp_tm16fcll_122x32_4ww2xoe_m_shd/dti_sp_tm16fcll_122x32_4ww2xoe_m_shd_ssgn40c.lib \
			$(ABS_PATH)../../../lib/mem/dti_sp_tm16fcll_122x32_4ww2xoe_m_shd/dti_sp_tm16fcll_122x32_4ww2xoe_m_shd_ssgnpn40c.lib \
			$(ABS_PATH)../../../lib/mem/dti_sp_tm16fcll_122x32_4ww2xoe_m_shd/dti_sp_tm16fcll_122x32_4ww2xoe_m_shd_ttth.lib \
			$(ABS_PATH)../../../lib/mem/dti_sp_tm16fcll_122x32_4ww2xoe_m_shd/dti_sp_tm16fcll_122x32_4ww2xoe_m_shd_typ.lib \
			$(ABS_PATH)../../../lib/mem/dti_sp_tm16fcll_122x32_4ww2xoe_m_shd/dti_sp_tm16fcll_122x32_4ww2xoe_m_shd_typ85crv.lib \
			$(ABS_PATH)../../../lib/mem/dti_sp_tm16fcll_122x32_4ww2xoe_m_shd/dti_sp_tm16fcll_122x32_4ww2xoe_m_shd_worst.lib \
			$(ABS_PATH)../../../lib/mem/dti_sp_tm16fcll_122x32_4ww2xoe_m_shd/dti_sp_tm16fcll_122x32_4ww2xoe_m_shd_worstn40c.lib \
			$(ABS_PATH)../../../lib/mem/dti_sp_tm16fcll_122x32_4ww2xoe_m_shd/dti_sp_tm16fcll_122x32_4ww2xoe_m_shd_worstzero.lib \
			$(ABS_PATH)../../../lib/mem/dti_sp_tm16fcll_1432x32_4ww2xoe_m_shd/dti_sp_tm16fcll_1432x32_4ww2xoe_m_shd_best.lib \
			$(ABS_PATH)../../../lib/mem/dti_sp_tm16fcll_1432x32_4ww2xoe_m_shd/dti_sp_tm16fcll_1432x32_4ww2xoe_m_shd_bestzero.lib \
			$(ABS_PATH)../../../lib/mem/dti_sp_tm16fcll_1432x32_4ww2xoe_m_shd/dti_sp_tm16fcll_1432x32_4ww2xoe_m_shd_ffg.lib \
			$(ABS_PATH)../../../lib/mem/dti_sp_tm16fcll_1432x32_4ww2xoe_m_shd/dti_sp_tm16fcll_1432x32_4ww2xoe_m_shd_ffgnp125.lib \
			$(ABS_PATH)../../../lib/mem/dti_sp_tm16fcll_1432x32_4ww2xoe_m_shd/dti_sp_tm16fcll_1432x32_4ww2xoe_m_shd_leak.lib \
			$(ABS_PATH)../../../lib/mem/dti_sp_tm16fcll_1432x32_4ww2xoe_m_shd/dti_sp_tm16fcll_1432x32_4ww2xoe_m_shd_mbist.lib \
			$(ABS_PATH)../../../lib/mem/dti_sp_tm16fcll_1432x32_4ww2xoe_m_shd/dti_sp_tm16fcll_1432x32_4ww2xoe_m_shd_ssg0c.lib \
			$(ABS_PATH)../../../lib/mem/dti_sp_tm16fcll_1432x32_4ww2xoe_m_shd/dti_sp_tm16fcll_1432x32_4ww2xoe_m_shd_ssg125c.lib \
			$(ABS_PATH)../../../lib/mem/dti_sp_tm16fcll_1432x32_4ww2xoe_m_shd/dti_sp_tm16fcll_1432x32_4ww2xoe_m_shd_ssgn40c.lib \
			$(ABS_PATH)../../../lib/mem/dti_sp_tm16fcll_1432x32_4ww2xoe_m_shd/dti_sp_tm16fcll_1432x32_4ww2xoe_m_shd_ssgnpn40c.lib \
			$(ABS_PATH)../../../lib/mem/dti_sp_tm16fcll_1432x32_4ww2xoe_m_shd/dti_sp_tm16fcll_1432x32_4ww2xoe_m_shd_ttth.lib \
			$(ABS_PATH)../../../lib/mem/dti_sp_tm16fcll_1432x32_4ww2xoe_m_shd/dti_sp_tm16fcll_1432x32_4ww2xoe_m_shd_typ.lib \
			$(ABS_PATH)../../../lib/mem/dti_sp_tm16fcll_1432x32_4ww2xoe_m_shd/dti_sp_tm16fcll_1432x32_4ww2xoe_m_shd_typ85crv.lib \
			$(ABS_PATH)../../../lib/mem/dti_sp_tm16fcll_1432x32_4ww2xoe_m_shd/dti_sp_tm16fcll_1432x32_4ww2xoe_m_shd_worst.lib \
			$(ABS_PATH)../../../lib/mem/dti_sp_tm16fcll_1432x32_4ww2xoe_m_shd/dti_sp_tm16fcll_1432x32_4ww2xoe_m_shd_worstn40c.lib \
			$(ABS_PATH)../../../lib/mem/dti_sp_tm16fcll_1432x32_4ww2xoe_m_shd/dti_sp_tm16fcll_1432x32_4ww2xoe_m_shd_worstzero.lib

LEF_SRC  := $(ABS_PATH)../../../lib/mem/dti_sp_tm16fcll_576x32_4ww2xoe_m_shd/dti_sp_tm16fcll_576x32_4ww2xoe_m_shd.lef \
			$(ABS_PATH)../../../lib/mem/dti_sp_tm16fcll_576x32_4ww2xoe_m_shd/dti_sp_tm16fcll_576x32_4ww2xoe_m_shd_ant.lef \
			$(ABS_PATH)../../../lib/mem/dti_sp_tm16fcll_122x32_4ww2xoe_m_shd/dti_sp_tm16fcll_122x32_4ww2xoe_m_shd.lef \
			$(ABS_PATH)../../../lib/mem/dti_sp_tm16fcll_122x32_4ww2xoe_m_shd/dti_sp_tm16fcll_122x32_4ww2xoe_m_shd_ant.lef \
			$(ABS_PATH)../../../lib/mem/dti_sp_tm16fcll_1432x32_4ww2xoe_m_shd/dti_sp_tm16fcll_1432x32_4ww2xoe_m_shd.lef \
			$(ABS_PATH)../../../lib/mem/dti_sp_tm16fcll_1432x32_4ww2xoe_m_shd/dti_sp_tm16fcll_1432x32_4ww2xoe_m_shd_ant.lef	\
			$(ABS_PATH)../../../lib/mem/pscc_EGP512X32UA016CW01/EGP512X32UA016CW01_M9.lef		
