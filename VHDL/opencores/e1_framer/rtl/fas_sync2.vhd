library ieee;
use ieee.std_logic_1164.all;

package e1_framer is
type state_type is (S1,S2,S3,S4);  --S1 Looking for first FAS word
                                   --S2 Looking for FAS non align bit
									-- S3 looking for 2nd FAS word
									-- S4 In sync	  
subtype  int_1024 is integer range 0 to 1023; --data bit counter
subtype int_8 is integer range 0 to 7 ; -- data register couner

end e1_framer;  

---------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use work.e1_framer.all;

entity fas_sync2 is port
     (clk,data,reset :in std_logic;
--      FASW_found,FASB_found: in bit;  -- 0=not found, 1=found
      sync_sig : out std_logic;
      
      counter :out int_1024) ;
end fas_sync2;

Architecture behave of fas_sync2 is

signal state:state_type:=S1;
--signal FASW_found,FASB_found: bit:='0';  -- 0=not found, 1=found
signal reg_8 : std_logic_vector(7 downto 0):="00000000"; -- temporary data register
signal cnt1k : int_1024:=0; --data bit counter
signal cnt8 : int_8:=0; -- data register couner

begin

p1:process (reset,clk)
begin

if reset='1' then
 state<=S1; --reset to first state;
 --next_state<=S1;
elsif (clk'event and clk='1') then

       reg_8(7 downto 1)<=reg_8(6 downto 0);  
       reg_8(0)<=data;           -- shift data-> 0,1,2,3,4,5,6,7
       cnt1k<=cnt1k +1;

  case state is 

       when S1 =>       ----------------------$$$$$$$ check here for transition from S4->S1 and first time searching for       FAS
 				    if cnt1k < 256 then
                       if (reg_8 = "00011011" or reg_8 = "10011011") then -- check for FAS X0011011 word
				          state <= S2;
				          cnt1k<=7; --reset to 7  count
                       end if;
                    elsif cnt1k > 255 then
                        sync_sig<='0'; --- one whole frame has been checked,but not got FAS word,so lost synchronisation...
                        cnt1k<=0;
	                end if;
      when S2 =>   
				if cnt1k=257 then 
                  if reg_8(1)='1' then 
                      state <= S3; -- got the non align frame bit now go to next state
                  else
                      state <=S1 ; -- not received non align frame bit indicate error goto previous state
                      sync_sig<='0';
				 end if;
                end if;
      when S3 => 
                if cnt1k=519 then 
					if (reg_8 = "00011011" or reg_8 = "10011011") then
                      state <= S4;
                    else 
                      state <=S1;    -- not received align frame word "X0011011" indicate error goto previous state
                      sync_sig<='0';  
				    end if;
               end if;
      when S4 => 
                sync_sig<='1';  --- syncronisation achieved...!!!
                cnt1k<=0;
                state <= S1;    -- continue checking for FAS..... 
				 
	 when others =>
                    state<= S1;
                   	  
    end case;

end if;
--end if;
end process;

--FASW<=FASW_found;
--FASB<=FASB_found;
counter<=cnt1k;

end behave;
-------------------------------------------------------------------------
  

