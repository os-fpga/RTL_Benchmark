#!/bin/bash

# USAGE: ./process.sh
# ARGs:
#    <none>
#    -clr
#    -arch
#    -bit
#    -elf
#    -cp
#

ROOT_DIR=$PWD
CP_DIR=~/vbox_share/WORK/Xilinx/upld

function run_clr {
echo "CLR:"

cd $ROOT_DIR/hw/layout
./process.sh -clr &> /dev/null

cd $ROOT_DIR/hw/msim
./process.sh -clr &> /dev/null

cd $ROOT_DIR/sw/dev/test_main
./process.sh -clr &> /dev/null
make clean -C $ROOT_DIR/sw/dev/test_bfm &> /dev/null
make clean -C $ROOT_DIR/sw/dev/test_main/src &> /dev/null
make clean -C $ROOT_DIR/sw/app/gtest &> /dev/null
}

function run_arch {
echo "ARCH:"
cd $ROOT_DIR/../
tar cfJ vtest_$(date +"%Y-%m-%d_%H-%M-%S").tar.xz vtest &> /dev/null
echo "=> done"
}

function run_bit {
echo "BIT:"
cd $ROOT_DIR/hw/layout
./process.sh
}

function run_elf {
echo "ELF:"
cd $ROOT_DIR/sw/dev/test_main
./process.sh
}

function run_cp {
echo "CP:"
local BIT_LIST=`find ./hw/layout/process/project_n1.runs/impl_1/*.bit`
local BIT_FILE=${BIT_LIST[0]}
local ELF_LIST=`find ./sw/dev/test_main/process/app_0/Debug/*.elf`
local ELF_FILE=${ELF_LIST[0]}
local HDF_LIST=`find ./sw/dev/test_main/process/*.hdf`
local HDF_FILE=${HDF_LIST[0]}

rm -rf $CP_DIR/*.bit
rm -rf $CP_DIR/*.elf
rm -rf $CP_DIR/*.hdf

cp $BIT_FILE $CP_DIR
cp $ELF_FILE $CP_DIR
cp $HDF_FILE $CP_DIR
}

echo "START: $(date)"
# proc NO-ARG
if [ "$1" == "" ]; then 
run_clr
run_bit
run_elf
fi
# proc 1ST-ARG
if [ "$1" == "-clr" ]; then run_clr ; fi
if [ "$1" == "-arch" ]; then run_arch ; fi
if [ "$1" == "-bit" ]; then run_bit ; fi
if [ "$1" == "-elf" ]; then run_elf ; fi
if [ "$1" == "-cp" ]; then run_cp ; fi
# proc 2ND-ARG
if [ "$2" == "-arch" ]; then run_arch ; fi
if [ "$2" == "-bit" ]; then run_bit ; fi
if [ "$2" == "-elf" ]; then run_elf ; fi
if [ "$2" == "-cp" ]; then run_cp ; fi
echo "STOP : $(date)"

# Final
exit 0
