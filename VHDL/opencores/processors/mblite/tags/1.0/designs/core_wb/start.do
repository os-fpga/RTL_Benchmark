restart
#Initialize all memories with zeros
mem load -filldata 00000000 -format hex /core_wb0/core0/decode0/gprf0/a/ram
mem load -filldata 00000000 -format hex /core_wb0/core0/decode0/gprf0/b/ram
mem load -filldata 00000000 -format hex /core_wb0/core0/decode0/gprf0/d/ram
mem load -filldata 00000000 -format hex /imem/ram
mem load -filldata 00000000 -format hex /dmem/ram
#Load the program
mem load -infile rom.mem    -format hex /imem/ram
mem load -infile rom.mem    -format hex /dmem/ram