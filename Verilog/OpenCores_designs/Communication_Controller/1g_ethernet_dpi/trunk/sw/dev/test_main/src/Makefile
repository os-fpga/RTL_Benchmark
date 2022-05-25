#
# makefile
#

TARGET_NAME = test_main

all: clean bsp_prep $(TARGET_NAME)

CC = gcc
CPP= g++
LD = g++
OBJDUMP = objdump
DEFAULT_CP := cp -f
DEFAULT_MKDIR := mkdir -p
DEFAULT_RM := rm -rf
BSP_ROOT_DIR := ../process/bsp_0/microblaze_0/include
BSP_COSIM_DIR := ./_hdl/bsp

INCDIR := ./ \
 /usr/local/modelsim/modelsim_dlx/include \
 ./_hdl/dpi \
 ./_hdl/bsp \
 ./_hdl/bsp/include \
 ./_hdl/bsp/libsrc/axidma_v9_0/src \
 ./xil_lib \
 ./net \
 ../../../../hw/src/rtl/tri_mode_emac/sw/src 


INCLUDE := $(addprefix -I, $(INCDIR))
CFLAGS := -DMSIM 
CFLAGS += -g
CFLAGS += -rdynamic
CFLAGS += $(INCLUDE)

C_SRCS := $(wildcard ./_hdl/dpi/*.c)
C_SRCS += $(wildcard ./_hdl/bsp/libsrc/standalone_v5_3/src/*.c)
C_SRCS += $(wildcard ./_hdl/bsp/libsrc/axidma_v9_0/src/*.c)
C_SRCS += $(wildcard ../../../../hw/src/rtl/tri_mode_emac/sw/src/*.c)
C_SRCS += $(wildcard ./xil_lib/*.c)
C_SRCS += $(wildcard ./net/*.c)
C_SRCS += $(wildcard ./main/*.c)

OBJFILE_C := $(patsubst %.c,%.o, $(C_SRCS))


$(TARGET_NAME): $(OBJFILE_C)
	@echo C_SRCS: $(C_SRCS)
	$(LD) -shared -o $(TARGET_NAME).so $(notdir $^) $(LDFLAGS) $(LIBRARIES)
	$(OBJDUMP) -S -d $(TARGET_NAME).so > $(TARGET_NAME).objdump
	rm -f *.o *~ core
	rm -f *.d *~ core
	@echo DONE: so-lib DPI-C

%.o: %.c
	@echo Compiling $<:
	$(CC) $(CFLAGS) $(LIBRARIES) -fPIC -c $<

clean:
	@echo clean:
	$(DEFAULT_RM) $(BSP_COSIM_DIR)/xparameters.h
	$(DEFAULT_RM) *.objdump
	$(DEFAULT_RM) $(TARGET_NAME).so

bsp_prep:
	@echo bsp_prep:
	$(DEFAULT_RM) $(BSP_COSIM_DIR)/xparameters.h
	$(DEFAULT_CP) $(BSP_ROOT_DIR)/xparameters.h $(BSP_COSIM_DIR)
