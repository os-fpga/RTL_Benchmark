# This is the aeX50_core's synthesis/STA constraint.
#
# Note that for SPI-related commands/constraints, please check atcspi200.sdc
# for the details.
#
# Four spi_mode values should all be run to make sure the timing is really 
# clean. However, if it's too time-consuming, using just a typical mode such 
# as 2'b11 should be safe enough. In addition, when it's sure only some modes 
# will be used, timing analyses of other modes can be skipped.

# -------------------------------------------------------------
# Variable settings
# -------------------------------------------------------------

set platform			ae250

#
# Synthesizer-configurable variables
#
set timing_enable_multiple_clocks_per_reg	1

#
# User-frequently-changed variables
#

# 0: Post-CTS
# 1: Pre-CTS
if {! [info exists pre_cts] } {
        set pre_cts                     1
}

# spi_mode
# By default, use spi_mode[1:0]==2'b11. The user can override spi_mode in the
# caller script.
if {! [info exists spi_mode_0]} {
        set spi_mode_0                  1
}
if {! [info exists spi_mode_1]} {
        set spi_mode_1                  1
}

# Check atcspi200.sdc for detailed descriptions for following SPI variables.
set spi_in_max_ratio            0.4   
set spi_in_min_ratio            0.0
set spi_mst_out_max_ratio       0.80
set spi_mst_out_min_ratio       0.00
set spi_slv_out_max_ratio       0.9
set spi_slv_out_min_ratio       0.0
set spi_cdc_margin              0.5

# -------------------------------------------------------------
# Set the clock periods and parameters
# -------------------------------------------------------------
if {![info exists env(osch_clk_period)]} {
        set osch_clk_period		1.0
} else {
        set osch_clk_period		$env(osch_clk_period)
}

if {![info exists env(oscl_clk_period)]} {
        set oscl_clk_period		30
} else {
        set oscl_clk_period		$env(oscl_clk_period)
}

if {![info exists env(jdtm_clk_period)]} {
	set jdtm_clk_period		33.0
} else {
	set jdtm_clk_period		$env(jdtm_clk_period)
}

# The SPI clock is exactly osch in the current ae350_chip clock tree implementation for ASIC.
set spi_clk_period		$env(osch_clk_period)

# The AHB/APB clocks are exactly osch in the current ae350_chip clock tree implementation for ASIC.
if {![info exists env(hclk_period)]} {
	set hclk_period			$osch_clk_period
} else {
	set hclk_period			$env(hclk_period)
}

if {![info exists env(pclk_period)]} {
	set pclk_period			$osch_clk_period
} else {
	set pclk_period			$env(pclk_period)
}

if {![info exists env(core_clk_period)]} {
	set core_clk_period		$osch_clk_period
} else {
	set core_clk_period		$env(core_clk_period)
}

if {![info exists env(spi_s_sclk_period)]} {
        set spi_s_sclk_period		[expr $spi_clk_period * 4.0]
} else {
        set spi_s_sclk_period		$env(spi_s_sclk_period)
}

# The user should fill a reasonable value according to the process and design
# so that the pre-CTS synthesis won't be over/under-constrained too much.
# Since here we are running at a higher frequency, relax the delay (compared to
# SPI's block-level constraints). In addition, RC has some clock-gating timing
# issue so a low delay value is used.
if {![info exists env(spi_m_sclk_delay)]} {
        set spi_m_sclk_delay		[expr $spi_clk_period * 0.5]
} else {
        set spi_m_sclk_delay		$env(spi_m_sclk_delay)
}

if {![info exists clock_uncertainty]} {
	set clock_uncertainty		0.3
}

if {![info exists clock_transition]} {
	set clock_transition		0.1
}

if {![info exists tech_lib]} {
	set tech_lib			"" 
	set driving_cell		"" 
	set load_val			1
	set operating_cond		""
}

if {![info exists env(maxFanout)]} {
	set max_fanout			64
} else {
	set max_fanout			$env(maxFanout)
}

if {![info exists env(max_transition)]} {
	set max_trans			0.5
} else {
	set max_trans			$env(max_transition)
}

# Derived variables
#
set hclk_coreclk_ratio          [expr int($hclk_period/$core_clk_period)]
set pclk_hclk_ratio             [expr int($pclk_period/$hclk_period)]
set pclk_coreclk_ratio          [expr int($pclk_period/$core_clk_period)]


# -------------------------------------------------------------
# Detect the configuration
# -------------------------------------------------------------
set jdtm_support                [expr [sizeof_collection [get_ports -quiet X_tms                        ]] != 0]
set i2c_support                 [expr [sizeof_collection [get_ports -quiet X_i2c_scl                    ]] != 0]
set uart1_support               [expr [sizeof_collection [get_ports -quiet X_uart1_txd                  ]] != 0]
set uart2_support               [expr [sizeof_collection [get_ports -quiet X_uart2_txd                  ]] != 0]
set pit_support                 [expr [sizeof_collection [get_ports -quiet X_pwm_ch0                    ]] != 0]
set gpio_support                [expr [sizeof_collection [get_ports -quiet {X_gpio*}                    ]] != 0]
set spi1_support                [expr [sizeof_collection [get_ports -quiet X_spi1_clk                   ]] != 0]
set spi2_support                [expr [sizeof_collection [get_ports -quiet X_spi2_clk                   ]] != 0]
set spi1_ahbbus_support         [expr [sizeof_collection [get_pins  -quiet u_spi1/hclk                  ]] != 0]
set spi1_apbbus_support         [expr [sizeof_collection [get_pins  -quiet u_spi1/pclk                  ]] != 0]
set spi1_eilmbus_support        [expr [sizeof_collection [get_pins  -quiet u_spi1/eilm_clk              ]] != 0]
set spi1_slave_support          [expr [sizeof_collection [get_pins  -quiet u_spi1/spi_default_as_slave  ]] != 0]
set spi1_quadspi_support        [expr [sizeof_collection [get_pins  -quiet u_spi1/spi_wp_n_oe           ]] != 0]
set spi2_ahbbus_support         [expr [sizeof_collection [get_pins  -quiet u_spi2/hclk                  ]] != 0]
set spi2_apbbus_support         [expr [sizeof_collection [get_pins  -quiet u_spi2/pclk                  ]] != 0]
set spi2_eilmbus_support        [expr [sizeof_collection [get_pins  -quiet u_spi2/eilm_clk              ]] != 0]
set spi2_slave_support          [expr [sizeof_collection [get_pins  -quiet u_spi2/spi_default_as_slave  ]] != 0]
set spi2_quadspi_support        [expr [sizeof_collection [get_pins  -quiet u_spi2/spi_wp_n_oe           ]] != 0]
set l2c_support			[expr [sizeof_collection [get_pins  -quiet u_${platform}_cpu_subsystem/l2c_reset_n	]] != 0]

# -------------------------------------------------------------
# Clean up existing constraints
# -------------------------------------------------------------
reset_design


# -------------------------------------------------------------
# Case analyses
# -------------------------------------------------------------
if {$spi1_support || $spi2_support} {
        set_case_analysis $spi_mode_0	[get_pins {u_spi*/u_spi_reg/spi_mode*0*}]
        set_case_analysis $spi_mode_1	[get_pins {u_spi*/u_spi_reg/spi_mode*1*}]
}


# -------------------------------------------------------------
# Specify Clock Information
# -------------------------------------------------------------

# OSCH
create_clock		-name OSCH [get_pins ${platform}_pin/T_osch] \
			-period [expr $osch_clk_period]

create_clock		-name OSCL [get_pins ${platform}_smu/${platform}_smu_aopd_top/${platform}_aopd_pin/T_oscl] \
			-period [expr $oscl_clk_period]

# JTAG
create_clock		-name DBG_CLK [get_pins ${platform}_smu/${platform}_smu_aopd_top/${platform}_aopd_pin/T_tck] \
			-period [expr $jdtm_clk_period]

# SPI1/2
create_generated_clock [get_pins ${platform}_clkgen/spi_clk]  -name SPI_CLOCK  -divide_by 1 -source [get_pins ${platform}_pin/T_osch]

if {$spi1_slave_support || $spi2_slave_support} {
	create_generated_clock [get_pins ${platform}_clkgen/spi_clk] -name CDC_SPI_CLOCK -divide_by 1 -source [get_pins ${platform}_pin/T_osch] -master [get_clocks SPI_CLOCK] -add
}

if {$spi1_support} {
	create_generated_clock [get_pins u_spi1/u_spi_spiif/master_sclk_r_reg/Q] -name SPI1_CLOCK_DIV -divide_by 2 -source [get_pins ${platform}_clkgen/spi_clk]

        # Create the SPI output clock seen by the remote side (slave).
        # The CLK_OUT version of clock lags behind the SPI*_CLOCK version
        # by ($spi_m_sclk_delay/2).
        if {$spi_mode_0 == $spi_mode_1} {
                create_generated_clock [get_ports X_spi1_clk] -name SPI1_CLK_OUT_ORG -divide_by 1 -source [get_pins ${platform}_clkgen/spi_clk]             -master [get_clocks SPI_CLOCK     ] -add -invert
        } else {
                create_generated_clock [get_ports X_spi1_clk] -name SPI1_CLK_OUT_ORG -divide_by 1 -source [get_pins ${platform}_clkgen/spi_clk]             -master [get_clocks SPI_CLOCK     ] -add
        }
        if {$spi_mode_1} {
	        create_generated_clock [get_ports X_spi1_clk] -name SPI1_CLK_OUT_DIV -divide_by 1 -source [get_pins u_spi1/u_spi_spiif/master_sclk_r_reg/Q] -master [get_clocks SPI1_CLOCK_DIV] -add -invert
        } else {
                create_generated_clock [get_ports X_spi1_clk] -name SPI1_CLK_OUT_DIV -divide_by 1 -source [get_pins u_spi1/u_spi_spiif/master_sclk_r_reg/Q] -master [get_clocks SPI1_CLOCK_DIV] -add
        }
	
	# Then create the loopback version of the SPI output clock. The M_SCLK
        # version of clock lags behind the CLK_OUT version by
        # ($spi_m_sclk_delay/2).
        create_generated_clock [get_ports X_spi1_clk] -name SPI1_M_SCLK_ORG -divide_by 1 -source [get_pins ${platform}_pin/spi1_clk_pad/O] -master [get_clocks SPI1_CLK_OUT_ORG] -add
        create_generated_clock [get_ports X_spi1_clk] -name SPI1_M_SCLK_DIV -divide_by 1 -source [get_pins ${platform}_pin/spi1_clk_pad/O] -master [get_clocks SPI1_CLK_OUT_DIV] -add

	if {$spi1_slave_support} {
                create_clock [get_ports X_spi1_clk] -name SPI1_S_SCLK     -period $spi_s_sclk_period -waveform [list 0 [expr $spi_s_sclk_period / 2.0]] -add
                create_clock [get_ports X_spi1_clk] -name CDC_SPI1_S_SCLK -period $spi_s_sclk_period -add
        }
}
if {$spi2_support} {
	create_generated_clock [get_pins u_spi2/u_spi_spiif/master_sclk_r_reg/Q] -name SPI2_CLOCK_DIV -divide_by 2 -source [get_pins ${platform}_clkgen/spi_clk]

        # Create the SPI output clock seen by the remote side (slave).
        # The CLK_OUT version of clock lags behind the SPI*_CLOCK version
        # by ($spi_m_sclk_delay/2).
        if {$spi_mode_0 == $spi_mode_1} {
                create_generated_clock [get_ports X_spi2_clk] -name SPI2_CLK_OUT_ORG -divide_by 1 -source [get_pins ${platform}_clkgen/spi_clk]             -master [get_clocks SPI_CLOCK     ] -add -invert
        } else { 
                create_generated_clock [get_ports X_spi2_clk] -name SPI2_CLK_OUT_ORG -divide_by 1 -source [get_pins ${platform}_clkgen/spi_clk]             -master [get_clocks SPI_CLOCK     ] -add
        }
        if {$spi_mode_1} {
	        create_generated_clock [get_ports X_spi2_clk] -name SPI2_CLK_OUT_DIV -divide_by 1 -source [get_pins u_spi2/u_spi_spiif/master_sclk_r_reg/Q] -master [get_clocks SPI2_CLOCK_DIV] -add -invert
        } else {
                create_generated_clock [get_ports X_spi2_clk] -name SPI2_CLK_OUT_DIV -divide_by 1 -source [get_pins u_spi2/u_spi_spiif/master_sclk_r_reg/Q] -master [get_clocks SPI2_CLOCK_DIV] -add
        }
	
	# Then create the loopback version of the SPI output clock. The M_SCLK
        # version of clock lags behind the CLK_OUT version by
        # ($spi_m_sclk_delay/2).
        create_generated_clock [get_ports X_spi2_clk] -name SPI2_M_SCLK_ORG -divide_by 1 -source [get_pins ${platform}_pin/spi2_clk_pad/O] -master [get_clocks SPI2_CLK_OUT_ORG] -add
        create_generated_clock [get_ports X_spi2_clk] -name SPI2_M_SCLK_DIV -divide_by 1 -source [get_pins ${platform}_pin/spi2_clk_pad/O] -master [get_clocks SPI2_CLK_OUT_DIV] -add

	if {$spi2_slave_support} {
                create_clock [get_ports X_spi2_clk] -name SPI2_S_SCLK     -period $spi_s_sclk_period -waveform [list 0 [expr $spi_s_sclk_period / 2.0]] -add
                create_clock [get_ports X_spi2_clk] -name CDC_SPI2_S_SCLK -period $spi_s_sclk_period -add
        }
}

if {$pre_cts} {
	# get_pins of some versions of DC only accept "direction==2" instead of "direction==out"
	# for the filter option so let's use a generic way to get this pin.
	if {[info exists synopsys_program_name]} {
		proc get_driver_pin {net} {
			foreach_in_collection i [get_pins -of_object $net -leaf] {
				if {[get_attribute $i direction] == "out"} {
					set driver_pin $i
				}
			}
			return $driver_pin;
		}
	} else {	# Cadence RC -- reversed argument order.
		proc get_driver_pin {net} {
			foreach_in_collection i [get_pins -of_object $net -leaf] {
				if {[get_attribute direction $i] == "out"} {
					set driver_pin $i
				}
			}
			return $driver_pin;
		}
	}

	set_ideal_network [get_driver_pin ${platform}_pin/T_osch]
        set_ideal_network [get_driver_pin ${platform}_smu/${platform}_smu_aopd_top/${platform}_aopd_pin/T_oscl]
	if {$jdtm_support} {
                set_ideal_network [get_driver_pin ${platform}_smu/${platform}_smu_aopd_top/${platform}_aopd_pin/T_tck]
        }
        # Net ${platform}_clkgen/spi_clk may be gone if this SDC is applied to the netlist so use u_spi1/spi_clk.
        set_ideal_network [get_driver_pin u_spi1/spi_clock]

        if {$spi1_support} {
                set_ideal_network [get_pins u_spi1/u_spi_spiif/master_sclk_r_reg/Q]
                set_ideal_network [get_ports X_spi1_clk]
	}
        if {$spi2_support} {
                set_ideal_network [get_pins u_spi2/u_spi_spiif/master_sclk_r_reg/Q]
                set_ideal_network [get_ports X_spi2_clk]
	}

	if {$spi1_support || $spi2_support} {
                # Half of the delay is spent on the way out to the pad.
	        set_clock_latency -source [expr $spi_m_sclk_delay / 2] [get_clocks SPI*_CLK_OUT_*]
	        # The other half of the delay is spent in the loopback path.
                set_clock_latency -source $spi_m_sclk_delay [get_clocks SPI*_M_SCLK_*]
        }

	# Specify Clock Skew
	set_clock_uncertainty -setup $clock_uncertainty [all_clocks]

	# Specify Clock Transition
	set_clock_transition $clock_transition [all_clocks]

} else {
        set_propagated_clock [all_clocks]

        if {$spi1_slave_support || $spi2_slave_support} {
                # Make CDC_* clocks ideal to not consider the clock insertion delay.
                remove_propagated_clock [get_clocks CDC_*]
        }
}


# ---------------------------------------
# Clock groups
# ---------------------------------------
if {$spi1_support || $spi2_support} {
        set_clock_groups -physically_exclusive -name clkgrp_SPI_CLK_OUT_ORG_DIV -group {SPI*_CLK_OUT_ORG} -group {SPI*_CLK_OUT_DIV}
        set_clock_groups -physically_exclusive -name clkgrp_SPI_M_SCLK_ORG_DIV  -group {SPI*_M_SCLK_ORG}  -group {SPI*_M_SCLK_DIV}

        set_clock_groups -physically_exclusive -name clkgrp_SPI_CLK_OUT_ORG_SPI_M_SCLK_DIV -group {SPI*_CLK_OUT_ORG} -group {SPI*_M_SCLK_DIV}
        set_clock_groups -physically_exclusive -name clkgrp_SPI_CLK_OUT_DIV_SPI_M_SCLK_ORG -group {SPI*_CLK_OUT_DIV} -group {SPI*_M_SCLK_ORG}
}

set_clock_groups -asynchronous -name clkgrp_PCLK_SPI -group OSCH -group {SPI*}

if {$spi1_slave_support || $spi2_slave_support} {
        set_clock_groups -physically_exclusive -name clkgrp_SPI_CLK_OUT_S_SCLK -group {SPI*_CLK_OUT*} -group {SPI*_S_SCLK}
        set_clock_groups -physically_exclusive -name clkgrp_SPI_M_S_SCLK       -group {SPI*_M_SCLK_*} -group {SPI*_S_SCLK}

        set_clock_groups -asynchronous -name clkgrp_SPI_CLOCK_S_SCLK -group SPI_CLOCK -group SPI*_S_SCLK

	set_clock_groups -physically_exclusive -name clkgrp_CDC_SPI_OTHERS -group {CDC_SPI*} -group [remove_from_collection [all_clocks] [get_clocks {CDC_SPI*}]]

        set_clock_groups -asynchronous -name clkgrp_CDC_SPI_CLOCK_S_SCLK -group CDC_SPI_CLOCK -group CDC_SPI*_S_SCLK -allow_paths

        foreach_in_collection cdc_clk [get_clocks CDC_SPI*] {
                set_false_path -from $cdc_clk -to $cdc_clk
        }
}


# -------------------------------------------------------------
# Define Input and Output Delays
# -------------------------------------------------------------
# JTAG
set_input_delay  -clock [get_clocks DBG_CLK] [expr $jdtm_clk_period * 2/3] [get_ports [list X_tdi X_tms X_trst]]
set_output_delay -clock [get_clocks DBG_CLK] [expr $jdtm_clk_period * 1/3] [get_ports X_tdo]

# SPI1/SPI2
# The procedure to set input delay for both master and slave modes
proc mode_set_spi_in_delay {clk ports} {
        global spi_mode_1
        global spi_mode_0
        global spi_clk_period
        global spi_in_max_ratio
        global spi_in_min_ratio
        if {$spi_mode_1 == $spi_mode_0} {
                set_input_delay -max [expr $spi_clk_period * $spi_in_max_ratio] -clock $clk $ports -add -clock_fall
                set_input_delay -min [expr $spi_clk_period * $spi_in_min_ratio] -clock $clk $ports -add -clock_fall
        } else {
                set_input_delay -max [expr $spi_clk_period * $spi_in_max_ratio] -clock $clk $ports -add
                set_input_delay -min [expr $spi_clk_period * $spi_in_min_ratio] -clock $clk $ports -add
        }
}

# The procedure to set master-mode output delay
proc mode_set_spi_mst_out_delay {clk ports} {
        global spi_mode_1
        global spi_mode_0
        global spi_clk_period
        global spi_mst_out_max_ratio
        global spi_mst_out_min_ratio
        if {[regexp {SPI._CLK_OUT_ORG} $clk]} {
		if {$spi_mode_1 == $spi_mode_0} {
                        set_output_delay -max [expr $spi_clk_period * $spi_mst_out_max_ratio] -clock $clk $ports -add -clock_fall
                        set_output_delay -min [expr $spi_clk_period * $spi_mst_out_min_ratio] -clock $clk $ports -add -clock_fall
                } else {
                        set_output_delay -max [expr $spi_clk_period * $spi_mst_out_max_ratio] -clock $clk $ports -add
                        set_output_delay -min [expr $spi_clk_period * $spi_mst_out_min_ratio] -clock $clk $ports -add
                }
	} else {
                # The N:1 clock path: master_sclk_r (SPI._CLK_OUT_DIV)
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
                continue;
        }
        # Master-mode input delay settings
	foreach clk "SPI${idx}_CLK_OUT_ORG SPI${idx}_CLK_OUT_DIV" {
                mode_set_spi_in_delay $clk [get_ports X_spi${idx}_mosi]
                mode_set_spi_in_delay $clk [get_ports X_spi${idx}_miso]
                if {(($idx == 1) && $spi1_quadspi_support) || (($idx==2) && $spi2_quadspi_support)} {
                        mode_set_spi_in_delay $clk [get_ports X_spi${idx}_wpn  ]
                        mode_set_spi_in_delay $clk [get_ports X_spi${idx}_holdn]
                }
        }

	# Master-mode output delay settings
        foreach clk "SPI${idx}_CLK_OUT_ORG SPI${idx}_CLK_OUT_DIV" {
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
        mode_set_spi_in_delay SPI1_S_SCLK [get_ports X_spi1_miso]
        mode_set_spi_in_delay SPI1_S_SCLK [get_ports X_spi1_mosi]

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
        mode_set_spi_in_delay SPI2_S_SCLK [get_ports X_spi2_miso]
        mode_set_spi_in_delay SPI2_S_SCLK [get_ports X_spi2_mosi]

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

# I2C
if {$i2c_support} {
	set_input_delay  -clock [get_clocks OSCH] [expr $env(pclk_period) * 1/3] [get_ports [list X_i2c_scl X_i2c_sda]]
	set_output_delay -clock [get_clocks OSCH] [expr $env(pclk_period) * 1/3] [get_ports [list X_i2c_scl X_i2c_sda]]
}

# UART
if {$uart1_support} {
	set_input_delay  -clock [get_clocks OSCH] [expr $pclk_period * 1/3] [get_ports {X_uart1_*}]
	set_output_delay -clock [get_clocks OSCH] [expr $pclk_period * 1/3] [get_ports {X_uart1_*}]
}

if {$uart2_support} {
	set_input_delay  -clock [get_clocks OSCH] [expr $pclk_period * 1/3] [get_ports {X_uart2_*}]
	set_output_delay -clock [get_clocks OSCH] [expr $pclk_period * 1/3] [get_ports {X_uart2_*}]
}

# PIT
if {$pit_support} {
	set_output_delay -clock [get_clocks OSCH] [expr $pclk_period * 1/3] [get_ports {X_pwm_ch*}]
}

# GPIO
if {$gpio_support} {
	set_input_delay  -clock [get_clocks OSCH] [expr $pclk_period * 1/3] [get_ports {X_gpio*}]
	set_output_delay -clock [get_clocks OSCH] [expr $pclk_period * 1/3] [get_ports {X_gpio*}]
}
	
# MISC


# -------------------------------------------------------------
# Set External Driver and Load
# -------------------------------------------------------------
set_driving_cell -library ${tech_lib} -lib_cell $driving_cell -no_design_rule [remove_from_collection [all_inputs] [get_ports X_oschin]]
set_load [expr $load_val * 16] [all_outputs]


# -------------------------------------------------------------
# Specify Operating Conditions
# -------------------------------------------------------------
set_operating_conditions $operating_cond


# -------------------------------------------------------------
# Specify Wire-load Models
# -------------------------------------------------------------
# Set the Wire-load Mode
set_wire_load_mode enclosed


# -------------------------------------------------------------
# Set Timing Exceptions
# -------------------------------------------------------------
# Specify False Paths
set_false_path -from [get_ports [list X_por_b X_hw_rstn]]

set_false_path -from [get_clocks OSCL] -to [get_clocks OSCH]
set_false_path -from [get_clocks OSCL] -to [get_clocks OSCL]
set_false_path -from [get_clocks DBG_CLK] -to [get_clocks OSCH]
set_false_path -from [get_clocks OSCH] -to [get_clocks DBG_CLK]
set_false_path -from [get_clocks DBG_CLK] -to [get_clocks OSCL]
set_false_path -from [get_clocks OSCL] -to [get_clocks DBG_CLK]

if {$spi1_support && $spi1_slave_support} {
        set_false_path -from [get_clocks SPI1_M_SCLK_*] -to [get_cells u_spi1/u_spi_spiif/spi_clk_in_syn/a_signal_sync1*]
        set_false_path -from [get_clocks SPI1_M_SCLK_*] -through [get_cells u_spi1/u_spi_spiif/spi_*_slv_r_*]

        set_false_path -hold -to [get_cells u_spi1/u_spi_spiif/spi_clk_in_syn/a_signal_sync1*]
}
if {$spi2_support && $spi2_slave_support} {
        set_false_path -from [get_clocks SPI2_M_SCLK_*] -to [get_cells u_spi2/u_spi_spiif/spi_clk_in_syn/a_signal_sync1*]
        set_false_path -from [get_clocks SPI2_M_SCLK_*] -through [get_cells u_spi2/u_spi_spiif/spi_*_slv_r_*]

        set_false_path -hold -to [get_cells u_spi2/u_spi_spiif/spi_clk_in_syn/a_signal_sync1*]
}

# Relationship for SCLK -> SPI_CLOCK -> SCLK in slave mode:
if {$spi1_slave_support} {
        set_false_path -hold -to [get_cells u_spi1/u_spi_spiif/spi_out_slv_r*]
        set_false_path -hold -to [get_cells u_spi1/u_spi_spiif/spi_oe_slv_r* ]

        set_max_delay [expr $spi_clk_period - $spi_cdc_margin] -from [get_clocks CDC_SPI_CLOCK] -to [get_clocks CDC_SPI1_S_SCLK]

        set_max_delay $spi_clk_period -from [get_clocks CDC_SPI1_S_SCLK] -to [get_clocks CDC_SPI_CLOCK]

        set_false_path -hold -from [get_clocks CDC_SPI1_S_SCLK] -to [get_clocks CDC_SPI_CLOCK]
        set_false_path -hold -from [get_clocks CDC_SPI_CLOCK] -to [get_clocks CDC_SPI1_S_SCLK]
}
if {$spi2_slave_support} {
        set_false_path -hold -to [get_cells u_spi2/u_spi_spiif/spi_out_slv_r*]
        set_false_path -hold -to [get_cells u_spi2/u_spi_spiif/spi_oe_slv_r* ]

        set_max_delay [expr $spi_clk_period - $spi_cdc_margin] -from [get_clocks CDC_SPI_CLOCK] -to [get_clocks CDC_SPI2_S_SCLK]

	set_max_delay $spi_clk_period -from [get_clocks CDC_SPI2_S_SCLK] -to [get_clocks CDC_SPI_CLOCK]

	set_false_path -hold -from [get_clocks CDC_SPI2_S_SCLK] -to [get_clocks CDC_SPI_CLOCK]
        set_false_path -hold -from [get_clocks CDC_SPI_CLOCK] -to [get_clocks CDC_SPI2_S_SCLK]
}

# Specify Multi-Cycle Paths
if {$spi1_support} {
        set_multicycle_path 2 -setup -from [get_cells u_spi1/u_spi_spiif/spi_in_r*] -to [get_cells u_spi1/u_spi_ctrl/rx_shift_reg_r*] -end
        set_multicycle_path 1 -hold  -from [get_cells u_spi1/u_spi_spiif/spi_in_r*] -to [get_cells u_spi1/u_spi_ctrl/rx_shift_reg_r*] -end
        
	set_false_path -from [get_clocks SPI1_CLK_OUT_DIV] -through [get_cells u_spi1/u_spi_spiif/spi_in_r_reg*] -to [get_cells u_spi1/u_spi_spiif/spi_in_d1_r_reg*]
        set_false_path -from [get_clocks SPI1_M_SCLK_DIV] -through [get_cells u_spi1/u_spi_spiif/spi_in_r_reg*] -to [get_cells u_spi1/u_spi_spiif/spi_in_d1_r_reg*]

	if {$spi1_slave_support} {
                set_false_path -hold -from [get_clocks SPI1_S_SCLK] -through [get_cells u_spi1/u_spi_spiif/spi_in_r_reg*] -to [get_cells u_spi1/u_spi_ctrl/rx_shift_reg*]
                set_false_path       -from [get_clocks SPI1_S_SCLK] -through [get_cells u_spi1/u_spi_spiif/spi_in_r_reg*] -to [get_cells u_spi1/u_spi_spiif/spi_in_d1_r_reg*]
        }

	# Not present in SPI's block-level SDC:
        # Since SPI1_CLK_OUT_ORG/DIV and SPI1_M_SCLK_ORG/DIV are created at the same point, 
	# SPI1_CLK_OUT_* will also loop back to clock internal registers like SPI1_M_SCLK_* 
	# during timing analysis. Since SPI1_CLK_OUT_* don't have the loop-back delay included, 
	# these paths shouldn't be analyzed. However, set_false_path is not capable to do the 
	# exact setting like:
        #   set_false_path -to_by_clock [get_clocks SPI1_CLK_OUT_*] -to [get_pins u_spi1/u_spi_spiif/spi_in_r_reg_*_/D]
        # As a result, use the alternaitve as below. We can do this since SPI1_CLK_OUT_* should 
	# be used either at the input or output delay part of a timing path. That is, both start 
	# and end clocks can't be SPI1_CLK_OUT_* at the same time.
        set_false_path -from [get_clocks SPI1_CLK_OUT_ORG] -to [get_clocks SPI1_CLK_OUT_ORG]
        set_false_path -from [get_clocks SPI1_CLK_OUT_DIV] -to [get_clocks SPI1_CLK_OUT_DIV]
}
if {$spi2_support} {
        set_multicycle_path 2 -setup -from [get_cells u_spi2/u_spi_spiif/spi_in_r*] -to [get_cells u_spi2/u_spi_ctrl/rx_shift_reg_r*] -end
        set_multicycle_path 1 -hold  -from [get_cells u_spi2/u_spi_spiif/spi_in_r*] -to [get_cells u_spi2/u_spi_ctrl/rx_shift_reg_r*] -end
        
	set_false_path -from [get_clocks SPI2_CLK_OUT_DIV] -through [get_cells u_spi2/u_spi_spiif/spi_in_r_reg*] -to [get_cells u_spi2/u_spi_spiif/spi_in_d1_r_reg*]
        set_false_path -from [get_clocks SPI2_M_SCLK_DIV] -through [get_cells u_spi2/u_spi_spiif/spi_in_r_reg*] -to [get_cells u_spi2/u_spi_spiif/spi_in_d1_r_reg*]

        if {$spi2_slave_support} {
		set_false_path -hold -from [get_clocks SPI2_S_SCLK] -through [get_cells u_spi2/u_spi_spiif/spi_in_r_reg*] -to [get_cells u_spi2/u_spi_ctrl/rx_shift_reg*]
		set_false_path       -from [get_clocks SPI2_S_SCLK] -through [get_cells u_spi2/u_spi_spiif/spi_in_r_reg*] -to [get_cells u_spi2/u_spi_spiif/spi_in_d1_r_reg*]
        }

	# Not present in SPI's block-level SDC:
        # Since SPI1_CLK_OUT_ORG/DIV and SPI1_M_SCLK_ORG/DIV are created at the same point, 
	# SPI1_CLK_OUT_* will also loop back to clock internal registers like SPI1_M_SCLK_* 
	# during timing analysis. Since SPI1_CLK_OUT_* don't have the loop-back delay included, 
	# these paths shouldn't be analyzed. However, set_false_path is not capable to do the 
	# exact setting like:
        #   set_false_path -to_by_clock [get_clocks SPI1_CLK_OUT_*] -to [get_pins u_spi1/u_spi_spiif/spi_in_r_reg_*_/D]
        # As a result, use the alternaitve as below. We can do this since SPI1_CLK_OUT_* should 
	# be used either at the input or output delay part of a timing path. That is, both start 
	# and end clocks can't be SPI1_CLK_OUT_* at the same time.
        set_false_path -from [get_clocks SPI2_CLK_OUT_ORG] -to [get_clocks SPI2_CLK_OUT_ORG]
        set_false_path -from [get_clocks SPI2_CLK_OUT_DIV] -to [get_clocks SPI2_CLK_OUT_DIV]
}

if {$spi1_apbbus_support} {
        if {$spi1_ahbbus_support} {
                set_multicycle_path $pclk_hclk_ratio            -setup -through [get_pins u_spi1/u_spi_sync/reg_*_sysclk] -to [get_clocks OSCH] -end
                set_multicycle_path [expr $pclk_hclk_ratio - 1] -hold  -through [get_pins u_spi1/u_spi_sync/reg_*_sysclk] -to [get_clocks OSCH] -end
                set_multicycle_path $pclk_hclk_ratio            -setup -through [get_pins u_spi1/u_spi_sync/spi_reset_regclk] -to [get_cells u_spi1/u_spi_sync/spi_reset_sysclk*] -end
                set_multicycle_path [expr $pclk_hclk_ratio - 1] -hold  -through [get_pins u_spi1/u_spi_sync/spi_reset_regclk] -to [get_cells u_spi1/u_spi_sync/spi_reset_sysclk*] -end
                set_multicycle_path $pclk_hclk_ratio            -setup -through [get_pins u_spi1/pwdata] -to [get_cells u_spi1/u_spi_fifo/u_spi_txfifo/mem*] -end
                set_multicycle_path [expr $pclk_hclk_ratio - 1] -hold  -through [get_pins u_spi1/pwdata] -to [get_cells u_spi1/u_spi_fifo/u_spi_txfifo/mem*] -end
        } elseif {$spi1_eilmbus_support} {
                set_multicycle_path $pclk_coreclk_rato             -setup -through [get_pins u_spi1/u_spi_sync/reg_*_sysclk] -to [get_clocks OSCH] -end
                set_multicycle_path [expr $pclk_coreclk_ratio - 1] -hold  -through [get_pins u_spi1/u_spi_sync/reg_*_sysclk] -to [get_clocks OSCH] -end
		set_multicycle_path $pclk_coreclk_rato             -setup -through [get_pins u_spi1/u_spi_sync/spi_reset_regclk] -to [get_cells u_spi1/u_spi_sync/spi_reset_sysclk*] -end
                set_multicycle_path [expr $pclk_coreclk_ratio - 1] -hold  -through [get_pins u_spi1/u_spi_sync/spi_reset_regclk] -to [get_cells u_spi1/u_spi_sync/spi_reset_sysclk*] -end
                set_multicycle_path $pclk_coreclk_rato             -setup -through [get_pins u_spi1/pwdata] -to [get_cells u_spi1/u_spi_fifo/u_spi_txfifo/mem*] -end
                set_multicycle_path [expr $pclk_coreclk_ratio - 1] -hold  -through [get_pins u_spi1/pwdata] -to [get_cells u_spi1/u_spi_fifo/u_spi_txfifo/mem*] -end
        }
}

# We are unable to know the strictest value of the multi-cycle setting since
# it's a run-time config. For ASIC, typically the clock frequency is high but
# SRAM may be slow. As a result, let's use a looser setting for the SRAM output
# access time to more easily finish the timing analysis. The user should adjust
# the multi-cycle setting according to their real run-time usages.
if {$l2c_support} {
	if {$NDS_L2C_CACHE_SIZE_KB != 0} {
		set vc_l2c_top ${platform}_cpu_subsystem/vcmp_core_top/vc_l2c_top

		set_multicycle_path 2 -setup -through [get_pins $vc_l2c_top/vc_l2c_ram/l2c_data*_rdata     ] -to [get_cells $vc_l2c_top/vc_l2c/u_vc_l2c_l2d/lb_data*       ]
		set_multicycle_path 1 -hold  -through [get_pins $vc_l2c_top/vc_l2c_ram/l2c_data*_rdata     ] -to [get_cells $vc_l2c_top/vc_l2c/u_vc_l2c_l2d/lb_data*       ]
		set_multicycle_path 2 -setup -through [get_pins $vc_l2c_top/vc_l2c_ram/l2c_bank*_tag*_rdata] -to [get_cells $vc_l2c_top/vc_l2c/u_vc_l2c_l2t/l2c_tag*_rdata*]
		set_multicycle_path 1 -hold  -through [get_pins $vc_l2c_top/vc_l2c_ram/l2c_bank*_tag*_rdata] -to [get_cells $vc_l2c_top/vc_l2c/u_vc_l2c_l2t/l2c_tag*_rdata*]
		set_multicycle_path 2 -setup -through [get_pins $vc_l2c_top/vc_l2c_ram/l2c_data*_rdata     ] -to [get_cells $vc_l2c_top/vc_l2c/u_vc_l2c_l2d/tgt_read_data* ]
		set_multicycle_path 1 -hold  -through [get_pins $vc_l2c_top/vc_l2c_ram/l2c_data*_rdata     ] -to [get_cells $vc_l2c_top/vc_l2c/u_vc_l2c_l2d/tgt_read_data* ]
		set_multicycle_path 2 -setup -through [get_pins $vc_l2c_top/vc_l2c_ram/l2c_bank*_tag*_rdata] -to [get_cells $vc_l2c_top/vc_l2c/u_vc_l2c_l2d/tgt_read_data* ]
		set_multicycle_path 1 -hold  -through [get_pins $vc_l2c_top/vc_l2c_ram/l2c_bank*_tag*_rdata] -to [get_cells $vc_l2c_top/vc_l2c/u_vc_l2c_l2d/tgt_read_data* ]
	}
}

# UART
if {$uart1_support} {
	set_multicycle_path 2 -setup -through [get_pins u_uart1/paddr]  -through [get_pins u_uart1/prdata]
	set_multicycle_path 1 -hold  -through [get_pins u_uart1/paddr]  -through [get_pins u_uart1/prdata]
	set_multicycle_path 2 -setup -through [get_pins u_uart1/psel]   -through [get_pins u_uart1/prdata]
	set_multicycle_path 1 -hold  -through [get_pins u_uart1/psel]   -through [get_pins u_uart1/prdata]
	set_multicycle_path 2 -setup -through [get_pins u_uart1/pwrite] -through [get_pins u_uart1/prdata]
	set_multicycle_path 1 -hold  -through [get_pins u_uart1/pwrite] -through [get_pins u_uart1/prdata]
}

if {$uart2_support} {
	set_multicycle_path 2 -setup -through [get_pins u_uart2/paddr]  -through [get_pins u_uart2/prdata]
	set_multicycle_path 1 -hold  -through [get_pins u_uart2/paddr]  -through [get_pins u_uart2/prdata]
	set_multicycle_path 2 -setup -through [get_pins u_uart2/psel]   -through [get_pins u_uart2/prdata]
	set_multicycle_path 1 -hold  -through [get_pins u_uart2/psel]   -through [get_pins u_uart2/prdata]
	set_multicycle_path 2 -setup -through [get_pins u_uart2/pwrite] -through [get_pins u_uart2/prdata]
	set_multicycle_path 1 -hold  -through [get_pins u_uart2/pwrite] -through [get_pins u_uart2/prdata]
}

# PIT
if {$pit_support} {
	set_multicycle_path 2 -setup -through [get_pins u_pit/paddr]  -through [get_pins u_pit/prdata]
	set_multicycle_path 1 -hold  -through [get_pins u_pit/paddr]  -through [get_pins u_pit/prdata]
	set_multicycle_path 2 -setup -through [get_pins u_pit/psel]   -through [get_pins u_pit/prdata]
	set_multicycle_path 1 -hold  -through [get_pins u_pit/psel]   -through [get_pins u_pit/prdata]
	set_multicycle_path 2 -setup -through [get_pins u_pit/pwrite] -through [get_pins u_pit/prdata]
	set_multicycle_path 1 -hold  -through [get_pins u_pit/pwrite] -through [get_pins u_pit/prdata]
}

# GPIO
if {$gpio_support} {
	set_multicycle_path 2 -setup -through [get_pins u_gpio/paddr]  -through [get_pins u_gpio/prdata]
	set_multicycle_path 1 -hold  -through [get_pins u_gpio/paddr]  -through [get_pins u_gpio/prdata]
	set_multicycle_path 2 -setup -through [get_pins u_gpio/psel]   -through [get_pins u_gpio/prdata]
	set_multicycle_path 1 -hold  -through [get_pins u_gpio/psel]   -through [get_pins u_gpio/prdata]
	set_multicycle_path 2 -setup -through [get_pins u_gpio/pwrite] -through [get_pins u_gpio/prdata]
	set_multicycle_path 1 -hold  -through [get_pins u_gpio/pwrite] -through [get_pins u_gpio/prdata]
}

# Specify Path Delays

# -------------------------------------------------------------
# Set Design Rule Constraints
# -------------------------------------------------------------
# Specify the Maximum Fanout Limit
set_max_fanout $max_fanout [current_design]

# Specify the Maximum Capacitance Limit

# Specify the Maximum Transition Limit
set_max_transition $max_trans [all_inputs]
set_max_transition $max_trans [all_outputs]


# -------------------------------------------------------------
# Handle Ideal Nets
# -------------------------------------------------------------
