--============================================================================= 
--  TITRE : LAYER2_RX
--  DESCRIPTION : 
--       Analyse les trames re�ues sur le port rx
--       D�capsule la partie Layer 2 et calcule le CRC
--       Note : les fanions, et l'adresse TID ne sont pas envoy�es
--       dans le flux de sortie mais le CRC oui
--       Limitation : Il faut au moins 1 pulse de clk_sys au niveau '0' entre 2 
--       pulses de clk_sys � 1 du validant de donn�e entrante val_in

--  FICHIER :        layer2_rx.vhd 
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

entity layer2_rx is
   GENERIC (
      nbbit_div : INTEGER := 10);   -- Nombre de bits pour coder le diviseur d'horloge 
   PORT (
      -- Ports syst�me
      clk_sys  : IN  STD_LOGIC;                    -- Clock syst�me
      rst_n    : IN  STD_LOGIC;                    -- Reset g�n�ral syst�me
      ad_mio   : IN  STD_LOGIC_VECTOR(7 DOWNTO 0); -- Adresse logique du MIO (TID)

      -- Interfaces ves le module SWITCH
      sw_ena   : OUT  STD_LOGIC;                   -- Indique qu'on est entre 2 trames (autorise le switch du tx)
      dat_in   : IN  STD_LOGIC_VECTOR(7 DOWNTO 0); -- Donn�e parall�lis�e re�ue sur port rx
      val_in   : IN  STD_LOGIC;                    -- validant du bus dat_in
      tc_divclk: IN  STD_LOGIC_VECTOR (nbbit_div-1 DOWNTO 0);  -- Diviseur d'horloge pour la dur�e d'un bit s�rie
      
      -- Interfaces vers le module FRAME_STORE
      sof      : OUT  STD_LOGIC;                   -- Indique au module suivant le d�but d'une trame en r�ception
      eof      : OUT  STD_LOGIC;                   -- Indique au module suivant la fin d'une trame en r�ception
      l2_ok    : OUT  STD_LOGIC;                   -- Indique que la trame re�ue est correcte d'un point de vue layer 2
      dat_out  : OUT  STD_LOGIC_VECTOR(7 downto 0);-- Donn�es de la couche applicative (�pur�e de la couche layer 2)
      val_out  : OUT  STD_LOGIC                    -- Validant du bus dat_out
      );
end layer2_rx;

architecture  rtl of layer2_rx is
   -- Buffer prenant la valeur du flux de sortie
   SIGNAL   dat_out_buf: STD_LOGIC_VECTOR(7 downto 0);

   -- Timer de r�ception entre 2 mots re�us. Le compteur doit pouvoir mesurer 16 bits. 
   -- La dur�e de 1 bit est cod� sur nbbit_div
   SIGNAL   cpt_timer: STD_LOGIC_VECTOR(nbbit_div+4-1 DOWNTO 0);  
   SIGNAL   timeout  : STD_LOGIC;                  -- Indique que la timer s'est �coul�
   
   SIGNAL   fanion_recu : STD_LOGIC;                  -- A 1 pour m�moriser qu'on a re�u un fanion
   SIGNAL   rec_encours : STD_LOGIC;                  -- A 1 pour indiquer qu'une trame est en cours d'analyse          
   SIGNAL   crc      : STD_LOGIC_VECTOR(15 downto 0); -- Valeur dynamique du crc
   SIGNAL   val_crc  : STD_LOGIC;                     -- Validant pour mettre � jour le CCRC
   SIGNAL   init_crc : STD_LOGIC;                     -- Initialise le calcul du CRC

   SIGNAL   cpt_byt  : STD_LOGIC_VECTOR(1 downto 0);  -- Pour comtper les premiers octets re�us dans la trame
   SIGNAL   adest_ok : STD_LOGIC;                     -- A 1 lorsque la trame s'adresse � ce MIO
   
   -- Machine d'�tat de gestion du module
   TYPE layer2_rx_type IS (idle_st, rec_st, destuf_st, endnok_st, endok_st, newdat_st);
   SIGNAL fsm_layer2_rx       : layer2_rx_type;

   -- Module de calcul du CRC16
	COMPONENT crc16
   GENERIC (
      poly : STD_LOGIC_VECTOR(15 downto 0) := x"1021"   -- CCITT16 par d�faut
      );
	PORT(
		clk_sys  : IN std_logic;
		rst_n    : IN std_logic;
		data     : IN std_logic_vector(7 downto 0);
		val      : IN std_logic;
		init     : IN std_logic;          
		crc      : OUT std_logic_vector(15 downto 0)
		);
	END COMPONENT;
   
BEGIN
   --------------------------------------------
   -- Timer entre la r�ception de 2 mots cons�cutifs
   --------------------------------------------
   timer : PROCESS(clk_sys, rst_n)
   BEGIN
      IF (rst_n = '0') THEN
         cpt_timer <= (others => '0');
         timeout <= '0';
      ELSIF (clk_sys'EVENT and clk_sys = '1') THEN
         IF (val_in = '1') THEN
         -- Pour chaque mot re�u
            cpt_timer <= (others => '0');
            timeout <= '0';
         ELSE
         -- Entre 2 mots re�us
            cpt_timer <= cpt_timer + 1;      -- On compte les clk_sys �coul�s
            IF (cpt_timer = (tc_divclk & "0000")) THEN
            -- Lorsque le comtpeur a mesur� un temps �quivalent � 16 bits
               timeout <= '1';               -- On d�clare un timeout (la trame en cours de r�ception doit �tre annum�e)
            END IF;
         END IF;
      END IF;
   END PROCESS;

   --------------------------------------------
   -- Machine d'�tat d'analyse du flux
   --------------------------------------------
   -- Le d�clenchement du timeout annule la r�ception d'une trame 
   man_fsm : PROCESS(clk_sys, rst_n)
   BEGIN
      IF (rst_n = '0') THEN
         fsm_layer2_rx <= idle_st;
         init_crc <= '1';
         val_crc <= '0';
         val_out <= '0';
         cpt_byt <= "00";
         eof <= '0';
         sof <= '0';           
         l2_ok <= '0';
         adest_ok <= '0';
         rec_encours <= '0';
         dat_out_buf <= (others => '0');

      ELSIF (clk_sys'EVENT and clk_sys = '1') THEN
         CASE fsm_layer2_rx IS
            WHEN idle_st =>
            -- Etat transitoire de remise � 0
               init_crc <= '1';
               val_crc <= '0';
               val_out <= '0';
               cpt_byt <= "00";
               eof <= '0';
               sof <= '0';           
               l2_ok <= '0';
               adest_ok <= '0';
               rec_encours <= '0';
               fanion_recu <= '0';
               fsm_layer2_rx <= rec_st;
               
            WHEN rec_st =>
            -- Etat d'attente des caract�res
               val_out <= '0';            -- On s'assure que les validants ne dure qu'1 pulse
               sof <= '0';                
               val_crc <= '0';
               init_crc <= '0';
               IF (val_in = '1') THEN
               -- Sur chaque donn�e re�ue
                  IF (dat_in = x"7E") THEN
                  -- Si on a re�u un fanion
                     fanion_recu <= '1';        -- On m�morise le fait d'avori re�u un fanion
                     IF (rec_encours = '1') THEN
                     -- Si on re�oit un fanion et qu'on est en r�ception de trame, alors c'est le fanion de fin de trame
                        IF (crc(15 downto 0) = x"470F") THEN
                        -- Si le crc est �gal au magic number, on valide la trame
                           fsm_layer2_rx <= endok_st;
                        ELSE
                        -- Sinon on annule la trame
                           fsm_layer2_rx <= endnok_st;
                        END IF;
                     -- Tant qu'on a re�u aucun octet, on ne consid�re pas les fanions
                     END IF;
                  ELSIF (fanion_recu = '1') THEN
                  -- Si on recoit une donn�e autre qu'un fanion et qu'on a d�j� re�u un fanion, c'est une donn�e utile
                     rec_encours <= '1';              -- On est au milieu d'une trame
                     IF (dat_in = x"7D") THEN
                     -- Si c'est un mot de bourage, on va attendre le mot suivant
                        fsm_layer2_rx <= destuf_st;
                     ELSE
                     -- Si c'est une donn�e normale, on la traite
                        dat_out_buf <= dat_in;     -- On m�morise la donn�e � traiter pour l'�tat suivant
                        fsm_layer2_rx <= newdat_st;
                     END IF;
                  END IF;
               ELSIF (timeout = '1') THEN
               -- S'il s'est �coul� plus de 16 bits depuis le dernier mot re�u
                  IF (rec_encours = '1') THEN
                  -- Si on �tait en cours de r�ception de trame
                     fsm_layer2_rx <= endnok_st;      -- On va traiter une erreur
                  ELSIF (fanion_recu = '1') THEN
                  -- Si on avait juste re�u des fanions, 
                     fsm_layer2_rx <= idle_st;        -- On r�init la machine
                  END IF;
                  -- Si ona rien re�u, on reste dans cet �tat
               END IF;
                  
            WHEN newdat_st =>
            -- Etat de traitement d'un nouveau caract�re re�u (hors Fanion)
               IF (timeout = '1') THEN
               -- En cas de timeout ici on va g�rer l'erreur
                  fsm_layer2_rx <= endnok_st;
               ELSE
                  fsm_layer2_rx <= rec_st;     -- Quand on aura fini de traiter on ira attendre le mot suivant
                  val_crc <= '1';              -- La valeur re�ues doit �tre prise en comtpe dans le CRC
                  val_out <= adest_ok;         -- On n'envoie pas l'@. On n'envoie rien si le MIO n'est pas concern�

                  IF (cpt_byt = "01") THEN     -- On n'envoie au module suivant que le flux � partir du 2 �me octet
                     sof <= adest_ok;          -- Le premier octet indique �galement le d�but de trame au module suivant
                  END IF;
                  IF (cpt_byt /= "10") THEN
                  -- On ne compte que les 2 premiers octets
                     cpt_byt <= cpt_byt + 1;
                  END IF;
                  IF (cpt_byt = "00") THEN     -- Le premier octet indique l'adresse de destination de la trame
                     IF ((dat_out_buf = ad_mio) OR (dat_out_buf = x"90") OR (dat_out_buf = x"FF")) THEN
                     -- Le MIO peut �tre adress� directement (ad_mio) ou bien en multicast (90h ou FFh)
                        adest_ok <= '1';
                     ELSE
                        adest_ok <=  '0';
                     END IF;
                  END IF;
               END IF;

            WHEN destuf_st =>
            -- Etat de gestion du destuffing. On a re�u un carat�re 7Dh
               IF (timeout = '1') THEN
                  fsm_layer2_rx <= endnok_st;
               ELSE
                  IF (val_in = '1') THEN
                  -- On attend le caract�re suivant. On fonction du stuffing on fourni la bonne donn�e
                     IF (dat_in = x"5E") THEN
                     -- Si l'octet de stfuffing est 5E
                        dat_out_buf <= x"7E";         -- La donn�e utile est 7E
                        fsm_layer2_rx <= newdat_st;   -- On va la traiter
                     ELSIF (dat_in = x"5D") THEN
                     -- Si l'octet de stfuffing est 5E
                        dat_out_buf <= x"7D";         -- La donn�e utile est 7D
                        fsm_layer2_rx <= newdat_st;   -- On va la traiter
                     ELSE
                     -- Si le stuffing est ni 5E ni 5D, c'est un cas d'erreur
                        fsm_layer2_rx <= endnok_st;
                     END IF;
                  END IF;
               END IF;

            WHEN endnok_st =>
            -- Cas de r�ception d'une mauvaise trame
               eof <= '1';          -- On indique la fin de r�ception au module suivant pour que l'information trame erron�e soit
                                    -- report�e pour comptage
               l2_ok <= '0';        -- On indique qu'il y'a eu un probl�me
               rec_encours <= '0';  -- On est plus en r�ception de trame
               fanion_recu <= '0';
               fsm_layer2_rx <= idle_st;

            WHEN endok_st =>
            -- Cas de r�ception d'une bonne trame
               eof <= '1';          -- On indique la fin de r�ception (l'information bonne trame est
                                    -- aussi utilis�e pour v�rouiller l'autobaudrate)
               l2_ok <= '1';        -- On indique que la trame est bonne
               rec_encours <= '0';  -- On est plus en r�ception de trame
               fanion_recu <= '0';
               fsm_layer2_rx <= idle_st;
   
            WHEN OTHERS =>
               fsm_layer2_rx <= idle_st;
         END CASE;
      END IF;
   END PROCESS;
   dat_out <= dat_out_buf;       -- Flux de donn�es d�stuff� vers le module suivant
   sw_ena <=  NOT(rec_encours OR fanion_recu);   -- Le switch est autoris� entre 2 trames (i.e. lorsqu'une r�ception n'est pas en cours)

   --------------------------------------------
   -- Calcul du crc16
   --------------------------------------------
	inst_crc16: crc16
   GENERIC MAP (
      poly => x"1021"   -- CCITT16
      )
   PORT MAP(
		clk_sys => clk_sys,
		rst_n => rst_n,
		data => dat_out_buf,
		val => val_crc,
		init => init_crc,
		crc => crc
	);
   
end rtl;

