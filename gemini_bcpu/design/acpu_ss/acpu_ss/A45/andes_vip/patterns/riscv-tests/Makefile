.PHONY: rtl setup rom clean result
abs_top_src_dir := $$NDS_HOME/andes_vip/patterns/riscv-tests
XLEN            := 32
ILM_SIZE	:= 1024
RVC            	:= yes
RVA            	:= yes
RVF		:= no
RVD		:= no
S_MODE		:= no
MMU		:= yes
isa_src_dir     := $(abs_top_src_dir)/isa
run_dir		:= $(abs_top_src_dir)/rundir
SUBDIRS = $(wildcard rundir/test_*)
EXCL_TESTS	:=  rv64ud/move rv32ud/move
ARG =

ifneq ($(ILM_SIZE),0)
	EXCL_TESTS += rv64si/dirty rv32si/dirty
else ifneq ($(MMU),yes)
	EXCL_TESTS += rv64si/dirty rv32si/dirty
endif

ifeq ($(XLEN),32)
	src = rv32ui rv32um rv32mi
	ifeq ($(RVC),yes)
		src += rv32uc
	endif
	ifeq ($(RVA),yes)
		src += rv32ua
	endif
	ifeq ($(RVF),yes)
		src += rv32uf
	endif
	ifeq ($(RVD),yes)
		src += rv32ud
	endif
	ifeq ($(S_MODE), yes)
		src += rv32si
	endif
else
	src = rv64ui rv64um rv64mi
	ifeq ($(RVC),yes)
		src += rv64uc
	endif
	ifeq ($(RVA),yes)
		src += rv64ua
	endif
	ifeq ($(RVF),yes)
		src += rv64uf
	endif
	ifeq ($(RVD),yes)
		src += rv64ud
	endif
	ifeq ($(S_MODE), yes)
		src += rv64si
	endif
endif

rtl:
	for i in $(SUBDIRS); do $(MAKE) -C $$i $@; done
	make result

result:
	@echo
	grep -E -e "ERROR|- SIMULATION" $(SUBDIRS:=/*verilog.log)
	$(eval total := $(shell ls rundir |grep test_* |wc -l))
	$(eval pass  := $(shell find $(SUBDIRS:=/*verilog.log) -exec sh -c "tac '{}' | grep -Hm1 \"\sSIMULATION\s\" " \; | grep PASSED | wc -l))
	$(eval skip  := $(shell find $(SUBDIRS:=/*verilog.log) -exec sh -c "tac '{}' | grep -Hm1 \"\sSIMULATION\s\" " \; | grep SKIPPED | wc -l))
	$(eval fail  := $(shell let "fail = $(total) - $(pass) - ${skip}" ; echo $$fail))
	@echo -----------------------------------------
	@echo TOTAL=$(total), PASS=$(pass), FAIL=$(fail), SKIP=$(skip)
	@echo -----------------------------------------
	make result_skip

result_skip:
ifeq ($(RVC), no)
	@echo '** skip uc test cases because rvc is not support **'
endif
ifeq ($(RVA), no)
	@echo '** skip ua test cases because rva is not support **'
endif
ifeq ($(RVF), no)
	@echo '** skip uf test cases because single precision is not support **'
endif
ifeq ($(RVD), no)
	@echo '** skip ud test cases because double precision is not support **'
endif
ifeq ($(S_MODE), no)
	@echo '** skip si test cases because S mode is not support **'
endif
ifneq ($(ILM_SIZE), 0)
	@echo '** skip dirty test case because ILM_SIZE is not 0 **'
else ifneq ($(MMU),yes)
	@echo '** skip dirty test case because MMU is not support **'
endif

setup:
	mkdir -p rundir
	rm -rf rundir/test_*
	for i in $(addprefix $(isa_src_dir)/,$(src)); do\
		for j in $${i}/*.S; do \
			filename="$${j##*/}"; \
			dir="$(run_dir)/test_$${i##*/}_$${filename%%.*}"; \
			if [[ "$(EXCL_TESTS)" =~ "$${i##*/}/$${filename%.*}" ]]; then \
				continue; \
			fi; \
			mkdir -p $$dir; \
			ln -sf $$j $${dir}/test.S; \
			if [[ $$i =~ rv64ua ]]; then \
				sed '/Make.vars/ a CFLAGS += -march=rv64imafdcxv5' $(run_dir)/Makefile.andes > $${dir}/Makefile; \
			elif [[ $$i =~ rv32ua ]]; then \
				sed '/Make.vars/ a CFLAGS += -march=rv32imafdcxv5' $(run_dir)/Makefile.andes > $${dir}/Makefile; \
			elif [[ $$i =~ rv64ud ]]; then \
				sed '/Make.vars/ a CFLAGS += -march=rv64imafdcxv5' $(run_dir)/Makefile.andes > $${dir}/Makefile; \
			elif [[ $$i =~ rv32ud ]]; then \
				sed '/Make.vars/ a CFLAGS += -march=rv32imafdcxv5' $(run_dir)/Makefile.andes > $${dir}/Makefile; \
			elif [[ $$i =~ rv64uf ]]; then \
				sed '/Make.vars/ a CFLAGS += -march=rv64imafdcxv5' $(run_dir)/Makefile.andes > $${dir}/Makefile; \
			elif [[ $$i =~ rv32uf ]]; then \
				sed '/Make.vars/ a CFLAGS += -march=rv32imafdcxv5' $(run_dir)/Makefile.andes > $${dir}/Makefile; \
			else \
				cp $(run_dir)/Makefile.andes $${dir}/Makefile; \
			fi \
		done; \
	done

rom:
	for i in $(SUBDIRS); do $(MAKE) -C $$i $@; done

clean:
	for i in $(SUBDIRS); do $(MAKE) -C $$i $@; done

rtl_parallel:
	$(eval ncore := $(shell lscpu | grep "^CPU(s)" | sed 's/\(.\+\):\(\s\+\)//g'))
	$(eval nthread := $(shell lscpu | grep "^Thread" | sed 's/\(.\+\):\(\s\+\)//g'))
	$(eval njob := $(shell expr $(ncore)*$(nthread) | bc))
	$(MAKE) -k -j $(njob) parallel
	$(MAKE) result

rom_parallel:
	$(MAKE) -k -j $(shell ls rundir |grep test_* |wc -l) parallel ARG=rom

clean_parallel:
	$(MAKE) -k -j $(shell ls rundir |grep test_* |wc -l) parallel ARG=clean


.PHONY: parallel $(SUBDIRS)
parallel: $(SUBDIRS)
$(SUBDIRS):
	$(MAKE) -C $@ ${ARG}


