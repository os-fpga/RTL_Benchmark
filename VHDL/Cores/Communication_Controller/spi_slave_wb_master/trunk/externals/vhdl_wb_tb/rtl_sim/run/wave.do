onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider TestBench_WbMaster
add wave -noupdate -format Event -expand /tb_top/tc_top_inst/wb_o
add wave -noupdate /tb_top/tc_top_inst/wb_i
add wave -noupdate -divider WbStimulator
add wave -noupdate /tb_top/stimulator_inst/wb_i
add wave -noupdate /tb_top/stimulator_inst/wb_o
add wave -noupdate /tb_top/stimulator_inst/signals_o
add wave -noupdate /tb_top/stimulator_inst/register0_s
add wave -noupdate /tb_top/stimulator_inst/register1_s
add wave -noupdate -divider WbVerifier
add wave -noupdate /tb_top/verifier_inst/wb_i
add wave -noupdate /tb_top/verifier_inst/wb_o
add wave -noupdate /tb_top/verifier_inst/signals_i
add wave -noupdate /tb_top/verifier_inst/register0_s
add wave -noupdate /tb_top/verifier_inst/register1_s
add wave -noupdate -divider Core_top
add wave -noupdate /tb_top/core_top_inst/clock_i
add wave -noupdate /tb_top/core_top_inst/reset_i
add wave -noupdate /tb_top/core_top_inst/signals_i
add wave -noupdate /tb_top/core_top_inst/signals_o
add wave -noupdate /tb_top/core_top_inst/shift_register_r
add wave -noupdate /tb_top/core_top_inst/old_shift_clock_r
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {649701366 fs} 0}
quietly wave cursor active 1
configure wave -namecolwidth 232
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 fs} {1142240758 fs}
bookmark add wave A {{187592960 fs} {1276319150 fs}} 0
