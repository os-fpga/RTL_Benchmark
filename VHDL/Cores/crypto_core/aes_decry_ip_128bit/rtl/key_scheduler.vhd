--************************************************************
--Copyright 2015, Ganesh Hegde < ghegde@opencores.org >      
--                                                           
--This source file may be used and distributed without  
--restriction provided that this copyright statement is not 
--removed from the file and that any derivative work contains
--the original copyright notice and the associated disclaimer.
--
--This source is distributed in the hope that it will be
--useful, but WITHOUT ANY WARRANTY; without even the implied
--warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
--PURPOSE.  See the GNU Lesser General Public License for more
--details.
--
--You should have received a copy of the GNU Lesser General
--Public License along with this source; if not, download it
--from http://www.opencores.org/lgpl.shtml
--
--*************************************************************

--*************************************************************
--Top level entity for key scheduling.
--Note that module does not support reconfigurable key.To change
-- the key the module has to undergo a reset.
--Logic type : Sequential (11 cycle latency for the key to be ready)
--*************************************************************

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity key_scheduler is 
port(
     key_in  : in std_logic_vector(127 downto 0);--Decryption Key
	 key_out : out std_logic_vector(127 downto 0);--Output key(one cycle delay)
	 valid_in : in std_logic;--Should be high when input key is valid
	 key_ready : out std_logic;--Asserted high when key_scheduler generated all the keys
	 round: in std_logic_vector(3 downto 0);--Which round key to access
	 clk,reset: in std_logic
    );
end key_scheduler;

architecture beh_key_scheduler of key_scheduler is
   --Single port RAM module 16x128
   component singleport_RAM
      port(
           datain : in std_logic_vector(127 downto 0);
   		addr : in std_logic_vector(3 downto 0);
   		we,clk   : in std_logic;
   		dataout: out std_logic_vector(127 downto 0)
      );
   end component;
   
   component one_round_key 
   port(
   	 in_key: in std_logic_vector(127 downto 0);
   	 out_key: out std_logic_vector(127 downto 0);
   	 rcon: in std_logic_vector(7 downto 0)
   	);
   end component;
   
   type state is (IDLE,ROUNDKEY,READY);
   signal state_n,state_reg: state;
   --RAM signals
   signal we :std_logic;
   signal ram_data_in,ram_data_out:std_logic_vector(127 downto 0);
   signal ram_addr:std_logic_vector(3 downto 0);
   
   --one_round_key signals
   signal rcon_in : std_logic_vector(7 downto 0);
   signal out_key : std_logic_vector(127 downto 0);
   
   signal count_reg,count_n:unsigned(3 downto 0);
   
begin
--Instantiate single port RAM
   singleport_RAM_inst:singleport_RAM
   port map(datain=>ram_data_in,dataout=>ram_data_out,addr=>ram_addr,clk=>clk,we=>we);
   
--Instantiate round key calculator
   one_round_key_inst:one_round_key
   port map(in_key=>ram_data_out,out_key=>out_key,rcon=>rcon_in);
   
--State register 
   process(clk,reset)
   begin
      if(reset='1') then --Active High reset
	     state_reg<=IDLE;
		 count_reg<="1010";--10
	  elsif(clk'event and clk='1') then
         state_reg <= state_n;	
         count_reg <= count_n;
	  end if;
   end process;
   
--Next state logic
  process(state_reg,valid_in,count_reg)
  begin
  case state_reg is
      when IDLE =>
	     if(valid_in='1') then
		    count_n<=count_reg-1;
			state_n<=ROUNDKEY;
		  else
		    state_n<=state_reg;
			count_n<=count_reg;
         end if;
      when ROUNDKEY =>
         if(count_reg = "0000") then
            state_n<=READY;
				count_n<=count_reg;
         else
			count_n<=count_reg-1;
			state_n<=state_reg;
		 end if;
	  when READY=>
	     state_n<=state_reg;
		  count_n<=count_reg;
		 --No error case handle
		 end case;
  end process;

 --Output logic
   with state_reg select 
         ram_data_in <= key_in when IDLE,
		                out_key when others;
						
    we <= '1' when (state_reg=IDLE or state_reg = ROUNDKEY) else
          '0';
		  
	with state_reg select 
	      ram_addr <= std_logic_vector(count_reg) when IDLE,
		              std_logic_vector(count_reg) when ROUNDKEY,
					  round when others;
		  
	key_out <= 	ram_data_out;--Output is valid after one cycle.
	key_ready<= '1' when state_reg = READY else
            '0';
			
	with count_reg select 
	      rcon_in <= x"01" when "1001",
                     x"02" when "1000",
                     x"04" when "0111",
                     x"08" when "0110",
                     x"10" when "0101",
                     x"20" when "0100",
                     x"40" when "0011",
                     x"80" when "0010",
                     x"1B" when "0001",	
                     x"36" when others;						 
end beh_key_scheduler;
