onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic /testbench/clk_in
add wave -noupdate -format Logic /testbench/nreset_in
add wave -noupdate -format Logic /testbench/int_in
add wave -noupdate -format Logic /testbench/dwait_in
add wave -noupdate -format Logic /testbench/ndre_out
add wave -noupdate -format Logic /testbench/ndwe_out
add wave -noupdate -format Logic /testbench/nadwe_out
add wave -noupdate -format Literal -radix hexadecimal /testbench/idata_in
add wave -noupdate -format Literal -radix hexadecimal /testbench/data_in
add wave -noupdate -format Literal -radix unsigned /testbench/iaddr_out
add wave -noupdate -format Literal -radix hexadecimal /testbench/data_out
add wave -noupdate -format Literal -radix unsigned /testbench/daddr_out
add wave -noupdate -format Literal -radix unsigned /testbench/adaddr_out
add wave -noupdate -format Literal -radix hexadecimal /testbench/i1/i3/acc
add wave -noupdate -format Literal /testbench/i1/i3/code
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {6350 ns} 0}
WaveRestoreZoom {0 ns} {4183 ns}
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
