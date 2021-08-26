## Directory Structure
    ├── des
    │   ├── rtl
    │   │   └── verilog
    │   │       ├── area_opt
    │   │       └── perf_opt
    │   └── testbench
    │       └── verilog
    ├── sha1
    │   ├── doc
    │   ├── rtl
    │   └── testbench
    ├── sha256
    │   ├── doc
    │   └── rtl
    └── systemCdes
        ├── rtl
        │   ├── systemc
        │   └── verilog
        └── testbench
            ├── systemc
            └── verilog



## Synthesis report of each benchmark on different tools:

|**_des_core(area_opt)_**|**LUT**|**FF**|**DSP**|**BRAM**|**IO**|
|:---:|:---:|:---:|:---:|:---:|:---:|
|Vivado|327|64|0|0|190|
|Quartus prime|390|64|0|0|190|
|Lattice diamond|675|64|0|0|190|
|Anlogic|400|64|0|0|190|
|Gowin|748|64|0|0|190|
|OSFPGA|458|64|0|0|190|
|**_des_core(prf_opt)_**|**LUT**|**FF**|**DSP**|**BRAM**|**IO**|
|Vivado|5512|6008|0|0|298|
|Quartus prime|5410|6604|0|4|298|
|Lattice diamond|10326|7022|0|0|298|
|Anlogic|3828|8808|0|0|298|
|Gowin|-|-|-|-|-|
|OSFPGA|5743|7637|0|0|298|
|**_sha1_**|**LUT**|**FF**|**DSP**|**BRAM**|**IO**|
|Vivado|942|895|0|0|74|
|Quartus prime|711|970|0|0|74|
|Lattice diamond|1537|893|0|0|74|
|Anlogic|1283|930|0|0|74|
|Gowin|1410|893|0|0|74|
|OSFPGA|1594|893|0|0|74|
|**_sha256_**|**LUT**|**FF**|**DSP**|**BRAM**|**IO**|
|Vivado|852|462|0|0.5|30|
|Quartus prime|991|590|0|0|30|
|Lattice diamond|1023|470|0|1|30|
|Anlogic|531|517|0|0|30|
|Gowin|1456|459|0|1|30|
|OSFPGA|1473|513|0|0|30|
|**_systemCdes_**|**LUT**|**FF**|**DSP**|**BRAM**|**IO**|
|Vivado|309|411|0|0|78|
|Quartus prime|248|420|0|0|82|
|Lattice diamond|544|190|0|0|189|
|Anlogic|328|198|0|0|197|
|Gowin|766|411|0|0|82|
|OSFPGA|418|190|0|0|189|
