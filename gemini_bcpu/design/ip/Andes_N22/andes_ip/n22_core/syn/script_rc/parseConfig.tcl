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
		switch -regexp -- $data {
			^`define {
				global [lindex $data 1]
				set [lindex $data 1] [lindex $data 2]
			}
			^//`define {
				global [lindex $data 1]
				set [lindex $data 1] 0
			}
			default {}
		}
	}
	catch {close $fd}
	return
}


