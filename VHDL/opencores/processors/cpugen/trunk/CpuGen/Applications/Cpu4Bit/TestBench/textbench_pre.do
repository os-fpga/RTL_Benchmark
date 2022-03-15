project open testbench_pre.mpf
# vcom *.vhd -refresh
vsim -t ns work.testbench(struct)
view dataflow
view list
view process
view signals
view source
view structure
view variables
view wave
do wave_pre.do
run 10000
