--
-- crc32_fast32_tab.vhd: A 32-bit CRC (IEEE) table for processing fixed 32 bits in parallel
-- Copyright (C) 2011 CESNET
-- Author(s): Lukas Kekely <xkekel00@stud.fit.vutbr.cz>
--
-- Redistribution and use in source and binary forms, with or without
-- modification, are permitted provided that the following conditions
-- are met:
-- 1. Redistributions of source code must retain the above copyright
--    notice, this list of conditions and the following disclaimer.
-- 2. Redistributions in binary form must reproduce the above copyright
--    notice, this list of conditions and the following disclaimer in
--    the documentation and/or other materials provided with the
--    distribution.
-- 3. Neither the name of the Company nor the names of its contributors
--    may be used to endorse or promote products derived from this
--    software without specific prior written permission.
--
-- This software is provided ``as is'', and any express or implied
-- warranties, including, but not limited to, the implied warranties of
-- merchantability and fitness for a particular purpose are disclaimed.
-- In no event shall the company or contributors be liable for any
-- direct, indirect, incidental, special, exemplary, or consequential
-- damages (including, but not limited to, procurement of substitute
-- goods or services; loss of use, data, or profits; or business
-- interruption) however caused and on any theory of liability, whether
-- in contract, strict liability, or tort (including negligence or
-- otherwise) arising in any way out of the use of this software, even
-- if advised of the possibility of such damage.
--
-- $Id$
--
-- TODO:
--
--

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;
use WORK.math_pack.all;
-- ----------------------------------------------------------------------------
--                        Entity declaration
-- ----------------------------------------------------------------------------
entity crc32_fast32_tab is
   port(
      DI    : in  std_logic_vector(32-1 downto 0);
      DO    : out std_logic_vector(31 downto 0)
   );
end entity crc32_fast32_tab;

-- ----------------------------------------------------------------------------
--                      Architecture declaration
-- ----------------------------------------------------------------------------
architecture arch of crc32_fast32_tab is
begin
-- 32-bit CRC equations processing 32 bits in parallel (VHDL code)
-- Generator polynomial: 0x104C11DB7
   DO(0) <= DI(8) XOR DI(3) XOR DI(4) XOR DI(6) XOR DI(22) XOR DI(7) XOR DI(23) XOR DI(2) XOR DI(0) XOR DI(16) XOR DI(1) XOR DI(20) XOR DI(26);
   DO(1) <= DI(9) XOR DI(4) XOR DI(5) XOR DI(7) XOR DI(23) XOR DI(8) XOR DI(24) XOR DI(3) XOR DI(1) XOR DI(17) XOR DI(2) XOR DI(21) XOR DI(27);
   DO(2) <= DI(10) XOR DI(5) XOR DI(6) XOR DI(8) XOR DI(24) XOR DI(9) XOR DI(25) XOR DI(4) XOR DI(0) XOR DI(2) XOR DI(18) XOR DI(3) XOR DI(22) XOR DI(28);
   DO(3) <= DI(11) XOR DI(6) XOR DI(7) XOR DI(9) XOR DI(25) XOR DI(10) XOR DI(26) XOR DI(5) XOR DI(1) XOR DI(3) XOR DI(19) XOR DI(4) XOR DI(23) XOR DI(29);
   DO(4) <= DI(12) XOR DI(7) XOR DI(8) XOR DI(10) XOR DI(26) XOR DI(11) XOR DI(27) XOR DI(6) XOR DI(2) XOR DI(4) XOR DI(20) XOR DI(5) XOR DI(24) XOR DI(30);
   DO(5) <= DI(13) XOR DI(8) XOR DI(9) XOR DI(11) XOR DI(27) XOR DI(12) XOR DI(28) XOR DI(7) XOR DI(3) XOR DI(5) XOR DI(21) XOR DI(6) XOR DI(0) XOR DI(25) XOR DI(31);
   DO(6) <= DI(14) XOR DI(9) XOR DI(10) XOR DI(2) XOR DI(12) XOR DI(16) XOR DI(28) XOR DI(0) XOR DI(3) XOR DI(20) XOR DI(13) XOR DI(23) XOR DI(29);
   DO(7) <= DI(15) XOR DI(10) XOR DI(11) XOR DI(3) XOR DI(13) XOR DI(17) XOR DI(29) XOR DI(1) XOR DI(4) XOR DI(21) XOR DI(14) XOR DI(24) XOR DI(30);
   DO(8) <= DI(16) XOR DI(11) XOR DI(12) XOR DI(4) XOR DI(14) XOR DI(18) XOR DI(30) XOR DI(2) XOR DI(5) XOR DI(22) XOR DI(15) XOR DI(0) XOR DI(25) XOR DI(31);
   DO(9) <= DI(17) XOR DI(4) XOR DI(8) XOR DI(20) XOR DI(12) XOR DI(13) XOR DI(7) XOR DI(2) XOR DI(5) XOR DI(22) XOR DI(15) XOR DI(0) XOR DI(19) XOR DI(31);
   DO(10) <= DI(7) XOR DI(18) XOR DI(4) XOR DI(5) XOR DI(9) XOR DI(21) XOR DI(13) XOR DI(22) XOR DI(2) XOR DI(0) XOR DI(14) XOR DI(26);
   DO(11) <= DI(8) XOR DI(19) XOR DI(5) XOR DI(6) XOR DI(10) XOR DI(22) XOR DI(14) XOR DI(23) XOR DI(3) XOR DI(1) XOR DI(15) XOR DI(27);
   DO(12) <= DI(9) XOR DI(20) XOR DI(6) XOR DI(7) XOR DI(11) XOR DI(23) XOR DI(15) XOR DI(24) XOR DI(4) XOR DI(2) XOR DI(16) XOR DI(28);
   DO(13) <= DI(10) XOR DI(21) XOR DI(7) XOR DI(8) XOR DI(12) XOR DI(24) XOR DI(16) XOR DI(25) XOR DI(5) XOR DI(0) XOR DI(3) XOR DI(17) XOR DI(29);
   DO(14) <= DI(11) XOR DI(22) XOR DI(8) XOR DI(9) XOR DI(13) XOR DI(25) XOR DI(17) XOR DI(26) XOR DI(6) XOR DI(1) XOR DI(4) XOR DI(0) XOR DI(18) XOR DI(30);
   DO(15) <= DI(12) XOR DI(23) XOR DI(9) XOR DI(10) XOR DI(14) XOR DI(26) XOR DI(18) XOR DI(27) XOR DI(7) XOR DI(2) XOR DI(5) XOR DI(1) XOR DI(19) XOR DI(31);
   DO(16) <= DI(13) XOR DI(7) XOR DI(23) XOR DI(24) XOR DI(10) XOR DI(26) XOR DI(1) XOR DI(11) XOR DI(15) XOR DI(27) XOR DI(4) XOR DI(19) XOR DI(16) XOR DI(22) XOR DI(28);
   DO(17) <= DI(14) XOR DI(8) XOR DI(24) XOR DI(25) XOR DI(11) XOR DI(27) XOR DI(2) XOR DI(12) XOR DI(16) XOR DI(28) XOR DI(5) XOR DI(20) XOR DI(17) XOR DI(23) XOR DI(29);
   DO(18) <= DI(15) XOR DI(9) XOR DI(25) XOR DI(26) XOR DI(12) XOR DI(28) XOR DI(3) XOR DI(13) XOR DI(17) XOR DI(29) XOR DI(6) XOR DI(21) XOR DI(0) XOR DI(18) XOR DI(24) XOR DI(30);
   DO(19) <= DI(16) XOR DI(10) XOR DI(26) XOR DI(27) XOR DI(13) XOR DI(29) XOR DI(4) XOR DI(14) XOR DI(18) XOR DI(30) XOR DI(7) XOR DI(22) XOR DI(1) XOR DI(0) XOR DI(19) XOR DI(25) XOR DI(31);
   DO(20) <= DI(17) XOR DI(11) XOR DI(27) XOR DI(16) XOR DI(28) XOR DI(4) XOR DI(14) XOR DI(30) XOR DI(7) XOR DI(3) XOR DI(5) XOR DI(6) XOR DI(22) XOR DI(15) XOR DI(0) XOR DI(19) XOR DI(31);
   DO(21) <= DI(26) XOR DI(18) XOR DI(12) XOR DI(28) XOR DI(17) XOR DI(29) XOR DI(2) XOR DI(3) XOR DI(5) XOR DI(22) XOR DI(15) XOR DI(0) XOR DI(31);
   DO(22) <= DI(22) XOR DI(7) XOR DI(8) XOR DI(26) XOR DI(27) XOR DI(19) XOR DI(13) XOR DI(29) XOR DI(2) XOR DI(20) XOR DI(18) XOR DI(30);
   DO(23) <= DI(23) XOR DI(8) XOR DI(9) XOR DI(27) XOR DI(28) XOR DI(20) XOR DI(14) XOR DI(30) XOR DI(3) XOR DI(21) XOR DI(0) XOR DI(19) XOR DI(31);
   DO(24) <= DI(8) XOR DI(24) XOR DI(9) XOR DI(10) XOR DI(26) XOR DI(16) XOR DI(28) XOR DI(23) XOR DI(29) XOR DI(7) XOR DI(2) XOR DI(3) XOR DI(21) XOR DI(6) XOR DI(15) XOR DI(31);
   DO(25) <= DI(9) XOR DI(25) XOR DI(10) XOR DI(26) XOR DI(11) XOR DI(27) XOR DI(17) XOR DI(23) XOR DI(29) XOR DI(6) XOR DI(1) XOR DI(2) XOR DI(20) XOR DI(24) XOR DI(30);
   DO(26) <= DI(10) XOR DI(26) XOR DI(11) XOR DI(27) XOR DI(12) XOR DI(28) XOR DI(18) XOR DI(24) XOR DI(30) XOR DI(7) XOR DI(2) XOR DI(3) XOR DI(21) XOR DI(25) XOR DI(31);
   DO(27) <= DI(11) XOR DI(27) XOR DI(12) XOR DI(16) XOR DI(28) XOR DI(20) XOR DI(13) XOR DI(23) XOR DI(29) XOR DI(7) XOR DI(2) XOR DI(6) XOR DI(1) XOR DI(0) XOR DI(19) XOR DI(25) XOR DI(31);
   DO(28) <= DI(12) XOR DI(16) XOR DI(22) XOR DI(28) XOR DI(13) XOR DI(17) XOR DI(23) XOR DI(29) XOR DI(6) XOR DI(4) XOR DI(21) XOR DI(0) XOR DI(14) XOR DI(24) XOR DI(30);
   DO(29) <= DI(13) XOR DI(17) XOR DI(23) XOR DI(29) XOR DI(14) XOR DI(18) XOR DI(24) XOR DI(30) XOR DI(7) XOR DI(5) XOR DI(22) XOR DI(1) XOR DI(15) XOR DI(0) XOR DI(25) XOR DI(31);
   DO(30) <= DI(4) XOR DI(20) XOR DI(14) XOR DI(18) XOR DI(24) XOR DI(30) XOR DI(7) XOR DI(3) XOR DI(22) XOR DI(15) XOR DI(19) XOR DI(25) XOR DI(31);
   DO(31) <= DI(7) XOR DI(2) XOR DI(3) XOR DI(5) XOR DI(21) XOR DI(6) XOR DI(22) XOR DI(1) XOR DI(15) XOR DI(0) XOR DI(19) XOR DI(25) XOR DI(31);
  
end architecture;