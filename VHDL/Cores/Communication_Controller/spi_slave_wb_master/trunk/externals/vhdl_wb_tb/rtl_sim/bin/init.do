quit -sim

# create work-lib (prevents later error)
vlib work
vmap work work
#delete work-lib 
vmap -del work
vdel -all -lib work
# create work-lib (empty lib)
vlib work
vmap work work

#compile all
project calculateorder

#set aliases
alias s "do ../bin/s.do"