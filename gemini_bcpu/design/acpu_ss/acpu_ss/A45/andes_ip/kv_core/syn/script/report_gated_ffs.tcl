
set_app_var power_cg_auto_identify true

report_clock_gating > ./rpt/clockgating.rpt
	
#set outfile [open "./rpt/ff_statistic.rpt" w]
#
#set total_ffs [sizeof_collection [filter [get_cells * -h] {@ff_edge_sense==1}]]
#
#puts $outfile "Total FFs : $total_ffs"
#
#puts $outfile "\n"
#puts $outfile "***************\n"
#puts $outfile "**Timing Path**\n"
#puts $outfile "***************\n"
#
#set gck_list [get_object_name [filter [get_cells * -h] {@name==gck}]]
#
#foreach gc $gck_list {
#	report_timing -from $gc/$gck_autogen_out_pin -max_path 9000 >> ./rpt/ff_statistic.rpt
#}
#
#close $outfile
#
#if {[file exists ./rpt/ff_statistic.rpt]} {
#    set infile [open "./rpt/ff_statistic.rpt" r]
#
#    if {[gets $infile line] >= 0} {
#	if [regexp {Total FFs : ([\d]+)} $line match total_ffs] {
#	    puts $line
#	} else {
#	    puts "Cannot get total ffs from ./rpt/ff_statistic.rpt"
#	}
#    }
#    close $infile
#
#    if { [catch {set gated_ffs [exec fgrep Endpoint ./rpt/ff_statistic.rpt | sort -u | wc -l]}] } {
#	    set gated_ffs 0
#    }
#    
#    file delete -force "./rpt/ff_statistic.rpt"
#
#    set outfile [open "./rpt/clockgating.rpt" w]
#    set clockgating_ratio [expr 100.00 * $gated_ffs / $total_ffs]
#
#    puts $outfile $line
#    puts $outfile [format "Total gated_FFs : %d (%.2f%%)" $gated_ffs $clockgating_ratio]
#    close $outfile
#} else {
#    puts "The ./rpt/ff_statistic.rpt doesn't exist"
#}
