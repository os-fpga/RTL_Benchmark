VERSION 6
BEGIN SCHEMATIC
    BEGIN ATTR DeviceFamilyName "spartan2"
        DELETE all:0
        EDITNAME all:0
        EDITTRAIT all:0
    END ATTR
    BEGIN NETLIST
        SIGNAL CLK
        SIGNAL CPU_DATA_OUT(3:0)
        SIGNAL NRESET
        SIGNAL nWE_CPU
        SIGNAL nRE_CPU
        SIGNAL CPU_DATA_IN(3:0)
        SIGNAL CTRL_DATA_IN(3:0)
        SIGNAL CPU_DADDR(4:0)
        SIGNAL nWR_RAM
        SIGNAL RAM_DATA_OUT(3:0)
        SIGNAL XLXN_86(7:0)
        SIGNAL CTRL_DATA_OUT(3:0)
        SIGNAL PWM_OUT
        SIGNAL CTRL_DATA_OUT(0)
        SIGNAL CPU_DADDR(2)
        SIGNAL nCS_PWM
        SIGNAL XLXN_8(9:0)
        SIGNAL CPU_IADDR(7:0)
        SIGNAL CPU_DADDR(5:0)
        SIGNAL CPU_DADDR(3:0)
        SIGNAL XLXN_87
        PORT Input CLK
        PORT Output CPU_DATA_OUT(3:0)
        PORT Input NRESET
        PORT Output nWE_CPU
        PORT Output nRE_CPU
        PORT Input CTRL_DATA_IN(3:0)
        PORT Output CTRL_DATA_OUT(3:0)
        PORT Output PWM_OUT
        PORT Output CPU_IADDR(7:0)
        PORT Output CPU_DADDR(5:0)
        BEGIN BLOCKDEF ctrl4cpu
            TIMESTAMP 2003 12 10 22 35 38
            LINE N 656 32 720 32 
            LINE N 64 -480 0 -480 
            LINE N 64 -416 0 -416 
            LINE N 64 -352 0 -352 
            LINE N 64 -288 0 -288 
            LINE N 64 -224 0 -224 
            RECTANGLE N 0 -236 64 -212 
            LINE N 64 -160 0 -160 
            RECTANGLE N 0 -172 64 -148 
            LINE N 64 -96 0 -96 
            RECTANGLE N 0 -108 64 -84 
            LINE N 64 -32 0 -32 
            RECTANGLE N 0 -44 64 -20 
            LINE N 656 -480 720 -480 
            LINE N 656 -240 720 -240 
            RECTANGLE N 656 -252 720 -228 
            LINE N 656 -160 720 -160 
            RECTANGLE N 656 -172 720 -148 
            LINE N 656 -80 720 -80 
            RECTANGLE N 656 -92 720 -68 
            RECTANGLE N 64 -512 656 64 
        END BLOCKDEF
        BEGIN BLOCKDEF pwm
            TIMESTAMP 2003 12 10 22 35 33
            LINE N 64 32 0 32 
            LINE N 64 96 0 96 
            LINE N 64 160 0 160 
            LINE N 64 -224 0 -224 
            LINE N 64 -160 0 -160 
            LINE N 64 -96 0 -96 
            LINE N 64 -32 0 -32 
            RECTANGLE N 0 -44 64 -20 
            LINE N 432 -352 496 -352 
            RECTANGLE N 64 -384 432 192 
        END BLOCKDEF
        BEGIN BLOCKDEF ram
            TIMESTAMP 2003 12 10 22 35 13
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
        BEGIN BLOCKDEF rom
            TIMESTAMP 2003 12 10 22 35 22
            RECTANGLE N 32 0 320 272 
            BEGIN LINE W 0 48 32 48 
            END LINE
            LINE N 0 240 32 240 
            BEGIN LINE W 320 48 352 48 
            END LINE
        END BLOCKDEF
        BEGIN BLOCKDEF inv
            TIMESTAMP 2001 2 2 12 53 52
            LINE N 0 -32 64 -32 
            LINE N 224 -32 160 -32 
            LINE N 64 -64 128 -32 
            LINE N 128 -32 64 0 
            LINE N 64 0 64 -64 
            CIRCLE N 128 -48 160 -16 
        END BLOCKDEF
        BEGIN BLOCKDEF cpu
            TIMESTAMP 2003 12 11 21 30 22
            RECTANGLE N 64 -448 336 0 
            LINE N 64 -416 0 -416 
            LINE N 64 -288 0 -288 
            LINE N 64 -160 0 -160 
            RECTANGLE N 0 -172 64 -148 
            LINE N 64 -32 0 -32 
            RECTANGLE N 0 -44 64 -20 
            LINE N 336 -416 400 -416 
            LINE N 336 -352 400 -352 
            LINE N 336 -288 400 -288 
            LINE N 336 -224 400 -224 
            RECTANGLE N 336 -236 400 -212 
            LINE N 336 -160 400 -160 
            RECTANGLE N 336 -172 400 -148 
            LINE N 336 -96 400 -96 
            RECTANGLE N 336 -108 400 -84 
            LINE N 336 -32 400 -32 
            RECTANGLE N 336 -44 400 -20 
        END BLOCKDEF
        BEGIN BLOCK XLXI_2 ctrl4cpu
            PIN nwe_cpu nWE_CPU
            PIN nre_cpu nRE_CPU
            PIN clk CLK
            PIN nreset NRESET
            PIN cpu_addr_out(4:0) CPU_DADDR(4:0)
            PIN cpu_data_out(3:0) CPU_DATA_OUT(3:0)
            PIN ram_data_out(3:0) RAM_DATA_OUT(3:0)
            PIN ctrl_data_in(3:0) CTRL_DATA_IN(3:0)
            PIN nwr_ram nWR_RAM
            PIN ncs_pwm nCS_PWM
            PIN cpu_data_in(3:0) CPU_DATA_IN(3:0)
            PIN ctrl_data_out(3:0) CTRL_DATA_OUT(3:0)
            PIN pwm_data_out(7:0) XLXN_86(7:0)
        END BLOCK
        BEGIN BLOCK XLXI_3 pwm
            PIN addr CPU_DADDR(2)
            PIN nwr nWE_CPU
            PIN ncs_pwm nCS_PWM
            PIN pwm_enable CTRL_DATA_OUT(0)
            PIN clk CLK
            PIN nreset NRESET
            PIN pwm_data(7:0) XLXN_86(7:0)
            PIN pwm_out PWM_OUT
        END BLOCK
        BEGIN BLOCK XLXI_4 ram
            PIN ADDR(3:0) CPU_DADDR(3:0)
            PIN DIN(3:0) CPU_DATA_OUT(3:0)
            PIN WE XLXN_87
            PIN CLK CLK
            PIN DOUT(3:0) RAM_DATA_OUT(3:0)
        END BLOCK
        BEGIN BLOCK XLXI_7 inv
            PIN I nWR_RAM
            PIN O XLXN_87
        END BLOCK
        BEGIN BLOCK XLXI_5 rom
            PIN addr(7:0) CPU_IADDR(7:0)
            PIN clk CLK
            PIN dout(9:0) XLXN_8(9:0)
        END BLOCK
        BEGIN BLOCK XLXI_10 cpu
            PIN nreset_in NRESET
            PIN clk_in CLK
            PIN idata_in(9:0) XLXN_8(9:0)
            PIN data_in(3:0) CPU_DATA_IN(3:0)
            PIN ndre_out nRE_CPU
            PIN ndwe_out nWE_CPU
            PIN nadwe_out
            PIN iaddr_out(7:0) CPU_IADDR(7:0)
            PIN data_out(3:0) CPU_DATA_OUT(3:0)
            PIN daddr_out(5:0) CPU_DADDR(5:0)
            PIN adaddr_out(5:0)
        END BLOCK
    END NETLIST
    BEGIN SHEET 1 3520 2720
        BEGIN INSTANCE XLXI_2 784 1904 R0
        END INSTANCE
        BEGIN BRANCH CLK
            WIRE 432 1552 672 1552
            WIRE 672 1552 784 1552
            BEGIN DISPLAY 672 1552 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH NRESET
            WIRE 432 1616 672 1616
            WIRE 672 1616 784 1616
            BEGIN DISPLAY 672 1616 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH nWE_CPU
            WIRE 432 1424 640 1424
            WIRE 640 1424 784 1424
            BEGIN DISPLAY 640 1424 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH nRE_CPU
            WIRE 432 1488 640 1488
            WIRE 640 1488 784 1488
            BEGIN DISPLAY 640 1488 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH CPU_DATA_OUT(3:0)
            WIRE 432 1744 608 1744
            WIRE 608 1744 784 1744
            BEGIN DISPLAY 608 1744 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH CTRL_DATA_IN(3:0)
            WIRE 432 1872 592 1872
            WIRE 592 1872 784 1872
            BEGIN DISPLAY 592 1872 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH CPU_DADDR(4:0)
            WIRE 432 1680 592 1680
            WIRE 592 1680 784 1680
            BEGIN DISPLAY 592 1680 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH RAM_DATA_OUT(3:0)
            WIRE 432 1808 608 1808
            WIRE 608 1808 784 1808
            BEGIN DISPLAY 608 1808 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH CPU_DATA_IN(3:0)
            WIRE 1504 1664 1648 1664
            WIRE 1648 1664 1840 1664
            BEGIN DISPLAY 1648 1664 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH XLXN_86(7:0)
            WIRE 1504 1824 2336 1824
        END BRANCH
        BEGIN BRANCH CTRL_DATA_OUT(3:0)
            WIRE 1504 1744 1664 1744
            WIRE 1664 1744 1840 1744
            BEGIN DISPLAY 1664 1744 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH CTRL_DATA_OUT(3:0)
            WIRE 2560 2320 2720 2320
            WIRE 2720 2320 2896 2320
            BEGIN DISPLAY 2720 2320 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        IOMARKER 432 1872 CTRL_DATA_IN(3:0) R180 28
        IOMARKER 2896 2320 CTRL_DATA_OUT(3:0) R0 28
        BEGIN BRANCH nWR_RAM
            WIRE 1504 1424 1520 1424
            WIRE 1520 1024 1520 1424
            WIRE 1520 1024 1616 1024
            WIRE 1616 1024 1712 1024
            BEGIN DISPLAY 1616 1024 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN INSTANCE XLXI_3 2336 1856 R0
        END INSTANCE
        BEGIN BRANCH PWM_OUT
            WIRE 2832 1504 2896 1504
            WIRE 2896 1504 3136 1504
            BEGIN DISPLAY 2896 1504 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        IOMARKER 3136 1504 PWM_OUT R0 28
        BEGIN BRANCH CTRL_DATA_OUT(0)
            WIRE 2048 1632 2192 1632
            WIRE 2192 1632 2336 1632
            BEGIN DISPLAY 2192 1632 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH CLK
            WIRE 2048 1696 2224 1696
            WIRE 2224 1696 2336 1696
            BEGIN DISPLAY 2224 1696 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH NRESET
            WIRE 2048 1760 2224 1760
            WIRE 2224 1760 2336 1760
            BEGIN DISPLAY 2224 1760 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH nWE_CPU
            WIRE 2048 1952 2192 1952
            WIRE 2192 1952 2336 1952
            BEGIN DISPLAY 2192 1952 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH CPU_DADDR(2)
            WIRE 2048 1888 2192 1888
            WIRE 2192 1888 2336 1888
            BEGIN DISPLAY 2192 1888 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH nCS_PWM
            WIRE 1504 1936 1632 1936
            WIRE 1632 1936 1824 1936
            WIRE 1824 1936 1824 2016
            WIRE 1824 2016 2336 2016
            BEGIN DISPLAY 1632 1936 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH NRESET
            WIRE 640 368 1520 368
            WIRE 1520 368 1712 368
            BEGIN DISPLAY 1520 368 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH nRE_CPU
            WIRE 2112 368 2224 368
            WIRE 2224 368 2544 368
            BEGIN DISPLAY 2224 368 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH nWE_CPU
            WIRE 2112 432 2224 432
            WIRE 2224 432 2544 432
            BEGIN DISPLAY 2224 432 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH CPU_DADDR(5:0)
            WIRE 2112 688 2272 688
            WIRE 2272 688 2544 688
            BEGIN DISPLAY 2272 688 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        IOMARKER 640 368 NRESET R180 28
        IOMARKER 2544 368 nRE_CPU R0 28
        IOMARKER 2544 432 nWE_CPU R0 28
        BEGIN BRANCH CLK
            WIRE 2048 1152 2240 1152
            WIRE 2240 1152 2400 1152
            BEGIN DISPLAY 2240 1152 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH CPU_DATA_OUT(3:0)
            WIRE 2048 992 2224 992
            WIRE 2224 992 2400 992
            BEGIN DISPLAY 2224 992 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH CPU_DADDR(3:0)
            WIRE 2048 960 2208 960
            WIRE 2208 960 2400 960
            BEGIN DISPLAY 2208 960 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH RAM_DATA_OUT(3:0)
            WIRE 2752 960 2960 960
            WIRE 2960 960 3136 960
            BEGIN DISPLAY 2960 960 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        INSTANCE XLXI_7 1712 1056 R0
        BEGIN INSTANCE XLXI_4 2400 912 R0
        END INSTANCE
        BEGIN BRANCH XLXN_87
            WIRE 1936 1024 2400 1024
        END BRANCH
        BEGIN BRANCH CPU_DATA_IN(3:0)
            WIRE 1376 752 1568 752
            WIRE 1568 752 1712 752
            BEGIN DISPLAY 1568 752 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH CLK
            WIRE 1376 496 1600 496
            WIRE 1600 496 1712 496
            BEGIN DISPLAY 1600 496 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH CLK
            WIRE 576 816 688 816
            WIRE 688 816 848 816
            BEGIN DISPLAY 688 816 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN INSTANCE XLXI_5 848 576 R0
        END INSTANCE
        BEGIN BRANCH CPU_IADDR(7:0)
            WIRE 496 624 656 624
            WIRE 656 624 848 624
            BEGIN DISPLAY 656 624 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        IOMARKER 576 816 CLK R180 28
        BEGIN BRANCH XLXN_8(9:0)
            WIRE 1200 624 1712 624
        END BRANCH
        IOMARKER 2544 688 CPU_DADDR(5:0) R0 28
        BEGIN BRANCH CPU_DATA_OUT(3:0)
            WIRE 2112 624 2288 624
            WIRE 2288 624 2544 624
            BEGIN DISPLAY 2288 624 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        IOMARKER 2544 624 CPU_DATA_OUT(3:0) R0 28
        BEGIN BRANCH CPU_IADDR(7:0)
            WIRE 2112 560 2272 560
            WIRE 2272 560 2544 560
            BEGIN DISPLAY 2272 560 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        IOMARKER 2544 560 CPU_IADDR(7:0) R0 28
        BEGIN INSTANCE XLXI_10 1712 784 R0
        END INSTANCE
    END SHEET
END SCHEMATIC
