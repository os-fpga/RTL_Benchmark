VERSION 6
BEGIN SCHEMATIC
    BEGIN ATTR DeviceFamilyName "spartan2e"
        DELETE all:0
        EDITNAME all:0
        EDITTRAIT all:0
    END ATTR
    BEGIN NETLIST
        SIGNAL CPU_INT
        SIGNAL NRESET
        SIGNAL UCLK
        SIGNAL CPU_DATA_IN(7:0)
        SIGNAL nRE_CPU
        SIGNAL nWE_CPU
        SIGNAL CPU_DATA_OUT(7:0)
        SIGNAL CPU_ADDR_OUT(9:0)
        SIGNAL nWE_RAM
        SIGNAL RAM_DATA_OUT(7:0)
        SIGNAL nCS_UART
        SIGNAL CPU_ADDR_OUT(0)
        SIGNAL nCS_REG
        SIGNAL REG_DATA_OUT(7:0)
        SIGNAL nCS_TIMER
        SIGNAL TIMER_DATA_OUT(7:0)
        SIGNAL INT_DATA_OUT(7:0)
        SIGNAL nCS_INT
        SIGNAL INT_INT(7:0)
        SIGNAL INT_INT(4)
        SIGNAL INT_INT(5)
        SIGNAL IADDR(9:0)
        SIGNAL RXD
        SIGNAL UART_DATA_OUT(7:0)
        SIGNAL INT_INT(7)
        SIGNAL INT_INT(0)
        SIGNAL IN_INT(0)
        SIGNAL IN_INT(1)
        SIGNAL INT_INT(1)
        SIGNAL CPU_ADDR_OUT(7:0)
        SIGNAL IN_INT(3:0)
        SIGNAL TXD
        SIGNAL INT_INT(6)
        SIGNAL XLXN_3
        SIGNAL IDATA(13:0)
        SIGNAL IN_INT(2)
        SIGNAL IN_INT(3)
        SIGNAL INT_INT(2)
        SIGNAL INT_INT(3)
        SIGNAL XLXN_11
        SIGNAL IN0_REG(7:0)
        SIGNAL IN1_REG(7:0)
        SIGNAL OUT0_REG(7:0)
        SIGNAL OUT1_REG(7:0)
        PORT Input NRESET
        PORT Input UCLK
        PORT Input RXD
        PORT Input IN_INT(3:0)
        PORT Output TXD
        PORT Input IN0_REG(7:0)
        PORT Input IN1_REG(7:0)
        PORT Output OUT0_REG(7:0)
        PORT Output OUT1_REG(7:0)
        BEGIN BLOCKDEF cpu
            TIMESTAMP 2003 12 13 0 18 47
            RECTANGLE N 64 -448 352 0 
            LINE N 64 -416 0 -416 
            LINE N 64 -320 0 -320 
            LINE N 64 -224 0 -224 
            LINE N 64 -128 0 -128 
            RECTANGLE N 0 -140 64 -116 
            LINE N 64 -32 0 -32 
            RECTANGLE N 0 -44 64 -20 
            LINE N 352 -416 416 -416 
            LINE N 352 -352 416 -352 
            LINE N 352 -288 416 -288 
            LINE N 352 -224 416 -224 
            RECTANGLE N 352 -236 416 -212 
            LINE N 352 -160 416 -160 
            RECTANGLE N 352 -172 416 -148 
            LINE N 352 -96 416 -96 
            RECTANGLE N 352 -108 416 -84 
            LINE N 352 -32 416 -32 
            RECTANGLE N 352 -44 416 -20 
        END BLOCKDEF
        BEGIN BLOCKDEF ctrl8cpu
            TIMESTAMP 2003 12 13 0 19 23
            LINE N 64 32 0 32 
            RECTANGLE N 0 20 64 44 
            LINE N 64 -608 0 -608 
            LINE N 64 -544 0 -544 
            LINE N 64 -480 0 -480 
            LINE N 64 -416 0 -416 
            LINE N 64 -352 0 -352 
            RECTANGLE N 0 -364 64 -340 
            LINE N 64 -288 0 -288 
            RECTANGLE N 0 -300 64 -276 
            LINE N 64 -224 0 -224 
            RECTANGLE N 0 -236 64 -212 
            LINE N 64 -160 0 -160 
            RECTANGLE N 0 -172 64 -148 
            LINE N 64 -96 0 -96 
            RECTANGLE N 0 -108 64 -84 
            LINE N 64 -32 0 -32 
            RECTANGLE N 0 -44 64 -20 
            LINE N 688 -608 752 -608 
            LINE N 688 -512 752 -512 
            LINE N 688 -416 752 -416 
            LINE N 688 -320 752 -320 
            LINE N 688 -224 752 -224 
            LINE N 688 -128 752 -128 
            RECTANGLE N 688 -140 752 -116 
            RECTANGLE N 64 -640 688 64 
        END BLOCKDEF
        BEGIN BLOCKDEF inout4reg
            TIMESTAMP 2003 12 13 0 19 32
            LINE N 64 32 0 32 
            LINE N 64 96 0 96 
            RECTANGLE N 0 84 64 108 
            LINE N 64 160 0 160 
            RECTANGLE N 0 148 64 172 
            LINE N 624 32 688 32 
            RECTANGLE N 624 20 688 44 
            LINE N 624 96 688 96 
            RECTANGLE N 624 84 688 108 
            LINE N 64 -480 0 -480 
            LINE N 64 -416 0 -416 
            LINE N 64 -352 0 -352 
            LINE N 64 -288 0 -288 
            LINE N 64 -224 0 -224 
            LINE N 64 -160 0 -160 
            RECTANGLE N 0 -172 64 -148 
            LINE N 624 -480 688 -480 
            RECTANGLE N 624 -492 688 -468 
            RECTANGLE N 64 -512 624 192 
        END BLOCKDEF
        BEGIN BLOCKDEF interrupt
            TIMESTAMP 2003 12 13 0 19 38
            RECTANGLE N 64 -448 496 0 
            LINE N 64 -416 0 -416 
            LINE N 64 -352 0 -352 
            LINE N 64 -288 0 -288 
            LINE N 64 -224 0 -224 
            LINE N 64 -160 0 -160 
            LINE N 64 -96 0 -96 
            RECTANGLE N 0 -108 64 -84 
            LINE N 64 -32 0 -32 
            RECTANGLE N 0 -44 64 -20 
            LINE N 496 -416 560 -416 
            LINE N 496 -32 560 -32 
            RECTANGLE N 496 -44 560 -20 
        END BLOCKDEF
        BEGIN BLOCKDEF timer
            TIMESTAMP 2003 12 13 0 19 48
            LINE N 64 32 0 32 
            LINE N 64 -288 0 -288 
            LINE N 64 -224 0 -224 
            LINE N 64 -160 0 -160 
            LINE N 64 -96 0 -96 
            LINE N 64 -32 0 -32 
            RECTANGLE N 0 -44 64 -20 
            LINE N 464 -480 528 -480 
            LINE N 464 -32 528 -32 
            RECTANGLE N 464 -44 528 -20 
            RECTANGLE N 64 -512 464 64 
        END BLOCKDEF
        BEGIN BLOCKDEF tx_uart
            TIMESTAMP 2003 12 13 0 19 53
            LINE N 560 32 624 32 
            LINE N 64 -352 0 -352 
            LINE N 64 -288 0 -288 
            LINE N 64 -224 0 -224 
            LINE N 64 -160 0 -160 
            LINE N 64 -96 0 -96 
            LINE N 64 -32 0 -32 
            RECTANGLE N 0 -44 64 -20 
            LINE N 560 -352 624 -352 
            RECTANGLE N 64 -384 560 64 
        END BLOCKDEF
        BEGIN BLOCKDEF ram
            TIMESTAMP 2003 12 13 0 19 4
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
            TIMESTAMP 2003 12 13 0 19 15
            RECTANGLE N 32 0 320 272 
            BEGIN LINE W 0 48 32 48 
            END LINE
            LINE N 0 240 32 240 
            BEGIN LINE W 320 48 352 48 
            END LINE
        END BLOCKDEF
        BEGIN BLOCKDEF buf
            TIMESTAMP 2001 2 2 12 51 12
            LINE N 0 -32 64 -32 
            LINE N 224 -32 128 -32 
            LINE N 64 0 128 -32 
            LINE N 128 -32 64 -64 
            LINE N 64 -64 64 0 
        END BLOCKDEF
        BEGIN BLOCKDEF rx_uart
            TIMESTAMP 2003 12 13 0 19 44
            RECTANGLE N 64 -512 592 0 
            LINE N 64 -480 0 -480 
            LINE N 64 -416 0 -416 
            LINE N 64 -352 0 -352 
            LINE N 64 -288 0 -288 
            LINE N 64 -224 0 -224 
            LINE N 64 -160 0 -160 
            LINE N 64 -96 0 -96 
            LINE N 64 -32 0 -32 
            RECTANGLE N 0 -44 64 -20 
            LINE N 592 -480 656 -480 
            LINE N 592 -256 656 -256 
            LINE N 592 -32 656 -32 
            RECTANGLE N 592 -44 656 -20 
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
        BEGIN BLOCK XLXI_26 rx_uart
            PIN rx_uart RXD
            PIN addr CPU_ADDR_OUT(0)
            PIN nwe nWE_CPU
            PIN nre nRE_CPU
            PIN ncs_uart nCS_UART
            PIN clk UCLK
            PIN nreset NRESET
            PIN rx_uart_in(7:0) CPU_DATA_OUT(7:0)
            PIN rx_uart_full INT_INT(5)
            PIN rx_uart_ovr INT_INT(4)
            PIN rx_uart_out(7:0) UART_DATA_OUT(7:0)
        END BLOCK
        BEGIN BLOCK XLXI_4 interrupt
            PIN addr CPU_ADDR_OUT(0)
            PIN nwe nWE_CPU
            PIN ncs_int nCS_INT
            PIN clk UCLK
            PIN nreset NRESET
            PIN int_in(7:0) INT_INT(7:0)
            PIN int_data(7:0) CPU_DATA_OUT(7:0)
            PIN int_ext CPU_INT
            PIN int_out(7:0) INT_DATA_OUT(7:0)
        END BLOCK
        BEGIN BLOCK XLXI_8 rom
            PIN ADDR(9:0) IADDR(9:0)
            PIN CLK UCLK
            PIN DOUT(13:0) IDATA(13:0)
        END BLOCK
        BEGIN BLOCK XLXI_5 timer
            PIN addr CPU_ADDR_OUT(0)
            PIN nwe nWE_CPU
            PIN ncs_timer nCS_TIMER
            PIN clk UCLK
            PIN nreset NRESET
            PIN tmr_in(7:0) CPU_DATA_OUT(7:0)
            PIN tmr_int INT_INT(7)
            PIN tmr_out(7:0) TIMER_DATA_OUT(7:0)
        END BLOCK
        BEGIN BLOCK XLXI_10 buf
            PIN I IN_INT(0)
            PIN O INT_INT(0)
        END BLOCK
        BEGIN BLOCK XLXI_12 buf
            PIN I IN_INT(1)
            PIN O INT_INT(1)
        END BLOCK
        BEGIN BLOCK XLXI_7 ram
            PIN ADDR(7:0) CPU_ADDR_OUT(7:0)
            PIN DIN(7:0) CPU_DATA_OUT(7:0)
            PIN WE XLXN_3
            PIN CLK UCLK
            PIN DOUT(7:0) RAM_DATA_OUT(7:0)
        END BLOCK
        BEGIN BLOCK XLXI_55 ctrl8cpu
            PIN nwe_cpu nWE_CPU
            PIN nre_cpu nRE_CPU
            PIN clk UCLK
            PIN nreset NRESET
            PIN cpu_addr_out(9:0) CPU_ADDR_OUT(9:0)
            PIN cpu_data_out(7:0) CPU_DATA_OUT(7:0)
            PIN ram_data_out(7:0) RAM_DATA_OUT(7:0)
            PIN int_data_out(7:0) INT_DATA_OUT(7:0)
            PIN reg_data_out(7:0) REG_DATA_OUT(7:0)
            PIN timer_data_out(7:0) TIMER_DATA_OUT(7:0)
            PIN uart_data_out(7:0) UART_DATA_OUT(7:0)
            PIN nwe_ram nWE_RAM
            PIN ncs_int nCS_INT
            PIN ncs_uart nCS_UART
            PIN ncs_timer nCS_TIMER
            PIN ncs_reg nCS_REG
            PIN cpu_data_in(7:0) CPU_DATA_IN(7:0)
        END BLOCK
        BEGIN BLOCK XLXI_6 tx_uart
            PIN addr CPU_ADDR_OUT(0)
            PIN nwe nWE_CPU
            PIN ncs_uart nCS_UART
            PIN clk UCLK
            PIN nreset NRESET
            PIN tx_uart_data(7:0) CPU_DATA_OUT(7:0)
            PIN tx_uart TXD
            PIN tx_uart_empty INT_INT(6)
        END BLOCK
        BEGIN BLOCK XLXI_56 inv
            PIN I nWE_RAM
            PIN O XLXN_3
        END BLOCK
        BEGIN BLOCK XLXI_1 cpu
            PIN int_in CPU_INT
            PIN nreset_in NRESET
            PIN clk_in UCLK
            PIN idata_in(13:0) IDATA(13:0)
            PIN data_in(7:0) CPU_DATA_IN(7:0)
            PIN ndre_out nRE_CPU
            PIN ndwe_out nWE_CPU
            PIN nadwe_out
            PIN iaddr_out(9:0) IADDR(9:0)
            PIN data_out(7:0) CPU_DATA_OUT(7:0)
            PIN daddr_out(9:0) CPU_ADDR_OUT(9:0)
            PIN adaddr_out(9:0)
        END BLOCK
        BEGIN BLOCK XLXI_11 buf
            PIN I IN_INT(2)
            PIN O INT_INT(2)
        END BLOCK
        BEGIN BLOCK XLXI_13 buf
            PIN I IN_INT(3)
            PIN O INT_INT(3)
        END BLOCK
        BEGIN BLOCK XLXI_3 inout4reg
            PIN nWE nWE_CPU
            PIN nRE nRE_CPU
            PIN nCS_REG nCS_REG
            PIN nreset NRESET
            PIN clk UCLK
            PIN reg_data_in(7:0) CPU_DATA_OUT(7:0)
            PIN reg_data_out(7:0) REG_DATA_OUT(7:0)
            PIN addr CPU_ADDR_OUT(0)
            PIN in_0reg(7:0) IN0_REG(7:0)
            PIN in_1reg(7:0) IN1_REG(7:0)
            PIN out_0reg(7:0) OUT0_REG(7:0)
            PIN out_1reg(7:0) OUT1_REG(7:0)
        END BLOCK
    END NETLIST
    BEGIN SHEET 1 3520 2720
        BEGIN BRANCH UCLK
            WIRE 432 2400 560 2400
            WIRE 560 2400 768 2400
            BEGIN DISPLAY 560 2400 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH INT_DATA_OUT(7:0)
            WIRE 1328 2592 1504 2592
            WIRE 1504 2592 1696 2592
            BEGIN DISPLAY 1504 2592 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH NRESET
            WIRE 432 2464 576 2464
            WIRE 576 2464 768 2464
            BEGIN DISPLAY 576 2464 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH nCS_INT
            WIRE 432 2336 576 2336
            WIRE 576 2336 768 2336
            BEGIN DISPLAY 576 2336 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH nWE_CPU
            WIRE 432 2272 576 2272
            WIRE 576 2272 768 2272
            BEGIN DISPLAY 576 2272 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH CPU_ADDR_OUT(0)
            WIRE 432 2208 624 2208
            WIRE 624 2208 768 2208
            BEGIN DISPLAY 624 2208 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH CPU_DATA_OUT(7:0)
            WIRE 432 2592 624 2592
            WIRE 624 2592 768 2592
            BEGIN DISPLAY 624 2592 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH CPU_INT
            WIRE 1328 2208 1488 2208
            WIRE 1488 2208 1696 2208
            BEGIN DISPLAY 1488 2208 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN INSTANCE XLXI_4 768 2624 R0
        END INSTANCE
        BEGIN BRANCH INT_INT(7:0)
            WIRE 432 2528 592 2528
            WIRE 592 2528 768 2528
            BEGIN DISPLAY 592 2528 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN INSTANCE XLXI_8 592 272 R0
        END INSTANCE
        BEGIN BRANCH IADDR(9:0)
            WIRE 240 320 400 320
            WIRE 400 320 592 320
            BEGIN DISPLAY 400 320 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH UCLK
            WIRE 240 512 368 512
            WIRE 368 512 592 512
            BEGIN DISPLAY 368 512 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN DISPLAY 724 240 TEXT ROM
            FONT 32 "Arial"
        END DISPLAY
        IOMARKER 240 512 UCLK R180 28
        BEGIN INSTANCE XLXI_26 736 1136 R0
        END INSTANCE
        BEGIN BRANCH NRESET
            WIRE 384 1040 528 1040
            WIRE 528 1040 736 1040
            BEGIN DISPLAY 528 1040 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH UCLK
            WIRE 384 976 512 976
            WIRE 512 976 736 976
            BEGIN DISPLAY 512 976 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH nCS_UART
            WIRE 384 912 528 912
            WIRE 528 912 736 912
            BEGIN DISPLAY 528 912 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH nRE_CPU
            WIRE 384 848 528 848
            WIRE 528 848 736 848
            BEGIN DISPLAY 528 848 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH nWE_CPU
            WIRE 384 784 528 784
            WIRE 528 784 736 784
            BEGIN DISPLAY 528 784 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH CPU_DATA_OUT(7:0)
            WIRE 384 1104 576 1104
            WIRE 576 1104 736 1104
            BEGIN DISPLAY 576 1104 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH CPU_ADDR_OUT(0)
            WIRE 384 720 576 720
            WIRE 576 720 736 720
            BEGIN DISPLAY 576 720 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH RXD
            WIRE 208 656 496 656
            WIRE 496 656 736 656
            BEGIN DISPLAY 496 656 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH INT_INT(4)
            WIRE 1392 880 1504 880
            WIRE 1504 880 1712 880
            BEGIN DISPLAY 1504 880 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH INT_INT(5)
            WIRE 1392 656 1504 656
            WIRE 1504 656 1712 656
            BEGIN DISPLAY 1504 656 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH UART_DATA_OUT(7:0)
            WIRE 1392 1104 1568 1104
            WIRE 1568 1104 1744 1104
            BEGIN DISPLAY 1568 1104 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH UCLK
            WIRE 2064 1456 2192 1456
            WIRE 2192 1456 2416 1456
            BEGIN DISPLAY 2192 1456 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH NRESET
            WIRE 2064 1520 2208 1520
            WIRE 2208 1520 2416 1520
            BEGIN DISPLAY 2208 1520 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH nCS_TIMER
            WIRE 2064 1392 2208 1392
            WIRE 2208 1392 2416 1392
            BEGIN DISPLAY 2208 1392 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH nWE_CPU
            WIRE 2064 1328 2208 1328
            WIRE 2208 1328 2416 1328
            BEGIN DISPLAY 2208 1328 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH CPU_DATA_OUT(7:0)
            WIRE 2064 1584 2256 1584
            WIRE 2256 1584 2416 1584
            BEGIN DISPLAY 2256 1584 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH INT_INT(7)
            WIRE 2944 1136 3136 1136
            WIRE 3136 1136 3296 1136
            BEGIN DISPLAY 3136 1136 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH TIMER_DATA_OUT(7:0)
            WIRE 2944 1584 3120 1584
            WIRE 3120 1584 3296 1584
            BEGIN DISPLAY 3120 1584 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        INSTANCE XLXI_10 2736 1792 R0
        BEGIN BRANCH INT_INT(0)
            WIRE 2960 1760 3072 1760
            WIRE 3072 1760 3280 1760
            BEGIN DISPLAY 3072 1760 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH IN_INT(0)
            WIRE 2496 1760 2608 1760
            WIRE 2608 1760 2736 1760
            BEGIN DISPLAY 2608 1760 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        INSTANCE XLXI_12 2736 1872 R0
        BEGIN BRANCH IN_INT(1)
            WIRE 2496 1840 2608 1840
            WIRE 2608 1840 2736 1840
            BEGIN DISPLAY 2608 1840 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH INT_INT(1)
            WIRE 2960 1840 3072 1840
            WIRE 3072 1840 3280 1840
            BEGIN DISPLAY 3072 1840 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN INSTANCE XLXI_7 2720 144 R0
        END INSTANCE
        BEGIN BRANCH UCLK
            WIRE 2384 384 2480 384
            WIRE 2480 384 2720 384
            BEGIN DISPLAY 2480 384 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH CPU_DATA_OUT(7:0)
            WIRE 2384 224 2560 224
            WIRE 2560 224 2720 224
            BEGIN DISPLAY 2560 224 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH RAM_DATA_OUT(7:0)
            WIRE 3072 192 3216 192
            WIRE 3216 192 3424 192
            BEGIN DISPLAY 3216 192 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH CPU_ADDR_OUT(7:0)
            WIRE 2384 192 2560 192
            WIRE 2560 192 2720 192
            BEGIN DISPLAY 2560 192 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN DISPLAY 2868 112 TEXT RAM
            FONT 32 "Arial"
        END DISPLAY
        IOMARKER 208 656 RXD R180 28
        BEGIN BRANCH UART_DATA_OUT(7:0)
            WIRE 368 1936 544 1936
            WIRE 544 1936 720 1936
            BEGIN DISPLAY 544 1936 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH nCS_REG
            WIRE 1472 1680 1600 1680
            WIRE 1600 1680 1808 1680
            BEGIN DISPLAY 1600 1680 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH nCS_TIMER
            WIRE 1472 1584 1600 1584
            WIRE 1600 1584 1808 1584
            BEGIN DISPLAY 1600 1584 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH nCS_UART
            WIRE 1472 1488 1600 1488
            WIRE 1600 1488 1808 1488
            BEGIN DISPLAY 1600 1488 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH nCS_INT
            WIRE 1472 1392 1600 1392
            WIRE 1600 1392 1808 1392
            BEGIN DISPLAY 1600 1392 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH CPU_DATA_IN(7:0)
            WIRE 1472 1776 1632 1776
            WIRE 1632 1776 1824 1776
            BEGIN DISPLAY 1632 1776 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH nWE_RAM
            WIRE 1472 1296 1616 1296
            WIRE 1616 1296 1808 1296
            BEGIN DISPLAY 1616 1296 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH TIMER_DATA_OUT(7:0)
            WIRE 368 1872 544 1872
            WIRE 544 1872 720 1872
            BEGIN DISPLAY 544 1872 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH REG_DATA_OUT(7:0)
            WIRE 368 1808 544 1808
            WIRE 544 1808 720 1808
            BEGIN DISPLAY 544 1808 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH INT_DATA_OUT(7:0)
            WIRE 368 1744 544 1744
            WIRE 544 1744 720 1744
            BEGIN DISPLAY 544 1744 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH RAM_DATA_OUT(7:0)
            WIRE 368 1680 544 1680
            WIRE 544 1680 720 1680
            BEGIN DISPLAY 544 1680 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH nWE_CPU
            WIRE 368 1296 512 1296
            WIRE 512 1296 720 1296
            BEGIN DISPLAY 512 1296 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH nRE_CPU
            WIRE 368 1360 512 1360
            WIRE 512 1360 720 1360
            BEGIN DISPLAY 512 1360 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH NRESET
            WIRE 368 1488 512 1488
            WIRE 512 1488 720 1488
            BEGIN DISPLAY 512 1488 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH CPU_DATA_OUT(7:0)
            WIRE 368 1616 544 1616
            WIRE 544 1616 720 1616
            BEGIN DISPLAY 544 1616 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH CPU_ADDR_OUT(9:0)
            WIRE 368 1552 544 1552
            WIRE 544 1552 720 1552
            BEGIN DISPLAY 544 1552 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH UCLK
            WIRE 368 1424 496 1424
            WIRE 496 1424 720 1424
            BEGIN DISPLAY 496 1424 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN INSTANCE XLXI_55 720 1904 R0
        END INSTANCE
        BEGIN BRANCH IN_INT(3:0)
            WIRE 416 2064 544 2064
            WIRE 544 2064 704 2064
            BEGIN DISPLAY 544 2064 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN INSTANCE XLXI_6 2352 944 R0
        END INSTANCE
        BEGIN BRANCH UCLK
            WIRE 2000 784 2128 784
            WIRE 2128 784 2352 784
            BEGIN DISPLAY 2128 784 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH NRESET
            WIRE 2000 848 2144 848
            WIRE 2144 848 2352 848
            BEGIN DISPLAY 2144 848 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH nCS_UART
            WIRE 2000 720 2144 720
            WIRE 2144 720 2352 720
            BEGIN DISPLAY 2144 720 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH nWE_CPU
            WIRE 2000 656 2144 656
            WIRE 2144 656 2352 656
            BEGIN DISPLAY 2144 656 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH CPU_DATA_OUT(7:0)
            WIRE 2000 912 2192 912
            WIRE 2192 912 2352 912
            BEGIN DISPLAY 2192 912 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH TXD
            WIRE 2976 592 3056 592
            WIRE 3056 592 3264 592
            BEGIN DISPLAY 3056 592 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH INT_INT(6)
            WIRE 2976 976 3104 976
            WIRE 3104 976 3264 976
            BEGIN DISPLAY 3104 976 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        IOMARKER 3264 592 TXD R0 28
        BEGIN BRANCH nWE_RAM
            WIRE 2288 288 2400 288
            WIRE 2400 288 2448 288
            BEGIN DISPLAY 2400 288 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH XLXN_3
            WIRE 2672 288 2704 288
            WIRE 2704 256 2720 256
            WIRE 2704 256 2704 288
        END BRANCH
        BEGIN INSTANCE XLXI_1 1424 544 R0
        END INSTANCE
        BEGIN BRANCH CPU_DATA_IN(7:0)
            WIRE 1072 512 1232 512
            WIRE 1232 512 1424 512
            BEGIN DISPLAY 1232 512 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH IDATA(13:0)
            WIRE 944 320 992 320
            WIRE 992 320 992 416
            WIRE 992 416 1232 416
            WIRE 1232 416 1424 416
            BEGIN DISPLAY 1232 416 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH UCLK
            WIRE 1072 320 1200 320
            WIRE 1200 320 1424 320
            BEGIN DISPLAY 1200 320 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH CPU_INT
            WIRE 1072 128 1216 128
            WIRE 1216 128 1424 128
            BEGIN DISPLAY 1216 128 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        IOMARKER 256 224 NRESET R180 28
        BEGIN BRANCH NRESET
            WIRE 256 224 1216 224
            WIRE 1216 224 1424 224
            BEGIN DISPLAY 1216 224 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH nRE_CPU
            WIRE 1840 128 1952 128
            WIRE 1952 128 2128 128
            BEGIN DISPLAY 1952 128 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH nWE_CPU
            WIRE 1840 192 1952 192
            WIRE 1952 192 2128 192
            BEGIN DISPLAY 1952 192 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH IADDR(9:0)
            WIRE 1840 320 1968 320
            WIRE 1968 320 2128 320
            BEGIN DISPLAY 1968 320 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        INSTANCE XLXI_56 2448 320 R0
        BEGIN BRANCH CPU_ADDR_OUT(9:0)
            WIRE 1840 448 2000 448
            WIRE 2000 448 2128 448
            BEGIN DISPLAY 2000 448 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH CPU_DATA_OUT(7:0)
            WIRE 1840 384 2000 384
            WIRE 2000 384 2128 384
            BEGIN DISPLAY 2000 384 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN INSTANCE XLXI_5 2416 1616 R0
        END INSTANCE
        BEGIN BRANCH CPU_ADDR_OUT(0)
            WIRE 2064 1648 2272 1648
            WIRE 2272 1648 2416 1648
            BEGIN DISPLAY 2272 1648 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH CPU_ADDR_OUT(0)
            WIRE 2000 592 2192 592
            WIRE 2192 592 2352 592
            BEGIN DISPLAY 2192 592 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        IOMARKER 416 2064 IN_INT(3:0) R180 28
        INSTANCE XLXI_11 1712 1872 R0
        INSTANCE XLXI_13 1712 1952 R0
        BEGIN BRANCH IN_INT(2)
            WIRE 1472 1840 1584 1840
            WIRE 1584 1840 1712 1840
            BEGIN DISPLAY 1584 1840 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH IN_INT(3)
            WIRE 1472 1920 1584 1920
            WIRE 1584 1920 1712 1920
            BEGIN DISPLAY 1584 1920 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH INT_INT(2)
            WIRE 1936 1840 2048 1840
            WIRE 2048 1840 2256 1840
            BEGIN DISPLAY 2048 1840 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH INT_INT(3)
            WIRE 1936 1920 2048 1920
            WIRE 2048 1920 2256 1920
            BEGIN DISPLAY 2048 1920 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN INSTANCE XLXI_3 2304 2480 R0
        END INSTANCE
        BEGIN BRANCH UCLK
            WIRE 1952 2256 2080 2256
            WIRE 2080 2256 2304 2256
            BEGIN DISPLAY 2080 2256 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH NRESET
            WIRE 1952 2192 2096 2192
            WIRE 2096 2192 2304 2192
            BEGIN DISPLAY 2096 2192 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH nCS_REG
            WIRE 1952 2128 2096 2128
            WIRE 2096 2128 2304 2128
            BEGIN DISPLAY 2096 2128 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH nWE_CPU
            WIRE 1952 2000 2096 2000
            WIRE 2096 2000 2304 2000
            BEGIN DISPLAY 2096 2000 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH nRE_CPU
            WIRE 1952 2064 2096 2064
            WIRE 2096 2064 2304 2064
            BEGIN DISPLAY 2096 2064 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH CPU_DATA_OUT(7:0)
            WIRE 1952 2320 2144 2320
            WIRE 2144 2320 2304 2320
            BEGIN DISPLAY 2144 2320 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH REG_DATA_OUT(7:0)
            WIRE 2992 2000 3168 2000
            WIRE 3168 2000 3344 2000
            BEGIN DISPLAY 3168 2000 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH CPU_ADDR_OUT(0)
            WIRE 1952 2512 2144 2512
            WIRE 2144 2512 2304 2512
            BEGIN DISPLAY 2144 2512 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH IN0_REG(7:0)
            WIRE 2048 2576 2160 2576
            WIRE 2160 2576 2304 2576
            BEGIN DISPLAY 2160 2576 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        IOMARKER 2048 2576 IN0_REG(7:0) R180 28
        BEGIN BRANCH IN1_REG(7:0)
            WIRE 2048 2640 2160 2640
            WIRE 2160 2640 2288 2640
            WIRE 2288 2640 2304 2640
            BEGIN DISPLAY 2160 2640 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH OUT0_REG(7:0)
            WIRE 2992 2512 3008 2512
            WIRE 3008 2512 3104 2512
            WIRE 3104 2512 3280 2512
            BEGIN DISPLAY 3104 2512 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH OUT1_REG(7:0)
            WIRE 2992 2576 3008 2576
            WIRE 3008 2576 3104 2576
            WIRE 3104 2576 3280 2576
            BEGIN DISPLAY 3104 2576 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        IOMARKER 3280 2512 OUT0_REG(7:0) R0 28
        IOMARKER 3280 2576 OUT1_REG(7:0) R0 28
        IOMARKER 2048 2640 IN1_REG(7:0) R180 28
    END SHEET
END SCHEMATIC
