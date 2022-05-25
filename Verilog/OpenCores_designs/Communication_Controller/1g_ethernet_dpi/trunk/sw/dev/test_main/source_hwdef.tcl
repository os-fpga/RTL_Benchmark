open_project ../../../../hw/layout/process/project_n1.xpr
update_compile_order -fileset sources_1
generate_target all [get_files  ../../../../hw/layout/process/project_n1.srcs/sources_1/bd/bd/base_microblaze_design.bd]
write_hwdef -force  -file ./base_microblaze_design_wrapper.hdf 
close_project