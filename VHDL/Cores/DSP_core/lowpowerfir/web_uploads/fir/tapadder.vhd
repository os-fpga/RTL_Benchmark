LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
ENTITY TAPADDER IS PORT (
	O10 : OUT std_logic;
	O11 : OUT std_logic;
	O12 : OUT std_logic;
	O13 : OUT std_logic;
	O14 : OUT std_logic;
	O15 : OUT std_logic;
	A0 : IN std_logic;
	A1 : IN std_logic;
	A2 : IN std_logic;
	A3 : IN std_logic;
	A4 : IN std_logic;
	A5 : IN std_logic;
	A6 : IN std_logic;
	A7 : IN std_logic;
	A8 : IN std_logic;
	A9 : IN std_logic;
	B0 : IN std_logic;
	B1 : IN std_logic;
	B2 : IN std_logic;
	B3 : IN std_logic;
	B4 : IN std_logic;
	B5 : IN std_logic;
	B6 : IN std_logic;
	B7 : IN std_logic;
	B8 : IN std_logic;
	B9 : IN std_logic;
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
	A10 : IN std_logic;
	A11 : IN std_logic;
	A12 : IN std_logic;
	A13 : IN std_logic;
	A14 : IN std_logic;
	A15 : IN std_logic;
	Cout : OUT std_logic;
	Cin : IN std_logic;
	Y10 : OUT std_logic;
	Y11 : OUT std_logic;
	Y12 : OUT std_logic;
	Y13 : OUT std_logic;
	Y14 : OUT std_logic;
	Y15 : OUT std_logic;
	OR1 : IN std_logic;
	OR2 : IN std_logic;
	OR3 : IN std_logic;
	AND1 : IN std_logic;
	AND2 : IN std_logic;
	AND3 : IN std_logic;
	O0 : OUT std_logic;
	O1 : OUT std_logic;
	O2 : OUT std_logic;
	O3 : OUT std_logic;
	O4 : OUT std_logic;
	O5 : OUT std_logic;
	O6 : OUT std_logic;
	O7 : OUT std_logic;
	O8 : OUT std_logic;
	O9 : OUT std_logic;
	B10 : IN std_logic;
	B11 : IN std_logic;
	B12 : IN std_logic;
	B13 : IN std_logic;
	B14 : IN std_logic;
	B15 : IN std_logic
); 

END TAPADDER;



ARCHITECTURE STRUCTURE OF TAPADDER IS

-- COMPONENTS

COMPONENT TAPCONTROL
	PORT (
	AND1 : IN std_logic;
	AND2 : IN std_logic;
	AND3 : IN std_logic;
	IN_SIG : IN std_logic;
	OR1 : IN std_logic;
	OR2 : IN std_logic;
	OR3 : IN std_logic;
	TO_ADDER : OUT std_logic;
	TO_OUTPUT : OUT std_logic
	); END COMPONENT;

COMPONENT \16adderBalanced\
	PORT (
	A0 : IN std_logic;
	A1 : IN std_logic;
	A2 : IN std_logic;
	A3 : IN std_logic;
	A4 : IN std_logic;
	A5 : IN std_logic;
	A6 : IN std_logic;
	A7 : IN std_logic;
	A8 : IN std_logic;
	A9 : IN std_logic;
	A10 : IN std_logic;
	A11 : IN std_logic;
	A12 : IN std_logic;
	A13 : IN std_logic;
	A14 : IN std_logic;
	A15 : IN std_logic;
	B0 : IN std_logic;
	B1 : IN std_logic;
	B2 : IN std_logic;
	B3 : IN std_logic;
	B4 : IN std_logic;
	B5 : IN std_logic;
	B6 : IN std_logic;
	B7 : IN std_logic;
	B8 : IN std_logic;
	B9 : IN std_logic;
	B10 : IN std_logic;
	B11 : IN std_logic;
	B12 : IN std_logic;
	B13 : IN std_logic;
	B14 : IN std_logic;
	B15 : IN std_logic;
	CIN : IN std_logic;
	COUT : OUT std_logic;
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

-- SIGNALS

SIGNAL SUM11 : std_logic;
SIGNAL SUM5 : std_logic;
SIGNAL SUM10 : std_logic;
SIGNAL SUM2 : std_logic;
SIGNAL SUM15 : std_logic;
SIGNAL SUM4 : std_logic;
SIGNAL SUM9 : std_logic;
SIGNAL SUM6 : std_logic;
SIGNAL SUM8 : std_logic;
SIGNAL SUM13 : std_logic;
SIGNAL SUM7 : std_logic;
SIGNAL SUM1 : std_logic;
SIGNAL SUM12 : std_logic;
SIGNAL SUM14 : std_logic;
SIGNAL SUM3 : std_logic;
SIGNAL SUM0 : std_logic;

-- GATE INSTANCES

BEGIN
U13 : TAPCONTROL	PORT MAP(
	AND1 => AND1, 
	AND2 => AND2, 
	AND3 => AND3, 
	IN_SIG => SUM6, 
	OR1 => OR1, 
	OR2 => OR2, 
	OR3 => OR3, 
	TO_ADDER => Y6, 
	TO_OUTPUT => O6
);
U14 : TAPCONTROL	PORT MAP(
	AND1 => AND1, 
	AND2 => AND2, 
	AND3 => AND3, 
	IN_SIG => SUM5, 
	OR1 => OR1, 
	OR2 => OR2, 
	OR3 => OR3, 
	TO_ADDER => Y5, 
	TO_OUTPUT => O5
);
U16 : TAPCONTROL	PORT MAP(
	AND1 => AND1, 
	AND2 => AND2, 
	AND3 => AND3, 
	IN_SIG => SUM2, 
	OR1 => OR1, 
	OR2 => OR2, 
	OR3 => OR3, 
	TO_ADDER => Y2, 
	TO_OUTPUT => O2
);
U17 : TAPCONTROL	PORT MAP(
	AND1 => AND1, 
	AND2 => AND2, 
	AND3 => AND3, 
	IN_SIG => SUM4, 
	OR1 => OR1, 
	OR2 => OR2, 
	OR3 => OR3, 
	TO_ADDER => Y4, 
	TO_OUTPUT => O4
);
U18 : TAPCONTROL	PORT MAP(
	AND1 => AND1, 
	AND2 => AND2, 
	AND3 => AND3, 
	IN_SIG => SUM7, 
	OR1 => OR1, 
	OR2 => OR2, 
	OR3 => OR3, 
	TO_ADDER => Y7, 
	TO_OUTPUT => O7
);
U2 : TAPCONTROL	PORT MAP(
	AND1 => AND1, 
	AND2 => AND2, 
	AND3 => AND3, 
	IN_SIG => SUM1, 
	OR1 => OR1, 
	OR2 => OR2, 
	OR3 => OR3, 
	TO_ADDER => Y1, 
	TO_OUTPUT => O1
);
U3 : TAPCONTROL	PORT MAP(
	AND1 => AND1, 
	AND2 => AND2, 
	AND3 => AND3, 
	IN_SIG => SUM15, 
	OR1 => OR1, 
	OR2 => OR2, 
	OR3 => OR3, 
	TO_ADDER => Y15, 
	TO_OUTPUT => O15
);
U4 : TAPCONTROL	PORT MAP(
	AND1 => AND1, 
	AND2 => AND2, 
	AND3 => AND3, 
	IN_SIG => SUM14, 
	OR1 => OR1, 
	OR2 => OR2, 
	OR3 => OR3, 
	TO_ADDER => Y14, 
	TO_OUTPUT => O14
);
U5 : TAPCONTROL	PORT MAP(
	AND1 => AND1, 
	AND2 => AND2, 
	AND3 => AND3, 
	IN_SIG => SUM12, 
	OR1 => OR1, 
	OR2 => OR2, 
	OR3 => OR3, 
	TO_ADDER => Y12, 
	TO_OUTPUT => O12
);
U21 : \16adderBalanced\	PORT MAP(
	A0 => A0, 
	A1 => A1, 
	A2 => A2, 
	A3 => A3, 
	A4 => A4, 
	A5 => A5, 
	A6 => A6, 
	A7 => A7, 
	A8 => A8, 
	A9 => A9, 
	A10 => A10, 
	A11 => A11, 
	A12 => A12, 
	A13 => A13, 
	A14 => A14, 
	A15 => A15, 
	B0 => B0, 
	B1 => B1, 
	B2 => B2, 
	B3 => B3, 
	B4 => B4, 
	B5 => B5, 
	B6 => B6, 
	B7 => B7, 
	B8 => B8, 
	B9 => B9, 
	B10 => B10, 
	B11 => B11, 
	B12 => B12, 
	B13 => B13, 
	B14 => B14, 
	B15 => B15, 
	CIN => CIN, 
	COUT => COUT, 
	Y0 => SUM0, 
	Y1 => SUM1, 
	Y2 => SUM2, 
	Y3 => SUM3, 
	Y4 => SUM4, 
	Y5 => SUM5, 
	Y6 => SUM6, 
	Y7 => SUM7, 
	Y8 => SUM8, 
	Y9 => SUM9, 
	Y10 => SUM10, 
	Y11 => SUM11, 
	Y12 => SUM12, 
	Y13 => SUM13, 
	Y14 => SUM14, 
	Y15 => SUM15
);
U6 : TAPCONTROL	PORT MAP(
	AND1 => AND1, 
	AND2 => AND2, 
	AND3 => AND3, 
	IN_SIG => SUM11, 
	OR1 => OR1, 
	OR2 => OR2, 
	OR3 => OR3, 
	TO_ADDER => Y11, 
	TO_OUTPUT => O11
);
U7 : TAPCONTROL	PORT MAP(
	AND1 => AND1, 
	AND2 => AND2, 
	AND3 => AND3, 
	IN_SIG => SUM8, 
	OR1 => OR1, 
	OR2 => OR2, 
	OR3 => OR3, 
	TO_ADDER => Y8, 
	TO_OUTPUT => O8
);
U8 : TAPCONTROL	PORT MAP(
	AND1 => AND1, 
	AND2 => AND2, 
	AND3 => AND3, 
	IN_SIG => SUM9, 
	OR1 => OR1, 
	OR2 => OR2, 
	OR3 => OR3, 
	TO_ADDER => Y9, 
	TO_OUTPUT => O9
);
U9 : TAPCONTROL	PORT MAP(
	AND1 => AND1, 
	AND2 => AND2, 
	AND3 => AND3, 
	IN_SIG => SUM10, 
	OR1 => OR1, 
	OR2 => OR2, 
	OR3 => OR3, 
	TO_ADDER => Y10, 
	TO_OUTPUT => O10
);
U10 : TAPCONTROL	PORT MAP(
	AND1 => AND1, 
	AND2 => AND2, 
	AND3 => AND3, 
	IN_SIG => SUM13, 
	OR1 => OR1, 
	OR2 => OR2, 
	OR3 => OR3, 
	TO_ADDER => Y13, 
	TO_OUTPUT => O13
);
U11 : TAPCONTROL	PORT MAP(
	AND1 => AND1, 
	AND2 => AND2, 
	AND3 => AND3, 
	IN_SIG => SUM0, 
	OR1 => OR1, 
	OR2 => OR2, 
	OR3 => OR3, 
	TO_ADDER => Y0, 
	TO_OUTPUT => O0
);
U12 : TAPCONTROL	PORT MAP(
	AND1 => AND1, 
	AND2 => AND2, 
	AND3 => AND3, 
	IN_SIG => SUM3, 
	OR1 => OR1, 
	OR2 => OR2, 
	OR3 => OR3, 
	TO_ADDER => Y3, 
	TO_OUTPUT => O3
);
END STRUCTURE;

