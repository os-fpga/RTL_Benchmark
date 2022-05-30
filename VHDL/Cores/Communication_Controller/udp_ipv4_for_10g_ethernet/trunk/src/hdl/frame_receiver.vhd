-------------------------------------------------------------------------------
--
-- (C) Copyright 2013 DFC Design, s.r.o., Brno, Czech Republic
-- Author: Marek Kvas (m.kvas@dfcdesign.cz)
--
-------------------------------------------------------------------------------
-- This file is part of UDP/IPv4 for 10 G Ethernet core.
-- 
-- UDP/IPv4 for 10 G Ethernet core is free software: you can 
-- redistribute it and/or modify it under the terms of 
-- the GNU Lesser General Public License as published by the Free 
-- Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
-- 
-- UDP/IPv4 for 10 G Ethernet core is distributed in the hope that 
-- it will be useful, but WITHOUT ANY WARRANTY; without even 
-- the implied warranty of MERCHANTABILITY or FITNESS FOR A 
-- PARTICULAR PURPOSE.  See the GNU Lesser General Public License 
-- for more details.
-- 
-- You should have received a copy of the GNU Lesser General Public 
-- License along with UDP/IPv4 for 10 G Ethernet core.  If not, 
-- see <http://www.gnu.org/licenses/>.
-------------------------------------------------------------------------------
--
-- First block of the receiver chain. It has XGMII as an input.
-- Output is raw 64 bit data guaranteed to be aligned on the frame start and 
-- stripped of preamble and CRC, valid signal covering frame data,
-- and byte enable signal that shall be used in case data amount is not
-- 8 byte aligned. Another signal indicates either CRC error or line
-- signalized error, in which case frame should be discarded.
--
-- Byte enable signal is guaranteed to be all ones for whole frame except
-- for the last word, in case packet length is not 8 byte integer divisible.
--
-- This can work under assumption that minimum IPG in incoming stream is
-- 4 bytes. This means when T is on L0-L4, S cannot be on L5-L7 of the same
-- cycle and when T is on L5-L7 S cannot be on L0-L3 of the next cycle. Under
-- this condition DV is always at leased one cycle deasserted between
-- frames.
--
-- RST must be asserted for 16 cycles to fully empty pipeline
--
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

Library UNISIM;
use UNISIM.vcomponents.all;

library work;
use work.srl_pkg.all;


entity frame_receiver is 
   port (
      RST               : in std_logic; -- Sync to XGMII_RX_CLK

      -- XGMII RX input interface
      XGMII_RXCLK       : in  std_logic;
      XGMII_RXD         : in  std_logic_vector(63 downto 0);
      XGMII_RXC         : in  std_logic_vector( 7 downto 0);

      -- Output interface
      RX_DATA           : out std_logic_vector(63 downto 0);
      RX_DV             : out std_logic;
      RX_BE             : out std_logic_vector(7 downto 0);
      RX_ERR            : out std_logic;
      RX_ERR_VALID      : out std_logic

        );
end entity;

architecture synthesis of frame_receiver is

   -- Local constants
   constant LC_START_CHAR  : std_logic_vector(7 downto 0) := x"FB";
   constant LC_TERM_CHAR   : std_logic_vector(7 downto 0) := x"FD";
   constant LC_ERR_CHAR    : std_logic_vector(7 downto 0) := x"FE";

   -- Aligning block
   signal align_buf_data  : std_logic_vector(XGMII_RXD'length-1 downto 0);
   signal align_res_data  : std_logic_vector(XGMII_RXD'length-1 downto 0);
   signal align_res_data_d: std_logic_vector(XGMII_RXD'length-1 downto 0);
   signal align_buf_ctrl  : std_logic_vector(XGMII_RXC'length-1 downto 0);
   signal align_res_ctrl  : std_logic_vector(XGMII_RXC'length-1 downto 0);
   type align_mode_type  is (S_L0, S_L4);
   signal align_mode     : align_mode_type;

   signal crc_data_d    : std_logic_vector(XGMII_RXD'length-1 downto 0);
   signal crc_data_dd   : std_logic_vector(XGMII_RXD'length-1 downto 0);
   signal data_mask_d   : std_logic_vector(7 downto 0);
   signal data_mask_dd  : std_logic_vector(7 downto 0);
   signal crc_mask_dd   : std_logic_vector(2 downto 0);
   signal crc_dv_d      : std_logic;
   signal crc_dv_dd     : std_logic;
   signal crc_eop       : std_logic;
   signal crc_eop_d     : std_logic;
   signal crc_eop_dd    : std_logic;
   signal data_valid    : std_logic;
   signal data_valid_d  : std_logic;
   signal sop_found     : std_logic;
   signal sop_found_d   : std_logic;

   signal extracted_crc          : std_logic_vector(31 downto 0);
   signal extracted_crc_eq       : std_logic_vector(31 downto 0);
   signal extracted_crc_n        : std_logic_vector(31 downto 0);

   signal data_err_valid         : std_logic;
   signal data_err_valid_d       : std_logic;
   signal data_err_valid_dd      : std_logic;
   signal data_err_valid_reg     : std_logic;
   signal data_err_valid_d_reg   : std_logic;
   signal data_err_valid_dd_reg  : std_logic;

   signal data_err               : std_logic;
   signal data_err_d             : std_logic;
   signal data_err_dd            : std_logic;

   -- Internal versions of output signals
   signal rx_data_i           : std_logic_vector(63 downto 0);
   signal rx_dv_i             : std_logic;
   signal rx_err_i            : std_logic;
   signal rx_err_valid_i      : std_logic;
   signal rx_be_i             : std_logic_vector(7 downto 0);

   signal data_err_eq_m1      : std_logic;

   -- crc connection
   signal crc32_result        : std_logic_vector(31 downto 0);
   signal crc32_result_n      : std_logic_vector(31 downto 0);
   signal crc_vld             : std_logic;


-- Returns true if there is a terminate command character in data
   function check_terminate_func(rxc : std_logic_vector; rxd : std_logic_vector)
                                             return boolean is
      variable res : boolean := false;
   begin
      if (rxd(7  downto  0) = LC_TERM_CHAR and rxc(0) = '1') or
         (rxd(15 downto  8) = LC_TERM_CHAR and rxc(1) = '1') or
         (rxd(23 downto 16) = LC_TERM_CHAR and rxc(2) = '1') or
         (rxd(31 downto 24) = LC_TERM_CHAR and rxc(3) = '1') or
         (rxd(39 downto 32) = LC_TERM_CHAR and rxc(4) = '1') or
         (rxd(47 downto 40) = LC_TERM_CHAR and rxc(5) = '1') or
         (rxd(55 downto 48) = LC_TERM_CHAR and rxc(6) = '1') or
         (rxd(63 downto 56) = LC_TERM_CHAR and rxc(7) = '1') then
         res := true;
      end if;
      
      return res;
   end function;
   
-- Returns true if there is a error command character in data
   function check_err_func(rxc : std_logic_vector; rxd : std_logic_vector)
                                             return boolean is
      variable res : boolean := false;
   begin
      if (rxd(7  downto  0) = LC_ERR_CHAR and rxc(0) = '1') or
         (rxd(15 downto  8) = LC_ERR_CHAR and rxc(1) = '1') or
         (rxd(23 downto 16) = LC_ERR_CHAR and rxc(2) = '1') or
         (rxd(31 downto 24) = LC_ERR_CHAR and rxc(3) = '1') or
         (rxd(39 downto 32) = LC_ERR_CHAR and rxc(4) = '1') or
         (rxd(47 downto 40) = LC_ERR_CHAR and rxc(5) = '1') or
         (rxd(55 downto 48) = LC_ERR_CHAR and rxc(6) = '1') or
         (rxd(63 downto 56) = LC_ERR_CHAR and rxc(7) = '1') then
         res := true;
      end if;

      return res;
   end function;   

   -- transform byte enables to crc mask
   function be_to_crc_mask_func(be : std_logic_vector) return std_logic_vector is
      variable res : std_logic_vector(2 downto 0);
   begin
      case be(7 downto 0) is
         when "00000000" => res := "000";
         when "00000001" => res := "111";
         when "00000011" => res := "110";
         when "00000111" => res := "101";
         when "00001111" => res := "100";
         when "00011111" => res := "011";
         when "00111111" => res := "010";
         when "01111111" => res := "001";
         when others => res := "000";
      end case;
      return res;
   end function;

   function swap_bytes32_cut(i : std_logic_vector; idx : integer) 
                                                return std_logic_vector is
      variable res : std_logic_vector(31 downto 0);
   begin
      res(7  downto 0 ) := i(31 + idx*8 downto 24+ idx*8 );
      res(15 downto 8 ) := i(23 + idx*8 downto 16+ idx*8 );
      res(23 downto 16) := i(15 + idx*8 downto 8 + idx*8 );
      res(31 downto 24) := i(7  + idx*8 downto 0 + idx*8 );
      return res;
   end function;
   

begin

--------------------------------------------------------------------------------
-- Allign data if start is on Lane 4
--------------------------------------------------------------------------------
   
   align_proc : process (XGMII_RXCLK)
      variable tmp      : std_logic_vector(2*align_res_data'length - 1 downto 0);
   begin
      if rising_edge(XGMII_RXCLK) then
         tmp := align_res_data & align_res_data_d;
         rx_err_valid_i <= '0';
         rx_err_i <= '0';
         crc_eop <= '0';
         sop_found <= '0';

         -- First stage - directly connected to input
         if XGMII_RXC(0) = '1' and
            XGMII_RXD((0+1)*8-1 downto 0*8) = LC_START_CHAR then
            align_mode <= S_L0;
            sop_found <= '1';
            data_err <= '0';
         elsif XGMII_RXC(0) = '1' and
               XGMII_RXD((4+1)*8-1 downto 4*8) = LC_START_CHAR then
            align_mode <= S_L4;
            sop_found <= '1';
            data_err <= '0';
         end if;
         align_buf_data <= XGMII_RXD;
         align_buf_ctrl <= XGMII_RXC;

         -- Second stage - registers after multiplexer that takes data
         -- either from buffer or from input
         case align_mode is
            when S_L0 =>
               align_res_data <= align_buf_data;
               align_res_ctrl <= align_buf_ctrl;
            when S_L4 =>
               align_res_data <= XGMII_RXD(31 downto 0) & 
                                 align_buf_data(63 downto 32);
               align_res_ctrl <= XGMII_RXC(3 downto 0) &
                                 align_buf_ctrl(7 downto 4);
         end case;
         sop_found_d <= sop_found;

         -- Derive correct BE and crc mask, align data for crc to this info
         -- derive error signal (remote error or invalid control combination
         -- 3 cycles
         align_res_data_d <= align_res_data;
         crc_data_d <= align_res_data_d;
         crc_data_dd <= crc_data_d;
         crc_eop_d <= crc_eop;
         crc_eop_dd <= crc_eop_d;
         data_mask_dd <= data_mask_d;
         crc_mask_dd <= be_to_crc_mask_func(data_mask_dd);

         data_valid <= data_valid or sop_found_d;
         data_valid_d <= data_valid;
         crc_dv_d <= data_valid_d;
         crc_dv_dd <= crc_dv_d;

         if data_valid = '1' then
            data_mask_d <= (others => '1');
         end if;
         

         if data_valid = '1' and 
            check_terminate_func (align_res_ctrl, align_res_data) then
            case align_res_ctrl is
               when "10000000" => 
                  data_mask_d <= "00000111";
                  data_valid_d  <= '1';
                  data_valid <= '0';
                  crc_eop     <= '1';
                  extracted_crc <= swap_bytes32_cut(tmp,11);
               when "11000000" => 
                  data_mask_d <= "00000011";
                  data_valid_d <= '1';
                  data_valid <= '0';
                  crc_eop     <= '1';
                  extracted_crc <= swap_bytes32_cut(tmp,10);
               when "11100000" => 
                  data_mask_d <= "00000001";
                  data_valid_d <= '1';
                  data_valid <= '0';
                  crc_eop     <= '1';
                  extracted_crc <= swap_bytes32_cut(tmp,9);
               when "11110000" => 
                  data_mask_d <= "00000000";
                  data_valid_d <= '0';
                  data_valid <= '0';
                  crc_eop_d   <= '1';
                  extracted_crc <= swap_bytes32_cut(tmp,8);
               when "11111000" => 
                  data_mask_d <= "00000000";
                  data_valid_d <= '0';
                  data_valid <= '0';
                  data_mask_dd <= "01111111";
                  crc_eop_d   <= '1';
                  extracted_crc <= swap_bytes32_cut(tmp,7);
               when "11111100" => 
                  data_mask_d <= "00000000";
                  data_valid_d <= '0';
                  data_valid <= '0';
                  data_mask_dd <= "00111111";
                  crc_eop_d   <= '1';
                  extracted_crc <= swap_bytes32_cut(tmp,6);
               when "11111110" => 
                  data_mask_d <= "00000000";
                  data_valid_d <= '0';
                  data_valid <= '0';
                  data_mask_dd <= "00011111";
                  crc_eop_d   <= '1';
                  extracted_crc <= swap_bytes32_cut(tmp,5);
               when "11111111" => 
                  data_mask_d <= "00000000";
                  data_valid_d <= '0';
                  data_valid <= '0';
                  data_mask_dd <= "00001111";
                  crc_eop_d   <= '1';
                  extracted_crc <= swap_bytes32_cut(tmp,4);
               when others => 
                  data_err <= '1';
                  data_valid_d <= '0';
                  data_valid <= '0';
            end case;
         end if;

         if check_err_func(align_res_ctrl, align_res_data) then
            data_err <= '1';
         end if;

         -- Check CRC validity
         -- takes 1 cycle, but crc itself has 4 cycles
         -- 5 cycles
         if crc_vld = '1' then
            if extracted_crc /= crc32_result then
               -- CRC error
               rx_err_i <= '1';
            else
               rx_err_i <= data_err_eq_m1;
            end if;
            rx_err_valid_i <= '1';
         end if;

         -- Reset only input to pipeline reset should be held asserted long
         -- enough to reset pipeline
         if RST = '1' then
            align_mode <= S_L0;
            align_buf_data <= (others => '0');
            align_buf_ctrl <= (others => '0');
            align_res_data <= (others => '0');
            align_res_ctrl <= (others => '0');
            data_valid <= '0';
            sop_found <= '0';
            
         end if;
      end if;
   end process;

   -- Equalized signals
   rx_data_eq_inst : ssrl_bus 
   generic map (rx_data'length, 4) port map (XGMII_RXCLK, crc_data_dd,rx_data_i);
   rx_be_eq_inst : ssrl_bus 
   generic map (rx_be'length, 5) port map (XGMII_RXCLK, data_mask_dd, rx_be_i);
   rx_dv_eq_inst : ssrl 
   generic map (4) port map (XGMII_RXCLK, crc_dv_dd, rx_dv_i);
   data_err_eq_inst : ssrl 
   generic map (4) port map (XGMII_RXCLK, data_err, data_err_eq_m1);
                        
   
   
   

--------------------------------------------------------------------------------
-- Process data
--------------------------------------------------------------------------------




   crc32_gen_inst: entity work.crc32_gen
   generic map (
      DATA_WIDTH => 64
   )
   port map(
      DI    => crc_data_dd,
      DI_DV => crc_dv_dd,
      EOP   => crc_eop_dd,
      MASK  => crc_mask_dd,
      CLK   => XGMII_RXCLK,
      RESET => RST,
      CRC   => crc32_result,
      DO_DV => crc_vld
   );


   crc32_result_n <= not crc32_result;

   -- Outputs assignment

   RX_DATA        <= rx_data_i;
   RX_DV          <= rx_dv_i;
   RX_BE          <= rx_be_i;
   RX_ERR         <= rx_err_i;
   RX_ERR_VALID   <= rx_err_valid_i;

end architecture;
