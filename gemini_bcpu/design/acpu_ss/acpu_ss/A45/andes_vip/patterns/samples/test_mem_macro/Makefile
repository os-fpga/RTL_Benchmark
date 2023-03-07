
include ../Make.vars

VDEFINES += +define+NDS_TB_PAT+NDS_SKIP_LM_SIZE_CHECK

ifeq ($(VERILOG), vcs)
OPTS =
else
OPTS = -xceligen rand_struct
endif

include ../Make.rules

test:   guard-NDS_HOME
	@rm -f flist
	@sed -e "s,\$$NDS_HOME,$$NDS_HOME," < $$NDS_HOME/flists/flist.in | grep -v "#" | sed -e "s,//*,/,g" > flist
	$(SIMULATION_COMMAND) $(OPTS) -f flist
