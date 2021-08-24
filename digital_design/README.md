## Directory Structure
    ├── bin2bcd
    │   ├── rtl
    │   └── testbench
    ├── cavlc
    │   ├── rtl
    │   └── testbench
    ├── counter
    │   ├── rtl
    │   └── testbench
    ├── counter120bitx5
    │   └── rtl
    ├── counter_16bit
    │   └── rtl
    ├── shift_reg_8192
    │   └── rtl
    └── simon_bit_serial
        └── rtl


## Synthesis report of each benchmark on different tools:

|**_bin2dec_**|**LUT**|**FF**|**DSP**|**BRAM**|**IO**|
|:---:|:---:|:---:|:---:|:---:|:---:|
|Vivado|10|0|0|0|20|
|Quartus prime|13|0|0|0|20|
|Lattice diamond|34|0|0|0|20|
|Anlogic|10|0|0|0|20|
|Gowin|23|0|0|0|20|
|OSFPGA|13|0|0|0|20|
|**_cavlc_**|**LUT**|**FF**|**DSP**|**BRAM**|**IO**|
|Vivado|702|396|0|0|187|
|Quartus prime|811|427|0|0|187|
|Lattice diamond|1590|391|0|0|187|
|Anlogic|949|571|0|0|187|
|Gowin|1086|391|0|0|187|
|OSFPGA|1445|391|0|0|187|
|**_counter_**|**LUT**|**FF**|**DSP**|**BRAM**|**IO**|
|Vivado|1|8|0|0|10|
|Quartus prime|9|8|0|0|10|
|Lattice diamond|0|5|0|0|10|
|Anlogic|7|16|0|0|10|
|Gowin|7|8|0|0|10|
|OSFPGA|0|5|0|0|10|
|**_counter120bitx5_**|**LUT**|**FF**|**DSP**|**BRAM**|**IO**|
|Vivado|5|605|0|0|76|
|Quartus prime|606|605|0|0|76|
|Lattice diamond|625|605|0|0|76|
|Anlogic|605|675|0|0|76|
|Gowin|600|605|0|0|76|
|OSFPGA|935|605|0|0|76|
|**_counter_16bit_**|**LUT**|**FF**|**DSP**|**BRAM**|**IO**|
|Vivado|1|16|0|0|19|
|Quartus prime|18|32|0|0|19|
|Lattice diamond|1|16|0|0|19|
|Anlogic|0|32|0|0|19|
|Gowin|15|16|0|0|19|
|OSFPGA|22|16|0|0|19|
|**_shift_reg_8192_**|**LUT**|**FF**|**DSP**|**BRAM**|**IO**|
|Vivado|256|2|0|0|3|
|Quartus prime|35|35|0|1|3|
|Lattice diamond|29|14|0|1|3|
|Anlogic|0|8192|0|0|3|
|Gowin|24|13|0|1|3|
|OSFPGA|0|8192|0|0|3|
|**_simon_bit_serial_**|**LUT**|**FF**|**DSP**|**BRAM**|**IO**|
|Vivado|45|27|0|0|5|
|Quartus prime|80|139|0|2|5|
|Lattice diamond|256|61|0|0|5|
|Anlogic|30|281|0|0|5|
|Gowin|199|59|0|0|5|
|OSFPGA|296|281|0|0|5|
