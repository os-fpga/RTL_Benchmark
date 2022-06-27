-------------------------------------------------------------------------------
-- Title      : DMT modulator
-- Project    : 
-------------------------------------------------------------------------------
-- File       : dmt_mod.vhd
-- Author     : 
-- Company    : 
-- Created    : 2004-05-17
-- Last update: 2004-05-17
-- Platform   : 
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2004 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2004-05-17  1.0      guenter	Created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity dmt_mod is
  
  port (
    clk_i        : in  std_logic;
    rst_i        : in  std_logic;
    data_en_i    : in  std_logic;       -- enables the data processing mode
    data_i       : in  std_logic_vector(14 downto 0);  -- input data to the modulator core
    conf_we_i    : in  std_logic;       -- enables the configuration mode
    bin_addr_i   : in  std_logic_vector(7 downto 0);  -- addresses the bin configuration
    const_size_i : in  std_logic_vector(3 downto 0);  -- constellation size for the addressed bin
    gain_i       : in  std_logic_vector(11 downto 0);  -- gain value for the addressed bin
    data_o       : out std_logic_vector(15 downto 0));  -- output data from the modulator core

end dmt_mod;

architecture arch of dmt_mod is

begin  -- arch

  

end arch;
