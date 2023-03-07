proc parseDefine {define_list} {
	foreach single_define $define_list {
		if {[regexp {(\S+)=(\S+)} $single_define -> macro value]} {
			global $macro
			set $macro $value
		}
	}
}

