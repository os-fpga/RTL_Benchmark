

set design_list [all_designs]
report_area > ./rpt/area${itr}.rpt
foreach_in_collection design_name [all_designs] {
    switch -regexp -- [get_object_name $design_name] {
	^gck.+ {
        }
	^sync_.+ {
        }
	^nds_dffsr.+ {
        }
	.+DP_OP.+ {
        }
	default {
            current_design $design_name
            report_area >> ./rpt/area${itr}.rpt
        }
    }
}


current_design $root_design
