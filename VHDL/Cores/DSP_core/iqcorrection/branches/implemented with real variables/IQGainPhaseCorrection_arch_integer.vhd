library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 
use ieee.std_logic_unsigned.all;
use ieee.math_real.all;


architecture IQGainPhaseCorrection_integer of IQGainPhaseCorrection is
	
	
begin

    correction : process (clk) is
	
	variable x1_real : real := 0.0;
	variable y1_real : real := 0.0;
	variable reg_1x1 : real := 0.0;
	variable y2      : real := 0.0;
	variable mu_1    : real := 0.000244;
	variable mu_2    : real := 0.000122;
	variable x1y2    : real := 0.0;
	variable reg_1   : real := 0.0;
	variable reg_2   : real := 1.0;
	variable y3      : real := 0.0;
	
	variable lock_counter : integer range 0 to 100 := 0;
	variable trail_reg_1 : real := 0.0;
	variable trail_reg_2 : real := 1.0;
	
		begin
		
   		if clk'event and clk = '1' then
			   --get the signed I and Q values. Convert them to real values. 
			   x1_real := real(to_integer(x1));
			   x1_real := x1_real / ((2.0**31.0)-1.0);
			   y1_real := real(to_integer(y1));
			   y1_real := y1_real / ((2.0**31.0)-1.0);
			   
			   
			   --phase error estimate, step size set to 0.000244
			   y2 := y1_real - reg_1 * x1_real;
			   reg_1 := reg_1 + mu_1*x1_real*y2;	   
			   
			   --convert to signed.			   
			   phase_error <= to_signed(integer(trunc(reg_1*((2.0**31.0)-1.0))), 32);
	
			   
			   --gain error estimate, step size set to 0.000122
			   y3 := y2 * reg_2;
			   reg_2 := reg_2 + mu_2 * ((x1_real*x1_real) - (y3*y3));
			   
			   
			   
			   
			   if (lock_counter = 100) then
				   
				   --if (abs(trail_reg_2 - reg_2) < 0.0005) then --early lock	
				   if (abs(trail_reg_2 - reg_2) < 0.00025) then	 --locks later
					   gain_lock <= '1';  --gain error is settling
				   else
					   gain_lock <= '0';  --gain error is not settled yet
				   end if;
				   
				   --if (abs(trail_reg_1 - reg_1) < 0.001) then	 --early lock
				   if (abs(trail_reg_1 - reg_1) < 0.00025) then	 --locks later
					   phase_lock <= '1';  --gain error is settling
				   else
					   phase_lock <= '0';  --gain error is not settled yet
				   end if;
				   
				   trail_reg_2 := reg_2;
				   trail_reg_1 := reg_1;
				   
			   end if;
			   
			   
			   --convert to signed.
			   gain_error <= to_signed(integer(trunc(reg_2*((2.0**31.0)-1.0))), 32);
			   
			   
			   
			   
			   corrected_x1 <= x1;  --I is passed along unchanged. No filter delay in this implementation.
			   corrected_y1 <= to_signed(integer(trunc((y1_real*reg_2*(cos(reg_1)))*((2.0**31.0)-1.0))), 32); --Q is corrected and then passed along.
			   
			   lock_counter := (lock_counter + 1) mod 101; --update counter that picks out values to test for phase and gain lock.
		
		end if;
		  
	end process;	

end IQGainPhaseCorrection_integer;	




