# Trivium_FPGA

The Xilinx FPGA Implementation of Trivium stream cipher. 

Was written using VHDL-2008 in Vivado.

The 'Design Sources' folder contains RTL architecture of Trivium cipher.

The 'Simulation Sources' folder contains two testbenches: 1) encipher test; 2) decipher test. Each testbench's folder contains waveform configuration. 

**Resources on the ZC702 Board:**

Resource  | Estimation  | Utilization,%
----------|-------------|--------------
  LUT       | 3670        | 6.9  
  FF        | 9           | 0.01
  BUFG      | 2           | 6.25
