-- PWM
-- gferrante@opencores.org
--
--	pwm_enable = '1' => enable pwm
--	nCS_PWM = 0 and addr = 0 => pwm_period	<=	pwm_data;
--	nCS_PWM = 0 and addr = 1 => pwm_low		<=	pwm_data; -- pwm_high = pwm_period - pwm_low
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity PWM is
	
	port(	
		pwm_out:		out   std_logic := '0';
		pwm_data:		in	std_logic_vector(7 downto 0);
		addr:			in	std_logic;
		nWR:			in	std_logic;
		nCS_PWM:		in	std_logic;
		pwm_enable:		in	std_logic;
		clk:			in	std_logic;
		nreset:		in	std_logic
	);
end;

architecture PWM_STRUCT of PWM is
   
CONSTANT	ALL_ZERO	: std_logic_vector(7 downto 0) := (others => '0');
CONSTANT	ALL_ONE	: std_logic_vector(7 downto 0) := (others => '1');										 
CONSTANT	PWM_PRESC	: std_logic_vector(7 downto 0) := "00000000";

SIGNAL 	pwm_period	: std_logic_vector(7 downto 0);
SIGNAL 	pwm_low	: std_logic_vector(7 downto 0);
SIGNAL 	pwm_high	: std_logic_vector(7 downto 0);
SIGNAL 	pwm_pcount	: std_logic_vector(7 downto 0);
SIGNAL 	pwm_count	: std_logic_vector(7 downto 0);
SIGNAL 	pwm_c		: std_logic;

begin

	process (nreset, clk, pwm_data)

	begin

		if (nreset = '0') then

			pwm_low	<= (others => '0');
			pwm_high	<= (others => '0');
			pwm_pcount 	<= (others => '0');
			pwm_count 	<= (others => '0');
			pwm_c 	<= '0';

		elsif (rising_edge(clk)) then
						
			if ((nCS_PWM = '0') and (nWR = '0') and (addr = '1')) then	-- PWML
				pwm_low		<=	pwm_data;
				pwm_high	<=	pwm_period - pwm_data;
			elsif ((nCS_PWM = '0') and (nWR = '0') and (addr = '0')) then	-- PWMP
				pwm_period	<=	pwm_data;
				pwm_high	<=	pwm_data - pwm_low;
			end if;
				
			if (pwm_enable = '1') then
				if (PWM_PRESC > ALL_ZERO) and (pwm_pcount < PWM_PRESC) then
					pwm_pcount <= pwm_pcount + 1;
				else
					pwm_pcount <= (others => '0');

					if ((pwm_c = '0') and (pwm_count < pwm_low)) then
						pwm_count <= pwm_count + 1;
					elsif ((pwm_c = '1') and (pwm_count < pwm_high)) then
						pwm_count <= pwm_count + 1;
					else	
						pwm_count 	<= (others => '0');
						if (pwm_c = '1') then
							pwm_c 	<= '0';
						else
							pwm_c 	<= '1';
						end if;
					end if;
				end if;
			end if;
		
		end if;

	end process;
	
	pwm_out	<=	pwm_c;
					                              			
end PWM_STRUCT;
