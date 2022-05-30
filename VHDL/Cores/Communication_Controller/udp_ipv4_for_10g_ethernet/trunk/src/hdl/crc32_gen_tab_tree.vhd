--
-- crc32_gen_tab.vhd: A 32-bit CRC (IEEE) table for processing generic number of bits in parallel
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
entity crc32_gen_tab_tree is
   generic(
      -- must be power of 2 and higher or equal to 32
      DATA_WIDTH : integer := 64;
      REG_BITMAP : integer := 0 
   );
   port(
      CLK   : in  std_logic;
      DI    : in  std_logic_vector(DATA_WIDTH-1 downto 0);
      DI_DV : in  std_logic;
      MASK  : in  std_logic_vector(log2(DATA_WIDTH/8)-1 downto 0);
      DO    : out std_logic_vector(31 downto 0);
      DO_DV : out std_logic
   );
end entity crc32_gen_tab_tree;

-- ----------------------------------------------------------------------------
--                      Architecture declaration
-- ----------------------------------------------------------------------------
architecture crc32_gen_tab_arch of crc32_gen_tab_tree is
   constant MW    : integer := log2(DATA_WIDTH/8); 
   signal crc_fin : std_logic_vector(31 downto 0);
   type pipe_t      is array (0 to MW-2) of std_logic_vector(DATA_WIDTH-1 downto 0);
   type pipe_mask_t is array (0 to MW-2) of std_logic_vector(MW-1 downto 0);
   type pipe_crc_t  is array (0 to MW-2) of std_logic_vector(31 downto 0);
   signal indata_pipe   : pipe_t;
   signal indata_pipe_MW_2_d : std_logic_vector(DATA_WIDTH-1 downto 0);
   signal outdata_pipe  : pipe_t;
   signal xordata_pipe  : pipe_t;
   signal mask_pipe     : pipe_mask_t;
   signal crc_pipe      : pipe_crc_t;
   signal dv_pipe       : std_logic_vector(MW-2 downto 0);
   signal crc32         : std_logic_vector(31 downto 0);
   signal crc24         : std_logic_vector(31 downto 0);
   signal crc16         : std_logic_vector(31 downto 0);
   signal crc8          : std_logic_vector(31 downto 0);

   signal crc32_d       : std_logic_vector(31 downto 0);
   signal crc24_d       : std_logic_vector(31 downto 0);
   signal crc16_d       : std_logic_vector(31 downto 0);
   signal crc8_d        : std_logic_vector(31 downto 0);

   signal do_32         : std_logic_vector(31 downto 0);
   signal do_24         : std_logic_vector(31 downto 0);
   signal do_16         : std_logic_vector(31 downto 0);
   signal do_8          : std_logic_vector(31 downto 0);

   signal do_dv_d       : std_logic;
   signal do_dv_dd      : std_logic;

   signal mask_pipe_d   : std_logic_vector(1 downto 0);
   signal mask_pipe_dd  : std_logic_vector(1 downto 0);

   signal xxx           : std_logic_vector(MW-1 downto 0);
   
begin
   xxx <= conv_std_logic_vector(REG_BITMAP,MW);
   
   process(MASK,DI) 
   begin
      indata_pipe(0) <=(DATA_WIDTH-1 downto 32 => '0') & DI(31 downto 0); 
      for i in 4 to (DATA_WIDTH/8-1) loop
         if (conv_std_logic_vector(DATA_WIDTH/8-i-1,MW) >= MASK ) then
            indata_pipe(0)((i*8)+7 downto i*8) <= DI((i*8)+7 downto i*8);
         end if;
      end loop;
   end process;
   mask_pipe(0)      <= MASK;
   dv_pipe(0)        <= DI_DV;
   
                  
   -- pipelined CRC tree --------------------------------
   tree_gen : if DATA_WIDTH > 32 generate
      tree_floor_gen : for i in 0 to MW-3 generate
         -- CRC TABLE 
         crc32_fast_tab_i: entity work.crc32_fast_tab
         generic map(
            DATA_WIDTH => DATA_WIDTH/(2**(i+1)))
         port map(
            DI   => indata_pipe(i)(DATA_WIDTH/(2**(i+1))-1 downto 0),
            DO   => crc_pipe(i));      
       
         -- DATA MUX
         outdata_pipe(i)(max(32,(DATA_WIDTH/(2**(i+1))))-1 downto 0) <= indata_pipe(i)(max(32,(DATA_WIDTH/(2**(i+1))))-1  downto 0) when mask_pipe(i)(MW-i-1) = '1' else
                                                                        xordata_pipe(i)(max(32,(DATA_WIDTH/(2**(i+1))))-1 downto 0); 
                                                                                                                           
         -- DATA-CRC XOR 
         xor32h_gen : if (DATA_WIDTH/(2**(i+1))) > 32 generate
            xordata_pipe(i)((DATA_WIDTH/(2**(i+1)))-1 downto 0) <= indata_pipe(i)((DATA_WIDTH/(2**(i)))-1 downto 32+(DATA_WIDTH/(2**(i+1))))  &  (indata_pipe(i)((32+(DATA_WIDTH/(2**(i+1))))-1 downto (DATA_WIDTH/(2**(i+1)))) XOR crc_pipe(i));
         end generate;
         xor32_gen : if (DATA_WIDTH/(2**(i+1))) = 32 generate
            xordata_pipe(i)(31 downto 0) <= indata_pipe(i)(63 downto 32) XOR crc_pipe(i);                           
         end generate;
         
         -- MASK PIPELINED
         reg_mask_gen : if conv_std_logic_vector(REG_BITMAP,MW)(i)='1' generate
            process(CLK)
            begin
               if CLK'event and CLK='1' then
                  mask_pipe(i+1)(MW-i-2 downto 0) <= mask_pipe(i)(MW-i-2 downto 0);
               end if;
            end process;
         end generate;
         noreg_mask_gen : if conv_std_logic_vector(REG_BITMAP,MW)(i)='0' generate
            mask_pipe(i+1)(MW-i-2 downto 0) <= mask_pipe(i)(MW-i-2 downto 0);
         end generate;
         -- DATA PIPELINED
         reg_data_gen : if conv_std_logic_vector(REG_BITMAP,MW)(i)='1' generate
            process(CLK)
            begin
               if CLK'event and CLK='1' then
                  indata_pipe(i+1)     <= outdata_pipe(i);
                  dv_pipe(i+1)         <= dv_pipe(i);
               end if;
            end process;
         end generate;
         noreg_data_gen : if conv_std_logic_vector(REG_BITMAP,MW)(i)='0' generate
            indata_pipe(i+1) <= outdata_pipe(i);
            dv_pipe(i+1)     <= dv_pipe(i);
         end generate;
      end generate;
   end generate;   
   
   crc32_fast_tab_32: entity work.crc32_fast_tab
   generic map(
      DATA_WIDTH => 32)
   port map(
      DI   => indata_pipe(MW-2)(31 downto 0),
      DO   => crc32);
   crc32_fast_tab_24: entity work.crc32_fast_tab
   generic map(
      DATA_WIDTH => 24)
   port map(
      DI   => indata_pipe(MW-2)(23 downto 0),
      DO   => crc24);
   crc32_fast_tab_16: entity work.crc32_fast_tab
   generic map(
      DATA_WIDTH => 16)
   port map(
      DI   => indata_pipe(MW-2)(15 downto 0),
      DO   => crc16);
   crc32_fast_tab_8: entity work.crc32_fast_tab
   generic map(
      DATA_WIDTH => 8)
   port map(
      DI   => indata_pipe(MW-2)(7 downto 0),
      DO   => crc8);


   do_pipeline_proc : process (CLK)
   begin
      if rising_edge(CLK) then
         crc8_d <= crc8;
         crc16_d <= crc16;
         crc24_d <= crc24;
         crc32_d <= crc32;
         do_dv_d <= dv_pipe(MW-2);

         indata_pipe_MW_2_d <= indata_pipe(MW-2);


         do_8 <= ((X"00" & indata_pipe_MW_2_d(31 downto 8)) XOR crc8_d);
         do_16 <= ((X"0000" & indata_pipe_MW_2_d(31 downto 16)) XOR crc16_d);
         do_24 <= ((X"000000" & indata_pipe_MW_2_d(31 downto 24)) XOR crc24_d);
         do_32 <= (crc32_d);         
         do_dv_dd <= do_dv_d;

         mask_pipe_d <= mask_pipe(MW-2)(1 downto 0);
         mask_pipe_dd <= mask_pipe_d;

      end if;
   end process;




   DO <= do_8  when mask_pipe_dd ="11" else
         do_16 when mask_pipe_dd ="10" else
         do_24 when mask_pipe_dd ="01" else
         do_32;  

   DO_DV <= do_dv_dd;
    
end architecture crc32_gen_tab_arch;



