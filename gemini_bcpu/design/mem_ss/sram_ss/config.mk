ABS_PATH := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))

RTL_SRC := $(ABS_PATH)arbiter.v \
           $(ABS_PATH)axi_decoder.v \
           $(ABS_PATH)bank_cntl.v  \
           $(ABS_PATH)mem_cntl.v \
	   $(ABS_PATH)../../ip/Andes_N22/andes_ip/macro/nds_sync_fifo_data.v \
           $(ABS_PATH)sram_ss.v 

RTL_STUB := $(ABS_PATH)sram_ss_stub.v

MODEL_SRC := $(ABS_PATH)../../../lib/mem/dti_sp_tm16fcll_16384x32_32byw2x_m_shd/dti_sp_tm16fcll_16384x32_32byw2x_m_shd.v 

LIB_SRC := $(ABS_PATH)../../../lib/mem/dti_sp_tm16fcll_16384x32_32byw2x_m_shd/dti_sp_tm16fcll_16384x32_32byw2x_m_shd_best.lib 

LEF_SRC := $(ABS_PATH)../../../lib/mem/dti_sp_tm16fcll_16384x32_32byw2x_m_shd/dti_sp_tm16fcll_16384x32_32byw2x_m_shd.lef 


DB_SRC :=  $(ABS_PATH)../../../syn/db/dti_sp_tm16fcll_16384x32_32byw2x_m_shd_typ.db 


