database -open waves -into ../out/irda -default 
probe -create -shm irda_test -all -depth all
stop -create -time 20000ns -relative
run

