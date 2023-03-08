ABS_PATH := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))

RTL_SRC := $(ABS_PATH)hdl/atcuart100.v \
           $(ABS_PATH)hdl/atcuart100_apbif_reg.v \
           $(ABS_PATH)hdl/atcuart100_baud.v \
           $(ABS_PATH)hdl/atcuart100_modem.v \
           $(ABS_PATH)hdl/atcuart100_rxctrl.v \
           $(ABS_PATH)hdl/atcuart100_txctrl.v \
           $(ABS_PATH)hdl/atcuart100_uart_rx.v \
           $(ABS_PATH)hdl/atcuart100_uart_tx.v \
           $(ABS_PATH)../../acpu_ss/acpu_ss/A45/andes_ip/macro/nds_sync_p2p.v \
           $(ABS_PATH)../../acpu_ss/acpu_ss/A45/andes_ip/macro/nds_sync_p2p_data.v \
           $(ABS_PATH)../../acpu_ss/acpu_ss/A45/andes_ip/macro/nds_sync_l2l.v \
           $(ABS_PATH)../../acpu_ss/acpu_ss/A45/andes_ip/macro/nds_async_buff.v \
           $(ABS_PATH)../../acpu_ss/acpu_ss/A45/andes_ip/macro/nds_sync_fifo_clr.v

RTL_STUB := $(ABS_PATH)hdl/stub/atcuart100_stub.v

RTL_INC := $(ABS_PATH)hdl/include