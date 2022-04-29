vlib work
vcom ../rtl/key_schd/*.vhd
vcom ../rtl/*.vhd
vcom ./*.vhd
vsim -novopt tb_AES_decrypt

add wave -noupdate -format Logic -radix unsigned /tb_AES_decrypt/clk
add wave -noupdate -format Logic -radix unsigned /tb_AES_decrypt/reset

add wave -noupdate -divider input
add wave -noupdate -format Logic -radix hex /tb_AES_decrypt/cipher
add wave -noupdate -format Logic -radix hex /tb_AES_decrypt/key
add wave -noupdate -format Logic -radix hex /tb_AES_decrypt/k_valid
add wave -noupdate -format Logic -radix hex /tb_AES_decrypt/c_valid

add wave -noupdate -divider output
add wave -noupdate -format Logic -radix hex /tb_AES_decrypt/text_out
add wave -noupdate -format Logic -radix hex /tb_AES_decrypt/ready
add wave -noupdate -format Logic -radix hex /tb_AES_decrypt/out_valid

run -all
