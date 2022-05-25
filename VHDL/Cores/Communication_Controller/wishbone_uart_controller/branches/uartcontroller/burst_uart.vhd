----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:50:17 04/16/2013 
-- Design Name: 
-- Module Name:    burst_uart - Behavioral 
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity burst_uart is
    Port ( CLOCK : in  STD_LOGIC;
			  DBIN  : in  std_logic_vector(7 downto 0);
			  write_strobe: in  STD_LOGIC;
			  ack: out std_logic;
			  RESET: in  STD_LOGIC;
			  DATA_STREAM_OUT_ACK : IN std_logic;
			  DATA_OUT : OUT std_logic_vector(7 downto 0);
			  DATA_STREAM_OUT_STB : OUT std_logic;
			  RX : IN std_logic;
			  TX : OUT std_logic
			  );
end burst_uart;

architecture Behavioral of burst_uart is
	COMPONENT uart_queue
	PORT(
			clk : IN std_logic;
			 DBIN : IN std_logic_vector(7 downto 0);
			 write_strobe : IN std_logic;
			 read_strobe : IN std_logic;          
			 DBOUT : OUT std_logic_vector(7 downto 0);
			 ack: OUT std_logic:='0';
			 WR : OUT std_logic:='0');
		
	END COMPONENT;

	COMPONENT UART
	Generic (
        BAUD_RATE           : positive:=230400;-- 9600;-- tijdelijke laage snelheid zal 
		  --later opgetrokken worden naar 19200 of 
		  --115200 
        CLOCK_FREQUENCY     : positive:= 50000000
        );
	PORT(
		CLOCK : IN std_logic;
		RESET : IN std_logic;
		DATA_STREAM_IN : IN std_logic_vector(7 downto 0);
		DATA_STREAM_IN_STB : IN std_logic;
		DATA_STREAM_OUT_ACK : IN std_logic;
		DATA_STREAM_IN_TBE  :   out	  std_logic;
		RX : IN std_logic;          
		DATA_STREAM_IN_ACK : OUT std_logic;
		DATA_STREAM_OUT : OUT std_logic_vector(7 downto 0);
		DATA_STREAM_OUT_STB : OUT std_logic;
		TX : OUT std_logic
		);
	END COMPONENT;

--
--	COMPONENT Rs232RefComp
--	PORT(
--		RXD : IN std_logic;
--		CLK : IN std_logic;
--		DBIN : IN std_logic_vector(7 downto 0);
--		RD : IN std_logic;
--		WR : IN std_logic;
--		RST : IN std_logic;          
--		TXD : OUT std_logic;
--		DBOUT : OUT std_logic_vector(7 downto 0);
--		RDA : OUT std_logic;
--		TBE : OUT std_logic;
--		OE : OUT std_logic
--		);
--	END COMPONENT;

	
signal wr_i :std_logic:='0';
signal DBOUT : std_logic_vector(7 downto 0);
signal  read_strobe :std_logic;
begin


	
	Inst_uart_sync: uart_queue PORT MAP(
		clk =>CLOCK ,
		write_strobe => write_strobe,
		read_strobe=>read_strobe,
		DBOUT => DBOUT,
		DBIN => DBIN,
		ack=>ack,
		WR => wr_i
	);

	Inst_UART: UART PORT MAP(
		CLOCK => CLOCK,
		RESET => RESET,
		DATA_STREAM_IN => DBOUT,
		DATA_STREAM_IN_STB => wr_i,
		DATA_STREAM_IN_ACK => read_strobe,
		DATA_STREAM_IN_TBE=> open,
		DATA_STREAM_OUT => DATA_OUT,
		DATA_STREAM_OUT_STB => DATA_STREAM_OUT_STB,
		DATA_STREAM_OUT_ACK => DATA_STREAM_OUT_ACK,
		TX => TX,
		RX => RX
	);

end Behavioral;

