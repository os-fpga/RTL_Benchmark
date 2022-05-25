library ieee; 
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.ALL; 
library work;

entity data_generator is
	port (
	    clk           : in std_logic;
	    Packet_Length : in std_logic_vector(6 downto 0);
	    TX_FIFO_Full  : in std_logic;
	    data_out	  : out std_logic_vector(63 downto 0);
        sop 		  : out std_logic;
        eop 		  : out std_logic;
        eop_valid 	  : out std_logic_vector(2 downto 0);
        channel 	  : out std_logic_vector(7 downto 0);
	    write_enable  : out std_logic
	);
end entity data_generator;

architecture rtl of data_generator is
	signal counter : integer range 0 to 512;
    signal data : std_logic_vector(63 downto 0):=(others => '0');
begin
    data_proc : process(clk)
    begin
		if rising_edge(clk) then
		    if(TX_FIFO_Full = '0') then
				sop <= '0';
                eop <= '0';
				eop_valid <= "000";
				counter <= counter + 1;
				channel <= X"01";
				
				if (counter = 0 ) then
					sop <= '1';
				elsif (counter = to_integer(unsigned(Packet_Length))) then
					counter <= 0;
					eop <= '1';
					eop_valid <= "111";
				end if;
				data <= data+1;
				
			end if;
		end if;
    end process;
    
    write_enable <= not TX_FIFO_Full;
    data_out <= data;

end architecture rtl;
