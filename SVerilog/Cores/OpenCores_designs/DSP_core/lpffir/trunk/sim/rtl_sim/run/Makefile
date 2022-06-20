export SYSTEMC ?= /opt/tools/SystemC/current/
export SYSTEMC_ARCH = linux64

TOP_RTL      = bench
TOP_RTL_FILE = $(patsubst %,%.sv,$(TOP_RTL))
RTL_PATH     = ../../../rtl
BENCH_PATH   = ../../../bench/verilog
SC_TB_FILE   = ../../../bench/systemc/main.cpp
OBJ_DIR      = obj_dir
EXE          = simu

VERILATOR_OPT  = -sc --trace -y $(RTL_PATH) -y $(BENCH_PATH) -exe -o ../$(EXE)

.PHONY: gen exe all clean wave

all:
	make gen
	make exe

gen:
	verilator $(VERILATOR_OPT) $(TOP_RTL_FILE) $(SC_TB_FILE)

exe:
	make -C $(OBJ_DIR) -f $(patsubst %,V%.mk, $(TOP_RTL))

wave:
	gtkwave wave.gtkw

clean:
	rm -f *.vcd
	rm -fr $(OBJ_DIR)
	rm -f $(EXE)
