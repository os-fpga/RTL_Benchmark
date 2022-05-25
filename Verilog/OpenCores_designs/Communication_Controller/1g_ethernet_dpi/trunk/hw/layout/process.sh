#!/bin/bash

# USAGE: ./process.sh
# ARGs:
#    <none>
#    -o
#    -clr
#    -asm

# qui-open
if [ "$1" == "-o" ]; then
 cd process
 vivado ./project_n1.xpr 
 exit 0
fi

# clr
rm -rf .Xil
rm -rf process
rm -rf *.jou
rm -rf *.log
if [ "$1" == "-clr" ]; then
 exit 0
fi

# prep
mkdir process
cd process

# prj-cre
vivado -mode batch -source ../tcl/vsetup.tcl 
if [ "$1" == "-asm" ]; then
 exit 0
fi

# prj-asm
vivado -mode batch -source ../tcl/vrun.tcl 

# Final
exit 0
