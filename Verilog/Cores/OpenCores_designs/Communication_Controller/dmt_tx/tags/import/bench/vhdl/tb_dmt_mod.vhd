-------------------------------------------------------------------------------
-- Title      : Testbench for DMT modulator
-- Project    : 
-------------------------------------------------------------------------------
-- File       : tb_dmt_mod.vhd
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
-- Revisions  : $Id: tb_dmt_mod.vhd,v 1.1.1.1 2004-05-17 19:58:40 dannori Exp $
-- Date        Version  Author  Description
-- 2004-05-17  1.0      guenter	Created
-------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity tb_dmt_mod is
  
  generic (Tpw_clk : time := 5 ns);

end tb_dmt_mod;

architecture arch of tb_dmt_mod is

  component dmt_mod
    port (
      clk_i        : in  std_logic;
      rst_i        : in  std_logic;
      data_en_i    : in  std_logic;
      data_i       : in  std_logic_vector(14 downto 0);
      conf_we_i    : in  std_logic;
      bin_addr_i   : in  std_logic_vector(7 downto 0);
      const_size_i : in  std_logic_vector(3 downto 0);
      gain_i       : in  std_logic_vector(11 downto 0);
      data_o       : out std_logic_vector(15 downto 0));

  end component;

  -- Stimulus signals for DUT
  signal sig_clk_i        : std_logic;
  signal sig_rst_i        : std_logic;
  signal sig_data_en_i    : std_logic;
  signal sig_data_i       : std_logic_vector(14 downto 0);
  signal sig_conf_we_i    : std_logic;
  signal sig_bin_addr_i   : std_logic_vector(7 downto 0);
  signal sig_const_size_i : std_logic_vector(3 downto 0);
  signal sig_gain_i       : std_logic_vector(11 downto 0);
  signal sig_data_o       : std_logic_vector(15 downto 0);


  
begin  -- arch

  DUT : dmt_mod
    port map(

      clk_i        => sig_clk_i,
      rst_i        => sig_rst_i,
      data_en_i    => sig_data_en_i,
      data_i       => sig_data_i,
      conf_we_i    => sig_conf_we_i,
      bin_addr_i   => sig_bin_addr_i,
      const_size_i => sig_const_size_i,
      gain_i       => sig_gain_i,
      data_o       => sig_data_o);

  -----------------------------------------------------------------------------
    -- clock generator
    clock_gen : process(sig_clk_i) is
    begin
      if sig_clk_i = '0' then
        sig_clk_i <= '1' after Tpw_clk, '0' after 2 * Tpw_clk;
      end if;
    end process clock_gen;


  -- purpose: ends the simulation after a specified number of clock cycles
  sim_timing : process
  begin  -- process sim_timing
    for count in 0 to 10 loop
      wait until sig_clk_i'event and sig_clk_i = '1';
    end loop;  -- count

    assert sig_clk_i /= '1' report "\n---> Finished simulation!" severity failure;
  end process sim_timing;

end arch;
