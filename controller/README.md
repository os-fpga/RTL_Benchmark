## Directory Structure

    ├── ac97
    │   ├── doc
    │   ├── rtl
    │   │   └── verilog
    │   └── testbench
    │       └── verilog
    ├── ata
    │   ├── doc
    │   ├── rtl
    │   │   ├── verilog
    │   │   │   ├── ocidec-1
    │   │   │   └── ocidec-2
    │   │   └── vhdl
    │   │       ├── ocidec1
    │   │       ├── ocidec2
    │   │       └── ocidec3
    │   └── testbench
    │       └── verilog
    ├── ch_intrinsic
    │   └── rtl
    ├── ethernet_mac
    │   ├── doc
    │   ├── rtl
    │   └── testbench
    │       └── verilog
    ├── i2c_master
    │   ├── doc
    │   ├── rtl
    │   └── testbench
    │       └── verilog
    ├── mem_ctl
    │   ├── doc
    │   ├── rtl
    │   │   └── verilog
    │   └── testbench
    │       ├── richard
    │       │   └── verilog
    │       │       └── models
    │       ├── verilog
    │       │   ├── 160b3ver
    │       │   ├── sdram_models
    │       │   │   ├── 16Mx16
    │       │   │   ├── 16Mx8
    │       │   │   ├── 2Mx32
    │       │   │   ├── 32Mx8
    │       │   │   ├── 4Mx16
    │       │   │   ├── 4Mx32
    │       │   │   ├── 8Mx16
    │       │   │   └── 8Mx8
    │       │   └── sram_models
    │       │       ├── IDT71T67802
    │       │       └── MicronSRAM
    │       └── vhdl
    ├── sasc
    │   └── rtl
    ├── sdc_controller
    │   ├── doc
    │   │   ├── references
    │   │   └── src
    │   ├── rtl
    │   │   ├── verilog
    │   │   └── VHDL
    │   └── testbench
    │       └── verilog
    ├── simple_pic
    │   └── rtl
    ├── steppermotordrive
    │   └── rtl
    ├── usb1.1_phy
    │   └── rtl
    ├── usb2.0
    │   ├── doc
    │   └── rtl
    │       └── verilog
    └── vga_lcd
        ├── doc
        ├── rtl
        │   ├── verilog
        │   └── vhdl
        └── testbench
            └── verilog


## Synthesis report of each benchmark on different tools:

|**_ata_ocidec-1_**|**LUT**|**FF**|**DSP**|**BRAM**|**IO**|
|:---:|:---:|:---:|:---:|:---:|:---:|
|Vivado|201|269|0|0|125|
|Quartus prime|206|273|0|0|125|
|Lattice diamond|279|269|0|0|125|
|Anlogic|231|270|0|0|125|
|Gowin|298|269|0|0|125|
|OSFPGA|-|-|-|-|-|
|**_ata_ocidec-2_**|**LUT**|**FF**|**DSP**|**BRAM**|**IO**|
|Vivado|240|303|0|0|125|
|Quartus prime|276|309|0|0|125|
|Lattice diamond|357|303|0|0|125|
|Anlogic|267|304|0|0|125|
|Gowin|368|303|0|0|125|
|OSFPGA|-|-|-|-|-|
|**_ata_ocidec-3_**|**LUT**|**FF**|**DSP**|**BRAM**|**IO**|
|Vivado|496|525|0|0|130|
|Quartus prime|535|618|0|1|130|
|Lattice diamond|682|525|0|0|130|
|Anlogic|446|526|0|0|130|
|Gowin|751|526|0|0|130|
|OSFPGA|-|-|-|-|-|
|**_ch_intrinsics_**|**LUT**|**FF**|**DSP**|**BRAM**|**IO**|
|Vivado|29|103|0|0|229|
|Quartus prime|132|152|0|0|229|
|Lattice diamond|223|219|0|0|229|
|Anlogic|57|112|0|0|229|
|Gowin|186|294|0|0|229|
|OSFPGA|-|-|-|-|-|
|**_ethernet_mac_**|**LUT**|**FF**|**DSP**|**BRAM**|**IO**|
|Vivado|1969|2350|0|2|211|
|Quartus prime|1115|1285|0|0|211|
|Lattice diamond|3144|2371|0|4|211|
|Anlogic|2020|2429|0|0|211|
|Gowin|2686|2344|0|4|211|
|OSFPGA|3627|2380|0|4|211|
|**_i2c_master_**|**LUT**|**FF**|**DSP**|**BRAM**|**IO**|
|Vivado|139|114|0|0|33|
|Quartus prime|205|129|0|0|33|
|Lattice diamond|178|130|0|0|33|
|Anlogic|150|129|0|0|33|
|Gowin|255|126|0|0|33|
|OSFPGA|247|128|0|0|33|
|**_mem_ctl_**|**LUT**|**FF**|**DSP**|**BRAM**|**IO**|
|Vivado|1120|992|0|1|267|
|Quartus prime|1324|1168|0|0|267|
|Lattice diamond|1644|1059|0|0|267|
|Anlogic|1097|1095|0|0|267|
|Gowin|2041|1051|0|0|267|
|OSFPGA|2435|1069|0|0|267|
|**_sasc_**|**LUT**|**FF**|**DSP**|**BRAM**|**IO**|
|Vivado|56|52|0|0|28|
|Quartus prime|74|130|0|0|28|
|Lattice diamond|87|54|0|0|28|
|Anlogic|56|53|0|0|28|
|Gowin|75|52|0|0|28|
|OSFPGA|188|132|0|0|28|
|**_sdc_controller_**|**LUT**|**FF**|**DSP**|**BRAM**|**IO**|
|Vivado|1458|1604|0|0|203|
|Quartus prime|1446|1732|0|0|207|
|Lattice diamond||||||
|Anlogic|1504|1674|0|0|207|
|Gowin||||||
|OSFPGA||||||
|**_simple_pic_**|**LUT**|**FF**|**DSP**|**BRAM**|**IO**|
|Vivado|33|66|0|0|31|
|Quartus prime|42|59|0|0|33|
|Lattice diamond|53|66|0|0|33|
|Anlogic|67|37|0|0|33|
|Gowin|50|66|0|0|33|
|OSFPGA|56|66|0|0|33|
|**_steppermotordrive_**|**LUT**|**FF**|**DSP**|**BRAM**|**IO**|
|Vivado|15|39|0|0|8|
|Quartus prime|48|40|0|0|8|
|Lattice diamond|69|390|0|0|8|
|Anlogic|38|39|0|0|8|
|Gowin|50|39|0|0|8|
|OSFPGA|-|-|-|-|-|
|**_usb1.1_phy_**|**LUT**|**FF**|**DSP**|**BRAM**|**IO**|
|Vivado|64|110|0|0|33|
|Quartus prime|109|126|0|0|33|
|Lattice diamond|103|103|0|0|33|
|Anlogic|71|111|0|0|33|
|Gowin|89|98|0|0|33|
|OSFPGA|106|98|0|0|33|
|**_usb2.0_**|**LUT**|**FF**|**DSP**|**BRAM**|**IO**|
|Vivado|1852|1713|0|0|235|
|Quartus prime|1491|1812|0|0|249|
|Lattice diamond|2836|1746|0|0|235|
|Anlogic|1780|1765|0|0|249|
|Gowin|2866|1719|0|0|249|
|OSFPGA|3129|1737|0|0|235|
|**_vga_lcd_**|**LUT**|**FF**|**DSP**|**BRAM**|**IO**|
|Vivado|914|748|0|1|196|
|Quartus prime|830|799|0|5|198|
|Lattice diamond|1000|807|0|2|196|
|Anlogic|857|763|0|2|198|
|Gowin|1320|746|0|2|198|
|OSFPGA|5614|3887|0|11|196|
