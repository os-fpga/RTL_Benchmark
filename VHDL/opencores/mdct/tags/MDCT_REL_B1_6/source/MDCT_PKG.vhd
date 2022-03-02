--------------------------------------------------------------------------------
--                                                                            --
--                          V H D L    F I L E                                --
--                          COPYRIGHT (C) 2006                                --
--                                                                            --
--------------------------------------------------------------------------------
--
-- Title       : MDCT_PKG
-- Design      : MDCT Core
-- Author      : Michal Krepa
--
--------------------------------------------------------------------------------
--
-- File        : MDCT_PKG.VHD
-- Created     : Sat Mar 5 2006
--
--------------------------------------------------------------------------------
--
--  Description : Package for MDCT core
--
--------------------------------------------------------------------------------

library IEEE;
  use IEEE.STD_LOGIC_1164.all;
  use ieee.numeric_std.all;
  
package MDCT_PKG is
    
  constant IP_W                 : INTEGER := 8; 
  constant OP_W                 : INTEGER := 12; 
  constant N                    : INTEGER := 8;
  constant COE_W                : INTEGER := 12;
  constant ROMDATA_W            : INTEGER := COE_W+2;
  constant ROMADDR_W            : INTEGER := 6;
  constant RAMDATA_W            : INTEGER := 10;
  constant RAMADRR_W            : INTEGER := 6;
  constant COL_MAX              : INTEGER := N-1;
  constant ROW_MAX              : INTEGER := N-1;
  constant LEVEL_SHIFT          : INTEGER := 128;
  constant DA_W                 : INTEGER := ROMDATA_W+IP_W;
  constant DA2_W                : INTEGER := DA_W+2;
  -- 2's complement numbers
  constant AP : SIGNED(ROMDATA_W-1 downto 0) := "00" & "010110101000";
  constant BP : SIGNED(ROMDATA_W-1 downto 0) := "00" & "011101100100";
  constant CP : SIGNED(ROMDATA_W-1 downto 0) := "00" & "001100010000";
  constant DP : SIGNED(ROMDATA_W-1 downto 0) := "00" & "011111011001";
  constant EP : SIGNED(ROMDATA_W-1 downto 0) := "00" & "011010100111";
  constant FP : SIGNED(ROMDATA_W-1 downto 0) := "00" & "010001110010";
  constant GP : SIGNED(ROMDATA_W-1 downto 0) := "00" & "000110010000";

  constant AM : SIGNED(ROMDATA_W-1 downto 0) := "11" & "101001011000";
  constant BM : SIGNED(ROMDATA_W-1 downto 0) := "11" & "100010011100";
  constant CM : SIGNED(ROMDATA_W-1 downto 0) := "11" & "110011110000";
  constant DM : SIGNED(ROMDATA_W-1 downto 0) := "11" & "100000100111";
  constant EM : SIGNED(ROMDATA_W-1 downto 0) := "11" & "100101011001";
  constant FM : SIGNED(ROMDATA_W-1 downto 0) := "11" & "101110001110";
  constant GM : SIGNED(ROMDATA_W-1 downto 0) := "11" & "111001110000";

end MDCT_PKG;