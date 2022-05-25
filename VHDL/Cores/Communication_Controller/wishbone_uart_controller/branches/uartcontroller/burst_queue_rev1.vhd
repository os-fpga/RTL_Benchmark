
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity burst_queue_rev1 is
    Port (clk : IN std_logic;
			 DBIN : IN std_logic_vector(7 downto 0);
			 write_strobe : IN std_logic;
			 read_strobe : IN std_logic;          
			 DBOUT : OUT std_logic_vector(7 downto 0);
			 ack: OUT std_logic:='0';
			 WR : OUT std_logic:='0');
end burst_queue_rev1;

architecture Behavioral of burst_queue_rev1 is
type shiftreg is array(0 to 3) of std_logic_vector(7 downto 0);

signal data_buf	: shiftreg;

constant width 		: integer :=3;
signal WR_int			: std_logic:='0';
signal writecount 	: integer range 0 to 3:=0;
signal readcount		: integer range 0 to 4:=0; 
signal ack_int			: std_logic:='0';
begin
process(clk,write_strobe) 

begin
	if rising_edge(clk) then
		
		if write_strobe='1' and ack_int='0' then
			if(readcount< 4 )then
				data_buf(writecount)<=DBIN;
				writecount<=(writecount+1) mod 4;
				ack_int<='1';
				readcount<=readcount+1;
			else
				ack_int<='0';
			end if;
		end if;
		if WR_int='0' or read_strobe='1' then
			if(readcount>0) then
				DBOUT<=data_buf((writecount-readcount) mod 4);
				if write_strobe = '0' then
					readcount<=readcount-1;-- laagste teld
				else 
					if(readcount< 4 and ack_int='0')then
						readcount<=readcount;
					else
						readcount<=readcount-1;
					end if;
				end if;
				WR_int<='1';
			else
				WR_int<='0';
			end if;
		end if;
		
end if;
		if write_strobe ='0' then
			ack_int<='0';
		end if;
end process;
WR<=WR_int;
ack<=ack_int;
end Behavioral;

