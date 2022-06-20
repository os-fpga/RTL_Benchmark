--============================================================================= 
--  TITRE : AUTOBAUD
--  DESCRIPTION : 
--       D�termine le baudrate utilis� pour la communication
--       Fourni un diviseur de l'horloge syst�me correspondant � la dur�e d'un bit
--       Principe : mesure le temps entre 2 fronts oppos�s sur rx1 et rx2 et 
--                  conserve le minimum. Ce temps donne une indication de la dur�e du bit.
--                  Il est utilis� pour d�terminer une des 8 valeurs discr�tes de communication

--  FICHIER :        autobaud.vhd 
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

ENTITY autobaud IS
   PORT (
      -- Ports syst�me
      clk_sys  : IN  STD_LOGIC;  -- Clock syst�me
      rst_n    : IN  STD_LOGIC;  -- Reset g�n�ral syst�me

      -- Interfaces s�rie
      rx1      : IN  STD_LOGIC;  -- R�ception s�rie port 1
      rx2      : IN  STD_LOGIC;  -- R�ception s�rie port 2

      -- Interface avec les modules d'analyse Layer 2
      val_rx1  : IN  STD_LOGIC;  -- 1 caract�re re�u sur le port 1
      eof1     : IN  STD_LOGIC;  -- Fin de trame port 1
      dat_rx1  : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);  -- Donn�e re�ue sur RX1
      l2_ok1   : IN  STD_LOGIC;  -- Flag de trame correcte port 1
      val_rx2  : IN  STD_LOGIC;  -- 1 caract�re re�u sur le port 2
      eof2     : IN  STD_LOGIC;  -- Fin de trame port 2
      dat_rx2  : IN  STD_LOGIC_VECTOR(7 DOWNTO 0);  -- Donn�e re�ue sur RX1
      l2_ok2   : IN  STD_LOGIC;  -- Flag de trame correcte port 2

      -- Sorties du module
      tc_divclk   : OUT  STD_LOGIC_VECTOR (10 DOWNTO 0);  -- Diviseur d'horloge syst�me. Un bit dure tc_dibclk+1 cycles de clk_sys
      baud_locked : OUT  STD_LOGIC        -- Indique que l'auto baudrate est lock�
      );
END autobaud;

ARCHITECTURE rtl of autobaud is
   -- Ne peuvent pas �tre trait�e en g�n�rique car le dernier process est optimis� pour freq_clk = 96
   CONSTANT freq_clk : INTEGER := 96;     -- Fr�quence de l'horloge syst�me en MHz
   CONSTANT nbbit    : INTEGER := 11;     -- Nombre de bits n�cessaires pour mesurer 20�s � freq_clk 

   SIGNAL rx_r1            : STD_LOGIC;   -- D�lai pour d�tecter les fronts de rx1
   SIGNAL front_des_rx_c1  : STD_LOGIC;   -- 1 pulse de clk_sys sur front descendant de rx1
   SIGNAL front_mon_rx_c1  : STD_LOGIC;   -- 1 pulse de clk_sys sur front montant de rx1
   SIGNAL rx_encours1      : STD_LOGIC;   -- Indique qu'on a d�j� d�tect� au moins 1 front sur rx1
   SIGNAL divclk1          : STD_LOGIC_VECTOR(nbbit-1 downto 0); -- mesure le nombre de clk_sys sur rx1
   SIGNAL cpt_car1         : STD_LOGIC_VECTOR(9 downto 0);       -- nb car re�u sur rx1 depuis la mise � jour du diviseur
                                                                 -- lorsque l'algo a converg�, compte les trames mauvaises
   SIGNAL rx_r2            : STD_LOGIC;   -- D�lai pour d�tecter les fronts de rx2
   SIGNAL front_des_rx_c2  : STD_LOGIC;   -- 1 pulse de clk_sys sur front descendant de rx2
   SIGNAL front_mon_rx_c2  : STD_LOGIC;   -- 1 pulse de clk_sys sur front montant de rx2
   SIGNAL rx_encours2      : STD_LOGIC;   -- Indique qu'on a d�j� d�tect� au moins 1 front sur rx2
   SIGNAL divclk2          : STD_LOGIC_VECTOR(nbbit-1 downto 0); -- mesure le nombre de clk_sys sur rx2
   SIGNAL cpt_car2         : STD_LOGIC_VECTOR(9 downto 0); -- nb car re�u sur rx2 depuis la mise � jour du diviseur
   SIGNAL memmin_div       : STD_LOGIC_VECTOR(nbbit-1 downto 0); -- m�morise la plus petite dur�e mesur�e sur rx1 ou rx2
   SIGNAL mux_divclk_c     : STD_LOGIC_VECTOR(nbbit-1 downto 0); -- pour muxer divclk1 et divclk2 avant de comparer � memmin_div
   SIGNAL baud_locked_buf  : STD_LOGIC;   -- 1 indique que le baudrate est fig�.

   SIGNAL cpt_fanion1      : STD_LOGIC_VECTOR(2 DOWNTO 0);        -- Compte le nombre de fanions cons�cutifs sur RX1
   SIGNAL cpt_fanion2      : STD_LOGIC_VECTOR(2 DOWNTO 0);        -- Compte le nombre de fanions cons�cutifs sur RX2
     
BEGIN
   --------------------------------------------
   -- D�tection des fronts montants et descendants sur rx1
   --------------------------------------------
   front_rx1 : PROCESS(clk_sys, rst_n)
   BEGIN
      IF (rst_n = '0') THEN
         rx_r1 <= '1';
      ELSIF (clk_sys'EVENT and clk_sys = '1') THEN
         rx_r1 <= rx1;
      END IF;
   END PROCESS;
   front_des_rx_c1 <= NOT(rx1) AND rx_r1;
   front_mon_rx_c1 <= rx1 AND NOT(rx_r1);   
   
   --------------------------------------------
   -- Mesure la dur�e entre 2 front oppos�s sur rx1
   --------------------------------------------
   mes_bit_1 : PROCESS(clk_sys, rst_n)
   BEGIN
      IF (rst_n = '0') THEN
         divclk1 <= (others => '0');
         rx_encours1 <= '0';
      ELSIF (clk_sys'EVENT and clk_sys = '1') THEN
         IF (baud_locked_buf = '0') THEN
         -- On ne mesure que si l'algo n'a pas encore converg�
            IF (front_des_rx_c1 = '1' OR front_mon_rx_c1 = '1') THEN  
            -- A chaque front d�tect� (montant ou descendant)
               rx_encours1 <= '1';        -- Pour se souvenir qu'on a d�j� vu un front
               divclk1 <= (others => '0');-- On initialise le comptage de cycle 
            ELSIF (rx_encours1 = '1') THEN
               -- Si on a d�j� d�tect� un front (i.e. le compteur a �t� correctement initialis�)
               IF (divclk1 /= SXT("11", nbbit)) THEN
               -- On compte le nombre de cycles depuis le front pr�c�dent
                  divclk1 <= divclk1 + 1;
               ELSE
               -- Si le compteur atteind son max, on recommence l'algo au d�but
                  rx_encours1 <= '0';
               END IF;
            END IF;
         ELSE
            rx_encours1 <= '0';
         END IF;
      END IF;
   END PROCESS;

   --------------------------------------------
   -- D�tection des fronts montants et descendants sur rx2
   --------------------------------------------
   front_rx2 : PROCESS(clk_sys, rst_n)
   BEGIN
      IF (rst_n = '0') THEN
         rx_r2 <= '1';
      ELSIF (clk_sys'EVENT and clk_sys = '1') THEN
         rx_r2 <= rx2;
      END IF;
   END PROCESS;
   front_des_rx_c2 <= NOT(rx2) AND rx_r2;
   front_mon_rx_c2 <= rx2 AND NOT(rx_r2);   

   --------------------------------------------
   -- Mesure la dur�e entre 2 front oppos�s sur rx2
   --------------------------------------------
   mes_bit_2 : PROCESS(clk_sys, rst_n)
   BEGIN
      IF (rst_n = '0') THEN
         divclk2 <= (others => '0');
         rx_encours2 <= '0';
      ELSIF (clk_sys'EVENT and clk_sys = '1') THEN
         IF (baud_locked_buf = '0') THEN
            IF (front_des_rx_c2 = '1' OR front_mon_rx_c2 = '1') THEN
               rx_encours2 <= '1';
               divclk2 <= (others => '0');
            ELSIF (rx_encours2 = '1') THEN
               IF (divclk2 /= SXT("11", nbbit)) THEN
                  divclk2 <= divclk2 + 1;
               ELSE
                  rx_encours2 <= '0';
               END IF;
            END IF;
         ELSE
            rx_encours2 <= '0';
         END IF;
      END IF;
   END PROCESS;

   --------------------------------------------
   -- M�morise le minimum mesur� sur rx1 ou rx2
   --------------------------------------------
   -- On donne arbitrairement la priorit� � rx1. Sur un front de rx1 on le traite, sinon on traite rx2
   mux_divclk_c <= divclk1 WHEN (front_mon_rx_c1 = '1' OR front_des_rx_c1 = '1') ELSE divclk2;
 
   compare : PROCESS(clk_sys, rst_n)
   BEGIN
      IF (rst_n = '0') THEN
         memmin_div <= (others => '1');
         cpt_car1 <= (others => '0');
         cpt_car2 <= (others => '0');
         cpt_fanion1 <= (OTHERS => '0');
         cpt_fanion2 <= (OTHERS => '0');         
         baud_locked_buf <= '0';
      ELSIF (clk_sys'EVENT and clk_sys = '1') THEN
         IF (baud_locked_buf = '0') THEN
            -- Si l'algo n'est pas fini
            IF ((((front_des_rx_c1 = '1' OR front_mon_rx_c1 = '1') and rx_encours1 = '1') OR 
                 ((front_des_rx_c2 = '1' OR front_mon_rx_c2 = '1') and rx_encours2 = '1')) AND
                 (('0' & mux_divclk_c) <  ('0' & memmin_div)))  THEN
               -- Si on a un  front sur rx1 ou rx2, et que ce n'est pas le premier (i.e. on peut
               -- utiliser la valeur du compteur), Et si cette valeur est plus petite que la valeur
               -- m�moris�e
               memmin_div <= mux_divclk_c;   -- on met � jour avec le nouveau compteur
               cpt_car1 <= (others => '0');  -- on r�initialise les ompteurs de caract�res
               cpt_car2 <= (others => '0');
            ELSE
            -- En dehors des fronts, on compte les octets re�us
               IF (cpt_car1 = "1111111111") OR (cpt_car2 = "1111111111") THEN
                  -- Si on re�u 1023 caract�re sur une interface depuis la derni�re mise � jour
                  -- et que l'algo n'est pas fini
                  memmin_div <= (others => '1');   -- on recommence au d�part en prenant la valeur max
               ELSE
                  IF (val_rx1 = '1') THEN    -- on compte chaque carat�re re�u par le module de r�ception
                     cpt_car1 <= cpt_car1 + 1;
                  END IF;
                  IF (val_rx2 = '1') THEN
                     cpt_car2 <= cpt_car2 + 1;
                  END IF;
               END IF;
            END IF;
            IF (val_rx1 = '1') THEN
            -- Si on a re�u un caract�re sur RX1, on comtpe les fanions succesifs
               IF (dat_rx1 = x"7E" OR dat_rx1 = x"F9") THEN
               -- On teste les F9 aussi car une succession de 7E mal d�but�e peut �tre vu comme des F9
                  cpt_fanion1 <= cpt_fanion1 + 1;  
               ELSE
                  cpt_fanion1 <= (OTHERS => '0');
               END IF;
            END IF;
            IF (val_rx2 = '1') THEN
               IF (dat_rx2 = x"7E" OR dat_rx2 = x"F9") THEN
                  cpt_fanion2 <= cpt_fanion2 + 1;
               ELSE
                  cpt_fanion2 <= (OTHERS => '0');
               END IF;
            END IF;
            IF (eof1 = '1' AND l2_ok1 = '1') OR
               (eof2 = '1' AND l2_ok2 = '1') OR
               (cpt_fanion1 = "111") OR
               (cpt_fanion2 = "111") THEN
               -- On consid�re que l'algo a converg� lorsque une trame a �t� re�ue correcte (CRC compris)
               -- ou bien qu'on a re�u 7 fanions cons�cutifs
               baud_locked_buf <= '1';
               cpt_car1 <= (others => '0');
            END IF;
         ELSE
         -- Si on est en mode lock�
            IF ((val_rx1 = '1' AND dat_rx1 /= x"7E" AND dat_rx1 /= x"F9") OR  
                (val_rx2 = '1' AND dat_rx2 /= x"7E" AND dat_rx2 /= x"F9")) THEN
            -- Si on re�oit un caract�re diff�rent du fanion
               cpt_car1 <= cpt_car1 + 1;
               IF (cpt_car1 = "0111111111") THEN
               -- Si on a re�u 511 caract�res sans avoir vu un seule trame correcte
                  baud_locked_buf <= '0';          -- On r�initialise la recherche
                  memmin_div <= (others => '1');
                  cpt_car1 <= (others => '0');
                  cpt_car2 <= (others => '0');
                  cpt_fanion1 <= (OTHERS => '0');
                  cpt_fanion2 <= (OTHERS => '0');         
               END IF;
            ELSIF (eof1 = '1' AND l2_ok1 = '1') OR
                  (eof2 = '1' AND l2_ok2 = '1') THEN
            -- A chaque trame bonne d'un cot� ou de l'autre
               cpt_car1 <= (others => '0');  --on consid�re que l'algo est bon et on reste lock�
            END IF;
         END IF;
      END IF;
   END PROCESS;
   baud_locked <= baud_locked_buf;

   --------------------------------------------
   -- Retourne une valeur quantifi�e de diviseur d'horloge correspondant � la dur�e d'un bit
   -- en fonction de la mesure effectu�e
   -- Le process est optimis� pour freq_clk = 96MHz. Il faut modifier les comparaison si diff�rent
   --------------------------------------------
   selectbaud : PROCESS(clk_sys, rst_n)
   BEGIN
      IF (rst_n = '0') THEN
         tc_divclk <= CONV_STD_LOGIC_VECTOR(freq_clk*1000/50-1, tc_divclk'length);
      ELSIF (clk_sys'EVENT and clk_sys = '1') THEN
         IF (memmin_div(10) = '1') THEN
            -- Si la mesure est entre 1024 et 2047 clk_sys (nominal : 1920), on est � 50kbit/s
            tc_divclk <= CONV_STD_LOGIC_VECTOR(freq_clk*1000/50-1, tc_divclk'length);
         ELSIF (memmin_div(9) = '1') THEN
            -- Si la mesure est entre 512 et 1023 clk_sys (nominal : 960) , on est � 100kbit/s
            tc_divclk <= CONV_STD_LOGIC_VECTOR(freq_clk*1000/100-1, tc_divclk'length);
         ELSIF (memmin_div(8) = '1') THEN
            -- Si la mesure est entre 256 et 511 clk_sys (nominal : 480), on est � 200kbit/s
            tc_divclk <= CONV_STD_LOGIC_VECTOR(freq_clk*1000/200-1, tc_divclk'length);
         ELSIF (memmin_div(7) = '1') THEN
            -- Si la mesure est entre 128 et 255 clk_sys (nominal : 192), on est � 500kbit/s
            tc_divclk <= CONV_STD_LOGIC_VECTOR(freq_clk*1000/500-1, tc_divclk'length);
         ELSIF (memmin_div(6) = '1') THEN
            -- Si la mesure est entre 64 et 127 clk_sys (nominal : 96), on est � 1Mbit/s
            tc_divclk <= CONV_STD_LOGIC_VECTOR(freq_clk*1000/1000-1, tc_divclk'length);
         ELSIF (memmin_div(5) = '1') THEN
            -- Si la mesure est entre 32 et 63 clk_sys (nominal : 48), on est � 2Mbit/s
            tc_divclk <= CONV_STD_LOGIC_VECTOR(freq_clk*1000/2000-1, tc_divclk'length);
         ELSIF (memmin_div(4) = '1' OR 
                memmin_div(3 downto 2) = "11") THEN
            -- Si la mesure est entre 12 et 31 clk_sys (nominal : 16), on est � 6Mbit/s
            tc_divclk <= CONV_STD_LOGIC_VECTOR(freq_clk*1000/6000-1, tc_divclk'length);
         ELSE
            -- Si la mesure est entre 0 et 11 clk_sys (nominal : 8), on est � 12Mbit/s
            tc_divclk <= CONV_STD_LOGIC_VECTOR(freq_clk*1000/12000-1, tc_divclk'length);
         END IF;
      END IF;
   END PROCESS;

END rtl;

