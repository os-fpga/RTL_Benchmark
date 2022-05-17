-- Copyright (c) 2013 Malte Graeper (mgraep@t-online.de) All rights reserved.

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

package qfp32_divider_p is

  function zero_blocks (
    data : unsigned;
    block_size : integer)
    return std_ulogic_vector;

end package qfp32_divider_p;

package body qfp32_divider_p is

  function zero_blocks (
    data : unsigned;
    block_size : integer)
    return std_ulogic_vector is

    constant max_blocks : integer := data'length/block_size;
    variable data_zero : std_ulogic_vector(max_blocks-1 downto 0);
    variable data_downto : unsigned(data'length-1 downto 0);
    
  begin

    -- workaround for slice problems
    -- if parameter is unsigned with std_ulogic_vector concat there are
    -- problems => use to_unsigned instead of std_ulogic_vector
    data_downto := data;
    
    data_zero := (others => '0');
    for i in 0 to max_blocks-1 loop
      if data_downto(data'length-1 downto data'length-(i+1)*block_size) = to_unsigned(0,(i+1)*block_size) then
        data_zero(i) := '1';        
      end if;      
    end loop;  -- i

    return data_zero;
  end zero_blocks;    

end package body qfp32_divider_p;


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library work;
use work.qfp_p.all;
use work.qfp32_divider_p.all;

entity qfp32_divider is
  
  port (
    clk_i     : in  std_ulogic;
    reset_n_i : in  std_ulogic;
    
    start_i : in  std_ulogic;
    ready_o : out std_ulogic;
    
    regA_i : in  qfp32_t;
    regB_i : in  qfp32_t;
    
    complete_o : out std_ulogic;
    result_o   : out qfp32_raw_t);

end qfp32_divider;

architecture Rtl of qfp32_divider is

  -- r=(1/d)*2^(29)
  -- shifting rem left each time (in loop), the result is effectivly multiplied by 2^(29)
  -- QFPx0: d = v*2^24
  -- QFPx8: d = v*2^16
  -- QFPx16: d = v*2^8
  -- QFPx24: d = v*2^0

  signal start_1d : std_ulogic;

  signal p1_divisor_mant : unsigned(28 downto 0);
  signal p1_dividend_mant : unsigned(28 downto 0);
  signal p1_divisor_zero : std_ulogic_vector(3 downto 0);
  signal p1_allowed_dividend_shift : unsigned(1 downto 0);
  -- if the msb of divisor is set, the possible additional shift cannot happen because
  -- the condition 'dividend_top_bits >= 2*divisor_top_bits can never be
  -- fullfilled (both vectors are 29 bits) therefore if an additional shift happens
  -- at most the 28th bit of divisor is set and shifted by 8 eg 36bits is enough
  signal p1_divisor : unsigned(35 downto 0); -- 28+8 buffer for shifting
  signal p1_dividend : unsigned(32 downto 0); -- 29+4
  signal p1_exp : unsigned(2 downto 0);
  signal p1_delta_exp : unsigned(2 downto 0);
  signal p1_adjust_divisor : unsigned(1 downto 0);
  signal p1_adjust_divisor_final : unsigned(2 downto 0);
  signal p1_adjust_dividend : unsigned(1 downto 0);
  signal p1_top_bits : unsigned(7 downto 0);
  signal p1_sign : std_ulogic;
  signal p1_exp_ov : std_ulogic; -- if p1_exp_sum > 7 => result will be maximum 
  signal p1_exp_sum : unsigned(3 downto 0);
  signal p1_rem : unsigned(41 downto 0); -- +1 bit for shift buffer, +5 for division correction, +2 to make size after division correction same as divisor
  signal p1_div_by_zero : std_ulogic;

  signal p2_busy : std_ulogic;
  signal p2_divisor : unsigned(35 downto 0);
  signal p2_exp : unsigned(2 downto 0);
  signal p2_exp_ov : std_ulogic;
  signal p2_exp_adjusted : unsigned(2 downto 0);
  signal p2_sign : std_ulogic;
  signal p2_rem : unsigned(41 downto 0);
  signal p2_rem_shft : unsigned(41 downto 0);
  signal p2_rem_next : unsigned(41 downto 0);
  
  signal p2_sub : unsigned(36 downto 0);
  signal p2_quo : unsigned(28 downto 0); -- extend for rounding bit calculation!!
  signal p2_quo_adjusted : unsigned(36 downto 0);
  signal p2_quo_shft : unsigned(28 downto 0);
  signal p2_quo_next : unsigned(28 downto 0);
  signal p2_cnt : unsigned(4 downto 0);
  signal p2_complete : std_ulogic;
  signal p2_complete_1d : std_ulogic;

begin  -- Rtl

  process (clk_i, reset_n_i)
  begin  -- process
    if reset_n_i = '0' then             -- asynchronous reset (active low)
      start_1d <= '0';
      p2_busy <= '0';
      p2_rem <= to_unsigned(0,42);
      p2_exp <= to_unsigned(0,3);
      p2_exp_ov <= '0'; 
      p2_sign <= '0';
      p2_divisor <= to_unsigned(0,36);
      p2_quo <= to_unsigned(0,29);
      p2_cnt <= to_unsigned(0,5);
      p2_complete_1d <= '0';
    elsif clk_i'event and clk_i = '1' then  -- rising clock edge

      start_1d <= '0';
      if start_i = '1' and p2_busy = '0' then
        start_1d <= '1';
      end if;
      
      p2_complete_1d <= '0';
      if start_1d = '1' then
        p2_rem <= p1_rem;
        p2_exp <= p1_exp;
        p2_exp_ov <= p1_exp_ov;
        p2_sign <= p1_sign;
        p2_divisor <= p1_divisor;
        p2_quo <= to_unsigned(0,29);
        p2_cnt <= to_unsigned(28,5);
        p2_busy <= '1';
      elsif p2_busy = '1' then
        p2_rem <= p2_rem_next;
        p2_quo <= p2_quo_next;
        p2_cnt <= p2_cnt-1;
        if p2_complete = '1' then
          p2_complete_1d <= '1'; 
          p2_busy <= '0';
          -- reset count
          p2_cnt <= to_unsigned(28,5);
        end if;
      end if;
    end if;
  end process;

  process (p1_adjust_dividend, p1_adjust_divisor, p1_adjust_divisor_final,
           p1_allowed_dividend_shift, p1_delta_exp, p1_div_by_zero,
           p1_dividend, p1_dividend(32 downto 25), p1_dividend_mant,
           p1_divisor_mant, p1_divisor_mant(12 downto 5),
           p1_divisor_mant(20 downto 13), p1_divisor_mant(28 downto 21),
           p1_divisor_mant(4 downto 0), p1_divisor_zero(0),
           p1_divisor_zero(1 downto 0), p1_divisor_zero(1),
           p1_divisor_zero(2 downto 1), p1_divisor_zero(2),
           p1_divisor_zero(3 downto 2), p1_divisor_zero(3), p1_exp_sum,
           p1_exp_sum(2 downto 0), p1_top_bits, p2_divisor(35 downto 0),
           p2_exp, p2_quo(27 downto 0), p2_quo(28 downto 0), p2_quo_shft,
           p2_rem(40 downto 0), p2_rem_shft, p2_rem_shft(41 downto 5),
           p2_sub(35 downto 0), p2_sub(36), regA_i.fmt.exp, regA_i.fmt.sign,
           regA_i.mant, regB_i.fmt.exp, regB_i.fmt.sign, regB_i.mant)
  begin  -- process

    -- stage 1

    p1_dividend_mant <= regA_i.mant;
    p1_divisor_mant <= regB_i.mant;

    p1_divisor_zero <= zero_blocks(p1_divisor_mant & to_unsigned(0,3),8);
   -- p1_dividend_zero <= zero_blocks(p1_dividend_mant,8);

    p1_delta_exp <= to_unsigned(3,3)+('0' & regA_i.fmt.exp)-('0' & regB_i.fmt.exp);

    -- determine maximum allowed left shift of dividend
    p1_allowed_dividend_shift <= to_unsigned(0,2);

    if p1_divisor_zero(1 downto 0) = "01" or p1_delta_exp = to_unsigned(4,3) then
      p1_allowed_dividend_shift <= to_unsigned(1,2);
    elsif p1_divisor_zero(2 downto 1) = "01" or p1_delta_exp = to_unsigned(5,3) then
      p1_allowed_dividend_shift <= to_unsigned(2,2);
    elsif p1_divisor_zero(3 downto 2) = "01" or p1_delta_exp = to_unsigned(6,3) then
      p1_allowed_dividend_shift <= to_unsigned(3,2);
    end if;

    -- adjust dividend
    p1_adjust_dividend <= to_unsigned(0,2);

    if p1_dividend_mant < to_unsigned(2**25,29) and p1_allowed_dividend_shift > to_unsigned(0,2) then 
      if p1_dividend_mant >= to_unsigned(2**17,29) or p1_allowed_dividend_shift = to_unsigned(1,3) then
        p1_adjust_dividend <= to_unsigned(1,2);
      elsif p1_dividend_mant >= to_unsigned(2**9,29) or p1_allowed_dividend_shift = to_unsigned(2,3) then
        p1_adjust_dividend <= to_unsigned(2,2);
      elsif p1_dividend_mant >= to_unsigned(2**1,29) or p1_allowed_dividend_shift = to_unsigned(3,2) then
        p1_adjust_dividend <= to_unsigned(3,2);
      end if;
    end if;

    p1_dividend <= fast_shift(to_unsigned(0,4) & p1_dividend_mant,to_integer(p1_adjust_dividend)*8,fast_shift_left); -- extend with 4bits 

    -- adjust divisor so that divisor >= dividend (when possible)
    p1_div_by_zero <= '0';
    p1_adjust_divisor <= to_unsigned(0,2);
    p1_top_bits <= p1_divisor_mant(28 downto 21);    
      
    if p1_divisor_zero(0) = '1' then
      if p1_divisor_zero(1) = '0' then
        p1_top_bits <= p1_divisor_mant(20 downto 13);
        p1_adjust_divisor <= to_unsigned(1,2);
      elsif p1_divisor_zero(2) = '0' then
        p1_top_bits <= p1_divisor_mant(12 downto 5);
        p1_adjust_divisor <= to_unsigned(2,2);
      elsif p1_divisor_zero(3) = '0' then
        p1_top_bits <= p1_divisor_mant(4 downto 0) & "000";
        p1_adjust_divisor <= to_unsigned(3,2);
      else
        p1_div_by_zero <= '1';
      end if;
    end if;

    -- because dividend will be shifted right by 5 and left by 1 (= shifted right by 4) before division, only the
    -- top 4 bits are used for extra shift determination; p1_top_bits will be
    -- shifted left by 1 cause only most significant bit position must be same; some example
    -- dividend: XXXXXAAA
    -- divisor:  BBBBBBBB
    -- msb position counts eg
    -- XXXXX111
    -- 00000100
    -- is a valid combination therefore the <= operator is not enough
    
    p1_adjust_divisor_final <= '0' & p1_adjust_divisor;
    if ('0' & p1_dividend(32 downto 25)) >= (p1_top_bits & '0') then
      p1_adjust_divisor_final <= ('0' & p1_adjust_divisor)+1;
    end if;

    p1_divisor <= fast_shift(to_unsigned(0,7) & p1_divisor_mant,to_integer(p1_adjust_divisor_final)*8,fast_shift_left); -- 8bit overhead for shifting left

    -- build resulting fmt
    p1_sign <= regA_i.fmt.sign xor regB_i.fmt.sign;

    p1_exp_sum <= ('0' & p1_delta_exp)-('0' & p1_adjust_dividend)+('0' & p1_adjust_divisor_final);

    p1_exp_ov <= '0';
    p1_exp <= to_unsigned(7,3);
    if p1_div_by_zero = '1' or p1_exp_sum >= to_unsigned(8,4) then
      p1_exp_ov <= '1';
    else
      p1_exp <= p1_exp_sum(2 downto 0);
    end if;

    p1_rem <= "000000000" & p1_dividend;

    -- stage 2

    -- shift
    p2_rem_shft <= p2_rem(40 downto 0) & '0';
    p2_quo_shft <= p2_quo(27 downto 0) & '0';

    -- situation when rem and divisor have same msb position but rem is still greater
    -- therefore the 41th of p2_rem_shft is mostly zero but in the case above
    -- it will '1' and p2_divisor is less (always has a '0' at this position, see below)
    p2_sub <= p2_rem_shft(41 downto 5)-('0' & p2_divisor(35 downto 0));

    p2_rem_next <= p2_rem_shft;
    p2_quo_next <= p2_quo_shft;

    -- check for sub overflow eg. p2_rem_shft >= p2_divisor
    if p2_sub(36) = '0' then -- no overflow: therefore do sub
      p2_rem_next(41 downto 5) <= '0' & p2_sub(35 downto 0);
      p2_quo_next(0) <= '1';
    end if;

    -- if exp > 3 normalize cannot correct it full therefore pre shift left (but loosing precision)
    p2_exp_adjusted <= p2_exp;
    p2_quo_adjusted <= "00000000" & p2_quo(28 downto 0);

    if p2_exp >= to_unsigned(4,3) then
      p2_exp_adjusted <= p2_exp-1;
      p2_quo_adjusted <= p2_quo(28 downto 0) & "00000000";
    end if;

  end process;

  p2_complete <= '1' when p2_cnt = to_unsigned(0,5) else '0';

  ready_o <= not p2_busy and not start_1d;
  result_o <= ((15 downto 0 => '0') & p2_quo_adjusted,to_unsigned(0,4) & p2_exp_ov,p2_exp_adjusted,p2_sign);
  complete_o <= p2_complete_1d;
  
end Rtl;

