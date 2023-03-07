// Copyright (c) 2006-2020 Qualcomm Technologies, Inc. All rights reserved.
// This RTL contains confidential and trade secret material and you may make, have
// made, use, reproduce, display or perform (publicly or otherwise), prepare
// derivative works based on, offer for sale, sell, distribute, import,
// disclose, license, sublicense, dispose of and otherwise exploit this RTL solely in
// accordance with your license agreement.
// If you have not agreed to all of the terms and conditions in such License
// Agreement, you should immediately return this RTL (including any copies)
// to your licensor.
// This RTL or portions thereof are protected under U.S. and foreign patent and patent applications.


package anvu_tests_pkg;
	import uvm_pkg::*;
	import anvu_commons_pkg::*;
	import anvu_noc_definitions_pkg::*;
	import anvu_xactors_pkg::*;
	import anvu_top_env_pkg::*;
	import svt_uvm_pkg::*;
	import svt_apb_uvm_pkg::*;
	import svt_ahb_uvm_pkg::*;
	import svt_axi_uvm_pkg::*;
	`include "anvu_random_test.sv"
	`include "anvu_connectivity_test.sv"
	`include "anvu_connectivityWithSlvError_test.sv"
	`include "anvu_latency_test.sv"
	`include "anvu_throughput_test.sv"
	`include "anvu_registerMap_test.sv"
	`include "anvu_bist_test.sv"
	`include "anvu_userBit_test.sv"
	`include "anvu_flowControl_test.sv"
	`include "anvu_thorough_test.sv"
	`include "anvu_probeConnectivity_test.sv"
	`include "anvu_power_test.sv"
endpackage
