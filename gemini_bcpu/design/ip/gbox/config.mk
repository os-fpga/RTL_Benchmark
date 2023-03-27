ABS_PATH := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))

RTL_SRC := $(ABS_PATH)gbox_top.sv.sv 
          
RTL_INC := $(ABS_PATH)
