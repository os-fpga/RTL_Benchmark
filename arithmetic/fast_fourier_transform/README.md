# Design Description

It Performs a radix 2 Fast Fourier Transform.The FFT architecture is pipelined on a rank basis; each rank has its own butterfly and ranks are isolated from each other using memory interleavers. This FFT can perform calcualations on continuous streaming data (one data set right after another).More over, inputs and outputs are passed in pairs, doubling the bandwidth. For instance, a 2048 point FFT can perform a transform every 1024 cycles.


# Directory structure

    └── rtl     # RTL Sources

# Utilization Report
Synthesized on Artix-7 device using vivado.

|Resource| No.|
|:---:|:---:|
|LUT|2656|
|FF|2556|
|DSP|0|
|BRAM|1|
|IO|69|

# Testbench
Unavailable

# Documentation
Unavailable
