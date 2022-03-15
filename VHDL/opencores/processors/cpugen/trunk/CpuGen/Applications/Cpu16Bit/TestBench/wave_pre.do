onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic -radix hexadecimal /testbench/clk_in
add wave -noupdate -format Logic -radix hexadecimal /testbench/nreset_in
add wave -noupdate -format Logic -radix hexadecimal /testbench/cpu_int
add wave -noupdate -format Logic -radix hexadecimal /testbench/nre_ext
add wave -noupdate -format Logic -radix hexadecimal /testbench/nwe_ext
add wave -noupdate -format Logic -radix hexadecimal /testbench/ncs_ext
add wave -noupdate -format Literal -radix unsigned /testbench/addr_out_ext
add wave -noupdate -format Literal -radix hexadecimal /testbench/data_in_ext
add wave -noupdate -format Literal -radix hexadecimal /testbench/data_out_ext
add wave -noupdate -format Literal -radix unsigned /testbench/i1/inst1/saddr_out
add wave -noupdate -format Logic -radix hexadecimal /testbench/i1/inst1/ipush_out
add wave -noupdate -format Logic -radix hexadecimal /testbench/i1/inst1/ipop_out
add wave -noupdate -format Literal -radix unsigned /testbench/i1/inst1/saddr_in
add wave -noupdate -format Literal -radix unsigned /testbench/i1/inst1/iaddr_out
add wave -noupdate -format Literal -radix hexadecimal /testbench/i1/inst1/data_out
add wave -noupdate -format Literal -radix unsigned /testbench/i1/inst1/daddr_out
add wave -noupdate -format Literal -radix unsigned /testbench/i1/inst1/adaddr_out
add wave -noupdate -format Literal -radix hexadecimal /testbench/i1/inst1/idata_in
add wave -noupdate -format Literal -radix hexadecimal /testbench/i1/inst1/data_in
add wave -noupdate -format Logic -radix hexadecimal /testbench/i1/inst1/ndre_out
add wave -noupdate -format Logic -radix hexadecimal /testbench/i1/inst1/ndwe_out
add wave -noupdate -format Logic -radix hexadecimal /testbench/i1/inst1/nadwe_out
add wave -noupdate -format Logic -radix hexadecimal /testbench/i1/inst1/int_in
add wave -noupdate -format Logic -radix hexadecimal /testbench/i1/inst1/dwait_in
add wave -noupdate -format Logic -radix hexadecimal /testbench/i1/inst1/iwait_in
add wave -noupdate -format Logic -radix hexadecimal /testbench/i1/inst1/nreset_in
add wave -noupdate -format Logic -radix hexadecimal /testbench/i1/inst1/clk_in
add wave -noupdate -format Literal /testbench/i1/inst1/i3/code
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
WaveRestoreZoom {19050 ns} {20050 ns}
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
