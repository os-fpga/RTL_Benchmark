ABS_PATH := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))

RTL_SRC := $(ABS_PATH)../../ip/primitives/clkgate.sv \
           $(ABS_PATH)../../ip/primitives/rstsync.sv \
           $(ABS_PATH)../../ip/primitives/gfckmux.v \
           $(ABS_PATH)../../ip/primitives/clk_div.sv \
           $(ABS_PATH)../../ip/primitives/sync_ff.sv \
           $(ABS_PATH)../../ip/primitives/sync_bus.sv \
           $(ABS_PATH)../../ip/primitives/clkmux.v \
           $(ABS_PATH)../../ip/apb_manager/apb_manager.sv \
           $(ABS_PATH)../../ip/pad_ctrl/pad_ctrl.sv \
           $(ABS_PATH)soc_scu.sv \
           $(ABS_PATH)soc_scu_cru.sv \
           $(ABS_PATH)soc_scu_irq_control.sv \
           $(ABS_PATH)soc_scu_registers.sv

RTL_INC := $(ABS_PATH)
