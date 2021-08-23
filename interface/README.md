## Directory Structure

    ├── simple_gpio
    │   └── rtl
    ├── simple_spi
    │   ├── doc
    │   ├── rtl
    │   │   └── verilog
    │   └── testbench
    │       └── verilog
    ├── spi
    │   ├── doc
    │   ├── rtl
    │   └── testbench
    │       └── verilog
    ├── ss_pcm
    │   └── rtl
    │       └── verilog
    ├── wb_conmax
    │   ├── doc
    │   ├── rtl
    │   │   ├── raw_rtl
    │   │   └── wrapper_rtl
    │   └── testbench
    │       └── verilog
    ├── wb_dma
    │   ├── doc
    │   ├── rtl
    │   │   ├── raw_rtl
    │   │   └── wrapper_rtl
    │   └── testbench
    │       └── verilog
    └── wbif_68k
        └── rtl
            └── verilog


## Synthesis report of each benchmark on different tools:

|**_simple_gpio_**|**LUT**|**FF**|**DSP**|**BRAM**|**IO**|
|:---:|:---:|:---:|:---:|:---:|:---:|
|Vivado|16|41|0|0|31|
|Quartus prime|12|33|0|0|31|
|Lattice diamond|11|41|0|0|31|
|Anlogic|23|42|0|0|31|
|Gowin|23|26|0|0|31|
|OSFPGA|-|-|-|-|-|
|**_simple_spi_**|**LUT**|**FF**|**DSP**|**BRAM**|**IO**|
|Vivado|92|68|0|0|28|
|Quartus prime|103|135|0|0|28|
|Lattice diamond|149|67|0|0|28|
|Anlogic|87|71|0|0|28|
|Gowin|130|67|0|0|28|
|OSFPGA|188|132|0|0|28|
|**_spi_**|**LUT**|**FF**|**DSP**|**BRAM**|**IO**|
|Vivado|555|229|0|0|90|
|Quartus prime|643|285|0|0|92|
|Lattice diamond|952|229|0|0|90|
|Anlogic|588|239|0|0|92|
|Gowin|691|229|0|0|92|
|OSFPGA|731|229|0|0|92|
|**_ss_pcm_**|**LUT**|**FF**|**DSP**|**BRAM**|**IO**|
|Vivado|31|79|0|0|28|
|Quartus prime|24|90|0|0|28|
|Lattice diamond|44|87|0|0|28|
|Anlogic|41|88|0|0|28|
|Gowin|40|87|0|0|28|
|OSFPGA|96|87|0|0|28|
|**_wm_conmax (wrapper)_**|**LUT**|**FF**|**DSP**|**BRAM**|**IO**|
|Vivado|519|527|0|0|221|
|Quartus prime|608|582|0|0|222|
|Lattice diamond|-|-|-|-|-|
|Anlogic|687|524|0|0|222|
|Gowin|773|521|0|0|222|
|OSFPGA|921|532|0|0|221|
|**_wbif_68k_**|**LUT**|**FF**|**DSP**|**BRAM**|**IO**|
|Vivado|5|31|0|0|83|
|Quartus prime|9|32|0|0|83|
|Lattice diamond|7|30|0|0|83|
|Anlogic|7|47|0|0|83|
|Gowin|6|30|0|0|83|
|OSFPGA|-|-|-|-|-|
