#
quit -sim

# def names
quietly set SCR_PATH "../layout/process/project_n1.ip_user_files/sim_scripts/bd/modelsim"
quietly set CPU_FILES [list "microblaze_v9_5_vh_rfs.vhd" "base_microblaze_design_microblaze_0_0.vhd"]
quietly set BD_SCR_FILE "compile.do"
quietly set BD_SIM_FILE "simulate.do"

# cfg-env
quietly set FAST_SIM $::env(FAST_SIM)
quietly set LIB_DEV_NAME $::env(LIB_DEV_NAME)
quietly set LIB_HOSTB_NAME $::env(LIB_HOSTB_NAME)

# ??
proc match_element {llist arg} {
	foreach idx $llist {
		if {$arg == $idx} {
			return 1
		}
	}
	return 0
}


#
# cp+prep compile.do
quietly set infile  [open "$SCR_PATH/$BD_SCR_FILE" r]
quietly set outfile [open $BD_SCR_FILE w]

quietly set lines [split [read $infile] \n]
quietly set skip_list [list]

quietly set cpu_line_cnt 0
foreach line $lines {
	foreach idx $CPU_FILES {
		if {[ expr [regexp $idx $line] == 1]} {
			lappend skip_list [expr $cpu_line_cnt - 1]
			lappend skip_list [expr $cpu_line_cnt - 0]
		}
	}
	incr cpu_line_cnt
}
#puts "skip_list: $skip_list"
quietly set cpu_line_cnt 0
foreach line $lines {
	if {[ expr [regexp "glbl.v" $line] == 1]} {
		incr cpu_line_cnt
		continue
	}
	if {[ expr [regexp "vmap" $line] == 1]} {
		incr cpu_line_cnt
		continue
	}
	if {[match_element $skip_list $cpu_line_cnt] == 1} {
		incr cpu_line_cnt
		continue
	}
	incr cpu_line_cnt

	set sitem0 "../../../ipstatic"
	set ritem0 "../layout/process/project_n1.ip_user_files/ipstatic"

	set sitem1 "../../../../project_n1.srcs"
	set ritem1 "../layout/process/project_n1.srcs"

	regsub -all "vlib work" $line " " line
	regsub -all " msim/" $line " " line
	regsub -all "vcom " $line "vcom -quiet " line
	regsub -all "vlog " $line "vlog -quiet " line

	regsub -all $sitem0 $line $ritem0 line
	regsub -all $sitem1 $line $ritem1 line

	puts $outfile $line
}
close $infile
close $outfile

# get LIB-list
quietly set infile  [open "$SCR_PATH/$BD_SIM_FILE" r]

quietly set lines [split [read $infile] \n]
foreach line $lines {
	if {[ expr [regexp "vsim" $line] != 1]} {
		continue
	}
	set sta_pos [string first "-L" $line]
	set stp_pos [string first " " $line [expr [string last "-L" $line] + 3]]
	set lib_list [string range $line $sta_pos $stp_pos]
	
}
close $infile
# cut-out secureip-lib
quietly regsub -all " -L secureip " $lib_list " " lib_list
#puts "lib_list: $lib_list"

# bd-files
foreach idx [glob -type f -nocomplain "${SCR_PATH}/*.mem"] {
	file copy -force $idx ./
}
source $BD_SCR_FILE
vlog -quiet -work xil_defaultlib $SCR_PATH/glbl.v 


# user-src
vlog -quiet -work xil_defaultlib -sv -f vlog_synth.f
vlog -quiet -work xil_defaultlib +incdir+../src/tb/bfm_eth_log -sv -f vlog_sim.f

# sim
if { $FAST_SIM == 1 } {
 eval "vsim -sv_lib $LIB_DEV_NAME -sv_lib $LIB_HOSTB_NAME -quiet  -t ps $lib_list xil_defaultlib.testcase xil_defaultlib.glbl"
} else {
 eval "vsim -sv_lib $LIB_DEV_NAME -sv_lib $LIB_HOSTB_NAME -novopt -t ps $lib_list xil_defaultlib.testcase xil_defaultlib.glbl"

 log -r /*
 do wave.do
}
quietly set StdArithNoWarnings 1
quietly set NumericStdNoWarnings 1

run -all
