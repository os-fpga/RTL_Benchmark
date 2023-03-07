// Copyright (c) 2006-2020 Qualcomm Technologies, Inc. All rights reserved.
// This code contains confidential and trade secret material and you may make, have
// made, use, reproduce, display or perform (publicly or otherwise), prepare
// derivative works based on, offer for sale, sell, distribute, import,
// disclose, license, sublicense, dispose of and otherwise exploit this code solely in
// accordance with your license agreement.
// If you have not agreed to all of the terms and conditions in such License
// Agreement, you should immediately return this code (including any copies)
// to your licensor.
// This code or portions thereof are protected under U.S. and foreign patent and patent applications.

typedef class anvu_user_bench_env;

`include "anvu_bench_env.sv"

class anvu_user_bench_env extends anvu_bench_env;
   `uvm_component_utils(anvu_user_bench_env)

	function new(string name = "anvu_user_bench_env" , uvm_component parent);
		super.new(name,parent);
	endfunction

endclass

