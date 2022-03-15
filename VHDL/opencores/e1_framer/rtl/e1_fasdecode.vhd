
--------------E1 Framer-------------------------------------

----********** E1 frame structure**************
--
---          FAS/nFAS         <-data->        CRC      <--data-->
--            |____|____|---------------|____|____|____|---------------|____|   ----
--  slot no.    0    1                   15    16                        31    ----- 
--  channel     -    1                   15     -   16                   30    ----
---**********************************************

--------------fas_sync--------------------------
library ieee;
use ieee.std_logic_1164.all;
 
use work.e1_package.all;

entity e1_fasdecode is port
     (clk,e1_data,reset :in std_logic;
--      FASW_found,FASB_found: in bit;  -- 0=not found, 1=found
      sync_sig : out std_logic;
      data:out std_logic_vector(7 downto 0);
      channel_no:out int_32;
  --    data_ready:out std_logic;
  --    frm_start:out std_logic;
     -- FASW,FASB :out bit;
      clkout:out std_logic;
      counter :out int_256) ;
end e1_fasdecode;

Architecture behave of e1_fasdecode is

signal state:state_type;

signal FASW_found,FASB_found: std_logic:='0';  -- 0=not found, 1=found

signal reg_8 : std_logic_vector(7 downto 0); -- temporary data register
--signal cnt8 : int_8:=0; -- data register couner
signal sync:std_logic:='0'; -- 0=not synchronised, 1= synch achieved
component clkdiv_8 is 
    port(clkin,enable :in std_logic;
         clkout:out std_logic);
end component;
signal enable_div: std_logic;
begin

data<=reg_8;

with reg_8 select 
     FASW_found<='1' when "00011011", '0' when others;
FASB_found<= reg_8(6);       -------

-----------take serial data,write to internal registers-------
-----------E1_data contains lower bit of data first-----------
p1:process(clk)
begin
if(clk'event and clk='1') then

       reg_8(6 downto 0)<=reg_8(7 downto 1);  
       reg_8(7)<=e1_data;           -- shift data 
       
 end if;      
end process;

-------------------implementation of state machine-----------
 ---------------------------------------
p2:process(clk)

variable cnt256 : int_256; --frame bits counter
variable frame_type:bit:='0'; -- 0=Aligned frame,1=non aligned frame
variable FAS_error: int_4:=0;
begin

if reset='1' then
 state<=S1; --reset to first state;
-- reg_8<="00000000";
-- FASW_found<='0';
-- FASB_found<='0';
elsif ( clk'event and clk='1' ) then
  
  case state is 

       when S1 =>    
 				 
                       if ( FASW_found='1') then -- check for FAS X0011011 word]
       			          state <= S2;
			         
                       end if;
                     cnt256:=0;--reset to 0 count
                     sync<='0'; --- looking for synchronisation...
                     frame_type:='0';
                     FAS_error:=0;   
	              --  end if;
      when S2 =>  frame_type:='1';
				if cnt256=255 then 
                  if (FASB_found='1') then 
                      state <= S3; -- got the non align frame bit now go to next state
                      cnt256:=0;
                   else
                      state <=S1 ; -- not received non align frame bit indicate error goto previous state
                   end if;
                else
                  cnt256:=cnt256+1;
                end if;
      when S3 => frame_type:='0';
                if cnt256=255 then 
					if (FASW_found='1' ) then
                      state <= S4;
                      sync<='1';    --- sync achieved--
                      cnt256:=0;
                    else 
                      state <=S1;    -- not received align frame word "X0011011" indicate error goto previous state
                    end if;
                else    
                  cnt256:=cnt256 + 1;  
               end if;
      when S4 => 
                --sync<='1';  --- syncronisation achieved...!!!
                if (cnt256=255) then
                 if(frame_type='0')then --- aligned frame
                   if (FASW_found='1') then --
                      FAS_error:=0;
                   else
                      FAS_error:=FAS_error+1;
                   end if;
                   
                 else       ---- non aligned frame
                   if(FASB_found='1') then
                      FAS_error:=0;
                   else
                      FAS_error:=FAS_error +1;
                   end if;
                 end if;          
                 frame_type:= not frame_type;
                 cnt256:=0;
                else
                   cnt256:=cnt256+1;
                end if;
                     
                if (FAS_error=3 ) then
                    state <= S1;    -- Three consecutive frames in error so resync criteria meet 
                    sync <='0'; 
                end if;     
				 
	 when others =>
                    state<= S1;
                   	  
    end case;

counter<=cnt256;

if (sync='1') then --valid data on data bus
    channel_no <= (1+ (cnt256 / 8));  --- channel number 0-31 
else
 channel_no<=0;
end if ;


end if;
--end if;
sync_sig<=sync;
end process;

enable_div<='1';
clkdiv:clkdiv_8 port map (clk,enable_div,clkout);
--FASW<=FASW_found;
--FASB<=FASB_found;

end behave;
-------------------------------------------------------------------------
  


