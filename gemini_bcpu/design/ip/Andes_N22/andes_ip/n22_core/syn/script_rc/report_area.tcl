


report area -depth 3 > $_REPORTS_PATH/area${itr}.rpt
report gates >> $_REPORTS_PATH/area${itr}.rpt

foreach module [find / -instance *] {
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
			report gates -instance_hier $module >> $_REPORTS_PATH/area${itr}.rpt
		}
	}
}
