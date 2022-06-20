LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
ENTITY XorBlockSch IS PORT (
	S10 : OUT std_logic;
	S11 : OUT std_logic;
	S12 : OUT std_logic;
	S13 : OUT std_logic;
	S14 : OUT std_logic;
	S15 : OUT std_logic;
	Signed : IN std_logic;
	Unsigned10 : IN std_logic;
	Unsigned11 : IN std_logic;
	Unsigned12 : IN std_logic;
	Unsigned13 : IN std_logic;
	Unsigned14 : IN std_logic;
	Unsigned15 : IN std_logic;
	Unsigned0 : IN std_logic;
	Unsigned1 : IN std_logic;
	Unsigned2 : IN std_logic;
	Unsigned3 : IN std_logic;
	Unsigned4 : IN std_logic;
	Unsigned5 : IN std_logic;
	Unsigned6 : IN std_logic;
	Unsigned7 : IN std_logic;
	Unsigned8 : IN std_logic;
	Unsigned9 : IN std_logic;
	S0 : OUT std_logic;
	S1 : OUT std_logic;
	S2 : OUT std_logic;
	S3 : OUT std_logic;
	S4 : OUT std_logic;
	S5 : OUT std_logic;
	S6 : OUT std_logic;
	S7 : OUT std_logic;
	S8 : OUT std_logic;
	S9 : OUT std_logic
); 

END XorBlockSch;



ARCHITECTURE STRUCTURE OF XorBlockSch IS

-- COMPONENTS

COMPONENT \7486\
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

-- GATE INSTANCES

BEGIN
U17 : \7486\	PORT MAP(
	A_A => UNSIGNED15, 
	B_A => SIGNED, 
	Y_A => S15, 
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
U18 : \7486\	PORT MAP(
	A_A => UNSIGNED7, 
	B_A => SIGNED, 
	Y_A => S7, 
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
U19 : \7486\	PORT MAP(
	A_A => UNSIGNED6, 
	B_A => SIGNED, 
	Y_A => S6, 
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
U20 : \7486\	PORT MAP(
	A_A => UNSIGNED5, 
	B_A => SIGNED, 
	Y_A => S5, 
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
U21 : \7486\	PORT MAP(
	A_A => UNSIGNED4, 
	B_A => SIGNED, 
	Y_A => S4, 
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
U22 : \7486\	PORT MAP(
	A_A => UNSIGNED14, 
	B_A => SIGNED, 
	Y_A => S14, 
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
U23 : \7486\	PORT MAP(
	A_A => UNSIGNED13, 
	B_A => SIGNED, 
	Y_A => S13, 
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
U24 : \7486\	PORT MAP(
	A_A => UNSIGNED12, 
	B_A => SIGNED, 
	Y_A => S12, 
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
U25 : \7486\	PORT MAP(
	A_A => UNSIGNED11, 
	B_A => SIGNED, 
	Y_A => S11, 
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
U26 : \7486\	PORT MAP(
	A_A => UNSIGNED3, 
	B_A => SIGNED, 
	Y_A => S3, 
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
U27 : \7486\	PORT MAP(
	A_A => UNSIGNED2, 
	B_A => SIGNED, 
	Y_A => S2, 
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
U28 : \7486\	PORT MAP(
	A_A => UNSIGNED1, 
	B_A => SIGNED, 
	Y_A => S1, 
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
U29 : \7486\	PORT MAP(
	A_A => UNSIGNED10, 
	B_A => SIGNED, 
	Y_A => S10, 
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
U30 : \7486\	PORT MAP(
	A_A => UNSIGNED9, 
	B_A => SIGNED, 
	Y_A => S9, 
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
U31 : \7486\	PORT MAP(
	A_A => UNSIGNED8, 
	B_A => SIGNED, 
	Y_A => S8, 
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
U32 : \7486\	PORT MAP(
	A_A => UNSIGNED0, 
	B_A => SIGNED, 
	Y_A => S0, 
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

