
foreach cg [find / -cost_group -null_ok *] {
	sh echo "" >> $_REPORTS_PATH/timing_summary${itr}.rpt
	sh echo "Cost Group : $cg" >> $_REPORTS_PATH/timing_summary${itr}.rpt

	if {[regexp {LSU_RDATA} $cg]} {
		sh echo "use slack 0.5 for Cost Group $cg" >> $_REPORTS_PATH/timing_summary${itr}.rpt
		report timing -cost_group $cg -slack 0.5 -num 100 -summary         >> $_REPORTS_PATH/timing_summary${itr}.rpt
		report timing -cost_group $cg -slack 0.5 -num 1000 -full_pin_names >> $_REPORTS_PATH/timing${itr}.rpt
	} else {
		report timing -cost_group $cg -slack 0.2 -num 100 -summary         >> $_REPORTS_PATH/timing_summary${itr}.rpt
		report timing -cost_group $cg -slack 0.2 -num 1000 -full_pin_names >> $_REPORTS_PATH/timing${itr}.rpt
	}
}

