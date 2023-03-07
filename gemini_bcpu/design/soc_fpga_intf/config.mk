ABS_PATH_SOC_FPGA_INTF := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))


include $(ABS_PATH_SOC_FPGA_INTF)config_controller/config.mk
SOC_FPGA_INTF_RTL_SRC = $(RTL_SRC)
SOC_FPGA_INTF_RTL_INC = $(RTL_INC)
SOC_FPGA_INTF_MODEL_SRC = $(MODEL_SRC)


SOC_FPGA_INTF_RTL_SRC += $(ABS_PATH_SOC_FPGA_INTF)../acpu_ss/acpu_ss/A45/andes_ip/macro/nds_async_fifo_afe.v \
                         $(ABS_PATH_SOC_FPGA_INTF)../ip/primitives/clkmux.v \
                         $(ABS_PATH_SOC_FPGA_INTF)soc_fpga_intf.sv


RTL_SRC := $(SOC_FPGA_INTF_RTL_SRC)
RTL_INC := $(SOC_FPGA_INTF_RTL_INC)
MODEL_SRC := $(SOC_FPGA_INTF_MODEL_SRC)
LIB_SRC := $(SOC_FPGA_INTF_LIB_SRC)
LEF_SRC := $(SOC_FPGA_INTF_LEF_SRC)
