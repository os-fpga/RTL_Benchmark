# Set GHDL in environment
GHDL=ghdl 
GHDLFLAGS = --workdir=work -Wl,-lm -Wc,-m32 -Wl,-m32 -Wa,--32  --ieee=synopsys -fexplicit
XST= eis-xst
GHDLA:=$(GHDL) -a $(GHDLFLAGS)
GHDLE:=$(GHDL) -e $(GHDLFLAGS)
#XST= echo
#prevent make from deleting the .o files
.PRECIOUS: work/%.o
all: clean work/eis_helpers.o work/fpu_package.o work/fpu_mul.o work/fpu_add.o work/simple.o openfpu64_tb
	
	#fpu_avalon_func

showme_%: %
	./$< --wave=$<.ghw --stop-time=1ms
	gtkwave $<.ghw $<.sav 

work/%.o: %.vhd
	$(GHDLA) $<

%_tb: eis_helpers.vhd work/eis_helpers.o %.vhd work/%.o %_tb.vhd work/%_tb.o 
	$(GHDLE) $@

%: %.vhd work/%.o
	$(GHDLE) $@

addsub_testsuite:
	cat openfpu64_tb.head.vhd tests/openfpu64_tb.addsub.inc.vhd openfpu64_tb.tail.vhd > openfpu64_tb.vhd

custom_testsuite:
	cat openfpu64_tb.head.vhd tests/openfpu64_tb.custom.inc.vhd openfpu64_tb.tail.vhd > openfpu64_tb.vhd

add_testsuite:
	cat openfpu64_tb.head.vhd tests/openfpu64_tb.add.inc.txt openfpu64_tb.tail.vhd > openfpu64_tb.vhd

sub_testsuite:
	cat openfpu64_tb.head.vhd tests/openfpu64_tb.sub.inc.txt openfpu64_tb.tail.vhd > openfpu64_tb.vhd

mul_testsuite:
	cat openfpu64_tb.head.vhd tests/openfpu64_tb.mul.inc.txt openfpu64_tb.tail.vhd > openfpu64_tb.vhd

clean:
	$(GHDL) --clean --workdir=work
	rm -rfv *.ghw *.cf *.log *.ngc *.ngr *.prj *.xrpt *.ifn *.ise xst_work xlnx_auto_0_xdb implement_viscy viscy.bit

get:
	export PATH=/data/opt/eis/bin/:/usr/local/Simili31/tcl/bin:/usr/local/bin:/usr/bin:/bin:/opt/bin:/usr/x86_64-pc-linux-gnu/arm-unknown-linux-gnu/gcc-bin/4.1.2:/usr/x86_64-pc-linux-gnu/avr/gcc-bin/3.4.6:/usr/x86_64-pc-linux-gnu/gcc-bin/4.1.2:/opt/sourcenav/bin:/usr/kde/3.5/bin:/usr/qt/3/bin:/usr/x86_64-pc-linux-gnu/gnat-gcc-bin/4.2:/usr/libexec/gnat-gcc/x86_64-pc-linux-gnu/4.2:/usr/games/bin:/opt/vmware/player/bin:/sbin:/home/peter/taihu/eldk/bin:/home/peter/taihu/eldk/usr/bin
	. /opt/Xilinx/11.1/settings32.sh
	sh /opt/Xilinx/11.1/settings32.sh
	export PATH=/data/opt/eis/bin/:/usr/local/Simili31/tcl/bin:/usr/local/bin:/usr/bin:/bin:/opt/bin:/usr/x86_64-pc-linux-gnu/arm-unknown-linux-gnu/gcc-bin/4.1.2:/usr/x86_64-pc-linux-gnu/avr/gcc-bin/3.4.6:/usr/x86_64-pc-linux-gnu/gcc-bin/4.1.2:/opt/sourcenav/bin:/usr/kde/3.5/bin:/usr/qt/3/bin:/usr/x86_64-pc-linux-gnu/gnat-gcc-bin/4.2:/usr/libexec/gnat-gcc/x86_64-pc-linux-gnu/4.2:/usr/games/bin:/opt/vmware/player/bin:/sbin:/home/peter/taihu/eldk/bin:/home/peter/taihu/eldk/usr/bin
	. /opt/Xilinx/11.1/settings32.sh
	sh /opt/Xilinx/11.1/settings32.sh


