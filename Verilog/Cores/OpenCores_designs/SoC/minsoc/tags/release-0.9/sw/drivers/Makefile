all: libdrivers.a

libdrivers.a: eth.o uart.o interrupts.o can.o i2c.o tick.o
	$(OR32_TOOL_PREFIX)-ar cru libdrivers.a eth.o uart.o interrupts.o can.o i2c.o tick.o
	$(OR32_TOOL_PREFIX)-ranlib libdrivers.a

eth.o: eth.c
	$(OR32_TOOL_PREFIX)-gcc $(GCC_OPT) $? -c -o $@

uart.o: uart.c
	$(OR32_TOOL_PREFIX)-gcc $(GCC_OPT) $? -c -o $@

interrupts.o: interrupts.c
	$(OR32_TOOL_PREFIX)-gcc $(GCC_OPT) $? -c -o $@

can.o: can.c
	$(OR32_TOOL_PREFIX)-gcc $(GCC_OPT) $? -c -o $@

i2c.o: i2c.c
	$(OR32_TOOL_PREFIX)-gcc $(GCC_OPT) $? -c -o $@

tick.o: tick.c
	$(OR32_TOOL_PREFIX)-gcc $(GCC_OPT) $? -c -o $@

include ../support/Makefile.inc
