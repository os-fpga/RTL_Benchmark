--============================================================================= 
--  TITRE : CRC16
--  DESCRIPTION : 
--       Calcule le CRC16 à partir du polynome poly
--       La donnée entrante est traitée LSB first
--       Le CRC est initilisaé à 0xFFFF
--       Le CRC est complémenté à 1 et les 2 octets sont swappés
--  FICHIER :        crc16.vhd 
--=============================================================================
--  CREATION 
--  DATE	      AUTEUR	PROJET	REVISION 
--  10/04/2014	DRA	   SATURN	V1.0 
--=============================================================================
--  HISTORIQUE  DES  MODIFICATIONS :
--  DATE	      AUTEUR	PROJET	REVISION 
--=============================================================================

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY crc16 IS
   GENERIC (
      poly : STD_LOGIC_VECTOR(15 downto 0) := x"1021"   -- CCITT16 par défaut
      );
   PORT (
      -- Ports système
      clk_sys  : IN  STD_LOGIC;  -- Clock système
      rst_n    : IN  STD_LOGIC;  -- Reset général système

      -- Interfaces d'entrée
      data     : IN  STD_LOGIC_VECTOR(7 DOWNTO 0); -- Donnée transmise ou reçue (LSB first)
      val      : IN  STD_LOGIC;                    -- validant du bus data
      init     : IN  STD_LOGIC;                    -- Initialise le caclul du CRC
      
      -- Résultat
      crc      : OUT  STD_LOGIC_VECTOR(15 downto 0)-- Résultat du calcul
      );
END crc16;

ARCHITECTURE rtl of crc16 is
   SIGNAL shifter          : STD_LOGIC_VECTOR(15 downto 0); -- DFF pour le calcul du CRC
  
BEGIN
   --------------------------------------------
   -- Détection des fronts montants et descendants sur rx1
   --------------------------------------------
   inst_crc : PROCESS(clk_sys, rst_n)
      VARIABLE shift_temp : STD_LOGIC_VECTOR(15 downto 0);  -- shifter temporaire pour traiter les 8 bits
      VARIABLE mask : STD_LOGIC;                            -- Pour le XOR d'un bit de data avec CRC(15)
   BEGIN
      IF (rst_n = '0') THEN
         shifter <= (others => '1');
      ELSIF (clk_sys'EVENT and clk_sys = '1') THEN
         IF (init = '1') THEN
            shifter <= (others => '1');      -- Le shifter est initialisé à FFFF (ISO 3309)
         ELSIF (val = '1') THEN
         -- Pour chaque octet reçu
            shift_temp := shifter;           -- Le shifter temp est initialisé avec le CRC courant    
            blc_bit : FOR i IN 0 to 7 LOOP   -- On traite tous les bits un par un LSB first
               mask := shift_temp(15) XOR data(i); -- Calcul de la valeur de feedback
               -- Shift du CRC avec mise à jour en fonction du polynome
               shift_temp := (shift_temp(14 downto 0) & '0') XOR 
                             (poly AND SXT(mask & mask, 16));
            END LOOP;
            shifter <= shift_temp;           -- Après traitement des 8 bits, maj du CRC
         END IF;
      END IF;
   END PROCESS;
  
   blc_form : FOR i IN 0 to 7 GENERATE
   BEGIN
   -- remise en forme du CRC pour assurer que x^15 est transmis en premier
      crc(15-i) <= NOT(shifter(i + 8));   -- complément à 2 selon ISO 3309
      crc(7-i)  <= NOT(shifter(i));       
   END GENERATE;

END rtl;

