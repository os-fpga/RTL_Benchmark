//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2018 Authors and OPENCORES.ORG                 ////
////                                                              ////
//// This source file may be used and distributed without         ////
//// restriction provided that this copyright statement is not    ////
//// removed from the file and that any derivative work contains  ////
//// the original copyright notice and the associated disclaimer. ////
////                                                              ////
//// This source file is free software; you can redistribute it   ////
//// and/or modify it under the terms of the GNU Lesser General   ////
//// Public License as published by the Free Software Foundation; ////
//// either version 2.1 of the License, or (at your option) any   ////
//// later version.                                               ////
////                                                              ////
//// This source is distributed in the hope that it will be       ////
//// useful, but WITHOUT ANY WARRANTY; without even the implied   ////
//// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      ////
//// PURPOSE.  See the GNU Lesser General Public License for more ////
//// details.                                                     ////
////                                                              ////
//// You should have received a copy of the GNU Lesser General    ////
//// Public License along with this source; if not, download it   ////
//// from http://www.opencores.org/lgpl.shtml                     ////
////                                                              ////
//////////////////////////////////////////////////////////////////////

class tb_env extends uvm_env;
  `uvm_component_utils(tb_env);

  // --------------------------------------------------------------------
  tb_dut_config #(N, U) cfg_h;
  // coverage coverage_h;
  avf_scoreboard scoreboard_h;
  avf_master_agent #(N, U) m_agent_h;
  avf_slave_agent #(N, U) s_agent_h;

  // --------------------------------------------------------------------
  function new (string name, uvm_component parent);
    super.new(name,parent);
  endfunction : new

  // --------------------------------------------------------------------
  function void build_phase(uvm_phase phase);
    if (!uvm_config_db #(tb_dut_config #(N, U))::get(this, "", "tb_dut_config", cfg_h))
      `uvm_fatal(get_name(), "Couldn't get config object!")

    m_agent_h = avf_master_agent #(N, U)::type_id::create("m_agent_h", this);
    m_agent_h.cfg_h = cfg_h.m_cfg_h;
    m_agent_h.is_active = cfg_h.m_cfg_h.get_is_active();

    s_agent_h = avf_slave_agent #(N, U)::type_id::create("s_agent_h", this);
    s_agent_h.cfg_h = cfg_h.s_cfg_h;
    s_agent_h.is_active = cfg_h.s_cfg_h.get_is_active();

    scoreboard_h = avf_scoreboard::type_id::create("scoreboard_h", this);
  endfunction : build_phase

  // --------------------------------------------------------------------
  function void connect_phase(uvm_phase phase);
    s_agent_h.monitor_h.ap.connect(scoreboard_h.analysis_export);
  endfunction : connect_phase

// --------------------------------------------------------------------
endclass : tb_env
