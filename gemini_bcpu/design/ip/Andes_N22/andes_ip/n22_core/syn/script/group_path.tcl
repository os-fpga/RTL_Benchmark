group_path -name "CORE_CLK" \
	-critical_range 0.2 \
	-weight 1  -from [get_clocks CORE_CLK]

#group_path -weight 1 \
#       -name "ALU" \
#       -through [list [get_pins $IPIPE_MODULE/alu_result*]] 
#
#group_path -weight 1 \
#	-name "BYPASS_TO_DLM" \
#	-through [list [get_pins $IPIPE_MODULE/lsu_ipipe_wb_bypass_data*] \
#                       [get_cell $IPIPE_MODULE/ex_src1_bypass*]]\
#	-through [list [get_pins $CORE_MODULE/dlm_cs*] \
#	               [get_pin $CORE_MODULE/dlm_addr*] \
#	               [get_pin $CORE_MODULE/dlm_byte_we*]]
#
#group_path -weight 1 \
#	-name "FETCH_ILM" \
#	-through [list [get_pins $IFU_MODULE/redirect_pc*] \
#                       [get_pins $IFU_MODULE/int_vector*]\
#                       [get_cell $IFU_MODULE/pred_pc*]]\
#	-through [list [get_pins $CORE_MODULE/ilm_cs*] \
#	               [get_pins $CORE_MODULE/ilm_addr*]]
#
#
#group_path -weight 1 \
#       -name "RESUME" \
#       -through [list [get_pins $IPIPE_MODULE/resume*]] 
#
#group_path -weight 1 \
#       -name "DECODE" \
#       -through [list [get_nets $IFU_MODULE/fetch_instr*]] 
#
#
#if {[string equal $NDS_MULTIPLIER "fast"]} {
#	group_path -weight 1 \
#	       -name "FASTMUL" \
#	       -from [list [get_cell $FASTMUL_MODULE/mreq*_reg]] 
#
#	group_path -weight 1 \
#	       -name "FASTMULOUT" \
#	       -through [list [get_nets $FASTMUL_MODULE/fmul_result*]] 
#
#}
