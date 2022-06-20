--============================================================================= 
--  TITRE : serial_rx
--  DESCRIPTION : 
--        D�serialisateur des donn�es re�ues sur rx et remet en forme
--        le signal (retaillage des dur�e de bit) pour la recopie 
--        La dur�e d'un bit est �gale � tc_divclk+1 pulse de clk_sys	
--        
--        On additionne 3 �chantillons cons�cutifs de part et d'autre
--        du milieu du bit � �chantilloner. Si la somme est >=2 => bit � 1
--        sinon bit � 0	
--  FICHIER :        serial_rx.vhd 
--=============================================================================
--  CREATION 
--  DATE	AUTEUR	PROJET	REVISION 
--  29/02/2012	DRA	CONCERTO	V1.0 
--  14/01/2013 DRA   Modificiation pour �chantillonner 3 fois et rendre plus robuste
--                   en environnement bruit�
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
      -- Ports syst�me
      clk_sys  : IN  STD_LOGIC;  -- Clock syst�me
      rst_n    : IN  STD_LOGIC;  -- Reset g�nr�l syst�me
      baud_lock: IN  STD_LOGIC;  -- Indique que le baudrate est cal�

      -- Interface s�rie
      tc_divclk: IN  STD_LOGIC_VECTOR (nbbit_div-1 DOWNTO 0); -- Diviseur de l'horloge syst�me pour le baudrate
      tx       : OUT  STD_LOGIC;    -- Re transmission s�rie
      rx       : IN STD_LOGIC;      -- Port de r�ception s�rie
      
      -- Interface parall�le
      busy     : OUT STD_LOGIC;     -- Indique qu'une r�ception est en cours
      val      : OUT STD_LOGIC;     -- rx_dat contient la derni�re donn�e re�u
      rx_dat   : OUT  STD_LOGIC_VECTOR (7 DOWNTO 0)  -- Donn�e re�ue (synchrone de val)
      );
END serial_rx;

ARCHITECTURE rtl of serial_rx is
   SIGNAL rx_r             : STD_LOGIC_VECTOR(1 DOWNTO 0);   -- D�lai pour d�tecter le front descendant
   SIGNAL sumrx            : STD_LOGIC_VECTOR(1 DOWNTO 0);   -- Pour additionner 3 �chantillons cons�cutifs
   SIGNAL front_des_rx_c   : STD_LOGIC;   -- Un pulse de clk_sys sur front descendant de rx
   
   SIGNAL cptbit_rx        : STD_LOGIC_VECTOR(3 downto 0);  -- Compteur de bits dans un caract�re en r�ception
   SIGNAL divclk_rx        : STD_LOGIC_VECTOR(nbbit_div-1 downto 0);  -- Diviseur d'horloge pour mesurer un bit en r�ception
   SIGNAL rx_encours       : STD_LOGIC;                     -- Indique qu'un caract�re est en cours de r�ception
   SIGNAL shifter_rx       : STD_LOGIC_VECTOR(7 downto 0);  -- Registre � d�calage de r�ception
   
BEGIN
   --------------------------------------------
   -- D�tection du front descendant sur rx
   --------------------------------------------
   -- rx_r(1) & rx_r(0) & rx repr�sente un registre � d�calage du flux rx
   front_rx : PROCESS(clk_sys, rst_n)
   BEGIN
      IF (rst_n = '0') THEN
         rx_r <= (OTHERS => '1');
      ELSIF (clk_sys'EVENT and clk_sys = '1') THEN
         rx_r <= rx_r(0) & rx;
      END IF;
   END PROCESS;
   front_des_rx_c <= NOT(rx_r(0)) AND rx_r(1);  -- D�tection du front descendant
   sumrx <= CONV_STD_LOGIC_VECTOR(rx_r(0), 2) + CONV_STD_LOGIC_VECTOR(rx_r(1), 2) +
            CONV_STD_LOGIC_VECTOR(rx, 2); -- On compte les 3 �chantillons cons�cutif

   --------------------------------------------
   -- D�serialisateur des donn�es re�ues sur rx 
   -- et remise en forme (retaillage des dur�e de bit) pour la recopie
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
         -- Si on est pas d�j� en train de s�rialiser un car
            val <= '0';    -- On s'assure que l'�criture dans la FIFO de r�ception ne dure qu'un pulse
            IF (front_des_rx_c = '1') THEN
            -- Sur d�tection du front descendant (le Start bit)
               cptbit_rx <= (OTHERS => '0');
               -- on initialise le diviseur d'horloge � la moti� de tc pour �chantilloner au milieu du bit
               -- on rajoute 2 pour compenser le retard de d�tection du front descendant
               divclk_rx <= ('0' & tc_divclk(tc_divclk'LEFT downto 1))+2;
               rx_encours <= '1';
            END IF;
            tx <= '1';
         ELSE
         -- Si on est en train de recevoir un car
            IF (divclk_rx = tc_divclk) THEN
            -- Si on atteind le terminal count (TC) du diviseur d'horloge
               divclk_rx <= (OTHERS => '0');
               cptbit_rx <= cptbit_rx + 1;                  -- Un bit de plus re�u
               -- Si la somme des 3 echantillons est >= 2 (i.e. le MSB est � 1) -> le bit est � 1
               shifter_rx <= sumrx(1) & shifter_rx(7 downto 1);   -- On garde le bit LSB first
               IF (baud_lock = '0') THEN
               -- Tant que l'algo d'Autobaudrate n'a pas converg�
                  tx <= '1';                                -- On ne recopie rien
               ELSE
                  tx <= sumrx(1);                           -- On �chantillonne rx pour la recopie
               END IF;
               IF (cptbit_rx = "1000") then                 -- On est en train de recevoir le 9�me bit (Start + 8 data)
                  val <= '1';                               -- On valide la donn�e
               ELSIF (cptbit_rx = "1001") then              -- Au 10 �me bit re�u
               -- Il faut attendre le 10�me bit pour garantir qu'en recopie, le 8�me bit utile (i.e. le 9�me) dure le bon temps
                  rx_encours <= '0';                        -- On arr�te la r�ception
                  val <= '0';                               -- On s'assure que le signal dure 1 pulse
               END IF;
            ELSE
               divclk_rx <= divclk_rx + 1;         -- En cours de r�ception on mesure la dur�e d'un bit
               val <= '0';                         -- On s'assure que le signal dure 1 pulse
            END IF;
         END IF;
      END IF;
   END PROCESS;
   rx_dat <= shifter_rx;         -- La data re�ue correspond au registre � d�calage lorsque val = '1'
   busy <= rx_encours;
END rtl;

