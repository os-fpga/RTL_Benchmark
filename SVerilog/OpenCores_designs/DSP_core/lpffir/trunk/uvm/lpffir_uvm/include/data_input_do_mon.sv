task data_input_monitor::do_mon;
  forever @(posedge vif.clk)
  begin
    wait (vif.reset == 1);
    if (vif.valid && vif.ready)
    begin
      m_trans.data = vif.data;
      analysis_port.write(m_trans);
      `uvm_info(get_type_name(), $sformatf("Input data = %0d", m_trans.data), UVM_HIGH)
    end
  end
endtask
