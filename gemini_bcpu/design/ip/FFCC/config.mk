ABS_PATH := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))

RTL_SRC := $(ABS_PATH)../primitives/clkmux.v \
$(ABS_PATH)cfg_block_engine.sv \
$(ABS_PATH)cfg_regs.sv \
$(ABS_PATH)cfg_top.sv 
# $(ABS_PATH)FCB_PLC.v 




RTL_INC := $(ABS_PATH)

