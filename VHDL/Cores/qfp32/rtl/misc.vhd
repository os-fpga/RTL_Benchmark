-- Copyright (c) 2013 Malte Graeper (mgraep@t-online.de) All rights reserved.

library IEEE;
use IEEE.std_logic_1164.all;

library work;
use work.qfp_p.all;

package qfp32_misc_p is

  constant QFP_SCMD_Q2I : qfp_scmd_t := "00";
  constant QFP_SCMD_I2Q : qfp_scmd_t := "01";

end package qfp32_misc_p;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library work;
use work.qfp_p.all;
use work.qfp32_misc_p.all;

entity qfp32_misc is
  
  port (
    clk_i     : in  std_ulogic;
    reset_n_i : in  std_ulogic;

    cmd_i : in qfp_scmd_t;
    
    start_i : in  std_ulogic;
    ready_o : out std_ulogic;
    
    regA_i : in  qfp32_t;
    regB_i : in  qfp32_t;
    
    complete_o : out std_ulogic;
    result_o   : out qfp32_raw_t);

end qfp32_misc;

architecture Rtl of qfp32_misc is

  -- integer input int(31 downto 0) mapped to
  -- mant = int(28 downto 0)
  -- exp = int(30 downto 29)
  -- sign = int(31)
  
  signal p1_sign : std_ulogic;
  signal p1_cy : std_ulogic;
  signal p1_mant : unsigned(28 downto 0);
  signal p1_shft : unsigned(1 downto 0);
  signal p1_pre_add : unsigned(28 downto 0);
  signal p1_mant_shft : unsigned(29 downto 0);
  signal p1_fmt : qfp_fmt_t;
  signal p1_result : unsigned(29 downto 0);
  signal p1_ov : std_ulogic;

  signal p2_fmt : qfp_fmt_t;
  signal p2_result : unsigned(29 downto 0);
  signal p2_ov : std_ulogic;
  
  signal complete : std_ulogic;

begin  -- Rtl
  
  process (cmd_i, p1_cy, p1_mant, p1_mant_shft(0), p1_mant_shft(29 downto 1),
           p1_pre_add, p1_shft, p1_sign, p2_fmt.exp, p2_fmt.sign, p2_ov,
           p2_result(28 downto 0), rega_i.fmt.exp, rega_i.fmt.sign,
           rega_i.mant)
  begin  -- process

    -- stage 1
    p1_sign <= rega_i.fmt.sign;
    p1_mant <= rega_i.mant;
    
    p1_cy <= '0';
    p1_ov <= '0'; 
    p1_shft <= to_unsigned(0,2);
    p1_fmt.sign <= p1_sign;
    p1_fmt.exp <= to_unsigned(3,2);
    if cmd_i = QFP_SCMD_Q2I then
      p1_shft <= to_unsigned(3,2)-rega_i.fmt.exp;
      -- result is integer => fill upper bits with sign at unit
      p1_fmt.exp <= to_unsigned(0,2); -- forced zero cause otherwise normalization would take effect
      p1_cy <= p1_mant_shft(0) xor p1_sign;
    else
      p1_cy <= p1_sign;
      p1_ov <= to_ulogic(regA_i.fmt.exp /= p1_sign & p1_sign);
    end if;

     -- extend mant for rounding bit
    p1_mant_shft <= fast_shift(p1_mant & '0',to_integer(p1_shft)*8,'1','0');-- if p1_shft = 0 => fill is not used!

     -- make 2's complement if needed
    p1_pre_add <= p1_mant_shft(29 downto 1);    
    if p1_sign = '1' then
      p1_pre_add <= not p1_mant_shft(29 downto 1);  
    end if;
    
    -- add one to make two's complement complete
    p1_result <= fast_add(p1_pre_add,to_unsigned(0,29),p1_cy);-- negate

    -- stage 2

    -- as qfp raw format
    result_o.extMant <= p2_result(28 downto 0) & (23 downto 0 => '0');
    result_o.ov <= "0000" & p2_ov;
    result_o.exp <= '0' & p2_fmt.exp;
    result_o.sign <= p2_fmt.sign;
  end process;

  process (clk_i, reset_n_i) is
  begin  -- process
    if reset_n_i = '0' then             -- asynchronous reset (active low)
      complete <= '0';
      p2_fmt <= (to_unsigned(0,2),'0');
      p2_result <= to_unsigned(0,30);
      p2_ov <= '0';
    elsif clk_i'event and clk_i = '1' then  -- rising clock edge
      complete <= '0';
      if start_i = '1' then
        p2_ov <= p1_ov;
        p2_fmt <= p1_fmt;
        p2_result <= p1_result;
        complete <= '1';
      end if;      
    end if;
  end process;

  ready_o <= '1';
  complete_o <= complete;--start_i;
  
end Rtl;


