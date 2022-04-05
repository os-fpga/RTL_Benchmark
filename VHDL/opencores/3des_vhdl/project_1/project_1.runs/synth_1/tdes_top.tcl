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
create_project -in_memory -part xc7a100tfgg676-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir /home/users/komal.inayat/Downloads/3des_vhdl/project_1/project_1.cache/wt [current_project]
set_property parent.project_path /home/users/komal.inayat/Downloads/3des_vhdl/project_1/project_1.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property ip_output_repo /home/users/komal.inayat/Downloads/3des_vhdl/project_1/project_1.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_vhdl -library xil_defaultlib {
  /home/users/komal.inayat/Downloads/3des_vhdl/trunk/VHDL/add_key.vhd
  /home/users/komal.inayat/Downloads/3des_vhdl/trunk/VHDL/add_left.vhd
  /home/users/komal.inayat/Downloads/3des_vhdl/trunk/VHDL/block_top.vhd
  /home/users/komal.inayat/Downloads/3des_vhdl/trunk/VHDL/des_cipher_top.vhd
  /home/users/komal.inayat/Downloads/3des_vhdl/trunk/VHDL/des_top.vhd
  /home/users/komal.inayat/Downloads/3des_vhdl/trunk/VHDL/e_expansion_function.vhd
  /home/users/komal.inayat/Downloads/3des_vhdl/trunk/VHDL/key_schedule.vhd
  /home/users/komal.inayat/Downloads/3des_vhdl/trunk/VHDL/p_box.vhd
  /home/users/komal.inayat/Downloads/3des_vhdl/trunk/VHDL/s1_box.vhd
  /home/users/komal.inayat/Downloads/3des_vhdl/trunk/VHDL/s2_box.vhd
  /home/users/komal.inayat/Downloads/3des_vhdl/trunk/VHDL/s3_box.vhd
  /home/users/komal.inayat/Downloads/3des_vhdl/trunk/VHDL/s4_box.vhd
  /home/users/komal.inayat/Downloads/3des_vhdl/trunk/VHDL/s5_box.vhd
  /home/users/komal.inayat/Downloads/3des_vhdl/trunk/VHDL/s6_box.vhd
  /home/users/komal.inayat/Downloads/3des_vhdl/trunk/VHDL/s7_box.vhd
  /home/users/komal.inayat/Downloads/3des_vhdl/trunk/VHDL/s8_box.vhd
  /home/users/komal.inayat/Downloads/3des_vhdl/trunk/VHDL/s_box.vhd
  /home/users/komal.inayat/Downloads/3des_vhdl/trunk/VHDL/tdes_top.vhd
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

synth_design -top tdes_top -part xc7a100tfgg676-1 -directive AreaOptimized_high -control_set_opt_threshold 1


# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef tdes_top.dcp
create_report "synth_1_synth_report_utilization_0" "report_utilization -file tdes_top_utilization_synth.rpt -pb tdes_top_utilization_synth.pb"
file delete __synthesis_is_running__
close [open __synthesis_is_complete__ w]
