-- Copyright (c) 2013 Malte Graeper (mgraep@t-online.de) All rights reserved.

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

use IEEE.std_logic_1164.all;            -- basic logic types
use STD.textio.all;                     -- basic I/O
use IEEE.std_logic_textio.all;          -- I/O for logic types

library work;
use work.cla_p.all;

package qfp_p is
  
  -- support 8 different formates
  type qfp_fmt_t is record
    exp  : unsigned(1 downto 0);
    sign : std_ulogic;
  end record;
  
  type qfp32_t is record
    mant : unsigned(28 downto 0);
    fmt  : qfp_fmt_t;
  end record;

  -- intermediate format (unnormalized)
  type qfp32_raw_t is record
    extMant : unsigned(52 downto 0);-- mant+x
    ov   : unsigned(4 downto 0);
    exp  : unsigned(2 downto 0);
    sign : std_ulogic;
  end record;

  subtype qfp_scmd_t is std_ulogic_vector(1 downto 0);-- sub command

  constant qfp_x0 : unsigned(1 downto 0) := to_unsigned(0,2);
  constant qfp_x8 : unsigned(1 downto 0) := to_unsigned(1,2);
  constant qfp_x16 : unsigned(1 downto 0) := to_unsigned(2,2);
  constant qfp_x24 : unsigned(1 downto 0) := to_unsigned(3,2);

  -- greater than
  function fast_gt (
    a : unsigned;
    b : unsigned)
    return boolean;

  -- add
  function fast_add (
    a : unsigned;
    b : unsigned;
    cy_in : std_ulogic)
    return unsigned;

  constant fast_shift_left : std_ulogic := '0';
  constant fast_shift_rigtht : std_ulogic := '1';

  -- implements a barrel shifter
  function fast_shift (
    data_in : unsigned;
    shft : natural;
    mode  : std_ulogic; -- left=0
    extend : std_ulogic := '0')
    return unsigned;

  function to_ulogic (
    cond : boolean)
    return std_ulogic;

  function min (
    a : unsigned;
    b : unsigned)
    return unsigned;

  function max (
    a : unsigned;
    b : unsigned)
    return unsigned;

  function log2 (
    x : integer)
    return integer;  

end package qfp_p;

package body qfp_p is

   -- greater than a > b SURE
  function fast_gt (
    a : unsigned;
    b : unsigned)
    return boolean is

    variable l1 : cla_level_t((a'length-1)/4 downto 0);
    variable l2 : cla_level_t((a'length-1)/16 downto 0);
    variable l3 : cla_level_t((a'length-1)/32 downto 0);
    variable cy : std_ulogic_vector(l3'length downto 0);-- groupsize+1
    
    variable a_inv : unsigned(a'length-1 downto 0);
    
  begin  -- function fast_gt

    a_inv := not a;
    l1 := CLALevelMk(a_inv,b,4);
    l2 := CLALevelMk(l1,4);
    l3 := CLALevelMk(l2,2);

    cy := CLAExpandCy(l3,'1');

    return cy(cy'length-1) = '0';
    
  end function fast_gt;

  function fast_add (
    a : unsigned;
    b : unsigned;
    cy_in : std_ulogic)
    return unsigned is

    variable l1 : cla_level_t((a'length-1)/4 downto 0);
    variable l2 : cla_level_t((a'length-1)/16 downto 0);
    variable l3 : cla_level_t((a'length-1)/32 downto 0);
    variable cy : std_ulogic_vector(l3'length downto 0);-- groupsize+1
    variable result : unsigned(a'length downto 0);
    
  begin  -- function fast_add

    l1 := CLALevelMk(a,b,4);
    l2 := CLALevelMk(l1,4);
    l3 := CLALevelMk(l2,2);

    cy := CLAExpandCy(l3,cy_in);

    return cy(cy'length-1) & CLAParallelAdd(a,b,CLAExpandCy(l1,CLAExpandCy(l2,cy)));
    
  end function fast_add;

  -- implements a barrel shifter
  function fast_shift (
    data_in : unsigned;
    shft : natural;
    mode  : std_ulogic; -- left=0
    extend : std_ulogic := '0')
    return unsigned is
    
    constant size_lg2 : integer := log2(data_in'length);
   
    variable shft_rem : natural;
    variable data : unsigned(data_in'length-1 downto 0);
  begin  -- fast_shift

    shft_rem := shft;
    
    data := data_in;
    
    for i in size_lg2-1 downto 0 loop
      if shft_rem >= 2**i then
        case mode is
          when '0' => -- shift left
            data := shift_left(data,2**i);
          when '1' => -- shift right 
            data := shift_right(data,2**i);
            -- overwrite top bits with extend
            data(data'length-1 downto (data'length-2**i)) := (others => extend);
          when others => null;
        end case;
        shft_rem := shft_rem-2**i;
      end if;
    end loop;  -- i
    
    return data;
    
  end fast_shift;

  function to_ulogic (
    cond : boolean)
    return std_ulogic is
  begin
    if cond then
      return '1';
    end if;

    return '0';
  end to_ulogic;

  function min (
    a : unsigned;
    b : unsigned)
    return unsigned is
  begin  -- function min
    if a < b then
      return a;
    end if;
    return b;
  end function min;

  function max (
    a : unsigned;
    b : unsigned)
    return unsigned is
  begin  -- function max
    if a > b then
      return a;
    end if;
    return b;
  end function max;

  function log2 (
    x : integer)
    return integer is
    
    variable i : integer;
    variable result : integer;
    
  begin  -- log2
    i := 1;
    result := x-1;
    while result >= 2 loop
      i := i+1;
      result := result/2;
    end loop;
    return i;    
  end log2;

end package body qfp_p;
