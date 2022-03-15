-- CTRL8CPUAPEX 
-- gferrante@opencores.org
--

library ieee;
use ieee.std_logic_1164.all;

entity ctrl8cpuApex is

	port(	
		nWE_RAM:		out	std_logic;
		nCS_INT:		out	std_logic;		
		nCS_UART_TX:	out	std_logic;
		nCS_UART_RX:	out	std_logic;
		nCS_TIMER:		out	std_logic;
		nWE_DISPLAY:		out	std_logic;
		nACS_DISPLAY:	out	std_logic;

		CPU_DATA_IN:	out	std_logic_vector(7 downto 0);

		CPU_ADADDR_OUT:	in	std_logic_vector(9 downto 0);	
		CPU_DADDR_OUT:	in	std_logic_vector(9 downto 0);					
		CPU_DATA_OUT:	in	std_logic_vector(7 downto 0);

		RAM_DATA_OUT:	in	std_logic_vector(7 downto 0);
		UART_DATA_OUT:	in	std_logic_vector(7 downto 0);
		INT_DATA_OUT:	in	std_logic_vector(7 downto 0);

		nAWE_CPU:		in	std_logic;
		nWE_CPU:		in	std_logic;
		nRE_CPU:		in	std_logic;
		clk:			in	std_logic;
		nreset:		in	std_logic
	);
end;

architecture ctrl8cpuApex_struct of ctrl8cpuApex is
 
CONSTANT 	MUX_IN	: integer := 3;

CONSTANT	RAM_IN		: std_logic_vector((MUX_IN - 1) downto 0) := "000";
CONSTANT	INT_IN		: std_logic_vector((MUX_IN - 1) downto 0) := "001";
CONSTANT	UART_IN		: std_logic_vector((MUX_IN - 1) downto 0) := "010";
 
CONSTANT 	INT_ADDR		:std_logic_vector((MUX_IN - 1) downto 0):= "000";
CONSTANT 	TX_UART_ADDR	:std_logic_vector((MUX_IN - 1) downto 0):= "001";
CONSTANT 	RX_UART_ADDR	:std_logic_vector((MUX_IN - 1) downto 0):= "010";
CONSTANT 	TIMER_ADDR		:std_logic_vector((MUX_IN - 1) downto 0):= "011";
CONSTANT 	DISPLAY_ADDR	:std_logic_vector((MUX_IN - 1) downto 0):= "100";
 
SIGNAL 		mux_x			:std_logic_vector((MUX_IN - 1) downto 0);  
SIGNAL 		mux_c			:std_logic_vector((MUX_IN - 1) downto 0);  

begin
	
	CTRL8: process (clk)

	begin

		if (nreset = '0') then
			mux_c		<=	RAM_IN;
		elsif (rising_edge(clk)) then
			mux_c		<=	mux_x;
		end if;

	end process;
	
	process (nreset,CPU_ADADDR_OUT,CPU_DADDR_OUT,nAWE_CPU,nWE_CPU,mux_c, 
			CPU_DATA_OUT,RAM_DATA_OUT,INT_DATA_OUT,UART_DATA_OUT)

	begin

		case	mux_c is
			when RAM_IN 	=>	CPU_DATA_IN	<=	RAM_DATA_OUT;
			when INT_IN 	=>	CPU_DATA_IN	<=	INT_DATA_OUT;
			when UART_IN 	=>	CPU_DATA_IN	<=	UART_DATA_OUT;
			when others		=>	CPU_DATA_IN	<=	RAM_DATA_OUT;
		end case;
		
		if (nreset = '1') then
			if ((CPU_ADADDR_OUT(8) = '1') and (CPU_ADADDR_OUT(4 downto 2) = DISPLAY_ADDR) and (nAWE_CPU = '0')) then
				nACS_DISPLAY	<= '0';					
			else
				nACS_DISPLAY	<= '1';								
			end if;

			if (CPU_DADDR_OUT(8) = '1') then		-- REG zone
				if (CPU_DADDR_OUT(4 downto 2) = INT_ADDR) then
					mux_x				<= INT_IN;
					nCS_INT			<= '0';
					nCS_UART_TX		<= '1';
					nCS_UART_RX		<= '1';
					nCS_TIMER		<= '1';
					nWE_DISPLAY		<= '1';
					nWE_RAM			<= '1';
				elsif (CPU_DADDR_OUT(4 downto 2) = TX_UART_ADDR) then
					mux_x			<= RAM_IN;
					nCS_INT			<= '1';
					nCS_UART_TX		<= '0';
					nCS_UART_RX		<= '1';
					nCS_TIMER		<= '1';
					nWE_DISPLAY		<= '1';
					nWE_RAM			<= '1';
				elsif (CPU_DADDR_OUT(4 downto 2) = RX_UART_ADDR) then
					mux_x			<= UART_IN;
					nCS_INT			<= '1';	
					nCS_UART_TX		<= '1';
					nCS_UART_RX		<= '0';
					nCS_TIMER		<= '1';
					nWE_DISPLAY		<= '1';
					nWE_RAM			<= '1';
				elsif (CPU_DADDR_OUT(4 downto 2) = TIMER_ADDR) then
					mux_x			<= RAM_IN;
					nCS_INT			<= '1';	
					nCS_UART_TX		<= '1';
					nCS_UART_RX		<= '1';
					nCS_TIMER		<= '0';
					nWE_DISPLAY		<= '1';
					nWE_RAM			<= '1';
				elsif ((CPU_DADDR_OUT(4 downto 2) = DISPLAY_ADDR) and (nWE_CPU = '0')) then
					mux_x			<= RAM_IN;
					nCS_INT			<= '1';	
					nCS_UART_TX		<= '1';
					nCS_UART_RX		<= '1';
					nCS_TIMER		<= '1';
					nWE_DISPLAY		<= '0';
					nWE_RAM			<= '1';
				else
					mux_x			<= RAM_IN;
					nCS_INT			<= '1';	
					nCS_UART_TX		<= '1';
					nCS_UART_RX		<= '1';
					nCS_TIMER		<= '1';
					nWE_DISPLAY		<= '1';
					nWE_RAM			<= '1';
				end if;	
			else			-- RAM zone
				mux_x			<= RAM_IN;	
				nCS_INT			<= '1';
				nCS_UART_TX		<= '1';
				nCS_UART_RX		<= '1';
				nCS_TIMER		<= '1';
				nWE_DISPLAY		<= '1';
				if (nWE_CPU = '0') then
					nWE_RAM 	<= '0';		
				else
					nWE_RAM 	<= '1';	
				end if;
			end if;
		else
			mux_x			<= RAM_IN;
			nCS_INT			<= '1';	
			nCS_UART_TX		<= '1';
			nCS_UART_RX		<= '1';
			nCS_TIMER		<= '1';
			nWE_DISPLAY		<= '1';
			nACS_DISPLAY	<= '1';					
			nWE_RAM			<= '1';
		end if;
	
	end process;
								                              			
end ctrl8cpuApex_struct;
