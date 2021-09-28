set_param general.maxThreads 1
create_project $::env(PROJECT_NAME) $::env(CGA_ROOT)/misc/vivado/$::env(PROJECT_NAME) -part $::env(VIVADO_PART) -force
add_files -norecurse $::env(CGA_ROOT)/../$::env(DESIGN_DIR)

if {[glob -nocomplain -directory "$::env(CGA_ROOT)/../$::env(DESIGN_DIR)" "*.vh"] != ""} {
  set_property is_global_include true [get_files [glob -nocomplain -directory "$::env(CGA_ROOT)/../$::env(DESIGN_DIR)" "*.vh"]] 
}
if {[glob -nocomplain -directory "$::env(CGA_ROOT)/../$::env(DESIGN_DIR)" "*.svh"] != ""} {
  set_property is_global_include true [get_files [glob -nocomplain -directory "$::env(CGA_ROOT)/../$::env(DESIGN_DIR)" "*.svh"]] 
}

set_property SEVERITY {Warning} [get_drc_checks NSTD-1]
set_property SEVERITY {Warning} [get_drc_checks UCIO-1]

launch_runs synth_1 -jobs 8
wait_on_run synth_1

get_property STATUS [get_runs synth_1]








