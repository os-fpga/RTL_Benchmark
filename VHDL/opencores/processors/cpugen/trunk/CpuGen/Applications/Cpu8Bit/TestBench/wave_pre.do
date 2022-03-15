onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic -radix hexadecimal /testbench/clk
add wave -noupdate -format Logic -radix hexadecimal /testbench/nreset
add wave -noupdate -format Logic -radix hexadecimal /testbench/txd
add wave -noupdate -format Logic -radix hexadecimal /testbench/rxd
add wave -noupdate -format Literal -radix hexadecimal /testbench/port0_in
add wave -noupdate -format Literal -radix hexadecimal /testbench/port1_in
add wave -noupdate -format Literal -radix hexadecimal /testbench/port0_out
add wave -noupdate -format Literal -radix hexadecimal /testbench/port1_out
add wave -noupdate -format Literal -radix hexadecimal /testbench/in_int
add wave -noupdate -format Literal -radix unsigned /testbench/i1/i1/iaddr_out
add wave -noupdate -format Literal -radix hexadecimal /testbench/i1/i1/data_out
add wave -noupdate -format Literal -radix hexadecimal /testbench/i1/i1/daddr_out
add wave -noupdate -format Literal -radix hexadecimal /testbench/i1/i1/idata_in
add wave -noupdate -format Literal -radix hexadecimal /testbench/i1/i1/data_in
add wave -noupdate -format Logic -radix hexadecimal /testbench/i1/i1/ndre_out
add wave -noupdate -format Logic -radix hexadecimal /testbench/i1/i1/ndwe_out
add wave -noupdate -format Logic -radix hexadecimal /testbench/i1/i1/int_in
add wave -noupdate -format Logic -radix hexadecimal /testbench/i1/i1/nreset_in
add wave -noupdate -format Logic -radix hexadecimal /testbench/i1/i1/clk_in
add wave -noupdate -format Literal -radix hexadecimal /testbench/i1/i1/i3/acc
add wave -noupdate -format Literal -radix hexadecimal /testbench/i1/i1/i3/code
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {3150 ns} 0}
WaveRestoreZoom {1948 ns} {2974 ns}
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
