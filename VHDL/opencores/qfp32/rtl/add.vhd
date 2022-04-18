-- Copyright (c) 2013 Malte Graeper (mgraep@t-online.de) All rights reserved.

library IEEE;
use IEEE.std_logic_1164.all;

library work;
use work.qfp_p.all;

package qfp32_add_p is

  type qfp32_SCMD_ADD_t is (QFP_ADD,QFP_SUB);

  constant QFP_SCMD_ADD : qfp_scmd_t := "00";
  constant QFP_SCMD_SUB : qfp_scmd_t := "01";

end package qfp32_add_p;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library work;
use work.qfp_p.all;
use work.cla_p.all;
use work.qfp32_add_p.all;

entity qfp32_add is
  
  port (
    clk_i     : in  std_ulogic;
    reset_n_i : in  std_ulogic;
    
    cmd_i : in qfp_scmd_t;
    
    start_i : in std_ulogic;
    ready_o : out std_ulogic;
    
    regA_i : in  qfp32_t;
    regB_i : in  qfp32_t;

    complete_o : out std_ulogic;
    result_o   : out qfp32_raw_t;
    
    cmp_le_o  : out std_ulogic);-- regA <= regB

end qfp32_add;

architecture Rtl of qfp32_add is

  signal p1_gt : std_ulogic;
  signal p1_fmt : qfp_fmt_t;
  signal p1_mant_a : unsigned(29 downto 0);
  signal p1_mant_b : unsigned(29 downto 0);
  signal p1_cy : std_ulogic;
  signal p1_op_a : unsigned(29 downto 0);
  signal p1_op_b : unsigned(29 downto 0);
  signal p1_clag1 : cla_level_t(7 downto 0);
  signal p1_clag2 : cla_level_t(1 downto 0);
  signal p1_cmp_gt : std_ulogic;
  signal p1_is_add : std_ulogic;
  signal p1_exp1 : std_ulogic_vector(2 downto 0);

  signal p2_complete : std_ulogic;
  signal p2_gt : std_ulogic;
  signal p2_fmt : qfp_fmt_t;
  signal p2_cy : std_ulogic;
  signal p2_op_a : unsigned(29 downto 0);
  signal p2_op_b : unsigned(29 downto 0);
  signal p2_clag1 : cla_level_t(7 downto 0);
  signal p2_clag2 : cla_level_t(1 downto 0);
  signal p2_is_add : std_ulogic;
  
  signal p2_exp1 : std_ulogic_vector(2 downto 0);
  signal p2_exp2 : std_ulogic_vector(8 downto 0);

  signal p2_result : unsigned(29 downto 0);
  signal p2_sign : std_ulogic;
  signal p2_cmp_gt : std_ulogic;

begin  -- Rtl

  process (clk_i, reset_n_i)
  begin  -- process
    if reset_n_i = '0' then             -- asynchronous reset (active low)
      p2_gt <= '0';
      p2_fmt <= (to_unsigned(0,2),'0');
      p2_is_add <= '0';
      p2_cy <= '0';
      p2_op_a <= to_unsigned(0,30);
      p2_op_b <= to_unsigned(0,30); 
      p2_clag1 <= (others => ('0','0'));
      p2_clag2 <= (others => ('0','0'));
      p2_complete <= '0';
      p2_cmp_gt <= '0';
      --p2_exp1 <= (others => '0');-- 6Mhz faster design without this reset value
    elsif clk_i'event and clk_i = '1' then  -- rising clock edge
      p2_complete <= start_i;

      if start_i = '1' then
        p2_gt <= p1_gt;
        p2_fmt <= p1_fmt;
        p2_is_add <= p1_is_add;
        p2_cy <= p1_cy;
        p2_op_a <= p1_op_a;
        p2_op_b <= p1_op_b;
        p2_clag1 <= p1_clag1;
        p2_clag2 <= p1_clag2;
        p2_cmp_gt <= p1_cmp_gt;
	p2_exp1 <= p1_exp1;
      end if;
          
    end if;
  end process;
  
  pp: process (cmd_i, p1_clag1, p1_clag2, p1_cy, p1_fmt.exp, p1_gt,
               p1_mant_a(0), p1_mant_a(29 downto 1), p1_mant_b(0),
               p1_mant_b(29 downto 1), p1_op_a, p1_op_b, p2_clag1, p2_exp1,
               p2_exp2, p2_fmt.exp, p2_fmt.sign, p2_is_add, p2_op_a, p2_op_b,
               p2_result(28 downto 0), p2_result(29), p2_sign, regA_i.fmt.exp,
               regA_i.fmt.sign, regA_i.mant, regB_i.fmt.exp, regB_i.fmt.sign,
               regB_i.mant)

  begin  -- process

    --------------------------------------------------------------------------------------------------------------------
    -- stage 1
    --------------------------------------------------------------------------------------------------------------------

    -- check if mantissa of regb > rega
    p1_gt <= '0';
    if regb_i.fmt.exp > rega_i.fmt.exp or (regb_i.fmt.exp = rega_i.fmt.exp and fast_gt(regb_i.mant,rega_i.mant)) then
      p1_gt <= '1';
    end if;

    -- adjust mantissa to be aligned
    if regA_i.fmt.exp < regB_i.fmt.exp then
      p1_fmt.exp <= regB_i.fmt.exp;
    else
      p1_fmt.exp <= regA_i.fmt.exp;
    end if;

    -- determine sign
    if p1_gt = '1' then -- b > a
      -- greater value determines sign; invert sign if b > a and will be substracted
      if cmd_i = QFP_SCMD_SUB then
        p1_fmt.sign <= not regB_i.fmt.sign;
      else
        p1_fmt.sign <= regB_i.fmt.sign;
      end if;      
    else
      p1_fmt.sign <= regA_i.fmt.sign;
    end if;

    -- extend for rounding
    p1_mant_a <= fast_shift(regA_i.mant & '0',to_integer(p1_fmt.exp-regA_i.fmt.exp)*8,'1');
    p1_mant_b <= fast_shift(regB_i.mant & '0',to_integer(p1_fmt.exp-regB_i.fmt.exp)*8,'1');

    -- negate operands for subtraction
    p1_cy <= '0';
    p1_is_add <= '0';
    p1_op_a <= '0' & p1_mant_a(29 downto 1);
    p1_op_b <= '0' & p1_mant_b(29 downto 1);
    if (cmd_i = QFP_SCMD_ADD and (regA_i.fmt.sign xor regB_i.fmt.sign) = '1') or
       (cmd_i = QFP_SCMD_SUB and (regA_i.fmt.sign xor regB_i.fmt.sign) = '0') then   
      -- substraction
      if p1_gt = '1' then
        p1_op_a <= not ('0' & p1_mant_a(29 downto 1));
        p1_cy <= not p1_mant_a(0);-- use rounding
      else
        p1_op_b <= not ('0' & p1_mant_b(29 downto 1));
        p1_cy <= not p1_mant_b(0);-- use rounding
      end if;
    else -- addition
      p1_cy <= p1_mant_a(0) or p1_mant_b(0);-- rounding up
      p1_is_add <= '1';
    end if;

    -- calc greater than b > a
    p1_cmp_gt <= p1_gt;
    if regA_i.fmt.sign /= regB_i.fmt.sign then
      p1_cmp_gt <= regA_i.fmt.sign;
    elsif regA_i.fmt.sign = '1' then
      p1_cmp_gt <= not p1_gt;
    end if;
    
    -- calculate pre carry (first level of carray lookahead adder)
    p1_clag1 <= CLALevelMk(p1_op_a,p1_op_b,4);

    -- second level
    p1_clag2 <= CLALevelMk(p1_clag1,4);
	
    -- expand first level carry
    p1_exp1 <= CLAExpandCy(p1_clag2,p1_cy);
	 
    --------------------------------------------------------------------------------------------------------------------
    -- stage 2
    --------------------------------------------------------------------------------------------------------------------
    
    -- expand second level carry
    p2_exp2 <= CLAExpandCy(p2_clag1,p2_exp1);
    
    -- propagate carry (level 2)
    p2_result <= CLAParallelAdd(p2_op_a,p2_op_b,p2_exp2);

    p2_sign <= p2_fmt.sign;

    result_o.extMant <= p2_result(28 downto 0) & (23 downto 0 => '0');
    result_o.ov <= "0000" & (p2_result(29) and p2_is_add); -- allow overflow only for real additions
    result_o.exp <= '0' & p2_fmt.exp;
    result_o.sign <= p2_sign;-- and not p2_cmp_eq;
    
  end process pp;

  cmp_le_o <= not p2_cmp_gt;-- less equal than

  ready_o <= '1';
  complete_o <= p2_complete;
  
end Rtl;
