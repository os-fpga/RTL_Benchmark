library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- c2003 Franks Development, LLC
-- http://www.franks-development.com
-- !This source is distributed under the terms & conditions specified at opencores.org
-- 
-- Please see the file "StepperMotorWiring.bmp" for info on connecting 4 & 6 
-- wire motors to your device.  This source should drive either type, though connection
-- to 4-wire motors requires significantly more FET's to buffer outputs.  The
-- circuitry for 6-wire motors is more straightforward.
--
-- Another practical consideration is the threshold voltage of the FET's used to
-- buffer the logic outputs & provide current drive to the motor.  Most power
-- FET's have a threshold voltage in the 5-12V range (or even higher),
-- while logic devices now run in the 3.3V and lower range.  Thus, you must be 
-- careful to choose a FET with a low threshold voltage, or a level-converter must
-- be utilized between the logic output and the gate of the drive FET's.
--
-- One of the most advantageous abilities of stepper motors is the ability to 
-- provide static holding force in any position.  Of course this consumes power
-- and heats the motor up significantly (though steppers are rated to handle this)
-- use of the "static holding" input port will specify this behavior.

entity StepperMotorPorts is
    Port (	
	 			StepDrive : out std_logic_vector(3 downto 0);
		 		clock : in std_logic;
		 		Direction : in std_logic;
		 		StepEnable : in std_logic --;
		 		--ProvideStaticHolding : in std_logic
		);
end StepperMotorPorts;

architecture StepDrive of StepperMotorPorts is

	signal state : std_logic_vector(1 downto 0);
	signal StepCounter : std_logic_vector(31 downto 0);
	constant StepLockOut : std_logic_vector(31 downto 0) := "00000000000000110000110101000000";

begin

	process(clock)
	begin

		if ( (clock'Event) and (clock = '1') ) then

			StepCounter <= StepCounter + "0000000000000000000000000000001";

			if (StepCounter >= StepLockOut) then

				StepCounter <= "00000000000000000000000000000000";

				StepDrive <= "0000";
				
				if (StepEnable = '1') then
				
					if (Direction = '1') then state <= state + "01"; end if;
					if (Direction = '0') then state <= state - "01"; end if;

					case state is 

						when "00" =>

							StepDrive <= "1010";			
							
						when "01" =>
		
							StepDrive <= "1001";
							
						when "10" =>
		
							StepDrive <= "0101";			
							
						when "11" =>
		
							StepDrive <= "0110";
							
						when others =>

					end case; --state
	
				end if;
	
			end if;

		end if;

	end process;

end StepDrive;
