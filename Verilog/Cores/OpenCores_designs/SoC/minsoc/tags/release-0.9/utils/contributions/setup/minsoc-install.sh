#!/bin/bash
# Xanthopoulos Constantinos
# Installing cable drivers for the impact to work
# under Debian Squeeze.


# ===== CONFIGURATIONS =====
# ==========================

# Where should I put the dir. minsoc?
# ex. /home/conx/Thesis/
DIR_TO_INSTALL=""


# ===== SCRIPT ======
# ===================
export DEBUG=0;
. conxshlib.sh

if [ `whoami` == "root" ];
then
	errormsg "You shouldn't be root for this script to run.";
fi;

if [ ! -d $DIR_TO_INSTALL ]
then
	errormsg "Directory doesn't exist. Please create it";	
fi;

cd $DIR_TO_INSTALL

if [ ! -f "minsoc.tar.gz" ];
then
	execcmd "Download minsoc" "wget http://xanthopoulos.info/pub/minsoc.tar.gz"
fi

if [ -d "minsoc" ]
then
	rm minsoc -rf
fi

execcmd "Un-tar minsoc" "tar xf minsoc.tar.gz"

cecho "I will now start to compile everything that's needed";

cd minsoc/sw/utils

execcmd "Make utils" "make"

cd ../support

execcmd "Make support tools" "make"

cd ../drivers

execcmd "Make drivers" "make"

cd ../gpio

execcmd "Make GPIO" "make"

cd ../uart

execcmd "Make UART" "make"

cd ${DIR_TO_INSTALL}/minsoc/rtl/verilog/adv_debug_sys/Software/adv_jtag_bridge

cecho "Installing FTDI headers! You will be asked to give root pass"

execcmd "Install FTDI headers" "su -c \"aptitude install libftdi-dev\"";

execcmd "Make adv_jtag_bridge" "make"

cecho "Installation Finised"
