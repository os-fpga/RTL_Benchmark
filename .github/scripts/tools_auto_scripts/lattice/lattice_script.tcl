set proj_name "impl"
set run_dir "$::env(LATTICE_GEN_LOG_PATH)/$proj_name/source"

prj_project new -name $::env(PROJECT_NAME) -impl $proj_name -dev $::env(LATTICE_PART) -synthesis "lse"

file mkdir $run_dir
foreach design_file [glob -nocomplain -directory "$::env(CGA_ROOT)/../$::env(DESIGN_DIR)" "*.*v*"] {
  file copy -force -- $design_file $run_dir
}
set file_list {}
foreach vh_file [glob -nocomplain -directory $run_dir "*.vh"] {
  set root_name [file rootname $vh_file]
  file rename -force -- $root_name.vh $root_name.v
  lappend file_list $root_name.v
}
foreach svh_file [glob -nocomplain -directory $run_dir "*.svh"] {
  set root_name [file rootname $svh_file]
  file rename -force -- $root_name.svh $root_name.sv
  lappend file_list $root_name.sv
} 
foreach src_file [glob -nocomplain -directory $run_dir "*.*v"] {
  if { $src_file ni $file_list } {
    lappend file_list $src_file
  }
}
foreach design $file_list {
  prj_src add $design
}
prj_project save

prj_strgy set_value -strategy Strategy1 lse_opt_goal=Balanced
prj_strgy set "Strategy1"

prj_run Synthesis -impl $proj_name;

