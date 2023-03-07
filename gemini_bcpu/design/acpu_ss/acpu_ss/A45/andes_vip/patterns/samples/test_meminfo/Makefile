
.PHONY: getmeminfo

include ../Make.vars

VDEFINES += +define+NDS_INTERNAL_SIM

include ../Make.rules

getmeminfo: test
	grep 'NDS_MEM_INFO' verilog.log | sort > meminfo.raw
	perl meminfo.pl meminfo.raw | tee meminfo.txt
