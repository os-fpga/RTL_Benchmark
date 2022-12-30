task rca_driver::do_drive();
  vif.a <= req.input1;
  vif.b <= req.input2;
  vif.ci <= req.carryinput;
  @(posedge vif.clk);
endtask