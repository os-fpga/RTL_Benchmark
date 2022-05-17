-- Copyright (c) 2013 Malte Graeper (mgraep@t-online.de) All rights reserved.

-------------------------------------------------------------------------------
-- Carry lookahead adder library
-- provides all functions for making carry lookahead adder of
-- arbitary deepth and width
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

package cla_p is

  type cla_group_t is record
          pro    : std_ulogic;
          gen    : std_ulogic;
  end record;

  type cla_level_t is array (natural range <>) of cla_group_t;

  function CLAGroupMk (
    a : unsigned;
    b : unsigned)
    return cla_group_t;

  function CLAGroupMk (
    level : cla_level_t)
    return cla_group_t;

  function CLALevelMk (
    a : unsigned;
    b : unsigned;
    group_size : natural)
    return cla_level_t;

  function CLALevelMk (
    level : cla_level_t;
    group_size : natural)
    return cla_level_t;
     
  -- purpose: propagates carry through groups and returns expanded carry vector
  function CLAExpandCy (
    level : cla_level_t;
    cy_in : std_ulogic)
    return std_ulogic_vector;
    
  function CLAExpandCy (
    level : cla_level_t;
    cy_in  : std_ulogic_vector)
    return std_ulogic_vector;
  
  -- purpose: adds vector a and b with using carry information from groups
  function CLAParallelAdd (
    a : unsigned;
    b : unsigned;
    cy_in : std_ulogic_vector)
    return unsigned;

end cla_p;

package body cla_p is

  function min(
    a : natural;
    b : natural)
    return natural is
  begin
    if a > b then
      return b;
    else 
      return a;
    end if;
  end min;
  
  function CLAGroupMk (
    a : unsigned;
    b : unsigned)
    return cla_group_t is

    variable gen : std_ulogic;
    variable pro : std_ulogic;
  begin
    gen := '0';
    pro := '1';
    for i in a'length-1 downto 0 loop
      gen := (a(i) and b(i) and pro) or gen;
      pro := (a(i) or b(i)) and pro;    
    end loop;
    return (pro,gen);
  end CLAGroupMk;

  function CLAGroupMk (
    level : cla_level_t)
    return cla_group_t is

    variable gen : std_ulogic;
    variable pro : std_ulogic;
  begin
    gen := '0';
    pro := '1';
    for i in level'length-1 downto 0 loop
      -- calc propagate/generate
      gen := (level(i).gen  and pro) or gen;
      pro := level(i).pro and pro;
    end loop;
    return (pro,gen);
  end CLAGroupMk;
  
  function CLALevelMk (
    a : unsigned;
    b : unsigned;
    group_size : natural)
    return cla_level_t is

    variable lb,ub : natural;
    variable slice_a,slice_b : unsigned(group_size-1 downto 0);
    variable level : cla_level_t((a'length-1)/group_size downto 0);
  begin
    for i in 0 to (a'length-1)/group_size loop
      lb := i*group_size;
      ub := min(lb+group_size,a'length)-1;
      slice_a(ub-lb downto 0) := a(ub downto lb);
      slice_b(ub-lb downto 0) := b(ub downto lb);
      level(i) := CLAGroupMk(slice_a(ub-lb downto 0),slice_b(ub-lb downto 0));
   end loop;
    
   return level;
  end CLALevelMk;
  
  function CLALevelMk (
    level : cla_level_t;
    group_size : natural)
    return cla_level_t is

    variable lb,ub : natural;
    variable slice : cla_level_t(group_size-1 downto 0);
    variable level_out : cla_level_t((level'length-1)/group_size downto 0);
  begin
    for i in 0 to (level'length-1)/group_size loop
      lb := i*group_size;
      ub := min(lb+group_size,level'length)-1;
      slice(ub-lb downto 0) := level(ub downto lb);
      level_out(i) := CLAGroupMk(slice(ub-lb downto 0));
    end loop;   
    return level_out;
  end CLALevelMk;

  -- purpose: propagates carry through group and returns expanded carry vector
  function CLAExpandCy (
    level : cla_level_t;
    cy_in  : std_ulogic)
    return std_ulogic_vector is
    
    variable cy : std_ulogic;
    variable cy_out : std_ulogic_vector(level'length downto 0);
  begin  -- CLAExpandCy
    cy := cy_in;     
    cy_out(0) := cy;
    for i in 0 to level'length-1 loop
      cy := level(i).gen or (level(i).pro and cy);
      cy_out(i+1) := cy;
    end loop;  -- i     
    return cy_out;     
  end CLAExpandCy;

  -- purpose: propagates carry through each group (maybe more than one) and returns expanded carry vector
  function CLAExpandCy (
    level : cla_level_t;
    cy_in  : std_ulogic_vector)
    return std_ulogic_vector is
    
    constant group_size : natural := 1+(level'length-1)/(cy_in'length-1);  -- length cy_in = number of groups+1          
    variable ub,lb : natural;
    variable slice : cla_level_t(group_size-1 downto 0);
    variable cy_out : std_ulogic_vector(level'length downto 0);
  begin  -- CLAExpandCy  
    cy_out(cy_out'length-1) := cy_in(cy_in'length-1);
    for i in 0 to (level'length-1)/group_size loop
      lb := i*group_size;
      ub := min(lb+group_size,level'length)-1;
      slice(ub-lb downto 0) := level(ub downto lb);
      cy_out(ub downto lb) := CLAExpandCy(slice(ub-lb downto 0),cy_in(i))(ub-lb downto 0);
    end loop;      
    return cy_out;     
  end CLAExpandCy;  
  
  -- purpose: adds vector a and b with using carry information from groups
  function CLAParallelAdd (
    a : unsigned;
    b : unsigned;
    cy_in : std_ulogic_vector)
    return unsigned is
     
    constant adder_size : integer := 1+(a'length-1)/(cy_in'length-1);     
    variable lb,ub : natural;
    variable result : unsigned(a'length-1 downto 0);
    variable cy_vec : std_ulogic_vector(adder_size-1 downto 0) := (others => '0');
  begin  -- CLAParallelAdd
    result := to_unsigned(0,result'length);
    
    for i in 0 to (a'length-1)/adder_size loop
      lb := i*adder_size;
      ub := min(lb+adder_size,a'length)-1;
      cy_vec(0) := cy_in(i);
      result(ub downto lb) := a(ub downto lb)+b(ub downto lb)+unsigned(cy_vec(ub-lb downto 0));
    end loop;  -- i     
    return result;
  end CLAParallelAdd;

end package body cla_p;
