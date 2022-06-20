LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
ENTITY NewSlice IS PORT (
	Load : IN std_logic;
	nRST : IN std_logic;
	S10 : OUT std_logic;
	S11 : OUT std_logic;
	S12 : OUT std_logic;
	S13 : OUT std_logic;
	S14 : OUT std_logic;
	S15 : OUT std_logic;
	Qco0 : OUT std_logic;
	Qco1 : OUT std_logic;
	Qco2 : OUT std_logic;
	Qco3 : OUT std_logic;
	Qco4 : OUT std_logic;
	Qco5 : OUT std_logic;
	Qco6 : OUT std_logic;
	Qco7 : OUT std_logic;
	Dsg0 : IN std_logic;
	Dsg1 : IN std_logic;
	Dsg2 : IN std_logic;
	Dsg3 : IN std_logic;
	Dsg4 : IN std_logic;
	Dsg5 : IN std_logic;
	Dsg6 : IN std_logic;
	Dsg7 : IN std_logic;
	Signed : OUT std_logic;
	Clk : IN std_logic;
	Qsg0 : OUT std_logic;
	Qsg1 : OUT std_logic;
	Qsg2 : OUT std_logic;
	Qsg3 : OUT std_logic;
	Qsg4 : OUT std_logic;
	Qsg5 : OUT std_logic;
	Qsg6 : OUT std_logic;
	Qsg7 : OUT std_logic;
	Dco0 : IN std_logic;
	Dco1 : IN std_logic;
	Dco2 : IN std_logic;
	Dco3 : IN std_logic;
	Dco4 : IN std_logic;
	Dco5 : IN std_logic;
	Dco6 : IN std_logic;
	Dco7 : IN std_logic;
	S0 : OUT std_logic;
	S1 : OUT std_logic;
	S2 : OUT std_logic;
	S3 : OUT std_logic;
	Enable : IN std_logic;
	S4 : OUT std_logic;
	S5 : OUT std_logic;
	S6 : OUT std_logic;
	S7 : OUT std_logic;
	S8 : OUT std_logic;
	S9 : OUT std_logic
); 

END NewSlice;



ARCHITECTURE STRUCTURE OF NewSlice IS

-- COMPONENTS

COMPONENT BALANCEDMULT
	PORT (
	A0 : IN std_logic;
	A1 : IN std_logic;
	A2 : IN std_logic;
	A3 : IN std_logic;
	A4 : IN std_logic;
	A5 : IN std_logic;
	A6 : IN std_logic;
	A7 : IN std_logic;
	B0 : IN std_logic;
	B1 : IN std_logic;
	B2 : IN std_logic;
	B3 : IN std_logic;
	B4 : IN std_logic;
	B5 : IN std_logic;
	B6 : IN std_logic;
	B7 : IN std_logic;
	Y0 : OUT std_logic;
	Y1 : OUT std_logic;
	Y2 : OUT std_logic;
	Y3 : OUT std_logic;
	Y4 : OUT std_logic;
	Y5 : OUT std_logic;
	Y6 : OUT std_logic;
	Y7 : OUT std_logic;
	Y8 : OUT std_logic;
	Y9 : OUT std_logic;
	Y10 : OUT std_logic;
	Y11 : OUT std_logic;
	Y12 : OUT std_logic;
	Y13 : OUT std_logic;
	Y14 : OUT std_logic;
	Y15 : OUT std_logic
	); END COMPONENT;

COMPONENT EIGHTBITREG
	PORT (
	CLK : IN std_logic;
	D0 : IN std_logic;
	D1 : IN std_logic;
	D2 : IN std_logic;
	D3 : IN std_logic;
	D4 : IN std_logic;
	D5 : IN std_logic;
	D6 : IN std_logic;
	D7 : IN std_logic;
	NPRESET : IN std_logic;
	NRESET : IN std_logic;
	Q0 : OUT std_logic;
	Q1 : OUT std_logic;
	Q2 : OUT std_logic;
	Q3 : OUT std_logic;
	Q4 : OUT std_logic;
	Q5 : OUT std_logic;
	Q6 : OUT std_logic;
	Q7 : OUT std_logic
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

COMPONENT XORBLOCKSCH
	PORT (
	S0 : OUT std_logic;
	S1 : OUT std_logic;
	S2 : OUT std_logic;
	S3 : OUT std_logic;
	S4 : OUT std_logic;
	S5 : OUT std_logic;
	S6 : OUT std_logic;
	S7 : OUT std_logic;
	S8 : OUT std_logic;
	S9 : OUT std_logic;
	S10 : OUT std_logic;
	S11 : OUT std_logic;
	S12 : OUT std_logic;
	S13 : OUT std_logic;
	S14 : OUT std_logic;
	S15 : OUT std_logic;
	SIGNED : IN std_logic;
	UNSIGNED0 : IN std_logic;
	UNSIGNED1 : IN std_logic;
	UNSIGNED2 : IN std_logic;
	UNSIGNED3 : IN std_logic;
	UNSIGNED4 : IN std_logic;
	UNSIGNED5 : IN std_logic;
	UNSIGNED6 : IN std_logic;
	UNSIGNED7 : IN std_logic;
	UNSIGNED8 : IN std_logic;
	UNSIGNED9 : IN std_logic;
	UNSIGNED10 : IN std_logic;
	UNSIGNED11 : IN std_logic;
	UNSIGNED12 : IN std_logic;
	UNSIGNED13 : IN std_logic;
	UNSIGNED14 : IN std_logic;
	UNSIGNED15 : IN std_logic
	); END COMPONENT;

-- SIGNALS

SIGNAL N02574 : std_logic;
SIGNAL N00712 : std_logic;
SIGNAL N06382 : std_logic;
SIGNAL N01549 : std_logic;
SIGNAL N06372 : std_logic;
SIGNAL N01317 : std_logic;
SIGNAL N02318 : std_logic;
SIGNAL N02830 : std_logic;
SIGNAL N06360 : std_logic;
SIGNAL N02702 : std_logic;
SIGNAL N00591 : std_logic;
SIGNAL N02446 : std_logic;
SIGNAL N06380 : std_logic;
SIGNAL N06364 : std_logic;
SIGNAL N00371 : std_logic;
SIGNAL N06370 : std_logic;
SIGNAL N00954 : std_logic;
SIGNAL N00833 : std_logic;
SIGNAL GND : std_logic;
SIGNAL N01075 : std_logic;
SIGNAL N06388 : std_logic;
SIGNAL N02190 : std_logic;
SIGNAL N01196 : std_logic;
SIGNAL N06384 : std_logic;
SIGNAL N06376 : std_logic;
SIGNAL N11741 : std_logic;
SIGNAL VCC : std_logic;
SIGNAL N06366 : std_logic;
SIGNAL N06368 : std_logic;
SIGNAL N06378 : std_logic;
SIGNAL N06390 : std_logic;
SIGNAL N01421 : std_logic;
SIGNAL N06374 : std_logic;
SIGNAL N06386 : std_logic;
SIGNAL N06362 : std_logic;

-- GATE INSTANCES

BEGIN
GND <= '0';
VCC <= '1';
Signed<=N01317;
QSG4<=N02446;
QSG5<=N02574;
QSG6<=N02702;
QSG7<=N02830;
QCO0<=N00371;
QCO1<=N00591;
QCO2<=N00712;
QCO3<=N00833;
QCO4<=N00954;
QCO5<=N01075;
QCO6<=N01196;
QSG0<=N01421;
QCO7<=N01317;
QSG1<=N01549;
QSG2<=N02190;
QSG3<=N02318;
U13 : BALANCEDMULT	PORT MAP(
	A0 => N00371, 
	A1 => N00591, 
	A2 => N00712, 
	A3 => N00833, 
	A4 => N00954, 
	A5 => N01075, 
	A6 => N01196, 
	A7 => GND, 
	B0 => N01421, 
	B1 => N01549, 
	B2 => N02190, 
	B3 => N02318, 
	B4 => N02446, 
	B5 => N02574, 
	B6 => N02702, 
	B7 => N02830, 
	Y0 => N06360, 
	Y1 => N06362, 
	Y2 => N06364, 
	Y3 => N06366, 
	Y4 => N06368, 
	Y5 => N06370, 
	Y6 => N06372, 
	Y7 => N06374, 
	Y8 => N06376, 
	Y9 => N06378, 
	Y10 => N06380, 
	Y11 => N06382, 
	Y12 => N06384, 
	Y13 => N06386, 
	Y14 => N06388, 
	Y15 => N06390
);
U21 : EIGHTBITREG	PORT MAP(
	CLK => LOAD, 
	D0 => DCO0, 
	D1 => DCO1, 
	D2 => DCO2, 
	D3 => DCO3, 
	D4 => DCO4, 
	D5 => DCO5, 
	D6 => DCO6, 
	D7 => DCO7, 
	NPRESET => VCC, 
	NRESET => NRST, 
	Q0 => N00371, 
	Q1 => N00591, 
	Q2 => N00712, 
	Q3 => N00833, 
	Q4 => N00954, 
	Q5 => N01075, 
	Q6 => N01196, 
	Q7 => N01317
);
U22 : EIGHTBITREG	PORT MAP(
	CLK => N11741, 
	D0 => DSG0, 
	D1 => DSG1, 
	D2 => DSG2, 
	D3 => DSG3, 
	D4 => DSG4, 
	D5 => DSG5, 
	D6 => DSG6, 
	D7 => DSG7, 
	NPRESET => VCC, 
	NRESET => NRST, 
	Q0 => N01421, 
	Q1 => N01549, 
	Q2 => N02190, 
	Q3 => N02318, 
	Q4 => N02446, 
	Q5 => N02574, 
	Q6 => N02702, 
	Q7 => N02830
);
U10 : \7408\	PORT MAP(
	A_A => ENABLE, 
	B_A => CLK, 
	Y_A => N11741, 
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
U12 : XORBLOCKSCH	PORT MAP(
	S0 => S0, 
	S1 => S1, 
	S2 => S2, 
	S3 => S3, 
	S4 => S4, 
	S5 => S5, 
	S6 => S6, 
	S7 => S7, 
	S8 => S8, 
	S9 => S9, 
	S10 => S10, 
	S11 => S11, 
	S12 => S12, 
	S13 => S13, 
	S14 => S14, 
	S15 => S15, 
	SIGNED => N01317, 
	UNSIGNED0 => N06360, 
	UNSIGNED1 => N06362, 
	UNSIGNED2 => N06364, 
	UNSIGNED3 => N06366, 
	UNSIGNED4 => N06368, 
	UNSIGNED5 => N06370, 
	UNSIGNED6 => N06372, 
	UNSIGNED7 => N06374, 
	UNSIGNED8 => N06376, 
	UNSIGNED9 => N06378, 
	UNSIGNED10 => N06380, 
	UNSIGNED11 => N06382, 
	UNSIGNED12 => N06384, 
	UNSIGNED13 => N06386, 
	UNSIGNED14 => N06388, 
	UNSIGNED15 => N06390
);
END STRUCTURE;

