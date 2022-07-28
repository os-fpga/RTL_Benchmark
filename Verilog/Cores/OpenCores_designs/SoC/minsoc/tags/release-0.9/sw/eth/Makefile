cases = eth-nocache eth-icdc
common = ../support/libsupport.a ../support/except.o
drivers = ../drivers/libdrivers.a

all: $(cases)

eth-nocache: eth.o ../support/reset-nocache.o $(common) $(drivers)
	$(OR32_TOOL_PREFIX)-gcc $(GCC_OPT) $(GCC_LIB_OPTS) -T ../support/orp.ld $? -o $@.or32
	$(OR32_TOOL_PREFIX)-objcopy -O binary $@.or32 $@.bin
	../utils/bin2hex $@.bin 1 -size_word > $@$(FLASH_MEM_HEX_FILE_SUFFIX).hex
	../utils/bin2vmem $@.bin > $@.vmem


eth-icdc: eth.o ../support/reset-icdc.o $(common) $(drivers)
	$(OR32_TOOL_PREFIX)-gcc $(GCC_OPT) $(GCC_LIB_OPTS) -T ../support/orp.ld $? -o $@.or32
	$(OR32_TOOL_PREFIX)-objcopy -O binary $@.or32 $@.bin
	../utils/bin2hex $@.bin 1 -size_word > $@$(FLASH_MEM_HEX_FILE_SUFFIX).hex
	../utils/bin2vmem $@.bin > $@.vmem


eth.o: eth.c
	$(OR32_TOOL_PREFIX)-gcc $(GCC_OPT) $? -c -o $@

include ../support/Makefile.inc
