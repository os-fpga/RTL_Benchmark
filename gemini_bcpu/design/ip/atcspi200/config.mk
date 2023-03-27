ABS_PATH := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))

RTL_SRC := $(ABS_PATH)hdl/atcspi200_arbiter.v \
           $(ABS_PATH)hdl/atcspi200_ctrl.v \
           $(ABS_PATH)hdl/atcspi200_spiif.v \
           $(ABS_PATH)hdl/atcspi200_reg.v \
           $(ABS_PATH)hdl/atcspi200_regif.v \
           $(ABS_PATH)hdl/atcspi200_eilmif_ctrl.v \
           $(ABS_PATH)hdl/atcspi200_ahbif_ctrl.v \
           $(ABS_PATH)hdl/atcspi200_regif_ctrl.v \
           $(ABS_PATH)hdl/atcspi200_fifo.v \
           $(ABS_PATH)hdl/atcspi200_sync.v \
           $(ABS_PATH)hdl/atcspi200.v \
           $(ABS_PATH)../../acpu_ss/acpu_ss/A45/andes_ip/macro/nds_sync_l2l.v \
           $(ABS_PATH)../../acpu_ss/acpu_ss/A45/andes_ip/macro/nds_sync_p2p.v \
	       $(ABS_PATH)../../acpu_ss/acpu_ss/A45/andes_ip/macro/gck.v \
           $(ABS_PATH)../../acpu_ss/acpu_ss/A45/andes_ip/macro/nds_async_fifo_clr.v

RTL_STUB := $(ABS_PATH)hdl/stub/atcspi200_stub.v

RTL_INC := $(ABS_PATH)hdl/include
