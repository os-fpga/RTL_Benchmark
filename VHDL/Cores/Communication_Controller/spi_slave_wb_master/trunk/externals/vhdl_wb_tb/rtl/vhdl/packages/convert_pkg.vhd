---------------------------------------------------------------------- 
----                                                              ---- 
----  VHDL Wishbone TESTBENCH                                     ---- 
----                                                              ---- 
----  This file is part of the vhdl_wb_tb project                 ---- 
----  http://www.opencores.org/cores/vhdl_wb_tb/                  ---- 
----                                                              ---- 
----  This file contains some type conversion functions.          ----
----                                                              ---- 
----  To Do:                                                      ---- 
----   -                                                          ---- 
----                                                              ---- 
----  Author(s):                                                  ---- 
----      - Sinx, sinx@opencores.org                              ---- 
----                                                              ---- 
---------------------------------------------------------------------- 
----    SVN information
----
----      $URL:  $
---- $Revision:  $
----     $Date:  $
----   $Author:  $
----       $Id:  $
---------------------------------------------------------------------- 
----                                                              ---- 
---- Copyright (C) 2018 Authors and OPENCORES.ORG                 ---- 
----                                                              ---- 
---- This source file may be used and distributed without         ---- 
---- restriction provided that this copyright statement is not    ---- 
---- removed from the file and that any derivative work contains  ---- 
---- the original copyright notice and the associated disclaimer. ---- 
----                                                              ---- 
---- This source file is free software; you can redistribute it   ---- 
---- and/or modify it under the terms of the GNU Lesser General   ---- 
---- Public License as published by the Free Software Foundation; ---- 
---- either version 2.1 of the License, or (at your option) any   ---- 
---- later version.                                               ---- 
----                                                              ---- 
---- This source is distributed in the hope that it will be       ---- 
---- useful, but WITHOUT ANY WARRANTY; without even the implied   ---- 
---- warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      ---- 
---- PURPOSE.  See the GNU Lesser General Public License for more ---- 
---- details.                                                     ---- 
----                                                              ---- 
---- You should have received a copy of the GNU Lesser General    ---- 
---- Public License along with this source; if not, download it   ---- 
---- from http://www.opencores.org/lgpl.shtml                     ---- 
----                                                              ---- 
----------------------------------------------------------------------
-- library -----------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;

-- package -----------------------------------------------------------
PACKAGE convert_pkg IS

  FUNCTION to_std_logic_vector(input : integer; length : integer) RETURN std_logic_vector;

  FUNCTION to_integer(input : std_logic_vector) RETURN integer;
  FUNCTION to_string(int             : integer; base : integer := 10; length : integer := 0) RETURN string;
  FUNCTION to_string(slv             : std_logic_vector; base : integer; length : integer) RETURN string;
  
END convert_pkg;

-- package body ------------------------------------------------------
PACKAGE BODY convert_pkg IS
  ----------------------------------------------------------------------
  FUNCTION to_std_logic_vector(input : integer; length : integer) RETURN std_logic_vector IS
  BEGIN
    RETURN std_logic_vector(conv_unsigned(input, length));
  END;
  ----------------------------------------------------------------------
  FUNCTION to_integer(input : std_logic_vector) RETURN integer IS
  BEGIN
    RETURN conv_integer(unsigned(input));
  END;
  ----------------------------------------------------------------------
  FUNCTION to_char(int : integer) RETURN character IS
    VARIABLE c : character;
  BEGIN
    CASE int IS
      WHEN 0      => c := '0';
      WHEN 1      => c := '1';
      WHEN 2      => c := '2';
      WHEN 3      => c := '3';
      WHEN 4      => c := '4';
      WHEN 5      => c := '5';
      WHEN 6      => c := '6';
      WHEN 7      => c := '7';
      WHEN 8      => c := '8';
      WHEN 9      => c := '9';
      WHEN 10     => c := 'A';
      WHEN 11     => c := 'B';
      WHEN 12     => c := 'C';
      WHEN 13     => c := 'D';
      WHEN 14     => c := 'E';
      WHEN 15     => c := 'F';
      WHEN 16     => c := 'G';
      WHEN 17     => c := 'H';
      WHEN 18     => c := 'I';
      WHEN 19     => c := 'J';
      WHEN 20     => c := 'K';
      WHEN 21     => c := 'L';
      WHEN 22     => c := 'M';
      WHEN 23     => c := 'N';
      WHEN 24     => c := 'O';
      WHEN 25     => c := 'P';
      WHEN 26     => c := 'Q';
      WHEN 27     => c := 'R';
      WHEN 28     => c := 'S';
      WHEN 29     => c := 'T';
      WHEN 30     => c := 'U';
      WHEN 31     => c := 'V';
      WHEN 32     => c := 'W';
      WHEN 33     => c := 'X';
      WHEN 34     => c := 'Y';
      WHEN 35     => c := 'Z';
      WHEN OTHERS => c := '?';
    END CASE;
    RETURN c;
  END to_char;
  ----------------------------------------------------------------------
  FUNCTION to_string(int : integer; base : integer := 10; length : integer := 0) RETURN string IS

    VARIABLE temp    : string(1 TO 1000);
    VARIABLE num     : integer;
    VARIABLE abs_int : integer;
    VARIABLE len     : integer := 1;
    VARIABLE power   : integer := 1;

  BEGIN
    abs_int := ABS(int);
    num     := abs_int;
    --
    IF (length = 0) THEN                -- automatic length detection 
      WHILE num >= base LOOP            -- Determine how many
        len := len + 1;                 -- characters required
        num := num / base;              -- to represent the
      END LOOP;  -- number.
    ELSE
      len := ABS(length);               -- 
    END IF;

    IF (base /= 10) THEN
      len := len + (len-1) / 4;                       -- increase for underlines
    END IF;
    --
    FOR i IN len DOWNTO 1 LOOP                        -- Convert the number to
      IF (((len-i) MOD 5 = 4) AND (base /= 10)) THEN  -- every fith char shell be an underline
        temp(i) := '_';
      ELSE
        temp(i) := to_char(abs_int/power MOD base);   -- a string starting
        power   := power * base;                      -- with the right hand
      END IF;
    END LOOP;  -- side.
    --
    -- return result and add sign if required
    IF (base = 16) THEN
      IF (int < 0) THEN
        CASE temp(len) IS
          WHEN '0'    => temp(len) := 'F';
          WHEN '1'    => temp(len) := '0';
          WHEN '2'    => temp(len) := '1';
          WHEN '3'    => temp(len) := '2';
          WHEN '4'    => temp(len) := '3';
          WHEN '5'    => temp(len) := '4';
          WHEN '6'    => temp(len) := '5';
          WHEN '7'    => temp(len) := '6';
          WHEN '8'    => temp(len) := '7';
          WHEN '9'    => temp(len) := '8';
          WHEN 'A'    => temp(len) := '9';
          WHEN 'B'    => temp(len) := 'A';
          WHEN 'C'    => temp(len) := 'B';
          WHEN 'D'    => temp(len) := 'C';
          WHEN 'E'    => temp(len) := 'D';
          WHEN 'F'    => temp(len) := 'E';
          WHEN OTHERS => NULL;
        END CASE;
        FOR i IN len DOWNTO 1 LOOP
          CASE temp(i) IS
            WHEN '0'    => temp(i) := 'F';
            WHEN '1'    => temp(i) := 'E';
            WHEN '2'    => temp(i) := 'D';
            WHEN '3'    => temp(i) := 'C';
            WHEN '4'    => temp(i) := 'B';
            WHEN '5'    => temp(i) := 'A';
            WHEN '6'    => temp(i) := '9';
            WHEN '7'    => temp(i) := '8';
            WHEN '8'    => temp(i) := '7';
            WHEN '9'    => temp(i) := '6';
            WHEN 'A'    => temp(i) := '5';
            WHEN 'B'    => temp(i) := '4';
            WHEN 'C'    => temp(i) := '3';
            WHEN 'D'    => temp(i) := '2';
            WHEN 'E'    => temp(i) := '1';
            WHEN 'F'    => temp(i) := '0';
            WHEN OTHERS => NULL;
          END CASE;
        END LOOP;  -- i
      END IF;
      RETURN temp(1 TO len);
    ELSE
      IF (int < 0) THEN
        RETURN '-'& temp(1 TO len);
      ELSE
        RETURN temp(1 TO len);
      END IF;
    END IF;
  END to_string;
  ----------------------------------------------------------------------
  FUNCTION to_string(slv : std_logic_vector) RETURN string IS

    VARIABLE hexlen  : integer;
    VARIABLE longslv : std_logic_vector(131 DOWNTO 0) := (OTHERS => '0');
    VARIABLE hex     : string(1 TO 32);
    VARIABLE fourbit : std_logic_vector(3 DOWNTO 0);

  BEGIN
    hexlen := ((slv'high - slv'low) + 1) / 4;
    IF (((slv'high - slv'low) + 1) MOD 4 /= 0) THEN
      hexlen := hexlen + 1;
    END IF;
    --
    longslv((slv'high - slv'low) DOWNTO 0) := slv;
    --
    FOR i IN (hexlen -1) DOWNTO 0 LOOP
      fourbit := longslv(((i*4)+3) DOWNTO (i*4));
      CASE fourbit IS
        WHEN "0000" => hex(hexlen -I) := '0';
        WHEN "0001" => hex(hexlen -I) := '1';
        WHEN "0010" => hex(hexlen -I) := '2';
        WHEN "0011" => hex(hexlen -I) := '3';
        WHEN "0100" => hex(hexlen -I) := '4';
        WHEN "0101" => hex(hexlen -I) := '5';
        WHEN "0110" => hex(hexlen -I) := '6';
        WHEN "0111" => hex(hexlen -I) := '7';
        WHEN "1000" => hex(hexlen -I) := '8';
        WHEN "1001" => hex(hexlen -I) := '9';
        WHEN "1010" => hex(hexlen -I) := 'A';
        WHEN "1011" => hex(hexlen -I) := 'B';
        WHEN "1100" => hex(hexlen -I) := 'C';
        WHEN "1101" => hex(hexlen -I) := 'D';
        WHEN "1110" => hex(hexlen -I) := 'E';
        WHEN "1111" => hex(hexlen -I) := 'F';
        WHEN "ZZZZ" => hex(hexlen -I) := 'z';
        WHEN "UUUU" => hex(hexlen -I) := 'u';
        WHEN "XXXX" => hex(hexlen -I) := 'x';
        WHEN OTHERS => hex(hexlen -I) := '?';
      END CASE;
    END LOOP;
    RETURN hex(1 TO hexlen);
  END to_string;
  ----------------------------------------------------------------------
  FUNCTION to_string(slv : std_logic_vector; base : integer; length : integer) RETURN string IS

  BEGIN
    RETURN to_string(to_integer(slv), base, length);
  END to_string;
  ----------------------------------------------------------------------
end package body;
----------------------------------------------------------------------
---- end of file                                                  ---- 
----------------------------------------------------------------------