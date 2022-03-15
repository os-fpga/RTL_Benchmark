set IterationLimit 10000
vsim -t ps work.testbench(struct)
view structure wave signals source
do wave_post.do
log -r *
run 50 us