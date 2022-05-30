

The USB 1.1 Function IP Core
============================================

Status
------
This core is done. It was tested on a XESS XCV800 board with
a Philips USB transceiver.

Test Bench
----------
There is no test bench, period !
Please don't email me asking for one, unless you want to hire
me to write one ! As I said above I have tested this core in
real hardware and it works just fine.

Documentation
-------------
Sorry, there is none. I just don't have the time to write it.
However, since this core is derived from my USB 2.0 Function
IP core, you might find something useful in there. Main
difference is that all the high speed support features have
been ripped out, and the interface was changed from a shared
memory model to a FIFO based interface. Further there is no
need for a micro-controller interface and/or register file.


Here is the quick info:

The core comes pre-configured with 6 endpoints:

ep 0 - Control endpoint [64/64]
ep 1 - isochronous IN [256/512]
ep 2 - isochronous OUT [256/512]
ep 3 - bulk IN [64/256]
ep 4 - bulk OUT [64/256]
ep 5 - interrupt IN [64/64]

The numbers in brackets are [Max Payload Size/Max FIFO Size]

The isochronous endpoints are handled special.  Data is
always transfered in 32 byte "chunks". If the FIFO can not
accept a 32 "byte" chunk, that chunk is dropped and
'dropped_frame" signal is asserted. If the host sends a
packet that is not in multiple of 32 bytes the
"misaligned_frame" signal is asserted.

This of this "chunks" as being video frames for example.
It's OK to drop one entire frame, or to display one frame
multiple times.  However you don't want to loose synchronization,
where the frame begins or ends. You might want to add some
encoding on to the data stream itself as well, as a fail
save mechanism to not get out of sync. All of this might be
disabled by making sure USB1_ISO_CHUNKS is NOT defined
anywahere.

Vendor Features allow you to define your own features and
set and check various device parameters. For example you
might wan tot count the number of drooped frames so that
the host can read this out for statistics purposes.

This core will perform the entire USB 1.1 enumeration
process in hardware. All you need is to edit the usb1_rom1.v
file and put appropriate values there. This allows you to build
a USB 1.1 device without the need for a micro-controller/CPU.
For example a mouse or joystick ...

The top level should be considered an example how to build
your own customized USB 1.1 device. 

The 'loop' signal allows you to place the isochronous and
bulk endpoints in to a loop back mode. Use that is you just
wan to see the core talk to your Linux box. Place it in to
loop-back mode, compile it in to and FPGA and plug in to your
PC running Linux.  Type 'lsusb' and you should see a device
which enumerated to "1234:5678" Strings don't work without a
dedicated driver that takes control of the device (At least
under RedHat linux 7.3).


Misc
----
The USB 1.1 Function Project Page is:
http://www.opencores.org/cores/usb1_funct/

To find out more about me (Rudolf Usselmann), please visit:
http://www.asics.ws


Directory Structure
-------------------
[core_root]
 |
 +-doc                        Documentation
 |
 +-bench--+                   Test Bench
 |        +-verilog           Verilog Sources
 |        +-vhdl              VHDL Sources
 |
 +-rtl----+                   Core RTL Sources
 |        +-verilog           Verilog Sources
 |        +-vhdl              VHDL Sources
 |
 +-sim----+
 |        +-rtl_sim---+       Functional verification Directory
 |        |           +-bin   Makefiles/Run Scripts
 |        |           +-run   Working Directory
 |        |
 |        +-gate_sim--+       Functional & Timing Gate Level
 |                    |       Verification Directory
 |                    +-bin   Makefiles/Run Scripts
 |                    +-run   Working Directory
 |
 +-lint--+                    Lint Directory Tree
 |       +-bin                Makefiles/Run Scripts
 |       +-run                Working Directory
 |       +-log                Linter log & result files
 |
 +-syn---+                    Synthesis Directory Tree
 |       +-bin                Synthesis Scripts
 |       +-run                Working Directory
 |       +-log                Synthesis log files
 |       +-out                Synthesis Output
