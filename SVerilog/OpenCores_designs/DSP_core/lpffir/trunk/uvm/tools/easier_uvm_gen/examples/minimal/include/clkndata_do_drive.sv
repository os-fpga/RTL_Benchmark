task clkndata_driver::do_drive();
  vif.data <= req.data;
  @(posedge vif.clk);
endtask
