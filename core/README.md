## Directory Structure

    ├── oc54x
    │   └── rtl
    ├── rs_decoder
    │   ├── doc
    │   ├── rtl
    │   └── testbench
    └── tv80s
        ├── doc
        └── rtl


## Synthesis report of each benchmark on different tools:

|**_oc54x_**|**LUT**|**FF**|**DSP**|**BRAM**|**IO**|
|:---:|:---:|:---:|:---:|:---:|:---:|
|Vivado|2338|432|1|0|140|
|Quartus prime|1915|456|1|0|140|
|Lattice diamond|3044|429|1|0|140|
|Anlogic|2038|439|1|0|140|
|Gowin|3039|424|1|0|140|
|OSFPGA||||||
|**_rs_decoder_**|**LUT**|**FF**|**DSP**|**BRAM**|**IO**|
|Vivado|570|395|0|0|20|
|Quartus prime|350|592|13|0|20|
|Lattice diamond|883|517|13|0|20|
|Anlogic|414|535|13|0|20|
|Gowin|678|517|13|0|20|
|OSFPGA|1143|517|0|0|20|
|**_tv80s_**|**LUT**|**FF**|**DSP**|**BRAM**|**IO**|
|Vivado|1147|230|0|0|46|
|Quartus prime|1371|426|0|0|46|
|Lattice diamond|2252|362|0|3|46|
|Anlogic|976|266|0|0|46|
|Gowin|1500|230|0|0|46|
|OSFPGA|1662|361|0|0|46|
