--
-- crc32_gen.vhd: 32-bit CRC module processing generic number of bits in parallel
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

entity crc32_gen is
   generic(
      DATA_WIDTH : integer := 64;
      REG_BITMAP : integer := 0     
   );
   port(
      DI    : in std_logic_vector(DATA_WIDTH-1 downto 0);
      DI_DV : in std_logic;
      EOP   : in std_logic;
      MASK  : in std_logic_vector(log2(DATA_WIDTH/8)-1 downto 0);
      CLK   : in std_logic;
      RESET : in std_logic;
      CRC   : out std_logic_vector(31 downto 0);
      DO_DV : out std_logic
   );
end entity crc32_gen;

architecture crc32_gen_arch of crc32_gen is
   constant MW    : integer := log2(DATA_WIDTH/8); 
   
   signal crc_reg: std_logic_vector(DATA_WIDTH-1 downto 0);
   signal crc_reg_input: std_logic_vector(DATA_WIDTH-1 downto 0);
   signal tctl, deop : std_logic;
   signal reg_low, reg_low_data, crctab_do, crctab_tree_do : std_logic_vector(31 downto 0);
   signal mx_di, do_reg : std_logic_vector(31 downto 0);

   signal reg_mask : std_logic_vector(log2(DATA_WIDTH/8)-1 downto 0);
   signal reg_di : std_logic_vector(DATA_WIDTH-1 downto 0);
   
   signal tree_vld    : std_logic;
    
begin 
   assert DATA_WIDTH >= 32 and DATA_WIDTH mod 8 = 0 report "CRC32: Wrong DATA_WIDTH set! DATA_WIDTH must be multiple of 8 and greater or equal to 32." severity error;
   
   crc32_gen_tab_instance: entity work.crc32_fast_tab
      generic map(
         DATA_WIDTH => DATA_WIDTH
      )
      port map(
         DI   => crc_reg,
         DO   => crctab_do
      );
      
   crc32_gen_tab_tree_instance: entity work.crc32_gen_tab_tree
      generic map(
         DATA_WIDTH => DATA_WIDTH,
         REG_BITMAP => REG_BITMAP
      )
      port map(
         CLK   => CLK,
         DI    => crc_reg,
         DI_DV => deop,
         MASK  => reg_mask,
         DO    => crctab_tree_do,
         DO_DV => tree_vld
      );

   crc32_gen_fsm_instance: entity work.crc32_gen_fsm
   port map(
      CLK   => CLK,
      RESET => RESET,
      DI_DV => DI_DV,
      EOP   => EOP,  
      TCTL  => tctl
   );
   
   reg_di_input_long_gen  : if (DATA_WIDTH > 32)  generate
      reg_di <= DI(DATA_WIDTH-1 downto 32) & mx_di;
   end generate;
   reg_di_input_short_gen : if (DATA_WIDTH <= 32) generate
      reg_di <= mx_di(DATA_WIDTH-1 downto 0);
   end generate;

   crc_reg_proc: process(CLK, RESET)
   begin
      if RESET = '1' then
         crc_reg <= (others => '0');
      elsif CLK'event AND clk = '1' then
         if DI_DV = '1' then
            crc_reg <= crc_reg_input;
         end if;
      end if;
   end process;
   crc_di_input_long_gen  : if (DATA_WIDTH > 32)  generate
      crc_reg_input <= reg_di(DATA_WIDTH-1 downto 32) & reg_low;
   end generate;
   crc_di_input_short_gen : if (DATA_WIDTH <= 32) generate
      crc_reg_input <= reg_low(DATA_WIDTH-1 downto 0);
   end generate;
   

   process(CLK, RESET)
   begin
      if RESET = '1' then
         deop <= '0';
      elsif CLK = '1' AND CLK'event then
         deop <= EOP and DI_DV;
      end if;
   end process;
    
   process(CLK, RESET)
   begin
      if RESET = '1' then
         DO_DV <= '0';
      elsif CLK = '1' AND CLK'event then
         DO_DV <= tree_vld;
      end if;
   end process;
   
   process(CLK, RESET)
   begin
      if RESET = '1' then
         do_reg <= (others => '0');
      elsif CLK = '1' AND CLK'event then
         do_reg <= crctab_tree_do;
      end if;
   end process;


   -- register reg_mask -------------------------------------------------
   reg_maskp: process(RESET, CLK)
   begin
      if (RESET = '1') then
         reg_mask <= (others => '0');
      elsif (CLK'event AND CLK = '1') then
         reg_mask <= MASK;
      end if;
   end process;


   -- mx_di multiplexor - handles special situation when MASK > DATA_WIDTH/8 - 4
   mx_di <=     X"00" & DI(23 downto 0) when MASK = conv_std_logic_vector(DATA_WIDTH/8-3,MW) else
              X"0000" & DI(15 downto 0) when MASK = conv_std_logic_vector(DATA_WIDTH/8-2,MW) else
            X"000000" & DI( 7 downto 0) when MASK = conv_std_logic_vector(DATA_WIDTH/8-1,MW) else
            DI(31 downto 0);

   reg_low_data <= crctab_do XOR reg_di(31 downto 0) when (tctl = '0') else
                   NOT reg_di(31 downto 0);
   
   reg_low <= reg_low_data;
                
   CRC <= NOT (do_reg(7 downto 0) & do_reg(15 downto 8) & do_reg(23 downto 16)
               & do_reg(31 downto 24));

end architecture;
