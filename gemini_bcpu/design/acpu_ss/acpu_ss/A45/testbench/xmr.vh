`ifndef NDS_XMR_VH
`define NDS_XMR_VH

`include "ae350_xmr.vh"

`define NDS_CORE_NAME		a45_core.kv_core

`define NDS_CORE_CLK		`NDS_PLATFORM_CORE.core_clk
`define NDS_CORE_RESETN		`NDS_PLATFORM_CORE.core_resetn
`define NDS_BUS_CLK		`NDS_BENCH.bus_clk
`define NDS_BUS_RESETN		`NDS_BENCH.H_hresetn

	`define NDS_CORE_TOP		`NDS_CPU_SUBSYSTEM.u_kv_core_top0
	`define NDS_CORE0_TOP           `NDS_CPU_SUBSYSTEM.u_kv_core_top0
	`define NDS_CORE1_TOP           `NDS_CPU_SUBSYSTEM.u_kv_core_top1
	`define NDS_CORE2_TOP           `NDS_CPU_SUBSYSTEM.u_kv_core_top2
	`define NDS_CORE3_TOP           `NDS_CPU_SUBSYSTEM.u_kv_core_top3
	`define NDS_CORE4_TOP           `NDS_CPU_SUBSYSTEM.u_kv_core_top4
	`define NDS_CORE5_TOP           `NDS_CPU_SUBSYSTEM.u_kv_core_top5
	`define NDS_CORE6_TOP           `NDS_CPU_SUBSYSTEM.u_kv_core_top6
	`define NDS_CORE7_TOP           `NDS_CPU_SUBSYSTEM.u_kv_core_top7


	`define NDS_CORE        `NDS_CPU_SUBSYSTEM.u_kv_core_top0.a45_core.kv_core


`define NDS_IFU                 `NDS_CORE.kv_ifu
`define NDS_IPIPE               `NDS_CORE.kv_ipipe
`define NDS_IEU                 `NDS_CORE.kv_ieu
`define NDS_ALU                 `NDS_CORE.kv_alu
`define NDS_MDU                 `NDS_CORE.kv_mdu
`define NDS_CSR                 `NDS_CORE.kv_csr
`define NDS_PFM_CSR             `NDS_CSR.kv_pfm_csr
`define NDS_PMP_CSR             `NDS_CORE.kv_pmp.u_pmp_csr
`define NDS_PMA_CSR             `NDS_CORE.kv_pma.u_pma_csr
`define NDS_CMT                 `NDS_CORE.kv_cmt
`define NDS_ICU                 `NDS_CORE.kv_icu
`define NDS_BIU                 `NDS_CORE.kv_biu
`define NDS_LSU                 `NDS_CORE.kv_lsu
`define NDS_LSPIPE              `NDS_LSU.u_lspipe
`define NDS_LSUOP		`NDS_LSU.u_lsuop
`define NDS_DCU                 `NDS_CORE.kv_dcu
`define NDS_INTC                `NDS_CORE.kv_intc
`define NDS_TRIGM               `NDS_CORE.kv_trigm

`define	NDS_ACE			u_ace
`define	NDS_FPU			`NDS_CORE.gen_fpipe.kv_fpu
`define	NDS_FPIPE		`NDS_FPU.kv_fpipe
`define NDS_FPU_EU              `NDS_FPU.kv_fpu_eu

`define	NDS_VPU                 `NDS_CORE.gen_vpu.kv_vpu

`define NDS_VPU_FPA_FRONTEND    `NDS_VPU.gen_fpa_frontend.fpa_frontend
`define NDS_FRF                 `NDS_VPU_FPA_FRONTEND.frf
`define NDS_FPIQ                `NDS_VPU_FPA_FRONTEND.fpiq

		`define NDS_ILM0			`NDS_CORE_TOP



`ifdef NDS_IO_DLM_TL_UL
		`define NDS_HART0_DLM0			`NDS_CPU_SUBSYSTEM.u_dlm_ram0.ram_inst.mem
		`define NDS_HART1_DLM0			`NDS_CPU_SUBSYSTEM.u_dlm_ram0.ram_inst.mem
		`define NDS_HART2_DLM0			`NDS_CPU_SUBSYSTEM.u_dlm_ram0.ram_inst.mem
		`define NDS_HART3_DLM0			`NDS_CPU_SUBSYSTEM.u_dlm_ram0.ram_inst.mem
		`define NDS_HART4_DLM0			`NDS_CPU_SUBSYSTEM.u_dlm_ram0.ram_inst.mem
		`define NDS_HART5_DLM0			`NDS_CPU_SUBSYSTEM.u_dlm_ram0.ram_inst.mem
		`define NDS_HART6_DLM0			`NDS_CPU_SUBSYSTEM.u_dlm_ram0.ram_inst.mem
		`define NDS_HART7_DLM0			`NDS_CPU_SUBSYSTEM.u_dlm_ram0.ram_inst.mem

`else







		`define NDS_HART0_DLM0			`NDS_CORE_TOP.u_dlm_ram0.ram_inst.mem
		`define NDS_HART0_DLM1			`NDS_CORE_TOP.u_dlm_ram1.ram_inst.mem
		`define NDS_HART0_DLM2			`NDS_CORE_TOP.u_dlm_ram2.ram_inst.mem
		`define NDS_HART0_DLM3			`NDS_CORE_TOP.u_dlm_ram3.ram_inst.mem

`endif

`define MRET_WB			`NDS_CORE0.`NDS_IPIPE.wb_reg_trap_ret

`define NDS_EDM_DIMU_EXECUTE    `NDS_EDM.dimu_execute_tck

`define NDS_DEBUG_SUBSYSTEM	`NDS_CPU_SUBSYSTEM.u_pldm

`endif
