
#set_attribute clock_network_late_latency -430  [find /designs -pin ${LSU_MODULE}/lsu_data_mux/lsu_addr_mm_reg*/C*]

#if {$mmu_support} {
##	set_attribute clock_network_late_latency -300 [find /designs -pin ${LSU_MODULE}/lsu_data_mux/lsu_user_mode_mm_reg*/C*]
##	set_attribute clock_network_late_latency -300  [find /designs -pin ${LSU_MODULE}/lsu_data_mux/lsu_dt_en_reg*/C*]
#}
#
##tmp_end
#if {$mmu_support} {
#	if {[string compare tcb013ghpwc $tech_lib] == 0} {
##		set_attribute clock_network_late_latency -550  [find /designs -pin ${SRU_MODULE}/tlb_acc_misc_reg*/C*]
#	} else {
##		set_attribute clock_network_late_latency -400  [find /designs -pin ${SRU_MODULE}/tlb_acc_misc_reg*/C*]
#	}
##	set_attribute clock_network_late_latency -400  [find /designs -pin ${SRU_MODULE}/mmu_ctl_d_reg*/C*]
##	set_attribute clock_network_late_latency -400  [find /designs -pin ${MMU_MODULE}/dtlb_ctrl/dtlb_entry*_reg*/C*]
#}


#set_attribute clock_network_late_latency  50  [find /designs -pin ${MEM_MODULE}/btb/btb0_data/CLK*]
#set_attribute clock_network_late_latency  50  [find /designs -pin ${MEM_MODULE}/btb/btb1_data/CLK*]
#set_attribute clock_network_late_latency  50  [find /designs -pin ${MEM_MODULE}/btb/btb0_tag/CLK*]
#set_attribute clock_network_late_latency  50  [find /designs -pin ${MEM_MODULE}/btb/btb1_tag/CLK*]
#
##mmu_fcu_pa tmp
#if {$icache_support} {
#	set_attribute clock_network_late_latency  375  [find /designs -pin ${MEM_MODULE}/icache_ram/icache_tag0_way0/CLK*]
#	set_attribute clock_network_late_latency  375  [find /designs -pin ${MEM_MODULE}/icache_ram/icache_tag0_way1/CLK*]
#	set_attribute clock_network_late_latency  375  [find /designs -pin ${MEM_MODULE}/icache_ram/icache_tag1_way0/CLK*]
#	set_attribute clock_network_late_latency  375  [find /designs -pin ${MEM_MODULE}/icache_ram/icache_tag1_way1/CLK*]
#	set_attribute clock_network_late_latency  375  [find /designs -pin ${MEM_MODULE}/icache_ram/icache_data0_way0/CLK*]
#	set_attribute clock_network_late_latency  375  [find /designs -pin ${MEM_MODULE}/icache_ram/icache_data0_way1/CLK*]
#	set_attribute clock_network_late_latency  375  [find /designs -pin ${MEM_MODULE}/icache_ram/icache_data1_way0/CLK*]
#	set_attribute clock_network_late_latency  375  [find /designs -pin ${MEM_MODULE}/icache_ram/icache_data1_way1/CLK*]
#}
#
#if {$btb_support } {
##	set_attribute clock_network_late_latency  60 [find /designs -pin ${UCORE_MODULE}/ifu_btb_mem/btb_ram/Xbtb_ram_model_*/C*] 
#}
#
#if {$dcache_support } {
##	set_attribute clock_network_late_latency -130 [find /designs -pin ${LSU_MODULE}/lsu_mem/lsu_dcu_mem/dcache_ram/clk_2]
#}
#
#if {$ilm_support && !$eilm_support} {
##	set_attribute clock_network_late_latency 100 [find /designs -pin ${FCU_MODULE}/ifetch_memory/ilm_ram/clk*]
#}
#
#if {$icache_support} {
##	set_attribute clock_network_late_latency 0.1 [list [find /designs -pin ${FCU_MODULE}/ifetech_memory/icache_ram/clk_1] \
#                                [find /designs -pin ${FCU_MODULE}/ifetech_memory/icache_ram/clk_2]]
#}
