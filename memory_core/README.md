## Directory Structure
    ├── generic_fifo_dc
    │   ├── rtl
    │   │   └── verilog
    │   └── testbench
    │       └── verilog
    ├── generic_fifo_dc_gray
    │   ├── rtl
    │   │   └── verilog
    │   └── testbench
    │       └── verilog
    ├── generic_fifo_lfsr
    │   ├── rtl
    │   │   └── verilog
    │   └── testbench
    │       └── verilog
    ├── generic_fifo_sc_a
    │   ├── rtl
    │   │   └── verilog
    │   └── testbench
    │       └── verilog
    ├── generic_fifo_sc_b
    │   ├── rtl
    │   │   └── verilog
    │   └── testbench
    │       └── verilog
    └── ssram
        └── rtl


## Synthesis report of each benchmark on different tools:

|**_generic_fifo_dc_**|**LUT**|**FF**|**DSP**|**BRAM**|**IO**|
|:---:|:---:|:---:|:---:|:---:|:---:|
|Vivado|46|62|0|0.5|28|
|Quartus prime|63|70|0|0|28|
|Lattice diamond|109|88|0|1|28|
|Anlogic|99|70|0|0|28|
|Gowin|80|62|0|1|28|
|OSFPGA|3096|2126|0|0|28|
|**_generic_fifo_dc_gray_**|**LUT**|**FF**|**DSP**|**BRAM**|**IO**|
|Vivado|87|90|0|0.5|44|
|Quartus prime|112|104|0|0|44|
|Lattice diamond|180|130|0|1|44|
|Anlogic|146|84|0|0|44|
|Gowin|119|88|0|1|44|
|OSFPGA|5888|4210|0|0|44|
|**_generic_fifo_lfsr_**|**LUT**|**FF**|**DSP**|**BRAM**|**IO**|
|Vivado|19|16|0|0|25|
|Quartus prime|14|8|0|0|25|
|Lattice diamond||||||
|Anlogic|26|18|0|0|25|
|Gowin|-|-|-|-|-|
|OSFPGA||||||
|**_generic_fifo_sc_a_**|**LUT**|**FF**|**DSP**|**BRAM**|**IO**|
|Vivado|63|34|0|0.5|31|
|Quartus prime|77|31|0|0|31|
|Lattice diamond|135|57|0|1|31|
|Anlogic|106|43|0|0|31|
|Gowin|105|31|0|1|31|
|OSFPGA|100|48|1|1|31|
|**_generic_fifo_sc_b_**|**LUT**|**FF**|**DSP**|**BRAM**|**IO**|
|Vivado|50|38|0|0.5|31|
|Quartus prime|53|38|0|0|31|
|Lattice diamond|97|43|0|0|31|
|Anlogic|106|60|0|1|31|
|Gowin|58|35|0|1|31|
|OSFPGA|86|52|0|0|31|
|**_ssram_**|**LUT**|**FF**|**DSP**|**BRAM**|**IO**|
|Vivado|31|109|0|0|148|
|Quartus prime|24|115|0|0|148|
|Lattice diamond|42|97|0|0|148|
|Anlogic|35|173|0|0|148|
|Gowin|93|61|0|0|148|
|OSFPGA|-|-|-|-|-|
