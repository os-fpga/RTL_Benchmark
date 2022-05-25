
open_project ./project_n1.xpr

config_webtalk -user off

update_compile_order -fileset sources_1
update_compile_order -fileset sim_1

launch_runs impl_1 -to_step write_bitstream
wait_on_run impl_1

#open_run impl_1

close_project
