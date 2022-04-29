--************************************************************
--Copyright 2015, Ganesh Hegde < ghegde@opencores.org >      
--                                                           
--This source file may be used and distributed without  
--restriction provided that this copyright statement is not 
--removed from the file and that any derivative work contains
--the original copyright notice and the associated disclaimer.
--
--This source is distributed in the hope that it will be
--useful, but WITHOUT ANY WARRANTY; without even the implied
--warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
--PURPOSE.  See the GNU Lesser General Public License for more
--details.
--
--You should have received a copy of the GNU Lesser General
--Public License along with this source; if not, download it
--from http://www.opencores.org/lgpl.shtml
--
--*************************************************************

--*************************************************************
-- GF multiplication of input byte by 0x0D
--Logic type : Combinational
--*************************************************************

library ieee;
use ieee.std_logic_1164.all;

entity xD is
port (
	--clk,reset : in std_logic;
	data_in: in std_logic_vector(7 downto 0);
	data_out:out std_logic_vector(7 downto 0)
);
end xD;

architecture beh_xD of xD is
begin
   process(data_in)
   begin
   case(data_in) is 
      when x"00"=> data_out<=x"00";
      when x"01"=> data_out<=x"0d";
      when x"02"=> data_out<=x"1a";
      when x"03"=> data_out<=x"17";
      when x"04"=> data_out<=x"34";
      when x"05"=> data_out<=x"39";
      when x"06"=> data_out<=x"2e";
      when x"07"=> data_out<=x"23";
      when x"08"=> data_out<=x"68";
      when x"09"=> data_out<=x"65";
      when x"0a"=> data_out<=x"72";
      when x"0b"=> data_out<=x"7f";
      when x"0c"=> data_out<=x"5c";
      when x"0d"=> data_out<=x"51";
      when x"0e"=> data_out<=x"46";
      when x"0f"=> data_out<=x"4b";
      when x"10"=> data_out<=x"d0";
      when x"11"=> data_out<=x"dd";
      when x"12"=> data_out<=x"ca";
      when x"13"=> data_out<=x"c7";
      when x"14"=> data_out<=x"e4";
      when x"15"=> data_out<=x"e9";
      when x"16"=> data_out<=x"fe";
      when x"17"=> data_out<=x"f3";
      when x"18"=> data_out<=x"b8";
      when x"19"=> data_out<=x"b5";
      when x"1a"=> data_out<=x"a2";
      when x"1b"=> data_out<=x"af";
      when x"1c"=> data_out<=x"8c";
      when x"1d"=> data_out<=x"81";
      when x"1e"=> data_out<=x"96";
      when x"1f"=> data_out<=x"9b";
      when x"20"=> data_out<=x"bb";
      when x"21"=> data_out<=x"b6";
      when x"22"=> data_out<=x"a1";
      when x"23"=> data_out<=x"ac";
      when x"24"=> data_out<=x"8f";
      when x"25"=> data_out<=x"82";
      when x"26"=> data_out<=x"95";
      when x"27"=> data_out<=x"98";
      when x"28"=> data_out<=x"d3";
      when x"29"=> data_out<=x"de";
      when x"2a"=> data_out<=x"c9";
      when x"2b"=> data_out<=x"c4";
      when x"2c"=> data_out<=x"e7";
      when x"2d"=> data_out<=x"ea";
      when x"2e"=> data_out<=x"fd";
      when x"2f"=> data_out<=x"f0";
      when x"30"=> data_out<=x"6b";
      when x"31"=> data_out<=x"66";
      when x"32"=> data_out<=x"71";
      when x"33"=> data_out<=x"7c";
      when x"34"=> data_out<=x"5f";
      when x"35"=> data_out<=x"52";
      when x"36"=> data_out<=x"45";
      when x"37"=> data_out<=x"48";
      when x"38"=> data_out<=x"03";
      when x"39"=> data_out<=x"0e";
      when x"3a"=> data_out<=x"19";
      when x"3b"=> data_out<=x"14";
      when x"3c"=> data_out<=x"37";
      when x"3d"=> data_out<=x"3a";
      when x"3e"=> data_out<=x"2d";
      when x"3f"=> data_out<=x"20";
      when x"40"=> data_out<=x"6d";
      when x"41"=> data_out<=x"60";
      when x"42"=> data_out<=x"77";
      when x"43"=> data_out<=x"7a";
      when x"44"=> data_out<=x"59";
      when x"45"=> data_out<=x"54";
      when x"46"=> data_out<=x"43";
      when x"47"=> data_out<=x"4e";
      when x"48"=> data_out<=x"05";
      when x"49"=> data_out<=x"08";
      when x"4a"=> data_out<=x"1f";
      when x"4b"=> data_out<=x"12";
      when x"4c"=> data_out<=x"31";
      when x"4d"=> data_out<=x"3c";
      when x"4e"=> data_out<=x"2b";
      when x"4f"=> data_out<=x"26";
      when x"50"=> data_out<=x"bd";
      when x"51"=> data_out<=x"b0";
      when x"52"=> data_out<=x"a7";
      when x"53"=> data_out<=x"aa";
      when x"54"=> data_out<=x"89";
      when x"55"=> data_out<=x"84";
      when x"56"=> data_out<=x"93";
      when x"57"=> data_out<=x"9e";
      when x"58"=> data_out<=x"d5";
      when x"59"=> data_out<=x"d8";
      when x"5a"=> data_out<=x"cf";
      when x"5b"=> data_out<=x"c2";
      when x"5c"=> data_out<=x"e1";
      when x"5d"=> data_out<=x"ec";
      when x"5e"=> data_out<=x"fb";
      when x"5f"=> data_out<=x"f6";
      when x"60"=> data_out<=x"d6";
      when x"61"=> data_out<=x"db";
      when x"62"=> data_out<=x"cc";
      when x"63"=> data_out<=x"c1";
      when x"64"=> data_out<=x"e2";
      when x"65"=> data_out<=x"ef";
      when x"66"=> data_out<=x"f8";
      when x"67"=> data_out<=x"f5";
      when x"68"=> data_out<=x"be";
      when x"69"=> data_out<=x"b3";
      when x"6a"=> data_out<=x"a4";
      when x"6b"=> data_out<=x"a9";
      when x"6c"=> data_out<=x"8a";
      when x"6d"=> data_out<=x"87";
      when x"6e"=> data_out<=x"90";
      when x"6f"=> data_out<=x"9d";
      when x"70"=> data_out<=x"06";
      when x"71"=> data_out<=x"0b";
      when x"72"=> data_out<=x"1c";
      when x"73"=> data_out<=x"11";
      when x"74"=> data_out<=x"32";
      when x"75"=> data_out<=x"3f";
      when x"76"=> data_out<=x"28";
      when x"77"=> data_out<=x"25";
      when x"78"=> data_out<=x"6e";
      when x"79"=> data_out<=x"63";
      when x"7a"=> data_out<=x"74";
      when x"7b"=> data_out<=x"79";
      when x"7c"=> data_out<=x"5a";
      when x"7d"=> data_out<=x"57";
      when x"7e"=> data_out<=x"40";
      when x"7f"=> data_out<=x"4d";
      when x"80"=> data_out<=x"da";
      when x"81"=> data_out<=x"d7";
      when x"82"=> data_out<=x"c0";
      when x"83"=> data_out<=x"cd";
      when x"84"=> data_out<=x"ee";
      when x"85"=> data_out<=x"e3";
      when x"86"=> data_out<=x"f4";
      when x"87"=> data_out<=x"f9";
      when x"88"=> data_out<=x"b2";
      when x"89"=> data_out<=x"bf";
      when x"8a"=> data_out<=x"a8";
      when x"8b"=> data_out<=x"a5";
      when x"8c"=> data_out<=x"86";
      when x"8d"=> data_out<=x"8b";
      when x"8e"=> data_out<=x"9c";
      when x"8f"=> data_out<=x"91";
      when x"90"=> data_out<=x"0a";
      when x"91"=> data_out<=x"07";
      when x"92"=> data_out<=x"10";
      when x"93"=> data_out<=x"1d";
      when x"94"=> data_out<=x"3e";
      when x"95"=> data_out<=x"33";
      when x"96"=> data_out<=x"24";
      when x"97"=> data_out<=x"29";
      when x"98"=> data_out<=x"62";
      when x"99"=> data_out<=x"6f";
      when x"9a"=> data_out<=x"78";
      when x"9b"=> data_out<=x"75";
      when x"9c"=> data_out<=x"56";
      when x"9d"=> data_out<=x"5b";
      when x"9e"=> data_out<=x"4c";
      when x"9f"=> data_out<=x"41";
      when x"a0"=> data_out<=x"61";
      when x"a1"=> data_out<=x"6c";
      when x"a2"=> data_out<=x"7b";
      when x"a3"=> data_out<=x"76";
      when x"a4"=> data_out<=x"55";
      when x"a5"=> data_out<=x"58";
      when x"a6"=> data_out<=x"4f";
      when x"a7"=> data_out<=x"42";
      when x"a8"=> data_out<=x"09";
      when x"a9"=> data_out<=x"04";
      when x"aa"=> data_out<=x"13";
      when x"ab"=> data_out<=x"1e";
      when x"ac"=> data_out<=x"3d";
      when x"ad"=> data_out<=x"30";
      when x"ae"=> data_out<=x"27";
      when x"af"=> data_out<=x"2a";
      when x"b0"=> data_out<=x"b1";
      when x"b1"=> data_out<=x"bc";
      when x"b2"=> data_out<=x"ab";
      when x"b3"=> data_out<=x"a6";
      when x"b4"=> data_out<=x"85";
      when x"b5"=> data_out<=x"88";
      when x"b6"=> data_out<=x"9f";
      when x"b7"=> data_out<=x"92";
      when x"b8"=> data_out<=x"d9";
      when x"b9"=> data_out<=x"d4";
      when x"ba"=> data_out<=x"c3";
      when x"bb"=> data_out<=x"ce";
      when x"bc"=> data_out<=x"ed";
      when x"bd"=> data_out<=x"e0";
      when x"be"=> data_out<=x"f7";
      when x"bf"=> data_out<=x"fa";
      when x"c0"=> data_out<=x"b7";
      when x"c1"=> data_out<=x"ba";
      when x"c2"=> data_out<=x"ad";
      when x"c3"=> data_out<=x"a0";
      when x"c4"=> data_out<=x"83";
      when x"c5"=> data_out<=x"8e";
      when x"c6"=> data_out<=x"99";
      when x"c7"=> data_out<=x"94";
      when x"c8"=> data_out<=x"df";
      when x"c9"=> data_out<=x"d2";
      when x"ca"=> data_out<=x"c5";
      when x"cb"=> data_out<=x"c8";
      when x"cc"=> data_out<=x"eb";
      when x"cd"=> data_out<=x"e6";
      when x"ce"=> data_out<=x"f1";
      when x"cf"=> data_out<=x"fc";
      when x"d0"=> data_out<=x"67";
      when x"d1"=> data_out<=x"6a";
      when x"d2"=> data_out<=x"7d";
      when x"d3"=> data_out<=x"70";
      when x"d4"=> data_out<=x"53";
      when x"d5"=> data_out<=x"5e";
      when x"d6"=> data_out<=x"49";
      when x"d7"=> data_out<=x"44";
      when x"d8"=> data_out<=x"0f";
      when x"d9"=> data_out<=x"02";
      when x"da"=> data_out<=x"15";
      when x"db"=> data_out<=x"18";
      when x"dc"=> data_out<=x"3b";
      when x"dd"=> data_out<=x"36";
      when x"de"=> data_out<=x"21";
      when x"df"=> data_out<=x"2c";
      when x"e0"=> data_out<=x"0c";
      when x"e1"=> data_out<=x"01";
      when x"e2"=> data_out<=x"16";
      when x"e3"=> data_out<=x"1b";
      when x"e4"=> data_out<=x"38";
      when x"e5"=> data_out<=x"35";
      when x"e6"=> data_out<=x"22";
      when x"e7"=> data_out<=x"2f";
      when x"e8"=> data_out<=x"64";
      when x"e9"=> data_out<=x"69";
      when x"ea"=> data_out<=x"7e";
      when x"eb"=> data_out<=x"73";
      when x"ec"=> data_out<=x"50";
      when x"ed"=> data_out<=x"5d";
      when x"ee"=> data_out<=x"4a";
      when x"ef"=> data_out<=x"47";
      when x"f0"=> data_out<=x"dc";
      when x"f1"=> data_out<=x"d1";
      when x"f2"=> data_out<=x"c6";
      when x"f3"=> data_out<=x"cb";
      when x"f4"=> data_out<=x"e8";
      when x"f5"=> data_out<=x"e5";
      when x"f6"=> data_out<=x"f2";
      when x"f7"=> data_out<=x"ff";
      when x"f8"=> data_out<=x"b4";
      when x"f9"=> data_out<=x"b9";
      when x"fa"=> data_out<=x"ae";
      when x"fb"=> data_out<=x"a3";
      when x"fc"=> data_out<=x"80";
      when x"fd"=> data_out<=x"8d";
      when x"fe"=> data_out<=x"9a";
      when others=> data_out<=x"97";
      
   end case;
 end process;

end beh_xD;
