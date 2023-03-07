#tech_lib:        Technology library name.
#operating_cond:  Chip operating condition.
#tech_lib_path:   Path to the technology library
#loading_cell:    Loading cell name and input pin name
#driving_cell:    Driving cell name
#max_trans:       the desired max transition rate (slew rate).
#dont_use_cells:  The cells that should be excluded from the specified library during the synthesis.
#wire_load_group: Wire load model selection group.
set tech_lib tcbn28hpcplusbwp30p140ssg0p81vm40c
set operating_cond ssg0p81vm40c
set tech_lib_tc tcbn28hpcplusbwp30p140tt0p9v25c
set operating_cond_tc tt0p9v25c
set tech_lib_path  /pseudopath/tcbn28hpcplusbwp30p140_180a
set loading_cell BUFFD4BWP30P140
set driving_cell BUFFD4BWP30P140
set max_trans 0.400
set dont_use_cells [list $tech_lib/SDF* $tech_lib/SEDF* $tech_lib/G* $tech_lib/*D0BWP30P140 $tech_lib/DEL* $tech_lib/CKAN2D* $tech_lib/CKBD* $tech_lib/CKLHQD* $tech_lib/CKMUX2D* $tech_lib/CKND* $tech_lib/CKND2D* $tech_lib/CKXOR2D*]
set wire_load_group WireAreaForZero


#mem_lib_path:    Path to memory library cells.
#mem_cond:        Memory macro file name suffix. Specify the file name
#                 suffix for searching the target memory library files in the
#                 memory path. The matched memory macro library file will
#                 be used for the synthesis.
set memory_lib_path /pseudopath/temn28hpcphssrammacros_110a/lib
set mem_cond ssg0p81v0p81vm40c
set mem_cond_tc tt0p9v0p9v25c
