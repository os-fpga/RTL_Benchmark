----------------slip buffer for temporary storage of channel data-------
library ieee;
use ieee.std_logic_1164.all;
use work.e1_package.all;

entity e1_buffer is port
     (clkwr:in std_logic;
     clkrd:in std_logic;
     start_wr:in std_logic;
     start_rd:in std_logic;
     datain: in std_logic_vector(7 downto 0);
    init:out boolean; 
     dataout:out std_logic_vector(7 downto 0)
     ) ;
end e1_buffer;

Architecture behave of e1_buffer is
type ram is array (0 to  7)  of std_logic_vector(7 downto 0) ;
signal buff: ram ;     -- main buffer to store data
subtype pntr_range is integer range 0 to 7 ;--(RAM_SIZE -1);
signal pntr_wr,pntr_rd:pntr_range:=0; --write ,read pointers

begin
	
wrproc: process(clkwr,start_wr)
variable ram_init:boolean:=false; -- buffer initialisation flag 
variable i:pntr_range:=0;
begin

if (ram_init=true) then
  	-- INITIALIZE TO 0 --
	for i in 0 to 7  loop  --(RAM_SIZE - 1)
			buff(i)<="00001111" ; --- (OTHERS => '0');
			end loop;
			ram_init:=false;
		init<=ram_init;
else
 if clkwr'event and clkwr='1' then
	if start_wr='1' then
	 pntr_wr<=0;
	else
	 pntr_wr<=pntr_wr+1;
	end if;
	
	buff(pntr_wr)<=datain; --write data to buffer pointed by write pointer
   end if;
 end if;  

end process;

readproc:process(clkrd,start_rd)

begin

if clkrd'event and clkrd='1' then
    if start_rd='1' then
	 pntr_rd<=0;
	else
	 pntr_rd<=pntr_rd+1;
	end if;
	
	dataout<=buff(pntr_rd); --write data to buffer pointed by write pointer
end if;

end process;
   
end behave;
   
	
	  
	

