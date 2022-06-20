LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
ENTITY counter IS PORT (
	nQ0 : OUT std_logic;
	nQ1 : OUT std_logic;
	nQ2 : OUT std_logic;
	nQ3 : OUT std_logic;
	nCLR : IN std_logic;
	CLK : IN std_logic;
	Q0 : OUT std_logic;
	Q1 : OUT std_logic;
	Q2 : OUT std_logic;
	Q3 : OUT std_logic;
	nPRE : IN std_logic
); 

END counter;



ARCHITECTURE STRUCTURE OF counter IS

-- COMPONENTS

COMPONENT \7474\
	PORT (
	CLK_A : IN std_logic;
	\C\\L\\R\\_A\ : IN std_logic;
	D_A : IN std_logic;
	\P\\R\\E\\_A\ : IN std_logic;
	Q_A : OUT std_logic;
	VCC : IN std_logic;
	GND : IN std_logic;
	\Q\\_A\ : OUT std_logic;
	CLK_B : IN std_logic;
	\C\\L\\R\\_B\ : IN std_logic;
	D_B : IN std_logic;
	\P\\R\\E\\_B\ : IN std_logic;
	Q_B : OUT std_logic;
	\Q\\_B\ : OUT std_logic
	); END COMPONENT;

COMPONENT COMB0
	PORT (
	D0 : INOUT std_logic;
	NQ1 : INOUT std_logic;
	NQ2 : INOUT std_logic;
	NQ3 : INOUT std_logic;
	Q1 : INOUT std_logic;
	Q2 : INOUT std_logic;
	Q3 : INOUT std_logic
	); END COMPONENT;

COMPONENT COMB2
	PORT (
	D2 : INOUT std_logic;
	NQ0 : INOUT std_logic;
	NQ1 : INOUT std_logic;
	NQ3 : INOUT std_logic;
	Q0 : INOUT std_logic;
	Q1 : INOUT std_logic;
	Q2 : INOUT std_logic
	); END COMPONENT;

COMPONENT COMB3
	PORT (
	D3 : INOUT std_logic;
	NQ0 : INOUT std_logic;
	NQ1 : INOUT std_logic;
	Q0 : INOUT std_logic;
	Q1 : INOUT std_logic;
	Q2 : INOUT std_logic;
	Q3 : INOUT std_logic
	); END COMPONENT;

COMPONENT COMB1
	PORT (
	D1 : INOUT std_logic;
	NQ0 : INOUT std_logic;
	NQ2 : INOUT std_logic;
	NQ3 : INOUT std_logic;
	Q0 : INOUT std_logic;
	Q1 : INOUT std_logic;
	Q2 : INOUT std_logic;
	Q3 : INOUT std_logic
	); END COMPONENT;

-- SIGNALS

SIGNAL N002472 : std_logic;
SIGNAL N002932 : std_logic;
SIGNAL N01020 : std_logic;
SIGNAL N00861 : std_logic;
SIGNAL N02001 : std_logic;
SIGNAL GND : std_logic;
SIGNAL VCC : std_logic;
SIGNAL N01154 : std_logic;
SIGNAL N00937 : std_logic;
SIGNAL N02116 : std_logic;
SIGNAL N01087 : std_logic;
SIGNAL N01221 : std_logic;
SIGNAL N002012 : std_logic;
SIGNAL N001532 : std_logic;

-- GATE INSTANCES

BEGIN
Q0<=N02001;
Q1<=N00861;
Q2<=N01020;
Q3<=N01154;
NQ0<=N02116;
NQ1<=N00937;
NQ2<=N01087;
NQ3<=N01221;
U0 : \7474\	PORT MAP(
	CLK_A => CLK, 
	\C\\L\\R\\_A\ => NCLR, 
	D_A => N002932, 
	\P\\R\\E\\_A\ => NPRE, 
	Q_A => N01154, 
	VCC => VCC, 
	GND => GND, 
	\Q\\_A\ => N01221, 
	CLK_B => 'Z', 
	\C\\L\\R\\_B\ => 'Z', 
	D_B => 'Z', 
	\P\\R\\E\\_B\ => 'Z', 
	Q_B => OPEN, 
	\Q\\_B\ => OPEN
);
U2 : \7474\	PORT MAP(
	CLK_A => CLK, 
	\C\\L\\R\\_A\ => NCLR, 
	D_A => N002012, 
	\P\\R\\E\\_A\ => NPRE, 
	Q_A => N00861, 
	VCC => VCC, 
	GND => GND, 
	\Q\\_A\ => N00937, 
	CLK_B => 'Z', 
	\C\\L\\R\\_B\ => 'Z', 
	D_B => 'Z', 
	\P\\R\\E\\_B\ => 'Z', 
	Q_B => OPEN, 
	\Q\\_B\ => OPEN
);
U3 : \7474\	PORT MAP(
	CLK_A => CLK, 
	\C\\L\\R\\_A\ => NCLR, 
	D_A => N001532, 
	\P\\R\\E\\_A\ => NPRE, 
	Q_A => N02001, 
	VCC => VCC, 
	GND => GND, 
	\Q\\_A\ => N02116, 
	CLK_B => 'Z', 
	\C\\L\\R\\_B\ => 'Z', 
	D_B => 'Z', 
	\P\\R\\E\\_B\ => 'Z', 
	Q_B => OPEN, 
	\Q\\_B\ => OPEN
);
U5 : \7474\	PORT MAP(
	CLK_A => CLK, 
	\C\\L\\R\\_A\ => NCLR, 
	D_A => N002472, 
	\P\\R\\E\\_A\ => NPRE, 
	Q_A => N01020, 
	VCC => VCC, 
	GND => GND, 
	\Q\\_A\ => N01087, 
	CLK_B => 'Z', 
	\C\\L\\R\\_B\ => 'Z', 
	D_B => 'Z', 
	\P\\R\\E\\_B\ => 'Z', 
	Q_B => OPEN, 
	\Q\\_B\ => OPEN
);
U6 : COMB0	PORT MAP(
	D0 => N001532, 
	NQ1 => N00937, 
	NQ2 => N01087, 
	NQ3 => N01221, 
	Q1 => N00861, 
	Q2 => N01020, 
	Q3 => N01154
);
U9 : COMB2	PORT MAP(
	D2 => N002472, 
	NQ0 => N02116, 
	NQ1 => N00937, 
	NQ3 => N01221, 
	Q0 => N02001, 
	Q1 => N00861, 
	Q2 => N01020
);
U10 : COMB3	PORT MAP(
	D3 => N002932, 
	NQ0 => N02116, 
	NQ1 => N00937, 
	Q0 => N02001, 
	Q1 => N00861, 
	Q2 => N01020, 
	Q3 => N01154
);
U12 : COMB1	PORT MAP(
	D1 => N002012, 
	NQ0 => N02116, 
	NQ2 => N01087, 
	NQ3 => N01221, 
	Q0 => N02001, 
	Q1 => N00861, 
	Q2 => N01020, 
	Q3 => N01154
);
END STRUCTURE;

