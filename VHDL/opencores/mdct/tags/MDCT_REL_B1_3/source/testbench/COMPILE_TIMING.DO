#-----------------------------------------------------------------------------#
#                                                                             #
#                         M A C R O    F I L E                                #
#                          COPYRIGHT (C) 2006                                 #
#                                                                             #
#-----------------------------------------------------------------------------#
#-
#- Title       : COMPILE_TIMING.DO
#- Design      : MDCT Core
#- Author      : Michal Krepa
#-
#-----------------------------------------------------------------------------
#-
#- File        : COMPILE_TIMING.DO
#- Created     : Sat April 12 2006
#-
#-----------------------------------------------------------------------------
#-
#-  Description : ModelSim macro for compilation (timing simulation)
#-
#-----------------------------------------------------------------------------

# SIMPRIM
set XILINX $env(XILINX)
vlib simprim
vmap simprim simprim

compxlib -s mti_se -f virtex2p -l all $XILINX/vhdl/src/simprims/simprim_Vpackage_mti.vhd
compxlib -s mti_se -f virtex2p -l all $XILINX/vhdl/src/simprims/simprim_Vcomponents_mti.vhd
compxlib -s mti_se -f virtex2p -l all $XILINX/vhdl/src/simprims/simprim_VITAL_mti.vhd

vlib work
vmap work work

vcom SOURCE/MDCT_PKG.vhd
vcom SOURCE/ROME.VHD
vcom SOURCE/ROMO.VHD
vcom SOURCE/RAM.VHD
vcom SOURCE/DCT1D.VHD
vcom SOURCE/DCT2D.VHD
vcom SOURCE/DBUFCTL.VHD
vcom SYNTHESIS/MDCT_TEMP_2/MDCT_OUT.VHD
vcom SOURCE/TESTBENCH/CLKGEN.VHD
vcom SOURCE/TESTBENCH/MDCTTB_PKG.VHD
vcom SOURCE/TESTBENCH/INPIMAGE.VHD
vcom SOURCE/TESTBENCH/MDCT_TB.VHD
