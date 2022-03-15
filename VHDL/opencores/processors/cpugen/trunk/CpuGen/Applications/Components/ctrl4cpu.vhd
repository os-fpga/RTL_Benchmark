-- CTRL4CPU 
-- gferrante@opencores.org
--

library ieee;
use ieee.std_logic_1164.all;

entity ctrl4cpu is

	port(	
		nWR_RAM:		out	std_logic;
		nCS_PWM:		out	std_logic;

		CPU_DATA_IN:	out	std_logic_vector(3 downto 0);
		CTRL_DATA_OUT:	out	std_logic_vector(3 downto 0);
		PWM_DATA_OUT:	out	std_logic_vector(7 downto 0);

		CPU_ADDR_OUT:	in	std_logic_vector(4 downto 0);
		CPU_DATA_OUT:	in	std_logic_vector(3 downto 0);
		
		RAM_DATA_OUT:	in	std_logic_vector(3 downto 0);
		CTRL_DATA_IN:	in	std_logic_vector(3 downto 0);

		nWE_CPU:		in	std_logic;
		nRE_CPU:		in	std_logic;
		clk:			in	std_logic;
		nreset:		in	std_logic
	);
end;

architecture ctrl4cpu_struct of ctrl4cpu is
 
CONSTANT 	MUX_IN	: integer := 1;

CONSTANT	RAM_IN		: std_logic_vector((MUX_IN - 1) downto 0) := "0";
CONSTANT	CTRL_IN		: std_logic_vector((MUX_IN - 1) downto 0) := "1";
 
CONSTANT 	CTRL_ADDR		:std_logic_vector(4 downto 0):= "10000";
CONSTANT 	PWMPL_ADDR		:std_logic_vector(4 downto 0):= "10010";
CONSTANT 	PWMPH_ADDR		:std_logic_vector(4 downto 0):= "10011";
CONSTANT 	PWMLL_ADDR		:std_logic_vector(4 downto 0):= "10100";
CONSTANT 	PWMLH_ADDR		:std_logic_vector(4 downto 0):= "10101";
 
SIGNAL 		pwm_data_x		:std_logic_vector(3 downto 0);  
SIGNAL 		pwm_data_c		:std_logic_vector(3 downto 0);  

SIGNAL 		ctrl_data_x		:std_logic_vector(3 downto 0);  
SIGNAL 		ctrl_data_c		:std_logic_vector(3 downto 0);  

SIGNAL 		mux_c			:std_logic_vector((MUX_IN - 1) downto 0);  

begin
	
	process (clk, nreset, CPU_ADDR_OUT)

	begin

		if (nreset = '0') then

			mux_c		<=	RAM_IN;
			pwm_data_c	<=	(others => '0');
			ctrl_data_c	<=	(others => '0');

		elsif (rising_edge(clk)) then

			if (CPU_ADDR_OUT(4 downto 0) = CTRL_ADDR) then
				mux_c		<=	CTRL_IN;																							
			else
				mux_c		<=	RAM_IN;						
			end if;			
			pwm_data_c		<=	pwm_data_x;	
			ctrl_data_c		<=	ctrl_data_x;
		
		end if;

	end process;
	
	process (nreset, CPU_ADDR_OUT, nWE_CPU, mux_c, CTRL_DATA_IN, RAM_DATA_OUT,
			CPU_DATA_OUT, pwm_data_c, ctrl_data_c)

	begin

		case	mux_c is
			when RAM_IN 	=>	CPU_DATA_IN	<=	RAM_DATA_OUT;
			when CTRL_IN 	=>	CPU_DATA_IN	<=	CTRL_DATA_IN;
			when others		=>	CPU_DATA_IN	<=	RAM_DATA_OUT;
		end case;
		
		if ((nreset = '1') and (nWE_CPU = '0')) then
			if (CPU_ADDR_OUT(4) = '0') then
				nWR_RAM		<= '0';
				nCS_PWM		<= '1';
				ctrl_data_x		<= ctrl_data_c;
				pwm_data_x		<= pwm_data_c;	
			elsif (CPU_ADDR_OUT(4 downto 0) = CTRL_ADDR) then 
				nWR_RAM		<= '1';
				nCS_PWM		<= '1';
				ctrl_data_x		<=	CPU_DATA_OUT;
				pwm_data_x		<= pwm_data_c;
			elsif (CPU_ADDR_OUT(4 downto 0) = PWMPL_ADDR) then 
				nWR_RAM		<= '1';
				nCS_PWM		<= '0';
				ctrl_data_x		<= ctrl_data_c;
				pwm_data_x		<= pwm_data_c;
			elsif (CPU_ADDR_OUT(4 downto 0) = PWMPH_ADDR) then 
				nWR_RAM		<= '1';
				nCS_PWM		<= '1';
				ctrl_data_x		<= ctrl_data_c;
				pwm_data_x		<= CPU_DATA_OUT;
			elsif (CPU_ADDR_OUT(4 downto 0) = PWMLL_ADDR) then 
				nWR_RAM		<= '1';
				nCS_PWM		<= '0';
				ctrl_data_x		<= ctrl_data_c;
				pwm_data_x		<= pwm_data_c;
			elsif (CPU_ADDR_OUT(4 downto 0) = PWMLH_ADDR) then 
				nWR_RAM		<= '1';
				nCS_PWM		<= '1';
				ctrl_data_x		<= ctrl_data_c;
				pwm_data_x		<= CPU_DATA_OUT;
			else
				nWR_RAM		<= '1';
				nCS_PWM		<= '1';
				ctrl_data_x		<= ctrl_data_c;
				pwm_data_x		<= pwm_data_c;
			end if;	
		else
			nWR_RAM		<= '1';
			nCS_PWM		<= '1';
			ctrl_data_x		<= ctrl_data_c;
			pwm_data_x		<= pwm_data_c;
		end if;

	end process;
			
	PWM_DATA_OUT	<=	pwm_data_c & CPU_DATA_OUT;
	CTRL_DATA_OUT	<=  	ctrl_data_c;
					                              			
end ctrl4cpu_struct;
