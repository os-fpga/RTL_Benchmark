# This is the aeX50's FPFA synthesis/STA constraint for the ORCA board.
#
# Note:
# * For SPI-related commands/constraints, please check atcspi200.sdc for the details.
# * This constraint file is only for the pure Xilinx Vivado flow.
#   - Synopsys Synplify + Xilinx Vivado may fail to process these complex SPI constraints.

# ====================
# Variable settings
# ====================

#
# User-frequently-changed variables
#

# spi_mode
# By default, use spi_mode[1:0]==2'b11. The user can override spi_mode in the caller script.
if {! [info exists spi_mode_0]} {
	set spi_mode_0			1
}
if {! [info exists spi_mode_1]} {
	set spi_mode_1			1
}

# Relax delay ratio for FPGA when the timing constraint can't be met
set spi_in_max_ratio		0.10
set spi_in_min_ratio		0.00
set spi_mst_out_max_ratio	0.40
set spi_mst_out_min_ratio	0.00
set spi_slv_out_max_ratio	0.70
set spi_slv_out_min_ratio	0.00
set spi_cdc_margin		0.50
set misc_in_max_ratio		0.70
set misc_in_min_ratio		0.05
set misc_out_max_ratio		0.50
set misc_out_min_ratio		0.05


# ====================
# Clocks period settings
# ====================
if {![info exists env(core_clk_period)]} {
	set core_clk_period		16.667
} else {
	set core_clk_period		$env(core_clk_period)
}

if {![info exists env(hclk_period)]} {
	set hclk_period			[expr $core_clk_period * 1.0]
} else {
	set hclk_period			$env(hclk_period)
}

if {![info exists env(pclk_period)]} {
	set pclk_period			[expr $hclk_period * 1.0]
} else {
	set pclk_period			$env(pclk_period)
}

if {![info exists env(jdtm_clk_period)]} {
	set jdtm_clk_period		41.667
} else {
	set jdtm_clk_period		$env(jdtm_clk_period)
}

if {![info exists env(uclk_period)]} {
	set uclk_period			25.0
} else {
	set uclk_period			$env(uclk_period)
}

if {![info exists env(spi_clk_period)]} {
	set spi_clk_period		15.18
} else {
	set spi_clk_period		$env(spi_clk_period)
}

if {![info exists env(spi_clk_latency)]} {
	set spi_clk_latency		[expr $spi_clk_period * 0.8]
} else {
	set spi_clk_latency		$env(spi_clk_latency)
}

if {![info exists env(s_sclk_period)]} {
	set spi_s_sclk_period		[expr $spi_clk_period * 4.0]
} else {
	set spi_s_sclk_period		$env(spi_s_sclk_period)
}

if {![info exists env(m_sclk_delay)]} {
	set spi_m_sclk_delay		[expr $spi_clk_period * 0.9]
} else {
	set spi_m_sclk_delay		$env(spi_m_sclk_delay)
}

if {![info exists env(osch_period)]} {
    if {$board_vcu118} {
        set osch_period			8.0
    } else {
        set osch_period			50.0
    }
} else {
	set osch_period			$env(osch_period)
}

if {![info exists env(oscl_period)]} {
	set oscl_period			31250.0
} else {
	set oscl_period			$env(oscl_period)
}

# ====================
# Case analyses
# ====================
if {$spi_support} {
	# Sometimes u_spi_reg/spi_mode*[01]* may be optimized out so let's use u_spi_*.
	set_case_analysis $spi_mode_0	[get_pins ae350_apb_subsystem/u_spi*/u_spi_*/spi_mode*0*]
	set_case_analysis $spi_mode_1	[get_pins ae350_apb_subsystem/u_spi*/u_spi_*/spi_mode*1*]
}


# ====================
# Clock creation
# ====================
create_clock -name OSCH		[get_port X_oschin]					-period $osch_period
create_clock -name OSCL		[get_port X_osclin]					-period $oscl_period

if {$platform_debug_port} {
	create_clock -name JDTM_CLK	[get_port X_tck]					-period $jdtm_clk_period
}

if {$ae350_core_clk_dfs} {
	set bufgmux_in	I
} else {
	set bufgmux_in	I0
}

if {$ae350_core_clk_dfs} {
	#DFS does not need to create generated clock, frequency is depend on mmcm_dfs
	create_clock -name CORE_CLK_ROOT_0	[get_pins ${platform}_aopd/sample_${platform}_clkgen/${platform}_fpga_dfs_wrapper/${platform}_fpga_dfs_clkgen/inst/CLK_CORE_DRP_I/clk_inst/mmcm*_adv_inst/CLKOUT0] -period 10.0
	create_clock -name CORE_CLK_ROOT_1	[get_pins ${platform}_aopd/sample_${platform}_clkgen/${platform}_fpga_dfs_wrapper/${platform}_fpga_dfs_clkgen/inst/CLK_CORE_DRP_I/clk_inst/mmcm*_adv_inst/CLKOUT1] -period 10.0
	create_clock -name CORE_CLK_ROOT_2	[get_pins ${platform}_aopd/sample_${platform}_clkgen/${platform}_fpga_dfs_wrapper/${platform}_fpga_dfs_clkgen/inst/CLK_CORE_DRP_I/clk_inst/mmcm*_adv_inst/CLKOUT2] -period 10.0
	create_clock -name CORE_CLK_ROOT_3	[get_pins ${platform}_aopd/sample_${platform}_clkgen/${platform}_fpga_dfs_wrapper/${platform}_fpga_dfs_clkgen/inst/CLK_CORE_DRP_I/clk_inst/mmcm*_adv_inst/CLKOUT3] -period 10.0
	if {$has_hart_7 && $board_vcu118} {
		set_property CLOCK_DEDICATED_ROUTE ANY_CMT_COLUMN [get_nets ${platform}_aopd/sample_${platform}_clkgen/${platform}_fpga_dfs_wrapper/${platform}_fpga_dfs_clkgen/inst/CLK_CORE_DRP_I/clk_inst/clk_out1]
		set_property CLOCK_DEDICATED_ROUTE ANY_CMT_COLUMN [get_nets ${platform}_aopd/sample_${platform}_clkgen/${platform}_fpga_dfs_wrapper/${platform}_fpga_dfs_clkgen/inst/CLK_CORE_DRP_I/clk_inst/clk_out2]
		set_property CLOCK_DEDICATED_ROUTE ANY_CMT_COLUMN [get_nets ${platform}_aopd/sample_${platform}_clkgen/${platform}_fpga_dfs_wrapper/${platform}_fpga_dfs_clkgen/inst/CLK_CORE_DRP_I/clk_inst/clk_out3]
		set_property CLOCK_DEDICATED_ROUTE ANY_CMT_COLUMN [get_nets ${platform}_aopd/sample_${platform}_clkgen/${platform}_fpga_dfs_wrapper/${platform}_fpga_dfs_clkgen/inst/CLK_CORE_DRP_I/clk_inst/clk_out4]
	}
} elseif {$core_clk_use_40m} {
	create_generated_clock -name CLK_40M	[get_pins ${platform}_aopd/sample_${platform}_clkgen/${platform}_fpga_clkgen/inst/mmcm*_adv_inst/CLKOUT2]
	create_generated_clock -name CLK_20M	[get_pins ${platform}_aopd/sample_${platform}_clkgen/${platform}_fpga_clkgen/inst/mmcm*_adv_inst/CLKOUT3]
	if {$has_hart_7 && $board_vcu118} {
                set_property CLOCK_DEDICATED_ROUTE ANY_CMT_COLUMN [get_nets ${platform}_aopd/sample_${platform}_clkgen/${platform}_fpga_clkgen/inst/clk_out3]
                set_property CLOCK_DEDICATED_ROUTE ANY_CMT_COLUMN [get_nets ${platform}_aopd/sample_${platform}_clkgen/${platform}_fpga_clkgen/inst/clk_out4]
        }
} elseif {$core_clk_use_20m} {
	create_generated_clock -name CLK_20M	[get_pins ${platform}_aopd/sample_${platform}_clkgen/${platform}_fpga_clkgen/inst/mmcm*_adv_inst/CLKOUT3]
	create_generated_clock -name CLK_10M	[get_pins ${platform}_aopd/sample_${platform}_clkgen/${platform}_fpga_clkgen/inst/mmcm*_adv_inst/CLKOUT6]
} else {
	create_generated_clock -name CLK_60M	[get_pins ${platform}_aopd/sample_${platform}_clkgen/${platform}_fpga_clkgen/inst/mmcm*_adv_inst/CLKOUT0]
	create_generated_clock -name CLK_30M	[get_pins ${platform}_aopd/sample_${platform}_clkgen/${platform}_fpga_clkgen/inst/mmcm*_adv_inst/CLKOUT1]
}

if {$uart_support} {
	create_generated_clock -name UART_CLK	[get_pins ${platform}_aopd/sample_${platform}_clkgen/${platform}_fpga_clkgen/inst/mmcm*_adv_inst/CLKOUT4]
}

set spi_clk_root [get_pins ${platform}_aopd/sample_${platform}_clkgen/${platform}_fpga_clkgen/inst/mmcm*_adv_inst/${spi_clk_source}]
create_generated_clock -name SPI_CLOCK	${spi_clk_root}


# Only select the fastest clock to reduce the constraint complexity.
create_generated_clock -name ROOT_CLK		[get_pins ${platform}_aopd/sample_${platform}_clkgen/ROOT_CLK_MUX_INST/O]	-divide_by 1 -source [get_pins ${platform}_aopd/sample_${platform}_clkgen/ROOT_CLK_MUX_INST/I0]
if {$ae350_core_clk_dfs} {
	create_generated_clock -name ROOT_DFS_CLK0	[get_pins ${platform}_aopd/sample_${platform}_clkgen/ROOT_DFS_CLK_0_MUX_INST/O]	-divide_by 1 -source [get_pins ${platform}_aopd/sample_${platform}_clkgen/ROOT_DFS_CLK_0_MUX_INST/I]
	create_generated_clock -name ROOT_DFS_CLK1	[get_pins ${platform}_aopd/sample_${platform}_clkgen/ROOT_DFS_CLK_1_MUX_INST/O]	-divide_by 1 -source [get_pins ${platform}_aopd/sample_${platform}_clkgen/ROOT_DFS_CLK_1_MUX_INST/I]
	create_generated_clock -name ROOT_DFS_CLK2	[get_pins ${platform}_aopd/sample_${platform}_clkgen/ROOT_DFS_CLK_2_MUX_INST/O]	-divide_by 1 -source [get_pins ${platform}_aopd/sample_${platform}_clkgen/ROOT_DFS_CLK_2_MUX_INST/I]
	create_generated_clock -name ROOT_DFS_CLK3	[get_pins ${platform}_aopd/sample_${platform}_clkgen/ROOT_DFS_CLK_3_MUX_INST/O]	-divide_by 1 -source [get_pins ${platform}_aopd/sample_${platform}_clkgen/ROOT_DFS_CLK_3_MUX_INST/I]
	create_generated_clock -name ROOT_DFS_CLK4	[get_pins ${platform}_aopd/sample_${platform}_clkgen/ROOT_DFS_CLK_4_MUX_INST/O]	-divide_by 1 -source [get_pins ${platform}_aopd/sample_${platform}_clkgen/ROOT_DFS_CLK_4_MUX_INST/I]
	create_generated_clock -name ROOT_DFS_CLK5	[get_pins ${platform}_aopd/sample_${platform}_clkgen/ROOT_DFS_CLK_5_MUX_INST/O]	-divide_by 1 -source [get_pins ${platform}_aopd/sample_${platform}_clkgen/ROOT_DFS_CLK_5_MUX_INST/I]
	create_generated_clock -name ROOT_DFS_CLK6	[get_pins ${platform}_aopd/sample_${platform}_clkgen/ROOT_DFS_CLK_6_MUX_INST/O]	-divide_by 1 -source [get_pins ${platform}_aopd/sample_${platform}_clkgen/ROOT_DFS_CLK_6_MUX_INST/I]
	create_generated_clock -name ROOT_DFS_CLK7	[get_pins ${platform}_aopd/sample_${platform}_clkgen/ROOT_DFS_CLK_7_MUX_INST/O]	-divide_by 1 -source [get_pins ${platform}_aopd/sample_${platform}_clkgen/ROOT_DFS_CLK_7_MUX_INST/I]
}

create_generated_clock -name CORE_CLK	[get_pins ${platform}_aopd/sample_${platform}_clkgen/gen_bufg[0].CORE_CLK_MUX_INST/O]	-divide_by 1 -source [get_pins ${platform}_aopd/sample_${platform}_clkgen/gen_bufg[0].CORE_CLK_MUX_INST/${bufgmux_in}]
create_generated_clock -name DC_CLK	[get_pins ${platform}_aopd/sample_${platform}_clkgen/gen_bufg[0].DC_CLK_MUX_INST/O]	-divide_by 1 -source [get_pins ${platform}_aopd/sample_${platform}_clkgen/gen_bufg[0].DC_CLK_MUX_INST/${bufgmux_in}]
create_generated_clock -name LM_CLK	[get_pins ${platform}_aopd/sample_${platform}_clkgen/gen_bufg[0].LM_CLK_MUX_INST/O]	-divide_by 1 -source [get_pins ${platform}_aopd/sample_${platform}_clkgen/gen_bufg[0].LM_CLK_MUX_INST/${bufgmux_in}]

if {$has_ilm_tl_ul} {
	if {$cluster_support} {
		if {$has_hart_0} {
			create_generated_clock -name ILM_TL_UL_CLK0 [get_pins ae350_cpu_cluster_subsystem/u_core0_ilm_clock_gen/TL_UL_CLK_MUX_INST/O] -divide_by 2 -source [get_pins ${platform}_aopd/sample_${platform}_clkgen/gen_bufg[0].LM_CLK_MUX_INST/O]	
		}
		if {$has_hart_1} {
			create_generated_clock -name ILM_TL_UL_CLK1 [get_pins ae350_cpu_cluster_subsystem/u_core1_ilm_clock_gen/TL_UL_CLK_MUX_INST/O] -divide_by 2 -source [get_pins ${platform}_aopd/sample_${platform}_clkgen/gen_bufg[1].LM_CLK_MUX_INST/O]	
		}
		if {$has_hart_3} {
			create_generated_clock -name ILM_TL_UL_CLK2 [get_pins ae350_cpu_cluster_subsystem/u_core2_ilm_clock_gen/TL_UL_CLK_MUX_INST/O] -divide_by 2 -source [get_pins ${platform}_aopd/sample_${platform}_clkgen/gen_bufg[2].LM_CLK_MUX_INST/O]	
			create_generated_clock -name ILM_TL_UL_CLK3 [get_pins ae350_cpu_cluster_subsystem/u_core3_ilm_clock_gen/TL_UL_CLK_MUX_INST/O] -divide_by 2 -source [get_pins ${platform}_aopd/sample_${platform}_clkgen/gen_bufg[3].LM_CLK_MUX_INST/O]	
		}
		if {$has_hart_7} {
			create_generated_clock -name ILM_TL_UL_CLK4 [get_pins ae350_cpu_cluster_subsystem/u_core4_ilm_clock_gen/TL_UL_CLK_MUX_INST/O] -divide_by 2 -source [get_pins ${platform}_aopd/sample_${platform}_clkgen/gen_bufg[4].LM_CLK_MUX_INST/O]	
			create_generated_clock -name ILM_TL_UL_CLK5 [get_pins ae350_cpu_cluster_subsystem/u_core5_ilm_clock_gen/TL_UL_CLK_MUX_INST/O] -divide_by 2 -source [get_pins ${platform}_aopd/sample_${platform}_clkgen/gen_bufg[5].LM_CLK_MUX_INST/O]	
			create_generated_clock -name ILM_TL_UL_CLK6 [get_pins ae350_cpu_cluster_subsystem/u_core6_ilm_clock_gen/TL_UL_CLK_MUX_INST/O] -divide_by 2 -source [get_pins ${platform}_aopd/sample_${platform}_clkgen/gen_bufg[6].LM_CLK_MUX_INST/O]	
			create_generated_clock -name ILM_TL_UL_CLK7 [get_pins ae350_cpu_cluster_subsystem/u_core7_ilm_clock_gen/TL_UL_CLK_MUX_INST/O] -divide_by 2 -source [get_pins ${platform}_aopd/sample_${platform}_clkgen/gen_bufg[7].LM_CLK_MUX_INST/O]	
		}
	} else {
		create_generated_clock -name ILM_TL_UL_CLK [get_pins ae350_cpu_subsystem/u_clock_gen/TL_UL_CLK_MUX_INST/O] -divide_by 2 -source [get_pins ${platform}_aopd/sample_${platform}_clkgen/gen_bufg[0].LM_CLK_MUX_INST/O]
	}
}

create_generated_clock -name HCLK	 [get_pins ${platform}_aopd/sample_${platform}_clkgen/HCLK_MUX_INST/O]		-divide_by 1 -source [get_pins ${platform}_aopd/sample_${platform}_clkgen/HCLK_MUX_INST/I0]
create_generated_clock -name PCLK	 [get_pins ${platform}_aopd/sample_${platform}_clkgen/PCLK_MUX_INST/O]		-divide_by 1 -source [get_pins ${platform}_aopd/sample_${platform}_clkgen/PCLK_MUX_INST/I0]

if {$l2c_support} {
        create_generated_clock -name L2_CLK                 [get_pins ${platform}_aopd/sample_${platform}_clkgen/L2_CLK_MUX_INST/O]                          -divide_by 1 -source [get_pins ${platform}_aopd/sample_${platform}_clkgen/L2_CLK_MUX_INST/I0]
        create_generated_clock -name L2C_BANK0_DATA_RAM_CLK [get_pins ae350_cpu_cluster_subsystem/u_cluster/u_l2/u_l2c_bank0_data_ram_clkgen/CLK_MUX_INST/O] -divide_by 2 -source [get_pins ${platform}_aopd/sample_${platform}_clkgen/L2_CLK_MUX_INST/O]
        create_generated_clock -name L2C_BANK1_DATA_RAM_CLK [get_pins ae350_cpu_cluster_subsystem/u_cluster/u_l2/u_l2c_bank1_data_ram_clkgen/CLK_MUX_INST/O] -divide_by 2 -source [get_pins ${platform}_aopd/sample_${platform}_clkgen/L2_CLK_MUX_INST/O]
	if {$l2c_4bank_support} {
	        create_generated_clock -name L2C_BANK2_DATA_RAM_CLK [get_pins ae350_cpu_cluster_subsystem/u_cluster/u_l2/u_l2c_bank2_data_ram_clkgen/CLK_MUX_INST/O] -divide_by 2 -source [get_pins ${platform}_aopd/sample_${platform}_clkgen/L2_CLK_MUX_INST/O]
		create_generated_clock -name L2C_BANK3_DATA_RAM_CLK [get_pins ae350_cpu_cluster_subsystem/u_cluster/u_l2/u_l2c_bank3_data_ram_clkgen/CLK_MUX_INST/O] -divide_by 2 -source [get_pins ${platform}_aopd/sample_${platform}_clkgen/L2_CLK_MUX_INST/O]
	}
}

create_generated_clock -name ACLK	 [get_pins ${platform}_aopd/sample_${platform}_clkgen/ACLK_MUX_INST/O]		-divide_by 1 -source [get_pins ${platform}_aopd/sample_${platform}_clkgen/ACLK_MUX_INST/I0]
create_generated_clock -name DMCLK	 [get_pins ${platform}_aopd/sample_${platform}_clkgen/DEBUG_CLK_MUX_INST/O]	-divide_by 1 -source [get_pins ${platform}_aopd/sample_${platform}_clkgen/DEBUG_CLK_MUX_INST/I0]

# create CORE_CLK* for mpcore
if {[llength [get_pins -quiet ${platform}_aopd/sample_${platform}_clkgen/gen_bufg[1].CORE_CLK_MUX_INST/O]]} {
        create_generated_clock -name CORE_CLK1	[get_pins ${platform}_aopd/sample_${platform}_clkgen/gen_bufg[1].CORE_CLK_MUX_INST/O]	-divide_by 1 -source [get_pins ${platform}_aopd/sample_${platform}_clkgen/gen_bufg[1].CORE_CLK_MUX_INST/${bufgmux_in}]
}
if {[llength [get_pins -quiet ${platform}_aopd/sample_${platform}_clkgen/gen_bufg[2].CORE_CLK_MUX_INST/O]]} {
        create_generated_clock -name CORE_CLK2	[get_pins ${platform}_aopd/sample_${platform}_clkgen/gen_bufg[2].CORE_CLK_MUX_INST/O]	-divide_by 1 -source [get_pins ${platform}_aopd/sample_${platform}_clkgen/gen_bufg[2].CORE_CLK_MUX_INST/${bufgmux_in}]
}
if {[llength [get_pins -quiet ${platform}_aopd/sample_${platform}_clkgen/gen_bufg[3].CORE_CLK_MUX_INST/O]]} {
        create_generated_clock -name CORE_CLK3	[get_pins ${platform}_aopd/sample_${platform}_clkgen/gen_bufg[3].CORE_CLK_MUX_INST/O]	-divide_by 1 -source [get_pins ${platform}_aopd/sample_${platform}_clkgen/gen_bufg[3].CORE_CLK_MUX_INST/${bufgmux_in}]
}
if {[llength [get_pins -quiet ${platform}_aopd/sample_${platform}_clkgen/gen_bufg[4].CORE_CLK_MUX_INST/O]]} {
        create_generated_clock -name CORE_CLK4	[get_pins ${platform}_aopd/sample_${platform}_clkgen/gen_bufg[4].CORE_CLK_MUX_INST/O]	-divide_by 1 -source [get_pins ${platform}_aopd/sample_${platform}_clkgen/gen_bufg[4].CORE_CLK_MUX_INST/${bufgmux_in}]
}
if {[llength [get_pins -quiet ${platform}_aopd/sample_${platform}_clkgen/gen_bufg[5].CORE_CLK_MUX_INST/O]]} {
        create_generated_clock -name CORE_CLK5	[get_pins ${platform}_aopd/sample_${platform}_clkgen/gen_bufg[5].CORE_CLK_MUX_INST/O]	-divide_by 1 -source [get_pins ${platform}_aopd/sample_${platform}_clkgen/gen_bufg[5].CORE_CLK_MUX_INST/${bufgmux_in}]
}
if {[llength [get_pins -quiet ${platform}_aopd/sample_${platform}_clkgen/gen_bufg[6].CORE_CLK_MUX_INST/O]]} {
        create_generated_clock -name CORE_CLK6	[get_pins ${platform}_aopd/sample_${platform}_clkgen/gen_bufg[6].CORE_CLK_MUX_INST/O]	-divide_by 1 -source [get_pins ${platform}_aopd/sample_${platform}_clkgen/gen_bufg[6].CORE_CLK_MUX_INST/${bufgmux_in}]
}
if {[llength [get_pins -quiet ${platform}_aopd/sample_${platform}_clkgen/gen_bufg[7].CORE_CLK_MUX_INST/O]]} {
        create_generated_clock -name CORE_CLK7	[get_pins ${platform}_aopd/sample_${platform}_clkgen/gen_bufg[7].CORE_CLK_MUX_INST/O]	-divide_by 1 -source [get_pins ${platform}_aopd/sample_${platform}_clkgen/gen_bufg[7].CORE_CLK_MUX_INST/${bufgmux_in}]
}

# create DC_CLK* for mpcore
if {[llength [get_pins -quiet ${platform}_aopd/sample_${platform}_clkgen/gen_bufg[1].DC_CLK_MUX_INST/O]]} {
        create_generated_clock -name DC_CLK1	[get_pins ${platform}_aopd/sample_${platform}_clkgen/gen_bufg[1].DC_CLK_MUX_INST/O]	-divide_by 1 -source [get_pins ${platform}_aopd/sample_${platform}_clkgen/gen_bufg[1].DC_CLK_MUX_INST/${bufgmux_in}]
}
if {[llength [get_pins -quiet ${platform}_aopd/sample_${platform}_clkgen/gen_bufg[2].DC_CLK_MUX_INST/O]]} {
        create_generated_clock -name DC_CLK2	[get_pins ${platform}_aopd/sample_${platform}_clkgen/gen_bufg[2].DC_CLK_MUX_INST/O]	-divide_by 1 -source [get_pins ${platform}_aopd/sample_${platform}_clkgen/gen_bufg[2].DC_CLK_MUX_INST/${bufgmux_in}]
}
if {[llength [get_pins -quiet ${platform}_aopd/sample_${platform}_clkgen/gen_bufg[3].DC_CLK_MUX_INST/O]]} {
        create_generated_clock -name DC_CLK3	[get_pins ${platform}_aopd/sample_${platform}_clkgen/gen_bufg[3].DC_CLK_MUX_INST/O]	-divide_by 1 -source [get_pins ${platform}_aopd/sample_${platform}_clkgen/gen_bufg[3].DC_CLK_MUX_INST/${bufgmux_in}]
}
if {[llength [get_pins -quiet ${platform}_aopd/sample_${platform}_clkgen/gen_bufg[4].DC_CLK_MUX_INST/O]]} {
        create_generated_clock -name DC_CLK4	[get_pins ${platform}_aopd/sample_${platform}_clkgen/gen_bufg[4].DC_CLK_MUX_INST/O]	-divide_by 1 -source [get_pins ${platform}_aopd/sample_${platform}_clkgen/gen_bufg[4].DC_CLK_MUX_INST/${bufgmux_in}]
}
if {[llength [get_pins -quiet ${platform}_aopd/sample_${platform}_clkgen/gen_bufg[5].DC_CLK_MUX_INST/O]]} {
        create_generated_clock -name DC_CLK5	[get_pins ${platform}_aopd/sample_${platform}_clkgen/gen_bufg[5].DC_CLK_MUX_INST/O]	-divide_by 1 -source [get_pins ${platform}_aopd/sample_${platform}_clkgen/gen_bufg[5].DC_CLK_MUX_INST/${bufgmux_in}]
}
if {[llength [get_pins -quiet ${platform}_aopd/sample_${platform}_clkgen/gen_bufg[6].DC_CLK_MUX_INST/O]]} {
        create_generated_clock -name DC_CLK6	[get_pins ${platform}_aopd/sample_${platform}_clkgen/gen_bufg[6].DC_CLK_MUX_INST/O]	-divide_by 1 -source [get_pins ${platform}_aopd/sample_${platform}_clkgen/gen_bufg[6].DC_CLK_MUX_INST/${bufgmux_in}]
}
if {[llength [get_pins -quiet ${platform}_aopd/sample_${platform}_clkgen/gen_bufg[7].DC_CLK_MUX_INST/O]]} {
        create_generated_clock -name DC_CLK7	[get_pins ${platform}_aopd/sample_${platform}_clkgen/gen_bufg[7].DC_CLK_MUX_INST/O]	-divide_by 1 -source [get_pins ${platform}_aopd/sample_${platform}_clkgen/gen_bufg[7].DC_CLK_MUX_INST/${bufgmux_in}]
}

# create LM_CLK* for mpcore
if {[llength [get_pins -quiet ${platform}_aopd/sample_${platform}_clkgen/gen_bufg[1].LM_CLK_MUX_INST/O]]} {
        create_generated_clock -name LM_CLK1	[get_pins ${platform}_aopd/sample_${platform}_clkgen/gen_bufg[1].LM_CLK_MUX_INST/O]	-divide_by 1 -source [get_pins ${platform}_aopd/sample_${platform}_clkgen/gen_bufg[1].LM_CLK_MUX_INST/${bufgmux_in}]
}
if {[llength [get_pins -quiet ${platform}_aopd/sample_${platform}_clkgen/gen_bufg[2].LM_CLK_MUX_INST/O]]} {
        create_generated_clock -name LM_CLK2	[get_pins ${platform}_aopd/sample_${platform}_clkgen/gen_bufg[2].LM_CLK_MUX_INST/O]	-divide_by 1 -source [get_pins ${platform}_aopd/sample_${platform}_clkgen/gen_bufg[2].LM_CLK_MUX_INST/${bufgmux_in}]
}
if {[llength [get_pins -quiet ${platform}_aopd/sample_${platform}_clkgen/gen_bufg[3].LM_CLK_MUX_INST/O]]} {
        create_generated_clock -name LM_CLK3	[get_pins ${platform}_aopd/sample_${platform}_clkgen/gen_bufg[3].LM_CLK_MUX_INST/O]	-divide_by 1 -source [get_pins ${platform}_aopd/sample_${platform}_clkgen/gen_bufg[3].LM_CLK_MUX_INST/${bufgmux_in}]
}
if {[llength [get_pins -quiet ${platform}_aopd/sample_${platform}_clkgen/gen_bufg[4].LM_CLK_MUX_INST/O]]} {
        create_generated_clock -name LM_CLK4	[get_pins ${platform}_aopd/sample_${platform}_clkgen/gen_bufg[4].LM_CLK_MUX_INST/O]	-divide_by 1 -source [get_pins ${platform}_aopd/sample_${platform}_clkgen/gen_bufg[4].LM_CLK_MUX_INST/${bufgmux_in}]
}
if {[llength [get_pins -quiet ${platform}_aopd/sample_${platform}_clkgen/gen_bufg[5].LM_CLK_MUX_INST/O]]} {
        create_generated_clock -name LM_CLK5	[get_pins ${platform}_aopd/sample_${platform}_clkgen/gen_bufg[5].LM_CLK_MUX_INST/O]	-divide_by 1 -source [get_pins ${platform}_aopd/sample_${platform}_clkgen/gen_bufg[5].LM_CLK_MUX_INST/${bufgmux_in}]
}
if {[llength [get_pins -quiet ${platform}_aopd/sample_${platform}_clkgen/gen_bufg[6].LM_CLK_MUX_INST/O]]} {
        create_generated_clock -name LM_CLK6	[get_pins ${platform}_aopd/sample_${platform}_clkgen/gen_bufg[6].LM_CLK_MUX_INST/O]	-divide_by 1 -source [get_pins ${platform}_aopd/sample_${platform}_clkgen/gen_bufg[6].LM_CLK_MUX_INST/${bufgmux_in}]
}
if {[llength [get_pins -quiet ${platform}_aopd/sample_${platform}_clkgen/gen_bufg[7].LM_CLK_MUX_INST/O]]} {
        create_generated_clock -name LM_CLK7	[get_pins ${platform}_aopd/sample_${platform}_clkgen/gen_bufg[7].LM_CLK_MUX_INST/O]	-divide_by 1 -source [get_pins ${platform}_aopd/sample_${platform}_clkgen/gen_bufg[7].LM_CLK_MUX_INST/${bufgmux_in}]
}

create_generated_clock -name AOPD_ROOT_CLK	[get_pins ${platform}_aopd/sample_${platform}_clkgen/AOPD_ROOT_CLK_MUX_INST/O]	-divide_by 1 -source [get_pins ${platform}_aopd/sample_${platform}_clkgen/AOPD_ROOT_CLK_MUX_INST/I0]
create_generated_clock -name AOPD_PCLK	[get_pins ${platform}_aopd/sample_${platform}_clkgen/AOPD_PCLK_MUX_INST/O]		-divide_by 1 -source [get_pins ${platform}_aopd/sample_${platform}_clkgen/AOPD_PCLK_MUX_INST/I0]

if {$spi1_slave_support || $spi2_slave_support} {
	create_generated_clock -name CDC_SPI_CLOCK [get_nets *spi_clk*] -divide_by 1 -source ${spi_clk_root} -master [get_clocks SPI_CLOCK] -add
}

if {$spi1_support} {
	create_generated_clock [get_nets ae350_apb_subsystem/u_spi1/u_spi_spiif/master_sclk_r] -name SPI1_CLOCK_DIV -divide_by 2 -source ${spi_clk_root}

	if {$spi_mode_0 == $spi_mode_1} {
		create_generated_clock [get_ports X_spi1_clk] -name SPI1_M_SCLK_ORG -divide_by 1 -source ${spi_clk_root} -master [get_clocks SPI_CLOCK] -add -invert
	} else {
		create_generated_clock [get_ports X_spi1_clk] -name SPI1_M_SCLK_ORG -divide_by 1 -source ${spi_clk_root} -master [get_clocks SPI_CLOCK] -add 
	}
	if {$spi_mode_1} {
		create_generated_clock [get_ports X_spi1_clk] -name SPI1_M_SCLK_DIV -divide_by 1 -source [get_pins -of_objects [get_nets ae350_apb_subsystem/u_spi1/u_spi_spiif/master_sclk_r] -leaf -filter {DIRECTION == OUT} ] -master [get_clocks SPI1_CLOCK_DIV] -add -invert
	} else {
		create_generated_clock [get_ports X_spi1_clk] -name SPI1_M_SCLK_DIV -divide_by 1 -source [get_pins -of_objects [get_nets ae350_apb_subsystem/u_spi1/u_spi_spiif/master_sclk_r] -leaf -filter {DIRECTION == OUT} ] -master [get_clocks SPI1_CLOCK_DIV] -add
	}

	if {$spi1_slave_support} {
		create_clock [get_ports X_spi1_clk] -name SPI1_S_SCLK		-period $spi_s_sclk_period -waveform [list 0 [expr $spi_s_sclk_period / 2.0]] -add
		create_clock [get_ports X_spi1_clk] -name CDC_SPI1_S_SCLK	-period $spi_s_sclk_period -add
	}
}

if {$spi2_support} {
	create_generated_clock [get_nets ae350_apb_subsystem/u_spi2/u_spi_spiif/master_sclk_r] -name SPI2_CLOCK_DIV -divide_by 2 -source ${spi_clk_root}

	if {$spi_mode_0 == $spi_mode_1} {
		create_generated_clock [get_ports X_spi2_clk] -name SPI2_M_SCLK_ORG -divide_by 1 -source ${spi_clk_root} -master [get_clocks SPI_CLOCK] -add -invert
	} else {
		create_generated_clock [get_ports X_spi2_clk] -name SPI2_M_SCLK_ORG -divide_by 1 -source ${spi_clk_root} -master [get_clocks SPI_CLOCK] -add 
	}
	if {$spi_mode_1} {
		create_generated_clock [get_ports X_spi2_clk] -name SPI2_M_SCLK_DIV -divide_by 1 -source [get_pins -of_objects [get_nets ae350_apb_subsystem/u_spi2/u_spi_spiif/master_sclk_r] -leaf -filter {DIRECTION == OUT} ] -master [get_clocks SPI2_CLOCK_DIV] -add -invert
	} else {
		create_generated_clock [get_ports X_spi2_clk] -name SPI2_M_SCLK_DIV -divide_by 1 -source [get_pins -of_objects [get_nets ae350_apb_subsystem/u_spi2/u_spi_spiif/master_sclk_r] -leaf -filter {DIRECTION == OUT} ] -master [get_clocks SPI2_CLOCK_DIV] -add
	}

	if {$spi2_slave_support} {
		create_clock [get_ports X_spi2_clk] -name SPI2_S_SCLK		-period $spi_s_sclk_period -waveform [list 0 [expr $spi_s_sclk_period / 2.0]] -add
		create_clock [get_ports X_spi2_clk] -name CDC_SPI2_S_SCLK	-period $spi_s_sclk_period -add
	}
}

# ====================
# Clock relationships
# ====================
set_clock_groups -logically_exclusive -name clkgrp_OSCL -group [get_clocks OSCL]
set_clock_groups -logically_exclusive -name clkgrp_OSCH -group [get_clocks OSCH]

if {$platform_debug_port} {
	set_clock_groups -logically_exclusive -name clkgrp_DTM_CLK -group [get_clocks JDTM_CLK]
}

if {$uart_support} {
	set_clock_groups -logically_exclusive -name clkgrp_UART -group [get_clocks UART_CLK]
}

# The DC_CLK and LM_CLK are only existed in ORCA/BIGORCA
if {$ae350_core_clk_dfs} {
	if {[llength [get_clocks -quiet {CORE_CLK}]]} {
	       	set_clock_groups -logically_exclusive -name clkgrp_CORE0   -group [get_clocks {ROOT_DFS_CLK0 CORE_CLK DC_CLK LM_CLK ILM_TL_UL_CLK0}]
	}
	if {[llength [get_clocks -quiet {CORE_CLK1}]]} {
	       	set_clock_groups -logically_exclusive -name clkgrp_CORE1   -group [get_clocks {ROOT_DFS_CLK1 CORE_CLK1 DC_CLK1 LM_CLK1 ILM_TL_UL_CLK1}]
	}
	if {[llength [get_clocks -quiet {CORE_CLK2}]]} {
	       	set_clock_groups -logically_exclusive -name clkgrp_CORE2   -group [get_clocks {ROOT_DFS_CLK2 CORE_CLK2 DC_CLK2 LM_CLK2 ILM_TL_UL_CLK2}]
	}
	if {[llength [get_clocks -quiet {CORE_CLK3}]]} {
	       	set_clock_groups -logically_exclusive -name clkgrp_CORE3   -group [get_clocks {ROOT_DFS_CLK3 CORE_CLK3 DC_CLK3 LM_CLK3 ILM_TL_UL_CLK3}]
	}
	if {[llength [get_clocks -quiet {CORE_CLK4}]]} {
	       	set_clock_groups -logically_exclusive -name clkgrp_CORE4   -group [get_clocks {ROOT_DFS_CLK4 CORE_CLK4 DC_CLK4 LM_CLK4 ILM_TL_UL_CLK4}]
	}
	if {[llength [get_clocks -quiet {CORE_CLK5}]]} {
	       	set_clock_groups -logically_exclusive -name clkgrp_CORE5   -group [get_clocks {ROOT_DFS_CLK5 CORE_CLK5 DC_CLK5 LM_CLK5 ILM_TL_UL_CLK5}]
	}
	if {[llength [get_clocks -quiet {CORE_CLK6}]]} {
	       	set_clock_groups -logically_exclusive -name clkgrp_CORE6   -group [get_clocks {ROOT_DFS_CLK6 CORE_CLK6 DC_CLK6 LM_CLK6 ILM_TL_UL_CLK6}]
	}
	if {[llength [get_clocks -quiet {CORE_CLK7}]]} {
	       	set_clock_groups -logically_exclusive -name clkgrp_CORE7   -group [get_clocks {ROOT_DFS_CLK7 CORE_CLK7 DC_CLK7 LM_CLK7 ILM_TL_UL_CLK7}]
	}
	if {$l2c_support} {
		if {$l2c_4bank_support} {
			set_clock_groups -logically_exclusive -name clkgrp_PIP     -group [get_clocks {ROOT_CLK HCLK PCLK L2_CLK L2C_BANK0_DATA_RAM_CLK L2C_BANK1_DATA_RAM_CLK L2C_BANK2_DATA_RAM_CLK L2C_BANK3_DATA_RAM_CLK ACLK DMCLK AOPD_PCLK}]
			set_clock_groups -logically_exclusive -name clkgrp_PIP_SPI -group [get_clocks {ROOT_CLK HCLK PCLK L2_CLK L2C_BANK0_DATA_RAM_CLK L2C_BANK1_DATA_RAM_CLK L2C_BANK2_DATA_RAM_CLK L2C_BANK3_DATA_RAM_CLK ACLK DMCLK AOPD_PCLK}] -group [get_clocks SPI*]
		} else {
			set_clock_groups -logically_exclusive -name clkgrp_PIP     -group [get_clocks {ROOT_CLK HCLK PCLK L2_CLK L2C_BANK0_DATA_RAM_CLK L2C_BANK1_DATA_RAM_CLK ACLK DMCLK AOPD_PCLK}]
			set_clock_groups -logically_exclusive -name clkgrp_PIP_SPI -group [get_clocks {ROOT_CLK HCLK PCLK L2_CLK L2C_BANK0_DATA_RAM_CLK L2C_BANK1_DATA_RAM_CLK ACLK DMCLK AOPD_PCLK}] -group [get_clocks SPI*]
		}
	}
} else {
	set clock_list {ROOT_CLK CORE_CLK* DC_CLK* LM_CLK* HCLK PCLK ACLK DMCLK AOPD_PCLK}
	if {$has_ilm_tl_ul} { append clock_list " ILM_TL_UL_CLK*"}
	if {$l2c_support} {
		append clock_list " L2_CLK L2C_BANK0_DATA_RAM_CLK L2C_BANK1_DATA_RAM_CLK"
		if {$l2c_4bank_support}  {
			append clock_list " L2C_BANK2_DATA_RAM_CLK L2C_BANK3_DATA_RAM_CLK"
		}
	}
        set_clock_groups -logically_exclusive -name clkgrp_CORE     -group [get_clocks $clock_list]
        set_clock_groups -logically_exclusive -name clkgrp_CORE_SPI -group [get_clocks $clock_list] -group [get_clocks SPI*]
}

if {$spi_support} {
	set_clock_groups -physically_exclusive -name clkgrp_SPI_M_SCLK_ORG_DIV -group [get_clocks SPI*_M_SCLK_ORG] -group [get_clocks SPI*_M_SCLK_DIV]

	set_clock_groups -asynchronous -name clkgrp_SPI_CLOCK_S_SCLK -group [get_clocks SPI_CLOCK] -group [get_clocks SPI*_S_SCLK]
	set_clock_groups -physically_exclusive -name clkgrp_M_S_SCLK -group [get_clocks SPI*_M_SCLK_*] -group [get_clocks SPI*_S_SCLK]

	# CDC
	set_clock_groups -physically_exclusive -name clkgrp_CDC_SPI_OTHERS -group [get_clocks CDC_SPI*] -group [get_clocks * -filter {NAME !~ "CDC_SPI*"}]

	foreach cdc_clk [get_clocks CDC_SPI*] {
		set_false_path -from $cdc_clk -to $cdc_clk
	}
}

# ====================
# Inputs/Outputs
# ====================
# Resets
set_input_delay 0 -clock OSCH [get_ports X_por_b]
set_input_delay 0 -clock OSCH [get_ports X_hw_rstn]
set_input_delay 0 -clock OSCH [get_ports X_wakeup_in]

# SPI
# The procedure to set input delay for both master and slave modes
proc mode_set_spi_in_delay {clk ports} {
	global spi_mode_1
	global spi_mode_0
	global spi_clk_period
	global spi_in_max_ratio
	global spi_in_min_ratio
	if {$spi_mode_1 == $spi_mode_0} {
		set_input_delay -max [expr $spi_clk_period * $spi_in_max_ratio] -clock $clk [get_ports $ports] -add -clock_fall
		set_input_delay -min [expr $spi_clk_period * $spi_in_min_ratio] -clock $clk [get_ports $ports] -add -clock_fall
	} else {
		set_input_delay -max [expr $spi_clk_period * $spi_in_max_ratio] -clock $clk [get_ports $ports] -add
		set_input_delay -min [expr $spi_clk_period * $spi_in_min_ratio] -clock $clk [get_ports $ports] -add
	}
}

# The procedure to set master-mode output delay
proc mode_set_spi_mst_out_delay {clk ports} {
	global spi_mode_1
	global spi_mode_0
	global spi_clk_period
	global spi_mst_out_max_ratio
	global spi_mst_out_min_ratio
	if {[regexp {SPI._M_SCLK_ORG} $clk]} {
		if {$spi_mode_1 == $spi_mode_0} {
			set_output_delay -max [expr $spi_clk_period * $spi_mst_out_max_ratio] -clock $clk $ports -add -clock_fall
			set_output_delay -min [expr $spi_clk_period * $spi_mst_out_min_ratio] -clock $clk $ports -add -clock_fall
		} else {
			set_output_delay -max [expr $spi_clk_period * $spi_mst_out_max_ratio] -clock $clk $ports -add
			set_output_delay -min [expr $spi_clk_period * $spi_mst_out_min_ratio] -clock $clk $ports -add
		}
	} else {
		# The N:1 clock path: master_sclk_r (SPI._M_SCLK_DIV)
		if {$spi_mode_1 == 0} {
			set_output_delay -max [expr $spi_clk_period * $spi_mst_out_max_ratio] -clock $clk $ports -add
			set_output_delay -min [expr $spi_clk_period * $spi_mst_out_min_ratio] -clock $clk $ports -add
		} else {
			set_output_delay -max [expr $spi_clk_period * $spi_mst_out_max_ratio] -clock $clk $ports -add -clock_fall
			set_output_delay -min [expr $spi_clk_period * $spi_mst_out_min_ratio] -clock $clk $ports -add -clock_fall
		}
	}
}

# The procedure to set slave-mode output delay
proc mode_set_spi_slv_out_delay {clk ports} {
	global spi_mode_1
	global spi_mode_0
	global spi_s_sclk_period
	global spi_slv_out_max_ratio
	global spi_slv_out_min_ratio
	if {$spi_mode_1 == $spi_mode_0} {
		set_output_delay -max [expr $spi_s_sclk_period * $spi_slv_out_max_ratio] -clock $clk $ports -add -clock_fall
		set_output_delay -min [expr $spi_s_sclk_period * $spi_slv_out_min_ratio] -clock $clk $ports -add -clock_fall
	} else {
		set_output_delay -max [expr $spi_s_sclk_period * $spi_slv_out_max_ratio] -clock $clk $ports -add
		set_output_delay -min [expr $spi_s_sclk_period * $spi_slv_out_min_ratio] -clock $clk $ports -add
	}
}

foreach idx {1 2} {
	if {!(($idx == 1 && $spi1_support) || ($idx == 2 && $spi2_support))} {
		continue
	}
	# Master-mode input delay settings
	foreach clk "SPI${idx}_M_SCLK_ORG SPI${idx}_M_SCLK_DIV" {
		mode_set_spi_in_delay $clk [get_ports X_spi${idx}_mosi]
		mode_set_spi_in_delay $clk [get_ports X_spi${idx}_miso]
		if {(($idx == 1) && $spi1_quadspi_support) || (($idx==2) && $spi2_quadspi_support)} {
			mode_set_spi_in_delay $clk [get_ports X_spi${idx}_wpn  ]
			mode_set_spi_in_delay $clk [get_ports X_spi${idx}_holdn]
		}
	}

	# Master-mode output delay settings
	foreach clk "SPI${idx}_M_SCLK_ORG SPI${idx}_M_SCLK_DIV" {
		mode_set_spi_mst_out_delay $clk [get_ports X_spi${idx}_csn]

		mode_set_spi_mst_out_delay $clk [get_ports X_spi${idx}_mosi]
		mode_set_spi_mst_out_delay $clk [get_ports X_spi${idx}_miso]
		if {(($idx == 1) && $spi1_quadspi_support) || (($idx==2) && $spi2_quadspi_support)} {
			mode_set_spi_mst_out_delay $clk [get_ports X_spi${idx}_wpn  ]
			mode_set_spi_mst_out_delay $clk [get_ports X_spi${idx}_holdn]
		}
	}
}

if {$spi1_slave_support} {
	# Input delay settings
	mode_set_spi_in_delay SPI1_S_SCLK [get_ports X_spi1_mosi]
	mode_set_spi_in_delay SPI1_S_SCLK [get_ports X_spi1_miso]

	if {$spi1_quadspi_support} {
		mode_set_spi_in_delay SPI1_S_SCLK [get_ports X_spi1_wpn  ]
		mode_set_spi_in_delay SPI1_S_SCLK [get_ports X_spi1_holdn]
	}

	# Output delay settings
	mode_set_spi_slv_out_delay SPI1_S_SCLK [get_ports X_spi1_mosi]
	mode_set_spi_slv_out_delay SPI1_S_SCLK [get_ports X_spi1_miso]
	if {$spi1_quadspi_support} {
		mode_set_spi_slv_out_delay SPI1_S_SCLK [get_ports X_spi1_wpn  ]
		mode_set_spi_slv_out_delay SPI1_S_SCLK [get_ports X_spi1_holdn]
	}

	set_input_delay -max 0 -clock SPI1_S_SCLK [get_ports X_spi1_csn]
}

if {$spi2_slave_support} {
	# Input delay settings
	mode_set_spi_in_delay SPI2_S_SCLK [get_ports X_spi2_mosi]
	mode_set_spi_in_delay SPI2_S_SCLK [get_ports X_spi2_miso]

	if {$spi2_quadspi_support} {
		mode_set_spi_in_delay SPI2_S_SCLK [get_ports X_spi2_wpn  ]
		mode_set_spi_in_delay SPI2_S_SCLK [get_ports X_spi2_holdn]
	}

	# Output delay settings
	mode_set_spi_slv_out_delay SPI2_S_SCLK [get_ports X_spi2_mosi]
	mode_set_spi_slv_out_delay SPI2_S_SCLK [get_ports X_spi2_miso]
	if {$spi2_quadspi_support} {
		mode_set_spi_slv_out_delay SPI2_S_SCLK [get_ports X_spi2_wpn  ]
		mode_set_spi_slv_out_delay SPI2_S_SCLK [get_ports X_spi2_holdn]
	}

	set_input_delay -max 0 -clock SPI2_S_SCLK [get_ports X_spi2_csn]
}

#-----------------------------------------------------
if {!$jtag_twowire} {
	set_output_delay	3.0		[get_ports X_tdo]		-clock JDTM_CLK	-add_delay
	set_input_delay		26.0		[get_ports X_tdi]		-clock JDTM_CLK	-add_delay
}
if {$platform_debug_port} {
	set_output_delay	1.50		[get_ports X_tms]		-clock JDTM_CLK	-add_delay
	set_input_delay		26.0		[get_ports X_tms]		-clock JDTM_CLK	-add_delay
}

if {[llength [get_ports -quiet X_secure_mode*]]} {
	set_input_delay		0		[get_ports X_secure_mode*]	-clock JDTM_CLK
}


# I2C
if {$iic_support} {
	set_input_delay  -max [expr $pclk_period * $misc_in_max_ratio]	 [get_ports X_i2c_s*]	-clock PCLK	-add_delay
	set_input_delay  -min [expr $pclk_period * $misc_in_min_ratio]	 [get_ports X_i2c_s*]	-clock PCLK	-add_delay
	set_output_delay -max [expr $pclk_period * $misc_out_max_ratio]	 [get_ports X_i2c_s*]	-clock PCLK	-add_delay
	set_output_delay -min [expr $pclk_period * $misc_out_min_ratio]	 [get_ports X_i2c_s*]	-clock PCLK	-add_delay
}

if {$uart1_support} {
	set_input_delay		5	[get_ports X_uart1_rxd]		-clock UART_CLK	-add_delay
	set_output_delay	5	[get_ports X_uart1_txd]		-clock UART_CLK	-add_delay
}
if {$uart2_support} {
	set_input_delay		5	[get_ports X_uart2_rxd]		-clock UART_CLK	-add_delay
	set_output_delay	5	[get_ports X_uart2_txd]		-clock UART_CLK	-add_delay
}

# GPIO
if {$gpio_support} {
	set_input_delay		2	[get_ports X_gpio[*]]		-clock PCLK		-add_delay
	set_output_delay	2	[get_ports X_gpio[*]]		-clock PCLK		-add_delay
}

# ====================
# Timing Exceptions
# ====================
# Max delay

# False Path
set_false_path -from [get_ports X_por_b]
set_false_path -from [get_ports X_hw_rstn]
set_false_path -from [get_ports X_wakeup_in]


if {($platform == "ae350") && $board_orca} {
	set_false_path -to [get_ports X_flash_dir]
}

# SPI
if {$spi1_support} {
	if {[llength [get_ports -quiet X_spi1_csn]]} {
		set_false_path -from [get_ports X_spi1_csn]
	}
	if {$spi1_slave_support} {
		set_false_path -from [get_clocks SPI1_M_SCLK_*] -to [get_cells ae350_apb_subsystem/u_spi1/u_spi_spiif/spi_clk_in_syn/a_signal_sync*0*]
		set_false_path -from [get_clocks SPI1_M_SCLK_*] -through [get_cells ae350_apb_subsystem/u_spi1/u_spi_spiif/spi_*_slv_r_*]

		set_false_path -hold -to [get_cells ae350_apb_subsystem/u_spi1/u_spi_spiif/spi_clk_in_syn/a_signal_sync*0*]
	}
}
if {$spi2_support} {
	if {[llength [get_ports -quiet X_spi2_csn]]} {
		set_false_path -from [get_ports X_spi2_csn]
	}
	if {$spi2_slave_support} {
		set_false_path -from [get_clocks SPI2_M_SCLK_*] -to [get_cells ae350_apb_subsystem/u_spi2/u_spi_spiif/spi_clk_in_syn/a_signal_sync*0*]
		set_false_path -from [get_clocks SPI2_M_SCLK_*] -through [get_cells ae350_apb_subsystem/u_spi2/u_spi_spiif/spi_*_slv_r_*]

		set_false_path -hold -to [get_cells ae350_apb_subsystem/u_spi2/u_spi_spiif/spi_clk_in_syn/a_signal_sync*0*]
	}
}

# Relationship for SCLK -> SPI_CLOCK -> SCLK in slave mode:
if {$spi1_slave_support} {
	set_false_path -hold -through [get_cells ae350_apb_subsystem/u_spi1/u_spi_spiif/spi_out_slv_r*]
	set_false_path -hold -through [get_cells ae350_apb_subsystem/u_spi1/u_spi_spiif/spi_oe_slv_r* ]

	# CDC
	set_max_delay [expr $spi_clk_period - $spi_cdc_margin] -from [get_clocks CDC_SPI_CLOCK] -to [get_clocks CDC_SPI1_S_SCLK]

	set_max_delay $spi_clk_period -from [get_clocks CDC_SPI1_S_SCLK] -to [get_clocks CDC_SPI_CLOCK]

	set_false_path -hold -from [get_clocks CDC_SPI1_S_SCLK] -to [get_clocks CDC_SPI_CLOCK  ]
	set_false_path -hold -from [get_clocks CDC_SPI_CLOCK  ] -to [get_clocks CDC_SPI1_S_SCLK]
}
if {$spi2_slave_support} {
	set_false_path -hold -through [get_cells ae350_apb_subsystem/u_spi2/u_spi_spiif/spi_out_slv_r*]
	set_false_path -hold -through [get_cells ae350_apb_subsystem/u_spi2/u_spi_spiif/spi_oe_slv_r*]

	# CDC
	set_max_delay [expr $spi_clk_period - $spi_cdc_margin] -from [get_clocks CDC_SPI_CLOCK] -to [get_clocks CDC_SPI2_S_SCLK]

	set_max_delay $spi_clk_period -from [get_clocks CDC_SPI2_S_SCLK] -to [get_clocks CDC_SPI_CLOCK]

	set_false_path -hold -from [get_clocks CDC_SPI2_S_SCLK] -to [get_clocks CDC_SPI_CLOCK  ]
	set_false_path -hold -from [get_clocks CDC_SPI_CLOCK  ] -to [get_clocks CDC_SPI2_S_SCLK]
}

if {$has_ilm_tl_ul} {
	if {$cluster_support} {
		if {$has_hart_0} {
			set_multicycle_path -setup 2 -start -from  [get_clocks CORE_CLK] -to [get_clocks ILM_TL_UL_CLK0]
        		set_multicycle_path -hold  1 -start -from  [get_clocks CORE_CLK] -to [get_clocks ILM_TL_UL_CLK0]
        		set_multicycle_path -setup 2 -end   -from  [get_clocks ILM_TL_UL_CLK0] -to [get_clocks CORE_CLK]
        		set_multicycle_path -hold  1 -end   -from  [get_clocks ILM_TL_UL_CLK0] -to [get_clocks CORE_CLK]
		}
		if {$has_hart_1} {
			set_multicycle_path -setup 2 -start -from  [get_clocks CORE_CLK1] -to [get_clocks ILM_TL_UL_CLK1]
        		set_multicycle_path -hold  1 -start -from  [get_clocks CORE_CLK1] -to [get_clocks ILM_TL_UL_CLK1]
        		set_multicycle_path -setup 2 -end   -from  [get_clocks ILM_TL_UL_CLK1] -to [get_clocks CORE_CLK1]
        		set_multicycle_path -hold  1 -end   -from  [get_clocks ILM_TL_UL_CLK1] -to [get_clocks CORE_CLK1]
		}
		if {$has_hart_3} {
			set_multicycle_path -setup 2 -start -from  [get_clocks CORE_CLK2] -to [get_clocks ILM_TL_UL_CLK2]
        		set_multicycle_path -hold  1 -start -from  [get_clocks CORE_CLK2] -to [get_clocks ILM_TL_UL_CLK2]
        		set_multicycle_path -setup 2 -end   -from  [get_clocks ILM_TL_UL_CLK2] -to [get_clocks CORE_CLK2]
        		set_multicycle_path -hold  1 -end   -from  [get_clocks ILM_TL_UL_CLK2] -to [get_clocks CORE_CLK2]

			set_multicycle_path -setup 2 -start -from  [get_clocks CORE_CLK3] -to [get_clocks ILM_TL_UL_CLK3]
        		set_multicycle_path -hold  1 -start -from  [get_clocks CORE_CLK3] -to [get_clocks ILM_TL_UL_CLK3]
        		set_multicycle_path -setup 2 -end   -from  [get_clocks ILM_TL_UL_CLK3] -to [get_clocks CORE_CLK3]
        		set_multicycle_path -hold  1 -end   -from  [get_clocks ILM_TL_UL_CLK3] -to [get_clocks CORE_CLK3]
		}
		if {$has_hart_7} {
			set_multicycle_path -setup 2 -start -from  [get_clocks CORE_CLK4] -to [get_clocks ILM_TL_UL_CLK4]
        		set_multicycle_path -hold  1 -start -from  [get_clocks CORE_CLK4] -to [get_clocks ILM_TL_UL_CLK4]
        		set_multicycle_path -setup 2 -end   -from  [get_clocks ILM_TL_UL_CLK4] -to [get_clocks CORE_CLK4]
        		set_multicycle_path -hold  1 -end   -from  [get_clocks ILM_TL_UL_CLK4] -to [get_clocks CORE_CLK4]

			set_multicycle_path -setup 2 -start -from  [get_clocks CORE_CLK5] -to [get_clocks ILM_TL_UL_CLK5]
        		set_multicycle_path -hold  1 -start -from  [get_clocks CORE_CLK5] -to [get_clocks ILM_TL_UL_CLK5]
        		set_multicycle_path -setup 2 -end   -from  [get_clocks ILM_TL_UL_CLK5] -to [get_clocks CORE_CLK5]
        		set_multicycle_path -hold  1 -end   -from  [get_clocks ILM_TL_UL_CLK5] -to [get_clocks CORE_CLK5]

			set_multicycle_path -setup 2 -start -from  [get_clocks CORE_CLK6] -to [get_clocks ILM_TL_UL_CLK6]
        		set_multicycle_path -hold  1 -start -from  [get_clocks CORE_CLK6] -to [get_clocks ILM_TL_UL_CLK6]
        		set_multicycle_path -setup 2 -end   -from  [get_clocks ILM_TL_UL_CLK6] -to [get_clocks CORE_CLK6]
        		set_multicycle_path -hold  1 -end   -from  [get_clocks ILM_TL_UL_CLK6] -to [get_clocks CORE_CLK6]

			set_multicycle_path -setup 2 -start -from  [get_clocks CORE_CLK7] -to [get_clocks ILM_TL_UL_CLK7]
        		set_multicycle_path -hold  1 -start -from  [get_clocks CORE_CLK7] -to [get_clocks ILM_TL_UL_CLK7]
        		set_multicycle_path -setup 2 -end   -from  [get_clocks ILM_TL_UL_CLK7] -to [get_clocks CORE_CLK7]
        		set_multicycle_path -hold  1 -end   -from  [get_clocks ILM_TL_UL_CLK7] -to [get_clocks CORE_CLK7]
		}
	} else {
		set_multicycle_path -setup 2 -start -from  [get_clocks CORE_CLK] -to [get_clocks ILM_TL_UL_CLK]
        	set_multicycle_path -hold  1 -start -from  [get_clocks CORE_CLK] -to [get_clocks ILM_TL_UL_CLK]
        	set_multicycle_path -setup 2 -end   -from  [get_clocks ILM_TL_UL_CLK] -to [get_clocks CORE_CLK]
        	set_multicycle_path -hold  1 -end   -from  [get_clocks ILM_TL_UL_CLK] -to [get_clocks CORE_CLK]
	}
}

if {$spi1_support} {
	set_multicycle_path 2 -setup -from [get_cells ae350_apb_subsystem/u_spi1/u_spi_spiif/spi_in_r*] -through [get_cells ae350_apb_subsystem/u_spi1/u_spi_ctrl/rx_shift_reg_r*] -end
	set_multicycle_path 1 -hold  -from [get_cells ae350_apb_subsystem/u_spi1/u_spi_spiif/spi_in_r*] -through [get_cells ae350_apb_subsystem/u_spi1/u_spi_ctrl/rx_shift_reg_r*] -end
	set_false_path -from [get_clocks SPI1_M_SCLK_DIV] -through [get_cells ae350_apb_subsystem/u_spi1/u_spi_spiif/spi_in_r_reg*] -to [get_cells ae350_apb_subsystem/u_spi1/u_spi_spiif/spi_in_d1_r_reg*]

	if {$spi1_slave_support} {
		set_false_path -hold -from [get_clocks SPI1_S_SCLK] -through [get_cells ae350_apb_subsystem/u_spi1/u_spi_spiif/spi_in_r_reg*] -through [get_cells ae350_apb_subsystem/u_spi1/u_spi_ctrl/rx_shift_reg*    ]
		set_false_path       -from [get_clocks SPI1_S_SCLK] -through [get_cells ae350_apb_subsystem/u_spi1/u_spi_spiif/spi_in_r_reg*] -to      [get_cells ae350_apb_subsystem/u_spi1/u_spi_spiif/spi_in_d1_r_reg*]
	}
}

if {$spi2_support} {
	set_multicycle_path 2 -setup -from [get_cells ae350_apb_subsystem/u_spi2/u_spi_spiif/spi_in_r*] -through [get_cells ae350_apb_subsystem/u_spi2/u_spi_ctrl/rx_shift_reg_r*] -end
	set_multicycle_path 1 -hold  -from [get_cells ae350_apb_subsystem/u_spi2/u_spi_spiif/spi_in_r*] -through [get_cells ae350_apb_subsystem/u_spi2/u_spi_ctrl/rx_shift_reg_r*] -end
	set_false_path -from [get_clocks SPI2_M_SCLK_DIV] -through [get_cells ae350_apb_subsystem/u_spi2/u_spi_spiif/spi_in_r_reg*] -to [get_cells ae350_apb_subsystem/u_spi2/u_spi_spiif/spi_in_d1_r_reg*]

	if {$spi2_slave_support} {
		set_false_path -hold -from [get_clocks SPI2_S_SCLK] -through [get_cells ae350_apb_subsystem/u_spi2/u_spi_spiif/spi_in_r_reg*] -through [get_cells ae350_apb_subsystem/u_spi2/u_spi_ctrl/rx_shift_reg*    ]
		set_false_path       -from [get_clocks SPI2_S_SCLK] -through [get_cells ae350_apb_subsystem/u_spi2/u_spi_spiif/spi_in_r_reg*] -to      [get_cells ae350_apb_subsystem/u_spi2/u_spi_spiif/spi_in_d1_r_reg*]
	}
}

if {$l2c_support} {
	if {$l2c_delay_2cycles} {
        	set_multicycle_path -setup 2 -start -from  [get_clocks L2_CLK] -to [get_clocks L2C_BANK0_DATA_RAM_CLK]
        	set_multicycle_path -hold  1 -start -from  [get_clocks L2_CLK] -to [get_clocks L2C_BANK0_DATA_RAM_CLK]
        	set_multicycle_path -setup 2 -start -from  [get_clocks L2_CLK] -to [get_clocks L2C_BANK1_DATA_RAM_CLK]
        	set_multicycle_path -hold  1 -start -from  [get_clocks L2_CLK] -to [get_clocks L2C_BANK1_DATA_RAM_CLK]
	}
        set_multicycle_path -setup 2 -end   -from  [get_clocks L2C_BANK0_DATA_RAM_CLK] -to [get_clocks L2_CLK]
        set_multicycle_path -hold  1 -end   -from  [get_clocks L2C_BANK0_DATA_RAM_CLK] -to [get_clocks L2_CLK]
        set_multicycle_path -setup 2 -end   -from  [get_clocks L2C_BANK1_DATA_RAM_CLK] -to [get_clocks L2_CLK]
        set_multicycle_path -hold  1 -end   -from  [get_clocks L2C_BANK1_DATA_RAM_CLK] -to [get_clocks L2_CLK]

	if {$l2c_4bank_support} {
		if {$l2c_delay_2cycles} {
        		set_multicycle_path -setup 2 -start -from  [get_clocks L2_CLK] -to [get_clocks L2C_BANK2_DATA_RAM_CLK]
        		set_multicycle_path -hold  1 -start -from  [get_clocks L2_CLK] -to [get_clocks L2C_BANK2_DATA_RAM_CLK]
        		set_multicycle_path -setup 2 -start -from  [get_clocks L2_CLK] -to [get_clocks L2C_BANK3_DATA_RAM_CLK]
        		set_multicycle_path -hold  1 -start -from  [get_clocks L2_CLK] -to [get_clocks L2C_BANK3_DATA_RAM_CLK]
		}
        	set_multicycle_path -setup 2 -end   -from  [get_clocks L2C_BANK2_DATA_RAM_CLK] -to [get_clocks L2_CLK]
        	set_multicycle_path -hold  1 -end   -from  [get_clocks L2C_BANK2_DATA_RAM_CLK] -to [get_clocks L2_CLK]
        	set_multicycle_path -setup 2 -end   -from  [get_clocks L2C_BANK3_DATA_RAM_CLK] -to [get_clocks L2_CLK]
        	set_multicycle_path -hold  1 -end   -from  [get_clocks L2C_BANK3_DATA_RAM_CLK] -to [get_clocks L2_CLK]
	}
}




if {$uart1_support && $uart2_support} {
	if {[llength [get_ports -quiet X_uart1_ctsn]]} {
		set_false_path -from [get_ports X_uart1_ctsn]
	}
}

if {$uart1_support} {
	if ([llength [get_ports -quiet X_uart1_rin]]) {
		set_false_path -from [get_ports X_uart1_rin]
	}
	if ([llength [get_ports -quiet X_uart1_dsrn]]) {
		set_false_path -from [get_ports X_uart1_dsrn]
	}
	if ([llength [get_ports -quiet X_uart1_dcdn]]) {
		set_false_path -from [get_ports X_uart1_dcdn]
	}

	set_false_path -from [get_ports X_uart1_rxd]
}

if {$uart2_support} {
	if {[llength [get_ports -quiet X_uart2_rin]]} {
		set_false_path -from [get_ports X_uart2_rin]
	}
	if {[llength [get_ports -quiet X_uart2_ctsn]]} {
		set_false_path -from [get_ports X_uart2_ctsn]
	}
	if {[llength [get_ports -quiet X_uart2_dsrn]]} {
		set_false_path -from [get_ports X_uart2_dsrn]
	}
	if {[llength [get_ports -quiet X_uart2_dcdn]]} {
		set_false_path -from [get_ports X_uart2_dcdn]
	}

	set_false_path -from [get_ports X_uart2_rxd]
}

