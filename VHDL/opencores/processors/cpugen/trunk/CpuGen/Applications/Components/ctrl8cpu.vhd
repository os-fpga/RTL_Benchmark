-- CTRL8CPU 
-- gferrante@opencores.org
--

library ieee;
use ieee.std_logic_1164.all;

entity ctrl8cpu is

	port(	
		nWE_RAM:		out	std_logic;
		nCS_INT:		out	std_logic;
		nCS_UART:		out	std_logic;
		nCS_TIMER:		out	std_logic;
		nCS_REG:		out	std_logic;

		CPU_DATA_IN:	out	std_logic_vector(7 downto 0);

		CPU_ADDR_OUT:	in	std_logic_vector(9 downto 0);		
		CPU_DATA_OUT:	in	std_logic_vector(7 downto 0);

		RAM_DATA_OUT:	in	std_logic_vector(7 downto 0);
		INT_DATA_OUT:	in	std_logic_vector(7 downto 0);
		REG_DATA_OUT:	in	std_logic_vector(7 downto 0);
		TIMER_DATA_OUT:	in	std_logic_vector(7 downto 0);
		UART_DATA_OUT:	in	std_logic_vector(7 downto 0);

		nWE_CPU:		in	std_logic;
		nRE_CPU:		in	std_logic;
		clk:			in	std_logic;
		nreset:		in	std_logic
	);
end;

architecture ctrl8cpu_struct of ctrl8cpu is
 
CONSTANT 	MUX_IN		: integer := 3;

CONSTANT	RAM_IN		: std_logic_vector((MUX_IN - 1) downto 0) := "000";
CONSTANT	INT_IN		: std_logic_vector((MUX_IN - 1) downto 0) := "001";
CONSTANT	REG_IN		: std_logic_vector((MUX_IN - 1) downto 0) := "010";
CONSTANT	TIMER_IN	: std_logic_vector((MUX_IN - 1) downto 0) := "011";
CONSTANT	UART_IN		: std_logic_vector((MUX_IN - 1) downto 0) := "100";
 
CONSTANT 	INT_ADDR		:std_logic_vector((MUX_IN - 1) downto 0):= "001";
CONSTANT 	REG_ADDR		:std_logic_vector((MUX_IN - 1) downto 0):= "010";
CONSTANT 	TIMER_ADDR		:std_logic_vector((MUX_IN - 1) downto 0):= "011";
CONSTANT 	UART_ADDR		:std_logic_vector((MUX_IN - 1) downto 0):= "100";
 
SIGNAL 		mux_x			:std_logic_vector((MUX_IN - 1) downto 0);  
SIGNAL 		mux_c			:std_logic_vector((MUX_IN - 1) downto 0);  

begin
	
	process (clk, nreset)

	begin

		if (nreset = '0') then

			mux_c		<=	RAM_IN;

		elsif (rising_edge(clk)) then

			mux_c		<=	mux_x;

		end if;

	end process;
	
	process (nreset,CPU_ADDR_OUT,nWE_CPU,mux_c, 
			CPU_DATA_OUT,RAM_DATA_OUT,INT_DATA_OUT,
			REG_DATA_OUT,TIMER_DATA_OUT,UART_DATA_OUT)

	begin

		case	mux_c is
			when RAM_IN 	=>	CPU_DATA_IN	<=	RAM_DATA_OUT;
			when INT_IN 	=>	CPU_DATA_IN	<=	INT_DATA_OUT;
			when REG_IN 	=>	CPU_DATA_IN	<=	REG_DATA_OUT;
			when TIMER_IN 	=>	CPU_DATA_IN	<=	TIMER_DATA_OUT;
			when UART_IN 	=>	CPU_DATA_IN	<=	UART_DATA_OUT;
			when others		=>	CPU_DATA_IN	<=	RAM_DATA_OUT;
		end case;
		
		if (nreset = '1') then
			if (CPU_ADDR_OUT(8) = '1') then		-- REG zone
				if (CPU_ADDR_OUT(4 downto 2) = INT_ADDR) then
					mux_x		<= INT_IN;
					nCS_INT	<= '0';
					nCS_UART	<= '1';
					nCS_TIMER	<= '1';
					nCS_REG	<= '1';
					nWE_RAM	<= '1';
				elsif (CPU_ADDR_OUT(4 downto 2) = REG_ADDR) then
					mux_x		<= REG_IN;	
					nCS_INT	<= '1';
					nCS_UART	<= '1';
					nCS_TIMER	<= '1';
					nCS_REG	<= '0';
					nWE_RAM	<= '1';
				elsif (CPU_ADDR_OUT(4 downto 2) = TIMER_ADDR) then
					mux_x		<= TIMER_IN;	
					nCS_INT	<= '1';
					nCS_UART	<= '1';
					nCS_TIMER	<= '0';
					nCS_REG	<= '1';
					nWE_RAM	<= '1';		
				elsif (CPU_ADDR_OUT(4 downto 2) = UART_ADDR) then
					mux_x		<= UART_IN;	
					nCS_INT	<= '1';
					nCS_UART	<= '0';
					nCS_TIMER	<= '1';
					nCS_REG	<= '1';
					nWE_RAM	<= '1';		
				else
					mux_x		<= RAM_IN;	
					nCS_INT	<= '1';
					nCS_UART	<= '1';
					nCS_TIMER	<= '1';
					nCS_REG	<= '1';
					nWE_RAM	<= '1';
				end if;	
			else			-- RAM zone
				mux_x		<= RAM_IN;	
				nCS_INT	<= '1';
				nCS_UART	<= '1';
				nCS_TIMER	<= '1';
				nCS_REG	<= '1';
				if (nWE_CPU = '0') then
					nWE_RAM <= '0';		
				else
					nWE_RAM <= '1';	
				end if;
			end if;
		else
			mux_x		<= RAM_IN;	
			nCS_INT	<= '1';
			nCS_UART	<= '1';
			nCS_TIMER	<= '1';
			nCS_REG	<= '1';
			nWE_RAM	<= '1';	
		end if;
	
	end process;
								                              			
end ctrl8cpu_struct;
