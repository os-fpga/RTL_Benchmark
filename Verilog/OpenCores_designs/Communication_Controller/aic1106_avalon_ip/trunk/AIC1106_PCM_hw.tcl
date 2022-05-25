# TCL File Generated by Component Editor 11.0sp1
# Sun Aug 12 17:32:19 IDT 2012
# DO NOT MODIFY


# +-----------------------------------
# | 
# | AIC1106_PCM "TLV320AIC1106" v1.0
# | AlexO by 2012 2012.08.12.17:32:19
# | TLV320AIC1106 voice codec
# | 
# | C:/_MicroTag/uTagG32/trunk/hardware/FPGA/AIC1106/AIC1106_PCM.v
# | 
# |    ./AIC1106_PCM.v syn, sim
# | 
# +-----------------------------------

# +-----------------------------------
# | request TCL package from ACDS 11.0
# | 
package require -exact sopc 11.0
# | 
# +-----------------------------------

# +-----------------------------------
# | module AIC1106_PCM
# | 
set_module_property DESCRIPTION "TLV320AIC1106 voice codec"
set_module_property NAME AIC1106_PCM
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property AUTHOR "AlexO by 2012"
set_module_property DISPLAY_NAME TLV320AIC1106
set_module_property TOP_LEVEL_HDL_FILE AIC1106_PCM.v
set_module_property TOP_LEVEL_HDL_MODULE AIC1106_PCM
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE true
set_module_property ANALYZE_HDL TRUE
set_module_property STATIC_TOP_LEVEL_MODULE_NAME AIC1106_PCM
set_module_property FIX_110_VIP_PATH false
# | 
# +-----------------------------------

# +-----------------------------------
# | files
# | 
add_file AIC1106_PCM.v {SYNTHESIS SIMULATION}
# | 
# +-----------------------------------

# +-----------------------------------
# | parameters
# | 
# | 
# +-----------------------------------

# +-----------------------------------
# | display items
# | 
# | 
# +-----------------------------------

# +-----------------------------------
# | connection point avalon
# | 
add_interface avalon clock end
#set_interface_property avalon clockRate 80000000

set_interface_property avalon ENABLED true

add_interface_port avalon csi_avalon_clk clk Input 1
# | 
# +-----------------------------------

# +-----------------------------------
# | connection point clock_reset
# | 
add_interface clock_reset reset end
set_interface_property clock_reset associatedClock avalon
set_interface_property clock_reset synchronousEdges DEASSERT

set_interface_property clock_reset ENABLED true

add_interface_port clock_reset csi_reset reset Input 1
# | 
# +-----------------------------------

# +-----------------------------------
# | connection point audio
# | 
add_interface audio clock end
set_interface_property audio clockRate 2048000

set_interface_property audio ENABLED true

add_interface_port audio csi_audio_clk clk Input 1
# | 
# +-----------------------------------

# +-----------------------------------
# | connection point creg
# | 
add_interface creg avalon end
set_interface_property creg addressAlignment DYNAMIC
set_interface_property creg addressUnits WORDS
set_interface_property creg associatedClock avalon
set_interface_property creg associatedReset clock_reset
set_interface_property creg burstOnBurstBoundariesOnly false
set_interface_property creg explicitAddressSpan 0
set_interface_property creg holdTime 0
set_interface_property creg isMemoryDevice false
set_interface_property creg isNonVolatileStorage false
set_interface_property creg linewrapBursts false
set_interface_property creg maximumPendingReadTransactions 0
set_interface_property creg printableDevice false
set_interface_property creg readLatency 0
set_interface_property creg readWaitTime 1
set_interface_property creg setupTime 0
set_interface_property creg timingUnits Cycles
set_interface_property creg writeWaitTime 0

set_interface_property creg ENABLED true

add_interface_port creg avs_creg_address address Input 2
add_interface_port creg avs_creg_chipselect chipselect Input 1
add_interface_port creg avs_creg_write write Input 1
add_interface_port creg avs_creg_read read Input 1
add_interface_port creg avs_creg_writedata writedata Input 32
add_interface_port creg avs_creg_readdata readdata Output 32
# | 
# +-----------------------------------

# +-----------------------------------
# | connection point avalon_streaming_sink
# | 
add_interface avalon_streaming_sink avalon_streaming end
set_interface_property avalon_streaming_sink associatedClock audio
set_interface_property avalon_streaming_sink dataBitsPerSymbol 32
set_interface_property avalon_streaming_sink errorDescriptor ""
set_interface_property avalon_streaming_sink firstSymbolInHighOrderBits true
set_interface_property avalon_streaming_sink maxChannel 0
set_interface_property avalon_streaming_sink readyLatency 1

set_interface_property avalon_streaming_sink ENABLED true

add_interface_port avalon_streaming_sink asi_data data Input 32
add_interface_port avalon_streaming_sink asi_valid valid Input 1
add_interface_port avalon_streaming_sink asi_ready ready Output 1
# | 
# +-----------------------------------

# +-----------------------------------
# | connection point avalon_streaming_source
# | 
add_interface avalon_streaming_source avalon_streaming start
set_interface_property avalon_streaming_source associatedClock audio
set_interface_property avalon_streaming_source dataBitsPerSymbol 32
set_interface_property avalon_streaming_source errorDescriptor ""
set_interface_property avalon_streaming_source firstSymbolInHighOrderBits true
set_interface_property avalon_streaming_source maxChannel 0
set_interface_property avalon_streaming_source readyLatency 0

set_interface_property avalon_streaming_source ENABLED true

add_interface_port avalon_streaming_source aso_data data Output 32
add_interface_port avalon_streaming_source aso_valid valid Output 1
# | 
# +-----------------------------------

# +-----------------------------------
# | connection point conduit_end
# | 
add_interface conduit_end conduit end

set_interface_property conduit_end ENABLED true

add_interface_port conduit_end coe_mclk export Output 1
add_interface_port conduit_end coe_pcmsyn export Output 1
add_interface_port conduit_end coe_pcmi export Output 1
add_interface_port conduit_end coe_pcmo export Input 1
add_interface_port conduit_end coe_reset_n export Output 1
add_interface_port conduit_end coe_mute export Output 1
add_interface_port conduit_end coe_linsel export Output 1
# | 
# +-----------------------------------
