-----clock divider by 8--
library ieee;
use ieee.std_logic_1164.all;
 

entity clkdiv_8 is port
     (clkin,enable :in std_logic;
      clkout:out std_logic);
end clkdiv_8;

architecture behave of clkdiv_8 is
signal clk:std_logic;
begin
div:process(clkin,enable)
 subtype int4 is integer range 0 to 3;
 variable cnt:int4;
begin
        if enable/='1' then
            cnt:=0;
            clk<='0';
        else 
          if clkin'event and clkin='1' then
             if cnt=3 then
               clk<= not clk;
               cnt:=0;
             else
                cnt:=cnt +1;
             end if;
          end if;
        
        end if;
    end process;
    
    clkout<=clk;
    
    end behave;                 
