quit -sim
project compileoutofdate
alias w "write format wave wave.do"
alias s "do ../bin/s.do"
alias b "bookmark add wave A"
vsim -t 1fs tb_top
#view wave
do ../run/wave.do
#run -all
run 120us