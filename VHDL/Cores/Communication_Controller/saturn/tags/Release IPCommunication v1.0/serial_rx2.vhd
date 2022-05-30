--============================================================================= 
--  TITRE : serial_rx2
--  DESCRIPTION : 
--        Déserialisateur des données reçues sur rx et remet en forme
--        le signal (retaillage des durée de bit) pour la recopie 
--        La durée d'un bit est égale à tc_divclk+1 pulse de clk_sys	
--        
--        On additionne les tc_divclk+1 échantillons de chaque bit
--        Si la somme est > tc_divclk/2, c'est un '1', sinon, c'est un '0'
--  FICHIER :        serial_rx2.vhd 
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

ENTITY serial_rx2 IS
   GENERIC (
      nbbit_div : INTEGER := 10); -- Nombre de bits pour coder le diviseur d'horloge
   PORT (
      -- Ports système
      clk_sys  : IN  STD_LOGIC;  -- Clock système
      rst_n    : IN  STD_LOGIC;  -- Reset général système
      baud_lock: IN  STD_LOGIC;  -- Indique que le baudrate est calé

      -- Interface série
      tc_divclk: IN  STD_LOGIC_VECTOR (nbbit_div-1 DOWNTO 0); -- Diviseur de l'horloge système pour le baudrate
      tx       : OUT  STD_LOGIC;    -- Re transmission série
      rx       : IN STD_LOGIC;      -- Port de réception série
      
      -- Interface parallèle
      busy     : OUT STD_LOGIC;     -- Indique qu'une réception est en cours
      val      : OUT STD_LOGIC;     -- Indique que rx_dat contient la dernière donnée reçu
      rx_dat   : OUT  STD_LOGIC_VECTOR (7 DOWNTO 0)  -- Donnée reçue (synchrone de val)
      );
END serial_rx2;

ARCHITECTURE rtl of serial_rx2 is
   SIGNAL rx_r             : STD_LOGIC;   -- Délai pour détecter le front descendant
   SIGNAL sumrx            : STD_LOGIC_VECTOR(nbbit_div-1 DOWNTO 0);   -- Pour additionner N échantillons consécutifs
   
   SIGNAL cptbit_rx        : STD_LOGIC_VECTOR(3 downto 0);  -- Compteur de bits dans un caractère en réception
   SIGNAL divclk_rx        : STD_LOGIC_VECTOR(nbbit_div-1 downto 0);  -- Diviseur d'horloge pour mesurer un bit en réception
   SIGNAL rx_encours       : STD_LOGIC;                     -- Indique qu'un caractère est en cours de réception
   SIGNAL shifter_rx       : STD_LOGIC_VECTOR(7 downto 0);  -- Registre à décalage de désrialisation
   SIGNAL consol_bit       : STD_LOGIC;                     -- Bit consolidé après sur-échantillonnage
   
BEGIN
   --------------------------------------------
   -- Détection du front descendant sur rx
   --------------------------------------------
   front_rx : PROCESS(clk_sys, rst_n)
   BEGIN
      IF (rst_n = '0') THEN
         rx_r <= '1';
      ELSIF (clk_sys'EVENT and clk_sys = '1') THEN
         rx_r <= rx;
      END IF;
   END PROCESS;

   -- Si on a compté des '1' plus de la moitié du temps, on considère un '1' sinon un '0'
   consol_bit <= '1' WHEN (('0' & sumrx) + rx) > ("00" & tc_divclk(nbbit_div-1 DOWNTO 1)) ELSE '0';

   --------------------------------------------
   -- Déserialisateur des données reçues sur rx 
   -- et remise en forme (retaillage des durée de bit) pour la recopie
   --------------------------------------------
   deser_shaper : PROCESS(clk_sys, rst_n)
   BEGIN
      IF (rst_n = '0') THEN
         cptbit_rx <= (OTHERS => '0');
         divclk_rx <= (OTHERS => '0');
         rx_encours <= '0';
         tx <= '1';
         val <= '0';
      ELSIF (clk_sys'EVENT and clk_sys = '1') THEN
         IF (rx_encours = '0') THEN
         -- Si on est pas déjà en train de sérialiser un car
            val <= '0';    -- On s'assure que l'écriture dans la FIFO de réception ne dure qu'un pulse
            IF (rx = '0' and rx_r = '1') THEN
            -- Sur détection du front descendant (le Start bit)
               cptbit_rx <= (OTHERS => '0');    -- On initialise le compteur de bits
               -- on initialise le diviseur d'horloge à la fin du tc 
               -- on rajoute 1 pour compenser le retard de détection du front descendant
               -- Donc on initialise à 0
               divclk_rx <= (others => '0');
               sumrx <= (others => '0');        -- On init la somme des sur-echantillonnages
               rx_encours <= '1';               -- On indique qu'on est en réception
            END IF;
            tx <= '1';                          -- Idle de la ligne Tx
         ELSE
         -- Si on est en train de recevoir un car
            IF (divclk_rx = tc_divclk) THEN
            -- Si on atteind le terminal count (TC) du diviseur d'horloge
            -- On va traiter un bit de plus
               divclk_rx <= (OTHERS => '0');                -- re init du diviseur d'horloge
               sumrx <= (others => '0');                    -- re init de la somme
               cptbit_rx <= cptbit_rx + 1;                  -- Un bit de plus reçu
               shifter_rx <= consol_bit & shifter_rx(7 downto 1);   -- On considère un nouveau bit LSB first
               IF (baud_lock = '0') THEN
               -- Tant que l'algo d'Autobaudrate n'a pas convergé
                  tx <= '1';                                -- On ne recopie rien
               ELSE
                  tx <= consol_bit;                         -- On recopie le bit consolidé
               END IF;
               IF (cptbit_rx = "1000") then                 -- On est en train de recevoir le 9ème bit (Start + 8 data)
                  val <= '1';                               -- On valide la donnée
                  rx_encours <= '0';                        -- On arrête la réception et on va attendre le prochain start
               ELSIF (cptbit_rx = "0000") AND (consol_bit = '1') THEN
               -- Si on est au premier bit et que c'est pas un '0' (bit de START)
                  rx_encours <= '0';                        -- On arrête la réception
               END IF;
            ELSE
               divclk_rx <= divclk_rx + 1;         -- En cours de réception on mesure la durée d'un bit
               sumrx <= sumrx + rx;                -- On somme les sur-échantillonnages
               val <= '0';                         -- On s'assure que le signal dure 1 pulse
            END IF;
         END IF;
      END IF;
   END PROCESS;
   rx_dat <= shifter_rx;         -- La data reçue correspond au registre à décalage lorsque val = '1'
   busy <= rx_encours;
END rtl;

