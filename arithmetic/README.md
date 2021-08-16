## Directory Structure


    ├── DCT
    │   └── rtl
    ├── LU8PEEng
    │   └── rtl
    ├── cordic_core
    │   ├── doc
    │   └── rtl
    │       ├── polar2rect
    │       └── rect2polar
    ├── diffeq1
    │   └── rtl
    ├── diffeq2
    │   └── rtl
    ├── fast_fourier_transform
    │   └── rtl
    ├── fpu
    │   ├── doc
    │   ├── rtl
    │   └── testbench
    ├── hardware_divider
    │   ├── rtl
    │   └── testbench
    ├── pipelined_dct
    │   ├── doc
    │   ├── rtl
    │   └── testbench
    └── unsigned_mult_80
        └── rtl

## Synthesis report of each benchmark on different tools:

|_Fast Fourier Transform_|LUT|FF|DSP|BRAM|IO|
|:---:|:---:|:---:|:---:|:---:|:---:|
|Vivado|2656|2556|0|1|69|
|Quartus prime|1161|2448|32|0|69|
|Lattice diamond|1376|2568|30|3|69|
|Anlogic|1524|2404|28|0|69|
|Gowin|1594|1967|30|2|69|
|**_CORDIC (polar2rect)_**|**LUT**|**FF**|**DSP**|**BRAM**|**IO**|
|Vivado|705|689|0|0|50|
|Quartus prime|339|669|0|0|50|
|Lattice diamond|787|701|0|0|50|
|Anlogic|1330|690|0|0|50|
|Gowin|700|695|0|0|50|
|**_CORDIC (rect2polar)_**|**LUT**|**FF**|**DSP**|**BRAM**|**IO**|
|Vivado|949|1001|0|0|74|
|Quartus prime|555|1050|0|0|74|
|Lattice diamond|1203|1009|0|0|74|
|Anlogic|1893|1059|0|0|74|
|Gowin|1255|1032|0|0|74|
|**_DCT_**|**LUT**|**FF**|**DSP**|**BRAM**|**IO**|
|Vivado|456|872|64|30.5|24|
|Quartus prime|1865|2857|64|0|25|
|Lattice diamond|-|-|-|-|-|
|Anlogic|3124|3542|124|0|25|
|Gowin|-|-|-|-|-|
|**_diffeq1_**|**LUT**|**FF**|**DSP**|**BRAM**|**IO**|
|Vivado|397|194|9|0|258|
|Quartus prime|277|226|6|0|258|
|Lattice diamond|272|193|16|0|258|
|Anlogic|136|193|13|0|258|
|Gowin|320|193|3|0|258|
|**_diffeq2_**|**LUT**|**FF**|**DSP**|**BRAM**|**IO**|
|Vivado|231|96|9|0|162|
|Quartus prime|314|117|6|0|162|
|Lattice diamond|364|96|16|0|162|
|Anlogic|64|192|13|0|162|
|Gowin|221|96|3|0|162|
|**_FPU_**|**LUT**|**FF**|**DSP**|**BRAM**|**IO**|
|Vivado|4255|580|2|0|110|
|Quartus prime|6400|622|1|0|110|
|Lattice diamond|10530|546|4|0|110|
|Anlogic|7090|547|3|0|110|
|Gowin|-|-|-|-|-|
|**_Hardware Divider_**|**LUT**|**FF**|**DSP**|**BRAM**|**IO**|
|Vivado|786|351|0|0|132|
|Quartus prime|730|373|0|0|132|
|Lattice diamond|1308|351|0|0|132|
|Anlogic|619|357|0|0|132|
|Gowin|1248|351|0|0|132|
|**_LU8PEEng_**|**LUT**|**FF**|**DSP**|**BRAM**|**IO**|
|Vivado|15136|4345|16|27.5|216|
|Quartus prime|19230|10669|8|38|216|
|Lattice diamond|35221|13942|32|33|216|
|Anlogic|12537|6276|16|49|216|
|Gowin|21484|4680|8|56|216|
|**_DCT_pipelined_**|**LUT**|**FF**|**DSP**|**BRAM**|**IO**|
|Vivado|659|550|4|0|25|
|Quartus prime|1347|3322|4|0|25|
|Lattice diamond|2289|2925|4|2|25|
|Anlogic|1644|2974|4|0|25|
|Gowin|2293|2914|4|2|25|
|**_Unsigned Mult_**|**LUT**|**FF**|**DSP**|**BRAM**|**IO**|
|Vivado|110|0|5|0|123|
|Quartus prime|48|0|4|0|123|
|Lattice diamond|160|0|13|0|123|
|Anlogic|53|0|5|0|123|
|Gowin|40|0|6|0|123|
