#
# Suppress some messages.
#

#
# Common Useful Subroutines
#

# recursive copy $src_dir to $result_dir/$src_dir
proc relocate_ip {src_dir} {
	global result_dir

	set src_dirname [file tail $src_dir]

	if {[file exists "$result_dir/$src_dirname"]} {
		file delete -force "$result_dir/$src_dirname"
	}

	file copy -force $src_dir $result_dir
	set new_dir [file join [pwd] $result_dir $src_dirname]
	return $new_dir
}

#
# Project attributes
#

if {[info exists env(NDS_HOME)]} {
	# If environment variable NDS_HOME exists, this script is executed
	# in the release package environment.
	set mode_release	1
} else {
	# Otherwise, we are in the engineering mode.
	set mode_release	0
}

if {[catch {current_project}]} {
	# If error was caught for current_project,
	# there is no currently opened project
	set project_opened	0
} else {
	set project_opened	1
}

set_param general.maxThreads	4

# Detect the platform.
set script_path	[info script]
regexp {(\w+)_vivado\w*\.tcl} $script_path -> platform
# Most codes are shared among all platforms so let's do a weak check here.
if {$platform != "ae210" && $platform != "ae250" && $platform != "ae300" && $platform != "ae350"} {
	puts [format "E%sOR: The detected platform '$platform' is not ae210, ae250, ae300, or ae350!" "RR"];
	exit 1
}
set PLATFORM		[string toupper $platform]

set NDS_HOME	$env(NDS_HOME)
set top_module		${platform}_chip
set result_dir		${platform}_chip

file mkdir $result_dir

# add_file options
source script/fpga_utils.tcl
parse_config ${platform}_config.vh	; # Platform configuration
parse_config fpga_config.inc		; # FPGA configuration
parse_config config.inc			; # CPU core configuration

# Add SPI configurations.
if {$platform == "ae210"} {
	parse_config "$NDS_HOME/andes_ip/${platform}/define/atcahb2spi200_config.vh"
} else {
	parse_config "$NDS_HOME/andes_ip/${platform}/define/atcspi200_config.vh"
}

# Build-flow switch
set_defined save_prj			VIVADO_SAVE_PROJECT

# Define board.
set_defined board_orca			NDS_BOARD_ORCA
set_defined board_cf1			NDS_BOARD_CF1
set_defined board_vcu118		NDS_BOARD_VCU118
set_defined board_cb19                  NDS_BOARD_CB19
set_defined device_xc7k410t		NDS_DEVICE_XC7K410T
set_defined multi_hart                  NDS_IO_HART1
set_defined has_hart_0			NDS_IO_HART0
set_defined has_hart_1			NDS_IO_HART1
set_defined has_hart_3			NDS_IO_HART3
set_defined has_hart_7			NDS_IO_HART7
set_defined i2c1_support		${PLATFORM}_I2C_SUPPORT
set_defined uart1_support		${PLATFORM}_UART1_SUPPORT
set_defined uart2_support		${PLATFORM}_UART2_SUPPORT
set_defined xip_support			${PLATFORM}_XIP_SUPPORT
set_defined spi1_support		${PLATFORM}_SPI1_SUPPORT
set_defined spi2_support		${PLATFORM}_SPI2_SUPPORT
set_defined dmac_support		${PLATFORM}_DMA_SUPPORT
set_defined gpio_support		${PLATFORM}_GPIO_SUPPORT
set_defined pit_support			${PLATFORM}_PIT_SUPPORT
set_defined rtc_support			${PLATFORM}_RTC_SUPPORT
set_defined wdt_support			${PLATFORM}_WDT_SUPPORT
set_defined dtrom_support		${PLATFORM}_DTROM_SUPPORT
set_defined eilm_support	 	NDS_EILM_SUPPORT
set_defined edlm_support		NDS_EDLM_SUPPORT
set_defined ilm_support	 		NDS_ILM_SUPPORT
set_defined dlm_support			NDS_DLM_SUPPORT
set_defined l2c_support			NDS_IO_L2C
set_defined l2c_4bank_support		NDS_IO_L2C_4BANK
set_defined ahb_support			NDS_AHB_SUPPORT
set_defined ahb_io_support		NDS_IO_AHB
set_defined axi_support			NDS_IO_AXI
set_defined ace_support			NDS_IO_ACE
set_defined mmu_support			NDS_IO_STLB
set_defined dsp_support			NDS_DSP_SUPPORT
set_defined rvv_support			NDS_RVV_SUPPORT
set_defined fp16_support		NDS_FP16_SUPPORT
set_defined bfloat16_support		NDS_BFLOAT16_SUPPORT
set_defined cluster_support		NDS_IO_CLUSTER
set_defined has_ilm_tl_ul		NDS_IO_ILM_TL_UL

set_defined jtag_twowire		PLATFORM_JTAG_TWOWIRE
set_defined platform_debug_port		PLATFORM_DEBUG_PORT
set_defined ncedbglock	 		PLATFORM_NCEDBGLOCK100_SUPPORT

set_defined spi1_slave_support		ATCSPI200_SLAVE_SUPPORT
set_defined spi2_slave_support		ATCSPI200_SLAVE_SUPPORT
set_defined spi1_quadspi_support	ATCSPI200_QUADSPI_SUPPORT
set_defined spi2_quadspi_support	ATCSPI200_QUADSPI_SUPPORT
set_defined spi3_slave_support		ATCSPI200_SLAVE_SUPPORT
set_defined spi4_slave_support		ATCSPI200_SLAVE_SUPPORT
set_defined spi3_quadspi_support	ATCSPI200_QUADSPI_SUPPORT
set_defined spi4_quadspi_support	ATCSPI200_QUADSPI_SUPPORT

set_defined ae250_core_clk_40mhz	AE250_CORE_CLK_40MHZ
set_defined ae350_core_clk_40mhz	AE350_CORE_CLK_40MHZ
set_defined ae350_core_clk_66mhz	AE350_CORE_CLK_66MHZ
set_defined ae250_core_clk_20mhz	AE250_CORE_CLK_20MHZ
set_defined ae350_core_clk_20mhz	AE350_CORE_CLK_20MHZ
set_defined ae250_spi_clk_40mhz		AE250_SPI_CLK_40MHZ


set_defined l2c_delay_2cycles		NDS_L2C_DATA_RAM_SETUP_CYCLE_2

set_defined ae350_core_clk_dfs		NDS_IO_CORE_BRG_ASYNC	

set_defined multi_jtag_device_support	NDS_MULTI_JTAG_DEVICE

if {$device_xc7k410t && $multi_hart} {
	puts "ERROR : Can't synthesize multiple cores on xc7k410t"
	exit
}

if {$board_vcu118} {	
	if {$spi2_support} {
		puts "ERROR : SPI2 is not supported for vcu118"
		exit
	} 
	if {$i2c1_support} {
		puts "ERROR : I2C is not supported for vcu118"
		exit
	} 
	if {$uart1_support} {
		puts "ERROR : UART1 is not supported for vcu118"
		exit
	} 
	if {$ncedbglock} {
		puts "ERROR : Secure debug mode is not supported for vcu118"
		exit
	} 
} 

if {$rvv_support || $fp16_support || $bfloat16_support} {
	set has_vpu   1
} else {
	set has_vpu   0
}

if {$platform == "ae350" && $ahb_io_support} {
	set ae350_ahb_support		1
	set ae350_axi_support		0
} elseif {$platform == "ae350"} {
	set ae350_ahb_support		0
	set ae350_axi_support		1
} else {
	set ae350_ahb_support		0
	set ae350_axi_support		0
}


if {$platform == "ae250" && $ae250_core_clk_40mhz} {
	set core_clk_use_66m	0
	set core_clk_use_40m	1
} elseif {$platform == "ae350" && $ae350_core_clk_40mhz} {
	set core_clk_use_66m	0
	set core_clk_use_40m	1
} elseif {$platform == "ae350" && $ae350_core_clk_66mhz} {
	set core_clk_use_66m	1
	set core_clk_use_40m	0
} else {
	set core_clk_use_66m	0
	set core_clk_use_40m	0
}

if {$platform == "ae250" && $ae250_core_clk_20mhz} {
	set core_clk_use_20m	1
} elseif {$platform == "ae350" && $ae350_core_clk_20mhz} {
	set core_clk_use_20m	1
} else {
	set core_clk_use_20m	0
}

if {$platform == "ae250" && $ae250_spi_clk_40mhz} {
	set spi_clk_source	CLKOUT2
} else {
	set spi_clk_source	CLKOUT5
}

# Andes-CF1-related
set_defined i2c2_support		${PLATFORM}_I2C2_SUPPORT
set_defined spi3_support		${PLATFORM}_SPI3_SUPPORT
set_defined spi4_support		${PLATFORM}_SPI4_SUPPORT

# Define board details.
if {$board_orca} {
	set BOARD		orca
	set DEVICE		xc7k
} elseif {$board_cf1} {
	set BOARD		cf1
	set DEVICE		xc7a100tftg256-1
} elseif {$board_vcu118} {
        set BOARD               vcu118
        set DEVICE              xcvu9p-flga2104-2L-e
} elseif {$board_cb19} {
        set BOARD               cb19
        set DEVICE              xcvu19p-fsva3824-2-e
} else {
	set BOARD		leopard
	set DEVICE		xc5v
}

if {$board_cf1} {
	set mem_path		$NDS_HOME/vendor_ip/xilinx_ip/$DEVICE/mem
	set clk_path		$NDS_HOME/vendor_ip/xilinx_ip/$DEVICE/clk
	set ila_path		$NDS_HOME/vendor_ip/xilinx_ip/$DEVICE/ila
} elseif {$board_vcu118} {
	set mem_path		$NDS_HOME/vendor_ip/xilinx_ip/$DEVICE/mem
	set clk_path		$NDS_HOME/vendor_ip/xilinx_ip/$DEVICE/clk
	set ila_path		$NDS_HOME/vendor_ip/xilinx_ip/$DEVICE/ila
} elseif {$board_cb19} {
        set mem_path            $NDS_HOME/vendor_ip/xilinx_ip/$DEVICE/mem
        set clk_path            $NDS_HOME/vendor_ip/xilinx_ip/$DEVICE/clk
        set ila_path            $NDS_HOME/vendor_ip/xilinx_ip/$DEVICE/ila
} else {
	if {$device_xc7k410t} {
		set mem_path		$NDS_HOME/vendor_ip/xilinx_ip/xc7k410tffg676-2/mem
		set ila_path		$NDS_HOME/vendor_ip/xilinx_ip/xc7k410tffg676-2/ila
		set clk_path		$NDS_HOME/vendor_ip/xilinx_ip/xc7k410tffg676-2/clk
	} else {
		set mem_path		$NDS_HOME/vendor_ip/xilinx_ip/xc7k/mem
		set ila_path		$NDS_HOME/vendor_ip/xilinx_ip/xc7k/ila
		set clk_path		$NDS_HOME/vendor_ip/xilinx_ip/xc7k/clk
	}
}

if {!$spi1_support} {
	set spi1_slave_support		0
	set spi1_quadspi_support	0
}
if {!$spi2_support} {
	set spi2_slave_support		0
	set spi2_quadspi_support	0
}
if {!$spi3_support} {
	set spi3_slave_support		0
	set spi3_quadspi_support	0
}
if {!$spi4_support} {
	set spi4_slave_support		0
	set spi4_quadspi_support	0
}

if {$spi1_support || $spi2_support || $spi3_support || $spi4_support} {
	set spi_support		1
} else {
	set spi_support		0
}

if {$i2c1_support || $i2c2_support} {
	set iic_support		1
} else {
	set iic_support		0
}

if {$uart1_support || $uart2_support} {
	set uart_support	1
} else {
	set uart_support	0
}

if {$eilm_support} {
	set flashfetch20_support 		0
	set multi_epb_support 			0
}

# Define the core.
set_defined hb_support			NDS_CORE_N7
set_defined n8_support			NDS_CORE_N8
set_defined e8_support			NDS_CORE_E8
set_defined s8_support			NDS_CORE_S8
set_defined n9_support			NDS_CORE_N9
set_defined n10_support			NDS_CORE_N10
set_defined d10_support			NDS_CORE_D10
set_defined n13_support			NDS_CORE_N13
set_defined dual_n13_support		NDS_DUAL_CORE_N13
set_defined n15_support			NDS_CORE_N15
set_defined d15_support			NDS_CORE_D15
set_defined n22_support			NDS_CORE_N22
set_defined vc_support			NDS_CORE_VC
set_defined kv_support			NDS_CORE_KV
set_defined flow_do_fix_gck		FLOW_DO_FIX_GCK

if {$hb_support} {
	set CORE				hb
} elseif {$n8_support} {
	set CORE				n8
} elseif {$e8_support} {
	set CORE				e8
} elseif {$s8_support} {
	set CORE				s8
} elseif {$n9_support} {
	set CORE				n9
} elseif {$n10_support} {
	set CORE				n10
} elseif {$d10_support} {
	set CORE				d10
} elseif {$n13_support} {
	set CORE				n13
} elseif {$n15_support} {
	set CORE				n15
} elseif {$d15_support} {
	set CORE				d15
} elseif {$n22_support} {
	set CORE				n22
} elseif {$vc_support} {
	set CORE				vc
} elseif {$kv_support} {
	set CORE				kv
}

# Device options
if {$board_orca} {
	if {$device_xc7k410t} {
		set part		xc7k410t
		set speed_grade		-2
	} else {
		set part		xc7k160t
		set speed_grade		-1
	}
	set package		ffg676
} elseif {$board_cf1} {
	set part		xc7a100t
	set package		ftg256
	set speed_grade		-1
} elseif {$board_vcu118} {
        set part                xcvu9p
        set package             -flga2104
        set speed_grade         -2L-e
} elseif {$board_cb19} {
        set part                xcvu19p
        set package             -fsva3824
        set speed_grade         -2-e
} else {
	set part		xc5vlx110
	set package		ff676
	set speed_grade		-1
}
set fpga_part		"$part$package$speed_grade"

#
# STEP #1: Setup design sources and constraints.
#

if {$project_opened} {
} elseif {$save_prj} {
        create_project -part $fpga_part $top_module ${top_module}_prj
        set_property source_mgmt_mode None [current_project]
} else {
        create_project -in_memory -part $fpga_part
}

if {$board_vcu118} {
	set_property board_part [get_board_parts -latest_file_version xilinx.com:vcu118:*] [current_project]
}

# Read mmcm IPs from .v
#foreach mmcm [glob $clk_path/*.xci] {
#	#read_verilog -sv $mmcm
#	
#}
set	clk_xci	[glob -nocomplain $clk_path/*.xci]

# Search IP files.
set mem_xci		[glob -nocomplain $mem_path/*.xci]

set_defined has_ila	NDS_ILA

if {$mode_release} {
	if {[file isdirectory "$ila_path"]} {
		set ila_xci		[glob -nocomplain $ila_path/*.xci]
	} else {
		set ila_xci		""
	}
} else {
	if {$has_ila} {
		set ila_xci		[glob -nocomplain $ila_path/*.xci]
	} else {
		set ila_xci		""
	}
}

# Import IP XCI files.
if {$project_opened} {
} else {
        foreach xci "$mem_xci $ila_xci $clk_xci" {
	        import_ip $xci
        }
}

set current_ips [get_ips *]
if {$current_ips ne ""} {
	# Upgrade IP files.
	upgrade_ip $current_ips

	# Install IP files.
	set_property generate_synth_checkpoint false [get_files *.xci]
	set_msg_config -id "IP_Flow 19-1686" -limit 500
	generate_target synthesis $current_ips
}

source flist/flist_${platform}_incdirs.tcl

if {![info exists include_path]} {
	set include_path			""
}

set include_all_inc ""
foreach include_search_path "$include_path" {
	append include_all_inc " " [glob -nocomplain ${include_search_path}/*.inc]
}


set include_all_vh  ""
append include_all_vh " " [glob -nocomplain *.vh]
append include_all_vh " " [glob -nocomplain $NDS_HOME/andes_ip/${platform}/define/*_config.vh]
foreach include_search_path "$include_path" {
	append include_all_vh " " [glob -nocomplain ${include_search_path}/*_const.vh]
}

add_file "${include_all_inc} ${include_all_vh}"
foreach include_files "${include_all_inc} ${include_all_vh}" {
	set_property is_global_include true [get_files ${include_files}]
	set_property file_type {Verilog Header} [get_files ${include_files}]
}

source flist/flist_${platform}_fpga.tcl
source flist/flist_${CORE}.tcl

#
# STEP #2: Run synthesis, report utilization and timing estimates, write checkpoint design.
#

# Use "unmanaged" to allow conditional syntax in the XDC file.
read_xdc -unmanaged constraint/${platform}_fpga_${BOARD}_pre_synth.sdc
if {[file exists constraint/cons_$CORE.sdc]} {
	read_xdc -unmanaged constraint/cons_$CORE.sdc
}


if {$save_prj} {
        # Exit after project setted up, implementation is human controlled
        return
}

regexp [0-9]{4} [eval version -short] ver
# synth_design -top $top_module -part $fpga_part -flatten rebuilt -include_dirs "$include_path" -directive runtimeoptimized -keep_equivalent_registers
#synth_design -top $top_module -part $fpga_part -flatten rebuilt -include_dirs "$include_path" -directive runtimeoptimized
if {($ver >= 2020) && $has_hart_7} {
	synth_design -top $top_module -part $fpga_part -flatten rebuilt -include_dirs "$include_path" -directive PerformanceOptimized -retiming
} else {
	synth_design -top $top_module -part $fpga_part -flatten rebuilt -include_dirs "$include_path" -directive default -retiming
}

read_xdc -unmanaged constraint/${platform}_fpga_${BOARD}_post_synth.sdc

write_checkpoint		-force $result_dir/post_synth.dcp
write_xdc			-force $result_dir/${platform}_chip_edif.xdc
# write_edif			-force $result_dir/${platform}_chip.edf

report_clocks			-file $result_dir/post_synth_clocks.rpt
report_utilization		-file $result_dir/post_synth_hier_util.rpt -hierarchical -hierarchical_depth 5
report_timing_summary		-file $result_dir/post_synth_timing_summary.rpt
report_power			-file $result_dir/post_synth_power.rpt
report_cdc			-file $result_dir/post_synth_cdc.rpt -detail
report_exceptions		-file $result_dir/post_synth_timing_exceptions.rpt -coverage

set_property SEVERITY {Warning} [get_drc_checks UCIO-1]

#
# STEP #3: Run placement and logic optimzation, report utilization and timing estimates, write checkpoint design.
#

opt_design -directive Explore
# write_checkpoint		-force $result_dir/post_synth_opt.dcp
#place_design -directive WLDrivenBlockPlacement
place_design -directive ExtraTimingOpt
if {$board_cf1} {
	route_design -verbose -directive Explore
	phys_opt_design -verbose -directive Explore
} else {
	if {$board_vcu118} {
		phys_opt_design -verbose -directive ExploreWithAggressiveHoldFix
	} elseif {$board_cb19}   {
                phys_opt_design -verbose -directive ExploreWithAggressiveHoldFix
	} else {
		phys_opt_design -verbose -directive ExploreWithHoldFix
	}
}

write_checkpoint		-force $result_dir/post_place.dcp

report_clock_utilization	-file $result_dir/post_place_clock_util.rpt
report_utilization		-file $result_dir/post_place_util.rpt
report_utilization		-file $result_dir/post_place_hier_util.rpt -hierarchical -hierarchical_depth 5
report_timing_summary		-file $result_dir/post_place_timing_summary.rpt -check_timing_verbose -report_unconstrained -verbose -slack_lesser_than 0
report_cdc			-file $result_dir/post_place_cdc.rpt -detail
report_exceptions		-file $result_dir/post_place_timing_exceptions.rpt -coverage


#
# STEP #4: Run router, report actual utilization and timing, write checkpoint design, run DRC, write Verilog and XDC out.
#

# For cluster DDR4 timing improvement.
if {$board_vcu118} {
	route_design -verbose -directive AggressiveExplore
} elseif {$board_cb19} {
	route_design -verbose -directive AggressiveExplore
} else {
	route_design -verbose -directive Explore
}

phys_opt_design -verbose -directive AggressiveExplore

write_checkpoint		-force $result_dir/post_route.dcp
write_verilog			-force $result_dir/${platform}_chip_netlist.v

report_drc			-file $result_dir/post_route_drc.rpt
report_utilization		-file $result_dir/post_route_util.rpt
report_utilization		-file $result_dir/post_route_hier_util.rpt -hierarchical -hierarchical_depth 5
report_timing_summary		-file $result_dir/post_route_timing_summary.rpt -check_timing_verbose -report_unconstrained -verbose -slack_lesser_than 0
report_cdc			-file $result_dir/post_route_cdc.rpt -detail
report_exceptions		-file $result_dir/post_route_timing_exceptions.rpt -coverage
report_io			-file $result_dir/post_route_io.rpt
# report_datasheet		-file $result_dir/post_route_datasheet.rpt

# Incremental post-opt phase
report_qor_suggestions          -file $result_dir/qor_suggestions_incr0.rpt
report_qor_assessment           -file $result_dir/qor_assessment_incr0.rpt
write_qor_suggestions 		-force $result_dir/post_route_incr0.rqs

set itr_max 3
set last_itr 0

for {set itr 1} {$itr <= $itr_max} {incr itr} {
	set WNS_pass [expr {[get_property SLACK [get_timing_paths]] >= 0}]
	set WHS_pass [expr {[get_property SLACK [get_timing_paths -hold]] >= 0}]
	if {$WNS_pass && $WHS_pass} {
		set itr_max $itr
	} else {
		close_design
		open_checkpoint $result_dir/post_synth.dcp
		read_qor_suggestions $result_dir/post_route_incr${last_itr}.rqs
		# opt_design directive must be same as the reference run
		opt_design -directive Explore
		if {$ver >= 2020} {
			read_checkpoint -auto_incremental -incremental $result_dir/post_route.dcp
		} else {
			read_checkpoint -incremental $result_dir/post_route.dcp
		}
		set last_itr $itr
		# place_design is running in TimingClosure mode
		place_design -verbose 
		# phys_opt_design is optimized for incremental
                phys_opt_design -verbose 
		# route_design is running in TimingClosure mode
		route_design -verbose 
                phys_opt_design -verbose

		write_checkpoint 		-force $result_dir/post_route.dcp
		report_qor_suggestions          -file $result_dir/qor_suggestions_incr${itr}.rpt
		report_qor_assessment           -file $result_dir/qor_assessment_incr${itr}.rpt
		write_qor_suggestions           -force $result_dir/post_route_incr${itr}.rqs
		report_timing_summary		-file $result_dir/post_route_timing_summary.rpt -check_timing_verbose -report_unconstrained -verbose -slack_lesser_than 0 -max_paths 20
	}
}
# NDS_INTERNAL_END
# Incremental post-opt phase end

if {$board_vcu118} {
	#set_property BITSTREAM.CONFIG.EXTMASTERCCLK_EN div-1 [current_design]
	set_property BITSTREAM.CONFIG.CONFIGRATE 127.5 [current_design]
	set_property BITSTREAM.CONFIG.SPI_32BIT_ADDR YES [current_design]
	set_property BITSTREAM.CONFIG.SPI_FALL_EDGE YES [current_design]
	set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 8 [current_design]
	set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]
	set_property CFGBVS GND [current_design]
	set_property CONFIG_VOLTAGE 1.8 [current_design]
	set_property CONFIG_MODE SPIx8 [current_design]
} elseif {$board_cf1} {
	# Use quad-mode SPI to speed up bitmap downloading.
	set_property BITSTREAM.CONFIG.CONFIGRATE 66 [current_design]
	set_property CONFIG_VOLTAGE 3.3 [current_design]
	set_property CFGBVS VCCO [current_design]
	set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design]
	set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]
	set_property BITSTREAM.CONFIG.SPI_FALL_EDGE YES [current_design]
}

#
# STEP #5: Generate bitstream/MCS/BIN files.
#
set_property SEVERITY {Warning} [get_drc_checks NSTD-1]

set bit_file $result_dir/${platform}_chip.bit
set ltx_file $result_dir/${platform}_chip.ltx
set mcs_file ${platform}_chip.mcs
set bin_file ${platform}_chip.bin

write_bitstream			-force $bit_file
write_debug_probes		-force $ltx_file

if {$board_vcu118} {
	write_cfgmem -format MCS -interface spix8 -size 256 -loadbit "up 0 $bit_file" -file $mcs_file -force
	write_cfgmem -format BIN -interface spix8 -size 256 -loadbit "up 0 $bit_file" -file $bin_file -force
} elseif {$board_cb19} {
        write_bitstream                 -force $bit_file
} elseif {$board_cf1} {
	write_cfgmem -format MCS -interface spix4 -size 16 -loadbit "up 0 $bit_file" -file $mcs_file -force
	write_cfgmem -format BIN -interface spix4 -size 16 -loadbit "up 0 $bit_file" -file $bin_file -force
} else {
	if {$ver >= 2014} {
		write_cfgmem -format MCS -interface bpix16 -size 32 -loadbit "up 0 $bit_file" -file $mcs_file -force
		write_cfgmem -format BIN -interface bpix16 -size 32 -loadbit "up 0 $bit_file" -file $bin_file -force
	} else {
		puts "WARNING: Vivado version < 2014.1. Generate MCS/BIN by external promgen."
		if { $board eq "orca" } {
			exec "promgen -w -p mcs -c FF -u 0 $bit_file -s 32768 -bpi_dc parallel -data_width 16 -o $mcs_file"
			exec "promgen -w -p bin -c FF -u 0 $bit_file -s 32768 -bpi_dc parallel -data_width 16 -o $bin_file"
		} else {
			exec "promgen -w -p mcs -c FF -u 0 $bit_file -x xcf32p -o $mcs_file"
			exec "promgen -w -p bin -c FF -u 0 $bit_file -x xcf32p -o $bin_file"
		}
	}
}

