
# export SC_SIGNAL_WRITE_CHECK=DISABLE 

SYSTEMC_HOME=path_to_your_home_systemC/systemc-2.3.0

g++ -I. -I$SYSTEMC_HOME/include -L. -L$SYSTEMC_HOME/lib-linux64 -Wall -Wreorder -Wextra -std=c++11 -fPIC -shared -fpermissive -lsystemc `pkg-config gtkmm-3.0 --cflags --libs` -lboost_thread -lboost_system  ../systemC/main.cc -o final_spw.so 

g++ -c -ldl -fpic ../vpi/vpi_test_stress/env_global_spw.cpp -Wall -Wextra  -std=c++11 -Wwrite-strings -fpermissive

g++ -shared  -Wall -Wextra -oenv_global_spw.vpi env_global_spw.o -lvpi -std=c++11 -Wwrite-strings -fpermissive

iverilog -oenv_global_spw.vvp ../rtl/RTL_VB/*.v ../testbench/module_tb.v 

vvp -M. -menv_global_spw env_global_spw.vvp
