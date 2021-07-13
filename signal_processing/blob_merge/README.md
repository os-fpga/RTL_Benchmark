# Design Description

It reads RLE encoded pixel data from input fifo, merge Runs based on bounding box criteria and write Blobs attributes to output fifo.

# Utilization Report
Synthesized on Artix-7 device using vivado.

|Resource| No.|
|:---:|:---:|
|LUT|5304|
|FF|575|
|DSP|0|
|BRAM|0|
|IO|136|

# License
The MIT License

# Directory structure

    └── rtl     # RTL Sources