----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:32:29 04/17/2013 
-- Design Name: 
-- Module Name:    burst_slave - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity queue  is
	 generic(adress : integer :=5;
				depth  : integer :=3);
    Port ( 
				
				ACK_O:  out std_logic; --The acknowledge input 
            ADR_I:  in std_logic_vector (7  downto 0 ); --adres output
            CLK_I:  in  std_logic;
				DAT_I:  in  std_logic_vector( 7 downto 0 );--data in
            DAT_O:  out std_logic_vector( 7 downto 0 ):=X"00";--data out
            RST_I:  in  std_logic;--reset in
            --SEL_O:  out std_logic;--deze input dient voor het selecteren van de poort word echter niet gebruikt als er maar met 8 bit word gewerkt
            STB_I:   in std_logic;--The strobe 
            WE_I :	in std_logic;--write enable  
				
			--- non wishbone
			 input: in  STD_LOGIC_VECTOR (7 downto 0);
			 OutputReady:in std_logic;
			 busfull: out std_logic;--- is er nog plaats in de bus? '1' is nee '0' is ja. 
			 --als er toch geschreven word zal dit een data overwrite geven
			 read_ack	: out std_logic
			 );
end queue;

architecture Behavioral of queue is

type shiftreg is array(0 to depth) of std_logic_vector(7 downto 0);

signal read_buf	: shiftreg;


signal writecount 	: integer range 0 to depth:=0;
signal readcount		: integer range 0 to depth:=0;
signal ACK_O_int : std_logic:='0';
signal read_ack_int :std_logic:='0';
begin

process(CLK_I,STB_I,OutputReady) 
begin
	if rising_edge(CLK_I) then
	if RST_I='1' then
		readcount<=0;
	else	
		-------------write
		if OutputReady='1' and read_ack_int='0' then
			read_buf(writecount)<=input;
			read_ack_int<='1';
			if writecount= depth then
				writecount<=0;
			else 
				writecount<=writecount+1;
			end if;
		end if;
		
		if WE_I='0' and STB_I ='1' and adress=to_integer(unsigned(ADR_I))and ACK_O_int='0' then
			ACK_O_int<='1';
			DAT_O<=read_buf(readcount);-- zet data klaar
			if readcount= depth then
				readcount<=0;
			else
				readcount<=readcount+1;
			end if;
		end if;
		------check is de queue vol ? code moet nog bedacht worden
		--if writecount=readcount then
	end if;
	end if;

	if STB_I= '0' then
		ACK_O_int<='0';
	end if;
	if OutputReady='0' then
		read_ack_int<='0';
	end if;
end process;
		ACK_O<=ACK_O_int;
		read_ack<=read_ack_int;
end Behavioral;

