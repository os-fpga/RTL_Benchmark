set project_dir $::env(GOWIN_GEN_LOG_PATH)
set_device GW2A-LV55PG484C7/I6 -name GW2A-55
set_option -synthesis_tool gowinsynthesis
set_option -output_base_name $::env(PROJECT_NAME)
set_option -top_module $::env(DESIGN_TOP)

foreach verilog_header_file [glob -nocomplain -directory "$::env(CGA_ROOT)/../$::env(DESIGN_DIR)" "*.vh"] {
add_file -type verilog $verilog_header_file
}
foreach sverilog_header_file [glob -nocomplain -directory "$::env(CGA_ROOT)/../$::env(DESIGN_DIR)" "*.svh"] {
add_file -type systemverilog $sverilog_header_file
}
foreach verilog_file [glob -nocomplain -directory "$::env(CGA_ROOT)/../$::env(DESIGN_DIR)" "*.v"] {
add_file -type verilog $verilog_file
}
foreach sverilog_file [glob -nocomplain -directory "$::env(CGA_ROOT)/../$::env(DESIGN_DIR)" "*.sv"] {
add_file -type systemverilog $sverilog_file
}

run syn

