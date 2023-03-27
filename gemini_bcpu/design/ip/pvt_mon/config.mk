ABS_PATH := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))

RTL_SRC := $(ABS_PATH)rtl/dti_apb_sync.sv \
           $(ABS_PATH)rtl/dti_bictr_rcnto_up.sv \
           $(ABS_PATH)rtl/dti_fifo_async_2port_mem_wrap_apb.sv \
           $(ABS_PATH)rtl/dti_p_mon_fsm.sv \
           $(ABS_PATH)rtl/dti_pvt_global_ctrl.sv \
           $(ABS_PATH)rtl/dti_pvt_reg_blk.sv \
           $(ABS_PATH)rtl/dti_vt_mon_fsm.sv \
           $(ABS_PATH)rtl/dti_pvt_controller.v

RTL_STUB := $(ABS_PATH)dti_pvt_controller_stub.v

RTL_INC := 

MODEL_SRC := $(ABS_PATH)models/tm16_pvt/dti_tm16ffc_96_9t_stdcells_rev1p1p0.v \
             $(ABS_PATH)models/tm16_pvt/tm16_pvt.v
LIB_SRC :=
LEF_SRC :=
