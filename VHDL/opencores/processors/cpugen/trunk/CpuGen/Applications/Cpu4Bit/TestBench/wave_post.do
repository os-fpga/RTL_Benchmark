onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic -radix hexadecimal /testbench/clk
add wave -noupdate -format Logic -radix hexadecimal /testbench/nreset
add wave -noupdate -format Logic -radix hexadecimal /testbench/pwm_out
add wave -noupdate -format Logic -radix hexadecimal /testbench/nwe_cpu
add wave -noupdate -format Logic -radix hexadecimal /testbench/nre_cpu
add wave -noupdate -format Literal -radix hexadecimal /testbench/cpu_data_out
add wave -noupdate -format Literal -radix hexadecimal /testbench/ctrl_out
add wave -noupdate -format Literal -radix hexadecimal /testbench/ctrl_in
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
WaveRestoreZoom {0 ps} {10500 ns}
configure wave -namecolwidth 209
configure wave -valuecolwidth 41
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
