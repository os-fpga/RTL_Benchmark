proc report_worst_slack {} {
    report_timing -delay max -max_path 1 -net -cap -nosplit > ./rpt/temp_timing.rpt
    set min_slack 0
    set infile [open "./rpt/temp_timing.rpt" r]
    
    while {[gets $infile line] >= 0} {
	if [regexp {slack.*VIOLATED.*(-[\d]+.[\d]+)} $line match temp_slack] {
	    if {$temp_slack < $min_slack} {
		set min_slack $temp_slack
	    }
	}
    }
    
    close $infile

    file delete -force "./rpt/temp_timing.rpt"

    return $min_slack
}
