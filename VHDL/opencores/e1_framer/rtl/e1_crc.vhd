library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use work.e1_framer.all;

entity e1_crc is port
     (clk,reset :in std_logic;
      datain : in std_logic_vector(7 downto 0);
      channelno:in int_32;
      sync_sig : in std_logic;
      dataout: out std_logic_vector(7 downto 0);
      ) ;
end e1_crc;

Architecture behave of e1_crc is

begin

