
#  Verilog implementation of the iso7816-3 smartcard interface.
#  Copyright (C) 2003 Blaise Gassend <blaise at gassend dot com>
#  
#  This program is free software; you can redistribute it and/or
#  modify it under the terms of the GNU General Public License
#  as published by the Free Software Foundation; either version 2
#  of the License, or (at your option) any later version.
#  
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#  
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software
#  Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.


# Files
TARGET=iso7816.bit
SIMULSRC=defines-simul.v inshifter.v outshifter.v atrgen.v control.v converge.v simul.v oscilloscope.v baudgen.v interface.v

# Target Parameters
FAMILY=Spartan2
ARCHITECTURE=xc2s200pq208-5

# Program Options
XSTFLAGS=
NGDBUILDFLAGS=
MAPFLAGS=
PARFLAGS=
BITGENFLAGS=



# ***** No more playing past this point *****

# File set manipulation
EDNFILES=;find -name \*.edu

# Auto parameters
XSTFLAGS+= -family $(FAMILY) -ofmt edif
NGDBUILDFLAGS+= -p $(FAMILY)
MAPFLAGS+= -p $(ARCHITECTURE)
PARFLAGS+= -w
BITGENFLAGS+=-g Compress -g StartupClk:JtagClk -w

# Programs
export DISPLAY=:0
#export XILINX=c:\\xilinx_webpack
export XILINX=c:\\Xilinx5
export WINEPREFIX=/home/gassend/.wine
XILINXBIN=$(XILINX)\\bin\\nt
WINE=wine.bin --debugmsg -all --
#WINE=wine.bin --
XST=$(WINE) $(XILINXBIN)\\xst
NGDBUILD=$(WINE) $(XILINXBIN)\\ngdbuild
MAP=$(WINE) $(XILINXBIN)\\map
PAR=$(WINE) $(XILINXBIN)\\par
BITGEN=$(WINE) $(XILINXBIN)\\bitgen
COLORIZECMD=sed "s/\(INFO\|WARNING\|ERROR\)\(.*\)/[41m\1\2[0m/"

all: 
	make coloredall | $(COLORIZECMD)
	
simul: $(SIMULSRC) 
	iverilog -Wall -s simul -o simul $(SIMULSRC)

coloredall: $(TARGET)

synth: $(TARGET:.bit=.ngc)

prog: all
	fpgaprog $(TARGET)

%.ucf:
	touch $*.ucf

#%.edn: %.v 
#	echo run -ifn $< -ifmt Verilog -ofn $*.edn $(XSTFLAGS)| $(XST) 

#%.ngd: %.edn $(EDNFILES) $(UCFFILES)
#	$(NGDBUILD) $(NGDBUILDFLAGS) $< 

%.ngc: %.xst *.v $(EDNFILES)
	$(XST) -ifn $*.xst -ofn $*.syr 

%.ngd: %.ngc %.ucf 
	$(NGDBUILD) $(NGDBUILDFLAGS) $< 

%-map.ncd: %.ngd
	$(MAP) $(MAPFLAGS) $< -o $*-map.ncd

%.ncd: %-map.ncd 
	$(PAR) $(PARFLAGS) $*-map.ncd $*.ncd

%.bit: %.ncd
	$(BITGEN) $(BITGENFLAGS) $*.ncd

.PRECIOUS: %.ncd %-map.ncd %.ngd %.edn

clean:
	rm -f *.ngd *.ngo netlist.lst *_ngdbuild.nav *.ncf *.bld *.ncd *-map.ngm *-map.mrp *-map.pcf *.bit *.bgn *.dly *.drc *.pad *.par *.xpi *.eqn *.syr *.ngc *.tmp simul
	
