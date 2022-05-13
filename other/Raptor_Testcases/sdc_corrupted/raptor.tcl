create_design sasc
architecture /eda_tools/raptor/instl_dir/share/raptor/Arch/gemini.xml /eda_tools/raptor/instl_dir/share/raptor/Arch/gemini_openfpga.xml
bitstream_config_files /eda_tools/raptor/instl_dir/share/raptor/Arch/bitstream_annotation.xml /eda_tools/raptor/instl_dir/share/raptor/Arch/fixed_sim_openfpga.xml /eda_tools/raptor/instl_dir/share/raptor/Arch/repack_design_constraint.xml
add_design_file -V_2001 ./rtl/timescale.v ./rtl/sasc_brg.v ./rtl/sasc_fifo4.v ./rtl/sasc.v
set_top_module sasc
add_constraint_file constraints.sdc
synthesize
packing
