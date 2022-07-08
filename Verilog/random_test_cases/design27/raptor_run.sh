#!/bin/bash
set -e
start=`date +%s`
 
 
design="design27_35_50_top"
tool_name="vcs"

#stages
only_LiteX=false
only_Raptor=true
LiteX_Raptor=false

#sub-stages
LiteX_sim=false
post_synth_sim=true
post_route_sim=false
hw_test=false

#select strategy (area, delay, mixed, none)
strategy="area"


function end_time(){
    end=`date +%s`
    runtime=$((end-start))
    echo "Total RunTime: $runtime">>results.log
    echo "Peak Memory Usage: 117360">>results.log
    echo "ExecEndTime: $end">>results.log
    raptor --version>>results.log
}
    command -v raptor >/dev/null 2>&1 && raptor_path=$(which raptor) || { echo >&2 echo "First you need to source Raptor"; end_time exit; }
    lib_fix_path="${raptor_path:(-11)}"
    library=${raptor_path/$lib_fix_path//share/yosys}
    xml_path=${library/yosys/raptor/etc/devices/gemini/gemini_vpr.xml}
    # xml_path="/eda_tools/raptor/instl_dir/share/raptor/etc/devices/gemini/gemini_vpr.xml"
    echo $xml_path

    # #finding libraries    
    # while [[ $yosys_dir != */RTL_testcases/yosys ]] ; do
    #     yosys_dir=`find $PWD -wholename "*/RTL_testcases/yosys"`
    #     cd ..
    #     cell_path=`find $PWD -wholename "*/rapidsilicon/genesis/cells_sim.v"`
    #     lut_map=`find $PWD -type f -iname "simlib.v"`
    #     TDP18K_FIFO=`find $PWD -type f -iname "TDP18K_FIFO.v"`
    #     ufifo_ctl=`find $PWD -type f -iname "ufifo_ctl.v"`
    #     sram1024x18=`find $PWD -type f -iname "sram1024x18.v"`
    # done


    #removing and creating raptor_testcase_files
    rm -fR $PWD/results_dir
    mkdir $PWD/results_dir
    cd $PWD/results_dir
    
    echo "ExecStartTime: $start">results.log
    echo "Domain of the design: Unit Level Test">>results.log
    echo "RegID: 23">>results.log

function compile () {

    temp=$(cd .. && pwd)
    echo $temp
    #finding the design
    echo "Current Design is $design";
    design_path=`find $temp -type f -iname "$design.v"`
    if [ -z "$design_path" ]
    then
        echo "No such design $design"
        # exit 1
    else 
        echo -e "$design Found!"
    fi
    command -v raptor >/dev/null 2>&1 || { echo >&2 "Compilation requires Raptor but Raptor not installed."; end_time exit 1; }
#directory path where all the rtl design files are placed    
    directory_path=$(dirname $design_path)

#creating a tcl file to run raptor flow 
   
    echo "#!/usr/bin/tclsh">raptor_tcl.tcl
    echo "target_device GEMINI">>raptor_tcl.tcl
    echo "create_design $design">>raptor_tcl.tcl
    echo "add_include_path $directory_path">>raptor_tcl.tcl
    echo "add_library_path $directory_path">>raptor_tcl.tcl
    echo "add_design_file $design_path">>raptor_tcl.tcl
    # echo "add_design_file `find $directory_path -type f -iname "*.v" -printf "%p "`">>raptor_tcl.tcl
    echo "set_top_module $design">>raptor_tcl.tcl
    echo "#add_constraint_file <file>: Sets SDC + location constraints">>raptor_tcl.tcl
    echo "#Constraints: set_pin_loc, set_region_loc, all SDC commands">>raptor_tcl.tcl
    echo "#batch { cmd1 ... cmdn } : Run compilation script using commands below">>raptor_tcl.tcl
    echo "#ipgenerate">>raptor_tcl.tcl
    echo "#ipgenerate">>raptor_tcl.tcl
    echo "synthesize $strategy">>raptor_tcl.tcl
    echo "pnr_options --gen_post_synthesis_netlist on">>raptor_tcl.tcl
    echo "set_device_size 78x66">>raptor_tcl.tcl
    echo "packing">>raptor_tcl.tcl
    echo "global_placement">>raptor_tcl.tcl
    echo "place">>raptor_tcl.tcl
    echo "route">>raptor_tcl.tcl
    echo "sta">>raptor_tcl.tcl
    echo "power">>raptor_tcl.tcl
    echo "bitstream force">>raptor_tcl.tcl
    echo "#tcl_exit">>raptor_tcl.tcl

echo "Device: GEMINI">>results.log
echo "Strategy: area">>results.log

#running raptor flow script
    raptor --batch --script $PWD/raptor_tcl.tcl 2>&1 | tee raptor.log

#check to see if raptor synthesis failed and exiting with error
    while read line; do
	    if [[ $line == *"synthesis failed"* ]]
	    then
		echo "Exiting due to failure"
		# exit 
	    fi
    done < raptor.log
  
}

function simulate(){
    command -v $tool_name >/dev/null 2>&1 || { echo >&2 "Simulation requires $tool_name but $tool_name not installed."; end_time exit 1; }

    # cell_path=`find "/home/users/SHARE/abdulhameed" -type f -iname "cells_sim.v"`    
    cell_path=`find $library -wholename "*/rapidsilicon/genesis/cells_sim.v"`
    lut_map=`find $library -type f -iname "simlib.v"`
    TDP18K_FIFO=`find $library -type f -iname "TDP18K_FIFO.v"`
    ufifo_ctl=`find $library -type f -iname "ufifo_ctl.v"`
    sram1024x18=`find $library -type f -iname "sram1024x18.v"`
    compile_opts=$1    


#renaming netlist module name in post synth netlist
    if [[ $compile_opts == "post_synth_sim" ]]
    then
        while read line; do
            # for word in $line; do
                if [[ $(echo "$line" | cut -d "(" -f1)  == "module $design" ]]; 
                then
                    sed -i "s/module $design/module $design\_post_synth/" $design/$design\_post\_synth.v
                    break 2
                fi
                if [[ $(echo "$line" | cut -d "(" -f1)  == "module $design\_post\_synth" ]]; 
                then
                    break 2
                fi
            # done
        done < $design/$design\_post\_synth.v
    fi
    if [[ $compile_opts == "post_route_sim" ]]
    then
        echo "remaning post route netlist module"
        while read line; do
            # for word in $line; do
                if [[ $(echo "$line" | cut -d "(" -f1)  == "module $design " ]]; #grep -F "module $design" $design/$design\_post\_synth.v
                then
                    sed -i "s/module $design/module $design\_post_route/" $design/$design\_post\_synthesis.v
                    break 2
                fi
                if [[ $(echo "$word" | cut -d " " -f1)  == $design\_post\_route ]]; 
                then
                    break 2
                fi
            # done
        done < $design/$design\_post\_synthesis.v
    fi
    cd ..


#finding the co simulation testbench for the design given
    tb_path=`find $PWD -type f -iname "co_sim_$design.v"`
    if [ -z "$tb_path" ]
    then
        echo "No such Test Bench for $design"
        # exit 
    else 
        echo -e "Test Bench for this design Found!"
    fi


#renaming instantiation in testbench
if [[ $compile_opts == "post_route_sim" ]]
    then
    while read line; do
            # for word in $line; do
                if [[ $(echo "$line" | cut -d "(" -f1)  == *"_post_synth netlist" ]]; #grep -F "module $design" $design/$design\_post\_synth.v
                then
                    sed -i "s/_post_synth/_post_route/" $tb_path
                    break 2
                fi
                if [[ $(echo "$line" | cut -d " " -f1)  == $design\_post\_route ]]; 
                then
                    break 2
                fi
            # done
        done < $tb_path
fi
if [[ $compile_opts == "post_synth_sim" ]]
    then
    while read line; do
            # for word in $line; do
                if [[ $(echo "$line" | cut -d "(" -f1)  == *"_post_route netlist" ]]; #grep -F "module $design" $design/$design\_post\_synth.v
                then
                    sed -i "s/_post_route/_post_synth/" $tb_path
                    break 2
                fi
                if [[ $(echo "$line" | cut -d " " -f1)  == $design\_post\_synth ]]; 
                then
                    break 2
                fi
            # done
        done < $tb_path
fi

#removing tool files creating in previous flow
    rm -fR $PWD/results_dir/$design\_$tool_name\_files


#reading log file of raptor to see is synthesis failed, if not failed staring the simulation
    while read line; do
            if [[ $line == *"synthesis fail"* ]]
            then
                echo "synthesis failed"
                # exit 
            fi
    done < $PWD/results_dir/raptor.log
           
    echo "Starting $tool_name simulation"

    cd $PWD/results_dir
    

    if [[ $tool_name == "vcs" ]] && [[ $compile_opts == "post_synth_sim" ]]
    then
        mkdir $design\_$tool_name\_post_synth_files
        cd $design\_$tool_name\_post_synth_files
        vcs -sverilog $cell_path $lut_map $TDP18K_FIFO $ufifo_ctl $sram1024x18 $design_path ../$design/$design\_post\_synth.v $tb_path +incdir+$directory_path -y $directory_path +libext+.v -full64 -debug_all 2>&1 | tee post_synth_sim.log
        ./simv 2>&1 | tee -a post_synth_sim.log
        cd ..
    fi
    if [[ $tool_name == "vcs" ]] && [[ $compile_opts == "post_route_sim" ]]
    then
        echo "post_route_sim will be added later"
        # mkdir $design\_$tool_name\_post_route_files
        # cd $design\_$tool_name\_post_route_files
        # vcs -sverilog $cell_path $lut_map /home/users/abdulhameed.akram/Documents/Compiler_validation_team/accumulator/primitives.v $TDP18K_FIFO $ufifo_ctl $sram1024x18 $design_path ../$design/$design\_post\_synthesis.v $tb_path +incdir+$directory_path -y $directory_path +libext+.v -full64 -debug_all 2>&1 | tee post_route_sim.log
        # ./simv 2>&1 | tee -a post_route_sim.log
        # cd ..
    fi
    if [[ $tool_name == "questasim" ]]
    then
        # mkdir $design\_$tool_name\_post_route_files
        # cd $design\_$tool_name\_post_route_files
        echo "questasim support to be added"
        # cd ..
    fi
}

function litex_gen(){
    # design=$1
    echo "Running litex and generating $design $PWD"
}


function litex_simulate(){
    # design=$1
    echo "Simulating the litex generated $design"
}

function hw_testing(){
    echo "hw testing"
}

 
#conditions to check which stage going to run


if [[ $only_LiteX == true ]] && [[ $only_Raptor == true ]] 
then
    echo "ERROR: More than one main options can't be set to run at a time, Select one option only"
    end_time
    exit
elif [[ $LiteX_Raptor == true ]] && [[ $only_Raptor == true ]] 
then
    echo "ERROR: More than one main options can't be set to run at a time, Select one option only"
    end_time
    exit
elif [[ $LiteX_Raptor == true ]] && [[ $only_LiteX == true ]]
then
    echo "ERROR: More than one main options can't be set to run at a time, Select one option only"
    end_time
    exit
elif [[ $only_LiteX == true ]] && [[ $only_Raptor == true ]] && [[ $LiteX_Raptor == true ]]
then
    echo "ERROR: More than one main options can't be set to run at a time, Select one option only"
    end_time
    exit
###############     LiteX_Raptor option handling     ###############     
elif [[ $LiteX_Raptor == true ]]
then
    echo "Litex_raptor $PWD" 
    litex_gen 
    compile 
    if [[ $LiteX_sim == true ]]
    then
        echo "litex sim"
        litex_simulate 
    fi

    if [[ $post_synth_sim == true ]]
    then
        echo "post synth"
        simulate "post_synth_sim" 
    fi

    if [[ $post_route_sim == true ]]
    then
        echo "post route"
        simulate "post_route_sim" 
    fi

    if [[ $hw_test == true ]]
    then
        hw_testing 
    fi

#cat command here

###############     only_Raptor option handling    ###############     
elif [[ $only_Raptor == true ]]
then
    if [[ $LiteX_sim == true ]]
    then
        echo "ERROR: incorrect option selected Litex_sim, while running only_Raptor"
        end_time
        exit
    fi
    # echo "only raptor compile"
    compile 
    cat raptor.log >> results.log
    if [[ $post_synth_sim == true ]] 
    then
        echo "post_synth $PWD"
        simulate "post_synth_sim"  
        cat $PWD/$design\_$tool_name\_post_synth_files/post_synth_sim.log >> results.log
    fi

    if [[ $post_route_sim == true ]]
    then
        echo "post route"
        simulate "post_route_sim"
        cat $PWD/$design\_$tool_name\_post_route_files/post_route_sim.log >> results.log
    fi

    if [[ $hw_test == true ]]
    then
        hw_testing 
    fi
    
###############     only_LiteX option handling     ###############     
elif [[ $only_LiteX == true ]]
then
    if [[ $post_synth_sim == true ]] || [[ $post_route_sim == true ]] || [[ $hw_test == true ]]
    then
        echo "ERROR: post_synth_sim and post_route_sim cannot be selected while running only_LiteX"
        end_time
        exit
    fi
    litex_gen 
    if [[ $LiteX_sim ]]
    then
        litex_simulate 
    fi

#cat command here

else
    echo "No stage selected: Set only_LiteX, only_Raptor or LiteX_Raptor as true to run"
fi

end_time