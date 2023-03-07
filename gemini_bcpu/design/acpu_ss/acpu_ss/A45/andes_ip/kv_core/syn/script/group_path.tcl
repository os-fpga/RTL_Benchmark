group_path -name "CORE_CLK" \
	-weight 1  -from [get_clocks CORE_CLK]

#group_path -weight 1 \
#       -name "ALU" \
#       -through [list [get_pins $IPIPE_MODULE/alu_result*]] 

if {$NDS_DLM_SIZE_KB != 0} {
group_path -weight 1 \
	-name "BYPASS_TO_DLM" \
	-through [list [get_pins $CORE_MODULE/dlm*_cs*] \
	               [get_pins $CORE_MODULE/dlm*_addr*] \
	               [get_pins $CORE_MODULE/dlm*_byte_we*]]
}

if {$NDS_FPU_TYPE != "none"} {
group_path -weight 1 \
	   -name "FPU" \
	   -through [list [get_pins $CORE_MODULE/gen_fpu.kv_fpu/f*] \
		          [get_pins $CORE_MODULE/gen_fpu.kv_fpu/u_fpu*/f*] \
		          [get_pins $CORE_MODULE/gen_fpu.kv_fpu/gen*.u_fpu*/f*]]
}

if {!$has_ilm_tl_ul} {
	if {$NDS_ILM_SIZE_KB != 0} {
	group_path -weight 1 \
		-name "FETCH_ILM" \
		-through [list [get_pins $IFU_MODULE/redirect_pc*]] \
		-through [list [get_pins $CORE_MODULE/ilm*_cs*] \
		               [get_pins $CORE_MODULE/ilm*_addr*]]
	}
}

group_path -weight 1 \
       -name "RESUME" \
       -through [list [get_pins $IPIPE_MODULE/resume*]] 

group_path -weight 1 \
       -name "REDIRECT" \
       -through [list [get_pins $IPIPE_MODULE/redirect*]] 

group_path -weight 1 \
       -name "DECODE" \
       -through [list [get_nets $IFU_MODULE/ifu_i*_instr*]] 




if {[string equal $NDS_MULTIPLIER "fast"]} {
	group_path -weight 1 \
	       -name "FASTMUL" \
	       -from [list [get_cell $FASTMUL_MODULE/mreq*_reg]] 

	group_path -weight 1 \
	       -name "FASTMULOUT" \
	       -through [list [get_nets $FASTMUL_MODULE/fmul_result*]] 

}

#group_path -weight 2 \
#       -name "LOAD_KILL" \
#       -through [list [get_nets $BIU_MODULE/lsu_biu_load_kill*]] 

