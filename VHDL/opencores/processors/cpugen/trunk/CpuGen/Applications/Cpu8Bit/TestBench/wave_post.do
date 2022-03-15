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
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1000054 ns} 0}
WaveRestoreZoom {0 ns} {492254 ns}
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
