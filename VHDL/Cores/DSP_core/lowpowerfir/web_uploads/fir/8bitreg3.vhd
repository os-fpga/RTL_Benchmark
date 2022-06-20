LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
ENTITY EightBitReg IS PORT (
	nPreset : IN std_logic;
	D0 : IN std_logic;
	D1 : IN std_logic;
	D2 : IN std_logic;
	D3 : IN std_logic;
	D4 : IN std_logic;
	D5 : IN std_logic;
	D6 : IN std_logic;
	D7 : IN std_logic;
	nReset : IN std_logic;
	Clk : IN std_logic;
	Q0 : OUT std_logic;
	Q1 : OUT std_logic;
	Q2 : OUT std_logic;
	Q3 : OUT std_logic;
	Q4 : OUT std_logic;
	Q5 : OUT std_logic;
	Q6 : OUT std_logic;
	Q7 : OUT std_logic
); 

END EightBitReg;



ARCHITECTURE STRUCTURE OF EightBitReg IS

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

-- SIGNALS

SIGNAL VCC : std_logic;
SIGNAL GND : std_logic;

-- GATE INSTANCES

BEGIN
U2 : \7474\	PORT MAP(
	CLK_A => CLK, 
	\C\\L\\R\\_A\ => NRESET, 
	D_A => D0, 
	\P\\R\\E\\_A\ => NPRESET, 
	Q_A => Q0, 
	VCC => VCC, 
	GND => GND, 
	\Q\\_A\ => OPEN, 
	CLK_B => 'Z', 
	\C\\L\\R\\_B\ => 'Z', 
	D_B => 'Z', 
	\P\\R\\E\\_B\ => 'Z', 
	Q_B => OPEN, 
	\Q\\_B\ => OPEN
);
U3 : \7474\	PORT MAP(
	CLK_A => CLK, 
	\C\\L\\R\\_A\ => NRESET, 
	D_A => D1, 
	\P\\R\\E\\_A\ => NPRESET, 
	Q_A => Q1, 
	VCC => VCC, 
	GND => GND, 
	\Q\\_A\ => OPEN, 
	CLK_B => 'Z', 
	\C\\L\\R\\_B\ => 'Z', 
	D_B => 'Z', 
	\P\\R\\E\\_B\ => 'Z', 
	Q_B => OPEN, 
	\Q\\_B\ => OPEN
);
U4 : \7474\	PORT MAP(
	CLK_A => CLK, 
	\C\\L\\R\\_A\ => NRESET, 
	D_A => D2, 
	\P\\R\\E\\_A\ => NPRESET, 
	Q_A => Q2, 
	VCC => VCC, 
	GND => GND, 
	\Q\\_A\ => OPEN, 
	CLK_B => 'Z', 
	\C\\L\\R\\_B\ => 'Z', 
	D_B => 'Z', 
	\P\\R\\E\\_B\ => 'Z', 
	Q_B => OPEN, 
	\Q\\_B\ => OPEN
);
U5 : \7474\	PORT MAP(
	CLK_A => CLK, 
	\C\\L\\R\\_A\ => NRESET, 
	D_A => D3, 
	\P\\R\\E\\_A\ => NPRESET, 
	Q_A => Q3, 
	VCC => VCC, 
	GND => GND, 
	\Q\\_A\ => OPEN, 
	CLK_B => 'Z', 
	\C\\L\\R\\_B\ => 'Z', 
	D_B => 'Z', 
	\P\\R\\E\\_B\ => 'Z', 
	Q_B => OPEN, 
	\Q\\_B\ => OPEN
);
U6 : \7474\	PORT MAP(
	CLK_A => CLK, 
	\C\\L\\R\\_A\ => NRESET, 
	D_A => D7, 
	\P\\R\\E\\_A\ => NPRESET, 
	Q_A => Q7, 
	VCC => VCC, 
	GND => GND, 
	\Q\\_A\ => OPEN, 
	CLK_B => 'Z', 
	\C\\L\\R\\_B\ => 'Z', 
	D_B => 'Z', 
	\P\\R\\E\\_B\ => 'Z', 
	Q_B => OPEN, 
	\Q\\_B\ => OPEN
);
U7 : \7474\	PORT MAP(
	CLK_A => CLK, 
	\C\\L\\R\\_A\ => NRESET, 
	D_A => D4, 
	\P\\R\\E\\_A\ => NPRESET, 
	Q_A => Q4, 
	VCC => VCC, 
	GND => GND, 
	\Q\\_A\ => OPEN, 
	CLK_B => 'Z', 
	\C\\L\\R\\_B\ => 'Z', 
	D_B => 'Z', 
	\P\\R\\E\\_B\ => 'Z', 
	Q_B => OPEN, 
	\Q\\_B\ => OPEN
);
U8 : \7474\	PORT MAP(
	CLK_A => CLK, 
	\C\\L\\R\\_A\ => NRESET, 
	D_A => D5, 
	\P\\R\\E\\_A\ => NPRESET, 
	Q_A => Q5, 
	VCC => VCC, 
	GND => GND, 
	\Q\\_A\ => OPEN, 
	CLK_B => 'Z', 
	\C\\L\\R\\_B\ => 'Z', 
	D_B => 'Z', 
	\P\\R\\E\\_B\ => 'Z', 
	Q_B => OPEN, 
	\Q\\_B\ => OPEN
);
U9 : \7474\	PORT MAP(
	CLK_A => CLK, 
	\C\\L\\R\\_A\ => NRESET, 
	D_A => D6, 
	\P\\R\\E\\_A\ => NPRESET, 
	Q_A => Q6, 
	VCC => VCC, 
	GND => GND, 
	\Q\\_A\ => OPEN, 
	CLK_B => 'Z', 
	\C\\L\\R\\_B\ => 'Z', 
	D_B => 'Z', 
	\P\\R\\E\\_B\ => 'Z', 
	Q_B => OPEN, 
	\Q\\_B\ => OPEN
);
END STRUCTURE;

