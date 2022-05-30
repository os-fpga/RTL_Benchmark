--
-- crc32_fast24_tab.vhd: A 32-bit crc (IEEE) table for processing fixed 24 bits in parallel
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
entity crc32_fast24_tab is
   port(
      DI    : in  std_logic_vector(24-1 downto 0);
      DO    : out std_logic_vector(31 downto 0)
   );
end entity crc32_fast24_tab;

-- ----------------------------------------------------------------------------
--                      Architecture declaration
-- ----------------------------------------------------------------------------
architecture arch of crc32_fast24_tab is
begin
-- 32-bit crc equations processing 24 bits in parallel (VHDL code)
-- Generator polynomial: 0x104C11DB7
   DO(0) <= DI(0) XOR DI(14) XOR DI(15) XOR DI(8) XOR DI(12) XOR DI(18);
   DO(1) <= DI(1) XOR DI(15) XOR DI(0) XOR DI(16) XOR DI(9) XOR DI(13) XOR DI(19);
   DO(2) <= DI(2) XOR DI(0) XOR DI(16) XOR DI(1) XOR DI(17) XOR DI(10) XOR DI(14) XOR DI(20);
   DO(3) <= DI(3) XOR DI(1) XOR DI(17) XOR DI(2) XOR DI(18) XOR DI(11) XOR DI(15) XOR DI(21);
   DO(4) <= DI(4) XOR DI(0) XOR DI(2) XOR DI(18) XOR DI(3) XOR DI(19) XOR DI(12) XOR DI(16) XOR DI(22);
   DO(5) <= DI(5) XOR DI(0) XOR DI(1) XOR DI(3) XOR DI(19) XOR DI(4) XOR DI(20) XOR DI(13) XOR DI(17) XOR DI(23);
   DO(6) <= DI(6) XOR DI(1) XOR DI(2) XOR DI(4) XOR DI(8) XOR DI(20) XOR DI(12) XOR DI(5) XOR DI(15) XOR DI(21);
   DO(7) <= DI(7) XOR DI(2) XOR DI(3) XOR DI(5) XOR DI(9) XOR DI(21) XOR DI(13) XOR DI(6) XOR DI(16) XOR DI(22);
   DO(8) <= DI(8) XOR DI(3) XOR DI(4) XOR DI(6) XOR DI(10) XOR DI(22) XOR DI(14) XOR DI(7) XOR DI(17) XOR DI(23);
   DO(9) <= DI(9) XOR DI(0) XOR DI(12) XOR DI(4) XOR DI(5) XOR DI(14) XOR DI(7) XOR DI(11) XOR DI(23);
   DO(10) <= DI(10) XOR DI(1) XOR DI(13) XOR DI(5) XOR DI(14) XOR DI(6) XOR DI(18);
   DO(11) <= DI(0) XOR DI(11) XOR DI(2) XOR DI(14) XOR DI(6) XOR DI(15) XOR DI(7) XOR DI(19);
   DO(12) <= DI(1) XOR DI(12) XOR DI(3) XOR DI(15) XOR DI(7) XOR DI(16) XOR DI(8) XOR DI(20);
   DO(13) <= DI(2) XOR DI(13) XOR DI(0) XOR DI(4) XOR DI(16) XOR DI(8) XOR DI(17) XOR DI(9) XOR DI(21);
   DO(14) <= DI(3) XOR DI(14) XOR DI(0) XOR DI(1) XOR DI(5) XOR DI(17) XOR DI(9) XOR DI(18) XOR DI(10) XOR DI(22);
   DO(15) <= DI(4) XOR DI(15) XOR DI(1) XOR DI(2) XOR DI(6) XOR DI(18) XOR DI(10) XOR DI(19) XOR DI(11) XOR DI(23);
   DO(16) <= DI(5) XOR DI(15) XOR DI(16) XOR DI(2) XOR DI(18) XOR DI(3) XOR DI(7) XOR DI(19) XOR DI(11) XOR DI(8) XOR DI(14) XOR DI(20);
   DO(17) <= DI(6) XOR DI(0) XOR DI(16) XOR DI(17) XOR DI(3) XOR DI(19) XOR DI(4) XOR DI(8) XOR DI(20) XOR DI(12) XOR DI(9) XOR DI(15) XOR DI(21);
   DO(18) <= DI(7) XOR DI(1) XOR DI(17) XOR DI(18) XOR DI(4) XOR DI(20) XOR DI(5) XOR DI(9) XOR DI(21) XOR DI(13) XOR DI(10) XOR DI(16) XOR DI(22);
   DO(19) <= DI(8) XOR DI(2) XOR DI(18) XOR DI(19) XOR DI(5) XOR DI(21) XOR DI(6) XOR DI(10) XOR DI(22) XOR DI(14) XOR DI(11) XOR DI(17) XOR DI(23);
   DO(20) <= DI(9) XOR DI(3) XOR DI(19) XOR DI(8) XOR DI(20) XOR DI(6) XOR DI(22) XOR DI(14) XOR DI(7) XOR DI(11) XOR DI(23);
   DO(21) <= DI(18) XOR DI(10) XOR DI(4) XOR DI(20) XOR DI(9) XOR DI(21) XOR DI(14) XOR DI(7) XOR DI(23);
   DO(22) <= DI(14) XOR DI(0) XOR DI(18) XOR DI(19) XOR DI(11) XOR DI(5) XOR DI(21) XOR DI(12) XOR DI(10) XOR DI(22);
   DO(23) <= DI(15) XOR DI(0) XOR DI(1) XOR DI(19) XOR DI(20) XOR DI(12) XOR DI(6) XOR DI(22) XOR DI(13) XOR DI(11) XOR DI(23);
   DO(24) <= DI(0) XOR DI(16) XOR DI(1) XOR DI(2) XOR DI(18) XOR DI(8) XOR DI(20) XOR DI(15) XOR DI(21) XOR DI(13) XOR DI(7) XOR DI(23);
   DO(25) <= DI(1) XOR DI(17) XOR DI(2) XOR DI(18) XOR DI(3) XOR DI(19) XOR DI(9) XOR DI(15) XOR DI(21) XOR DI(12) XOR DI(16) XOR DI(22);
   DO(26) <= DI(2) XOR DI(18) XOR DI(3) XOR DI(19) XOR DI(4) XOR DI(20) XOR DI(10) XOR DI(16) XOR DI(22) XOR DI(13) XOR DI(17) XOR DI(23);
   DO(27) <= DI(3) XOR DI(19) XOR DI(4) XOR DI(8) XOR DI(20) XOR DI(12) XOR DI(5) XOR DI(15) XOR DI(21) XOR DI(11) XOR DI(17) XOR DI(23);
   DO(28) <= DI(4) XOR DI(8) XOR DI(14) XOR DI(20) XOR DI(5) XOR DI(9) XOR DI(15) XOR DI(21) XOR DI(13) XOR DI(6) XOR DI(16) XOR DI(22);
   DO(29) <= DI(5) XOR DI(9) XOR DI(15) XOR DI(21) XOR DI(6) XOR DI(10) XOR DI(16) XOR DI(22) XOR DI(14) XOR DI(7) XOR DI(17) XOR DI(23);
   DO(30) <= DI(12) XOR DI(6) XOR DI(10) XOR DI(16) XOR DI(22) XOR DI(14) XOR DI(7) XOR DI(11) XOR DI(17) XOR DI(23);
   DO(31) <= DI(13) XOR DI(14) XOR DI(7) XOR DI(11) XOR DI(17) XOR DI(23);  
end architecture;