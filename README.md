# RTL_Benchmark
This repository contains the benchmarks, catagorized on the bases of their domain.

## Synthesis report of each catagory on different tools:
### 1. Arithmetic
 - #### Vivado

|Benchmark|LUT|FF|DSP|BRAM|IO|
|:---:|:---:|:---:|:---:|:---:|:---:|
|Min|110 (unsign_mult)|0 (unsign_mult)|0 (cf_fft)|0 (fpu)|24 (DCT)|
|Max|15136 (LU8PEEng)|4345 (LU8PEEng)|64 (DCT)|30.5 (DCT)|258 (diffeq1)|
|Avg|2394.5|1021.3|9.91|5.4|113|

- #### Quartus prime lite

|Benchmark|LUT|FF|DSP|BRAM|IO|
|:---:|:---:|:---:|:---:|:---:|:---:|
|Min|48 (unsign_mult)|0 (unsign_mult)|0 (cordic_core)|0 (fpu)|25 (DCT)|
|Max|19230 (LU8PEEng)|10669 (LU8PEEng)|64 (DCT)|38 (LU8PEEng)|258 (diffeq1)|
|Avg|2933.3|2032.1|11.4|3.4|113.1|

- #### Lattice diamond

|Benchmark|LUT|FF|DSP|BRAM|IO|
|:---:|:---:|:---:|:---:|:---:|:---:|
|Min|160 (unsign_mult)|0 (unsign_mult)|0 (cordic_core)|0 (fpu)|25 (DCT)|
|Max|35221 (LU8PEEng)|13942 (LU8PEEng)|48 (LU8PEEng)|33 (LU8PEEng)|258 (diffeq1)|
|Avg|5351|2233.1|13.9|4.2|135.4|

- #### Anlogic

|Benchmark|LUT|FF|DSP|BRAM|IO|
|:---:|:---:|:---:|:---:|:---:|:---:|
|Min|53 (unsign_mult)|0 (unsign_mult)|0 (cordic_core)|0 (fpu)|25 (DCT)|
|Max|12537 (LU8PEEng)|6276 (LU8PEEng)|124 (DCT)|49 (LU8PEEng)|258 (diffeq1)|
|Avg|2728.5|1657.6|18.7|4.4|113.1|

- #### Gowin

|Benchmark|LUT|FF|DSP|BRAM|IO|
|:---:|:---:|:---:|:---:|:---:|:---:|
|Min|40 (unsign_mult)|0 (unsign_mult)|0 (cordic_core)|0 (unsign_mult)|25 (DCT)|
|Max|21484 (LU8PEEng)|4680 (LU8PEEng)|30 (cf_fft)|56 (LU8PEEng)|258 (diffeq1)|
|Avg|3239.4|1325.3|6|6.7|123.2|


## Directory structure
    ├── arithmetic
    │   ├── cf_fft_256_8
    │   ├── cordic_core
    │   ├── DCT
    │   ├── diffeq1
    │   ├── diffeq2
    │   ├── fpu
    │   ├── hardware_divider
    │   ├── LU8PEEng
    │   ├── pipelined_dct
    │   └── unsigned_mult_80
    ├── controller
    │   ├── ac97
    │   ├── ata
    │   ├── ch_intrinsic
    │   ├── ethernet_mac
    │   ├── i2c_master
    │   ├── mem_ctl
    │   ├── sasc
    │   ├── sdc_controller
    │   ├── simple_pic
    │   ├── steppermotordrive
    │   ├── usb1.1_phy
    │   ├── usb2.0
    │   └── vga_lcd
    ├── core
    │   ├── oc54x
    │   ├── rs_decoder
    │   └── tv80s
    ├── digital_design
    │   ├── bin2bcd
    │   ├── cavlc
    │   ├── counter
    │   ├── counter120bitx5
    │   ├── counter_16bit
    │   ├── shift_reg_8192
    │   └── simon_bit_serial
    ├── encryption
    │   ├── des
    │   ├── des3
    │   ├── sha
    │   ├── sha1
    │   ├── sha256
    │   └── systemCdes
    ├── finance
    │   └── bgm
    ├── interface
    │   ├── simple_gpio
    │   ├── simple_spi
    │   ├── spi
    │   ├── ss_pcm
    │   ├── wb_conmax
    │   ├── wb_dma
    │   └── wbif_68k
    ├── memory_core
    │   ├── generic_fifo_dc
    │   ├── generic_fifo_dc_gray
    │   ├── generic_fifo_lfsr
    │   ├── generic_fifo_sc_a
    │   ├── generic_fifo_sc_b
    │   └── ssram
    └── signal_processing
        ├── blob_merge
        ├── iir
        ├── jpeg_qnr
        ├── stereovision3
        └── stereovission1
