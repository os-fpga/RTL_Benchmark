#!/bin/bash
#
# USAGE: ./process.sh
# ARGs:
#    <none>
#    -clr
#    -reasm
#    -fast


ROOT_DIR=$PWD

SOLIB_DEV_NAME="test_main"
SOLIB_DEV_DIR="$PWD/../../sw/dev/${SOLIB_DEV_NAME}/src"
SOLIB_DEV_FILE="$SOLIB_DEV_DIR/${SOLIB_DEV_NAME}.so"

SOLIB_HOSTB_NAME="test_bfm"
SOLIB_HOSTB_DIR="$PWD/../../sw/dev/${SOLIB_HOSTB_NAME}"
SOLIB_HOSTB_FILE="$SOLIB_HOSTB_DIR/${SOLIB_HOSTB_NAME}.so"

#
# view
if [ "$1" == "-view" ]; then
 vsim -view vsim.wlf -do wave.do
 exit 0
fi

#
# clr / 2FIX!!!
find -type d -exec rm -rf {} +
rm -rf *.h
rm -rf *.tr
#rm -rf work
rm -rf *wlf*
rm -rf *.hex
rm -rf *.mem
rm -rf *.ver
rm -rf *.so
rm -rf *.log
rm -rf *.pcap
rm -rf *.vstf
rm -rf *.ini
rm -rf compile.do
rm -rf *transcript*
if [ "$1" == "-clr" ]; then
 exit 0
fi

#
# q2-chk
if [ ! -d ../layout/process/project_n1.ip_user_files/sim_scripts ]; then
echo "V-ASM:"
cd ../layout/
./process.sh -asm &> /dev/null
cd $ROOT_DIR
echo""
fi
# ublaze-bsp
if [ ! -d ../../sw/dev/test_main/process ]; then
echo "BSP-ASM:"
cd ../../sw/dev/test_main
./process.sh -bsp &> /dev/null
cd $ROOT_DIR
echo""
fi
# ublaze-app / so-lib
if [ ! -f $SOLIB_DEV_FILE ] || [ "$1" == "-reasm" ]; then
cd $SOLIB_DEV_DIR
cmd="make"
$cmd &> $ROOT_DIR/dpi-main.log || {
    echo "test_main MAKE failed"
    exit 1
}
fi
cd $ROOT_DIR
rm -rf ./${SOLIB_DEV_NAME}.so
cp -f $SOLIB_DEV_FILE ./
# host-bfm / so-lib
if [ ! -f $SOLIB_HOSTB_FILE ] || [ "$1" == "-reasm" ]; then
cd $SOLIB_HOSTB_DIR
cmd="make"
$cmd &> $ROOT_DIR/dpi-hostb.log || {
    echo "HOST_BFM MAKE failed"
    exit 1
}
fi
cd $ROOT_DIR
rm -rf ./$SOLIB_HOSTB_NAME.so 
cp -f $SOLIB_HOSTB_FILE ./

# prep-var
export LIB_DEV_NAME=$SOLIB_DEV_NAME
export LIB_HOSTB_NAME=$SOLIB_HOSTB_NAME

# start
if [ "$1" == "-fast" ] || [ "$2" == "-fast" ] 
then
 export FAST_SIM=1
 vsim -c -do start_sim.tcl
else
 export FAST_SIM=0
 vsim -do start_sim.tcl
fi

#
#Final
exit 0
