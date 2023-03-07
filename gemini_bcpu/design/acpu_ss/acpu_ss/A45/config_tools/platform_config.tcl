proc edit_atcbmc301_addr {slave value unmask} {
	global NDS_HOME
	set config_vh ""

	set platform [selected NDS_PLATFORM]
	set PREFIX ATCBMC301
	set SUFFIX BASE_ADDR
	set config_vh "$NDS_HOME/andes_ip/$platform/define/atcbmc301_config.vh"

	if {![file exists $config_vh]} {
		return
	}

	set macro "${PREFIX}_${slave}_${SUFFIX}"

	set value [extract_hex_digits $value]
	set value [format "`%s_ADDR_WIDTH'h%X" ${PREFIX} [expr "0x${value} & ~$unmask"]]

	edit_define $macro $value $config_vh
}

proc edit_atcbmc301_default_size {} {
	global NDS_HOME
	set config_vh ""

	set platform [selected NDS_PLATFORM]
	set addr_width [selected NDS_BIU_ADDR_WIDTH]

	set config_vh "$NDS_HOME/andes_ip/$platform/define/atcbmc301_config.vh"
	set value [expr "$addr_width - 32 + 13"]

	if {![file exists $config_vh]} {
		return
	}

	edit_define ATCBMC301_SLV2_SIZE $value $config_vh
	edit_define ATCBMC301_SLV3_SIZE $value $config_vh
}

proc edit_atcbmc300_size {slave value} {
	global NDS_HOME
	set config_vh ""

	set platform [selected NDS_PLATFORM]

	set PREFIX ATCBMC300
	set SUFFIX SIZE
	set config_vh "$NDS_HOME/andes_ip/$platform/define/atcbmc300_config.vh"

	if {![file exists $config_vh]} {
		return
	}

	set macro "${PREFIX}_${slave}_${SUFFIX}"

	edit_define $macro $value $config_vh
}

proc edit_atcbusdec301_addr {slave value mask} {
	global NDS_HOME

	set platform [selected NDS_PLATFORM]
	set config_vh ""

	set PREFIX ATCBUSDEC301
	set config_vh "$NDS_HOME/andes_ip/$platform/define/atcbusdec301_config.vh"

	if {![file exists $config_vh]} {
		return
	}

	set macro "${PREFIX}_${slave}_OFFSET"

	set value [extract_hex_digits $value]
	set value [format "`%s_ADDR_DECODE_WIDTH'h%X" $PREFIX [expr "0x${value} & $mask"]]

	edit_define $macro $value $config_vh
}

proc edit_atcbusdec302_addr {value} {
	global NDS_HOME

	set platform [selected NDS_PLATFORM]
	set config_vh ""

	set PREFIX ATCBUSDEC302
	set config_vh "$NDS_HOME/andes_ip/$platform/define/atcbusdec302_config.vh"

	if {![file exists $config_vh]} {
		return
	}

	set offset [format "0x%x" [expr {[selected SLVPORT_SIZE] * 1024 * 1024}]]
	set size [expr {int ((log($offset / (1024 * 1024))/log(2)) + 1)}]
	foreach slave {SLV1 SLV2 SLV3 SLV4} {
		set macro "${PREFIX}_${slave}_OFFSET"
		set value [extract_hex_digits $value]
		set opt_value [format "`%s_ADDR_DECODE_WIDTH'h%X" $PREFIX [expr "0x${value} & 0xffffffff"]]
		edit_define $macro $opt_value $config_vh
		set macro "${PREFIX}_${slave}_SIZE"
		edit_define $macro $size $config_vh
		set value [format "64'h%x" [expr "0x$value + $offset"]]
	}
}

proc edit_atcbmc300_addr {slave value} {
	global NDS_HOME

	set platform [selected NDS_PLATFORM]
	set config_vh ""

	set PREFIX ATCBMC300
	set SUFFIX BASE_ADDR
	set config_vh "$NDS_HOME/andes_ip/$platform/define/atcbmc300_config.vh"
	set width "`${PREFIX}_ADDR_WIDTH"

	if {![file exists $config_vh]} {
		return
	}

	set macro "${PREFIX}_${slave}_${SUFFIX}"

	set value [extract_hex_digits $value]
	set value [format "%s'h%X" $width "0x$value"]

	edit_define $macro $value $config_vh
}

proc edit_atcbusdec200_addr {slave value mask} {
	global NDS_HOME

	set platform [selected NDS_PLATFORM]

	set PREFIX ATCBUSDEC200
	set config_vh "$NDS_HOME/andes_ip/$platform/define/atcbusdec200_config.vh"

	if {![file exists $config_vh]} {
		return
	}

	set macro "${PREFIX}_${slave}_OFFSET"

	set value [extract_hex_digits $value]
	set value [format "`%s_ADDR_DECODE_WIDTH'h%X" $PREFIX [expr "0x${value} & $mask"]]

	edit_define $macro $value $config_vh
}

########################
# Platform Common
########################
title Platform Level Settings

design_option NDS_PLATFORM {} {
	full_name	{Platform}
	value		{ae350}
	default		ae350
	hidden		yes
	to_define {
			echo {`define PLATFORM_AE350_SUPPORT}
	}
}

design_option NDS_CONFIG_PLATFORM {} {
	full_name	{Platform and CPU Subsystem}
	value		{ae350 custom}
	default		ae350
	to_define {
	}
}

constraint NDS_CONFIG_PLATFORM {} {
	if {[selected NDS_CONFIG_PLATFORM] == "ae350"} {
		set_default_platform_config
	} else {
		enable_platform_config
	}
}

design_option NDS_RESET_VECTOR {} {
	full_name       {Reset Vector Address}
	value           {textinput}
	validate        {key}
	vcmd            {validate_verilog_hex %P}
	default         64'h0000000080000000
	to_define    {
	}
	platform_config	{
		edit_platform_config PLATFORM_RESET_VECTOR $value
		set value_s [extract_hex_digits $value]
		for {set i [string length $value_s]} {$i < 16} {incr i} {
			set value_s "0$value_s"
		}
		edit_define "ATCSMU100_RESET_VECTOR_DEFAULT" "0x$value_s" $NDS_HOME/andes_vip/patterns/samples/include/atcsmu100.h

		regsub {^[0-9a-fA-F_]{8}} $value_s {32'h} value_lo
		regsub {([0-9a-fA-F_]+)[0-9a-fA-F_]{8}$} $value_s {32'h\1} value_hi

		edit_smu_config SAMPLE_AE350_SMU_RESET_VECTOR_LO_DEFAULT $value_lo
		edit_smu_config SAMPLE_AE350_SMU_RESET_VECTOR_HI_DEFAULT $value_hi

		set reset_vector [extract_hex_digits $value]
		set rambrg_base [extract_hex_digits [selected RAMBRG_BASE]]
		set rambrg_size [expr "[selected RAMBRG_REGION_SIZE]*1024*1024"]

		set ilm_base [extract_hex_digits [selected NDS_ILM_BASE]]
		set ilm_size [expr "[selected NDS_ILM_SIZE]*1024"]

		set dlm_base [extract_hex_digits [selected NDS_DLM_BASE]]
		set dlm_size [expr "[selected NDS_DLM_SIZE]*1024"]

		set boot_on_rambrg [expr "0x${reset_vector} >= 0x$rambrg_base && 0x${reset_vector} < 0x$rambrg_base + $rambrg_size"]
		set has_ilm [expr "$ilm_size > 0x0"]
		set has_dlm [expr "$dlm_size > 0x0"]
		set ilm_overlap_rambrg [expr "$ilm_size > 0x0 && 0x${ilm_base} >= 0x$rambrg_base && 0x${ilm_base} < 0x$rambrg_base + $rambrg_size"]
		set dlm_overlap_rambrg [expr "$dlm_size > 0x0 && 0x${dlm_base} >= 0x$rambrg_base && 0x${dlm_base} < 0x$rambrg_base + $rambrg_size"]
		set dlm_gt_64k [expr "$dlm_size >= (64 * 1024)"]
		set nhart [selected NDS_NHART]

		if {$boot_on_rambrg} {
			edit_all_ldscripts __TEXT_BASE "0x$rambrg_base"
			edit_turbu_pattern ilm "0x$rambrg_base" $NDS_HOME/andes_vip/patterns/turbu/test_turbu/test_inst.ace.in
			edit_all_ldscripts __DATA_BASE "."
			edit_turbu_pattern dlm [format "0x%x" [expr "0x$rambrg_base + 0x200000"]] $NDS_HOME/andes_vip/patterns/turbu/test_turbu/test_inst.ace.in
			edit_all_ldscripts __STACK_BASE ". + 0x8000 "
			edit_all_ldscripts __SHAREDATA_BASE ". + [format "0x%x" [expr "$nhart * 0x8000"]] "
		} elseif {$has_ilm} {
			edit_all_ldscripts __TEXT_BASE "0x$ilm_base"
			edit_turbu_pattern ilm "0x$ilm_base" $NDS_HOME/andes_vip/patterns/turbu/test_turbu/test_inst.ace.in
			if ($dlm_gt_64k) {
				edit_all_ldscripts __DATA_BASE "0x$dlm_base"
				edit_turbu_pattern dlm "0x$dlm_base" $NDS_HOME/andes_vip/patterns/turbu/test_turbu/test_inst.ace.in
				# data from 0
				# stack from DLM/2 to 0
				# heap from DLM/2 to DLM
				edit_all_ldscripts __STACK_BASE [format "0x%x" [expr "0x$dlm_base + ($dlm_size >> 1)"]]
				if {$dlm_overlap_rambrg} {
					if ([expr "(0x$dlm_base + ($dlm_size >> 1) + ($nhart * 0x8000)) > (0x$dlm_base + $dlm_size)"]) {
						edit_all_ldscripts __SHAREDATA_BASE [format "0x%x" [expr "0x$dlm_base + ($dlm_size >> 1) + ($nhart * 0x8000)"]]
					} else {
						edit_all_ldscripts __SHAREDATA_BASE [format "0x%x" [expr "0x$dlm_base + $dlm_size"]]
					}
				} elseif {$ilm_overlap_rambrg} {
					edit_all_ldscripts __SHAREDATA_BASE [format "0x%x" [expr "0x$ilm_base + $ilm_size"]]
				} else {
					edit_all_ldscripts __SHAREDATA_BASE "0x$rambrg_base"
				}
			} elseif {$ilm_overlap_rambrg} {
				edit_all_ldscripts __DATA_BASE [format "0x%x" [expr "0x$ilm_base + 0x200000"]]
				edit_turbu_pattern dlm [format "0x%x" [expr "0x$ilm_base + 0x200000"]] $NDS_HOME/andes_vip/patterns/turbu/test_turbu/test_inst.ace.in
				edit_all_ldscripts __STACK_BASE ". + 0x8000 "
				edit_all_ldscripts __SHAREDATA_BASE ". + [format "0x%x" [expr "$nhart * 0x8000"]] "
			} else {
				edit_all_ldscripts __DATA_BASE "0x$rambrg_base"
				edit_turbu_pattern dlm "0x$rambrg_base" $NDS_HOME/andes_vip/patterns/turbu/test_turbu/test_inst.ace.in
				edit_all_ldscripts __STACK_BASE ". + 0x8000 "
				edit_all_ldscripts __SHAREDATA_BASE ". + [format "0x%x" [expr "$nhart * 0x8000"]] "
			}
		} else {
			edit_all_ldscripts __TEXT_BASE "0x$rambrg_base"
			edit_turbu_pattern ilm "0x$rambrg_base" $NDS_HOME/andes_vip/patterns/turbu/test_turbu/test_inst.ace.in
			if ($dlm_gt_64k) {
				edit_all_ldscripts __DATA_BASE "0x$dlm_base"
				edit_turbu_pattern dlm "0x$dlm_base" $NDS_HOME/andes_vip/patterns/turbu/test_turbu/test_inst.ace.in
				# data from 0
				# stack from DLM/2 to 0
				# heap from DLM/2 to DLM
				edit_all_ldscripts __STACK_BASE [format "0x%x" [expr "0x$dlm_base + ($dlm_size >> 1)"]]
				if {$dlm_overlap_rambrg} {
					if ([expr "(0x$dlm_base + ($dlm_size >> 1) + ($nhart * 0x8000)) > (0x$dlm_base + $dlm_size)"]) {
						edit_all_ldscripts __SHAREDATA_BASE [format "0x%x" [expr "0x$dlm_base + ($dlm_size >> 1) + ($nhart * 0x8000)"]]
					} else {
						edit_all_ldscripts __SHAREDATA_BASE [format "0x%x" [expr "0x$dlm_base + $dlm_size"]]
					}
				} else {
					edit_all_ldscripts __SHAREDATA_BASE [format "0x%x" [expr "0x$rambrg_base + 0x200000"]]
				}
			} else {
				edit_all_ldscripts __DATA_BASE [format "0x%x" [expr "0x$rambrg_base + 0x200000"]]
				edit_turbu_pattern dlm [format "0x%x" [expr "0x$rambrg_base + 0x200000"]] $NDS_HOME/andes_vip/patterns/turbu/test_turbu/test_inst.ace.in
				edit_all_ldscripts __STACK_BASE ". + 0x8000 "
				edit_all_ldscripts __SHAREDATA_BASE ". + [format "0x%x" [expr "$nhart * 0x8000"]] "
			}
		}
	}
}

design_option PLATFORM_L2C_REG_BASE {} {
        full_name       {L2C Register Base}
        value           {textinput}
        validate        {key}
        vcmd            {validate_verilog_hex %P}
        default         64'h00000000e0500000
	hidden		yes
        to_define       {
        }
	platform_config	{
		edit_cheader L2C_BASE $value
	}
}
constraint PLATFORM_L2C_REG_BASE {} {
	set_opt_value PLATFORM_L2C_REG_BASE [selected NDS_L2C_REG_BASE]
}

title CPU Subsystem Bus Matrix
########################
# Platform PLIC Option
########################
design_option PLATFORM_VECTOR_PLIC_SUPPORT {} {
	full_name	{Andes Vectored PLIC Extension}
	value		{no yes}
	default		no
	hidden		yes
	to_define	{
	}
	platform_config {
		edit_platform_config PLATFORM_VECTOR_PLIC_SUPPORT $value
	}
}
constraint PLATFORM_VECTOR_PLIC_SUPPORT {} {
	set_opt_value PLATFORM_VECTOR_PLIC_SUPPORT [selected NDS_VECTOR_PLIC_SUPPORT]
}

design_option PLIC_REGS_BASE {} {
	full_name       {Interrupt Controller (PLIC) Base Address}
	value           {textinput}
	validate        {key}
	vcmd            {validate_verilog_hex %P}
	default         64'h00000000E4000000
	to_define    {
	}
	platform_config	{
		edit_atcbmc301_addr SLV1 $value 0x3FFFFFF
		edit_atcbmc301_default_size
		edit_atcbusdec301_addr SLV1 $value 0x3FFFFFF
		edit_cheader PLIC_BASE $value
	}
}

design_option PLMT_REGS_BASE {} {
	full_name       {Machine Timer (PLMT) Base Address}
	value           {textinput}
	validate        {key}
	vcmd            {validate_verilog_hex %P}
	default         64'h00000000E6000000
	to_define    {
	}
	platform_config	{
		edit_atcbusdec301_addr SLV2 $value 0x3FFFFFF
		edit_cheader PLMT_BASE $value
	}
}

design_option PLIC_SWINT_SUPPORT {} {
	full_name    {Software Interrupts (PLIC_SWINT)}
	value        {yes no}
	default      yes
	to_define    {
	}
	platform_config {
		if {$value == "no"} {
			edit_platform_config PLATFORM_NO_PLIC_SW "yes"
		} else {
			edit_platform_config PLATFORM_NO_PLIC_SW "no"
		}
	}
}

design_option PLIC_SW_REGS_BASE {} {
	full_name       {PLIC_SWINT Base Address}
	value           {textinput}
	validate        {key}
	vcmd            {validate_verilog_hex %P}
	default         64'h00000000E6400000
	to_define    {
	}
	platform_config	{
		edit_atcbusdec301_addr SLV3 $value 0x3FFFFFF
		edit_cheader PLIC_SW_BASE $value
	}
}

design_option NDS_DEBUG_VEC {} {
    full_name    {Debug Vector Address}
    value        {textinput}
    validate     {key}
    vcmd         {validate_verilog_hex %P}
    default      64'h0000000000000088
    to_define    {
        echo {`define NDS_DEBUG_VEC $value}
    }
}

design_option PLATFORM_DEBUG_SUPPORT {} {
	full_name	{Platform Debug Support}
	value	{no yes}
	default	  no
        hidden    yes
	platform_config {
                edit_platform_config PLATFORM_DEBUG_PORT $value
                edit_platform_config PLATFORM_DEBUG_SUBSYSTEM $value
	}
}

design_option PLATFORM_JTAG_TWOWIRE {} {
	full_name	{Debug Interface}
	value	{jtag serial}
	default	  jtag
	platform_config	{
		if {$value == "serial"} {
			set value yes
		} else {
			set value no
		}
		edit_platform_config PLATFORM_JTAG_TWOWIRE $value
	}
}

design_option PLATFORM_PLDM_SYS_BUS_ACCESS {} {
	full_name	{PLDM System Bus Access}
	value	{no yes}
	default	  no
	platform_config	{
		edit_platform_config PLATFORM_PLDM_SYS_BUS_ACCESS $value
	}
}

design_option PLATFORM_PLDM_PROGBUF_SIZE {} {
	full_name	{PLDM Program Buffer}
	value	{8 2}
	default	  8
	platform_config	{
		edit_platform_config PLATFORM_PLDM_PROGBUF_SIZE $value
	}
}

design_option PLATFORM_PLDM_HALTGROUP_COUNT {} {
	full_name	{PLDM Group Halting}
	value	{3 2 1 0}
	default	  0
	platform_config	{
		edit_platform_config PLATFORM_PLDM_HALTGROUP_COUNT $value
	}
}

design_option PLATFORM_NCEDBGLOCK100_SUPPORT {} {
	full_name	{Secure Debug}
	value	{no yes}
	default	  no
	platform_config	{
		edit_platform_config PLATFORM_NCEDBGLOCK100_SUPPORT $value
	}
}

# ==========================================================================

constraint PLATFORM_DEBUG_SUPPORT {} {
	if {[selected NDS_DEBUG_SUPPORT] == "yes"} {
                set_opt_value PLATFORM_DEBUG_SUPPORT "yes"
	} else {
                set_opt_value PLATFORM_DEBUG_SUPPORT "no"
	}
}

constraint PLATFORM_JTAG_TWOWIRE {} {
	if {[selected PLATFORM_DEBUG_SUPPORT] == "yes"} {
		enable PLATFORM_JTAG_TWOWIRE
	} else {
		set_opt_value PLATFORM_JTAG_TWOWIRE "jtag"
		disable PLATFORM_JTAG_TWOWIRE
	}
}

constraint PLATFORM_PLDM_SYS_BUS_ACCESS {} {
	if {[selected PLATFORM_DEBUG_SUPPORT] == "yes"} {
		enable PLATFORM_PLDM_SYS_BUS_ACCESS
	} else {
		set_opt_value PLATFORM_PLDM_SYS_BUS_ACCESS "no"
		disable PLATFORM_PLDM_SYS_BUS_ACCESS
	}
}

constraint PLATFORM_PLDM_PROGBUF_SIZE {} {
	if {[selected PLATFORM_DEBUG_SUPPORT] == "yes"} {
		enable PLATFORM_PLDM_PROGBUF_SIZE
	} else {
		set_opt_value PLATFORM_PLDM_PROGBUF_SIZE 8
		disable PLATFORM_PLDM_PROGBUF_SIZE
	}
}

constraint PLATFORM_PLDM_HALTGROUP_COUNT {} {
	if {[selected PLATFORM_DEBUG_SUPPORT] == "yes"} {
		enable PLATFORM_PLDM_HALTGROUP_COUNT
	} else {
		set_opt_value PLATFORM_PLDM_HALTGROUP_COUNT 0
		disable PLATFORM_PLDM_HALTGROUP_COUNT
	}
}

constraint PLATFORM_PLDM_HALTGROUP_COUNT {} {
	if {[selected PLATFORM_DEBUG_SUPPORT] == "yes"} {
		enable PLATFORM_PLDM_HALTGROUP_COUNT
	} else {
		set_opt_value PLATFORM_PLDM_HALTGROUP_COUNT 0
		disable PLATFORM_PLDM_HALTGROUP_COUNT
	}
}
constraint PLATFORM_NCEDBGLOCK100_SUPPORT {} {
	if {[selected PLATFORM_DEBUG_SUPPORT] == "yes"} {
		enable PLATFORM_NCEDBGLOCK100_SUPPORT
	} else {
		set_opt_value PLATFORM_NCEDBGLOCK100_SUPPORT "no"
		disable PLATFORM_NCEDBGLOCK100_SUPPORT
	}
}

design_option PLDM_REGS_BASE {} {
	full_name       {Debug Module (PLDM) Base Address}
	value           {textinput}
	validate        {key}
	vcmd            {validate_verilog_hex %P}
	default         64'h00000000E6800000
	to_define    {
	}
	platform_config	{
		edit_platform_config PLATFORM_PLDM_REGS_BASE $value
		edit_atcbusdec301_addr SLV4 $value 0x3FFFFFF
		edit_cheader PLDM_BASE $value
	    	edit_platform_config PLATFORM_DEBUG_VECTOR $value
	}
}

title Devices in AXI Space
design_option BMC_REGS_BASE {} {
	full_name       {AXI Bus Matrix Program Register Base Address}
	value           {textinput}
	validate        {key}
	vcmd            {validate_verilog_hex %P}
	default         64'h00000000C0000000
	to_define    {
	}
	platform_config	{
		edit_atcbmc300_addr SLV0 $value
		edit_cheader BMC_BASE $value
	}
}

proc edit_all_ldscripts {name value} {
	global NDS_HOME
	edit_ldscript $name $value $NDS_HOME/andes_vip/patterns/samples/test_coremark_v5/coremark.ld
	edit_ldscript $name $value $NDS_HOME/andes_vip/patterns/samples/test_whetstone_v5/whet.ld
	edit_ldscript $name $value $NDS_HOME/andes_vip/patterns/samples/etc/script.ld
	edit_ldscript $name $value $NDS_HOME/andes_vip/patterns/samples/test_dhrystone_v5/dhry.ld
	edit_ldscript $name $value $NDS_HOME/andes_vip/patterns/samples/test_ace/ace.ld
	edit_ldscript $name $value $NDS_HOME/andes_vip/patterns/riscv-tests/env/p/link.ld
	edit_ldscript $name $value $NDS_HOME/andes_vip/patterns/riscv-compliance/env/p/link.ld
	edit_ldscript $name $value $NDS_HOME/andes_vip/patterns/turbu/test_turbu/init.ld
}

proc edit_turbu_pattern {macro value file_name} {
	global edit_file_cache opt_debug

	if {[info exists edit_file_cache($file_name)]} {
		set content $edit_file_cache($file_name)
	} else {
		if {![file exists $file_name]} {
			return
		}

		if {[catch {set fp [open $file_name "r"]} err]} {
			puts $err
			return
		}

		set content {}
		while {[gets $fp line] >= 0} {
			lappend content $line
		}
		close $fp
		
	        puts "INFO: editing $file_name"
	}
	if {$opt_debug} {
		global NDS_HOME
		set print_file_name $file_name
		if {[string first $NDS_HOME $file_name] == 0} {
			set print_file_name [string replace $file_name 0 [string length $NDS_HOME]-1 {$NDS_HOME}]
		}

		puts "DEBUG: PROVIDE($macro = $value) in $print_file_name"
	}

	for {set i 0} {$i < [llength $content]} {incr i} {
		set line [lindex $content $i]
		#@! s_mem_map = ilm:{0x00000000..0x000fffff}, dlm:{0x00200000..0x002fffff};
		if {[regexp "${macro}:\\\{0x\[a-zA-Z0-9\]+\.\.0x\[a-zA-Z0-9\]+\\\}" $line]} {
			regsub "(${macro}:\\\{)0x\[a-zA-Z0-9\]+\.\.0x\[a-zA-Z0-9\]+\\\}" $line "\\1[format "0x%x" ${value}]\.\.[format "0x%x" [expr "${value} + 0xfffff"]]\}" line
			lset content $i $line
		}
	}

	set edit_file_cache($file_name) $content
}


proc edit_all_initS {name value} {
	global NDS_HOME
	edit_define $name $value $NDS_HOME/andes_vip/patterns/samples/test_coremark_v5/init.S
	edit_define $name $value $NDS_HOME/andes_vip/patterns/samples/test_whetstone_v5/init.S
	edit_define $name $value $NDS_HOME/andes_vip/patterns/samples/test_dhrystone_v5/init.S
	edit_define $name $value $NDS_HOME/andes_vip/patterns/samples/test_ace/init.S
	edit_define $name $value $NDS_HOME/andes_vip/patterns/riscv-tests/env/p/riscv_test.h
#	edit_define $name $value $NDS_HOME/andes_vip/patterns/riscv-compliance/env/p/riscv_test.h
}

design_option RAMBRG_REGION_SIZE {} {
	full_name       {RAM Bridge Region Size (MiB)}
	value           {textinput}
	validate        {key}
	vcmd            {string is int %P}
	default         2048
	platform_config	{
		set val $value
		set size 1
		if {$val == 0} {
			set size 0
		} else {
			while {$val != 1} {
				incr size
				set val [expr $val >> 1]
			}
		}

		edit_atcbmc300_size SLV2 $size
	}
}

design_option RAMBRG_BASE {} {
	full_name       {RAM Bridge Base Address}
	value           {textinput}
	validate        {key}
	vcmd            {validate_verilog_hex %P}
	default         64'h0000000000000000
	to_define    {
	}
	platform_config	{
		edit_atcbmc300_addr SLV2 $value
		edit_cheader DDR3_MEM_BASE $value
	}
}

design_option SLVPORT_SIZE {} {
	full_name       {Slave Port Region Size (MiB)}
	value           {textinput}
	validate        {key}
	vcmd            {string is int %P}
	default         4
	to_define    {
	}
	platform_config	{
       		set offset [format "0x%x" [expr {$value * 1024 * 1024* [selected NDS_NHART]}]]
		set size [expr {int ((log($offset / (1024 * 1024))/log(2)) + 1)}]
		edit_atcbmc300_size SLV3 $size
	}
}

design_option SLVPORT_ILM_BASE {} {
	full_name       {ILM Slave Port Base Address}
	value           {textinput}
	validate        {key}
	vcmd            {validate_verilog_hex %P}
	default         64'h00000000A0000000
	to_define    {
	}
	platform_config	{
		edit_atcbmc300_addr SLV3 $value
		edit_cheader SLVPORT_BASE $value
		edit_atcbusdec302_addr $value
	}
}

design_option SLVPORT_DLM_SEL_BIT {} {
	full_name       {Slave Port DLM Selection Bit}
	value           {textinput}
	validate        {key}
	vcmd            {string is int %P}
	default         21
	to_define    {
	}
	platform_config	{
		edit_platform_config PLATFORM_SLVPORT_DLM_SEL_BIT $value
	}
}

design_option SLVPORT_DLM_BASE {} {
	full_name       {DLM Slave Port Base Address}
	value           {textinput}
	validate        {key}
	vcmd            {validate_verilog_hex %P}
	default         64'h00000000A0200000
	to_define    {
	}
	platform_config	{
		edit_cheader SLVPORT_DLM_BASE $value
	}
}

design_option NDS_DFS_REG_BASE {} {
        full_name       {Dynamic Frequency Scaling Program Register Base Address}
        value           {textinput}
        validate        {key}
        vcmd            {validate_verilog_hex %P}
        default         64'h00000000c0200000
        to_define       {
        }
	platform_config	{
		edit_atcbmc300_addr SLV31 $value
		edit_cheader DFS_REG_BASE $value
	}
}

title Devices in AHB Space
design_option AHBDEC_REGS_BASE {} {
	full_name       {AHB Decoder Program Register Base Address}
	value           {textinput}
	validate        {key}
	vcmd            {validate_verilog_hex %P}
	default         64'h00000000E0000000
	to_define    {
	}
	platform_config	{
		edit_atcbmc300_addr SLV1 $value
		edit_cheader AHBDEC_BASE $value

		set value [extract_hex_digits $value]
		edit_all_initS AHBDEC_BASE "0x$value"
	}
}

title Devices in APB Space
design_option AHBDEC_SUPPORT {} {
	full_name	{AHB Decoder}
	hidden		yes
	value		{yes no}
	default		{yes}
	platform_config	{
	}
}

design_option APBBRG_SUPPORT {} {
	full_name	{APB Bridge}
	hidden		yes
	value		{yes no}
	default		{yes}
	platform_config	{
	}
}

design_option SMU_SUPPORT {} {
	full_name	{System Management Unit}
	hidden		yes
	value		{yes no}
	default		{yes}
	platform_config	{
	}
}

design_option UART1_SUPPORT {} {
	full_name	{UART1}
	value		{yes no}
	default		{yes}
	to_define    {
	}
	platform_config	{
		edit_apb_config UART1_SUPPORT $value
	}
}

design_option UART2_SUPPORT {} {
	full_name	{UART2}
	value		{yes no}
	default		{yes}
	to_define    {
	}
	platform_config	{
		edit_apb_config UART2_SUPPORT $value
	}
}

design_option PIT_SUPPORT {} {
	full_name	{Programmable Interval Timer}
	value		{yes no}
	default		{yes}
	to_define    {
	}
	platform_config	{
		edit_apb_config PIT_SUPPORT $value
	}
}

design_option WDT_SUPPORT {} {
	full_name	{Watchdog Timer}
	value		{yes no}
	default		{yes}
	to_define    {
	}
	platform_config	{
		edit_apb_config WDT_SUPPORT $value
	}
}

design_option RTC_SUPPORT {} {
	full_name	{Real-Time Clock}
	value		{yes no}
	default		{yes}
	to_define    {
	}
	platform_config	{
		edit_apb_config RTC_SUPPORT $value
	}
}

design_option GPIO_SUPPORT {} {
	full_name	{GPIO}
	value		{yes no}
	default		{yes}
	to_define    {
	}
	platform_config	{
		edit_apb_config GPIO_SUPPORT $value
	}
}

design_option I2C_SUPPORT {} {
	full_name	{I2C}
	value		{yes no}
	default		{yes}
	to_define    {
	}
	platform_config	{
		edit_apb_config I2C_SUPPORT $value
	}
}

design_option SPI1_SUPPORT {} {
	full_name	{SPI1}
	value		{yes no}
	default		{yes}
	to_define    {
	}
	platform_config	{
		edit_apb_config SPI1_SUPPORT $value
	}
}

design_option DMAC_SUPPORT {} {
	full_name	{DMA Controller}
	value		{yes no}
	default		{yes}
	to_define    {
	}
	platform_config	{
		edit_apb_config DMA_SUPPORT $value
	}
}

design_option SPI2_SUPPORT {} {
	full_name	{SPI2}
	value		{yes no}
	default		{yes}
	to_define    {
	}
	platform_config	{
		edit_apb_config SPI2_SUPPORT $value
	}
}

design_option DTROM_SUPPORT {} {
	full_name	{DTROM}
	value		{yes no}
	default		{no}
	to_define    {
	}
	platform_config	{
		edit_apb_config DTROM_SUPPORT $value
	}
}


design_option APBBRG_REGS_BASE {} {
	full_name       {APB Bridge Program Register Base Address}
	value           {textinput}
	validate        {key}
	vcmd            {validate_verilog_hex %P}
	default         64'h00000000F0000000
	to_define    {
	}
	platform_config	{
		edit_atcbusdec200_addr SLV1 $value 0x1FFFFFFF
		edit_cheader APBBRG_BASE $value
	}
}

design_option SMU_REGS_BASE {} {
	full_name       {SMU Program Register Base Address}
	value           {textinput}
	validate        {key}
	vcmd            {validate_verilog_hex %P}
	default         64'h00000000F0100000
	to_define    {
	}
	platform_config	{
		if {[selected SMU_SUPPORT] == "yes"} {
			edit_apb_base ATCAPBBRG100_SLV1_OFFSET SMU_BASE $value
		}
	}
}
design_option UART1_REGS_BASE {} {
	full_name       {UART1 Program Register Base Address}
	value           {textinput}
	validate        {key}
	vcmd            {validate_verilog_hex %P}
	default         64'h00000000F0200000
	to_define    {
	}
	platform_config	{
		if {[selected UART1_SUPPORT] == "yes"} {
			edit_apb_base ATCAPBBRG100_SLV2_OFFSET UART1_BASE $value
		}
	}
}
design_option UART2_REGS_BASE {} {
	full_name       {UART2 Program Register Base Address}
	value           {textinput}
	validate        {key}
	vcmd            {validate_verilog_hex %P}
	default         64'h00000000F0300000
	to_define    {
	}
	platform_config	{
		if {[selected UART2_SUPPORT] == "yes"} {
			edit_apb_base ATCAPBBRG100_SLV3_OFFSET UART2_BASE $value
		}
	}
}
design_option PIT_REGS_BASE {} {
	full_name       {Programmable Interval Timer Base Address}
	value           {textinput}
	validate        {key}
	vcmd            {validate_verilog_hex %P}
	default         64'h00000000F0400000
	to_define    {
	}
	platform_config	{
		if {[selected PIT_SUPPORT] == "yes"} {
			edit_apb_base ATCAPBBRG100_SLV4_OFFSET PIT_BASE $value
			edit_cheader TIMER_BASE $value
		}
	}
}
design_option WDT_REGS_BASE {} {
	full_name       {Watchdog Timer Base Address}
	value           {textinput}
	validate        {key}
	vcmd            {validate_verilog_hex %P}
	default         64'h00000000F0500000
	to_define    {
	}
	platform_config	{
		if {[selected WDT_SUPPORT] == "yes"} {
			edit_apb_base ATCAPBBRG100_SLV5_OFFSET WDT_BASE $value
		}
	}
}
design_option RTC_REGS_BASE {} {
	full_name       {Real-Time Clock Base Address}
	value           {textinput}
	validate        {key}
	vcmd            {validate_verilog_hex %P}
	default         64'h00000000F0600000
	to_define    {
	}
	platform_config	{
		if {[selected RTC_SUPPORT] == "yes"} {
			edit_apb_base ATCAPBBRG100_SLV6_OFFSET RTC_BASE $value
		}
	}
}
design_option GPIO_REGS_BASE {} {
	full_name       {GPIO Base Address}
	value           {textinput}
	validate        {key}
	vcmd            {validate_verilog_hex %P}
	default         64'h00000000F0700000
	to_define    {
	}
	platform_config	{
		if {[selected GPIO_SUPPORT] == "yes"} {
			edit_apb_base ATCAPBBRG100_SLV7_OFFSET GPIO_BASE $value
		}
	}
}
design_option I2C_REGS_BASE {} {
	full_name       {I2C Base Address}
	value           {textinput}
	validate        {key}
	vcmd            {validate_verilog_hex %P}
	default         64'h00000000F0A00000
	to_define    {
	}
	platform_config	{
		if {[selected I2C_SUPPORT] == "yes"} {
			edit_apb_base ATCAPBBRG100_SLV8_OFFSET I2C_BASE $value
		}
	}
}
design_option SPI1_REGS_BASE {} {
	full_name       {SPI1 Base Address}
	value           {textinput}
	validate        {key}
	vcmd            {validate_verilog_hex %P}
	default         64'h00000000F0B00000
	to_define    {
	}
	platform_config	{
		if {[selected SPI1_SUPPORT] == "yes"} {
			edit_apb_base ATCAPBBRG100_SLV9_OFFSET SPI1_BASE $value
		}
	}
}
design_option SPI_MEM_BASE {} {
	full_name       {SPI MEM Base Address}
	value           {textinput}
	validate        {key}
	vcmd            {validate_verilog_hex %P}
	default         64'h0000000080000000
	to_define    {
	}
	platform_config	{
		edit_platform_config PLATFORM_SPI_MEM_BASE $value
		if {[selected SPI1_SUPPORT]=="yes"} {
			edit_atcbmc300_addr SLV4 $value
		}
		edit_cheader SPI1_MEM_BASE $value

		set value [extract_hex_digits $value]
		edit_all_ldscripts __SPI_MEM_BASE "0x$value"
	}
}

design_option DMAC_REGS_BASE {} {
	full_name       {DMA Controller Base Address}
	value           {textinput}
	validate        {key}
	vcmd            {validate_verilog_hex %P}
	default         64'h00000000F0C00000
	to_define    {
	}
	platform_config	{
		if {[selected DMAC_SUPPORT] == "yes"} {
			edit_apb_base ATCAPBBRG100_SLV12_OFFSET DMAC_BASE $value
		}
	}
}
design_option SPI2_REGS_BASE {} {
	full_name       {SPI2 Base Address}
	value           {textinput}
	validate        {key}
	vcmd            {validate_verilog_hex %P}
	default         64'h00000000F0F00000
	to_define    {
	}
	platform_config	{
		if {[selected SPI2_SUPPORT] == "yes"} {
			edit_apb_base ATCAPBBRG100_SLV10_OFFSET SPI2_BASE $value
		}
	}
}

design_option DTROM_REGS_BASE {} {
	full_name       {DTROM Base Address}
	value           {textinput}
	validate        {key}
	vcmd            {validate_verilog_hex %P}
	default         64'h00000000F2000000
	to_define    {
	}
	platform_config	{
		if {[selected DTROM_SUPPORT] == "yes"} {
			edit_apb_base ATCAPBBRG100_SLV14_OFFSET DTROM_BASE $value
		}
	}
}


proc check_device_region_size_valid {size_name} {
	set size_sval [selected $size_name]

	set val $size_sval
	while {$val != 1} {
		if {($val & 0x1) != 0} {
			break
		}

		set val [expr $val >> 1]
	}
	if {$val != 1} {
		show_error "ERROR: \"$size_sval\" is not a valid region size"
		set default_val [selected_default $size_name]
		set_opt_value $size_name $default_val
	} else {
		disable_highlight $size_name
	}
}

constraint NDS_RESET_VECTOR {} {
	if {[selected NDS_RESET_VECTOR] == [selected_default NDS_RESET_VECTOR]} {
		disable_highlight NDS_RESET_VECTOR
	} else {
		check_device_region_base_valid NDS_RESET_VECTOR
	}
}

constraint RAMBRG_REGION_SIZE {} {
	if {[selected RAMBRG_REGION_SIZE] == [selected_default RAMBRG_REGION_SIZE]} {
		disable_highlight RAMBRG_REGION_SIZE
	} elseif {[selected RAMBRG_REGION_SIZE] == 0} {
		show_error "ERROR: Value \"[selected RAMBRG_REGION_SIZE]\" is not allowed for [selected_full_name RAMBRG_REGION_SIZE]"
		set_opt_value RAMBRG_REGION_SIZE [selected_default RAMBRG_REGION_SIZE]
	} elseif {([format "0x%X" [selected RAMBRG_REGION_SIZE]] ^ ([format "0x%X" [expr [selected RAMBRG_REGION_SIZE] -1]])) < [format "0x%X" [selected RAMBRG_REGION_SIZE]]} {
		show_error "ERROR: Value \"[selected RAMBRG_REGION_SIZE]\" is not allowed for [selected_full_name RAMBRG_REGION_SIZE], please specify the size with power of two"
		set_opt_value RAMBRG_REGION_SIZE [selected_default RAMBRG_REGION_SIZE]
	} else {
		check_device_region_size_valid RAMBRG_REGION_SIZE
	}
}
constraint RAMBRG_BASE {} {
	if {[selected RAMBRG_REGION_SIZE] == 0} {
		disable RAMBRG_BASE
	}
	if {[selected RAMBRG_REGION_SIZE] != 0} {
		enable RAMBRG_BASE
		if {[selected RAMBRG_BASE] == [selected_default RAMBRG_BASE]} {
			disable_highlight RAMBRG_BASE
		} else {
			check_device_region_base_valid RAMBRG_BASE
		}
	}
}
constraint PLIC_REGS_BASE {} {
	if {[selected PLIC_REGS_BASE] == [selected_default PLIC_REGS_BASE]} {
		disable_highlight PLIC_REGS_BASE
	} else {
		check_device_region_base_valid PLIC_REGS_BASE
	}
}

constraint PLIC_SW_REGS_BASE {} {
	if {[selected PLIC_SWINT_SUPPORT] == "no"} {
		disable PLIC_SW_REGS_BASE
	}
	if {[selected PLIC_SWINT_SUPPORT] == "yes"} {
		enable PLIC_SW_REGS_BASE
		if {[selected PLIC_SW_REGS_BASE] == [selected_default PLIC_SW_REGS_BASE]} {
			disable_highlight PLIC_SW_REGS_BASE
		} else {
			check_device_region_base_valid PLIC_SW_REGS_BASE
		}
	}
}

constraint PLMT_REGS_BASE {} {
	if {[selected PLMT_REGS_BASE] == [selected_default PLMT_REGS_BASE]} {
		disable_highlight PLMT_REGS_BASE
	} else {
		check_device_region_base_valid PLMT_REGS_BASE
	}
}

constraint PLDM_REGS_BASE {} {
	if {[selected NDS_DEBUG_SUPPORT] == "no"} {
		disable PLDM_REGS_BASE
		set_opt_value PLDM_REGS_BASE [selected_default PLDM_REGS_BASE]
	}
	if {[selected NDS_DEBUG_SUPPORT] == "yes"} {
		disable PLDM_REGS_BASE
		set_opt_value PLDM_REGS_BASE [selected NDS_DEBUG_VEC]
		if {[selected PLDM_REGS_BASE] == [selected_default PLDM_REGS_BASE]} {
			disable_highlight PLDM_REGS_BASE
		} else {
			check_device_region_base_valid PLDM_REGS_BASE
		}
	}
}
constraint SLVPORT_SIZE {} {
	if {[selected NDS_SLAVE_PORT_SUPPORT] == "no"} {
		disable SLVPORT_SIZE
		set_opt_value SLVPORT_SIZE [selected_default SLVPORT_SIZE]
	}
	if {[selected NDS_SLAVE_PORT_SUPPORT] == "yes"} {
		if {[selected NDS_CONFIG_PLATFORM] == "ae350"} {
			disable SLVPORT_SIZE
			if { [expr [selected NDS_ILM_SIZE] < 2048] && [expr [selected NDS_DLM_SIZE] < 2048] } {
				set_opt_value SLVPORT_SIZE 4
			} elseif {[expr [selected NDS_DLM_SIZE] > [selected NDS_ILM_SIZE]]} {
				set_opt_value SLVPORT_SIZE [expr {([selected NDS_DLM_SIZE] / 1024) * 2}]
			} else {
				set_opt_value SLVPORT_SIZE [expr {([selected NDS_ILM_SIZE] / 1024) * 2}]
			}
		} else {
			enable SLVPORT_SIZE
			if {[selected SLVPORT_SIZE] == [selected_default SLVPORT_SIZE]} {
				disable_highlight SLVPORT_SIZE
			} elseif {[selected SLVPORT_SIZE] == 0} {
				puts "WARNING: Value \"[selected SLVPORT_SIZE]\" is not allowed for [selected_full_name SLVPORT_SIZE]"
				set_opt_value SLVPORT_SIZE [selected_default SLVPORT_SIZE]
			} elseif {([format "0x%X" [selected SLVPORT_SIZE]] ^ ([format "0x%X" [expr [selected SLVPORT_SIZE] -1]])) < [format "0x%X" [selected SLVPORT_SIZE]]} {
				puts "WARNING: Value \"[selected SLVPORT_SIZE]\" is not allowed for [selected_full_name SLVPORT_SIZE], please specify the size with power of two"
				set_opt_value SLVPORT_SIZE [selected_default SLVPORT_SIZE]
			}
		}
	}
}

constraint SLVPORT_ILM_BASE {} {
	if {[selected NDS_SLAVE_PORT_SUPPORT] == "no"} {
		disable SLVPORT_ILM_BASE
	}
	if {[selected NDS_SLAVE_PORT_SUPPORT] == "yes"} {
		enable SLVPORT_ILM_BASE
		if {[selected SLVPORT_ILM_BASE] == [selected_default SLVPORT_ILM_BASE]} {
			disable_highlight SLVPORT_ILM_BASE
		} else {
			check_device_region_base_valid SLVPORT_ILM_BASE
		}
	}
}

constraint SLVPORT_DLM_BASE {} {
	disable SLVPORT_DLM_BASE
	disable SLVPORT_DLM_SEL_BIT
	set slvport_dlm_base [format "0x%x" [expr {(([selected SLVPORT_SIZE] * 1024 * 1024) / 2)}]]
	check_verilog_number [selected SLVPORT_ILM_BASE] base_addr bit_length radix_type]
	
	set_opt_value SLVPORT_DLM_BASE [format "64'h%016X" [expr "0x$base_addr | $slvport_dlm_base"]]

	set val [extract_hex_digits [selected SLVPORT_DLM_BASE]]
	set val [expr "0x$val | 0x0"]
	set dlm_sel_bit 0
	while {($val & 0x1) == 0} {
		incr dlm_sel_bit
		set val [expr $val >> 1]
	}
	set_opt_value SLVPORT_DLM_SEL_BIT $dlm_sel_bit
}
constraint NDS_DFS_REG_BASE {} {
    if {[selected NDS_CORE_BRG_TYPE] == 2} {
        enable NDS_DFS_REG_BASE
	check_device_region_base_valid NDS_DFS_REG_BASE
    } else {
	set_opt_value NDS_DFS_REG_BASE [selected_default NDS_DFS_REG_BASE]
	disable NDS_DFS_REG_BASE
    }
}
constraint BMC_REGS_BASE {} {
	if {[selected BMC_REGS_BASE] == [selected_default BMC_REGS_BASE]} {
		disable_highlight BMC_REGS_BASE
	} else {
		check_device_region_base_valid BMC_REGS_BASE
	}
}
constraint AHBDEC_REGS_BASE {} {
	if {[selected AHBDEC_REGS_BASE] == [selected_default AHBDEC_REGS_BASE]} {
		disable_highlight AHBDEC_REGS_BASE
	} else {
		check_device_region_base_valid AHBDEC_REGS_BASE
	}
}
constraint APBBRG_REGS_BASE {} {
	if {[selected APBBRG_REGS_BASE] == [selected_default APBBRG_REGS_BASE]} {
		disable_highlight APBBRG_REGS_BASE
	} else {
		check_device_region_base_valid APBBRG_REGS_BASE
	}
}
proc check_in_apb_region {dev} {
	set apb_base [selected APBBRG_REGS_BASE]
	set dev_base [selected $dev]

	# get only the hex digits
	set apb_base [extract_hex_digits $apb_base]
	set dev_base [extract_hex_digits $dev_base]
	if {[expr "0x$dev_base >= 0x$apb_base && (0x$dev_base + 0x1000) <= (0x$apb_base + 0x1000000)"]} {
		disable_highlight UART1_REGS_BASE
	} else {
		show_error "ERROR: $dev is not within APB space"
	}
}

constraint SMU_REGS_BASE {} {
	if {[selected SMU_SUPPORT] == "no"} {
		disable SMU_REGS_BASE
	}
	if {[selected SMU_SUPPORT] == "yes"} {
		enable SMU_REGS_BASE
		if {[selected SMU_REGS_BASE] == [selected_default SMU_REGS_BASE]} {
			disable_highlight SMU_REGS_BASE
		} else {
			check_device_region_base_valid SMU_REGS_BASE
		}
	}
}

constraint UART1_REGS_BASE {} {
	if {[selected UART1_SUPPORT] == "no"} {
		disable UART1_REGS_BASE
	}
	if {[selected UART1_SUPPORT] == "yes"} {
		enable UART1_REGS_BASE
		if {[selected UART1_REGS_BASE] == [selected_default UART1_REGS_BASE]} {
			disable_highlight UART1_REGS_BASE
		} else {
			check_device_region_base_valid UART1_REGS_BASE
		}
	}
}
constraint UART2_REGS_BASE {} {
	if {[selected UART2_SUPPORT] == "no"} {
		disable UART2_REGS_BASE
	}
	if {[selected UART2_SUPPORT] == "yes"} {
		enable UART2_REGS_BASE
		if {[selected UART2_REGS_BASE] == [selected_default UART2_REGS_BASE]} {
			disable_highlight UART2_REGS_BASE
		} else {
			check_device_region_base_valid UART2_REGS_BASE
		}
	}
}
constraint PIT_REGS_BASE {} {
	if {[selected PIT_SUPPORT] == "no"} {
		disable PIT_REGS_BASE
	}
	if {[selected PIT_SUPPORT] == "yes"} {
		enable PIT_REGS_BASE
		if {[selected PIT_REGS_BASE] == [selected_default PIT_REGS_BASE]} {
			disable_highlight PIT_REGS_BASE
		} else {
			check_device_region_base_valid PIT_REGS_BASE
		}
	}
}
constraint WDT_REGS_BASE {} {
	if {[selected WDT_SUPPORT] == "no"} {
		disable WDT_REGS_BASE
	}
	if {[selected WDT_SUPPORT] == "yes"} {
		enable WDT_REGS_BASE
		if {[selected WDT_REGS_BASE] == [selected_default WDT_REGS_BASE]} {
			disable_highlight WDT_REGS_BASE
		} else {
			check_device_region_base_valid WDT_REGS_BASE
		}
	}
}
constraint RTC_REGS_BASE {} {
	if {[selected RTC_SUPPORT] == "no"} {
		disable RTC_REGS_BASE
	}
	if {[selected RTC_SUPPORT] == "yes"} {
		enable RTC_REGS_BASE
		if {[selected RTC_REGS_BASE] == [selected_default RTC_REGS_BASE]} {
			disable_highlight RTC_REGS_BASE
		} else {
			check_device_region_base_valid RTC_REGS_BASE
		}
	}
}
constraint GPIO_REGS_BASE {} {
	if {[selected GPIO_SUPPORT] == "no"} {
		disable GPIO_REGS_BASE
	}
	if {[selected GPIO_SUPPORT] == "yes"} {
		enable GPIO_REGS_BASE
		if {[selected GPIO_REGS_BASE] == [selected_default GPIO_REGS_BASE]} {
			disable_highlight GPIO_REGS_BASE
		} else {
			check_device_region_base_valid GPIO_REGS_BASE
		}
	}
}
constraint I2C_REGS_BASE {} {
	if {[selected I2C_SUPPORT] == "no"} {
		disable I2C_REGS_BASE
	}
	if {[selected I2C_SUPPORT] == "yes"} {
		enable I2C_REGS_BASE
		if {[selected I2C_REGS_BASE] == [selected_default I2C_REGS_BASE]} {
			disable_highlight I2C_REGS_BASE
		} else {
			check_device_region_base_valid I2C_REGS_BASE
		}
	}
}
constraint SPI1_REGS_BASE {} {
	if {[selected SPI1_SUPPORT] == "no"} {
		disable SPI1_REGS_BASE
	}
	if {[selected SPI1_SUPPORT] == "yes"} {
		enable SPI1_REGS_BASE
		if {[selected SPI1_REGS_BASE] == [selected_default SPI1_REGS_BASE]} {
			disable_highlight SPI1_REGS_BASE
		} else {
			check_device_region_base_valid SPI1_REGS_BASE
		}
	}
}

constraint SPI_MEM_BASE {} {
	if {[selected SPI1_SUPPORT] == "no"} {
		disable SPI_MEM_BASE
	}
	if {[selected SPI1_SUPPORT] == "yes"} {
		enable SPI_MEM_BASE
		check_device_region_base_valid SPI_MEM_BASE
	}
}

constraint DMAC_REGS_BASE {} {
	if {[selected DMAC_SUPPORT] == "no"} {
		disable DMAC_REGS_BASE
	}
	if {[selected DMAC_SUPPORT] == "yes"} {
		enable DMAC_REGS_BASE
		if {[selected DMAC_REGS_BASE] == [selected_default DMAC_REGS_BASE]} {
			disable_highlight DMAC_REGS_BASE
		} else {
			check_device_region_base_valid DMAC_REGS_BASE
		}
	}
}
constraint SPI2_REGS_BASE {} {
	if {[selected SPI2_SUPPORT] == "no"} {
		disable SPI2_REGS_BASE
	}
	if {[selected SPI2_SUPPORT] == "yes"} {
		enable SPI2_REGS_BASE
		if {[selected SPI2_REGS_BASE] == [selected_default SPI2_REGS_BASE]} {
			disable_highlight SPI2_REGS_BASE
		} else {
			check_device_region_base_valid SPI2_REGS_BASE
		}
	}
}

constraint DTROM_REGS_BASE {} {
	if {[selected DTROM_SUPPORT] == "no"} {
		disable DTROM_REGS_BASE
	}
	if {[selected DTROM_SUPPORT] == "yes"} {
		enable DTROM_REGS_BASE
		if {[selected DTROM_REGS_BASE] == [selected_default DTROM_REGS_BASE]} {
			disable_highlight DTROM_REGS_BASE
		} else {
			check_device_region_base_valid DTROM_REGS_BASE
		}
	}
}


proc in_device_region {dev_base dev_size} {
        for {set i 0} {$i < 8} {incr i} {
		set base [extract_hex_digits [selected NDS_DEVICE_REGION${i}_BASE]]
		set mask [extract_hex_digits [selected NDS_DEVICE_REGION${i}_MASK]]
		if {[expr 0x$mask == 0]} {
			continue
		}
		if {[expr "((0x${dev_base} & 0x${mask}) == (0x${base} & 0x${mask}) && ((0x${dev_base} + $dev_size - 1) & 0x${mask}) == (0x${base} & 0x${mask}))"]} {
			return 1
			break
		}
        }
	return 0
}

end_dependency_checker {DEBUG_VEC_L2C_SPACE} {
	set l {}
	if {[selected NDS_DEBUG_SUPPORT] == "yes"} {
		set dev "NDS_DEBUG_VEC"
		set dev_base [extract_hex_digits [selected $dev]]
		set dev_size [expr 4*1024]
		set dev_mask [format "0x%x" [expr $dev_size - 1]]
		if {![in_device_region $dev_base $dev_size]} {
			show_error_highlight $dev [format "ERROR: [selected_full_name $dev] at 64'h%X..64'h%X is not in any of the device regions" "0x$dev_base" [expr "0x$dev_base + $dev_size - 1"]]
		}
		set pldm_base [extract_hex_digits [selected PLDM_REGS_BASE]]
		if {"0x$dev_base" != "0x$pldm_base"} {
			puts [format "WARNING: [selected_full_name NDS_DEBUG_VEC]@64'h%X is not equal to AE350 [selected_full_name PLDM_REGS_BASE]@64'h%X" "0x$dev_base" "0x$pldm_base"]
		}
		lappend l [list $dev $dev_base $dev_mask]
	}
	if {[selected NDS_L2C_CACHE_SIZE_KB]!=0} {
		set dev "NDS_L2C_REG_BASE"
		set dev_base [extract_hex_digits [selected $dev]]
		set dev_size [expr 1*1024*1024]
		set dev_mask [format "0x%x" [expr $dev_size - 1]]
		if {![in_device_region $dev_base $dev_size]} {
			show_error_highlight $dev [format "ERROR: [selected_full_name $dev] at 64'h%X..64'h%X is not in any of the device regions" "0x$dev_base" [expr "0x$dev_base + $dev_size - 1"]]
		}
		lappend l [list $dev $dev_base $dev_mask]
	}
	
	if {[selected NDS_DEBUG_SUPPORT] == "yes" && [selected NDS_L2C_CACHE_SIZE_KB]!=0} {
		return [check_overlap_error $l]
	} else {
		return 1
	}
}

end_dependency_checker {NDS_RESET_VECTOR} {
	set reset_vector [extract_hex_digits [selected NDS_RESET_VECTOR]]
	set rambrg_base [extract_hex_digits [selected RAMBRG_BASE]]
	set rambrg_size [expr "[selected RAMBRG_REGION_SIZE]*1024*1024"]
	
	set ilm_base [extract_hex_digits [selected NDS_ILM_BASE]]
	set ilm_size [expr "[selected NDS_ILM_SIZE]*1024"]
	
	set spi_mem_base [extract_hex_digits [selected SPI_MEM_BASE]]
	# assume SPI ROM size is 128MiB
	set spi_mem_size 0x100000
	
	if {[selected SPI1_SUPPORT]!="yes"} {
		set spi_mem_size 0
	}
	
	set valid_pointer 0
	
	if {[expr "0x${reset_vector} >= 0x${ilm_base} && 0x${reset_vector} < 0x${ilm_base} + $ilm_size"]} {
		set valid_pointer 1
	}
	
	if {[expr "0x${reset_vector} >= 0x$rambrg_base && 0x${reset_vector} < 0x$rambrg_base + $rambrg_size"]} {
		set valid_pointer 1
	}
	
	if {[expr "0x${reset_vector} >= 0x$spi_mem_base && 0x${reset_vector} < 0x$spi_mem_base + $spi_mem_size"]} {
		set valid_pointer 1
	}
	
	if {!$valid_pointer} {
		puts [format "WARNING: [selected_full_name NDS_RESET_VECTOR]@64'h%X is not pointing to any known memory spaces" "0x$reset_vector"]
		return 1
	}
	return 1
}

end_dependency_checker {DFS_SPACE} {
	if {[selected NDS_CORE_BRG_TYPE] == 2} {
		set dev "NDS_DFS_REG_BASE"
		set dev_base [extract_hex_digits [selected $dev]]
		set dev_size [expr 1*1024*1024]
		if {![in_device_region $dev_base $dev_size]} {
			puts [format "WARNING: [selected_full_name $dev] at 64'h%X..64'h%X is not in any of the device regions" "0x$dev_base" [expr "0x$dev_base + $dev_size - 1"]]
		}
	}
	return 1
}

end_dependency_checker {PLIC_MT_DM} {
	# SLV1: 4MiB
	set plic_mask 0x003FFFFF
	set plic_base [extract_hex_digits [selected PLIC_REGS_BASE]]

	# SLV2: 1MiB
	set plmt_mask 0x000FFFFF
	set plmt_base [extract_hex_digits [selected PLMT_REGS_BASE]]

	# SLV3: 4MiB
	set plic_sw_mask 0x003FFFFF
	set plic_sw_base [extract_hex_digits [selected PLIC_SW_REGS_BASE]]

	# SLV4: 1MiB
	set pldm_mask 0x000FFFFF
	set pldm_base [extract_hex_digits [selected PLDM_REGS_BASE]]

	# CPU Level Bus Matrix: 64MiB
	set mask 0x3FFFFFF
	set cpu_bmc_base [expr "0x${plic_base} & ~$mask"]
	set cpu_bmc_end [expr "$cpu_bmc_base | $mask"]

	set reg_base_list {PLIC_REGS_BASE PLMT_REGS_BASE}
	if {[selected PLIC_SWINT_SUPPORT] == "yes"} {
		lappend reg_base_list PLIC_SW_REGS_BASE
	}
	if {[selected NDS_DEBUG_SUPPORT] == "yes"} {
		lappend reg_base_list PLDM_REGS_BASE
	}
	foreach dev $reg_base_list {
		set dev_base [extract_hex_digits [selected $dev]]
		if {[expr "(0x${dev_base} & ~$mask) != $cpu_bmc_base"]} {
			puts [format "WARNING: [selected_full_name $dev]: 64'h%X is not in the same 64MiB space with [selected_full_name PLIC_REGS_BASE]:64'h%X..64'h%X" "0x$dev_base" $cpu_bmc_base $cpu_bmc_end]
		}
		switch -regexp $dev {
			(PLIC*)	{
				set dev_size [expr {4 * 1024 * 1024}]
			}
			(PLMT*|PLDM*)	{
				set dev_size [expr {1 * 1024 * 1024}]
			}
		}
		if {![in_device_region $dev_base $dev_size]} {
			puts [format "WARNING: [selected_full_name $dev] at 64'h%X..64'h%X is not in any of the device regions" "0x$dev_base" [expr "0x$dev_base + $dev_size - 1"]]
			return 1
		}
	}

	set l {}
	lappend l [list [selected_full_name PLIC_REGS_BASE] $plic_base $plic_mask]
	lappend l [list [selected_full_name PLMT_REGS_BASE] $plmt_base $plmt_mask]
	if {[selected PLIC_SWINT_SUPPORT] == "yes"} {
		lappend l [list [selected_full_name PLIC_SW_REGS_BASE] $plic_sw_base $plic_sw_mask]
	}
	if {[selected NDS_DEBUG_SUPPORT] == "yes"} {
		lappend l [list [selected_full_name PLDM_REGS_BASE] $pldm_base $pldm_mask]
	}
	set result [check_base_align_size $l]
	if {$result == 0} {
		return 0
	}
	return [check_overlap $l]
}

proc check_base_align_size {regions} {
	set nregions [llength $regions]
	for {set i 0} {$i < $nregions} {incr i} {
		set i_list [lindex $regions $i]
		set i_name [lindex $i_list 0]
		set i_base [lindex $i_list 1]
		set i_mask [lindex $i_list 2]
		if {[expr "(0x$i_base & $i_mask) != 0x0"]} {
			puts "WARNING: ${i_name} 64'h${i_base} is not naturally aligned to [format "0x%X" [expr $i_mask + 1]] boundary"
		}
	}
	return 1
}

end_dependency_checker {BMC_SPACE} {
	# SLV0: 1MiB
	set bmc_reg_mask 0x000FFFFF
	set bmc_reg_base [extract_hex_digits [selected BMC_REGS_BASE]]

	# SLV1: total 512MiB
	#   - AHBDEC: 1MiB
	#   - APB bridge: in next 256MiB (AHBDEC_REGS_BASE + 256MiB)
	set ahbdec_mask 0x1FFFFFFF
	set ahbdec_base [extract_hex_digits [selected AHBDEC_REGS_BASE]]

	# SLV2
	set rambrg_mask [format "0x%x" [expr "[selected RAMBRG_REGION_SIZE]*1024*1024 - 1"]]
	set rambrg_base [extract_hex_digits [selected RAMBRG_BASE]]
	
	# SLV3:
	set slvport_mask [format "0x%x" [expr {[selected SLVPORT_SIZE] * 1024 * 1024 * [selected NDS_NHART] - 1}]]
	set slvport_base [extract_hex_digits [selected SLVPORT_ILM_BASE]]

	# SLV4: 1MiB
	set spi_rom_mask 0x000FFFFF
	set spi_rom_base [extract_hex_digits [selected SPI_MEM_BASE]]

	set l {}
	lappend l [list [selected_full_name BMC_REGS_BASE] $bmc_reg_base $bmc_reg_mask]
	lappend l [list [selected_full_name AHBDEC_REGS_BASE] $ahbdec_base $ahbdec_mask]
	lappend l [list [selected_full_name RAMBRG_BASE] $rambrg_base $rambrg_mask]
	if {[selected NDS_SLAVE_PORT_SUPPORT]=="yes"} {
		lappend l [list [selected_full_name SLVPORT_ILM_BASE] $slvport_base $slvport_mask]
	}
	if {[selected SPI1_SUPPORT]=="yes"} {
		lappend l [list [selected_full_name SPI_MEM_BASE] $spi_rom_base $spi_rom_mask]
	}
	set result [check_base_align_size $l]
	if {$result == 0} {
		return 0
	}

	set l {}
	lappend l [list [selected_full_name BMC_REGS_BASE] $bmc_reg_base $bmc_reg_mask]
	lappend l [list [selected_full_name AHBDEC_REGS_BASE] $ahbdec_base $ahbdec_mask]
	lappend l [list [selected_full_name RAMBRG_BASE] $rambrg_base $rambrg_mask]
	if {[selected NDS_SLAVE_PORT_SUPPORT]=="yes"} {
		lappend l [list [selected_full_name SLVPORT_ILM_BASE] $slvport_base $slvport_mask]
	}
	if {[selected SPI1_SUPPORT]=="yes"} {
		lappend l [list [selected_full_name SPI_MEM_BASE] $spi_rom_base $spi_rom_mask]
	}

	# CPU Level Bus Matrix and L2C Register does not require to check with other BMC devices
	# CPU Level Bus Matrix: 64MiB
	#set plic_base [extract_hex_digits [selected PLIC_REGS_BASE]]
	#set cpu_bmc_mask 0x3FFFFFF
	#set cpu_bmc_base [expr "0x${plic_base} & ~$cpu_bmc_mask"]
	#set cpu_bmc_base [format "%X" $cpu_bmc_base]
	#lappend l [list "CPU Level Bus Matrix" $cpu_bmc_base $cpu_bmc_mask]

	#if {[selected NDS_L2C_CACHE_SIZE_KB]!=0} {
	#	set l2c_mask 0x000FFFFF
	#	set l2c_base [extract_hex_digits [selected NDS_L2C_REG_BASE]]
	#	lappend l [list [selected_full_name NDS_L2C_REG_BASE] $l2c_base $l2c_mask]
	#}
	if {[selected NDS_CORE_BRG_TYPE] == 2} {
		set dfs_mask 0xFFFFF
		set dfs_base [extract_hex_digits [selected NDS_DFS_REG_BASE]]
		lappend l [list [selected_full_name NDS_DFS_REG_BASE] $dfs_base $dfs_mask]
	}

	return [check_overlap $l]
}

end_dependency_checker {AHB_SPACE} {

	# SLV1: total 512MiB
	#   - AHBDEC: 1MiB
	#   - APB bridge: in next 256MiB (AHBDEC_REGS_BASE + 256MiB)
	set ahbdec_mask 0xFFFFF
	set ahbdec_base [extract_hex_digits [selected AHBDEC_REGS_BASE]]

	# APB bridge in SLV1 with 256MiB
	set apb_mask 0x0FFFFFFF
	set apb_base [extract_hex_digits [selected APBBRG_REGS_BASE]]

	set l {}
	lappend l [list [selected_full_name AHBDEC_REGS_BASE] $ahbdec_base $ahbdec_mask]
	lappend l [list [selected_full_name APBBRG_REGS_BASE] $apb_base $apb_mask]

	return [check_overlap $l]
}


end_dependency_checker {SLVPORT_SPACE} {
	if {[selected NDS_SLAVE_PORT_SUPPORT]=="no"} {
		return 1
	}

	set slvport_ilm_base [extract_hex_digits [selected SLVPORT_ILM_BASE]]
	set ilm_mask [expr "[selected NDS_ILM_SIZE]*1024 - 1"]
	set slvport_ilm_end [expr "0x${slvport_ilm_base} | $ilm_mask"]

	set slvport_dlm_base [extract_hex_digits [selected SLVPORT_DLM_BASE]]
	set dlm_mask [expr "[selected NDS_DLM_SIZE]*1024 - 1"]
	set slvport_dlm_end [expr "0x${slvport_dlm_base} | $dlm_mask"]

	# SLVPORT size: 64MiB
	set slvport_mask [format "0x%x" [expr {[selected SLVPORT_SIZE] * 1024 * 1024 * [selected NDS_NHART] - 1}]]
	set slvport_end [expr "0x${slvport_ilm_base} | $slvport_mask"]

	if {[selected NDS_DLM_SIZE] != 0} {
		set l {}
		lappend l [list "DLM Slave Port" $slvport_dlm_base $dlm_mask]
		set result [check_base_align_size $l]
		if {$result == 0} {
			return 0
		}	
	}

	if {![expr "$slvport_ilm_end < 0x${slvport_dlm_base}"]} {
		puts "WARNING: ILM Slave Port and DLM Slave Port overlaps: \[0x${slvport_ilm_base}-[format "0x%X" $slvport_ilm_end]] and \[0x${slvport_dlm_base}-[format "0x%X" $slvport_dlm_end]]"
	}
	if {![expr "$slvport_dlm_end < 0x${slvport_end}"]} {
		puts [format "WARNING: DLM Slave Port:64'h%X is not in the 64MiB Slave Port space:64'h%X..64'h%X" "0x$slvport_dlm_base" "0x$slvport_ilm_base" $slvport_end]
	}
	return 1
}

end_dependency_checker {BMC_REGS_BASE} {
	set bmc_base [extract_hex_digits [selected BMC_REGS_BASE]]
	set bmc_size [expr 1*1024*1024]
	if {![in_device_region $bmc_base $bmc_size]} {
		puts [format "WARNING: [selected_full_name BMC_REGS_BASE] at 64'h%X..64'h%X is not in any of the device regions" "0x$bmc_base" [expr "0x$bmc_base + $bmc_size - 1"]]
	}
	return 1
}


end_dependency_checker {AHBDEC_REGS_BASE} {
	set ahbdec_base [extract_hex_digits [selected AHBDEC_REGS_BASE]]
	set ahbdec_size [expr 512*1024*1024]
	if {![in_device_region $ahbdec_base $ahbdec_size]} {
		puts [format "WARNING: [selected_full_name AHBDEC_REGS_BASE] at 64'h%X..64'h%X is not in any of the device regions" "0x$ahbdec_base" [expr "0x$ahbdec_base + $ahbdec_size - 1"]]
	}

	# 512MiB
	set mask 0x1FFFFFFF
	set ahbdec_end [expr "0x${ahbdec_base} | $mask"]

	foreach dev {APBBRG_REGS_BASE} {
		set dev_base [extract_hex_digits [selected $dev]]
		if {[expr "0x${dev_base} == 0x${ahbdec_base}"]} {
			puts [format "WARNING: [selected_full_name $dev]: 64'h%X overlaps with the [selected_full_name AHBDEC_REGS_BASE]:64'h%X" "0x$dev_base" "0x$ahbdec_base"]
			puts [format "WARNING: [selected_full_name $dev]: 64'h%X overlaps with the AHBDEC control register space:64'h%X" "0x$dev_base" "0x$ahbdec_base"]
		}
		if {[expr "(0x${dev_base} & ~$mask) != (0x${ahbdec_base} & ~$mask)"]} {
			puts [format "WARNING: [selected_full_name $dev]: 64'h%X is not in the [selected_full_name AHBDEC_REGS_BASE] space:64'h%X..64'h%X" "0x$dev_base" "0x$ahbdec_base" $ahbdec_end]
		}
		set dev_size [expr 256*1024*1024]
		if {![in_device_region $dev_base $dev_size]} {
			puts [format "WARNING: [selected_full_name $dev] at 64'h%X..64'h%X is not in any of the device regions" "0x$dev_base" [expr "0x$dev_base + $dev_size - 1"]]
		}
	}
	return 1
}

end_dependency_checker {APB_SPACE} {
	set apb_dev_bases {SMU_REGS_BASE UART1_REGS_BASE UART2_REGS_BASE PIT_REGS_BASE WDT_REGS_BASE  RTC_REGS_BASE GPIO_REGS_BASE I2C_REGS_BASE SPI1_REGS_BASE DMAC_REGS_BASE SPI2_REGS_BASE DTROM_REGS_BASE}

	set apb_base [selected APBBRG_REGS_BASE]
	set apb_base [extract_hex_digits $apb_base]

	set mask {0x0FFFFFFF}
	set dev_mask {0x000FFFFF}
	set apb_end [expr "0x${apb_base} | $mask"]

	set l {}
	lappend l [list [selected_full_name APBBRG_REGS_BASE] $apb_base $mask]
	set result [check_base_align_size $l]
	if {$result == 0} {
		return 0
	}

	set l {}
	foreach dev $apb_dev_bases {
		regsub {_REGS_BASE} $dev {_SUPPORT} dev_support
		set configured [selected $dev_support]
		if {$configured == ""} {
			puts "WARNING: no such option: $dev_support"
			continue
		} elseif {$configured == "no"} {
			continue
		}

		set dev_base [extract_hex_digits [selected $dev]]
		if {[expr "0x${dev_base} == 0x${apb_base}"]} {
			puts [format "WARNING: [selected_full_name $dev]: 64'h%X overlaps with the [selected_full_name APBBRG_REGS_BASE]:64'h%X" "0x$dev_base" "0x$apb_base"]
		}
		if {[expr "(0x${dev_base} & ~$mask) != (0x${apb_base} & ~$mask)"]} {
			puts [format "WARNING: [selected_full_name $dev]: 64'h%X is not in the [selected_full_name APBBRG_REGS_BASE] space:64'h%X..64'h%X" "0x$dev_base" "0x$apb_base" $apb_end]
		}
		lappend l [list [selected_full_name $dev] $dev_base $dev_mask]
	}

	set result [check_base_align_size $l]
	if {$result == 0} {
		return 0
	}
	return [check_overlap $l]
}

