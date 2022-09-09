LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
ENTITY Comb3 IS PORT (
	nQ0 : IN std_logic;
	nQ1 : IN std_logic;
	D3 : OUT std_logic;
	Q0 : IN std_logic;
	Q1 : IN std_logic;
	Q2 : IN std_logic;
	Q3 : IN std_logic
); 

END Comb3;



ARCHITECTURE STRUCTURE OF Comb3 IS

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

-- SIGNALS

SIGNAL N00538 : std_logic;
SIGNAL N00756 : std_logic;
SIGNAL N00448 : std_logic;
SIGNAL N00370 : std_logic;
SIGNAL N00487 : std_logic;
SIGNAL N00331 : std_logic;
SIGNAL N00586 : std_logic;
SIGNAL N00409 : std_logic;
SIGNAL GND : std_logic;
SIGNAL VCC : std_logic;

-- GATE INSTANCES

BEGIN
U1 : \7432\	PORT MAP(
	A_A => N00756, 
	B_A => N00586, 
	Y_A => N00409, 
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
	A_A => N00409, 
	B_A => N00538, 
	Y_A => N00448, 
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
	A_A => N00448, 
	B_A => N00487, 
	Y_A => D3, 
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
	A_A => Q3, 
	B_A => Q1, 
	Y_A => N00756, 
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
	A_A => Q3, 
	B_A => Q0, 
	Y_A => N00586, 
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
	A_A => Q2, 
	B_A => NQ1, 
	Y_A => N00331, 
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
U7 : \7408\	PORT MAP(
	A_A => N00331, 
	B_A => NQ0, 
	Y_A => N00538, 
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
U8 : \7408\	PORT MAP(
	A_A => Q3, 
	B_A => Q2, 
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
U9 : \7408\	PORT MAP(
	A_A => N00370, 
	B_A => Q0, 
	Y_A => N00487, 
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
