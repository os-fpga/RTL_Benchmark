report_constraint -all_violators -nosplit > ./rpt/timing_summary${itr}.rpt
report_timing -max_path 1000 -net -cap -nworst 10 > ./rpt/timing${itr}.rpt
