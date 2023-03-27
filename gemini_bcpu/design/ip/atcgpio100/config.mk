ABS_PATH := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))

RTL_SRC := $(ABS_PATH)hdl/atcgpio100.v \
           $(ABS_PATH)hdl/atcgpio100_apbslv.v \
           $(ABS_PATH)hdl/atcgpio100_gpio.v

RTL_STUB := $(ABS_PATH)hdl/stub/atcgpio100_stub.v           

RTL_INC := $(ABS_PATH)hdl/include