--deze modulle/testbench is gemaakt door boris smidt.
--voor deze modulles kan je geen punten verdienen
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity IOALU is
    Port ( 
			  ACK_I:  in  std_logic; --The acknowledge input 
           ADR_O:  out std_logic_vector( 7  downto 0 ):=X"00"; --adres output
           CLK_I:  in  std_logic;--clock input
           CYC_O:  out std_logic;-- The cycle output dient voor block doorvoer
           
			  DAT_I:  in  std_logic_vector( 7 downto 0 );--data in
           DAT_O:  out std_logic_vector( 7 downto 0 );--data out
           RST_I:  in  std_logic;--reset in
           --SEL_O:  out std_logic;--deze input dient voor het selecteren van de poort word echter niet gebruikt als er maar met 8 bit word gewerkt
           STB_O:   out std_logic;--The strobe output
           WE_O :	out std_logic;--write enable output 0 is read 1 is write
			  
			  
			  enable : in std_logic;
			  adress  : in  STD_LOGIC_VECTOR (7 downto 0);
			  
			  db_in	 : in  STD_LOGIC_VECTOR (7 downto 0);
			  db_out  : out  STD_LOGIC_VECTOR (7 downto 0);
			  
			  rs232_we: out	STD_LOGIC;
			  queue_ack: in  STD_LOGIC;
			  
           opcode  : in  STD_LOGIC;
			  error	 : out	STD_LOGIC;
			  
			  next_instructie: out std_logic:='1');
end IOALU;

architecture Behavioral of IOALU is
type state is(AdressOut, readwrite,toqueue);
signal currentstate :state :=AdressOut;
signal timeout :integer range 0 to 7 := 0;
signal enable_int: std_logic := '0';
begin
process(CLK_I)

begin
if rising_edge(CLK_I) then
	if RST_I='1' then
		null;
	else
	
		if enable ='1' then
			enable_int<='1';
		end if;
		if enable_int='1' then
		if opcode='0' then
			if AdressOut = currentstate  then
				next_instructie<='0';
				ADR_O<=adress;
				CYC_O<='1';
				WE_O <='0';	
				STB_O<='1';
				currentstate<=readwrite;
				timeout<=0;
			elsif currentstate=readwrite then
				if ACK_I='1' then
					CYC_O<='0';
					WE_O <='0';	
					STB_O<='0';
					ADR_O<="00000000";
					currentstate<=toqueue;
					db_out<=DAT_I;
					rs232_we<='1';
					timeout<=0;
				elsif timeout=7 then
					CYC_O<='0';
					WE_O <='0';	
					STB_O<='0';
					ADR_O<="00000000";
					next_instructie<='1';
					currentstate<=AdressOut;
					error<='1';
					timeout<=0;
				else
					timeout<=timeout+1;
				end if;
				
			elsif currentstate=toqueue then
				if queue_ack='1' then
					rs232_we<='0';
					next_instructie<='1';
					currentstate<=AdressOut;
					enable_int<='0';
				end if;
			end if;
		
		
	--------------------------------write
		else
			if AdressOut =currentstate  then
				next_instructie<='0';
				ADR_O<=adress;
				DAT_O<=db_in;
				CYC_O<='1';
				WE_O <='1';	
				STB_O<='1';
				currentstate<=readwrite;
				timeout<=0;
			elsif currentstate=readwrite then
				if ACK_I='1' then
					CYC_O<='0';
					WE_O <='0';	
					STB_O<='0';
					currentstate<=AdressOut;
					ADR_O<="00000000";
					next_instructie<='1';
					timeout<=0;
					enable_int<='0';
				elsif timeout=7 then
					CYC_O<='0';
					WE_O <='0';	
					STB_O<='0';
					ADR_O<="00000000";
					currentstate<=AdressOut;
					error<='1';
					timeout<=0;
					enable_int<='0';
					next_instructie<='1';
				else
					timeout<=timeout+1;
				end if ;
			end if;
		end if;
		end if;
	end if;
end if;
end process;
end Behavioral;

