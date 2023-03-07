#tech_lib:        Technology library name.
#operating_cond:  Chip operating condition.
#tech_lib_path:   Path to the technology library
#loading_cell:    Loading cell name and input pin name
#driving_cell:    Driving cell name
#max_trans:       the desired max transition rate (slew rate).
#dont_use_cells:  The cells that should be excluded from the specified library during the synthesis.
#wire_load_group: Wire load model selection group.
set tech_lib tcbn28hpcbwp12t35p140ssg0p81v0c
set operating_cond ssg0p81v0c
set tech_lib_path /pseudopath/tcbn28hpcbwp12t35p140_100a
set loading_cell BUFFD4BWP12T35P140
set driving_cell BUFFD4BWP12T35P140
set max_trans 0.400
set dont_use_cells [list tcbn28hpcbwp12t35p140ssg0p81v0c/SDF* tcbn28hpcbwp12t35p140ssg0p81v0c/SDF* tcbn28hpcbwp12t35p140ssg0p81v0c/SEDF* tcbn28hpcbwp12t35p140ssg0p81v0c/G* tcbn28hpcbwp12t35p140ssg0p81v0c/*D0BWP12T35P140 tcbn28hpcbwp12t35p140ssg0p81v0c/DEL* tcbn28hpcbwp12t35p140ssg0p81v0c/CKAN2D* tcbn28hpcbwp12t35p140ssg0p81v0c/CKBD* tcbn28hpcbwp12t35p140ssg0p81v0c/CKLHQD* tcbn28hpcbwp12t35p140ssg0p81v0c/CKLNQD* tcbn28hpcbwp12t35p140ssg0p81v0c/CKMUX2D* tcbn28hpcbwp12t35p140ssg0p81v0c/CKND* tcbn28hpcbwp12t35p140ssg0p81v0c/CKND2D* tcbn28hpcbwp12t35p140ssg0p81v0c/CKXOR2D* ]
set wire_load_group WireAreaForZero


#mem_lib_path:    Path to memory library cells.
#mem_cond:        Memory macro file name suffix. Specify the file name
#                 suffix for searching the target memory library files in the
#                 memory path. The matched memory macro library file will
#                 be used for the synthesis.
set memory_lib_path /pseudopath/hsspt28c/lib
set mem_cond N40CSSG0P81 
