include ../Make.vars

include ../Make.rules

FILES   = start.S init.S whet.c putchar.c nds_function.c
OBJS    = $(subst .c,.o,$(subst .S,.o,$(FILES)))
LDFLAGS = -static -nostartfiles -Xlinker -Twhet.ld -lm
DEFINES = -DTIME -include dummyio.h

FPU_TEST_TYPE = sp
# FPU_TEST_TYPE = dp

ifeq ($(FPU_TEST_TYPE), sp)
#for sp
COPTS   = -O3 -funroll-loops -fsingle-precision-constant
CFLAGS  = -c $(COPTS) -I../include 
else
#for dp
COPTS  = -O3 -funroll-loops
CFLAGS = -c $(COPTS) -I../include -DDP
endif

ifdef FPU_NO_FMA
CFLAGS += -mno-fma
else
CFLAGS += -DFUSED
endif

.PHONY: getwips whet

whet: whet.exe
	@rm -f a.out
	@rm -f NDSROM.dat NDSROM.list
	[ -f whet.exe ] && riscv-elf-aout2mem whet.exe NDSROM.dat
	@cp -f whet.exe a.out
	@rm -f whet.exe

rmobjs:
	@rm -f *.o

getwips:
	@rm -f whet.log
	./getwips.pl
	cat whet.log

gentcf:
	@rm -f whet.log
	@rm -f flist
	@sed -e "s,\$$NDS_HOME,$$NDS_HOME," < $$NDS_HOME/flists/flist.in | grep -v "#" > flist
	./getwips.pl
	./setup_power_sim.pl $(TCF_SCOPE)
	$(SIMULATION_COMMAND) -f flist +notimingchecks $(POWER_RPT_COMMAND) +access+r
	@echo; echo; echo "TCF file and pf_info genereated"; echo;

gensaif:
	@rm -f whet.log
	@rm -f flist
	@sed -e "s,\$$NDS_HOME,$$NDS_HOME," < $$NDS_HOME/flists/flist.in | grep -v "#" > flist
	./getwips.pl
	./setup_power_sim.pl $(TCF_SCOPE) saif
	$(SIMULATION_COMMAND) -f flist +notimingchecks $(POWER_RPT_COMMAND) +access+r
	@echo; echo; echo "INFO: SAIF file and pf_info genereated"; echo;


whet.exe: rmobjs $(OBJS)
	$(CC) $(CFLAGS:-c=) $(OBJS) $(LDFLAGS) -o $@ 

whet.o: whet.c
	$(CC) $(CFLAGS) $(DEFINES) $^ -o $@

.S.o:
	$(CC) $(CFLAGS) $^ -o $@

.c.o:
	$(CC) $(CFLAGS) $^ -o $@

