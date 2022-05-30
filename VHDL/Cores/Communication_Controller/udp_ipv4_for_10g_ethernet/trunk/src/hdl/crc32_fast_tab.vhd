--
-- crc32_fast_tab.vhd: A 32-bit CRC (IEEE) table for processing generic number of unmasked bits in parallel
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
entity crc32_fast_tab is
   generic(
      DATA_WIDTH : integer := 64
   );
   port(
      DI    : in  std_logic_vector(DATA_WIDTH-1 downto 0);
      DO    : out std_logic_vector(31 downto 0)
   );
end entity crc32_fast_tab;

-- ----------------------------------------------------------------------------
--                      Architecture declaration
-- ----------------------------------------------------------------------------
architecture arch of crc32_fast_tab is
begin
   DW8_gen : if DATA_WIDTH = 8 generate
      crc_tab_i : entity work.crc32_fast8_tab
      port map (
         DI => DI,
         DO => DO);
   end generate;
   
   DW16_gen : if DATA_WIDTH = 16 generate
      crc_tab_i : entity work.crc32_fast16_tab
      port map (
         DI => DI,
         DO => DO);
   end generate;
   
   DW24_gen : if DATA_WIDTH = 24 generate
      crc_tab_i : entity work.crc32_fast24_tab
      port map (
         DI => DI,
         DO => DO);
   end generate;
   
   DW32_gen : if DATA_WIDTH = 32 generate
      crc_tab_i : entity work.crc32_fast32_tab
      port map (
         DI => DI,
         DO => DO);
   end generate;
   
   DW64_gen : if DATA_WIDTH = 64 generate
      crc_tab_i : entity work.crc32_fast64_tab
      port map (
         DI => DI,
         DO => DO);
   end generate;
   
   DW128_gen : if DATA_WIDTH = 128 generate
      crc_tab_i : entity work.crc32_fast128_tab
      port map (
         DI => DI,
         DO => DO);
   end generate;
   
   DW256_gen : if DATA_WIDTH = 256 generate
      crc_tab_i : entity work.crc32_fast256_tab
      port map (
         DI => DI,
         DO => DO);
   end generate;
   
   DW512_gen : if DATA_WIDTH = 512 generate
      crc_tab_i : entity work.crc32_fast512_tab
      port map (
         DI => DI,
         DO => DO);
   end generate;
   
   DW1024_gen : if DATA_WIDTH = 1024 generate
      crc_tab_i : entity work.crc32_fast1024_tab
      port map (
         DI => DI,
         DO => DO);
   end generate;
   
end architecture;