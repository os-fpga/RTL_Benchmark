MEM_SS_ABS_PATH := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))

MEM_SS_RTL_SRC   := $(MEM_SS_ABS_PATH)memss.v
MEM_SS_RTL_INC   := 
MEM_SS_MODEL_SRC :=
MEM_SS_LIB_SRC   := 
MEM_SS_LEF_SRC   :=
MEM_SS_DB_SRC    :=

include $(MEM_SS_ABS_PATH)sram_ss/config.mk
MEM_SS_RTL_INC   += $(RTL_INC)
MEM_SS_MODEL_SRC += $(MODEL_SRC)
MEM_SS_LIB_SRC   += $(LIB_SRC)
MEM_SS_LEF_SRC   += $(LEF_SRC)
MEM_SS_DB_SRC    += $(DB_SRC) 
ifeq ($(USE_SRAM_STUB),1)
	MEM_SS_RTL_SRC += $(RTL_STUB)
else
	MEM_SS_RTL_SRC += $(RTL_SRC)
endif

include $(MEM_SS_ABS_PATH)ddr_ss/config.mk
MEM_SS_RTL_INC   += $(RTL_INC)
MEM_SS_MODEL_SRC += $(MODEL_SRC)
MEM_SS_LIB_SRC   += $(LIB_SRC)
MEM_SS_LEF_SRC   += $(LEF_SRC)
MEM_SS_DB_SRC    += $(DB_SRC) 
ifeq ($(USE_DDR_STUB),1)
	MEM_SS_RTL_SRC += $(RTL_STUB)
else
	MEM_SS_RTL_SRC += $(RTL_SRC)
endif

MEM_SS_RTL_STUB := $(MEM_SS_ABS_PATH)memss_stub.v


RTL_SRC   := $(MEM_SS_RTL_SRC)
RTL_INC   := $(MEM_SS_RTL_INC)
MODEL_SRC := $(MEM_SS_MODEL_SRC)
LIB_SRC   := $(MEM_SS_LIB_SRC)
LEF_SRC   := $(MEM_SS_LEF_SRC)
DB_SRC    := $(MEM_SS_DB_SRC)
RTL_STUB  := $(MEM_SS_RTL_STUB)

