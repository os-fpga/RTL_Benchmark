ABS_PATH := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))

RTL_SRC := $(ABS_PATH)hdl/atcpit100.v \
           $(ABS_PATH)hdl/atcpit100_apbslv.v \
           $(ABS_PATH)hdl/atcpit100_cntr.v \
           $(ABS_PATH)hdl/atcpit100_ch.v \
           $(ABS_PATH)../../acpu_ss/acpu_ss/A45/andes_ip/macro/nds_sync_l2l.v

RTL_STUB := $(ABS_PATH)hdl/stub/atcpit100_stub.v

RTL_INC := $(ABS_PATH)hdl/include