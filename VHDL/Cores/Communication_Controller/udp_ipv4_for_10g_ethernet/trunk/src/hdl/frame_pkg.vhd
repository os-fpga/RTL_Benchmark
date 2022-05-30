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
-- This package is collection of types and constants that are shared between
-- several modules in the UDP/IPv4 frame processing components.
--
--
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package frame_pkg is

   -- Type to hold MAC and IP addresses and UDP ports
   subtype mac_addr_type is std_logic_vector(47 downto 0);
   type mac_addr_array_type is array (natural range <>) of mac_addr_type;

   subtype ip_addr_type is std_logic_vector(31 downto 0);
   type ip_addr_array_type is array (natural range <>) of ip_addr_type;

   subtype udp_port_type is std_logic_vector(15 downto 0);
   type udp_port_array_type is array (natural range <>) of udp_port_type;


   -- Types for 64 bit data ports
   subtype data64_port_type is std_logic_vector(63 downto 0);
   type data64_port_array_type is array (natural range <>) of data64_port_type;


   -- Frame process constants and types
   constant C_FP_TAG_LENGTH_BITLEN : integer := 16;
   constant C_FP_TAG_RET_INFO_LENGTH_BITLEN : integer := 
                                             C_FP_TAG_LENGTH_BITLEN +16;
   constant C_FP_TAG_FLAGS_BITLEN : integer := 2;

   constant C_FP_TAG_UDP : std_logic_vector
                  (C_FP_TAG_FLAGS_BITLEN - 1 downto 0) := "01";
   constant C_FP_TAG_DISCARD : std_logic_vector
                  (C_FP_TAG_FLAGS_BITLEN - 1 downto 0) := "10";
   constant C_FP_TAG_RETINF : std_logic_vector
                  (C_FP_TAG_FLAGS_BITLEN - 1 downto 0) := "00";
                  
                  

   -- Type for tag fifo 2b flags + 32bit return info or length
   subtype fp_tfifo_data_type is std_logic_vector(C_FP_TAG_FLAGS_BITLEN + C_FP_TAG_RET_INFO_LENGTH_BITLEN  - 1 downto 0);
   subtype fp_dfifo_data_type is std_logic_vector(71 downto 0);


   subtype txi_tfifo_data_type is std_logic_vector(C_FP_TAG_LENGTH_BITLEN - 1 downto 0);
   subtype txi_dfifo_data_type is std_logic_vector(71 downto 0);
   

   -- Mainly for CMP registers
   subtype data32_port_type is std_logic_vector(31 downto 0);
   type data32_port_array_type is array (natural range <>) of data32_port_type;


   -- Function that sets one bit only according to addr
   function one_of_n(vec_len: integer; addr : integer) return std_logic_vector;
   function one_of_n(vec: std_logic_vector; addr : integer) return std_logic_vector;
   -- Returns position of the first bit
   function first_bit_set(vec : std_logic_vector) return integer;

   -- Returns number of bits in 1
   function num_of_ones(vec : std_logic_vector) return integer;

end package;

package body frame_pkg is

   -- Returns vector of length of vec with one bit set only at
   -- position addr
   function one_of_n(vec: std_logic_vector; addr : integer) return std_logic_vector is
      variable res : std_logic_vector(vec'range) := (others => '0');
   begin
      res(addr) := '1';
      return res;
   end function;
   -- Returns vector of length of vec_len with one bit set only at
   -- position addr
   function one_of_n(vec_len: integer; addr : integer) return std_logic_vector is
      variable res : std_logic_vector(vec_len - 1 downto 0) := (others => '0');
   begin
      res(addr) := '1';
      return res;
   end function;

   function first_bit_set(vec : std_logic_vector) return integer is   
   begin
      -- find first bit set
      for i in vec'range loop
         if vec(i) = '1' then
            return i;
         end if;
      end loop;
      return 0;
   end function;

   -- Returns number of bits in 1
   function num_of_ones(vec : std_logic_vector) return integer is
      variable res   : integer := 0;
   begin
      for i in 0 to vec'left loop
         if vec(i) = '1' then
            res := res + 1;
         end if;
      end loop;

      return res;
   end function;

end package body;

