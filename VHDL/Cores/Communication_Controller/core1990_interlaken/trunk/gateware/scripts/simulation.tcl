
proc simulate { arg1 } {
	set scriptdir [pwd]
	set proj_dir $scriptdir/../
	
	add_files -fileset sim_1 -norecurse $proj_dir/simulation/Core1990_Test_tb.vhd	
	add_files -fileset sim_1 -norecurse $proj_dir/simulation/crc-32_tb.vhd	
	add_files -fileset sim_1 -norecurse $proj_dir/simulation/decoder_tb.vhd	
	add_files -fileset sim_1 -norecurse $proj_dir/simulation/deframing_burst_tb.vhd	
	add_files -fileset sim_1 -norecurse $proj_dir/simulation/deframing_meta_tb.vhd
	add_files -fileset sim_1 -norecurse $proj_dir/simulation/descrambler_tb.vhd	
	add_files -fileset sim_1 -norecurse $proj_dir/simulation/encoder_tb.vhd	
	add_files -fileset sim_1 -norecurse $proj_dir/simulation/framing_burst_tb.vhd	
	add_files -fileset sim_1 -norecurse $proj_dir/simulation/framing_meta_tb.vhd	
	add_files -fileset sim_1 -norecurse $proj_dir/simulation/interlaken_interface_tb.vhd
	add_files -fileset sim_1 -norecurse $proj_dir/simulation/interlaken_receiver_tb.vhd	
	add_files -fileset sim_1 -norecurse $proj_dir/simulation/interlaken_transmitter_tb.vhd	
	add_files -fileset sim_1 -norecurse $proj_dir/simulation/scrambler_tb.vhd

	close_sim -force -quiet
	update_compile_order -fileset sources_1

	
	if {$arg1 eq {core1990}} {
		set_property top testbench_Interface_Test [get_filesets sim_1]	
		set_property top_lib work [get_filesets sim_1]
		set_property top_arch tb_interlaken_interface [get_filesets sim_1]
		launch_xsim -simset sim_1 -mode behavioral
		open_wave_config {/home/nayibb/Desktop/report/Code/Core1990/projects/core1990_interlaken/testbench_interlaken_interface_behav.wcfg}
		puts "$arg1 it is, you've chosen wisely"

	} elseif {$arg1 eq {interface}} {

		set_property top testbench_interlaken_interface [get_filesets sim_1]	
		set_property top_lib work [get_filesets sim_1]
		set_property top_arch tb_interlaken_interface [get_filesets sim_1]
		launch_xsim -simset sim_1 -mode behavioral

	} elseif {$arg1 eq {decoder}} {
		
		set_property top testbench_decoder [get_filesets sim_1]	
		set_property top_lib work [get_filesets sim_1]
		set_property top_arch tb_decoder [get_filesets sim_1]
		launch_xsim -simset sim_1 -mode behavioral

	} elseif {$arg1 eq {-help} } {
		puts "Seems you need help\n"
		puts "Run the simulation by entering the command simulate followed by the part you would like to simulate. \n Syntax : simulate object \n Arguments : core1990, interface , decoder."
	} else {
		puts "No valid command"
	}
}

puts "\nRun the simulation by entering the command simulate followed by the part you would like to simulate. \n Syntax : simulate object \n Arguments : interface , decoder."
