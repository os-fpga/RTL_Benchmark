-- TX_UART
-- gferrante@opencores.org
--
-- BAUD,(8,N,1 fixed):
-- (clock_freq) / (16 * BAUD) = (d+1) => d = TX_CLK_DIV
-- 
-- nCS_UART = '0' and nWE = '0' and addr = 0 =>	tx_uart_fifo	<=	tx_uart_data; clear tx_uart_empty;
-- nCS_UART = '0' and nWE = '0' and addr = 1 =>	BAUD			<=	tx_uart_data;
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
USE ieee.std_logic_arith.all;

entity TX_UART is
	
	port(	
		tx_uart:		out   std_logic;
		tx_uart_empty:	out   std_logic;
		tx_uart_data:	in	std_logic_vector(7 downto 0);
		addr:			in	std_logic;		
		nWE:			in	std_logic;
		nCS_UART:		in	std_logic;
		clk:			in	std_logic;
		nreset:			in	std_logic
	);
end;

architecture TX_UART_STRUCT of TX_UART is
   
type		 TX_STATE is (IDLE, DATA); 
										 
CONSTANT	TX_BIT			: integer := 10;
CONSTANT	ALL_ZERO		: std_logic_vector(7 downto 0) := (others => '0');
CONSTANT	COUNT_ZERO		: std_logic_vector(3 downto 0) := (others => '0');
SIGNAL		tx_clk_div		: std_logic_vector(7 downto 0);
SIGNAL		tx_clk_count	: std_logic_vector(7 downto 0);
SIGNAL 		tx_uart_shift	: std_logic_vector(TX_BIT downto 0);  
SIGNAL 		tx_uart_fifo	: std_logic_vector(7 downto 0);  
SIGNAL 		tx_uart_busy	: std_logic;

begin

	process (nreset, clk)
	
	variable 	tx_s			: TX_STATE;
	variable 	tx_bit_count	: std_logic_vector(3 downto 0);
	variable 	tx_16_count		: std_logic_vector(3 downto 0);

	begin

		if (nreset = '0') then

			tx_clk_div		<= (others => '0');
			tx_uart_fifo	<= (others => '1');
			tx_uart_shift	<= (others => '1');
			tx_clk_count	<= (others => '0');								
			tx_uart			<= '1';				
			tx_bit_count	:= COUNT_ZERO;
			tx_s			:= IDLE;
			tx_uart_busy	<= '0';					

		elsif (rising_edge(clk)) then
																		
			if (tx_clk_count = ALL_ZERO) then

				case tx_s is
					
					when IDLE 	=>
						tx_uart	<= '1';		
						if (tx_uart_busy = '1') then
							tx_uart_shift(10)	<= '1';	-- INTERCHAR BIT							
							tx_uart_shift(9)	<= '1';	-- STOP BIT
							tx_uart_shift(8 downto 1)	<= tx_uart_fifo;
							tx_uart_shift(0)	<= '0';	-- START BIT														
							tx_bit_count		:= 	COUNT_ZERO;	
							tx_16_count			:=  COUNT_ZERO;		
							tx_uart_busy 		<= '0';					
							tx_s 				:= DATA;
						end if;						
					when DATA 	=>
						tx_uart	<= tx_uart_shift(Conv_Integer(unsigned(tx_bit_count)));						
						if (tx_16_count = "1111") then
							if (tx_bit_count < TX_BIT) then 
								tx_bit_count := tx_bit_count + 1;
							else
								tx_s := IDLE;
								tx_bit_count := COUNT_ZERO;
							end if;
							tx_16_count := COUNT_ZERO;
						else
							tx_16_count := tx_16_count + 1;
						end if;					
					when others => 	
						tx_uart	<= '1';											
						tx_16_count  	:= COUNT_ZERO;
						tx_bit_count 	:= COUNT_ZERO;
						tx_s			:= IDLE;			
				end case;
					
				tx_clk_count	<= tx_clk_div;
					
			else
				
				tx_clk_count <= tx_clk_count - 1;
					
			end if;
						
			if ((nWE = '0') and (nCS_UART = '0') and (addr = '0')) then
				
				tx_uart_fifo	<=	tx_uart_data;
				tx_uart_busy	<=	'1';

			elsif ((nWE = '0') and (nCS_UART = '0') and (addr = '1')) then
				
				tx_clk_div		<=	tx_uart_data;

			end if;

		end if;

	end process;
	
	tx_uart_empty	<=	not tx_uart_busy;
					                              			
end TX_UART_STRUCT;
