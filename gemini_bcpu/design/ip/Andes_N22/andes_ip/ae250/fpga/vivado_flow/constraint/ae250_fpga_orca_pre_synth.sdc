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
	set osch_period			50.0
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
if {$spi1_support || $spi2_support} {
	# Sometimes u_spi_reg/spi_mode*[01]* may be optimized out so let's use u_spi_*.
	set_case_analysis $spi_mode_0	[get_pins u_spi*/u_spi_*/spi_mode*0*]
	set_case_analysis $spi_mode_1	[get_pins u_spi*/u_spi_*/spi_mode*1*]
}


# ====================
# Clock creation
# ====================
create_clock -name OSCH		[get_port X_oschin]					-period $osch_period
create_clock -name OSCL		[get_port X_osclin]					-period $oscl_period
if {$platform_debug_port} {
	create_clock -name JDTM_CLK	[get_port X_tck]					-period $jdtm_clk_period
}

# If we create generated clocks which are not actually used, Vivado will report errors.
if {$core_clk_use_40m} {
	create_generated_clock -name CLK_40M	[get_pins ${platform}_clkgen/${platform}_fpga_clkgen/mmcm_adv_inst/CLKOUT2]
	create_generated_clock -name CLK_20M	[get_pins ${platform}_clkgen/${platform}_fpga_clkgen/mmcm_adv_inst/CLKOUT3]
} elseif {$core_clk_use_20m} {
	create_generated_clock -name CLK_20M	[get_pins ${platform}_clkgen/${platform}_fpga_clkgen/mmcm_adv_inst/CLKOUT3]
	create_generated_clock -name CLK_10M	[get_pins ${platform}_clkgen/${platform}_fpga_clkgen/mmcm_adv_inst/CLKOUT6]
} else {
	create_generated_clock -name CLK_60M	[get_pins ${platform}_clkgen/${platform}_fpga_clkgen/mmcm_adv_inst/CLKOUT0]
	create_generated_clock -name CLK_30M	[get_pins ${platform}_clkgen/${platform}_fpga_clkgen/mmcm_adv_inst/CLKOUT1]
}
create_generated_clock -name UART_CLK	[get_pins ${platform}_clkgen/${platform}_fpga_clkgen/mmcm_adv_inst/CLKOUT4]
create_generated_clock -name SPI_CLOCK	[get_pins ${platform}_clkgen/${platform}_fpga_clkgen/mmcm_adv_inst/${spi_clk_source}]

# Only select the fastest clock to reduce the constraint complexity.
create_generated_clock -name ROOT_CLK	[get_pins ${platform}_clkgen/ROOT_CLK_MUX_INST/O]	-divide_by 1 -source [get_pins ${platform}_clkgen/ROOT_CLK_MUX_INST/I0]
create_generated_clock -name CORE_CLK	[get_pins ${platform}_clkgen/CORE_CLK_MUX_INST/O]	-divide_by 1 -source [get_pins ${platform}_clkgen/CORE_CLK_MUX_INST/I0]
create_generated_clock -name HCLK	[get_pins ${platform}_clkgen/HCLK_MUX_INST/O]		-divide_by 1 -source [get_pins ${platform}_clkgen/HCLK_MUX_INST/I0]
create_generated_clock -name PCLK	[get_pins ${platform}_clkgen/PCLK_MUX_INST/O]		-divide_by 1 -source [get_pins ${platform}_clkgen/PCLK_MUX_INST/I0]

if {$spi1_slave_support || $spi2_slave_support} {
	create_generated_clock -name CDC_SPI_CLOCK [get_nets *spi_clk*] -divide_by 1 -source [get_pins ${platform}_clkgen/${platform}_fpga_clkgen/mmcm_adv_inst/${spi_clk_source}] -master [get_clocks SPI_CLOCK] -add
}

if {$spi1_support} {
	create_generated_clock [get_nets u_spi1/u_spi_spiif/master_sclk_r] -name SPI1_CLOCK_DIV -divide_by 2 -source [get_pins ${platform}_clkgen/${platform}_fpga_clkgen/mmcm_adv_inst/${spi_clk_source}]

	if {$spi_mode_0 == $spi_mode_1} {
		create_generated_clock [get_ports X_spi1_clk] -name SPI1_M_SCLK_ORG -divide_by 1 -source [get_pins ${platform}_clkgen/${platform}_fpga_clkgen/mmcm_adv_inst/${spi_clk_source}] -master [get_clocks SPI_CLOCK] -add -invert
	} else {
		create_generated_clock [get_ports X_spi1_clk] -name SPI1_M_SCLK_ORG -divide_by 1 -source [get_pins ${platform}_clkgen/${platform}_fpga_clkgen/mmcm_adv_inst/${spi_clk_source}] -master [get_clocks SPI_CLOCK] -add
	}
	if {$spi_mode_1} {
		create_generated_clock [get_ports X_spi1_clk] -name SPI1_M_SCLK_DIV -divide_by 1 -source [get_pins -of_objects [get_nets u_spi1/u_spi_spiif/master_sclk_r] -leaf -filter {DIRECTION == OUT} ] -master [get_clocks SPI1_CLOCK_DIV] -add -invert
	} else {
		create_generated_clock [get_ports X_spi1_clk] -name SPI1_M_SCLK_DIV -divide_by 1 -source [get_pins -of_objects [get_nets u_spi1/u_spi_spiif/master_sclk_r] -leaf -filter {DIRECTION == OUT} ] -master [get_clocks SPI1_CLOCK_DIV] -add
	}

	if {$spi1_slave_support} {
		create_clock [get_ports X_spi1_clk] -name SPI1_S_SCLK		-period $spi_s_sclk_period -waveform [list 0 [expr $spi_s_sclk_period / 2.0]] -add
		create_clock [get_ports X_spi1_clk] -name CDC_SPI1_S_SCLK	-period $spi_s_sclk_period -add
	}
}

if {$spi2_support} {
	create_generated_clock [get_nets u_spi2/u_spi_spiif/master_sclk_r] -name SPI2_CLOCK_DIV -divide_by 2 -source [get_pins ${platform}_clkgen/${platform}_fpga_clkgen/mmcm_adv_inst/${spi_clk_source}]

	if {$spi_mode_0 == $spi_mode_1} {
		create_generated_clock [get_ports X_spi2_clk] -name SPI2_M_SCLK_ORG -divide_by 1 -source [get_pins ${platform}_clkgen/${platform}_fpga_clkgen/mmcm_adv_inst/${spi_clk_source}] -master [get_clocks SPI_CLOCK] -add -invert
	} else {
		create_generated_clock [get_ports X_spi2_clk] -name SPI2_M_SCLK_ORG -divide_by 1 -source [get_pins ${platform}_clkgen/${platform}_fpga_clkgen/mmcm_adv_inst/${spi_clk_source}] -master [get_clocks SPI_CLOCK] -add
	}
	if {$spi_mode_1} {
		create_generated_clock [get_ports X_spi2_clk] -name SPI2_M_SCLK_DIV -divide_by 1 -source [get_pins -of_objects [get_nets u_spi2/u_spi_spiif/master_sclk_r] -leaf -filter {DIRECTION == OUT} ] -master [get_clocks SPI2_CLOCK_DIV] -add -invert
	} else {
		create_generated_clock [get_ports X_spi2_clk] -name SPI2_M_SCLK_DIV -divide_by 1 -source [get_pins -of_objects [get_nets u_spi2/u_spi_spiif/master_sclk_r] -leaf -filter {DIRECTION == OUT} ] -master [get_clocks SPI2_CLOCK_DIV] -add
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

set_clock_groups -logically_exclusive -name clkgrp_DTM_CLK -group [get_clocks JDTM_CLK]
set_clock_groups -logically_exclusive -name clkgrp_CORE -group [get_clocks {ROOT_CLK CORE_CLK HCLK PCLK}]
set_clock_groups -logically_exclusive -name clkgrp_UART -group [get_clocks UART_CLK]

set_clock_groups -logically_exclusive -name clkgrp_CORE_CLK_SPI -group [get_clocks CORE_CLK] -group [get_clocks SPI*]
set_clock_groups -logically_exclusive -name clkgrp_HCLK_SPI -group [get_clocks HCLK] -group [get_clocks SPI*]
set_clock_groups -logically_exclusive -name clkgrp_PCLK_SPI -group [get_clocks PCLK] -group [get_clocks SPI*]

set_clock_groups -physically_exclusive -name clkgrp_SPI_M_SCLK_ORG_DIV -group [get_clocks SPI*_M_SCLK_ORG] -group [get_clocks SPI*_M_SCLK_DIV]

if {$spi1_slave_support || $spi2_slave_support} {
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
set_input_delay 0 -clock OSCH [get_ports X_aopd_por_b]
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
	set_input_delay		16.0		[get_ports X_tdi]		-clock JDTM_CLK	-add_delay
}
if {$platform_debug_port} {
	set_output_delay	1.50		[get_ports X_tms]		-clock JDTM_CLK	-add_delay
	set_input_delay		16.0		[get_ports X_tms]		-clock JDTM_CLK	-add_delay
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
set_input_delay		2	[get_ports X_gpio[*]]		-clock PCLK		-add_delay
set_output_delay	2	[get_ports X_gpio[*]]		-clock PCLK		-add_delay

# ====================
# Timing Exceptions
# ====================
# Max delay

# False Path
set_false_path -from [get_ports X_por_b]

set_false_path -from [get_ports X_aopd_por_b]

set_false_path -from [get_ports X_hw_rstn]

set_false_path -from [get_ports X_wakeup_in]

set_false_path -to [get_ports X_rtc_wakeup]

if {$platform == "ae350"} {
	set_false_path -to [get_ports X_flash_cs ]
	set_false_path -to [get_ports X_flash_dir]
}

# SPI
if {$spi1_support} {
	if {[llength [get_ports -quiet X_spi1_csn]]} {
		set_false_path -from [get_ports X_spi1_csn]
	}
	if {$spi1_slave_support} {
		set_false_path -from [get_clocks SPI1_M_SCLK_*] -to [get_cells u_spi1/u_spi_spiif/spi_clk_in_syn/a_signal_sync1*]
		set_false_path -from [get_clocks SPI1_M_SCLK_*] -through [get_cells u_spi1/u_spi_spiif/spi_*_slv_r_*]

		set_false_path -hold -to [get_cells u_spi1/u_spi_spiif/spi_clk_in_syn/a_signal_sync1*]
	}
}
if {$spi2_support} {
	if {[llength [get_ports -quiet X_spi2_csn]]} {
		set_false_path -from [get_ports X_spi2_csn]
	}
	if {$spi2_slave_support} {
		set_false_path -from [get_clocks SPI2_M_SCLK_*] -to [get_cells u_spi2/u_spi_spiif/spi_clk_in_syn/a_signal_sync1*]
		set_false_path -from [get_clocks SPI2_M_SCLK_*] -through [get_cells u_spi2/u_spi_spiif/spi_*_slv_r_*]

		set_false_path -hold -to [get_cells u_spi2/u_spi_spiif/spi_clk_in_syn/a_signal_sync1*]
	}
}

# Relationship for SCLK -> SPI_CLOCK -> SCLK in slave mode:
if {$spi1_slave_support} {
	set_false_path -hold -through [get_cells u_spi1/u_spi_spiif/spi_out_slv_r*]
	set_false_path -hold -through [get_cells u_spi1/u_spi_spiif/spi_oe_slv_r* ]

	# CDC
	set_max_delay [expr $spi_clk_period - $spi_cdc_margin] -from [get_clocks CDC_SPI_CLOCK] -to [get_clocks CDC_SPI1_S_SCLK]

	set_max_delay $spi_clk_period -from [get_clocks CDC_SPI1_S_SCLK] -to [get_clocks CDC_SPI_CLOCK]

	set_false_path -hold -from [get_clocks CDC_SPI1_S_SCLK] -to [get_clocks CDC_SPI_CLOCK  ]
	set_false_path -hold -from [get_clocks CDC_SPI_CLOCK  ] -to [get_clocks CDC_SPI1_S_SCLK]
}
if {$spi2_slave_support} {
	set_false_path -hold -through [get_cells u_spi2/u_spi_spiif/spi_out_slv_r*]
	set_false_path -hold -through [get_cells u_spi2/u_spi_spiif/spi_oe_slv_r*]

	# CDC
	set_max_delay [expr $spi_clk_period - $spi_cdc_margin] -from [get_clocks CDC_SPI_CLOCK] -to [get_clocks CDC_SPI2_S_SCLK]

	set_max_delay $spi_clk_period -from [get_clocks CDC_SPI2_S_SCLK] -to [get_clocks CDC_SPI_CLOCK]

	set_false_path -hold -from [get_clocks CDC_SPI2_S_SCLK] -to [get_clocks CDC_SPI_CLOCK  ]
	set_false_path -hold -from [get_clocks CDC_SPI_CLOCK  ] -to [get_clocks CDC_SPI2_S_SCLK]
}

if {$spi1_support} {
	set_multicycle_path 2 -setup -from [get_cells u_spi1/u_spi_spiif/spi_in_r*] -through [get_cells u_spi1/u_spi_ctrl/rx_shift_reg_r*] -end
	set_multicycle_path 1 -hold  -from [get_cells u_spi1/u_spi_spiif/spi_in_r*] -through [get_cells u_spi1/u_spi_ctrl/rx_shift_reg_r*] -end
	set_false_path -from [get_clocks SPI1_M_SCLK_DIV] -through [get_cells u_spi1/u_spi_spiif/spi_in_r_reg*] -to [get_cells u_spi1/u_spi_spiif/spi_in_d1_r_reg*]

	if {$spi1_slave_support} {
		set_false_path -hold -from [get_clocks SPI1_S_SCLK] -through [get_cells u_spi1/u_spi_spiif/spi_in_r_reg*] -through [get_cells u_spi1/u_spi_ctrl/rx_shift_reg*    ]
		set_false_path       -from [get_clocks SPI1_S_SCLK] -through [get_cells u_spi1/u_spi_spiif/spi_in_r_reg*] -to      [get_cells u_spi1/u_spi_spiif/spi_in_d1_r_reg*]
	}
}

if {$spi2_support} {
	set_multicycle_path 2 -setup -from [get_cells u_spi2/u_spi_spiif/spi_in_r*] -through [get_cells u_spi2/u_spi_ctrl/rx_shift_reg_r*] -end
	set_multicycle_path 1 -hold  -from [get_cells u_spi2/u_spi_spiif/spi_in_r*] -through [get_cells u_spi2/u_spi_ctrl/rx_shift_reg_r*] -end
	set_false_path -from [get_clocks SPI2_M_SCLK_DIV] -through [get_cells u_spi2/u_spi_spiif/spi_in_r_reg*] -to [get_cells u_spi2/u_spi_spiif/spi_in_d1_r_reg*]

	if {$spi2_slave_support} {
		set_false_path -hold -from [get_clocks SPI2_S_SCLK] -through [get_cells u_spi2/u_spi_spiif/spi_in_r_reg*] -through [get_cells u_spi2/u_spi_ctrl/rx_shift_reg*    ]
		set_false_path       -from [get_clocks SPI2_S_SCLK] -through [get_cells u_spi2/u_spi_spiif/spi_in_r_reg*] -to      [get_cells u_spi2/u_spi_spiif/spi_in_d1_r_reg*]
	}
}

if {$l2c_support} {
	# The single-cycle setting should also be tested on FPGA so comment out those multi-cycle settings.
	# if {$NDS_L2C_CACHE_SIZE_KB != 0} {
	# 	set vc_l2c_top ${platform}_cpu_subsystem/vcmp_core_top/vc_l2c_top
	# 
	# 	set_multicycle_path 2 -setup -through [get_pins $vc_l2c_top/vc_l2c_ram/l2c_data*_rdata     ] -to [get_cells $vc_l2c_top/vc_l2c/u_vc_l2c_l2d/lb_data*       ]
	# 	set_multicycle_path 1 -hold  -through [get_pins $vc_l2c_top/vc_l2c_ram/l2c_data*_rdata     ] -to [get_cells $vc_l2c_top/vc_l2c/u_vc_l2c_l2d/lb_data*       ]
	# 	set_multicycle_path 2 -setup -through [get_pins $vc_l2c_top/vc_l2c_ram/l2c_bank*_tag*_rdata] -to [get_cells $vc_l2c_top/vc_l2c/u_vc_l2c_l2t/l2c_tag*_rdata*]
	# 	set_multicycle_path 1 -hold  -through [get_pins $vc_l2c_top/vc_l2c_ram/l2c_bank*_tag*_rdata] -to [get_cells $vc_l2c_top/vc_l2c/u_vc_l2c_l2t/l2c_tag*_rdata*]
	# 	set_multicycle_path 2 -setup -through [get_pins $vc_l2c_top/vc_l2c_ram/l2c_data*_rdata     ] -to [get_cells $vc_l2c_top/vc_l2c/u_vc_l2c_l2d/tgt_read_data* ]
	# 	set_multicycle_path 1 -hold  -through [get_pins $vc_l2c_top/vc_l2c_ram/l2c_data*_rdata     ] -to [get_cells $vc_l2c_top/vc_l2c/u_vc_l2c_l2d/tgt_read_data* ]
	# 	set_multicycle_path 2 -setup -through [get_pins $vc_l2c_top/vc_l2c_ram/l2c_bank*_tag*_rdata] -to [get_cells $vc_l2c_top/vc_l2c/u_vc_l2c_l2d/tgt_read_data* ]
	# 	set_multicycle_path 1 -hold  -through [get_pins $vc_l2c_top/vc_l2c_ram/l2c_bank*_tag*_rdata] -to [get_cells $vc_l2c_top/vc_l2c/u_vc_l2c_l2d/tgt_read_data* ]
	# }
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


