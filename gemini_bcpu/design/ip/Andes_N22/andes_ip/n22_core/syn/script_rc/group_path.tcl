
if {$tool_name == "rc"} {
	if {[llength [all::all_seqs]] > 0} { 
		define_cost_group -name I2C -design $DESIGN
		define_cost_group -name C2O -design $DESIGN
		path_group -from [all::all_seqs] -to [all::all_outs] -group C2O -name C2O
		path_group -from [all::all_inps]  -to [all::all_seqs] -group I2C -name I2C
	}
} else {
	if {[llength [all_registers]] > 0} { 
		define_cost_group -name I2C -design $DESIGN
		define_cost_group -name C2O -design $DESIGN
		path_group -from [all_registers] -to [all_outputs] -group C2O -name C2O
		path_group -from [all_inputs]  -to [all_registers] -group I2C -name I2C
	}
}

#define_cost_group -name ALU -design $DESIGN
#path_group -through [list [find / -pin $IPIPE_MODULE/alu_result*] \
#                          [find / -pin $IPIPE_MODULE/alu_br_taken]] \
#	-name ALU -group ALU
#
#define_cost_group -name BYPASS -design $DESIGN
#path_group -through [list [find / -pin $IPIPE_MODULE/lsu_ipipe_wb_bypass_data*]] \
#	-name BYPASS -group BYPASS

#define_cost_group -name DLM -design $DESIGN
#path_group -through [list [find / -pin $CORE_MODULE/dlm_cs*] \
#	                  [find / -pin $CORE_MODULE/dlm_addr*] \
#	                  [find / -pin $CORE_MODULE/dlm_byte_we*]] \
#	   -name DLM -group DLM 
#
#define_cost_group -name FETCH_ILM -design $DESIGN
#path_group -through [list [find / -pin $IFU_MODULE/redirect_pc*] \
#                          [find / -pin $IFU_MODULE/int_vector*]\
#                          [find / -instance $IFU_MODULE/pred_pc*]]\
#	   -through [list [find / -pin $CORE_MODULE/ilm_cs*] \
#	                  [find / -pin $CORE_MODULE/ilm_addr*]] \
#	   -name FETCH_ILM -group FETCH_ILM
#
#define_cost_group -name RESUME -design $DESIGN
#path_group -through [list [find / -pin $IPIPE_MODULE/resume*]] \
#	   -name RESUME -group RESUME
#
#define_cost_group -name DECODE -design $DESIGN
#path_group -through [list [find / -pin $IFU_MODULE/fetch_instr*]] \
#	   -name DECODE -group DECODE 
#
#if {$fastmul_support} {
#	define_cost_group -name FASTMUL -design $DESIGN
#	path_group -from $FASTMUL_MODULE/mreq*_reg \
#		   -name FASTMUL -group FASTMUL 
#	define_cost_group -name FASTMULOUT -design $DESIGN
#	path_group -through $FASTMUL_MODULE/fmul_result* \
#		   -name FASTMULOUT -group FASTMULOUT
#}
