@echo off
set xv_path=D:\\Vivado2015_2\\install\\Vivado\\2015.2\\bin
call %xv_path%/xelab  -wto 03d808c657f04c21886ac62c5c510ba2 -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L dist_mem_gen_v8_0 -L blk_mem_gen_v8_2 -L xbip_utils_v3_0 -L c_reg_fd_v12_0 -L xbip_dsp48_wrapper_v3_0 -L xbip_pipe_v3_0 -L xbip_dsp48_addsub_v3_0 -L xbip_addsub_v3_0 -L c_addsub_v12_0 -L unisims_ver -L unimacro_ver -L secureip --snapshot PipelineMIPS_tb_behav xil_defaultlib.PipelineMIPS_tb xil_defaultlib.glbl -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
