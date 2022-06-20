--***************************************************************************
--*                                                                         *
--*                         Copyright (C) 1987-1995                         *
--*                              by OrCAD, INC.                             *
--*                                                                         *
--*                           All rights reserved.                          *
--*                                                                         *
--***************************************************************************
   
   
-- Purpose:		OrCAD VHDL Source File
-- Version:		v7.00.01
-- Date:			February 24, 1997
-- File:			TTL.VHD
-- Resource:	  National, Logic Data Book, 1984
-- Delay units:	  Nanoseconds 
-- Characteristics: 74XXXX MIN/MAX, Vcc=5V +/-0.5 V
 
-- Rev Notes:
--		x7.00.00 - Handle feedback in correct manner for Simulate v7.0 
--		v7.00.01 - Fixed components with Px port names.  



LIBRARY ieee;
USE ieee.std_logic_1164.all;

--USE work.orcad_prims.all;

ENTITY \7400\ IS PORT(
A_A : IN  std_logic;
A_B : IN  std_logic;
A_C : IN  std_logic;
A_D : IN  std_logic;
B_A : IN  std_logic;
B_B : IN  std_logic;
B_C : IN  std_logic;
B_D : IN  std_logic;
Y_A : OUT  std_logic;
Y_B : OUT  std_logic;
Y_C : OUT  std_logic;
Y_D : OUT  std_logic;
VCC : IN  std_logic;
GND : IN  std_logic);
END \7400\;

ARCHITECTURE model OF \7400\ IS

    BEGIN
    Y_A <= NOT ( A_A AND B_A )  ;
    Y_B <= NOT ( A_B AND B_B )  ;
    Y_C <= NOT ( B_C AND A_C )  ;
    Y_D <= NOT ( B_D AND A_D )  ;
END model;




LIBRARY ieee;
USE ieee.std_logic_1164.all;


ENTITY \7404\ IS PORT(
A_A : IN  std_logic;
A_B : IN  std_logic;
A_C : IN  std_logic;
A_D : IN  std_logic;
A_E : IN  std_logic;
A_F : IN  std_logic;
Y_A : OUT  std_logic;
Y_B : OUT  std_logic;
Y_C : OUT  std_logic;
Y_D : OUT  std_logic;
Y_E : OUT  std_logic;
Y_F : OUT  std_logic;
VCC : IN  std_logic;
GND : IN  std_logic);
END \7404\;

ARCHITECTURE model OF \7404\ IS

    BEGIN
    Y_A <= NOT ( A_A );
    Y_B <= NOT ( A_B ) ;
    Y_C <= NOT ( A_C ) ;
    Y_D <= NOT ( A_D ) ;
    Y_E <= NOT ( A_E ) ;
    Y_F <= NOT ( A_F ) ;
END model;



LIBRARY ieee;
USE ieee.std_logic_1164.all;



ENTITY \7408\ is
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
	); END \7408\;

ARCHITECTURE model OF \7408\ IS

    BEGIN
    Y_A <=  ( A_A AND B_A ) ;
    Y_B <=  ( A_B AND B_B ) ;
    Y_C <=  ( A_C AND B_C ) ;
    Y_D <=  ( A_D AND B_D ) ;
END model;



LIBRARY ieee;
USE ieee.std_logic_1164.all;



ENTITY \7411\ IS PORT(
A_A : IN  std_logic;
A_B : IN  std_logic;
A_C : IN  std_logic;
B_A : IN  std_logic;
B_B : IN  std_logic;
B_C : IN  std_logic;
C_A : IN  std_logic;
C_B : IN  std_logic;
C_C : IN  std_logic;
Y_A : OUT  std_logic;
Y_B : OUT  std_logic;
Y_C : OUT  std_logic;
VCC : IN  std_logic;
GND : IN  std_logic);
END \7411\;

ARCHITECTURE model OF \7411\ IS

    BEGIN
    Y_A <=  ( A_A AND B_A AND C_A );
    Y_B <=  ( A_B AND B_B AND C_B ) ;
    Y_C <=  ( C_C AND B_C AND A_C ) ;
END model;





LIBRARY ieee;
USE ieee.std_logic_1164.all;



ENTITY \7426\ IS PORT(
A_A : IN  std_logic;
A_B : IN  std_logic;
A_C : IN  std_logic;
A_D : IN  std_logic;
B_A : IN  std_logic;
B_B : IN  std_logic;
B_C : IN  std_logic;
B_D : IN  std_logic;
Y_A : OUT  std_logic;
Y_B : OUT  std_logic;
Y_C : OUT  std_logic;
Y_D : OUT  std_logic;
VCC : IN  std_logic;
GND : IN  std_logic);
END \7426\;

ARCHITECTURE model OF \7426\ IS

    BEGIN
    Y_A <= NOT ( A_A AND B_A ) ;
    Y_B <= NOT ( A_B AND B_B )   ;
    Y_C <= NOT ( A_C AND B_C )   ;
    Y_D <= NOT ( B_D AND A_D )   ;
END model;


LIBRARY ieee;
USE ieee.std_logic_1164.all;



ENTITY \7427\ IS PORT(
A_A : IN  std_logic;
A_B : IN  std_logic;
A_C : IN  std_logic;
B_A : IN  std_logic;
B_B : IN  std_logic;
B_C : IN  std_logic;
C_A : IN  std_logic;
C_B : IN  std_logic;
C_C : IN  std_logic;
Y_A : OUT  std_logic;
Y_B : OUT  std_logic;
Y_C : OUT  std_logic;
VCC : IN  std_logic;
GND : IN  std_logic);
END \7427\;

ARCHITECTURE model OF \7427\ IS

    BEGIN
    Y_A <= NOT ( A_A OR B_A OR C_A )  ;
    Y_B <= NOT ( A_B OR B_B OR C_B )   ;
    Y_C <= NOT ( C_C OR B_C OR A_C )  ;
END model;



LIBRARY ieee;
USE ieee.std_logic_1164.all;





ENTITY \7432\ is
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
	); END \7432\;

ARCHITECTURE model OF \7432\ IS

    BEGIN
    Y_A <=  ( A_A OR B_A )   ;
    Y_B <=  ( A_B OR B_B )   ;
    Y_C <=  ( A_C OR B_C )   ;
    Y_D <=  ( A_D OR B_D )   ;
END model;


LIBRARY ieee;
USE ieee.std_logic_1164.all;


ENTITY \7474\ IS PORT(
D_A : IN  std_logic;
D_B : IN  std_logic;
CLK_A : IN  std_logic;
CLK_B : IN  std_logic;
Q_A : OUT  std_logic;
Q_B : OUT  std_logic;
\Q\\_A\ : OUT  std_logic;
\Q\\_B\ : OUT  std_logic;
VCC : IN  std_logic;
\P\\R\\E\\_A\ : IN  std_logic;
\P\\R\\E\\_B\ : IN  std_logic;
GND : IN  std_logic;
\C\\L\\R\\_A\ : IN  std_logic;
\C\\L\\R\\_B\ : IN  std_logic);
END \7474\;

ARCHITECTURE model OF \7474\ IS

BEGIN
 
process(CLK_A, \C\\L\\R\\_A\, \P\\R\\E\\_A\) is
begin
  if( \C\\L\\R\\_A\ = '0') then
     Q_A <= '0';
     \Q\\_A\ <= '1';
  elsif(\P\\R\\E\\_A\ = '0') then
     Q_A <= '1';
     \Q\\_A\ <= '0';
  elsif(CLK_A'event and CLK_A = '1') then
     Q_A <= D_A;
     \Q\\_A\  <= not D_A;
  end if;  
end process;

process(CLK_B, \C\\L\\R\\_B\, \P\\R\\E\\_B\) is
begin
  if( \C\\L\\R\\_B\ = '0') then
     Q_B <= '0';
     \Q\\_B\ <= '1';
  elsif(\P\\R\\E\\_B\ = '0') then
     Q_B <= '1';
     \Q\\_B\ <= '0';
  elsif(CLK_B'event and CLK_B = '1') then
     Q_B <= D_B;
     \Q\\_B\  <= not D_B;
  end if;  
end process;

END model;



LIBRARY ieee;
USE ieee.std_logic_1164.all;


entity \7486\ is
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
	); END entity;

ARCHITECTURE model OF \7486\ IS

    BEGIN
    Y_A <=  ( A_A XOR B_A ) ;
    Y_B <=  ( A_B XOR B_B )   ;
    Y_C <=  ( B_C XOR A_C )   ;
    Y_D <=  ( B_D XOR A_D )   ;
END model;

LIBRARY ieee;
USE ieee.std_logic_1164.all;


ENTITY \74HC21\ IS PORT(
A_A : IN  std_logic;
A_B : IN  std_logic;
B_A : IN  std_logic;
B_B : IN  std_logic;
C_A : IN  std_logic;
C_B : IN  std_logic;
D_A : IN  std_logic;
D_B : IN  std_logic;
Y_A : OUT  std_logic;
Y_B : OUT  std_logic;
VCC : IN  std_logic;
GND : IN  std_logic);
END \74HC21\;

ARCHITECTURE model OF \74HC21\ IS

    BEGIN
    Y_A <=  ( A_A AND B_A AND C_A AND D_A );
    Y_B <=  ( A_B AND B_B AND C_B AND D_B ) ;
END model;
