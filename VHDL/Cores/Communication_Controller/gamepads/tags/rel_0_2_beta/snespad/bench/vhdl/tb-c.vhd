-------------------------------------------------------------------------------
--
-- Testbench for the
-- SNESpad controller core
--
-- Copyright (c) 2004, Arnim Laeuger (arniml@opencores.org)
--
-- $Id: tb-c.vhd,v 1.1 2004-10-05 17:05:31 arniml Exp $
--
-------------------------------------------------------------------------------

configuration tb_behav_c0 of tb is

  for behav
    for dut : snespad
      use configuration work.snespad_struct_c0;
    end for;
  end for;

end tb_behav_c0;
