#!/bin/bash
set -e
main_path=$PWD
start=`date +%s`
 
 
design="dsp_mul_signed_reg_active_low_async_reset"
ip_name="" #design_level
#select tool (verilator, vcs, ghdl)
tool_name="vcs" 

#stages
only_LiteX=false #design_level
only_Raptor=true #design_level
LiteX_Raptor=false #design_level

#sub-stages
LiteX_sim=false #design_level
ghdl_rtl_sim=false #design_level
[ -z $3 ] && post_synth_sim=true || post_synth_sim=$3 #design_level
post_route_sim=false #design_level
hw_test=false #design_level

#raptor options
device="GEMINI"

strategy="delay" #(area, delay, mixed, none) 

add_constraint_file="" #Sets SDC + location constraints  Constraints: set_pin_loc, set_mode, all SDC Standard commands

verific_parser="" #(on/off)

synthesis_type="" #(Yosys/QL/RS)

custom_synth_script="" #(Uses a custom Yosys templatized script)

synth_options=""
                        #synth_options <option list>: RS-Yosys Plugin Options. The following defaults exist:
                        #                               :   -effort high
                        #                               :   -fsm_encoding binary if optimization == area else onehot
                        #                               :   -carry auto
                        #                               :   -clke_strategy early
                        #       -effort <level>          : Optimization effort level (high, medium, low)
                        #       -fsm_encoding <encoding> : FSM encoding:
                        #       binary                 : Compact encoding - using minimum of registers to cover the N states
                        #       onehot                 : One hot encoding - using N registers for N states
                        #       -carry <mode>            : Carry logic inference mode:
                        #       all                    : Infer as much as possible
                        #       auto                   : Infer carries based on internal heuristics
                        #       none                   : Do not infer carries
                        #       -no_dsp                  : Do not use DSP blocks to implement multipliers and associated logic
                        #       -no_bram                 : Do not use Block RAM to implement memory components
                        #       -fast                    : Perform the fastest synthesis. Don't expect good QoR.
                        #       -no_simplify             : Do not run special simplification algorithms in synthesis. 
                        #       -clke_strategy <strategy>: Clock enable extraction strategy for FFs:
                        #       early                  : Perform early extraction
                        #       late                   : Perform late extraction
                        #       -cec                     : Dump verilog after key phases and use internal equivalence checking (ABC based)

pin_loc_assign_method=""  #pin_loc_assign_method <Method>: Method choices:
                          #      in_define_order(Default), port order pin assignment
                          #      random , random pin assignment
                          #      free , no automatic pin assignment

pnr_options=""  #VPR options
pnr_netlist_lang="" #blif, edif, verilog
set_channel_width="" #int
architecture="" #<vpr_file.xml> ?<openfpga_file.xml>? : Uses the architecture file and optional openfpga arch file (For bitstream generation)
set_device_size="" #XxY Device fabric size selection
bitstream="" #force

################################################################



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
    

    #removing and creating raptor_testcase_files
    #rm -fR $PWD/results_dir
    [ ! -d $PWD/results_dir ] && mkdir $PWD/results_dir
    [ -d $PWD/results_dir ] && cd $PWD/results_dir
    
    echo "ExecStartTime: $start">results.log
    echo "Domain of the design: Unit Level Test">>results.log
    if [ -z $1 ]; then
        echo "RegID: 23">>results.log
    else
        echo "RegID: $1">>results.log
    fi

    if [ -z $2 ]; then
        timeout="90"
        echo "timeout: $timeout">>results.log
    else
        timeout=$2
        echo "timeout: $2">>results.log
    fi

function compile () {

    [ -z "$ip_name" ] && temp=$(cd .. && pwd) || echo ""
    [ -z "$ip_name" ] && echo $temp || echo ""
    #finding the design
    [ -z "$ip_name" ] && echo "Current Design is $design" || echo ""
    [ -z "$ip_name" ] && design_path=`find $temp -type f -iname "$design.v"` || echo ""
    if [ -z "$design_path" ]
    then
        [ -z "$ip_name" ] && echo "No such design $design" || echo ""
        # exit 1
    else 
        [ -z "$ip_name" ] && echo -e "$design Found!" || echo ""
    fi
    command -v raptor >/dev/null 2>&1 || { echo >&2 "Compilation requires Raptor but Raptor not installed."; end_time exit 1; }
#directory path where all the rtl design files are placed    
    [ -z "$ip_name" ] && directory_path=$(dirname $design_path) || echo ""

#creating a tcl file to run raptor flow 
    cd ..
    
    echo "create_design $design">raptor_tcl.tcl 
    echo "target_device $device">>raptor_tcl.tcl 

    ##vary design to design
    [ -z "$ip_name" ] && echo "" || echo "configure_ip $ip_name"_v1_0" -mod_name=$design -Pdata_width=32 -Paddr_width=16 -Pid_width=32 -Pa_pip_out=0 -Pb_pip_out=0 -Pa_interleave=0 -Pb_interleave=0 -out_file ./$design.v">>raptor_tcl.tcl
    [ -z "$ip_name" ] && echo "" || echo "ipgenerate">>raptor_tcl.tcl

    [ -z "$ip_name" ] && echo "" || echo "add_include_path ./rapidsilicon/ip/$ip_name/v1_0/$design/src/">>raptor_tcl.tcl
    [ -z "$ip_name" ] && echo "" || echo "add_library_ext .v .sv">>raptor_tcl.tcl
    [ -z "$ip_name" ] && echo "" || echo "add_library_path rapidsilicon/ip/$ip_name/v1_0/$design/src/">>raptor_tcl.tcl
    [ -z "$ip_name" ] && echo "" || echo "add_design_file ./rapidsilicon/ip/$ip_name/v1_0/$design/src/$design.v">>raptor_tcl.tcl

    [ -z "$ip_name" ] && echo "add_include_path ./rtl">>raptor_tcl.tcl || echo "" 
    [ -z "$ip_name" ] && echo "add_library_path ./rtl">>raptor_tcl.tcl || echo "" 
    [ -z "$ip_name" ] && echo "add_library_ext .v .sv">>raptor_tcl.tcl || echo "" 
    [ -z "$ip_name" ] && echo "add_design_file ./rtl/$design.v">>raptor_tcl.tcl || echo "" 
    ##vary design to design

    echo "set_top_module $design">>raptor_tcl.tcl 

    ##vary design to design
    [ -z "$add_constraint_file" ] && echo "" || echo "add_constraint_file $add_constraint_file">>raptor_tcl.tcl #design_level
    ##vary design to design

    [ -z "$verific_parser" ] && echo "" || echo "verific_parser $verific_parser">>raptor_tcl.tcl
    [ -z "$synthesis_type" ] && echo "" || echo "synthesis_type $synthesis_type">>raptor_tcl.tcl
    [ -z "$custom_synth_script" ] && echo "" || echo "custom_synth_script $custom_synth_script">>raptor_tcl.tcl
    [ -z "$synth_options" ] && echo "" || echo "synth_options $synth_options">>raptor_tcl.tcl
    [ -z "$strategy" ] && echo "" || echo "synthesize $strategy">>raptor_tcl.tcl  
    # [ -z "$pin_loc_assign_method" ] && echo "" || echo "pin_loc_assign_method $pin_loc_assign_method">>raptor_tcl.tcl 
    # [ -z "$pnr_options" ] && echo "" || echo "pnr_options $pnr_options">>raptor_tcl.tcl
    # [ -z "$pnr_netlist_lang" ] && echo "" || echo "pnr_netlist_lang $pnr_netlist_lang">>raptor_tcl.tcl
    # [ -z "$set_channel_width" ] && echo "" || echo "set_channel_width $set_channel_width">>raptor_tcl.tcl 
    # [ -z "$architecture" ] && echo "" || echo "architecture $architecture">>raptor_tcl.tcl 
    # [ -z "$set_device_size" ] && echo "" || echo "set_device_size $set_device_size">>raptor_tcl.tcl 
    # echo "packing">>raptor_tcl.tcl  
    # echo "global_placement">>raptor_tcl.tcl  
    # echo "place">>raptor_tcl.tcl  
    # echo "route">>raptor_tcl.tcl  
    # echo "sta">>raptor_tcl.tcl  
    # echo "power">>raptor_tcl.tcl  
    # echo "bitstream $bitstream">>raptor_tcl.tcl  

cd results_dir
echo "Device: $device">>results.log
echo "Strategy: $strategy">>results.log

timeout+='m'
if [ -d ../rtl ]; then 
rm -fr ../rtl/obj_dir ../rtl/*.vcd ../rtl/*.cpp ../rtl/simv.daidir ../rtl/csrc
[ ! -f ../cksums.md5 ] && find ../rtl -type f -exec md5sum {} + > ../cksums.md5 
find ../rtl -type f -exec md5sum {} + > ../newsum.md5
else
echo ""
fi
#running raptor flow script
if cmp --silent -- "../cksums.md5" "../newsum.md5" && [ -f raptor.log ]; then
   echo "Raptor was already compiled"  
else 
   timeout $timeout raptor --batch --script ../raptor_tcl.tcl 2>&1 | tee raptor.log 
fi 
[ -f ../newsum.md5 ] && cp ../newsum.md5 ../cksums.md5

    if [ ${PIPESTATUS[0]} -eq 124 ]; then
        echo -e "\nERROR: TIM: Design Compilation took $timeout. Exiting due to timeout">>results.log
        exit
    fi


    rm -fR $design/$design\_post\_synth.blif
    rm -fR $design/$design\_post\_synthesis.blif
    
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

    bram_sim=`find $library -wholename "*/rapidsilicon/genesis2/brams_sim.v"`    
    cell_path=`find $library -wholename "*/rapidsilicon/genesis2/cells_sim.v"`
    dsp_sim=`find $library -wholename "*/rapidsilicon/genesis2/dsp_sim.v"`
    dsp_map=`find $library -wholename "*/rapidsilicon/genesis2/dsp_map.v"`
    dsp_final_map=`find $library -wholename "*/rapidsilicon/genesis2/dsp_final_map.v"`
    lut_map=`find $library -wholename "*/rapidsilicon/common/simlib.v"`
    TDP18K_FIFO=`find $library -wholename "*/rapidsilicon/genesis2/TDP18K_FIFO.v"`
    ufifo_ctl=`find $library -wholename "*/rapidsilicon/genesis2/ufifo_ctl.v"`
    sram1024x18=`find $library -wholename "*/rapidsilicon/genesis2/sram1024x18.v"`
    compile_opts=$1    


#renaming netlist module name in post synth netlist
    if [[ $compile_opts == "post_synth_sim" ]]
    then
        string="_post_synth"
        while read line; do
            # for word in $line; do
                if [[ $(echo "$line" | cut -d "(" -f1)  == "module $design" ]]; 
                then
                    sed -i "s/module $design/module $design\_post_synth/" $design/$design\_post\_synth.v
                    break 2
                fi
                if [[ $(echo "$line" | cut -d "(" -f1)  == "module $design$string" ]]; 
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
    #rm -fR $PWD/results_dir/$design\_$tool_name\_files


#reading log file of raptor to see is synthesis failed, if not failed staring the simulation
    while read line; do
            if [[ $line == *"synthesis fail"* ]]
            then
                echo "synthesis failed"
                # exit 
            fi
    done < $PWD/results_dir/raptor.log
           
    echo "Starting $tool_name simulation"

    [ -d $PWD/results_dir ] && cd $PWD/results_dir
    

    if [[ $tool_name == "vcs" ]] && [[ $compile_opts == "post_synth_sim" ]]
    then
        [ ! -d $design\_$tool_name\_post_synth_files ] && mkdir $design\_$tool_name\_post_synth_files
        [ -d $design\_$tool_name\_post_synth_files ] && cd $design\_$tool_name\_post_synth_files
        (cd ../../rtl && timeout 4m vcs -sverilog $cell_path $bram_sim $lut_map $TDP18K_FIFO $ufifo_ctl $sram1024x18 $dsp_sim $design_path ../results_dir/$design/$design\_post\_synth.v $tb_path +incdir+$directory_path -y $directory_path +libext+.v +define+VCS_MODE=1 -full64 -debug_all -lca -kdb && ./simv && mv simv *.vcd *.key *.log verdi_config_file csrc simv.daidir -t ../results_dir/$design\_$tool_name\_post_synth_files) 2>&1 | tee post_synth_sim.log
		while read line; do
                if [[ $line == *"All Comparison Matched"* ]]
                then
                    rm -fr tb.vcd
                fi
                if [[ $line == *"ERROR: SIM: Simulation Failed"* ]]
                then
                    vcd2fst tb.vcd tb.fst --compress
                    rm -fr tb.vcd
                fi
        done < post_synth_sim.log
        cd ..
    fi
    if [[ $tool_name == "vcs" ]] && [[ $compile_opts == "post_route_sim" ]]
    then
        echo "post_route_sim will be added later"
        #timeout 4m  vcs -sverilog $cell_path $bram_sim $lut_map /home/users/abdulhameed.akram/Documents/Compiler_validation_team/accumulator/primitives.v $TDP18K_FIFO $ufifo_ctl $sram1024x18 $design_path ../$design/$design\_post\_synthesis.v $tb_path +incdir+$directory_path -y $directory_path +libext+.v +define+VCS_MODE=1 -full64 -debug_all 2>&1 | tee post_route_sim.log
        # ./simv 2>&1 | tee -a post_route_sim.log
    fi
    if [[ $tool_name == "verilator" ]] && [[ $compile_opts == "post_synth_sim" ]]
    then
        [ ! -d $design\_$tool_name\_post_synth_files ] && mkdir $design\_$tool_name\_post_synth_files
        [ -d $design\_$tool_name\_post_synth_files ] && cd $design\_$tool_name\_post_synth_files
        echo "#include \"obj_dir/Vco_sim_$design.h\"">tb_$design.cpp
        echo "int sc_main(int argc, char** argv){">>tb_$design.cpp
        echo "    Verilated::commandArgs(argc,argv);">>tb_$design.cpp
        echo "    Verilated::traceEverOn(true);">>tb_$design.cpp
        echo "    Vco_sim_$design* top;">>tb_$design.cpp
        echo "    top = new Vco_sim_$design(\"top\");">>tb_$design.cpp
        echo "        while (!Verilated::gotFinish())    {sc_start(1, SC_NS);}">>tb_$design.cpp
        echo "    return 0;">>tb_$design.cpp
        echo "}">>tb_$design.cpp
        mv tb_$design.cpp ../../rtl
        (cd ../../rtl && verilator -Wno-fatal -Wno-BLKANDNBLK -sc -exe $tb_path tb_$design.cpp --timing --timescale 1ps/1ps --trace -v $cell_path -v $bram_sim -v $lut_map -v $TDP18K_FIFO -v $ufifo_ctl -v $dsp_sim -v $sram1024x18 -v $design_path -v ../results_dir/$design/$design\_post\_synth.v -y $directory_path +libext+.v+.sv && make -j -C obj_dir -f Vco_sim_$design.mk Vco_sim_$design && obj_dir/Vco_sim_$design && mv obj_dir *.vcd *.cpp -t ../results_dir/$design\_$tool_name\_post_synth_files) 2>&1 | tee post_synth_sim.log
		while read line; do
                if [[ $line == *"All Comparison Matched"* ]]
                then
                    rm -fr tb.vcd
                fi
                if [[ $line == *"ERROR: SIM: Simulation Failed"* ]]
                then
                    vcd2fst tb.vcd tb.fst --compress
                    rm -fr tb.vcd
                fi
        done < post_synth_sim.log
        cd .. 
    fi
    if [[ $tool_name == ghdl ]] && [[ $compile_opts == ghdl_rtl_sim ]]
    then
        [ ! -d $design\_$tool_name\_post_synth_files ] && mkdir $design\_$tool_name\_post_synth_files
        [ -d $design\_$tool_name\_post_synth_files ] && cd $design\_$tool_name\_post_synth_files
        (cd ../.. && make run) 2>&1 | tee post_synth_sim.log 
        cd ..
    fi
}

function litex_gen(){
    # design=$1
    echo "support not added"
}


function litex_simulate(){
    # design=$1
    echo "support not added"
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
cat raptor.log >> results.log
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
    if [[ $ghdl_rtl_sim == true ]] 
    then
        echo "Only RTL simulation $PWD"
        simulate "ghdl_rtl_sim" 
    fi
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
 
cd $main_path
python3 ../../../parser.py ./results_dir/results.log
