#-----------------------------------------------------------------------------#
#                                                                             #
#                         M A C R O    F I L E                                #
#                          COPYRIGHT (C) 2006                                 #
#                                                                             #
#-----------------------------------------------------------------------------#
#-
#- Title       : MDCT_TB.DO
#- Design      : MDCT Core
#- Author      : Michal Krepa
#-
#------------------------------------------------------------------------------
#-
#- File        : MDCT_TB.DO
#- Created     : Sat Mar 5 2006
#-
#------------------------------------------------------------------------------
#-
#-  Description : ModelSim macro for compilation
#-
#------------------------------------------------------------------------------


#set ROM_MODEL XILINX
set ROM_MODEL GENERIC

vlib work
vmap work work
vcom SOURCE/MDCT_PKG.vhd
if {$ROM_MODEL=="XILINX"} {
  vcom SOURCE/XILINX/ROME_XIL.VHD
  vcom SOURCE/XILINX/ROME.VHD
  vcom SOURCE/XILINX/ROMO_XIL.VHD
  vcom SOURCE/XILINX/ROMO.VHD 
} else {
  vcom SOURCE/ROME.VHD
  vcom SOURCE/ROMO.VHD
}
vcom SOURCE/RAM.VHD
vcom SOURCE/DCT1D.VHD
vcom SOURCE/DCT2D.VHD
vcom SOURCE/DBUFCTL.VHD
vcom SOURCE/MDCT.VHD
vcom SOURCE/TESTBENCH/random1.VHD
vcom SOURCE/TESTBENCH/CLKGEN.VHD
vcom SOURCE/TESTBENCH/MDCTTB_PKG.VHD
vcom SOURCE/TESTBENCH/INPIMAGE.VHD
vcom SOURCE/TESTBENCH/MDCT_TB.VHD
