ABS_PATH := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))

RTL_SRC := $(ABS_PATH)gemini.v \
           $(ABS_PATH)soc_ss_shell.sv

RTL_STUB :=

RTL_INC := $(ABS_PATH)../castor \
           $(ABS_PATH)../intf

MODEL_SRC :=
LIB_SRC :=
LEF_SRC :=
