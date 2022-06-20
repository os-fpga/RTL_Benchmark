-------------------------------------------------------------------------------
--
-- SD/MMC Bootloader
--
-- $Id: tb_pack-p.vhd,v 1.1 2005-02-08 21:09:20 arniml Exp $
--
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package tb_pack is

  function calc_crc(payload : in std_logic_vector) return std_logic_vector;
  function calc_crc(payload : in unsigned) return unsigned;

end tb_pack;


package body tb_pack is

  function calc_crc(payload : in std_logic_vector) return std_logic_vector is

    variable crc_v  : std_logic_vector(6 downto 0);
    variable temp_v : std_logic;

  begin

    crc_v := (others => '0');

    for i in payload'high downto payload'low loop
      temp_v := payload(i) xor crc_v(6);

      crc_v(6 downto 4) := crc_v(5 downto 3);
      crc_v(3) := crc_v(2) xor temp_v;
      crc_v(2 downto 1) := crc_v(1 downto 0);
      crc_v(0) := temp_v;
    end loop;

    return crc_v;
  end calc_crc;

  function calc_crc(payload : in unsigned) return unsigned is
  begin
    return unsigned(calc_crc(std_logic_vector(payload)));
  end calc_crc;

end tb_pack;


-------------------------------------------------------------------------------
-- File History:
--
-- $Log: not supported by cvs2svn $
-------------------------------------------------------------------------------
