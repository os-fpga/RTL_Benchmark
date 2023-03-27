BRAMs are used to model the OTP/PUF array on the FPGA

There are as many BRAMs as the number of cells per bit. For example, if the OTP uses
two cells to store one bit of data, then there will be two BRAMs to model that behavior.

When the FPGA powers up, it requires some values to initialize the BRAMs. These initial
values are found in the three .dat files located in this directory.

There are several different .dat files for different simulation environments:
1) BRAM_BLANK_FAULT.dat -- models the array on a fresh die with initial fail bits for the verification of Auto Repair function
2) BRAM_BLANK_GOOD.dat  -- models the array on a fresh die -- all 1s
3) BRAM_CHIP_GOOD.dat   -- models the array when it leaves the factory
                           - PUF has been enrolled
                           - only usermode functions are enabled (testmode/OTP/PUF locks have all been applied)
4) BRAM_CHIP_WOLCK.dat  -- models the array when it leaves the factory with all locks disabled
                           - PUF has been enrolled
                           - all functions are enabled, including PUF enrollment and zeroization, repair, etc.

Address Ranges in the .dat files, corresponding to their functional sections:

//----------------------
// PUFrt block ram map
//----------------------
//    PUF 0x000~0x07f     
//    OTP 0x080~0x27f   
//    REP 0x280~0x28f   
//    PIF 0x290~0x2cf   
//    PTR 0x2d0~0x2d7   
//    PTC 0x2d8~0x317   

