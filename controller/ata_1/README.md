# Design Description

ATA (AT attachment) interface core, also known as the IDE (Integrated Drive Electronics) interface. The ATA interface provides a simple interface to (low cost) non-volatile memories, like harddisk drives, DVD players, CD(ROM) players/writers and CompactFlash and PC-CARD devices.

Currently three cores are available: 

## OCIDEC-1
### Features
- Smallest core.
- PIO transfer support only.
- Single timing register for all accesses to the connected devices.

### Intended use
- Single PIO only devices (PC-CARDs, CompactFlash).
- Designs requiring ATA capabilities, without the need for a complex feature set.	

## OCIDEC-2
### Features
- Small core.
- PIO transfer support only.
- Common timing register for all compatible accesses to the connected devices. 
- Separate timing register per device for fast DataPort accesses.

### Intended use
- Dual PIO only devices (PC-CARDs, CompactFlash).
- Designs requiring fast ATA capabilities, without DMA transfers.

## OCIDEC-3
### Features
- PIO, Single-Word DMA and Multi-Word DMA transfer support.
- Common timing register for all PIO compatible accesses to the connected devices.
- Separate timing registers per device for fast PIO DataPort accesses.
- Separate timing registers per device for DMA transfers.
- PIO write access ping-pong.
- WISHBONE Retry cycles for PIO accesses while controller busy.

### Intended use
- High speed ATA devices (Hard disks, CDROMs)
- Designs requiring full featured ATA capabilities.

# Directory structure

    ├── doc                 # Documentation
    ├── rtl                 # RTL Sources
    │   ├── verilog         # Verilog Sources
    │   │   ├── ocidec-1
    │   │   └── ocidec-2
    │   └── vhdl            # Vhdl Sources
    │       ├── ocidec1
    │       ├── ocidec2
    │       └── ocidec3
    └── testbench           # Testbench
        └── verilog         # Verilog Sources

# Utilization Report
Synthesized on Artix-7 device using vivado.

## OCIDEC-1
|Resource| No.|
|:---:|:---:|
|LUT|201|
|FF|269|
|DSP|0|
|BRAM|0|
|IO|125|

## OCIDEC-2
|Resource| No.|
|:---:|:---:|
|LUT|240|
|FF|303|
|DSP|0|
|BRAM|0|
|IO|125|

## OCIDEC-3
|Resource| No.|
|:---:|:---:|
|LUT|496|
|FF|525|
|DSP|0|
|BRAM|24|
|IO|130|

# Testbench
Available

# Documentation
Available
