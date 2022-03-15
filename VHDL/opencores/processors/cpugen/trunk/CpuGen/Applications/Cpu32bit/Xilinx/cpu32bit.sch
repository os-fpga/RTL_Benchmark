VERSION 6
BEGIN SCHEMATIC
    BEGIN ATTR DeviceFamilyName "spartan3"
        DELETE all:0
        EDITNAME all:0
        EDITTRAIT all:0
    END ATTR
    BEGIN NETLIST
        SIGNAL INT_IN
        SIGNAL XLXN_2
        SIGNAL NRESET_IN
        SIGNAL CLK_IN
        SIGNAL IDATA_IN(31:0)
        SIGNAL DATA_IN(31:0)
        SIGNAL NDRE_OUT
        SIGNAL NDWE_OUT
        SIGNAL NADWE_OUT
        SIGNAL IADDR_OUT(26:0)
        SIGNAL DATA_OUT(31:0)
        SIGNAL DADDR_OUT(26:0)
        SIGNAL ADADDR_OUT(26:0)
        SIGNAL IADDR_OUT(9:0)
        SIGNAL DADDR_OUT(9:0)
        SIGNAL XLXN_19
        PORT Input INT_IN
        PORT Input NRESET_IN
        PORT Input CLK_IN
        PORT Output NDRE_OUT
        PORT Output NDWE_OUT
        PORT Output DATA_OUT(31:0)
        PORT Output DADDR_OUT(26:0)
        BEGIN BLOCKDEF cpuc
            TIMESTAMP 2004 2 1 17 28 4
            RECTANGLE N 64 -448 368 0 
            LINE N 64 -416 0 -416 
            LINE N 64 -352 0 -352 
            LINE N 64 -288 0 -288 
            LINE N 64 -224 0 -224 
            LINE N 64 -160 0 -160 
            RECTANGLE N 0 -172 64 -148 
            LINE N 64 -96 0 -96 
            RECTANGLE N 0 -108 64 -84 
            LINE N 368 -416 432 -416 
            LINE N 368 -352 432 -352 
            LINE N 368 -288 432 -288 
            LINE N 368 -224 432 -224 
            RECTANGLE N 368 -236 432 -212 
            LINE N 368 -160 432 -160 
            RECTANGLE N 368 -172 432 -148 
            LINE N 368 -96 432 -96 
            RECTANGLE N 368 -108 432 -84 
            LINE N 368 -32 432 -32 
            RECTANGLE N 368 -44 432 -20 
        END BLOCKDEF
        BEGIN BLOCKDEF ram
            TIMESTAMP 2004 2 7 13 50 55
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
            TIMESTAMP 2004 2 7 13 51 24
            RECTANGLE N 32 0 320 272 
            BEGIN LINE W 0 48 32 48 
            END LINE
            LINE N 0 240 32 240 
            BEGIN LINE W 320 48 352 48 
            END LINE
        END BLOCKDEF
        BEGIN BLOCKDEF gnd
            TIMESTAMP 2001 2 2 12 37 29
            LINE N 64 -64 64 -96 
            LINE N 76 -48 52 -48 
            LINE N 68 -32 60 -32 
            LINE N 88 -64 40 -64 
            LINE N 64 -64 64 -80 
            LINE N 64 -128 64 -96 
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
        BEGIN BLOCK XLXI_1 cpuc
            PIN int_in INT_IN
            PIN dwait_in XLXN_2
            PIN nreset_in NRESET_IN
            PIN clk_in CLK_IN
            PIN idata_in(31:0) IDATA_IN(31:0)
            PIN data_in(31:0) DATA_IN(31:0)
            PIN ndre_out NDRE_OUT
            PIN ndwe_out NDWE_OUT
            PIN nadwe_out NADWE_OUT
            PIN iaddr_out(26:0) IADDR_OUT(26:0)
            PIN data_out(31:0) DATA_OUT(31:0)
            PIN daddr_out(26:0) DADDR_OUT(26:0)
            PIN adaddr_out(26:0) ADADDR_OUT(26:0)
        END BLOCK
        BEGIN BLOCK XLXI_2 ram
            PIN addr(9:0) DADDR_OUT(9:0)
            PIN din(31:0) DATA_OUT(31:0)
            PIN we XLXN_19
            PIN clk CLK_IN
            PIN dout(31:0) DATA_IN(31:0)
        END BLOCK
        BEGIN BLOCK XLXI_3 rom
            PIN addr(9:0) IADDR_OUT(9:0)
            PIN clk CLK_IN
            PIN dout(31:0) IDATA_IN(31:0)
        END BLOCK
        BEGIN BLOCK XLXI_4 gnd
            PIN G XLXN_2
        END BLOCK
        BEGIN BLOCK XLXI_5 inv
            PIN I NDWE_OUT
            PIN O XLXN_19
        END BLOCK
    END NETLIST
    BEGIN SHEET 1 3520 2720
        BEGIN INSTANCE XLXI_1 1472 896 R0
        END INSTANCE
        BEGIN INSTANCE XLXI_2 1520 1360 R0
        END INSTANCE
        BEGIN INSTANCE XLXI_3 1520 1008 R0
        END INSTANCE
        BEGIN BRANCH INT_IN
            WIRE 1120 480 1184 480
            WIRE 1184 480 1472 480
            BEGIN DISPLAY 1184 480 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH XLXN_2
            WIRE 1360 544 1360 832
            WIRE 1360 544 1472 544
        END BRANCH
        BEGIN BRANCH NRESET_IN
            WIRE 1120 608 1216 608
            WIRE 1216 608 1472 608
            BEGIN DISPLAY 1216 608 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH CLK_IN
            WIRE 1120 672 1184 672
            WIRE 1184 672 1472 672
            BEGIN DISPLAY 1184 672 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH IDATA_IN(31:0)
            WIRE 1120 736 1232 736
            WIRE 1232 736 1472 736
            BEGIN DISPLAY 1232 736 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH DATA_IN(31:0)
            WIRE 1120 800 1232 800
            WIRE 1232 800 1472 800
            BEGIN DISPLAY 1232 800 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH NDRE_OUT
            WIRE 1904 480 2016 480
            WIRE 2016 480 2240 480
            BEGIN DISPLAY 2016 480 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH NDWE_OUT
            WIRE 1904 544 2016 544
            WIRE 2016 544 2240 544
            BEGIN DISPLAY 2016 544 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH NADWE_OUT
            WIRE 1904 608 2032 608
            WIRE 2032 608 2240 608
            BEGIN DISPLAY 2032 608 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH IADDR_OUT(26:0)
            WIRE 1904 672 2048 672
            WIRE 2048 672 2240 672
            BEGIN DISPLAY 2048 672 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH DATA_OUT(31:0)
            WIRE 1904 736 2048 736
            WIRE 2048 736 2240 736
            BEGIN DISPLAY 2048 736 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH DADDR_OUT(26:0)
            WIRE 1904 800 2048 800
            WIRE 2048 800 2240 800
            BEGIN DISPLAY 2048 800 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH ADADDR_OUT(26:0)
            WIRE 1904 864 2048 864
            WIRE 2048 864 2240 864
            BEGIN DISPLAY 2048 864 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH IDATA_IN(31:0)
            WIRE 1872 1056 2064 1056
            WIRE 2064 1056 2240 1056
            BEGIN DISPLAY 2064 1056 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH IADDR_OUT(9:0)
            WIRE 1120 1056 1248 1056
            WIRE 1248 1056 1520 1056
            BEGIN DISPLAY 1248 1056 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH CLK_IN
            WIRE 1120 1248 1200 1248
            WIRE 1200 1248 1520 1248
            BEGIN DISPLAY 1200 1248 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH DADDR_OUT(9:0)
            WIRE 1120 1408 1248 1408
            WIRE 1248 1408 1520 1408
            BEGIN DISPLAY 1248 1408 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH DATA_OUT(31:0)
            WIRE 1120 1440 1248 1440
            WIRE 1248 1440 1520 1440
            BEGIN DISPLAY 1248 1440 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH XLXN_19
            WIRE 1120 1472 1520 1472
        END BRANCH
        BEGIN BRANCH CLK_IN
            WIRE 1120 1600 1184 1600
            WIRE 1184 1600 1520 1600
            BEGIN DISPLAY 1184 1600 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH DATA_IN(31:0)
            WIRE 1872 1408 2064 1408
            WIRE 2064 1408 2240 1408
            BEGIN DISPLAY 2064 1408 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        IOMARKER 1120 480 INT_IN R180 28
        IOMARKER 1120 608 NRESET_IN R180 28
        IOMARKER 1120 672 CLK_IN R180 28
        IOMARKER 2240 480 NDRE_OUT R0 28
        IOMARKER 2240 544 NDWE_OUT R0 28
        IOMARKER 2240 736 DATA_OUT(31:0) R0 28
        IOMARKER 2240 800 DADDR_OUT(26:0) R0 28
        INSTANCE XLXI_4 1296 960 R0
        INSTANCE XLXI_5 896 1504 R0
        BEGIN BRANCH NDWE_OUT
            WIRE 592 1472 720 1472
            WIRE 720 1472 896 1472
            BEGIN DISPLAY 720 1472 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
    END SHEET
END SCHEMATIC
