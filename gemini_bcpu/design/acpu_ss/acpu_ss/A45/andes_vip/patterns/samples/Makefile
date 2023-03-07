include Make.vars
.PHONY: test rom clean cleanrom distclean result

SUBDIRS =
TEST_SUBDIRS = $(wildcard test_*)
ALL_SUBDIRS = $(SUBDIRS) $(TEST_SUBDIRS)
ARG =

test:
	for i in $(TEST_SUBDIRS); do \
		$(MAKE) -C $$i $@; \
	done
	make result

result:
	@$(VERILOG_VERSION)
	grep -E -e "ERROR|- SIMULATION" test_*/*verilog.log
	$(eval total := $(shell ls |grep test_ |wc -l))
	$(eval pass  := $(shell find test_*/*verilog.log -exec sh -c "tac '{}' | grep -Hm1 \"\sSIMULATION\s\" " \; | grep PASSED | wc -l))
	$(eval skip  := $(shell find test_*/*verilog.log -exec sh -c "tac '{}' | grep -Hm1 \"\sSIMULATION\s\" " \; | grep SKIPPED | wc -l))
	$(eval fail  := $(shell let "fail = $(total) - $(pass) - $(skip)" ; echo $$fail))
	@echo -----------------------------------------
	@echo TOTAL=$(total), PASS=$(pass), FAIL=$(fail), SKIP=$(skip)
	@echo -----------------------------------------

rom:
	@for i in $(TEST_SUBDIRS); do \
		if [[ $$i =~ ace ]]; then \
			copilot --version; \
		fi \
	done
	@echo NDS_TOOLCHAIN=$(NDS_TOOLCHAIN)
	for i in $(TEST_SUBDIRS); do \
		if [[ $$i =~ dhrystone ]]; then \
			$(MAKE) -C $$i dhry; \
		elif [[ $$i =~ coremark ]]; then \
			$(MAKE) -C $$i coremark; \
		elif [[ $$i =~ whetstone ]]; then \
			$(MAKE) -C $$i whet; \
		elif [[ $$i =~ ace ]]; then \
			$(MAKE) -C $$i ace_rom; \
		else \
			$(MAKE) -C $$i $@; \
		fi \
	done

clean:
	for i in $(ALL_SUBDIRS); do $(MAKE) -C $$i $@; done

cleanrom:
	for i in $(ALL_SUBDIRS); do $(MAKE) -C $$i $@; done

distclean:
	for i in $(ALL_SUBDIRS); do $(MAKE) -C $$i $@; done

test_parallel:
	$(eval core := $(shell lscpu | grep "^CPU(s)" | sed 's/\(.\+\):\(\s\+\)//g'))
	$(eval thread := $(shell lscpu | grep "^Thread" | sed 's/\(.\+\):\(\s\+\)//g'))
	$(eval core_thread := $(shell expr $(core)/$(thread) | bc))
	$(MAKE) -k -j $(core_thread) parallel
	$(MAKE) result

rom_parallel:
	$(MAKE) -k -j $(shell ls |grep test_ |wc -l) parallel ARG=rom

clean_parallel:
	$(MAKE) -k -j $(shell ls |grep test_ |wc -l) parallel ARG=clean

.PHONY: parallel $(TEST_SUBDIRS)
parallel: $(TEST_SUBDIRS)
$(TEST_SUBDIRS):
ifeq ($(ARG),)
	$(MAKE) -C $@
else
	if [[ $@ =~ dhrystone && ${ARG} =~ rom ]]; then \
		$(MAKE) -C $@ dhry; \
	elif [[ $@ =~ coremark && ${ARG} =~ rom ]]; then \
		$(MAKE) -C $@ coremark; \
	elif [[ $@ =~ whetstone && ${ARG} =~ rom ]]; then \
		$(MAKE) -C $@ whet; \
	elif [[ $@ =~ ace && ${ARG} =~ rom ]]; then \
		$(MAKE) -C $@ ace_rom; \
	else \
		$(MAKE) -C $@ ${ARG}; \
	fi
endif

