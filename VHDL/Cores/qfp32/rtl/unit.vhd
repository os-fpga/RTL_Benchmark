-- Copyright (c) 2013 Malte Graeper (mgraep@t-online.de) All rights reserved.

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library work;
use work.qfp_p.all;
use work.qfp32_add_p.all;
use work.qfp32_misc_p.all;

package qfp32_unit_p is
  
  type qfp_cmd_t is record
    unit    : unsigned(2 downto 0);
    sub_cmd : qfp_scmd_t;
  end record qfp_cmd_t;

  constant QFP_UNIT_ADD : unsigned(2 downto 0) := to_unsigned(0,3);
  constant QFP_UNIT_MUL : unsigned(2 downto 0) := to_unsigned(1,3);
  constant QFP_UNIT_RECP : unsigned(2 downto 0) := to_unsigned(2,3);
  constant QFP_UNIT_MISC : unsigned(2 downto 0) := to_unsigned(3,3);
  constant QFP_UNIT_NONE : unsigned(2 downto 0) := to_unsigned(5,3);
  constant QFP_UNIT_DIV : unsigned(2 downto 0) := to_unsigned(4,3);

  constant qfp_config_add : natural := 2**to_integer(QFP_UNIT_ADD);
  constant qfp_config_mul : natural := 2**to_integer(QFP_UNIT_MUL);
  constant qfp_config_recp : natural := 2**to_integer(QFP_UNIT_RECP);
  constant qfp_config_misc : natural := 2**to_integer(QFP_UNIT_MISC);
  constant qfp_config_div : natural := 2**to_integer(QFP_UNIT_DIV);
  
  constant qfp_config_all : natural := qfp_config_add+qfp_config_mul+qfp_config_recp+qfp_config_misc+qfp_config_div;

  component qfp32_add is
    port (
      clk_i      : in  std_ulogic;
      reset_n_i  : in  std_ulogic;
      cmd_i      : in  qfp_scmd_t;
      start_i    : in  std_ulogic;
      ready_o    : out std_ulogic;
      regA_i     : in  qfp32_t;
      regB_i     : in  qfp32_t;
      complete_o : out std_ulogic;
      result_o   : out qfp32_raw_t;
      cmp_eq_o   : out std_ulogic;
      cmp_gt_o   : out std_ulogic);
  end component qfp32_add;

  component qfp32_mul is
    port (
      clk_i      : in  std_ulogic;
      reset_n_i  : in  std_ulogic;
      start_i    : in  std_ulogic;
      ready_o    : out std_ulogic;
      regA_i     : in  qfp32_t;
      regB_i     : in  qfp32_t;
      complete_o : out std_ulogic;
      result_o   : out qfp32_raw_t);
  end component qfp32_mul;

  component qfp32_recp is
    port (
      clk_i      : in  std_ulogic;
      reset_n_i  : in  std_ulogic;
      start_i    : in  std_ulogic;
      ready_o    : out std_ulogic;
      regA_i     : in  qfp32_t;
      complete_o : out std_ulogic;
      result_o   : out qfp32_t);
  end component qfp32_recp;

  component qfp32_divider is
    port (
      clk_i      : in  std_ulogic;
      reset_n_i  : in  std_ulogic;
      start_i    : in  std_ulogic;
      ready_o    : out std_ulogic;
      regA_i     : in  qfp32_t;
      regB_i     : in  qfp32_t;
      complete_o : out std_ulogic;
      result_o   : out qfp32_raw_t);
  end component qfp32_divider;

  component qfp32_misc is
    port (
      clk_i      : in  std_ulogic;
      reset_n_i  : in  std_ulogic;
      cmd_i      : in  qfp_scmd_t;
      start_i    : in  std_ulogic;
      ready_o    : out std_ulogic;
      regA_i     : in  qfp32_t;
      regB_i     : in  qfp32_t;
      complete_o : out std_ulogic;
      result_o   : out qfp32_raw_t);
  end component qfp32_misc;

  component qfp_norm is
    port (
      clk_i          : in  std_ulogic;
      reset_n_i      : in  std_ulogic;
      raw_i          : in  qfp32_raw_t;
      result_o       : out qfp32_t;
      result_zero_o  : out std_ulogic);
  end component qfp_norm;  
 
end package qfp32_unit_p;


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library work;
use work.qfp_p.all;
use work.qfp32_unit_p.all;
use work.qfp32_norm_p.all;
use work.qfp32_misc_p.all;

entity qfp_unit is
  
  generic (
    config : natural := qfp_config_all);

  port (
    clk_i      : in  std_ulogic;
    reset_n_i  : in  std_ulogic;
    
    cmd_i      : in  qfp_cmd_t;
    ready_o    : out std_ulogic;
    start_i    : in  std_ulogic;
    regA_i     : in  std_ulogic_vector(31 downto 0);
    regB_i     : in  std_ulogic_vector(31 downto 0);
    result_o   : out std_ulogic_vector(31 downto 0);
    cmp_gt_o   : out std_ulogic;
    cmp_z_o    : out std_ulogic;
    complete_o : out std_ulogic);

end entity qfp_unit;

architecture Rtl of qfp_unit is

  constant units_config : unsigned(5 downto 0) := to_unsigned(config,6);

  type qfp32_vector_t is array (natural range <>) of qfp32_raw_t;
  
  function "sll" (ARG: std_ulogic_vector; COUNT: integer) return std_ulogic_vector is
  begin
    return To_StdULogicVector(std_logic_vector(unsigned(ARG) sll COUNT));
  end "sll";

  signal units_start    : std_ulogic_vector(5 downto 0);
  signal units_ready    : std_ulogic_vector(5 downto 0);
  signal units_complete : std_ulogic_vector(5 downto 0);
  signal units_result   : qfp32_vector_t(5 downto 0);
  
  signal i : natural range 0 to 5;
  signal j : natural range 0 to 5;

  signal regA : qfp32_t;
  signal regB : qfp32_t;
  signal cmp_le : std_ulogic;
  signal result : qfp32_t;
  signal active_unit : unsigned(2 downto 0);

  signal sign_ext : std_ulogic;
  
  signal raw_result : qfp32_raw_t;
  signal result_zero : std_ulogic;

begin  -- architecture Rtl

  qfp32_add_1: entity work.qfp32_add
    port map (
      clk_i      => clk_i,
      reset_n_i  => reset_n_i,
      cmd_i      => cmd_i.sub_cmd,
      start_i    => units_start(0),
      ready_o    => units_ready(0),
      regA_i     => regA,
      regB_i     => regB,
      complete_o => units_complete(0),
      result_o   => units_result(0),
      cmp_le_o   => cmp_le);

  qfp32_mul_1: entity work.qfp32_mul
    port map (
      clk_i      => clk_i,
      reset_n_i  => reset_n_i,
      start_i    => units_start(1),
      ready_o    => units_ready(1),
      regA_i     => regA,
      regB_i     => regB,
      complete_o => units_complete(1),
      result_o   => units_result(1));

  qfp32_recp_1: entity work.qfp32_recp
    port map (
      clk_i      => clk_i,
      reset_n_i  => reset_n_i,
      start_i    => units_start(2),
      ready_o    => units_ready(2),
      regA_i     => regA,
      complete_o => units_complete(2),
      result_o   => units_result(2));

  qfp32_divider_1: entity work.qfp32_divider
    port map (
      clk_i      => clk_i,
      reset_n_i  => reset_n_i,
      start_i    => units_start(4),
      ready_o    => units_ready(4),
      regA_i     => regA,
      regB_i     => regB,
      complete_o => units_complete(4),
      result_o   => units_result(4));

  qfp32_misc_1: entity work.qfp32_misc
    port map (
      clk_i      => clk_i,
      reset_n_i  => reset_n_i,
      cmd_i      => cmd_i.sub_cmd,
      start_i    => units_start(3),
      ready_o    => units_ready(3),
      regA_i     => regA,
      regB_i     => regB,
      complete_o => units_complete(3),
      result_o   => units_result(3));

  qfp_norm_1: entity work.qfp_norm
    port map (
      clk_i          => clk_i,
      reset_n_i      => reset_n_i,
      raw_i          => raw_result,
      result_o       => result,
      result_zero_o  => result_zero);
      
  raw_result <= units_result(i);

  process (clk_i, reset_n_i) is
  begin  -- process
    if reset_n_i = '0' then             -- asynchronous reset (active low)
      active_unit <= QFP_UNIT_NONE;
    elsif clk_i'event and clk_i = '1' then  -- rising clock edge
      active_unit <= cmd_i.unit;
    end if;
  end process;

  units_result(to_integer(QFP_UNIT_NONE)) <= (unsigned(regA_i(28 downto 0)) & X"000000","00000",'0' & unsigned(regA_i(30 downto 29)),regA_i(31));
  units_ready(to_integer(QFP_UNIT_NONE)) <= '1';
  units_complete(to_integer(QFP_UNIT_NONE)) <= '0';

  i <= to_integer(cmd_i.unit);
  j <= to_integer(active_unit);

  -- start unit
  units_start <= ("000001" sll i) when units_config(i) = '1' and start_i = '1' else (others => '0');

  -- convert from q to integer
  sign_ext <= '1' when cmd_i.unit = to_unsigned(3,3) and cmd_i.sub_cmd = QFP_SCMD_Q2I else '0';

  regA <= (unsigned(regA_i(28 downto 0)),(unsigned(regA_i(30 downto 29)),regA_i(31)));
  regB <= (unsigned(regB_i(28 downto 0)),(unsigned(regB_i(30 downto 29)),regB_i(31)));

  result_o(31) <= result.fmt.sign;
  result_o(30 downto 29) <= std_ulogic_vector(result.fmt.exp) when sign_ext = '0' else result.fmt.sign & result.fmt.sign;
  result_o(28 downto 0) <= std_ulogic_vector(result.mant);
 
  -- add/sub: 2 cycles, fully pipelined
  -- mul: 3 cycles, delay 2 cycles
  -- recp: 31 cycles, delay 30 cycles
  -- misc: 1 cycle, delay 1 cycle
  -- div: 32cycles, delay 31 cycles
  ready_o <= units_ready(j);
  complete_o <= units_complete(j);

  -- only valid for sub
  cmp_gt_o <= not result_zero and cmp_le;
  cmp_z_o <= result_zero;
 
end architecture Rtl;
