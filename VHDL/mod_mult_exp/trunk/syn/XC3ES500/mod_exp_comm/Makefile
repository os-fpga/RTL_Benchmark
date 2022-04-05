PROJECT=mont-mult

RM=/bin/rm -rf

PLATFORM=xc3s500e-fg320-5
UCF="../../../rtl/vhdl/communication/ModExpDataCtrlUCF.ucf"

XILINX_DIR="c:/Xilinx/14.2/ISE_DS/ISE/bin/nt64/"
XST_DIR=$(XILINX_DIR)"xst.exe"
NGDBUILD_DIR=$(XILINX_DIR)"ngdbuild.exe"
MAP=$(XILINX_DIR)"map.exe"
PAR=$(XILINX_DIR)"par.exe"
TRCE=$(XILINX_DIR)"trce.exe"
BITGEN=$(XILINX_DIR)"bitgen.exe"

clean: clean_postgen
	$(RM) "./out/"*.*
	$(RM) "./log/"*.* 
	$(RM) "./out/"
	$(RM) "./log/"

clean_postgen:
	$(RM) "./_xmsgs"
	$(RM) "./_ngo"
	$(RM) "./xlnx_auto_0_xdb"
	$(RM) "./xst"
	$(RM) *_vhdl.prj *.bgn *.bld *.csv *.drc *.lso *.map *.mrp *.ncd *.ngc *.ngd *.ngm *.ngr *.pad *.par *.pcf *.ptwx *.syr *.twr *.twx *.unroutes *.xpi *.xwbt

synthesize: clean
	mkdir "./xst"
	mkdir "./xst/projnav.tmp"
	mkdir "./out/"
	mkdir "./log/"
	$(XST_DIR) -intstyle ise -ifn "./ModExpComm.xst" -ofn "./ModExpComm.syr"

translate: synthesize
	$(NGDBUILD_DIR) -intstyle ise -dd _ngo -sd ../../../rtl/vhdl/mod_exp/blockMemory512 -nt timestamp -uc $(UCF) -p $(PLATFORM) "ModExpComm.ngc" ModExpComm.ngd

map: translate
	$(MAP) -intstyle ise -p $(PLATFORM) -timing -logic_opt off -ol high -xe n -t 1 -register_duplication off -cm area -ir off -pr b -power off -o ModExpComm_map.ncd ModExpComm.ngd ModExpComm.pcf

par: map
	$(PAR) -w -intstyle ise -pl high -rl high -xe n -t 1 ModExpComm_map.ncd ModExpComm.ncd ModExpComm.pcf

trce: par
	$(TRCE) -intstyle ise -v 3 -s 5 -n 3 -fastpaths -xml ModExpComm.twx ModExpComm.ncd -o ModExpComm.twr ModExpComm.pcf

bitgen: trce
	$(BITGEN) -intstyle ise -f ModExpComm.ut ModExpComm.ncd

postgen:
	mv *.log ./log
	mv *.xrpt ./log
	mv *.txt ./log
	mv *.xml ./log
	mv *.html ./log
	mv *.bit ./out