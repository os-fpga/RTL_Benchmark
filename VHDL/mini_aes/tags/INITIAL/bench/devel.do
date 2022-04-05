# $Id: devel.do,v 1.1.1.1 2005-12-06 02:47:45 arif_endro Exp $

quit -sim
vlib work
vcom ../source/bram_block_a.vhdl
vcom ../source/bram_block_b.vhdl
vcom ../source/bram_block_c.vhdl
vcom ../source/counter2bit.vhdl
vcom ../source/key_scheduler.vhdl
vcom ../source/xtime.vhdl
vcom ../source/mix_column.vhdl
vcom ../source/mini_aes.vhdl
vcom ../source/shiftregluts16bit.vhdl
vcom ../source/folded_register.vhdl

# vcom input.vhdl
# vcom output.vhdl
# vcom modelsim_bench.vhdl

vsim mini_aes

add wave      sim:/mini_aes/clock
add wave      sim:/mini_aes/clear
add wave      sim:/mini_aes/enc
add wave      sim:/mini_aes/done
add wave      sim:/mini_aes/done_o
add wave      sim:/mini_aes/key_counter_up
add wave      sim:/mini_aes/key_counter_down
add wave -hex sim:/mini_aes/data_i
add wave -hex sim:/mini_aes/current_key
add wave -hex sim:/mini_aes/foldreg/round0
add wave -hex sim:/mini_aes/key_i
add wave -hex sim:/mini_aes/fifo16x8
add wave -hex sim:/mini_aes/key_o_srl1_p
add wave -hex sim:/mini_aes/key_o_srl2_p
add wave -hex sim:/mini_aes/key_o_srl3_p
add wave -hex sim:/mini_aes/key_o_srl4_p
add wave -hex sim:/mini_aes/key_o_srl1
add wave -hex sim:/mini_aes/key_o_srl2
add wave -hex sim:/mini_aes/key_o_srl3
add wave -hex sim:/mini_aes/data_o
add wave -hex sim:/mini_aes/input
add wave -hex sim:/mini_aes/addr_a_1_i
add wave -hex sim:/mini_aes/addr_a_2_i
add wave -hex sim:/mini_aes/addr_b_1_i
add wave -hex sim:/mini_aes/addr_b_2_i
add wave -hex sim:/mini_aes/do_a_1_o
add wave -hex sim:/mini_aes/do_a_2_o
add wave -hex sim:/mini_aes/do_b_1_o
add wave -hex sim:/mini_aes/do_b_2_o
add wave -hex sim:/mini_aes/mixcol_s0_i
add wave -hex sim:/mini_aes/mixcol_s1_i
add wave -hex sim:/mini_aes/mixcol_s2_i
add wave -hex sim:/mini_aes/mixcol_s3_i
add wave -hex sim:/mini_aes/inv_mixcol_o
add wave -hex sim:/mini_aes/mixcol_o
add wave -hex sim:/mini_aes/key/key_o
add wave -hex sim:/mini_aes/output
add wave -hex sim:/mini_aes/output_o

force -freeze sim:/mini_aes/clock 1 0, 0 {50 ns} -r 100
force -freeze sim:/mini_aes/enc 0 0
force -freeze sim:/mini_aes/clear 1 0
run 100ns
force -freeze sim:/mini_aes/clear 0 0
noforce sim:/mini_aes/clear

run 4100ns
run 4100ns
