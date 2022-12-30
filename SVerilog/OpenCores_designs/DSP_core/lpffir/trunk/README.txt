                                  README

This file is part of the LowPass Filter with Finite Impulse Response (LPFFIR) project:
https://opencores.org/projects/lpffir

AUTHOR:
Vladimir Armstrong, vladimirarmstrong@opencores.org

DESCRIPTION:
Implementation of LPFFIR according to specification document:
./doc/LPFFIR_Specifications.pdf

DIRECTORY STRUCTURE:
── bench            Top level test bench
│   ├── systemc     SystemC test bench sources
│   └── verilog     Verilog test bench sources
│
├── doc             Specification, verification and other PDF documents
│   └── src         Source version of all documents (Microsoft Word, Microsoft Visio)
│
├── rtl             Verilog RTL sources
│
├── sim             Top level simulations
│   ├── matlab_sim  MATLAB simulations
│   │   ├── out     Useful output from MATLAB simulation
│   │   └── run     MATLAB sources and for running MATLAB simulations
│   │
│   └── rtl_sim     RTL simulations
│       ├── out     Useful output from RTL simulation
│       └── run     For running RTL simulations
│
├── sw              Software sources for Python script utilities
│   ├── out         Useful output from Python script utilities
│   └── run         Python sources and for running Python script utilities
│
└── uvm                  Universal Verification Methodology (UVM)
    ├── rca_uvm          Ripple Carry Adder Easier UVM project
    ├── lpffir_uvm       Low Pass Filter FIR Easier UVM project
    └── tools              Open-source Tools
        ├── easier_uvm_gen Automatic UVM test bench generator
        └── uvm_syoscb     General purpose UVM Scoreboard

OPEN-SOURCE TOOLS:
1. Ubuntu 18.04 LTS         Linux OS development platform
2. SystemC 2.3.2-Accellera  SystemC test bench simulator
3. Verilator                Verilog simulator
4. GTKWave                  Verilog simulation waveform viewer
5. GNU Octave               Octave syntax is largely compatible with MATLAB
6. Python                   RTL-simulation vs. MATLAB-expected check script
