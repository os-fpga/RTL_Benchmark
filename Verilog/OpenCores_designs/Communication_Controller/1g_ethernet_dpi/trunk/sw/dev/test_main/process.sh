#!/bin/bash

# USAGE: ./process.sh
# ARGs:
#    <none>

# clr
rm -rf *.jou
rm -rf *.log
rm -rf doc
rm -rf process
if [ "$1" == "-clr" ]; then
 exit 0
fi

# cre
mkdir process
cd process

# prj-hwdef
vivado -mode batch -source ../source_hwdef.tcl 

# prj-run
xsdk -batch -source ../source_xsdk.tcl $1

# Final
exit 0
