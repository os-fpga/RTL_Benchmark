


report area -depth 3 > $report_path/area${itr}.rpt
report gates >> $report_path/area${itr}.rpt

if {$has_vpu} {
	foreach module [find /designs/$DESIGN -instance *kv_vpu] {
		if {$tool_name == "rc"} {
			report area -depth 3 -instance_hierarchy $module >> $report_path/area${itr}.rpt
		} else {
			report area -depth 3 -hinst $module >> $report_path/area${itr}.rpt
		}
	}
}
foreach module [find  /designs/$DESIGN -instance *] {
	switch -regexp -- $module {
		.+instances_seq.+ {
		}
		.+instances_comb.+ {
		}
		.+dff.+ {
		}
		.+RC_CG_HIER.+ {
		}
		.+gck.+ {
		}
		default {
			report gates -instance_hier $module >> $report_path/area${itr}.rpt
		}
	}
}
