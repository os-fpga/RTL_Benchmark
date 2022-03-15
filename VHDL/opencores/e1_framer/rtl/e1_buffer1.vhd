----------------slip buffer for temporary storage of channel data-------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use work.e1_package.all;

entity e1_buffer1 is port
     (clkwr:in std_logic;
     clkrd:in std_logic;
     start_wr:in std_logic;
     start_rd:in std_logic;
     datain: in std_logic_vector(7 downto 0);
   -- init:out boolean; 
     dataout:out std_logic_vector(7 downto 0)
     ) ;
end e1_buffer1;

Architecture behave of e1_buffer1 is
--type ram is array (0 to RAM_SIZE )  of std_logic_vector(7 downto 0) ;
signal buff: ram ;     -- main buffer to store data
--subtype pntr_range is integer range 0 to RAM_SIZE; --(RAM_SIZE -1);
signal pntr_wr,pntr_rd:pntr_range:=0; --write ,read pointers
signal reg_rd,reg_wr:std_logic_vector(7 downto 0); 
begin
	
wrproc: process(clkwr)
begin
 if clkwr'event and clkwr='1' then
	if start_wr='1' then
	 pntr_wr<=0;
	else
	 pntr_wr<=pntr_wr+1;
	end if;
	reg_wr<=datain;
	--buff(pntr_wr)<=reg_wr; --write data to buffer pointed by write pointer
   end if;
end process;

readproc:process(clkrd)
begin
 if clkrd'event and clkrd='1' then
    if start_rd='1' then
	 pntr_rd<=0;
	else
	 pntr_rd<=pntr_rd+1;
	end if;
	dataout<=reg_rd;
	--dataout<=buff(pntr_rd); --write data to buffer pointed by write pointer
  end if;
end process;
 
     buff(pntr_wr)<=reg_wr;
     reg_rd<=buff(pntr_rd);
 
 end behave;
   
	
	  
	

