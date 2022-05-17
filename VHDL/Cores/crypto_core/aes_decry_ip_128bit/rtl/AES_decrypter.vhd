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
--Top level entity for AES decryption IP.
--*************************************************************

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity AES_decrypter is
	port(
		  cipher: in std_logic_vector(127 downto 0); --Cipher text
		  text_out: out std_logic_vector(127 downto 0); -- Decrypted output	
		  key: in std_logic_vector(127 downto 0); --Cipher Key
		  k_valid,c_valid: in std_logic;--Asserted when either key, cipher is valid
		  ready:out std_logic;--Asserted high when IP is ready to accept the data(key or Cipher)
		  out_valid: out std_logic;--out_valid:Asserted high when decrypted cipher is on the bus.(IMP : **Output is valid only for one cycle)
		  clk,reset: in std_logic
		);
end AES_decrypter;

architecture beh_AES_decrypter of AES_decrypter is
   
   component key_scheduler 
   port(
     key_in  : in std_logic_vector(127 downto 0);--Decryption Key
	 key_out : out std_logic_vector(127 downto 0);
	 valid_in : in std_logic;--Should be high when input key is valid
	 key_ready : out std_logic;--Asserted high when key_scheduler generated all the keys
	 round: in std_logic_vector(3 downto 0);--Which round key to access
	 clk,reset: in std_logic
    );
   end component;
   
   component one_round_decrypt
   port(
          cipher : in std_logic_vector(127 downto 0);
		  text_out: out std_logic_vector(127 downto 0);
		  round_key: in std_logic_vector(127 downto 0)
       );
   end component; 
   
   component InvSub_addRk
   port(
        state_in : in std_logic_vector(127 downto 0);
        state_out : out std_logic_vector(127 downto 0);
		key : in std_logic_vector(127 downto 0)
         );
   end component;

   type state is (IDLE,KEYGEN,GETKY0,ROUND,FINALR,DELAY);
   signal state_reg,state_n: state;
   signal round_reg:unsigned(3 downto 0);
   
   signal KS_key_ready:std_logic;
   signal KS_key_out:std_logic_vector(127 downto 0);
   signal KS_round:unsigned(3 downto 0);
   
   signal one_round_out:std_logic_vector(127 downto 0);
   
   signal cipher_reg,cipher_n,cipher_round0: std_logic_vector(127 downto 0);
begin
   key_scheduler_inst:key_scheduler
   port map(key_in=>key,key_out=>KS_key_out,valid_in=>k_valid,key_ready=>KS_key_ready,round=>std_logic_vector(KS_round),clk=>clk,reset=>reset);
   
   one_round_decrypt_inst:one_round_decrypt
   port map(cipher=>cipher_reg,text_out=>one_round_out,round_key=>KS_key_out);
   
   InvSub_addRk_inst:InvSub_addRk
   port map(state_in=>cipher_reg,state_out=>text_out,key=>KS_key_out);
   
--State register logic
   process(clk,reset)
   begin
      if(reset='1') then
		state_reg <= IDLE;
		round_reg<=(others=>'0');
		cipher_reg<=(others=>'0');
	   elsif(clk ' event and clk='1') then
		state_reg <= state_n;
		round_reg<=KS_round+1;
		cipher_reg<=cipher_n;
		end if;
   end process;
   
--Next state logic
	process(state_reg,c_valid,KS_key_ready,k_valid,round_reg)
	begin
	   case state_reg is
	      when IDLE =>
		      if(k_valid='1') then
			     state_n <= KEYGEN;
			  else
			     state_n <= IDLE;
			  end if;
		  when KEYGEN =>
		      if(KS_key_ready='1') then
			    state_n <= GETKY0;--Unnecessary delay here??????
			  else
			    state_n <= KEYGEN;
			  end if;
		  when GETKY0 =>
				if(c_valid='1') then
				   state_n<=DELAY;
				else
                   state_n<=GETKY0;
				end if;
		  when DELAY =>
		       state_n <= ROUND;
			   
		  when ROUND=>
			   if(round_reg="1010") then
			      state_n<=FINALR;
			   else 
			      state_n<=ROUND;
			   end if;
          when FINALR=>
               state_n<=GETKY0;	  
	   end case;
	end process;
	
	cipher_round0 <= KS_key_out xor cipher;
	
	with state_reg select
	KS_round <= "0000" when GETKY0,
	            round_reg when DELAY,
				round_reg when ROUND,
				"1010" when others;
				
	with state_reg select 
	cipher_n <= cipher_round0 when DELAY,
	            one_round_out when others;
				
	out_valid<='1' when state_reg=FINALR else
	           '0';
	
    ready<='1' when state_reg=GETKY0 or state_reg=IDLE else
		   '0' ;
end beh_AES_decrypter;