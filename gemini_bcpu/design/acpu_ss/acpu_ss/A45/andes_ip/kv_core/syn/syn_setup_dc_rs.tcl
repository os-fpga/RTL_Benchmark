#tech_lib:        Technology library name.
#operating_cond:  Chip operating condition.
#tech_lib_path:   Path to the technology library
#loading_cell:    Loading cell name and input pin name
#driving_cell:    Driving cell name
#max_trans:       the desired max transition rate (slew rate).
#dont_use_cells:  The cells that should be excluded from the specified library during the synthesis.
#wire_load_group: Wire load model selection group.
set tech_lib tcbn16ffcllbwp7d5t16p96cpdssgnp0p72v125c_ccs
set operating_cond ssgnp0p72v125c
set tech_lib_tc tcbn16ffcllbwp7d5t16p96cpdssgnp0p72v125c_ccs
set operating_cond_tc ssgnp0p72v125c
set tech_lib_path /cadlib/gemini/TSMC16NMFFC/library/std_cells/tsmc/7.5t/tcbn16ffcllbwp7d5t16p96cpd_100i/tcbn16ffcllbwp7d5t16p96cpd_100d_ccs/TSMCHOME/digital/Front_End/timing_power_noise/CCS/tcbn16ffcllbwp7d5t16p96cpd_100d/
set loading_cell BUFFD2BWP7D5T16P96CPD
set driving_cell BUFFD2BWP7D5T16P96CPD
set max_trans 0.400
#set dont_use_cells [list $tech_lib/SDF* $tech_lib/SEDF* $tech_lib/G* $tech_lib/*D0BWP30P140 $tech_lib/DEL* $tech_lib/CKAN2D* $tech_lib/CKBD* $tech_lib/CKLHQD* $tech_lib/CKLNQD* $tech_lib/CKMUX2D* $tech_lib/CKND* $tech_lib/CKND2D* $tech_lib/CKXOR2D*]
set wire_load_group WireAreaForZero

#mem_lib_path:    Path to memory library cells.
#mem_cond:        Memory macro file name suffix. Specify the file name
#                 suffix for searching the target memory library files in the
#                 memory path. The matched memory macro library file will
#                 be used for the synthesis.
set memory_lib_path "/cadlib/gemini/TSMC16NMFFC/library/memory/dti/memories/rev_111022/101222_tsmc16ffc_1PR_RAPIDSILICON_GEMINI_rev1p0p1_BE/dti_1pr_tm16ffcll_128x23_4ww2x_m_shc/ \
                     /cadlib/gemini/TSMC16NMFFC/library/memory/dti/memories/rev_111022/101222_tsmc16ffc_1PR_RAPIDSILICON_GEMINI_rev1p0p1_BE/dti_1pr_tm16ffcll_128x56_4ww2x_m_shc/ \
                     /cadlib/gemini/TSMC16NMFFC/library/memory/dti/memories/rev_111022/101222_tsmc16ffc_1PR_RAPIDSILICON_GEMINI_rev1p0p1_BE/dti_1pr_tm16ffcll_1024x32_4ww2x_m_shc/ \
                     /cadlib/gemini/TSMC16NMFFC/library/memory/dti/memories/rev_131022/101322_tsmc16ffc_SP_RAPIDSILICON_GEMINI_rev1p0p5_BE/dti_sp_tm16ffcll_2048x32_4byw2x_m_shd/ \
                     /cadlib/gemini/TSMC16NMFFC/library/memory/dti/memories/rev_131022/101322_tsmc16ffc_SP_RAPIDSILICON_GEMINI_rev1p0p5_BE/dti_sp_tm16ffcll_8192x32_16byw2x_m_shd/"
set mem_cond ssgnp0p72v125c
set mem_cond_tc ssgnp0p72v125c
