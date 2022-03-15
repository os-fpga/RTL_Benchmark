@echo off
set xv_path=D:\\Vivado2015_2\\install\\Vivado\\2015.2\\bin
call %xv_path%/xsim PipelineMIPS_tb_behav -key {Behavioral:sim_1:Functional:PipelineMIPS_tb} -tclbatch PipelineMIPS_tb.tcl -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
