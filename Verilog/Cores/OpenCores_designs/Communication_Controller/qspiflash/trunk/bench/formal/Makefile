################################################################################
##
## Filename:	Makefile
##
## Project:	Wishbone Controlled Quad SPI Flash Controller
##
## Purpose:	To direct the formal verification of the quad-spi flash
##		controller.
##
## Creator:	Dan Gisselquist, Ph.D.
##		Gisselquist Technology, LLC
##
################################################################################
##
## Copyright (C) 2017, Gisselquist Technology, LLC
##
## This program is free software (firmware): you can redistribute it and/or
## modify it under the terms of  the GNU General Public License as published
## by the Free Software Foundation, either version 3 of the License, or (at
## your option) any later version.
##
## This program is distributed in the hope that it will be useful, but WITHOUT
## ANY WARRANTY; without even the implied warranty of MERCHANTIBILITY or
## FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
## for more details.
##
## You should have received a copy of the GNU General Public License along
## with this program.  (It's in the $(ROOT)/doc directory.  Run make with no
## target there if the PDF file isn't present.)  If not, see
## <http://www.gnu.org/licenses/> for a copy.
##
## License:	GPL, v3, as defined and found on www.gnu.org,
##		http://www.gnu.org/licenses/gpl.html
##
##
################################################################################
##
##
all:	test
test: llqspi.check
YOSYS   := yosys
SMTBMC  := yosys-smtbmc
# SOLVER  := -s z3	# 18 minutes
# SOLVER := -s yices	# 34 seconds
SOLVER := -s boolector	# 25 seconds
# SOLVER := -s cvc4 ... not properly installed ??
# SOLVER := -s mathsat

LLQSPISTEPS=88
LLQSPI=llqspi
BMCOUT=$(BASE)_bmc
INDOUT=$(BASE)_tmp
LLQSPIBMCARGS := $(SOLVER)    -t $(LLQSPISTEPS) --dump-vcd $(BMCOUT).vcd
LLQSPIINDARGS := $(SOLVER) -i -t $(LLQSPISTEPS) --dump-vcd $(INDOUT)_ind.vcd

.PHONY: llqspi.check llqspi.check.bmc llqspi.check.ind
llqspi.check: llqspi.check.bmc llqspi.check.ind

llqspi.check.bmc: llqspi.smt2
	$(SMTBMC)    $(LLQSPIBMCARGS) llqspi.smt2
	$(SMTBMC) -g $(LLQSPIBMCARGS) llqspi.smt2
llqspi.check.ind: llqspi.smt2
	$(SMTBMC)    $(LLQSPIINDARGS) llqspi.smt2

llqspi.smt2: ../../rtl/llqspi.v llqspi.ys
	$(YOSYS) -ql llqspi.yslog -s llqspi.ys

.PHONY: clean
clean:
	rm $(BASE).smt2 $(BMCOUT).smt2 $(INDOUT).smt2 *.vcd
