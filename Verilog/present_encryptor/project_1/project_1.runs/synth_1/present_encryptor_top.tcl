# 
# Synthesis run script generated by Vivado
# 

set TIME_start [clock seconds] 
proc create_report { reportName command } {
  set status "."
  append status $reportName ".fail"
  if { [file exists $status] } {
    eval file delete [glob $status]
  }
  send_msg_id runtcl-4 info "Executing : $command"
  set retval [eval catch { $command } msg]
  if { $retval != 0 } {
    set fp [open $status w]
    close $fp
    send_msg_id runtcl-5 warning "$msg"
  }
}
set_param synth.incrementalSynthesisCache ./.Xil/Vivado-57215-khyber/incrSyn
set_msg_config -id {Synth 8-256} -limit 10000
set_msg_config -id {Synth 8-638} -limit 10000
create_project -in_memory -part xc7a100tfgg676-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir /home/users/komal.inayat/Downloads/present_encryptor/project_1/project_1.cache/wt [current_project]
set_property parent.project_path /home/users/komal.inayat/Downloads/present_encryptor/project_1/project_1.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property ip_output_repo /home/users/komal.inayat/Downloads/present_encryptor/project_1/project_1.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_verilog -library xil_defaultlib {
  /home/users/komal.inayat/Downloads/present_encryptor/trunk/rtl/verilog/key_update.v
  /home/users/komal.inayat/Downloads/present_encryptor/trunk/rtl/verilog/permutation.v
  /home/users/komal.inayat/Downloads/present_encryptor/trunk/rtl/verilog/sbox.v
  /home/users/komal.inayat/Downloads/present_encryptor/trunk/rtl/verilog/sub_per.v
  /home/users/komal.inayat/Downloads/present_encryptor/trunk/rtl/verilog/substitution.v
  /home/users/komal.inayat/Downloads/present_encryptor/trunk/rtl/verilog/present_encryptor_top.v
}
# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
set_param ips.enableIPCacheLiteLoad 0
close [open __synthesis_is_running__ w]

synth_design -top present_encryptor_top -part xc7a100tfgg676-1 -directive AreaOptimized_high -control_set_opt_threshold 1


# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef present_encryptor_top.dcp
create_report "synth_1_synth_report_utilization_0" "report_utilization -file present_encryptor_top_utilization_synth.rpt -pb present_encryptor_top_utilization_synth.pb"
file delete __synthesis_is_running__
close [open __synthesis_is_complete__ w]
