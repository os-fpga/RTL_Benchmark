
# export SC_SIGNAL_WRITE_CHECK=DISABLE 

#SYSTEMC_HOME=/opt/systemc

#g++ -I. -I$SYSTEMC_HOME/include -L. -L$SYSTEMC_HOME/lib64 -Wall -Wreorder -Wextra -std=c++11 -fPIC -shared -fpermissive -lsystemc `pkg-config gtkmm-3.0 --cflags --libs` -lboost_thread -lboost_system  ../systemC/main.cc -o final_spw.so 

#g++ -I. -I$SYSTEMC_HOME/include -L. -L$SYSTEMC_HOME/lib-linux64 -std=c++11 -fPIC -shared -fpermissive -lsystemc ../systemC/main.cc -o final_spw.so 

g++ -c -ldl -fpic ../vpi/vpi_test_stress/env_global_spw.cpp -Wall -Wextra  -std=c++11 -Wwrite-strings -fpermissive

g++ -shared  -Wall -Wextra -oenv_global_spw.vpi env_global_spw.o -lvpi -std=c++11 -Wwrite-strings -fpermissive

#EXECUTE LOOPBACK IP
#OBS: CHANGE on file env_global_spw.cpp variable LOOPBACK_VLOG_EN to 1 
#iverilog -oenv_global_spw.vvp -D VERILOG_B ../rtl/RTL_VB/*.v ../testbench/module_tb.v 
 
#EXECUTE WITH SYSTEMC 
#OBS: CHANGE on file env_global_spw.cpp variable LOOPBACK_VLOG_EN to 0
iverilog -oenv_global_spw.vvp ../rtl/RTL_VB/*.v ../testbench/module_tb.v 

vvp -M. -menv_global_spw env_global_spw.vvp
