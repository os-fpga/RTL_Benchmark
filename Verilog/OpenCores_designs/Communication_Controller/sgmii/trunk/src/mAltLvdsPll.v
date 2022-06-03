// megafunction wizard: %Altera PLL v12.0%
// GENERATION: XML
// mAltLvdsPll.v

// Generated using ACDS version 12.0sp2 263 at 2012.11.06.21:41:41

`timescale 1 ps / 1 ps
module mAltLvdsPll (
		input  wire  refclk,   //  refclk.clk
		input  wire  rst,      //   reset.reset
		output wire  outclk_0, // outclk0.clk
		output wire  outclk_1, // outclk1.clk
		output wire  outclk_2, // outclk2.clk
		output wire  locked    //  locked.export
	);

//	mAltLvdsPll_0002 maltlvdspll_inst (
//		.refclk   (refclk),   //  refclk.clk
//		.rst      (rst),      //   reset.reset
//		.outclk_0 (outclk_0), // outclk0.clk
//		.outclk_1 (outclk_1), // outclk1.clk
//		.outclk_2 (outclk_2), // outclk2.clk
//		.locked   (locked)    //  locked.export
//	);

endmodule
// Retrieval info: <?xml version="1.0"?>
//<!--
//	Generated by Altera MegaWizard Launcher Utility version 1.0
//	************************************************************
//	THIS IS A WIZARD-GENERATED FILE. DO NOT EDIT THIS FILE!
//	************************************************************
//	Copyright (C) 1991-2012 Altera Corporation
//	Any megafunction design, and related net list (encrypted or decrypted),
//	support information, device programming or simulation file, and any other
//	associated documentation or information provided by Altera or a partner
//	under Altera's Megafunction Partnership Program may be used only to
//	program PLD devices (but not masked PLD devices) from Altera.  Any other
//	use of such megafunction design, net list, support information, device
//	programming or simulation file, or any other related documentation or
//	information is prohibited for any other purpose, including, but not
//	limited to modification, reverse engineering, de-compiling, or use with
//	any other silicon devices, unless such use is explicitly licensed under
//	a separate agreement with Altera or a megafunction partner.  Title to
//	the intellectual property, including patents, copyrights, trademarks,
//	trade secrets, or maskworks, embodied in any such megafunction design,
//	net list, support information, device programming or simulation file, or
//	any other related documentation or information provided by Altera or a
//	megafunction partner, remains with Altera, the megafunction partner, or
//	their respective licensors.  No other licenses, including any licenses
//	needed under any third party's intellectual property, are provided herein.
//-->
// Retrieval info: <instance entity-name="altera_pll" version="12.0" >
// Retrieval info: 	<generic name="device_family" value="Arria V" />
// Retrieval info: 	<generic name="gui_device_speed_grade" value="5_H4" />
// Retrieval info: 	<generic name="gui_pll_mode" value="Integer-N PLL" />
// Retrieval info: 	<generic name="gui_reference_clock_frequency" value="125.0" />
// Retrieval info: 	<generic name="gui_channel_spacing" value="0.0" />
// Retrieval info: 	<generic name="gui_operation_mode" value="lvds" />
// Retrieval info: 	<generic name="gui_feedback_clock" value="Global Clock" />
// Retrieval info: 	<generic name="gui_fractional_cout" value="24" />
// Retrieval info: 	<generic name="gui_use_locked" value="true" />
// Retrieval info: 	<generic name="gui_en_adv_params" value="false" />
// Retrieval info: 	<generic name="gui_number_of_clocks" value="3" />
// Retrieval info: 	<generic name="gui_output_clock_frequency0" value="1250.0" />
// Retrieval info: 	<generic name="gui_multiply_factor0" value="1" />
// Retrieval info: 	<generic name="gui_frac_multiply_factor0" value="1" />
// Retrieval info: 	<generic name="gui_divide_factor0" value="1" />
// Retrieval info: 	<generic name="gui_actual_output_clock_frequency0" value="0 MHz" />
// Retrieval info: 	<generic name="gui_ps_units0" value="degrees" />
// Retrieval info: 	<generic name="gui_phase_shift0" value="0" />
// Retrieval info: 	<generic name="gui_phase_shift_deg0" value="-180" />
// Retrieval info: 	<generic name="gui_actual_phase_shift0" value="0" />
// Retrieval info: 	<generic name="gui_duty_cycle0" value="50" />
// Retrieval info: 	<generic name="gui_output_clock_frequency1" value="125.0" />
// Retrieval info: 	<generic name="gui_multiply_factor1" value="1" />
// Retrieval info: 	<generic name="gui_frac_multiply_factor1" value="1" />
// Retrieval info: 	<generic name="gui_divide_factor1" value="1" />
// Retrieval info: 	<generic name="gui_actual_output_clock_frequency1" value="0 MHz" />
// Retrieval info: 	<generic name="gui_ps_units1" value="degrees" />
// Retrieval info: 	<generic name="gui_phase_shift1" value="0" />
// Retrieval info: 	<generic name="gui_phase_shift_deg1" value="288" />
// Retrieval info: 	<generic name="gui_actual_phase_shift1" value="0" />
// Retrieval info: 	<generic name="gui_duty_cycle1" value="10" />
// Retrieval info: 	<generic name="gui_output_clock_frequency2" value="125.0" />
// Retrieval info: 	<generic name="gui_multiply_factor2" value="1" />
// Retrieval info: 	<generic name="gui_frac_multiply_factor2" value="1" />
// Retrieval info: 	<generic name="gui_divide_factor2" value="1" />
// Retrieval info: 	<generic name="gui_actual_output_clock_frequency2" value="0 MHz" />
// Retrieval info: 	<generic name="gui_ps_units2" value="degrees" />
// Retrieval info: 	<generic name="gui_phase_shift2" value="0" />
// Retrieval info: 	<generic name="gui_phase_shift_deg2" value="-18" />
// Retrieval info: 	<generic name="gui_actual_phase_shift2" value="0" />
// Retrieval info: 	<generic name="gui_duty_cycle2" value="50" />
// Retrieval info: 	<generic name="gui_output_clock_frequency3" value="100.0" />
// Retrieval info: 	<generic name="gui_multiply_factor3" value="1" />
// Retrieval info: 	<generic name="gui_frac_multiply_factor3" value="1" />
// Retrieval info: 	<generic name="gui_divide_factor3" value="1" />
// Retrieval info: 	<generic name="gui_actual_output_clock_frequency3" value="0 MHz" />
// Retrieval info: 	<generic name="gui_ps_units3" value="ps" />
// Retrieval info: 	<generic name="gui_phase_shift3" value="0" />
// Retrieval info: 	<generic name="gui_phase_shift_deg3" value="0" />
// Retrieval info: 	<generic name="gui_actual_phase_shift3" value="0" />
// Retrieval info: 	<generic name="gui_duty_cycle3" value="50" />
// Retrieval info: 	<generic name="gui_output_clock_frequency4" value="100.0" />
// Retrieval info: 	<generic name="gui_multiply_factor4" value="1" />
// Retrieval info: 	<generic name="gui_frac_multiply_factor4" value="1" />
// Retrieval info: 	<generic name="gui_divide_factor4" value="1" />
// Retrieval info: 	<generic name="gui_actual_output_clock_frequency4" value="0 MHz" />
// Retrieval info: 	<generic name="gui_ps_units4" value="ps" />
// Retrieval info: 	<generic name="gui_phase_shift4" value="0" />
// Retrieval info: 	<generic name="gui_phase_shift_deg4" value="0" />
// Retrieval info: 	<generic name="gui_actual_phase_shift4" value="0" />
// Retrieval info: 	<generic name="gui_duty_cycle4" value="50" />
// Retrieval info: 	<generic name="gui_output_clock_frequency5" value="100.0" />
// Retrieval info: 	<generic name="gui_multiply_factor5" value="1" />
// Retrieval info: 	<generic name="gui_frac_multiply_factor5" value="1" />
// Retrieval info: 	<generic name="gui_divide_factor5" value="1" />
// Retrieval info: 	<generic name="gui_actual_output_clock_frequency5" value="0 MHz" />
// Retrieval info: 	<generic name="gui_ps_units5" value="ps" />
// Retrieval info: 	<generic name="gui_phase_shift5" value="0" />
// Retrieval info: 	<generic name="gui_phase_shift_deg5" value="0" />
// Retrieval info: 	<generic name="gui_actual_phase_shift5" value="0" />
// Retrieval info: 	<generic name="gui_duty_cycle5" value="50" />
// Retrieval info: 	<generic name="gui_output_clock_frequency6" value="100.0" />
// Retrieval info: 	<generic name="gui_multiply_factor6" value="1" />
// Retrieval info: 	<generic name="gui_frac_multiply_factor6" value="1" />
// Retrieval info: 	<generic name="gui_divide_factor6" value="1" />
// Retrieval info: 	<generic name="gui_actual_output_clock_frequency6" value="0 MHz" />
// Retrieval info: 	<generic name="gui_ps_units6" value="ps" />
// Retrieval info: 	<generic name="gui_phase_shift6" value="0" />
// Retrieval info: 	<generic name="gui_phase_shift_deg6" value="0" />
// Retrieval info: 	<generic name="gui_actual_phase_shift6" value="0" />
// Retrieval info: 	<generic name="gui_duty_cycle6" value="50" />
// Retrieval info: 	<generic name="gui_output_clock_frequency7" value="100.0" />
// Retrieval info: 	<generic name="gui_multiply_factor7" value="1" />
// Retrieval info: 	<generic name="gui_frac_multiply_factor7" value="1" />
// Retrieval info: 	<generic name="gui_divide_factor7" value="1" />
// Retrieval info: 	<generic name="gui_actual_output_clock_frequency7" value="0 MHz" />
// Retrieval info: 	<generic name="gui_ps_units7" value="ps" />
// Retrieval info: 	<generic name="gui_phase_shift7" value="0" />
// Retrieval info: 	<generic name="gui_phase_shift_deg7" value="0" />
// Retrieval info: 	<generic name="gui_actual_phase_shift7" value="0" />
// Retrieval info: 	<generic name="gui_duty_cycle7" value="50" />
// Retrieval info: 	<generic name="gui_output_clock_frequency8" value="100.0" />
// Retrieval info: 	<generic name="gui_multiply_factor8" value="1" />
// Retrieval info: 	<generic name="gui_frac_multiply_factor8" value="1" />
// Retrieval info: 	<generic name="gui_divide_factor8" value="1" />
// Retrieval info: 	<generic name="gui_actual_output_clock_frequency8" value="0 MHz" />
// Retrieval info: 	<generic name="gui_ps_units8" value="ps" />
// Retrieval info: 	<generic name="gui_phase_shift8" value="0" />
// Retrieval info: 	<generic name="gui_phase_shift_deg8" value="0" />
// Retrieval info: 	<generic name="gui_actual_phase_shift8" value="0" />
// Retrieval info: 	<generic name="gui_duty_cycle8" value="50" />
// Retrieval info: 	<generic name="gui_output_clock_frequency9" value="100.0" />
// Retrieval info: 	<generic name="gui_multiply_factor9" value="1" />
// Retrieval info: 	<generic name="gui_frac_multiply_factor9" value="1" />
// Retrieval info: 	<generic name="gui_divide_factor9" value="1" />
// Retrieval info: 	<generic name="gui_actual_output_clock_frequency9" value="0 MHz" />
// Retrieval info: 	<generic name="gui_ps_units9" value="ps" />
// Retrieval info: 	<generic name="gui_phase_shift9" value="0" />
// Retrieval info: 	<generic name="gui_phase_shift_deg9" value="0" />
// Retrieval info: 	<generic name="gui_actual_phase_shift9" value="0" />
// Retrieval info: 	<generic name="gui_duty_cycle9" value="50" />
// Retrieval info: 	<generic name="gui_output_clock_frequency10" value="100.0" />
// Retrieval info: 	<generic name="gui_multiply_factor10" value="1" />
// Retrieval info: 	<generic name="gui_frac_multiply_factor10" value="1" />
// Retrieval info: 	<generic name="gui_divide_factor10" value="1" />
// Retrieval info: 	<generic name="gui_actual_output_clock_frequency10" value="0 MHz" />
// Retrieval info: 	<generic name="gui_ps_units10" value="ps" />
// Retrieval info: 	<generic name="gui_phase_shift10" value="0" />
// Retrieval info: 	<generic name="gui_phase_shift_deg10" value="0" />
// Retrieval info: 	<generic name="gui_actual_phase_shift10" value="0" />
// Retrieval info: 	<generic name="gui_duty_cycle10" value="50" />
// Retrieval info: 	<generic name="gui_output_clock_frequency11" value="100.0" />
// Retrieval info: 	<generic name="gui_multiply_factor11" value="1" />
// Retrieval info: 	<generic name="gui_frac_multiply_factor11" value="1" />
// Retrieval info: 	<generic name="gui_divide_factor11" value="1" />
// Retrieval info: 	<generic name="gui_actual_output_clock_frequency11" value="0 MHz" />
// Retrieval info: 	<generic name="gui_ps_units11" value="ps" />
// Retrieval info: 	<generic name="gui_phase_shift11" value="0" />
// Retrieval info: 	<generic name="gui_phase_shift_deg11" value="0" />
// Retrieval info: 	<generic name="gui_actual_phase_shift11" value="0" />
// Retrieval info: 	<generic name="gui_duty_cycle11" value="50" />
// Retrieval info: 	<generic name="gui_output_clock_frequency12" value="100.0" />
// Retrieval info: 	<generic name="gui_multiply_factor12" value="1" />
// Retrieval info: 	<generic name="gui_frac_multiply_factor12" value="1" />
// Retrieval info: 	<generic name="gui_divide_factor12" value="1" />
// Retrieval info: 	<generic name="gui_actual_output_clock_frequency12" value="0 MHz" />
// Retrieval info: 	<generic name="gui_ps_units12" value="ps" />
// Retrieval info: 	<generic name="gui_phase_shift12" value="0" />
// Retrieval info: 	<generic name="gui_phase_shift_deg12" value="0" />
// Retrieval info: 	<generic name="gui_actual_phase_shift12" value="0" />
// Retrieval info: 	<generic name="gui_duty_cycle12" value="50" />
// Retrieval info: 	<generic name="gui_output_clock_frequency13" value="100.0" />
// Retrieval info: 	<generic name="gui_multiply_factor13" value="1" />
// Retrieval info: 	<generic name="gui_frac_multiply_factor13" value="1" />
// Retrieval info: 	<generic name="gui_divide_factor13" value="1" />
// Retrieval info: 	<generic name="gui_actual_output_clock_frequency13" value="0 MHz" />
// Retrieval info: 	<generic name="gui_ps_units13" value="ps" />
// Retrieval info: 	<generic name="gui_phase_shift13" value="0" />
// Retrieval info: 	<generic name="gui_phase_shift_deg13" value="0" />
// Retrieval info: 	<generic name="gui_actual_phase_shift13" value="0" />
// Retrieval info: 	<generic name="gui_duty_cycle13" value="50" />
// Retrieval info: 	<generic name="gui_output_clock_frequency14" value="100.0" />
// Retrieval info: 	<generic name="gui_multiply_factor14" value="1" />
// Retrieval info: 	<generic name="gui_frac_multiply_factor14" value="1" />
// Retrieval info: 	<generic name="gui_divide_factor14" value="1" />
// Retrieval info: 	<generic name="gui_actual_output_clock_frequency14" value="0 MHz" />
// Retrieval info: 	<generic name="gui_ps_units14" value="ps" />
// Retrieval info: 	<generic name="gui_phase_shift14" value="0" />
// Retrieval info: 	<generic name="gui_phase_shift_deg14" value="0" />
// Retrieval info: 	<generic name="gui_actual_phase_shift14" value="0" />
// Retrieval info: 	<generic name="gui_duty_cycle14" value="50" />
// Retrieval info: 	<generic name="gui_output_clock_frequency15" value="100.0" />
// Retrieval info: 	<generic name="gui_multiply_factor15" value="1" />
// Retrieval info: 	<generic name="gui_frac_multiply_factor15" value="1" />
// Retrieval info: 	<generic name="gui_divide_factor15" value="1" />
// Retrieval info: 	<generic name="gui_actual_output_clock_frequency15" value="0 MHz" />
// Retrieval info: 	<generic name="gui_ps_units15" value="ps" />
// Retrieval info: 	<generic name="gui_phase_shift15" value="0" />
// Retrieval info: 	<generic name="gui_phase_shift_deg15" value="0" />
// Retrieval info: 	<generic name="gui_actual_phase_shift15" value="0" />
// Retrieval info: 	<generic name="gui_duty_cycle15" value="50" />
// Retrieval info: 	<generic name="gui_output_clock_frequency16" value="100.0" />
// Retrieval info: 	<generic name="gui_multiply_factor16" value="1" />
// Retrieval info: 	<generic name="gui_frac_multiply_factor16" value="1" />
// Retrieval info: 	<generic name="gui_divide_factor16" value="1" />
// Retrieval info: 	<generic name="gui_actual_output_clock_frequency16" value="0 MHz" />
// Retrieval info: 	<generic name="gui_ps_units16" value="ps" />
// Retrieval info: 	<generic name="gui_phase_shift16" value="0" />
// Retrieval info: 	<generic name="gui_phase_shift_deg16" value="0" />
// Retrieval info: 	<generic name="gui_actual_phase_shift16" value="0" />
// Retrieval info: 	<generic name="gui_duty_cycle16" value="50" />
// Retrieval info: 	<generic name="gui_output_clock_frequency17" value="100.0" />
// Retrieval info: 	<generic name="gui_multiply_factor17" value="1" />
// Retrieval info: 	<generic name="gui_frac_multiply_factor17" value="1" />
// Retrieval info: 	<generic name="gui_divide_factor17" value="1" />
// Retrieval info: 	<generic name="gui_actual_output_clock_frequency17" value="0 MHz" />
// Retrieval info: 	<generic name="gui_ps_units17" value="ps" />
// Retrieval info: 	<generic name="gui_phase_shift17" value="0" />
// Retrieval info: 	<generic name="gui_phase_shift_deg17" value="0" />
// Retrieval info: 	<generic name="gui_actual_phase_shift17" value="0" />
// Retrieval info: 	<generic name="gui_duty_cycle17" value="50" />
// Retrieval info: 	<generic name="gui_pll_auto_reset" value="Off" />
// Retrieval info: 	<generic name="gui_pll_bandwidth_preset" value="Auto" />
// Retrieval info: 	<generic name="gui_en_reconf" value="false" />
// Retrieval info: 	<generic name="gui_en_dps_ports" value="false" />
// Retrieval info: 	<generic name="gui_refclk_switch" value="false" />
// Retrieval info: 	<generic name="gui_refclk1_frequency" value="100.0" />
// Retrieval info: 	<generic name="gui_switchover_mode" value="Automatic Switchover" />
// Retrieval info: 	<generic name="gui_switchover_delay" value="0" />
// Retrieval info: 	<generic name="gui_active_clk" value="false" />
// Retrieval info: 	<generic name="gui_clk_bad" value="false" />
// Retrieval info: 	<generic name="AUTO_REFCLK_CLOCK_RATE" value="-1" />
// Retrieval info: </instance>
// IPFS_FILES : mAltLvdsPll.vo
// RELATED_FILES: mAltLvdsPll.v, mAltLvdsPll_0002.v