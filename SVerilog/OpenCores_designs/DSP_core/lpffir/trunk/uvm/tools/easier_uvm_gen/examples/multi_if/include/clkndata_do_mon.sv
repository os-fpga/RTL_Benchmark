task clkndata_monitor::do_mon;
  forever @(posedge vif.clk)
  begin
    m_trans = data_tx::type_id::create("m_trans");
    m_trans.data = vif.data;
    analysis_port.write(m_trans);
  end
endtask
