-------------------------------------------------------------------------------
--
-- GCpad controller core
--
-- Copyright (c) 2004, Arnim Laeuger (arniml@opencores.org)
--
-- $Id: gcpad_rx-c.vhd,v 1.2 2004-10-08 21:18:39 arniml Exp $
--
-------------------------------------------------------------------------------

configuration gcpad_rx_rtl_c0 of gcpad_rx is

  for rtl
    for sampler_b : gcpad_sampler
      use configuration work.gcpad_sampler_rtl_c0;
    end for;
  end for;

end gcpad_rx_rtl_c0;
