foreach verilog_header_file [glob -nocomplain -directory "$::env(CGA_ROOT)/../$::env(DESIGN_DIR)" "*.vh"] {
yosys read_verilog $verilog_header_file
}
foreach sverilog_header_file [glob -nocomplain -directory "$::env(CGA_ROOT)/../$::env(DESIGN_DIR)" "*.svh"] {
yosys read_verilog $sverilog_header_file
}
foreach verilog_file [glob -nocomplain -directory "$::env(CGA_ROOT)/../$::env(DESIGN_DIR)" "*.v"] {
yosys read_verilog $verilog_file
puts "$::env(CGA_ROOT)/../$::env(DESIGN_DIR)"
puts $verilog_file
}
foreach sverilog_file [glob -nocomplain -directory "$::env(CGA_ROOT)/../$::env(DESIGN_DIR)" "*.sv"] {
yosys read_verilog $sverilog_file
}

yosys synth_quicklogic -top $::env(DESIGN_TOP) -family pp3
