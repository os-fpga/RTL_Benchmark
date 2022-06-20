-------------------------------------------------------------------------------
--
-- GCpad controller core
--
-- Copyright (c) 2004, Arnim Laeuger (arniml@opencores.org)
--
-- $Id: gcpad_basic-c.vhd,v 1.1 2004-10-07 21:23:10 arniml Exp $
--
-------------------------------------------------------------------------------

configuration gcpad_basic_struct_c0 of gcpad_basic is

  for struct
    for ctrl_b : gcpad_ctrl
      use configuration work.gcpad_ctrl_rtl_c0;
    end for;

    for tx_b : gcpad_tx
      use configuration work.gcpad_tx_rtl_c0;
    end for;

    for rx_b : gcpad_rx
      use configuration work.gcpad_rx_rtl_c0;
    end for;
  end for;

end gcpad_basic_struct_c0;
