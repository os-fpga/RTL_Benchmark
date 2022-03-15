library ieee;
use ieee.std_logic_1164.all;

entity test_fas_insert is
port(clkin:in std_logic;
     enable:in std_logic;
     datain: in std_logic_vector(7 downto 0);
     clkout:out std_logic;
     data:out std_logic_vector(7 downto 0);
     reset:out std_logic);
end test_fas_insert;

architecture behave of test_fas_insert is
signal clk: std_logic;
begin     
reset<=enable;
clkout<=clk;

clkdiv: process(clkin)
constant div:integer:=5; -- divide input clock by 2*(div+1)
variable cnt: integer range 0 to div;
begin
if clkin'event and clkin='1' then
 if cnt=div then
   cnt:=0;
   clk<=not clk;
 else
   cnt:=cnt +1;
 end if;
end if;
end process;

outdata: process(clkin,enable)
begin
if enable='0' then
 data<="00000000";
elsif clkin'event and clkin='1' then
 data<=datain; 
end if;
end process;

end behave;

 
