library ieee;
use ieee.std_logic_1164.all;
--use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use work.e1_package.all;

entity up_interface is port
     (clk:in std_logic;
      enable:in std_logic;
      rd_wr:in std_logic;
      address: in std_logic_vector(7 downto 0);
      data:inout std_logic_vector(7 downto 0)
     ) ;
end up_interface;

Architecture behave of up_interface is
--signal ioreg:std_logic_vector( 7 downto 0);
type reg_arr is array(0 to 4) of std_logic_vector(7 downto 0);
signal reg :reg_arr;
signal inreg,outreg:std_logic_vector(7 downto 0);

begin

memory: process(clk,enable,rd_wr) 
begin
 
if enable='0' then
    outreg<="00000000";
elsif clk'event and clk='1' then
   if rd_wr='1' then -- read
     case address(3 downto 0) is
      when "0000" =>
      	            outreg<=reg(0);
      when "0001" =>
      	            outreg<=reg(1);
      when "0010" =>
      	            outreg<=reg(2);
      when "0011" =>
      	            outreg<=reg(3);
      when "0100" =>
      	            outreg<=reg(4);
      when others =>
                    outreg<=reg(5);
      end case;
                    	            
   elsif rd_wr='0' then --write
    case address(3 downto 0) is
      when "0000" =>
      	            reg(0)<=inreg;
      when "0001" =>
      	            reg(1)<=inreg;
      when "0010" =>
      	            reg(2)<=inreg;
      when "0011" =>
      	            reg(3)<=inreg;
      when "0100" =>
      	            reg(4)<=inreg;
      when others =>
      	            reg(5)<=inreg;
     end case;
    end if;
 end if;     

end process;
 
 process(clk,enable,rd_wr)
 begin
  if enable='0' then
    data<="00000000";
  elsif clk'event and clk='1' then
    if rd_wr='1' then --read
      data<=outreg;
     elsif rd_wr='0' then --write
      inreg<=data;
     end if;
   end if;
 end process;
         
end behave;   
 
  

