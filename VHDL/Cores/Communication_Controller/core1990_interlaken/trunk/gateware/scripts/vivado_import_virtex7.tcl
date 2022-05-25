#
#	File import script for the core1990 interlaken hdl project
#	

#Script Configuration
set proj_name core1990_interlaken

# Set the supportfiles directory path
set scriptdir [pwd]
set proj_dir $scriptdir/../

#Close currently open project and create a new one. (OVERWRITES PROJECT!!)
close_project -quiet

create_project -force -part xc7vx485tffg1761-2 $proj_name $proj_dir/projects/$proj_name

set_property target_language VHDL [current_project]
set_property default_lib work [current_project]

# ----------------------------------------------------------
# Core1990 top file
# ----------------------------------------------------------
read_vhdl -library work $proj_dir/sources/interlaken_interface.vhd

# ----------------------------------------------------------
# CRC
# ----------------------------------------------------------
read_vhdl -library work $proj_dir/sources/crc/crc-24.vhd
read_vhdl -library work $proj_dir/sources/crc/crc-32.vhd

# ----------------------------------------------------------
# Transmitter
# ----------------------------------------------------------
read_vhdl -library work $proj_dir/sources/transmitter/framing_burst.vhd
read_vhdl -library work $proj_dir/sources/transmitter/framing_meta.vhd
read_vhdl -library work $proj_dir/sources/transmitter/scrambler.vhd
read_vhdl -library work $proj_dir/sources/transmitter/encoder.vhd
read_vhdl -library work $proj_dir/sources/transmitter/interlaken_transmitter.vhd

# ----------------------------------------------------------
# Receiver
# ----------------------------------------------------------
read_vhdl -library work $proj_dir/sources/receiver/deframing_burst.vhd
read_vhdl -library work $proj_dir/sources/receiver/deframing_meta.vhd
read_vhdl -library work $proj_dir/sources/receiver/descrambler.vhd
read_vhdl -library work $proj_dir/sources/receiver/decoder.vhd
read_vhdl -library work $proj_dir/sources/receiver/interlaken_receiver.vhd

# ----------------------------------------------------------
# IP cores
# ----------------------------------------------------------
import_ip $proj_dir/sources/ip_cores/clk_40MHz.xci
import_ip $proj_dir/sources/ip_cores/Transceiver_10g_64b67b.xci
import_ip $proj_dir/sources/ip_cores/RX_FIFO.xci
import_ip $proj_dir/sources/ip_cores/TX_FIFO.xci

# ----------------------------------------------------------
# finish project initilization
# ----------------------------------------------------------
upgrade_ip [get_ips]

set_property top interlaken_interface [current_fileset]

puts "INFO: Done!"

