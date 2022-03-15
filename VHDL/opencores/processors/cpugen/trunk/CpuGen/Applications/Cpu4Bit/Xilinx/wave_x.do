onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic /testbench_xe/clk
add wave -noupdate -format Logic /testbench_xe/nreset
add wave -noupdate -format Logic /testbench_xe/int
add wave -noupdate -format Logic /testbench_xe/dwait
add wave -noupdate -format Logic /testbench_xe/breq
add wave -noupdate -format Logic /testbench_xe/pwm_out
add wave -noupdate -format Logic /testbench_xe/nwe_cpu
add wave -noupdate -format Logic /testbench_xe/nre_cpu
add wave -noupdate -format Literal -radix unsigned /testbench_xe/cpu_iaddr
add wave -noupdate -format Literal -radix unsigned /testbench_xe/cpu_daddr
add wave -noupdate -format Literal -radix hexadecimal /testbench_xe/cpu_data_out
add wave -noupdate -format Literal -radix hexadecimal /testbench_xe/ctrl_out
add wave -noupdate -format Literal -radix hexadecimal /testbench_xe/ctrl_in
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {0 ns}
WaveRestoreZoom {0 ns} {13800 ns}
configure wave -namecolwidth 296
configure wave -valuecolwidth 143
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
