
include ../Make.vars

LIB_OBJS += atcdmac300.o
VDEFINES += +define+NDS_TB_PAT +define+NDS_SKIP_MISALIGNED_DEVICE_SLAVE_PORT_CHECK

ifeq ($(VERILOG), vcs)
OPTS =
else
OPTS = -xceligen rand_struct
endif

include ../Make.rules

rpt:                                                                                                                                                                    
	@rm -f latency.log
	@./parselog
	@echo Generate rpt in latency.log
