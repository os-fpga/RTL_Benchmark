VERSION 6
BEGIN SCHEMATIC
    BEGIN ATTR DeviceFamilyName "spartan3"
        DELETE all:0
        EDITNAME all:0
        EDITTRAIT all:0
    END ATTR
    BEGIN NETLIST
        SIGNAL NRESET_IN
        BEGIN SIGNAL IWAIT_IN
        END SIGNAL
        SIGNAL CLK_IN
        BEGIN SIGNAL MEM_DATA_OUT(15:0)
        END SIGNAL
        SIGNAL CPU_DATA_IN_M(15:0)
        BEGIN SIGNAL DWAIT_IN
        END SIGNAL
        SIGNAL CPU_NDRE
        SIGNAL DATA_OUT_EXT(15:0)
        SIGNAL NWE_RAM
        SIGNAL CPU_ADADDR_OUT(9:0)
        SIGNAL NACS_EXT
        SIGNAL CPU_DATA_IN(15:0)
        BEGIN SIGNAL MADDR(9:0)
        END SIGNAL
        SIGNAL NRE_EXT
        SIGNAL NWE_EXT
        SIGNAL ADDR_OUT_EXT(9:0)
        SIGNAL NCS_EXT
        SIGNAL DATA_IN_EXT(15:0)
        SIGNAL CPU_IADDR_OUT(9:0)
        SIGNAL XLXN_1
        SIGNAL XLXN_2
        SIGNAL CPU_INT
        SIGNAL CPU_NADWE
        SIGNAL XLXN_14(11:0)
        BEGIN SIGNAL CPU_IADDR_OUT(11:0)
        END SIGNAL
        SIGNAL CPU_ADADDR_OUT(11:0)
        SIGNAL XLXN_19(7:0)
        SIGNAL XLXN_20(11:0)
        SIGNAL XLXN_27
        PORT Input NRESET_IN
        PORT Input CLK_IN
        PORT Output DATA_OUT_EXT(15:0)
        PORT Output NRE_EXT
        PORT Output NWE_EXT
        PORT Output ADDR_OUT_EXT(9:0)
        PORT Output NCS_EXT
        PORT Input DATA_IN_EXT(15:0)
        PORT Input CPU_INT
        BEGIN BLOCKDEF cpu
            TIMESTAMP 2004 1 2 22 30 7
            RECTANGLE N 64 -640 368 0 
            LINE N 64 -608 0 -608 
            LINE N 64 -528 0 -528 
            LINE N 64 -448 0 -448 
            LINE N 64 -368 0 -368 
            LINE N 64 -288 0 -288 
            LINE N 64 -208 0 -208 
            RECTANGLE N 0 -220 64 -196 
            LINE N 64 -128 0 -128 
            RECTANGLE N 0 -140 64 -116 
            LINE N 64 -48 0 -48 
            RECTANGLE N 0 -60 64 -36 
            LINE N 368 -608 432 -608 
            LINE N 368 -544 432 -544 
            LINE N 368 -480 432 -480 
            LINE N 368 -416 432 -416 
            LINE N 368 -352 432 -352 
            LINE N 368 -288 432 -288 
            RECTANGLE N 368 -300 432 -276 
            LINE N 368 -224 432 -224 
            RECTANGLE N 368 -236 432 -212 
            LINE N 368 -160 432 -160 
            RECTANGLE N 368 -172 432 -148 
            LINE N 368 -96 432 -96 
            RECTANGLE N 368 -108 432 -84 
            LINE N 368 -32 432 -32 
            RECTANGLE N 368 -44 432 -20 
        END BLOCKDEF
        BEGIN BLOCKDEF ctrl16cpu
            TIMESTAMP 2004 1 3 14 21 10
            LINE N 64 32 0 32 
            LINE N 64 -288 0 -288 
            LINE N 64 -224 0 -224 
            LINE N 64 -160 0 -160 
            RECTANGLE N 0 -172 64 -148 
            LINE N 64 -96 0 -96 
            RECTANGLE N 0 -108 64 -84 
            LINE N 64 -32 0 -32 
            RECTANGLE N 0 -44 64 -20 
            LINE N 448 -352 512 -352 
            LINE N 448 -256 512 -256 
            LINE N 448 -160 512 -160 
            LINE N 448 -64 512 -64 
            RECTANGLE N 448 -76 512 -52 
            RECTANGLE N 64 -384 448 64 
        END BLOCKDEF
        BEGIN BLOCKDEF h2v
            TIMESTAMP 2004 1 2 22 30 14
            RECTANGLE N 64 -448 320 0 
            LINE N 64 -416 0 -416 
            LINE N 64 -352 0 -352 
            LINE N 64 -288 0 -288 
            LINE N 64 -224 0 -224 
            LINE N 64 -160 0 -160 
            LINE N 64 -96 0 -96 
            RECTANGLE N 0 -108 64 -84 
            LINE N 64 -32 0 -32 
            RECTANGLE N 0 -44 64 -20 
            LINE N 320 -416 384 -416 
            LINE N 320 -32 384 -32 
            RECTANGLE N 320 -44 384 -20 
        END BLOCKDEF
        BEGIN BLOCKDEF stack_if
            TIMESTAMP 2004 1 2 22 30 17
            RECTANGLE N 64 -256 320 0 
            LINE N 64 -224 0 -224 
            LINE N 64 -160 0 -160 
            LINE N 64 -96 0 -96 
            LINE N 64 -32 0 -32 
            LINE N 320 -224 384 -224 
            RECTANGLE N 320 -236 384 -212 
        END BLOCKDEF
        BEGIN BLOCKDEF waitstategen
            TIMESTAMP 2004 1 2 23 7 6
            RECTANGLE N 64 -448 544 0 
            LINE N 64 -416 0 -416 
            LINE N 64 -352 0 -352 
            LINE N 64 -288 0 -288 
            LINE N 64 -224 0 -224 
            LINE N 64 -160 0 -160 
            LINE N 64 -96 0 -96 
            RECTANGLE N 0 -108 64 -84 
            LINE N 64 -32 0 -32 
            RECTANGLE N 0 -44 64 -20 
            LINE N 544 -416 608 -416 
            LINE N 544 -320 608 -320 
            LINE N 544 -224 608 -224 
            LINE N 544 -128 608 -128 
            RECTANGLE N 544 -140 608 -116 
            LINE N 544 -32 608 -32 
            RECTANGLE N 544 -44 608 -20 
        END BLOCKDEF
        BEGIN BLOCKDEF ram
            TIMESTAMP 2004 1 3 14 14 32
            RECTANGLE N 32 0 320 272 
            BEGIN LINE W 0 48 32 48 
            END LINE
            BEGIN LINE W 0 80 32 80 
            END LINE
            LINE N 0 112 32 112 
            LINE N 0 240 32 240 
            BEGIN LINE W 320 48 352 48 
            END LINE
        END BLOCKDEF
        BEGIN BLOCKDEF sram
            TIMESTAMP 2004 1 3 13 38 46
            RECTANGLE N 32 0 320 272 
            BEGIN LINE W 0 48 32 48 
            END LINE
            BEGIN LINE W 0 80 32 80 
            END LINE
            LINE N 0 112 32 112 
            LINE N 0 240 32 240 
            BEGIN LINE W 320 48 352 48 
            END LINE
        END BLOCKDEF
        BEGIN BLOCKDEF inv
            TIMESTAMP 2001 2 2 12 38 38
            LINE N 0 -32 64 -32 
            LINE N 224 -32 160 -32 
            LINE N 64 -64 128 -32 
            LINE N 128 -32 64 0 
            LINE N 64 0 64 -64 
            CIRCLE N 128 -48 160 -16 
        END BLOCKDEF
        BEGIN BLOCK XLXI_5 waitstategen
            PIN nacs_wait NACS_EXT
            PIN ndre_in CPU_NDRE
            PIN nadwe_in CPU_NADWE
            PIN nreset_in NRESET_IN
            PIN clk_in CLK_IN
            PIN cpu_data_in(15:0) CPU_DATA_IN(15:0)
            PIN cpu_adaddr_out_m(9:0) CPU_ADADDR_OUT(9:0)
            PIN dwait_out DWAIT_IN
            PIN ndre_out NRE_EXT
            PIN ndwe_out NWE_EXT
            PIN cpu_data_in_m(15:0) CPU_DATA_IN_M(15:0)
            PIN cpu_daddr_out(9:0) ADDR_OUT_EXT(9:0)
        END BLOCK
        BEGIN BLOCK XLXI_2 ctrl16cpu
            PIN nADWE_CPU CPU_NADWE
            PIN nreset_in NRESET_IN
            PIN clk_in CLK_IN
            PIN DATA_IN_RAM(15:0) MEM_DATA_OUT(15:0)
            PIN DATA_IN_EXT(15:0) DATA_IN_EXT(15:0)
            PIN ADADDR_IN(9:0) CPU_ADADDR_OUT(9:0)
            PIN nWE_RAM NWE_RAM
            PIN nCS_EXT NCS_EXT
            PIN nACS_EXT NACS_EXT
            PIN DATA_OUT(15:0) CPU_DATA_IN(15:0)
        END BLOCK
        BEGIN BLOCK XLXI_3 h2v
            PIN ndre_in CPU_NDRE
            PIN nadwe_in CPU_NADWE
            PIN dwait_in DWAIT_IN
            PIN nreset_in NRESET_IN
            PIN clk_in CLK_IN
            PIN iaddr(9:0) CPU_IADDR_OUT(9:0)
            PIN daddr(9:0) CPU_ADADDR_OUT(9:0)
            PIN iwait_out IWAIT_IN
            PIN maddr(9:0) MADDR(9:0)
        END BLOCK
        BEGIN BLOCK Cpu16 cpu
            PIN int_in CPU_INT
            PIN dwait_in DWAIT_IN
            PIN iwait_in IWAIT_IN
            PIN nreset_in NRESET_IN
            PIN clk_in CLK_IN
            PIN saddr_in(11:0) XLXN_20(11:0)
            PIN idata_in(15:0) MEM_DATA_OUT(15:0)
            PIN data_in(15:0) CPU_DATA_IN_M(15:0)
            PIN ipush_out XLXN_1
            PIN ipop_out XLXN_2
            PIN ndre_out CPU_NDRE
            PIN ndwe_out
            PIN nadwe_out CPU_NADWE
            PIN saddr_out(11:0) XLXN_14(11:0)
            PIN iaddr_out(11:0) CPU_IADDR_OUT(11:0)
            PIN data_out(15:0) DATA_OUT_EXT(15:0)
            PIN daddr_out(11:0)
            PIN adaddr_out(11:0) CPU_ADADDR_OUT(11:0)
        END BLOCK
        BEGIN BLOCK XLXI_7 sram
            PIN addr(7:0) XLXN_19(7:0)
            PIN din(11:0) XLXN_14(11:0)
            PIN we XLXN_1
            PIN clk CLK_IN
            PIN dout(11:0) XLXN_20(11:0)
        END BLOCK
        BEGIN BLOCK XLXI_4 stack_if
            PIN push_in XLXN_1
            PIN pop_in XLXN_2
            PIN nreset_in NRESET_IN
            PIN clk_in CLK_IN
            PIN addr_out(7:0) XLXN_19(7:0)
        END BLOCK
        BEGIN BLOCK XLXI_6 ram
            PIN addr(9:0) MADDR(9:0)
            PIN din(15:0) DATA_OUT_EXT(15:0)
            PIN we XLXN_27
            PIN clk CLK_IN
            PIN dout(15:0) MEM_DATA_OUT(15:0)
        END BLOCK
        BEGIN BLOCK XLXI_9 inv
            PIN I NWE_RAM
            PIN O XLXN_27
        END BLOCK
    END NETLIST
    BEGIN SHEET 1 3520 2720
        BEGIN INSTANCE XLXI_5 544 2368 R0
        END INSTANCE
        BEGIN BRANCH DWAIT_IN
            WIRE 1152 1952 1232 1952
            WIRE 1232 1952 1504 1952
            BEGIN DISPLAY 1232 1952 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH NRE_EXT
            WIRE 1152 2048 1232 2048
            WIRE 1232 2048 1504 2048
            BEGIN DISPLAY 1232 2048 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH NWE_EXT
            WIRE 1152 2144 1232 2144
            WIRE 1232 2144 1504 2144
            BEGIN DISPLAY 1232 2144 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH CPU_DATA_IN_M(15:0)
            WIRE 1152 2240 1296 2240
            WIRE 1296 2240 1504 2240
            BEGIN DISPLAY 1296 2240 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH NACS_EXT
            WIRE 224 1952 352 1952
            WIRE 352 1952 544 1952
            BEGIN DISPLAY 352 1952 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH CPU_NDRE
            WIRE 224 2016 352 2016
            WIRE 352 2016 544 2016
            BEGIN DISPLAY 352 2016 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH CPU_NADWE
            WIRE 224 2080 352 2080
            WIRE 352 2080 544 2080
            BEGIN DISPLAY 352 2080 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH NRESET_IN
            WIRE 224 2144 352 2144
            WIRE 352 2144 544 2144
            BEGIN DISPLAY 352 2144 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH CLK_IN
            WIRE 224 2208 320 2208
            WIRE 320 2208 544 2208
            BEGIN DISPLAY 320 2208 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH CPU_DATA_IN(15:0)
            WIRE 224 2272 352 2272
            WIRE 352 2272 544 2272
            BEGIN DISPLAY 352 2272 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH CPU_ADADDR_OUT(9:0)
            WIRE 224 2336 368 2336
            WIRE 368 2336 544 2336
            BEGIN DISPLAY 368 2336 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH ADDR_OUT_EXT(9:0)
            WIRE 1152 2336 1296 2336
            WIRE 1296 2336 1504 2336
            BEGIN DISPLAY 1296 2336 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        IOMARKER 1504 2336 ADDR_OUT_EXT(9:0) R0 28
        IOMARKER 1504 2144 NWE_EXT R0 28
        IOMARKER 1504 2048 NRE_EXT R0 28
        BEGIN INSTANCE XLXI_2 2368 1824 R0
        END INSTANCE
        BEGIN BRANCH NWE_RAM
            WIRE 2880 1472 2960 1472
            WIRE 2960 1472 3184 1472
            BEGIN DISPLAY 2960 1472 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH NCS_EXT
            WIRE 2880 1568 2944 1568
            WIRE 2944 1568 3184 1568
            BEGIN DISPLAY 2944 1568 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH NACS_EXT
            WIRE 2880 1664 2960 1664
            WIRE 2960 1664 3184 1664
            BEGIN DISPLAY 2960 1664 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH CPU_DATA_IN(15:0)
            WIRE 2880 1760 3008 1760
            WIRE 3008 1760 3184 1760
            BEGIN DISPLAY 3008 1760 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH NRESET_IN
            WIRE 2032 1536 2144 1536
            WIRE 2144 1536 2368 1536
            BEGIN DISPLAY 2144 1536 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH CLK_IN
            WIRE 2032 1600 2128 1600
            WIRE 2128 1600 2368 1600
            BEGIN DISPLAY 2128 1600 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH MEM_DATA_OUT(15:0)
            WIRE 2032 1664 2176 1664
            WIRE 2176 1664 2368 1664
            BEGIN DISPLAY 2176 1664 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH DATA_IN_EXT(15:0)
            WIRE 2016 1728 2160 1728
            WIRE 2160 1728 2368 1728
            BEGIN DISPLAY 2160 1728 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH CPU_ADADDR_OUT(9:0)
            WIRE 2032 1792 2192 1792
            WIRE 2192 1792 2368 1792
            BEGIN DISPLAY 2192 1792 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        IOMARKER 3184 1568 NCS_EXT R0 28
        IOMARKER 2016 1728 DATA_IN_EXT(15:0) R180 28
        BEGIN INSTANCE XLXI_3 544 1696 R0
        END INSTANCE
        BEGIN BRANCH CPU_NDRE
            WIRE 224 1280 352 1280
            WIRE 352 1280 544 1280
            BEGIN DISPLAY 352 1280 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH CPU_NADWE
            WIRE 224 1344 352 1344
            WIRE 352 1344 544 1344
            BEGIN DISPLAY 352 1344 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH DWAIT_IN
            WIRE 224 1408 336 1408
            WIRE 336 1408 544 1408
            BEGIN DISPLAY 336 1408 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH NRESET_IN
            WIRE 224 1472 352 1472
            WIRE 352 1472 544 1472
            BEGIN DISPLAY 352 1472 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH CLK_IN
            WIRE 224 1536 320 1536
            WIRE 320 1536 544 1536
            BEGIN DISPLAY 320 1536 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH CPU_IADDR_OUT(9:0)
            WIRE 224 1600 368 1600
            WIRE 368 1600 544 1600
            BEGIN DISPLAY 368 1600 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH CPU_ADADDR_OUT(9:0)
            WIRE 224 1664 384 1664
            WIRE 384 1664 544 1664
            BEGIN DISPLAY 384 1664 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH IWAIT_IN
            WIRE 928 1280 976 1280
            WIRE 976 1280 1312 1280
            BEGIN DISPLAY 976 1280 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH MADDR(9:0)
            WIRE 928 1664 1040 1664
            WIRE 1040 1664 1312 1664
            BEGIN DISPLAY 1040 1664 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN INSTANCE Cpu16 1344 1200 R0
        END INSTANCE
        BEGIN INSTANCE XLXI_7 3024 544 R0
        END INSTANCE
        BEGIN BRANCH XLXN_1
            WIRE 1776 592 2368 592
            WIRE 2368 592 2400 592
            WIRE 2368 464 2912 464
            WIRE 2912 464 2912 656
            WIRE 2912 656 3024 656
            WIRE 2368 464 2368 592
        END BRANCH
        BEGIN BRANCH XLXN_2
            WIRE 1776 656 2400 656
        END BRANCH
        BEGIN BRANCH NRESET_IN
            WIRE 896 832 1200 832
            WIRE 1200 832 1344 832
            BEGIN DISPLAY 1200 832 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH IWAIT_IN
            WIRE 1072 752 1184 752
            WIRE 1184 752 1344 752
            BEGIN DISPLAY 1184 752 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH CLK_IN
            WIRE 896 912 1168 912
            WIRE 1168 912 1344 912
            BEGIN DISPLAY 1168 912 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH MEM_DATA_OUT(15:0)
            WIRE 1072 1072 1200 1072
            WIRE 1200 1072 1344 1072
            BEGIN DISPLAY 1200 1072 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH CPU_DATA_IN_M(15:0)
            WIRE 1072 1152 1200 1152
            WIRE 1200 1152 1344 1152
            BEGIN DISPLAY 1200 1152 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH DWAIT_IN
            WIRE 1072 672 1184 672
            WIRE 1184 672 1344 672
            BEGIN DISPLAY 1184 672 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH CPU_INT
            WIRE 896 592 1184 592
            WIRE 1184 592 1344 592
            BEGIN DISPLAY 1184 592 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH CPU_NDRE
            WIRE 1776 720 1888 720
            WIRE 1888 720 2048 720
            BEGIN DISPLAY 1888 720 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH CPU_NADWE
            WIRE 1776 848 1904 848
            WIRE 1904 848 2048 848
            BEGIN DISPLAY 1904 848 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH XLXN_14(11:0)
            WIRE 1776 912 2784 912
            WIRE 2784 624 2784 912
            WIRE 2784 624 3024 624
        END BRANCH
        BEGIN BRANCH CPU_IADDR_OUT(11:0)
            WIRE 1776 976 1920 976
            WIRE 1920 976 2048 976
            BEGIN DISPLAY 1920 976 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH DATA_OUT_EXT(15:0)
            WIRE 1776 1040 1920 1040
            WIRE 1920 1040 2160 1040
            BEGIN DISPLAY 1920 1040 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH CPU_ADADDR_OUT(11:0)
            WIRE 1776 1168 1936 1168
            WIRE 1936 1168 2048 1168
            BEGIN DISPLAY 1936 1168 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH XLXN_19(7:0)
            WIRE 2784 592 3024 592
        END BRANCH
        BEGIN BRANCH XLXN_20(11:0)
            WIRE 992 416 992 992
            WIRE 992 992 1344 992
            WIRE 992 416 3424 416
            WIRE 3424 416 3424 592
            WIRE 3376 592 3424 592
        END BRANCH
        BEGIN INSTANCE XLXI_4 2400 816 R0
        END INSTANCE
        BEGIN BRANCH CLK_IN
            WIRE 2832 784 2912 784
            WIRE 2912 784 3024 784
            BEGIN DISPLAY 2912 784 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH CLK_IN
            WIRE 2176 784 2256 784
            WIRE 2256 784 2400 784
            BEGIN DISPLAY 2256 784 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH NRESET_IN
            WIRE 2176 720 2288 720
            WIRE 2288 720 2400 720
            BEGIN DISPLAY 2288 720 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        IOMARKER 896 832 NRESET_IN R180 28
        IOMARKER 896 592 CPU_INT R180 28
        IOMARKER 896 912 CLK_IN R180 28
        IOMARKER 2160 1040 DATA_OUT_EXT(15:0) R0 28
        BEGIN BRANCH MEM_DATA_OUT(15:0)
            WIRE 960 176 1104 176
            WIRE 1104 176 1264 176
            BEGIN DISPLAY 1104 176 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH DATA_OUT_EXT(15:0)
            WIRE 320 208 448 208
            WIRE 448 208 608 208
            BEGIN DISPLAY 448 208 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH CLK_IN
            WIRE 320 368 416 368
            WIRE 416 368 608 368
            BEGIN DISPLAY 416 368 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH MADDR(9:0)
            WIRE 320 176 448 176
            WIRE 448 176 608 176
            BEGIN DISPLAY 448 176 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN INSTANCE XLXI_6 608 128 R0
        END INSTANCE
        BEGIN BRANCH NWE_RAM
            WIRE 64 240 176 240
            WIRE 176 240 352 240
            BEGIN DISPLAY 176 240 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        INSTANCE XLXI_9 352 272 R0
        BEGIN BRANCH XLXN_27
            WIRE 576 240 608 240
        END BRANCH
        BEGIN BRANCH CPU_NADWE
            WIRE 2032 1856 2144 1856
            WIRE 2144 1856 2368 1856
            BEGIN DISPLAY 2144 1856 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
    END SHEET
END SCHEMATIC
