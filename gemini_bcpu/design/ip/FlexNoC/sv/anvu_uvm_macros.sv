// Copyright (c) 2013-2020 Qualcomm Technologies, Inc. All rights reserved.
// This RTL contains confidential and trade secret material and you may make, have
// made, use, reproduce, display or perform (publicly or otherwise), prepare
// derivative works based on, offer for sale, sell, distribute, import,
// disclose, license, sublicense, dispose of and otherwise exploit this RTL solely in
// accordance with your license agreement.
// If you have not agreed to all of the terms and conditions in such License
// Agreement, you should immediately return this RTL (including any copies)
// to your licensor.
// This RTL or portions thereof are protected under U.S. and foreign patent and patent applications.

`ifndef ANVU_UVM_MACROS
`define ANVU_UVM_MACROS

`define ANVU_SET_CONFIG( type , handle , name)                                         \
	begin                                                                              \
        uvm_config_db#(type)::set(null,"*",name,handle);                               \
	end                                                                                \

`define ANVU_GET_CONFIG( type , handle , name)                                         \
	begin                                                                              \
        if (!uvm_config_db#(type)::get(null,"*",name,handle))                          \
			`uvm_error("anvu_bench",$psprintf("Could not get config entry %s",name))   \
	end                                                                                \

`endif
