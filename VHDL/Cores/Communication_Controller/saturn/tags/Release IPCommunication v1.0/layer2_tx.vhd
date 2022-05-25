--============================================================================= 
--  TITRE : LAYER2_TX
--  DESCRIPTION : 
--       Encapsule la trame applicative dans une trame Layer2
--       Ajoute les fanions de d�but et de fin, effectue le byte stuffing 
--       et calcule le CRC
--  FICHIER :        layer2_tx.vhd 
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

entity layer2_tx is
   PORT (
      -- Ports syst�me
      clk_sys  : IN  STD_LOGIC;                    -- Clock syst�me
      rst_n    : IN  STD_LOGIC;                    -- Reset g�n�ral syst�me

      -- Interfaces vers le module d'interface du PIC
      dat_in   : IN  STD_LOGIC_VECTOR(7 DOWNTO 0); -- Flux de donn�es applicatives � �mettre
                                                   -- La premi�re donn�e du flux qui suit le sof est l'@ de destination
      val_in   : IN  STD_LOGIC;                    -- validant du bus dat_in
      sof      : IN  STD_LOGIC;                    -- Indique le d�but d'une trame � �mettre (non synchrone de la 1�re donn�e)
      eof      : IN STD_LOGIC;                     -- Indique le dernier octet de la trame � �mettre
      datin_free: OUT  STD_LOGIC;                  -- Indique que le module layer2_tx est pr�t � recevoir 1 octet suivant

      -- Interfaces vers les FIFO de transmissions
      dat_out  : OUT  STD_LOGIC_VECTOR(7 downto 0);-- Flux de donn�es Layer2 � stocker dans les FIFO Tx
      val_out  : OUT  STD_LOGIC;                   -- Validant du bus dat_out
      clr_fifo : IN   STD_LOGIC;                   -- Signal de reset des FIFO Tx
      progfull1: IN   STD_LOGIC;                   -- Indique la FIFO Tx1 est presque pleine
      progfull2: IN   STD_LOGIC;                   -- Indique la FIFO Tx2 est presque pleine
      full1    : IN   STD_LOGIC;                   -- Indique la FIFO Tx1 est pleine
      empty1   : IN   STD_LOGIC;                   -- Indique la FIFO Tx1 est vide
      full2    : IN   STD_LOGIC;                   -- Indique la FIFO Tx2 est pleine
      empty2   : IN   STD_LOGIC                    -- Indique la FIFO Tx2 est vide
      );
end layer2_tx;

architecture  rtl of layer2_tx is
   SIGNAL   crc      : STD_LOGIC_VECTOR(15 downto 0); -- Valeur dynamique du crc
   SIGNAL   val_crc  : STD_LOGIC;                     -- Validant du CCRC
   SIGNAL   init_crc : STD_LOGIC;                     -- Initialise le calcul du CRC
   SIGNAL   dat_crc  : STD_LOGIC_VECTOR(7 DOWNTO 0);  -- Donn�e � prendre en compte pour le calcul du CRC
   SIGNAL   last_char: STD_LOGIC;                     -- Pour m�moriser le eof au cas ou il y'ait du stuffing sur le dernier char
   SIGNAL   empty1_r1, empty1_r2: STD_LOGIC;          -- Pour changer empty1 d'horloge
   SIGNAL   empty2_r1, empty2_r2: STD_LOGIC;          -- Pour changer empty2 d'horloge
   -- Machine d'�tat de gestion du module
   TYPE layer2_tx_type IS (idle_st, addest_st, data_st, fifo_full_st, stuf5E_st, stuf5D_st, 
                           waitcrc_st, crc1_st, stufcrc1_st, crc2_st, stufcrc2_st, fanionfin_st, waitendsend_st);
   SIGNAL fsm_layer2_tx       : layer2_tx_type;

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
   -- Machine d'�tat de g�n�ration du flux et d'�criture dans la FIFO Tx
   --       Les FIFO Tx font 512 octet mais leur 'prog_full' est cal� � 495 octets
   --       En testant le prog_full, on a donc toujours au moins 15 octets de libre
   --       On ne teste donc le prog_full que quand on �crit des don�es utiles de la trame
   --       Lorsqu'on �crit l'ent�te ou le CRC ou du stuffing, il n 'y a pas besoin de tester
   --       le niveau de remplissage
   --------------------------------------------
   -- La donn�e entrante est prise en compte que si on est dans l'�tat data_st ou addest_st
   -- Autrement dit, le module est dipos pour une nouvelle donn�e dans ces cas l�
   datin_free <= '1' WHEN (fsm_layer2_tx = data_st OR fsm_layer2_tx = addest_st) ELSE '0';
   man_fsm : PROCESS(clk_sys, rst_n)
   BEGIN
      IF (rst_n = '0') THEN
         fsm_layer2_tx <= idle_st;
         init_crc <= '1';
         val_crc <= '0';
         val_out <= '0';
         last_char <= '0';
         empty1_r1 <= '0';
         empty1_r2 <= '0';
         empty2_r1 <= '0';
         empty2_r2 <= '0';
         dat_out <= (others => '0');
         dat_crc <= (others => '0');

      ELSIF (clk_sys'EVENT and clk_sys = '1') THEN
         empty1_r1 <= empty1;       -- Changement d'horloge de empty1
         empty1_r2 <= empty1_r1;
         empty2_r1 <= empty2;       -- Changement d'horloge de empty2
         empty2_r2 <= empty2_r1;
         CASE fsm_layer2_tx IS
            WHEN idle_st =>
            -- Etat d'attente du signal sof
               IF (sof = '1' AND full1 = '0' AND full2 = '0' AND clr_fifo = '0') THEN
               -- Si on commence une trame et que le processus de clr est termin�
               -- Lors d'un reset de fifo, le flag full reste actif durant quelques cycle apr�s 
               -- le relachement du clr_fifo
                  dat_out <= x"7E";             -- On envoie le fanion de d�but 
                  init_crc <= '0';              -- On annule le reset du CRC
                  val_crc <= '0';               -- L'octet qu'on va sortir ne compte pas dans le calcul du crc
                  val_out <= '1';               -- On l'�crit dans la FIFO
                  fsm_layer2_tx <= addest_st;   -- On va g�n�rer l'octet de commande
               ELSE
               -- Si pas de d�but de trame
                  init_crc <= '1';              -- On initialise le CRC
                  val_crc <= '0';               -- On fait rien
                  val_out <= '0';
               END IF;
               
            WHEN addest_st =>
               IF (val_in = '1') THEN
               -- La premi�re donn�e de la trmae est l'@ destination. Elle ne peut pas �tre stuff�e car 7E et 7D sont interdites
                  val_out <= '1';            -- Quelle que soit la donn�e on la prend en compte dans le calcul du CRC
                  val_crc <= '1';            -- Elle compte dans le calcul du CRC
                  dat_out <= dat_in;         -- On la fournit � la FIFO
                  dat_crc <= dat_in;         -- On la forunit au CRC
                  fsm_layer2_tx <= data_st;  -- On va traiter l'octet suivant
               ELSE
               -- Tant qu'on recoit pas de donn�e
                  val_out <= '0';            -- Rien dans le FIFO
                  val_crc <= '0';            -- CRC inchang�
               END IF;
              
            WHEN data_st =>
            -- On attend une donn�e disponible sur le bus d'entr�e
               IF (val_in = '1') THEN
               -- Si il y'a une donn�e sur le bus
                  val_crc <= '1';            -- Quelle que soit la donn�e on la prend en compte dans le calcul du CRC
                  dat_crc <= dat_in;         
                  val_out <= '1';            -- Quelle que soit la donn�e on va �crire quelque chose dans la FIFO
                  IF (dat_in = x"7E") THEN
                     dat_out <= x"7D";          -- Si c'est un 7E il doit �tre remplac� par la s�quence 7D 5E
                     last_char <= eof;          -- On m�morise s'il s'agit du dernier char de la trame
                     fsm_layer2_tx <= stuf5E_st;-- On va ins�rer le code 5E dans le flux
                  ELSIF (dat_in = x"7D") THEN
                     dat_out <= x"7D";          -- Si c'est un 7D il doit �tre remplac� par la s�quence 7D 5D
                     last_char <= eof;          -- On m�morise s'il s'agit du dernier char de la trame
                     fsm_layer2_tx <= stuf5D_st;-- On va ins�rer le code 5D dans le flux
                  ELSE                          
                  -- Si c'est une donn�e normale
                     dat_out <= dat_in;         -- On la met dans le flux
                     IF (eof = '1') THEN        -- Si c'est la derni�re donn�e de la trame
                        fsm_layer2_tx <= waitcrc_st;  -- On va attendre que le CRC soit pr�t
                     ELSIF (progfull1 = '1' OR progfull2 = '1') THEN
                     -- Si une des 2 FIFO en �criture est presque pleine
                        fsm_layer2_tx <= fifo_full_st;   -- On va attendre
                     END IF;
                  END IF;
               ELSE
               -- Si il n'y a pas de nouvelle donn�e sur le bus
                  val_crc <= '0';               -- On fait rien
                  val_out <= '0';
               END IF;

            WHEN fifo_full_st =>
            -- Etat d'attente qu'il y'ait de la place dans les FIFO en �criture
               val_crc <= '0';               -- On fait rien
               val_out <= '0';
               IF (progfull1 = '0' AND progfull2 = '0') THEN
               -- On attend que les 2 FIFO ne soient plus pleines
                  fsm_layer2_tx <= data_st;
               END IF;
               
                   
            WHEN stuf5E_st =>
            -- Etat d'insertion du char 5E dans le flux
               dat_out <= x"5E";
               val_crc <= '0';                  -- Le CRC ne doit pa s�tre mis � jour avec l'octet de bourrage
               val_out <= '1';                  -- On l'�crit dans la FIFO
               IF (last_char = '1') THEN        -- Si c'�tait le dernier octet, on va ins�rer le CRC 
                  fsm_layer2_tx <= crc1_st;
               ELSE
                  fsm_layer2_tx <= data_st;
               END IF;

            WHEN stuf5D_st =>
            -- Etat d'insertion du char 5D dans le flux
               dat_out <= x"5D";                
               val_crc <= '0';                  -- Le CRC ne doit pa s�tre mis � jour avec l'octet de bourrage
               val_out <= '1';                  -- On l'�crit dans la FIFO
               IF (last_char = '1') THEN        -- Si c'�tait le dernier octet, on va ins�rer le CRC
                  fsm_layer2_tx <= crc1_st;
               ELSE
                  fsm_layer2_tx <= data_st;
               END IF;

            WHEN waitcrc_st =>
            -- On attend un cycle que le CRC soit � jour avec la derni�re donn�e
               val_crc <= '0';
               val_out <= '0';
               fsm_layer2_tx <= crc1_st;        -- On va traiter les 8 MSB du CRC

            WHEN crc1_st =>
            -- Etat de traitement des 8 MSB du CRC
               val_crc <= '0';                  -- On doit pas modifier le CRC
               val_out <= '1';                  -- On va �crire une donn�e en FIFO
               IF (crc(15 downto 8) = x"7E" OR crc(15 downto 8) = x"7D") THEN
               -- Si les 8 MSB sont une donn�e � stuffer
                  dat_out <= x"7D";             -- On �crit le code de stuffing
                  fsm_layer2_tx <= stufcrc1_st; -- On va traiter le stuf
               ELSE
               -- Si les 8 MSB ne sont pas � stuffer
                  dat_out <= crc(15 downto 8);  -- On les met tel quel dans le flux
                  fsm_layer2_tx <= crc2_st;     -- On va traiter les 8 LSB du CRC
               END IF;

            WHEN stufcrc1_st =>
            -- Etat de gestion du stuffing des 8 MSB du CRC
               val_crc <= '0';
               val_out <= '1';
               IF (crc(15 downto 8) = x"7E") THEN
               -- Selon la valeur � stuffer
                  dat_out <= x"5E";             -- On envoie le bon code
               ELSE
                  dat_out <= x"5D";
               END IF;
               fsm_layer2_tx <= crc2_st;        -- On va traiter les 8 LSB du CRC 

            WHEN crc2_st =>
            -- Etat de traitement des 8 LSB du CRC
               val_crc <= '0';
               val_out <= '1';
               IF (crc(7 downto 0) = x"7E" OR crc(7 downto 0) = x"7D") THEN
               -- Si les 8 LSB sont une donn�e � stuffer
                  dat_out <= x"7D";
                  fsm_layer2_tx <= stufcrc2_st;
               ELSE
               -- Si les 8 MSB ne sont pas � stuffer
                  dat_out <= crc(7 downto 0);
                  fsm_layer2_tx <= fanionfin_st;   -- On va ins�rer le fanion de fin dans le flux
               END IF;

            WHEN stufcrc2_st =>
            -- Etat de gestion du stuffing des 8 LSB du CRC
               val_crc <= '0';
               val_out <= '1';
               IF (crc(7 downto 0) = x"7E") THEN
                  dat_out <= x"5E";
               ELSE
                  dat_out <= x"5D";
               END IF;
               fsm_layer2_tx <= fanionfin_st;

            WHEN fanionfin_st =>
            -- On envoie le fanion de fin
               dat_out <= x"7E";
               val_crc <= '0';
               init_crc <= '1';
               val_out <= '1';
               fsm_layer2_tx <= waitendsend_st; -- On va attendre la fin des transmission
               
            WHEN waitendsend_st =>
               -- Etat d'attente que la trame soit partie. Permet de laisser le temps au r�seau priv� de 
               -- reprendre la main sur le Tx
               val_out <= '0';
               IF (empty1_r2 = '1' AND empty2_r2 = '1') THEN
               -- Si les 2 FIFO Tx sont vides
                  fsm_layer2_tx <= idle_st;
               END IF;

            WHEN OTHERS =>
               fsm_layer2_tx <= idle_st;
               
         END CASE;
      END IF;
   END PROCESS;

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
		data => dat_crc,         -- Dans le calcul du CRC, on prend en compte le flux d�stuff�
		val => val_crc,
		init => init_crc,
		crc => crc
	);
   
end rtl;

