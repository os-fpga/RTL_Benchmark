ABS_PATH := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))

RTL_SRC := $(ABS_PATH)mailbox.sv
RTL_INC := $(ABS_PATH)
