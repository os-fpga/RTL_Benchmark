LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY mac IS
	GENERIC (n   :   INTEGER := 4);	--define X and Y size 
	PORT (
		ck  : IN  STD_LOGIC;
		rst : IN  STD_LOGIC;
		X   : IN  SIGNED (n-1 DOWNTO 0); --n
		Y   : IN  SIGNED (n-1 DOWNTO 0); --n
		A   : OUT SIGNED ((2+2*n)-1 DOWNTO 0)  --2+2n (include two leading bits for overflow)
	);
END mac;

ARCHITECTURE hdl OF mac IS
	SIGNAL acc : SIGNED ((2+2*n)-1 DOWNTO 0) := (OTHERS => '0'); --2+2n

BEGIN

	PROCESS (ck)
	BEGIN
		IF rising_edge(ck) THEN
			IF rst ='0' THEN --reset accumulator at low
				acc <= (OTHERS => '0');
			ELSE
				acc <= acc + shift_left(X * Y, 1);
			END IF;
		END IF;
	END PROCESS;

	A <= acc;
END hdl;
