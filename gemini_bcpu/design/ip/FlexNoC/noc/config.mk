ABS_PATH := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))

# !!! Synchronizer and clock gater RTL modules below must be later substituted by tech. lib cells !!!
RTL_SRC := $(ABS_PATH)rsnoc_commons.v \
           $(ABS_PATH)rtl.ClockManagerCell.v \
           $(ABS_PATH)rtl.SynchronizerCell.v \
           $(ABS_PATH)rtl.GaterCell.v \
           $(ABS_PATH)rsnoc.v

RTL_STUB := $(ABS_PATH)../stub/rsnoc_stub.v          
           
RTL_INC := $(ABS_PATH)