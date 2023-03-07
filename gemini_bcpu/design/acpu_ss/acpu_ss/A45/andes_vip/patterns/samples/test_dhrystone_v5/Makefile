include ../Make.vars

include ../Make.rules

FILES   = start.S init.S dhry_1.c dhry_2.c
COPTS   = -O3 -flto -fno-inline 
OBJS    = $(subst .c,.o,$(subst .S,.o,$(FILES)))
LDFLAGS = -static -nostartfiles -Xlinker -Tdhry.ld
CFLAGS  = -c $(COPTS) -I../include -DTIME -include dummyio.h
#CFLAGS += -DNO_CONFLICT=1024

.PHONY: getdmips dhry

dhry: dhry.exe
	@rm -f a.out
	@rm -f NDSROM.dat NDSROM.list
	[ -f dhry.exe ] && riscv-elf-aout2mem dhry.exe NDSROM.dat
	@cp -f dhry.exe a.out
	@rm -f dhry.exe

rmobjs:
	@rm -f *.o

getdmips:
	@rm -f dmips.log
	./getdmips.pl 
	cat dmips.log

gentcf:
	@rm -f dmips.log
	@rm -f flist
	@sed -e "s,\$$NDS_HOME,$$NDS_HOME," < $$NDS_HOME/flists/flist.in | grep -v "#" > flist
	./getdmips.pl
	./setup_power_sim.pl $(TCF_SCOPE) tcf
	$(SIMULATION_COMMAND) -f flist +notimingchecks $(POWER_RPT_COMMAND) +access+r
	@echo; echo; echo "INFO: TCF file and pf_info genereated"; echo;

gensaif:
	@rm -f dmips.log
	@rm -f flist
	@sed -e "s,\$$NDS_HOME,$$NDS_HOME," < $$NDS_HOME/flists/flist.in | grep -v "#" > flist
	./getdmips.pl
	./setup_power_sim.pl $(TCF_SCOPE) saif
	$(SIMULATION_COMMAND) -f flist +notimingchecks $(POWER_RPT_COMMAND) +access+r
	@echo; echo; echo "INFO: SAIF file and pf_info genereated"; echo;

dhry.exe: rmobjs $(OBJS)
	$(CC) $(LDFLAGS) $(CFLAGS:-c=) $(OBJS) -o $@

dhry_1.o: dhry_1.c
	$(CC) $(CFLAGS) $^ -o $@

.S.o:
	$(CC) $(CFLAGS) $^ -o $@

.c.o:
	$(CC) $(CFLAGS) $^ -o $@

