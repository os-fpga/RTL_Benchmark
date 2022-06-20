LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
ENTITY Comb2 IS PORT (
	nQ0 : IN std_logic;
	nQ1 : IN std_logic;
	nQ3 : IN std_logic;
	D2 : OUT std_logic;
	Q0 : IN std_logic;
	Q1 : IN std_logic;
	Q2 : IN std_logic
); 

END Comb2;



ARCHITECTURE STRUCTURE OF Comb2 IS

-- COMPONENTS

COMPONENT \7408\
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
SIGNAL N00390 : std_logic;
SIGNAL N00429 : std_logic;
SIGNAL N00468 : std_logic;
SIGNAL N00507 : std_logic;
SIGNAL N00546 : std_logic;
SIGNAL N00592 : std_logic;
SIGNAL N00638 : std_logic;
SIGNAL N00684 : std_logic;

-- GATE INSTANCES

BEGIN
U1 : \7408\	PORT MAP(
	A_A => Q2, 
	B_A => NQ1, 
	Y_A => N00684, 
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
U2 : \7408\	PORT MAP(
	A_A => Q2, 
	B_A => Q0, 
	Y_A => N00638, 
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
U3 : \7408\	PORT MAP(
	A_A => NQ3, 
	B_A => Q1, 
	Y_A => N00468, 
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
U4 : \7408\	PORT MAP(
	A_A => N00468, 
	B_A => NQ0, 
	Y_A => N00592, 
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
U5 : \7408\	PORT MAP(
	A_A => NQ3, 
	B_A => Q2, 
	Y_A => N00507, 
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
U6 : \7408\	PORT MAP(
	A_A => N00507, 
	B_A => Q1, 
	Y_A => N00546, 
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
	A_A => N00684, 
	B_A => N00638, 
	Y_A => N00390, 
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
U8 : \7432\	PORT MAP(
	A_A => N00390, 
	B_A => N00592, 
	Y_A => N00429, 
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
U9 : \7432\	PORT MAP(
	A_A => N00429, 
	B_A => N00546, 
	Y_A => D2, 
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

