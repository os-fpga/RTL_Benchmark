library ieee;
use ieee.std_logic_1164.all;

entity fas_sync is port
     (clk,data,reset :in std_logic;
      FASW_found,FASB_found: bit;  -- 0=not found, 1=found
      sync_sig : out std_logic);
end fas_sync;

Architecture behave of fas_sync is
type state_type is (S1,S2,S3,S4);  --S1 Looking for first FAS word
                                   --S2 Looking for FAS non align bit
									-- S3 looking for 2nd FAS word
									-- S4 In sync	  
signal current_state,next_state : state_type;
--signal FASW_found,FASB_found: bit:='0';  -- 0=not found, 1=found

begin
p1:process (clk,reset)

begin
if reset='1' then
 current_state<=S1; --reset to first state;
else 
 if (clk'event and clk='1') then
    current_state<= next_state;
 end if;
end if;
end process;

p2: process(current_state,clk)

begin
   case current_state is
      when S1 =>
                if FASW_found='1' then
                   next_state <= S2;
                end if;
      when S2 =>
                if FASB_found='1' then
                   next_state <= S3;
                end if;
      when S3 =>
                if FASW_found='1' then
                   next_state <= S4;
                end if;
      when S4 =>
                sync_sig <='1';
                if (FASW_found or FASB_found) ='0' then
                   next_state <= S1;
                end if;
    end case;
end process;

end behave;

  

