library ieee;
use ieee.std_logic_1164.all;
use work.e1_package;


entity CRC_4 is
 port(indata:in std_logic;  --- serial one bit in data
      clk: in std_logic;
      reset:in std_logic;
 	 -- start_frm:out std_logic;
 	  checksum:out std_logic_vector(3 downto 0)
 	  
 	  );
end CRC_4;

architecture struct of CRC_4 is
signal s: std_logic_vector(0 to 3);
signal feedback,clrn,prn,x0:std_logic;
COMPONENT DFF        --- use of inbuilt D ff
   PORT (d   : IN STD_LOGIC;
      clk : IN STD_LOGIC;
      clrn: IN STD_LOGIC;
      prn : IN STD_LOGIC;
      q   : OUT STD_LOGIC );
END COMPONENT;

begin
clrn<=reset;
prn<='1';
S0 : DFF port map(feedback,clk,clrn,prn,s(0));
x0<=feedback xor s(0);
S1 : DFF port map(x0,clk,clrn,prn,s(1)); 
S2 : DFF port map(s(1),clk,clrn,prn,s(2));
S3 : DFF port map(s(2),clk,clrn,prn,s(3));
feedback<=s(3) xor indata;  

checksum<=s;

end struct;
