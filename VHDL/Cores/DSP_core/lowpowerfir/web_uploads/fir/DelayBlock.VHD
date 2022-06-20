LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
ENTITY DelayBlock IS PORT (
	DIN : IN std_logic;
	DOUT : OUT std_logic
); 

END DelayBlock;



ARCHITECTURE STRUCTURE OF DelayBlock IS

-- COMPONENTS

COMPONENT \7400\
	PORT (
	A_A : IN std_logic;
	B_A : IN std_logic;
	Y_A : OUT std_logic;
	GND : IN std_logic;
	VCC : IN std_logic;
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

SIGNAL N00093 : std_logic;
SIGNAL GND : std_logic;
SIGNAL VCC : std_logic;
SIGNAL N00440 : std_logic;
SIGNAL N00482 : std_logic;

-- GATE INSTANCES

BEGIN
U1 : \7400\	PORT MAP(
	A_A => DIN, 
	B_A => DIN, 
	Y_A => N00093, 
	GND => GND, 
	VCC => VCC, 
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
U2 : \7400\	PORT MAP(
	A_A => N00093, 
	B_A => N00093, 
	Y_A => N00440, 
	GND => GND, 
	VCC => VCC, 
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
U3 : \7400\	PORT MAP(
	A_A => N00440, 
	B_A => N00440, 
	Y_A => N00482, 
	GND => GND, 
	VCC => VCC, 
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
U4 : \7400\	PORT MAP(
	A_A => N00482, 
	B_A => N00482, 
	Y_A => DOUT, 
	GND => GND, 
	VCC => VCC, 
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

