LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
ENTITY ORPart IS PORT (
	Output : OUT std_logic;
	A : IN std_logic;
	B : IN std_logic;
	C : IN std_logic;
	D : IN std_logic;
	E : IN std_logic;
	F : IN std_logic;
	G : IN std_logic;
	H : IN std_logic
); 

END ORPart;



ARCHITECTURE STRUCTURE OF ORPart IS

-- COMPONENTS

COMPONENT \7432\
	PORT (
	A_A : IN std_logic;
	B_A : IN std_logic;
	Y_A : OUT std_logic;
	VCC : IN std_logic;
	GND : IN std_logic;
	A_B : IN std_logic;
	B_B : IN std_logic;
	Y_B : OUT std_logic;
	A_C : IN std_logic;
	B_C : IN std_logic;
	Y_C : OUT std_logic;
	A_D : IN std_logic;
	B_D : IN std_logic;
	Y_D : OUT std_logic
	); END COMPONENT;

-- SIGNALS

SIGNAL VCC : std_logic;
SIGNAL GND : std_logic;
SIGNAL N00243 : std_logic;
SIGNAL N00286 : std_logic;
SIGNAL N00328 : std_logic;
SIGNAL N00370 : std_logic;
SIGNAL N00412 : std_logic;
SIGNAL N00454 : std_logic;

-- GATE INSTANCES

BEGIN
U1 : \7432\	PORT MAP(
	A_A => A, 
	B_A => B, 
	Y_A => N00243, 
	VCC => VCC, 
	GND => GND, 
	A_B => 'Z', 
	B_B => 'Z', 
	Y_B => OPEN, 
	A_C => 'Z', 
	B_C => 'Z', 
	Y_C => OPEN, 
	A_D => 'Z', 
	B_D => 'Z', 
	Y_D => OPEN
);
U2 : \7432\	PORT MAP(
	A_A => C, 
	B_A => D, 
	Y_A => N00286, 
	VCC => VCC, 
	GND => GND, 
	A_B => 'Z', 
	B_B => 'Z', 
	Y_B => OPEN, 
	A_C => 'Z', 
	B_C => 'Z', 
	Y_C => OPEN, 
	A_D => 'Z', 
	B_D => 'Z', 
	Y_D => OPEN
);
U3 : \7432\	PORT MAP(
	A_A => E, 
	B_A => F, 
	Y_A => N00328, 
	VCC => VCC, 
	GND => GND, 
	A_B => 'Z', 
	B_B => 'Z', 
	Y_B => OPEN, 
	A_C => 'Z', 
	B_C => 'Z', 
	Y_C => OPEN, 
	A_D => 'Z', 
	B_D => 'Z', 
	Y_D => OPEN
);
U4 : \7432\	PORT MAP(
	A_A => G, 
	B_A => H, 
	Y_A => N00370, 
	VCC => VCC, 
	GND => GND, 
	A_B => 'Z', 
	B_B => 'Z', 
	Y_B => OPEN, 
	A_C => 'Z', 
	B_C => 'Z', 
	Y_C => OPEN, 
	A_D => 'Z', 
	B_D => 'Z', 
	Y_D => OPEN
);
U5 : \7432\	PORT MAP(
	A_A => N00243, 
	B_A => N00286, 
	Y_A => N00454, 
	VCC => VCC, 
	GND => GND, 
	A_B => 'Z', 
	B_B => 'Z', 
	Y_B => OPEN, 
	A_C => 'Z', 
	B_C => 'Z', 
	Y_C => OPEN, 
	A_D => 'Z', 
	B_D => 'Z', 
	Y_D => OPEN
);
U6 : \7432\	PORT MAP(
	A_A => N00328, 
	B_A => N00370, 
	Y_A => N00412, 
	VCC => VCC, 
	GND => GND, 
	A_B => 'Z', 
	B_B => 'Z', 
	Y_B => OPEN, 
	A_C => 'Z', 
	B_C => 'Z', 
	Y_C => OPEN, 
	A_D => 'Z', 
	B_D => 'Z', 
	Y_D => OPEN
);
U7 : \7432\	PORT MAP(
	A_A => N00454, 
	B_A => N00412, 
	Y_A => OUTPUT, 
	VCC => VCC, 
	GND => GND, 
	A_B => 'Z', 
	B_B => 'Z', 
	Y_B => OPEN, 
	A_C => 'Z', 
	B_C => 'Z', 
	Y_C => OPEN, 
	A_D => 'Z', 
	B_D => 'Z', 
	Y_D => OPEN
);
END STRUCTURE;

