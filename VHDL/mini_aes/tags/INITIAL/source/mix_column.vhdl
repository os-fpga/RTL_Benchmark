-- $Id: mix_column.vhdl,v 1.1.1.1 2005-12-06 02:48:33 arif_endro Exp $
-------------------------------------------------------------------------------
-- Title       :
-- Project     : Mini AES 128 
-------------------------------------------------------------------------------
-- File        :
-- Author      : "Arif E. Nugroho" <arif_endro@yahoo.com>
-- Created     : 2005/12/03
-- Last update : 
-- Simulators  : ModelSim SE PLUS 6.0
-- Synthesizers: ISE Xilinx 6.3i
-- Target      : 
-------------------------------------------------------------------------------
-- Description : 
-------------------------------------------------------------------------------
-- Copyright (C) 2005 Arif E. Nugroho
-- This VHDL design file is an open design; you can redistribute it and/or
-- modify it and/or implement it after contacting the author
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- 
--         THIS SOURCE FILE MAY BE USED AND DISTRIBUTED WITHOUT RESTRICTION
-- PROVIDED THAT THIS COPYRIGHT STATEMENT IS NOT REMOVED FROM THE FILE AND THAT
-- ANY DERIVATIVE WORK CONTAINS THE ORIGINAL COPYRIGHT NOTICE AND THE
-- ASSOCIATED DISCLAIMER.
-- 
-------------------------------------------------------------------------------
-- 
--         THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
-- IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
-- MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO
-- EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
-- SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
-- PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
-- OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
-- WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
-- OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
-- ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
-- 
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use work.xtime_pkg.all;

entity mix_column is

  port (
    s0          : in  std_logic_vector (07 downto 00);
    s1          : in  std_logic_vector (07 downto 00);
    s2          : in  std_logic_vector (07 downto 00);
    s3          : in  std_logic_vector (07 downto 00);
    mix_col     : out std_logic_vector (31 downto 00);
    inv_mix_col : out std_logic_vector (31 downto 00)
    );

end mix_column;

architecture data_flow of mix_column is

  type state is array (03 downto 00) of std_logic_vector (07 downto 00);

  signal mc : state :=
    ( X"00", X"00", X"00", X"00" );

begin

  --
  -- MixColumn   : a(x)  = {03}x^3 + {01}x^2 + {01}x + {02}
  --
  -- s'0c = | 02 03 01 01 | s0c
  -- s'1c = | 01 02 03 01 | s1c
  -- s'2c = | 01 01 02 03 | s2c
  -- s'3c = | 03 01 01 02 | s3c
  --
  -- InvMixColumn: a'(x) = {0B}x^3 + {0D}x^2 + {09}x + {0E}
  --               a'(x) = {03}x^3 + {01}x^2 + {01}x + {02} +
  --                       {08}x^3 + {08}x^2 + {08}x + {08} +
  --                                 {04}x^2 + {04}x
  --  a(x) * a'(x)     = {01}
  --  a(x) * {a'(x)}^2 = {01} * a'(x) = a'(x)
  --         {a'(x)}^2 = {04}x^2 + {05}
  --
  --              | 05 00 04 00 |          | 0E 0B 0D 09 |   E = 14 = 1110 = 8 xor 4 xor 2 = 1000 xor 0100 xor 0010
  --  {a'(x)}^2 = | 00 05 00 04 |  a'(x) = | 09 0E 0B 0D |   D = 13 = 1101 = 8 xor 4 xor 1 = 1000 xor 0100 xor 0001
  --              | 04 00 05 00 |          | 0D 09 0E 0B |   B = 11 = 1011 = 8 xor 2 xor 1 = 1000 xor 0010 xor 0001
  --              | 00 04 00 05 |          | 0B 0D 09 0E |   9 = 09 = 1001 = 8 xor 0 xor 1 = 1000 xor 0000 xor 0001
  --

  mc (3) <= xtime_2(s0) xor xtime_2(s1) xor s1 xor s2 xor s3;
  mc (2) <= s0 xor xtime_2(s1) xor xtime_2(s2) xor s2 xor s3;
  mc (1) <= s0 xor s1 xor xtime_2(s2) xor xtime_2(s3) xor s3;
  mc (0) <= xtime_2(s0) xor s0 xor s1 xor s2 xor xtime_2(s3);
--
  mix_col <= (mc(3) & mc(2) & mc(1) & mc(0));
-- 
  inv_mix_col (31 downto 24) <= xtime_4(mc(3)) xor mc(3) xor xtime_4(mc(1));
  inv_mix_col (23 downto 16) <= xtime_4(mc(2)) xor mc(2) xor xtime_4(mc(0));
  inv_mix_col (15 downto 08) <= xtime_4(mc(1)) xor mc(1) xor xtime_4(mc(3));
  inv_mix_col (07 downto 00) <= xtime_4(mc(0)) xor mc(0) xor xtime_4(mc(2));
--
--   inv_mix_col (31 downto 24) <= 
--                                 xtime_8(mc(3)) xor xtime_4(mc(3)) xor xtime_2(mc(3)) xor 
--                                 xtime_8(mc(2)) xor xtime_2(mc(2)) xor mc(2) xor
--                                 xtime_8(mc(1)) xor xtime_4(mc(1)) xor mc(1) xor
--                                 xtime_8(mc(0)) xor mc(0);
--   inv_mix_col (23 downto 16) <= 
--                                 xtime_8(mc(3)) xor mc(3) xor
--                                 xtime_8(mc(2)) xor xtime_4(mc(2)) xor xtime_2(mc(2)) xor 
--                                 xtime_8(mc(1)) xor xtime_2(mc(1)) xor mc(1) xor
--                                 xtime_8(mc(0)) xor xtime_4(mc(0)) xor mc(0);
--   inv_mix_col (15 downto 08) <= 
--                                 xtime_8(mc(3)) xor xtime_4(mc(3)) xor mc(3) xor
--                                 xtime_8(mc(2)) xor mc(2) xor
--                                 xtime_8(mc(1)) xor xtime_4(mc(1)) xor xtime_2(mc(1)) xor 
--                                 xtime_8(mc(0)) xor xtime_2(mc(0)) xor mc(0);
--   inv_mix_col (07 downto 00) <= 
--                                 xtime_8(mc(3)) xor xtime_2(mc(3)) xor mc(3) xor
--                                 xtime_8(mc(2)) xor xtime_4(mc(2)) xor mc(2) xor
--                                 xtime_8(mc(1)) xor mc(1) xor
--                                 xtime_8(mc(0)) xor xtime_4(mc(0)) xor xtime_2(mc(0));

end data_flow;
