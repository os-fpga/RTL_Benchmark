#!/usr/bin/tclsh

# User-specified code here.
set code "524953432d5640416e64657354656368"


# DO NOT modify the following code.
# DO NOT modify the following code.
# DO NOT modify the following code.
set where  [file dirname    [info script]]
set script [file rootname [file tail [info script]]]
set code_format "hex"
set code_length 128
set code_unit 8

# main 
#code_format "format" $code_format
switch $code_format {
	"string"	{set code_format "str"}
	"str"		{set code_format "str"}
	"s"		{set code_format "str"}
	"hex"		{set code_format "hex"}
	"h"		{set code_format "hex"}
	"x"		{set code_format "hex"}
	"binary"	{set code_format "bin"}
	"bin"		{set code_format "bin"}
	"b"		{set code_format "bin"}
	default { 
			puts "#ERROR:\t$code_format is not a valid format"
			exit
		}
}

#code_unit   "unit"   $code_unit
if {[string is integer $code_unit] ne 1} {
	puts "#ERROR:\t$code_unit is not a valid unit"
	exit
} else {
	if {$code_unit <= 0} {
		puts "#ERROR:\t$code_unit is not a valid unit"
		exit
	}
}

#code_length "length" $code_length
if {[string is integer $code_length] ne 1} {
		puts "#ERROR:\t$code_length is not a valid length"
		exit
} else {
	if {[expr $code_length % $code_unit] ne 0} {
		puts "#ERROR:\t$code_length is not a valid length"
		exit
	}
}

#code        "code"   $code
switch $code_format {
	str {
		# do nothing
	}
	hex {
		if {[regexp -nocase ^(\[0-9a-f_\]+)$ $code match(full) match(sub1)]} {
			set code $code
		} elseif {[regexp -nocase ^0x(\[0-9a-f_\]+)$ $code match(full) match(sub1)]} {
			set code $match(sub1)
		} elseif {[regexp -nocase ^\[0-9\]+'h(\[0-9a-f_\]+)$ $code match(full) match(sub1)]} {
			set code $match(sub1)
		} else {
			puts "#ERROR:\t$code is not a valid hex format of $code_format"
			exit
		}
		set code [regsub -all {_} $code ""]
	}
	bin {
		if {[regexp -nocase ^(\[0-1_\]+)$ $code match(full) match(sub1)]} {
			set code $code
		} elseif {[regexp -nocase ^0b(\[0-1_\]+)$ $code match(full) match(sub1)]} {
			set code $match(sub1)
		} elseif {[regexp -nocase ^\[0-9\]+'b(\[0-1_\]+)$ $code match(full) match(sub1)]} {
			set code $match(sub1)
		} else {
			puts "#ERROR:\t$code is not a valid bin format of $code_format"
			exit
		}
		set code [regsub -all {_} $code ""]
	}
}




puts "#INFO:\tCode                   - $code"
puts "#INFO:\tCode format            - $code_format"
puts "#INFO:\tLength (in binary)     - $code_length"
puts "#INFO:\tUnit length per packet - $code_unit"

if {[regexp -nocase hex|bin $code_format] eq 0} {
	puts "#INFO:\tProcessing string code $code"
	binary scan $code H* code
}

if {[regexp -nocase bin $code_format] eq 0} {
	puts "#INFO:\tProcessing hex code $code"
	set chars [split $code {}]
	set code ""
	foreach char $chars {
		switch $char {
			"0"	{append code "0000"}
			"1"	{append code "0001"}
			"2"	{append code "0010"}
			"3"	{append code "0011"}
			"4"	{append code "0100"}
			"5"	{append code "0101"}
			"6"	{append code "0110"}
			"7"	{append code "0111"}
			"8"	{append code "1000"}
			"9"	{append code "1001"}
			"a"	{append code "1010"}
			"b"	{append code "1011"}
			"c"	{append code "1100"}
			"d"	{append code "1101"}
			"e"	{append code "1110"}
			"f"	{append code "1111"}
		}
	}
}

set valid_code ""
puts "#INFO:\tProcessing binary code $code"
for {set i [expr [string length $code] - 1]} {$i >= [expr [string length $code] - $code_length]} {incr i -1} {
	if {$i < 0} {
		set valid_code "0$valid_code"
	} else {
		set valid_code "[string index $code $i]$valid_code"
	}
}
puts "#INFO:\tFinal binary code $valid_code"

set tms "111111111"
for {set i 0} {$i < [expr $code_length / $code_unit]} {incr i} {
	set temp_code ""
	for {set j 0} {$j < $code_unit} {incr j} {
		append temp_code [string index $valid_code [expr $i * $code_unit + $j]]
	}
	set  tms "${temp_code}0${tms}"

}
	set  tms "00000000000000000111111111$tms"

set writepins {}
for {set i 0} {$i < [string length $tms]} {incr i} {
	lappend	writepins "[string index $tms $i]0"
	lappend	writepins "[string index $tms $i]0"
	lappend	writepins "[string index $tms $i]1"
	lappend	writepins "[string index $tms $i]1"
}

puts "#INFO:\tTotal write_pins nibbles [llength $writepins]"
puts "#INFO:\tExample write_pins script";
puts "#INFO:\t==========";
for {set i 0} {$i <= [expr [llength $writepins] / 200]} {incr i} {
	set cmd ""
	for {set j 0} {$j < 200} {incr j} {
		switch [lindex $writepins [expr $i * 200 + $j]] {
			00 {append cmd "0"}
			01 {append cmd "1"}
			10 {append cmd "2"}
			11 {append cmd "3"}
		}
	}
	if {[catch {write_pins $cmd} err]} {
		puts "write_pins $cmd"
	}
}
puts "#INFO:\t==========";


