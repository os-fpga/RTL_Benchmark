LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
ENTITY Comb0 IS PORT (
	nQ1 : IN std_logic;
	nQ2 : IN std_logic;
	nQ3 : IN std_logic;
	D0 : OUT std_logic;
	Q1 : IN std_logic;
	Q2 : IN std_logic;
	Q3 : IN std_logic
); 

END Comb0;



ARCHITECTURE STRUCTURE OF Comb0 IS

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

SIGNAL N00568 : std_logic;
SIGNAL N00529 : std_logic;
SIGNAL N00952 : std_logic;
SIGNAL N00835 : std_logic;
SIGNAL N01003 : std_logic;
SIGNAL N01058 : std_logic;
SIGNAL N00913 : std_logic;
SIGNAL N01592 : std_logic;
SIGNAL N01553 : std_logic;
SIGNAL VCC : std_logic;
SIGNAL GND : std_logic;
SIGNAL N03522 : std_logic;

-- GATE INSTANCES

BEGIN
U15 : \7432\	PORT MAP(
	A_A => N00568, 
	B_A => N01592, 
	Y_A => D0, 
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
U16 : \7432\	PORT MAP(
	A_A => N00529, 
	B_A => N01058, 
	Y_A => N00568, 
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
U17 : \7432\	PORT MAP(
	A_A => N00952, 
	B_A => N01003, 
	Y_A => N00529, 
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
U18 : \7408\	PORT MAP(
	A_A => NQ3, 
	B_A => NQ2, 
	Y_A => N00835, 
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
U19 : \7408\	PORT MAP(
	A_A => N00835, 
	B_A => NQ1, 
	Y_A => N00952, 
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
U20 : \7408\	PORT MAP(
	A_A => NQ3, 
	B_A => Q2, 
	Y_A => N03522, 
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
U21 : \7408\	PORT MAP(
	A_A => N03522, 
	B_A => Q1, 
	Y_A => N01003, 
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
U22 : \7408\	PORT MAP(
	A_A => Q3, 
	B_A => Q2, 
	Y_A => N00913, 
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
U23 : \7408\	PORT MAP(
	A_A => N00913, 
	B_A => NQ1, 
	Y_A => N01058, 
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
U24 : \7408\	PORT MAP(
	A_A => Q3, 
	B_A => NQ2, 
	Y_A => N01553, 
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
U25 : \7408\	PORT MAP(
	A_A => N01553, 
	B_A => Q1, 
	Y_A => N01592, 
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

