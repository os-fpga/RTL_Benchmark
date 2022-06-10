set_property SRC_FILE_INFO {cfile:/home/user/aes/fpga/aec128_ecb_2017/aes128_ecb.srcs/sources_1/ip/clk_gen/clk_gen.xdc rfile:../../../../../../aes/fpga/aec128_ecb_2017/aes128_ecb.srcs/sources_1/ip/clk_gen/clk_gen.xdc id:1 order:EARLY scoped_inst:inst} [current_design]
set_property src_info {type:SCOPED_XDC file:1 line:57 export:INPUT save:INPUT read:READ} [current_design]
set_input_jitter [get_clocks -of_objects [get_ports clk_in1_p]] 0.05
