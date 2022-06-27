# Description

ARINC 429 is the most widely used avionics communication standard for commercial aviation.

The aim of this project is to provide a set of ARINC-429-compatible TX and RX synthesizable interfaces. The transmitting interface serializes a 32-bit A429 word with the appropriate timing and encoding characteristics whereas the receiving interface samples serialized data, providing the decoded 32-bit words at the output. This implementation does not include any particular CPU bus interface (i.e. Wishbone, etc.), leaving the option for any designer to make it as complex or simple as required for their application.

As happens with other serial communication protocols, ARINC 429 needs for external line driver and receiver circuits to obtain the electric signaling levels required by the standard.
# Features
* Single 2MHz master clock operation.
* Generic parallel interface.
* Selectable bit rate (12.5Kb/s or 100Kb/s).
* Optional parity bit check (RX).
* ARINC 429 word formatting (incl. 'label' field bit reversal).

# Status
Synthesizable, FPGA-tested Verilog code available under the [MIT License](https://en.wikipedia.org/wiki/MIT_License).
Parity bit generation option (TX interface) is not implemented yet.