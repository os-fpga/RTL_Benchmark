ABS_PATH := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))

RTL_SRC := $(ABS_PATH)hdl/atcdmac300.v \
           $(ABS_PATH)hdl/atcdmac300_apbslv.v \
           $(ABS_PATH)hdl/atcdmac300_arbiter.v \
           $(ABS_PATH)hdl/atcdmac300_aximst.v \
           $(ABS_PATH)hdl/atcdmac300_chmux.v \
           $(ABS_PATH)hdl/atcdmac300_engine.v \
           $(ABS_PATH)hdl/atcdmac300_fifo.v \
           $(ABS_PATH)hdl/atcdmac300_register.v \
           $(ABS_PATH)../../acpu_ss/acpu_ss/A45/andes_ip/macro/nds_sync_fifo_clr.v \
           $(ABS_PATH)../../acpu_ss/acpu_ss/A45/andes_ip/macro/nds_async_buff.v \
           $(ABS_PATH)../../acpu_ss/acpu_ss/A45/andes_ip/macro/nds_sync_l2l.v

RTL_STUB := $(ABS_PATH)hdl/stub/atcdmac300_stub.v           

RTL_INC := $(ABS_PATH)hdl/include