--============================================================================= 
--  TITRE : serial_rx
--  DESCRIPTION : 
--        Déserialisateur des données reçues sur rx et remet en forme
--        le signal (retaillage des durée de bit) pour la recopie 
--        La durée d'un bit est égale à tc_divclk+1 pulse de clk_sys	
--        
--        On additionne 3 échantillons consécutifs de part et d'autre
--        du milieu du bit à échantilloner. Si la somme est >=2 => bit à 1
--        sinon bit à 0	
--  FICHIER :        serial_rx.vhd 
--=============================================================================
--  CREATION 
--  DATE	AUTEUR	PROJET	REVISION 
--  29/02/2012	DRA	CONCERTO	V1.0 
--  14/01/2013 DRA   Modificiation pour échantillonner 3 fois et rendre plus robuste
--                   en environnement bruité
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

ENTITY serial_rx IS
   GENERIC (
      nbbit_div : INTEGER := 10); -- Nombre de bits pour coder le diviseur d'horloge
   PORT (
      -- Ports système
      clk_sys  : IN  STD_LOGIC;  -- Clock système
      rst_n    : IN  STD_LOGIC;  -- Reset génrél système
      baud_lock: IN  STD_LOGIC;  -- Indique que le baudrate est calé

      -- Interface série
      tc_divclk: IN  STD_LOGIC_VECTOR (nbbit_div-1 DOWNTO 0); -- Diviseur de l'horloge système pour le baudrate
      tx       : OUT  STD_LOGIC;    -- Re transmission série
      rx       : IN STD_LOGIC;      -- Port de réception série
      
      -- Interface parallèle
      busy     : OUT STD_LOGIC;     -- Indique qu'une réception est en cours
      val      : OUT STD_LOGIC;     -- rx_dat contient la dernière donnée reçu
      rx_dat   : OUT  STD_LOGIC_VECTOR (7 DOWNTO 0)  -- Donnée reçue (synchrone de val)
      );
END serial_rx;

ARCHITECTURE rtl of serial_rx is
   SIGNAL rx_r             : STD_LOGIC_VECTOR(1 DOWNTO 0);   -- Délai pour détecter le front descendant
   SIGNAL sumrx            : STD_LOGIC_VECTOR(1 DOWNTO 0);   -- Pour additionner 3 échantillons consécutifs
   SIGNAL front_des_rx_c   : STD_LOGIC;   -- Un pulse de clk_sys sur front descendant de rx
   
   SIGNAL cptbit_rx        : STD_LOGIC_VECTOR(3 downto 0);  -- Compteur de bits dans un caractère en réception
   SIGNAL divclk_rx        : STD_LOGIC_VECTOR(nbbit_div-1 downto 0);  -- Diviseur d'horloge pour mesurer un bit en réception
   SIGNAL rx_encours       : STD_LOGIC;                     -- Indique qu'un caractère est en cours de réception
   SIGNAL shifter_rx       : STD_LOGIC_VECTOR(7 downto 0);  -- Registre à décalage de réception
   
BEGIN
   --------------------------------------------
   -- Détection du front descendant sur rx
   --------------------------------------------
   -- rx_r(1) & rx_r(0) & rx représente un registre à décalage du flux rx
   front_rx : PROCESS(clk_sys, rst_n)
   BEGIN
      IF (rst_n = '0') THEN
         rx_r <= (OTHERS => '1');
      ELSIF (clk_sys'EVENT and clk_sys = '1') THEN
         rx_r <= rx_r(0) & rx;
      END IF;
   END PROCESS;
   front_des_rx_c <= NOT(rx_r(0)) AND rx_r(1);  -- Détection du front descendant
   sumrx <= CONV_STD_LOGIC_VECTOR(rx_r(0), 2) + CONV_STD_LOGIC_VECTOR(rx_r(1), 2) +
            CONV_STD_LOGIC_VECTOR(rx, 2); -- On compte les 3 échantillons consécutif

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
            IF (front_des_rx_c = '1') THEN
            -- Sur détection du front descendant (le Start bit)
               cptbit_rx <= (OTHERS => '0');
               -- on initialise le diviseur d'horloge à la motié de tc pour échantilloner au milieu du bit
               -- on rajoute 2 pour compenser le retard de détection du front descendant
               divclk_rx <= ('0' & tc_divclk(tc_divclk'LEFT downto 1))+2;
               rx_encours <= '1';
            END IF;
            tx <= '1';
         ELSE
         -- Si on est en train de recevoir un car
            IF (divclk_rx = tc_divclk) THEN
            -- Si on atteind le terminal count (TC) du diviseur d'horloge
               divclk_rx <= (OTHERS => '0');
               cptbit_rx <= cptbit_rx + 1;                  -- Un bit de plus reçu
               -- Si la somme des 3 echantillons est >= 2 (i.e. le MSB est à 1) -> le bit est à 1
               shifter_rx <= sumrx(1) & shifter_rx(7 downto 1);   -- On garde le bit LSB first
               IF (baud_lock = '0') THEN
               -- Tant que l'algo d'Autobaudrate n'a pas convergé
                  tx <= '1';                                -- On ne recopie rien
               ELSE
                  tx <= sumrx(1);                           -- On échantillonne rx pour la recopie
               END IF;
               IF (cptbit_rx = "1000") then                 -- On est en train de recevoir le 9ème bit (Start + 8 data)
                  val <= '1';                               -- On valide la donnée
               ELSIF (cptbit_rx = "1001") then              -- Au 10 ème bit reçu
               -- Il faut attendre le 10ème bit pour garantir qu'en recopie, le 8ème bit utile (i.e. le 9ème) dure le bon temps
                  rx_encours <= '0';                        -- On arrête la réception
                  val <= '0';                               -- On s'assure que le signal dure 1 pulse
               END IF;
            ELSE
               divclk_rx <= divclk_rx + 1;         -- En cours de réception on mesure la durée d'un bit
               val <= '0';                         -- On s'assure que le signal dure 1 pulse
            END IF;
         END IF;
      END IF;
   END PROCESS;
   rx_dat <= shifter_rx;         -- La data reçue correspond au registre à décalage lorsque val = '1'
   busy <= rx_encours;
END rtl;

