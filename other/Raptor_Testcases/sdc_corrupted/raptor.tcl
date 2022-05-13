create_design sasc
architecture /eda_tools/raptor/instl_dir/share/raptor/Arch/gemini.xml
add_design_file -V_2001 ./rtl/timescale.v ./rtl/sasc_brg.v ./rtl/sasc_fifo4.v ./rtl/sasc.v
set_top_module sasc
add_constraint_file constraints.sdc
synthesize
packing
