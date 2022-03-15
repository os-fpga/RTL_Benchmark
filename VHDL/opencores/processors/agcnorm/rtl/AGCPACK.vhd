--	Package File Template
--
--	Purpose: This package defines supplemental types, subtypes, 
--		 constants, and functions 

library IEEE;
use IEEE.STD_LOGIC_1164.all;

package AGCPACK is

  subtype AGCBIT is std_logic;
  
  subtype AGCBITARRAY is std_logic_vector;
  
  constant \0VDCA\ : AGCBIT := '0';

  subtype  VGA_COLOUR  is std_logic_vector( 2 downto 0 ); -- "RGB"
  
  -- --------------------------------- "RGB"
  constant VGA_CBLACK   : VGA_COLOUR := "000";
  constant VGA_CRED     : VGA_COLOUR := "100";
  constant VGA_CGREEN   : VGA_COLOUR := "010";
  constant VGA_CBLUE    : VGA_COLOUR := "001";
  constant VGA_CYELLOW  : VGA_COLOUR := "110";
  constant VGA_CMAGENTA : VGA_COLOUR := "101";
  constant VGA_CCYAN    : VGA_COLOUR := "011";
  constant VGA_CWHITE   : VGA_COLOUR := "111";
  
  constant DEBUG_X_MIN : integer :=  0;
  constant DEBUG_X_MAX : integer := 39;
  constant DEBUG_Y_MIN : integer :=  0;
  constant DEBUG_Y_MAX : integer := 29;
  
  type t_debug is array( DEBUG_X_MIN to DEBUG_X_MAX, DEBUG_Y_MIN to DEBUG_Y_MAX ) of AGCBIT;
  
  type d_debug is array( 0 to 15 ) of AGCBITARRAY( 11 downto 1 );
  
end AGCPACK;

