#!/bin/csh

#Xcelium installation
setenv CDS_INST_DIR /opt/cad/Cadence/IC6/XCELIUMMAIN18.09.005_

#CDN_VIP_ROOT:: Environment variable pointing to Cadence VIP installation
setenv CDN_VIP_ROOT /opt/cad/Cadence/IC6/vipcat-11.30.053

#CDS_ARCH:: Platform for Cadence VIP libraries
#This is obtained from: ${CDN_VIP_ROOT}/bin/cds_plat
setenv CDS_ARCH lnx86

#DENALI:: Environment variable pointing to Cadence VIP base libraries
setenv DENALI ${CDN_VIP_ROOT}/tools.${CDS_ARCH}/denali_64bit

#CDN_VIP_LIB_PATH:: Location of Cadence VIP compiled libraries
#This is a user-specified directory.
#IMPORTANT:: The libraries must be recompiled (-install option)
#after each new VIP download (and after each Xcelium installation upgrade).
setenv CDN_VIP_LIB_PATH ${TOP_DESIGN}/tb/vip_lib_xc64

#Additional components in ${PATH} to ensure necessary executables are available
setenv PATH ${CDS_INST_DIR}/tools.${CDS_ARCH}/bin:${PATH}

#Additional components in ${LD_LIBRARY_PATH} to ensure necessary libraries are available
	#The following line accounts for (extremely rare) users with no LD_LIBRARY_PATH
	if (! ${?LD_LIBRARY_PATH}) setenv LD_LIBRARY_PATH ""
setenv LD_LIBRARY_PATH ${CDN_VIP_LIB_PATH}/64bit:${DENALI}/verilog:${CDS_INST_DIR}/tools.${CDS_ARCH}/lib/64bit:${LD_LIBRARY_PATH}

# Disable automatic nc to xm remapping
setenv CDN_VIP_DISABLE_REMAP_NC_XM  

