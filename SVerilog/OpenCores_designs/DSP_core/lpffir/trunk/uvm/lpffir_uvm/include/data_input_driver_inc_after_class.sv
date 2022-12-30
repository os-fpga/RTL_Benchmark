task data_input_driver::run_phase(uvm_phase phase);
  `uvm_info(get_type_name(), "run_phase", UVM_HIGH)

  forever @(posedge vif.clk)
  begin
    seq_item_port.get_next_item(req);
    phase.raise_objection(this);
    wait (vif.reset == 1);
    vif.data <= req.data;
    vif.valid  <= 1;
    vif.last  <= 0;
    wait (vif.ready == 1);
  
    fork
      begin
        repeat (10) @(posedge vif.clk);
        phase.drop_objection(this);
      end
    join_none
    seq_item_port.item_done();
  end
endtask : run_phase
