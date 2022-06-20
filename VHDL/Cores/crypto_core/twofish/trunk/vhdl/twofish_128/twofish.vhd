-- Twofish.vhd
-- Copyright (C) 2006 Spyros Ninos
--
-- This program is free software; you can redistribute it and/or modify 
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation; either version 2 of the License, or
-- (at your option) any later version.
-- 
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
-- 
-- You should have received a copy of the GNU General Public License
-- along with this library; see the file COPYING.  If not, write to:
-- 
-- Free Software Foundation
-- 59 Temple Place - Suite 330
-- Boston, MA  02111-1307, USA.

-- description	: 	this file includes all the components necessary to perform symmetric encryption
--					with the twofish 128 bit block cipher. Within there are four main parts of the file.
--					the first part is the twofish crypto primitives which are independent of the key
--					input length, the second part is the 128 bit key input components, the third part 
--					is the 192 bit key components and finaly the 256 bit key input components
--


-- ====================================================== --
-- ====================================================== --
--												  		  --
-- first part: key input independent component primitives --
--												  		  --
-- ====================================================== --
-- ====================================================== --

-- 
-- q0
--

library ieee;
Use ieee.std_logic_1164.all;

entity q0 is
port	(
		in_q0 	: in std_logic_vector(7 downto 0);
		out_q0	: out std_logic_vector(7 downto 0)
		);
end q0;

architecture q0_arch of q0 is

	-- declaring internal signals
	signal	a0,b0,
			a1,b1,
			a2,b2,
			a3,b3,
			a4,b4		: std_logic_vector(3 downto 0);
	signal	b0_ror4,
			a0_times_8,
			b2_ror4,
			a2_times_8	: std_logic_vector(3 downto 0);

-- beginning of the architecture description
begin
	
	-- little endian
	b0 <= in_q0(3 downto 0);
	a0 <= in_q0(7 downto 4); 
	
	a1 <= a0 XOR b0;
	
	-- signal b0 is ror4'ed by 1 bit
	b0_ror4(2 downto 0) <= b0(3 downto 1);
	b0_ror4(3) <= b0(0);
	
	-- 8*a0 = 2^3*a0= a0 << 3
	a0_times_8(2 downto 0) <= (others => '0');
	a0_times_8(3) <= a0(0);
	
	b1 <= a0 XOR b0_ror4 XOR a0_times_8;

	--
	-- t0 table
	--
	with a1 select 
		a2 <=	"1000" when "0000", -- 8
			   	"0001" when "0001", -- 1
			   	"0111" when "0010", -- 7
			   	"1101" when "0011", -- D
			   	"0110" when "0100", -- 6
			   	"1111" when "0101", -- F
			   	"0011" when "0110", -- 3
			   	"0010" when "0111", -- 2
			  	"0000" when "1000", -- 0
			   	"1011" when "1001", -- B
			   	"0101" when "1010", -- 5
			   	"1001" when "1011", -- 9
			   	"1110" when "1100", -- E
			   	"1100" when "1101", -- C
			   	"1010" when "1110", -- A
			   	"0100" when others; -- 4

	--
	-- t1 table
	--
	with b1 select
		b2 <=	"1110" when "0000", -- E
				"1100" when "0001", -- C
				"1011" when "0010", -- B
				"1000" when "0011", -- 8
				"0001" when "0100", -- 1
				"0010" when "0101", -- 2
				"0011" when "0110", -- 3
				"0101" when "0111", -- 5
				"1111" when "1000", -- F
				"0100" when "1001", -- 4
				"1010" when "1010", -- A
				"0110" when "1011", -- 6
				"0111" when "1100", -- 7
				"0000" when "1101", -- 0
				"1001" when "1110", -- 9
				"1101" when others; -- D

	a3 <= a2 XOR b2;
	
	-- signal b2 is ror4'ed by 1 bit
	b2_ror4(2 downto 0) <= b2(3 downto 1);
	b2_ror4(3) <= b2(0);
	
	-- 8*a2 = 2^3*a2=a2<<3
	a2_times_8(2 downto 0) <= (others => '0');
	a2_times_8(3) <= a2(0);
	
	b3 <= a2 XOR b2_ror4 XOR a2_times_8;


	--
	-- t0 table
	--
	with a3 select
		a4 <=	"1011" when "0000", -- B
				"1010" when "0001", -- A
				"0101" when "0010", -- 5
				"1110" when "0011", -- E
				"0110" when "0100", -- 6
				"1101" when "0101", -- D
				"1001" when "0110", -- 9
				"0000" when "0111", -- 0
				"1100" when "1000", -- C
				"1000" when "1001", -- 8
				"1111" when "1010", -- F
				"0011" when "1011", -- 3
				"0010" when "1100", -- 2
				"0100" when "1101", -- 4
				"0111" when "1110", -- 7
				"0001" when others; -- 1

	--
	-- t1 table
	--
	with b3 select
		b4 <=	"1101" when "0000", -- D
				"0111" when "0001", -- 7
				"1111" when "0010", -- F
				"0100" when "0011", -- 4
				"0001" when "0100", -- 1
				"0010" when "0101", -- 2
				"0110" when "0110", -- 6
				"1110" when "0111", -- E
				"1001" when "1000", -- 9
				"1011" when "1001", -- B
				"0011" when "1010", -- 3
				"0000" when "1011", -- 0
				"1000" when "1100", -- 8
				"0101" when "1101", -- 5
				"1100" when "1110", -- C
				"1010" when others; -- A
 	
	-- the output of q0
	out_q0 <= b4 & a4;

end q0_arch;


-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ --
--																			--
-- 								new component								--
--																			--
-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ --

--
-- q1
--

library ieee;
Use ieee.std_logic_1164.all;

entity q1 is
port	(
		in_q1 	: in std_logic_vector(7 downto 0);
		out_q1	: out std_logic_vector(7 downto 0)
		);
end q1;

-- architecture description
architecture q1_arch of q1 is

	-- declaring the internal signals
	signal	a0,b0,
			a1,b1,
			a2,b2,
			a3,b3,
			a4,b4		: std_logic_vector(3 downto 0);
	signal	b0_ror4,
			a0_times_8,
			b2_ror4,
			a2_times_8	: std_logic_vector(3 downto 0);

-- begin the architecture description
begin
	
	-- little endian
	b0 <= in_q1(3 downto 0);
	a0 <= in_q1(7 downto 4); 
	
	a1 <= a0 XOR b0;
	
	-- signal b0 is ror4'ed by 1 bit
	b0_ror4(2 downto 0) <= b0(3 downto 1);
	b0_ror4(3) <= b0(0);
	
	-- 8*a0 = 2^3*a0=a0<<3
	a0_times_8(2 downto 0) <= (others => '0');
	a0_times_8(3) <= a0(0);
	
	b1 <= a0 XOR b0_ror4 XOR a0_times_8;

	--
	-- t0 table
	--
	with a1 select 
		a2 <=	"0010" when "0000", -- 2
			   	"1000" when "0001", -- 8
			   	"1011" when "0010", -- b
			   	"1101" when "0011", -- d
			   	"1111" when "0100", -- f
			   	"0111" when "0101", -- 7
			   	"0110" when "0110", -- 6
			   	"1110" when "0111", -- e
			  	"0011" when "1000", -- 3
			   	"0001" when "1001", -- 1
			   	"1001" when "1010", -- 9
			   	"0100" when "1011", -- 4
			   	"0000" when "1100", -- 0
			   	"1010" when "1101", -- a
			   	"1100" when "1110", -- c
			   	"0101" when others; -- 5

	--
	-- t1 table
	--
	with b1 select
		b2 <=	"0001" when "0000", -- 1
				"1110" when "0001", -- e
				"0010" when "0010", -- 2
				"1011" when "0011", -- b
				"0100" when "0100", -- 4
				"1100" when "0101", -- c
				"0011" when "0110", -- 3
				"0111" when "0111", -- 7
				"0110" when "1000", -- 6
				"1101" when "1001", -- d
				"1010" when "1010", -- a
				"0101" when "1011", -- 5
				"1111" when "1100", -- f
				"1001" when "1101", -- 9
				"0000" when "1110", -- 0
				"1000" when others; -- 8

	a3 <= a2 XOR b2;
	
	-- signal b2 is ror4'ed by 1	bit
	b2_ror4(2 downto 0) <= b2(3 downto 1);
	b2_ror4(3) <= b2(0);
	
	-- 8*a2 = 2^3*a2=a2<<3
	a2_times_8(2 downto 0) <= (others => '0');
	a2_times_8(3) <= a2(0);
	
	b3 <= a2 XOR b2_ror4 XOR a2_times_8;

	--
	-- t0 table
	--
	with a3 select
		a4 <=	"0100" when "0000", -- 4
				"1100" when "0001", -- c
				"0111" when "0010", -- 7
				"0101" when "0011", -- 5
				"0001" when "0100", -- 1
				"0110" when "0101", -- 6
				"1001" when "0110", -- 9
				"1010" when "0111", -- a
				"0000" when "1000", -- 0
				"1110" when "1001", -- e
				"1101" when "1010", -- d
				"1000" when "1011", -- 8
				"0010" when "1100", -- 2
				"1011" when "1101", -- b
				"0011" when "1110", -- 3
				"1111" when others; -- f

	--
	-- t1 table
	--
	with b3 select
		b4 <=	"1011" when "0000", -- b
				"1001" when "0001", -- 9
				"0101" when "0010", -- 5
				"0001" when "0011", -- 1
				"1100" when "0100", -- c
				"0011" when "0101", -- 3
				"1101" when "0110", -- d
				"1110" when "0111", -- e
				"0110" when "1000", -- 6
				"0100" when "1001", -- 4
				"0111" when "1010", -- 7
				"1111" when "1011", -- f
				"0010" when "1100", -- 2
				"0000" when "1101", -- 0
				"1000" when "1110", -- 8
				"1010" when others; -- a
 	
	-- output of q1
	out_q1 <= b4 & a4;

end q1_arch;



-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ --
--																			--
-- 								new component								--
--																			--
-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ --

--
-- ef multiplier
--

library ieee;
use ieee.std_logic_1164.all;

entity mul_ef is
port	(
		in_ef 	: in std_logic_vector(7 downto 0);
		out_ef 	: out std_logic_vector(7 downto 0)
		);
end mul_ef;


architecture mul_ef_arch of mul_ef is

begin
	out_ef(0) <= in_ef(2) XOR in_ef(1) XOR in_ef(0);
	out_ef(1) <= in_ef(3) XOR in_ef(2) XOR in_ef(1) XOR in_ef(0);
	out_ef(2) <= in_ef(4) XOR in_ef(3) XOR in_ef(2) XOR in_ef(1) XOR in_ef(0);
	out_ef(3) <= in_ef(5) XOR in_ef(4) XOR in_ef(3) XOR in_ef(0);
	out_ef(4) <= in_ef(6) XOR in_ef(5) XOR in_ef(4) XOR in_ef(1);
	out_ef(5) <= in_ef(7) XOR in_ef(6) XOR in_ef(5) XOR in_ef(1) XOR in_ef(0);
	out_ef(6) <= in_ef(7) XOR in_ef(6) XOR in_ef(0);
	out_ef(7) <= in_ef(7) XOR in_ef(1) XOR in_ef(0);
end mul_ef_arch;


-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ --
--																			--
-- 								new component								--
--																			--
-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ --


--
-- 5b multiplier
--

library ieee;
use ieee.std_logic_1164.all;

entity mul_5b is
port	(
		in_5b 	: in std_logic_vector(7 downto 0);
		out_5b 	: out std_logic_vector(7 downto 0)
		);
end mul_5b;

architecture mul_5b_arch of mul_5b is
begin
	out_5b(0) <= in_5b(2) XOR in_5b(0);
	out_5b(1) <= in_5b(3) XOR in_5b(1) XOR in_5b(0);
	out_5b(2) <= in_5b(4) XOR in_5b(2) XOR in_5b(1);
	out_5b(3) <= in_5b(5) XOR in_5b(3) XOR in_5b(0);
	out_5b(4) <= in_5b(6) XOR in_5b(4) XOR in_5b(1) XOR in_5b(0);
	out_5b(5) <= in_5b(7) XOR in_5b(5) XOR in_5b(1);
	out_5b(6) <= in_5b(6) XOR in_5b(0);
	out_5b(7) <= in_5b(7) XOR in_5b(1);
end mul_5b_arch;

-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ --
--																			--
-- 								new component								--
--																			--
-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ --

--
-- mds
--

library ieee;
use ieee.std_logic_1164.all;

entity mds is
port	(
		y0,
		y1,
		y2,
		y3	: in std_logic_vector(7 downto 0);
		z0,
		z1,
		z2,
		z3	: out std_logic_vector(7 downto 0)
		);
end mds;


-- architecture description of mds component
architecture mds_arch of mds is

	-- we declare the multiplier by ef
 	component mul_ef
 	port	( 
			in_ef : in std_logic_vector(7 downto 0);
			out_ef : out std_logic_vector(7 downto 0)
			);
 	end component;

	-- we declare the multiplier by 5b
 	component mul_5b
 	port	(
			in_5b : in std_logic_vector(7 downto 0);
			out_5b : out std_logic_vector(7 downto 0)
			);
 	end component;

	-- we declare the multiplier's outputs
 	signal 	y0_ef, y0_5b,
			y1_ef, y1_5b,
			y2_ef, y2_5b,
			y3_ef, y3_5b	: std_logic_vector(7 downto 0);

begin

	-- we perform the signal multiplication
	y0_times_ef: mul_ef
	port map	(
				in_ef => y0,
				out_ef => y0_ef
				);

	y0_times_5b: mul_5b
	port map	(
				in_5b => y0,
				out_5b => y0_5b
				);

	y1_times_ef: mul_ef
	port map	(
				in_ef => y1,
				out_ef => y1_ef
				);

	y1_times_5b: mul_5b
	port map	(
				in_5b => y1,
				out_5b => y1_5b
				);

	y2_times_ef: mul_ef
	port map	(
				in_ef => y2,
				out_ef => y2_ef
				);

	y2_times_5b: mul_5b
	port map	(
				in_5b => y2,
				out_5b => y2_5b
				);

	y3_times_ef: mul_ef
	port map	(
				in_ef => y3,
				out_ef => y3_ef
				);

	y3_times_5b: mul_5b
	port map	(
				in_5b => y3,
				out_5b => y3_5b
				);

	-- we perform the addition of the partial results in order to receive
	-- the table output

	-- z0 = y0*01 + y1*ef + y2*5b + y3*5b , opoy + bazoyme XOR
	 z0 <= y0 XOR y1_ef XOR y2_5b XOR y3_5b;
	
	-- z1 = y0*5b + y1*ef + y2*ef + y3*01
	 z1 <= y0_5b XOR y1_ef XOR y2_ef XOR y3;

	-- z2 = y0*ef + y1*5b + y2*01 +y3*ef
	 z2 <= y0_ef XOR y1_5b XOR y2 XOR y3_ef;

	-- z3 = y0*ef + y1*01 + y2*ef + y3*5b
	 z3 <= y0_ef XOR y1 XOR y2_ef XOR y3_5b;

end mds_arch;


-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ --
--																			--
-- 								new component								--
--																			--
-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ --

--
-- 1 bit adder
--

library ieee;
use ieee.std_logic_1164.all;

entity adder is
port	(
		in1_adder,
		in2_adder,
		in_carry_adder	: in std_logic;
		out_adder,
		out_carry_adder	: out std_logic
		);
end adder;

architecture adder_arch of adder is
begin

	out_adder <= in_carry_adder XOR in1_adder XOR in2_adder;
	out_carry_adder <= (in_carry_adder AND (in1_adder XOR in2_adder)) OR (in1_adder AND in2_adder);
	
end adder_arch;
			   

-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ --
--																			--
-- 								new component								--
--																			--
-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ --

--
-- pht
--

  library ieee;
  use ieee.std_logic_1164.all;
  
  entity pht is
  port	(
  		up_in_pht,
  		down_in_pht		: in std_logic_vector(31 downto 0);
  		up_out_pht,
  		down_out_pht	: out std_logic_vector(31 downto 0)
  		);
  end pht;
  
  
  -- architecture description
  architecture pht_arch of pht is
  
  	-- we declare internal signals
  	signal	intermediate_carry1,
  			intermediate_carry2,
  			to_upper_out			: std_logic_vector(31 downto 0);
  	signal	zero					: std_logic;
  	
  	component adder
  	port	(
  			in1_adder,
  			in2_adder,
  			in_carry_adder	: in std_logic;
  			out_adder,
  			out_carry_adder	: out std_logic
  			);
  	end component;
  					 
  begin
  	
  	-- initializing zero signal
  	zero <= '0';
  	
  	-- instantiating the upper adder of 32 bits
  	up_adder: for i in 0 to 31 generate
  		adder_one: if (i=0) generate
  			the_adder: adder
  			port map	(
  						in1_adder => up_in_pht(0),
  						in2_adder => down_in_pht(0),
  						in_carry_adder => zero,
  						out_adder => to_upper_out(0),
  						out_carry_adder => intermediate_carry1(0)
  						);
  		end generate adder_one;
  		rest_adders: if (i>0) generate
  			next_adder: adder 
  			port map	(
  						in1_adder => up_in_pht(i),
  						in2_adder => down_in_pht(i),
  						in_carry_adder => intermediate_carry1(i-1),
  						out_adder => to_upper_out(i),
  						out_carry_adder => intermediate_carry1(i)
  						);
  		end generate rest_adders;
  	end generate up_adder;
  	
  	--intermediate_carry1(31) <= '0';
  	
  	-- receiving the upper pht output
  	up_out_pht <= to_upper_out;
  	
  	-- instantiating the lower adder of 32 bits
  	down_adder: for i in 0 to 31 generate
  		adder_one_1: if (i=0) generate
  			the_adder_1: adder
  			port map	(
  						in1_adder => down_in_pht(0),
  						in2_adder => to_upper_out(0),
  						in_carry_adder => zero,
  						out_adder => down_out_pht(0),
  						out_carry_adder => intermediate_carry2(0)
  						);
  		end generate adder_one_1;
  		rest_adders_1: if (i>0) generate
  			next_adder_1: adder
  			port map	(
  						in1_adder => down_in_pht(i),
  						in2_adder => to_upper_out(i),
  						in_carry_adder => intermediate_carry2(i-1),
  						out_adder => down_out_pht(i),
  						out_carry_adder => intermediate_carry2(i)
  						);
  		end generate rest_adders_1;
  	end generate down_adder;
  	
  	--intermediate_carry2(31) <= '0';
  	
  end pht_arch;


-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ --
--																			--
-- 								new component								--
--																			--
-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ --

-- 						
--	multiplier by 01	
--						

library ieee;
use ieee.std_logic_1164.all;

entity mul01 is
port	(
		in_mul01	: in std_logic_vector(7 downto 0);
		out_mul01	: out std_logic_vector(7 downto 0)
		);
end mul01;
						
architecture mul01_arch of mul01 is
begin
	out_mul01 <= in_mul01;
end mul01_arch;


-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ --
--																			--
-- 								new component								--
--																			--
-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ --

-- 						
--	multiplier by a4	
--						

library ieee;
use ieee.std_logic_1164.all;

entity mula4 is
port	(
		in_mula4	: in std_logic_vector(7 downto 0);			
		out_mula4	: out std_logic_vector(7 downto 0)
		);
end mula4;

architecture mula4_arch of mula4 is
begin
	out_mula4(0) <= in_mula4(7) xor in_mula4(1);
	out_mula4(1) <= in_mula4(2);
	out_mula4(2) <= in_mula4(7) xor in_mula4(3) xor in_mula4(1) xor in_mula4(0);
	out_mula4(3) <= in_mula4(7) xor in_mula4(4) xor in_mula4(2);
	out_mula4(4) <= in_mula4(5) xor in_mula4(3);
	out_mula4(5) <= in_mula4(6) xor in_mula4(4) xor in_mula4(0);
	out_mula4(6) <= in_mula4(5);
	out_mula4(7) <= in_mula4(6) xor in_mula4(0);
end mula4_arch;


-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ --
--																			--
-- 								new component								--
--																			--
-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ --

-- 						
--	multiplier by 55	
--						

library ieee;
use ieee.std_logic_1164.all;

entity mul55 is
port	(
		in_mul55	: in std_logic_vector(7 downto 0);
		out_mul55	: out std_logic_vector(7 downto 0)
		);
end mul55;

architecture mul55_arch of mul55 is
begin
	out_mul55(0) <= in_mul55(7) xor in_mul55(6) xor in_mul55(2) xor in_mul55(0);
	out_mul55(1) <= in_mul55(7) xor in_mul55(3) xor in_mul55(1);
	out_mul55(2) <= in_mul55(7) xor in_mul55(6) xor in_mul55(4) xor in_mul55(0);
	out_mul55(3) <= in_mul55(6) xor in_mul55(5) xor in_mul55(2) xor in_mul55(1);
	out_mul55(4) <= in_mul55(7) xor in_mul55(6) xor in_mul55(3) xor in_mul55(2) xor in_mul55(0);
	out_mul55(5) <= in_mul55(7) xor in_mul55(4) xor in_mul55(3) xor in_mul55(1);
	out_mul55(6) <= in_mul55(7) xor in_mul55(6) xor in_mul55(5) xor in_mul55(4) xor in_mul55(0);
	out_mul55(7) <= in_mul55(7) xor in_mul55(6) xor in_mul55(5) xor in_mul55(1);
end mul55_arch;
			  

-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ --
--																			--
-- 								new component								--
--																			--
-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ --

-- 						
--	multiplier by 87	
--						

library ieee;
use ieee.std_logic_1164.all;

entity mul87 is
port	(
		in_mul87	: in std_logic_vector(7 downto 0);
		out_mul87	: out std_logic_vector(7 downto 0)
		);
end mul87;

architecture mul87_arch of mul87 is
begin
	out_mul87(0) <= in_mul87(7) xor in_mul87(5) xor in_mul87(3) xor in_mul87(1) xor in_mul87(0);
	out_mul87(1) <= in_mul87(6) xor in_mul87(4) xor in_mul87(2) xor in_mul87(1) xor in_mul87(0);
	out_mul87(2) <= in_mul87(2) xor in_mul87(0);
	out_mul87(3) <= in_mul87(7) xor in_mul87(5);
	out_mul87(4) <= in_mul87(6);
	out_mul87(5) <= in_mul87(7);
	out_mul87(6) <= in_mul87(7) xor in_mul87(5) xor in_mul87(3) xor in_mul87(1);
	out_mul87(7) <= in_mul87(6) xor in_mul87(4) xor in_mul87(2) xor in_mul87(0);
end mul87_arch;


-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ --
--																			--
-- 								new component								--
--																			--
-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ --

-- 					
--	multiplier by 5a
--					

library ieee;
use ieee.std_logic_1164.all;

entity mul5a is
port	(
		in_mul5a	: in std_logic_vector(7 downto 0);
		out_mul5a	: out std_logic_vector(7 downto 0)
		);
end mul5a;

architecture mul5a_arch of mul5a is
begin
	out_mul5a(0) <= in_mul5a(7) xor in_mul5a(5) xor in_mul5a(2);
	out_mul5a(1) <= in_mul5a(6) xor in_mul5a(3) xor in_mul5a(0);
	out_mul5a(2) <= in_mul5a(5) xor in_mul5a(4) xor in_mul5a(2) xor in_mul5a(1);
	out_mul5a(3) <= in_mul5a(7) xor in_mul5a(6) xor in_mul5a(3) xor in_mul5a(0);
	out_mul5a(4) <= in_mul5a(7) xor in_mul5a(4) xor in_mul5a(1) xor in_mul5a(0);
	out_mul5a(5) <= in_mul5a(5) xor in_mul5a(2) xor in_mul5a(1);
	out_mul5a(6) <= in_mul5a(7) xor in_mul5a(6) xor in_mul5a(5) xor in_mul5a(3) xor in_mul5a(0);
	out_mul5a(7) <= in_mul5a(7) xor in_mul5a(6) xor in_mul5a(4) xor in_mul5a(1);
end mul5a_arch;


-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ --
--																			--
-- 								new component								--
--																			--
-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ --

-- 					
--	multiplier by 58
--					

library ieee;
use ieee.std_logic_1164.all;

entity mul58 is 
port	(
		in_mul58	: in std_logic_vector(7 downto 0);
		out_mul58	: out std_logic_vector(7 downto 0)
		);
end mul58;

architecture mul58_arch of mul58 is
begin
	out_mul58(0) <= in_mul58(5) xor in_mul58(2);
	out_mul58(1) <= in_mul58(6) xor in_mul58(3);
	out_mul58(2) <= in_mul58(7) xor in_mul58(5) xor in_mul58(4) xor in_mul58(2);
	out_mul58(3) <= in_mul58(6) xor in_mul58(3) xor in_mul58(2) xor in_mul58(0);
	out_mul58(4) <= in_mul58(7) xor in_mul58(4) xor in_mul58(3) xor in_mul58(1) xor in_mul58(0);
	out_mul58(5) <= in_mul58(5) xor in_mul58(4) xor in_mul58(2) xor in_mul58(1);
	out_mul58(6) <= in_mul58(6) xor in_mul58(3) xor in_mul58(0);
	out_mul58(7) <= in_mul58(7) xor in_mul58(4) xor in_mul58(1);
end mul58_arch;


-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ --
--																			--
-- 								new component								--
--																			--
-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ --

-- 						
--	multiplier by db	
--						

library ieee;
use ieee.std_logic_1164.all;

entity muldb is
port	(
		in_muldb	: in std_logic_vector(7 downto 0);
		out_muldb	: out std_logic_vector(7 downto 0)
		);
end muldb;

architecture muldb_arch of muldb is
begin
	out_muldb(0) <= in_muldb(7) xor in_muldb(6) xor in_muldb(3) xor in_muldb(2) xor in_muldb(1) xor in_muldb(0);
	out_muldb(1) <= in_muldb(7) xor in_muldb(4) xor in_muldb(3) xor in_muldb(2) xor in_muldb(1) xor in_muldb(0);
	out_muldb(2) <= in_muldb(7) xor in_muldb(6) xor in_muldb(5) xor in_muldb(4);
	out_muldb(3) <= in_muldb(5) xor in_muldb(3) xor in_muldb(2) xor in_muldb(1) xor in_muldb(0);
	out_muldb(4) <= in_muldb(6) xor in_muldb(4) xor in_muldb(3) xor in_muldb(2) xor in_muldb(1) xor in_muldb(0);
	out_muldb(5) <= in_muldb(7) xor in_muldb(5) xor in_muldb(4) xor in_muldb(3) xor in_muldb(2) xor in_muldb(1);
	out_muldb(6) <= in_muldb(7) xor in_muldb(5) xor in_muldb(4) xor in_muldb(1) xor in_muldb(0);
	out_muldb(7) <= in_muldb(6) xor in_muldb(5) xor in_muldb(2) xor in_muldb(1) xor in_muldb(0);
end muldb_arch;


-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ --
--																			--
-- 								new component								--
--																			--
-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ --

-- 						
--	multiplier by 9e	
--						

library ieee;
use ieee.std_logic_1164.all;

entity mul9e is
port	(
		in_mul9e	: in std_logic_vector(7 downto 0);
		out_mul9e	: out std_logic_vector(7 downto 0)
		);
end mul9e;

architecture mul9e_arch of mul9e is
begin
	out_mul9e(0) <= in_mul9e(6) xor in_mul9e(4) xor in_mul9e(3) xor in_mul9e(1);
	out_mul9e(1) <= in_mul9e(7) xor in_mul9e(5) xor in_mul9e(4) xor in_mul9e(2) xor in_mul9e(0);
	out_mul9e(2) <= in_mul9e(5) xor in_mul9e(4) xor in_mul9e(0);
	out_mul9e(3) <= in_mul9e(5) xor in_mul9e(4) xor in_mul9e(3) xor in_mul9e(0);
	out_mul9e(4) <= in_mul9e(6) xor in_mul9e(5) xor in_mul9e(4) xor in_mul9e(1) xor in_mul9e(0);
	out_mul9e(5) <= in_mul9e(7) xor in_mul9e(6) xor in_mul9e(5) xor in_mul9e(2) xor in_mul9e(1);
	out_mul9e(6) <= in_mul9e(7) xor in_mul9e(4) xor in_mul9e(2) xor in_mul9e(1);
	out_mul9e(7) <= in_mul9e(5) xor in_mul9e(3) xor in_mul9e(2) xor in_mul9e(0);
end mul9e_arch;


-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ --
--																			--
-- 								new component								--
--																			--
-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ --

-- 						
--	multiplier by 56	
--						

library ieee;
use ieee.std_logic_1164.all;

entity mul56 is
port	(
		in_mul56	: in std_logic_vector(7 downto 0);
		out_mul56	: out std_logic_vector(7 downto 0)
		);
end mul56;

architecture mul56_arch of mul56 is
begin
	out_mul56(0) <= in_mul56(6) xor in_mul56(2);
	out_mul56(1) <= in_mul56(7) xor in_mul56(3) xor in_mul56(0);
	out_mul56(2) <= in_mul56(6) xor in_mul56(4) xor in_mul56(2) xor in_mul56(1) xor in_mul56(0);
	out_mul56(3) <= in_mul56(7) xor in_mul56(6) xor in_mul56(5) xor in_mul56(3) xor in_mul56(1);
	out_mul56(4) <= in_mul56(7) xor in_mul56(6) xor in_mul56(4) xor in_mul56(2) xor in_mul56(0);
	out_mul56(5) <= in_mul56(7) xor in_mul56(5) xor in_mul56(3) xor in_mul56(1);
	out_mul56(6) <= in_mul56(4) xor in_mul56(0);
	out_mul56(7) <= in_mul56(5) xor in_mul56(1);
end mul56_arch;


-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ --
--																			--
-- 								new component								--
--																			--
-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ --

-- 						
--	multiplier by 82	
--						

library ieee;
use ieee.std_logic_1164.all;

entity mul82 is
port	(
		in_mul82	: in std_logic_vector(7 downto 0);
		out_mul82	: out std_logic_vector(7 downto 0)
		);
end mul82;

architecture mul82_arch of mul82 is
begin
	out_mul82(0) <= in_mul82(7) xor in_mul82(6) xor in_mul82(5) xor in_mul82(3) xor in_mul82(1);
	out_mul82(1) <= in_mul82(7) xor in_mul82(6) xor in_mul82(4) xor in_mul82(2) xor in_mul82(0);
	out_mul82(2) <= in_mul82(6);
	out_mul82(3) <= in_mul82(6) xor in_mul82(5) xor in_mul82(3) xor in_mul82(1);
	out_mul82(4) <= in_mul82(7) xor in_mul82(6) xor in_mul82(4) xor in_mul82(2);
	out_mul82(5) <= in_mul82(7) xor in_mul82(5) xor in_mul82(3);
	out_mul82(6) <= in_mul82(7) xor in_mul82(5) xor in_mul82(4) xor in_mul82(3) xor in_mul82(1);
	out_mul82(7) <= in_mul82(6) xor in_mul82(5) xor in_mul82(4) xor in_mul82(2) xor in_mul82(0);
end mul82_arch;


-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ --
--																			--
-- 								new component								--
--																			--
-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ --

-- 						
--	multiplier by f3	
--						

library ieee;
use ieee.std_logic_1164.all;

entity mulf3 is
port	(
		in_mulf3	: in std_logic_vector(7 downto 0);
		out_mulf3	: out std_logic_vector(7 downto 0)
		);
end mulf3;

architecture mulf3_arch of mulf3 is
begin
	out_mulf3(0) <= in_mulf3(7) xor in_mulf3(6) xor in_mulf3(2) xor in_mulf3(1) xor in_mulf3(0);
	out_mulf3(1) <= in_mulf3(7) xor in_mulf3(3) xor in_mulf3(2) xor in_mulf3(1) xor in_mulf3(0);
	out_mulf3(2) <= in_mulf3(7) xor in_mulf3(6) xor in_mulf3(4) xor in_mulf3(3);
	out_mulf3(3) <= in_mulf3(6) xor in_mulf3(5) xor in_mulf3(4) xor in_mulf3(2) xor in_mulf3(1);
	out_mulf3(4) <= in_mulf3(7) xor in_mulf3(6) xor in_mulf3(5) xor in_mulf3(3) xor in_mulf3(2) xor in_mulf3(0);
	out_mulf3(5) <= in_mulf3(7) xor in_mulf3(6) xor in_mulf3(4) xor in_mulf3(3) xor in_mulf3(1) xor in_mulf3(0);
	out_mulf3(6) <= in_mulf3(6) xor in_mulf3(5) xor in_mulf3(4) xor in_mulf3(0);
	out_mulf3(7) <= in_mulf3(7) xor in_mulf3(6) xor in_mulf3(5) xor in_mulf3(1) xor in_mulf3(0);
end mulf3_arch;


-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ --
--																			--
-- 								new component								--
--																			--
-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ --

-- 						
--	multiplier by 1e	
--						


library ieee;
use ieee.std_logic_1164.all;

entity mul1e is
port	(
		in_mul1e	: in std_logic_vector(7 downto 0);
		out_mul1e	: out std_logic_vector(7 downto 0)
		);
end mul1e;

architecture mul1e_arch of mul1e is
begin
	out_mul1e(0) <= in_mul1e(5) xor in_mul1e(4);
	out_mul1e(1) <= in_mul1e(6) xor in_mul1e(5) xor in_mul1e(0);
	out_mul1e(2) <= in_mul1e(7) xor in_mul1e(6) xor in_mul1e(5) xor in_mul1e(4) xor in_mul1e(1) xor in_mul1e(0);
	out_mul1e(3) <= in_mul1e(7) xor in_mul1e(6) xor in_mul1e(4) xor in_mul1e(2) xor in_mul1e(1) xor in_mul1e(0);
	out_mul1e(4) <= in_mul1e(7) xor in_mul1e(5) xor in_mul1e(3) xor in_mul1e(2) xor in_mul1e(1) xor in_mul1e(0);
	out_mul1e(5) <= in_mul1e(6) xor in_mul1e(4) xor in_mul1e(3) xor in_mul1e(2) xor in_mul1e(1);
	out_mul1e(6) <= in_mul1e(7) xor in_mul1e(3) xor in_mul1e(2);
	out_mul1e(7) <= in_mul1e(4) xor in_mul1e(3);
end mul1e_arch;

-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ --
--																			--
-- 								new component								--
--																			--
-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ --

-- 						
--	multiplier by c6	
--						

library ieee;
use ieee.std_logic_1164.all;

entity mulc6 is
port	(
		in_mulc6	: in std_logic_vector(7 downto 0);
		out_mulc6	: out std_logic_vector(7 downto 0)
		);
end mulc6;

architecture mulc6_arch of mulc6 is
begin
	out_mulc6(0) <= in_mulc6(6) xor in_mulc6(5) xor in_mulc6(4) xor in_mulc6(3) xor in_mulc6(2) xor in_mulc6(1);
	out_mulc6(1) <= in_mulc6(7) xor in_mulc6(6) xor in_mulc6(5) xor in_mulc6(4) xor in_mulc6(3) xor in_mulc6(2) xor in_mulc6(0);
	out_mulc6(2) <= in_mulc6(7) xor in_mulc6(2) xor in_mulc6(0);
	out_mulc6(3) <= in_mulc6(6) xor in_mulc6(5) xor in_mulc6(4) xor in_mulc6(2);
	out_mulc6(4) <= in_mulc6(7) xor in_mulc6(6) xor in_mulc6(5) xor in_mulc6(3);
	out_mulc6(5) <= in_mulc6(7) xor in_mulc6(6) xor in_mulc6(4);
	out_mulc6(6) <= in_mulc6(7) xor in_mulc6(6) xor in_mulc6(4) xor in_mulc6(3) xor in_mulc6(2) xor in_mulc6(1) xor in_mulc6(0);
	out_mulc6(7) <= in_mulc6(7) xor in_mulc6(5) xor in_mulc6(4) xor in_mulc6(3) xor in_mulc6(2) xor in_mulc6(1) xor in_mulc6(0);
end mulc6_arch;


-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ --
--																			--
-- 								new component								--
--																			--
-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ --

-- 						
--	multiplier by 68	
--						

library ieee;
use ieee.std_logic_1164.all;

entity mul68 is
port	(
		in_mul68	: in std_logic_vector(7 downto 0);
		out_mul68	: out std_logic_vector(7 downto 0)
		);
end mul68;


architecture mul68_arch of mul68 is
begin
	out_mul68(0) <= in_mul68(7) xor in_mul68(6) xor in_mul68(4) xor in_mul68(3) xor in_mul68(2);
	out_mul68(1) <= in_mul68(7) xor in_mul68(5) xor in_mul68(4) xor in_mul68(3);
	out_mul68(2) <= in_mul68(7) xor in_mul68(5) xor in_mul68(3) xor in_mul68(2);
	out_mul68(3) <= in_mul68(7) xor in_mul68(2) xor in_mul68(0);
	out_mul68(4) <= in_mul68(3) xor in_mul68(1);
	out_mul68(5) <= in_mul68(4) xor in_mul68(2) xor in_mul68(0);
	out_mul68(6) <= in_mul68(7) xor in_mul68(6) xor in_mul68(5) xor in_mul68(4) xor in_mul68(2) xor in_mul68(1) xor in_mul68(0);
	out_mul68(7) <= in_mul68(7) xor in_mul68(6) xor in_mul68(5) xor in_mul68(3) xor in_mul68(2) xor in_mul68(1);
end mul68_arch;


-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ --
--																			--
-- 								new component								--
--																			--
-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ --

-- 						
--	multiplier by e5	
--						

library ieee;
use ieee.std_logic_1164.all;

entity mule5 is
port	(
		in_mule5	: in std_logic_vector(7 downto 0);
		out_mule5	: out std_logic_vector(7 downto 0)
		);
end mule5;


architecture mule5_arch of mule5 is
begin
	out_mule5(0) <= in_mule5(6) xor in_mule5(4) xor in_mule5(2) xor in_mule5(1) xor in_mule5(0);
	out_mule5(1) <= in_mule5(7) xor in_mule5(5) xor in_mule5(3) xor in_mule5(2) xor in_mule5(1);
	out_mule5(2) <= in_mule5(3) xor in_mule5(1) xor in_mule5(0);
	out_mule5(3) <= in_mule5(6);
	out_mule5(4) <= in_mule5(7);
	out_mule5(5) <= in_mule5(0);
	out_mule5(6) <= in_mule5(6) xor in_mule5(4) xor in_mule5(2) xor in_mule5(0);
	out_mule5(7) <= in_mule5(7) xor in_mule5(5) xor in_mule5(3) xor in_mule5(1) xor in_mule5(0);
end mule5_arch;


-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ --
--																			--
-- 								new component								--
--																			--
-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ --

-- 						
--	multiplier by 02	
--						

library ieee;
use ieee.std_logic_1164.all;

entity mul02 is
port	(
		in_mul02	: in std_logic_vector(7 downto 0);
		out_mul02	: out std_logic_vector(7 downto 0)
		);
end mul02;


architecture mul02_arch of mul02 is
begin
	out_mul02(0) <= in_mul02(7);
	out_mul02(1) <= in_mul02(0);
	out_mul02(2) <= in_mul02(7) xor in_mul02(1);
	out_mul02(3) <= in_mul02(7) xor in_mul02(2);
	out_mul02(4) <= in_mul02(3);
	out_mul02(5) <= in_mul02(4);
	out_mul02(6) <= in_mul02(7) xor in_mul02(5);
	out_mul02(7) <= in_mul02(6);
end mul02_arch;
			  

-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ --
--																			--
-- 								new component								--
--																			--
-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ --

-- 						
--	multiplier by a1	
--						

library ieee;
use ieee.std_logic_1164.all;

entity mula1 is
port	(
		in_mula1	: in std_logic_vector(7 downto 0);
		out_mula1	: out std_logic_vector(7 downto 0)
		);
end mula1;

architecture mula1_arch of mula1 is
begin
	out_mula1(0) <= in_mula1(7) xor in_mula1(6) xor in_mula1(1) xor in_mula1(0);
	out_mula1(1) <= in_mula1(7) xor in_mula1(2) xor in_mula1(1);
	out_mula1(2) <= in_mula1(7) xor in_mula1(6) xor in_mula1(3) xor in_mula1(2) xor in_mula1(1);
	out_mula1(3) <= in_mula1(6) xor in_mula1(4) xor in_mula1(3) xor in_mula1(2) xor in_mula1(1);
	out_mula1(4) <= in_mula1(7) xor in_mula1(5) xor in_mula1(4) xor in_mula1(3) xor in_mula1(2);
	out_mula1(5) <= in_mula1(6) xor in_mula1(5) xor in_mula1(4) xor in_mula1(3) xor in_mula1(0);
	out_mula1(6) <= in_mula1(5) xor in_mula1(4);
	out_mula1(7) <= in_mula1(6) xor in_mula1(5) xor in_mula1(0);
end mula1_arch;


-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ --
--																			--
-- 								new component								--
--																			--
-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ --

-- 						
--	multiplier by fc	
--						

library ieee;
use ieee.std_logic_1164.all;

entity mulfc is
port	(
		in_mulfc	: in std_logic_vector(7 downto 0);
		out_mulfc	: out std_logic_vector(7 downto 0)
		);
end mulfc;


architecture mulfc_arch of mulfc is
begin
	out_mulfc(0) <= in_mulfc(7) xor in_mulfc(5) xor in_mulfc(2) xor in_mulfc(1);
	out_mulfc(1) <= in_mulfc(6) xor in_mulfc(3) xor in_mulfc(2);
	out_mulfc(2) <= in_mulfc(5) xor in_mulfc(4) xor in_mulfc(3) xor in_mulfc(2) xor in_mulfc(1) xor in_mulfc(0);
	out_mulfc(3) <= in_mulfc(7) xor in_mulfc(6) xor in_mulfc(4) xor in_mulfc(3) xor in_mulfc(0);
	out_mulfc(4) <= in_mulfc(7) xor in_mulfc(5) xor in_mulfc(4) xor in_mulfc(1) xor in_mulfc(0);
	out_mulfc(5) <= in_mulfc(6) xor in_mulfc(5) xor in_mulfc(2) xor in_mulfc(1) xor in_mulfc(0);
	out_mulfc(6) <= in_mulfc(6) xor in_mulfc(5) xor in_mulfc(3) xor in_mulfc(0);
	out_mulfc(7) <= in_mulfc(7) xor in_mulfc(6) xor in_mulfc(4) xor in_mulfc(1) xor in_mulfc(0);
end mulfc_arch;


-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ --
--																			--
-- 								new component								--
--																			--
-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ --

-- 						
--	multiplier by c1	
--						

library ieee;
use ieee.std_logic_1164.all;

entity mulc1 is
port	(
		in_mulc1	: in std_logic_vector(7 downto 0);
		out_mulc1	: out std_logic_vector(7 downto 0)
		);
end mulc1;


architecture mulc1_arch of mulc1 is
begin
	out_mulc1(0) <= in_mulc1(7) xor in_mulc1(5) xor in_mulc1(4) xor in_mulc1(3) xor in_mulc1(2) xor in_mulc1(1) xor in_mulc1(0);
	out_mulc1(1) <= in_mulc1(6) xor in_mulc1(5) xor in_mulc1(4) xor in_mulc1(3) xor in_mulc1(2) xor in_mulc1(1);
	out_mulc1(2) <= in_mulc1(6) xor in_mulc1(1);
	out_mulc1(3) <= in_mulc1(5) xor in_mulc1(4) xor in_mulc1(3) xor in_mulc1(1);
	out_mulc1(4) <= in_mulc1(6) xor in_mulc1(5) xor in_mulc1(4) xor in_mulc1(2);
	out_mulc1(5) <= in_mulc1(7) xor in_mulc1(6) xor in_mulc1(5) xor in_mulc1(3);
	out_mulc1(6) <= in_mulc1(6) xor in_mulc1(5) xor in_mulc1(3) xor in_mulc1(2) xor in_mulc1(1) xor in_mulc1(0);
	out_mulc1(7) <= in_mulc1(7) xor in_mulc1(6) xor in_mulc1(4) xor in_mulc1(3) xor in_mulc1(2) xor in_mulc1(1) xor in_mulc1(0);
end mulc1_arch;


-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ --
--																			--
-- 								new component								--
--																			--
-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ --

-- 						
--	multiplier by 47	
--						

library ieee;
use ieee.std_logic_1164.all;

entity mul47 is
port	(
		in_mul47	: in std_logic_vector(7 downto 0);
		out_mul47	: out std_logic_vector(7 downto 0)
		);
end mul47;

architecture mul47_arch of mul47 is
begin
	out_mul47(0) <= in_mul47(4) xor in_mul47(2) xor in_mul47(0);
	out_mul47(1) <= in_mul47(5) xor in_mul47(3) xor in_mul47(1) xor in_mul47(0);
	out_mul47(2) <= in_mul47(6) xor in_mul47(1) xor in_mul47(0);
	out_mul47(3) <= in_mul47(7) xor in_mul47(4) xor in_mul47(1);
	out_mul47(4) <= in_mul47(5) xor in_mul47(2);
	out_mul47(5) <= in_mul47(6) xor in_mul47(3);
	out_mul47(6) <= in_mul47(7) xor in_mul47(2) xor in_mul47(0);
	out_mul47(7) <= in_mul47(3) xor in_mul47(1);
end mul47_arch;


-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ --
--																			--
-- 								new component								--
--																			--
-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ --

-- 						
--	multiplier by ae	
--						

library ieee;
use ieee.std_logic_1164.all;

entity mulae is
port	(
		in_mulae	: in std_logic_vector(7 downto 0);
		out_mulae	: out std_logic_vector(7 downto 0)
		);
end mulae;

architecture mulae_arch of mulae is
begin
	out_mulae(0) <= in_mulae(7) xor in_mulae(5) xor in_mulae(1);
	out_mulae(1) <= in_mulae(6) xor in_mulae(2) xor in_mulae(0);
	out_mulae(2) <= in_mulae(5) xor in_mulae(3) xor in_mulae(0);
	out_mulae(3) <= in_mulae(7) xor in_mulae(6) xor in_mulae(5) xor in_mulae(4) xor in_mulae(0);
	out_mulae(4) <= in_mulae(7) xor in_mulae(6) xor in_mulae(5) xor in_mulae(1);
	out_mulae(5) <= in_mulae(7) xor in_mulae(6) xor in_mulae(2) xor in_mulae(0);
	out_mulae(6) <= in_mulae(5) xor in_mulae(3);
	out_mulae(7) <= in_mulae(6) xor in_mulae(4) xor in_mulae(0);
end mulae_arch;


-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ --
--																			--
-- 								new component								--
--																			--
-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ --

-- 						
--	multiplier by 3d	
--						

library ieee;
use ieee.std_logic_1164.all;

entity mul3d is
port	(
		in_mul3d	: in std_logic_vector(7 downto 0);
		out_mul3d	: out std_logic_vector(7 downto 0)
		);
end mul3d;

architecture mul3d_arch of mul3d is
begin
	out_mul3d(0) <= in_mul3d(4) xor in_mul3d(3) xor in_mul3d(0);
	out_mul3d(1) <= in_mul3d(5) xor in_mul3d(4) xor in_mul3d(1);
	out_mul3d(2) <= in_mul3d(6) xor in_mul3d(5) xor in_mul3d(4) xor in_mul3d(3) xor in_mul3d(2) xor in_mul3d(0);
	out_mul3d(3) <= in_mul3d(7) xor in_mul3d(6) xor in_mul3d(5) xor in_mul3d(1) xor in_mul3d(0);
	out_mul3d(4) <= in_mul3d(7) xor in_mul3d(6) xor in_mul3d(2) xor in_mul3d(1) xor in_mul3d(0);
	out_mul3d(5) <= in_mul3d(7) xor in_mul3d(3) xor in_mul3d(2) xor in_mul3d(1) xor in_mul3d(0);
	out_mul3d(6) <= in_mul3d(2) xor in_mul3d(1);
	out_mul3d(7) <= in_mul3d(3) xor in_mul3d(2);
end mul3d_arch;


-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ --
--																			--
-- 								new component								--
--																			--
-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ --

-- 						
--	multiplier by 19	
--						

library ieee;
use ieee.std_logic_1164.all;

entity mul19 is
port	(
		in_mul19	: in std_logic_vector(7 downto 0);
		out_mul19	: out std_logic_vector(7 downto 0)
		);
end mul19;

architecture mul19_arch of mul19 is
begin
	out_mul19(0) <= in_mul19(7) xor in_mul19(6) xor in_mul19(5) xor in_mul19(4) xor in_mul19(0);
	out_mul19(1) <= in_mul19(7) xor in_mul19(6) xor in_mul19(5) xor in_mul19(1);
	out_mul19(2) <= in_mul19(5) xor in_mul19(4) xor in_mul19(2);
	out_mul19(3) <= in_mul19(7) xor in_mul19(4) xor in_mul19(3) xor in_mul19(0);
	out_mul19(4) <= in_mul19(5) xor in_mul19(4) xor in_mul19(1) xor in_mul19(0);
	out_mul19(5) <= in_mul19(6) xor in_mul19(5) xor in_mul19(2) xor in_mul19(1);
	out_mul19(6) <= in_mul19(5) xor in_mul19(4) xor in_mul19(3) xor in_mul19(2);
	out_mul19(7) <= in_mul19(6) xor in_mul19(5) xor in_mul19(4) xor in_mul19(3);
end mul19_arch;


-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ --
--																			--
-- 								new component								--
--																			--
-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ --

-- 						
--	multiplier by 03	
--						

library ieee;
use ieee.std_logic_1164.all;

entity mul03 is
port	(
		in_mul03	: in std_logic_vector(7 downto 0);
		out_mul03	: out std_logic_vector(7 downto 0)
		);
end mul03;

architecture mul03_arch of mul03 is
begin
	out_mul03(0) <= in_mul03(7) xor in_mul03(0);
	out_mul03(1) <= in_mul03(1) xor in_mul03(0);
	out_mul03(2) <= in_mul03(7) xor in_mul03(2) xor in_mul03(1);
	out_mul03(3) <= in_mul03(7) xor in_mul03(3) xor in_mul03(2);
	out_mul03(4) <= in_mul03(4) xor in_mul03(3);
	out_mul03(5) <= in_mul03(5) xor in_mul03(4);
	out_mul03(6) <= in_mul03(7) xor in_mul03(6) xor in_mul03(5);
	out_mul03(7) <= in_mul03(7) xor in_mul03(6);
end mul03_arch;


-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ --
--																			--
-- 								new component								--
--																			--
-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ --

--
-- h function for 128 bits key
-- 

library ieee;
use ieee.std_logic_1164.all;

entity h_128 is
port	(
		in_h128		: in std_logic_vector(7 downto 0);
		Mfirst_h128,
		Msecond_h128	: in std_logic_vector(31 downto 0);
		out_h128		: out std_logic_vector(31 downto 0)
		);
end h_128;

architecture h128_arch of h_128 is

	-- we declare internal signals
	signal	from_first_row,
			to_second_row,
			from_second_row,
			to_third_row,
			to_mds			: std_logic_vector(31 downto 0);
					
	-- we declare all components needed 				   
	component q0
	port	(			   
			in_q0 	: in std_logic_vector(7 downto 0);
			out_q0	: out std_logic_vector(7 downto 0)
			);
	end component;
	
	component q1
	port	(
			in_q1 	: in std_logic_vector(7 downto 0);
			out_q1	: out std_logic_vector(7 downto 0)
			);
	end component;

	component mds
	port	(
			y0,
			y1,
			y2,
			y3	: in std_logic_vector(7 downto 0);
			z0,
			z1,
			z2,
			z3	: out std_logic_vector(7 downto 0)
			);
	end component;

-- begin architecture description
begin

	-- first row of q
	first_q0_1: q0
	port map	(
				in_q0 => in_h128,
				out_q0 => from_first_row(7 downto 0)
				);
	first_q1_1: q1
	port map	(
				in_q1 => in_h128,
				out_q1 => from_first_row(15 downto 8)
				);
	first_q0_2: q0
	port map	(
				in_q0 => in_h128,
				out_q0 => from_first_row(23 downto 16)
				);
	first_q1_2: q1
	port map	(
				in_q1 => in_h128,
				out_q1 => from_first_row(31 downto 24)
				);

	-- we perform the XOR of the results of the first row
	-- with first M of h (Mfist_h128)
	to_second_row <= from_first_row XOR Mfirst_h128;

	-- second row of q
	second_q0_1: q0
	port map	(
				in_q0 => to_second_row(7 downto 0),
				out_q0 => from_second_row(7 downto 0)
				);
	second_q0_2: q0
	port map	(
				in_q0 => to_second_row(15 downto 8),
				out_q0 => from_second_row(15 downto 8)
				);
	second_q1_1: q1
	port map	(
				in_q1 => to_second_row(23 downto 16),
				out_q1 => from_second_row(23 downto 16)
				);
	second_q1_2: q1
	port map	(
				in_q1 => to_second_row(31 downto 24),
				out_q1 => from_second_row(31 downto 24)
				);
				
	-- we perform the second XOR
	to_third_row <= from_second_row XOR Msecond_h128;
	
	-- the third row of q
	third_q1_1: q1
	port map	(
				in_q1 => to_third_row(7 downto 0),
				out_q1 => to_mds(7 downto 0)
				);
	third_q0_1: q0
	port map	(
				in_q0 => to_third_row(15 downto 8),
				out_q0 => to_mds(15 downto 8)
				);
	third_q1_2: q1
	port map	(
				in_q1 => to_third_row(23 downto 16),
				out_q1 => to_mds(23 downto 16)
				);
	third_q0_2: q0
	port map	(
				in_q0 => to_third_row(31 downto 24),
				out_q0 => to_mds(31 downto 24)
				);
				
	-- mds table
	mds_table: mds
	port map	(
				y0 => to_mds(7 downto 0),
				y1 => to_mds(15 downto 8),
				y2 => to_mds(23 downto 16),
				y3 => to_mds(31 downto 24),
				z0 => out_h128(7 downto 0),
				z1 => out_h128(15 downto 8),
				z2 => out_h128(23 downto 16),
				z3 => out_h128(31 downto 24)
				);

end h128_arch;


-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ --
--																			--
-- 								new component								--
--																			--
-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ --

--
-- twofish whitening key scheduler for 128 bits key input			   
--

library ieee;
use ieee.std_logic_1164.all;

entity twofish_whit_keysched128 is
port	(
		in_key_twk128		: in std_logic_vector(127 downto 0);
		out_K0_twk128,
		out_K1_twk128,
		out_K2_twk128,
		out_K3_twk128,
		out_K4_twk128,
		out_K5_twk128,
		out_K6_twk128,
		out_K7_twk128			: out std_logic_vector(31 downto 0)
		);
end twofish_whit_keysched128;
				
architecture twofish_whit_keysched128_arch of twofish_whit_keysched128 is

	-- we declare internal signals
	signal	to_up_pht_1,
			to_shift_8_1,
			from_shift_8_1,
			to_shift_9_1,
			to_up_pht_2,
			to_shift_8_2,
			from_shift_8_2,
			to_shift_9_2,
			to_up_pht_3,
			to_shift_8_3,
			from_shift_8_3,
			to_shift_9_3,
			to_up_pht_4,
			to_shift_8_4,
			from_shift_8_4,
			to_shift_9_4,
			M0, M1, M2, M3	: std_logic_vector(31 downto 0);

	signal	byte0, byte1, byte2, byte3,
			byte4, byte5, byte6, byte7,
			byte8, byte9, byte10, byte11,
			byte12, byte13, byte14, byte15	: std_logic_vector(7 downto 0);

	signal		zero, one, two, three, four, five, six, seven	: std_logic_vector(7 downto 0);
																		   			
	-- we declare the components to be used
	component pht
	port	(
			up_in_pht,
			down_in_pht		: in std_logic_vector(31 downto 0);
			up_out_pht,
			down_out_pht	: out std_logic_vector(31 downto 0)
			);
	end component;

	component h_128 
	port	(
			in_h128			: in std_logic_vector(7 downto 0);
			Mfirst_h128,
			Msecond_h128	: in std_logic_vector(31 downto 0);
			out_h128		: out std_logic_vector(31 downto 0)
			);
	end component;

-- begin architecture description
begin

	-- we produce the first eight numbers
	zero <= "00000000";
	one <= "00000001";
	two <= "00000010";
	three <= "00000011";
	four <= "00000100";
	five <= "00000101";
	six <= "00000110";
	seven <= "00000111";

	-- we assign the input signal to the respective
	-- bytes as is described in the prototype
	byte15 <= in_key_twk128(7 downto 0);
	byte14 <= in_key_twk128(15 downto 8);
	byte13 <= in_key_twk128(23 downto 16);
	byte12 <= in_key_twk128(31 downto 24);
	byte11 <= in_key_twk128(39 downto 32);
	byte10 <= in_key_twk128(47 downto 40);
	byte9 <= in_key_twk128(55 downto 48);
	byte8 <= in_key_twk128(63 downto 56);
	byte7 <= in_key_twk128(71 downto 64);
	byte6 <= in_key_twk128(79 downto 72);
	byte5 <= in_key_twk128(87 downto 80);
	byte4 <= in_key_twk128(95 downto 88);
	byte3 <= in_key_twk128(103 downto 96);
	byte2 <= in_key_twk128(111 downto 104);
	byte1 <= in_key_twk128(119 downto 112);
	byte0 <= in_key_twk128(127 downto 120);

	-- we form the M{0..3}
	M0 <= byte3 & byte2 & byte1 & byte0;
	M1 <= byte7 & byte6 & byte5 & byte4;
	M2 <= byte11 & byte10 & byte9 & byte8;
	M3 <= byte15 & byte14 & byte13 & byte12;

	-- we produce the keys for the whitening steps
	-- keys K0,1
	-- upper h
	upper_h1: h_128
	port map	(
				in_h128 => zero,
				Mfirst_h128 => M2,
				Msecond_h128 => M0,
				out_h128 => to_up_pht_1
				);
				
	-- lower h
	lower_h1: h_128
	port map	(
				in_h128 => one,
				Mfirst_h128 => M3,
				Msecond_h128 => M1,
				out_h128 => to_shift_8_1
				);
				
	-- left rotate by 8
	from_shift_8_1(31 downto 8) <= to_shift_8_1(23 downto 0);
	from_shift_8_1(7 downto 0) <= to_shift_8_1(31 downto 24);
	
	-- pht transformation
	pht_transform1: pht
	port map	(
				up_in_pht => to_up_pht_1,
				down_in_pht => from_shift_8_1,
				up_out_pht => out_K0_twk128,
				down_out_pht => to_shift_9_1
				);
				
	-- left rotate by 9
	out_K1_twk128(31 downto 9) <= to_shift_9_1(22 downto 0);
	out_K1_twk128(8 downto 0) <= to_shift_9_1(31 downto 23);

	-- keys K2,3
	-- upper h
	upper_h2: h_128
	port map	(
				in_h128 => two,
				Mfirst_h128 => M2,
				Msecond_h128 => M0,
				out_h128 => to_up_pht_2
				);
				
	-- lower h
	lower_h2: h_128
	port map	(
				in_h128 => three,
				Mfirst_h128 => M3,
				Msecond_h128 => M1,
				out_h128 => to_shift_8_2
				);
				
	-- left rotate by 8
	from_shift_8_2(31 downto 8) <= to_shift_8_2(23 downto 0);
	from_shift_8_2(7 downto 0) <= to_shift_8_2(31 downto 24);
	
	-- pht transformation
	pht_transform2: pht
	port map	(
				up_in_pht => to_up_pht_2,
				down_in_pht => from_shift_8_2,
				up_out_pht => out_K2_twk128,
				down_out_pht => to_shift_9_2
				);
				
	-- left rotate by 9
	out_K3_twk128(31 downto 9) <= to_shift_9_2(22 downto 0);
	out_K3_twk128(8 downto 0) <= to_shift_9_2(31 downto 23);

	-- keys K4,5
	-- upper h
	upper_h3: h_128
	port map	(
				in_h128 => four,
				Mfirst_h128 => M2,
				Msecond_h128 => M0,
				out_h128 => to_up_pht_3
				);
				
	-- lower h
	lower_h3: h_128
	port map	(
				in_h128 => five,
				Mfirst_h128 => M3,
				Msecond_h128 => M1,
				out_h128 => to_shift_8_3
				);
				
	-- left rotate by 8
	from_shift_8_3(31 downto 8) <= to_shift_8_3(23 downto 0);
	from_shift_8_3(7 downto 0) <= to_shift_8_3(31 downto 24);
	
	-- pht transformation
	pht_transform3: pht
	port map	(
				up_in_pht => to_up_pht_3,
				down_in_pht => from_shift_8_3,
				up_out_pht => out_K4_twk128,
				down_out_pht => to_shift_9_3
				);
				
	-- left rotate by 9
	out_K5_twk128(31 downto 9) <= to_shift_9_3(22 downto 0);
	out_K5_twk128(8 downto 0) <= to_shift_9_3(31 downto 23);

	-- keys K6,7
	-- upper h
	upper_h4: h_128
	port map	(
				in_h128 => six,
				Mfirst_h128 => M2,
				Msecond_h128 => M0,
				out_h128 => to_up_pht_4
				);
				
	-- lower h
	lower_h4: h_128
	port map	(
				in_h128 => seven,
				Mfirst_h128 => M3,
				Msecond_h128 => M1,
				out_h128 => to_shift_8_4
				);
				
	-- left rotate by 8
	from_shift_8_4(31 downto 8) <= to_shift_8_4(23 downto 0);
	from_shift_8_4(7 downto 0) <= to_shift_8_4(31 downto 24);
	
	-- pht transformation
	pht_transform4: pht
	port map	(
				up_in_pht => to_up_pht_4,
				down_in_pht => from_shift_8_4,
				up_out_pht => out_K6_twk128,
				down_out_pht => to_shift_9_4
				);
				
	-- left rotate by 9
	out_K7_twk128(31 downto 9) <= to_shift_9_4(22 downto 0);
	out_K7_twk128(8 downto 0) <= to_shift_9_4(31 downto 23);

end twofish_whit_keysched128_arch;

