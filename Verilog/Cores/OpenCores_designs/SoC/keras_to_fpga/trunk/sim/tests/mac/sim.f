#
#

# +incdir+${ALTERA_LIBS}/code

# +UVM_VERBOSITY=UVM_DEBUG
+UVM_VERBOSITY=UVM_HIGH

-voptargs=+acc=npr+/tb_top

-L work 
# -L mac_altera_fpdsp_block_171 
-L ${ALTERA_LIBS}/altera_ver 
-L ${ALTERA_LIBS}/lpm_ver 
-L ${ALTERA_LIBS}/sgate_ver 
-L ${ALTERA_LIBS}/altera_mf_ver 
-L ${ALTERA_LIBS}/altera_lnsim_ver 
-L ${ALTERA_LIBS}/twentynm_ver 
-L ${ALTERA_LIBS}/twentynm_hssi_ver 
-L ${ALTERA_LIBS}/twentynm_hip_ver


