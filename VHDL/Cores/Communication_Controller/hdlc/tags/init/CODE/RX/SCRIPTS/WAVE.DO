onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic /rx_tb_ent/rxclk_i
add wave -noupdate -format Logic /rx_tb_ent/rst_i
add wave -noupdate -format Logic /rx_tb_ent/rx_i
add wave -noupdate -format Literal /rx_tb_ent/rxdata_i
add wave -noupdate -format Logic /rx_tb_ent/validframe_i
add wave -noupdate -format Logic /rx_tb_ent/readbyte_i
add wave -noupdate -format Logic /rx_tb_ent/rdy_i
add wave -noupdate -format Logic /rx_tb_ent/rxen_i
add wave -noupdate -format Logic /rx_tb_ent/uut/rxd_i
add wave -noupdate -format Logic /rx_tb_ent/uut/enable_i
add wave -noupdate -format Logic /rx_tb_ent/uut/aval_i
add wave -noupdate -format Logic /rx_tb_ent/uut/flagdetect_i
add wave -noupdate -format Logic /rx_tb_ent/uut/initzero_i
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {399808 ps}
WaveRestoreZoom {0 ps} {1463296 ps}
