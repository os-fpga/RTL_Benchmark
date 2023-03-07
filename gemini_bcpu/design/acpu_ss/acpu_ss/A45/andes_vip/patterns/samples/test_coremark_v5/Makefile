include ../Make.vars

include ../Make.rules

GIT_REPO = https://github.com/eembc/coremark
FILES	 = start.S init.S core_portme.c core_list_join.c core_main.c core_matrix.c core_state.c core_util.c
EXE      = coremark.exe
OBJS=$(subst .c,.o,$(subst .S,.o,$(FILES)))

OPTFLAGS = -O3 -funroll-all-loops -finline-limit=600 -ftree-dominator-opts -fno-if-conversion2 -fselective-scheduling -fno-code-hoisting -mcmov

LIBFLAGS = -static -nostartfiles
MFLAGS   =  
SIMFLAGS = -DSEED_METHOD=SEED_VOLATILE -DPERFORMANCE_RUN=1 -DITERATIONS=4 -DMEM_METHOD=MEM_STACK -DNDS32_SID -DNDS32_RTLSIM
LDFLAGS  = $(LIBFLAGS) -Xlinker "-Tcoremark.ld"
CFLAGS	 = -c $(OPTFLAGS) $(MFLAGS) $(SIMFLAGS) -I../include -DTIME
.PHONY: getcoremark coremark core_portme.h core_portme.c core_main.c git_clone checkfiles clean_git

coremark: git_clone checkfiles core_portme.h core_portme.c $(EXE)
	@rm -f a.out
	@rm -f NDSROM.dat NDSROM.list
	[ -f coremark.exe ] && riscv-elf-aout2mem coremark.exe NDSROM.dat
	@cp -f coremark.exe a.out
	@rm -f coremark.exe

rmobjs:
	@rm -f *.o

$(EXE): rmobjs $(OBJS)
	        $(CC) $(LDFLAGS) $(CFLAGS:-c=) $(OBJS) -o $@

core_main.o: core_main.c
	$(CC) $(CFLAGS:-funroll%-loops=) $^ -o $@     # remove -funroll-loops or -funroll-all-loops flag from $(OPTFLAGS)
core_list_join.o: core_list_join.c
	$(CC) $(CFLAGS) $^ -o $@
core_matrix.o: core_matrix.c
	$(CC) $(CFLAGS) $^ -o $@
core_state.o: core_state.c
	$(CC) $(CFLAGS) $^ -o $@
core_util.o: core_util.c
	$(CC) $(CFLAGS) $^ -o $@

.S.o:
	$(CC) $(CFLAGS) $^ -o $@

.c.o:
	$(CC) $(CFLAGS) $^ -o $@

core_portme.c:
	cp -f nds_core_portme.c core_portme.c
core_portme.h:
	cp -f nds_core_portme.h core_portme.h

getcoremark:
	@rm -f coremark.log
	./getcoremark.pl 
	cat coremark.log

gentcf:
	@rm -f coremark.log
	@rm -f flist
	@sed -e "s,\$$NDS_HOME,$$NDS_HOME," < $$NDS_HOME/flists/flist.in | grep -v "#" > flist
	./getcoremark.pl
	./setup_power_sim.pl $(TCF_SCOPE)
	$(SIMULATION_COMMAND) -f flist +notimingchecks $(POWER_RPT_COMMAND) +access+r
	@echo; echo; echo "INFO: TCF file and pf_info genereated"; echo;

gensaif:
	@rm -f coremark.log
	@rm -f flist
	@sed -e "s,\$$NDS_HOME,$$NDS_HOME," < $$NDS_HOME/flists/flist.in | grep -v "#" > flist
	./getcoremark.pl
	./setup_power_sim.pl $(TCF_SCOPE) saif
	$(SIMULATION_COMMAND) -f flist +notimingchecks $(POWER_RPT_COMMAND) +access+r
	@echo; echo; echo "INFO: SAIF file and pf_info genereated"; echo;

git_clone:
	if [ ! -f core_main.c ]; then \
		[ -d coremark ] || git clone --depth 1 $(GIT_REPO) ; \
		[ -f coremark/core_main.c ] ; \
		ln -sf coremark/*.[ch] . ; \
	fi

distclean: clean cleanrom clean_git

clean_git:
	rm -rf coremark
	@for i in core_*.[ch]; do \
		if [ -L "$$i" ]; then rm $$i; fi \
	done
	@if [ -L "coremark.h" ]; then rm coremark.h; fi

checkfiles:
	@ for i in coremark.h core_list_join.c core_main.c core_matrix.c core_state.c core_util.c; do \
		if [ ! -f $$i ]; then \
			echo "ERROR: $$i file doesn't exist, please see Data Sheet for details"; \
			exit 1; \
		fi \
	done
