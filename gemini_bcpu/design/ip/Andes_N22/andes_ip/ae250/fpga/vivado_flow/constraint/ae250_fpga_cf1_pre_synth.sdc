# This is the aeX50's FPFA synthesis/STA constraint for the CF1 board.
#
# Note:
# * For SPI-related commands/constraints, please check atcspi200.sdc for the details.
# * This constraint file is only for the pure Xilinx Vivado flow.
#   - Synopsys Synplify + Xilinx Vivado may fail to process these complex SPI constraints.

# -------------------------------------------------------------
# Variable settings
# -------------------------------------------------------------

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

# relax delay ratio for FPGA
set spi_in_max_ratio		0.10
set spi_in_min_ratio		0.00
set spi_mst_out_max_ratio	0.40
set spi_mst_out_min_ratio	0.00
set spi_slv_out_max_ratio	0.65
set spi_slv_out_min_ratio	0.00
set spi_cdc_margin		0.50
set misc_in_max_ratio		0.70
set misc_in_min_ratio		0.05
set misc_out_max_ratio		0.45
set misc_out_min_ratio		0.05


# ====================
# Clocks
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

# same as mmcm_adv_inst/CLKOUT5
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

if {![info exists env(mac_period)]} {
	set mac_period			25.0
} else {
	set mac_period			$env(mac_period)
}

#
# Defined variables @aeX50_vivado.tcl
#

#
# Configuration variables
#

# Case analysis
if {$spi1_support || $spi2_support || $spi3_support || $spi4_support} {
	# Sometimes u_spi_reg/spi_mode*[01]* may be optimized out so let's use u_spi_*.
	set_case_analysis $spi_mode_0	[get_pins u_spi*/u_spi_*/spi_mode*0*]
	set_case_analysis $spi_mode_1	[get_pins u_spi*/u_spi_*/spi_mode*1*]
}

# -------------------------------------------------------------
# Clock creation
# -------------------------------------------------------------
create_clock -name OSCH		[get_port X_oschin]					-period $osch_period
create_clock -name OSCL		[get_port X_osclin]					-period $oscl_period
create_clock -name JDTM_CLK	[get_port X_tck]					-period $jdtm_clk_period

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

if {$spi1_slave_support || $spi2_slave_support || $spi3_slave_support || $spi4_slave_support} {
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
		create_generated_clock [get_ports X_spi1_clk] -name SPI1_M_SCLK_DIV -divide_by 1 -source [get_pins -of_objects [get_nets u_spi1/u_spi_spiif/master_sclk_r] -filter {DIRECTION == OUT} ] -master [get_clocks SPI1_CLOCK_DIV] -add -invert
	} else {
		create_generated_clock [get_ports X_spi1_clk] -name SPI1_M_SCLK_DIV -divide_by 1 -source [get_pins -of_objects [get_nets u_spi1/u_spi_spiif/master_sclk_r] -filter {DIRECTION == OUT} ] -master [get_clocks SPI1_CLOCK_DIV] -add
	}

	if {$spi1_slave_support} {
		create_clock [get_ports X_spi1_clk] -name SPI1_S_SCLK		-period $spi_s_sclk_period -waveform [list 0 [expr $spi_s_sclk_period / 2.0]] -add
		create_clock [get_ports X_spi1_clk] -name CDC_SPI1_S_SCLK	-period $spi_s_sclk_period -add
	}
}

if {$spi2_support} {
	create_generated_clock [get_nets u_spi2/u_spi_spiif/master_sclk_r] -name SPI2_CLOCK_DIV -divide_by 2 -source [get_pins ${platform}_clkgen/${platform}_fpga_clkgen/mmcm_adv_inst/${spi_clk_source}]

	# X_spi2_clk is pinmux'ed to X_gpio[29].
	if {$spi_mode_0 == $spi_mode_1} {
		create_generated_clock [get_ports X_gpio[29]] -name SPI2_M_SCLK_ORG -divide_by 1 -source [get_pins ${platform}_clkgen/${platform}_fpga_clkgen/mmcm_adv_inst/${spi_clk_source}] -master [get_clocks SPI_CLOCK] -add -invert
	} else {
		create_generated_clock [get_ports X_gpio[29]] -name SPI2_M_SCLK_ORG -divide_by 1 -source [get_pins ${platform}_clkgen/${platform}_fpga_clkgen/mmcm_adv_inst/${spi_clk_source}] -master [get_clocks SPI_CLOCK] -add
	}
	if {$spi_mode_1} {
		create_generated_clock [get_ports X_gpio[29]] -name SPI2_M_SCLK_DIV -divide_by 1 -source [get_pins -of_objects [get_nets u_spi2/u_spi_spiif/master_sclk_r] -filter {DIRECTION == OUT} ] -master [get_clocks SPI2_CLOCK_DIV] -add -invert
	} else {
		create_generated_clock [get_ports X_gpio[29]] -name SPI2_M_SCLK_DIV -divide_by 1 -source [get_pins -of_objects [get_nets u_spi2/u_spi_spiif/master_sclk_r] -filter {DIRECTION == OUT} ] -master [get_clocks SPI2_CLOCK_DIV] -add
	}

	if {$spi2_slave_support} {
		create_clock [get_ports X_gpio[29]] -name SPI2_S_SCLK		-period $spi_s_sclk_period -waveform [list 0 [expr $spi_s_sclk_period / 2.0]] -add
		create_clock [get_ports X_gpio[29]] -name CDC_SPI2_S_SCLK	-period $spi_s_sclk_period -add
	}
}

if {$spi3_support} {
	create_generated_clock [get_nets u_spi3/u_spi_spiif/master_sclk_r] -name SPI3_CLOCK_DIV -divide_by 2 -source [get_pins ${platform}_clkgen/${platform}_fpga_clkgen/mmcm_adv_inst/${spi_clk_source}]

	if {$spi_mode_0 == $spi_mode_1} {
		create_generated_clock [get_ports X_spi3_clk] -name SPI3_M_SCLK_ORG -divide_by 1 -source [get_pins ${platform}_clkgen/${platform}_fpga_clkgen/mmcm_adv_inst/${spi_clk_source}] -master [get_clocks SPI_CLOCK] -add -invert
	} else {
		create_generated_clock [get_ports X_spi3_clk] -name SPI3_M_SCLK_ORG -divide_by 1 -source [get_pins ${platform}_clkgen/${platform}_fpga_clkgen/mmcm_adv_inst/${spi_clk_source}] -master [get_clocks SPI_CLOCK] -add
	}
	if {$spi_mode_1} {
		create_generated_clock [get_ports X_spi3_clk] -name SPI3_M_SCLK_DIV -divide_by 1 -source [get_pins -of_objects [get_nets u_spi3/u_spi_spiif/master_sclk_r] -filter {DIRECTION == OUT} ] -master [get_clocks SPI3_CLOCK_DIV] -add -invert
	} else {
		create_generated_clock [get_ports X_spi3_clk] -name SPI3_M_SCLK_DIV -divide_by 1 -source [get_pins -of_objects [get_nets u_spi3/u_spi_spiif/master_sclk_r] -filter {DIRECTION == OUT} ] -master [get_clocks SPI3_CLOCK_DIV] -add
	}

	if {$spi3_slave_support} {
		create_clock [get_ports X_spi3_clk] -name SPI3_S_SCLK		-period $spi_s_sclk_period -waveform [list 0 [expr $spi_s_sclk_period / 2.0]] -add
		create_clock [get_ports X_spi3_clk] -name CDC_SPI3_S_SCLK	-period $spi_s_sclk_period -add
	}
}

if {$spi4_support} {
	create_generated_clock [get_nets u_spi4/u_spi_spiif/master_sclk_r] -name SPI4_CLOCK_DIV -divide_by 2 -source [get_pins ${platform}_clkgen/${platform}_fpga_clkgen/mmcm_adv_inst/${spi_clk_source}]

	if {$spi_mode_0 == $spi_mode_1} {
		create_generated_clock [get_ports X_spi4_clk] -name SPI4_M_SCLK_ORG -divide_by 1 -source [get_pins ${platform}_clkgen/${platform}_fpga_clkgen/mmcm_adv_inst/${spi_clk_source}] -master [get_clocks SPI_CLOCK] -add -invert
	} else {
		create_generated_clock [get_ports X_spi4_clk] -name SPI4_M_SCLK_ORG -divide_by 1 -source [get_pins ${platform}_clkgen/${platform}_fpga_clkgen/mmcm_adv_inst/${spi_clk_source}] -master [get_clocks SPI_CLOCK] -add
	}
	if {$spi_mode_1} {
		create_generated_clock [get_ports X_spi4_clk] -name SPI4_M_SCLK_DIV -divide_by 1 -source [get_pins -of_objects [get_nets u_spi4/u_spi_spiif/master_sclk_r] -filter {DIRECTION == OUT} ] -master [get_clocks SPI4_CLOCK_DIV] -add -invert
	} else {
		create_generated_clock [get_ports X_spi4_clk] -name SPI4_M_SCLK_DIV -divide_by 1 -source [get_pins -of_objects [get_nets u_spi4/u_spi_spiif/master_sclk_r] -filter {DIRECTION == OUT} ] -master [get_clocks SPI4_CLOCK_DIV] -add
	}

	if {$spi4_slave_support} {
		create_clock [get_ports X_spi4_clk] -name SPI4_S_SCLK		-period $spi_s_sclk_period -waveform [list 0 [expr $spi_s_sclk_period / 2.0]] -add
		create_clock [get_ports X_spi4_clk] -name CDC_SPI4_S_SCLK	-period $spi_s_sclk_period -add
	}
}

if {$mac_support} {
	create_clock -name MAC_TXCLK [get_ports X_tx_clk] -period $mac_period
	create_clock -name MAC_RXCLK [get_ports X_rx_clk] -period $mac_period

	set_clock_groups -asynchronous -name clkgrp_mac -group [get_clocks {MAC_TXCLK MAC_RXCLK}]
}

# # SSP
# if {$ssp_support} {
# #	create_clock [get_pins ${platform}_clkgen/ssp_bufg/O] -name SSP_CLK -period $core_clk_period
# 	create_clock [get_nets ${platform}_clkgen/sspclk]     -name SSP_CLK -period $core_clk_period
# 	set_clock_groups -asynchronous -name ssp_clk_clkgroup -group [get_clocks SSP_CLK]
# }

# # LCD
# if {$lcdc_support} {
# 	create_clock [get_nets ${platform}_clkgen/lcd_clk] -name LCD_CLK -period $hclk_period
# 	create_generated_clock -name LCD_CLKN -source [get_nets ${platform}_clkgen/lcd_clk] -divide_by 1 -invert [get_nets ${platform}_clkgen/lcd_clkn]
# 	set_clock_groups -asynchronous -name lcd_clkgroup -group [get_clocks LCD_CLK]
# }

report_clocks -verbose -file report_clocks.rpt


# -------------------------------------------------------------
# Clock relationships
# -------------------------------------------------------------
set_clock_groups -logically_exclusive -name clkgrp_X_osclin -group [get_clocks OSCL]
set_clock_groups -logically_exclusive -name clkgrp_X_oschin -group [get_clocks OSCH]

set_clock_groups -logically_exclusive -name clkgrp_DTM_CLK_OTHERS -group [get_clocks JDTM_CLK]
set_clock_groups -logically_exclusive -name clkgrp_CORE -group [get_clocks {ROOT_CLK CORE_CLK HCLK PCLK}]
set_clock_groups -logically_exclusive -name clkgrp_uart -group [get_clocks UART_CLK]

set_clock_groups -logically_exclusive -name clkgrp_CORE_CLK_SPI -group [get_clocks CORE_CLK] -group [get_clocks SPI*]
set_clock_groups -logically_exclusive -name clkgrp_HCLK_SPI -group [get_clocks HCLK] -group [get_clocks SPI*]
set_clock_groups -logically_exclusive -name clkgrp_PCLK_SPI -group [get_clocks PCLK] -group [get_clocks SPI*]

set_clock_groups -physically_exclusive -name clkgrp_SPI_M_SCLK_ORG_DIV -group [get_clocks SPI*_M_SCLK_ORG] -group [get_clocks SPI*_M_SCLK_DIV]

if {$spi1_slave_support || $spi2_slave_support || $spi3_slave_support || $spi4_slave_support} {
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

foreach idx {1 2 3 4} {
	if {!(($idx==1 && $spi1_support) || ($idx==2 && $spi2_support) || ($idx==3 && $spi3_support) || ($idx==4 && $spi4_support))} {
		continue
	}
	# Master-mode input delay settings
	foreach clk "SPI${idx}_M_SCLK_ORG SPI${idx}_M_SCLK_DIV" {
		if {$idx == 2} {
			# X_spi2_mosi/miso are pinmux'ed to X_gpio[27,28]
			mode_set_spi_in_delay $clk [get_ports X_gpio[27]]
			mode_set_spi_in_delay $clk [get_ports X_gpio[28]]
		} else {
			mode_set_spi_in_delay $clk [get_ports X_spi${idx}_mosi]
			mode_set_spi_in_delay $clk [get_ports X_spi${idx}_miso]
		}
		if {($idx==1 && $spi1_quadspi_support) || ($idx==2 && $spi2_quadspi_support) || ($idx==3 && $spi3_quadspi_support) || ($idx==4 && $spi4_quadspi_support)} {
			mode_set_spi_in_delay $clk [get_ports X_spi${idx}_wpn  ]
			mode_set_spi_in_delay $clk [get_ports X_spi${idx}_holdn]
		}
	}

	# Master-mode output delay settings
	foreach clk "SPI${idx}_M_SCLK_ORG SPI${idx}_M_SCLK_DIV" {
		if {$idx == 2} {
			# X_spi2_csn/mosi/miso are pinmux'ed to X_gpio[26,27,28]
			mode_set_spi_mst_out_delay $clk [get_ports X_gpio[26]]
			mode_set_spi_mst_out_delay $clk [get_ports X_gpio[27]]
			mode_set_spi_mst_out_delay $clk [get_ports X_gpio[28]]
		} else {
			mode_set_spi_mst_out_delay $clk [get_ports X_spi${idx}_csn ]
			mode_set_spi_mst_out_delay $clk [get_ports X_spi${idx}_mosi]
			mode_set_spi_mst_out_delay $clk [get_ports X_spi${idx}_miso]
		}
		if {($idx==1 && $spi1_quadspi_support) || ($idx==2 && $spi2_quadspi_support) || ($idx==3 && $spi3_quadspi_support) || ($idx==4 && $spi4_quadspi_support)} {
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
	# X_spi2_mosi/miso are pinmux'ed to X_gpio[27,28]
	# Input delay settings
	mode_set_spi_in_delay SPI2_S_SCLK [get_ports X_gpio[27]]
	mode_set_spi_in_delay SPI2_S_SCLK [get_ports X_gpio[28]]

	if {$spi2_quadspi_support} {
		mode_set_spi_in_delay SPI2_S_SCLK [get_ports X_spi2_wpn  ]
		mode_set_spi_in_delay SPI2_S_SCLK [get_ports X_spi2_holdn]
	}

	# Output delay settings
	mode_set_spi_slv_out_delay SPI2_S_SCLK [get_ports X_gpio[27]]
	mode_set_spi_slv_out_delay SPI2_S_SCLK [get_ports X_gpio[28]]
	if {$spi2_quadspi_support} {
		mode_set_spi_slv_out_delay SPI2_S_SCLK [get_ports X_spi2_wpn  ]
		mode_set_spi_slv_out_delay SPI2_S_SCLK [get_ports X_spi2_holdn]
	}

	# spi2_csn is pinmux'ed to X_gpio[26]
	set_input_delay -max 0 -clock SPI2_S_SCLK [get_ports X_gpio[26]]
}

if {$spi3_slave_support} {
	# Input delay settings
	mode_set_spi_in_delay SPI3_S_SCLK [get_ports X_spi3_mosi]
	mode_set_spi_in_delay SPI3_S_SCLK [get_ports X_spi3_miso]

	if {$spi3_quadspi_support} {
		mode_set_spi_in_delay SPI3_S_SCLK [get_ports X_spi3_wpn  ]
		mode_set_spi_in_delay SPI3_S_SCLK [get_ports X_spi3_holdn]
	}

	# Output delay settings
	mode_set_spi_slv_out_delay SPI3_S_SCLK [get_ports X_spi3_mosi]
	mode_set_spi_slv_out_delay SPI3_S_SCLK [get_ports X_spi3_miso]
	if {$spi3_quadspi_support} {
		mode_set_spi_slv_out_delay SPI3_S_SCLK [get_ports X_spi3_wpn  ]
		mode_set_spi_slv_out_delay SPI3_S_SCLK [get_ports X_spi3_holdn]
	}

	set_input_delay -max 0 -clock SPI3_S_SCLK [get_ports X_spi3_csn]
}

if {$spi4_slave_support} {
	# Input delay settings
	mode_set_spi_in_delay SPI4_S_SCLK [get_ports X_spi4_mosi]
	mode_set_spi_in_delay SPI4_S_SCLK [get_ports X_spi4_miso]

	if {$spi4_quadspi_support} {
		mode_set_spi_in_delay SPI4_S_SCLK [get_ports X_spi4_wpn  ]
		mode_set_spi_in_delay SPI4_S_SCLK [get_ports X_spi4_holdn]
	}

	# Output delay settings
	mode_set_spi_slv_out_delay SPI4_S_SCLK [get_ports X_spi4_mosi]
	mode_set_spi_slv_out_delay SPI4_S_SCLK [get_ports X_spi4_miso]
	if {$spi4_quadspi_support} {
		mode_set_spi_slv_out_delay SPI4_S_SCLK [get_ports X_spi4_wpn  ]
		mode_set_spi_slv_out_delay SPI4_S_SCLK [get_ports X_spi4_holdn]
	}

	set_input_delay -max 0 -clock SPI4_S_SCLK [get_ports X_spi4_csn]
}

#-----------------------------------------------------
if {!$jtag_twowire} {
	set_output_delay	3.0		[get_ports X_tdo]		-clock JDTM_CLK	-add_delay
	set_input_delay		16.0		[get_ports X_tdi]		-clock JDTM_CLK	-add_delay
}
set_output_delay	1.50		[get_ports X_tms]		-clock JDTM_CLK	-add_delay
set_input_delay		16.0		[get_ports X_tms]		-clock JDTM_CLK	-add_delay

# I2C
if {$i2c1_support} {
	# I2C SDA -- pinmuxed to X_gpio[30]
	set_input_delay  -max [expr $pclk_period * $misc_in_max_ratio]	[get_ports X_gpio[30]]	-clock PCLK	-add_delay
	set_input_delay  -min [expr $pclk_period * $misc_in_min_ratio]	[get_ports X_gpio[30]]	-clock PCLK	-add_delay
	set_output_delay -max [expr $pclk_period * $misc_out_max_ratio]	[get_ports X_gpio[30]]	-clock PCLK	-add_delay
	set_output_delay -min [expr $pclk_period * $misc_out_min_ratio]	[get_ports X_gpio[30]]	-clock PCLK	-add_delay
	# I2C SCL -- pinmuxed to X_gpio[31]
	set_input_delay  -max [expr $pclk_period * $misc_in_max_ratio]	[get_ports X_gpio[31]]	-clock PCLK	-add_delay
	set_input_delay  -min [expr $pclk_period * $misc_in_min_ratio]	[get_ports X_gpio[31]]	-clock PCLK	-add_delay
	set_output_delay -max [expr $pclk_period * $misc_out_max_ratio]	[get_ports X_gpio[31]]	-clock PCLK	-add_delay
	set_output_delay -min [expr $pclk_period * $misc_out_min_ratio]	[get_ports X_gpio[31]]	-clock PCLK	-add_delay
}
if {$i2c2_support} {
	# I2C2 SDA -- pinmuxed to X_gpio[24]
	set_input_delay  -max [expr $pclk_period * $misc_in_max_ratio]	[get_ports X_gpio[24]]	-clock PCLK	-add_delay
	set_input_delay  -min [expr $pclk_period * $misc_in_min_ratio]	[get_ports X_gpio[24]]	-clock PCLK	-add_delay
	set_output_delay -max [expr $pclk_period * $misc_out_max_ratio]	[get_ports X_gpio[24]]	-clock PCLK	-add_delay
	set_output_delay -min [expr $pclk_period * $misc_out_min_ratio]	[get_ports X_gpio[24]]	-clock PCLK	-add_delay
	# I2C2 SCL -- pinmuxed to X_gpio[25]
	set_input_delay  -max [expr $pclk_period * $misc_in_max_ratio]	[get_ports X_gpio[25]]	-clock PCLK	-add_delay
	set_input_delay  -min [expr $pclk_period * $misc_in_min_ratio]	[get_ports X_gpio[25]]	-clock PCLK	-add_delay
	set_output_delay -max [expr $pclk_period * $misc_out_max_ratio]	[get_ports X_gpio[25]]	-clock PCLK	-add_delay
	set_output_delay -min [expr $pclk_period * $misc_out_min_ratio]	[get_ports X_gpio[25]]	-clock PCLK	-add_delay
}

# X_uart1_rxd/txd/X_uart2_rxd/txd are pinmux'ed to X_gpio[18,19,16,17].
if {$uart1_support} {
	set_input_delay		5	[get_ports X_gpio[18]]		-clock UART_CLK	-add_delay
	set_output_delay	5	[get_ports X_gpio[19]]		-clock UART_CLK	-add_delay
}
if {$uart2_support} {
	set_input_delay		5	[get_ports X_gpio[16]]		-clock UART_CLK	-add_delay
	set_output_delay	5	[get_ports X_gpio[17]]		-clock UART_CLK	-add_delay
}

# GPIO
for {set idx 0} {$idx < 32} {incr idx} {
	# X_gpio[29] is pinmux'ed as X_spi2_clk. Can't set_input_delay on it (a clock pin).
	if {$idx != 29} {
		set_input_delay		2	[get_ports X_gpio[$idx]]	-clock PCLK		-add_delay
	}
}
set_output_delay	2	[get_ports X_gpio[*]]			-clock PCLK		-add_delay

if {$sdc_support} {
	set_input_delay		5.5	[get_ports X_sd_cmd_rsp]	-clock PCLK		-add_delay
	set_output_delay	5.5	[get_ports X_sd_cmd_rsp]	-clock PCLK		-add_delay
	set_input_delay		5.5	[get_ports X_sd_dat0]		-clock PCLK		-add_delay
	set_output_delay	5.5	[get_ports X_sd_dat0]		-clock PCLK		-add_delay
	set_input_delay		5.5	[get_ports X_sd_dat1]		-clock PCLK		-add_delay
	set_output_delay	5.5	[get_ports X_sd_dat1]		-clock PCLK		-add_delay
	set_input_delay		5.5	[get_ports X_sd_dat2]		-clock PCLK		-add_delay
	set_output_delay	5.5	[get_ports X_sd_dat2]		-clock PCLK		-add_delay
	set_input_delay		5.5	[get_ports X_sd_dat3]		-clock PCLK		-add_delay
	set_output_delay	5.5	[get_ports X_sd_dat3]		-clock PCLK		-add_delay
	set_input_delay		5.5	[get_ports X_sd_wp]		-clock PCLK		-add_delay
	set_input_delay		5.5	[get_ports X_sd_cd]		-clock PCLK		-add_delay
	set_output_delay	5.5	[get_ports X_sd_clk]		-clock PCLK		-add_delay
	set_output_delay	5.5	[get_ports X_sd_power_on]	-clock PCLK		-add_delay
}

if {$mac_support} {
	set_output_delay	5.5	[get_ports X_mdc]		-clock MAC_TXCLK	-add_delay
	set_input_delay		5.5	[get_ports X_mdio]		-clock MAC_TXCLK	-add_delay
	set_output_delay	5.5	[get_ports X_mdio]		-clock MAC_TXCLK	-add_delay
	set_output_delay	5.5	[get_ports X_tx_en]		-clock MAC_TXCLK	-add_delay
	set_output_delay	5.5	[get_ports X_txd[*]]		-clock MAC_TXCLK	-add_delay
	set_input_delay		5.5	[get_ports X_col]		-clock MAC_RXCLK	-add_delay
	set_input_delay		5.5	[get_ports X_crs]		-clock MAC_RXCLK	-add_delay
	set_input_delay		5.5	[get_ports X_phy_linksts]	-clock MAC_RXCLK	-add_delay
	set_input_delay		5.5	[get_ports X_rx_dv]		-clock MAC_RXCLK	-add_delay
	set_input_delay		5.5	[get_ports X_rx_er]		-clock MAC_RXCLK	-add_delay
	set_input_delay		5.5	[get_ports X_rxd[*]]		-clock MAC_RXCLK	-add_delay
	set_output_delay	5.5	[get_ports X_pdn_phy]		-clock HCLK		-add_delay
}

##### Static Memory ################################
if {$smc_support} {
	set_output_delay 5.50	[get_ports X_memaddr[*]]	-clock [get_clocks HCLK]	-add_delay
	set_output_delay 5.50	[get_ports X_smc_cs_b  ]	-clock [get_clocks HCLK]	-add_delay
	set_output_delay 5.50	[get_ports X_smc_oe_b  ]	-clock [get_clocks HCLK]	-add_delay
	set_output_delay 5.50	[get_ports X_smc_we_b  ]	-clock [get_clocks HCLK]	-add_delay
}

##### LCD Signal ################################
if {$lcdc_support} {
	# set_output_delay 0.175	[get_ports X_clcp]	-clock LCD_CLKN	-add_delay
	# set_output_delay 0.25		[get_ports X_clac]	-clock LCD_CLK	-add_delay
	# set_output_delay 0.25		[get_ports X_cld[*]]	-clock LCD_CLK	-add_delay
	# set_output_delay 0.25		[get_ports X_clfp]	-clock LCD_CLK	-add_delay
	# set_output_delay 0.25		[get_ports X_clle]	-clock LCD_CLK	-add_delay
	# set_output_delay 0.25		[get_ports X_cllp]	-clock LCD_CLK	-add_delay
	set_output_delay 0.175	[get_ports X_clcp]	-clock HCLK	-add_delay -clock_fall
	set_output_delay 0.25	[get_ports X_clac]	-clock HCLK	-add_delay
	set_output_delay 0.25	[get_ports X_cld[*]]	-clock HCLK	-add_delay
	set_output_delay 0.25	[get_ports X_clfp]	-clock HCLK	-add_delay
	set_output_delay 0.25	[get_ports X_clle]	-clock HCLK	-add_delay
	set_output_delay 0.25	[get_ports X_cllp]	-clock HCLK	-add_delay
	set_output_delay 0.25	[get_ports X_clpower]	-clock HCLK	-add_delay
}

##### SSP for AC97 Signal ################################
if {$ssp_support} {
	# set_input_delay  1.00	[get_ports X_ssp_sclk       ]	-clock SSP_CLK	-add_delay
	# set_output_delay 1.00	[get_ports X_ssp_sclk       ]	-clock SSP_CLK	-add_delay
	# set_input_delay  1.00	[get_ports X_ssp_fs         ]	-clock SSP_CLK	-add_delay
	# set_output_delay 1.00	[get_ports X_ssp_fs         ]	-clock SSP_CLK	-add_delay
	# set_input_delay  1.00	[get_ports X_ssp_rxd        ]	-clock SSP_CLK	-add_delay
	# set_output_delay 1.00	[get_ports X_ssp_txd        ]	-clock SSP_CLK	-add_delay
	# set_output_delay 1.00	[get_ports X_ssp_ac97_resetn]	-clock SSP_CLK	-add_delay
	set_input_delay  1.00	[get_ports X_ssp_sclk       ]	-clock CORE_CLK	-add_delay
	set_output_delay 1.00	[get_ports X_ssp_sclk       ]	-clock CORE_CLK	-add_delay
	set_input_delay  1.00	[get_ports X_ssp_fs         ]	-clock CORE_CLK	-add_delay
	set_output_delay 1.00	[get_ports X_ssp_fs         ]	-clock CORE_CLK	-add_delay
	set_input_delay  1.00	[get_ports X_ssp_rxd        ]	-clock CORE_CLK	-add_delay
	set_output_delay 1.00	[get_ports X_ssp_txd        ]	-clock CORE_CLK	-add_delay
	set_output_delay 1.00	[get_ports X_ssp_ac97_resetn]	-clock CORE_CLK	-add_delay
}


# ====================
# Set Timing Exceptions
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
	# spi2_csn is pinmux'ed to X_gpio[26]
	if {[llength [get_pins -quiet u_spi2/spi_csn_in]]} {
		# set_false_path -from [get_ports X_spi2_csn] -through [get_pins u_spi2/spi_csn_in]
		set_false_path -from [get_ports X_gpio[26]] -through [get_pins u_spi2/spi_cs_n_in]
	}
	if {$spi2_slave_support} {
		set_false_path -from [get_clocks SPI2_M_SCLK_*] -to [get_cells u_spi2/u_spi_spiif/spi_clk_in_syn/a_signal_sync1*]
		set_false_path -from [get_clocks SPI2_M_SCLK_*] -through [get_cells u_spi2/u_spi_spiif/spi_*_slv_r_*]

		set_false_path -hold -to [get_cells u_spi2/u_spi_spiif/spi_clk_in_syn/a_signal_sync1*]
	}
}
if {$spi3_support} {
	if {[llength [get_ports -quiet X_spi3_csn]]} {
		set_false_path -from [get_ports X_spi3_csn]
	}
	if {$spi3_slave_support} {
		set_false_path -from [get_clocks SPI3_M_SCLK_*] -to [get_cells u_spi3/u_spi_spiif/spi_clk_in_syn/a_signal_sync1*]
		set_false_path -from [get_clocks SPI3_M_SCLK_*] -through [get_cells u_spi3/u_spi_spiif/spi_*_slv_r_*]

		set_false_path -hold -to [get_cells u_spi3/u_spi_spiif/spi_clk_in_syn/a_signal_sync1*]
	}
}
if {$spi4_support} {
	if {[llength [get_ports -quiet X_spi4_csn]]} {
		set_false_path -from [get_ports X_spi4_csn]
	}
	if {$spi4_slave_support} {
		set_false_path -from [get_clocks SPI4_M_SCLK_*] -to [get_cells u_spi4/u_spi_spiif/spi_clk_in_syn/a_signal_sync1*]
		set_false_path -from [get_clocks SPI4_M_SCLK_*] -through [get_cells u_spi4/u_spi_spiif/spi_*_slv_r_*]

		set_false_path -hold -to [get_cells u_spi4/u_spi_spiif/spi_clk_in_syn/a_signal_sync1*]
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
if {$spi3_slave_support} {
	set_false_path -hold -through [get_cells u_spi3/u_spi_spiif/spi_out_slv_r*]
	set_false_path -hold -through [get_cells u_spi3/u_spi_spiif/spi_oe_slv_r*]

	# CDC
	set_max_delay [expr $spi_clk_period - $spi_cdc_margin] -from [get_clocks CDC_SPI_CLOCK] -to [get_clocks CDC_SPI3_S_SCLK]

	set_max_delay $spi_clk_period -from [get_clocks CDC_SPI3_S_SCLK] -to [get_clocks CDC_SPI_CLOCK]

	set_false_path -hold -from [get_clocks CDC_SPI3_S_SCLK] -to [get_clocks CDC_SPI_CLOCK  ]
	set_false_path -hold -from [get_clocks CDC_SPI_CLOCK  ] -to [get_clocks CDC_SPI3_S_SCLK]
}
if {$spi4_slave_support} {
	set_false_path -hold -through [get_cells u_spi4/u_spi_spiif/spi_out_slv_r*]
	set_false_path -hold -through [get_cells u_spi4/u_spi_spiif/spi_oe_slv_r*]

	# CDC
	set_max_delay [expr $spi_clk_period - $spi_cdc_margin] -from [get_clocks CDC_SPI_CLOCK] -to [get_clocks CDC_SPI4_S_SCLK]

	set_max_delay $spi_clk_period -from [get_clocks CDC_SPI4_S_SCLK] -to [get_clocks CDC_SPI_CLOCK]

	set_false_path -hold -from [get_clocks CDC_SPI4_S_SCLK] -to [get_clocks CDC_SPI_CLOCK  ]
	set_false_path -hold -from [get_clocks CDC_SPI_CLOCK  ] -to [get_clocks CDC_SPI4_S_SCLK]
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
        set_multicycle_path 2 -setup -through [get_pins ${platform}_cpu_subsystem/vc_l2c_top/vc_l2c_ram/l2c_data_ram*/douta*]  -to [get_cells ${platform}_cpu_subsystem/vc_l2c_top/vc_l2c/u_vc_l2c_l2d/gen_line_buf*.lb_data_reg*] -end
        set_multicycle_path 1 -hold  -through [get_pins ${platform}_cpu_subsystem/vc_l2c_top/vc_l2c_ram/l2c_data_ram*/douta*]	 -to [get_cells ${platform}_cpu_subsystem/vc_l2c_top/vc_l2c/u_vc_l2c_l2d/gen_line_buf*.lb_data_reg*] -end
	set_multicycle_path 2 -setup -through [get_pins ${platform}_cpu_subsystem/vc_l2c_top/vc_l2c_ram/l2c_bank*_tag_ram*/douta*] -to [get_cells ${platform}_cpu_subsystem/vc_l2c_top/vc_l2c/u_vc_l2c_l2t/l2c_bank*_tag*_rdata_reg*] -end
	set_multicycle_path 1 -hold  -through [get_pins ${platform}_cpu_subsystem/vc_l2c_top/vc_l2c_ram/l2c_bank*_tag_ram*/douta*] -to [get_cells ${platform}_cpu_subsystem/vc_l2c_top/vc_l2c/u_vc_l2c_l2t/l2c_bank*_tag*_rdata_reg*] -end
}
if {$spi3_support} {
	set_multicycle_path 2 -setup -from [get_cells u_spi3/u_spi_spiif/spi_in_r*] -through [get_cells u_spi3/u_spi_ctrl/rx_shift_reg_r*] -end
	set_multicycle_path 1 -hold  -from [get_cells u_spi3/u_spi_spiif/spi_in_r*] -through [get_cells u_spi3/u_spi_ctrl/rx_shift_reg_r*] -end
	set_false_path -from [get_clocks SPI3_M_SCLK_DIV] -through [get_cells u_spi3/u_spi_spiif/spi_in_r_reg*] -to [get_cells u_spi3/u_spi_spiif/spi_in_d1_r_reg*]

	if {$spi3_slave_support} {
		set_false_path -hold -from [get_clocks SPI3_S_SCLK] -through [get_cells u_spi3/u_spi_spiif/spi_in_r_reg*] -through [get_cells u_spi3/u_spi_ctrl/rx_shift_reg*    ]
		set_false_path       -from [get_clocks SPI3_S_SCLK] -through [get_cells u_spi3/u_spi_spiif/spi_in_r_reg*] -to      [get_cells u_spi3/u_spi_spiif/spi_in_d1_r_reg*]
	}
}
if {$spi4_support} {
	set_multicycle_path 2 -setup -from [get_cells u_spi4/u_spi_spiif/spi_in_r*] -through [get_cells u_spi4/u_spi_ctrl/rx_shift_reg_r*] -end
	set_multicycle_path 1 -hold  -from [get_cells u_spi4/u_spi_spiif/spi_in_r*] -through [get_cells u_spi4/u_spi_ctrl/rx_shift_reg_r*] -end
	set_false_path -from [get_clocks SPI4_M_SCLK_DIV] -through [get_cells u_spi4/u_spi_spiif/spi_in_r_reg*] -to [get_cells u_spi4/u_spi_spiif/spi_in_d1_r_reg*]

	if {$spi4_slave_support} {
		set_false_path -hold -from [get_clocks SPI4_S_SCLK] -through [get_cells u_spi4/u_spi_spiif/spi_in_r_reg*] -through [get_cells u_spi4/u_spi_ctrl/rx_shift_reg*    ]
		set_false_path       -from [get_clocks SPI4_S_SCLK] -through [get_cells u_spi4/u_spi_spiif/spi_in_r_reg*] -to      [get_cells u_spi4/u_spi_spiif/spi_in_d1_r_reg*]
	}
}

if {$uart1_support && $uart2_support} {
	if {[llength [get_ports -quiet X_uart1_ctsn]]} {
		set_false_path -from [get_ports X_uart1_ctsn]
	}
}

if {$uart1_support} {
	# set_false_path -from [get_ports X_uart1_rin]
	# set_false_path -from [get_ports X_uart1_dsrn]
	# set_false_path -from [get_ports X_uart1_dcdn]

	# X_uart1_rxd is pinmux'ed to X_gpio[18]. uart1/uart_sin is optimized out.
	# set_false_path -from [get_ports X_gpio[18]] -through [get_pins u_uart1/uart_sin]
	set_false_path -from [get_ports X_gpio[18]] -to [get_clocks UART_CLK]
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

	# X_uart2_rxd is pinmux'ed to X_gpio[16]. uart2/uart_sin is optimized out.
	# set_false_path -from [get_ports X_gpio[16]] -through [get_pins uart2/uart_sin]
	set_false_path -from [get_ports X_gpio[16]] -to [get_clocks UART_CLK]
}


# PINMUX control registers are quasi-static.
set_false_path -from [get_cells ${platform}_smu/${platform}_smu_apbif/cf1_pinmux_ctrl0_reg_reg*]
set_false_path -from [get_cells ${platform}_smu/${platform}_smu_apbif/cf1_pinmux_ctrl1_reg_reg*]
