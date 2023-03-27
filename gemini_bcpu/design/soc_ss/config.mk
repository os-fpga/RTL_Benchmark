ABS_PATH_SOC := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))

ifeq ($(USE_ACPU_A45),1)
	include $(ABS_PATH_SOC)../acpu_ss/config_A45.mk
else
	include $(ABS_PATH_SOC)../acpu_ss/config_D45.mk
endif
ifeq ($(USE_ACPU_STUB),1)
	SOC_SS_RTL_SRC := $(RTL_STUB)
else
	SOC_SS_RTL_SRC := $(RTL_SRC)
endif
SOC_SS_RTL_INC   := $(RTL_INC)
SOC_SS_MODEL_SRC := $(MODEL_SRC)
SOC_SS_LIB_SRC   := $(LIB_SRC)
SOC_SS_LEF_SRC   := $(LEF_SRC)

include $(ABS_PATH_SOC)../config_ss/config.mk
SOC_SS_RTL_SRC   += $(RTL_SRC)
SOC_SS_RTL_INC   += $(RTL_INC)
SOC_SS_MODEL_SRC += $(MODEL_SRC)
SOC_SS_LIB_SRC   += $(LIB_SRC)
SOC_SS_LEF_SRC   += $(LEF_SRC)


include $(ABS_PATH_SOC)../ip/FlexNoC/noc/config.mk
SOC_SS_RTL_SRC   += $(RTL_SRC)
SOC_SS_RTL_INC   += $(RTL_INC)
SOC_SS_MODEL_SRC += $(MODEL_SRC)


include $(ABS_PATH_SOC)../mem_ss/config.mk
ifeq ($(USE_MEMSS_STUB),1)
	SOC_SS_RTL_SRC += $(RTL_STUB)
else
	SOC_SS_RTL_SRC += $(RTL_SRC)
endif
SOC_SS_RTL_INC   += $(RTL_INC)
SOC_SS_MODEL_SRC += $(MODEL_SRC)
SOC_SS_LIB_SRC   += $(LIB_SRC)
SOC_SS_LEF_SRC   += $(LEF_SRC)

include $(ABS_PATH_SOC)../soc_fpga_intf/config.mk
SOC_SS_RTL_SRC   += $(RTL_SRC)
SOC_SS_RTL_INC   += $(RTL_INC)
SOC_SS_MODEL_SRC += $(MODEL_SRC)
SOC_SS_LIB_SRC   += $(LIB_SRC)
SOC_SS_LEF_SRC   += $(LEF_SRC)


SOC_SS_RTL_SRC += $(ABS_PATH_SOC)soc_ss_ipd_build.sv


RTL_SRC   := $(SOC_SS_RTL_SRC)
RTL_INC   := $(SOC_SS_RTL_INC)
MODEL_SRC := $(SOC_SS_MODEL_SRC)
LIB_SRC   := $(SOC_SS_LIB_SRC)
LEF_SRC   := $(SOC_SS_LEF_SRC)
