-- Copyright (c) 2013 Malte Graeper (mgraep@t-online.de) All rights reserved.

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library work;
use work.qfp_p.all;

entity qfp32_mul is
  
  port (
    clk_i     : in  std_ulogic;
    reset_n_i : in  std_ulogic;

    start_i   : in  std_ulogic;
    ready_o   : out std_ulogic;
       
    regA_i    : in  qfp32_t;
    regB_i    : in  qfp32_t;
    
    complete_o : out std_ulogic;
    result_o   : out qfp32_raw_t);

end qfp32_mul;

architecture Rtl of qfp32_mul is

  signal start_1d : std_ulogic;
  signal start_2d : std_ulogic;
  
  signal p1_result : unsigned(57 downto 0);
  signal p1_sign : std_ulogic;
  signal p1_exp_special : unsigned(2 downto 0);

  signal p2_complete : std_ulogic;
  signal p2_result : unsigned(57 downto 0);
  signal p2_sign : std_ulogic;
  signal p2_exp_special : unsigned(2 downto 0);

begin  -- Rtl

  -- make multiplication multicycle path => better performance

  process (clk_i, reset_n_i)
  begin  -- process
    if reset_n_i = '0' then             -- asynchronous reset (active low)
      p2_result <= to_unsigned(0,58);
      p2_sign <= '0';
      p2_exp_special <= to_unsigned(0,3);
      p2_complete <= '0';
      start_1d <= '0';
      start_2d <= '0';
    elsif clk_i'event and clk_i = '1' then  -- rising clock edge
      start_1d <= start_i;
      start_2d <= start_1d;
      p2_complete <= '0';
      
      -- move data to next pipeline stage
      if start_2d = '1' then
        p2_result <= p1_result;
        p2_sign <= p1_sign;
        p2_exp_special <= p1_exp_special;
        p2_complete <= '1';
      end if;

    end if;
  end process;
  
  process (p2_exp_special, p2_result, p2_sign, regA_i, regB_i)
  begin  -- process

    -- stage 1
    p1_result <= regA_i.mant * regB_i.mant;

    p1_sign <= regA_i.fmt.sign xor regB_i.fmt.sign;
    p1_exp_special <= ('0' & regA_i.fmt.exp)+('0' & regB_i.fmt.exp); 

    -- stage 2
    result_o.sign <= p2_sign;
    result_o.extMant <= p2_result(52 downto 0);
    result_o.ov <= p2_result(57 downto 53);
    result_o.exp <= p2_exp_special;    

  end process;
  
  ready_o <= not start_1d;
  complete_o <= p2_complete;

end Rtl;


