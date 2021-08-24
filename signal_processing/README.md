## Directory Structure

    ├── blob_merge
    │   └── rtl
    ├── iir
    │   └── rtl
    ├── jpeg_qnr
    │   └── rtl
    ├── stereovision1
    │   └── rtl
    └── stereovision3
        └── rtl


## Synthesis report of each benchmark on different tools:

|**_blob_merge_**|**LUT**|**FF**|**DSP**|**BRAM**|**IO**|
|:---:|:---:|:---:|:---:|:---:|:---:|
|Vivado|5304|575|0|0|136|
|Quartus prime|5436|665|0|0|232|
|Lattice diamond|7798|578|0|0|136|
|Anlogic|6125|685|0|0|232|
|Gowin|6740|552|0|0|232|
|OSFPGA|6161|735|0|0|136|
|**_iir_**|**LUT**|**FF**|**DSP**|**BRAM**|**IO**|
|Vivado|108|444|5|0|38|
|Quartus prime|324|132|4|0|38|
|Lattice diamond|376|122|5|0|38|
|Anlogic|225|332|5|0|38|
|Gowin|125|340|4|0|38|
|OSFPGA|-|-|-|-|-|
|**_jpeg_qnr_**|**LUT**|**FF**|**DSP**|**BRAM**|**IO**|
|Vivado|220|373|0|0|42|
|Quartus prime|299|485|0|0|42|
|Lattice diamond|281|457|0|0|42|
|Anlogic|401|474|0|0|42|
|Gowin|528|399|0|0|42|
|OSFPGA|760|468|0|0|42|
|**_stereovision1_**|**LUT**|**FF**|**DSP**|**BRAM**|**IO**|
|Vivado|13828|11512|0|0|278|
|Quartus prime|2486|8832|76|0|278|
|Lattice diamond|2297|9218|152|0|278|
|Anlogic|1575|3004|152|0|278|
|Gowin|-|-|-|-|-|
|OSFPGA|10706|11775|152|0|278|
|**_stereovision3_**|**LUT**|**FF**|**DSP**|**BRAM**|**IO**|
|Vivado|65|99|0|0|41|
|Quartus prime|92|120|0|0|53|
|Lattice diamond|123|99|0|0|41|
|Anlogic|79|118|0|0|53|
|Gowin|99|118|0|0|53|
|OSFPGA|-|-|-|-|-|
