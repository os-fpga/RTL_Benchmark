LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
ENTITY MCELLnone IS PORT (
	BIN : IN std_logic;
	AOUT : OUT std_logic;
	BOUT : OUT std_logic;
	SUMOUT : OUT std_logic;
	SUMIN : IN std_logic;
	AIN : IN std_logic;
	COUT : OUT std_logic;
	CIN : IN std_logic
); 

END MCELLnone;



ARCHITECTURE STRUCTURE OF MCELLnone IS

-- COMPONENTS

COMPONENT \1BITADDER\
	PORT (
	A : IN std_logic;
	B : IN std_logic;
	CIN : IN std_logic;
	COUT : OUT std_logic;
	SUM : OUT std_logic
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

SIGNAL N02080 : std_logic;
SIGNAL N02162 : std_logic;
SIGNAL N02046 : std_logic;
SIGNAL GND : std_logic;
SIGNAL VCC : std_logic;

-- GATE INSTANCES

BEGIN
AOUT<=AIN;
BOUT<=BIN;

U2 : \1BITADDER\	PORT MAP(
	A => N02046, 
	B => SUMIN, 
	CIN => CIN, 
	COUT => COUT, 
	SUM => SUMOUT
);
U3 : \7408\	PORT MAP(
	A_A => BIN, 
	B_A => AIN, 
	Y_A => N02046, 
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

