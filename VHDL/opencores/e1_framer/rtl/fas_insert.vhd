library ieee;
use ieee.std_logic_1164.all;
use work.e1_package;


entity FAS_insert is
 port(indata:in std_logic_vector(7 downto 0);
      TICLK: in std_logic;
 	  reset:in std_logic;
 	  start_frm:out std_logic;
 	  outdata:out std_logic;
 	 rd:out std_logic
 	  );
end FAS_insert;

architecture behave of FAS_insert is
type statetype is (S0,S1); -- S0= zero time slot (FAS word) generation
                       -- S1= reading data channels
signal intreg: std_logic_vector(7 downto 0);
signal bitcnt: integer range 0 to 7;
signal frame_type,intclk,intres:std_logic;
signal state: statetype;
begin
----------process for serial output of e1(FAS + channel 1-31) data from paralle register 	   	
parral2serial:process (TICLK,intres)
begin
if intres='1' then
  bitcnt<=0;
  outdata<='0';
elsif TICLK'event and TICLK='0' then --- folling edge
    outdata<=intreg(bitcnt);
    bitcnt<=bitcnt+1;
--    intclk<=not intcl;
end if;
end process;
--------------
process (TICLK,reset)
begin
if (reset='1') then
  intres<='1';
elsif TICLK'event and TICLK='0' then
  intres<='0';
end if;
end process;

  
--------process for generating FAS word and reading channel data-----------------
stateproc:process(TICLK,intres)
variable bytecnt: integer range 0 to 31;
begin

if intres='1' then
   state<=S0;
   frame_type<='0';
elsif (TICLK'event and TICLK='1') then --- rising edge 
 
 case state is
       when S0 =>
                 bytecnt:=0;
                 start_frm<='1';
                 if frame_type='0' then
                    intreg<="10011011"; -- FAS word X0011011
                 else
                    intreg<=indata;
                    intreg(1)<='1'; -- bit1 must be '1' for nonalign frames
                 end if;   
                -- state<=S1 when bitcnt=7;
                 if (bitcnt=7) then
                   state<=S1;
                 end if;   
       when S1 =>
                  start_frm<='0';
                  if (bitcnt=0 ) then  
                  	  intreg<=indata; -- read the input data	
                  	  rd<='1';
                  else
                     rd<='0';
                   end if;
                  	  
                  if bitcnt=7 then
                      if bytecnt=30 then
                          state<=S0;
                          frame_type<= not frame_type;
                      else
                         bytecnt:=bytecnt+1;
                      end if;
                  end if;
        when others =>
                     state <= S0;
     end case;
  end if;
 end process;
 
-- clk_out<=intclk;
end behave;       
                                          	  
                   
   


    
 	   	
 
