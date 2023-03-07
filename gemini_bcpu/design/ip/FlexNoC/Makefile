include fc.mk
include anvu_build_options.mk
include noc/anvu_noc_options.mk

debug=0
enable_fsdb_transaction=0
enable_kdb=0

ifeq (${nttpInstrumentation},1)
	INSTRUMENTATION_FLAGS= -P pli.tab +vpi noc/libVpiBehaviourWrapper.so
else
	INSTRUMENTATION_FLAGS=
endif
ifeq (${createWaves},1)
	debug=1
	WAVE_OPTS=-ucli -i $$\2.tcl
else
	WAVE_OPTS=
endif
VCS_FLAGS=-CFLAGS -Wa,--64 -LDFLAGS -Wl,-L/lib,-L/usr/lib -CFLAGS -DVCS ${UVM_HOME}/src/dpi/uvm_dpi.cc +vcs+lic+wait -q -sverilog ${DEBUG_FLAG} -full64
ifeq (${enable_fsdb_transaction},1)
	debug=1
	createWaves=1
	FSDB_BUILD_FLAGS=+define+SVT_FSDB_ENABLE  -ntb_opts uvm
	VCS_FLAGS=-CFLAGS -Wa,--64 -LDFLAGS -Wl,-L/lib,-L/usr/lib -CFLAGS -DVCS  +vcs+lic+wait -q -sverilog ${DEBUG_FLAG} -full64
	WAVE_OPTS= +UVM_VERDI_TRACE=UVM_AWARE+TLM+PRINT+HIER+RAL +UVM_LOG_RECORD +UVM_TR_RECORD +svt_enable_pa=FSDB -ucli -i $$\2.tcl
endif

ifeq (${debug},1)
	DEBUG_FLAG=-debug_acc
else
	DEBUG_FLAG=
endif
ifeq (${enable_kdb},1)
	KDB_FLAGS=-lca -kdb
endif
build_name=anvu_build_files.base
VIP_FLAGS=+define+SYNOPSYS_SV
NTB_FLAGS=-ntb_opts use_sigprop

NOWARNINGS= +warn=noPCWM-W


STD_DEP=anvu_build_options.mk Makefile

all: compilation

########################
# Standard compilation #
########################
runUvmTestEnv: $(wildcard sv/*.sv) $(wildcard *.sv) $(wildcard noc/*.sv) $(wildcard noc/*.v) anvu_build_vipModelList ${build_name} anvu_uvmTestEnv_Top.v ${STD_DEP}
	${DESIGNWARE_HOME}/bin/dw_vip_setup -path vips -add -model_list anvu_build_vipModelList -svtb
	cat ${build_name} > anvu_build_files
	vcs ${VCS_FLAGS} ${NTB_FLAGS} ${FSDB_BUILD_FLAGS} ${KDB_FLAGS} ${VIP_FLAGS} ${AIP_FLAGS} ${INSTRUMENTATION_FLAGS} ${NOWARNINGS} -timescale=${timescale} ${userBuildFlags}  -o runUvmTestEnv -f anvu_build_files 


runUvmTestEnv.sh: sv/runUvmTestEnv.sh.templ runUvmTestEnv ${STD_DEP}
	echo "#!/bin/bash" > runUvmTestEnv.sh
	echo waveOpts=\"${WAVE_OPTS}\" >> runUvmTestEnv.sh
	cat sv/runUvmTestEnv.sh.templ >> runUvmTestEnv.sh
	chmod a+x runUvmTestEnv.sh

.PHONY: check runSimulation
check:
	@echo;if [ "${UVM_HOME}" == "" ]; then echo "---";echo "Please set your UVM_HOME environment variable";echo "---"; exit 1 ; fi
	@echo;if ! echo "${UVM_HOME}" | grep -q "etc/uvm-1.2"; then echo "---";echo "Please set your UVM_HOME environment variable to use UVM 1.2.";echo "---"; exit 1 ; fi
	@echo;if [ "${DESIGNWARE_HOME}" == "" ]; then echo "---";echo "Please set your DESIGNWARE_HOME environment variable";echo "---"; exit 1 ; fi
	@echo;if [ "$(shell vcs -ID | grep "script version" | cut -d " " -f 5 | cut -d "-" -f 2 | cut -d "." -f 1)" -lt "2011" ]; then echo "---";echo "Minimal VCS version required is 2011 - current version is $(shell  vcs -ID | grep "script version" | cut -d " " -f 5)."; echo "---"; exit 1; fi

compilation: check runUvmTestEnv.sh

simulation: check connectivity

tests: check connectivity connectivityWithSlvError latency throughput registerMap random thorough probeConnectivity userBit flowControl power

clean:
	rm -rf runUvmTestEnv* vips csrc simv*


random : check runUvmTestEnv runUvmTestEnv.sh  $(wildcard noc/*.txt) $(wildcard anvu_sim*)
	./runUvmTestEnv.sh anvu_random_test random
connectivity : check runUvmTestEnv runUvmTestEnv.sh  $(wildcard noc/*.txt) $(wildcard anvu_sim*)
	./runUvmTestEnv.sh anvu_connectivity_test connectivity
connectivityWithSlvError : check runUvmTestEnv runUvmTestEnv.sh  $(wildcard noc/*.txt) $(wildcard anvu_sim*)
	./runUvmTestEnv.sh anvu_connectivityWithSlvError_test connectivityWithSlvError
latency : check runUvmTestEnv runUvmTestEnv.sh  $(wildcard noc/*.txt) $(wildcard anvu_sim*)
	./runUvmTestEnv.sh anvu_latency_test latency
throughput : check runUvmTestEnv runUvmTestEnv.sh  $(wildcard noc/*.txt) $(wildcard anvu_sim*)
	./runUvmTestEnv.sh anvu_throughput_test throughput
flowControl : check runUvmTestEnv runUvmTestEnv.sh  $(wildcard noc/*.txt) $(wildcard anvu_sim*)
	./runUvmTestEnv.sh anvu_flowControl_test flowControl
registerMap : check runUvmTestEnv runUvmTestEnv.sh  $(wildcard noc/*.txt) $(wildcard anvu_sim*)
	./runUvmTestEnv.sh anvu_registerMap_test registerMap
thorough : check runUvmTestEnv runUvmTestEnv.sh  $(wildcard noc/*.txt) $(wildcard anvu_sim*)
	./runUvmTestEnv.sh anvu_thorough_test thorough
probeConnectivity : check runUvmTestEnv runUvmTestEnv.sh  $(wildcard noc/*.txt) $(wildcard anvu_sim*)
	./runUvmTestEnv.sh anvu_probeConnectivity_test probeConnectivity
userBit : check runUvmTestEnv runUvmTestEnv.sh  $(wildcard noc/*.txt) $(wildcard anvu_sim*)
	./runUvmTestEnv.sh anvu_userBit_test userBit
power : check runUvmTestEnv runUvmTestEnv.sh  $(wildcard noc/*.txt) $(wildcard anvu_sim*)
	./runUvmTestEnv.sh anvu_power_test power
bist : check runUvmTestEnv runUvmTestEnv.sh  $(wildcard noc/*.txt) $(wildcard anvu_sim*)
	./runUvmTestEnv.sh anvu_bist_test bist
 
