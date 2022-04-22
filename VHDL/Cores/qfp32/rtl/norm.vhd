-- Copyright (c) 2013 Malte Graeper (mgraep@t-online.de) All rights reserved.

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library work;
use work.qfp_p.all;

package qfp32_norm_p is

  type raw_norm_t is record
    zero     : std_ulogic;
    err      : std_ulogic;
    mant     : unsigned(28 downto 0);
    exp      : unsigned(2 downto 0);
    rounding : std_ulogic;
  end record raw_norm_t;

  function normMant (
    raw : unsigned; -- raw mantissa (unnormalized mant + block*(steps-1)
    exp : unsigned;
    dont_shft : std_ulogic)
    return raw_norm_t;
  
end package qfp32_norm_p;

package body qfp32_norm_p is

  function normMant (
    raw : unsigned; -- raw format: ov (n-bits) | mant | shifted in m=(steps-1)*block bits
    exp : unsigned; -- exponent: min=0 max=2*k-2
    dont_shft : std_ulogic)
    return raw_norm_t is

    constant blockSize : natural := 8;
    constant numBlocks : natural := 4;
    constant mantSize : natural := 29;
    constant mantRestSize : natural := mantSize-((numBlocks-1)*blockSize);  -- 5                                                                      

    variable ov : std_ulogic;
    variable zero : std_ulogic_vector(numBlocks-2 downto 0);
    variable norm : unsigned(mantSize downto 0);
    variable slice : natural;
    variable shft : unsigned(log2(numBlocks)-1 downto 0);
    variable mant_zero : std_ulogic_vector(numBlocks-1 downto 0);
    variable full_mant_zero : std_ulogic;
  begin
    
    zero := (others => '0');
    -- check which blocks are zero
    for i in 0 to numBlocks-2 loop
      slice := raw'length-i*blockSize;
      if raw(slice-1 downto slice-blockSize) = to_unsigned(0,blockSize) then
        zero(i) := '1';
      end if;
    end loop;  -- i

    -- check if mant is zero
    -- mant depends on shft value but all top block must be zero
    -- select correct block from mant_zero by using shft    
    mant_zero := (others => '0');
    if zero = (numBlocks-2 downto 0 => '1') then
      for i in 0 to numBlocks-1 loop
        if raw(mantSize-1 downto mantSize-mantRestSize-8*i) = to_unsigned(0,mantRestSize+i*8) then
          mant_zero(i) := '1';
        end if;
      end loop;  -- i
    end if;
    
    -- calc shift
    shft := to_unsigned(0,log2(numBlocks));
    for i in 0 to numBlocks-2 loop
      if zero(i) = '0' or exp = i  then
        exit; -- break
      end if;
      shft := shft+1;
    end loop;  -- i

    -- check for format overflow
    ov := '0';
    if exp > numBlocks-1 then -- possible overflow
      for i in numBlocks to (numBlocks-1)*2 loop  
        if zero(i-numBlocks) = '0' and exp >= i then
          ov := '1';
        end if;
      end loop;  -- i      
    end if;

    -- make sure we dont shift if not allowed
    if dont_shft = '1' then
      shft := to_unsigned(0,shft'length);
      ov := to_ulogic(exp > blockSize-1);
    end if;

    norm := fast_shift(raw,to_integer(shft)*blockSize,fast_shift_left,'0')(raw'length-1 downto raw'length-mantSize-1);

    return (mant_zero(to_integer(shft)),ov,norm(mantSize downto 1),exp-shft,norm(0));
    
  end function;
  
end package body qfp32_norm_p;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library work;
use work.qfp_p.all;
use work.qfp32_norm_p.all;

entity qfp_norm is
  
  port (
    clk_i      : in  std_ulogic;
    reset_n_i  : in  std_ulogic;
    
    -- raw interface
    raw_i      : in  qfp32_raw_t;

    -- result
    result_o : out qfp32_t;
    result_zero_o : out std_ulogic);

end entity qfp_norm;

architecture Rtl of qfp_norm is

  signal is_ext : std_ulogic;
  signal err : std_ulogic;
  signal mant : unsigned(28 downto 0);
  signal full_mant : unsigned(33 downto 0);
  signal exp : unsigned(2 downto 0);
  signal rounding : std_ulogic;
  signal rd_mant : unsigned(34 downto 0);
  signal rounding_err : std_ulogic;
  --signal rd_add : unsigned(33 downto 0);
  signal zero : std_ulogic;
  
  signal norm : raw_norm_t;
  
begin  -- architecture Rtl

  process (err, exp, exp(1 downto 0), full_mant, full_mant(28 downto 0),
           full_mant(33 downto 8), is_ext, mant, raw_i.exp, raw_i.extMant,
           raw_i.ov, raw_i.sign, rd_mant(29), rounding_err, zero)
  begin  -- process

    is_ext <= '0';
    if raw_i.ov /= to_unsigned(0,5) then
      is_ext <= '1';
    end if;
    
    -- <<
    (zero,err,mant,exp,rounding) <= normMant(raw_i.extMant,raw_i.exp,is_ext);

    full_mant <= raw_i.ov & mant;

    -- round
    rd_mant <= '0' & full_mant;
    --if enableRounding and rounding = '1' then
    --  if is_ext = '0' then
    --    rd_add <= to_unsigned(1,34);
    --  else
    --    rd_add <= to_unsigned(256,34);
    --  end if;
      
    --  rd_mant <= fast_add(full_mant,rd_add,'0');
    --end if;

    rounding_err <= '0';

    -- check if fmt must be shifted right >>
    if rd_mant(29) = '1' or is_ext = '1' then-- overflow to next fmt cause of rounding
      if exp >= 3 then
        rounding_err <= '1';
      end if;      
    end if;

    -- if value is zero => sign must be 0
    result_o.fmt.sign <= raw_i.sign;
    if zero = '1' and is_ext = '0' then
      result_o.fmt.sign <= '0';
    end if;
    
    -- shift >> or select overflow
    result_o.fmt.exp <= to_unsigned(3,2);
    result_o.mant <= to_unsigned(2**29-1,29);  
    if rounding_err = '0' and err = '0' then
      if rd_mant(29) = '0' and is_ext = '0' then
        result_o.mant <= full_mant(28 downto 0);
        result_o.fmt.exp <= exp(1 downto 0);
      else
        result_o.mant <= "000" & full_mant(33 downto 8);
        result_o.fmt.exp <= exp(1 downto 0)+to_unsigned(1,2);
      end if;
    end if;
    
  end process;

  result_zero_o <= zero and not is_ext;
  
end architecture Rtl;
