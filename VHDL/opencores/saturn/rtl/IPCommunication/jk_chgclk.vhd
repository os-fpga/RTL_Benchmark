--============================================================================= 
--  TITRE : jk_chgclk
--  DESCRIPTION : 
--       Assure la transformation d'un pulse synchrone de clk1
--       en un pulse de clk2
--       Il faut 
--            - que freq(clk1) >> freq(clk2);
--            - que la période des pulses sur clk1 soit inférieure à 2 fois la période de clk2
--       Principe : une bascule JK est mise à 1 sur pulse1
--       Une triple FF assure la détection du front montant de la JK avec clk2
--       Le pulse généré sur clk2 est passé dans une triple FF pour détecter
--       le front montant avec clk1 et clearer la JK

--  FICHIER :        jk_chgclk.vhd 
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



-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

ENTITY jk_chgclk IS
   PORT (
      rstn     : IN  STD_LOGIC;  -- Reset général
      clk1     : IN  STD_LOGIC;  -- Horloge principale 1
      clk2     : IN  STD_LOGIC;  -- Horloge principale 2
      pulsein  : IN  STD_LOGIC;  -- Signal synchronie de clk1 à prendre en compte avec clk2
      pulseout : OUT STD_LOGIC   -- Pulse sur clk2 sur front montant de pulse1
      );
END jk_chgclk;

ARCHITECTURE rtl of jk_chgclk is
   SIGNAL clk1_to_clk2 : STD_LOGIC_VECTOR(2 DOWNTO 0);   -- Triple FF pour le front de JK avec clk2
   SIGNAL clk2_to_clk1 : STD_LOGIC_VECTOR(2 DOWNTO 0);   -- Triple FF pour le front de front_jk avec clk1
   SIGNAL jk_clk1      : STD_LOGIC;                      -- JK de mémorisation de pulse1
   SIGNAL front_jk     : STD_LOGIC;                      -- Détection du front de JK avec clk2

BEGIN
   -- Process de passage de clk1 à clk2
   toclk2 : PROCESS(clk2, rstn)
   BEGIN
      IF (rstn = '0') THEN
         clk1_to_clk2 <= (OTHERS => '0');
      ELSIF (clk2'EVENT and clk2 = '1') THEN
      -- Triple FF sur la bascule JK
         clk1_to_clk2 <= clk1_to_clk2(1 DOWNTO 0) & jk_clk1;
      END IF;
   END PROCESS;
   front_jk <= clk1_to_clk2(2) AND NOT(clk1_to_clk2(1));
   pulseout <= front_jk;

   -- Process de passage de clk2 à clk1 et de gestion de la JK
   backtoclk1 : PROCESS(clk1, rstn)
   BEGIN
      IF (rstn = '0') THEN
         clk2_to_clk1 <= (OTHERS => '0');
         jk_clk1 <= '0';
      ELSIF (clk1'EVENT and clk1 = '1') THEN
         clk2_to_clk1 <= clk2_to_clk1(1 DOWNTO 0) & front_jk;  -- Triple FF sur le front_jk
         IF (clk2_to_clk1(2) = '1' AND clk2_to_clk1(1) = '0') THEN
         -- Priorité au clear sinon on peu avoir un deadlock
            jk_clk1 <= '0';
         ELSIF (pulsein = '1') THEN
         -- A chaque pulse sur pulse1
            jk_clk1 <= '1';        -- On mémorise l'info
         END IF;
      END IF;
   END PROCESS;

END rtl;

