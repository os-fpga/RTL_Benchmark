# Design Description

The 'SSRAM interface core' is a collection of designs for easy integration of synchronous srams (ZBT srams) in your designs. The design uses attributes to preserve all tri-state enables. Standard compiler strategy is to optimize redundant logic resulting in a single output/tristate enable signal. For maximum performance all output enables have to be preserved. 

## Features

- Sandard interface for pipelined ZBTs
- Dual ported memory using cycle shared ssram

# Directory structure

    └── rtl                # RTL Sources

# Utilization Report
Synthesized on Artix-7 device using vivado.

|Resource| No.|
|:---:|:---:|
|LUT|31|
|FF|109|
|DSP|0|
|BRAM|0|
|IO|148|

# Testbench
Unavailable

# Documentation
Unavailable
