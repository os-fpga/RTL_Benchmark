LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
ENTITY \16adderBalanced\ IS PORT (
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
	COUT : OUT std_logic;
	CIN : IN std_logic;
	Y10 : OUT std_logic;
	Y11 : OUT std_logic;
	Y12 : OUT std_logic;
	Y13 : OUT std_logic;
	Y14 : OUT std_logic;
	Y15 : OUT std_logic;
	B10 : IN std_logic;
	B11 : IN std_logic;
	B12 : IN std_logic;
	B13 : IN std_logic;
	B14 : IN std_logic;
	B15 : IN std_logic
); 

END \16adderBalanced\;



ARCHITECTURE STRUCTURE OF \16adderBalanced\ IS

-- COMPONENTS

COMPONENT \4BITCLAADDER\
	PORT (
	A0 : IN std_logic;
	A1 : IN std_logic;
	A2 : IN std_logic;
	A3 : IN std_logic;
	B0 : IN std_logic;
	B1 : IN std_logic;
	B2 : IN std_logic;
	B3 : IN std_logic;
	CIN : IN std_logic;
	COUT : OUT std_logic;
	SUM0 : OUT std_logic;
	SUM1 : OUT std_logic;
	SUM2 : OUT std_logic;
	SUM3 : OUT std_logic
	); END COMPONENT;

COMPONENT DELAYBLOCK
	PORT (
	DIN : IN std_logic;
	DOUT : OUT std_logic
	); END COMPONENT;

-- SIGNALS

SIGNAL N02444 : std_logic;
SIGNAL N60736 : std_logic;
SIGNAL N700341 : std_logic;
SIGNAL N699821 : std_logic;
signal Mike : std_logic;
SIGNAL N699561 : std_logic;
SIGNAL N699301 : std_logic;
SIGNAL N685791 : std_logic;
SIGNAL N701590 : std_logic;
SIGNAL N701340 : std_logic;
SIGNAL N702090 : std_logic;
SIGNAL N700081 : std_logic;
SIGNAL N701840 : std_logic;
SIGNAL N63182 : std_logic;
SIGNAL N63240 : std_logic;
SIGNAL N63638 : std_logic;
SIGNAL N63577 : std_logic;
SIGNAL N63754 : std_logic;
SIGNAL N700601 : std_logic;
SIGNAL N702590 : std_logic;
SIGNAL N700821 : std_logic;
SIGNAL N63863 : std_logic;
SIGNAL N703070 : std_logic;
SIGNAL N701081 : std_logic;
SIGNAL N63696 : std_logic;
SIGNAL N702340 : std_logic;
SIGNAL N63805 : std_logic;
SIGNAL N702820 : std_logic;
SIGNAL N62276 : std_logic;
SIGNAL N689991 : std_logic;
SIGNAL N62096 : std_logic;
SIGNAL N62336 : std_logic;
SIGNAL N691041 : std_logic;
SIGNAL N62216 : std_logic;
SIGNAL N688941 : std_logic;
SIGNAL N686841 : std_logic;
SIGNAL N61917 : std_logic;
SIGNAL N681391 : std_logic;
SIGNAL N62156 : std_logic;
SIGNAL N687891 : std_logic;
SIGNAL N76314 : std_logic;
SIGNAL N62036 : std_logic;
SIGNAL N59299 : std_logic;
SIGNAL N59248 : std_logic;
SIGNAL N59190 : std_logic;
SIGNAL N59132 : std_logic;
SIGNAL N59074 : std_logic;
SIGNAL N59016 : std_logic;
SIGNAL N59353 : std_logic;
SIGNAL N57992 : std_logic;
SIGNAL N683580 : std_logic;

-- GATE INSTANCES

BEGIN
U77 : DELAYBLOCK	PORT MAP(
	DIN => A15, 
	DOUT => N700081
);
U78 : DELAYBLOCK	PORT MAP(
	DIN => B12, 
	DOUT => N700341
);
U79 : DELAYBLOCK	PORT MAP(
	DIN => B13, 
	DOUT => N700601
);
U17 : \4BITCLAADDER\	PORT MAP(
	A0 => A0, 
	A1 => A1, 
	A2 => A2, 
	A3 => A3, 
	B0 => B0, 
	B1 => B1, 
	B2 => B2, 
	B3 => B3, 
	CIN => CIN, 
	COUT => N02444, 
	SUM0 => Y0, 
	SUM1 => Y1, 
	SUM2 => Y2, 
	SUM3 => Y3
);
U18 : \4BITCLAADDER\	PORT MAP(
	A0 => N59016, 
	A1 => N59074, 
	A2 => N59132, 
	A3 => N59190, 
	B0 => N59248, 
	B1 => N59299, 
	B2 => N59353, 
	B3 => N57992, 
	CIN => N02444, 
	COUT => N60736, 
	SUM0 => Y4, 
	SUM1 => Y5, 
	SUM2 => Y6, 
	SUM3 => Y7
);
U19 : \4BITCLAADDER\	PORT MAP(
	A0 => N61917, 
	A1 => N61917, 
	A2 => N62036, 
	A3 => N62096, 
	B0 => N62156, 
	B1 => N62216, 
	B2 => N62276, 
	B3 => N62336, 
	CIN => N60736, 
	COUT => N76314, 
	SUM0 => Y8, 
	SUM1 => Y9, 
	SUM2 => Y10, 
	SUM3 => Y11
);
U80 : DELAYBLOCK	PORT MAP(
	DIN => B14, 
	DOUT => N700821
);
U81 : DELAYBLOCK	PORT MAP(
	DIN => B15, 
	DOUT => N701081
);
U50 : DELAYBLOCK	PORT MAP(
	DIN => A4, 
	DOUT => N59016
);
U82 : DELAYBLOCK	PORT MAP(
	DIN => N701340, 
	DOUT => N63182
);
U51 : DELAYBLOCK	PORT MAP(
	DIN => A5, 
	DOUT => N59074
);
U83 : DELAYBLOCK	PORT MAP(
	DIN => N701590, 
	DOUT => N63240
);
U20 : \4BITCLAADDER\	PORT MAP(
	A0 => N63182, 
	A1 => N63240, 
	A2 => N63577, 
	A3 => N63638, 
	B0 => N63696, 
	B1 => N63754, 
	B2 => N63805, 
	B3 => N63863, 
	CIN => N76314, 
	COUT => COUT, 
	SUM0 => Y12, 
	SUM1 => Y13, 
	SUM2 => Y14, 
	SUM3 => Y15
);
U84 : DELAYBLOCK	PORT MAP(
	DIN => N701840, 
	DOUT => N63577
);
U52 : DELAYBLOCK	PORT MAP(
	DIN => A6, 
	DOUT => N59132
);
U53 : DELAYBLOCK	PORT MAP(
	DIN => A7, 
	DOUT => N59190
);
U85 : DELAYBLOCK	PORT MAP(
	DIN => N702090, 
	DOUT => N63638
);
U86 : DELAYBLOCK	PORT MAP(
	DIN => N702340, 
	DOUT => N63696
);
U54 : DELAYBLOCK	PORT MAP(
	DIN => B4, 
	DOUT => N59248
);
U87 : DELAYBLOCK	PORT MAP(
	DIN => N702590, 
	DOUT => N63754
);
U55 : DELAYBLOCK	PORT MAP(
	DIN => B5, 
	DOUT => N59299
);
U56 : DELAYBLOCK	PORT MAP(
	DIN => B6, 
	DOUT => N59353
);
U88 : DELAYBLOCK	PORT MAP(
	DIN => N702820, 
	DOUT => N63805
);
U89 : DELAYBLOCK	PORT MAP(
	DIN => N703070, 
	DOUT => N63863
);
U57 : DELAYBLOCK	PORT MAP(
	DIN => B7, 
	DOUT => N57992
);
U58 : DELAYBLOCK	PORT MAP(
	DIN => A8, 
	DOUT => N681391
);
U59 : DELAYBLOCK	PORT MAP(
	DIN => N681391, 
  DOUT => Mike
--	DOUT => N61917
);
U90 : DELAYBLOCK	PORT MAP(
	DIN => N699301, 
	DOUT => N701340
);
U91 : DELAYBLOCK	PORT MAP(
	DIN => N699561, 
	DOUT => N701590
);
U60 : DELAYBLOCK	PORT MAP(
	DIN => N683580, 
	DOUT => N61917
);
U92 : DELAYBLOCK	PORT MAP(
	DIN => N699821, 
	DOUT => N701840
);
U93 : DELAYBLOCK	PORT MAP(
	DIN => N700081, 
	DOUT => N702090
);
U61 : DELAYBLOCK	PORT MAP(
	DIN => A9, 
	DOUT => N683580
);
U94 : DELAYBLOCK	PORT MAP(
	DIN => N700341, 
	DOUT => N702340
);
U62 : DELAYBLOCK	PORT MAP(
	DIN => A10, 
	DOUT => N685791
);
U63 : DELAYBLOCK	PORT MAP(
	DIN => A11, 
	DOUT => N686841
);
U95 : DELAYBLOCK	PORT MAP(
	DIN => N700821, 
	DOUT => N702820
);
U64 : DELAYBLOCK	PORT MAP(
	DIN => B8, 
	DOUT => N687891
);
U96 : DELAYBLOCK	PORT MAP(
	DIN => N701081, 
	DOUT => N703070
);
U65 : DELAYBLOCK	PORT MAP(
	DIN => B9, 
	DOUT => N688941
);
U97 : DELAYBLOCK	PORT MAP(
	DIN => N700601, 
	DOUT => N702590
);
U98 : DELAYBLOCK	PORT MAP(
	DIN => N685791, 
	DOUT => N62036
);
U66 : DELAYBLOCK	PORT MAP(
	DIN => B10, 
	DOUT => N689991
);
U67 : DELAYBLOCK	PORT MAP(
	DIN => B11, 
	DOUT => N691041
);
U69 : DELAYBLOCK	PORT MAP(
	DIN => N686841, 
	DOUT => N62096
);
U70 : DELAYBLOCK	PORT MAP(
	DIN => N687891, 
	DOUT => N62156
);
U71 : DELAYBLOCK	PORT MAP(
	DIN => N688941, 
	DOUT => N62216
);
U72 : DELAYBLOCK	PORT MAP(
	DIN => N689991, 
	DOUT => N62276
);
U73 : DELAYBLOCK	PORT MAP(
	DIN => N691041, 
	DOUT => N62336
);
U74 : DELAYBLOCK	PORT MAP(
	DIN => A12, 
	DOUT => N699301
);
U75 : DELAYBLOCK	PORT MAP(
	DIN => A13, 
	DOUT => N699561
);
U76 : DELAYBLOCK	PORT MAP(
	DIN => A14, 
	DOUT => N699821
);
END STRUCTURE;

