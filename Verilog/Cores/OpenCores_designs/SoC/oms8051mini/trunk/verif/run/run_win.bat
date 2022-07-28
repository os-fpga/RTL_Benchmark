vlib work
vlog -f filelist.f -l ../log/compile.log
copy ..\testcase\dat\uart_lb.dat dat\oc8051_xrom.in /Y
vsim -do run.do -c tb_top +uart_test_1 +INTERNAL_ROM -l ../log/uart_test_1.log
vsim -do run.do -c tb_top +spi_test_1 +INTERNAL_ROM -l ../log/spi_test_1.log

echo ""##############################################""
copy ..\testcase\dat\fib.dat dat\oc8051_xrom.in /Y
vsim -do run.do -c tb_top +INTERNAL_ROM -l ../log/int_fib.log

copy ..\testcase\dat\divmul.dat dat\oc8051_xrom.in /Y
vsim -do run.do -c tb_top +INTERNAL_ROM -l ../log/int_divmul.log

copy ..\testcase\dat\sort.dat dat\oc8051_xrom.in /Y
vsim -do run.do -c tb_top +INTERNAL_ROM -l ../log/int_sort.log

copy ..\testcase\dat\gcd.dat dat\oc8051_xrom.in /Y
vsim -do run.do -c tb_top +INTERNAL_ROM -l ../log/int_gcd.log

copy ..\testcase\dat\cast.dat dat\oc8051_xrom.in /Y
vsim -do run.do -c tb_top +INTERNAL_ROM -l ../log/int_cast.log

copy ..\testcase\dat\xram.dat dat\oc8051_xrom.in /Y
vsim -do run.do -c tb_top +INTERNAL_ROM -l ../log/int_xram.log
