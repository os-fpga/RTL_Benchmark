LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
ENTITY EnableALL IS PORT (
	EnableThirteen : OUT std_logic;
	EnableEleven : OUT std_logic;
	EnableFour : OUT std_logic;
	C0 : IN std_logic;
	C1 : IN std_logic;
	C2 : IN std_logic;
	C3 : IN std_logic;
	EnableThree : OUT std_logic;
	EnableOne : OUT std_logic;
	EnableSix : OUT std_logic;
	nC0 : IN std_logic;
	nC1 : IN std_logic;
	nC2 : IN std_logic;
	EnableTwo : OUT std_logic;
	EnableFifteen : OUT std_logic;
	EnableNine : OUT std_logic;
	EnableTen : OUT std_logic;
	EnableFive : OUT std_logic;
	EnableFourteen : OUT std_logic;
	EnableTwelve : OUT std_logic;
	EnableSeven : OUT std_logic
); 

END EnableALL;



ARCHITECTURE STRUCTURE OF EnableALL IS

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

-- SIGNALS

SIGNAL N388519 : std_logic;
SIGNAL N381505 : std_logic;
SIGNAL VCC : std_logic;
SIGNAL GND : std_logic;
SIGNAL N391316 : std_logic;
SIGNAL N390423 : std_logic;
SIGNAL N390465 : std_logic;
SIGNAL N389998 : std_logic;
SIGNAL N391032 : std_logic;
SIGNAL C3C1 : std_logic;
SIGNAL C1NC0 : std_logic;
SIGNAL C3NC2 : std_logic;
SIGNAL N391816 : std_logic;
SIGNAL N389367 : std_logic;
SIGNAL N389419 : std_logic;
SIGNAL N389461 : std_logic;

-- GATE INSTANCES

BEGIN
VCC <= '1';
ENABLEFOURTEEN<=N391316;
ENABLEFOUR<=N381505;
ENABLETWELVE<=C3NC2;
ENABLETEN<=N390465;
ENABLETWO<=N388519;
ENABLESIX<=N389367;
U51 : \7432\	PORT MAP(
	A_A => N381505, 
	B_A => C1, 
	Y_A => N388519, 
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
U52 : \7432\	PORT MAP(
	A_A => N388519, 
	B_A => C0, 
	Y_A => ENABLEONE, 
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
U53 : \7432\	PORT MAP(
	A_A => C3, 
	B_A => C2, 
	Y_A => N381505, 
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
U54 : \7408\	PORT MAP(
	A_A => C1, 
	B_A => NC0, 
	Y_A => C1NC0, 
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
U55 : \7432\	PORT MAP(
	A_A => N381505, 
	B_A => C1NC0, 
	Y_A => ENABLETHREE, 
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
U56 : \7432\	PORT MAP(
	A_A => N389419, 
	B_A => N389367, 
	Y_A => ENABLEFIVE, 
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
U57 : \7432\	PORT MAP(
	A_A => N389461, 
	B_A => C3, 
	Y_A => N389367, 
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
U58 : \7408\	PORT MAP(
	A_A => C2, 
	B_A => C0, 
	Y_A => N389419, 
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
U59 : \7408\	PORT MAP(
	A_A => C2, 
	B_A => NC1, 
	Y_A => N389461, 
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
U60 : \74HC21\	PORT MAP(
	Y_A => N389998, 
	VCC => VCC, 
	GND => GND, 
	A_A => VCC, 
	B_A => C2, 
	C_A => NC1, 
	D_A => NC0, 
	Y_B => OPEN, 
	A_B => 'Z', 
	B_B => 'Z', 
	C_B => 'Z', 
	D_B => 'Z'
);
U61 : \7432\	PORT MAP(
	A_A => N389998, 
	B_A => C3, 
	Y_A => ENABLESEVEN, 
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
U62 : \7432\	PORT MAP(
	A_A => C3C1, 
	B_A => C3NC2, 
	Y_A => N390465, 
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
U63 : \7432\	PORT MAP(
	A_A => N390423, 
	B_A => N390465, 
	Y_A => ENABLENINE, 
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
U64 : \7408\	PORT MAP(
	A_A => C0, 
	B_A => C3, 
	Y_A => N390423, 
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
U65 : \7408\	PORT MAP(
	A_A => C3, 
	B_A => C1, 
	Y_A => C3C1, 
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
U66 : \7408\	PORT MAP(
	A_A => C3, 
	B_A => NC2, 
	Y_A => C3NC2, 
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
U67 : \7432\	PORT MAP(
	A_A => N391032, 
	B_A => C3NC2, 
	Y_A => ENABLEELEVEN, 
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
U68 : \7408\	PORT MAP(
	A_A => C3C1, 
	B_A => C1NC0, 
	Y_A => N391032, 
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
U69 : \7408\	PORT MAP(
	A_A => C3NC2, 
	B_A => NC1, 
	Y_A => N391316, 
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
U70 : \7408\	PORT MAP(
	A_A => N391316, 
	B_A => NC0, 
	Y_A => ENABLEFIFTEEN, 
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
U71 : \7408\	PORT MAP(
	A_A => C0, 
	B_A => C3NC2, 
	Y_A => N391816, 
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
U72 : \7432\	PORT MAP(
	A_A => N391816, 
	B_A => N391316, 
	Y_A => ENABLETHIRTEEN, 
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

