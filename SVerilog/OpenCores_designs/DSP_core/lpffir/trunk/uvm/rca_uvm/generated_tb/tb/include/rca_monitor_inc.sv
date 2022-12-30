task rca_monitor::do_mon;
  forever @(posedge vif.clk)
    begin
	  m_trans.input1 = vif.a;
	  m_trans.input2 = vif.b;
	  m_trans.carryinput = vif.ci;
	  m_trans.carryoutput = vif.co;
	  m_trans.sum = vif.s;
	  analysis_port.write(m_trans);
	  `uvm_info(get_type_name(),$sformatf("a(%0d) + b(%0d) + ci(%0d) = co(%0d) and s(%0d)", vif.a, vif.b, vif.ci, vif.co, vif.s), UVM_MEDIUM);
    end
endtask