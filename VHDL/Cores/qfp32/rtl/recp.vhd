-- Copyright (c) 2013 Malte Graeper (mgraep@t-online.de) All rights reserved.

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library work;
use work.qfp_p.all;

entity qfp32_recp is
  
  port (
    clk_i     : in  std_ulogic;
    reset_n_i : in  std_ulogic;
    
    start_i : in  std_ulogic;
    ready_o : out std_ulogic;
    
    regA_i : in  qfp32_t;
    
    complete_o : out std_ulogic;
    result_o   : out qfp32_raw_t);

end qfp32_recp;

architecture Rtl of qfp32_recp is

  -- r=(1/d)*2^(29)
  -- shifting rem left each time (in loop), the result is effectivly multiplied by 2^(29)
  -- QFPx0: d = v*2^24
  -- QFPx8: d = v*2^16
  -- QFPx16: d = v*2^8
  -- QFPx24: d = v*2^0

  -- instead of shift mant left (if needed, at most 5bits) the dividend "1" is shifted right eg. divided by at most 32
  -- therefore the remainder reg has to be appended with additional 5bits for storing values less than 1
  -- overflow bit is although needed => ov 1bit + mant 29bits + add 5bits

  -- dividend > 1:
  --    1*2^x
  --    rem( >5 ) <= '1'
  
  -- dividend = 1:
  --    1
  --    rem(5) <= '1'
  
  -- dividend < 1:
  --    1*2^-x
  --    rem( <5 ) <= '1'

  -- MOD
  -- generate rounding bit => iterate 30cycles instead
  
  signal p1_mant : unsigned(28 downto 0);
  signal p1_fmt : qfp_fmt_t;
  signal p1_rem : unsigned(34 downto 0);

  signal p2_busy : std_ulogic;
  signal p2_mant : unsigned(28 downto 0);
  signal p2_fmt : qfp_fmt_t;  
  signal p2_rem : unsigned(34 downto 0);
  signal p2_rem_shft : unsigned(34 downto 0);
  signal p2_rem_next : unsigned(34 downto 0);
  
  signal p2_sub : unsigned(29 downto 0);
  signal p2_quo : unsigned(29 downto 0);-- extend by 1 bit for calc rounding bit!!
  signal p2_quo_shft : unsigned(29 downto 0);
  signal p2_quo_next : unsigned(29 downto 0);
  signal p2_cnt : unsigned(4 downto 0);
  signal p2_complete : std_ulogic;
  signal p2_complete_1d : std_ulogic;

begin  -- Rtl

  process (clk_i, reset_n_i)
  begin  -- process
    if reset_n_i = '0' then             -- asynchronous reset (active low)
      p2_busy <= '0';
      p2_rem <= to_unsigned(0,35);
      p2_fmt <= (qfp_x0,'0');
      p2_mant <= to_unsigned(0,29);
      p2_quo <= to_unsigned(0,30);
      p2_cnt <= to_unsigned(0,5);
      p2_complete_1d <= '0';
    elsif clk_i'event and clk_i = '1' then  -- rising clock edge
      p2_complete_1d <= '0';
      if start_i = '1' and p2_busy = '0' then
        p2_rem <= p1_rem;
        p2_fmt <= p1_fmt;
        p2_mant <= p1_mant;
        p2_quo <= to_unsigned(0,30);
        p2_cnt <= to_unsigned(29,5);
        p2_busy <= '1';
      elsif p2_busy = '1' then
        p2_rem <= p2_rem_next;
        p2_quo <= p2_quo_next;
        p2_cnt <= p2_cnt-1;
        if p2_complete = '1' then
          p2_complete_1d <= '1'; 
          p2_busy <= '0';
          -- reset count
          p2_cnt <= to_unsigned(29,5);
        end if;
      end if;
    end if;
  end process;

  process (p1_mant, p2_mant, p2_quo(28 downto 0), p2_quo_shft,
           p2_rem(33 downto 0), p2_rem_shft, p2_rem_shft(34 downto 5), p2_sub,
           p2_sub(29), regA_i.fmt.sign, regA_i.mant, rega_i.fmt.exp)
  begin  -- process

    -- stage 1
    p1_mant <= unsigned(regA_i.mant);

    -- shift dividend and initial reminder correct
    -- so that no other correction is needed at the end division
    p1_fmt <= (qfp_x0,regA_i.fmt.sign);
    p1_rem <= to_unsigned(0,35);
    case rega_i.fmt.exp is
      when qfp_x24 => p1_rem <= to_unsigned(1,35);  -- -5
      when qfp_x16 => p1_rem <= to_unsigned(2**8,35);  -- +3
      when qfp_x8 => p1_rem <= to_unsigned(2**16,35);  -- +11
      when qfp_x0 =>
        if p1_mant <= to_unsigned(2**3,29) then  -- less or equal than 1/2M
          p1_rem <= to_unsigned(1,35); -- -5 
          p1_fmt.exp <= qfp_x24;
        elsif p1_mant <= to_unsigned(2**11,29) then  -- less or equal than 1/32
          p1_rem <= to_unsigned(2**8,35);-- +3
          p1_fmt.exp <= qfp_x16;
        elsif p1_mant <= to_unsigned(2**19,29) then  -- less or equal than 1/8192
          p1_rem <= to_unsigned(2**16,35);-- +11
          p1_fmt.exp <= qfp_x8;
        else
          p1_rem <= to_unsigned(2**24,35);-- +19
          p1_fmt.exp <= qfp_x0;          
        end if;
      when others => null;
    end case;
    
    -- stage 2

    -- shift
    p2_rem_shft <= p2_rem(33 downto 0) & '0';
    p2_quo_shft <= p2_quo(28 downto 0) & '0';
    
    -- use only upper 30bits for sub, cause last 5bits only appended for not shifting mant
    p2_sub <= p2_rem_shft(34 downto 5)-('0' & p2_mant);

    p2_rem_next <= p2_rem_shft;
    p2_quo_next <= p2_quo_shft;

    if p2_sub(29) = '0' then           -- overflow: p2_rem_shft >= p2_mant therefore do sub
      p2_rem_next(34 downto 5) <= p2_sub;
      p2_quo_next(0) <= '1';
    end if;

  end process;

  p2_complete <= '1' when p2_cnt = to_unsigned(0,5) else '0';

  ready_o <= not p2_busy;
  result_o <= (p2_quo(29 downto 1) & '0' & (22 downto 0 => '0'),to_unsigned(0,5),'0' & p2_fmt.exp,p2_fmt.sign);
  complete_o <= p2_complete_1d;
  
end Rtl;

