#!/bin/bash
# Xanthopoulos Constantinos
# Installing cable drivers for the impact to work
# under Debian Squeeze.


# ===== CONFIGURATIONS =====
# ==========================
# Webpack installation directory ex. ISE_PATH=/opt/WebPackISE/12.3/
# make sure this directory contains ISE_DS

ISE_PATH=""


# ===== SCRIPT ======
# ===================
export DEBUG=0;
. conxshlib.sh

ISE_PATH=${ISE_PATH}"/ISE_DS/ISE/";

if [ ! -d $ISE_PATH ];
then
	errormsg "You must set the configuration variable ISE_PATH of this script";
fi

if [ `whoami` != "root" ];
then
	errormsg "You must be root for this script to run.";
fi;

execcmd "Installing make" "aptitude install -y make"

execcmd "Add WebPack binaries to PATH" "echo \"PATH=\\\$PATH:${ISE_PATH}/bin/lin/\" >> /etc/bash.bashrc;";

execcmd "Downloading drivers" "wget -O usb-driver-HEAD.tar.gz http://git.zerfleddert.de/cgi-bin/gitweb.cgi/usb-driver?a=snapshot;h=HEAD;sf=tgz ";

execcmd "Move tar to $ISE_PATH" "mv usb-driver-HEAD.tar.gz $ISE_PATH"

cd $ISE_PATH;

execcmd "Un-tar usb drivers" "tar xf usb-driver-HEAD.tar.gz";

execcmd "Removing tar" "rm usb-driver-HEAD.tar.gz"

cd usb-driver

execcmd "Install libusb" "aptitude install -y libusb-dev";

execcmd "Compile usb-driver" "make"

execcmd "Adding the export line to bashrc" "echo \"export LD_PRELOAD=${ISE_PATH}/usb-driver/libusb-driver.so\" >> /etc/bash.bashrc"

cecho "Unplug the cable if it is plugged and press enter"

read nothing;

execcmd "Creating new udev rule" "echo \"ACTION==\\\"add\\\", SUBSYSTEMS==\\\"usb\\\", ATTRS{idVendor}==\\\"03fd\\\", MODE=\\\"666\\\"\" > /etc/udev/rules.d/libusb-driver.rules";

execcmd "Copy udev rules" "cp ${ISE_PATH}/bin/lin/xusbdfwu.rules /etc/udev/rules.d/";

execcmd "Apply patch for Squeeze" "sed -i -e 's/TEMPNODE/tempnode/' -e 's/SYSFS/ATTRS/g' -e 's/BUS/SUBSYSTEMS/' /etc/udev/rules.d/xusbdfwu.rules";

execcmd "Install fxload" "aptitude install -y fxload";

execcmd "Copy .hex files to /usr/share" "cp ${ISE_PATH}/bin/lin/xusb*.hex /usr/share";

execcmd "Restart udev" "/etc/init.d/udev restart";

cecho "Ready!!!"
