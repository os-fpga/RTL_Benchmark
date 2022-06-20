function void reference::write_reference_0(input_tx t);
  send(t);
endfunction
  
function void reference::send(input_tx t);
  output_tx tx;
  tx = output_tx::type_id::create("tx");
  if (init_flag == 1)
    begin
      init_flag = 0;
      foreach(tx_save[j])
        tx_save[j] = 0;
    end
  if (save_pnt == 5)
    save_pnt = 0;
  else
  save_pnt++;
  tx_save[save_pnt] = t.data;
  tx.data = tx_save[0] + tx_save[1] + tx_save[2] + tx_save[3] + tx_save[4] + tx_save[5];
  analysis_port_0.write(tx);
  `uvm_info(get_type_name(), $sformatf("Reference Model save_pnt = %0d, data = %0d",save_pnt, tx.data), UVM_HIGH)
endfunction
