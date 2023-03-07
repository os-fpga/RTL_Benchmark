
foreach cg [find /designs/$DESIGN -cost_group -null_ok *] {
	sh echo "" >> $report_path/timing_summary${itr}.rpt
	sh echo "Cost Group : $cg" >> $report_path/timing_summary${itr}.rpt

	if {[regexp {LSU_RDATA} $cg]} {
		sh echo "use slack 0.5 for Cost Group $cg" >> $report_path/timing_summary${itr}.rpt
		report timing -cost_group $cg -slack 0.5 -num 100 -summary         >> $report_path/timing_summary${itr}.rpt
		report timing -cost_group $cg -slack 0.5 -num 1000 -full_pin_names >> $report_path/timing${itr}.rpt
	} else {
		report timing -cost_group $cg -slack 0.2 -num 100 -summary         >> $report_path/timing_summary${itr}.rpt
		report timing -cost_group $cg -slack 0.2 -num 1000 -full_pin_names >> $report_path/timing${itr}.rpt
	}
}


if {$bus_async} {
	report timing -num 1000 -from [get_clocks BUS_CLK] -to [get_clocks CORE_CLK] -summary >> $report_path/timing_bus_to_core_summary${itr}.rpt
	report timing -num 1000 -from [get_clocks BUS_CLK] -to [get_clocks CORE_CLK] -full_pin_names >> $report_path/timing_bus_to_core${itr}.rpt
	report timing -num 1000 -from [get_clocks CORE_CLK] -to [get_clocks BUS_CLK] -summary >> $report_path/timing_core_to_bus_summary${itr}.rpt
	report timing -num 1000 -from [get_clocks CORE_CLK] -to [get_clocks BUS_CLK] -full_pin_names >> $report_path/timing_core_to_bus${itr}.rpt
}

