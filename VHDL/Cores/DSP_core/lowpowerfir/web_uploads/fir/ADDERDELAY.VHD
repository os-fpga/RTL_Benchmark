LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY ADDERDELAY IS PORT (
	DIN0 : IN std_logic;
	DIN1 : IN std_logic;
	DIN2 : IN std_logic;
	DIN3 : IN std_logic;
	DIN4 : IN std_logic;
	DIN5 : IN std_logic;
	DIN6 : IN std_logic;
	DIN7 : IN std_logic;
	DIN8 : IN std_logic;
	DIN9 : IN std_logic;
	DIN10 : IN std_logic;
	DIN11 : IN std_logic;
	DIN12 : IN std_logic;
	DIN13 : IN std_logic;
	DIN14 : IN std_logic;
	DIN15 : IN std_logic;
	SIGNEDIN : IN std_logic;
	DOUT0 : OUT std_logic;
	DOUT1 : OUT std_logic;
	DOUT2 : OUT std_logic;
	DOUT3 : OUT std_logic;
	DOUT4 : OUT std_logic;
	DOUT5 : OUT std_logic;
	DOUT6 : OUT std_logic;
	DOUT7 : OUT std_logic;
	DOUT8 : OUT std_logic;
	DOUT9 : OUT std_logic;
	SIGNEDOUT : OUT std_logic;
	DOUT10 : OUT std_logic;
	DOUT11 : OUT std_logic;
	DOUT12 : OUT std_logic;
	DOUT13 : OUT std_logic;
	DOUT14 : OUT std_logic;
	DOUT15 : OUT std_logic
); 

END ADDERDELAY;



ARCHITECTURE STRUCTURE OF ADDERDELAY IS

-- COMPONENTS

COMPONENT DELAYBLOCK
	PORT (
	DIN : IN std_logic;
	DOUT : OUT std_logic
	); END COMPONENT;

-- SIGNALS


-- GATE INSTANCES

BEGIN
U13 : DELAYBLOCK	PORT MAP(
	DIN => DIN11, 
	DOUT => DOUT11
);
U14 : DELAYBLOCK	PORT MAP(
	DIN => DIN12, 
	DOUT => DOUT12
);
U15 : DELAYBLOCK	PORT MAP(
	DIN => DIN13, 
	DOUT => DOUT13
);
U16 : DELAYBLOCK	PORT MAP(
	DIN => DIN14, 
	DOUT => DOUT14
);
U17 : DELAYBLOCK	PORT MAP(
	DIN => DIN15, 
	DOUT => DOUT15
);
U18 : DELAYBLOCK	PORT MAP(
	DIN => SIGNEDIN, 
	DOUT => SIGNEDOUT
);
U2 : DELAYBLOCK	PORT MAP(
	DIN => DIN0, 
	DOUT => DOUT0
);
U3 : DELAYBLOCK	PORT MAP(
	DIN => DIN1, 
	DOUT => DOUT1
);
U4 : DELAYBLOCK	PORT MAP(
	DIN => DIN2, 
	DOUT => DOUT2
);
U5 : DELAYBLOCK	PORT MAP(
	DIN => DIN3, 
	DOUT => DOUT3
);
U6 : DELAYBLOCK	PORT MAP(
	DIN => DIN4, 
	DOUT => DOUT4
);
U7 : DELAYBLOCK	PORT MAP(
	DIN => DIN5, 
	DOUT => DOUT5
);
U8 : DELAYBLOCK	PORT MAP(
	DIN => DIN6, 
	DOUT => DOUT6
);
U9 : DELAYBLOCK	PORT MAP(
	DIN => DIN7, 
	DOUT => DOUT7
);
U10 : DELAYBLOCK	PORT MAP(
	DIN => DIN8, 
	DOUT => DOUT8
);
U11 : DELAYBLOCK	PORT MAP(
	DIN => DIN9, 
	DOUT => DOUT9
);
U12 : DELAYBLOCK	PORT MAP(
	DIN => DIN10, 
	DOUT => DOUT10
);
END STRUCTURE;

