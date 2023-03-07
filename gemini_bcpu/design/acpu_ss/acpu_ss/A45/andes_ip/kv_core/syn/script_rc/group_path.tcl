
if {[llength [all::all_seqs]] > 0} { 
	define_cost_group -name I2C -design $DESIGN
	define_cost_group -name C2O -design $DESIGN
	path_group -from [all::all_seqs] -to [all::all_outs] -group C2O -name C2O
	path_group -from [all::all_inps]  -to [all::all_seqs] -group I2C -name I2C
}

if {$NDS_FPU_TYPE != "none"} {
define_cost_group -name FPU -design $DESIGN
path_group -through [list [find / -pin $CORE_MODULE/gen_fpu.kv_fpu/f*] \
		          [find / -pin $CORE_MODULE/gen_fpu.kv_fpu/u_fpu*/f*] \
		          [find / -pin $CORE_MODULE/gen_fpu.kv_fpu/gen*.u_fpu*/f*]] \
                   -name FPU -group FPU
}

if {$NDS_DLM_SIZE_KB != 0} {
define_cost_group -name DLM -design $DESIGN
path_group -through [list [find / -pin $CORE_MODULE/dlm_cs*] \
	                  [find / -pin $CORE_MODULE/dlm_addr*] \
	                  [find / -pin $CORE_MODULE/dlm_byte_we*]] \
	   -name DLM -group DLM 
define_cost_group -name DLM -design $DESIGN
path_group -through [list [find / -pin $CORE_MODULE/dlm1_cs*] \
	                  [find / -pin $CORE_MODULE/dlm1_addr*] \
	                  [find / -pin $CORE_MODULE/dlm1_byte_we*]] \
	   -name DLM -group DLM 
define_cost_group -name DLM -design $DESIGN
path_group -through [list [find / -pin $CORE_MODULE/dlm2_cs*] \
	                  [find / -pin $CORE_MODULE/dlm2_addr*] \
	                  [find / -pin $CORE_MODULE/dlm2_byte_we*]] \
	   -name DLM -group DLM 
define_cost_group -name DLM -design $DESIGN
path_group -through [list [find / -pin $CORE_MODULE/dlm3_cs*] \
	                  [find / -pin $CORE_MODULE/dlm3_addr*] \
	                  [find / -pin $CORE_MODULE/dlm3_byte_we*]] \
	   -name DLM -group DLM 
}

if {!$has_ilm_tl_ul} {
	if {$NDS_ILM_SIZE_KB != 0} {
	define_cost_group -name FETCH_ILM -design $DESIGN
	path_group -through [list [find / -pin $IFU_MODULE/redirect_pc*]] \
		   -through [list [find / -pin $CORE_MODULE/ilm0_cs*] \
		                  [find / -pin $CORE_MODULE/ilm0_addr*]] \
		   -name FETCH_ILM -group FETCH_ILM
	define_cost_group -name FETCH_ILM -design $DESIGN
	path_group -through [list [find / -pin $IFU_MODULE/redirect_pc*]] \
		   -through [list [find / -pin $CORE_MODULE/ilm1_cs*] \
		                  [find / -pin $CORE_MODULE/ilm1_addr*]] \
		   -name FETCH_ILM -group FETCH_ILM
	}
}

define_cost_group -name RESUME -design $DESIGN
path_group -through [list [find / -pin $IFU_MODULE/resume*]] \
	   -name RESUME -group RESUME

define_cost_group -name REDIRECT -design $DESIGN
path_group -through [list [find / -pin $IFU_MODULE/redirect*]] \
	   -name REDIRECT -group REDIRECT

define_cost_group -name DECODE -design $DESIGN
path_group -through [list [find / -pin $IFU_MODULE/ifu_i*_instr*]] \
	   -name DECODE -group DECODE 

if {[string equal $NDS_MULTIPLIER "fast"]} {
	define_cost_group -name FASTMUL -design $DESIGN
	path_group -from $FASTMUL_MODULE/mreq*_reg \
		   -name FASTMUL -group FASTMUL 
	define_cost_group -name FASTMULOUT -design $DESIGN
	path_group -through $FASTMUL_MODULE/fmul_result* \
		   -name FASTMULOUT -group FASTMULOUT
}

define_cost_group -name I2O -design $DESIGN
path_group -from [all::all_inps] -through [list [find / -pin $CORE_MODULE/*]] -to [all::all_outs] -group I2O -name I2O


