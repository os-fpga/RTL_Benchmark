#!!
#export NDS_HOME=/home/dbakriev/git_ref/gemini/design/acpu_ss/acpu_ss/A45

#### Template Script for the Synthesis Flow
set suppress_errors [list ABS-351 TIM-179 TIM-250]

# Get environment settings.
source -verbose ./core_env_rs.tcl

set NDS_HOME    $env(NDS_HOME)
set PLATFORM        $nds_platform
set nds_core        kv_core

set RTL_PATH        $NDS_HOME/andes_ip/$nds_core
set ACE_RTL_PATH        $RTL_PATH/ace/hdl
set ACE_MEM_PATH        $RTL_PATH/ace/memory/syn

set env(NDS_PLATFORM)   $PLATFORM

#set compile_delete_unloaded_sequential_cells false
#set compile_seqmap_propagate_constants false


#MultiCore Flow
#set_app_var disable_multicore_resource_checks true

#set cpu_info [exec cpuinfo | head -n 1]
#set core_num [lindex $cpu_info 2]
set core_num 5

echo "Number of Cores: $core_num"

if {$core_num > 4} {
    set_host_options -max_cores 4
} else {
    set_host_options -max_cores [expr $core_num - 1]
}

report_host_options

#make dir
foreach dir { work ddc db rpt log netlist } {
        if {![file exists $dir]} {
                file mkdir $dir
        }
}

exec date +Start\ Time:\ %H:%M\ \(%D\)
# When following script has error, use -echo to debug
### Synthesis Environment Setting ###
source -verbose ./syn_setup_dc_rs.tcl 

source -verbose ./script/syn_env.tcl 

source ./script/parseConfig.tcl
parseConfig config.inc

if {![info exists root_design] || ![string equal $root_design "kv_core_top"]} {
        set chip_design ae350_chip
    set root_design ae350_cpu_subsystem
}


set search_path " $search_path $tech_lib_path"


set PLATFORM_BUSDEC     "$NDS_HOME/andes_ip/peripheral_ip/atcbmc301/hdl/include $NDS_HOME/andes_ip/peripheral_ip/atcbusdec301/hdl/include"
set EXTRA_SEARCH_PATH   ""

if {[info exists NDS_RVV_SUPPORT]} {
    if {[string equal $NDS_RVV_SUPPORT "yes"]} {
        set rvv_support 1
    } else {
        set rvv_support 0
    }
} else {
        set rvv_support 0
}

if {[info exists NDS_FP16_SUPPORT]} {
    if {[string equal $NDS_FP16_SUPPORT "yes"]} {
        set fp16_support 1
    } else {
        set fp16_support 0
    }
} else {
        set fp16_support 0
}

if {[info exists NDS_BFLOAT16_SUPPORT]} {
    if {[string equal $NDS_BFLOAT16_SUPPORT "yes"]} {
        set bfloat16_support 1
    } else {
        set bfloat16_support 0
    }
} else {
        set bfloat16_support 0
}

if {$rvv_support} {
        set has_vpu 1
        set EXTRA_SEARCH_PATH "$EXTRA_SEARCH_PATH $RTL_PATH/vpu/hdl"
} else {
        set has_vpu 0
}

if {[info exists NDS_IO_ILM_TL_UL]} {
    set has_ilm_tl_ul 1
} else {
    set has_ilm_tl_ul 0
}

if {[info exists NDS_BIU_ASYNC]} {
    set bus_async 1
} else {
    set bus_async 0
}

# Include path for AE350 should be placed before include paths for
# individual IPs. This ordering rule guarantees that the config file
# specialized for the platform is used instead of the one for individual IP.
set search_path "$search_path ."
set search_path "$search_path $NDS_HOME/andes_ip/${nds_core}/top/hdl"
set search_path "$search_path $NDS_HOME/andes_ip/$PLATFORM/top/hdl/include"
set search_path "$search_path $NDS_HOME/andes_ip/$PLATFORM/define"
set search_path "$search_path $PLATFORM_BUSDEC"
set search_path "$search_path $EXTRA_SEARCH_PATH"

set memory_list  "/cadlib/gemini/TSMC16NMFFC/library/memory/dti/memories/rev_111022/101222_tsmc16ffc_1PR_RAPIDSILICON_GEMINI_rev1p0p1_BE/dti_1pr_tm16ffcll_128x23_4ww2x_m_shc/dti_1pr_tm16ffcll_128x23_4ww2x_m_shc_ssg125c.db \
                   /cadlib/gemini/TSMC16NMFFC/library/memory/dti/memories/rev_111022/101222_tsmc16ffc_1PR_RAPIDSILICON_GEMINI_rev1p0p1_BE/dti_1pr_tm16ffcll_128x56_4ww2x_m_shc/dti_1pr_tm16ffcll_128x56_4ww2x_m_shc_ssg125c.db \
                   /cadlib/gemini/TSMC16NMFFC/library/memory/dti/memories/rev_111022/101222_tsmc16ffc_1PR_RAPIDSILICON_GEMINI_rev1p0p1_BE/dti_1pr_tm16ffcll_1024x32_4ww2x_m_shc/dti_1pr_tm16ffcll_1024x32_4ww2x_m_shc_ssg125c.db \
                   /cadlib/gemini/TSMC16NMFFC/library/memory/dti/memories/rev_131022/101322_tsmc16ffc_SP_RAPIDSILICON_GEMINI_rev1p0p5_BE/dti_sp_tm16ffcll_2048x32_4byw2x_m_shd/dti_sp_tm16ffcll_2048x32_4byw2x_m_shd_ssg125c.db \
                   /cadlib/gemini/TSMC16NMFFC/library/memory/dti/memories/rev_131022/101322_tsmc16ffc_SP_RAPIDSILICON_GEMINI_rev1p0p5_BE/dti_sp_tm16ffcll_8192x32_16byw2x_m_shd/dti_sp_tm16ffcll_8192x32_16byw2x_m_shd_ssg125c.db"

set link_library " * ${tech_lib}.db $memory_list"
set target_library " ${tech_lib}.db"
set symbol_library " ${tech_lib}.sdb"

if {$synthesis_upf} {
    set_app_var enable_golden_upf true
    set_app_var upf_create_implicit_supply_sets true
    if {[file exists ./syn_setup_dc_upf.tcl]} {
        source -verbose ./syn_setup_dc_upf.tcl >> ./log/syn_setup_dc.log
    } else {
        set switch_lib_path ""
        set switch_lib ""
        set iso_lvl_lib ""
    }
    
    if {${switch_lib_path} ne ""} {
        append search_path " ${switch_lib_path}"
    }   
    if {${switch_lib} ne ""} {
        append link_library " ${switch_lib}.db"
        append target_library " ${switch_lib}.db"
    }   
    if {${iso_lvl_lib} ne ""} {
        append link_library " ${iso_lvl_lib}.db"
        append target_library " ${iso_lvl_lib}.db"
    }   
}

if {[info exists dont_use_cells]} {
    set_dont_use $dont_use_cells
}

source ./script/naming_rule.tcl

### Read RTL ###

source -verbose ./script/read_design.tcl

### Apply budget
source -verbose -echo ./script/clock.tcl     
source -verbose -echo ./script/io_delay.tcl  
source -verbose -echo ./script/group_path.tcl
source -verbose -echo ./script/timing_con.tcl

set_timing_derate -cell_delay $synthesis_derate

#uniquify > ./log/uniquify.log

# ----------------------------------------
# Changing names to avoid naming conflicts
# ----------------------------------------
set macro_design [get_designs -quiet {gck* nds* clkmux* sync_l2l* sync_p2p* sync_fifo* async_fifo*}]
if {[llength $macro_design]} {
    rename_design -update_links $macro_design -prefix "${root_design}_"
}

set_max_transition $max_trans $root_design
set_operating_conditions -lib $tech_lib $operating_cond

set_boundary_optimization [all_designs] true
#set_boundary_optimization [get_designs $root_design] false

set_max_area 0
set_wire_load_mode  enclosed

set_fix_multiple_port_net -all -buffer_constants [all_designs]

#set_structure -boolean true
#set compile_new_boolean_structure true

if {![info exists compile_itr]} {
    set compile_itr 10
}

puts "tech_lib = $tech_lib"

if {$synthesis_upf} {
    source -verbose ./script/synthesisUpf.tcl > ./log/synthesisUpf.log
}

if {[string compare "gtech" $tech_lib] == 0} {
    puts "set compile_itr 1"
    set compile_itr 1 
}


#   check_timing > ./rpt/check_timing_pre.rpt
#   check_design > ./rpt/check_design_pre.rpt

set_ideal_network [get_ports *core_reset*]
## Bottom-up optimization for VPU
if {[info exists vpu_bottom_up]} {
    set instance_list [list [get_cells $VPU_MODULE/gen_vp_frontend.frontend] \
                            [get_cells $VPU_MODULE/gen_lane.lane_top0]]

    characterize -constraints $instance_list > ./log/characterize.log

    set design_list [list [get_designs kv_vp_frontend*] \
                          [get_designs kv_lane_top]]

    foreach_in_collection design_unit $design_list {
#       To get Design Name (String) with get_attribute
        set subdesign [get_attribute [get_designs $design_unit] full_name]
        current_design $subdesign
        set_port_fanout 5 [all_outputs]
        puts "Compiling $subdesign"
        puts "Start Compiling (itr 1) $subdesign"
        exec date +Start\ Time:\ %H:%M\ \(%D\) > ./log/compile_${subdesign}.log
        compile_ultra -gate_clock -no_seq_output_inversion -no_autoungroup >> ./log/compile_${subdesign}.log
        report_constraint -all_violators -nosplit > ./rpt/timing_summary_${subdesign}_0.rpt
        report_timing -max_path 50 -net -cap -nworst 3 > ./rpt/timing_${subdesign}_0.rpt

#        puts "Start Compiling (itr 2) $subdesign"
#        compile_ultra -incremental -no_seq_output_inversion -no_autoungroup >> ./log/compile_${subdesign}.log
#        report_constraint -all_violators -nosplit > ./rpt/timing_summary_${subdesign}_1.rpt
#        report_timing -max_path 50 -net -cap -nworst 3 > ./rpt/timing_${subdesign}_1.rpt

        write_sdc  ./netlist/${subdesign}.sdc
        set_dont_touch $subdesign true  >> ./log/compile_${subdesign}.log
        exec date +End\ Time:\ %H:%M\ \(%D\) >> ./log/compile_${subdesign}.log
        puts "Compiling $subdesign done"
    }
}


exit
