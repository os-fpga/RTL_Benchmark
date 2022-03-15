--
--	PACKAGE UTILS_PKG da "A VHDL PRIMER" & G.FERRANTE
--	gferrante@opencores.org
--	

library ieee;
use ieee.std_logic_1164.all;

package UTILS_PKG is

	function to_integer (s : in std_logic_vector) return integer;

	function to_natural (s : in std_logic_vector) return natural;

	function to_string(s: std_ulogic_vector) return string;

	function to_nstring(s: natural) return string;

	function to_istring(s: integer) return string;

	function to_character(s: std_ulogic) return character;

	function to_stdnlogic(opd: natural; no_bits: natural) return std_logic;

	function to_stdnlogic_vector(opd: natural; no_bits: natural) return std_logic_vector;

	function to_stdnlogic_wvector(opd: natural; no_bits: natural) return std_logic_vector;

	function to_bitvector(opd: natural; no_bits: natural) return bit_vector;


end UTILS_PKG;

package body UTILS_PKG is

	function to_integer (s : std_logic_vector) return integer is

		variable temp : integer := 0;
		variable j: integer := s'LENGTH - 1;

	begin

		for index in s'RANGE loop
			if s(index) = '1' then
				temp := temp + 2 ** j;
			end if;
			j := j - 1;
		end loop;
	
		return temp;

	end to_integer;

	function to_natural (s : std_logic_vector) return natural is

		variable temp : natural := 0;
		variable j: natural := s'LENGTH - 1;

	begin

		for index in s'RANGE loop
			if s(index) = '1' then
				temp := temp + 2 ** j;
			end if;
			j := j - 1;
		end loop;
	
		return temp;

	end to_natural;


	function to_character(s: std_ulogic) return character is
		begin
		  case s is
			when 'X' => return 'X';	
			when '0' => return '0';	
			when '1' => return '1';	
			when 'Z' => return 'Z';	
			when 'U' => return 'U';	
			when 'W' => return 'W';	
			when 'L' => return 'L';	
			when 'H' => return 'H';	
			when '-' => return '-';	
		  end case;
	end to_character;

	function to_string(s: std_ulogic_vector) return string is
		variable ret:string(1 to s'LENGTH);
		variable K: integer:= 1;
		begin
		  for J in s'RANGE loop
			RET(K) := to_character(s(J));
			K := K + 1;
		  end loop;
		return ret;		  
	end to_string;	

	function to_nstring(s: natural) return string is
		variable ret, iret:string(1 to 16);
		variable K, J: integer;
		variable s1, s2, s3: natural := 0;
		begin	

		  s1 := s;
		  ret(1) := '0';	
		  K := 1;	
		
		  while (s1 > 0 and K < 16) loop

			s2 := s1 / 10;
			s3 := s1 - (s2 * 10);
			if (s3 = 0) then 
				ret(K) := '0';
			elsif (s3 = 1) then
				ret(K) := '1';
			elsif (s3 = 2) then
				ret(K) := '2';
			elsif (s3 = 3) then
				ret(K) := '3';
			elsif (s3 = 4) then
				ret(K) := '4';
			elsif (s3 = 5) then
				ret(K) := '5';
			elsif (s3 = 6) then
				ret(K) := '6';
			elsif (s3 = 7) then
				ret(K) := '7';
			elsif (s3 = 8) then
				ret(K) := '8';
			elsif (s3 = 9) then
				ret(K) := '9';
			end if;
			K := K + 1;
			s1 := s2;

		  end loop;
		
		if (K > 1) then
			K := K - 1;
		end if;

		J := 1;

            while (K > 0) loop

			iret(J) := ret(K);
			K := K - 1;
			J := J + 1;

		end loop;  			
 
		return iret;		  

	end to_nstring;


	function to_istring(s: integer) return string is
	
        begin
	    if (s < 0) then
		return "-" & to_nstring(-s);
	    else
		return to_nstring(s);
	    end if;		
	end to_istring;

	function to_stdnlogic(opd: natural; no_bits: natural) return std_logic is

		variable m1: integer;
		variable ret: std_logic := '0';
		variable rvet: std_logic_vector(no_bits - 1 downto 0);

		begin

		  m1 := opd;
		  for J in rvet'REVERSE_RANGE loop
			if (m1 mod 2) = 1 then
			  ret := '1';
			else
			  ret := '0';
			end if;
			m1 := m1 / 2;
		  end loop;
		  return ret;

	end to_stdnlogic;

	function to_stdnlogic_vector(opd: natural; no_bits: natural) return std_logic_vector is

		variable m1: integer;
		variable ret: std_logic_vector(no_bits - 1 downto 0);
		variable rvet: std_logic_vector(no_bits - 1 downto 0);

		begin

		  m1 := opd;
		  for J in rvet'REVERSE_RANGE loop
			if (m1 mod 2) = 1 then
			  ret(J) := '1';
			else
			  ret(J) := '0';
			end if;
			m1 := m1 / 2;
		  end loop;
		  return ret;

	end to_stdnlogic_vector;

	function to_stdnlogic_wvector(opd: natural; no_bits: natural) return std_logic_vector is

		variable m1: integer;
		variable ret: std_logic_vector(no_bits - 1 downto 0);
		variable rvet: std_logic_vector(no_bits - 1 downto 0);

		begin

		  m1 := opd;
		  for J in rvet'REVERSE_RANGE loop
			if (m1 mod 2) = 1 then
			  ret(J) := 'H';
			else
			  ret(J) := 'L';
			end if;
			m1 := m1 / 2;
		  end loop;
		  return ret;

	end to_stdnlogic_wvector;

	function to_bitvector(opd: natural; no_bits: natural) return bit_vector is

		variable m1: integer;
		variable ret: bit_vector(no_bits - 1 downto 0);
		variable rvet: std_logic_vector(no_bits - 1 downto 0);

		begin

		  m1 := opd;
		  for J in rvet'REVERSE_RANGE loop
			if (m1 mod 2) = 1 then
			  ret(J) := '1';
			else
			  ret(J) := '0';
			end if;
			m1 := m1 / 2;
		  end loop;
		  return ret;

	end to_bitvector;

end UTILS_PKG;