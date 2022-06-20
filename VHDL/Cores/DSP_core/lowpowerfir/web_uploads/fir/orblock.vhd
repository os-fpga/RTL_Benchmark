LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
ENTITY ORBlock IS PORT (
	D10 : IN std_logic;
	D11 : IN std_logic;
	D12 : IN std_logic;
	D13 : IN std_logic;
	D14 : IN std_logic;
	D15 : IN std_logic;
	F10 : IN std_logic;
	F11 : IN std_logic;
	F12 : IN std_logic;
	F13 : IN std_logic;
	F14 : IN std_logic;
	F15 : IN std_logic;
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
	C0 : IN std_logic;
	C1 : IN std_logic;
	C2 : IN std_logic;
	H10 : IN std_logic;
	C3 : IN std_logic;
	H11 : IN std_logic;
	C4 : IN std_logic;
	H12 : IN std_logic;
	C5 : IN std_logic;
	H13 : IN std_logic;
	C6 : IN std_logic;
	H14 : IN std_logic;
	C7 : IN std_logic;
	H15 : IN std_logic;
	C8 : IN std_logic;
	C9 : IN std_logic;
	D0 : IN std_logic;
	D1 : IN std_logic;
	D2 : IN std_logic;
	D3 : IN std_logic;
	D4 : IN std_logic;
	D5 : IN std_logic;
	D6 : IN std_logic;
	D7 : IN std_logic;
	D8 : IN std_logic;
	D9 : IN std_logic;
	E0 : IN std_logic;
	E1 : IN std_logic;
	E2 : IN std_logic;
	E3 : IN std_logic;
	E4 : IN std_logic;
	E5 : IN std_logic;
	E6 : IN std_logic;
	E7 : IN std_logic;
	E8 : IN std_logic;
	E9 : IN std_logic;
	A10 : IN std_logic;
	A11 : IN std_logic;
	A12 : IN std_logic;
	A13 : IN std_logic;
	A14 : IN std_logic;
	A15 : IN std_logic;
	F0 : IN std_logic;
	F1 : IN std_logic;
	F2 : IN std_logic;
	F3 : IN std_logic;
	F4 : IN std_logic;
	F5 : IN std_logic;
	F6 : IN std_logic;
	F7 : IN std_logic;
	F8 : IN std_logic;
	F9 : IN std_logic;
	G0 : IN std_logic;
	G1 : IN std_logic;
	G2 : IN std_logic;
	G3 : IN std_logic;
	G4 : IN std_logic;
	G5 : IN std_logic;
	G6 : IN std_logic;
	G7 : IN std_logic;
	G8 : IN std_logic;
	G9 : IN std_logic;
	H0 : IN std_logic;
	C10 : IN std_logic;
	H1 : IN std_logic;
	C11 : IN std_logic;
	H2 : IN std_logic;
	C12 : IN std_logic;
	H3 : IN std_logic;
	C13 : IN std_logic;
	H4 : IN std_logic;
	C14 : IN std_logic;
	H5 : IN std_logic;
	C15 : IN std_logic;
	H6 : IN std_logic;
	H7 : IN std_logic;
	H8 : IN std_logic;
	H9 : IN std_logic;
	Output0 : OUT std_logic;
	Output1 : OUT std_logic;
	Output2 : OUT std_logic;
	Output3 : OUT std_logic;
	Output4 : OUT std_logic;
	Output5 : OUT std_logic;
	Output6 : OUT std_logic;
	Output7 : OUT std_logic;
	Output8 : OUT std_logic;
	Output9 : OUT std_logic;
	E10 : IN std_logic;
	E11 : IN std_logic;
	E12 : IN std_logic;
	E13 : IN std_logic;
	E14 : IN std_logic;
	E15 : IN std_logic;
	G10 : IN std_logic;
	G11 : IN std_logic;
	G12 : IN std_logic;
	G13 : IN std_logic;
	G14 : IN std_logic;
	G15 : IN std_logic;
	Output10 : OUT std_logic;
	Output11 : OUT std_logic;
	Output12 : OUT std_logic;
	Output13 : OUT std_logic;
	Output14 : OUT std_logic;
	Output15 : OUT std_logic;
	B10 : IN std_logic;
	B11 : IN std_logic;
	B12 : IN std_logic;
	B13 : IN std_logic;
	B14 : IN std_logic;
	B15 : IN std_logic
); 

END ORBlock;



ARCHITECTURE STRUCTURE OF ORBlock IS

-- COMPONENTS

COMPONENT ORPART
	PORT (
	A : IN std_logic;
	B : IN std_logic;
	C : IN std_logic;
	D : IN std_logic;
	E : IN std_logic;
	F : IN std_logic;
	G : IN std_logic;
	H : IN std_logic;
	OUTPUT : OUT std_logic
	); END COMPONENT;

-- SIGNALS


-- GATE INSTANCES

BEGIN
U13 : ORPART	PORT MAP(
	A => A11, 
	B => B11, 
	C => C11, 
	D => D11, 
	E => E11, 
	F => F11, 
	G => G11, 
	H => H11, 
	OUTPUT => OUTPUT11
);
U14 : ORPART	PORT MAP(
	A => A12, 
	B => B12, 
	C => C12, 
	D => D12, 
	E => E12, 
	F => F12, 
	G => G12, 
	H => H12, 
	OUTPUT => OUTPUT12
);
U15 : ORPART	PORT MAP(
	A => A13, 
	B => B13, 
	C => C13, 
	D => D13, 
	E => E13, 
	F => F13, 
	G => G13, 
	H => H13, 
	OUTPUT => OUTPUT13
);
U16 : ORPART	PORT MAP(
	A => A14, 
	B => B14, 
	C => C14, 
	D => D14, 
	E => E14, 
	F => F14, 
	G => G14, 
	H => H14, 
	OUTPUT => OUTPUT14
);
U17 : ORPART	PORT MAP(
	A => A15, 
	B => B15, 
	C => C15, 
	D => D15, 
	E => E15, 
	F => F15, 
	G => G15, 
	H => H15, 
	OUTPUT => OUTPUT15
);
U2 : ORPART	PORT MAP(
	A => A0, 
	B => B0, 
	C => C0, 
	D => D0, 
	E => E0, 
	F => F0, 
	G => G0, 
	H => H0, 
	OUTPUT => OUTPUT0
);
U3 : ORPART	PORT MAP(
	A => A1, 
	B => B1, 
	C => C1, 
	D => D1, 
	E => E1, 
	F => F1, 
	G => G1, 
	H => H1, 
	OUTPUT => OUTPUT1
);
U4 : ORPART	PORT MAP(
	A => A2, 
	B => B2, 
	C => C2, 
	D => D2, 
	E => E2, 
	F => F2, 
	G => G2, 
	H => H2, 
	OUTPUT => OUTPUT2
);
U5 : ORPART	PORT MAP(
	A => A3, 
	B => B3, 
	C => C3, 
	D => D3, 
	E => E3, 
	F => F3, 
	G => G3, 
	H => H3, 
	OUTPUT => OUTPUT3
);
U6 : ORPART	PORT MAP(
	A => A4, 
	B => B4, 
	C => C4, 
	D => D4, 
	E => E4, 
	F => F4, 
	G => G4, 
	H => H4, 
	OUTPUT => OUTPUT4
);
U7 : ORPART	PORT MAP(
	A => A5, 
	B => B5, 
	C => C5, 
	D => D5, 
	E => E5, 
	F => F5, 
	G => G5, 
	H => H5, 
	OUTPUT => OUTPUT5
);
U8 : ORPART	PORT MAP(
	A => A6, 
	B => B6, 
	C => C6, 
	D => D6, 
	E => E6, 
	F => F6, 
	G => G6, 
	H => H6, 
	OUTPUT => OUTPUT6
);
U9 : ORPART	PORT MAP(
	A => A7, 
	B => B7, 
	C => C7, 
	D => D7, 
	E => E7, 
	F => F7, 
	G => G7, 
	H => H7, 
	OUTPUT => OUTPUT7
);
U10 : ORPART	PORT MAP(
	A => A8, 
	B => B8, 
	C => C8, 
	D => D8, 
	E => E8, 
	F => F8, 
	G => G8, 
	H => H8, 
	OUTPUT => OUTPUT8
);
U11 : ORPART	PORT MAP(
	A => A9, 
	B => B9, 
	C => C9, 
	D => D9, 
	E => E9, 
	F => F9, 
	G => G9, 
	H => H9, 
	OUTPUT => OUTPUT9
);
U12 : ORPART	PORT MAP(
	A => A10, 
	B => B10, 
	C => C10, 
	D => D10, 
	E => E10, 
	F => F10, 
	G => G10, 
	H => H10, 
	OUTPUT => OUTPUT10
);
END STRUCTURE;

