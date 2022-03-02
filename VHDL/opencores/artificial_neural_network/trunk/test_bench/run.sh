#!/bin/bash

echo neural network training and wb_init.vhd file generation...
cd octave
octave nn_ex.m
mv wb_init.vhd ../../ANN_kernel/RTL_VHDL_files/wb_init.vhd
cd ..
echo GHDL simulation
make
echo results from octave vs results from GHDL
octave show_res.m