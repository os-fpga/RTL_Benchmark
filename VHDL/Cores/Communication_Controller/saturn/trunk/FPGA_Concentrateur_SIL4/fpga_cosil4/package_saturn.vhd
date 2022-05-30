--============================================================================= 
--  TITRE : MEMORY_MAP
--  DESCRIPTION : 
--        Mappe la zone mémoire du BAR accédée par le bus local sur les registres
--        internes et les DPRAM 
--  FICHIER :        memory_map.vhd 
--=============================================================================
--  CREATION 
--  DATE	AUTEUR	PROJET	REVISION 
--  29/02/2012	DRA	CONCERTO	V1.0 
--=============================================================================
--  HISTORIQUE  DES  MODIFICATIONS :
--  DATE	AUTEUR	PROJET	REVISION 
--=============================================================================

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;


PACKAGE package_saturn IS
   CONSTANT VERSION_FIRMWARE: STD_LOGIC_VECTOR(7 DOWNTO 0) := x"10";
   CONSTANT NBBIT_ADD_LOCAL : INTEGER := 16;
   
   CONSTANT ADD_BASE_BAR0      : STD_LOGIC_VECTOR(NBBIT_ADD_LOCAL-1 DOWNTO 0) := x"0000";
   CONSTANT ADD_BASE_BAR1      : STD_LOGIC_VECTOR(NBBIT_ADD_LOCAL-1 DOWNTO 0) := x"8000";
   CONSTANT ADD_BASE_TXPER     : STD_LOGIC_VECTOR(NBBIT_ADD_LOCAL-1 DOWNTO 0) := x"8000";
   CONSTANT ADD_BASE_TXAPER    : STD_LOGIC_VECTOR(NBBIT_ADD_LOCAL-1 DOWNTO 0) := x"9000";

   -- Types provisoires pour le débug
   CONSTANT NB_MIO      : INTEGER := 20;
   TYPE miodat_type IS ARRAY(NB_MIO-1 DOWNTO 0) OF STD_LOGIC_VECTOR(31 DOWNTO 0);

END package_saturn;