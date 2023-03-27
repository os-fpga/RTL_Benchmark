# This is the block-level synthesis/STA constraint for ATCSPI200.
#
# With fixed spi_mode, some paths to following end points will not be covered:
#   - u_spi_spiif/master_sclk_r_reg/D
#   - u_spi_ctrl/rx_mask_cnt_r*/D
#   - ...
# As a result, four spi_mode values should all be run to make sure the timing
# is really clean. However, if it's too time-consuming, using just a typical
# mode such as 2'b11 should be safe enough. In addition, when it's sure only
# some modes will be used, timing analyses of other modes can be skipped.
#

# -------------------------------------------------------------
# Variable settings
# -------------------------------------------------------------

#
# User-frequently-changed variables
#

# 0: Post-CTS
# 1: Pre-CTS
if {! [info exists pre_cts] } {
	set pre_cts			1
}

# spi_mode
# By default, use spi_mode[1:0]==2'b11. The user can override spi_mode in the
# caller script.
if {! [info exists spi_mode_0]} {
	set spi_mode_0			1
}
if {! [info exists spi_mode_1]} {
	set spi_mode_1			1
}

# SPI input delay ratio (relative to one spi_clock period)
# The data should be externally driven on SPI bus at one edge (neg/pos) and
# sampled at the immediately next edge (pos/neg), so the input delay can't be
# larger than half a clock period. This value depends on how much margin we
# desire. We don't need to distinguish master mode from slave mode since both
# modes use the same data paths.
set spi_in_max_ratio		0.40
set spi_in_min_ratio		0.00

# SPI master-mode output delay ratio (relative to one spi_clock period)
# In SPI master mode, this controls how much time is reserved for the external
# slave for data. Theoretically, the master puts data on one edge (pos/neg) and
# the slave samples data on the immediately next edge (neg/pos). Therefore, the
# ratio is supposed to be between 0~0.5 of the clock period. However, to make
# it more intuitive, we use a full cycle to do the setup check (pos->pos or
# neg->neg, instead of pos->neg or neg->pos) so the range of the ratio becomes
# 0.5~1.0.
# Since the external master flops data at the other edge, the hold time check
# is unimportant. A value greater than -0.5 should be safe.
set spi_mst_out_max_ratio	0.80
set spi_mst_out_min_ratio	0.00

# SPI slave-mode output delay ratio (relative to one spi_clk_in period)
# In SPI slave mode, use one edge of spi_clk_in (pos/neg) to send out the data
# to the external SPI master and the external master uses the immediately next
# edge (neg/pos) to sample the data. This means we have less than half a clock
# period of time (negedge->posedge). That is, the output delay ratio must be
# greater than 0.5. In addition, we need to make sure the setup time is enough
# for general masters and the slave-mode spi_clk_in should not be too fast. As
# a result, we choose a big value close to 1.0. The user may relax/tighten the
# ratio according to how much margin should be left for the external master.
# Since the external master flops data at the other edge, the hold time check
# is unimportant. A value greater than -0.5 should be safe.
set spi_slv_out_max_ratio	0.90
set spi_slv_out_min_ratio	0.00

# The margin left for CDC synchronization of flops (in library time unit)
set spi_cdc_margin		0.50

# Misc input/output delay ratios
# Assume 70% time is consumed externally for setup time checks (as max delay)
# The hold time check may be adjusted according to the full-chip environment.
# In fullchip-level STA, connections among blocks will be accurately checked.
set misc_in_max_ratio		0.70
set misc_in_min_ratio		0.05
set misc_out_max_ratio		0.70
set misc_out_min_ratio		0.05

#
# Clock-related variables
#

# Clock uncertainty for ideal clocks for Pre-CTS
if {! [info exists clock_uncertainty]} {
	set clock_uncertainty		0.3
}

# Clock transition for ideal clocks for Pre-CTS
if {! [info exists clock_transition]} {
	set clock_transition		0.1
}

# EILM clock period
if {![info exists env(eilm_clk_period)]} {
	set eilm_clk_period		5.0
} else {
	set eilm_clk_period		$env(eilm_clk_period)
}

# AHB clock period
if {![info exists env(hclk_period)]} {
	set hclk_period			10.0
} else {
	set hclk_period			$env(hclk_period)
}

# APB clock period (integer multiple of EILM/AHB clock)
if {![info exists env(pclk_period)]} {
	set pclk_period			20.0
} else {

	set pclk_period			$env(pclk_period)
}

# Clock period of spi_clock
if {![info exists env(spi_clk_period)]} {
	set spi_clk_period		10.0
} else {
	set spi_clk_period		$env(spi_clk_period)
}

# Clock network latency of spi_clock
# The value itself is not important. We just use this to mimic the CTS result
# so that we can have better feeling about the correctness of constraints.
if {![info exists env(spi_clk_latency)]} {
	set spi_clk_latency		[expr $spi_clk_period * 0.3]
} else {
	set spi_clk_latency		$env(spi_clk_latency)
}

# Clock period of slave-mode spi_clk_in
# It must be at least 4x slower than spi_clock.
if {![info exists env(spi_s_sclk_period)]} {
	set spi_s_sclk_period		[expr $spi_clk_period * 4.0]
} else {
	set spi_s_sclk_period		$env(spi_s_sclk_period)
}

# Clock network latency of master-mode spi_clk_in
# In master mode, spi_clk_in is the loopback version of spi_clock through
# spi_clk_out and the I/O pad. spi_m_sclk_delay specifies the delay of
# spi_clk_in relative to spi_clock for pre-CTS. To be more precise:
#   A: The time spi_clock toggles at the internal flop's clock pin
#   B: The time spi_clk_in toggles at the internal flop's clock pin for
#      the same spi_clock edge of time A
# spi_m_sclk_delay is (B-A) and it must be less than $spi_clk_period. We just
# use this to mimic the CTS result to make sure the timing constraints are
# correct so the value itself is not very important. This will be ignored in
# the post-CTS stage where real clock trees are present.
if {![info exists env(spi_m_sclk_delay)]} {
	set spi_m_sclk_delay		[expr $spi_clk_period * 0.9]
} else {
	set spi_m_sclk_delay		$env(spi_m_sclk_delay)
}

#
# Configuration variables
#

set ahbbus_exist	[expr [sizeof_collection [get_ports -quiet hclk			]] != 0]
set eilmbus_exist	[expr [sizeof_collection [get_ports -quiet eilm_clk		]] != 0]
set apbbus_exist	[expr [sizeof_collection [get_ports -quiet pclk			]] != 0]
set ahb_mem_support	[expr [sizeof_collection [get_ports -quiet hsel_mem		]] != 0]
set reg_ahbbus		[expr [sizeof_collection [get_ports -quiet hsel_reg		]] != 0]
set reg_eilmbus		[expr [sizeof_collection [get_ports -quiet eilm_reg_sel		]] != 0]
set hsplit_support	[expr [sizeof_collection [get_ports -quiet hsplit		]] != 0]
set quadspi_support	[expr [sizeof_collection [get_ports -quiet spi_wp_n_oe		]] != 0]
set slave_support	[expr [sizeof_collection [get_ports -quiet spi_default_as_slave	]] != 0]

#
# Synthesizer-built-in variables
#

# Allow analysis of multiple clocks on a register
set timing_enable_multiple_clocks_per_reg	true

#
# Misc variables
#

# Max fanout
if {![info exists env(max_fanout)]} {
	set max_fanout			64
} else {
	set max_fanout			$env(max_fanout)
}

if {![info exists tech_lib]} {
	set tech_lib			""
	set driving_cell		""
	set load_val			1
	set operating_cond		""
}

# -------------------------------------------------------------
# Clean up existing constraints
# -------------------------------------------------------------
reset_design


# -------------------------------------------------------------
# Case analyses
# -------------------------------------------------------------
set_case_analysis 0 [get_ports scan_test]

# If spi_mode[1:0] is not fixed, spi_clk_out-related timing becomes very
# complicated. For example, if spi_clk_out is the non-inverting SPI_CLOCK, it
# may be actually internally inverted twice. In addition, both posedge and
# negedge can happen at the same time from the inverted/non-inverted source.
# These cause complex setup/hold violations and can't be resolved by currently
# available commands which can't specify the source clock edge of the
# start point.
set_case_analysis $spi_mode_0 [get_pins {u_spi_reg/spi_mode*0*}]
set_case_analysis $spi_mode_1 [get_pins {u_spi_reg/spi_mode*1*}]


# -------------------------------------------------------------
# Clock creation
# -------------------------------------------------------------
if {$ahbbus_exist} {
	create_clock -name HCLK -period $hclk_period [get_ports hclk]
}

if {$eilmbus_exist} {
	create_clock -name EILM_CLK -period $eilm_clk_period [get_ports eilm_clk]
}

if {$apbbus_exist} {
	create_clock -name PCLK -period $pclk_period [get_ports pclk]
}

create_clock -name SPI_CLOCK -period $spi_clk_period [get_ports spi_clock]
# A clock divider to generate a lower-frequency spi_clock.
create_generated_clock [get_pins u_spi_spiif/master_sclk_r_reg/Q] -name SPI_CLOCK_DIV -divide_by 2 -source [get_ports spi_clock] -master [get_clocks SPI_CLOCK] -add

# For ORG and INV clocks, each may have two possible paths based on spi_mode[]:
#   Non-inverting path: 0 ^ org | 1 ^ inv
#   Inverting path:     1 ^ org | 0 ^ inv
# When spi_mode[] is fixed, things become much easier.
#   2'b00: spi_clk_out = master_sclk =  (~spi_clock or master_sclk_r) = ~spi_clock or  master_sclk_r
#   2'b01: spi_clk_out = master_sclk =  ( spi_clock or master_sclk_r) =  spi_clock or  master_sclk_r
#   2'b10: spi_clk_out = master_sclk = ~(~spi_clock or master_sclk_r) =  spi_clock or ~master_sclk_r
#   2'b11: spi_clk_out = master_sclk = ~( spi_clock or master_sclk_r) = ~spi_clock or ~master_sclk_r
if {$spi_mode_0 == $spi_mode_1} {
	create_generated_clock [get_ports spi_clk_out] -name SPI_CLK_OUT_ORG -divide_by 1 -source [get_ports spi_clock]                      -master [get_clocks SPI_CLOCK    ] -add -comb -invert
} else {
	create_generated_clock [get_ports spi_clk_out] -name SPI_CLK_OUT_ORG -divide_by 1 -source [get_ports spi_clock]                      -master [get_clocks SPI_CLOCK    ] -add -comb
}
if {$spi_mode_1} {
	create_generated_clock [get_ports spi_clk_out] -name SPI_CLK_OUT_DIV -divide_by 1 -source [get_pins u_spi_spiif/master_sclk_r_reg/Q] -master [get_clocks SPI_CLOCK_DIV] -add -comb -invert
} else {
	create_generated_clock [get_ports spi_clk_out] -name SPI_CLK_OUT_DIV -divide_by 1 -source [get_pins u_spi_spiif/master_sclk_r_reg/Q] -master [get_clocks SPI_CLOCK_DIV] -add -comb
}

# Then create the loopback version of the SPI output clock. The M_SCLK version
# of clock lags behind the CLK_OUT version by ($spi_m_sclk_delay/2).
# In master mode, spi_clk_in is the loopback of spi_clock/master_sclk_r.
# Since the bi-directional pad doesn't exist in the block-level environment
# (no physical path exists), create_generated_clock works basically like
# create_clock.
create_generated_clock [get_ports spi_clk_in] -name SPI_M_SCLK_ORG -divide_by 1 -source [get_ports spi_clk_out] -master [get_clocks SPI_CLK_OUT_ORG] -add -comb
create_generated_clock [get_ports spi_clk_in] -name SPI_M_SCLK_DIV -divide_by 1 -source [get_ports spi_clk_out] -master [get_clocks SPI_CLK_OUT_DIV] -add -comb

if {$slave_support} {
	# In slave mode, spi_clk_in comes from the external master's
	# spi_clk_out which equals that master's spi_clock/master_sclk_r.
	# According to the design, spi_clk_in's frequency must be lower than
	# 1/4 of spi_clock's.
	create_clock [get_ports spi_clk_in] -name SPI_S_SCLK -period $spi_s_sclk_period -add

	# For the CDC timing checks to spi_out_slv_r*/spi_oe_slv_r* (from
	# SPI_CLOCK to SPI_S_SCLK asynchronously).
	create_clock [get_ports spi_clock] -name CDC_SPI_CLOCK -period $spi_clk_period -add
	create_clock [get_ports spi_clk_in] -name CDC_SPI_S_SCLK -period $spi_s_sclk_period -add
}


if {$pre_cts} {
	# Set ideal clock properties.

	if ${ahbbus_exist} {
		set_ideal_network [get_ports hclk]
	}
	if {$eilmbus_exist} {
		set_ideal_network [get_ports eilm_clk]
	}
	if {$apbbus_exist} {
		set_ideal_network [get_ports pclk]
	}
	set_ideal_network [get_ports spi_clock]
	set_ideal_network [get_pins u_spi_spiif/master_sclk_r_reg/Q]
	set_ideal_network [get_ports spi_clk_in]

	# Mimic the clock tree delay.
	# We can't use the network latency since spi_clk_out won't see this
	# latency and data checks will be violated.
	# Actually clock latency is unimportant for synthesis. It's just used
	# to make the block-level timing report resemble the full-chip one.
	set_clock_latency -source $spi_clk_latency [get_clocks SPI_CLOCK]
	set_clock_latency -source $spi_clk_latency [get_clocks SPI_CLOCK_DIV]

	# The clock propagation to the I/O pad takes some time ($spi_m_sclk_delay/2).
	set_clock_latency -source [expr $spi_clk_latency + $spi_m_sclk_delay / 2.0] [get_clocks SPI_CLK_OUT_ORG]
	set_clock_latency -source [expr $spi_clk_latency + $spi_m_sclk_delay / 2.0] [get_clocks SPI_CLK_OUT_DIV]

	# Note: It's required that the delay (spi_m_sclk_delay) of spi_clk_in
	# related to the source (spi_clock/master_sclk_r) be less than one
	# clock period so that spi_in_d1_r (directly clocked by ~spi_clock) can
	# safely see the flopped data of spi_in_r_reg (always effecitvely
	# clocked by ~spi_clock, which is delayed by $spi_m_sclk_delay). This
	# affects the following timing path in 1:1 master mode:
	# SPI_CLOCK~($spi_m_sclk_delay)~>SPI_M_SCLK_ORG~>spi_in_r_reg*/CP (inverted clock path)
	#   -> spi_in_d1_r_reg*/D (clocked by SPI_CLOCK')
	set_clock_latency -source [expr $spi_clk_latency + $spi_m_sclk_delay] [get_clocks SPI_M_SCLK_*]

	# Clock skew
	set_clock_uncertainty -setup $clock_uncertainty [all_clocks]

	# Clock transition
	set_clock_transition $clock_transition [all_clocks]
} else {
	set_propagated_clock [all_clocks]

	# The loopback path doesn't exist in the block-level environment.
	# Mimic the delay caused by this path.
	set_clock_latency -source [expr $spi_m_sclk_delay] [get_clocks SPI_M_SCLK_*]

	if {$slave_support} {
		# Make CDC_* clocks ideal to not consider the clock insertion
		# delay.
		remove_propagated_clock [get_clocks CDC_*]
	}
}

# -------------------------------------------------------------
# Clock relationships
# -------------------------------------------------------------
# These clocks are created at the same port.
set_clock_groups -physically_exclusive -name clkgrp_SPI_CLK_OUT_ORG_DIV -group SPI_CLK_OUT_ORG -group SPI_CLK_OUT_DIV
set_clock_groups -physically_exclusive -name clkgrp_SPI_M_SCLK_ORG_DIV -group SPI_M_SCLK_ORG -group SPI_M_SCLK_DIV

# One input spi_clk_in (ORG or DIV) type won't co-exist with the other
# spi_clk_out type since it's derived from the same type of spi_clk_out.
set_clock_groups -physically_exclusive -name clkgrp_SPI_CLK_OUT_ORG_SPI_M_SCLK_DIV -group SPI_CLK_OUT_ORG -group SPI_M_SCLK_DIV
set_clock_groups -physically_exclusive -name clkgrp_SPI_CLK_OUT_DIV_SPI_M_SCLK_ORG -group SPI_CLK_OUT_DIV -group SPI_M_SCLK_ORG

if {$ahbbus_exist} {
	set_clock_groups -asynchronous -name clkgrp_HCLK_SPI -group HCLK -group {SPI*}
}

if {$eilmbus_exist} {
	set_clock_groups -asynchronous -name clkgrp_EILM_SPI -group EILM_CLK -group {SPI*}
}

if {$apbbus_exist} {
	set_clock_groups -asynchronous -name clkgrp_PCLK_SPI -group PCLK -group {SPI*}
}

if {$slave_support} {
	# Master and slave-mode spi_clk_in clocks won't co-exist.
	set_clock_groups -physically_exclusive -name clkgrp_SPI_CLK_OUT_S_SCLK -group {SPI_CLK_OUT*} -group {SPI_S_SCLK}
	set_clock_groups -physically_exclusive -name clkgrp_SPI_M_S_SCLK -group {SPI_M_SCLK_*} -group {SPI_S_SCLK}

	# These two clocks have no relationship. Use CDC clocks to guarantee
	# the signals won't have too bad timing when crossing clock domains.
	set_clock_groups -asynchronous -name clkgrp_SPI_CLOCK_S_SCLK -group SPI_CLOCK -group SPI_S_SCLK

	# CDC clocks are only for CDC checks. They have nothing to do with
	# other normal clocks.
	set_clock_groups -physically_exclusive -name clkgrp_CDC_SPI_OTHERS -group {CDC_SPI*} -group [remove_from_collection [all_clocks] [get_clocks {CDC_SPI*}]]

	# Check CDC SPI clock crossings with SI consideration.
	set_clock_groups -asynchronous -name clkgrp_CDC_SPI_CLOCK_S_SCLK -group CDC_SPI_CLOCK -group CDC_SPI_S_SCLK -allow_paths

	# The intra-clock checks are covered by non-CDC clocks.
	foreach_in_collection cdc_clk [get_clocks CDC_SPI*] {
		set_false_path -from $cdc_clk -to $cdc_clk
	}
}

# -------------------------------------------------------------
# I/O constraints
# -------------------------------------------------------------
# The clock for scan_test/scan_enable is unimportant since they will be set
# false path.
set_input_delay 0 [get_ports scan_test]   -clock SPI_CLOCK
set_input_delay 0 [get_ports scan_enable] -clock SPI_CLOCK

#
# AHB bus
#
if {$ahbbus_exist} {
	# The AHB_MEM interface is also considered by using "*".
	set_input_delay  -max [expr $hclk_period * $misc_in_max_ratio] -clock HCLK [get_ports hresetn]
	set_input_delay  -max [expr $hclk_period * $misc_in_max_ratio] -clock HCLK [get_ports hsel*]
	set_input_delay  -max [expr $hclk_period * $misc_in_max_ratio] -clock HCLK [get_ports htrans*]
	set_input_delay  -max [expr $hclk_period * $misc_in_max_ratio] -clock HCLK [get_ports hwrite*]
	set_input_delay  -max [expr $hclk_period * $misc_in_max_ratio] -clock HCLK [get_ports haddr*]
	set_input_delay  -max [expr $hclk_period * $misc_in_max_ratio] -clock HCLK [get_ports hreadyin*]

	set_input_delay  -min [expr $hclk_period * $misc_in_min_ratio] -clock HCLK [get_ports hresetn]
	set_input_delay  -min [expr $hclk_period * $misc_in_min_ratio] -clock HCLK [get_ports hsel*]
	set_input_delay  -min [expr $hclk_period * $misc_in_min_ratio] -clock HCLK [get_ports htrans*]
	set_input_delay  -min [expr $hclk_period * $misc_in_min_ratio] -clock HCLK [get_ports hwrite*]
	set_input_delay  -min [expr $hclk_period * $misc_in_min_ratio] -clock HCLK [get_ports haddr*]
	set_input_delay  -min [expr $hclk_period * $misc_in_min_ratio] -clock HCLK [get_ports hreadyin*]

	if {$apbbus_exist} {
		set_input_delay  -max [expr $hclk_period * $misc_in_max_ratio] -clock HCLK [get_ports apb2ahb_clken]
		set_input_delay  -min [expr $hclk_period * $misc_in_min_ratio] -clock HCLK [get_ports apb2ahb_clken]
	}		
}

if {$hsplit_support} {
	set_input_delay  -max [expr $hclk_period * $misc_in_max_ratio ] -clock HCLK [get_ports hmaster*]
	set_input_delay  -min [expr $hclk_period * $misc_in_min_ratio ] -clock HCLK [get_ports hmaster*]
}

if {$reg_ahbbus} {
	set_input_delay  -max [expr $hclk_period * $misc_in_max_ratio ] -clock HCLK [get_ports hwdata*]
	set_input_delay  -min [expr $hclk_period * $misc_in_min_ratio ] -clock HCLK [get_ports hwdata*]

	set_output_delay -max [expr $hclk_period * $misc_out_max_ratio] -clock HCLK [get_ports hreadyout_reg]
	set_output_delay -max [expr $hclk_period * $misc_out_max_ratio] -clock HCLK [get_ports hresp_reg*]
	set_output_delay -max [expr $hclk_period * $misc_out_max_ratio] -clock HCLK [get_ports hrdata_reg*]

	set_output_delay -min [expr $hclk_period * $misc_out_max_ratio] -clock HCLK [get_ports hreadyout_reg]
	set_output_delay -min [expr $hclk_period * $misc_out_max_ratio] -clock HCLK [get_ports hresp_reg*]
	set_output_delay -min [expr $hclk_period * $misc_out_max_ratio] -clock HCLK [get_ports hrdata_reg*]
}

if {$ahb_mem_support} {
	set_output_delay -max [expr $hclk_period * $misc_out_max_ratio] -clock HCLK [get_ports hrdata_mem*]
	set_output_delay -max [expr $hclk_period * $misc_out_max_ratio] -clock HCLK [get_ports hreadyout_mem]
	set_output_delay -max [expr $hclk_period * $misc_out_max_ratio] -clock HCLK [get_ports hresp_mem*]

	set_output_delay -min [expr $hclk_period * $misc_out_min_ratio] -clock HCLK [get_ports hrdata_mem*]
	set_output_delay -min [expr $hclk_period * $misc_out_min_ratio] -clock HCLK [get_ports hreadyout_mem]
	set_output_delay -min [expr $hclk_period * $misc_out_min_ratio] -clock HCLK [get_ports hresp_mem*]

	if {$hsplit_support} {
		set_output_delay -max [expr $hclk_period * $misc_out_max_ratio] -clock HCLK [get_ports hsplit*]
		set_output_delay -min [expr $hclk_period * $misc_out_min_ratio] -clock HCLK [get_ports hsplit*]
	}
}


#
# EILM bus
#
if {$eilmbus_exist} {
	set_input_delay  -max [expr $eilm_clk_period * $misc_in_max_ratio] -clock EILM_CLK [get_ports eilm_resetn]
	set_input_delay  -max [expr $eilm_clk_period * $misc_in_max_ratio] -clock EILM_CLK [get_ports eilm_req]
	set_input_delay  -max [expr $eilm_clk_period * $misc_in_max_ratio] -clock EILM_CLK [get_ports eilm_web*]
	set_input_delay  -max [expr $eilm_clk_period * $misc_in_max_ratio] -clock EILM_CLK [get_ports eilm_wait_cnt*]
	set_input_delay  -max [expr $eilm_clk_period * $misc_in_max_ratio] -clock EILM_CLK [get_ports eilm_addr*]
	set_input_delay  -max [expr $eilm_clk_period * $misc_in_max_ratio] -clock EILM_CLK [get_ports eilm_wdata*]

	set_input_delay  -min [expr $eilm_clk_period * $misc_in_min_ratio] -clock EILM_CLK [get_ports eilm_resetn]
	set_input_delay  -min [expr $eilm_clk_period * $misc_in_min_ratio] -clock EILM_CLK [get_ports eilm_req]
	set_input_delay  -min [expr $eilm_clk_period * $misc_in_min_ratio] -clock EILM_CLK [get_ports eilm_web*]
	set_input_delay  -min [expr $eilm_clk_period * $misc_in_min_ratio] -clock EILM_CLK [get_ports eilm_wait_cnt*]
	set_input_delay  -min [expr $eilm_clk_period * $misc_in_min_ratio] -clock EILM_CLK [get_ports eilm_addr*]
	set_input_delay  -min [expr $eilm_clk_period * $misc_in_min_ratio] -clock EILM_CLK [get_ports eilm_wdata*]

	if {!$ahbbus_exist && $apbbus_exist} {
		# Unlike other input ports driven by other IPs or pads,
		# apb2eilm_clken is aligned with pclk and eilm_clk so it
		# shouldn't have too worse input delay. In addition,
		# ahb2eilm_clken will directly affect the output port
		# eilm_wait so let's use a smaller input delay.
		set_input_delay  -max [expr $eilm_clk_period * 0.3] -clock EILM_CLK [get_ports apb2eilm_clken]
		set_input_delay  -min [expr $eilm_clk_period * 0.0] -clock EILM_CLK [get_ports apb2eilm_clken]
	}
	if {$ahbbus_exist} {
		# Unlike other input ports driven by other IPs or pads,
		# ahb2eilm_clken is aligned with hclk and eilm_clk so it
		# shouldn't have too worse input delay. In addition,
		# ahb2eilm_clken will directly affect the output port
		# eilm_wait so let's use a smaller input delay.
		set_input_delay  -max [expr $eilm_clk_period * 0.3] -clock EILM_CLK [get_ports ahb2eilm_clken]
		set_input_delay  -min [expr $eilm_clk_period * 0.0] -clock EILM_CLK [get_ports ahb2eilm_clken]
	}

	if {$reg_eilmbus} {
		set_input_delay  -max [expr $eilm_clk_period * $misc_in_max_ratio] -clock EILM_CLK [get_ports eilm_reg_sel]
	}
}

if {$eilmbus_exist} {
	set_output_delay -max [expr $eilm_clk_period * $misc_in_max_ratio] -clock EILM_CLK [get_ports eilm_rdata*]
	# There's a pass-through path from ahb2eilm_clken to eilm_wait. In
	# addition, CPU will directly flop eilm_wait so that the timing can be
	# relaxed.
	set_output_delay -max [expr $eilm_clk_period * 0.5               ] -clock EILM_CLK [get_ports eilm_wait]

	set_output_delay -min [expr $eilm_clk_period * $misc_in_min_ratio] -clock EILM_CLK [get_ports eilm_rdata*]
	set_output_delay -min [expr $eilm_clk_period * $misc_in_min_ratio] -clock EILM_CLK [get_ports eilm_wait]
}

#
# APB bus
#
if {$apbbus_exist} {
	set_input_delay  -max [expr $pclk_period * $misc_in_max_ratio] -clock PCLK [get_ports presetn]
	set_input_delay  -max [expr $pclk_period * $misc_in_max_ratio] -clock PCLK [get_ports psel]
	set_input_delay  -max [expr $pclk_period * $misc_in_max_ratio] -clock PCLK [get_ports penable]
	set_input_delay  -max [expr $pclk_period * $misc_in_max_ratio] -clock PCLK [get_ports pwrite]
	set_input_delay  -max [expr $pclk_period * $misc_in_max_ratio] -clock PCLK [get_ports paddr*]
	set_input_delay  -max [expr $pclk_period * $misc_in_max_ratio] -clock PCLK [get_ports pwdata*]
}

if {$apbbus_exist} {
	set_output_delay -max [expr $pclk_period * $misc_in_max_ratio] -clock PCLK [get_ports prdata*]
	set_output_delay -min [expr $pclk_period * $misc_in_min_ratio] -clock PCLK [get_ports prdata*]
	set_output_delay -max [expr $pclk_period * $misc_in_max_ratio] -clock PCLK [get_ports pready]
	set_output_delay -min [expr $pclk_period * $misc_in_min_ratio] -clock PCLK [get_ports pready]
}


#
# SPI bus (direct I/O mode is not considered since register writes are slow and
# the following constraints should also solve related issues)
#

# The procedure to set input delay for both master and slave modes
proc mode_set_spi_in_delay {clk ports} {
	global spi_mode_1
	global spi_mode_0
	global spi_clk_period
	global spi_in_max_ratio
	global spi_in_min_ratio
	# (posedge spi_r_clk) is used to sample the input SPI data to spi_in_r,
	# so set the input delay related to the corresponding edge.
	# Based on spi_mode:
	#   2'b00: spi_r_clk =  spi_clk_in
	#   2'b01: spi_r_clk = ~spi_clk_in
	#   2'b10: spi_r_clk = ~spi_clk_in
	#   2'b11: spi_r_clk =  spi_clk_in
	if {$spi_mode_1 == $spi_mode_0} {
		# Non-inverting so use the negative edge of spi_clk_in to put
		# the data.
		set_input_delay  -max [expr $spi_clk_period * $spi_in_max_ratio] -clock $clk $ports -add -clock_fall
		set_input_delay  -min [expr $spi_clk_period * $spi_in_min_ratio] -clock $clk $ports -add -clock_fall
	} else {
		# Inverted so use the positive edge of spi_clk_in to put the
		# data.
		set_input_delay  -max [expr $spi_clk_period * $spi_in_max_ratio] -clock $clk $ports -add
		set_input_delay  -min [expr $spi_clk_period * $spi_in_min_ratio] -clock $clk $ports -add
	}
}

# The procedure to set master-mode output delay
proc mode_set_spi_mst_out_delay {clk ports} {
	global spi_mode_1
	global spi_mode_0
	global spi_clk_period
	global spi_mst_out_max_ratio
	global spi_mst_out_min_ratio
	# (posedge spi_clock) is used to clock spi_out_r/spi_oe_r to put the
	# output SPI data, so set the output delay related to the
	# corresponding edge. Based on spi_mode:
	#   2'b00: spi_clk_out = master_sclk =  (~spi_clock | master_sclk_r) = ~spi_clock |  master_sclk_r
	#   2'b01: spi_clk_out = master_sclk =  ( spi_clock | master_sclk_r) =  spi_clock |  master_sclk_r
	#   2'b10: spi_clk_out = master_sclk = ~(~spi_clock | master_sclk_r) =  spi_clock | ~master_sclk_r
	#   2'b11: spi_clk_out = master_sclk = ~( spi_clock | master_sclk_r) = ~spi_clock | ~master_sclk_r
	# Since data is always put on (posedge spi_clock) and the delay ratio is
	# specified based on a spi_clock period, we need to find the next clock
	# edge which is one spi_clock period away to do the timing check.
	if {$clk eq "SPI_CLK_OUT_ORG"} {
		# The 1:1 clock path: spi_clock (SPI_CLK_OUT_ORG)
		if {$spi_mode_1 == $spi_mode_0} {
			# ~spi_clock: One cycle away from (posedge spi_clock)
			# is (negedge SPI_CLK_OUT_ORG).
			set_output_delay -max [expr $spi_clk_period * $spi_mst_out_max_ratio] -clock $clk $ports -add -clock_fall
			set_output_delay -min [expr $spi_clk_period * $spi_mst_out_min_ratio] -clock $clk $ports -add -clock_fall
		} else {
			#  spi_clock: One cycle away from (posedge spi_clock)
			#  is (posedge SPI_CLK_OUT_ORG).
			set_output_delay -max [expr $spi_clk_period * $spi_mst_out_max_ratio] -clock $clk $ports -add
			set_output_delay -min [expr $spi_clk_period * $spi_mst_out_min_ratio] -clock $clk $ports -add
		}
	} else {
		# The N:1 clock path: master_sclk_r (SPI_CLK_OUT_DIV)
		# SPI_CLK_OUT_DIV has twice the period in this SDC. However,
		# since we don't set multicycle path, one spi_clk_period will
		# still be used for setup time checks.
		if {$spi_mode_1 == 0} {
			#  master_sclk_r: One cycle away from (posedge
			#  spi_clock) is (posedge SPI_CLK_OUT_DIV).
			set_output_delay -max [expr $spi_clk_period * $spi_mst_out_max_ratio] -clock $clk $ports -add
			set_output_delay -min [expr $spi_clk_period * $spi_mst_out_min_ratio] -clock $clk $ports -add
		} else {
			# ~master_sclk_r: One cycle away from (posedge
			# spi_clock) is (negedge SPI_CLK_OUT_DIV).
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
	# (posedge spi_w_clk_slv) is used to put the output SPI data to
	# spi_out_slv_r/spi_oe_slv_r, so set the output delay related to the
	# corresponding edge. Based on spi_mode:
	#   2'b00: spi_w_clk_slv = ~spi_r_clk = ~spi_clk_in
	#   2'b01: spi_w_clk_slv = ~spi_r_clk =  spi_clk_in
	#   2'b10: spi_w_clk_slv = ~spi_r_clk =  spi_clk_in
	#   2'b11: spi_w_clk_slv = ~spi_r_clk = ~spi_clk_in
	if {$spi_mode_1 == $spi_mode_0} {
		# posedge ~spi_clk_in: Data is put on the falling edge so also
		# use the falling edge to check the data since the ratio is
		# specified based on a SPI_S_SCLK period.
		set_output_delay -max [expr $spi_s_sclk_period * $spi_slv_out_max_ratio] -clock $clk $ports -add -clock_fall
		set_output_delay -min [expr $spi_s_sclk_period * $spi_slv_out_min_ratio] -clock $clk $ports -add -clock_fall
	} else {
		# posedge  spi_clk_in: Data is put on the rising edge so also
		# use the rising edge to check the data since the ratio is
		# specified based on a SPI_S_SCLK period.
		set_output_delay -max [expr $spi_s_sclk_period * $spi_slv_out_max_ratio] -clock $clk $ports -add
		set_output_delay -min [expr $spi_s_sclk_period * $spi_slv_out_min_ratio] -clock $clk $ports -add
	}
}


# Master-mode input delay settings
foreach clk {SPI_CLK_OUT_ORG SPI_CLK_OUT_DIV} {
	mode_set_spi_in_delay $clk [get_ports spi_mosi_in] 
	mode_set_spi_in_delay $clk [get_ports spi_miso_in] 
	if {$quadspi_support} {
		mode_set_spi_in_delay $clk [get_ports spi_wp_n_in  ]
		mode_set_spi_in_delay $clk [get_ports spi_hold_n_in] 
	}
}

# Master-mode output delay settings
foreach clk {SPI_CLK_OUT_ORG SPI_CLK_OUT_DIV} {
	# spi_cs_n_out is only used in master mode and is clocked by (posedge
	# spi_clock).
	mode_set_spi_mst_out_delay $clk [get_ports spi_cs_n_out]

	# In master mode, {spi_mosi_out, spi_miso_out, spi_wp_n_out,
	# spi_hold_n_out} are driven by spi_out_r[] which is clocked by
	# spi_clock.
	mode_set_spi_mst_out_delay $clk [get_ports spi_mosi_out]
	mode_set_spi_mst_out_delay $clk [get_ports spi_miso_out]
	mode_set_spi_mst_out_delay $clk [get_ports spi_mosi_oe ]
	mode_set_spi_mst_out_delay $clk [get_ports spi_miso_oe ]
	if {$quadspi_support} {
		mode_set_spi_mst_out_delay $clk [get_ports spi_wp_n_out  ]
		mode_set_spi_mst_out_delay $clk [get_ports spi_hold_n_out]
		mode_set_spi_mst_out_delay $clk [get_ports spi_wp_n_oe   ]
		mode_set_spi_mst_out_delay $clk [get_ports spi_hold_n_oe ]
	}
}

if {$slave_support} {
	#
	# Input delay settings
	#
	mode_set_spi_in_delay SPI_S_SCLK [get_ports spi_miso_in] 
	mode_set_spi_in_delay SPI_S_SCLK [get_ports spi_mosi_in] 

	if {$quadspi_support} {
		mode_set_spi_in_delay SPI_S_SCLK [get_ports spi_wp_n_in  ]
		mode_set_spi_in_delay SPI_S_SCLK [get_ports spi_hold_n_in] 
	}

	#
	# Output delay settings
	#
	# In slave mode, {spi_mosi_out, spi_miso_out, spi_wp_n_out,
	# spi_hold_n_out} and {spi_mosi_oe, spi_miso_oe, spi_wp_n_oe,
	# spi_hold_n_oe} are driven by spi_out_slv_r[]/spi_oe_slv_r[]
	# which are clocked by (posedge/negedge spi_clk_in).
	mode_set_spi_slv_out_delay SPI_S_SCLK [get_ports spi_mosi_out]
	mode_set_spi_slv_out_delay SPI_S_SCLK [get_ports spi_miso_out]
	if {$quadspi_support} {
		mode_set_spi_slv_out_delay SPI_S_SCLK [get_ports spi_wp_n_out  ]
		mode_set_spi_slv_out_delay SPI_S_SCLK [get_ports spi_hold_n_out]
	}

	mode_set_spi_slv_out_delay SPI_S_SCLK [get_ports spi_mosi_oe]
	mode_set_spi_slv_out_delay SPI_S_SCLK [get_ports spi_miso_oe]
	if {$quadspi_support} {
		mode_set_spi_slv_out_delay SPI_S_SCLK [get_ports spi_wp_n_oe  ]
		mode_set_spi_slv_out_delay SPI_S_SCLK [get_ports spi_hold_n_oe]
	}

	# spi_cs_n_in should be asserted much earlier. A rough timing check is
	# used to make sure spi_cs_n_in won't have too bad timing so the input
	# delay is 0. And the hold time check is unnecessary.
	set_input_delay -max 0 -clock SPI_S_SCLK [get_ports spi_cs_n_in]
}


#
# regclk-related
#
if {$reg_ahbbus} {
	set regclk		[get_clocks HCLK]
	set regclk_period	$hclk_period
} elseif {$reg_eilmbus} {
	set regclk		[get_clocks EILM_CLK]
	set regclk_period	$eilm_clk_period
} else {
	set regclk		[get_clocks PCLK]
	set regclk_period	$pclk_period
}

set_input_delay 0 -clock $regclk [get_ports spi_rstn]

# spi_clk_oe and spi_cs_n_oe are either constant or quasi-static w.r.t. regclk.
# Constrain them to have a reasonable amount of delay (just not too big). Hold
# time is don't care.
set_output_delay -max [expr $regclk_period * 0.5] -clock $regclk [get_ports spi_clk_oe ]
set_output_delay -max [expr $regclk_period * 0.5] -clock $regclk [get_ports spi_cs_n_oe]


# If spi_default_mode3 and spi_default_as_slave are constants, they can be
# set_case_analysis'ed.
if {$slave_support} {
	set_input_delay  -max [expr $regclk_period * $misc_in_max_ratio] -clock $regclk [get_ports spi_default_as_slave]
	set_input_delay  -min [expr $regclk_period * $misc_in_min_ratio] -clock $regclk [get_ports spi_default_as_slave]
}

set_input_delay  -max [expr $regclk_period * $misc_in_max_ratio ] -clock $regclk [get_ports spi_default_mode3]
set_input_delay  -max [expr $regclk_period * $misc_in_max_ratio ] -clock $regclk [get_ports spi_rx_dma_ack]
set_input_delay  -max [expr $regclk_period * $misc_in_max_ratio ] -clock $regclk [get_ports spi_tx_dma_ack]

set_input_delay  -min [expr $regclk_period * $misc_in_min_ratio ] -clock $regclk [get_ports spi_default_mode3]
set_input_delay  -min [expr $regclk_period * $misc_in_min_ratio ] -clock $regclk [get_ports spi_rx_dma_ack]
set_input_delay  -min [expr $regclk_period * $misc_in_min_ratio ] -clock $regclk [get_ports spi_tx_dma_ack]

set_output_delay -max [expr $regclk_period * $misc_out_max_ratio] -clock $regclk [get_ports spi_boot_intr]
set_output_delay -max [expr $regclk_period * $misc_out_max_ratio] -clock $regclk [get_ports spi_rx_dma_req]
set_output_delay -max [expr $regclk_period * $misc_out_max_ratio] -clock $regclk [get_ports spi_tx_dma_req]

set_output_delay -min [expr $regclk_period * $misc_out_min_ratio] -clock $regclk [get_ports spi_boot_intr]
set_output_delay -min [expr $regclk_period * $misc_out_min_ratio] -clock $regclk [get_ports spi_rx_dma_req]
set_output_delay -min [expr $regclk_period * $misc_out_min_ratio] -clock $regclk [get_ports spi_tx_dma_req]

# -------------------------------------------------------------
# Timing exceptions
# -------------------------------------------------------------
# Scan and resets are not considered by us.
set_false_path -from [get_ports scan_enable]

set_false_path -from [get_ports spi_rstn]

if {$ahbbus_exist} {
	set_false_path -from [get_ports hresetn]
}
if {$eilmbus_exist} {
	set_false_path -from [get_ports eilm_resetn]
}
if {$apbbus_exist} {
	set_false_path -from [get_ports presetn]
}

if {$slave_support} {
	# The master-mode clock will also propagate to a_signal_sync's D.
	# However, a_signal_sync is only used to sample the slave-mode clock.
	set_false_path -from [get_clocks SPI_M_SCLK_*] -to [get_cells u_spi_spiif/spi_clk_in_syn/a_signal_sync*0*]
	# Don't consider the master-mode spi_clk_in clocks for slave-mode
	# output registers since now those clocks should be using SPI_S_SCLK.
	set_false_path -from [get_clocks SPI_M_SCLK_*] -through [get_cells u_spi_spiif/spi_*_slv_r_*]
	# We don't care the hold time for syncing registers.
	set_false_path -hold -to [get_cells u_spi_spiif/spi_clk_in_syn/a_signal_sync*0*]
}

#
# Relationship for SCLK -> SPI_CLOCK -> SCLK in slave mode:
#
#            0_  1_  2_  3_  4_
# SPI_CLOCK _| |_| |_| |_| |_| |
#             _______         __
# SCLK      _|       |_______|     * freq(SCLK) <= freq(SPI_CLOCK)/4
#           _____________ ______
# internal  _____________x______ 
# state
#
#   Edge 0: SPI_CLOCK happens to sample the changing SCLK and still gets 0.
#   Edge 1: SPI_CLOCK now correctly samples the changed SCLK and gets 1.
#   Edge 2: The 2nd flop of the double-sampling circuit gets 1 and we know the
#           state is changed now.
#   Edge 3: The registered internal state changes accordingly.
#   Edge 4: SCLK's next edge also comes (the worst case -- the fastest SCLK).
#           The result will be flopped into spi_out_slv_r/spi_oe_slv_r.
#
# According to the above flow, in the worst case, there's only one SPI_CLOCK
# cycle time for data to be safely sampled into spi_out_slv_r/spi_oe_slv_r.
#
if {$slave_support} {
	# No hold time check is necessary. We only care if the internal state
	# can be sampled by next (posedge SPI_S_SCLK) in time.
	set_false_path -hold -to [get_cells u_spi_spiif/spi_out_slv_r*]
	set_false_path -hold -to [get_cells u_spi_spiif/spi_oe_slv_r* ]

	# CDC clocks are treated ideal so clock path propagation delays are 0
	# for all clocked points. This means the clock propagation delays for
	# the start and end points will be completely nullified and we get
	# exactly one cycle of time for the setup check.  Obviously this trick
	# can't be used for propagated clocks since unequal clock propagation
	# delays won't nullify each other.
	# A strict one cycle of delay is imposed to spi_out_slv_r/spi_oe_slv_r.
	# As a result, leave some margin here ($spi_cdc_margin).
	set_max_delay [expr $spi_clk_period - $spi_cdc_margin] -from [get_clocks CDC_SPI_CLOCK] -to [get_clocks CDC_SPI_S_SCLK]

	# Roughly constrain paths for samping slave mode inputs. This delay can
	# be relaxed if the timing is too tight.
	set_max_delay $spi_clk_period -from [get_clocks CDC_SPI_S_SCLK] -to [get_clocks CDC_SPI_CLOCK]

	# For synchronization, we don't care the hold time checks.
	set_false_path -hold -from [get_clocks CDC_SPI_S_SCLK] -to [get_clocks CDC_SPI_CLOCK]
	set_false_path -hold -from [get_clocks CDC_SPI_CLOCK] -to [get_clocks CDC_SPI_S_SCLK]
}

# spi_in_r won't be used by rx_shift_reg_r when the spi_clock:spi_clk_out ratio
# is 1:1 in master mode (instead, spi_in_d1_r (clocked by ~spi_clock) is used).
# That is, this path is only for 2:1 or more and hence at least two cycles of
# SPI_CLOCK delay are available.
# We can't just use "set_false_path -from [get_clocks SPI_M_SCLK_ORG] ..." to
# ignore the 1:1 case since SPI_M_SCLK_DIV's timing (N:1) still may violate for the
# simple single SPI_CLOCK cycle check (the endpoint is clocked by SPI_CLOCK).
# The design will sample the data at the correct cycle so let's use
# set_multicycle_path.
set_multicycle_path 2 -setup -from [get_cells u_spi_spiif/spi_in_r*] -to [get_cells u_spi_ctrl/rx_shift_reg_r*] -end
set_multicycle_path 1 -hold  -from [get_cells u_spi_spiif/spi_in_r*] -to [get_cells u_spi_ctrl/rx_shift_reg_r*] -end
# spi_in_d1 is only used in 1:1 master mode so we can ignore the N:1 case.
set_false_path -from [get_clocks SPI_M_SCLK_DIV] -through [get_cells u_spi_spiif/spi_in_r_reg*] -to [get_cells u_spi_spiif/spi_in_d1_r_reg*]

if {$slave_support} {
	# In slave mode, spi_in_r (clocked by SPI_S_SCLK) is asynchronous to
	# rx_shift_reg (clocked by SPI_CLOCK) so we can ignore the hold time
	# check.
	set_false_path -hold -from [get_clocks SPI_S_SCLK] -through [get_cells u_spi_spiif/spi_in_r_reg*] -to [get_cells u_spi_ctrl/rx_shift_reg*]
	# spi_in_d1 is not used in slave mode
	set_false_path -from [get_clocks SPI_S_SCLK] -through [get_cells u_spi_spiif/spi_in_r_reg*] -to [get_cells u_spi_spiif/spi_in_d1_r_reg*]
}

if {$apbbus_exist && $ahbbus_exist} {
	if {[expr int($pclk_period/$hclk_period)] > 1} {
		set_multicycle_path [expr int($pclk_period/$hclk_period)    ] -setup -through [get_pins u_spi_sync/reg_*_sysclk] -to [get_clocks HCLK] -end
		set_multicycle_path [expr int($pclk_period/$hclk_period) - 1] -hold  -through [get_pins u_spi_sync/reg_*_sysclk] -to [get_clocks HCLK] -end
		set_multicycle_path [expr int($pclk_period/$hclk_period)    ] -setup -through [get_pins u_spi_sync/spi_reset_regclk] -to [get_cells u_spi_sync/spi_reset_sysclk*] -end
		set_multicycle_path [expr int($pclk_period/$hclk_period) - 1] -hold  -through [get_pins u_spi_sync/spi_reset_regclk] -to [get_cells u_spi_sync/spi_reset_sysclk*] -end
		set_multicycle_path [expr int($pclk_period/$hclk_period)    ] -setup -from [get_port pwdata*] -to [get_cells u_spi_fifo/u_spi_txfifo/mem*] -end
		set_multicycle_path [expr int($pclk_period/$hclk_period) - 1] -hold  -from [get_port pwdata*] -to [get_cells u_spi_fifo/u_spi_txfifo/mem*] -end
	}
}
if {$apbbus_exist && $eilmbus_exist} {
	if {[expr int($pclk_period/$eilm_clk_period)] > 1} {
		set_multicycle_path [expr int($pclk_period/$eilm_clk_period)    ] -setup -through [get_pins u_spi_sync/reg_*_sysclk] -to [get_clocks EILM_CLK] -end
		set_multicycle_path [expr int($pclk_period/$eilm_clk_period) - 1] -hold  -through [get_pins u_spi_sync/reg_*_sysclk] -to [get_clocks EILM_CLK] -end
		set_multicycle_path [expr int($pclk_period/$eilm_clk_period)    ] -setup -through [get_pins u_spi_sync/spi_reset_regclk] -to [get_cells u_spi_sync/spi_reset_sysclk*] -end
		set_multicycle_path [expr int($pclk_period/$eilm_clk_period) - 1] -hold  -through [get_pins u_spi_sync/spi_reset_regclk] -to [get_cells u_spi_sync/spi_reset_sysclk*] -end
		set_multicycle_path [expr int($pclk_period/$eilm_clk_period)    ] -setup -from [get_port pwdata*] -to [get_cells u_spi_fifo/u_spi_txfifo/mem*] -end
		set_multicycle_path [expr int($pclk_period/$eilm_clk_period) - 1] -hold  -from [get_port pwdata*] -to [get_cells u_spi_fifo/u_spi_txfifo/mem*] -end
	}
}
if {$ahbbus_exist && $eilmbus_exist} {
	if {[expr int($hclk_period/$eilm_clk_period)] > 1} {
		set_multicycle_path [expr int($hclk_period/$eilm_clk_period)    ] -setup -through [get_pins u_spi_sync/reg_*_sysclk] -to [get_clocks EILM_CLK] -end
		set_multicycle_path [expr int($hclk_period/$eilm_clk_period) - 1] -hold  -through [get_pins u_spi_sync/reg_*_sysclk] -to [get_clocks EILM_CLK] -end
		set_multicycle_path [expr int($hclk_period/$eilm_clk_period)    ] -setup -through [get_pins u_spi_sync/spi_reset_regclk] -to [get_cells u_spi_sync/spi_reset_sysclk*] -end
		set_multicycle_path [expr int($hclk_period/$eilm_clk_period) - 1] -hold  -through [get_pins u_spi_sync/spi_reset_regclk] -to [get_cells u_spi_sync/spi_reset_sysclk*] -end
		if ($reg_ahbbus) {
			set_multicycle_path [expr int($hclk_period/$eilm_clk_period)    ] -setup -from [get_port hwdata*] -to [get_cells u_spi_fifo/u_spi_txfifo/mem*] -end
			set_multicycle_path [expr int($hclk_period/$eilm_clk_period) - 1] -hold  -from [get_port hwdata*] -to [get_cells u_spi_fifo/u_spi_txfifo/mem*] -end
		}
	}
}

# -------------------------------------------------------------
# External driver and load
# -------------------------------------------------------------
set_driving_cell -library ${tech_lib} -lib_cell $driving_cell -no_design_rule [all_inputs]
set_load [expr $load_val * 16] [all_outputs]
set_max_fanout $max_fanout [current_design]


# -------------------------------------------------------------
# Operating condition
# -------------------------------------------------------------
set_operating_conditions $operating_cond


# -------------------------------------------------------------
# Wire-load mode
# -------------------------------------------------------------
set_wire_load_mode enclosed

