-- RX_UART
-- gferrante@opencores.org
--
-- BAUD,(8,N,1 fixed):
-- (clock_freq) / (16 * BAUD) = (d+1) => d = RX_CLK_DIV
--
-- nCS_UART = '0' and nRE = '0' and addr = 0 =>	rx_uart_in	<=	rx_uart_fifo;
-- nCS_UART = '0' and nWE = '0' and addr = 1 =>	BAUD		<=	tx_uart_data; clear rx_uart_full; clear rx_uart_ovr;
--


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
USE ieee.std_logic_arith.all;

entity RX_UART is
	
	port(			
		rx_uart_full:	out std_logic;
		rx_uart_ovr:	out std_logic;
		rx_uart_out:	out	std_logic_vector(7 downto 0);
		rx_uart_in:		in	std_logic_vector(7 downto 0);
		rx_uart: 		in	std_logic;
		addr: 			in	std_logic;
		nWE:			in	std_logic;
		nRE:			in	std_logic;
		nCS_UART:		in	std_logic;
		clk:			in	std_logic;
		nreset:			in	std_logic
	);
end;

architecture RX_UART_STRUCT of RX_UART is

CONSTANT	IDLE		: std_logic_vector(1 downto 0) := "00";
CONSTANT	DATA		: std_logic_vector(1 downto 0) := "01";
CONSTANT	STOP		: std_logic_vector(1 downto 0) := "10";

					 
CONSTANT	STOP_BIT		: integer := 8;
CONSTANT	ALL_ZERO		: std_logic_vector(7 downto 0) := (others => '0');
CONSTANT	COUNT_ZERO		: std_logic_vector(3 downto 0) := (others => '0');
SIGNAL		rx_clk_div		: std_logic_vector(7 downto 0);
SIGNAL 		clk_rx			: std_logic;
SIGNAL 		rx_uart_full_d	: std_logic;
SIGNAL 		rx_uart_full_s	: std_logic;
SIGNAL 		rx_uart_full_c	: std_logic;
SIGNAL 		rx_uart_ovr_d	: std_logic;
SIGNAL 		rx_uart_ovr_s	: std_logic;
SIGNAL 		rx_uart_ovr_c	: std_logic;

SIGNAL 		rx_clk_count	: std_logic_vector(7 downto 0);
SIGNAL 		rx_uart_reg		: std_logic_vector(STOP_BIT downto 0);  
SIGNAL 		rx_uart_fifo	: std_logic_vector(7 downto 0);
SIGNAL 		rx_bit_count	: std_logic_vector(3 downto 0);
SIGNAL 		rx_8z_count		: std_logic_vector(3 downto 0);
SIGNAL 		rx_8_count		: std_logic_vector(3 downto 0);
SIGNAL 		rx_16_count		: std_logic_vector(3 downto 0);
SIGNAL		rx_s			: std_logic_vector(1 downto 0);


begin

	process (nreset, clk)


	begin

		if (nreset = '0') then

			rx_s			<= IDLE;
			rx_clk_div		<= (others => '0');
			rx_clk_count	<= (others => '0');
			rx_uart_full_c	<= '0';
			rx_uart_full_s	<= '0';
			rx_uart_full_d	<= '0';
			rx_uart_ovr_c	<= '0';
			rx_uart_ovr_s	<= '0';
			rx_uart_ovr_d	<= '0';
			rx_bit_count	<= COUNT_ZERO;
			rx_8z_count		<= COUNT_ZERO;
			rx_8_count		<= COUNT_ZERO;
			rx_16_count		<= COUNT_ZERO;
			rx_uart_fifo	<= (others => '0');
			rx_uart_reg		<= (others => '1');

		elsif (rising_edge(clk)) then
																		
			if (rx_clk_count = ALL_ZERO) then
				
				case rx_s is
					
					when IDLE 	=>
						rx_uart_full_s <= '0';	
						rx_uart_ovr_s 	<= '0';																						
						if (rx_uart = '0') then 
						 	if (rx_8z_count = "0111") then
								rx_s <= DATA;
								rx_8z_count <= COUNT_ZERO;
							else
								rx_s <= IDLE;
								rx_8z_count <= rx_8z_count + 1;
							end if;
						else
							rx_s <= IDLE;
							rx_8z_count <= COUNT_ZERO;
						end if;	
					when DATA 	=>
						rx_uart_full_s <= '0';	
						rx_uart_ovr_s 	<= '0';																						
						if (rx_16_count = "1111") then
							rx_uart_reg(Conv_Integer(unsigned(rx_bit_count))) <= rx_uart;
							if (rx_bit_count < STOP_BIT) then 
								rx_bit_count <= rx_bit_count + 1;
								rx_s <= DATA;
							else
								rx_s <= STOP;
								rx_bit_count <= COUNT_ZERO;
							end if;
							rx_16_count <= COUNT_ZERO;
						else
							rx_s <= DATA;
							rx_16_count <= rx_16_count + 1;
						end if;
					when STOP 	=>
						if (rx_8_count = "0111") then 
							rx_s <= IDLE;
							rx_uart_full_s <= '0';	
							rx_uart_ovr_s 	<= '0';																
							rx_8_count <= COUNT_ZERO;
						elsif ((rx_8_count = COUNT_ZERO) and (rx_uart_reg(STOP_BIT) = '1')) then
							rx_uart_fifo 	<= rx_uart_reg(7 downto 0);
							rx_uart_full_s 	<= '1';	
							if (rx_uart_full_d = '1') then
								rx_uart_ovr_s 	<= '1';
							else
								rx_uart_ovr_s 	<= '0';								
							end if;
							rx_8_count <= rx_8_count + 1;
							rx_s <= STOP;
						else
							rx_8_count <= rx_8_count + 1;
							rx_uart_full_s 	<= '0';	
							rx_uart_ovr_s 	<= '0';		
							rx_s <= STOP;														
						end if;					
					when others => 
				
						rx_8z_count <= COUNT_ZERO;
						rx_8_count <= COUNT_ZERO;
						rx_16_count  <= COUNT_ZERO;
						rx_bit_count <= COUNT_ZERO;
						rx_uart_full_s 	<= '0';
						rx_uart_ovr_s 	<= '0';	
						rx_s <= IDLE;							
					
					end case;
						
					rx_clk_count	<= rx_clk_div;

			else
				
				rx_clk_count <= rx_clk_count - 1;
				rx_uart_full_s 	<= '0';
				rx_uart_ovr_s 	<= '0';								
		
			end if;
						
			if ((nWE = '0') and (nCS_UART = '0') and (addr = '1')) then
				
				rx_clk_div		<=	rx_uart_in;
				rx_uart_full_c	<=	'1';
				rx_uart_ovr_c	<=	'1';
									
			elsif ((nRE = '0') and (nCS_UART = '0') and (addr = '0')) then

				rx_uart_full_c	<=	'1';
				rx_uart_ovr_c	<=	'1';

			else

				rx_uart_full_c	<=	'0';
				rx_uart_ovr_c	<=	'0';

			end if;

			if (rx_uart_full_s = '1') then

				rx_uart_full_d <= '1';

			elsif (rx_uart_full_c = '1') then

				rx_uart_full_d <= '0';
									
			end if;

			if (rx_uart_ovr_s = '1') then

				rx_uart_ovr_d <= '1';

			elsif (rx_uart_ovr_c = '1') then

				rx_uart_ovr_d <= '0';
										
			end if;

		end if;

	end process;

	rx_uart_full	<=	(rx_uart_full_d and (not rx_uart_full_c));
	rx_uart_ovr		<=	(rx_uart_ovr_d and (not rx_uart_ovr_c));
	rx_uart_out		<= 	rx_uart_fifo;
					                              			
end RX_UART_STRUCT;
