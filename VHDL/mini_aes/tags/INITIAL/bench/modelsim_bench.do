# $Id: modelsim_bench.do,v 1.1.1.1 2005-12-06 02:47:46 arif_endro Exp $

# destroy .wave

quit -sim
vlib work
vcom -cover bcesx ../source/bram_block_a.vhdl
vcom -cover bcesx ../source/bram_block_b.vhdl
vcom -cover bcesx ../source/counter2bit.vhdl
vcom -cover bcesx ../source/key_scheduler.vhdl
vcom -cover bcesx ../source/xtime.vhdl
vcom -cover bcesx ../source/mix_column.vhdl
vcom -cover bcesx ../source/folded_register.vhdl
vcom -cover bcesx ../source/mini_aes.vhdl

vcom -cover bcesx input.vhdl
vcom -cover bcesx output.vhdl
vcom -cover bcesx modelsim_bench.vhdl

# vsim -coverage modelsim_bench
vsim modelsim_bench

# .wave.tree zoomrange {0ns} {200ns}
# .wave.tree zoomrange {4000ns} {4400ns}
# .wave.tree zoomin 2

add wave      sim:/modelsim_bench/clock_enc
add wave      sim:/modelsim_bench/clear_enc
add wave      sim:/modelsim_bench/my_aes_enc/enc
add wave      sim:/modelsim_bench/done_enc
add wave      sim:/modelsim_bench/test_iteration_enc
add wave -hex sim:/modelsim_bench/data_i_enc
add wave -hex sim:/modelsim_bench/key_i_enc
add wave -hex sim:/modelsim_bench/cipher_o_enc
add wave -hex sim:/modelsim_bench/data_o_enc
add wave      sim:/modelsim_bench/my_output_enc/passed
add wave      sim:/modelsim_bench/my_output_enc/failed

add wave      sim:/modelsim_bench/clock_dec
add wave      sim:/modelsim_bench/clear_dec
add wave      sim:/modelsim_bench/my_aes_dec/enc
add wave      sim:/modelsim_bench/done_dec
add wave      sim:/modelsim_bench/test_iteration_dec
add wave -hex sim:/modelsim_bench/data_i_dec
add wave -hex sim:/modelsim_bench/key_i_dec
add wave -hex sim:/modelsim_bench/cipher_o_dec
add wave -hex sim:/modelsim_bench/data_o_dec
add wave      sim:/modelsim_bench/my_output_dec/passed
add wave      sim:/modelsim_bench/my_output_dec/failed

run 21300ns
