# the parseConfig procedure reads system config file
# parse the line with `define at the begining
# and set it as global variable for EDA tcl script to process
# Copyright: Andes Technology 2007
# Author: Jason Peng
#

proc parseConfig {fname} {
	if {[file exists $fname]} {
	    set fd [open $fname r]
	} else {
	    puts "Can't find $fname or perms are bad"
	    exit
	}
	while {![eof $fd]} {
		set data [gets $fd]
		if {[regexp {^[ \t]*`define[ \t]+([a-zA-Z0-9_]+)} $data full macro]} {
			global $macro
			if {"" ne [lindex $data 2]} {
				set $macro [lindex $data 2]
			} else {
				set $macro 1 
			}
			#print config string
			puts "MACRO_DEFINED: [lindex $data 1] [lindex $data 2] "
			#puts [lindex $data 1]
			#puts [expr $[lindex $data 1]]
		} elseif {[regexp {^[ \t]*//[ \t]*`define[ \t]+([a-zA-Z0-9_]+)} $data full macro]} {
			global $macro
			set $macro 0
		}
	}
	catch {close $fd}
	return
}

