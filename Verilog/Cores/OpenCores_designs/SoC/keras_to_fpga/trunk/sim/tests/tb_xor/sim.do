#
#

quit -sim

# vsim -suppress 12110 -novopt work.tb_top
vsim -f ./sim.f work.tb_top

# log all signals
log /* -r
