# Description

A simple quadrature oscillator that generates two quadrature waves (a sine and a cosine) with a period equal to 100 samples.

The implementation is designed for systems with hardware constrains, so that no multiplier is used and the sine and cosine samples are generated at each clock cycle with only 6 additions. The generated waves have a resolution of 8 bits (can be manually adjusted to up to 16 bits).

The oscillation frequency can be controlled by the clock frequency divided by 100 (eg 10 kHz clock frequency generates 100 Hz waves). 

The url of the svn repository is: https://opencores.org/websvn/listing/quadrature_oscillator/quadrature_oscillator

The url of the git repository is: https://github.com/davimoreno/quadrature_oscillator

# Usage
The program has only two verilog files and is simple to use. To use them just follow the descriptions present in each of the files.

# Working principle
The mathematics behind the functioning of the system lies in the design of marginally stable discrete systems (that is, with simple poles present in the unit circle of the Z plane). The system works from a simple IIR filter with outputs that have an impulse response equal to sine and cosine.
# Simulation result
Simulations made in ModelSim.

![](https://cdn.opencores.org/usercontent/2c8b1eb7c40f0a0e63ba95cc3adca3022fa1d1432c9997241365a6b30d858c4d.jpg)

# FPGA test
Below is the oscillator frequency test video. A clock frequency of 48 kHz was used, so the oscillator generates a wave of approximately `48 kHz/100=480 Hz`. The video shows that a 475 Hz frequency wave was generated, very close to what was expected (this small difference is due to small numerical precision errors in the design of the IIR filter coefficients).

[![FPGA test video](https://img.youtube.com/vi/TAZPnaK2IME/0.jpg)](https://www.youtube.com/watch?v=TAZPnaK2IME)

# Synthesis result

Analysis and synthesis result (from Quartus Prime Lite Edition 18.1.0):

|            Family / Device         | MAX 10 / 10M50DAF484C6GES|
|------------------------------------|--------------|
| Total logic elements               | 97           |
| Total registers                    | 34           |
| Total pins                         | 35           |
| Total virtual pins                 | 0            |
| Total memory bits                  | 0            |
| Embedded Multiplier 9-bit elements | 0            |
| Total PLLs                         | 0            |

# License

MIT License

Copyright (c) 2021 Davi C. M. de Almeida
