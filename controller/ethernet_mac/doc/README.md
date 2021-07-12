# Design Description

The Ethernet IP Core is a MAC (Media Access Controller). It connects to the Ethernet PHY chip on one side and to the WISHBONE SoC bus on the other. The core has been designed to offer as much flexibility as possible to all kinds of applications.

## Features

- Performing MAC layer functions of IEEE 802.3 and Ethernet
- Automatic 32-bit CRC generation and checking
- Delayed CRC generation
- Preamble generation and removal
- Automatically pad short frames on transmit
- Detection of too long or too short packets (length limits)
- Possible transmission of packets that are bigger than standard packets
- Full duplex support
- 10 and 100 Mbps bit rates supported
- Automatic packet abortion on Excessive deferral limit, too small inter packet gap, when enabled
- Flow control and automatic generation of control frames in full duplex mode (IEEE 802.3x)
- Collision detection and auto retransmission on collisions in half duplex mode (CSMA/CD protocol)
- Complete status for TX/RX packets
- IEEE 802.3 Media Independent Interface (MII)
- WISHBONE SoC Interconnection Rev. B2 and B3 compliant interface
- Internal RAM for holding 128 TX/RX buffer descriptors
- Interrupt generation an all events

# Utilization Report

|Resource| No.|
|:---:|:---:|
|LUT|1969|
|FF|2350|
|DSP|0|
|BRAM|2|
|IO|211|

# License
GNU Lesser General Public License