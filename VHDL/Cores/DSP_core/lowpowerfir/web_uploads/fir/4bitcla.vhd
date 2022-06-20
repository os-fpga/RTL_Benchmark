LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
ENTITY \4BITCLAADDER\ IS PORT (
	A0 : IN std_logic;
	A1 : IN std_logic;
	A2 : IN std_logic;
	A3 : IN std_logic;
	B0 : IN std_logic;
	B1 : IN std_logic;
	B2 : IN std_logic;
	B3 : IN std_logic;
	COUT : OUT std_logic;
	CIN : IN std_logic;
	SUM0 : OUT std_logic;
	SUM1 : OUT std_logic;
	SUM2 : OUT std_logic;
	SUM3 : OUT std_logic
); 

END \4BITCLAADDER\;



ARCHITECTURE STRUCTURE OF \4BITCLAADDER\ IS

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

COMPONENT \1BITPFA\
	PORT (
	A : IN std_logic;
	B : IN std_logic;
	C : IN std_logic;
	G : OUT std_logic;
	P : OUT std_logic;
	S : OUT std_logic
	); END COMPONENT;

COMPONENT \7411\
	PORT (
	A_A : IN std_logic;
	Y_A : OUT std_logic;
	VCC : IN std_logic;
	GND : IN std_logic;
	B_A : IN std_logic;
	C_A : IN std_logic;
	A_B : IN std_logic;
	Y_B : OUT std_logic;
	B_B : IN std_logic;
	C_B : IN std_logic;
	A_C : IN std_logic;
	Y_C : OUT std_logic;
	B_C : IN std_logic;
	C_C : IN std_logic
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

COMPONENT \74HC21\
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

SIGNAL N51758 : std_logic;
SIGNAL N53427 : std_logic;
SIGNAL N53608 : std_logic;
SIGNAL N53205 : std_logic;
SIGNAL N372760 : std_logic;
SIGNAL N18388 : std_logic;
SIGNAL N15402 : std_logic;
SIGNAL N06267 : std_logic;
SIGNAL N14946 : std_logic;
SIGNAL N34966 : std_logic;
SIGNAL N16885 : std_logic;
SIGNAL N16789 : std_logic;
SIGNAL N16979 : std_logic;
SIGNAL N28079 : std_logic;
SIGNAL N27978 : std_logic;
SIGNAL N24244 : std_logic;
SIGNAL N18064 : std_logic;
SIGNAL N01390 : std_logic;
SIGNAL C0 : std_logic;
SIGNAL C1 : std_logic;
SIGNAL N01306 : std_logic;
SIGNAL N02165 : std_logic;
SIGNAL N02828 : std_logic;
SIGNAL C2 : std_logic;
SIGNAL N02908 : std_logic;
SIGNAL P3 : std_logic;
SIGNAL G3 : std_logic;
SIGNAL VCC : std_logic;
SIGNAL GND : std_logic;
SIGNAL N27878 : std_logic;



-- GATE INSTANCES

BEGIN

GND <= '0';
VCC <= '1';

U13 : \7432\	PORT MAP(
	A_A => N53608, 
	B_A => N27878, 
	Y_A => COUT, 
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
U14 : \1BITPFA\	PORT MAP(
	A => B1, 
	B => A1, 
	C => N01306, 
	G => N02165, 
	P => C1, 
	S => SUM1
);
U15 : \7411\	PORT MAP(
	A_A => P3, 
	Y_A => N27978, 
	VCC => VCC, 
	GND => GND, 
	B_A => N02828, 
	C_A => N02165, 
	A_B => 'Z', 
	Y_B => OPEN, 
	B_B => 'Z', 
	C_B => 'Z', 
	A_C => 'Z', 
	Y_C => OPEN, 
	B_C => 'Z', 
	C_C => 'Z'
);
U16 : \7408\	PORT MAP(
	A_A => N34966, 
	B_A => P3, 
	Y_A => N24244, 
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
U17 : \1BITPFA\	PORT MAP(
	A => B2, 
	B => A2, 
	C => C2, 
	G => N02908, 
	P => N02828, 
	S => SUM2
);
U18 : \7408\	PORT MAP(
	A_A => N02908, 
	B_A => P3, 
	Y_A => N28079, 
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
	A_A => N02165, 
	B_A => N02828, 
	Y_A => N16979, 
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
	A_A => CIN, 
	B_A => C0, 
	Y_A => N06267, 
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
	A_A => C1, 
	B_A => N01390, 
	Y_A => N15402, 
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
	A_A => N06267, 
	B_A => N01390, 
	Y_A => N01306, 
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
U22 : \7411\	PORT MAP(
	A_A => N02828, 
	Y_A => N16789, 
	VCC => VCC, 
	GND => GND, 
	B_A => C1, 
	C_A => N01390, 
	A_B => 'Z', 
	Y_B => OPEN, 
	B_B => 'Z', 
	C_B => 'Z', 
	A_C => 'Z', 
	Y_C => OPEN, 
	B_C => 'Z', 
	C_C => 'Z'
);
U8 : \7427\	PORT MAP(
	A_A => N02165, 
	B_A => N14946, 
	C_A => N15402, 
	Y_A => N18064, 
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
U23 : \7411\	PORT MAP(
	A_A => C1, 
	Y_A => N14946, 
	VCC => VCC, 
	GND => GND, 
	B_A => C0, 
	C_A => CIN, 
	A_B => 'Z', 
	Y_B => OPEN, 
	B_B => 'Z', 
	C_B => 'Z', 
	A_C => 'Z', 
	Y_C => OPEN, 
	B_C => 'Z', 
	C_C => 'Z'
);
U24 : \74HC21\	PORT MAP(
	Y_A => N16885, 
	VCC => VCC, 
	GND => GND, 
	A_A => N02828, 
	B_A => C1, 
	C_A => C0, 
	D_A => CIN, 
	Y_B => OPEN, 
	A_B => 'Z', 
	B_B => 'Z', 
	C_B => 'Z', 
	D_B => 'Z'
);
U25 : \1BITPFA\	PORT MAP(
	A => B3, 
	B => A3, 
	C => N18388, 
	G => G3, 
	P => P3, 
	S => SUM3
);
U26 : \74HC21\	PORT MAP(
	Y_A => N34966, 
	VCC => VCC, 
	GND => GND, 
	A_A => CIN, 
	B_A => C0, 
	C_A => C1, 
	D_A => N02828, 
	Y_B => OPEN, 
	A_B => 'Z', 
	B_B => 'Z', 
	C_B => 'Z', 
	D_B => 'Z'
);
U27 : \74HC21\	PORT MAP(
	Y_A => N27878, 
	VCC => VCC, 
	GND => GND, 
	A_A => N01390, 
	B_A => C1, 
	C_A => N02828, 
	D_A => P3, 
	Y_B => OPEN, 
	A_B => 'Z', 
	B_B => 'Z', 
	C_B => 'Z', 
	D_B => 'Z'
);
U30 : \7404\	PORT MAP(
	A_A => N18064, 
	Y_A => C2, 
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
U31 : \7404\	PORT MAP(
	A_A => N372760, 
	Y_A => N51758, 
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
U32 : \7404\	PORT MAP(
	A_A => N53427, 
	Y_A => N53205, 
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
U33 : \1BITPFA\	PORT MAP(
	A => B0, 
	B => A0, 
	C => CIN, 
	G => N01390, 
	P => C0, 
	S => SUM0
);
U34 : \7427\	PORT MAP(
	A_A => N02908, 
	B_A => N16789, 
	C_A => N16885, 
	Y_A => N372760, 
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
U36 : \7432\	PORT MAP(
	A_A => N51758, 
	B_A => N16979, 
	Y_A => N18388, 
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
U37 : \7432\	PORT MAP(
	A_A => N53205, 
	B_A => N28079, 
	Y_A => N53608, 
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
U39 : \7427\	PORT MAP(
	A_A => N24244, 
	B_A => G3, 
	C_A => N27978, 
	Y_A => N53427, 
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
END STRUCTURE;

