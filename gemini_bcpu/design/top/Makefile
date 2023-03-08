ABS_PATH_FILELIST := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))
GEMINI_DIR :=$(shell echo $(ABS_PATH_FILELIST) | sed 's/.design.top.//')

USE_FCB_STUB   := 0
USE_GBE_STUB   := 0
USE_BCPU_STUB  := 0
USE_MEMSS_STUB := 0
USE_DDR_STUB   := 0
USE_SRAM_STUB  := 0
USE_USB_STUB   := 0
USE_PUFCC_STUB := 0
USE_PVT_STUB   := 0

USE_BCPU_ENCRYPTED := 0
USE_ACPU_ENCRYPTED := 0

USE_ACPU_A45 := 1

ifeq ($(USE_ACPU_A45),0)
   USE_ACPU_D45 := 1
else
   USE_ACPU_D45 := 0
endif

ifeq ($(or $USE_DDR_STUB, $USE_SRAM_STUB),1)
   USE_MEMSS_STUB := 0
endif

include $(ABS_PATH_FILELIST)../top/config.mk
TOP_MAKEFILE_RTL_SRC         := $(RTL_SRC)
TOP_MAKEFILE_RTL_INC         := $(RTL_INC)
TOP_MAKEFILE_MODEL_SRC       := $(MODEL_SRC)
TOP_MAKEFILE_LIB_SRC         := $(LIB_SRC)
TOP_MAKEFILE_LEF_SRC         := $(LEF_SRC)

include $(ABS_PATH_FILELIST)../soc_ss/config.mk
SOC_SS_MAKEFILE_RTL_SRC      := $(RTL_SRC)
SOC_SS_MAKEFILE_RTL_INC      := $(RTL_INC)
SOC_SS_MAKEFILE_MODEL_SRC    := $(MODEL_SRC)
SOC_SS_MAKEFILE_LIB_SRC      := $(LIB_SRC)
SOC_SS_MAKEFILE_LEF_SRC      := $(LEF_SRC)

include $(ABS_PATH_FILELIST)../config_ss/config.mk
CONFIG_SS_MAKEFILE_RTL_SRC   := $(RTL_SRC)
CONFIG_SS_MAKEFILE_RTL_INC   := $(RTL_INC)
CONFIG_SS_MAKEFILE_MODEL_SRC := $(MODEL_SRC)
CONFIG_SS_MAKEFILE_LIB_SRC   := $(LIB_SRC)
CONFIG_SS_MAKEFILE_LEF_SRC   := $(LEF_SRC)

include $(ABS_PATH_FILELIST)../acpu_ss/config_A45.mk
ACPU_SS_MAKEFILE_RTL_SRC     :=  $(RTL_SRC)
ACPU_SS_MAKEFILE_RTL_INC     :=  $(RTL_INC)
ACPU_SS_MAKEFILE_MODEL_SRC   :=  $(MODEL_SRC)
ACPU_SS_MAKEFILE_LIB_SRC     :=  $(LIB_SRC)
ACPU_SS_MAKEFILE_LEF_SRC     :=  $(LEF_SRC)

include $(ABS_PATH_FILELIST)../ip/FlexNoC/noc/config.mk
NOC_RTL_MAKEFILE_SRC         :=  $(RTL_SRC)
NOC_RTL_MAKEFILE_INC         :=  $(RTL_INC)

include $(ABS_PATH_FILELIST)../mem_ss/config.mk
MEM_SS_MAKEFILE_RTL_SRC      := $(RTL_SRC)
MEM_SS_MAKEFILE_RTL_INC      := $(RTL_INC)
MEM_SS_MAKEFILE_MODEL_SRC    := $(MODEL_SRC)
MEM_SS_MAKEFILE_LIB_SRC      := $(LIB_SRC)
MEM_SS_MAKEFILE_LEF_SRC      := $(LEF_SRC)
MEM_SS_MAKEFILE_DB_SRC       := $(DB_SRC)

include $(ABS_PATH_FILELIST)../soc_fpga_intf/config.mk
SOC_FPGA_INTF_MAKEFILE_RTL_SRC   := $(RTL_SRC)
SOC_FPGA_INTF_MAKEFILE_RTL_INC   := $(RTL_INC)
SOC_FPGA_INTF_MAKEFILE_MODEL_SRC := $(MODEL_SRC)
SOC_FPGA_INTF_MAKEFILE_LIB_SRC   := $(LIB_SRC)
SOC_FPGA_INTF_MAKEFILE_LEF_SRC   := $(LEF_SRC)


filelist_syn_a350:
	echo $(sort $(abspath $(ACPU_SS_MAKEFILE_RTL_SRC)))    | sed 's/ /\n/g' | sed "s|$(GEMINI_DIR)|\x24GEMINI|g" > $(ABS_PATH_FILELIST)/../../syn/filelists/ae350_cpu_subsystem_rtl.syn.f
	echo $(sort $(abspath $(ACPU_SS_MAKEFILE_RTL_INC)))    | sed 's/ /\n/g' | sed "s|$(GEMINI_DIR)|\x24GEMINI|g" > $(ABS_PATH_FILELIST)/../../syn/filelists/ae350_cpu_subsystem_inc.syn.f
	echo $(sort $(abspath $(ACPU_SS_MAKEFILE_LIB_SRC)))    | sed 's/ /\n/g' | sed "s|$(GEMINI_DIR)|\x24GEMINI|g" > $(ABS_PATH_FILELIST)/../../syn/filelists/ae350_cpu_subsystem_lib.syn.f
	echo $(sort $(abspath $(ACPU_SS_MAKEFILE_LEF_SRC)))    | sed 's/ /\n/g' | sed "s|$(GEMINI_DIR)|\x24GEMINI|g" > $(ABS_PATH_FILELIST)/../../syn/filelists/ae350_cpu_subsystem_lef.syn.f

filelist_syn_config_ss:
	echo $(sort $(abspath $(CONFIG_SS_MAKEFILE_RTL_SRC)))  | sed 's/ /\n/g' | sed "s|$(GEMINI_DIR)|\x24GEMINI|g" > $(ABS_PATH_FILELIST)/../../syn/filelists/config_ss_rtl.syn.f
	echo $(sort $(abspath $(CONFIG_SS_MAKEFILE_RTL_INC)))  | sed 's/ /\n/g' | sed "s|$(GEMINI_DIR)|\x24GEMINI|g" > $(ABS_PATH_FILELIST)/../../syn/filelists/config_ss_inc.syn.f
	echo $(sort $(abspath $(CONFIG_SS_MAKEFILE_LIB_SRC)))  | sed 's/ /\n/g' | sed "s|$(GEMINI_DIR)|\x24GEMINI|g" > $(ABS_PATH_FILELIST)/../../syn/filelists/config_ss_lib.syn.f
	echo $(sort $(abspath $(CONFIG_SS_MAKEFILE_LEF_SRC)))  | sed 's/ /\n/g' | sed "s|$(GEMINI_DIR)|\x24GEMINI|g" > $(ABS_PATH_FILELIST)/../../syn/filelists/config_ss_lef.syn.f

filelist_syn_rsnoc:
	echo $(sort $(abspath $(NOC_RTL_MAKEFILE_SRC)))        | sed 's/ /\n/g' | sed "s|$(GEMINI_DIR)|\x24GEMINI|g" > $(ABS_PATH_FILELIST)/../../syn/filelists/rsnoc_rtl.syn.f
	echo $(sort $(abspath $(NOC_RTL_MAKEFILE_INC)))        | sed 's/ /\n/g' | sed "s|$(GEMINI_DIR)|\x24GEMINI|g" > $(ABS_PATH_FILELIST)/../../syn/filelists/rsnoc_inc.syn.f

filelist_syn_memss:
	echo $(sort $(abspath $(MEM_SS_MAKEFILE_RTL_SRC)))     | sed 's/ /\n/g' | sed "s|$(GEMINI_DIR)|\x24GEMINI|g" > $(ABS_PATH_FILELIST)/../../syn/filelists/memss_rtl.syn.f
	echo $(sort $(abspath $(MEM_SS_MAKEFILE_RTL_INC)))     | sed 's/ /\n/g' | sed "s|$(GEMINI_DIR)|\x24GEMINI|g" > $(ABS_PATH_FILELIST)/../../syn/filelists/memss_inc.syn.f
	echo $(sort $(abspath $(MEM_SS_MAKEFILE_LIB_SRC)))     | sed 's/ /\n/g' | sed "s|$(GEMINI_DIR)|\x24GEMINI|g" > $(ABS_PATH_FILELIST)/../../syn/filelists/memss_lib.syn.f
	echo $(sort $(abspath $(MEM_SS_MAKEFILE_LEF_SRC)))     | sed 's/ /\n/g' | sed "s|$(GEMINI_DIR)|\x24GEMINI|g" > $(ABS_PATH_FILELIST)/../../syn/filelists/memss_lef.syn.f
	echo $(sort $(abspath $(MEM_SS_MAKEFILE_DB_SRC)))      | sed 's/ /\n/g' | sed "s|$(GEMINI_DIR)|\x24GEMINI|g" > $(ABS_PATH_FILELIST)/../../syn/filelists/memss_db.syn.f

filelist_syn_soc_fpga_intf:
	echo $(sort $(abspath $(SOC_FPGA_INTF_MAKEFILE_RTL_SRC)))  | sed 's/ /\n/g' | sed "s|$(GEMINI_DIR)|\x24GEMINI|g" > $(ABS_PATH_FILELIST)/../../syn/filelists/soc_fpga_intf_rtl.syn.f
	echo $(sort $(abspath $(SOC_FPGA_INTF_MAKEFILE_RTL_INC)))  | sed 's/ /\n/g' | sed "s|$(GEMINI_DIR)|\x24GEMINI|g" > $(ABS_PATH_FILELIST)/../../syn/filelists/soc_fpga_intf_inc.syn.f
	echo $(sort $(abspath $(SOC_FPGA_INTF_MAKEFILE_LIB_SRC)))  | sed 's/ /\n/g' | sed "s|$(GEMINI_DIR)|\x24GEMINI|g" > $(ABS_PATH_FILELIST)/../../syn/filelists/soc_fpga_intf_lib.syn.f
	echo $(sort $(abspath $(SOC_FPGA_INTF_MAKEFILE_LEF_SRC)))  | sed 's/ /\n/g' | sed "s|$(GEMINI_DIR)|\x24GEMINI|g" > $(ABS_PATH_FILELIST)/../../syn/filelists/soc_fpga_intf_lef.syn.f

filelist_syn_soc_ss:
	echo $(sort $(abspath $(SOC_SS_MAKEFILE_RTL_SRC)))  | sed 's/ /\n/g' | sed "s|$(GEMINI_DIR)|\x24GEMINI|g" > $(ABS_PATH_FILELIST)/../../syn/filelists/soc_ss_rtl.syn.f
	echo $(sort $(abspath $(SOC_SS_MAKEFILE_RTL_INC)))  | sed 's/ /\n/g' | sed "s|$(GEMINI_DIR)|\x24GEMINI|g" > $(ABS_PATH_FILELIST)/../../syn/filelists/soc_ss_inc.syn.f
	echo $(sort $(abspath $(SOC_SS_MAKEFILE_LIB_SRC)))  | sed 's/ /\n/g' | sed "s|$(GEMINI_DIR)|\x24GEMINI|g" > $(ABS_PATH_FILELIST)/../../syn/filelists/soc_ss_lib.syn.f
	echo $(sort $(abspath $(SOC_SS_MAKEFILE_LEF_SRC)))  | sed 's/ /\n/g' | sed "s|$(GEMINI_DIR)|\x24GEMINI|g" > $(ABS_PATH_FILELIST)/../../syn/filelists/soc_ss_lef.syn.f

filelist_syn_top:
	echo $(sort $(abspath $(TOP_MAKEFILE_RTL_SRC)))  | sed 's/ /\n/g' | sed "s|$(GEMINI_DIR)|\x24GEMINI|g" > $(ABS_PATH_FILELIST)/../../syn/filelists/top_rtl.syn.f
	echo $(sort $(abspath $(TOP_MAKEFILE_RTL_INC)))  | sed 's/ /\n/g' | sed "s|$(GEMINI_DIR)|\x24GEMINI|g" > $(ABS_PATH_FILELIST)/../../syn/filelists/top_inc.syn.f
	echo $(sort $(abspath $(TOP_MAKEFILE_LIB_SRC)))  | sed 's/ /\n/g' | sed "s|$(GEMINI_DIR)|\x24GEMINI|g" > $(ABS_PATH_FILELIST)/../../syn/filelists/top_lib.syn.f
	echo $(sort $(abspath $(TOP_MAKEFILE_LEF_SRC)))  | sed 's/ /\n/g' | sed "s|$(GEMINI_DIR)|\x24GEMINI|g" > $(ABS_PATH_FILELIST)/../../syn/filelists/top_lef.syn.f


#RTL_SRC   := $(sort ($(CONFIG_SS_RTL_SRC)+$(MEM_SS_RTL_SRC)+$(TOP_RTL_SRC)))
#RTL_INC   := $(sort ($(CONFIG_SS_RTL_INC)+$(MEM_SS_RTL_INC)))
#MODEL_SRC := $(sort ($(CONFIG_SS_MODEL_SRC)+$(MEM_SS_MODEL_SRC)))
#LIB_SRC   := $(sort ($(CONFIG_SS_LIB_SRC)+$(MEM_SS_LIB_SRC)))
#LEF_SRC   := $(sort ($(CONFIG_SS_LEF_SRC)+$(MEM_SS_LEF_SRC)))

all:
	@echo $(ABS_PATH_FILELIST)

