--============================================================================= 
--  TITRE : serial_rx2
--  DESCRIPTION : 
--        D�serialisateur des donn�es re�ues sur rx et remet en forme
--        le signal (retaillage des dur�e de bit) pour la recopie 
--        La dur�e d'un bit est �gale � tc_divclk+1 pulse de clk_sys	
--        
--        On additionne les tc_divclk+1 �chantillons de chaque bit
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
      -- Ports syst�me
      clk_sys  : IN  STD_LOGIC;  -- Clock syst�me
      rst_n    : IN  STD_LOGIC;  -- Reset g�n�ral syst�me
      baud_lock: IN  STD_LOGIC;  -- Indique que le baudrate est cal�

      -- Interface s�rie
      tc_divclk: IN  STD_LOGIC_VECTOR (nbbit_div-1 DOWNTO 0); -- Diviseur de l'horloge syst�me pour le baudrate
      tx       : OUT  STD_LOGIC;    -- Re transmission s�rie
      rx       : IN STD_LOGIC;      -- Port de r�ception s�rie
      
      -- Interface parall�le
      busy     : OUT STD_LOGIC;     -- Indique qu'une r�ception est en cours
      val      : OUT STD_LOGIC;     -- Indique que rx_dat contient la derni�re donn�e re�u
      rx_dat   : OUT  STD_LOGIC_VECTOR (7 DOWNTO 0)  -- Donn�e re�ue (synchrone de val)
      );
END serial_rx2;

ARCHITECTURE rtl of serial_rx2 is
   SIGNAL rx_r             : STD_LOGIC;   -- D�lai pour d�tecter le front descendant
   SIGNAL sumrx            : STD_LOGIC_VECTOR(nbbit_div-1 DOWNTO 0);   -- Pour additionner N �chantillons cons�cutifs
   
   SIGNAL cptbit_rx        : STD_LOGIC_VECTOR(3 downto 0);  -- Compteur de bits dans un caract�re en r�ception
   SIGNAL divclk_rx        : STD_LOGIC_VECTOR(nbbit_div-1 downto 0);  -- Diviseur d'horloge pour mesurer un bit en r�ception
   SIGNAL rx_encours       : STD_LOGIC;                     -- Indique qu'un caract�re est en cours de r�ception
   SIGNAL shifter_rx       : STD_LOGIC_VECTOR(7 downto 0);  -- Registre � d�calage de d�srialisation
   SIGNAL consol_bit       : STD_LOGIC;                     -- Bit consolid� apr�s sur-�chantillonnage
   
BEGIN
   --------------------------------------------
   -- D�tection du front descendant sur rx
   --------------------------------------------
   front_rx : PROCESS(clk_sys, rst_n)
   BEGIN
      IF (rst_n = '0') THEN
         rx_r <= '1';
      ELSIF (clk_sys'EVENT and clk_sys = '1') THEN
         rx_r <= rx;
      END IF;
   END PROCESS;

   -- Si on a compt� des '1' plus de la moiti� du temps, on consid�re un '1' sinon un '0'
   consol_bit <= '1' WHEN (('0' & sumrx) + rx) > ("00" & tc_divclk(nbbit_div-1 DOWNTO 1)) ELSE '0';

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
            IF (rx = '0' and rx_r = '1') THEN
            -- Sur d�tection du front descendant (le Start bit)
               cptbit_rx <= (OTHERS => '0');    -- On initialise le compteur de bits
               -- on initialise le diviseur d'horloge � la fin du tc 
               -- on rajoute 1 pour compenser le retard de d�tection du front descendant
               -- Donc on initialise � 0
               divclk_rx <= (others => '0');
               sumrx <= (others => '0');        -- On init la somme des sur-echantillonnages
               rx_encours <= '1';               -- On indique qu'on est en r�ception
            END IF;
            tx <= '1';                          -- Idle de la ligne Tx
         ELSE
         -- Si on est en train de recevoir un car
            IF (divclk_rx = tc_divclk) THEN
            -- Si on atteind le terminal count (TC) du diviseur d'horloge
            -- On va traiter un bit de plus
               divclk_rx <= (OTHERS => '0');                -- re init du diviseur d'horloge
               sumrx <= (others => '0');                    -- re init de la somme
               cptbit_rx <= cptbit_rx + 1;                  -- Un bit de plus re�u
               shifter_rx <= consol_bit & shifter_rx(7 downto 1);   -- On consid�re un nouveau bit LSB first
               IF (baud_lock = '0') THEN
               -- Tant que l'algo d'Autobaudrate n'a pas converg�
                  tx <= '1';                                -- On ne recopie rien
               ELSE
                  tx <= consol_bit;                         -- On recopie le bit consolid�
               END IF;
               IF (cptbit_rx = "1000") then                 -- On est en train de recevoir le 9�me bit (Start + 8 data)
                  val <= '1';                               -- On valide la donn�e
                  rx_encours <= '0';                        -- On arr�te la r�ception et on va attendre le prochain start
               ELSIF (cptbit_rx = "0000") AND (consol_bit = '1') THEN
               -- Si on est au premier bit et que c'est pas un '0' (bit de START)
                  rx_encours <= '0';                        -- On arr�te la r�ception
               END IF;
            ELSE
               divclk_rx <= divclk_rx + 1;         -- En cours de r�ception on mesure la dur�e d'un bit
               sumrx <= sumrx + rx;                -- On somme les sur-�chantillonnages
               val <= '0';                         -- On s'assure que le signal dure 1 pulse
            END IF;
         END IF;
      END IF;
   END PROCESS;
   rx_dat <= shifter_rx;         -- La data re�ue correspond au registre � d�calage lorsque val = '1'
   busy <= rx_encours;
END rtl;

