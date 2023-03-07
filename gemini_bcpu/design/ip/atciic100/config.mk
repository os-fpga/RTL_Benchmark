ABS_PATH := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))

RTL_SRC := $(ABS_PATH)hdl/atciic100.v \
           $(ABS_PATH)hdl/atciic100_apbslv.v \
           $(ABS_PATH)hdl/atciic100_ctrl.v \
           $(ABS_PATH)hdl/atciic100_gsf.v \
           $(ABS_PATH)hdl/atciic100_fifo.v \
           $(ABS_PATH)../../acpu_ss/acpu_ss/A45/andes_ip/macro/nds_sync_l2l.v \
           $(ABS_PATH)../../acpu_ss/acpu_ss/A45/andes_ip/macro/nds_sync_fifo_clr.v

RTL_STUB := $(ABS_PATH)hdl/stub/atciic100_stub.v

RTL_INC := $(ABS_PATH)hdl/include