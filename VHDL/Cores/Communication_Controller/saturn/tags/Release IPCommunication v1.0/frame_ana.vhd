--============================================================================= 
--  TITRE : FRAME_ANA
--  DESCRIPTION : 
--       Analyse la couche applicative des trames re�ues sur dat_in
--       Stocke les donn�es utiles � l'ex�cution de la commande dans une DPRAM
--       Si la trame est mauvaise, le pointeur d'�criture dans la DPRAM est 
--       ramen� � sa position initiale 

--  FICHIER :        frame_ana.vhd 
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

entity frame_ana is
   PORT (
      -- Ports syst�me
      clk_sys  : IN  STD_LOGIC;                    -- Clock syst�me
      rst_n    : IN  STD_LOGIC;                    -- Reset g�nr�l syst�me
      ad_mio   : IN  STD_LOGIC_VECTOR(7 DOWNTO 0); -- Adress logique du MIO
      -- Interfaces vers le le module LAYER2_RX

      sof      : IN  STD_LOGIC;                   -- Indique le d�but d'une trame en r�ception sur dat_in
      eof      : IN  STD_LOGIC;                   -- Indique la fin d'une trame en r�ception sur dat_in
      l2_ok    : IN  STD_LOGIC;                   -- Indique que la trame re�ue est correcte d'un point de vue layer 2
      dat_in   : IN  STD_LOGIC_VECTOR(7 downto 0);-- Donn�es de la couche applicative (�pur�e de la couche layer 2)
      val_in   : IN  STD_LOGIC;                   -- Validant du bus dat_in

      -- Interfaces vers le module COM_EXEC
      dat_out  : OUT STD_LOGIC_VECTOR(7 DOWNTO 0); -- Donn�es utiles de la couche applicative (commande, @, data)
      soc_out  : OUT STD_LOGIC;                    -- Indique que l'octet sur dat_out est le 1e d'une commande
      rd_datout: IN  STD_LOGIC;                    -- Signal de lecture d'un nouvel octet applicatif
      new_frame: OUT STD_LOGIC;                    -- Indique qu'une nouvelle trame est disponible
      com_dispo: OUT STD_LOGIC;                    -- Inidque qu'il y'a des donn�es de commande � traiter dans la DPRAM
      l7_ok    : OUT STD_LOGIC;                    -- Indique que la nouvelle trame est conforme du point de vue layer 7
      overflow : OUT STD_LOGIC                     -- Indique un overflow du buffer de stockage des commandes
      );
end frame_ana;

architecture  rtl of frame_ana is
   CONSTANT typ_sec  : STD_LOGIC_VECTOR(1 downto 0) := "00";   -- D�finition des codes du champ TYP
   CONSTANT typ_nosec: STD_LOGIC_VECTOR(1 downto 0) := "01";
   CONSTANT typ_sync : STD_LOGIC_VECTOR(1 downto 0) := "10";
   CONSTANT typ_sup  : STD_LOGIC_VECTOR(1 downto 0) := "11";
   CONSTANT rep_read : STD_LOGIC_VECTOR(1 downto 0) := "00";   -- D�finition des codes du champ COM
   CONSTANT com_write: STD_LOGIC_VECTOR(1 downto 0) := "01";
   CONSTANT com_read : STD_LOGIC_VECTOR(1 downto 0) := "10";
   CONSTANT com_rdwr : STD_LOGIC_VECTOR(1 downto 0) := "11";   
   
   SIGNAL   adread   : STD_LOGIC_VECTOR(9 DOWNTO 0);  -- Signal d'adresse pour la lecture
   SIGNAL   cpt_adread: STD_LOGIC_VECTOR(9 DOWNTO 0); -- Compteur d'adresse pour la lecture
   SIGNAL   adwrite  : STD_LOGIC_VECTOR(9 DOWNTO 0);  -- Compteur d'adresse dynamique pour l'�criture
   SIGNAL   old_adw  : STD_LOGIC_VECTOR(9 DOWNTO 0);  -- Pour m�moriser la premi�re location vide dans la DPRAM
   SIGNAL   cpt_byte : STD_LOGIC_VECTOR(7 DOWNTO 0);  -- Compteur d'octets en r�ception 
   SIGNAL   wea      : STD_LOGIC_VECTOR(0 DOWNTO 0);  -- Pour transformer le signal d'�criture dans la DPRAM en VECTOR
   SIGNAL   dpram_dw : STD_LOGIC_VECTOR(8 DOWNTO 0);  -- Pour fabriquer le vecteur d'�criture dans la DPRAM
   SIGNAL   dpram_dr : STD_LOGIC_VECTOR(8 DOWNTO 0);  -- Pour fabriquer le vecteur de lecutre dans la DPRAM

   SIGNAL   soc_wr    : STD_LOGIC;                    -- Indique le 1er octet d'une commande
   SIGNAL   type_field: STD_LOGIC_VECTOR(1 downto 0); -- Pour m�moriser le type de la trame
   SIGNAL   com_field : STD_LOGIC_VECTOR(1 downto 0); -- Pour m�moriser le champ com
   SIGNAL   crc       : STD_LOGIC_VECTOR(15 downto 0);-- Valeur dynamique du crc
   SIGNAL   init_crc  : STD_LOGIC;                    -- Initialise le calcul du CRC
   SIGNAL   overflow_buf  : STD_LOGIc;                    -- Indique que le buffer de stockage des commandes a d�bord�

   -- Machine d'�tat de gestion du module
   TYPE layer7_type IS (idle_st, rectyp_st, destination_st, source_st, adrw_st, nrw_st,  
                        dataw_st, crc1_st, crc2_st, crccheck_st, endok_st, endnok_st, abort_st);
   SIGNAL fsm_layer7      : layer7_type;

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
   
   COMPONENT dpram
   PORT (
      clka     : IN STD_LOGIC;
      wea      : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
      addra    : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
      dina     : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
      clkb     : IN STD_LOGIC;
      addrb    : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
      doutb    : OUT STD_LOGIC_VECTOR(8 DOWNTO 0)
   );
   END COMPONENT;   
   
begin
   --------------------------------------------
   -- Gestion du comtpeur d'adresse en lecture
   --------------------------------------------
   cptr : PROCESS(clk_sys, rst_n)
   BEGIN
      IF (rst_n = '0') THEN
         cpt_adread <= (others => '0');
      ELSIF (clk_sys'EVENT and clk_sys = '1') THEN
         IF (rd_datout = '1') THEN
            cpt_adread <= cpt_adread + 1;
         END IF;
      END IF;
   END PROCESS;
   -- Permet d'avoir un fonctionnement style FWFT avec un seul cycle entre le rd et la donn�e
   adread <= cpt_adread WHEN (rd_datout = '0') ELSE cpt_adread+1;
   -- Si le pointeur en lecture est diff�rent du pointeur en �criture, on indique qu'il 
   -- y'a des donn�es � traiter
   com_dispo <= '0' WHEN (adread = old_adw) ELSE '1';
   -- On consid�re un overflow du buffer de stockage des commandes lorsque le pointeur de write a presque
   -- rattrap� le pointeur de read
   overflow_buf <= '1' WHEN (adwrite = cpt_adread-2) AND (wea(0) = '1') ELSE '0';
   overflow <= overflow_buf;
   
   --------------------------------------------
   -- Machine d'�tat d'analyse du flux
   --------------------------------------------
   man_fsm : PROCESS(clk_sys, rst_n)
   BEGIN
      IF (rst_n = '0') THEN
         old_adw <= (others => '0');
         adwrite <= (others => '0');
         fsm_layer7 <= idle_st;
         soc_wr <= '0';
         l7_ok <= '0';
         new_frame <= '0';
      ELSIF (clk_sys'EVENT and clk_sys = '1') THEN
         CASE fsm_layer7 IS
            WHEN idle_st =>
            -- Etat transitoire d'initialisation de l'algo de traitement
               init_crc <= '1';     -- R�init du calcul du CRC
               old_adw <= adwrite;  -- Le pointeur d'�criture dynamique est initialis� avec la premi�re location vide
               l7_ok <= '0';
               new_frame <= '0';
               fsm_layer7 <= rectyp_st;
               soc_wr <= '1';       -- Si on est ici, le prochain octet sera le premier de la commande
               
            WHEN rectyp_st =>
            -- Etat d'attente du 1er octet de la couche applicative
               init_crc <= '0';
               type_field <= dat_in(7 downto 6);   -- M�morise le type de trame
               com_field <= dat_in(5 downto 4);    -- M�morise la partie com
               -- DRA le 17/10/2012 : suppression du code qui provoquait des d�claration de trame erron�e 
               -- sur r�ception d'une trame correcte mais non destin�e � ce MIO
               -- Le code a peut d'int�r�t car la condition recevoir un eof avant de recevoir le sof n'est possible qu'en
               -- cas de plantage du FPGA
--               IF (eof = '1') THEN
--               -- Si on re�oit la fin de trame maintenant, c'est qu'il y a un probl�me
--                  fsm_layer7 <= abort_st;   
--               ELS
               IF (overflow_buf = '1') THEN
                  fsm_layer7 <= endnok_st;
               ELSIF (val_in = '1') THEN
               -- Si un octet est pr�t � �tre trait�
                  IF (sof = '1') THEN              
                  -- Si c'est bien le 1er octet de la trame
                     soc_wr <= '0';                   -- le prochain octet ne devra pas �tre tagg� comme �tant le premeir de la commadne
                     adwrite <= adwrite + 1;          -- on le garde (i.e on augemente le pointeur d'�criture
                     CASE dat_in(7 downto 6) IS
                        WHEN typ_sup =>
                        -- Si c'est une trame de supervision
                           IF (dat_in(5 downto 4) = "00") THEN
                           -- Si le champ COM est bien � 00
                              fsm_layer7 <= source_st;   -- Le prochain octet sera l'@ source
                           ELSE
                           -- Si le champ COM n'est pas "00", c'est qu'il y'a une erreur
                              fsm_layer7 <= endnok_st;
                           END IF;
                        
                        WHEN typ_sec =>
                        -- Si c'est une trame de s�curit�
                           IF (dat_in(5 downto 4) /= rep_read) THEN
                           -- Le champ COM ne peut pas �tre � rep_read
                              fsm_layer7 <= destination_st; -- Le prochain octet sera l'@ destination
                           ELSE
                           -- Si le champ COM est rep_read, c'est qu'il y'a une erreur
                              fsm_layer7 <= endnok_st;
                           END IF;

                        WHEN typ_nosec =>
                        -- Si c'est une trame non s�curitaire
                           IF (dat_in(5 downto 4) /= rep_read) THEN
                           -- Le champ COM ne peut pas �tre � rep_read
                              fsm_layer7 <= source_st;      -- Le prochain octet sera l'@ source
                           ELSE
                           -- Si le champ COM est rep_read, c'est qu'il y'a une erreur
                              fsm_layer7 <= endnok_st;
                           END IF;

                        WHEN typ_sync =>
                        -- Si c'est une trame de synchronisation
                           IF (dat_in(5 downto 4) = "10") THEN
                           -- Si le champ COM est bien � 10
                              fsm_layer7 <= source_st;      -- Le prochain octet sera l'@ source
                           ELSE
                           -- Si le champ COM n'est pas "10", c'est qu'il y'a une erreur
                              fsm_layer7 <= endnok_st;
                           END IF;

                        WHEN OTHERS =>
                           NULL;
                     END CASE;
                  END IF;
               END IF;

            WHEN destination_st =>
            -- Etat d'attente de l'octet @ de destination. La destination n'est pas m�moris�e dans la DPRAM
            -- (i.e le pointeur n'est pas incr�ment�)
               IF (eof = '1') THEN
               -- Si on re�oit la fin de trame maintenant, c'est qu'il y a un probl�me
                  fsm_layer7 <= abort_st;   
               ELSIF (overflow_buf = '1') THEN
                  fsm_layer7 <= endnok_st;
               ELSE
                  IF (val_in = '1') THEN
                     IF (dat_in = ad_mio) OR (dat_in = x"80") OR (dat_in = x"FF") THEN
                     -- Si l'@ destination d�signe bien le MIO
                        fsm_layer7 <= source_st;   -- Le prochain octet sera l'@ source
                     ELSE
                     -- Si l'adresse destination ne d�signe pas le MIO c'est qu'il y'a un probl�me 
                     -- car la trame a d�j� �t� filtr� par le module layer2
                        fsm_layer7 <= endnok_st;
                     END IF;
                  END IF;
               END IF;

            WHEN source_st =>
            -- Etat d'attente de l'octet @ source.
               -- Par d�faut le compteur est initialis� � 9 des fois que la trame soit une trame de supervision
               cpt_byte <= CONV_STD_LOGIC_VECTOR(9, cpt_byte'length);
               IF (eof = '1') THEN
               -- Si on re�oit la fin de trame maintenant, c'est qu'il y a un probl�me
                  fsm_layer7 <= abort_st;   
               ELSIF (overflow_buf = '1') THEN
                  fsm_layer7 <= endnok_st;
               ELSE
                  IF (val_in = '1') THEN
                     adwrite <= adwrite + 1; -- L'adresse source est m�moris�e dans la DPRAM
                     IF (dat_in = x"81" OR dat_in = x"82") THEN
                     -- Si la source est bien un des 2 concentrateurs
                        CASE type_field IS
                        -- Selon le type de la trame
                           WHEN typ_sec | typ_nosec =>
                           -- Si c'est une trame de commande (s�curitaire ou non) 
                              fsm_layer7 <= adrw_st;   -- Le prochain octet sera une adresse de lecture ou d'�criture
                           WHEN typ_sync =>
                           -- Si c'est une trame de synchronisation
                              fsm_layer7 <= endok_st; -- LA trame doit �tre finie
                           WHEN typ_sup =>
                           -- Si c'est une trame de supervision
                              fsm_layer7 <= dataw_st; -- On va recevoir les 9 octets correspondant 
                           WHEN OTHERS =>
                              NULL;
                        END CASE;
                     ELSE
                     -- Si la source n'est pas un des 2 concentrateurs
                        fsm_layer7 <= endnok_st;      -- Il y'a un probl�me
                     END IF;
                  END IF;
               END IF;
               
            WHEN adrw_st =>
            -- Etat d'attente de l'adresse de lecture ou d'�criture de la commande
               IF (eof = '1') THEN
               -- Si on re�oit la fin de trame maintenant, c'est qu'il y a un probl�me
                  fsm_layer7 <= abort_st;   
               ELSIF (overflow_buf = '1') THEN
                  fsm_layer7 <= endnok_st;
               ELSE
                  IF (val_in = '1') THEN
                     adwrite <= adwrite + 1; -- Cette adresse est m�moris�e dans la DPRAM
                     fsm_layer7 <= nrw_st;   -- Le prochain octet sera un champ longeur
                  END IF;
               END IF;

            WHEN nrw_st =>
            -- Etat d'attente du champ qui code la longueur des donn�es
               IF (eof = '1') THEN
               -- Si on re�oit la fin de trame maintenant, c'est qu'il y a un probl�me
                  fsm_layer7 <= abort_st;   
               ELSIF (overflow_buf = '1') THEN
                  fsm_layer7 <= endnok_st;
               ELSE
                  IF (val_in = '1') THEN
                     adwrite <= adwrite + 1;    -- Le champ longeur est m�moris� dans la DPRAM
                     -- On r�cup�re le nombre de data utiles (ce champ n'est utilis� que pour des trames d'�criture
                     cpt_byte <= dat_in;         
--                     IF (com_field = com_write AND dat_in = x"00") THEN
                     IF (dat_in = x"00") THEN
                     -- Si le champ actuel est un Nw (ie. un  nombre d'octets � �crire) et que ce champ vaut 0
                        fsm_layer7 <= endnok_st;    -- La trame a un mauvais format
                     ELSE
                        IF (type_field = typ_sec AND com_field = com_read) THEN
                        -- Si c'est une commande de lecture dans une trame de s�curit�
                           fsm_layer7 <= crc1_st;  -- Les champs suivants seront le CRC
                        ELSIF (type_field = typ_nosec AND com_field = com_read) THEN
                        -- Si c'est une commande de lecture dans une trame non s�curitaire
                           fsm_layer7 <= endok_st; -- La trame est finie
                        ELSIF (com_field = com_rdwr) THEN 
                        -- Si c'est une commande en lecture/�criture
                           fsm_layer7 <= adrw_st;   -- Le prochain octet sera une adresse d'�criture
                           com_field <= com_write;  -- On force le champ COM en �criture pour pas rester dansune boucle infini
                        ELSE
                        -- Si c'est une commande d'�criture ou de lecture/�criture
                           fsm_layer7 <= dataw_st; -- Il y'a d'autres octets � r�ceptionner
                        END IF;
                     END IF;
                  END IF;
               END IF;

            WHEN dataw_st =>
            -- Etat de r�ception des octets d'une trame d'�criture, d'�criture lecture ou d'une trame de supervision
            -- de configuration de l'adresse MAC
               IF (eof = '1') THEN
               -- Si on re�oit la fin de trame maintenant, c'est qu'il y a un probl�me
                  fsm_layer7 <= abort_st;   
               ELSIF (overflow_buf = '1') THEN
                  fsm_layer7 <= endnok_st;
               ELSE
                  IF (val_in = '1') THEN
                     cpt_byte <= cpt_byte - 1;     -- On d�compte chaque octet re�u
                     adwrite <= adwrite + 1;       -- chaque octet est m�moris� dans la DPRAM
                     IF (cpt_byte = CONV_STD_LOGIC_VECTOR(1, cpt_byte'length)) THEN
                     -- A la r�ception du dernier octet
                        IF (type_field = typ_sec OR type_field = typ_sup) THEN
                        -- Si c'est une trame de s�curit� ou une trame de supervision
                           fsm_layer7 <= crc1_st;  -- Il y'a un CRC
                        ELSE
                        -- Si ce n'est pas une trame de s�curit� ou de supervision 
                        -- (i.e. une commande non s�curitaire)
                           fsm_layer7 <= endok_st; -- la trame est finie
                        END IF;
                     END IF;
                  END IF;
               END IF;
   
            WHEN crc1_st =>
            -- Etat d'attente du 1er octet de CRC
               IF (eof = '1') THEN
               -- Si on re�oit la fin de trame maintenant, c'est qu'il y a un probl�me
                  fsm_layer7 <= abort_st;   
               ELSIF (overflow_buf = '1') THEN
                  fsm_layer7 <= endnok_st;
               ELSE
                  IF (val_in = '1') THEN
                     fsm_layer7 <= crc2_st;
                  END IF;
               END IF;

            WHEN crc2_st =>
            -- Etat d'attente du 2�me octet de CRC
               IF (eof = '1') THEN
               -- Si on re�oit la fin de trame maintenant, c'est qu'il y a un probl�me
                  fsm_layer7 <= abort_st;   
               ELSIF (overflow_buf = '1') THEN
                  fsm_layer7 <= endnok_st;
               ELSE
                  IF (val_in = '1') THEN
                        fsm_layer7 <= crccheck_st;
                  END IF;
               END IF;
               
            WHEN crccheck_st =>
            -- Etat de v�rifciation du CRC (i.e. il est �gal au magic number)
               IF (eof = '1') THEN
               -- Si on re�oit la fin de trame maintenant, c'est qu'il y a un probl�me
                  fsm_layer7 <= abort_st;   
               ELSIF (overflow_buf = '1') THEN
                  fsm_layer7 <= endnok_st;
               ELSE
                  IF (crc(15 downto 0) = x"E88B") THEN
                     fsm_layer7 <= endok_st;
                  ELSE
                     fsm_layer7 <= endnok_st;
                  END IF;
               END IF;

            WHEN endok_st =>
            -- Le format de la couche applicative est correct
               IF (eof = '1') THEN
               -- On attend le sigal de fin de trame
                  new_frame <= '1';       -- On signale une nouvelle trame
                  l7_ok <= l2_ok;         -- Si le format de la couche 2 est �galement correct, la trma est bonne
                  IF (l2_ok = '0') THEN
                     adwrite <= old_adw;     -- On ignore tout ce qu'on vient de copier dans la DPRAM en reprenant l'ancien pointeur
                  END IF;
                  fsm_layer7 <= idle_st;
               END IF;

            WHEN endnok_st =>
            -- Le format de la couche applicative n'est pas correct
               IF (eof = '1') THEN
               -- On attend le signal de fin de trame
                  new_frame <= '1';       -- On signale une nouvelle trame
                  l7_ok <= '0';           -- dont le format n'est pas correct
                  adwrite <= old_adw;     -- On ignore tout ce qu'on vient de copier dans la DPRAM en reprenant l'ancien pointeur
                  fsm_layer7 <= idle_st;
               END IF;

            WHEN abort_st =>
            -- On a re�u une fin de trame au mauvais moment.
               new_frame <= '1';       -- On signale une nouvelle trame
               l7_ok <= '0';           -- dont le format n'est pas correct
               adwrite <= old_adw;     -- On ignore tout ce qu'on vient de copier dans la DPRAM en reprenant l'ancien pointeur
               fsm_layer7 <= idle_st;

            WHEN OTHERS =>
               fsm_layer7 <= idle_st;
         END CASE;
      END IF;
   END PROCESS;

   --------------------------------------------
   -- Calcul du crc16
   --------------------------------------------
	inst_crc16: crc16
   GENERIC MAP (
      poly => x"90D9"   -- Polynome g�n�rateur de x^16 + x^15 + x^12 + x^7 + x^6 + x^4 + x^3 + 1
      )
   PORT MAP(
		clk_sys => clk_sys,
		rst_n => rst_n,
		data => dat_in,
		val => val_in,
		init => init_crc,
		crc => crc
	);

   wea(0) <= val_in;                -- On �crit toutes les donn�es entrantes dans le DPRAM
   dpram_dw <= soc_wr & dat_in;     -- Le vecteur d'�criture contient en SMB le signal de d�but de la commande
   dat_out <= dpram_dr(7 DOWNTO 0); -- En lecture de la DPRAM, les 8 MSB sont les donn�es
   soc_out <= dpram_dr(8);          -- Le MSB est le signal de d�but de commande
   inst_dpram : dpram
   PORT MAP (
      clka => clk_sys,
      wea => wea,
      addra => adwrite,
      dina => dpram_dw,
      clkb => clk_sys,
      addrb => adread,
      doutb => dpram_dr
   );
   
end rtl;

