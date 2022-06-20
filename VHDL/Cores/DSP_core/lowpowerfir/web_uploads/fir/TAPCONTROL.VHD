LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
ENTITY TAPCONTROL IS PORT (
	In_sig : IN std_logic;
	To_output : OUT std_logic;
	or1 : IN std_logic;
	or2 : IN std_logic;
	or3 : IN std_logic;
	To_adder : OUT std_logic;
	and1 : IN std_logic;
	and2 : IN std_logic;
	and3 : IN std_logic
); 

END TAPCONTROL;



ARCHITECTURE STRUCTURE OF TAPCONTROL IS

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

COMPONENT \7422\
	PORT (
	Y_A : OUT std_logic;
	VCC : IN std_logic;
	GND : IN std_logic;
	A_A : IN std_logic;
	B_A : IN std_logic;
	C_A : IN std_logic;
	D_A : IN std_logic;
	Y_B : OUT std_logic;
	A_B : IN std_logic;
	B_B : IN std_logic;
	C_B : IN std_logic;
	D_B : IN std_logic
	); END COMPONENT;

COMPONENT \7427\
	PORT (
	A_A : IN std_logic;
	B_A : IN std_logic;
	C_A : IN std_logic;
	Y_A : OUT std_logic;
	VCC : IN std_logic;
	GND : IN std_logic;
	A_B : IN std_logic;
	B_B : IN std_logic;
	C_B : IN std_logic;
	Y_B : OUT std_logic;
	A_C : IN std_logic;
	B_C : IN std_logic;
	C_C : IN std_logic;
	Y_C : OUT std_logic
	); END COMPONENT;

COMPONENT \7404\
	PORT (
	A_A : IN std_logic;
	Y_A : OUT std_logic;
	GND : IN std_logic;
	VCC : IN std_logic;
	A_B : IN std_logic;
	Y_B : OUT std_logic;
	A_C : IN std_logic;
	Y_C : OUT std_logic;
	A_D : IN std_logic;
	Y_D : OUT std_logic;
	A_E : IN std_logic;
	Y_E : OUT std_logic;
	A_F : IN std_logic;
	Y_F : OUT std_logic
	); END COMPONENT;

-- SIGNALS

SIGNAL GND : std_logic;
SIGNAL VCC : std_logic;
SIGNAL N00327 : std_logic;
SIGNAL N00369 : std_logic;
SIGNAL N00427 : std_logic;

-- GATE INSTANCES

BEGIN
U1 : \7408\	PORT MAP(
	A_A => IN_SIG, 
	B_A => N00369, 
	Y_A => TO_ADDER, 
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
U2 : \7422\	PORT MAP(
	Y_A => N00427, 
	VCC => VCC, 
	GND => GND, 
	A_A => IN_SIG, 
	B_A => AND1, 
	C_A => AND2, 
	D_A => AND3, 
	Y_B => OPEN, 
	A_B => 'Z', 
	B_B => 'Z', 
	C_B => 'Z', 
	D_B => 'Z'
);
U3 : \7427\	PORT MAP(
	A_A => OR1, 
	B_A => OR2, 
	C_A => OR3, 
	Y_A => N00327, 
	VCC => VCC, 
	GND => GND, 
	A_B => 'Z', 
	B_B => 'Z', 
	C_B => 'Z', 
	Y_B => OPEN, 
	A_C => 'Z', 
	B_C => 'Z', 
	C_C => 'Z', 
	Y_C => OPEN
);
U4 : \7404\	PORT MAP(
	A_A => N00327, 
	Y_A => N00369, 
	GND => GND, 
	VCC => VCC, 
	A_B => 'Z', 
	Y_B => OPEN, 
	A_C => 'Z', 
	Y_C => OPEN, 
	A_D => 'Z', 
	Y_D => OPEN, 
	A_E => 'Z', 
	Y_E => OPEN, 
	A_F => 'Z', 
	Y_F => OPEN
);
U5 : \7404\	PORT MAP(
	A_A => N00427, 
	Y_A => TO_OUTPUT, 
	GND => GND, 
	VCC => VCC, 
	A_B => 'Z', 
	Y_B => OPEN, 
	A_C => 'Z', 
	Y_C => OPEN, 
	A_D => 'Z', 
	Y_D => OPEN, 
	A_E => 'Z', 
	Y_E => OPEN, 
	A_F => 'Z', 
	Y_F => OPEN
);
END STRUCTURE;

