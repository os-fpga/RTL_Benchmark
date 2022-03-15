onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic /testbench/clk
add wave -noupdate -format Logic /testbench/nreset
add wave -noupdate -format Logic /testbench/pwm_out
add wave -noupdate -format Logic /testbench/nwe_cpu
add wave -noupdate -format Logic /testbench/nre_cpu
add wave -noupdate -format Literal -radix hexadecimal /testbench/cpu_data_out
add wave -noupdate -format Literal -radix unsigned /testbench/cpu_iaddr_out
add wave -noupdate -format Literal -radix hexadecimal /testbench/cpu_daddr_out
add wave -noupdate -format Literal -radix hexadecimal /testbench/ctrl_out
add wave -noupdate -format Literal -radix hexadecimal /testbench/ctrl_in
add wave -noupdate -format Literal /testbench/i1/xlxi_1/i3/code
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {250 ns} 0}
WaveRestoreZoom {2016 ns} {10421 ns}
configure wave -namecolwidth 247
configure wave -valuecolwidth 82
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
