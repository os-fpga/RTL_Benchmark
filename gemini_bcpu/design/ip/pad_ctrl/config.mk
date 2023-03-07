ABS_PATH := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))

RTL_SRC := $(ABS_PATH)apb_pad_ctrl.sv 
          
RTL_INC := $(ABS_PATH)